Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF5DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PD-0007LI-11; Thu, 09 Jul 2026 22:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PC-0007JI-1D
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:58 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PA-0008MB-Dm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:57 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso408639a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652155; x=1784256955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g8lYdRd5z5cOdOPvgyruOLYv32eQ/+tR4wiDQUpFPzg=;
 b=SK70lFXd3O1a38XnuFhSKdt98dn7FbJMRncmBuM7Gxg2W4EfENw5lTsyznD4r5YJM5
 smVpC3yopdopl+PfUs4yOtyNZVwbWW1hJMwKFdxsL24N7xaF7XeYm6GaDONuH35ymxxT
 1Z1rFUA/QoHLiuj5Uz+hLjDLEDmjd9IipRQEhV1u0Idn/qi1Mb+jSdX7Gbd1da+ZGZDI
 gDcaIiCHN2B3BeSRzAqRQipJAr4NjbXV7OdGvADs1RJByQqa1v3MhWb9jXlzALWIF4wH
 bHytdsKx5pDnEWJiImt9yXaSSOahgtwS/xBEewmdC+JpjlSu0KNYc5fQGd9iPHqcncYH
 zJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652155; x=1784256955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g8lYdRd5z5cOdOPvgyruOLYv32eQ/+tR4wiDQUpFPzg=;
 b=MgJqVi6gjQf5ggmlY522Hig6GYvclHORirq3TuEEoP8MT7D+gx+cslGNa9lqtvOi8s
 BI3WJHqOjsOdVm4Em8WiaeRaswlI2YKcTmwcpPq88XJbnuHK3Vg1wdrwnc/suaVQoiLL
 gr0OHyQgcDxYGkjBgGhgwi9i0mjTYWt4yaESNB5XXuWwphG2D04cHBnHc4wS+ZXfDG+s
 Li9DTW4tNUhNDChOddWGbS4v65bMdRMstMzaW70lAiby1OLWs0BJ1SjzeuUVUlACy8ku
 Sp69CeV9k+/WPGGmh8sbtm7WEc/9sesWRgqUFECDvJlC/rlhmD5qCyr7USpdz/6tx5mp
 9lbQ==
X-Gm-Message-State: AOJu0YzzV7f87+z1FrRV9dMyry22ytmS4VFXF1Q9VL8o95uAkrShr1a5
 fJLOsjH75UI9BU1I8Om9uBPeQMVzP/adbkV4dAG+wdw7GqQZskJWI9G5YLXu+Q==
X-Gm-Gg: AfdE7ck+WncqSK5iCX6vuZCXuWah+QUvqcN8cZheXEJjz+XmKmo7pzHzzw8lIXJSx10
 QmPPwJfaaPEv+MG50m1dprgy5a8GllxOrjpBl2vPv8oscH2nF0g7qCJwaQwzzcLjArZlm7tKdHI
 m0RiNMPI5r2cBSf+2O9ggAJS3/UCIE2lEKYaSjD19tIVrq2E+RsKiWiZfjvtd8bdtU+6kYbLPQV
 PU4jE3xWX8yV2d+ynGa8LbuoJs+TI5MHCSwmzxpO5BfBIIMuKrie+fU7KbjIMmOdY3eV8it7Jnp
 Dy91M8zyi1T3cxr6ZflCp3KTrADAm6qRskhAun0RXiQe1UjNw8wCICn/nA1lq8BKP1wL7EFo9ri
 qdY4rG72vU89E9dMR5kv8mJyFDTf252oCwfGW6GKfdba/uR5v8QdGgutq3w01ddm/CdK44PBuPR
 38gICZ+UfbIv0uNXF/k/U4fnqwCC8bY2I=
X-Received: by 2002:a05:6a21:62c6:b0:3bf:6c08:2841 with SMTP id
 adf61e73a8af0-3c0bd1ab474mr11982341637.48.1783652155017; 
 Thu, 09 Jul 2026 19:55:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/40] hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
Date: Fri, 10 Jul 2026 12:54:50 +1000
Message-ID: <20260710025525.1704417-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

We need to throw an MSI_MISCONFIGURED error when any of the reserved PTE
bits (first doubleword only) are set.

Fixes: Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3563
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 6b20940b89..c3f9f052ae 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -677,6 +677,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
     case RISCV_IOMMU_MSI_PTE_M_BASIC:
+        /*
+         * riscv-iommu spec MSI PTE basic translate mode:
+         * "When an MSI PTE has fields V = 1, C = 0, and M = 3
+         *  (basic translate mode), the PTE's complete format is:
+         *  First doubleword:  bit 63      C, = 0
+         *                     bits 53:10  PPN
+         *                     bits 2:1    M, = 3
+         *                     bit 0       V, = 1
+         *  All other bits of the first doubleword are reserved
+         *  and must be set to zeros by software.  The second
+         *  doubleword is ignored by an IOMMU so is free for
+         *  software to use."
+         *
+         * In other words, bits 62:54 and 9:3 of pte[0] are reserved.
+         */
+        if (pte[0] & (GENMASK_ULL(62, 54) | GENMASK_ULL(9, 3))) {
+            res = MEMTX_DECODE_ERROR;
+            cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
+            goto err;
+        }
+
         /* MSI Pass-through mode */
         addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
 
-- 
2.54.0


