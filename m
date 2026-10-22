Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UwM02Btt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzce-0006NV-Tm; Thu, 22 Oct 2026 16:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJzcO-0006M5-Ee
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:42:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJzcK-0000bd-Hv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:42:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso950735f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792701747; x=1793306547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Tp7VwhFvHAsi8dSi+irjPRdwFI/zuGh/S5ZsAhoA2k=;
 b=UwM02Btt8q0w+jP0azmMPxGHr0cT9GpEoz/MaxuG2P30YICuPdRyc/qfSunLB3/1fF
 7pa+phmOQhyP+Kib0Ai7WBChzhh/yAfkwr7NWr11f5++E0Ge8RTJdbw4jnxdfTRE00+c
 xN+M53pir2f5f3udxFZKrYG4wdHZTYARSVJXNH5PvVSq1LjFQ4EgdYT7cSai9FwUYW9Q
 MTW+QG5+QRKTOM8MzIs2wHfHSponZmhGLr7fizM1KjYp7vmkEc6mn2LjIHKrBfw6FXLK
 sG1jIzvUs3P1jEx1CCFZ367a2Atdw+szU6xwM/qqnA8d/NWgklKhYVP/W7IM9F06SjNX
 TQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701747; x=1793306547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Tp7VwhFvHAsi8dSi+irjPRdwFI/zuGh/S5ZsAhoA2k=;
 b=sMrp5th9PTFC8v/Dc0QlNr2sp6VFqlkoE84t8I3q8P484UIGLoGSu9iluxK6g14hxG
 zbeC7Iv2k8eunOkGYYRmQ9AqkwFMfg+tKes4eIGmXLIXULKEorZJLafka8BnO6Vn+Quv
 MxL7Gtg8tdhlZuIscr85QqO+TdoL0Qs+stDFiX/CEJ4w1wvuWlWt994MXh6S1Rb2sBZJ
 AujRvrhwH7/QMO7Epjqpq7QhMuYodcNKsCXpXZsIGeRcKYGG5SscHlmVM8H9ZbNl7+W4
 aAbtSzgjP7YNfUXL9x/PpOQ3adxXxHH18dGmkDBSJRJMo8uSB0GlGLCUwV3WNDqFNliG
 B2tg==
X-Gm-Message-State: AFq9FYLIkQi0emBc8Tr7PW2ldN+97MKTSuTVCASHEEYSRdTjaXj2Lt1I
 k9cPokfrCt1rZYUtDDDQ/s8/9V5KW3PrCYHvTa9IYwgsOPbMxm1LSUGM8tDaJGhFiUzW++/vIYM
 aZxR+w9E=
X-Gm-Gg: AYBFou39OFDha+p8dZoV4wfnbz0ku8wSEPqqDyqLvvAzU9mYhOiRS9OxgiWa7rQG5zb
 k13YjJjLUhB/0VDgkwL5Mo16g+jOj4jho9qzHmURJg0FADNDkrq40kH4+Y2cSaS8OYw/nOPWfG0
 8w3Cq6LtNVMOAmC6UlGvcfCknYgVhrYF+Pa4OLd4gz2o301bVGbzjOgGgRCRl48VeQCFR4uDgCL
 Xsaou1kasxpSWSJ/si7M/w0O+5i7W/JfD8LpfmKCoZz5wQNjC9Z1NB1vGTJZ2gYakVYcocI2nFu
 PBm0yD8Gt2TNAXTgM8/Z+0Spy+lvHxBFgMGt8H72kseTPj0XGYjrqNPS0/dBy2ZOo1QT9SnlPNu
 PraHgQJwng6tMiv1ybrHUqLgwcTRAGRn/V7WrAjGVOfO4DQ4LqstB0SVy1gbBjkJYPmPF6Axn31
 DOA/VPYTmF0PuotZU+snNdHiiIxYxXV9BKeG6PB6AExXBry/zEV18JMaBBKjYjPve76m7rtiKoW
 KB2kZA74aIUaMUcHYLfpe7wcAzAFRpj5hHRUxzOSlvHAosyW9Bv1OWTk45u+jpe2T8008gQXvSR
 B9N3hCa4jHWDeqAPTlc1I5KYZp2KtaZg8tvuf4n6Js0qQpSOjCT7HIi9Fb68
X-Received: by 2002:a05:600c:3b0a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4a211c869d9mr3433155e9.16.1792701746768; 
 Thu, 22 Oct 2026 13:42:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053821sm326700f8f.41.2026.10.22.13.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:42:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
Date: Thu, 22 Oct 2026 21:42:23 +0100
Message-ID: <20261022204223.854640-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
I noticed this because Coverity complains about possible overflow in
various places that e.g.  multiply
  aplic->num_harts * APLIC_IDC_SIZE
That can't overflow the 32x32 multiply because of the limit on
num_harts. Moving the error checks won't make Coverity any
better able to figure out the maximum range on num_harts etc,
though, so I have marked CID 1487105, 1487113, 1487185, 1487208
as false positives.

NB that I have assumed that the existing code is correct in
asserting "must be < APLIC_MAX_SOURCE" before adding 1, which is
why the "assert(num_sources < APLIC_MAX_SOURCE)" becomes a check
on num_irqs > APLIC_MAX_SOURCE and looks oddly different
from the num_harts check.

Caveat: tested with 'make check' and 'make check-functional' only.
---
 hw/intc/riscv_aplic.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 03a0852b8b8..b29a22a455a 100644
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
2.43.0


