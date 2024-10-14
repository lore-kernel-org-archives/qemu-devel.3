Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6DCD1813B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Pg6-0002cv-3C; Mon, 14 Oct 2024 14:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfy-0002Ue-Gz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfw-0005Rm-Gu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so11211505ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728930010; x=1729534810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJXkflRiS6GKrVgYKiT7kieW99sQA1m/liEOIXMaMt8=;
 b=gB4+pvMUEbE99OE2ta12HC+IAlT+hOq7ck6B/kEgo3lKEns66pb8Liteon9aRDRW0c
 8Uvb0Pr5Xi5PP7nxMuW4j74mhXZ1mTtU7EgXvUMuaHrCeGMKIw/+5YemDctGZmS6gqJt
 hYsyk3wrmlIlC4b++pH6B7qD15GH++PFgwjg2fnHtRFLAl1hb+EzUogghNur/zKeBABg
 ROR/YmZ0r9R38JQ3GjKMdG+ohjSU8qB3KX61FPOEA9k4wwK98jtTCTqnpSlU73raP1bi
 MbQZlXpLZM7mRLvaYU3cXR4A1LiNr4oSD3ItiuwOCcOfqyFZ4Pq5EcQ8b/YJ+Sf7zaBu
 jE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930010; x=1729534810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJXkflRiS6GKrVgYKiT7kieW99sQA1m/liEOIXMaMt8=;
 b=jtKR4fUPEVk4lFa9J8/PbWqDcKKWkFY8cPefoCDWREkM91uAIZ05cuF4Q6DFKMZ8y7
 6kLUZ+8Tms93FS6w6owDmEAEkykTJC7fx3RTY2t/HDUS4QTSeeDtLX4rYf8c6IlDCwq2
 lyfSo4ITD+MQkLCzZ9mBCdc0pW5UxoZ2ohlKUXDN6xiJ9UdvRAiPI1pz2P3ka2gokAaw
 CHRDSxgrTRtyRkyZR2SSpBK68p/4XqStm9Iq+/6+YadeJ967kZs8EIybGqSOfP6RG2DL
 wpyj1UgTRa8U0ersFCRbN0Ed+R0Ywzpn81na5CYQzwGauPBCq0LBagD2kXCYC1hFAMLR
 Y3PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzD7lGQVRLPCKPbTrpQzGyPKc3A0UVF5FppjQF8tSZUF/HteguDmmfBxA41OGp1zXBpsKJsJqjntOm@nongnu.org
X-Gm-Message-State: AOJu0YwQdDOdFVSvXsCPmsJmiIjZi+6PtEiiikAuh2xzy1YAZHV6OcAf
 JEGll0diMqnY2MSn/ZuEcuyGrVyRSERZsvl8lWKFPBXl49e5dddJKnyeMfi5H+8=
X-Google-Smtp-Source: AGHT+IEA2Fd0aPGuNfowrAzphiCf21o5Nr0K1BPpbs4J6ys/Am9CF0L/VFwOYtTzyC9vGgBVeQ9ySA==
X-Received: by 2002:a17:902:d588:b0:20c:7898:a8f5 with SMTP id
 d9443c01a7336-20ca148bea0mr174228295ad.28.1728930010162; 
 Mon, 14 Oct 2024 11:20:10 -0700 (PDT)
Received: from fchang-1826.. (1-169-245-242.dynamic-ip.hinet.net.
 [1.169.245.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c375d0csm68964525ad.304.2024.10.14.11.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:20:09 -0700 (PDT)
From: frank.chang@sifive.com
To: 
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 4/5] target/riscv: Add Smrnmi mnret instruction
Date: Tue, 15 Oct 2024 02:19:47 +0800
Message-Id: <20241014181948.1974405-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014181948.1974405-1-frank.chang@sifive.com>
References: <20241014181948.1974405-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This patch adds a new instruction 'mnret'. 'mnret' is an M-mode-only
instruction that uses the values in `mnepc` and `mnstatus` to return to the
program counter, privilege mode, and virtualization mode of the
interrupted context.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++++++
 target/riscv/op_helper.c                      | 45 ++++++++++++++++---
 4 files changed, 64 insertions(+), 5 deletions(-)

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
index bc5263a4e0..b51f30846d 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -18,6 +18,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define REQUIRE_SMRNMI(ctx) do {     \
+    if (!ctx->cfg_ptr->ext_smrnmi) { \
+        return false;                \
+    }                                \
+} while (0)
+
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
     /* always generates U-level ECALL, fixed in do_interrupt handler */
@@ -106,6 +112,20 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    REQUIRE_SMRNMI(ctx);
+    decode_save_opc(ctx);
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
index 25a5263573..180886f32a 100644
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
@@ -353,6 +359,35 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    target_ulong retpc = env->mnepc;
+    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+    target_ulong prev_virt;
+
+    check_ret_from_m_mode(env, retpc, prev_priv);
+
+    prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
+                (prev_priv != PRV_M);
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
2.34.1


