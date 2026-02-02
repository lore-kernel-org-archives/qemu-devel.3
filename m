Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC90E7FDF8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3dQ-0006T6-EP; Mon, 02 Feb 2026 18:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3dF-000646-Kg
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:47:04 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3d5-00056o-Pl
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-48069a48629so51913125e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770076001; x=1770680801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAL+aIs5ry4vKmBS8ogIFPfxGSOuowscEEIzZgSPSPk=;
 b=qoElUm0cbmTQ+YAFb6FlsRIAbDYzj6mnnR+3ya/rzuo7/2ZzZ5jW8N5uHyhK31hYoV
 VIhIFSiry4ftle6+r9SbrD4NQzpFLKJ0D1lGPZ0t/Q3fiH+qjuSD2OTl6sQ3tg7DZJED
 MtV85W/4g+lkN6hE7FYVkf6LHeV9fkFzFkmycrNiWiyN0ByEkD3r1yH8v+lMN1wSUqwV
 dSKcAUyTKk8FwkY+WOEwqnFYJrbxKZHfU0DVXxCwkabc2kRawRLOf9gtAILGTv/Lx2IQ
 ekxnBGSbdBoiLcdXHRmuDTJHWaZkKmuO3/r/OMdcO2ILGpLB32i7djYeeU/qpgYYQLgC
 MAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770076001; x=1770680801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAL+aIs5ry4vKmBS8ogIFPfxGSOuowscEEIzZgSPSPk=;
 b=uaIxt3WUs4Q7vNIFYfdiSNfF9ZgPx1jm1SWUI5oGIsJuCxuoCHYY3ywbhSmDIC3kHV
 il5yT51fwbVLakuz6OkFW64HILxOtMeFyKgQA7NF/tcDiJDiEBIfd0R43DGL4YfedYQY
 r4sQjdSeIGgs0kcweVuxdTY5EWttMWzH3H7nxqmdDrc4gdSLHb0tlgJhZsHHfal9lMlt
 ZPJih0srR94ir8c2pR8DW5NhgCSU+poSxcKLpWb4MrMO4sw2CeMcYqHqhP0zJ24Boq52
 X3Z+WlmPc5VIdiSTe43VriGsQgg+ay9s4Jn/+LuMkB6sLI5ExljUjRJKKg82fGBXBEA5
 EW4g==
X-Gm-Message-State: AOJu0YzuDn8hj1d7NFxiqpW3uBS5/CWdPCrPcpKbEGSUwofs5ilhy2xK
 uCb5c82j8hNXqG1fkNhzOWXMVOks8p72OZBL/0leMQoRtJqxGC507nUjT6JIZxPbMBFkXKJYDpY
 LPC3REa0=
X-Gm-Gg: AZuq6aKMZXobHWlBMIw+Q4rGeEIoOpIvhqEAymetgXuOqJyEoKd5TtTb4ZY3X4o37W+
 Yu7bX77nJV58upH93hFHSG6pi43gnvXBuCHgjh1UkycpdH0fyq9TvNUyXZlZkGF1jOB8TuN/SLU
 h5OCrSFQ4taWCFayBECKStTuXfyMBgFtKssvvo3k5qCvoNOU2OLmCJididJL5Nchll+kh9aF881
 pTO0gIH6o4ZHfBENPO7k+/pm7gGO6bb+VAQMz5eyQBG61BW1PdkgaQecOkBi1Tm3qNWrLdX3hpP
 d31V21GDdEfSAw0K+vH6gzSvL61gF+GP4Jwv8HOHw+qRFjzAl+BiuRBVQ/mRvyZAoo5hp4GTmzt
 xi8JnJW7AQtWRvoo+No81ObFCXaclUmE/SQ2t0dLMTozLL0G8Izh6gfSx0f4PmQT6KDTtHE9LIg
 8G+HwK8XPuwp6xHGgsjxHXFKaG1QSh7qH98dNqph9AF3JRnuuHSD8PItFyLPeL
X-Received: by 2002:a05:600c:c16d:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-482db44d22dmr190088395e9.6.1770076000676; 
 Mon, 02 Feb 2026 15:46:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512e0edsm22108275e9.7.2026.02.02.15.46.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] target/alpha: Expand TCGv type for 64-bit target
Date: Tue,  3 Feb 2026 00:45:49 +0100
Message-ID: <20260202234550.34156-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

The Alpha targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha-*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Replace:

  TCGv -> TCGv_i64
  tcg_temp_new -> tcg_temp_new_i64

This is a mechanical replacement, adapting style to pass
the checkpatch.pl script.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 228 ++++++++++++++++++++-------------------
 1 file changed, 116 insertions(+), 112 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 48ac50a7cdf..4442462891e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -65,11 +65,11 @@ struct DisasContext {
     int tb_ftz;
 
     /* The set of registers active in the current context.  */
-    TCGv *ir;
+    TCGv_i64 *ir;
 
     /* Temporaries for $31 and $f31 as source and destination.  */
-    TCGv zero;
-    TCGv sink;
+    TCGv_i64 zero;
+    TCGv_i64 sink;
 };
 
 #ifdef CONFIG_USER_ONLY
@@ -86,21 +86,21 @@ struct DisasContext {
 #define DISAS_PC_STALE            DISAS_TARGET_2
 
 /* global register indexes */
-static TCGv cpu_std_ir[31];
-static TCGv cpu_fir[31];
-static TCGv cpu_pc;
-static TCGv cpu_lock_addr;
-static TCGv cpu_lock_value;
+static TCGv_i64 cpu_std_ir[31];
+static TCGv_i64 cpu_fir[31];
+static TCGv_i64 cpu_pc;
+static TCGv_i64 cpu_lock_addr;
+static TCGv_i64 cpu_lock_value;
 
 #ifndef CONFIG_USER_ONLY
-static TCGv cpu_pal_ir[31];
+static TCGv_i64 cpu_pal_ir[31];
 #endif
 
 void alpha_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
 
-    typedef struct { TCGv *var; const char *name; int ofs; } GlobalVar;
+    typedef struct { TCGv_i64 *var; const char *name; int ofs; } GlobalVar;
     static const GlobalVar vars[] = {
         DEF_VAR(pc),
         DEF_VAR(lock_addr),
@@ -160,7 +160,7 @@ void alpha_translate_init(void)
     }
 }
 
-static TCGv load_zero(DisasContext *ctx)
+static TCGv_i64 load_zero(DisasContext *ctx)
 {
     if (!ctx->zero) {
         ctx->zero = tcg_constant_i64(0);
@@ -168,10 +168,10 @@ static TCGv load_zero(DisasContext *ctx)
     return ctx->zero;
 }
 
-static TCGv dest_sink(DisasContext *ctx)
+static TCGv_i64 dest_sink(DisasContext *ctx)
 {
     if (!ctx->sink) {
-        ctx->sink = tcg_temp_new();
+        ctx->sink = tcg_temp_new_i64();
     }
     return ctx->sink;
 }
@@ -184,7 +184,7 @@ static void free_context_temps(DisasContext *ctx)
     }
 }
 
-static TCGv load_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (likely(reg < 31)) {
         return ctx->ir[reg];
@@ -193,7 +193,7 @@ static TCGv load_gpr(DisasContext *ctx, unsigned reg)
     }
 }
 
-static TCGv load_gpr_lit(DisasContext *ctx, unsigned reg,
+static TCGv_i64 load_gpr_lit(DisasContext *ctx, unsigned reg,
                          uint8_t lit, bool islit)
 {
     if (islit) {
@@ -205,7 +205,7 @@ static TCGv load_gpr_lit(DisasContext *ctx, unsigned reg,
     }
 }
 
-static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 dest_gpr(DisasContext *ctx, unsigned reg)
 {
     if (likely(reg < 31)) {
         return ctx->ir[reg];
@@ -214,7 +214,7 @@ static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
     }
 }
 
-static TCGv load_fpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 load_fpr(DisasContext *ctx, unsigned reg)
 {
     if (likely(reg < 31)) {
         return cpu_fir[reg];
@@ -223,7 +223,7 @@ static TCGv load_fpr(DisasContext *ctx, unsigned reg)
     }
 }
 
-static TCGv dest_fpr(DisasContext *ctx, unsigned reg)
+static TCGv_i64 dest_fpr(DisasContext *ctx, unsigned reg)
 {
     if (likely(reg < 31)) {
         return cpu_fir[reg];
@@ -243,17 +243,17 @@ static int get_flag_ofs(unsigned shift)
     return ofs;
 }
 
-static void ld_flag_byte(TCGv val, unsigned shift)
+static void ld_flag_byte(TCGv_i64 val, unsigned shift)
 {
     tcg_gen_ld8u_i64(val, tcg_env, get_flag_ofs(shift));
 }
 
-static void st_flag_byte(TCGv val, unsigned shift)
+static void st_flag_byte(TCGv_i64 val, unsigned shift)
 {
     tcg_gen_st8_i64(val, tcg_env, get_flag_ofs(shift));
 }
 
-static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
+static void gen_pc_disp(DisasContext *ctx, TCGv_i64 dest, int32_t disp)
 {
     uint64_t addr = ctx->base.pc_next + disp;
     if (ctx->pcrel) {
@@ -284,38 +284,38 @@ static inline DisasJumpType gen_invalid(DisasContext *ctx)
     return gen_excp(ctx, EXCP_OPCDEC, 0);
 }
 
-static void gen_ldf(DisasContext *ctx, TCGv dest, TCGv addr)
+static void gen_ldf(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
     gen_helper_memory_to_f(dest, tmp32);
 }
 
-static void gen_ldg(DisasContext *ctx, TCGv dest, TCGv addr)
+static void gen_ldg(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
-    TCGv tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
     gen_helper_memory_to_g(dest, tmp);
 }
 
-static void gen_lds(DisasContext *ctx, TCGv dest, TCGv addr)
+static void gen_lds(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
     gen_helper_memory_to_s(dest, tmp32);
 }
 
-static void gen_ldt(DisasContext *ctx, TCGv dest, TCGv addr)
+static void gen_ldt(DisasContext *ctx, TCGv_i64 dest, TCGv_i64 addr)
 {
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
 }
 
 static void gen_load_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
-                        void (*func)(DisasContext *, TCGv, TCGv))
+                        void (*func)(DisasContext *, TCGv_i64, TCGv_i64))
 {
     /* Loads to $f31 are prefetches, which we can treat as nops. */
     if (likely(ra != 31)) {
-        TCGv addr = tcg_temp_new();
+        TCGv_i64 addr = tcg_temp_new_i64();
         tcg_gen_addi_i64(addr, load_gpr(ctx, rb), disp16);
         func(ctx, cpu_fir[ra], addr);
     }
@@ -324,7 +324,7 @@ static void gen_load_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
 static void gen_load_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
                          MemOp op, bool clear, bool locked)
 {
-    TCGv addr, dest;
+    TCGv_i64 addr, dest;
 
     /* LDQ_U with ra $31 is UNOP.  Other various loads are forms of
        prefetches, which we can treat as nops.  No worries about
@@ -333,7 +333,7 @@ static void gen_load_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
         return;
     }
 
-    addr = tcg_temp_new();
+    addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(addr, load_gpr(ctx, rb), disp16);
     if (clear) {
         tcg_gen_andi_i64(addr, addr, ~0x7);
@@ -350,36 +350,36 @@ static void gen_load_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
     }
 }
 
-static void gen_stf(DisasContext *ctx, TCGv src, TCGv addr)
+static void gen_stf(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     gen_helper_f_to_memory(tmp32, addr);
     tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
 }
 
-static void gen_stg(DisasContext *ctx, TCGv src, TCGv addr)
+static void gen_stg(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
-    TCGv tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
     gen_helper_g_to_memory(tmp, src);
     tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
 }
 
-static void gen_sts(DisasContext *ctx, TCGv src, TCGv addr)
+static void gen_sts(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     TCGv_i32 tmp32 = tcg_temp_new_i32();
     gen_helper_s_to_memory(tmp32, src);
     tcg_gen_qemu_st_i32(tmp32, addr, ctx->mem_idx, MO_LEUL | UNALIGN(ctx));
 }
 
-static void gen_stt(DisasContext *ctx, TCGv src, TCGv addr)
+static void gen_stt(DisasContext *ctx, TCGv_i64 src, TCGv_i64 addr)
 {
     tcg_gen_qemu_st_i64(src, addr, ctx->mem_idx, MO_LEUQ | UNALIGN(ctx));
 }
 
 static void gen_store_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
-                         void (*func)(DisasContext *, TCGv, TCGv))
+                         void (*func)(DisasContext *, TCGv_i64, TCGv_i64))
 {
-    TCGv addr = tcg_temp_new();
+    TCGv_i64 addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(addr, load_gpr(ctx, rb), disp16);
     func(ctx, load_fpr(ctx, ra), addr);
 }
@@ -387,9 +387,9 @@ static void gen_store_fp(DisasContext *ctx, int ra, int rb, int32_t disp16,
 static void gen_store_int(DisasContext *ctx, int ra, int rb, int32_t disp16,
                           MemOp op, bool clear)
 {
-    TCGv addr, src;
+    TCGv_i64 addr, src;
 
-    addr = tcg_temp_new();
+    addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(addr, load_gpr(ctx, rb), disp16);
     if (clear) {
         tcg_gen_andi_i64(addr, addr, ~0x7);
@@ -406,7 +406,7 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
                                            MemOp op)
 {
     TCGLabel *lab_fail, *lab_done;
-    TCGv addr, val;
+    TCGv_i64 addr, val;
 
     addr = tcg_temp_new_i64();
     tcg_gen_addi_i64(addr, load_gpr(ctx, rb), disp16);
@@ -469,7 +469,8 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, uint64_t imm, int32_t disp)
+                                        TCGv_i64 cmp,
+                                        uint64_t imm, int32_t disp)
 {
     TCGLabel *lab_true = gen_new_label();
 
@@ -616,9 +617,9 @@ static void gen_qual_flushzero(DisasContext *ctx, int fn11)
 #endif
 }
 
-static TCGv gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
+static TCGv_i64 gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
 {
-    TCGv val;
+    TCGv_i64 val;
 
     if (unlikely(reg == 31)) {
         val = load_zero(ctx);
@@ -674,9 +675,9 @@ static void gen_fp_exc_raise(int rc, int fn11)
     }
 }
 
-static void gen_cvtlq(TCGv vc, TCGv vb)
+static void gen_cvtlq(TCGv_i64 vc, TCGv_i64 vb)
 {
-    TCGv tmp = tcg_temp_new();
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     /* The arithmetic right shift here, plus the sign-extended mask below
        yields a sign-extended result without an explicit ext32s_i64.  */
@@ -686,10 +687,10 @@ static void gen_cvtlq(TCGv vc, TCGv vb)
 }
 
 static void gen_ieee_arith2(DisasContext *ctx,
-                            void (*helper)(TCGv, TCGv_ptr, TCGv),
+                            void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64),
                             int rb, int rc, int fn11)
 {
-    TCGv vb;
+    TCGv_i64 vb;
 
     gen_qual_roundmode(ctx, fn11);
     gen_qual_flushzero(ctx, fn11);
@@ -713,7 +714,7 @@ IEEE_ARITH2(cvtts)
 
 static void gen_cvttq(DisasContext *ctx, int rb, int rc, int fn11)
 {
-    TCGv vb, vc;
+    TCGv_i64 vb, vc;
 
     /* No need to set flushzero, since we have an integer output.  */
     vb = gen_ieee_input(ctx, rb, fn11, 0);
@@ -731,10 +732,10 @@ static void gen_cvttq(DisasContext *ctx, int rb, int rc, int fn11)
 }
 
 static void gen_ieee_intcvt(DisasContext *ctx,
-                            void (*helper)(TCGv, TCGv_ptr, TCGv),
+                            void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64),
                             int rb, int rc, int fn11)
 {
-    TCGv vb, vc;
+    TCGv_i64 vb, vc;
 
     gen_qual_roundmode(ctx, fn11);
     vb = load_fpr(ctx, rb);
@@ -760,10 +761,11 @@ static inline void glue(gen_, name)(DisasContext *ctx,          \
 IEEE_INTCVT(cvtqs)
 IEEE_INTCVT(cvtqt)
 
-static void gen_cpy_mask(TCGv vc, TCGv va, TCGv vb, bool inv_a, uint64_t mask)
+static void gen_cpy_mask(TCGv_i64 vc, TCGv_i64 va, TCGv_i64 vb,
+                         bool inv_a, uint64_t mask)
 {
-    TCGv vmask = tcg_constant_i64(mask);
-    TCGv tmp = tcg_temp_new_i64();
+    TCGv_i64 vmask = tcg_constant_i64(mask);
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
     if (inv_a) {
         tcg_gen_andc_i64(tmp, vmask, va);
@@ -776,10 +778,11 @@ static void gen_cpy_mask(TCGv vc, TCGv va, TCGv vb, bool inv_a, uint64_t mask)
 }
 
 static void gen_ieee_arith3(DisasContext *ctx,
-                            void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv),
+                            void (*helper)(TCGv_i64, TCGv_ptr,
+                                           TCGv_i64, TCGv_i64),
                             int ra, int rb, int rc, int fn11)
 {
-    TCGv va, vb, vc;
+    TCGv_i64 va, vb, vc;
 
     gen_qual_roundmode(ctx, fn11);
     gen_qual_flushzero(ctx, fn11);
@@ -808,10 +811,11 @@ IEEE_ARITH3(mult)
 IEEE_ARITH3(divt)
 
 static void gen_ieee_compare(DisasContext *ctx,
-                             void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv),
+                             void (*helper)(TCGv_i64, TCGv_ptr,
+                                            TCGv_i64, TCGv_i64),
                              int ra, int rb, int rc, int fn11)
 {
-    TCGv va, vb, vc;
+    TCGv_i64 va, vb, vc;
 
     va = gen_ieee_input(ctx, ra, fn11, 1);
     vb = gen_ieee_input(ctx, rb, fn11, 1);
@@ -848,7 +852,7 @@ static inline uint64_t zapnot_mask(uint8_t lit)
 /* Implement zapnot with an immediate operand, which expands to some
    form of immediate AND.  This is a basic building block in the
    definition of many of the other byte manipulation instructions.  */
-static void gen_zapnoti(TCGv dest, TCGv src, uint8_t lit)
+static void gen_zapnoti(TCGv_i64 dest, TCGv_i64 src, uint8_t lit)
 {
     switch (lit) {
     case 0x00:
@@ -873,8 +877,8 @@ static void gen_zapnoti(TCGv dest, TCGv src, uint8_t lit)
 }
 
 /* EXTWH, EXTLH, EXTQH */
-static void gen_ext_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_ext_h(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         int pos = (64 - lit * 8) & 0x3f;
@@ -885,7 +889,7 @@ static void gen_ext_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
             tcg_gen_movi_i64(vc, 0);
         }
     } else {
-        TCGv tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_shli_i64(tmp, load_gpr(ctx, rb), 3);
         tcg_gen_neg_i64(tmp, tmp);
         tcg_gen_andi_i64(tmp, tmp, 0x3f);
@@ -895,8 +899,8 @@ static void gen_ext_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 }
 
 /* EXTBL, EXTWL, EXTLL, EXTQL */
-static void gen_ext_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_ext_l(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         int pos = (lit & 7) * 8;
@@ -906,7 +910,7 @@ static void gen_ext_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
         }
         tcg_gen_extract_i64(vc, va, pos, len);
     } else {
-        TCGv tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, load_gpr(ctx, rb), 7);
         tcg_gen_shli_i64(tmp, tmp, 3);
         tcg_gen_shr_i64(vc, va, tmp);
@@ -915,8 +919,8 @@ static void gen_ext_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 }
 
 /* INSWH, INSLH, INSQH */
-static void gen_ins_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_ins_h(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         int pos = 64 - (lit & 7) * 8;
@@ -927,8 +931,8 @@ static void gen_ins_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
             tcg_gen_movi_i64(vc, 0);
         }
     } else {
-        TCGv tmp = tcg_temp_new();
-        TCGv shift = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        TCGv_i64 shift = tcg_temp_new_i64();
 
         /* The instruction description has us left-shift the byte mask
            and extract bits <15:8> and apply that zap at the end.  This
@@ -951,8 +955,8 @@ static void gen_ins_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 }
 
 /* INSBL, INSWL, INSLL, INSQL */
-static void gen_ins_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_ins_l(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         int pos = (lit & 7) * 8;
@@ -962,8 +966,8 @@ static void gen_ins_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
         }
         tcg_gen_deposit_z_i64(vc, va, pos, len);
     } else {
-        TCGv tmp = tcg_temp_new();
-        TCGv shift = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        TCGv_i64 shift = tcg_temp_new_i64();
 
         /* The instruction description has us left-shift the byte mask
            and extract bits <15:8> and apply that zap at the end.  This
@@ -978,14 +982,14 @@ static void gen_ins_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 }
 
 /* MSKWH, MSKLH, MSKQH */
-static void gen_msk_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_msk_h(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         gen_zapnoti(vc, va, ~((byte_mask << (lit & 7)) >> 8));
     } else {
-        TCGv shift = tcg_temp_new();
-        TCGv mask = tcg_temp_new();
+        TCGv_i64 shift = tcg_temp_new_i64();
+        TCGv_i64 mask = tcg_temp_new_i64();
 
         /* The instruction description is as above, where the byte_mask
            is shifted left, and then we extract bits <15:8>.  This can be
@@ -1008,14 +1012,14 @@ static void gen_msk_h(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
 }
 
 /* MSKBL, MSKWL, MSKLL, MSKQL */
-static void gen_msk_l(DisasContext *ctx, TCGv vc, TCGv va, int rb, bool islit,
-                      uint8_t lit, uint8_t byte_mask)
+static void gen_msk_l(DisasContext *ctx, TCGv_i64 vc, TCGv_i64 va,
+                      int rb, bool islit, uint8_t lit, uint8_t byte_mask)
 {
     if (islit) {
         gen_zapnoti(vc, va, ~(byte_mask << (lit & 7)));
     } else {
-        TCGv shift = tcg_temp_new();
-        TCGv mask = tcg_temp_new();
+        TCGv_i64 shift = tcg_temp_new_i64();
+        TCGv_i64 mask = tcg_temp_new_i64();
 
         tcg_gen_andi_i64(shift, load_gpr(ctx, rb), 7);
         tcg_gen_shli_i64(shift, shift, 3);
@@ -1100,7 +1104,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 
             /* But make sure and store only the 3 IPL bits from the user.  */
             {
-                TCGv tmp = tcg_temp_new();
+                TCGv_i64 tmp = tcg_temp_new_i64();
                 tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
                 st_flag_byte(tmp, ENV_FLAG_PS_SHIFT);
             }
@@ -1151,7 +1155,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
     return gen_excp(ctx, EXCP_CALL_PAL, palcode);
 #else
     {
-        TCGv tmp = tcg_temp_new();
+        TCGv_i64 tmp = tcg_temp_new_i64();
 
         gen_pc_disp(ctx, tmp, 0);
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
@@ -1199,9 +1203,9 @@ static int cpu_pr_data(int pr)
     return 0;
 }
 
-static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
+static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv_i64 va, int regno)
 {
-    void (*helper)(TCGv);
+    void (*helper)(TCGv_i64);
     int data;
 
     switch (regno) {
@@ -1249,7 +1253,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
     return DISAS_NEXT;
 }
 
-static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
+static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv_i64 vb, int regno)
 {
     int data;
     DisasJumpType ret = DISAS_NEXT;
@@ -1361,7 +1365,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     uint16_t fn11;
     uint8_t opc, ra, rb, rc, fpfn, fn7, lit;
     bool islit, real_islit;
-    TCGv va, vb, vc, tmp, tmp2;
+    TCGv_i64 va, vb, vc, tmp, tmp2;
     TCGv_i32 t32;
     DisasJumpType ret;
 
@@ -1484,7 +1488,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x02:
             /* S4ADDL */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_add_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
@@ -1496,7 +1500,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x0B:
             /* S4SUBL */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_sub_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
@@ -1512,14 +1516,14 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x12:
             /* S8ADDL */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_add_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
             break;
         case 0x1B:
             /* S8SUBL */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_sub_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
@@ -1534,7 +1538,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x22:
             /* S4ADDQ */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_add_i64(vc, tmp, vb);
             break;
@@ -1544,7 +1548,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x2B:
             /* S4SUBQ */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_sub_i64(vc, tmp, vb);
             break;
@@ -1554,13 +1558,13 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x32:
             /* S8ADDQ */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_add_i64(vc, tmp, vb);
             break;
         case 0x3B:
             /* S8SUBQ */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_sub_i64(vc, tmp, vb);
             break;
@@ -1570,7 +1574,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x40:
             /* ADDL/V */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_add_i64(tmp, tmp, vc);
@@ -1579,7 +1583,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x49:
             /* SUBL/V */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_sub_i64(tmp, tmp, vc);
@@ -1592,8 +1596,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x60:
             /* ADDQ/V */
-            tmp = tcg_temp_new();
-            tmp2 = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
+            tmp2 = tcg_temp_new_i64();
             tcg_gen_eqv_i64(tmp, va, vb);
             tcg_gen_mov_i64(tmp2, va);
             tcg_gen_add_i64(vc, va, vb);
@@ -1605,8 +1609,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x69:
             /* SUBQ/V */
-            tmp = tcg_temp_new();
-            tmp2 = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
+            tmp2 = tcg_temp_new_i64();
             tcg_gen_xor_i64(tmp, va, vb);
             tcg_gen_mov_i64(tmp2, va);
             tcg_gen_sub_i64(vc, va, vb);
@@ -1798,7 +1802,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             if (islit) {
                 tcg_gen_shri_i64(vc, va, lit & 0x3f);
             } else {
-                tmp = tcg_temp_new();
+                tmp = tcg_temp_new_i64();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_shr_i64(vc, va, tmp);
@@ -1813,7 +1817,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             if (islit) {
                 tcg_gen_shli_i64(vc, va, lit & 0x3f);
             } else {
-                tmp = tcg_temp_new();
+                tmp = tcg_temp_new_i64();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_shl_i64(vc, va, tmp);
@@ -1828,7 +1832,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             if (islit) {
                 tcg_gen_sari_i64(vc, va, lit & 0x3f);
             } else {
-                tmp = tcg_temp_new();
+                tmp = tcg_temp_new_i64();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_sar_i64(vc, va, tmp);
@@ -1891,12 +1895,12 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x30:
             /* UMULH */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_mulu2_i64(tmp, vc, va, vb);
             break;
         case 0x40:
             /* MULL/V */
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_mul_i64(tmp, tmp, vc);
@@ -1905,8 +1909,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x60:
             /* MULQ/V */
-            tmp = tcg_temp_new();
-            tmp2 = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
+            tmp2 = tcg_temp_new_i64();
             tcg_gen_muls2_i64(vc, tmp, va, vb);
             tcg_gen_sari_i64(tmp2, vc, 63);
             gen_helper_check_overflow(tcg_env, tmp, tmp2);
@@ -2351,7 +2355,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
            prediction stack action, which of course we don't implement.  */
         vb = load_gpr(ctx, rb);
         if (ra != 31) {
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i64();
             tcg_gen_andi_i64(tmp, vb, ~3);
             gen_pc_disp(ctx, ctx->ir[ra], 0);
             tcg_gen_mov_i64(cpu_pc, tmp);
@@ -2366,7 +2370,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
-            TCGv addr = tcg_temp_new();
+            TCGv_i64 addr = tcg_temp_new_i64();
             vb = load_gpr(ctx, rb);
             va = dest_gpr(ctx, ra);
 
@@ -2615,7 +2619,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         }
         tcg_gen_movi_i64(cpu_lock_addr, -1);
         st_flag_byte(load_zero(ctx), ENV_FLAG_RX_SHIFT);
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i64();
         tcg_gen_andi_i64(tmp, vb, 1);
         st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
@@ -2636,7 +2640,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
                 /* Longword physical access */
                 va = load_gpr(ctx, ra);
                 vb = load_gpr(ctx, rb);
-                tmp = tcg_temp_new();
+                tmp = tcg_temp_new_i64();
                 tcg_gen_addi_i64(tmp, vb, disp12);
                 tcg_gen_qemu_st_i64(va, tmp, MMU_PHYS_IDX, MO_LESL | MO_ALIGN);
                 break;
@@ -2644,7 +2648,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
                 /* Quadword physical access */
                 va = load_gpr(ctx, ra);
                 vb = load_gpr(ctx, rb);
-                tmp = tcg_temp_new();
+                tmp = tcg_temp_new_i64();
                 tcg_gen_addi_i64(tmp, vb, disp12);
                 tcg_gen_qemu_st_i64(va, tmp, MMU_PHYS_IDX, MO_LEUQ | MO_ALIGN);
                 break;
-- 
2.52.0


