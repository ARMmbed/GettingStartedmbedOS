# Blinky on a breadboard

We've seen how to automatically blink the built-in LED, but the great thing about dev kits is that they allow us to add new sensors and peripherals and experiment with user interactions. Let's use an external LED instead of the on-board one, then add manual control.

If you skipped Blinky, please go [get the code for it](FirstProjectmbedOS.md). You'll need to modify that code to get this example working.

## The hardware

Get a breadboard, a 220 ohm resistor (or something close to 220 ohm), and two wires.

To know how we should connect everything together we need to take a look at the pinout of the board. Normally, this is listed on the board's page on the mbed website (for example, here is the [FRDM-K64F pinout](https://www.mbed.com/en/development/hardware/boards/nxp/frdm_k64f/)). You can also do an image search for '[board-name] pinout'.

<span class="images">![Finding pinouts with your favourite search engine](Images/bb01.png)<span>Finding pinouts with your favourite search engine</span></span>


We need a digital pin for the LED. Since I'm using the FRDM-K64F, I selected pin PTB23/D4.

<span class="images">![Choosing a digital pin](Images/bb04.png)</span>

Now we're ready to set up the circuit.

<span class="images">![Sketch of a LED wired up on a breadboard](Images/bb-sketch-led.png)<span>*Black wire running from GND to the short leg of the LED. Orange wire running from PTB23 through a resistor to the long leg of the LED.*</span></span>

## Changing the pin association in the code

Now we need to configure the LED in our [Blinky code](https://github.com/ARMmbed/example-mbedos-blinky/blob/master/source/blinky.cpp) to no longer reference `LED1`. To reference our pin we can use the name of the pin directly (`PTB23`) or we can use the standard name 'D4', which is mapped automatically to the right pin through [yotta](http://yottadocs.mbed.com/reference/config.html). The latter is prefered, as it makes it easier to port your code to other hardware.

Change [the ``blinky`` function](https://github.com/ARMmbed/example-mbedos-blinky/blob/master/source/blinky.cpp) to:

```cpp
static void blinky(void) {
    // If we use the standard name (D4), we need to prefix the pin name.
    // If we use PTB23, we do not need to do this.
    static DigitalOut led(YOTTA_CFG_HARDWARE_PINS_D4);
    led = !led;
    printf("LED = %d \r\n",led.read());
}
```

Now the LED on the breadboard blinks, rather than the LED on the board.

<span class="images">![LED wired up on a breadboard](Images/bb02.png)</span>

## Adding a button

Since we have the breadboard ready anyway, we can also change this program to toggle the LED when a button is being pressed, rather than every 500ms.

First we need to take another digital pin (in my case PTA2/D5), and wire the button up on the breadboard. Make sure to also have a pull-down resistor to ground.

<span class="images">![Sketch of a button and a LED on a breadboard](Images/bb-sketch-btn.png)</span>

Now we can configure PTA2/D5 as an [`InterruptIn`](https://developer.mbed.org/handbook/InterruptIn) pin and get notified when the button gets pressed or released. Change 'source/app.cpp' to read:

```cpp
#include "mbed-drivers/mbed.h"

static DigitalOut led(YOTTA_CFG_HARDWARE_PINS_D4);

static void led_toggle(void) {
    led = !led;
    printf("LED = %d \r\n", led.read());
}

void app_start(int, char**) {
    static InterruptIn button(YOTTA_CFG_HARDWARE_PINS_D5);

    // when we press the button the circuit closes and the LED state is toggled
    button.rise(&led_toggle);
    // when we release the button the circuit opens again and the LED state is toggled again
    button.fall(&led_toggle);
}
```

<span class="images">![Button and a LED on a breadboard](https://raw.githubusercontent.com/ARMmbed/GettingStartedmbedOS/master/Docs/Images/bb03.gif)</span>

## Making the code safe

The LED state changes as it should and it might look like everything is fine, but there's actually a very important change in the code above when compared with its original version: the use of `rise` and `fall`:

```cpp
button.rise(&led_toggle);
button.fall(&led_toggle);
```

`rise` and `fall` set the functions that will be called when the logic level on `button` changes from 0 to 1 and 1 to 0 respectively. However, `rise` and `fall` are legacy functions from mbed Classic, so they bypass [MINAR](Full_Guide/MINAR.md) and call their arguments (`led_toggle` in this case) in an interrupt cotext. As explained in the [InterruptIn documentation](https://developer.mbed.org/handbook/InterruptIn), it is not safe to call some C library functions from an interrupt context. `printf` is one of these functions, so the code above might actually be problematic. Even if it works fine in this particular case, calling `printf` from an interrupt context should generally be avoided. Fortunately, this is one of the things that [MINAR](Full_Guide/MINAR.md) is good at: deferring code executing from interrupt context to user context. Since calling MINAR from an interrupt context is safe, all we need to do is schedule a callback from an interrupt handler. MINAR will safely execute that callback later from the user context:

```cpp
#include "mbed-drivers/mbed.h"
#include "minar/minar.h"
#include "core-util/FunctionPointer.h"

using namespace mbed::util;

static DigitalOut led(YOTTA_CFG_HARDWARE_PINS_D4);

static void led_toggle_user(void) {
    led = !led;
    printf("LED = %d \r\n", led.read());
}

static void led_toggle_irq(void) {
   minar::Scheduler::postCallback(FunctionPointer0<void>(&led_toggle_user).bind());
}

void app_start(int, char**) {
    static InterruptIn button(YOTTA_CFG_HARDWARE_PINS_D5);

    // when we press the button the circuit closes and the LED state is toggled
    button.rise(&led_toggle_irq);
    // when we release the button the circuit opens again and the LED state is toggled again
    button.fall(&led_toggle_irq);
}
```
<span class="tips">**Tip:** You can read more [about MINAR here](Full_Guide/MINAR.md).</span>
