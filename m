Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D30BC47BC6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd24f-0000Y1-EY; Tue, 06 Jan 2026 03:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vd24U-0000R1-0o
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:05:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vd24R-0004Gp-4g
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:05:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso6864215ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 00:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767686728; x=1768291528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r0+HXvaOPgEYA2MnwwOSj7ERZPdvCuGaqIN9xne3U/4=;
 b=Kuk6RrW/z2sbP91MHENQ7Eh2PHTIguLPdC/dFBJ7J0BTtGsRrzS3mdVfz2QhWa5Wa7
 vxGWIrX0cPHa18dqCwhvRZC5XyXEH7ZxNIhi2EIB6cUnX/e2aivxhnj7p9oWvSSqOVbf
 k9oHEV8TtlnmbiFhgoGQTREqX8P2xYDHQs8DPC3qdZ/E5zDfhZakUzxXSHENMiPE1onx
 YDyYBKIZ0gfm41WbZ64+lvyvyxx2XLsJHfSom0zAH6n5+Pmpi5obFW6tPp/7JoQQ2Dum
 d1oHEnVM5QweXP1y92/VS2eiAWgZAJepA/Rys8g6zc40g7cX6BRNtF2T4hW+6MPCEPP1
 3ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767686728; x=1768291528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0+HXvaOPgEYA2MnwwOSj7ERZPdvCuGaqIN9xne3U/4=;
 b=RJia9KY6Ayk2DTU002b1bbHEGQM7E9aeX95osqEw7BeIVwv50WqKFQQTF7uxfEc83s
 9FBA00rIvNbXhbR7/0M5XtEo+GjX1lmGdTK4mA5IIYOm25AEeNsxqNgStFJhEEWbd/GK
 AeMTXYFJfSOVtuJycTKa2zzKw/NbPFcN7s5dZBrQH6uk32dFax6BHJxiX01DpocJBf4H
 yc7O2/xbuLDj42RnMuTc3X0r+NiaHst7mDpXBdCTrbMFE9BjvCLgYEfNHy+uFeDxPCP7
 q5hwxuwKsJf62PJ6ckIV1gVE4sYZpz3iHq/CYbMdnQPIKiBte/hXmQwJ2f6wvrZfuntN
 Vo8w==
X-Gm-Message-State: AOJu0Yw7oeNr28Y+GpsVgeFp9m3bfuHzPRBOml1/EYcWXSiN3LGXP3gv
 VKXQU4yt3YyGHK6pjpNk1LUaxs2ZVOVy5HgquFtfdSNnrt558Fb+qxKnNNgJtiMjPo9x9NQhLbP
 H+MOegX2ag4Q8KZKgZfzRnCg02RQqUMapJF4t5Y5MxbpZhQtEtixk4PHYKHBj6/RVLZfflEclv+
 xgIRK/ynJK6PGEVRT3UvMl4Qcgo2W8DAFSx+fW9IIB98g=
X-Gm-Gg: AY/fxX4iIVtXSELuTLbVnqyaPEnsrEZQcZgZzxKYK9/jljd75mLrjvKsJNE5tNoprGL
 oRgxJQzJ6sKizax6/FT6g76cC0ynJxRAyjPHAQclMSBWudHoO4HjccEcxzCk2VgqAczm8m0GRmr
 CafdeK03CLzkkDDdnGXPd1rIXpZe8te+0ZIICWiQwJME6bDy/s61z6VSCKEq9EMpyiVMouPwyUF
 P45hiVQKEsyzXHre3nSJ+FvBP/NvIh3RGEmDzy8JUxduwIQ/Brwd4XeWC+CpaAQ+XJ4Np8hx296
 mNEpmw2D7zboo7sr4QDHCTlMfbpWfubt/4KW1FHIjYIIv0qzNtiubU/prPJGGc2CSxYGLgX5col
 tHVaIGMOCwbrihVTBWb3ia6VVKEJ8OY5RozroVFUrUCVO2wfxBq6h2ifSjlVq0CaYzLJxW9RX6a
 LWmgvry9OxQQoeIfQqrprJKdgMsYSDlln7QjmkzyO16bG8pKTSfQ==
X-Google-Smtp-Source: AGHT+IEHi8OaYGR07dRsBvbtYafRPK2Hsr95GZcK19DT4obD5CbMdzXMHYaSov/KnbzL/8+0wtUUog==
X-Received: by 2002:a17:902:e808:b0:2a2:f0cb:dfa2 with SMTP id
 d9443c01a7336-2a3e2ca283bmr25787035ad.13.1767686727709; 
 Tue, 06 Jan 2026 00:05:27 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d2932bsm1608698a12.21.2026.01.06.00.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 00:05:27 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
Date: Tue,  6 Jan 2026 16:05:20 +0800
Message-ID: <20260106080520.28711-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62c.google.com
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

When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
the IOMMU should re-check the command queue and continue processing
pending commands if head != tail.

Per RISC-V IOMMU specification, the software error recovery sequence:

  1. Read the head pointer
  2. Software has two options:
     - Option 1: Set tail = head to re-start from an empty queue
     - Option 2: Overwrite the illegal command with a valid one
  3. Re-enable the command queue by writing 1 to cqcsr.cmd_ill

  "At this point, IOMMU will start working on the first command
   in the queue."

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b46b337375..e89a262a63 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1992,6 +1992,16 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
     }
 
     riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
+
+    /*
+     * After clearing error bits (CMD_ILL, CQMF), if queue is still active,
+     * re-process pending command.
+     */
+    ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
+    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
+        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
+        riscv_iommu_process_cq_tail(s);
+    }
 }
 
 static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
-- 
2.48.1


