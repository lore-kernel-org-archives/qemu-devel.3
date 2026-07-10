Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D718AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1P1-0007Gp-VW; Thu, 09 Jul 2026 22:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Oz-0007GY-RF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Ox-0008KN-T5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8454160043aso381512b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652142; x=1784256942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W90HJTxOqEIBzB25r20xhD/LGkwlsggR/lqqd0Qil4s=;
 b=XFpAjQVUbBEfT/ZzAS24DUKDx7tGlez6kdhfintFoLPP+lPUzyZW5tNAj4DshlOR/A
 PXUxZeLKa00Qmz0yM4BMuXmjnJKR1l2iaYLUTkpN1jusCGOblkx2+J5Zgpdsz8hRQ4Xq
 m5BMTId9BKKlkMhEZBWXC46vGWU4jFZ0QhqtqKv5pkZHZxIhJrbyPIvqEbrFWzHlG0X9
 sfgdrg8C+FI87niQJag4TwL8MGX5FlFCUCjRAcYToyqlijBD6VhFlpVJ9Os8t9qqMetd
 qT9QId5aMwIHmHdabUVKCsm3HuVjgKuesHp2NhFTcXI3mphLIgamq1hQF4jKyx6KDys8
 pr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652142; x=1784256942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W90HJTxOqEIBzB25r20xhD/LGkwlsggR/lqqd0Qil4s=;
 b=T6YsI4epBniUKcDtONd7iEfmv7u5ITOnVfNLra83I2wYGMSJyd8QUXTbHQ+WAbzp0L
 uJomv9XG6fdriuHVzkNamptOQr9y7AsIzUptiLx79W3EIu4/Jiggi7jxVf5eSXIkex8K
 pTwHaaxf9xBmj3K8iquaw8d49eBemTtGgwdLdO3ECEbb6IXHxjwHa2argg7mSBjqSnMA
 Fud0QwfuJ5QrSzTqpVWOsg2qF42qRRkl6eM7Rac7Ub+pAWvF5zq3+0a5bnTQ6hhbe4lL
 mM821agHD8IhZo+xWwTZIa6o78dSI8LuNXZCKABnF2r/aRsCrWY/eF0s0OuEm9C75SJC
 mYEQ==
X-Gm-Message-State: AOJu0YzL8xAeTDrke631cBWOg7nDTR/kM+DrgjbuiRAT2oOtIllaBM6c
 nzOtqVUyetILPUVyGMAiEtyK17eUEHPUCg088v7/Io+hAWB697AZ3OkpSro1rA==
X-Gm-Gg: AfdE7clSV4DNUurVFGkruD1h1dIfYHZMrEbuFgi5S+mhTYSceSeXLoKC9aVbK2mSvQO
 u0SMQOspe0GBDb+0SwNBnZOa9AJwCCrgU3MXQCR72KLTKW7o7aScdSWH+MiyFDLJ9SF51XKqGsq
 HFSdlj308NyRCAd0fpFNl//4A9BelWqpEgIf3PZHHGVo6bU7IeLRVhvCmj+rZnCRRRsA9QGi3eT
 UAzA6Aii7rmK94HAcV6PVHTn78Ug/z67fqO9yIjas01WbNCGMU0X/kDbE2ztKVIxZmSSP6DUdq1
 3ChInoZF4ciGnVtvxYChcpL+biddEDPREuriqwJNPrc3NT7nOV59opNgUWYjbQ0njleNv3ySI2U
 mwgTcQJkYreTSLVw4z+/cUTcLeHIMWKoqpzEVk5VEIuFoMJEvyVxapCRt8VbK5AGlhRPJAdr8k3
 Mv2xZNdEz+SJAGJDz5GKHAxx6+rCMTSzY=
X-Received: by 2002:a05:6a00:198f:b0:848:6f63:8d37 with SMTP id
 d2e1a72fcca58-8486f639411mr1817418b3a.61.1783652142074; 
 Thu, 09 Jul 2026 19:55:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/40] hw/riscv/riscv-iommu.c: fix fault type for spa_fetch()
 faults
Date: Fri, 10 Jul 2026 12:54:46 +1000
Message-ID: <20260710025525.1704417-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Under certain circunstances, like the one described in [1] and [2],
a read operation that faults will be logged as a write fault instead,
and vice-versa, if they happen after the translation phase in
riscv_iommu_spa_fetch().

The first problem is that we're overwriting iotlb->perm with PTE flags,
so an IOMMU_RO access flag can be overwritten by whatever flags
the PTE has.  This will cause the wrong fault type to be thrown at
the end of the function in case a fault happens.

To solve the iotlb->perm overwrite we'll bit_and the original
iotlb->perm access flags with the PTE access flags, preserving the
original access type.  So a IOMMU_RO access in a R+W PTE will result in
a IOMMU_RO perm.

Second, the resulting fault is received by riscv_iommu_translate(), which
will then report the fault.  To do that we require a transaction type
(ttype).  We're prioritizing checking "perm & IOMMU_RW" to set a
UADDR_WR ttype, and then checking "perm & IOMMU_RO" to set UADDR_RD
ttype.  The issue with that is IOMMU_RO=1 and IOMMU_RW=3, thus checking
"perm & IOMMU_RW" for a write then "perm & IOMMU_RO" for a read will
cause the read fault to always be diagnosed as write.

Make the iotlb->perm matches more strict: "perm & IOMMU_RW" must be
exactly IOMMU_RW, ensuring that 'perm' has both flags.  Then we can
check perm & IOMMU_WO and perm & IOMMU_RO without worrying about
overlapping with the RW flag.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3557
[2] https://gitlab.com/qemu-project/qemu/-/work_items/3577

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3557
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3577
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 974042d017..7f94ce152e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -282,6 +282,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
+    IOMMUAccessFlags pte_perm;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -509,8 +510,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             }
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
-            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                                         : IOMMU_RO;
+
+            /*
+             * Do a bit_and between the PTE bits and the original
+             * request flags to determine the exact permission we
+             * need, i.e. if the original request is RO and the
+             * PTE has RW flags the actual perm is RO.
+             */
+            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
+                                     : IOMMU_RO;
+            iotlb->perm &= pte_perm;
 
             /* Check MSI GPA address match */
             if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
@@ -1727,7 +1736,8 @@ done:
     if (fault) {
         unsigned ttype = RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
 
-        if (iotlb->perm & IOMMU_RW) {
+        if ((iotlb->perm & IOMMU_RW) == IOMMU_RW
+            || iotlb->perm & IOMMU_WO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
         } else if (iotlb->perm & IOMMU_RO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
-- 
2.54.0


