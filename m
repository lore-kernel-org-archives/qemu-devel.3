Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE919C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhulu-0006NW-Q5; Wed, 06 Mar 2024 12:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhuln-0006MG-Ab
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rhulk-0004EZ-VC
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:30 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso42253295ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709744966; x=1710349766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAAdWJySPSwaib4W22x7z4b4/zwrmSzPD4sUhq56KtY=;
 b=JWJLamevZUHvwWS/nlQW3+xoAxqL+Fw0K1WsvesyabORPQJtEBLN519mdOdMislIn4
 hcwKV/RcYN5uGaP7Z8hHqM/H2LCyJ/EXXfwXVcYNEk/WPl8RvlPKMN4Ls546/IkKDQPA
 z+8e2k7jbgEbapyFhzZMjvHb3ebHNRaXvkU3IkIzJMDIbVxFfzf7E3yZc5h/L++yiY1W
 a1rvvuQd2403G8qzEieHtJgt5L+SeCb1aUrsHTIP/A5P4Rgq1hs3DmkXXZYr5lnkdUPV
 if6/k23Enu20aSKr+ubpsIP+OTBebg8GhFEYAwmemM3wpjwhMDYibu8CRErfYG2DsQ9h
 9LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744966; x=1710349766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAAdWJySPSwaib4W22x7z4b4/zwrmSzPD4sUhq56KtY=;
 b=beR5+bWWTWvnsDg+89kNrChksXx06zCFQdyOdLXzSkUfgTCHvZW6etYy2I6rvKJRcy
 8RczEjj6odnXGqDQAKiGoSvOQ3Me7qpwuq+Xp1dqilM60DXgzY1yebza4J79kWc2BHvL
 rwCiXVNpj5L/dXH6N6AsCLjOjGVxPPWIp+7Ckc6nVeXts2cjCie9+t+uXYKV7C/TLG5c
 FjFc63BMSJmaiagvdHbQ4GjLKLDCQ4XxR8JfPGXdR2nzmZO7DXsEx9uGYxH1EI6XBQOe
 /JaDZ9GpLTzGVo6JCJv83t+9QrTWkzibx7vsVS687rvd3GOCyHQnUkisHU+k1hjStYVh
 IBxA==
X-Gm-Message-State: AOJu0YxeYibz/ZN4ITVJ1js4iLgnm+WbIOKjH9N1O5/6vs1Zi6vaNCNl
 dk12bUIWO/tOc7rJmUQkpgqfcblSQsKAlyjfe8K8jnJ4lwI3reTeNDU2YzXGMXzz6uubsxf57eb
 a+45NERCLz0mZhaWWgkcQqBGJ/bMgD4VE1VdkR3RrLnJkAzXAfKVx0HMmqM3Zwz27UVhCHvFY6R
 XvzdZkH8YgL2l7yr++6WAIm/3BIQqxNRMVEwwymAX0cg==
X-Google-Smtp-Source: AGHT+IG8ZZ2G1BnsW+0sHNYQhq3BcramYRDt02xcIKX1ylFsoUqyaSwWDM5oKPsosCzKLedy/dukZQ==
X-Received: by 2002:a17:902:6506:b0:1dc:d515:79cb with SMTP id
 b6-20020a170902650600b001dcd51579cbmr4561125plk.3.1709744965428; 
 Wed, 06 Mar 2024 09:09:25 -0800 (PST)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170902e74800b001dd091cbc4esm7230076plf.181.2024.03.06.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:09:24 -0800 (PST)
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
Subject: [PATCH 1/5] target/riscv: Add support for Zve32x extension
Date: Thu,  7 Mar 2024 01:08:34 +0800
Message-ID: <20240306170855.24341-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306170855.24341-1-jason.chien@sifive.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index fd0c7efdda..10ccae3323 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
+    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index be39870691..beb3d10213 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -90,6 +90,7 @@ struct RISCVCPUConfig {
     bool ext_zhinx;
     bool ext_zhinxmin;
     bool ext_zve32f;
+    bool ext_zve32x;
     bool ext_zve64f;
     bool ext_zve64d;
     bool ext_zvbb;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c994a72634..ebbe56d9a2 100644
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
index 9e101ab434..f00f1ee886 100644
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
index ab6db817db..ce539528e6 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -501,9 +501,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -653,13 +657,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


