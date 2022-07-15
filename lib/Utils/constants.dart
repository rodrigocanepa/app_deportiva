import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const int PAGE_TRANSITION_DURATION = 400;

const Color GRANDIENT_GREEEN_TOP = Color.fromARGB(255, 143, 209, 190);

// Shimmer Settings
const ShimmerDirection shimmerDirection = ShimmerDirection.ltr;
const Duration shimmerPeriod = Duration(milliseconds: 2000);
const Gradient shimmerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  stops: [0, 0.25, 0.75, 1],
  colors: [
    Color(0x1A000000),
    Color(0x20FFFFFF),
    Color(0x1A000000),
    Color(0x20FFFFFF),
  ],
  // tileMode: TileMode.repeated,
);

const bool shimmerEnabled = true;

// firebase references
const REFERENCE_USERS = "Users";
const SUBREFERENCE_FOLLOWING = "XXXXXXX";


