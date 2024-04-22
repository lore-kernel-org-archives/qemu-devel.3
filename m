Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4B8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuXW-0002Xp-Tg; Mon, 22 Apr 2024 10:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryuXV-0002X6-PR
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:21:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryuXU-0007Qm-6F
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:21:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41a7aa24c4fso4515435e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713795658; x=1714400458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4YWpEqod8VkCFbiBd1V4s0E6yoxlRHNnLW4c6hmROsc=;
 b=dWMQoMbwzZa4d3nnHKFYsgpu8FK+LhZIW5O7Kue8JYgFqB7PkvtAULewFzfzIN5ytO
 YMaLn+c1A2W6VsDPS8OeggWTutHItLfe5gqSV5ECzMRrGZWcagQtHKc/7iTGR8LJUJcS
 3YwYOk3EuMul84nWd4xy+fExuxbhi8isBvyeTjNPN5Ef6/ohKTP8zfAhRdSUh5K7PMpT
 7lrqX6IXnVs6ySZ51/h6sG9Lik2E+zQhz0Kuavby0wH4S75/BR3qwEr/XVZ7XtRyv88z
 +N/NzK5X697qvFlBmDN4iYKz2AetARU3LcRiVgyNgUQRRd3LTpqJ1m0GG6bhX9asm7xY
 wAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795658; x=1714400458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YWpEqod8VkCFbiBd1V4s0E6yoxlRHNnLW4c6hmROsc=;
 b=lwqfuJzLWZrfDQqBSQQ+ymA81+gIcYMXQcWXNZ+RTC6FIq7nG8ChY6gkVkFTPZqhVn
 obm2xt9QBsvHi/wa4N2S8zJaxg8LVkZlPKCZk27c3V4KD1HJ67ltHrRRuCSRPSrgQzJa
 SkakRzv1TBhfODbALEnld8g8HVpAt8FQcgqCCP65wxJut6wWcX3jbEkMFE7XyD9TZ/5t
 uKSyfIx7hs+fy/2GKApP/2e5hTBPbixiTHSXitlZqi5pPoEADzEq3FE9FWpi6CLEJRSG
 EVtldYIHW/bk1Ur0CQJGA5U+Dn98JU3SwDzYdAwimTG7EsuViCrZndoy1T1YlBgoeKjq
 X85A==
X-Gm-Message-State: AOJu0YyEmDfcWsTLQsgYGNSXUwvRf2iY7OWZSyujCaijtXiy+6QVjGcm
 tE42WXJLhydJJDRZqZxwGhikY0WgWJoi4ul/zrRcAEvNm/rFOn9vVxQSsigBU86YnmTG/nv9vRM
 C
X-Google-Smtp-Source: AGHT+IEKwIODAbpX2blRzGBFDp4Dvsc8SrnJfWXtAGOxfs8pkFptnPro8FzuYnXe5L0WPwIrlxPvEg==
X-Received: by 2002:adf:cb83:0:b0:34a:4b5b:a4a with SMTP id
 q3-20020adfcb83000000b0034a4b5b0a4amr6865799wrh.47.1713795658015; 
 Mon, 22 Apr 2024 07:20:58 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b00349cadc5024sm12161612wrp.61.2024.04.22.07.20.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 07:20:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Date: Mon, 22 Apr 2024 16:20:56 +0200
Message-ID: <20240422142056.3023-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
v2: Use virtio_is_big_endian()
v3: Remove "hw/core/cpu.h
---
 hw/audio/virtio-snd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..939cd78026 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -24,7 +24,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
-#include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
@@ -395,13 +394,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
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
+    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
 }
 
 /*
@@ -464,7 +465,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         s->pcm->streams[stream_id] = stream;
     }
 
-    virtio_snd_get_qemu_audsettings(&as, params);
+    virtio_snd_get_qemu_audsettings(s, &as, params);
     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-- 
2.41.0


