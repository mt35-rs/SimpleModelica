within ITest.SimpleModel;
model TestModel
    parameter String file = "/home/pn/SimpleModelica/test.csv" annotation (Dialog(
        loadSelector(filter="M files (*.csv);;All files (*.*)",
        caption="Open file in which table is present")));
    // TODO: Add a descriptive string here
    parameter Real k = 12;
    parameter Real torqueConst = -10 "Constant torque";
    parameter Real J1 = 1 "First inertia";
    parameter Real J2 = 1 "Second inertia";
    Modelica.Blocks.Sources.Clock clock
        annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}},
                    rotation = 90,
                    origin = {-83.88, -85.85})));
    Modelica.Blocks.Math.Sin _sin
        annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}},
                    rotation = 90,
                    origin = {-83.88, -50})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation(Placement(transformation(extent = {
                        {-35.24, 2.17},
                        {-15.24, 22.17}
                    })));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J1 + 2)
        annotation(Placement(transformation(extent = {
                        {-4.6, 2.17},
                        {15.4, 22.17}
                    })));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper
        annotation(Placement(transformation(extent = {{30, 2.17}, {50, 22.17}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = J2)
        annotation(Placement(transformation(extent = {{60, 1.44}, {80, 21.44}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant = torqueConst)
        annotation(Placement(transformation(extent = {{20, -80}, {40, -60}})));
    Modelica.Blocks.Math.Gain gain(k = k)
        annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}},
                    rotation = 90,
                    origin = {-90, 12.17})));
equation
    connect(inertia.flange_a, torque.flange) annotation(Line(points = {
                {-4.6, 12.17},
                {10, 12.17},
                {-15.24, 12.17}
            },
            color = {0, 0, 0}));
    connect(springDamper.flange_a, inertia.flange_b) annotation(Line(points = {
                {30, 12.17},
                {15.4, 12.17}
            },
            color = {0, 0, 0}));
    connect(springDamper.flange_b, inertia1.flange_a) annotation(Line(points = {
                {50, 12.17},
                {60, 12.17},
                {60, 11.44}
            },
            color = {0, 0, 0}));
    connect(constantTorque.flange, inertia1.flange_b) annotation(Line(points = {
                {40, -70},
                {95.79, -70},
                {95.79, 11.44},
                {80, 11.44}
            },
            color = {0, 0, 0}));
    connect(_sin.u, clock.y) annotation(Line(points = {
                {-83.88, -62},
                {-83.88, -74.85},
                {-83.88, -74.85}
            }));
    connect(_sin.y, gain.u) annotation(Line(points = {
                {-83.88, -39},
                {-83.88, 0.17},
                {-90, 0.17}
            }));
    connect(gain.y, torque.tau) annotation(Line(points = {
                {-90, 23.17},
                {-90, 12.33},
                {-37.24, 12.33},
                {-37.24, 12.17}
            }));
    annotation(Documentation(info = "<html><p>Documentation for <strong>ITest.SimpleModel.TestModel</strong></p></html>"),
        Report(text = "
# Chart

<chart signals=\"Solver\\.*.Case_0.inertia1.w,Solver\\.*.Case_0.kinematicPTP.y[1]\"  height=\"200px\"></chart>

# Variable tree

<tree></tree>
"),
        Icon(coordinateSystem(preserveAspectRatio = true,
                extent = {{-100.0, -100.0}, {100.0, 100.0}}),
            graphics = {
                Rectangle(
                    extent = {{-100, -100}, {100, 100}},
                    lineColor = {0, 0, 127},
                    pattern = LinePattern.Dot,
                    fillColor = {255, 255, 255},
                    fillPattern = FillPattern.Solid
                ),
                Text(
                    extent = {{-150, 150}, {150, 110}},
                    textString = "%name",
                    lineColor = {0, 0, 255}
                ),
                Ellipse(
                    lineColor = {0, 0, 255},
                    fillColor = {255, 255, 255},
                    fillPattern = FillPattern.Solid,
                    extent = {{-70.66, 42.33}, {56.67, -50.33}}
                )
            }),
        Diagram(coordinateSystem(preserveAspectRatio = true,
                extent = {{-100, -100}, {100, 100}})));
end TestModel;