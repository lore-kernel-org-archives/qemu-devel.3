Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9DFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5r-0004uu-Jn; Wed, 25 Feb 2026 18:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5p-0004tf-QM
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5n-0002a5-UP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so3155145e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061294; x=1772666094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bv1YTmDeCuzjnJPBd8zZSE5aw4rUhX2lPhGkqOCY6/I=;
 b=vyT85OnZCVpVNDbS/OK+cp2Djwql89gKvreb6Pmy2NENUgSHsd7uAdUwxt4kKKg0oU
 PpFRkXDVNCPmpBROCGdmfyxZdce6iW2nyngApxw+gKjDkkpZRM9UErcvfUTmT0T8+EU2
 uUjr6YeWWFXWMxzGz1QpRiZsJEpM3DimYdInW41wLSzvd+Y0vmMx1Ku5gvIQIN/IFPg8
 lkrJ3npGwQek2Qa56yuXtd3a+ErEhisgJ+KIgMin9ZmJ0+69e2nVzpyy4c2k+78USdkR
 C/t5V6TsjwvCbN14DfZR/MT2PHT0+grV6Qdoarb01aaWchij6ePdkrFVP2JwGw7yt8tZ
 k1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061294; x=1772666094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bv1YTmDeCuzjnJPBd8zZSE5aw4rUhX2lPhGkqOCY6/I=;
 b=gGER9X6MszucLUbgq1kYUK/Fs8dj2qeEO/gnlMtGQj8NLLfT90k38GOwkD6ohgizO1
 iuPr0kpWgo8YCYnVSfSXfL4UhzolDzg+y6JGnImH8Sm9DMF50C8j0TwqUmOi1ApaaUIC
 uQaL1fEcIh0hSOXJ968+1+BhCDgss2trFpzuIe1FewPBSU7+RsU9elPL6wpyMRfuHzVq
 eTacAJhsk621onPfRYn8fFUB3H1oxBEGYRRKBMyaREdr4Dkc6tppN0P2QL9uBaS8LMTa
 EmEqOKQvfwAX3XV5Zcy6eJv2DZT+k6rjo4AdgxwP3FG2/z1Ma29FS0Qrn1hH5u8zVVDW
 qqeA==
X-Gm-Message-State: AOJu0Yyz1qPNKaWSQQEeRRvAbuwRzqjAc7Cg1/nOoy5OBC4eXdJhOqnX
 56FMD2DRdiE31mHzBGDHswL3oavJWiInAn7bmt+1UtvgsGpIWEh1TrTqmsJVrlTQhm+nqsgkZ6A
 sWABL27g=
X-Gm-Gg: ATEYQzxfny3moaN0IqRvK9APzjeWagA8ruW4QNcQFqRoXPngBB1zyfZz2fqRtY2FXIJ
 vcJkDX1hz8UHuNI165JilSrJbmvZFoCbnrU5xurjBIhRrVwFuegNhBqmSoiEagTkBXO3zuOAE0B
 nUeZo5sSw4BnCObeNVzW9CVeyDXT0G1Sk/pNTCbSQAXyjqFjjk82iI1oGkUPyp8CWYfDsLwOHqM
 HksbpCm0n4JaThVUEL94iqm67eRHD6clQuRbVF6OIvwZ/qnDLxLHO1e243bqsl9iRNKzZMbbK7Z
 ry8fyQLcy1jVUusHPbBbxANJg+YzR2+6W8Hmgyer3LO1gSQcgOLW77GQw0YHHlTXWZSU8gwDHNc
 6ISPoejjwLu0lFJVr3CqJ+0BDBIznAP/64s08kp8WzFt263sYxkJpvEjoWEHClOpgWAq3g3pIea
 FMdLFLUU8aK5mJxLFlcfpQqZLexpDyDKxKVSF4vTWB6xQ9bJFbw3kR7KCsYZlN7uw+YtZ4a+nHI
 1JfGnJZnyc=
X-Received: by 2002:a05:600c:3e0e:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c3db2184mr1485875e9.1.1772061294042; 
 Wed, 25 Feb 2026 15:14:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfba9a5esm54135155e9.4.2026.02.25.15.14.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/70] hw/riscv: Set IOMMU PAS via property
Date: Thu, 26 Feb 2026 00:13:06 +0100
Message-ID: <20260225231411.96482-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Anton Johansson <anjo@rev.ng>

Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
with a property RISCVIOMMUState::pas_bits that gets written to the
capabilities field upon device realization.  This write needs to happen
at realize-time to ensure the property has been set.

For the virt machine and sysbus device, pas_bits is set by
virt_machine_init() to either 34 or 56 bits, retaining previous behaviour.
However, for the PCI device we do not have access to the CPU state, and
instead use the maximum riscv64 value of 56 bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260218-phys_addr-v6-6-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu.h     | 1 +
 hw/riscv/riscv-iommu-pci.c | 3 +++
 hw/riscv/riscv-iommu.c     | 8 ++++----
 hw/riscv/virt.c            | 7 +++++++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2dabd86941b..2a9f6fccd52 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -34,6 +34,7 @@ struct RISCVIOMMUState {
     /*< public >*/
     uint32_t version;     /* Reported interface version number */
     uint32_t pid_bits;    /* process identifier width */
+    uint32_t pas_bits;    /* physical address bits */
     uint32_t bus;         /* PCI bus mapping for non-root endpoints */
 
     uint64_t cap;         /* IOMMU supported capabilities */
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 5f7d3592047..14dd5f3857e 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -158,6 +158,9 @@ static void riscv_iommu_pci_init(Object *obj)
 
     iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
     riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
+
+    /* Report maximum physical address size of riscv64 */
+    iommu->pas_bits = 56;
 }
 
 static const Property riscv_iommu_pci_properties[] = {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b46b337375a..98345b1280b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2453,10 +2453,6 @@ static void riscv_iommu_instance_init(Object *obj)
     /* Enable translation debug interface */
     s->cap = RISCV_IOMMU_CAP_DBG;
 
-    /* Report QEMU target physical address space limits */
-    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
-                       TARGET_PHYS_ADDR_SPACE_BITS);
-
     /* TODO: method to report supported PID bits */
     s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
     s->cap |= RISCV_IOMMU_CAP_PD8;
@@ -2487,6 +2483,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
+    /* Report QEMU target physical address space limits. */
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
+
     s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
@@ -2645,6 +2644,7 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
 static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
+    DEFINE_PROP_UINT32("pas-bits", RISCVIOMMUState, pas_bits, 0),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
     DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
         LIMIT_CACHE_IOT),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 07e66b39364..bbce2fb6671 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1739,6 +1739,13 @@ static void virt_machine_init(MachineState *machine)
         object_property_set_link(OBJECT(iommu_sys), "irqchip",
                                  OBJECT(mmio_irqchip),
                                  &error_fatal);
+        /*
+         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
+         * and for riscv32 use 34 bits (22 bit PPN).
+         */
+        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
+                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
+                                 &error_fatal);
 
         sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }
-- 
2.52.0


