-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  map_frame = "map",
  tracking_frame = "base_link",
  published_frame = "odom",
  odom_frame = "odom",
  provide_odom_frame = false,
  use_odometry = false,
  use_laser_scan = true,
  use_multi_echo_laser_scan = false,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 0.1,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
}

TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 7
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 30

MAP_BUILDER.use_trajectory_builder_2d = true

TRAJECTORY_BUILDER_2D.laser_min_range = 0.
TRAJECTORY_BUILDER_2D.laser_max_range = 25.
TRAJECTORY_BUILDER_2D.laser_missing_echo_ray_length = 5.
TRAJECTORY_BUILDER_2D.use_imu_data = true

TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 1e2
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 100

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.0
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(50)
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 0
-- TRAJECTORY_BUILDER_2D.submaps.laser_fan_inserter.miss_probability = 0.48
TRAJECTORY_BUILDER_2D.submaps.laser_fan_inserter.hit_probability = 0.60
TRAJECTORY_BUILDER_2D.submaps.resolution = 0.05
TRAJECTORY_BUILDER_2D.submaps.num_laser_fans = 35
TRAJECTORY_BUILDER_2D.submaps.output_debug_images = true
TRAJECTORY_BUILDER_2D.submaps.laser_fan_inserter.insert_free_space = true

-- SPARSE_POSE_GRAPH.optimization_problem.huber_scale = 1e2
SPARSE_POSE_GRAPH.constraint_builder.min_score = 0.70
SPARSE_POSE_GRAPH.constraint_builder.max_constraint_distance = 8.
SPARSE_POSE_GRAPH.optimize_every_n_scans = 35
SPARSE_POSE_GRAPH.optimization_problem.ceres_solver_options.num_threads = 35

return options
