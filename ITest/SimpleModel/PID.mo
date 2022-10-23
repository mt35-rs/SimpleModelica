within ITest.SimpleModel;

model PID

	parameter Real k = 1;
    parameter Real torqueConst = 10.0 "Constant torque";
    parameter Real J1 = 1 "First inertia";
    parameter Real J2 = 2 "Second inertia";
    parameter Real      Ti = 1.0;
    parameter Real      Td = 1.0;
    parameter Real      Tp = 1.0;

    
    Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation(Placement(transformation(extent = {
                        {-35.24, 2.17},
                        {-15.24, 22.17}
                    })));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J1)
        annotation(Placement(transformation(extent = {
                        {-4.6, 2.17},
                        {15.4, 22.17}
                    })));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper
        (c = 10000,d = 100)annotation(Placement(transformation(extent = {{30, 2.17}, {50, 22.17}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = J2)
        annotation(Placement(transformation(extent = {{60, 1.44}, {80, 21.44}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant = torqueConst)
        annotation(Placement(transformation(extent = {
                        {27.05, -45.35},
                        {47.05, -25.35}
                    })));
	Modelica.Blocks.Math.Add add
             (k2 = -1)annotation (Placement(transformation(extent={{-35.02, 46.93}, {-55.02, 66.93}})));
	Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
             annotation (Placement(transformation(extent={{-10, -10}, {10, 10}}, rotation = 90, origin={17.05, 36.93})));
	Modelica.Blocks.Sources.Step step
             (startTime = 5)annotation (Placement(transformation(extent={{47.97, 67.79}, {27.97, 87.79}})));
	Modelica.Blocks.Continuous.PID controller
             (k = Tp,Ti = Ti,Td = Td)annotation (Placement(transformation(extent={{-79.27, 2.36}, {-59.27, 22.36}})));
	Modelica.Blocks.Continuous.Integrator error
             annotation (Placement(transformation(extent={{-50, -40}, {-30, -20}})));
	Modelica.Blocks.Math.Abs abs1
             annotation (Placement(transformation(extent={{-82.68, -40.45}, {-62.68, -20.45}})));
	
    
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
                {47.05, -35.35},
                {95.79, -35.35},
                {95.79, 11.44},
                {80, 11.44}
            },
            color = {0, 0, 0}));
            
	 connect(inertia.flange_b, speedSensor.flange) 
		annotation(Line(points={{15.4,12.17},{15.4,26.93},{17.05,26.93}},color={0,0,0}));
	 connect(speedSensor.w, add.u2) 
		annotation(Line(points={{17.05,47.93},{17.05,54.85},{-33.02,54.85},{-33.02,50.93}}));
	 connect(step.y, add.u1) 
		annotation(Line(points={{26.97,77.79},{-2.33,77.79},{-2.33,62.93},{-33.02,62.93}}));
	 connect(torque.tau, controller.y) 
		annotation(Line(points={{-37.24,12.17},{-58.27,12.17},{-58.27,12.36}}));
	 connect(controller.u, add.y) 
		annotation(Line(points={{-81.27,12.36},{-94.65,12.36},{-94.65,56.93},{-56.02,56.93}}));
	 connect(error.u, abs1.y) 
		annotation(Line(points={{-52,-30},{-61.68,-30},{-61.68,-30.45}}));
	 connect(abs1.u, add.y) 
		annotation(Line(points={{-84.68,-30.45},{-93.68,-30.45},{-93.68,56.89},{-56.02,56.89},{-56.02,56.93}}));


	 






    
    
    
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
                )
            }),
        Diagram(coordinateSystem(preserveAspectRatio = true,
                extent = {{-100, -100}, {100, 100}})));
end PID;