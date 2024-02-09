Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48679C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKZy-0005xk-Cu; Fri, 09 Feb 2024 01:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZs-0005rK-1f
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:36 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZl-0002O2-HQ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:35 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so70429566b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 22:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707460886; x=1708065686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyx14WO2VlxFkhc1a5xMd2hg19LxPHSwC4OsD7s+Vd8=;
 b=NzMhSE9msZDHbxldU396Xmv+bK9o1SE7Vn+UNkf3Yf5SNpz3lC9w2uZ1aBz1HMBks9
 1chXiYk/hvCe3WqnaYD36tJN6cSohU6QprG+9oAFrYJ5FncQDQidS/QAtyu5dp2m/pB/
 rQ5StWyv7s9M/JciJoUONTb9N6p8ewcSn5VmspKjwVnYJvLgJJr6k72oJLm5Q0ztmtsJ
 CYuf+N5yuXynPZTaPY07D9vwRXMMnD5lsJ95e0RRS0fvu7/g9vJlW78j0jLd4FNbYPeO
 6kriThiYQxvIJ+cvQkR5ySkBR9kigxJfGync32j9nScYQzTVAdDYPC/Aq0yOTQS7Pekk
 nBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707460886; x=1708065686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyx14WO2VlxFkhc1a5xMd2hg19LxPHSwC4OsD7s+Vd8=;
 b=aXAYay6c3lPYWHIwvF5kLS0xZ3VENSKLsmbDK8hmgnqziYmXkoL1dBksl1nRTS7DFv
 oMSjVNDtOqm5VgAcaDURVqYXNeNjw6lOrmflhN0xtkL4THTDES+PuhXCol2T+Gv+rB2O
 xiahhxYtr2OLL3fepvqkS4/riC0nWnvA/ga+Jkn7dQHcbs5Bk1aaxM79Md80QCBe7nae
 1rPI9v91dtHB34SHD+nNTa5iQbbTUyY3LjxxOrvGC6HBsudlzB8A2WXisJ6IxP2mncrO
 imHiLluy+9h4TnHM57/mXtrT+SyM4sdhBD7MndQvY4v4A1vzDQPTY/uUPYlVsQHGKg7h
 Um/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjF4Zf7QflGKlIvW8EaQ6pv7YJv/uqKQiVPOd/bQP1Ia7Z+VWiL+LGH2xSPQwPJdkUx/HL0e0+zyfqX8kigfyOc58oJoE=
X-Gm-Message-State: AOJu0YxDGi6t6t2yP7n+vJaKgv3UCKXYPCkwAlTI2Jg9KrLGO5RYxIGI
 87Ju/pCh3Vw/1A4lHvf1rDyY5UTnGwF6ZEI4wjV7bPME70cEzqzytfXeiRyH7Cg=
X-Google-Smtp-Source: AGHT+IHTlnTiRjjIG5iGqID+1N5AGA7ugO/4dpu/2pphdV/WOEERYZ6slSefSrUbEV5/MAug6BYlpg==
X-Received: by 2002:a17:906:56ce:b0:a36:f811:1050 with SMTP id
 an14-20020a17090656ce00b00a36f8111050mr377077ejc.45.1707460886618; 
 Thu, 08 Feb 2024 22:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXUwEhrfC72X16CSzyz1KVZWQwv3mhhZWfeaVUmJg50H2aBK/VDI9pn+dFr0LGOGT3cOpaCNZuHyekGu0T0UW2lm2mERLxF223s0oDQRoFxhANu5dU7P58RoPZeS37DbK2w5MyHVMJR211UcO2O+CuVCP1JSJIm+r247uK+CcTqZXbnNDEh5CWZ4YUyEVC8MXjb6am+xOCbt9ZHQuxXHZaT1OEIfDiMAjvPk5FWoCC4p38hApCB+rdhWhSOlIJz+rHcdkJKaqgvF0v5Zx/8xvwSd9Bxhx0wKYxujukXrWpl3PSicWpW5Tzg8VePm28nigea1GaqLR29JnM1owD/PHHfX9tW6gPOr9h8RONASqeIjmWPcJ2+29tl8rHO6ajB5iK01KEg/Vc3rjnt
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 vk9-20020a170907cbc900b00a36c499c935sm450575ejc.43.2024.02.08.22.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 22:41:26 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [RFC PATCH v2 1/4] RISC-V: Add support for Ssdtso
Date: Fri,  9 Feb 2024 07:41:14 +0100
Message-ID: <20240209064117.2746701-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
References: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Ssdtso extension introduces a DTSO field to the {m,s,h}envcfg
register to enable TSO at run-time.  Building on top of Ztso support,
this patch treats Ssdtso just like Ztso (always execute in TSO mode),
which should be fine from a correctness perspective.

Similar like Ztso, this is expected to have little overhead on
host machines that operate in TSO mode (e.g. x86).
However, executing the TSO fences on guests without TSO, will
have a negative performance impact, regardless if TSO is enabled
in the guest or not (e.g. running a RV guest with Ssdtso and disabled
DTSO bit on an aarch64 host).

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/cpu.c       |  8 ++++++--
 target/riscv/cpu_bits.h  |  3 +++
 target/riscv/cpu_cfg.h   |  1 +
 target/riscv/csr.c       | 14 +++++++++++---
 target/riscv/translate.c |  2 +-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b679ecd8c7..ee90c09600 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -174,6 +174,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(ssdtso, PRIV_VERSION_1_12_0, ext_ssdtso),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -950,9 +951,11 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->two_stage_lookup = false;
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
+                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0) |
+                   (cpu->cfg.ext_ztso && cpu->cfg.ext_ssdtso ? MENVCFG_DTSO : 0);
     env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
+                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0) |
+                   (cpu->cfg.ext_ztso && cpu->cfg.ext_ssdtso ? HENVCFG_DTSO : 0);
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
@@ -1460,6 +1463,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("ssdtso", ext_ssdtso, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fc2068ee4d..e11191977d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -744,6 +744,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
+#define MENVCFG_DTSO                       BIT(8)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -757,11 +758,13 @@ typedef enum RISCVException {
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
+#define SENVCFG_DTSO                       MENVCFG_DTSO
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
+#define HENVCFG_DTSO                       MENVCFG_DTSO
 #define HENVCFG_ADUE                       MENVCFG_ADUE
 #define HENVCFG_PBMTE                      MENVCFG_PBMTE
 #define HENVCFG_STCE                       MENVCFG_STCE
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index afba8ed0b2..606ae5a120 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -73,6 +73,7 @@ struct RISCVCPUConfig {
     bool ext_zihpm;
     bool ext_ztso;
     bool ext_smstateen;
+    bool ext_ssdtso;
     bool ext_sstc;
     bool ext_svadu;
     bool ext_svinval;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b9..c06b674994 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2058,7 +2058,9 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
+    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
+                    MENVCFG_CBZE |
+		    (cfg->ext_ssdtso && !cfg->ext_ztso ? MENVCFG_DTSO : 0);
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -2108,7 +2110,10 @@ static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
-    uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+    uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE |
+                    SENVCFG_CBZE |
+		    (cfg->ext_ssdtso && !cfg->ext_ztso ? SENVCFG_DTSO : 0);
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -2143,7 +2148,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
-    uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+    uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
+                    HENVCFG_CBZE |
+		    (cfg->ext_ssdtso && !cfg->ext_ztso ? HENVCFG_DTSO : 0);
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ea5d52b2ef..f0d4db0b64 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1198,7 +1198,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     ctx->pm_mask_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENABLED);
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
-    ctx->ztso = cpu->cfg.ext_ztso;
+    ctx->ztso = cpu->cfg.ext_ztso || cpu->cfg.ext_ssdtso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
-- 
2.43.0


