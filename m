Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A2CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDRG-0007ti-5z; Thu, 21 May 2026 20:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDPG-0003mG-EB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDP6-0004uR-16
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso44356195ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408372; x=1780013172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjZMmpyQD1LLA9i3sAZPSJaJH6BunaEwKF+ldbZm58o=;
 b=hakbDboqCi01LHSyVJKlCTXzdEFX+NXwXWbWWqg/S4arzqUCJp543UZ88da/LSk6PF
 4O7LV5zTBIAT7xndi/gYyHRAprmRLRtkdw0ExSbSIunLuijeNQ3302BxIK6vWTOtAuGn
 9XL6CuBWq+dOegw7Il4b20jTMOk3Nokqi3GVUA7scZPXJZhRzAHcRiKdjAOyRbN86nCf
 D4pQDwRaSiirbuJ7TRiIB9gGti8/Eo2lCBiEHyuDa+grGAp3OIdWXDT71LWQY0jt1xuR
 SEJOPePSStWCyuRUw4UbQ05IHaH7jnRkvIG2fjcVhk4mQaeN6UQdN20Hw0l/KtthRlUj
 yUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408372; x=1780013172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vjZMmpyQD1LLA9i3sAZPSJaJH6BunaEwKF+ldbZm58o=;
 b=Fllju4ei44IL0lPkg5bkTxHG5BZxY5m7bK+G++xEI7qJjr2FFYq00krlsKWW7Esr8u
 PFVo85fx61vLZA1n4pniTxagk85Qa22u5IEbltjxdv4p5nFXfSbGyJzJE60yNGokHwZT
 aSfRRQaI+dpcTq7Y9DuL60k3r0OMoe0BYN25OCBSeNaEjTtIHvrMb8BRZa+AKchmoT2y
 DQtjweyqh4/La+v3lv8926QVj+dgXFlO3H+HIFxtcda+VAwCFlLTPJq3X6PiusXeE3UZ
 sztiYLA6ORbjGaocsRemAePxfNlINOO1Mye55+boMoXv9LEFhravEmXt/8WWYApCbL4x
 /kSg==
X-Gm-Message-State: AOJu0Yw+01jwOdModl3U3IM3vgZn2S85qYw5klSD8pbRKrjq42/Vd0YJ
 pDuEN3yOVnx9zmHMH1pb+is4bXm37l0kFjVuZ82YibVQU4RdMsCCIxFvJJ3c8haS
X-Gm-Gg: Acq92OGrP+HyApqrMVXK1sZeZw7oIl/trg3Zbm9ngPbDnLqmuQTZLWlRibtbzzsLHuZ
 Uks7OicBMKPNE6XbV1YDFEzOkvRAMelw0T70ZPm5L6W3LXHSBZPuIoDAHFzUQD1+UOODYjzB4p4
 ZCn6OVxNFCoqE2e3RkOqCLbJ4UvdShDatOvuI9LhdS0PIXKz9CyKbDy+KrWl4O9WDhaAhi3MWHu
 3NGYTJ3xSCpIQCqOxosvaIlC2C1EXtn8sZfkgzrtS507qXKs6vU2pKjXDyQbEQWkJVrBc/bdZgA
 kAh14NTKdKoax8+zc1hUjgDxWzPgr2DGPOu/zQX8nTIXKZTYRFReV1DRyymQ6AfeN2dS7H9P9sd
 RnL6kdL0Kp2FVAOe7pQK513yyhB0+1ba7Nr+8CqPfgpa+a2QoJyRyheWhVdWyPp7Fx8QXwJo2si
 63dd3OHqAF7cgSI3vW4P2V7kCDf0tndhBcdKnzSM40CUT7TfQ/WAKw
X-Received: by 2002:a17:902:cf0e:b0:2bd:ba87:40a1 with SMTP id
 d9443c01a7336-2beb07ffc75mr10639205ad.29.1779408372154; 
 Thu, 21 May 2026 17:06:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:06:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/48] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
Date: Fri, 22 May 2026 10:03:24 +1000
Message-ID: <20260522000324.23255-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Jay Chang <jay.chang@sifive.com>

When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
the IOMMU should re-check the command queue and continue processing
pending commands if head != tail.

Per RISC-V IOMMU specification :
If command-queue access leads to a memory fault then the
command-queue-memory-fault bit is set to 1 and the commandqueue
stalls until this bit is cleared. To re-enable command
processing, software should clear this bit by writing 1.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260518070143.8405-1-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5bc2472a83..1b8a8e9ef2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2034,6 +2034,16 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
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
2.53.0


