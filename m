Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD207CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmz-0005d6-9l; Mon, 12 Jan 2026 17:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmp-0004mt-9c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmn-0003XC-Rn
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so5948301f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258400; x=1768863200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tJ/bFayLqqI0u1jQiX20vfmUfDSzPimkbdxxULJWrXg=;
 b=nFe2/ZPZUYr/ODa3xF50130INGJUNk3L1aVOEFedVUJ52ZyijHepb2u5cToB4r+aMm
 HRGcmlTnPv+TNd8LPNVOigu+Nd0EWSpqTdsDMwNc4ihog6zof2ola3EWtTA1tg5XBlUn
 UNghjx9fkJvU4SM529/xDXbBHIQe42m8JrLywWoglIqkjhXG2jkZ9KYYXbm+87xBlJo1
 inVEpL5RDumACNX5yKvUFA0OC8ua2OiE2Dz9jmdad/1NxxY1bTt8Bb5Xar4ESJXgGOWV
 TuBXGxZA5Ip7bRGy+RS22b2eTzLZQFn3OlTgY+kEfNg1RGLRKiVDu3YRi8dOWBPkf2Nf
 784g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258400; x=1768863200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tJ/bFayLqqI0u1jQiX20vfmUfDSzPimkbdxxULJWrXg=;
 b=YxpSkiFo4S/ptnQCHaCL78XX6A/hhL5QMKfMUEUL7QY99/CVPHZe/geux+n5dYirgV
 raQApYAsuaqekXl+rqimy7R97S2PGy2Hn3gjl6Yku8QQzzJU4NZSkZTM0X/FwQi0QOQ0
 kcquQeSb8pxIPQ7kLEKolKq8MhikCGS3SWsvCO1Kfjce6yuWGqVsjhmGbPdK8+rv++uD
 ClaMIdXDfTG0ZwueM+mOekoegTIhOWJgxYyU3uGCddNzdzmN+WsNVZ6e1w0jO9RW9Eg9
 qU/3oQTySm4S83tiT2N/GStC1dOCwUW8/4kj7ImR3l2FvEHBJGOWUUCcSm98pSPiWyzm
 yX2A==
X-Gm-Message-State: AOJu0YyQA8vsGnNYeHe7Y7ssfVH/Jr5mff6yWKcnwT7QIe8k6wFRilPj
 mlUc5RHFdFXEpEwvgNBdfWYXQMoM7yDiqjklj5GB/fasp2JIemL18USZPktAba8P+9cR6Af/Bbc
 ixaAGm2Q=
X-Gm-Gg: AY/fxX6n+SEiu0mOXeI+jzCLH/sqVBHfYav7dcZoCQbjEDQ4HAk4bt75p2m2iE1jxq/
 pumCnT0MPDK71vbxfCwmOJJadu0vxeQLMT8o0nXBEJIKinDA8ocAQMn/L/F0EnSNlyeTdrE4Ecw
 lO//1EttZoh79j9XNhgJf5vISJdEj8Tzid/Fexl/q9G1i3syd7wibwBS9STKSepCKm+xDt7wLMB
 pGdz+B7w7yKzAVOdkMt+zTRNgWRRiBhf4VQ7/LfvUwIQb7hpGo1BPEXjSqxHlgh3BYKfydabjGO
 LJ7DlUSKH+tjE29AUc6WFGDgIGFUfpOwGYxgwkla+a8Sla18JRhSw520SztkTyaxOAJN2EvANIb
 8AYU8mhqJCxcxo4AXnc+pN4i+KZmr1qCSTasgmiXkOEZ4rADeVpzbv5jktmMH7WpDkrED7a58Kr
 kRwpnOlHBthu96sbjfaDrFMV0qJmmE+I2YSpPluZGnKZ4SKlJ1Fmyv4w/EXQigXOM813XZFUA=
X-Google-Smtp-Source: AGHT+IEZ8IVKH5RAkfltEztI+6VGem5KnOgM/cswJHnhDFWcuenBkbkN+eOSqhHDEDnHW7+zVtSmJQ==
X-Received: by 2002:a05:6000:1ac7:b0:432:88bd:df3a with SMTP id
 ffacd0b85a97d-432c37d2f98mr25178104f8f.46.1768258400094; 
 Mon, 12 Jan 2026 14:53:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm40590731f8f.5.2026.01.12.14.53.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/61] hw/intc: Mark OpenRISC-specific peripheral as big-endian
Date: Mon, 12 Jan 2026 23:48:33 +0100
Message-ID: <20260112224857.42068-39-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The Open Multi-Processor Interrupt Controller (ompic) is only
used by the OpenRISC target, which is only built as big-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_BIG_ENDIAN (besides, the DEVICE_LITTLE_ENDIAN case isn't
tested). Simplify directly using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224161804.90064-2-philmd@linaro.org>
---
 hw/intc/ompic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 58736cd8a0c..cf930afbba4 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -96,7 +96,7 @@ static void ompic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
 static const MemoryRegionOps ompic_ops = {
     .read = ompic_read,
     .write = ompic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .max_access_size = 8,
     },
-- 
2.52.0


