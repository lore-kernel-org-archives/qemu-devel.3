Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D15D65C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 06:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBTmJ-0001Ka-DP; Thu, 14 Nov 2024 01:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tBTmI-0001KR-5l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 01:56:30 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tBTmG-000709-4D
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 01:56:29 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so181578a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731567385; x=1732172185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=joTCuEkN28Wat4wyLgXlDZjsAVW0LdkDoKc0u2sKf/o=;
 b=GLGFb0XXxFdesgHUEHgO7Rui/brTZr/M2cVS5vCcu2wvdhk2e75w05E0zMvWtpK8GB
 DrTbSkTEGXlefqwlVcZ/IeSLZ9Uo0QMzmWlhW99jjcSz0Mgtplp9LeQXZ4r9l8kZ32Ls
 c/TmUPLjYXF5VL+x05NQa2ptlMllmyjhN9iVKn231YMer9jjc/pWTh2yh6BJOmWvDfKD
 lhXkpXJ3Y2gCXnYWvWNcPkB7EqgX0Itr0d7QnDpnyM2yb4+dXY5fptz5u8HWp0fZ/Vbm
 GiZWSyobkx3/HoGBa1Go+hkXhWlh1tqwadmsPC4aU7aKytDn/onnU1KEnBQL2kr22NgO
 pW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731567385; x=1732172185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joTCuEkN28Wat4wyLgXlDZjsAVW0LdkDoKc0u2sKf/o=;
 b=CCUmB2SZA11VqJHHjd4FKCMzZfe8/Pxq0MrUJkRa0r1kHzkcsQuZxALJPg7dBHegP5
 sM2JP+6W3P+eRezFgHUqlZh6jDNV7bu3AbEatWkT/GuQxWC55qw9IY4gmqmUSZh0al1y
 Aq9hNj7dxQtBMHNTXpSw3jx4RnEtIoL8n1stWzFciDpyoerC9y0hGLhKy7HhzIGR2VuK
 7E1VVLp8IyojVLLSPtCPuT1Kr2v1lBI/9rL76lX/dOHfD160wjGcP3t0N97C7vcFw5+B
 /affEFgsedHsqU+ghCrNKcj9xXnqpK600JhqG+QfrjYr7F3GS5qlC3TWCxBf9MhAgnxK
 kfzA==
X-Gm-Message-State: AOJu0Yyy+bedLoZmWooy+xVin8EOay/UNasW2BzHysxFz9WEpPCAi9nV
 x81axZut4XGW0Rvbd3ZKQtzukWvIpZq0GAIzJtid0Zp+IfvDcGAA7NfNOxO/iRXSzxvUsaWoTk3
 lWDW2aHWMQH6KJV4oboIHIjoTNnp4HLjdxy5JeUr8mDg3GhhGhPkekUixZtd3kIY5BHtFZToFIh
 omjyAvTsyyIU0duSnuoUpOxctGI0uRcPBRM6o/kR/Jtw4E
X-Google-Smtp-Source: AGHT+IHxsYQkSxnHJhC30/V4Ct6WgSOITWNV8vkkJ/ZYF2yCfWEU0rn5EhgkxhwdvVZ2+lsG/NV8WQ==
X-Received: by 2002:a05:6a20:2448:b0:1dc:792f:d27c with SMTP id
 adf61e73a8af0-1dc792fd539mr5263562637.42.1731567385271; 
 Wed, 13 Nov 2024 22:56:25 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f1b17asm485528a91.15.2024.11.13.22.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 22:56:24 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v2] hw/riscv/riscv-iommu.c: Correct the validness check of iova
Date: Thu, 14 Nov 2024 14:56:17 +0800
Message-ID: <20241114065617.25133-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x530.google.com
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

From RISCV IOMMU spec section 2.1.3:
When SXL is 1, the following rules apply:
- If the first-stage is not Bare, then a page fault corresponding to the
original access type occurs if the IOVA has bits beyond bit 31 set to 1.
- If the second-stage is not Bare, then a guest page fault corresponding
to the original access type occurs if the incoming GPA has bits beyond bit
33 set to 1.

From RISCV IOMMU spec section 2.3 step 17:
Use the process specified in Section "Two-Stage Address Translation" of
the RISC-V Privileged specification to determine the GPA accessed by the
transaction.

From RISCV IOMMU spec section 2.3 step 19:
Use the second-stage address translation process specified in Section
"Two-Stage Address Translation" of the RISC-V Privileged specification
to translate the GPA A to determine the SPA accessed by the transaction.

This commit adds the iova check with the following rules:
- For Sv32, Sv32x4, Sv39x4, Sv48x4 and Sv57x4, the iova must be zero
extended.
- For Sv39, Sv48 and Sv57, the iova must be signed extended with most
significant bit.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index bbc95425b3..ff9deefe37 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -392,9 +392,26 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
         /* Address range check before first level lookup */
         if (!sc[pass].step) {
-            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
-            if ((addr & va_mask) != addr) {
-                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
+            const uint64_t va_len = va_skip + va_bits;
+            const uint64_t va_mask = (1ULL << va_len) - 1;
+
+            if (pass == S_STAGE && va_len > 32) {
+                target_ulong mask, masked_msbs;
+
+                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
+                masked_msbs = (addr >> (va_len - 1)) & mask;
+
+                if (masked_msbs != 0 && masked_msbs != mask) {
+                    return (iotlb->perm & IOMMU_WO) ?
+                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
+                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
+                }
+            } else {
+                if ((addr & va_mask) != addr) {
+                    return (iotlb->perm & IOMMU_WO) ?
+                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
+                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
+                }
             }
         }
 
-- 
2.43.2


