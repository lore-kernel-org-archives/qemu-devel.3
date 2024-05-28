Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F91C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpS-0003vd-Oe; Mon, 27 May 2024 22:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpQ-0003nf-Qi
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpD-0003k6-TU
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so3053135ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864270; x=1717469070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObFEgQY5wZEWImSu4eT6GUcuwz9M2wSSVb6vxWt0eME=;
 b=JsUYtWcOQiD8DajQgp4IBPiw0fTZiW9iwolRmWkH8IPozGws/L/gWijK5RyjnpsrBO
 COBRD/tI2gI7sbkkEw1Q+s6lscq2P/Vzih556RMijzSB0dFzOoWySO8B4u1/aNIpTSpr
 OVn0gvKqtnZe9DT9ZQ5Nr7b65xP7w0u5PArr4i/pMpLZGpjJe4Vj1JSga0KvHBVXu9XC
 nlsgU+M8O7uBEKlbfNFMlb3HV+Cqox+5FVxVSF712RBx0zqRqEpz+A92ApEYjweFIaXj
 XH7OF3+JcZbUrWuXeXL7hcEPbs31eZ6aeeA6UGPIFomudLiyKmVfE8swFglA74CoofzY
 4xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864270; x=1717469070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObFEgQY5wZEWImSu4eT6GUcuwz9M2wSSVb6vxWt0eME=;
 b=Sz8UMn0bojR1JuKKSL7xoVyFsiqENhbAsy14uXRSFyCdm5oHVkMULQz2PmU4a+hv2z
 ivaoJBZZJl+KXdtWkQLZOASO31x/PVuLkTeYf0MXGuJTd9oRVfgpL6mZ/2W0nvRKv+5i
 oLoWTxbVsPwaEC228hv4HBM9xVbhXwpchHGhecGHTt4nrJWv1GrKtZsn0OFvs9NehWn8
 8PVIOhzjd0P6ooRvOYwUek/KS+cDxu7FO/aM6IofVvriPB4wJhMv6vg0GxNxoqnajsY8
 1UMKrB/q991YkEcMpvBDoQ9nr2aDUSm8cZav9jHa5ZIxE7Le06n7o1R7v3nLBN809XVH
 QjWQ==
X-Gm-Message-State: AOJu0YwUUGqnTJZnVkFKwlUfej9Jcnj3wugaMVETxnydtNOZiKAl3uQO
 Vdlg+/9kULCDLBijJ+gpk75RPIsWUsHsNzXUh0Krm/vTjo6J96iRSCYiEQ==
X-Google-Smtp-Source: AGHT+IHp+s/eat18HthQKYxjHpIDca9zMdWJzO2ELjEHvQWBCNOoj85MwpPQawb/Kc9m7YmURsH23A==
X-Received: by 2002:a17:903:1211:b0:1f3:5ba:18d with SMTP id
 d9443c01a7336-1f4486bc775mr146414405ad.4.1716864270358; 
 Mon, 27 May 2024 19:44:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/28] target/riscv: Add support for Zve32x extension
Date: Tue, 28 May 2024 12:43:10 +1000
Message-ID: <20240528024328.246965-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jason Chien <jason.chien@sifive.com>

Add support for Zve32x extension and replace some checks for Zve32f with
Zve32x, since Zve32f depends on Zve32x.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240328022343.6871-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/cpu.c                      |  2 ++
 target/riscv/cpu_helper.c               |  2 +-
 target/riscv/csr.c                      |  2 +-
 target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
 target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..dce49050c0 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -91,6 +91,7 @@ struct RISCVCPUConfig {
     bool ext_zhinx;
     bool ext_zhinxmin;
     bool ext_zve32f;
+    bool ext_zve32x;
     bool ext_zve64f;
     bool ext_zve64d;
     bool ext_zvbb;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..d744594cc4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,6 +153,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
+    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
@@ -1472,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
     MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 179cf3d1a1..d71245a8cb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -73,7 +73,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
 
-    if (cpu->cfg.ext_zve32f) {
+    if (cpu->cfg.ext_zve32x) {
         /*
          * If env->vl equals to VLMAX, we can use generic vector operation
          * expanders (GVEC) to accerlate the vector operations.
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 829d8346ed..58ef7079dc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
 
 static RISCVException vs(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->ext_zve32f) {
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
 #if !defined(CONFIG_USER_ONLY)
         if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
             return RISCV_EXCP_ILLEGAL_INST;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 40054a391a..e2cf5f429d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -511,9 +511,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "Zve32f/Zve64f extensions require F extension");
-        return;
+    /* The Zve32f extension depends on the Zve32x extension */
+    if (cpu->cfg.ext_zve32f) {
+        if (!riscv_has_ext(env, RVF)) {
+            error_setg(errp, "Zve32f/Zve64f extensions require F extension");
+            return;
+        }
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
     }
 
     if (cpu->cfg.ext_zvfh) {
@@ -658,13 +662,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
     }
 
-    /*
-     * In principle Zve*x would also suffice here, were they supported
-     * in qemu
-     */
     if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
          cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
-         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
+         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7d84e7d812..eec2939e23 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
 {
     TCGv s1, dst;
 
-    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
+    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
         return false;
     }
 
@@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 {
     TCGv dst;
 
-    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
+    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
         return false;
     }
 
-- 
2.45.1


