Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC99C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rofmQ-0003bl-Ka; Mon, 25 Mar 2024 04:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmO-0003Zz-Pb
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rofmN-0004HM-1m
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:34:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ea9a616cc4so798553b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711355641; x=1711960441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLIbztS1B/f/kZz4MvwbrRHywnUwo5ZMMZA2JJ4cvaE=;
 b=j+hngFjLleyzDaPH1qLUpeMbgORCkgl2VnD3nQgFQAYNYvKtnZftlYcBdRV9p//bwi
 bfEZh5f3fqAT0g+kF1YqX6dwJhvPYfkdEW1E3LZ+RwaNYSqnMAMt4WgQp79R04q564Qi
 alHFkUyBFU9y624Q0d51rRQcBqMTuyCEXwy7xCpEIqbD7G25m1oy0lW6F12+lE3jQ5WG
 ns6Xs08n4KkPHBM8pzH+O1tTzpjFfzXBwrFaEY/2Y0B871uYWKezTNWL8gpJH9V2wTeE
 hqmfBcYst1HDh/Kho/nrsfdBJ/YmmZ/XdXBFYjQ1urQSrUSvgL5+sQvvm94T+Igrzzjc
 o9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711355641; x=1711960441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLIbztS1B/f/kZz4MvwbrRHywnUwo5ZMMZA2JJ4cvaE=;
 b=NiFGnq2pqqlyqzjRmlGbaS/EVDTdEf1T4ZLu5X2BVf5F5pxJ5ommO74AmbE6hkaPhB
 FHGMwWjJpMifYYQjHM/dVZ4eDEPqqRnwf2+Di7GbAqhfeHwflSr1KJusId2XMgDHVmVy
 4WYDGv65/sg5f9jiG6Yb3Jb+hsXRutVPQ5G5U82iZVs1u7rx1VVL6t0qjVY3DUo93GYW
 SLTdTRK39ef2tdjEvvlERWbov0KcR6JhFI5wL9BqrfJSWY1H+EsgRS4tnUhTkH3ZIEvu
 dgEgjo3suoNT0ZfiUEZ5C4xXLjh4XjYKW107WSQ1A/4OLkQtAUIjRqsJoW25IGwG9+7L
 m3OQ==
X-Gm-Message-State: AOJu0YzdTo36uN4C/IfPkQ8OqPeat1hBYj+2y34+zFzz2VwrZMkpwSLS
 Vhape09r1ErPq1+j16vtrYMx+qCX6Abq/UOe4rcXjP6K0O7wE7frKNyBPuNN8jj4tUIPxdxSuUa
 eKyrSfvjeeC1GN9ncuKxqUi2F3UGmTNmTaXWLcSGJQdd8NZSM3JUzOY1glGQ51qTrMVeTl0GZ1h
 tXQjXbw7d6lyYTXBmBmSFo9ZolqbPBtOvstUFyYRU=
X-Google-Smtp-Source: AGHT+IHUiPIgDmSi0QeljvI7GM2TFEli4xtTIG6zv3nqlul70l3hm0jt8GVIazyT+HKaaGBKR0PH6g==
X-Received: by 2002:a05:6a20:8f0b:b0:1a3:b153:5f4e with SMTP id
 b11-20020a056a208f0b00b001a3b1535f4emr6043566pzk.54.1711355640596; 
 Mon, 25 Mar 2024 01:34:00 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e0287592c4sm4311269pln.267.2024.03.25.01.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:34:00 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 1/5] target/riscv: Add support for Zve32x extension
Date: Mon, 25 Mar 2024 16:33:35 +0800
Message-ID: <20240325083346.16656-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325083346.16656-1-jason.chien@sifive.com>
References: <20240325083346.16656-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x429.google.com
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

Add support for Zve32x extension and replace some checks for Zve32f with
Zve32x, since Zve32f depends on Zve32x.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                      |  1 +
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/cpu_helper.c               |  2 +-
 target/riscv/csr.c                      |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
 target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36e3e5fdaf..851ac7372c 100644
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
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..b13a50a665 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
 
-    if (cpu->cfg.ext_zve32f) {
+    if (cpu->cfg.ext_zve32x) {
         /*
          * If env->vl equals to VLMAX, we can use generic vector operation
          * expanders (GVEC) to accerlate the vector operations.
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..d96feea5d3 100644
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
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b5b95e052d..ff0d485e7f 100644
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
-- 
2.43.2


