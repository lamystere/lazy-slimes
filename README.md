# lamystere's lazy slimes
#### Tutorial and 3d print files for the easiest slime build possible
<img alt="a slime worn" src="/images/worn-slime.jpg" height="400" ></img>
### Pros  
- Quick to build: Each pair of trackers takes less than 15 minutes.
<sub><sup>(your soldering times may vary)</sup></sub>
- You'll have battery life for days.  About 36 hours run time.
- You can swap out low batteries for fresh ones.
- The only tools needed are a 3d printer, soldering iron, and scissors.
### Cons
- Putting batteries in backwards will kill your d1 board!!!
- No battery percentage indication.
<sub><sup>(However D1s will shut off before 18650s reach a harmfully low voltage)</sup></sub>
- The battery makes it bigger than stock slimes. 
- You'll have to remove the batteries to charge them or turn off the slimes.


## Parts for 10 trackers: $87 using amazon
-  4 pin female right-angle JST connectors:  $6
([bag of 50 for \$6](https://www.amazon.com/dp/B0BMDQLR4Q))  

-  4-pin 2.54mm JST cables+connectors:  $8 - 19
([30cm x 20 for \$8](https://www.amazon.com/dp/B09JNZJXTF)) 
([100cm x 5 for \$11](https://www.amazon.com/Kidisoii-Connector-Pre-Crimped-Housing-Adapter/dp/B0BW9T2L26) - optional for longer runs to satellites)


- Mini D1s: \$15 for 10 tracking points
([$3 each](https://www.amazon.com/dp/B081PX9YFV))
- BMI 160s: \$21 for 10 tracking points
([$2 each](https://www.amazon.com/dp/B0C4TMKL3V)) 
- Battery holders: $8
([10 for \$8](https://www.amazon.com/HiLetgo-10pcs-Battery-Holder-Storage/dp/B00LSG5BKO))
- 18650 batteries and charger: $29
([cheapest option](https://www.amazon.com/Tokeyla-Rechargeable-6-Button-top-B%EF%BF%B5at%EF%BF%B5t%EF%BF%B5%EF%BF%B5ery-Ba%EF%BF%B5tt%EF%BF%B5%EF%BF%B5er%EF%BF%B5y/dp/B0CBRDVHTY/))
(or separate [batteries](https://www.amazon.com/1%EF%BF%B58%EF%BF%B56%EF%BF%B550-Rechargeable-Batter%EF%BF%B5y-Universal-Batteries/dp/B0CLZTS43N/) and [6 bay charger](https://www.amazon.com/Battery-Universal-Rechargeable-Batteries-Compatible/dp/B091GDK56V))

- 3d printed cases: priceless
- I'm assuming you have a soldering iron

### Straps:
Consult [the slime VR docs for some good DIY strap ideas](https://docs.slimevr.dev/diy/diy-straps.html) to match your sewing skills.  Stretchy straps are very necessary! Regular velcro/nylon will fall right off.  If you just want to buy everything here's the amazon solution for \$40:
-  Stretchy 1" and 2" straps:  $26
([two of these at \$13](https://www.amazon.com/dp/B08CDGZ774))([or one and this pack for \$12](https://www.amazon.com/VELCRO-Brand-VEL-30794-AMS-Stretchable-Umbrellas/dp/B09QSYVP5H))
- Chest harness: \$14
([\$14 for the cheapest gopro holder](https://www.amazon.com/dp/B01D3I8A7A))


# Cases
If you just want to print them you can use the [included STL files](/case-files/stl/) to slice and print.  If you have an Ender3 and PLA you can skip slicing and use the [included gcode files](/case-files/gcode%20for%20ender3/).  
   
The [master file](/case-files/lazy-slimes.scad) is written in [OpenSCAD](https://openscad.org/). You will need to use that to customize it (Fork it and send me a PR!).  Check out the parameters at the top for isolating each piece.  
![screen shot of scad file](/images/scad.png)

# Building
<img alt="a wired slime tracker" src="/images/wired-slime.jpg" height="400"></img>
<sub><sup>(youtube walk-through is in the works)</sup></sub>

1. Cut one of the 4 pin jst cables to about the length of the case and strip the ends of the now shorter cable.  <span style="font-size:0.8rem;">Skip this step if you want 2 long separated sensors.  I use this method for thigh trackers with the battery strapped to my waist.</span>
1. Solder the right angle connectors to the BMI160 boards covering the pins from 3v3 to SDA on the side with the parts.
2. Plug the long and short cables in to the BMI160s so you can follow the pad labels. Use the 100cm cables for longer runs like waist to chest or waist to thighs.  The cheaper 30cm cables should be enough for all the rest.  
<sub><sup> If you want to save \$11 you could omit the 100cm cables and make extensions by soldering a female jst connector onto a 30cm cable.  
If you don't need a satellite sensor connected you can skip the longer cable entirely.</sup></sub>
1. Use a scrap of the cut wire to solder a jumper on the satellite BMI160 from the G pad to the SAO pad. <sub><sup>This is necessary to identify it as sensor #2 on the data bus.</sup></sub>
1. Insert the battery ground wire and the ground wire for both BMI160s* into the G pad on the D1.  This is the trickiest part of the build but all 3 WILL fit in the hole.  Solder them all in. <sub><sup>(*note: to keep things quick ignore the color of the jst wires.  The G wire should be the second pad from the top on the BMI160)</sup></sub>
1. Solder the red battery lead into the 5V pad of the D1
1. Solder both of the 3V3 leads from the BMI160s to the 3V3 pad of the D1
1. Solder both of the SCL leads from the BMI 160s to the D1 pad of the D1
1. Solder both of the SDA leads from the BMI 160s to the D2 pad of the D1
1. Configure and connect to the wifi and Slime Server using a usb cable to the D1.  Configure and upload Slime firmware to the D1 first if you haven't already.  [Instructions](https://docs.slimevr.dev/firmware/index.html) and <a href="data:text/plain;charset=utf-8,%23define%20IMU%20IMU_BMI160%0A%23define%20SECOND_IMU%20IMU_BMI160%0A%23define%20BOARD%20BOARD_WEMOSD1MINI%0A%23define%20IMU_ROTATION%20DEG_90%0A%23define%20SECOND_IMU_ROTATION%20DEG_90%0A%0A%23define%20PRIMARY_IMU_OPTIONAL%20false%0A%23define%20SECONDARY_IMU_OPTIONAL%20true%0A%0A%23define%20MAX_IMU_COUNT%202%0A%0A%23ifndef%20IMU_DESC_LIST%0A%23define%20IMU_DESC_LIST%20%5C%0A%20%20%20%20IMU_DESC_ENTRY(IMU%2C%20%20%20%20%20%20%20%20PRIMARY_IMU_ADDRESS_ONE%2C%20%20%20IMU_ROTATION%2C%20%20%20%20%20%20%20%20PIN_IMU_SCL%2C%20PIN_IMU_SDA%2C%20PRIMARY_IMU_OPTIONAL%2C%20%20%20PIN_IMU_INT)%20%5C%0A%20%20%20%20IMU_DESC_ENTRY(SECOND_IMU%2C%20SECONDARY_IMU_ADDRESS_TWO%2C%20SECOND_IMU_ROTATION%2C%20PIN_IMU_SCL%2C%20PIN_IMU_SDA%2C%20SECONDARY_IMU_OPTIONAL%2C%20PIN_IMU_INT_2)%0A%23endif%0A%0A%2F%2F%20Battery%20monitoring%20options%20(comment%20to%20disable)%3A%0A%2F%2F%20BAT_EXTERNAL%20for%20ADC%20pin%2C%20BAT_INTERNAL%20for%20internal%20-%20can%20detect%20only%20low%20battery%2C%20BAT_MCP3021%20for%20external%20ADC%0A%23define%20BATTERY_MONITOR%20BAT_EXTERNAL%0A%23define%20BATTERY_SHIELD_RESISTANCE%20180%20%2F%2F130k%20BatteryShield%2C%20180k%20SlimeVR%20or%20fill%20in%20external%20resistor%20value%20in%20kOhm%0A%0A%23define%20PIN_IMU_SDA%20D2%0A%23define%20PIN_IMU_SCL%20D1%0A%23define%20PIN_IMU_INT%20D5%0A%23define%20PIN_IMU_INT_2%20D6%0A%23define%20PIN_BATTERY_LEVEL%20A0%0A">defines.h</a>
1. Place the BMI160 with the shorter wires into the top of the main case, the D1 into the bottom with wifi shield down, and the battery holder into the longest slot.
1. Place the base and cover on a flat surface to help line them up.  Slide the cover over the electronics.  Tuck the shorter cable and battery wires under the cover as you slide it.  Run the longer cable out the notch in the top or bottom. 
<sub><sup>To keep all BMI160 sensors pointed towards the ceiling you should run it through the hole nearest to the BMI160.  The BMI160 connector should always point towards the ceiling.  If that's not convenient you could [re-flash your firmware to customize the sensor orientation](https://docs.slimevr.dev/firmware/configuring-project.html#configuring-definesh-automatically).  Feet seem to be the exception.</sup></sub>  
1. Insert the satellite sensor into its little case and slide the cover over it
1. Thread the straps through the sides of cases over the battery slot so it can hold the battery in.  
<img alt="a completed slime tracker" src="/images/completed-slime.jpg" height="400"></img>

# Placement example
<img alt="a 10 tracking point setup" src="/images/10-point-setup.jpg" height="500"></img>
1. Make sure all BMI160s have the connectors facing the ceiling (except the feet).  You may want to draw an arrow on the cover to indicate the "up" side of the tracker.
1. Combine 2 straps to reach around your waist.  
1. Notice that for one thigh I used a full size case just to hold a BMI160.  This is to accomodate needing a 2" strap to reach around a thigh.  I thread the cord over the waistband so it doesn't float between my legs.  <sub><sup>This would be a good case for having 2 independent trackers, but for this example of 5 trackers with 5 satellites I think it works best.  Some people connect one thigh to the waist sensor and the other thigh to the hip sensor.</sup></sub>
1. Its a similar dilemma with the upper arm sensors, but the 1" strap can reach around my bicep so its easier to keep to the standard setup and simply have a longer cord.  Notice I used 30cm extension cables rather than starting with a 100cm cable.

#### 12 point example:
Same except with lower arms.  Some may prefer shoulders instead.  
<img alt="a 12 tracking point setup" src="/images/12-point-setup.jpg" height="500"></img>  
Why not add in another 4 and get upper chest, waist, shoulders and lower arms?  Why stop there?  With 20 points you could get head, neck, and hands too and ditch the HMD for mocap purposes.  Then you only need finger tracking gloves!  And don't forget to strap a phone on to capture your face!

# Putting it on
1. Loosen the straps and insert all the batteries.  
<sub><sup>(Put red tape on the positive end of both the battery and the holder if you're worried you might accidentally insert it backwards)</sup></sub>
1. Tap the trackers while watching the slime server to confirm they are all connected and which is which.
1. Sit down and put on the waist band first.
1. Put on the harness with the chest sensor.
1. Strap remaining sensors around arms, legs and feet.
1. [Calibrate](https://docs.slimevr.dev/server/imu-calibration.html), [calibrate](https://docs.slimevr.dev/server/configuring-trackers.html), [calibrate](https://docs.slimevr.dev/server/body-config.html)!
1. Dance, dance, dance!
1. Remove the batteries to turn them off or when you need to charge.



