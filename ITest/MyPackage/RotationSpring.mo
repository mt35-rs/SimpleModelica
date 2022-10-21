within ITest.MyPackage;

model RotationSpring

    parameter Modelica.SIunits.Inertia J1 = 1 "Inertia body 1";
    parameter Modelica.SIunits.Inertia J2 = 1 "Inertia body 1";

    parameter Real springConstant = 1000 "Spring constant";
    parameter Real springDumping = 0.0001 "Spring dumping";

	Modelica.Mechanics.Rotational.Components.Inertia inertia
             annotation (Placement(transformation(extent={{-72.33, -11.17}, {-52.33, 8.83}})));
	Modelica.Mechanics.Rotational.Components.Inertia inertia1
             annotation (Placement(transformation(extent={{43.67, -10.83}, {63.67, 9.17}})));
	Modelica.Mechanics.Rotational.Components.SpringDamper springDamper
             annotation (Placement(transformation(extent={{-15, -10.83}, {5, 9.17}})));
	Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
             annotation (Placement(transformation(extent={{-110.99, -10.2}, {-90.99, 9.8}})));
	Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
             annotation (Placement(transformation(extent={{89.79, -10.79}, {109.79, 9.21}})));
	Modelica.Blocks.Interfaces.RealOutput y
             annotation (Placement(transformation(extent={{-10, -10}, {10, 10}}, rotation = 90, origin={-0.33, 98.83})));
	Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
             annotation (Placement(transformation(extent={{-45, 32.83}, {-25, 52.83}})));

equation
	 connect(inertia.flange_a, flange_a) 
		annotation(Line(points={{-72.33,-1.17},{-100.99,-1.17},{-100.99,-0.2}},color={0,0,0}));
	 connect(inertia.flange_b, springDamper.flange_a) 
		annotation(Line(points={{-52.33,-1.17},{-15,-1.17},{-15,-0.83}},color={0,0,0}));
	 connect(springDamper.flange_b, inertia1.flange_a) 
		annotation(Line(points={{5,-0.83},{43.67,-0.83},{43.67,-0.83}},color={0,0,0}));
	 connect(inertia1.flange_b, flange_b) 
		annotation(Line(points={{63.67,-0.83},{99.79,-0.83},{99.79,-0.79}},color={0,0,0}));
	 connect(inertia.flange_b, speedSensor.flange) 
		annotation(Line(points={{-52.33,-1.17},{-52.33,42.83},{-45,42.83}},color={0,0,0}));
	 connect(speedSensor.w, y) 
		annotation(Line(points={{-24,42.83},{0.08,42.83},{0.08,98.83},{-0.33,98.83}}));






    // content
    annotation (
        Documentation(
            info="<html><p>Documentation for <strong>ITest.MyPackage.RotationSpring</strong></p></html>"
        ),
        Icon(
            coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100.0,-100.0},{100.0,100.0}}
            ),
            graphics={
                Rectangle(
                    extent={{-100,-100},{100,100}},
                    lineColor={0,0,127},
                    pattern=LinePattern.Dot,
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid
                ),
                Text(
                    extent={{-150,150},{150,110}},
                    textString="%name",
                    lineColor={0,0,255}
                ), 
Rectangle(lineColor={0,0,255},fillPattern=FillPattern.Solid,extent={{-81.5,26.83},{-8.17,-16.17}}), 
Rectangle(lineColor={0,0,255},fillColor={80,227,194},fillPattern=FillPattern.Solid,extent={{12.17,26.5},{84.83,-15.17}}), 
Line(points={{-8.5,-0.83},{-4.83,11.17},{-1.5,-0.5},{2.17,11.17},{5.5,-0.5},{9.17,11.5},{12.17,-0.5}},color={0,0,255},thickness=1)



            }
        ),
        Diagram(
            coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}
            )
        )
    ,Report(
	text="
# How to

Use a text mode to add different components such as charts, tables, trees,
or just write a text using MD format, all main renderers are supported including
Math 


# Examples

## Equation

$L = \\sqrt{\\frac{1}{2} \\rho v^2 S C_L + 2 }$

## Autolink literals

www.example.com, https://example.com, and contact@example.com.

## Footnote

A note[^1]

[^1]: Big note.

## Strikethrough

~one~ or ~~two~~ tildes.


## Table

| a | b  |  c |  d  |
| - | :- | -: | :-: |
| 1 | 2  | 5  | 6   |
## Tasklist

* [ ] to do
* [x] done")
);
end RotationSpring;