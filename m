Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39012EDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfYP-0004FI-Jo; Wed, 04 Mar 2026 01:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfY2-0004Cz-8Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfXz-0003Di-FL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:29 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246H77r067747
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:17:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1c39cPmv2n24yxC+0JhoxYKLp5eYLtjZSWAVp+nTdDM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605037; v=1;
 b=R3hlQlCqhT2pQrpBlF7uYOhc0mSyLqWCuYCI/sDdi4eIxr3eg05WJBZ74jBVoz2N
 ZodULKEi6l3HllrnJ8PZITnE3aqQPIz7OXOyrRKjeReI7fDVMmcC178AxAsU4Y0Y
 VzfkdRBqM1S57V6Fr7gSNcbcVt/KO11QqHz42qp+XXUd5hO5D0NRMFFp4hdFbQt4
 lw1QoWLeKwAyojjUWV5cWR2gsXhqtNXCWYte8S4Wbwt5UsUDeacaK7HSiU5Aa66E
 XPnKKXio/prsZsnEg5qrQmzX2C4ek/Ls+Ymib+bOKnKuXy3hNp2N69k6VAtHMVyO
 IZKZB40QZhHDPUT7hD0uXQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:16:55 +0900
Subject: [PATCH v8 2/6] coreaudio: Remove extra whitespaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-coreaudio-v8-2-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
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

Remove extra whitespaces around parentheses.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cbda4f143698..bc9ab7477b68 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -272,7 +272,7 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
 #define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
     static ret_type glue(coreaudio_, name)args_decl             \
     {                                                           \
-        coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;     \
+        coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;      \
         ret_type ret;                                           \
                                                                 \
         if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
@@ -313,13 +313,13 @@ static OSStatus audioDeviceIOProc(
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
 
@@ -329,7 +329,7 @@ static OSStatus audioDeviceIOProc(
     /* if there are not enough samples, set signal and return */
     if (pending_frames < frameCount) {
         inInputTime = 0;
-        coreaudio_buf_unlock (core, "audioDeviceIOProc(empty)");
+        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
         return 0;
     }
 
@@ -349,7 +349,7 @@ static OSStatus audioDeviceIOProc(
         out += write_len;
     }
 
-    coreaudio_buf_unlock (core, "audioDeviceIOProc");
+    coreaudio_buf_unlock(core, "audioDeviceIOProc");
     return 0;
 }
 
@@ -563,7 +563,7 @@ static OSStatus handle_voice_change(
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     OSStatus status;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
     int err;
     Audiodev *dev = hw->s->dev;
     AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
@@ -579,7 +579,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
     obt_as = *as;
     as = &obt_as;
     as->fmt = AUDIO_FORMAT_F32;
-    audio_pcm_init_info (&hw->info, as);
+    audio_pcm_init_info(&hw->info, as);
 
     core->frameSizeSetting = audio_buffer_frames(
         qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
@@ -615,7 +615,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 {
     OSStatus status;
     int err;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
 
     status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
                                                &voice_addr,
@@ -636,7 +636,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 
 static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
 
     core->enabled = enable;
     update_device_playback_state(core);

-- 
2.53.0


