Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA6FED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6O-0002y6-RS; Tue, 17 Mar 2026 13:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6E-0002eA-0A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6B-0005f2-Dd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZELC7n7zbnFWjRmMkg6vBGd/m+uJfldpdetbA43ORNk=;
 b=io/si4leYCCzGlQoR0b/W7oDNXjNrwQ1L1cRPj42xDymW1aQO4N2PZ+48YdzdWgVWUqH5H
 qusPRAY0IBkdgi2qHvD7ZZ1kaJGw+BtPn2mElLbLB3pNMw+RF8u8D5wCAn9cvBr+sqxzSw
 iWoUFdai2fbHsaHGLdxD57vW1BTnqts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-b-z7PoDGPiqWZ_QOYLmxsQ-1; Tue,
 17 Mar 2026 13:20:50 -0400
X-MC-Unique: b-z7PoDGPiqWZ_QOYLmxsQ-1
X-Mimecast-MFC-AGG-ID: b-z7PoDGPiqWZ_QOYLmxsQ_1773768049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E369018005BE; Tue, 17 Mar 2026 17:20:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 552AC30001A1; Tue, 17 Mar 2026 17:20:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 13/16] coreaudio: Improve naming
Date: Tue, 17 Mar 2026 21:19:13 +0400
Message-ID: <20260317171916.438575-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

coreaudio had names that are not conforming to QEMU codding style.
coreaudioVoiceOut also had some members that are prefixed with redundant
words like "output" or "audio".
Global names included "out" to tell they are specific to output devices,
but this rule was not completely enforced.
The frame size had three different names "frameSize", "bufferFrameSize",
and "frameCount".

Replace identifiers to fix these problems.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 188 +++++++++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 93 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index bc9ab7477b6..736227eb2b7 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -43,34 +43,34 @@
 typedef struct coreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t buf_mutex;
-    AudioDeviceID outputDeviceID;
-    int frameSizeSetting;
-    uint32_t bufferCount;
-    UInt32 audioDevicePropertyBufferFrameSize;
+    AudioDeviceID device_id;
+    int frame_size_setting;
+    uint32_t buffer_count;
+    UInt32 device_frame_size;
     AudioDeviceIOProcID ioprocid;
     bool enabled;
-} coreaudioVoiceOut;
+} CoreaudioVoiceOut;
 
-static const AudioObjectPropertyAddress voice_addr = {
+static const AudioObjectPropertyAddress voice_out_addr = {
     kAudioHardwarePropertyDefaultOutputDevice,
     kAudioObjectPropertyScopeGlobal,
     kAudioObjectPropertyElementMain
 };
 
-static OSStatus coreaudio_get_voice(AudioDeviceID *id)
+static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
 {
     UInt32 size = sizeof(*id);
 
     return AudioObjectGetPropertyData(kAudioObjectSystemObject,
-                                      &voice_addr,
+                                      &voice_out_addr,
                                       0,
                                       NULL,
                                       &size,
                                       id);
 }
 
-static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
-                                             AudioValueRange *framerange)
+static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
+                                                 AudioValueRange *framerange)
 {
     UInt32 size = sizeof(*framerange);
     AudioObjectPropertyAddress addr = {
@@ -87,7 +87,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
                                       framerange);
 }
 
-static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
+static OSStatus coreaudio_get_out_framesize(AudioDeviceID id, UInt32 *framesize)
 {
     UInt32 size = sizeof(*framesize);
     AudioObjectPropertyAddress addr = {
@@ -104,7 +104,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
                                       framesize);
 }
 
-static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
+static OSStatus coreaudio_set_out_framesize(AudioDeviceID id, UInt32 *framesize)
 {
     UInt32 size = sizeof(*framesize);
     AudioObjectPropertyAddress addr = {
@@ -121,8 +121,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
                                       framesize);
 }
 
-static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
-                                           AudioStreamBasicDescription *d)
+static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
+                                               AudioStreamBasicDescription *d)
 {
     UInt32 size = sizeof(*d);
     AudioObjectPropertyAddress addr = {
@@ -139,7 +139,7 @@ static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
                                       d);
 }
 
-static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
+static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32 *result)
 {
     UInt32 size = sizeof(*result);
     AudioObjectPropertyAddress addr = {
@@ -243,7 +243,8 @@ static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(OSStatus status,
 #define coreaudio_playback_logerr(status, ...) \
     coreaudio_logerr2(status, "playback", __VA_ARGS__)
 
-static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
+                                        const char *fn_name)
 {
     int err;
 
@@ -256,7 +257,8 @@ static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut *core,
+                                          const char *fn_name)
 {
     int err;
 
@@ -269,20 +271,20 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
-    static ret_type glue(coreaudio_, name)args_decl             \
-    {                                                           \
-        coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;      \
-        ret_type ret;                                           \
-                                                                \
-        if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
-            return 0;                                           \
-        }                                                       \
-                                                                \
-        ret = glue(audio_generic_, name)args;                   \
-                                                                \
-        coreaudio_buf_unlock(core, "coreaudio_" #name);             \
-        return ret;                                             \
+#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args)       \
+    static ret_type glue(coreaudio_, name)args_decl                   \
+    {                                                                 \
+        CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;            \
+        ret_type ret;                                                 \
+                                                                      \
+        if (coreaudio_voice_out_buf_lock(core, "coreaudio_" #name)) { \
+            return 0;                                                 \
+        }                                                             \
+                                                                      \
+        ret = glue(audio_generic_, name)args;                         \
+                                                                      \
+        coreaudio_voice_out_buf_unlock(core, "coreaudio_" #name);     \
+        return ret;                                                   \
     }
 COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
@@ -298,7 +300,7 @@ static ret_type glue(coreaudio_, name)args_decl             \
  * callback to feed audiooutput buffer. called without BQL.
  * allowed to lock "buf_mutex", but disallowed to have any other locks.
  */
-static OSStatus audioDeviceIOProc(
+static OSStatus out_device_ioproc(
     AudioDeviceID inDevice,
     const AudioTimeStamp *inNow,
     const AudioBufferList *inInputData,
@@ -307,33 +309,33 @@ static OSStatus audioDeviceIOProc(
     const AudioTimeStamp *inOutputTime,
     void *hwptr)
 {
-    UInt32 frameCount, pending_frames;
+    UInt32 frame_size, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = hwptr;
+    CoreaudioVoiceOut *core = hwptr;
     size_t len;
 
-    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
+    if (coreaudio_voice_out_buf_lock(core, "out_device_ioproc")) {
         inInputTime = 0;
         return 0;
     }
 
-    if (inDevice != core->outputDeviceID) {
-        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
+    if (inDevice != core->device_id) {
+        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(old device)");
         return 0;
     }
 
-    frameCount = core->audioDevicePropertyBufferFrameSize;
+    frame_size = core->device_frame_size;
     pending_frames = hw->pending_emul / hw->info.bytes_per_frame;
 
     /* if there are not enough samples, set signal and return */
-    if (pending_frames < frameCount) {
+    if (pending_frames < frame_size) {
         inInputTime = 0;
-        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
+        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(empty)");
         return 0;
     }
 
-    len = frameCount * hw->info.bytes_per_frame;
+    len = frame_size * hw->info.bytes_per_frame;
     while (len) {
         size_t write_len, start;
 
@@ -349,16 +351,16 @@ static OSStatus audioDeviceIOProc(
         out += write_len;
     }
 
-    coreaudio_buf_unlock(core, "audioDeviceIOProc");
+    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");
     return 0;
 }
 
-static OSStatus init_out_device(coreaudioVoiceOut *core)
+static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
+    AudioValueRange value_range;
     OSStatus status;
-    AudioValueRange frameRange;
 
-    AudioStreamBasicDescription streamBasicDescription = {
+    AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = audio_format_bits(core->hw.info.af),
         .mBytesPerFrame = core->hw.info.bytes_per_frame,
         .mBytesPerPacket = core->hw.info.bytes_per_frame,
@@ -369,21 +371,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice(&core->outputDeviceID);
+    status = coreaudio_get_voice_out(&core->device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not get default output device");
         return status;
     }
-    if (core->outputDeviceID == kAudioDeviceUnknown) {
+    if (core->device_id == kAudioDeviceUnknown) {
         error_report("coreaudio: Could not initialize playback: "
                      "Unknown audio device");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_framesizerange(core->outputDeviceID,
-                                          &frameRange);
+    status = coreaudio_get_out_framesizerange(core->device_id, &value_range);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -393,34 +394,34 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return status;
     }
 
-    if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
+    if (value_range.mMinimum > core->frame_size_setting) {
+        core->device_frame_size = value_range.mMinimum;
         warn_report("coreaudio: Upsizing buffer frames to %f",
-                    frameRange.mMinimum);
-    } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
+                    value_range.mMinimum);
+    } else if (value_range.mMaximum < core->frame_size_setting) {
+        core->device_frame_size = value_range.mMaximum;
         warn_report("coreaudio: Downsizing buffer frames to %f",
-                    frameRange.mMaximum);
+                    value_range.mMaximum);
     } else {
-        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
+        core->device_frame_size = core->frame_size_setting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_set_out_framesize(core->device_id,
+                                         &core->device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not set device buffer frame size %" PRIu32,
-                                  (uint32_t)core->audioDevicePropertyBufferFrameSize);
+                                  (uint32_t)core->device_frame_size);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_get_out_framesize(core->device_id,
+                                         &core->device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -429,19 +430,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
                                   "Could not get device buffer frame size");
         return status;
     }
-    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
+    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_streamformat(core->outputDeviceID,
-                                        &streamBasicDescription);
+    status = coreaudio_set_out_streamformat(core->device_id,
+                                            &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not set samplerate %lf",
-                                  streamBasicDescription.mSampleRate);
-        core->outputDeviceID = kAudioDeviceUnknown;
+                                  stream_basic_description.mSampleRate);
+        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -456,8 +457,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
      * with the callers of AudioObjectGetPropertyData.
      */
     core->ioprocid = NULL;
-    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
-                                       audioDeviceIOProc,
+    status = AudioDeviceCreateIOProcID(core->device_id,
+                                       out_device_ioproc,
                                        &core->hw,
                                        &core->ioprocid);
     if (status == kAudioHardwareBadDeviceError) {
@@ -465,20 +466,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
     if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
         coreaudio_playback_logerr(status, "Could not set IOProc");
-        core->outputDeviceID = kAudioDeviceUnknown;
+        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
     return 0;
 }
 
-static void fini_out_device(coreaudioVoiceOut *core)
+static void fini_out_device(CoreaudioVoiceOut *core)
 {
     OSStatus status;
     UInt32 isrunning;
 
     /* stop playback */
-    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
+    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
     if (status != kAudioHardwareBadObjectError) {
         if (status != kAudioHardwareNoError) {
             coreaudio_logerr(status,
@@ -486,7 +487,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
         }
 
         if (isrunning) {
-            status = AudioDeviceStop(core->outputDeviceID, core->ioprocid);
+            status = AudioDeviceStop(core->device_id, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr(status, "Could not stop playback");
             }
@@ -494,20 +495,20 @@ static void fini_out_device(coreaudioVoiceOut *core)
     }
 
     /* remove callback */
-    status = AudioDeviceDestroyIOProcID(core->outputDeviceID,
+    status = AudioDeviceDestroyIOProcID(core->device_id,
                                         core->ioprocid);
     if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
         coreaudio_logerr(status, "Could not remove IOProc");
     }
-    core->outputDeviceID = kAudioDeviceUnknown;
+    core->device_id = kAudioDeviceUnknown;
 }
 
-static void update_device_playback_state(coreaudioVoiceOut *core)
+static void update_out_device_playback_state(CoreaudioVoiceOut *core)
 {
     OSStatus status;
     UInt32 isrunning;
 
-    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
+    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
     if (status != kAudioHardwareNoError) {
         if (status != kAudioHardwareBadObjectError) {
             coreaudio_logerr(status,
@@ -520,7 +521,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
     if (core->enabled) {
         /* start playback */
         if (!isrunning) {
-            status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
+            status = AudioDeviceStart(core->device_id, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr(status, "Could not resume playback");
             }
@@ -528,7 +529,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
     } else {
         /* stop playback */
         if (isrunning) {
-            status = AudioDeviceStop(core->outputDeviceID,
+            status = AudioDeviceStop(core->device_id,
                                      core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr(status, "Could not pause playback");
@@ -538,22 +539,22 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
 }
 
 /* called without BQL. */
-static OSStatus handle_voice_change(
+static OSStatus handle_voice_out_change(
     AudioObjectID in_object_id,
     UInt32 in_number_addresses,
     const AudioObjectPropertyAddress *in_addresses,
     void *in_client_data)
 {
-    coreaudioVoiceOut *core = in_client_data;
+    CoreaudioVoiceOut *core = in_client_data;
 
     bql_lock();
 
-    if (core->outputDeviceID) {
+    if (core->device_id) {
         fini_out_device(core);
     }
 
     if (!init_out_device(core)) {
-        update_device_playback_state(core);
+        update_out_device_playback_state(core);
     }
 
     bql_unlock();
@@ -563,7 +564,7 @@ static OSStatus handle_voice_change(
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     OSStatus status;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
     int err;
     Audiodev *dev = hw->s->dev;
     AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
@@ -581,13 +582,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
     as->fmt = AUDIO_FORMAT_F32;
     audio_pcm_init_info(&hw->info, as);
 
-    core->frameSizeSetting = audio_buffer_frames(
+    core->frame_size_setting = audio_buffer_frames(
         qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
 
-    core->bufferCount = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
+    core->buffer_count = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
 
     status = AudioObjectAddPropertyListener(kAudioObjectSystemObject,
-                                            &voice_addr, handle_voice_change,
+                                            &voice_out_addr,
+                                            handle_voice_out_change,
                                             core);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
@@ -597,8 +599,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     if (init_out_device(core)) {
         status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
-                                                   &voice_addr,
-                                                   handle_voice_change,
+                                                   &voice_out_addr,
+                                                   handle_voice_out_change,
                                                    core);
         if (status != kAudioHardwareNoError) {
             coreaudio_playback_logerr(status,
@@ -615,11 +617,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 {
     OSStatus status;
     int err;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
 
     status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
-                                               &voice_addr,
-                                               handle_voice_change,
+                                               &voice_out_addr,
+                                               handle_voice_out_change,
                                                core);
     if (status != kAudioHardwareNoError) {
         coreaudio_logerr(status, "Could not remove voice property change listener");
@@ -636,10 +638,10 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 
 static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
 
     core->enabled = enable;
-    update_device_playback_state(core);
+    update_out_device_playback_state(core);
 }
 
 static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


