Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B08F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcwm-0008Fu-4a; Mon, 09 Mar 2026 11:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwQ-0007wZ-B8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwO-0000PJ-NT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439aa2f8ebaso5672921f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071682; x=1773676482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R4mjnc6tXY+cKbc3ib7GxWhkvz4lXXEfF9utxwY+JMc=;
 b=szCc/nNyqCG/yAP6TVF998kQi+RLqcq94LtRz9VgkDFDpD/T2TZzEMpT7CJEXzIojm
 6JIddnC5HMaZBTuSX8jMbpQeqS+Y/M4yJH5cyigmJS1uegYju4FvgpjCi9CHPtErKMHw
 IrxN4ZMZlT0NV0a3+n9UMbG4b2hwDIqy5lNf6vuPDeXM/pRRLblAfneYu336leJTL7oV
 Nx6lyGSRaER0Ms40T8uMIHsUqvwSyvh6RXZnAzup79Qiuxdwm3RCYw23h1uKOVxoVd9H
 lygW8q4xZkTXsxj5FAB0bj+zRKOSqWA2SXPX33Dx4yIq9Tvu0NjokD5d2fwQaUK8r6uy
 XgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071682; x=1773676482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R4mjnc6tXY+cKbc3ib7GxWhkvz4lXXEfF9utxwY+JMc=;
 b=cLnHBEBeO5tTMdF3+YHIdQSFqd+WkCcgs/3s93uyUpDrVcy6cOc/cXhaNG6t5MFxS9
 EQWxo9LFL3hB346VnK2CWFkkszRGSA/6kBSCOacqw1b8haVmsnqDubOKG597Gaql4+MM
 Bcuxic65Gq3eKCEWIVhkJmrK7SbHACfHF5VEt+/PdVRkcfPmnyMQwl19tlBf3vYGOC+w
 m7d73F1wbT2YJHG8svmk5Akqk38HpGK+J14pcXAidTY5eUIFblWmpPN1FS7Wah1iUitk
 G9XzD56heedpA0aEvl7QgMkjV0E5JAew3FVBBV+2MMHZeoWRpyxvqOhLPVK10jbBsMxw
 9y7g==
X-Gm-Message-State: AOJu0YxnBH/9f25zq2S0mnjsAs6KAxT43VKF1FMYPDufwEqxqnq/jjS4
 tYuEvfsqtwRpVqsMDN/hZXcNc9fCWA6ENJA9ulTxc/iEsYpzEQE2Een0nO1xneOQJtKQBq2hltR
 O1cQn6og=
X-Gm-Gg: ATEYQzw6Mc6zzXqNdjlmxrI6TTfSx8SNaTHMEfnVOjWXR8S8YujmxlQ7gkWP3ygVjks
 96wSzMKiyza3cv+zHUyKXduIvbTXOlxbNotROZbPQQbu41sYXjECGx29lqdIhPlfEgQ5kNmK0CZ
 qfzWWCJG+WVBonEnAXCYcCRSV7sDGfMMY6Tiv58GdJtspQUGxnyZ3+/LWUiH6o16u9lSuCVCvda
 TnvJt00XoHjgL1BSL8Jm+5m2xpqtBgjI1b8JIMkyyYreRAs+7dt09nYpANxEzhTr4ZsFD/uPKFd
 nCtrklkaTC/WD+fnq53ngn6mMWawwNCWkGs/u1GiKHUdOEU5IlpC23ePzJ9Ba/cxoa8x9icNRnO
 u6ltyp9ODSi6ETDxFSSUt2mRWsH54tXj6Ff7jbf1EgCyQcdh55kde+urHWQR/t0U87J6w5GiQ0O
 bG9nEkRScbQiV++/DIBC4LvSM4jgbCKeRcFFHrB9cVhx5OzdBTJXDcPzlah1OmaTXMmTkWeKsjK
 WmA/P+Xl3I=
X-Received: by 2002:a5d:64e7:0:b0:439:af81:1b21 with SMTP id
 ffacd0b85a97d-439da118cbamr19063337f8f.0.1773071682485; 
 Mon, 09 Mar 2026 08:54:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm28802948f8f.25.2026.03.09.08.54.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/49] coreaudio: Remove extra whitespaces
Date: Mon,  9 Mar 2026 16:51:51 +0100
Message-ID: <20260309155219.62400-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove extra whitespaces around parentheses.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260304-coreaudio-v8-2-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/coreaudio.m | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cbda4f14369..bc9ab7477b6 100644
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


