SELECT SDO_GEOM.SDO_MBR(c.shape, m.diminfo) as shp
  FROM picture c, user_sdo_geom_metadata m
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c.name = 'M';
SELECT c.name,
  SDO_GEOM.RELATE(c.shape, 'determine', c_b.shape, 0.005) relationship 
  FROM picture c, picture c_b WHERE c_b.name = '81';
SELECT SDO_GEOM.SDO_MBR(c.shape, m.diminfo) 
  FROM picture c, user_sdo_geom_metadata m
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c.name = 'sky1';
SELECT name, SDO_GEOM.SDO_AREA(shape, 0.005) as area FROM picture;
SELECT c.name, SDO_GEOM.SDO_CENTROID(c.shape, m.diminfo) as shp
  FROM picture c, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c.name = 'nemoeye3';
SELECT SDO_GEOM.SDO_DISTANCE(c_b.shape, c_d.shape, 0.005) as dis
   FROM picture c_b, picture c_d
   WHERE c_b.name = 'bird' AND c_d.name = 'sky1';
SELECT c.name, SDO_GEOM.SDO_LENGTH(c.shape, m.diminfo) 
  FROM picture c, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' AND c.name='sky1';
SELECT SDO_GEOM.SDO_DIFFERENCE(c_a.shape, m.diminfo, c_c.shape, m.diminfo) 
  FROM PICTURE c_a, PICTURE c_c, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c_a.name = 'nemoeye3' AND c_c.name = '81';
  
SELECT SDO_GEOM.WITHIN_DISTANCE(c_b.shape, m.diminfo, 1,
     c_d.shape, m.diminfo) as bool
  FROM picture c_b, picture c_d, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c_b.name = 'E1' AND c_d.name = 'E2';
SELECT c.name, SDO_GEOM.SDO_CONVEXHULL(c.shape, m.diminfo) 
  FROM picture c, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c.name = 'ship1';
SELECT c.name, SDO_GEOM.SDO_ARC_DENSIFY(c.shape, m.diminfo, 
                                       'arc_tolerance=0.05') 
  FROM picture c, user_sdo_geom_metadata m 
  WHERE m.table_name = 'PICTURE' AND m.column_name = 'SHAPE' 
  AND c.name = 'S1';

  
DROP TABLE picture purge;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'PICTURE';
CREATE TABLE picture(
  id NUMBER PRIMARY KEY,
  name VARCHAR2(32),
  shape MDSYS.SDO_GEOMETRY);
INSERT INTO USER_SDO_GEOM_METADATA VALUES (
  'PICTURE','shape',MDSYS.SDO_DIM_ARRAY (
     MDSYS.SDO_DIM_ELEMENT('X',0,750,0.005),
     MDSYS.SDO_DIM_ELEMENT('Y',0,750,0.005)), NULL
);
--INSERT INTO picture VALUES (
--  1,'sky',MDSYS.SDO_GEOMETRY (2004,  -- many arc
--  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,4,12, 1,2,2, 5,2,2,9,2,2,13,2,2,17,2,2,21,2,2,25,2,2,29,2,2,33,2,2,37,2,2,41,2,2,45,2,2), -- rectangle
--  MDSYS.SDO_ORDINATE_ARRAY(30,570,45,562,60,570,90,580,120,570,150,560,180,570,210,580,240,570,270,560,300,570,330,580,360,570,390,560,420,570
--  ,450,580,480,570,510,560,540,570,570,580,600,570,630,560,660,570,675,577,690,580
--  )) -- rectangle corners
--);
INSERT INTO picture VALUES (
  1,'sky1',MDSYS.SDO_GEOMETRY (2004,  -- many arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,4,10, 1,2,2, 5,2,2,9,2,2,13,2,2,17,2,2,21,2,2,25,2,2,29,2,2,33,2,2,37,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(60,570,90,580,120,570,150,560,180,570,210,580,240,570,270,560,300,570,330,580,360,570,390,560,420,570
 ,450,580,480,570,510,560,540,570,570,580,600,570,630,560,660,570
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  2,'sky2',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(60,570,45,563,30,560)) 
);
INSERT INTO picture VALUES (
  3,'sky3',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(660,570,675,577,690,580)) 
);


INSERT INTO picture VALUES (
  4,'moon1',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(270,660,255,645,270,630)) 
);
INSERT INTO picture VALUES (
  5,'moon2',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(270,660,262,645,270,630)) 
);
INSERT INTO picture VALUES (
  6,'bird',MDSYS.SDO_GEOMETRY (2004,  -- 2 arcs
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,4,2, 1,2,2, 5,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(480,652,490,660,500,652,510,660,520,652)) -- 
);
--INSERT INTO picture VALUES (
--  6,'bird',MDSYS.SDO_GEOMETRY (2004,  -- 2 arcs
--  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,4,2, 1,2,2, 5,2,2), -- 
--  MDSYS.SDO_ORDINATE_ARRAY(400,612,410,620,420,612,430,620,440,612)) -- 
--);


INSERT INTO picture VALUES (
  7,'ship1',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(240,375,330,390,420,375)) -- 
);
INSERT INTO picture VALUES (
 8,'ship2',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(240,315,330,300,420,315)) -- 
);
INSERT INTO picture VALUES (
 9,'ship3',MDSYS.SDO_GEOMETRY (2006,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- MULTIPLE LINE
  MDSYS.SDO_ORDINATE_ARRAY(240,315,210,300,210,390,240,375))
);
INSERT INTO picture VALUES (
  10,'ship4',MDSYS.SDO_GEOMETRY (2006,  -- multiline
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- 
  MDSYS.SDO_ORDINATE_ARRAY(420,375,480,345,420,315)) 
);
INSERT INTO picture VALUES (
  11,'ship4',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(420,375,405,345,420,315)) 
);
--INSERT INTO picture VALUES (
--  11,'ship4',MDSYS.SDO_GEOMETRY (2003,  -- 2D polygon
-- null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,1005,2, 1,2,1, 5,2,2), -- POLYGON
--  MDSYS.SDO_ORDINATE_ARRAY(420,315,480,345,420,375,405,345,420,315)) 
--);

INSERT INTO picture VALUES (
  12,'ship5',MDSYS.SDO_GEOMETRY (2006,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- MULTIPLE LINE
  MDSYS.SDO_ORDINATE_ARRAY(285,387,285,414,328,414,328,390)) 
);
INSERT INTO picture VALUES (
  13,'ship6',MDSYS.SDO_GEOMETRY (2006,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- multi line
  MDSYS.SDO_ORDINATE_ARRAY(300,414,300,460,330,460,330,450,309,450,309,414)) 
);
INSERT INTO picture VALUES (
  14,'N',MDSYS.SDO_GEOMETRY (2006,  
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), --  multi line
  MDSYS.SDO_ORDINATE_ARRAY(165,510,165,525,174,510,174,525)) 
);
INSERT INTO picture VALUES (
  15,'E1',MDSYS.SDO_GEOMETRY (2006,  
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- 
  MDSYS.SDO_ORDINATE_ARRAY(189,525,180,525,180,510,189,510)) -- 
);
INSERT INTO picture VALUES (
  16,'E2',MDSYS.SDO_GEOMETRY (2002,  
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), --line
  MDSYS.SDO_ORDINATE_ARRAY(180,517,189,517)) -- 
);
INSERT INTO picture VALUES (
  17,'M',MDSYS.SDO_GEOMETRY (2006,  -- multiline
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- 
  MDSYS.SDO_ORDINATE_ARRAY(195,510,195,525,202,515,209,525,209,510)) -- 
);
INSERT INTO picture VALUES (
  18,'O1',MDSYS.SDO_GEOMETRY (2002,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- arc
 MDSYS.SDO_ORDINATE_ARRAY(220,525,215,518,220,510)) 
);
INSERT INTO picture VALUES (
 19,'O2',MDSYS.SDO_GEOMETRY (2002,  -- 
 null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- arc
  MDSYS.SDO_ORDINATE_ARRAY(220,525,225,518,220,510)) 
);
INSERT INTO picture VALUES (
  20,'V',MDSYS.SDO_GEOMETRY (2006,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- multiline
  MDSYS.SDO_ORDINATE_ARRAY(255,525,259,510,264,525)) -- 
);
INSERT INTO picture VALUES (
  21,'S1',MDSYS.SDO_GEOMETRY (2002,  -- 2D polygon
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- rectangle
  MDSYS.SDO_ORDINATE_ARRAY(
  273,525,275,524,277,521
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  22,'S2',MDSYS.SDO_GEOMETRY (2002,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
 273,525,269,521,273,517
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  23,'S3',MDSYS.SDO_GEOMETRY (2002,  -- 2D polygon
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- rectangle
  MDSYS.SDO_ORDINATE_ARRAY(
  273,517,275,516, 277,513
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  24,'S4',MDSYS.SDO_GEOMETRY (2002,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  269,513,273,509,277,513
  )) -- rectangle corners
);


INSERT INTO picture VALUES (
  25,'81',MDSYS.SDO_GEOMETRY (2003,  -- circle
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,4), -- circle
  MDSYS.SDO_ORDINATE_ARRAY(
  292,521,300,521,296,517
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  26,'82',MDSYS.SDO_GEOMETRY (2003,  -- circle
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,4), 
  MDSYS.SDO_ORDINATE_ARRAY(
  292,513,300,513,296,509
  )) -- rectangle corners
);

INSERT INTO picture VALUES (
  27,'nemohead1',MDSYS.SDO_GEOMETRY (2002,  --arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(
  375,387,366,403,365,420
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  28,'nemohead2',MDSYS.SDO_GEOMETRY (2002,  --arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(
  365,420,384,480,422,506
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  29,'nemohead3',MDSYS.SDO_GEOMETRY (2002,  --arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), 
  MDSYS.SDO_ORDINATE_ARRAY(
  422,506,456,495,470,458
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  33,'nemohead4',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), --
  MDSYS.SDO_ORDINATE_ARRAY(
 470,458,466,428,418,377
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  34,'nemoarm1',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), --
  MDSYS.SDO_ORDINATE_ARRAY(
 309,300,328,369,365,420
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  35,'nemoarm2',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  319,300,330,351,366,408
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  36,'nemoarm3',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  358,389,364,398,368,400
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  37,'nemoarm4',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  366,389,368,393,370,394
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  38,'nemoarm5',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  309,300,324,285,339,300
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  39,'nemoarm6',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  319,300,324,295,329,300
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  40,'nemoarm7',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  395,304,385,293,371,286
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  41,'nemoarm8',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  385,304,379,298,371,296
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  42,'nemoarm9',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  371,296,366,297,361,300
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  43,'nemoarm10',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  371,286,357,290,351,300
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  44,'nemoarm11',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  351,300,356,314,365,324
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  45,'nemoarm12',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  361,300,363,314,365,324
  )) -- rectangle corners
);



INSERT INTO picture VALUES (
  46,'nemoeye1',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  420,475,432,479,444,475
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  47,'nemoeye2',MDSYS.SDO_GEOMETRY (2002,  -- arc
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,2), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
   420,475,432,471,444,475
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  48,'nemoeye3',MDSYS.SDO_GEOMETRY (2003,  -- circle
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,4), -- 
  MDSYS.SDO_ORDINATE_ARRAY(
  430,475,434,475,432,473
  )) -- rectangle corners
);
INSERT INTO picture VALUES (
  49,'nemomouth',MDSYS.SDO_GEOMETRY (2006,  -- 
  null,null,MDSYS.SDO_ELEM_INFO_ARRAY(1,2,1), -- multiline
  MDSYS.SDO_ORDINATE_ARRAY(
   381,417,391,422,391,411,401,416,401,
   405,411,411,411,399,421,406,421,393
  )) 
);

