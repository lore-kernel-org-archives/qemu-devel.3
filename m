Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D627DD47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtG-0004T0-Se; Fri, 16 Jan 2026 06:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vght6-00045w-P5
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vght4-0007LB-Rl
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:08 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1055524f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562465; x=1769167265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UA5gOsxTA/GrWaYHRcJrMgSSYpRnnrE20/jFtsf2ofc=;
 b=ghxEN/CZQ0biUv2HT5ggFwFgqUrjn6TZ+NsCTDHDlpR7fuEoKY3g8XCNehOvwCHxiF
 IA3uRbep4NmiHQF3BdRUl58zoj1sVVYUIBntSBC/q8ToalF1cc+D/ogDmqOghVzsPcCx
 +s2jnY2hyXfXiV3W+TSPlIA4zfEjY9oNgqtdOYQxrwIz7QgIiFcX21ZcdyMpD3glay9L
 4mbNEXIFNnc+3q+drvF/cDGHd/aH6Q4qBYH82Ic51w2UlrYWflmNOt3MN92R3lzkctFB
 WATUqG6r/dE5gQFzDMtn0ChhcBKhse/gWUWTd39KD15bMppnv70p3SduYD4wfKmXKbL/
 Ittg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562465; x=1769167265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UA5gOsxTA/GrWaYHRcJrMgSSYpRnnrE20/jFtsf2ofc=;
 b=wrPuINw7E5r3I+kFqJtHCErWdS0/FLZ05Neh0vy3ipurw1Iv4HamEiJM6xQhIklmTe
 3mv+CybgTxGT9KLD5MRqQCAd60wR53Ip8KXzcNKJ5mBxi+++4x6H0sRiz15h5JROE9B+
 zTKg81g3/FOQfAkYzWhGdYKbYgZRiGK04orCRALOaGxRBkAaq2SdS9Aaa/Hs/paXQiYR
 IYdq0jFvtkTLO5nM5TaMWIQo1qSxdPFJ5q7V01k4W5+E3nnzWd7F3YtoLxrGP5s6Fln1
 AN8DX+5Jh6W1GJbcUhZPmfVXXvSBOCu3A2U6PVZoPnMgBe+6WRKywWCXxkIFwC1vbNI0
 5qbg==
X-Gm-Message-State: AOJu0YynqahZU9Ea833aTrLQXpIcm1muWn5dxLF8q87LCgSmFPZkuqfM
 3vqU1G9EzY5F3bMCNNwhJjOwe4u0scKQ5ZjS2lUPEGLLcyibSAwG7nwsSS5T4PVMZXa2hDVGbP8
 LGZFnqdY=
X-Gm-Gg: AY/fxX5rA00QNC5pYLBL+Mq2rjzMI+LqymMGpTXH2RSpodlpq1ke8qJs+nrshQC9gdz
 P+Q7N44O036Qcn80m87uzuwuWehRja4WQTmSR07JRIKQ2pg6yadlmhAGxM4E8mGDf2kO/pqHkOJ
 oxqur06nKmzpeD2dgyJM/AWCHqeREO7BhIJKN8j2UdPjvrgtigCvq2+5wFZWiPfgxP3QNIi4Rb1
 CRxyHIwmYW8JKlLDPZRLV2nLOhaXf9paLA+IeMYGRtTYArCk/ubAvWR34hxCtMnnX+BvNsHy4l2
 pIYUpLU3WJkgpq3ASrF7e6Kth0COEKhddJlVb/q8leJL+n4r8CK1JcBgXpmaV9KyqVTmwEijoHv
 8zTvP/Bwj3yVLPXDy+MVjSce/3T9K08dfS08nddiSSIyqUrPrZUU2+GYZLy/gKKX44xBMbzinEB
 mtc834QhFubYruIqj4vPogMaZnHE38roJdFtwitr3T8duvqdGZgjQQJ7Rl46iHwC3086yDbrk=
X-Received: by 2002:a05:6000:288a:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-43569bd341amr2669188f8f.55.1768562464555; 
 Fri, 16 Jan 2026 03:21:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm4780071f8f.10.2026.01.16.03.21.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:21:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/30] target/arm: Only allow disabling NEON when using TCG
Date: Fri, 16 Jan 2026 12:18:03 +0100
Message-ID: <20260116111807.36053-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Only allow disabling NEON when using TCG.

This avoids confusing user experience:

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-20-philmd@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c1087bf5b92..05fa3339b1a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1460,7 +1460,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
-- 
2.52.0


