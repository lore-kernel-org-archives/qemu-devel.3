Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E4BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTVr-0000yV-DK; Thu, 28 May 2026 01:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVl-0000xa-Il
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVi-0002Cz-RU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bd266f6fc0so61590395ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779946945; x=1780551745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpTeKWofDBjw7w+JDPclFTF8UMNevt5UsZhKC86KoUo=;
 b=FBiJsnejVr+M69+NykoZb2JgELtaNIVDBZX8/HrvDALQrt2xo2U87/GPCMxcP++23E
 0+ygS6PdLJDkKMqQc5Yu8nMlO6K1m1SCV+6unMDRDyORwC5Dh1upiLiHg7iHe5Swep36
 jN2BMboyet19vbuf1zuddUq19A6oVHR62s/yJ/kuMq5fHnEC5pqDCaYLpRggZ1WzwunJ
 GrKXS78QM5ExaDAlM8MK1R32JLjh6ytAndig8DxtRO2yo9Z4kE0O/VXSt2ojz6kN/xxJ
 OPGyHdIPKewo7rZnuTMmBVWJusQPwOWsehdcvEcKvMtpU6SazdkwtesCiq8DXxKDLX9O
 pRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946945; x=1780551745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dpTeKWofDBjw7w+JDPclFTF8UMNevt5UsZhKC86KoUo=;
 b=tESlztFIaEtXaQzRmM+yYQPQx+fCg3Ktof9/pmLnlQkoGMUqY25C+Rp1+Zo/TjDKYn
 +nQZWkOZztsfSIKw4DDkNAWQS7Z0Th2K0CEKtTLKvoNrJG1Hg83xtPFDuT46HqV41/Dj
 gckHopgaMJESlZzJcLEcn3pWkRT4njGOFHf/gLU19KRRhAmfsYDQ1nT7+27faV+CtR+I
 3gNeZD6wRUSdvkVrVnwzcG+vpCs5Piu+OOD6gf95jjncwP0pqwW4kqVsvhd2TS84mx/q
 JqQrc1zSiGZTleNW2c5LnHTLlR2wzWSMwdqVg81G2Xu03ZVkRZ8CQ85LMiw1Guwaj/TB
 uQnw==
X-Gm-Message-State: AOJu0YyHW3xE7fktw5TyEH6Sqjyjn/7eb1//9g9vnM+C+43MzI+rh1c2
 mB37ItluWL23qm+JSH04sxFayiuupy9dM1w+cy9CzOiwzOpQ8tR0j8KjbAVx+S2g1xxjA+C7nLj
 eCBoPY+tnaxHrXjQe8GRb7beutZ4Iw4E8w3g5b23huR8CpvQr3gNg+FuFnthduLdDAfW2XCZb+7
 Nu84cTb/74JiROWL0Vc03H+nU6fLKW/OlYG5guYsl7wkzECxxN
X-Gm-Gg: Acq92OGQPCMIgiCk4R1qDvRPqk5xjyTmcP2y/ZQ75nW+EdqtVlHuXIkXJdwd1ATBmku
 wwmDZiRABd+8dsDy0Lhal2WlGBlavzEk6rfIrewkIh3DZOQ3Qub9RUKcI0KapccRbgGUMvF6MqL
 IommtuBfRDShlLwrMtCEtcbMgYxePUE11UXJxM7yF21+J3zLUWOjth5hda7WyTYUOdV5VwByxBb
 ZXZeM1MHMS5EMr0O77DR1d/vgbHRPWLG5Jjsq6MEuk0rupU1fBH0rUqerrJJqaDueZqxRUcEHD4
 W9DPtApdBVHz09nWbNyz5IwgHbUOXqlqA8AHiDQs57vqmbVqq/MpMqkvEO/x+tojox6pXBvMtwE
 65OxeKER2Ttw/Sg+wg02vVrFT8nrSpucoTzYAn3E6jTK2ZGv7YD+1IKsB9RJHK48uEnmRfoQLok
 dVm2FbSQ25Yv6Qs45AXiDGOLvkuEuy8VJBldW2/6gLTDOhfl7IsVIViCr/HsiC
X-Received: by 2002:a17:903:3c6b:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2beb0715592mr279469515ad.39.1779946945113; 
 Wed, 27 May 2026 22:42:25 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beca535bc1sm122275815ad.56.2026.05.27.22.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:42:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Jim Shu <jim.shu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 1/2] target/riscv: Add the implied rule for G extension
Date: Thu, 28 May 2026 13:42:12 +0800
Message-ID: <20260528054213.678458-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528054213.678458-1-frank.chang@sifive.com>
References: <20260528054213.678458-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Add the missing implied rule from G to imafd_zicsr_zifencei.
We can also remove the auto-enables in riscv_cpu_validate_g() as
IMAFD, Zicsr, Zifencei extensions can be enabled by the implied rule.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 21 ++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 952e34fdf55..4246fb87c64 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2094,6 +2094,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
+    .is_misa = true,
+    .ext = RVG,
+    .implied_misa_exts = RVI | RVM | RVA | RVF | RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+        CPU_CFG_OFFSET(ext_zifencei),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2501,7 +2513,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7e964e8f1aa..66ac011c54d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -496,30 +496,17 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
             continue;
         }
 
-        if (!cpu_misa_ext_is_user_set(bit)) {
-            riscv_cpu_write_misa_bit(cpu, bit, true);
-            continue;
-        }
-
         if (send_warn) {
             warn_report(warn_msg, riscv_get_misa_ext_name(bit));
         }
     }
 
-    if (!cpu->cfg.ext_zicsr) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
-            cpu->cfg.ext_zicsr = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zicsr");
-        }
+    if (!cpu->cfg.ext_zicsr && send_warn) {
+        warn_report(warn_msg, "zicsr");
     }
 
-    if (!cpu->cfg.ext_zifencei) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
-            cpu->cfg.ext_zifencei = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zifencei");
-        }
+    if (!cpu->cfg.ext_zifencei && send_warn) {
+        warn_report(warn_msg, "zifencei");
     }
 }
 
-- 
2.43.0


