Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CFCEDEC08
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfYL-0004Ed-GM; Wed, 04 Mar 2026 01:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfY2-0004D3-MQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfXz-0003Dq-P3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246H77t067747
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:17:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=u0Fc5umq6WceNnLCwNli3zJ0ydLQmjhO/wjOG2BnQPY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605038; v=1;
 b=bYAvoam+Ch+rHrZihl68CpjodfxPAbP8V2TUgspsd+xKQvX8R2dB0OkkgJU4Y6GS
 Mnv2SF6KTzJrOGIb9myc80Vz0F7PI95BiVIpF66KHmj/YqBdvtAj1E3Co7H099FN
 1RDxzWjUxOXWZKNRwsN3XiiBekpuw6GGI9oDbt5dSLsjUM6sBcV/VgtiVTOady6G
 41uG+wez6xzsl1pS0IuGcAOYXjHZ7w0CASOb00DIoMcF3/+VGGuAmaY/WccFfQBh
 30/noOHMBhPpxs2n2s2WMjqwRqsBJY+TFuluQToPFQl2JT0el7lkWM21rBFrelxk
 VZOtDtubPyEQ1vw220Husg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:16:57 +0900
Subject: [PATCH v8 4/6] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-coreaudio-v8-4-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 736227eb2b7a..23c3d1f80ac5 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -357,8 +357,11 @@ static OSStatus out_device_ioproc(
 
 static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
+    AudioDeviceID device_id;
+    AudioDeviceIOProcID ioprocid;
     AudioValueRange value_range;
     OSStatus status;
+    UInt32 device_frame_size;
 
     AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = audio_format_bits(core->hw.info.af),
@@ -371,20 +374,20 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice_out(&core->device_id);
+    status = coreaudio_get_voice_out(&device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not get default output device");
         return status;
     }
-    if (core->device_id == kAudioDeviceUnknown) {
+    if (device_id == kAudioDeviceUnknown) {
         error_report("coreaudio: Could not initialize playback: "
                      "Unknown audio device");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_out_framesizerange(core->device_id, &value_range);
+    status = coreaudio_get_out_framesizerange(device_id, &value_range);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -395,33 +398,31 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
     }
 
     if (value_range.mMinimum > core->frame_size_setting) {
-        core->device_frame_size = value_range.mMinimum;
+        device_frame_size = value_range.mMinimum;
         warn_report("coreaudio: Upsizing buffer frames to %f",
                     value_range.mMinimum);
     } else if (value_range.mMaximum < core->frame_size_setting) {
-        core->device_frame_size = value_range.mMaximum;
+        device_frame_size = value_range.mMaximum;
         warn_report("coreaudio: Downsizing buffer frames to %f",
                     value_range.mMaximum);
     } else {
-        core->device_frame_size = core->frame_size_setting;
+        device_frame_size = core->frame_size_setting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_set_out_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not set device buffer frame size %" PRIu32,
-                                  (uint32_t)core->device_frame_size);
+                                  (uint32_t)device_frame_size);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_get_out_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -430,10 +431,9 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
                                   "Could not get device buffer frame size");
         return status;
     }
-    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_out_streamformat(core->device_id,
+    status = coreaudio_set_out_streamformat(device_id,
                                             &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
@@ -442,7 +442,6 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         coreaudio_playback_logerr(status,
                                   "Could not set samplerate %lf",
                                   stream_basic_description.mSampleRate);
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -456,20 +455,24 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
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
         coreaudio_playback_logerr(status, "Could not set IOProc");
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
 
@@ -553,7 +556,9 @@ static OSStatus handle_voice_out_change(
         fini_out_device(core);
     }
 
-    if (!init_out_device(core)) {
+    init_out_device(core);
+
+    if (core->device_id) {
         update_out_device_playback_state(core);
     }
 
@@ -650,7 +655,7 @@ static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
 
     k->max_voices_out = 1;
     k->max_voices_in = 0;
-    k->voice_size_out = sizeof(coreaudioVoiceOut);
+    k->voice_size_out = sizeof(CoreaudioVoiceOut);
     k->voice_size_in = 0;
 
     k->init_out = coreaudio_init_out;

-- 
2.53.0


