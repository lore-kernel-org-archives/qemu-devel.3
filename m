Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76134CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgj-0006CU-Hp; Tue, 16 Jun 2026 06:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgh-0005xV-0T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:31 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgf-0003Ar-2B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:30 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so4252918a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604387; x=1782209187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt59bHyZKYJMHUs0fyDqd5bA4aPiDp7GL+LqxWw11qc=;
 b=TCI6YTjDycY2y8gcv3Yc8aHxq26VP2cr1NY7ItREw2953gkcBf/pJAilR9+e0lW9Rh
 Syi5vLBjXoc6vtbx0H2id4efzRavWLCY9x3p88IZRF7ZGmNtO5/6Km/aOfPuSRZ+pHvw
 gZuWKcsnOhwmDhj2ezll1+uO1srTmIYUq19ec4EKZud4Q8ahC06a03VYTwyDh09UJxyl
 RwnjZe/VwPyTGOc6zUk/yoTcDTNOdkY4LZ4CsyAZJYzJ/hAbvvFFQIn+iMr15QLQ1Hp+
 2n6ls0lR40ArjblKIKh7zaxyW37AJOfqQEWWbh7qVDEPgZTUjiOc+2YomxxSAoNxKLoq
 PR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604387; x=1782209187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lt59bHyZKYJMHUs0fyDqd5bA4aPiDp7GL+LqxWw11qc=;
 b=gb1jLM85I9mMHitpqr01nEact2Z9jQDBXgCrciuTqX7pw4/DberIeTmGPTRBRXxznb
 5pINEWKodOak4V9+94+tWI3GkoaAqhNFLwlT/kBh0N8EoH9A+gXem+Baunkdz6Gv0uzr
 ImHCfemK5A2lK4zI1kvl+Gg66HDDAUzC9Jxw90ggyXR+msRafkHF7BnluqYLbuqbojMZ
 Mm1jCeQE/fKLANWFzLe9R+mHLxJxicVWP4TyTwzY3tiLxAMWmdkZ3q0pQg5WIKDYViri
 l/DIss6eJqgWb4qMd9yPdBQzt2uGtysTRxDC2hECDdbl3w3fD3EkOgFwlcOax5JHTMjC
 OIXg==
X-Gm-Message-State: AOJu0Yza0fQ5sw5SXc7LwRDPQF00CapkUpulgmh/BDEPEBNxoZAHjMCU
 JebzPF5WAsy4OW4ExdQPLypI+lSzLsds+wlB+frnvOHnGyYJqnwwViIS/rbeEYpj
X-Gm-Gg: Acq92OEcDDi52oZBy3Wsq6MqNjhbCY8/sYcBdVxDB5PsesNoWClCzaC7uOh3ccF62j+
 k/+y8+UbnS+KhOmoyutKyvCPB8fx3gVop74OtHbUT5lQXj/im0cNu/zRW7FKVxazfXKpirBhKTx
 xYnklEMmgDeHgqgmHAI+ixIqMJgss2K960Brh+nz4Lb1T/4LmNsn76R0irEV3c2MoB4h0vCrR1s
 BJdDhaXN5sbm1UYFzMPG+r5UPNpujAKOZbE/TsFQn73yrlWrWNYxjyyJiiE3cTZo3IBxlf9L2ET
 7jrGdTpu/TTF+NXIvFZijmlR+O5+JPIvTsa3ex0owVvpaVSuPX1Ojxgz7anaj0pKa9CyBzEnRvD
 QWcbggQmG+r562qpUwC1Lt/IhUJ12t0QOT/RZ1Km16DCH1jeV4hvGpIjc2qt97WBS/I+UMnBQMw
 j0CA7uO9Z3RH+952a3TLoIBo/pAq2Lu/H6eedV2TJI
X-Received: by 2002:a17:90b:4ec8:b0:368:7c0f:ebf7 with SMTP id
 98e67ed59e1d1-37c2bd06679mr15422428a91.16.1781604387398; 
 Tue, 16 Jun 2026 03:06:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/83] target/riscv: Fix size of frm and fflags
Date: Tue, 16 Jun 2026 20:04:18 +1000
Message-ID: <20260616100527.1939565-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the unprivileged specification the frm
field of fcsr is 3-bits in size, fix it to 8-bits.  Similarly fflags is
5 bits, fix to 8.  Uses of frm is restricted to uint8_t where sensible,
helpers still need 32-bit arguments and the DisasContext field is kept
as int to represent -1 for an unknown rm.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-5-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  6 +++---
 target/riscv/csr.c        |  4 ++++
 target/riscv/fpu_helper.c | 10 +++++-----
 target/riscv/machine.c    |  2 +-
 target/riscv/translate.c  |  4 ++--
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8f0e73b6b5..6692bff456 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,7 +232,7 @@ struct CPUArchState {
 
     /* Floating-Point state */
     uint64_t fpr[32]; /* assume both F and D extensions */
-    target_ulong frm;
+    uint8_t frm;
     float_status fp_status;
 
     target_ulong badaddr;
@@ -667,8 +667,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
                                       uintptr_t pc);
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
+uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
+void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
 
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, target_ulong address);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2e81221b1d..8c2dcbeca4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -918,6 +918,10 @@ static RISCVException write_frm(CPURISCVState *env, int csrno,
 static RISCVException read_fcsr(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
+    /*
+     * This is an 8-bit operation, fflags make up the lower 5 bits and
+     * frm the upper 3 bits of fcsr.
+     */
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index af40561b31..e6d1ffb1d6 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -23,10 +23,10 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+uint8_t riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft = get_float_exception_flags(&env->fp_status);
-    target_ulong hard = 0;
+    uint8_t hard = 0;
 
     hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
     hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
@@ -37,7 +37,7 @@ target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
     return hard;
 }
 
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
+void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t hard)
 {
     int soft = 0;
 
@@ -52,7 +52,7 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
 
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
-    int softrm;
+    FloatRoundMode softrm;
 
     if (rm == RISCV_FRM_DYN) {
         rm = env->frm;
@@ -82,7 +82,7 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 
 void helper_set_rounding_mode_chkfrm(CPURISCVState *env, uint32_t rm)
 {
-    int softrm;
+    FloatRoundMode softrm;
 
     /* Always validate frm, even if rm != DYN. */
     if (unlikely(env->frm >= 5)) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index a0376c7564..5c692e0fe6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -456,7 +456,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.pc, RISCVCPU),
         VMSTATE_UINT64(env.load_res, RISCVCPU),
         VMSTATE_UINT64(env.load_val, RISCVCPU),
-        VMSTATE_UINTTL(env.frm, RISCVCPU),
+        VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINTTL(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b444fde3ef..7c23996271 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -753,7 +753,7 @@ static void finalize_rvv_inst(DisasContext *ctx)
     ctx->vstart_eq_zero = true;
 }
 
-static void gen_set_rm(DisasContext *ctx, int rm)
+static void gen_set_rm(DisasContext *ctx, uint8_t rm)
 {
     if (ctx->frm == rm) {
         return;
@@ -770,7 +770,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
 }
 
-static void gen_set_rm_chkfrm(DisasContext *ctx, int rm)
+static void gen_set_rm_chkfrm(DisasContext *ctx, uint8_t rm)
 {
     if (ctx->frm == rm && ctx->frm_valid) {
         return;
-- 
2.54.0


