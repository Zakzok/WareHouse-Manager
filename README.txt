The model is fully explained in the paper. There are 9 premade problem files, as
described in the paper. We trust that the comments in any ready-made 
problem file will guide you to creat your own problem files.

To run what we call the 'default' enhsp-2020, use the following command, replacing 
problem.pddl with whatever problem you wish to test:

enhsp-2020 --domain domain.pddl --problem problem.pddl

To run what we call short-sited enhsp-2020, use the following command in a similar way:

enhsp-2020 --domain domain.pddl --problem problem.pddl -ha true -h hmrp -wh 4
