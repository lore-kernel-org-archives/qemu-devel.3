Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E0C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjb-0001Ov-Mc; Wed, 19 Aug 2026 23:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjZ-0001Hu-Q0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:29 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjY-00043q-20
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2168806a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197587; x=1787802387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SgsaYtQ8tDSYVVM1L00F+By8GMWleAT9fxOmw/AcfMA=;
 b=Vlz3R3rWZoJY1Zqj3BM5/Oj7WZjmXao/FMz1kx6vVoJZrn0SX4VdNbCE2rlvOO8nV7
 bVmRavytSoqXpQPiw+JkbcbLwm+7icRhEEOLp9Go1xmUV2TEJqiwimzyjTCS4CVkIBqf
 iaXL+g5MM29csPsF35YsTpSdagiqG+BFy7Iu3J0T3EC+Jh8gDSe6ji+Ugi6TWdQhtCEM
 AfrvCpVreauOzZDhzOUzr9Q2gfWEEhIj+xOS5jpUINSGOnX8QZsQniJJvTa+CrDohY6j
 8CVnB5SuZ+rIpsFYYpfalV+BXT/Do7NmJfOBh2a7ny+uAidlf9J0BFfICLtQPlbL6s6F
 mFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197587; x=1787802387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SgsaYtQ8tDSYVVM1L00F+By8GMWleAT9fxOmw/AcfMA=;
 b=GabrICtc1/rrHFeDy8r8yU+kvNcXhR9RkdxJulay4t1oA13Jq510WcYtJfejYUcKZt
 j7zDzoZKThmc7s9bTrC2HvvmVG0TQWya6/4D9g8SrzOoX4jId1MoBhMd9USa273l9JgS
 zcF/R44lPL0Jd4SlmQsMSHrhZBDZFWgsCUjbb6nRwz4QuUYgofALzBtQ4rRiQEGvOlzw
 HlhjWZ8Z9bOGRgMpDQQg6XTjeR9PT4Zt6Wtw1SUdFy/kNmJVIxPRa6tuap3xdsAoLq6B
 CRTK3w+8pVGtFkjt2KgKEhRc0xmLNWB/+Z1w7IdXoFKfkUCYCD/8uZsg6ROknx68N4qC
 N1Mg==
X-Gm-Message-State: AFuF++lzODpr7bbQn5d4dUECBO0aRvet2NBilTkmTwWnfy2U7mb3RVXS
 Ms6WvtS/9AfLvKiiaboR3PvWNs7tJ4QHfwhC0mFTVrYKWnT6AdA0hCK0V0+Sgw==
X-Gm-Gg: AR+sD13Xz6lLH6Cv6K1W9ZaIbbQYc6m3HhdPhhvExQhy7aGR/i6awGPefD8sqm5ANMF
 0Hlmp85CqB5hycRBqzPPA1/4yHhDjINTuKTrfD8ubkRdr+nVXDNXxNEFuJeoIx1KbUbcX6nQd+/
 JSY8brZTbx6cQN0813wmGQRn6yKAFCh1tPhQqWwibXceNMzI7Ou4Wl9AGGMJqrwEsn+dI1jnZK/
 JElJAuPNfXFmFslQGzc1IsepsRmlrSh5aCTaLJXFu884ZWzuAQLqywA9beNdnkmfLTz4TPbh7yg
 4zZ0jOchcmKTcw59n5y+LZ+AZJj148AxKx2LaBlbehzwr3BZ8+G3+gPq1AoYEko/lH0MCVw+MAb
 vAHt5yjjxn/geDELr/jbbr4hA7seziXY6pY1ASw9ajoaVEEEqF6bqxS1dEyf7f1ycYmzd063dIC
 MJXUho5sjVFBazPWJC/KbktHCCTK5bDL+a2GDXGEvF+iTrU8PZUxYxaEidoDuu0Pz+8pCGDhtl2
 Ixt2g==
X-Received: by 2002:a17:90b:2b8e:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-39580f03c97mr18254727a91.7.1787197586624; 
 Wed, 19 Aug 2026 20:46:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/93] hw/riscv/riscv-iommu: fix U-bit check to apply only to
 leaf S/VS-stage PTEs
Date: Thu, 20 Aug 2026 13:43:31 +1000
Message-ID: <20260820034430.1186695-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
no priv access") placed its check ahead of the leaf-vs-non-leaf
branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
including non-leaf/table entries. Per the RISC-V privileged spec's
address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
been reached" step, followed separately by the U-bit permission
check), the U bit is only defined and checked for the leaf PTE
reached at the end of the walk -- non-leaf PTEs don't carry a
meaningful U bit at all.

Move the check after the leaf/non-leaf branch, alongside the other
leaf-only checks, mirroring how the G_STAGE U-bit check (added in
9158c900ab30) is already correctly placed.

Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 2bbac30cfa..462087f401 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
-        } else if (!(pte & PTE_U) && !pv) {
-            /*
-             * All accesses are assumed to be User mode unless
-             * process_id is valid (pv).  In case we have a
-             * non-user mode PTE and !pv we need to fault.
-             */
-            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
@@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
         } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
             break;                /* Misaligned PPN */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode leaf PTE and !pv we need to fault.
+             */
+            break;
         } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
-- 
2.54.0


