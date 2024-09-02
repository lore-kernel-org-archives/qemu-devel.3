Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FACD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 07:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl1Gn-0000sc-1b; Mon, 02 Sep 2024 03:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1Gl-0000mX-Br
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1Ga-0003jR-4V
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-714114be925so3175924b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725261262; x=1725866062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9Rj5XH4OpfmEHaIVToFPnkTlpcGbOtFPfKlICf0VvA=;
 b=GCC0NfGgir39+GR2eYwV98iGfYLn4eg6DB+81EUf0Dbpm5sevzob8tzN8Gvm/h5Vll
 z7Trtbj2FrZ9hJwDiG+NpsYNuepHG0eETRGC0epVaH6anrhgBh/aS2yqcJ+viPmp1Da/
 j8arUrg7Q6n5HFdMxtL1IFWLA0VOdQ3sOcoF4Q8f2Mplfc9LgKGgWxUuN02ZpJo3LsPQ
 yJ63GzYA4VKJjHJqOV4gvtKv15n5maqc0btv4okARA00xN3RbY+uvpUtKWZqbJuDBURO
 xtRcg4vdLQR5MHgpolAwaJbfx0gwekLNZlvca3iperoZ06UI6Eyjb38x9wnVxxwIUcJd
 kp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725261262; x=1725866062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9Rj5XH4OpfmEHaIVToFPnkTlpcGbOtFPfKlICf0VvA=;
 b=IZ3zUG5s2xmWx8egArnMdwpOYlQYFLkyKBUWKhWb/VhVHLp8p7Kaag3SdZv4Ieqlat
 4MH7qDjT/HZEwlA6dKBr9KV7qZzYH3Cz0EqBQ1EetNsXmSfwOmkR6/Kw8Kv8VEkcsqKJ
 ezMM33bxlmCITYb8/Wb96h+oho3KcHhjIDEpm6fakYSeIc1+9ycZhXkXedY16QFDvbGN
 TzOEgvdQqjVqbq4KdFCpNuaQE1OFuBRJ36/ujec4NHU5NqfDRL8YK+EKz+ZDu2xmLwqX
 eljX+kfu+NAUF9Sb9eu20AuzgOLonVYpPPPW/Xr17LhOkUYxlTOFvnm1Je+Im41VG4cY
 Dz/A==
X-Gm-Message-State: AOJu0YxeAxLF13N3G/jdG+1sYfybaPRl22rH14CWDohZDgcfTTBaQYHt
 EKtnDaS6ur8SP0kBixqpgQj8ps+5H9o6FB6+aMCxF/e9MqR2cUWdUdzI1j4aM+pZNER5I7p5kJH
 t/D+eqbH8fxlAaGZlqlNgr6D2+r/JVkMbqLizVsNqRzgCTPeUVXWCXucEuPD4JJmGNgHCELAUO3
 AmbbYLt6w5NRatqEX5Hc9ce6jc2g7+K1JQu2xywg==
X-Google-Smtp-Source: AGHT+IFIrAwRhLB/vHV5Jqxb2nI6RY5kmzyM2JAgR4Y0JPLllrw8AYGlVF8CpU2YyUbOu21kCdcVUQ==
X-Received: by 2002:a05:6a21:3489:b0:1c4:231e:8ee5 with SMTP id
 adf61e73a8af0-1cecf516945mr6729999637.29.1725261261513; 
 Mon, 02 Sep 2024 00:14:21 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e743252sm6793331a12.15.2024.09.02.00.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 00:14:21 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 4/5] target/riscv: Add Smrnmi mnret instruction.
Date: Mon,  2 Sep 2024 00:13:57 -0700
Message-Id: <20240902071358.1061693-5-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=tommy.wu@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

This patch adds a new instruction `mnret`. `mnret` is an M-mode-only
instruction that uses the values in `mnepc` and `mnstatus` to return to the
program counter, privilege mode, and virtualization mode of the
interrupted context.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
 target/riscv/op_helper.c                      | 49 +++++++++++++++++--
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..16ea240d26 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..d320631e8c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
+# *** NMI ***
+mnret       0111000    00010 00000 000 00000 1110011
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index bc5263a4e0..06bc20dda4 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -106,6 +106,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_mnret(cpu_pc, tcg_env);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 25a5263573..6895c7596b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -312,24 +312,30 @@ target_ulong helper_sret(CPURISCVState *env)
     return retpc;
 }
 
-target_ulong helper_mret(CPURISCVState *env)
+static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
+                                  target_ulong prev_priv)
 {
     if (!(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong retpc = env->mepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
-    uint64_t mstatus = env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
+}
+
+target_ulong helper_mret(CPURISCVState *env)
+{
+    target_ulong retpc = env->mepc;
+    uint64_t mstatus = env->mstatus;
+    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+
+    check_ret_from_m_mode(env, retpc, prev_priv);
 
     target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
@@ -353,6 +359,39 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    if (!riscv_cpu_cfg(env)->ext_smrnmi) {
+        /* RNMI feature is not presented. */
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    target_ulong retpc = env->mnepc;
+    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+
+    check_ret_from_m_mode(env, retpc, prev_priv);
+
+    target_ulong prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
+                             (prev_priv != PRV_M);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
+
+    /*
+     * If MNRET changes the privilege mode to a mode
+     * less privileged than M, it also sets mstatus.MPRV to 0.
+     */
+    if (prev_priv < PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
+    }
+
+    if (riscv_has_ext(env, RVH) && prev_virt) {
+        riscv_cpu_swap_hypervisor_regs(env);
+    }
+
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
+
+    return retpc;
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.39.3


