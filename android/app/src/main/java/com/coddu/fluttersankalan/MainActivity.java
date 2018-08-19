package com.coddu.fluttersankalan;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.crashlytics.android.Crashlytics;
import io.fabric.sdk.android.Fabric;
public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Fabric.with(this, new Crashlytics());
  }
}
