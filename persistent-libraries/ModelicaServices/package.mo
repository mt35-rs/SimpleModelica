within ;
package ModelicaServices "ModelicaServices (Default implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation"
  extends Modelica.Icons.Package;
  constant String target="Default"
    "Target of this ModelicaServices implementation";

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class ReleaseNotes "Release notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>
<h4>Version 3.2.3, 2019-01-23</h4>

<ul>
<li> New function
     <a href=\"modelica://ModelicaServices.System.exit\">exit</a>
     to terminate the Modelica environment, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2211\">#2211</a>.
     </li>
</ul>

<h4>Version 3.2.1, 2012-12-05</h4>

<ul>
<li> Version numbering adapted to the corresponding version number of
     package Modelica (= Modelica Standard Library).</li>
<li> New function
     <a href=\"modelica://ModelicaServices.ExternalReferences.loadResource\">loadResource</a>
     to determine the absolute, local file name from an URI path name.
     </li>
<li> New String type with tool dependent choices
     <a href=\"modelica://ModelicaServices.Types.SolverMethod\">SolverMethod</a>
     to define the integration method to solve differential equations in a
     clocked discretized continuous-time partition.
     </li>
<li> New package
     <a href=\"modelica://ModelicaServices.Machine\">Machine</a>
     to define the processor dependent constants as used in
     <a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
     </li>
</ul>


<h4>Version 1.1, 2010-07-30</h4>

<ul>
<li> New model <a href=\"modelica://ModelicaServices.Animation.Surface\">Surface</a>
     to describe movable, parameterized surfaces.</li>
<li> New string constant ModelicaServices.target to define the
     target of the corresponding ModelicaServices implementation</li>
<li> Package icons adapted to the icons of package Modelica, version 3.2.</li>
<li> ModelicaServices library on the Modelica subversion server provided in three versions:
     <ol>
     <li> <strong>Default/ModelicaServices</strong><br>
          (for tools that do not support 3-dim. visualization).</li>

     <li> <strong>Dymola/ModelicaServices</strong><br>
          (a Dymola-specific implementation).</li>

     <li> <strong>DymolaAndDLRVisualization/ModelicaServices</strong><br>
          (an implementation that uses the DLR Visualization library
           in combination with Dymola).</li>
     </ol>
     </li>
</ul>

<h4>Version 1.0, 2009-06-21</h4>

<p>
First version of the ModelicaServices library.
</p>
</html>"));
    end ReleaseNotes;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h5>Main Author:</h5>

<table border=0 cellspacing=0 cellpadding=2>
<tr>
<td>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Robotik und Mechatronik Zentrum (RMC)<br>
    Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></td>
</tr>
</table>

<p><strong>Acknowledgements:</strong></p>

<p>
The design of the Animation.Shape component is from Hilding Elmqvist, previously at Dassault Syst&egrave;mes AB.
</p>
</html>"));
    end Contact;
    annotation (DocumentationClass=true);
  end UsersGuide;

package Animation "Models and functions for 3-dim. animation"
  extends Modelica.Icons.Package;
    model Shape
       "Different visual shapes with variable size; all data have to be set as modifiers (see info layer)"
        extends
        Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;

        import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
        import SI = Modelica.SIunits;
        import Modelica.Mechanics.MultiBody.Frames;
        import Modelica.Mechanics.MultiBody.Types;


    protected
      output RealAnimation rxvisobj[3](each final unit="1")
        "x-axis unit vector of shape, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization =true);
      output RealAnimation ryvisobj[3](each final unit="1")
        "y-axis unit vector of shape, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization =true);
      output RealAnimation rvisobj[3]
          "position vector from world frame to shape frame, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization = true);
       output RealAnimation size[3] "{length,width,height} of shape"
         annotation (HideResult=false, IgniteVisualization = true);

       output RealAnimation Material[4] annotation(HideResult=false, IgniteVisualization = true);
       output RealAnimation Extra  annotation(HideResult=false, IgniteVisualization = true);

       Real abs_n_x(final unit="1") annotation (HideResult=true);
       Real n_z_aux[3](each final unit="1") annotation (HideResult=true);
       Real e_x[3](each final unit="1", start={1,0,0})
          "Unit vector in lengthDirection, resolved in object frame"
                                                                   annotation (HideResult=true);
       Real e_y[3](each final unit="1", start={0,1,0})
          "Unit vector orthogonal to lengthDirection in the plane of lengthDirection and widthDirection, resolved in object frame"
         annotation (HideResult=true);



       parameter Boolean isURI=Modelica.Utilities.Strings.find(shapeType, "modelica://", caseSensitive=false)==1 or Modelica.Utilities.Strings.find(shapeType, "%")==1
        annotation(Evaluate=true);
       parameter StringAnimation shape = if isURI then Modelica.Utilities.Files.loadResource(shapeType) else shapeType annotation(HideResult=false, IgniteVisualization = true);

       parameter Integer ShapeType= if shapeType== "box" then 1
           elseif shapeType== "sphere" then 2
           elseif shapeType== "cylinder" then 3
           elseif shapeType== "pipecylinder" then 4
           elseif shapeType== "pipe" then 5
           elseif shapeType== "beam" then 6
           elseif shapeType== "gearwheel" then 7
           elseif shapeType== "spring" then 8
           else 42;

       parameter IntegerAnimation ObjectType =  if isURI then 90000 else 91000 + ShapeType annotation (HideResult=false, IgniteVisualization = true);



    equation
      abs_n_x = Modelica.Math.Vectors.length(lengthDirection);
      e_x     = noEvent(if abs_n_x < 1.e-10 then {1,0,0} else lengthDirection/abs_n_x);
      n_z_aux = cross(e_x, widthDirection);
      e_y     = noEvent(cross(Modelica.Math.Vectors.normalize(
                       cross(e_x, if n_z_aux*n_z_aux > 1.0e-6 then widthDirection else
                                 (if abs(e_x[1]) > 1.0e-6 then {0,1,0} else {1,0,0}))), e_x));


      rxvisobj = transpose(R.T)*e_x;
      ryvisobj = transpose(R.T)*e_y;
      rvisobj = r + T.resolve1(R.T, r_shape);
      size = {length,width,height};
      Material = {color[1], color[2], color[3], specularCoefficient};
      Extra = extra;
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
              graphics={Text(
                extent={{-150,-110},{150,-140}},
                textString="default")}), Documentation(info="<html>
    <p>
    The interface of this model is documented at
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>.
    </p>

    </html>"));
    end Shape;

    model Surface
        "Animation of a moveable, parameterized surface; the surface characteristic is provided by a function"
      extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;



    protected
      output RealAnimation rxvisobj[3](each final unit="1")
        "x-axis unit vector of surface, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation ryvisobj[3](each final unit="1")
        "y-axis unit vector of surface, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation rvisobj[ 3]
        "Position vector from world frame to surface frame, resolved in world frame"
        annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation x[nu, nv] annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation y[nu, nv] annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation z[nu, nv] annotation (HideResult=false, IgniteVisualization = true);
      output RealAnimation Material[5] = {color[1], color[2], color[3], specularCoefficient, transparency} annotation (HideResult=false, IgniteVisualization = true);
      parameter IntegerAnimation Extra =if wireframe then 0 else 1   annotation (HideResult=false, IgniteVisualization = true);
      parameter IntegerAnimation mesh_size[2] = {nu, nv}  annotation (HideResult=false, IgniteVisualization = true);
      parameter IntegerAnimation  ObjectType = if multiColoredSurface then 100000 else 100001
       "ShapeAnimationId"
       annotation (HideResult=false, IgniteVisualization = true);

    equation
      (x, y, z) = surfaceCharacteristic( nu,    nv,    multiColoredSurface);
      rvisobj = r_0;
      rxvisobj = R.T[1, 1:3];
      ryvisobj = R.T[2, 1:3];
        annotation (Documentation(info="<html>
    <p>
    The interface of this model is documented at
    <a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>.<br>
    The interface of this model is defined at
    <a href=\"modelica://Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface\">Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface</a>.
    </p>

    </html>"));
  end Surface;

  type RealAnimation
    extends Real;
  end RealAnimation;

  type IntegerAnimation
    extends Integer;
  end IntegerAnimation;

  type StringAnimation
    extends String;
  end StringAnimation;

  end Animation;

  package ExternalReferences "Library of functions to access external resources"
    extends Modelica.Icons.Package;
    function loadResource
      "Return the absolute path name of a URI or local file name (in this default implementation URIs are not supported, but only local file names)"
      extends
        Modelica.Utilities.Internal.PartialModelicaServices.ExternalReferences.PartialLoadResource;
      //algorithm
      //fileReference := Modelica.Utilities.Files.fullPathName(uri);
      external "builtin" fileReference = loadResource_(uri);

      annotation (Documentation(info="<html>
<p>
The interface of this model is documented at
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Files.loadResource</a>.
</p>
</html>"));
    end loadResource;
  end ExternalReferences;

  package Machine "Machine dependent constants"
    extends Modelica.Icons.Package;
    final constant Real eps=1e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small=1e-60
      "Smallest number such that small and -small are representable on the machine";
    final constant Real inf=1e60
      "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf=2147483647
      "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
    annotation (Documentation(info="<html>
<p>
Package in which processor specific constants are defined that are needed
by numerical algorithms. Typically these constants are not directly used,
but indirectly via the alias definition in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
</p>
</html>"));
  end Machine;

  package System "System dependent functions"
    extends Modelica.Icons.Package;
    function exit "Terminate execution of Modelica environment"
      extends Modelica.Utilities.Internal.PartialModelicaServices.System.exitBase;
      external "C" exit(status) annotation(Include="#include <stdlib.h>", Library="ModelicaExternalC");
      annotation(__ModelicaAssociation_Impure=true, Documentation(info="<html>
<p>
Tool-specific implementation of <a href=\"modelica://Modelica.Utilities.System.exit\">Modelica.Utilities.System.exit</a>.
</p>
</html>"));
    end exit;
  end System;

  package Types "Library of types with vendor specific choices"
    extends Modelica.Icons.Package;
    type SolverMethod = String
      "String defining the integration method to solve differential equations in a clocked discretized continuous-time partition"
      annotation (choices(
        choice="External" "Solver specified externally",
        choice="ExplicitEuler" "Explicit Euler method (order 1)",
        choice="ExplicitMidPoint2" "Explicit mid point rule (order 2)",
        choice="ExplicitRungeKutta4" "Explicit Runge-Kutta method (order 4)",
        choice="ImplicitEuler" "Implicit Euler method (order 1)",
        choice="ImplicitTrapezoid" "Implicit trapezoid rule (order 2)"),
        Documentation(info="<html>
<p>
Type <strong>SolverMethod</strong> is a String type with menu choices to select the
integration method to solve differential equations in a clocked discretized
continuous-time partition. The choices are tool dependent.
For details, see chapter 16.8.2 \"Solver Method\" in the Modelica Language
Specification (version &ge; 3.3).
</p>
</html>"));
  end Types;

  annotation (
    preferredView="info",
    version="3.2.3",
    versionBuild=4,
    versionDate="2019-01-23",
    dateModified="2020-03-18 12:00:00Z",
    revisionId="7ac06a513 2020-03-18 12:19:34 +0100",
    uses(Modelica(version="3.2.3")),
    conversion(
      noneFromVersion="1.0",
      noneFromVersion="1.1",
      noneFromVersion="1.2",
      noneFromVersion="3.2.1",
      noneFromVersion="3.2.2"),
    Documentation(info="<html>
<p>
This package contains a set of functions and models to be used in the
Modelica Standard Library that requires a tool specific implementation.
These are:
</p>

<ul>
<li> <a href=\"modelica://ModelicaServices.Animation.Shape\">Animation.Shape</a>
     provides a 3-dim. visualization of elementary
     mechanical objects. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Animation.Surface\">Animation.Surface</a>
     provides a 3-dim. visualization of
     moveable parameterized surface. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.ExternalReferences.loadResource\">ExternalReferences.loadResource</a>
     provides a function to return the absolute path name of an URI or a local file name. It is used in
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Files.loadResource</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Machine\">Machine</a>
     provides a package of machine constants. It is used in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.</li>

<li> <a href=\"modelica://ModelicaServices.System.exit\">System.exit</a> provides a function to terminate the execution of the Modelica environment. It is used in <a href=\"modelica://Modelica.Utilities.System.exit\">Modelica.Utilities.System.exit</a> via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Types.SolverMethod\">Types.SolverMethod</a>
     provides a string defining the integration method to solve differential equations in
     a clocked discretized continuous-time partition (see Modelica 3.3 language specification).
     It is not yet used in the Modelica Standard Library, but in the Modelica_Synchronous library
     that provides convenience blocks for the clock operators of Modelica version &ge; 3.3.</li>
</ul>

<p>
This is the default implementation, if no tool-specific implementation is available.
This ModelicaServices package provides only \"dummy\" models that do nothing.
</p>

<p>
<strong>Licensed by the Modelica Association under the 3-Clause BSD License</strong><br>
Copyright &copy; 2009-2019, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>

</html>"));
end ModelicaServices;
