Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCABFD88D2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06wt-0004xb-BJ; Tue, 10 Mar 2026 19:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31K-waQQKCks4xv4t11tyr.p1z3rz7-qr8ry010t07.14t@flex--rkir.bounces.google.com>)
 id 1w06wq-0004wm-OA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:12 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31K-waQQKCks4xv4t11tyr.p1z3rz7-qr8ry010t07.14t@flex--rkir.bounces.google.com>)
 id 1w06wp-0002Kb-0K
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:12 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2aad5fec175so493351005ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773187028; x=1773791828; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+tvHrOSmRSOnOXDvNjCkR0rSrHEk4lUHcoMU37rZ2kM=;
 b=tvr45PW3cJcgl/tb5rN5EKiqNdO3V47DsXHLslBe9jP2PQ+0Zfzwq2R+QwKkIy5D7X
 MnoMWjHwlGDTFt94iylGFQJQ7SM/OHDtKkxJO0m3O+fBUCrJ4/qtl4lmB4Yv504cDw/V
 wwTMOO9AAKto+72O2LyuwR9eTWg8KKFBQmWZh90qC6FZR2WDpnMR39YyrSgqLJ/UfstD
 /mbBr8WaSQkV0mAXCm5/ootMcJdmzuuyAJXJ6Mp6jFsJr0uoK1WbQr4pzR2y+IqgtGDe
 ETMCAF4Et+Gd6IK92H+s19XO0KNaPXIKd3VNIFrtp7PJJf24FQe4oCydO8pZdmscfMBi
 JetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773187028; x=1773791828;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+tvHrOSmRSOnOXDvNjCkR0rSrHEk4lUHcoMU37rZ2kM=;
 b=s6IK9GlM2OXbIPb2wwJz667kP9gbs3KCRtv/a7waFZk10i/C/Pqmo53IV+rYkX2n54
 MbHTNCy/VGcqROF0Shiy35OKpBqpG+eNQfk2QFH3ysyUQeaIwRJIvGOvGlgpxEXE4U2t
 1sYWYuJZ57/OSWUh/v1jbeVUmVTDPcu7q4xpWjwvkeLvCwX+mfmjOXznBTxM3IJUuT6h
 RKtWlfHYdSKiupGpKHDMnECHBs0GhPdnGWBrSr0K4+orZ0/jzN/laYNgxOKWyhzy3ROs
 aSK9kjD8Np0UpSu8pXza4Iw77QiU58ySW+0cLaqsz0hY+HPIY9zpqwIxbcyksrk/ilv0
 WDUw==
X-Gm-Message-State: AOJu0YwLJkSuL+GyrmaUDdEm2cOsIY7IX/LvVNIZfKLT1Nl3dPyKXXlK
 Rpoq64SsXLjH+vL6SrXpZ5EdQtJ1b7wtuinlJvGipkqOpmWVjVsV5wN+rz+nVBeJ/yc34tNk3g=
 =
X-Received: from plbmg4.prod.google.com ([2002:a17:903:3484:b0:2ae:4702:a100])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b0b:b0:2ae:4948:f866
 with SMTP id d9443c01a7336-2aeae7c4d4emr5794765ad.22.1773187028234; Tue, 10
 Mar 2026 16:57:08 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:56:32 +0000
In-Reply-To: <20260310235632.3987668-1-rkir@google.com>
Mime-Version: 1.0
References: <20260310235632.3987668-1-rkir@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310235632.3987668-4-rkir@google.com>
Subject: [PATCH 3/3] virtio-snd: introduce VirtIOPcmParams
From: Roman Kiryanov <rkir@google.com>
To: philmd@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=31K-waQQKCks4xv4t11tyr.p1z3rz7-qr8ry010t07.14t@flex--rkir.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Introduce the `VirtIOPcmParams` struct to represent
the payload of `virtio_snd_pcm_set_params` without
the VirtIO transport-specific header fields.

By decoupling the internal PCM state from the
transport layout, `VirtIOPcmParams` simplifies the
snapshot and migration handling code and slightly
reduces the allocation footprint per stream.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/audio/virtio-snd.c         | 12 ++++++------
 include/hw/audio/virtio-snd.h | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6d820b56a6..8899eb7d5e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -139,8 +139,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
  * @s: VirtIOSound device
  * @stream_id: stream id
  */
-static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
-                                                            uint32_t stream_id)
+static VirtIOPcmParams *virtio_snd_pcm_get_params(VirtIOSound *s,
+                                                  uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL
         : &s->pcm.pcm_params[stream_id];
@@ -258,7 +258,7 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                                    uint32_t stream_id,
                                    virtio_snd_pcm_set_params *params)
 {
-    virtio_snd_pcm_set_params *st_params;
+    VirtIOPcmParams *st_params;
 
     if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
@@ -384,7 +384,7 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
  * params.
  */
 static void virtio_snd_get_qemu_audsettings(audsettings *as,
-                                            virtio_snd_pcm_set_params *params)
+                                            VirtIOPcmParams *params)
 {
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
@@ -421,7 +421,7 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
     audsettings as;
-    virtio_snd_pcm_set_params *params;
+    VirtIOPcmParams *params;
     VirtIOSoundPCMStream *stream;
 
     if (s->pcm.streams == NULL ||
@@ -1063,7 +1063,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm.pcm_params =
-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
+        g_new0(VirtIOPcmParams, vsnd->snd_conf.streams);
 
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index a767f68301..e9fa9c620d 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -71,6 +71,8 @@ typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
 
 typedef struct VirtIOSound VirtIOSound;
 
+typedef struct VirtIOPcmParams VirtIOPcmParams;
+
 typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
 
 typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
@@ -121,6 +123,15 @@ struct VirtIOSoundPCMBuffer {
     uint8_t data[];
 };
 
+struct VirtIOPcmParams {
+    uint32_t buffer_bytes;
+    uint32_t period_bytes;
+    uint32_t features;
+    uint8_t channels;
+    uint8_t format;
+    uint8_t rate;
+};
+
 struct VirtIOSoundPCM {
     /*
      * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
@@ -129,7 +140,7 @@ struct VirtIOSoundPCM {
      * means that some times we get parameters without having an allocated
      * stream yet.
      */
-    virtio_snd_pcm_set_params *pcm_params;
+    VirtIOPcmParams *pcm_params;
     VirtIOSoundPCMStream **streams;
 };
 
-- 
2.53.0.473.g4a7958ca14-goog


