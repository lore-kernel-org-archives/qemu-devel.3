Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C818C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbe-0005Tr-4q; Wed, 17 Jul 2024 22:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbN-00058f-Sv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbL-0003MD-Sr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so2257385ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268634; x=1721873434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIVdqCE+9V3zLHKr7KMoh7icEFJRFOPHyoDtieSP+rI=;
 b=RabGRnaDDZNynMH95axo7ZHD50WqunNWV/mkUx6p813s8qdQz6fn2QyYspG5G88qZw
 mPEORKbGTGzTe06zFZoIiIkdlgSw37/OqHhGy+L0nrEjh0m9Rv2x886mr1Z9hY8gqfuG
 N6g2O1OD7o8edT/BnaGIBZtDG5bnZDryyWLEt1gpy7YtLNg58AmtVP3mtfgCi7kTXwXn
 GGZuSQwhXqzNj7DPGOihGu3gJN/iHhesddVTSE5DIuB3D5Z4g4J5m1sJn1+JYBmX5lBi
 Xc3I3AHWUcceMS01zbDnTjkm9paUBPdYE/Z7YSUnJRR8nh1V0fv+P5d8lbct70XO9QAi
 WH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268634; x=1721873434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIVdqCE+9V3zLHKr7KMoh7icEFJRFOPHyoDtieSP+rI=;
 b=X33EuJkosCeXaTPMR970czgHieIz+vd88mT6D4er4CnVaS8qsDyMCgouVP0tpwW4jn
 QOQ7g/qA2tqQaUYADc8atnJ2EtoLqUk/TtwcE9Ocp964JPVA+Z5q92QKtoMMrGO9JekH
 PczwWgNM6XuhOiU7ic5y6zYRBV6fKvUWWemIRxs5Bl8zaWzxwmI3lOLEFmTcfzEposT7
 vgmmAcRyiuntyW6NiUC6z6tbiDWNQ1Z4MCzuT5Z2Sdao4YLUy8s0fMQAYgzavkcZ1DMF
 v0/6RM7//zYmRgdn4IglCrx7jqrLQJFYIa3iY4J0WF5DSRtiYdf5+bjcVo0L/CYRML+p
 jVcg==
X-Gm-Message-State: AOJu0Yyk7YIRoitemdIPAanyZIA8AStAwW3562aVtQeQpYYQbwabrUO9
 x5IO7uoNXxuqVir+ONSfmpJ3Xpm5KAgk4KFbKp+qKEmHfOH1SLwUEsrb3390
X-Google-Smtp-Source: AGHT+IHEO2LJfhYaS/yTmzoM8UzC1+Y85w/Rm6hYXaVb4G9go8xWwKlf38v0hcM13nfih/j0/26gMQ==
X-Received: by 2002:a17:903:11c7:b0:1fc:494b:3ee8 with SMTP id
 d9443c01a7336-1fc5b5fc3c6mr21272855ad.11.1721268634038; 
 Wed, 17 Jul 2024 19:10:34 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PULL 03/30] target/riscv: Add zcmop extension
Date: Thu, 18 Jul 2024 12:09:45 +1000
Message-ID: <20240718021012.2057986-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zcmop defines eight 16-bit MOP instructions named C.MOP.n, where n is
an odd integer between 1 and 15, inclusive. C.MOP.n is encoded in
the reserved encoding space corresponding to C.LUI xn, 0.

Unlike the MOPs defined in the Zimop extension, the C.MOP.n instructions
are defined to not write any register.

In current implementation, C.MOP.n only has an check function, without any
other more behavior.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Message-ID: <20240709113652.1239-4-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/insn16.decode                  |  1 +
 target/riscv/cpu.c                          |  2 ++
 target/riscv/tcg/tcg-cpu.c                  |  5 ++++
 target/riscv/translate.c                    |  1 +
 target/riscv/insn_trans/trans_rvzcmop.c.inc | 29 +++++++++++++++++++++
 6 files changed, 39 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9f53512053..d85e54b475 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -72,6 +72,7 @@ struct RISCVCPUConfig {
     bool ext_zihintpause;
     bool ext_zihpm;
     bool ext_zimop;
+    bool ext_zcmop;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..3953bcf82d 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac503826ce..f4f8287a6d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -131,6 +131,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zcf, PRIV_VERSION_1_12_0, ext_zcf),
     ISA_EXT_DATA_ENTRY(zcd, PRIV_VERSION_1_12_0, ext_zcd),
     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
+    ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
@@ -1473,6 +1474,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
+    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ecf366d6c7..b8814ab753 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -549,6 +549,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zcmop && !cpu->cfg.ext_zca) {
+        error_setg(errp, "Zcmop extensions require Zca");
+        return;
+    }
+
     if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 379b68289f..8a546f4ece 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1114,6 +1114,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_rvzcmop.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/insn_trans/trans_rvzcmop.c.inc
new file mode 100644
index 0000000000..7205586508
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzcmop.c.inc
@@ -0,0 +1,29 @@
+/*
+ * RISC-V translation routines for compressed May-Be-Operation(zcmop).
+ *
+ * Copyright (c) 2024 Alibaba Group.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZCMOP(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zcmop) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_c_mop_n(DisasContext *ctx, arg_c_mop_n *a)
+{
+    REQUIRE_ZCMOP(ctx);
+    return true;
+}
-- 
2.45.2


