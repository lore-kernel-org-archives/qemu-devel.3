Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DDCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDN4-0001YF-2f; Thu, 21 May 2026 20:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN2-0001Xp-LN
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN0-0003IC-PH
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ba856db1c0so49142775ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408245; x=1780013045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWclSkJBFNBbgj7Bf7xZl/684YkVm+PSyCPH4svFOR4=;
 b=r1BsT1GwJmjv53whjfeThZHoDjwsjdsd0DLd18olaB6wQM3jI0wV4+WtYgNPXNpSVw
 jNbJPdOhflTh3oTtl0BtaAthDQ/LnyuxKku6SWjkqD/zvk+BSKXfSuBoTBg0fkD8eKnh
 kuqxSrJcUkwcPLR3FN4bW6JdKZwMfuPvkwBUfRB/jUWu68IbZVegfijJ42/q0tN+DhG3
 vFmDZ6jwqKo20P94eZHK49K8Qlh75p9Gv/KnFL0A1lyzs7PJho/197J0v8CMePjV820A
 OAabdmS00GVSy2C4nCvm2aUtbGzPRLyjZG1Q+dmBuBtZMVJjE2jKTt7H97awuhgM9qRq
 IQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408245; x=1780013045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dWclSkJBFNBbgj7Bf7xZl/684YkVm+PSyCPH4svFOR4=;
 b=TXxwvbjShykcRpS8ish1mke4gb16UeQxyfGNPkIA1gTQS7jve5OEhQ6pxhEYYV2Jsw
 OUYGUkroATlali78vo8oNl+QLVwlxbEq3Z0gZKX2e8TmzJ2nd7GeR/ktkZdR7W1KnFHc
 g9h6BJ3B5Swu1pdGjrBxMShddE1Dg7AmpXGggXu1FyXESpsB+bE3jMN+Wv7wVgb4BS61
 aAE+FjjbGJbApcQd+RU1LVDry/tIiuU2ofm3LtFHLiqI8kvB9oqMnO0ACwX79x8xV8bw
 RxpxTclusdsWXwXJNv959RbTW1FyHebnK4u4lv92ClESc+gwyvRzhSY0P1DQ0yXnqPXI
 mxXA==
X-Gm-Message-State: AOJu0YzqMFS+1tPOeZzoJNmwjyydSlUrXXX0j44XiJMACRLzrY7JP9kv
 IvZM6m+nKherpWyrkfJxozTd94rtFNLKeqUuFL5V3GVqMKhig55e+5f0fGEU/6hb
X-Gm-Gg: Acq92OHUVOTAhz4pKAqsuhWCLtqIeV4ImsFO3/KTxYdXeTxVypO0LAAVMD+IvzvtYtR
 xXfCQdH8alXtrWPu8yP9z6hoYT1As1wO9oIFT2LA1+Maq4svIWkY2NihyrqAu6MeiKXcCGC+29I
 vDb3JN6ZKI0z8+7dMvIJuydYXS50996u3Qn27tx45gQhE+43QF3hLsKCDNMs8vrEoSiG+8Ixc2Q
 /8cJI3lFlzdbcBzlpacx6l7FEWoyf5pFIz4slTsRkbvXIt90RPWYT5eiGxpBB/jLZVtVUssFn6F
 Hw/NLwrqR4/27ctNuJODKEt5/QLIt5MpcnR987xxQTTanU2u43L+/kHV5FpKG0Jlwh2z+UBh496
 pv5iBQCKWlLdcjE6LodoJQwUpIZaGoXwkWBQ7c9gLjYN1mcPJsQkpq9kuD0EGFLjLL0vxCdKNKj
 u8ZOjgalAkqPxhcQa8wbe2ZouwQPBzIDYoea3E89OvxQ==
X-Received: by 2002:a17:903:246:b0:2bd:8395:fed8 with SMTP id
 d9443c01a7336-2beb0722b38mr11003215ad.27.1779408245067; 
 Thu, 21 May 2026 17:04:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/48] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
Date: Fri, 22 May 2026 10:02:45 +1000
Message-ID: <20260522000324.23255-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
model wasn't checking PTE_N and therefore was using the raw (NAPOT-
encoded) PPN directly in the physical address, yielding an address
32 KB above the correct base.

Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
the Svnapot handling already present in target/riscv/cpu_helper.c:

  napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
  napot_mask  = (1 << napot_bits) - 1   /* 0xF */
  phys_base   = PPN_PHYS(ppn & ~napot_mask)
  page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))

The spec only defines napot_bits == 4 (64KB); any other value is
treated as a reserved encoding.

This is a fix, rather than new feature support, because the spec
says "IOMMU implementations must support the Svnapot standard
extension for NAPOT Translation Contiguity."

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Message-ID: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 25a356d1d3..eb09cc9748 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     return true;
 }
 
+/* Returns the NAPOT page mask, or 0 for reserved encodings. */
+static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
+{
+    int napot_bits = ctz64(ppn) + 1;
+    hwaddr napot_mask, page_mask;
+
+    /* The spec only defines 64KB (napot_bits == 4) */
+    if (napot_bits != 4) {
+        return 0;
+    }
+
+    napot_mask = (1ULL << napot_bits) - 1;
+    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
+
+    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
+
+    return page_mask;
+}
+
 /*
  * RISCV IOMMU Address Translation Lookup - Page Table Walk
  *
@@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
-            /* Update address mask based on smallest translation granularity */
-            iotlb->addr_mask &= (1ULL << va_skip) - 1;
+
+            if (pte & PTE_N) {
+                hwaddr mask = riscv_iommu_napot_page_mask(ppn, addr, &base);
+
+                if (!mask) {
+                    break;
+                }
+                iotlb->addr_mask &= mask;
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+                /* Update address mask based on smallest translation granularity */
+                iotlb->addr_mask &= (1ULL << va_skip) - 1;
+            }
+
             /* Continue with S-Stage translation? */
             if (pass && sc[0].step != sc[0].levels) {
                 pass = S_STAGE;
@@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
             return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
         } else {
             /* Leaf PTE, translation completed. */
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            if (pte & PTE_N) {
+                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
+                    return MEMTX_ACCESS_ERROR;
+                }
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            }
             break;
         }
 
-- 
2.53.0


