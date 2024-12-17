Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11283E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR1O-00036U-Ax; Tue, 17 Dec 2024 01:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1A-0002zF-Pv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:16 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR17-00054L-MP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:16 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-728e729562fso4180164b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416712; x=1735021512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YBszf0JEY6lGH98UF5Cbrpj+6ZfpD+LYDcXM9Rwtik=;
 b=L5jMV+GAnm+VDqHqhuccHbccJqf3HXZA+Fmo6ba6V/Qw7x5SVWsON2VpwcWHmo7Ddw
 mqwQknYk0P6T9wwJnZwbPmP9XhKh2+3bpb0c4vdeDkI4VhsFCDl1MxrScgw4bDKh1aP+
 LVgzcXXi66P7HMAKE5UUcFA/PCyc0cMzgRzia2I9dqZshWAsQYvEctm/HnifEpB1Lv4A
 KnF5PCi4o+bBhZPiYQJj0wsnKvxxK3qerPpbOUnGMH7ok7ZJtgGbny2qryHiDWkNB00X
 0bus9Lolm4Bt6/6D0QM9hV3/LPZKSI3MeA+OnRYBLjg3qwBvbQeKvLAeytfT9S/tlr2i
 tWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416712; x=1735021512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YBszf0JEY6lGH98UF5Cbrpj+6ZfpD+LYDcXM9Rwtik=;
 b=p7B9KMGC8p53YD08vHbffWSK596TtUkJ6yoPlCjImKEBr8KhfMPnOhsXlLIQkP4JUy
 /6KX2KgDV4s9l5tv5bKcg5wqlG25ys9zgyMM1fglReqtPDl7rwwqM4rGaDjGBt4Y5wwy
 x2z2a33ymUel78JmkQ+ZlSxHvfZfbw2XyedmfdBq86N0fGV+TT1DuJB341/a475jjq9i
 pxH5ZnG0YcNFc2GTB06MVGRJyH7Mhw9hZ9XucznN+/u5VyxBftFfDMlnnQciBgtq/s+9
 HttDc3cfV9dSW8zE1sBi4ru6LauYmdGDexaSMwUesAprdXTBNlw//poCAfCEAZ7gvUH7
 WQTA==
X-Gm-Message-State: AOJu0Ywj6qCilM2zu6EjAZ02+UwCYmOn29lJ0ndGXam34LufEaOVBgbj
 3r3NmVF/J9Fl5XAkboWZmhavLb2UpcanXnMxchIUIAvYDr8BXtZnjPAD3qB5szIgyE8DJ1xa/9W
 7IPHd1PdTwWzu1H7nAU6OJqF7fgXcvkITNJ0Knkd6oNUfH65CRg2a27KdOBqMopHHIvbzl+A6gB
 hRA+uAUAzI1ejtimBx8qJuFEQXjo55WX2IlkSzWu7tiA==
X-Gm-Gg: ASbGncuslUBI+L2uMfJvFcuu9lCwqtanzscCdH4h4w4RYnP6zNk5qHAvXJA8RFqkBR5
 4ybeSDAtvpMy4BvGtwLZ7rHS+wrNwmD0Kwjn9weoQwCR3g43lH9//F/ZoN6xnfo9oIg33eVCliS
 S+kUXZX14DQ+aGOnXluD2jXRX+27xJrFZ66x/N1iGEnXIgK/WpoVq1Gjpuphej2bkht86AZodel
 75lb2p4Xw9ZwH/GcNAAbyBRy+ubSjY7cUywGTnruz28KowE0uA97DmgLyoUkRBwc+qc4X5xwQCr
 J3CBmIkWqB8=
X-Google-Smtp-Source: AGHT+IEsCps6JcmiXQ13A8bvBhhQaAz2zYfx9lwwi+Fq2rY8xMTRnyswiZeaA0QlY7alWQe1NS9uNg==
X-Received: by 2002:a05:6a21:3947:b0:1dc:e8d:c8f0 with SMTP id
 adf61e73a8af0-1e1dfe12af4mr24555198637.29.1734416711618; 
 Mon, 16 Dec 2024 22:25:11 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:11 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 4/7] target/riscv: Add Smrnmi mnret instruction
Date: Tue, 17 Dec 2024 14:24:37 +0800
Message-Id: <20241217062440.884261-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217062440.884261-1-frank.chang@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index e9139ec1b9..942c434c6e 100644
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
 {
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ecd3b8b2c9..73f940d406 100644
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
+    decode_save_opc(ctx, 0);
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
index eddedacf4b..63ec53e992 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -321,24 +321,30 @@ target_ulong helper_sret(CPURISCVState *env)
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
@@ -370,6 +376,35 @@ target_ulong helper_mret(CPURISCVState *env)
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


