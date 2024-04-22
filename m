Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0559C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytLP-0001Q7-B6; Mon, 22 Apr 2024 09:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytLL-0001PR-Ps
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:04:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytLJ-0000SQ-69
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:04:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so3932962f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713791058; x=1714395858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qL0hwwkI7O8dqqIUz2nL3BM8u7vZrcx6Ul9nhARaGhI=;
 b=Ikv1LYlYdgfRDn/yH45WQadqIeGvYDEQzeco11d08xsds+Bx0OUeKCj2dub1Dz1TIR
 Ug/r2klGFKk+sPkcnWlnWSfyHvZvIB8WE0DgPGfFUd5bQwB5bR9QQuoS5QkXIJ20QQA0
 NBqWRzo2dkOxjHf31SpM8ufFARQiRpVlKcphd87dRzmYGfJ5geY6sqxsKN0a/izLFKaf
 Ph3ZcD8QIkaPiNYV0IbyXyitx2xifUmGSMNfRlNOk3NzwZiBVwCY3j5z5TQDvdj4Iwf4
 JFCTecrYZJieKTzkbZ/pq47lZcywrDaTTf34jKL6qOlL+lyKwqAQAkK6KFR/OEiZSYXe
 yapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713791058; x=1714395858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL0hwwkI7O8dqqIUz2nL3BM8u7vZrcx6Ul9nhARaGhI=;
 b=h4NmajY76TMGCPgsNyiE0qoDJHdwVYFb5DQqKAbYV+bZb4cGvWuXpBEr7+eQebz8NX
 sWIOPdGe+oa625cR+Uvi5hkCOTO8m8YO0evr0wJ5LNKIS+AsA55pGradiWQIlKUtM1tU
 fRUiXqTVe7MmyyOs4EVbPR1gh/umaVpAeHRTFeNZAZzTr+ava/DqBIdpJcroXHMWitOt
 reOZ/J7CQc7R6Be3SdV1Ykd+XorTwmwqeDhwI6iGUOl1301SSSn0TJE6EuzVimV0UDPo
 EeJUFDTERiGnyNS483tLUiTDcWuJMUEBrHoGnRQaBEO5i9VgOo4F8YEsCMJFOtt0SZ8Q
 k/7w==
X-Gm-Message-State: AOJu0YwsY42uVNKH1ypcf7R8wZvoDoYuDSFeis1nmUPlmewEsEkt9H03
 tCGwcAxbgDfPLperGRuAJEVt0e35oGk6K9XHdyKM93xi7XKArzjUqSAKuicTmjWGCis0ZAFvGKB
 Z
X-Google-Smtp-Source: AGHT+IHH1SIIt8G/5g7u4HGItuTEd4T4b2rDuK4XiJ2Waq07dK0d+L9Y1iMOHo8coUhQ4LbmQDTT7g==
X-Received: by 2002:a05:6000:d8b:b0:34a:e884:fd71 with SMTP id
 dv11-20020a0560000d8b00b0034ae884fd71mr2856729wrb.29.1713791058233; 
 Mon, 22 Apr 2024 06:04:18 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 w15-20020a5d544f000000b00349c63eb484sm11968165wrv.23.2024.04.22.06.04.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 06:04:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/audio/virtio-snd: Use device endianness instead of target
 one
Date: Mon, 22 Apr 2024 15:04:16 +0200
Message-ID: <20240422130416.1891-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since VirtIO devices can change endianness at runtime,
we need to use the device endianness, not the target
one.

Cc: qemu-stable@nongnu.org
Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..796e0753d6 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -395,13 +395,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
  * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
  * params.
  */
-static void virtio_snd_get_qemu_audsettings(audsettings *as,
+static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
                                             virtio_snd_pcm_set_params *params)
 {
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
     as->freq = virtio_snd_get_qemu_freq(params->rate);
-    as->endianness = target_words_bigendian() ? 1 : 0;
+    as->endianness = vdev->device_endian ? 1 : 0;
 }
 
 /*
@@ -464,7 +466,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         s->pcm->streams[stream_id] = stream;
     }
 
-    virtio_snd_get_qemu_audsettings(&as, params);
+    virtio_snd_get_qemu_audsettings(s, &as, params);
     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-- 
2.41.0


