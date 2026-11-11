Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312C606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rBDlLldy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6wD-0000yS-RI; Wed, 11 Nov 2026 06:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6wB-0000xj-Ap
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w9-0000rx-Ld
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:23 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so22819735e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398180; x=1795002980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sx5Cs3hdzYTPiKfeYGNx4gIWIpraMBIeZuW56xTuH3g=;
 b=rBDlLldyeBMWSvwdxTr0VHRHyIo5umdzJsumczDim1aF3oapjeMK9aKxxv+gaQypXD
 KiBGhYMYsWISluiwn26AJSr6PZsh3bgU7UNCyaWB0Y/f/TMvVDA7S/kfbY8GkLn7dvIt
 BIbuC4evnr+K6rws/rES2Pt/YJIefFi4vofoBaCi/rxve6iX0mO2dQopcPiBEzn93XSq
 xt78dpvMpqhdvQ4UDfPDx9vxrpBCIylw/h2/HL2dArg2xryem/ZWY8AVOqxwF4Wkoc1B
 UpPOpk/k6/YAvYfbMr6X+QsCmWNeKeWTCiy7H5dnUJhLsphwsLuxNjhortSD5KlxeaEM
 Bl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398180; x=1795002980;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sx5Cs3hdzYTPiKfeYGNx4gIWIpraMBIeZuW56xTuH3g=;
 b=wJqv48GOOdD/TVeuGyIaPbhNurpuwxvm2sXE4dZMbSDONvyQMBOM0uycMIGVWwIlwa
 7HfjSRwyv/Igh38wO19axVCeNH2BB3s0tnZJ97iHd1hUwZujTTzP6X67u5W7WTTUzyLB
 6N0rLhJcOFYIGBVf4N2l2X1at3xoGhoPWQ3AloAXxFyFC7P0tg4MSqkww0GD6MX4lda9
 pqYNeYM/sKsk+8FE4B6BcfZqVY2qPflrwsRvhPLo8awznNG6+Nmj11qcBwQiGWtPaN2G
 NlMm56nW/nDXyUeYWtcbDUoIj8ya1pnVbSUm5r4Rg1108FCkP90x990BOplrtwtj9Bfy
 +DUg==
X-Gm-Message-State: APuU4Z/uBMsIpQVrpoB0gpu1mqJ2qxUfETB4eOXtnlz0bDJcw0Ji3fng
 +/f9FhY/zJ28Rf2G8ixn7gyTGJeA2bPmXo3FZt6qiH5Y99Mgxjs3vaGO3G2z9QqbFLxIHPGPcFa
 j9eVr
X-Gm-Gg: AYBFou0rzJM+BGdzjn81AwIRuTFrI+4ScSdAlaOa/R21DBjm5VkYdshVnn3ICKShcox
 r+GcR1MWli8BUwm6+wfd9jj7LR21s4yYLkdSd9ST2Q1fDJfK/r1mWSMop0eTWOqJZRfNT/VF7HR
 Vz4m07/Ro/+m8kkD122h1mlUWj9RvUDMZkgWXkNh7nwxGQHlhITFsPHuc20Uv6Jn0mFBkrnSyXv
 GS3pkt/D0YiPZ/Qx4SvCJjggZr+H6V8RC/JxG+OZUVxJsw2kA29FElj1Fx2QMoyG3punlu/17Tt
 P9eYP1sxf+jyBkTrmEm9BVaBj9HbXaaCB/N/++0a5QotV4/xEcCS1C4ZmEKFUW730DiRzXNtRad
 sNqjqZWSvP2B9T6ef3i6BCsVcUP+EbrrZyEWHNg0F+RelBKRXNU2CnolnkAFf0J1rMltSbNRVHN
 syQqdKHTlI0a1eJVpMYdKAeHAQpALYdcycuUFffEplWkmaEtEwpwf27m5eToJJOVT8nIE4l0g1N
 xU9d5Pr0hGfh1Nfl+ZyTpuZjKvx27b6DoS3pKaAi6j2T9EuBDiBpkeeavPbsQN2tCMbBl+sAKYf
 rfD+B5IE+NLpnBOC8CwGXFDf4HGBD5Vms5Nk5LtDOPDo/pdDQu4EpfS3ND+/7mhZrW8kIZoS60B
 W/VKlQtMDkebGLqkRL+oPuePFpXQAh5uPow45ShinHbcJ6t9j1iltyZaEmtJznG3hALBt34bTef
 wrOa9fQD/tvrAOKJ43dtR/1DdtXnVIcJqVbps8Gi1VJ+51ozxrl0ipV6dRKA==
X-Received: by 2002:a05:600c:620e:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4ba091aacf9mr39342095e9.0.1794398179941; 
 Wed, 11 Nov 2026 03:56:19 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:19 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 5/6] virtio-snd: cap maximum buffer_bytes to half a GiB
Date: Wed, 11 Nov 2026 13:55:57 +0200
Message-ID: <20261111115559.18557-6-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A faulty/malicious guest can try to exhaust host memory. Cap the buffer
size to 500 MiB.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3587
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a7d749f24f..a6036d5b75 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "system/runstate.h"
@@ -24,6 +25,8 @@
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
 
+#define MAX_BUFFER_MIB 500
+
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -368,6 +371,14 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                      & ~(stream->info.features));
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
+    if (le32_to_cpu(params->buffer_bytes) > MAX_BUFFER_MIB * MiB) {
+        error_report("%s: given buffer_bytes value %"PRIu32" "
+                     "is too big: over %d MiB",
+                     VIRTIO_DEVICE(s)->name,
+                     le32_to_cpu(params->buffer_bytes),
+                     MAX_BUFFER_MIB);
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     st_params = virtio_snd_pcm_get_params(s, stream_id);
 
@@ -1037,6 +1048,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         stream = &vsnd->streams[stream_id];
+        size = MIN(stream->params.buffer_bytes, size);
+
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
-- 
γαῖα πυρί μιχθήτω


