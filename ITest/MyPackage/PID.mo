within ITest.MyPackage;

model PID
    parameter Real Kp = 1 "Propotinal constant ";
    parameter Real Kd = 1 "Deriv constant ";


	ITest.MyPackage.RotationSpring rotationSpring
             annotation (Placement(transformation(extent={{-11.39, -10.89}, {8.61, 9.11}})));
	Modelica.Mechanics.Rotational.Sources.Torque torque
             annotation (Placement(transformation(extent={{-63.3, -9.56}, {-43.3, 10.44}})));
	Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque
             annotation (Placement(transformation(extent={{68.95, -9.56}, {48.95, 10.44}})));
	Modelica.Blocks.Continuous.PID PID
             (k = Kp,Td = Kd)annotation (Placement(transformation(extent={{-21.92, 50}, {-1.92, 70}})));
	Modelica.Blocks.Sources.Step step
             (offset = 0,startTime = 5,height = 1)annotation (Placement(transformation(extent={{-98.39, -9.44}, {-78.39, 10.56}})));
	Modelica.Blocks.Math.Add add
             (k2 = -1)annotation (Placement(transformation(extent={{-60.64, 50}, {-40.64, 70}})));

equation
	 connect(constantTorque.flange, rotationSpring.flange_b) 
		annotation(Line(points={{48.95,0.44},{8.59,0.44},{8.59,-0.97}},color={0,0,0}));
	 connect(torque.flange, rotationSpring.flange_a) 
		annotation(Line(points={{-43.3,0.44},{-11.49,0.44},{-11.49,-0.91}},color={0,0,0}));
	 connect(rotationSpring.y, add.u2) 
		annotation(Line(points={{-1.42,8.99},{-1.42,27.91},{-72.8,27.91},{-72.8,54},{-62.64,54}}));
	 connect(step.y, add.u1) 
		annotation(Line(points={{-77.39,0.56},{-77.39,66},{-62.64,66}}));
	 connect(add.y, PID.u) 
		annotation(Line(points={{-39.64,60},{-23.92,60},{-23.92,60}}));
	 connect(PID.y, torque.tau) 
		annotation(Line(points={{-0.92,60},{27.67,60},{27.67,-41.02},{-70.96,-41.02},{-70.96,0.44},{-65.3,0.44}}));






	
    // content
    annotation (
        Documentation(
            info="<html><p>Documentation for <strong>ITest.MyPackage.PID</strong></p></html>"
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
                )
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

<chart signals=\"Solver.*.Case_0.rotationSpring.speedSensor.w\"  height=400px></chart>
<chart signals=\"Solver_1.Case_0.step.y\"  height=300px></chart><tree></tree># Examples

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
end PID;