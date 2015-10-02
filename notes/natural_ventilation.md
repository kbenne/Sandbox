---
title: Natural Ventilation
layout: default
---

There are two zone ventilation objects in EnergyPlus that can be used to model natural ventilation.

[**ZoneVentilation:DesignFlowRate**](http://bigladdersoftware.com/epx/docs/8-3/input-output-reference/group-airflow.html#zoneventilationdesignflowrate)

$$Ventilation = (V_{design}) (F_{schedule})[A + B |T_{zone} - T_{odb}| + C (WindSpeed) + D (WindSpeed^2)]$$

[**ZoneVentilation:WindandStackOpenArea**](http://bigladdersoftware.com/epx/docs/8-3/input-output-reference/group-airflow.html#zoneventilationwindandstackopenarea)

There is a ventilation component contributed by the wind,

$$Q_w = C_w A_{opening} F_{schedule} V$$,

plus a ventilation component contributed by the stack effect,

$$Q_s = C_D A_{opening} F_{schedule} \sqrt{2 g \Delta H_{NPL} (|T_{zone} - T_{odb}| / T_{zone})}$$
.

The principle difference between the zone ventilation models is the shape of the windspeed and temperature dependency. Both objects account for temperature and windspeed sensitivies, but with different approximations. The ```ZoneVentilation:DesignFlowRate``` object does not have an explicit window opening term although area may theorhetically be accounted for in the $A$, $B$, $C$, and $D$ terms. They both may be scheduled to forcefully turn the effect of natural ventilation on or off mimicking operable windows. Neither zone ventilation input object interacts with the HVAC system short of influencing the load observed by the systems.

OpenStudio 1.9.0 only supports ZoneVentilationDesignFlowRate although the WindowStackOpenArea object could easily be added on request.

There is a relevant thread on [UnmetHours](https://unmethours.com/question/13/how-do-you-model-operable-windows/) about this topic.


