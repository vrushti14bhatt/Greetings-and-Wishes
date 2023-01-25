package app.greetings.wishes.greetings_and_wishes


import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.core.content.ContextCompat.*
import android.content.Context
import java.io.File
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import android.widget.ImageView
import com.google.android.gms.ads.formats.UnifiedNativeAd
import com.google.android.gms.ads.formats.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class MainActivity: FlutterActivity() {

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val factory: NativeAdFactory = NativeAdFactoryExample(layoutInflater)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", factory)
    }

}

internal class NativeAdFactoryExample(private val layoutInflater: LayoutInflater) : NativeAdFactory {
    override fun createNativeAd(nativeAd: com.google.android.gms.ads.nativead.NativeAd?, customOptions: MutableMap<String, Any>?): NativeAdView? {
        val adView = layoutInflater.inflate(R.layout.list_tile_native_ad, null) as NativeAdView
//        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
//        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
//        headlineView.text = nativeAd.headline
//        bodyView.text = nativeAd.body

        adView.setNativeAd(nativeAd!!)

        val attributionViewSmall: TextView = adView
                .findViewById(R.id.tv_list_tile_native_ad_attribution_small)
        val attributionViewLarge: TextView = adView
                .findViewById(R.id.tv_list_tile_native_ad_attribution_large)

        val iconView: ImageView = adView.findViewById(R.id.iv_list_tile_native_ad_icon)
        val icon: com.google.android.gms.ads.nativead.NativeAd.Image? = nativeAd!!.getIcon()
        if (icon != null) {
            attributionViewSmall.setVisibility(View.VISIBLE)
            attributionViewLarge.setVisibility(View.INVISIBLE)
            iconView.setImageDrawable(icon.getDrawable())
        } else {
            attributionViewSmall.setVisibility(View.INVISIBLE)
            attributionViewLarge.setVisibility(View.VISIBLE)
        }
        adView.setIconView(iconView)

        val headlineView: TextView = adView.findViewById(R.id.tv_list_tile_native_ad_headline)
        headlineView.setText(nativeAd.getHeadline())
        adView.setHeadlineView(headlineView)

        val bodyView: TextView = adView.findViewById(R.id.tv_list_tile_native_ad_body)
        bodyView.setText(nativeAd.getBody())
        bodyView.setVisibility(if (nativeAd.getBody() != null) View.VISIBLE else View.INVISIBLE)
        adView.setBodyView(bodyView)

        return adView
    }


}
