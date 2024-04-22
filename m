Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E69C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 21:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz13f-0003GF-4z; Mon, 22 Apr 2024 17:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz13c-0003Fr-0U
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:18:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz13a-0007pE-G3
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:18:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41a4f291f80so11970425e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713820712; x=1714425512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YqPCwvQuGJPWfQyJL1E4FlIJNAyThx9FnbqUDh3L0Zs=;
 b=JLIjyjb4bJDwlxcwWzFYQdNrt5zai8OtvAfiohxdcr6GSGBuVmqXpUWjNm/SB1fy4t
 nvXLUS+H0CU+Rb5F5EP9omJtFtV/wsp5CKnMgohrUZF9BNAJgOevCZoSXHUPBfMUKTLZ
 VQ3a6v5mg71akgSHft41dn1f1H3bps6j6dynQxW7XQWDdP52PDzGqI74TbKxJddGrVTQ
 1rw1GPBGibt/qdi36IMUWcNQ8WAQVf1NPPdIFHIqsZdxim9bMkaZscSIE0Zm7o/Kdp4d
 ytMUbGlTuEe/bj2g2NiPw48N7imc2K8zWgFw57EuXCs+FeM7Jlssqqhk7d4rCdeOs83c
 fJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713820712; x=1714425512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqPCwvQuGJPWfQyJL1E4FlIJNAyThx9FnbqUDh3L0Zs=;
 b=tBTtdBLPHMVbDJqTLTB3NWiJRGKpPkU0h4bKBhysyzkRF5r/kTjcb3s8cPA5FOPbSg
 s7T1fvDFvMIe+Qr1ESpnyntm8ujlBoXkxDNP86IUgeHlhD7oFXuIe0GjLZGPm+2YqBpO
 WFqHNcppzBlmYnnSUYQZH0filjxOHcnv9PgbJrPY9WCBOWOMF2XdG1dnh8z78Y+s7TjY
 6mL3yUiCUmUpcHGz4ymkHSJYB/Rr3r8xc1/ozZQ1eoy71w2YpW+ExOSfrv3/4Lg0O62P
 rXsbPe5UvkVlUXG+LqHQ9YoCCTv5rJQYq574TI9vC++UYyMr9XDUO9sqicZazTNqJQB+
 bmBg==
X-Gm-Message-State: AOJu0YwBpd8P0wfoWnWeV6Puq2v9dxcbD2E/xYyjxZH5xNrt9PjcpZgN
 MiSikRQ2mlvHpMcameUYt4RodbjO2Vhr7Lt5pOoVsocsy44Njovb4IAPP65252uUGxUClxlphlz
 e
X-Google-Smtp-Source: AGHT+IGfgTTGUidYvKQOc279RHOW8sKvBDqYNHJWu5gHPOX1+2//QphpyeNxAtF4SbDZ2kj7Eb+UiA==
X-Received: by 2002:a05:600c:4e8b:b0:418:e2e4:a84c with SMTP id
 f11-20020a05600c4e8b00b00418e2e4a84cmr9047314wmq.30.1713820712032; 
 Mon, 22 Apr 2024 14:18:32 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b00417ee886977sm21854328wmq.4.2024.04.22.14.18.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 14:18:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v4] hw/audio/virtio-snd: Always use little endian audio format
Date: Mon, 22 Apr 2024 23:18:30 +0200
Message-ID: <20240422211830.25606-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The VIRTIO Sound Device conforms with the Virtio spec v1.2,
thus only use little endianness.

Remove the suspicious target_words_bigendian() noticed during
code review.

Cc: qemu-stable@nongnu.org
Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Supersedes: <20240422142056.3023-1-philmd@linaro.org>
v4: always LE (MST)
---
 hw/audio/virtio-snd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..ba4fff7302 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -24,7 +24,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
-#include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
@@ -401,7 +400,7 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
     as->freq = virtio_snd_get_qemu_freq(params->rate);
-    as->endianness = target_words_bigendian() ? 1 : 0;
+    as->endianness = 0; /* Conforming to VIRTIO 1.0: always little endian. */
 }
 
 /*
-- 
2.41.0


