Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DCC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAA-0007GJ-Gx; Fri, 08 Mar 2024 06:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA8-0007Eq-Rg
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:16 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA5-0001gZ-Q2
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:15 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd6412da28so7888095ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896392; x=1710501192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhMWBg8AjhXOC/Sw2h0NKMMtiMLRHrjyoh4xDMfobYw=;
 b=EX8qsvByA4nWKQ7ksheZNqdtxaSLs4AZ3c9mytSqLdITc7keN7svX2ZB7ZwNhjIYdw
 AsWt/TwCnkO2ngTPN1wO5Qad2rdM/O39USHJa7ekSatl9m6A2EPTOXdMzlIOvVN+fz89
 uyf9xc4VbJPzHiQbn557WkEs8BTwlFkSZ1X0SBSmejJyV8YPkePueZpJjOBLFbwVQth4
 CqS2Q7HmeK02bLTYxYIMob5e+36+cBs/kk6sP8dV4tx4TEtZH+AyFuuI+3Bd6vjEWamS
 wX4i65hgPMqsOBuDwQh4Tdv4mx1B7g9SsKwjMM3BGn91tqsvHtQw+jSMlJLNThC7Jf9s
 zN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896392; x=1710501192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhMWBg8AjhXOC/Sw2h0NKMMtiMLRHrjyoh4xDMfobYw=;
 b=wsnSxYelrFjqnRJg6Tz4Mp5vV1zh42BdhgUFRLrdSUfMT5IGKKG/mq4Amh0m0TkskK
 lQUjNZhDHiMpJ5u17rwA21xP5IlcmBMezNx+29yvSoBoeCOJurFqpHTPGRJyarfzDx3b
 V+gocG3EUyUjphBiKrhUodKw4OQEkxvKZhJ5oaBRMYFMIUf6CNNdmA/j7u9ZQbWbxrxF
 1BXaCctdTJ8rjiYc00cxNSy/6Hkh69RU17foK1RklbNbYeYyP5ApZ3vZY6ofTmojiW38
 n5FKGHKPMHbpM9hP9VRf8IDeqNNrk9MhcoUTSIMPRe5vpIeljRMviv3zavXmpNmszxbP
 LmiQ==
X-Gm-Message-State: AOJu0Yzple+doej6IFmSSRKQQ+4deX0pEvu2W8s3JYKm3pBoEADoRtLh
 jWIo1+1Wr/dReLbgO/vrbeA+LWORHZpZtETWSeMP4tzxgq3E/Klk25Y9pJ9hluAdrg==
X-Google-Smtp-Source: AGHT+IEtaUE4PLfip5H00v3B5nc+99UyD0+h5IkGy1nX5qKNi0lJR+f2eXlNeq779WfxyFnsvqyChw==
X-Received: by 2002:a17:902:f547:b0:1dc:fc88:c5b1 with SMTP id
 h7-20020a170902f54700b001dcfc88c5b1mr13038858plf.7.1709896392189; 
 Fri, 08 Mar 2024 03:13:12 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/34] RISC-V: Add support for Ztso
Date: Fri,  8 Mar 2024 21:11:39 +1000
Message-ID: <20240308111152.2856137-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Palmer Dabbelt <palmer@rivosinc.com>

The Ztso extension is already ratified, this adds it as a CPU property
and adds various fences throughout the port in order to allow TSO
targets to function on weaker hosts.  We need no fences for AMOs as
they're already SC, the places we need barriers are described.
These fences are placed in the RISC-V backend rather than TCG as is
planned for x86-on-arm64 because RISC-V allows heterogeneous (and
likely soon dynamic) hart memory models.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Message-ID: <20240207122256.902627-2-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/cpu.c                      |  2 ++
 target/riscv/translate.c                |  3 +++
 target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
 target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
 6 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index be39870691..2040b90da0 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -71,6 +71,7 @@ struct RISCVCPUConfig {
     bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_zihpm;
+    bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_svadu;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 71bdedc9bb..37425e0e50 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -149,6 +149,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zksed, PRIV_VERSION_1_12_0, ext_zksed),
     ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
     ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
+    ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
     ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
@@ -1500,6 +1501,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
     MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
     MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
+    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
 
     MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
     MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..ea5d52b2ef 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -109,6 +109,8 @@ typedef struct DisasContext {
     /* PointerMasking extension */
     bool pm_mask_enabled;
     bool pm_base_enabled;
+    /* Ztso */
+    bool ztso;
     /* Use icount trigger for native debug */
     bool itrigger;
     /* FRM is known to contain a valid value. */
@@ -1196,6 +1198,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     ctx->pm_mask_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENABLED);
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
+    ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 267930e5bc..4a9e4591d1 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -40,7 +40,11 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
     tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
-    if (a->aq) {
+    /*
+     * TSO defines AMOs as acquire+release-RCsc, but does not define LR/SC as
+     * AMOs.  Instead treat them like loads.
+     */
+    if (a->aq || ctx->ztso) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
@@ -76,9 +80,10 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     gen_set_label(l1);
     /*
      * Address comparison failure.  However, we still need to
-     * provide the memory barrier implied by AQ/RL.
+     * provide the memory barrier implied by AQ/RL/TSO.
      */
-    tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
+    TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
+    tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
     gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
 
     gen_set_label(l2);
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index faf6d65064..ad40d3e87f 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -266,12 +266,20 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
 
 static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
+    bool out;
+
     decode_save_opc(ctx);
     if (get_xl(ctx) == MXL_RV128) {
-        return gen_load_i128(ctx, a, memop);
+        out = gen_load_i128(ctx, a, memop);
     } else {
-        return gen_load_tl(ctx, a, memop);
+        out = gen_load_tl(ctx, a, memop);
+    }
+
+    if (ctx->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
+
+    return out;
 }
 
 static bool trans_lb(DisasContext *ctx, arg_lb *a)
@@ -328,6 +336,10 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv addr = get_address(ctx, a->rs1, a->imm);
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    if (ctx->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 9e101ab434..742008f58b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -636,8 +636,28 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
+    /*
+     * According to the specification
+     *
+     *   Additionally, if the Ztso extension is implemented, then vector memory
+     *   instructions in the V extension and Zve family of extensions follow
+     *   RVTSO at the instruction level.  The Ztso extension does not
+     *   strengthen the ordering of intra-instruction element accesses.
+     *
+     * as a result neither ordered nor unordered accesses from the V
+     * instructions need ordering within the loop but we do still need barriers
+     * around the loop.
+     */
+    if (is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+
     fn(dest, mask, base, tcg_env, desc);
 
+    if (!is_store && s->ztso) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+
     if (!is_store) {
         mark_vs_dirty(s);
     }
-- 
2.44.0


