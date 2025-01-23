Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF51C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 07:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tarUI-0007VS-Pd; Thu, 23 Jan 2025 02:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUH-0007UK-Gd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:49 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUE-0006D3-Dq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216281bc30fso12569145ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 23:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737616725; x=1738221525;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pLPszRf5z+P++6TKNc8EVJlN/G55/bMgM7kgbbSSz1c=;
 b=yJAnEoxbBU4U2numWx8cBwRZnMaJCktMxBeXjP2YLi9B9PvkvMWnvmh3VcWDOXUb5j
 ZnzuIKGVkXPENu2GMLP+He6Ps32svG2hZpwVvnCQ2MMmZWe9qxVXsYbiC3KVPth34yMb
 Sdk9OKqMNw5WLV3Oxkpq60Ai/9cBzCtlyIv6OlJnYakWkbFbTgKXefMcE4cNy3PWoicf
 U7jcgtcTC/vQ9pg7XB/zrn6aKmsqOd5W3UBzC0FoH0uvfXxOLTS+bdxVQCi7Om6wtfY0
 mNDzChrU4O71U5e+1+/HqSTv0ylsX9M7RnCKcwqE44ZbTPUxvVrKulvL/Y4kXnL0G7OL
 o8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737616725; x=1738221525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLPszRf5z+P++6TKNc8EVJlN/G55/bMgM7kgbbSSz1c=;
 b=q5o1VPuFXprF/Hk7tHoFzHlQ1v3nXZglqt7QEF7Rdu0fvOAzpcah48iKU/krmfnA55
 u17o8BV1kgLKTXZECjPyUsN9oDxOgSSE1euNME4lq2Z8zEFbQwyAKffesknm5MUu9uzb
 Flnj+kKEFNJ9zkbgg06g8g68EP2dn7GMfWJBbSSI5dqZS6Pper0gCAGW41i5RjnO5TfA
 dMQn38itufNYD0ef4KP9e4l0CS29NFce4TR9vidk8IGjPMvnGHXjFE30ARuGKsHZtHbQ
 1u2tWM/+OyRopt9nOdv32B8KctAwS0J0ecorCI54nzLNqLDAMVkYzHng0g35ZG6Q9xuk
 E0HA==
X-Gm-Message-State: AOJu0Yx6kS/VP8Rr2rWCpoeRD6W2BYah2HkDpeN3Ksl887u2s+BxmsDM
 UNm+qUvNzqEReQO6eSB/c6zQQ/JPa/n51aDdBKq1tZFCQwJxFi1qajFRwoHQUp9hAyFJm0sy+tG
 f+F0=
X-Gm-Gg: ASbGncvV+j7O0xcNF8mUlqj1bZbnKzqyAXuWVBoSeE4KPZofmbOzFjsIzpD3GhTVB/9
 RjOfxiTkMVbOsHR+sFfUaT9nAfho4qvXikJ+b0gPWq+mU5jLUULe45Ly8L2qFEh+JUkk7alaf2i
 RDFJ+ZEBjnBZTOmg0ANiv6rmw1Uoa46NXeTeDvGstTZc7TNqzyyUJOihCqWUtIqsF5PuwetFou3
 uqxfQBoibrcKqQoOLfdqEYaB23MZ7KDg1qQR5h1iyoa3vSFxACUZVHhR80kr6lkICTkaNaO8jbG
 4YCpqUMT
X-Google-Smtp-Source: AGHT+IHG71N0QYJXYNnld0YfPcCsh1t2ARibmJoY9fGOTeQD8i3Tli5lFT7RpMBbpkPI8D3XW7PRwg==
X-Received: by 2002:a17:903:1cc:b0:216:2474:3c9f with SMTP id
 d9443c01a7336-21c357b6a7bmr332836005ad.52.1737616724921; 
 Wed, 22 Jan 2025 23:18:44 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21d92a67da3sm19943405ad.225.2025.01.22.23.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 23:18:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 23 Jan 2025 16:18:30 +0900
Subject: [PATCH v5 2/4] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-coreaudio-v5-2-6873df4215a0@daynix.com>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
In-Reply-To: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

init_out_device may only commit some part of the result and leave the
state inconsistent when it encounters a fatal error or the device gets
unplugged during the operation, which is expressed by
kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
result in the end of the function so that it commits the result iff it
sees no fatal error and the device remains plugged.

With this change, handle_voice_change can rely on core->outputDeviceID
to know whether the output device is initialized after calling
init_out_device.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index d6469b77cbde3d84a40017aed64279ab4fce6b29..a8d71c6cf816f7658037e26608a4c1101ebd071e 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -357,7 +357,10 @@ static OSStatus out_device_ioproc(
 static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
     OSStatus status;
+    AudioDeviceID device_id;
     AudioValueRange framerange;
+    UInt32 device_frame_size;
+    AudioDeviceIOProcID ioprocid;
 
     AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = core->hw.info.bits,
@@ -370,20 +373,19 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice_out(&core->device_id);
+    status = coreaudio_get_voice_out(&device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                    "Could not get default output Device\n");
         return status;
     }
-    if (core->device_id == kAudioDeviceUnknown) {
+    if (device_id == kAudioDeviceUnknown) {
         dolog ("Could not initialize playback - Unknown Audiodevice\n");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_out_framesizerange(core->device_id,
-                                              &framerange);
+    status = coreaudio_get_out_framesizerange(device_id, &framerange);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -394,31 +396,29 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
     }
 
     if (framerange.mMinimum > core->frame_size_setting) {
-        core->device_frame_size = (UInt32) framerange.mMinimum;
+        device_frame_size = (UInt32) framerange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", framerange.mMinimum);
     } else if (framerange.mMaximum < core->frame_size_setting) {
-        core->device_frame_size = (UInt32) framerange.mMaximum;
+        device_frame_size = (UInt32) framerange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", framerange.mMaximum);
     } else {
-        core->device_frame_size = core->frame_size_setting;
+        device_frame_size = core->frame_size_setting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_set_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                     "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->device_frame_size);
+                                    (uint32_t)device_frame_size);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_get_out_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -427,10 +427,9 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
                                     "Could not get device buffer frame size\n");
         return status;
     }
-    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_out_streamformat(core->device_id,
+    status = coreaudio_set_out_streamformat(device_id,
                                             &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
@@ -439,7 +438,6 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         coreaudio_playback_logerr (status,
                                    "Could not set samplerate %lf\n",
                                    stream_basic_description.mSampleRate);
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -453,20 +451,24 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
      * Therefore, the specified callback must be designed to avoid a deadlock
      * with the callers of AudioObjectGetPropertyData.
      */
-    core->ioprocid = NULL;
-    status = AudioDeviceCreateIOProcID(core->device_id,
+    ioprocid = NULL;
+    status = AudioDeviceCreateIOProcID(device_id,
                                        out_device_ioproc,
                                        &core->hw,
-                                       &core->ioprocid);
+                                       &ioprocid);
     if (status == kAudioHardwareBadDeviceError) {
         return 0;
     }
-    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
+    if (status != kAudioHardwareNoError || ioprocid == NULL) {
         coreaudio_playback_logerr (status, "Could not set IOProc\n");
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
+    core->device_id = device_id;
+    core->device_frame_size = device_frame_size;
+    core->hw.samples = core->buffer_count * core->device_frame_size;
+    core->ioprocid = ioprocid;
+
     return 0;
 }
 
@@ -550,7 +552,9 @@ static OSStatus handle_voice_out_change(
         fini_out_device(core);
     }
 
-    if (!init_out_device(core)) {
+    init_out_device(core);
+
+    if (core->device_id) {
         update_out_device_playback_state(core);
     }
 

-- 
2.48.1


