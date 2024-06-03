Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F98C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5h8-0004UA-6M; Mon, 03 Jun 2024 07:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5h3-0004IW-8A
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gw-0006Er-1X
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so38054405ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413445; x=1718018245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObFEgQY5wZEWImSu4eT6GUcuwz9M2wSSVb6vxWt0eME=;
 b=ABszdHhp7oHnjXzoTIiPvhJTz47YYosh8iXLtMANKy13n/jICUaFUF8g3IkaAh8Ig1
 Dg9ZK55mbFXT638dXntXfHq1h7HBfx3YM/92LT0mwqvTiXYdG55U4PPsv/l3notRRhPo
 bGmbkVdifN0KUESfY9g6jYziSVLraVSC7v35okkdk1fFec0K5a92MneOYpBSxqFivg+y
 /OgEMYv22j8WSAcf/xU5hPNJzxKZ93Czr41ka1M2Ft5jehQZroS0i3Cv5/SWo+bxsxI3
 XzrfVYIVGZTS5s+2GR5t5hsk9T5FntQx3iWPTBky4EFEuVlahIKMoSUbDP0tjOT9qg2c
 NB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413445; x=1718018245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObFEgQY5wZEWImSu4eT6GUcuwz9M2wSSVb6vxWt0eME=;
 b=dYvV0GczRRIqCCUJDiQ9XQr3wQ5xwTaiT6DotS7yuJYcoakkG3BE4mnX2oCBri90Ij
 wuW7RrmscLKqJWjFeD6SqqIrT8H5+9x5vDNBhtEz3RvU9kZrkEAGlUwGZuv1CyfQ6I/F
 bacefsjH5+YgVAlcC0hedSAq/KzU2nfo2Y5sk32IQcuLFF/1GThwFqRI81LJ+9hVihuN
 5sibj3UkMxK5rBgL8xPkkiaWN3yP8Na8ezqZy8wscxP6I8IL8pNJWb2nAfKnyzXmgAfH
 XbPE7Q3mOVzVntkT8eVj/z5NMZpBeqqJAF9Cg2WnYbn3WSprWKAOZEEpohCIs/0HphP1
 Axlg==
X-Gm-Message-State: AOJu0Yz3G2Ee6cKTMocILpGoSKEwy7QzPucinfVGhcucA9PdVVAWZ+7i
 WP+7bvVzrjI12zPruLy93PJxQOs7mdDJQr+6WlE7YXoLQ9TKsADeBxLYrQ==
X-Google-Smtp-Source: AGHT+IFmIi3Aem1aej1hy2Jo7gvVxOeDFhWMOMIedkyF/x4gyxjUxaq+IJzaSmEVxJ5w44oVzQ9zzw==
X-Received: by 2002:a17:903:22c8:b0:1f6:7e03:b8b with SMTP id
 d9443c01a7336-1f67e030dbbmr28346515ad.42.1717413445032; 
 Mon, 03 Jun 2024 04:17:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 10/27] target/riscv: Add support for Zve32x extension
Date: Mon,  3 Jun 2024 21:16:26 +1000
Message-ID: <20240603111643.258712-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


