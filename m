Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCB1C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgxJ-0006ub-TR; Wed, 07 Feb 2024 07:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxF-0006tC-50
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:05 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxD-0007Cc-28
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:04 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5116930e92cso299613e87.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707308581; x=1707913381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqXN7kP1hctkf0dzKT9GxG/h8OL9Zq0Ugm+1HgJ+nt4=;
 b=iCBfTRMSqYLuk3KBgu05pjo21HhQmAHgKCpZ/Ox6OgRoLou2BXbDy2Am9EZJ/eR1Q9
 4s3i2pLqoepkRjJDNEPbBB7jM+IA8hq8WV1YvQVVeJfqXkr7GAqFHPtac9vnJGl9iVAe
 dP7Z5B5I8KOPDCERYDfhiWt8DE2lDeX+uNWdPj8yMlOq7cUsXmXRnxY8bIjHqu5KjdAn
 rTGmDvnU1OrskEZdIYMvqLhLNWWfP+p85FUfcqU4tARytFXhL3UG1w/grHWxNIq+Wvpj
 B4kb2cCrTskT0FhKHbOLwctMRmhZc2I5gUDHPy5c223aTD344nSItHaW9Y8vkOBbvzwk
 DmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707308581; x=1707913381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqXN7kP1hctkf0dzKT9GxG/h8OL9Zq0Ugm+1HgJ+nt4=;
 b=ok6Gl0unbVNClQXb0XJsLNx5eAhDFYrKOXUbzUmDgmHgwG25oyXHN/sJlarpkH2uXx
 mxDaUsjCcocd5tQrqnDlA9Z+mvD0oeU1HZ9S63tGomvLAUEgaqDzBsIWH/kyRJcQbO44
 gt+2deLL13EZV5gsa70VDCebvFW4tJlvpAw8bgWASGKWCHhr567vjSpaBGQxjJn5W2b/
 fxqDWEtlDOEyoroN2PTqpuormFGIk87W3Ju9HG5lLlhRPfba1L/PJFkhZhcPRADNTA+k
 mM9z8Zp0KjZ3E6Nga1XTyJQUEHCsLRLYA4G2qI1GT41PjZRde5thV+fFZ5ihe7j4gXXk
 TfNA==
X-Gm-Message-State: AOJu0YzqO3rP83IWMXacavDHbtRO93s2ZcQUq8swqDkNHmedWSnB062I
 oHBOMU8dYHVUlJe37iW79och6YC1NxDP13QEDzCBw3baKPOk0UDlJ1NQLk6spJ0=
X-Google-Smtp-Source: AGHT+IFFBB0SRgcniQOnugEhExpT2pSJTnPazCTWJ5zZSz6Am93L+piFzh2Z4SvrCpsEm2K+T6lCHg==
X-Received: by 2002:a05:6512:3e01:b0:511:577d:10de with SMTP id
 i1-20020a0565123e0100b00511577d10demr5031414lfv.37.1707308581096; 
 Wed, 07 Feb 2024 04:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXOdJc7rgpLQkz92BuDWuM+J+PVREOGSDid42I63YE6Py5MtQF5JDzOGw++eB8OVXEBMFsXfD3rtDBz269RhX1qGMzKVZ4vytN4eeCbFpSNzaal8/p/yRfaKJsSI74AMVS6hculrU7T95FNmUMV2wZvu7b4MYEad2pxjSQEN9ZAlI2oczhg45TO+t9y3W1Nb/Ab9IWS8MUI7F7WLL/Sw8tFZLLo5Z4pccqwLukrHanuL/1LdSwdaGIi82HUblYVFRqmjgadFUv8+7Wea1C5CD4Ylg9+it6ZGtecWO08DwKOGeMiV6tSMMUemkLjGv6dIq4VXsq91rIE9UhGNpOnw26earFY869gsd2mhKMnWqoW/OZSXDd7juGRx3Age6qAhox+GFlJ58CyPsunyvBAoLbubZmlGZbAXDQvmGsS0VTIuF2m6ampNX4=
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 v8-20020a1709063bc800b00a3515b35be4sm702284ejf.104.2024.02.07.04.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 04:23:00 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/2] RISC-V: Add support for Ztso
Date: Wed,  7 Feb 2024 13:22:54 +0100
Message-ID: <20240207122256.902627-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207122256.902627-1-christoph.muellner@vrull.eu>
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lf1-x132.google.com
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
---
 target/riscv/cpu.c                      |  2 ++
 target/riscv/cpu_cfg.h                  |  1 +
 target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
 target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
 target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
 target/riscv/translate.c                |  3 +++
 6 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b8d001d23..b679ecd8c7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -143,6 +143,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zksed, PRIV_VERSION_1_12_0, ext_zksed),
     ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),
     ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),
+    ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_ztso),
     ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
@@ -1488,6 +1489,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
     MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
     MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
+    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
 
     MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
     MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 833bf58217..afba8ed0b2 100644
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
-- 
2.43.0


