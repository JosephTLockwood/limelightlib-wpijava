diff --git a/LimelightHelpers.java b/LimelightHelpers.java
index efdfeb5..8135f60 100644
--- a/LimelightHelpers.java
+++ b/LimelightHelpers.java
@@ -1,4 +1,4 @@
-//LimelightHelpers v1.9 (REQUIRES 2024.9.1)
+//LimelightHelpers v1.10 (REQUIRES 2024.9.1)
 
 package frc.robot;
 
@@ -32,11 +32,17 @@ import com.fasterxml.jackson.databind.DeserializationFeature;
 import com.fasterxml.jackson.databind.ObjectMapper;
 import java.util.concurrent.ConcurrentHashMap;
 
+/**
+ * LimelightHelpers provides static methods and classes for interfacing with Limelight vision cameras in FRC.
+ * This library supports all Limelight features including AprilTag tracking, Neural Networks, and standard color/retroreflective tracking.
+ */
 public class LimelightHelpers {
 
     private static final Map<String, DoubleArrayEntry> doubleArrayEntries = new ConcurrentHashMap<>();
 
-
+    /**
+     * Represents a Color/Retroreflective Target Result extracted from JSON Output
+     */
     public static class LimelightTarget_Retro {
 
         @JsonProperty("t6c_ts")
@@ -101,16 +107,22 @@ public class LimelightHelpers {
 
         @JsonProperty("tx")
         public double tx;
+        
+        @JsonProperty("ty")
+        public double ty;
 
         @JsonProperty("txp")
         public double tx_pixels;
 
-        @JsonProperty("ty")
-        public double ty;
-
         @JsonProperty("typ")
         public double ty_pixels;
 
+        @JsonProperty("tx_nocross")
+        public double tx_nocrosshair;
+
+        @JsonProperty("ty_nocross")
+        public double ty_nocrosshair;
+
         @JsonProperty("ts")
         public double ts;
 
@@ -124,6 +136,9 @@ public class LimelightHelpers {
 
     }
 
+    /**
+     * Represents an AprilTag/Fiducial Target Result extracted from JSON Output
+     */
     public static class LimelightTarget_Fiducial {
 
         @JsonProperty("fID")
@@ -195,15 +210,21 @@ public class LimelightHelpers {
         @JsonProperty("tx")
         public double tx;
 
-        @JsonProperty("txp")
-        public double tx_pixels;
-
         @JsonProperty("ty")
         public double ty;
 
+        @JsonProperty("txp")
+        public double tx_pixels;
+
         @JsonProperty("typ")
         public double ty_pixels;
 
+        @JsonProperty("tx_nocross")
+        public double tx_nocrosshair;
+
+        @JsonProperty("ty_nocross")
+        public double ty_nocrosshair;
+
         @JsonProperty("ts")
         public double ts;
         
@@ -216,10 +237,58 @@ public class LimelightHelpers {
         }
     }
 
+    /**
+     * Represents a Barcode Target Result extracted from JSON Output
+     */
     public static class LimelightTarget_Barcode {
 
+        /**
+         * Barcode family type (e.g. "QR", "DataMatrix", etc.)
+         */
+        @JsonProperty("fam")
+        public String family;
+
+        /**
+         * Gets the decoded data content of the barcode
+         */
+        @JsonProperty("data") 
+        public String data;
+
+        @JsonProperty("txp")
+        public double tx_pixels;
+
+        @JsonProperty("typ")
+        public double ty_pixels;
+
+        @JsonProperty("tx")
+        public double tx;
+
+        @JsonProperty("ty")
+        public double ty;
+
+        @JsonProperty("tx_nocross")
+        public double tx_nocrosshair;
+
+        @JsonProperty("ty_nocross")
+        public double ty_nocrosshair;
+
+        @JsonProperty("ta")
+        public double ta;
+
+        @JsonProperty("pts")
+        public double[][] corners;
+
+        public LimelightTarget_Barcode() {
+        }
+
+        public String getFamily() {
+            return family;
+        }
     }
 
+    /**
+     * Represents a Neural Classifier Pipeline Result extracted from JSON Output
+     */
     public static class LimelightTarget_Classifier {
 
         @JsonProperty("class")
@@ -250,6 +319,9 @@ public class LimelightHelpers {
         }
     }
 
+    /**
+     * Represents a Neural Detector Pipeline Result extracted from JSON Output
+     */
     public static class LimelightTarget_Detector {
 
         @JsonProperty("class")
@@ -267,19 +339,28 @@ public class LimelightHelpers {
         @JsonProperty("tx")
         public double tx;
 
-        @JsonProperty("txp")
-        public double tx_pixels;
-
         @JsonProperty("ty")
         public double ty;
 
+        @JsonProperty("txp")
+        public double tx_pixels;
+
         @JsonProperty("typ")
         public double ty_pixels;
 
+        @JsonProperty("tx_nocross")
+        public double tx_nocrosshair;
+
+        @JsonProperty("ty_nocross")
+        public double ty_nocrosshair;
+
         public LimelightTarget_Detector() {
         }
     }
 
+    /**
+     * Limelight Results object, parsed from a Limelight's JSON results output.
+     */
     public static class LimelightResults {
         
         public String error;
@@ -384,6 +465,9 @@ public class LimelightHelpers {
 
     }
 
+    /**
+     * Represents a Limelight Raw Fiducial result from Limelight's NetworkTables output.
+     */
     public static class RawFiducial {
         public int id = 0;
         public double txnc = 0;
@@ -405,6 +489,9 @@ public class LimelightHelpers {
         }
     }
 
+    /**
+     * Represents a Limelight Raw Neural Detector result from Limelight's NetworkTables output.
+     */
     public static class RawDetection {
         public int classId = 0;
         public double txnc = 0;
@@ -439,7 +526,10 @@ public class LimelightHelpers {
             this.corner3_Y = corner3_Y;
         }
     }
-
+    
+    /**
+     * Represents a 3D Pose Estimate.
+     */
     public static class PoseEstimate {
         public Pose2d pose;
         public double timestampSeconds;
@@ -448,10 +538,11 @@ public class LimelightHelpers {
         public double tagSpan;
         public double avgTagDist;
         public double avgTagArea;
+
         public RawFiducial[] rawFiducials; 
 
         /**
-         * Makes a PoseEstimate object with default values
+         * Instantiates a PoseEstimate object with default values
          */
         public PoseEstimate() {
             this.pose = new Pose2d();
@@ -494,6 +585,12 @@ public class LimelightHelpers {
         return name;
     }
 
+    /**
+     * Takes a 6-length array of pose data and converts it to a Pose3d object.
+     * Array format: [x, y, z, roll, pitch, yaw] where angles are in degrees.
+     * @param inData Array containing pose data [x, y, z, roll, pitch, yaw]
+     * @return Pose3d object representing the pose, or empty Pose3d if invalid data
+     */
     public static Pose3d toPose3D(double[] inData){
         if(inData.length < 6)
         {
@@ -506,6 +603,13 @@ public class LimelightHelpers {
                     Units.degreesToRadians(inData[5])));
     }
 
+    /**
+     * Takes a 6-length array of pose data and converts it to a Pose2d object.
+     * Uses only x, y, and yaw components, ignoring z, roll, and pitch.
+     * Array format: [x, y, z, roll, pitch, yaw] where angles are in degrees.
+     * @param inData Array containing pose data [x, y, z, roll, pitch, yaw]
+     * @return Pose2d object representing the pose, or empty Pose2d if invalid data
+     */
     public static Pose2d toPose2D(double[] inData){
         if(inData.length < 6)
         {
@@ -518,11 +622,12 @@ public class LimelightHelpers {
     }
 
     /**
-     * Converts a Pose3d object to an array of doubles.
+     * Converts a Pose3d object to an array of doubles in the format [x, y, z, roll, pitch, yaw].
+     * Translation components are in meters, rotation components are in degrees.
      * 
-     * @param pose The Pose3d object to convert.
-     * @return The array of doubles representing the pose.
-     **/
+     * @param pose The Pose3d object to convert
+     * @return A 6-element array containing [x, y, z, roll, pitch, yaw]
+     */
     public static double[] pose3dToArray(Pose3d pose) {
         double[] result = new double[6];
         result[0] = pose.getTranslation().getX();
@@ -535,11 +640,13 @@ public class LimelightHelpers {
     }
 
     /**
-     * Converts a Pose2d object to an array of doubles.
+     * Converts a Pose2d object to an array of doubles in the format [x, y, z, roll, pitch, yaw].
+     * Translation components are in meters, rotation components are in degrees.
+     * Note: z, roll, and pitch will be 0 since Pose2d only contains x, y, and yaw.
      * 
-     * @param pose The Pose2d object to convert.
-     * @return The array of doubles representing the pose.
-     **/
+     * @param pose The Pose2d object to convert
+     * @return A 6-element array containing [x, y, 0, 0, 0, yaw]
+     */
     public static double[] pose2dToArray(Pose2d pose) {
         double[] result = new double[6];
         result[0] = pose.getTranslation().getX();
@@ -604,7 +711,13 @@ public class LimelightHelpers {
         return new PoseEstimate(pose, adjustedTimestamp, latency, tagCount, tagSpan, tagDist, tagArea, rawFiducials);
     }
 
-    private static RawFiducial[] getRawFiducials(String limelightName) {
+    /**
+     * Gets the latest raw fiducial/AprilTag detection results from NetworkTables.
+     * 
+     * @param limelightName Name/identifier of the Limelight
+     * @return Array of RawFiducial objects containing detection details
+     */
+    public static RawFiducial[] getRawFiducials(String limelightName) {
         var entry = LimelightHelpers.getLimelightNTTableEntry(limelightName, "rawfiducials");
         var rawFiducialArray = entry.getDoubleArray(new double[0]);
         int valsPerEntry = 7;
@@ -631,10 +744,16 @@ public class LimelightHelpers {
         return rawFiducials;
     }
 
+    /**
+     * Gets the latest raw neural detector results from NetworkTables
+     *
+     * @param limelightName Name/identifier of the Limelight
+     * @return Array of RawDetection objects containing detection details
+     */
     public static RawDetection[] getRawDetections(String limelightName) {
         var entry = LimelightHelpers.getLimelightNTTableEntry(limelightName, "rawdetections");
         var rawDetectionArray = entry.getDoubleArray(new double[0]);
-        int valsPerEntry = 11;
+        int valsPerEntry = 12;
         if (rawDetectionArray.length % valsPerEntry != 0) {
             return new RawDetection[0];
         }
@@ -663,6 +782,13 @@ public class LimelightHelpers {
         return rawDetections;
     }
 
+    /**
+     * Prints detailed information about a PoseEstimate to standard output.
+     * Includes timestamp, latency, tag count, tag span, average tag distance,
+     * average tag area, and detailed information about each detected fiducial.
+     *
+     * @param pose The PoseEstimate object to print. If null, prints "No PoseEstimate available."
+     */
     public static void printPoseEstimate(PoseEstimate pose) {
         if (pose == null) {
             System.out.println("No PoseEstimate available.");
@@ -735,7 +861,6 @@ public class LimelightHelpers {
     }
 
 
-
     public static String getLimelightNTString(String tableName, String entryName) {
         return getLimelightNTTableEntry(tableName, entryName).getString("");
     }
@@ -759,23 +884,57 @@ public class LimelightHelpers {
     /////
     /////
 
+    /**
+     * Does the Limelight have a valid target?
+     * @param limelightName Name of the Limelight camera ("" for default)
+     * @return True if a valid target is present, false otherwise
+     */
+    public static boolean getTV(String limelightName) {
+        return 1.0 == getLimelightNTDouble(limelightName, "tv");
+    }
+
+    /**
+     * Gets the horizontal offset from the crosshair to the target in degrees.
+     * @param limelightName Name of the Limelight camera ("" for default)
+     * @return Horizontal offset angle in degrees
+     */
     public static double getTX(String limelightName) {
         return getLimelightNTDouble(limelightName, "tx");
     }
 
+    /**
+     * Gets the vertical offset from the crosshair to the target in degrees.
+     * @param limelightName Name of the Limelight camera ("" for default)
+     * @return Vertical offset angle in degrees
+     */
     public static double getTY(String limelightName) {
         return getLimelightNTDouble(limelightName, "ty");
     }
 
+    /**
+     * Gets the target area as a percentage of the image (0-100%).
+     * @param limelightName Name of the Limelight camera ("" for default) 
+     * @return Target area percentage (0-100)
+     */
     public static double getTA(String limelightName) {
         return getLimelightNTDouble(limelightName, "ta");
     }
 
+    /**
+     * T2D is an array that contains several targeting metrcis
+     * @param limelightName Name of the Limelight camera
+     * @return Array containing  [targetValid, targetCount, targetLatency, captureLatency, tx, ty, txnc, tync, ta, tid, targetClassIndexDetector, 
+     * targetClassIndexClassifier, targetLongSidePixels, targetShortSidePixels, targetHorizontalExtentPixels, targetVerticalExtentPixels, targetSkewDegrees]
+     */
     public static double[] getT2DArray(String limelightName) {
         return getLimelightNTDoubleArray(limelightName, "t2d");
     }
     
-
+    /**
+     * Gets the number of targets currently detected.
+     * @param limelightName Name of the Limelight camera
+     * @return Number of detected targets
+     */
     public static int getTargetCount(String limelightName) {
       double[] t2d = getT2DArray(limelightName);
       if(t2d.length == 17)
@@ -785,6 +944,11 @@ public class LimelightHelpers {
       return 0;
     }
 
+    /**
+     * Gets the classifier class index from the currently running neural classifier pipeline
+     * @param limelightName Name of the Limelight camera
+     * @return Class index from classifier pipeline
+     */
     public static int getClassifierClassIndex (String limelightName) {
     double[] t2d = getT2DArray(limelightName);
       if(t2d.length == 17)
@@ -793,6 +957,12 @@ public class LimelightHelpers {
       }
       return 0;
     }
+
+    /**
+     * Gets the detector class index from the primary result of the currently running neural detector pipeline.
+     * @param limelightName Name of the Limelight camera
+     * @return Class index from detector pipeline
+     */
     public static int getDetectorClassIndex (String limelightName) {
      double[] t2d = getT2DArray(limelightName);
       if(t2d.length == 17)
@@ -801,31 +971,66 @@ public class LimelightHelpers {
       }
       return 0;
     }
-    
+
+    /**
+     * Gets the current neural classifier result class name.
+     * @param limelightName Name of the Limelight camera
+     * @return Class name string from classifier pipeline
+     */
     public static String getClassifierClass (String limelightName) {
         return getLimelightNTString(limelightName, "tcclass");
     }
+
+    /**
+     * Gets the primary neural detector result class name.
+     * @param limelightName Name of the Limelight camera
+     * @return Class name string from detector pipeline
+     */
     public static String getDetectorClass (String limelightName) {
         return getLimelightNTString(limelightName, "tdclass");
     }
 
-
+    /**
+     * Gets the pipeline's processing latency contribution.
+     * @param limelightName Name of the Limelight camera
+     * @return Pipeline latency in milliseconds
+     */
     public static double getLatency_Pipeline(String limelightName) {
         return getLimelightNTDouble(limelightName, "tl");
     }
 
+    /**
+     * Gets the capture latency.
+     * @param limelightName Name of the Limelight camera
+     * @return Capture latency in milliseconds
+     */
     public static double getLatency_Capture(String limelightName) {
         return getLimelightNTDouble(limelightName, "cl");
     }
 
+    /**
+     * Gets the active pipeline index.
+     * @param limelightName Name of the Limelight camera
+     * @return Current pipeline index (0-9)
+     */
     public static double getCurrentPipelineIndex(String limelightName) {
         return getLimelightNTDouble(limelightName, "getpipe");
     }
 
+    /**
+     * Gets the current pipeline type.
+     * @param limelightName Name of the Limelight camera
+     * @return Pipeline type string (e.g. "retro", "apriltag", etc)
+     */
     public static String getCurrentPipelineType(String limelightName) {
         return getLimelightNTString(limelightName, "getpipetype");
     }
 
+    /**
+     * Gets the full JSON results dump.
+     * @param limelightName Name of the Limelight camera
+     * @return JSON string containing all current results
+     */
     public static String getJSONDump(String limelightName) {
         return getLimelightNTString(limelightName, "json");
     }
@@ -915,36 +1120,71 @@ public class LimelightHelpers {
         return toPose3D(poseArray);
     }
 
+    /**
+     * (Not Recommended) Gets the robot's 3D pose in the WPILib Red Alliance Coordinate System.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the robot's position and orientation in Red Alliance field space
+     */
     public static Pose3d getBotPose3d_wpiRed(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "botpose_wpired");
         return toPose3D(poseArray);
     }
 
+    /**
+     * (Recommended) Gets the robot's 3D pose in the WPILib Blue Alliance Coordinate System.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the robot's position and orientation in Blue Alliance field space
+     */
     public static Pose3d getBotPose3d_wpiBlue(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "botpose_wpiblue");
         return toPose3D(poseArray);
     }
 
+    /**
+     * Gets the robot's 3D pose with respect to the currently tracked target's coordinate system.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the robot's position and orientation relative to the target
+     */
     public static Pose3d getBotPose3d_TargetSpace(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "botpose_targetspace");
         return toPose3D(poseArray);
     }
 
+    /**
+     * Gets the camera's 3D pose with respect to the currently tracked target's coordinate system.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the camera's position and orientation relative to the target
+     */
     public static Pose3d getCameraPose3d_TargetSpace(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "camerapose_targetspace");
         return toPose3D(poseArray);
     }
 
+    /**
+     * Gets the target's 3D pose with respect to the camera's coordinate system.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the target's position and orientation relative to the camera
+     */
     public static Pose3d getTargetPose3d_CameraSpace(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "targetpose_cameraspace");
         return toPose3D(poseArray);
     }
 
+    /**
+     * Gets the target's 3D pose with respect to the robot's coordinate system.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the target's position and orientation relative to the robot
+     */
     public static Pose3d getTargetPose3d_RobotSpace(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "targetpose_robotspace");
         return toPose3D(poseArray);
     }
 
+    /**
+     * Gets the camera's 3D pose with respect to the robot's coordinate system.
+     * @param limelightName Name/identifier of the Limelight
+     * @return Pose3d object representing the camera's position and orientation relative to the robot
+     */
     public static Pose3d getCameraPose3d_RobotSpace(String limelightName) {
         double[] poseArray = getLimelightNTDoubleArray(limelightName, "camerapose_robotspace");
         return toPose3D(poseArray);
@@ -964,8 +1204,7 @@ public class LimelightHelpers {
     }
 
     /**
-     * Gets the Pose2d and timestamp for use with WPILib pose estimator (addVisionMeasurement) when you are on the BLUE
-     * alliance
+     * Gets the MegaTag1 Pose2d and timestamp for use with WPILib pose estimator (addVisionMeasurement) in the WPILib Blue alliance coordinate system.
      * 
      * @param limelightName
      * @return
@@ -975,8 +1214,8 @@ public class LimelightHelpers {
     }
 
     /**
-     * Gets the Pose2d and timestamp for use with WPILib pose estimator (addVisionMeasurement) when you are on the BLUE
-     * alliance
+     * Gets the MegaTag2 Pose2d and timestamp for use with WPILib pose estimator (addVisionMeasurement) in the WPILib Blue alliance coordinate system.
+     * Make sure you are calling setRobotOrientation() before calling this method.
      * 
      * @param limelightName
      * @return
@@ -1032,10 +1271,8 @@ public class LimelightHelpers {
         return toPose2D(result);
 
     }
+   
 
-    public static boolean getTV(String limelightName) {
-        return 1.0 == getLimelightNTDouble(limelightName, "tv");
-    }
 
     /////
     /////
@@ -1050,8 +1287,8 @@ public class LimelightHelpers {
     }
 
     /**
-     * The LEDs will be controlled by Limelight pipeline settings, and not by robot
-     * code.
+     * Sets LED mode to be controlled by the current pipeline.
+     * @param limelightName Name of the Limelight camera
      */
     public static void setLEDMode_PipelineControl(String limelightName) {
         setLimelightNTDouble(limelightName, "ledMode", 0);
@@ -1069,22 +1306,38 @@ public class LimelightHelpers {
         setLimelightNTDouble(limelightName, "ledMode", 3);
     }
 
+    /**
+     * Enables standard side-by-side stream mode.
+     * @param limelightName Name of the Limelight camera
+     */
     public static void setStreamMode_Standard(String limelightName) {
         setLimelightNTDouble(limelightName, "stream", 0);
     }
 
+    /**
+     * Enables Picture-in-Picture mode with secondary stream in the corner.
+     * @param limelightName Name of the Limelight camera
+     */
     public static void setStreamMode_PiPMain(String limelightName) {
         setLimelightNTDouble(limelightName, "stream", 1);
     }
 
+    /**
+     * Enables Picture-in-Picture mode with primary stream in the corner.
+     * @param limelightName Name of the Limelight camera
+     */
     public static void setStreamMode_PiPSecondary(String limelightName) {
         setLimelightNTDouble(limelightName, "stream", 2);
     }
 
 
     /**
-     * Sets the crop window. The crop window in the UI must be completely open for
-     * dynamic cropping to work.
+     * Sets the crop window for the camera. The crop window in the UI must be completely open.
+     * @param limelightName Name of the Limelight camera
+     * @param cropXMin Minimum X value (-1 to 1)
+     * @param cropXMax Maximum X value (-1 to 1)
+     * @param cropYMin Minimum Y value (-1 to 1)
+     * @param cropYMax Maximum Y value (-1 to 1)
      */
     public static void setCropWindow(String limelightName, double cropXMin, double cropXMax, double cropYMin, double cropYMax) {
         double[] entries = new double[4];
@@ -1106,6 +1359,17 @@ public class LimelightHelpers {
         setLimelightNTDoubleArray(limelightName, "fiducial_offset_set", entries);
     }
 
+    /**
+     * Sets robot orientation values used by MegaTag2 localization algorithm.
+     * 
+     * @param limelightName Name/identifier of the Limelight
+     * @param yaw Robot yaw in degrees. 0 = robot facing red alliance wall in FRC
+     * @param yawRate (Unnecessary) Angular velocity of robot yaw in degrees per second
+     * @param pitch (Unnecessary) Robot pitch in degrees 
+     * @param pitchRate (Unnecessary) Angular velocity of robot pitch in degrees per second
+     * @param roll (Unnecessary) Robot roll in degrees
+     * @param rollRate (Unnecessary) Angular velocity of robot roll in degrees per second
+     */
     public static void SetRobotOrientation(String limelightName, double yaw, double yawRate, 
         double pitch, double pitchRate, 
         double roll, double rollRate) {
@@ -1136,7 +1400,15 @@ public class LimelightHelpers {
         }
     }
 
-
+    /**
+     * Sets the 3D point-of-interest offset for the current fiducial pipeline. 
+     * https://docs.limelightvision.io/docs/docs-limelight/pipeline-apriltag/apriltag-3d#point-of-interest-tracking
+     *
+     * @param limelightName Name/identifier of the Limelight
+     * @param x X offset in meters
+     * @param y Y offset in meters
+     * @param z Z offset in meters
+     */
     public static void SetFidcuial3DOffset(String limelightName, double x, double y, 
         double z) {
 
@@ -1147,6 +1419,13 @@ public class LimelightHelpers {
         setLimelightNTDoubleArray(limelightName, "fiducial_offset_set", entries);
     }
 
+    /**
+     * Overrides the valid AprilTag IDs that will be used for localization.
+     * Tags not in this list will be ignored for robot pose estimation.
+     *
+     * @param limelightName Name/identifier of the Limelight
+     * @param validIDs Array of valid AprilTag IDs to track
+     */
     public static void SetFiducialIDFiltersOverride(String limelightName, int[] validIDs) {
         double[] validIDsDouble = new double[validIDs.length];
         for (int i = 0; i < validIDs.length; i++) {
@@ -1155,6 +1434,13 @@ public class LimelightHelpers {
         setLimelightNTDoubleArray(limelightName, "fiducial_id_filters_set", validIDsDouble);
     }
 
+    /**
+     * Sets the downscaling factor for AprilTag detection.
+     * Increasing downscale can improve performance at the cost of potentially reduced detection range.
+     * 
+     * @param limelightName Name/identifier of the Limelight
+     * @param downscale Downscale factor. Valid values: 1.0 (no downscale), 1.5, 2.0, 3.0, 4.0. Set to 0 for pipeline control.
+     */
     public static void SetFiducialDownscalingOverride(String limelightName, float downscale) 
     {
         int d = 0; // pipeline
@@ -1181,6 +1467,16 @@ public class LimelightHelpers {
         setLimelightNTDouble(limelightName, "fiducial_downscale_set", d);
     }
     
+    /**
+     * Sets the camera pose relative to the robot.
+     * @param limelightName Name of the Limelight camera
+     * @param forward Forward offset in meters
+     * @param side Side offset in meters
+     * @param up Up offset in meters
+     * @param roll Roll angle in degrees
+     * @param pitch Pitch angle in degrees
+     * @param yaw Yaw angle in degrees
+     */
     public static void setCameraPose_RobotSpace(String limelightName, double forward, double side, double up, double roll, double pitch, double yaw) {
         double[] entries = new double[6];
         entries[0] = forward;
@@ -1237,7 +1533,9 @@ public class LimelightHelpers {
     }
 
     /**
-     * Parses Limelight's JSON results dump into a LimelightResults Object
+     * Gets the latest JSON results output and returns a LimelightResults object.
+     * @param limelightName Name of the Limelight camera
+     * @return LimelightResults object containing all current target data
      */
     public static LimelightResults getLatestResults(String limelightName) {
 
