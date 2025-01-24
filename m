Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1234C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzZ-0003Lc-45; Fri, 24 Jan 2025 00:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzU-0003Kn-CW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:24 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzS-0000Ge-9o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:24 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216426b0865so27595795ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695541; x=1738300341;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7r/m+Ynal1Hau8iDW2vBlCw59o8z1y0oQ4nfOltvLo=;
 b=Qjjy0zFi9EtoK2sTQXqU5OqCvYh5Zo1RtpBg6+Cyl8rUgkkzdhbnSEiNDw+gmOUn8Z
 Gbgyh8NJU/k93At5qZ9Wygglk2Tx/+N/7VDb+Cg3PxEYcAoWmwbGjyIF6PPPtT3KIuE0
 agNZ4OOT5eGeb9GrJ1CddUrz+lXrLxjRjYAE7n8u2f4nDVU2Q3r75/h073sTuiFN/0V2
 u5HxqzLiuWMUlmHruYFEiJtqFzat5x26ix/H4kKq75Dv9QeDre885M8nQ+nTrLZm4AEc
 p38kEbu5zcMvF3T0nXXwFH3ZcgYaiWJK2HgqEglLeXma1oLQakRQSrUDHDSrDxy+38Fd
 KETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695541; x=1738300341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7r/m+Ynal1Hau8iDW2vBlCw59o8z1y0oQ4nfOltvLo=;
 b=jCJJBgS+HN8vrpXTNTZkMEdLy4y7/HRelDOsbJ23IVXH73YVsD/tAvhF9j7q24cApv
 TjynGY1DHEPKrnTndIFRshhykMDR8yB7Nbg0VsT340uAC9K4LNfpA8Rghu09pyhPyQYU
 OQgkvpfKMOwOg6ALh6CC3d/OSWUM+K3J8AZALObOHcPuJ9f/T2noPEE8puBRPUDd18eH
 kVCf0R7MKtuUwBBQkByEzs1ji0xiWokGTVpYQQz6iWeQgtbgV9KAs23b1ioBLQVvRDM3
 92lvOdpo7gMpShQOvQv/IgEHHDEKOoCL2OOAXb4qLcPFUCCqq3dJbvhd11DIbPdtNqqm
 B2cA==
X-Gm-Message-State: AOJu0Yx8velGWdVIMxC4A7DQMgqwj/4DggOyMeoeEqLNFoiPMbjEPBkq
 HCEM/QkqfQugr1htZvq3oS7woW3Fs9VpGec/1BN2xrTh9yaIt8Mt3Db2UGJzBa35oy7d5vaIdCd
 pVrM=
X-Gm-Gg: ASbGncsLjWXwtsz6MPzZa75YZ3X2fAxQu0RXJDkgqLzZ3f3c+Yd/t7qMaRq6jrcDGsf
 a/SWW1R7RbXsLRScFDEahr++qNtLwbcgSEC2uEFT60mCP4Q5ZiJLnpJV8qdS0jzMETAld7czQ3H
 Ylu0X+elQm+pIzGdaY3Tuwv3cX7VQWm3PWBbhlXTIPIeEL1EFsO/xTe1xw41k34ejr09aX2RkgR
 /3RVLgkWbF7Lazs0dbdZUAAWSWeF7sND4pHS03iMD/5UYTFah9JZHefRFUB2FAzY15Uzx6WU1KR
 J3jPAWpyvHTOwkoKozU=
X-Google-Smtp-Source: AGHT+IFmD6tR92H7g1qTfwFHwuCyokARPnkLLWIX8jC8F17hnI4A31uXhHcWglYXwrM7HyHgVu++xg==
X-Received: by 2002:a17:903:2286:b0:21b:b3c9:3908 with SMTP id
 d9443c01a7336-21c35577cb7mr468067785ad.34.1737695540639; 
 Thu, 23 Jan 2025 21:12:20 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21da555a428sm5428055ad.84.2025.01.23.21.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 14:12:05 +0900
Subject: [PATCH v7 2/6] coreaudio: Remove extra whitespaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v7-2-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
In-Reply-To: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
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

Remove extra whitespaces around parentheses.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 108 +++++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 0b67347ad7e8c43a77af308a1a3a654dd7084083..04e8ac59f4572c1e5fb7dc4f04f5e21520507ab5 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -149,7 +149,7 @@ static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
                                       result);
 }
 
-static void coreaudio_logstatus (OSStatus status)
+static void coreaudio_logstatus(OSStatus status)
 {
     const char *str = "BUG";
 
@@ -199,14 +199,14 @@ static void coreaudio_logstatus (OSStatus status)
         break;
 
     default:
-        AUD_log (AUDIO_CAP, "Reason: status code %" PRId32 "\n", (int32_t)status);
+        AUD_log(AUDIO_CAP, "Reason: status code %" PRId32 "\n", (int32_t)status);
         return;
     }
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", str);
+    AUD_log(AUDIO_CAP, "Reason: %s\n", str);
 }
 
-static void G_GNUC_PRINTF (2, 3) coreaudio_logerr (
+static void G_GNUC_PRINTF(2, 3) coreaudio_logerr(
     OSStatus status,
     const char *fmt,
     ...
@@ -214,14 +214,14 @@ static void G_GNUC_PRINTF (2, 3) coreaudio_logerr (
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_log (AUDIO_CAP, fmt, ap);
-    va_end (ap);
+    va_start(ap, fmt);
+    AUD_log(AUDIO_CAP, fmt, ap);
+    va_end(ap);
 
-    coreaudio_logstatus (status);
+    coreaudio_logstatus(status);
 }
 
-static void G_GNUC_PRINTF (3, 4) coreaudio_logerr2 (
+static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(
     OSStatus status,
     const char *typ,
     const char *fmt,
@@ -230,39 +230,39 @@ static void G_GNUC_PRINTF (3, 4) coreaudio_logerr2 (
 {
     va_list ap;
 
-    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
+    AUD_log(AUDIO_CAP, "Could not initialize %s\n", typ);
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
+    va_start(ap, fmt);
+    AUD_vlog(AUDIO_CAP, fmt, ap);
+    va_end(ap);
 
-    coreaudio_logstatus (status);
+    coreaudio_logstatus(status);
 }
 
 #define coreaudio_playback_logerr(status, ...) \
     coreaudio_logerr2(status, "playback", __VA_ARGS__)
 
-static int coreaudio_buf_lock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
 {
     int err;
 
-    err = pthread_mutex_lock (&core->buf_mutex);
+    err = pthread_mutex_lock(&core->buf_mutex);
     if (err) {
-        dolog ("Could not lock voice for %s\nReason: %s\n",
-               fn_name, strerror (err));
+        dolog("Could not lock voice for %s\nReason: %s\n",
+              fn_name, strerror(err));
         return -1;
     }
     return 0;
 }
 
-static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
 {
     int err;
 
-    err = pthread_mutex_unlock (&core->buf_mutex);
+    err = pthread_mutex_unlock(&core->buf_mutex);
     if (err) {
-        dolog ("Could not unlock voice for %s\nReason: %s\n",
-               fn_name, strerror (err));
+        dolog("Could not unlock voice for %s\nReason: %s\n",
+               fn_name, strerror(err));
         return -1;
     }
     return 0;
@@ -271,7 +271,7 @@ static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
 #define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
     static ret_type glue(coreaudio_, name)args_decl             \
     {                                                           \
-        coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;     \
+        coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;      \
         ret_type ret;                                           \
                                                                 \
         if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
@@ -312,13 +312,13 @@ static OSStatus audioDeviceIOProc(
     coreaudioVoiceOut *core = hwptr;
     size_t len;
 
-    if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
+    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
         inInputTime = 0;
         return 0;
     }
 
     if (inDevice != core->outputDeviceID) {
-        coreaudio_buf_unlock (core, "audioDeviceIOProc(old device)");
+        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
         return 0;
     }
 
@@ -328,7 +328,7 @@ static OSStatus audioDeviceIOProc(
     /* if there are not enough samples, set signal and return */
     if (pending_frames < frameCount) {
         inInputTime = 0;
-        coreaudio_buf_unlock (core, "audioDeviceIOProc(empty)");
+        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
         return 0;
     }
 
@@ -348,7 +348,7 @@ static OSStatus audioDeviceIOProc(
         out += write_len;
     }
 
-    coreaudio_buf_unlock (core, "audioDeviceIOProc");
+    coreaudio_buf_unlock(core, "audioDeviceIOProc");
     return 0;
 }
 
@@ -370,12 +370,12 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
 
     status = coreaudio_get_voice(&core->outputDeviceID);
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not get default output Device\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get default output Device\n");
         return status;
     }
     if (core->outputDeviceID == kAudioDeviceUnknown) {
-        dolog ("Could not initialize playback - Unknown Audiodevice\n");
+        dolog("Could not initialize playback - Unknown Audiodevice\n");
         return status;
     }
 
@@ -386,17 +386,17 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not get device buffer frame range\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get device buffer frame range\n");
         return status;
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
         core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
-        dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
+        dolog("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
         core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
-        dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
+        dolog("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     } else {
         core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
     }
@@ -408,9 +408,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
+        coreaudio_playback_logerr(status,
+                                  "Could not set device buffer frame size %" PRIu32 "\n",
+                                  (uint32_t)core->audioDevicePropertyBufferFrameSize);
         return status;
     }
 
@@ -421,8 +421,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not get device buffer frame size\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get device buffer frame size\n");
         return status;
     }
     core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
@@ -434,9 +434,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not set samplerate %lf\n",
-                                   streamBasicDescription.mSampleRate);
+        coreaudio_playback_logerr(status,
+                                  "Could not set samplerate %lf\n",
+                                  streamBasicDescription.mSampleRate);
         core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
@@ -460,7 +460,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
-        coreaudio_playback_logerr (status, "Could not set IOProc\n");
+        coreaudio_playback_logerr(status, "Could not set IOProc\n");
         core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
@@ -518,7 +518,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
         if (!isrunning) {
             status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
-                coreaudio_logerr (status, "Could not resume playback\n");
+                coreaudio_logerr(status, "Could not resume playback\n");
             }
         }
     } else {
@@ -560,7 +560,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
     OSStatus status;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
     int err;
     Audiodev *dev = drv_opaque;
     AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
@@ -569,14 +569,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
     /* create mutex */
     err = pthread_mutex_init(&core->buf_mutex, NULL);
     if (err) {
-        dolog("Could not create mutex\nReason: %s\n", strerror (err));
+        dolog("Could not create mutex\nReason: %s\n", strerror(err));
         return -1;
     }
 
     obt_as = *as;
     as = &obt_as;
     as->fmt = AUDIO_FORMAT_F32;
-    audio_pcm_init_info (&hw->info, as);
+    audio_pcm_init_info(&hw->info, as);
 
     core->frameSizeSetting = audio_buffer_frames(
         qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
@@ -587,8 +587,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                                             &voice_addr, handle_voice_change,
                                             core);
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not listen to voice property change\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not listen to voice property change\n");
         return -1;
     }
 
@@ -612,7 +612,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 {
     OSStatus status;
     int err;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
 
     status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
                                                &voice_addr,
@@ -627,13 +627,13 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
     /* destroy mutex */
     err = pthread_mutex_destroy(&core->buf_mutex);
     if (err) {
-        dolog("Could not destroy mutex\nReason: %s\n", strerror (err));
+        dolog("Could not destroy mutex\nReason: %s\n", strerror(err));
     }
 }
 
 static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
 
     core->enabled = enable;
     update_device_playback_state(core);
@@ -644,7 +644,7 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
     return dev;
 }
 
-static void coreaudio_audio_fini (void *opaque)
+static void coreaudio_audio_fini(void *opaque)
 {
 }
 
@@ -670,7 +670,7 @@ static void coreaudio_audio_fini (void *opaque)
     .pcm_ops        = &coreaudio_pcm_ops,
     .max_voices_out = 1,
     .max_voices_in  = 0,
-    .voice_size_out = sizeof (coreaudioVoiceOut),
+    .voice_size_out = sizeof(coreaudioVoiceOut),
     .voice_size_in  = 0
 };
 

-- 
2.48.1


