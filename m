Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62CD75BBE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0Rc-0004Zm-Tl; Thu, 21 Nov 2024 01:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RI-0004Wa-E1; Thu, 21 Nov 2024 01:13:17 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RG-0006Kp-J2; Thu, 21 Nov 2024 01:13:16 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53c779ef19cso498787e87.3; 
 Wed, 20 Nov 2024 22:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169592; x=1732774392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwcJT32j32KKKz/tCRrugf9yi6vjemEK7dj9TrpBfM8=;
 b=IIGyLunvs6FQupyldKfdXuXvw4/gAK5FpclSkKgZJfUHEcLY/y+GGKIlkxfgrLosmK
 87hZfbQMaptN3Jp9wAv3CO3t8JQwPVVLcpM+uEJo2cfLyHR/Pue2nWID14B1N9dKdqMH
 pWS+Fng9n5lxLdZ63E61NqX/pR4ZI0k1oUvzcPDWWd1WUGvW+OaQG5jSDO4SyaEhg1UE
 VbVyiPbBSEB2bE38PO3nHvyTNmH32NONc2sEujWWZdH9ml4XLnCg8khLdGXDTO+l/qTD
 WpUdwxRw/b9ajvVmVUtC2V7pOGZWKuG/HqZepsi75LZb7yOX9d5T7JInws6RVTsK8YU/
 7xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169592; x=1732774392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwcJT32j32KKKz/tCRrugf9yi6vjemEK7dj9TrpBfM8=;
 b=CrqldzuMSnQmZG/0swNiCnGfqmGTfGNlSASJr5AqxP1A+CyTNVH0LCqqBy+L1WuZyu
 1A+QdIYBw1pZebmOQzMJn362cCQD1LwdN0ghovpIQYqYdZzk7tZWq7d/YEKbkXhOzWU+
 7PbTInayJUu7q8do2ow0BEMzztplca+CLtBxajPZiNC/VyHDpplJ/pHOVSPNH9ksFX88
 e670InBHkJbkdNdhxNKbXcxcnO7MPx8iT3L8tUYaNpoGJJnXqL3BQ/z7RiuNkpRrfRoD
 EUtW2Zy82Pg1M+x+3lmzE/US5MxDafMpDk5pqDfQLXWBY5HNidNbCRhlPssE9+hYR3xl
 X9Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoB5HmF37uYANw3KWMSpc5EGAnvnPCTzMrFiHBeiEZJ1Bp3/sjMtIJ2b0kk1V/Rj2r16BZW3qQ+xpJ2Q==@nongnu.org,
 AJvYcCXjNTzyinUqkKH4soONRsZhLUzrZWtLmr9LhJce+yyPX5DaNwZ25E8JlsBMgW/RWkg/hzOWfz2hS+Qy@nongnu.org
X-Gm-Message-State: AOJu0YzUNlKD18YxHs5wbKu2eRFaHa8FlbYT1H8HUv6LuJytxNW7dgzf
 78JdkgkUxoEylkKNQkDCTaBAfHcEvdJiLObLsNGQFa2bBlyFHNbV
X-Google-Smtp-Source: AGHT+IG6FfjP2NF19F0ASBrLYxaqH1b+MM5wn9wmBRoZxON33mvIkYXf+TV+S6GQJC9TzMWyZvq0NQ==
X-Received: by 2002:a05:6512:3044:b0:539:f5a9:b224 with SMTP id
 2adb3069b0e04-53dc1323555mr2207662e87.11.1732169592323; 
 Wed, 20 Nov 2024 22:13:12 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:11 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Thu, 21 Nov 2024 09:12:58 +0300
Message-Id: <20241121061259.4043177-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.h                      |  2 ++
 target/riscv/cpu_helper.c               | 19 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvh.c.inc | 11 +++++++++++
 target/riscv/translate.c                |  4 ++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11e3a6d647..6bbd9c6c25 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -634,6 +634,7 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 /* If pointer masking should be applied and address sign extended */
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
+FIELD(TB_FLAGS, PM_VPMM, 32, 2)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -773,6 +774,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 int riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 78b461a5cf..4065809d9f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -213,6 +213,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
+    flags = FIELD_DP64(flags, TB_FLAGS, PM_VPMM, riscv_pm_get_virt_pmm(env));
 
     *pflags = flags;
 }
@@ -260,6 +261,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     return pmm;
 }
 
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    if (priv_mode == PRV_U) {
+        pmm = get_field(env->hstatus, HSTATUS_HUPMM);
+    } else {
+        if (get_field(env->hstatus, HSTATUS_SPVP)) {
+            pmm = get_field(env->henvcfg, HENVCFG_PMM);
+        } else {
+            pmm = get_field(env->senvcfg, SENVCFG_PMM);
+        }
+    }
+#endif
+    return pmm;
+}
+
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
 {
     bool virt_mem_en = false;
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 03c6694430..ae067789d1 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -44,6 +44,14 @@ static bool do_hlv(DisasContext *ctx, arg_r2 *a,
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    bool is_hlvx = (func == gen_helper_hyp_hlvx_hu) ||
+                   (func == gen_helper_hyp_hlvx_wu);
+
+    /* Apply Zjpm pointer masking */
+    if (!is_hlvx) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_vxl);
+    }
+
     decode_save_opc(ctx, 0);
     func(dest, tcg_env, addr);
     gen_set_gpr(ctx, a->rd, dest);
@@ -56,6 +64,9 @@ static bool do_hsv(DisasContext *ctx, arg_r2_s *a,
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    /* Apply Zjpm pointer masking */
+    tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_vxl);
+
     decode_save_opc(ctx, 0);
     func(tcg_env, addr, data);
     return true;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 32df295123..d8f83315c6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -104,6 +104,7 @@ typedef struct DisasContext {
     TCGv zero;
     /* actual address width */
     uint8_t addr_xl;
+    uint8_t addr_vxl;
     bool addr_signed;
     /* Ztso */
     bool ztso;
@@ -1239,10 +1240,13 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     if (get_xl(ctx) == MXL_RV32) {
         ctx->addr_xl = 32;
+        ctx->addr_vxl = 32;
         ctx->addr_signed = false;
     } else {
         int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
         ctx->addr_xl = 64 - riscv_pm_get_pmlen(pm_pmm);
+        int pm_vpmm = FIELD_EX64(tb_flags, TB_FLAGS, PM_VPMM);
+        ctx->addr_vxl = 64 - riscv_pm_get_pmlen(pm_vpmm);
         ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
     }
     ctx->ztso = cpu->cfg.ext_ztso;
-- 
2.39.5


