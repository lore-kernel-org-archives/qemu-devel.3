Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB1606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CAErN2xm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQM-0008Vc-4h; Sat, 14 Nov 2026 19:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQK-0008Uh-So
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:48 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQJ-00017a-7B
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:48 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a315ed211so2184853eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703725; x=1795308525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O1ZiKeTgLj5e7Scr4eBfCPFcfIz4yTLG1STw6Gr4XIk=;
 b=CAErN2xm2AWQd1YOD1pN8ktxqUZrDeM+sglsceNfcTqcKopxBvTBQGiWd3XXS5JWD1
 g9PUv3NP6HEHkFzhNkvH5l93w+i2F1lwI2K+Y+w8kLe/Rd11EA9H41q7dNDqU4cl0Xkb
 NE6u6tfiJkhiSk7oi6ht2Okcmx0VQZnPNYeoRIU5zkDwIWvaZpXT8EhwAfazRmVtSy4p
 i8HLEBz0GbVGwj8c2WBEaVJN5/yewaFa7POeN8/joIlTPHMbY49Oz2fMkzDerH+MFuO0
 29J2DEzt2WUHrqzgZHnMv+my4LYuZU8Ao7FJAKsyE/RYXkILZUl48A5ZOILFp0mbI8Td
 Ud8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703725; x=1795308525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O1ZiKeTgLj5e7Scr4eBfCPFcfIz4yTLG1STw6Gr4XIk=;
 b=C+ovs09rzSL5AefOMWnGga7aWAHtuBNTSuJ7MmQnxILWNuNha3qk379iFwOWaRbS7H
 bET8WHwAct0vVIeb7Miw95GWBHiLeEDenNUVrojs4Nf0y+kaLs627rxH9yv42FSVsad5
 GOFXhQFjr0T+WcQBOBw59L2masobSKASy8vxh9zYBg13GvBjcIhvAZAFcJmjYYiPYU2g
 /LCYsxkAF2mBMBgBPLItJIBoa7hzvVnmW7nerqsqHQ+/Nxev+j0DTNqB76wPQ28A4Kwx
 jBXy4EtTeSvI1iIOP7pxMK2CAXxR4Wm6J12PYxcEifrPjYePbCWx/0HmuWbjGAXJeiCB
 42Iw==
X-Gm-Message-State: APuU4Z8Q9F9EXsPDNJgD3f7nSsvcPqRPUdX12qBwSJoVZ3waF3vA1kAA
 YOiUmpd3NYSfVvaygxfj4wPMXHGFRcRBNC15aFIBaUn4P2+3kj5O726KycjIUQ==
X-Gm-Gg: AYBFou3wHNi7R2tvcdxLJLQn+BmEy3EUeDVuX1P05aTwl+TJjASYj8r63jfo5Pbco3O
 W+DdojT+6cW0aRnlaIZknoiv0LPLuZ6AjVfPhkzQxIaQiBL4t9rVqJiBcx9e1h9H5SpBaMWHBt8
 Dy7Pm7JyfTtb4z9lyds1QtSF3hRKD5Ut75jhSJECIWLghZ3cU9Y4uBzebrAH+qH9gPv9551I2aM
 NoUvciq1Bh4BxwtKVYvwhXNFhIWuNa61Ncz/D04AZy9gx/4fAUbjagrl8jKZKvB3FMuLWsUz9Ml
 KMAqXVRAroQfBTUte8HS8lr5dtrQ0XNVNkBVklNWjSa4S5pnT2qzCrR81moL5+2ALh6sHLC7YPW
 4edGzkHt4F/SGgcERu5cGDhOjB5u6RONdF2nOZWTMQeFmwov0rTvNZjtilv6caHVeMbgdKoV9lE
 1OQcZrtMcDeNTCnJa8URz9WuGtC1VIAvj6c3QFb//V/K77l/b9ZrXMiGB1kx0dDVPtByIe0yKrM
 Z1tA+K5mBx7rCm/iGUpIfRAZ8FgWqrqOkSmRGuxIf1kY8GZbXO25/BF5WximENawRJE87JAixbH
 M/HuPSm8ahJc8sUux5rpPlKZN/Tujs5rPrK4JOtFwYJFgPE=
X-Received: by 2002:a05:7300:148c:b0:361:a195:c46e with SMTP id
 5a478bee46e88-377de5f761amr13657300eec.1.1794703725060; 
 Sat, 14 Nov 2026 16:48:45 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:44 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 6/8] hw/intc/riscv_aplic: Check config value bounds in realize
Date: Sun, 15 Nov 2026 10:48:17 +1000
Message-ID: <20261115004819.2586336-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The riscv aplic interrupt controller has various configurable
properties for things like num-harts and num-irqs, which have
architectural upper limits.

Currently these are checked in riscv_aplic_create(), by assert().
QOM devices should check this kind of thing in their realize method,
and fail realize for out of range values (which in this case will
cause riscv_aplic_create() to make QEMU exit with an error, since it
uses &error_fatal).  This isn't a problem currently as no SoC creates
and configures the TYPE_RISCV_APLIC device itself, but it avoids one
for the future.

Move the checks to the realize method. This requires slight
adjustments in some cases because:
 * property num-irqs is set to num_sources + 1
 * property iprio-mask is set to (1U << iprio_bits) - 1

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261022204223.854640-1-peter.maydell@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 03a0852b8b88..b29a22a455a1 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -954,6 +954,32 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
+    if (aplic->num_harts >= APLIC_MAX_IDC) {
+        error_setg(errp, "num-harts must be less than %d", (int)APLIC_MAX_IDC);
+        return;
+    }
+    if ((APLIC_IDC_BASE + (aplic->num_harts * APLIC_IDC_SIZE)) >
+        aplic->aperture_size) {
+        error_setg(errp, "aperture-size 0x%x too small for num-harts %d",
+                   aplic->aperture_size, aplic->num_harts);
+        return;
+    }
+    if (aplic->num_irqs > APLIC_MAX_SOURCE) {
+        error_setg(errp, "num-irqs must be less than or equal to %d",
+                   APLIC_MAX_SOURCE);
+        return;
+    }
+    if (!is_power_of_2(aplic->iprio_mask + 1)) {
+        error_setg(errp, "iprio-mask must have all lower bits set");
+        return;
+    }
+    if (aplic->iprio_mask < ((1U << APLIC_MIN_IPRIO_BITS) - 1) ||
+        aplic->iprio_mask > ((1U << APLIC_MAX_IPRIO_BITS) - 1)) {
+        error_setg(errp, "iprio-mask must specify between %d and %d bits of "
+                   "priority", APLIC_MIN_IPRIO_BITS, APLIC_MAX_IPRIO_BITS);
+        return;
+    }
+
     if (riscv_use_emulated_aplic(aplic->msimode)) {
         /* Create output IRQ lines for non-MSI mode */
         if (!aplic->msimode) {
@@ -1119,12 +1145,6 @@ DeviceState *riscv_aplic_create(MemoryRegion *container,
     DeviceState *dev = qdev_new(TYPE_RISCV_APLIC);
     uint32_t i;
 
-    assert(num_harts < APLIC_MAX_IDC);
-    assert((APLIC_IDC_BASE + (num_harts * APLIC_IDC_SIZE)) <= size);
-    assert(num_sources < APLIC_MAX_SOURCE);
-    assert(APLIC_MIN_IPRIO_BITS <= iprio_bits);
-    assert(iprio_bits <= APLIC_MAX_IPRIO_BITS);
-
     qdev_prop_set_uint32(dev, "aperture-size", size);
     qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
-- 
2.55.0


