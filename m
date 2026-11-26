Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADD606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=khaoCYug;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=Yy7wiewc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgNh-0000xc-Hu; Thu, 26 Nov 2026 15:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNf-0000wT-Ub
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:47 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNc-00066Y-Iy
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Yx6IQTe
 eotRaK4ikWy4MfDVwY7SinNFObqUWK58Z7Fw9Wvk25xvkjIJ34SNDzp7OA23B2iA8elS0t
 W0+/Ah2rpPQg0ZqaE0qz3U6BgawkTXklqTq+T7DJ08ZtUThOj9f3Cg8EaD5nJR0GfQwRfB
 +jCQTBimUzgkvBt+RUQy/9QsW6E1rrSW8oN6qrMbpHmpnGQL5yfctXHw0xMu9AHGDnOsZV
 H+gjKhrpxYqNg4dgoSbGtSB/juWJRF+/9YBtrkA9wxkf0CchOfbTq0LXDpA8q/0VOGahbX
 2CQdNwE2T7KmtRLkxbg0UpTO4ENBVL9CuIg1POCnE7lCqauJc9mpgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=t
 qHKdggepmmZrJE0AVlW5WOYWsdKBJQmRifm+0lrdj8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=v+MQpWXXUWVTswQdXwJid4rxdfB6GIDJfbe35QxFjTmb4mOxWWwCMYUFSa7ZiKIITFsF
 EmVGICPEsGWTKtRzKr0tKFWZ5Q/TpLLul7SZHODvCbrWVl34UKMDKE0cC7PQ8VrnunhtAe
 7qqweAMDeXJeoary7i2XydC3FPhbTtgsyZS2f5Qq7Ec8xQpRfy3Rnf4XIGneZm24o+Bmxc
 s7p7m02K1MGc0oQnklgQI6DwdFy/r/BtMTWH5HbwmvE5y4SUlUJCtsOLv0H7+E0hZFocbo
 pjWyUyXC3S74gI2OkQDkz0+0HmOjg31+3Y81rZv9qy1ipvy8zzQttRmh6DdFjZVQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=khaoCYug; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Yy7wiewc;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=tqHKdgge
 pmmZrJE0AVlW5WOYWsdKBJQmRifm+0lrdj8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=khaoCYugWghREcIoNOqZ3MC8hIW0os1wS52
 iPl0zs1LjxEsfjC3v83dKFJaAO9zW5NPzhG88cvAAz0/xNr3+wOBGhUjx5OvmZ5nuvODfb
 fcXUTiubqXdgaw+f8qyLFW8KCcoMCrfF1Cs5r1NVg0UrpXaK9DvP4ItAhJRlp/gDBKPUBm
 UOui9BQTieA1LBSBJjM9SNwvL8y1FdApOV7YM1FW0/PQF2v2RXjO66m5AkTMI+OAAA1Wqi
 ywEZbCdwlKrCV8GBoIJyZblRy5isuvbIlDVnCHpN5S7TcSITTUva7fmgZ5JjQb64WBJ8Pi
 IAeyHF0DbXoYuHJEpveSfyW4vqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=tqHKdggepmmZrJE0AVlW5WOYWsdKBJQmRifm+0lrdj8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=Yy7wiewcIvz35lBfyH
 dFB52ev+dyIdjEN3+60A9dxr+a+TXmO3zl1MshTF5wD6i/04v2NvjU9jy1R0qy7/NwCQ==
Received: by mx1.catap.net (OpenSMTPD) id e5e3ad77;
 Thu, 26 Nov 2026 21:47:39 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 5ade4d50;
 Thu, 26 Nov 2026 21:47:36 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH 3/3] target/hppa: Defer PA7300LC multiply assists
Date: Thu, 26 Nov 2026 21:39:22 +0100
Message-ID: <20261126204733.9423-4-kirill@korins.ky>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126204733.9423-1-kirill@korins.ky>
References: <20261126204733.9423-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

With FPSR.D clear, PA7300LC defers FMPY, FMPYADD and FMPYSUB for
certain denormal operands or a result that is tiny after rounding,
including exact results that leave IEEE underflow clear. Detect
tininess through SoftFloat's output flush flag on a scratch status.

Evaluate both components of FMPYADD and FMPYSUB from the original
operands. If either requires an assist, record the instruction in
ER2 and set FPSR.T, preserving both destinations and the FPSR
exception flags.

OpenBSD/hppa's trig_test-3 takes its expected failure path when
tanf encounters the assist, and the full msun regression passes
with the original Makefile.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/hppa/fpu_helper.c    | 116 +++++++++++++++++++++++++++++++++++-
 target/hppa/helper.h        |   6 ++
 target/hppa/translate.c     |  39 ++++++++++++
 tests/qtest/hppa-fpu-test.c | 104 ++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 82ad6da34d..1255b4999c 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -240,7 +240,25 @@ float64 HELPER(frem_d)(CPUHPPAState *env, float64 a, float64 b)
 #ifndef CONFIG_USER_ONLY
 static void defer_fp_unimplemented(CPUHPPAState *env, uint32_t insn)
 {
-    uint32_t code = (insn >> 26) == 0x0c ? 0x09 : 0x0b;
+    uint32_t code;
+
+    switch (insn >> 26) {
+    case 0x06:
+        code = 0x03;
+        break;
+    case 0x26:
+        code = 0x23;
+        break;
+    case 0x0c:
+        code = 0x09;
+        break;
+    case 0x0e:
+        code = 0x0b;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
     uint32_t record = deposit32(insn, 26, 6, code);
 
     /* PA7300LC records the original operation in exception register 2. */
@@ -248,6 +266,102 @@ static void defer_fp_unimplemented(CPUHPPAState *env, uint32_t insn)
     env->fr0_shadow |= R_FPSR_T_MASK;
     env->fr[0] = deposit64(env->fr[0], 32, 32, env->fr0_shadow);
 }
+
+static float_status pa1_multiply_status(CPUHPPAState *env)
+{
+    float_status status = env->fp_status;
+
+    if (!(env->fr0_shadow & R_FPSR_D_MASK)) {
+        /* Identify tiny results even when IEEE underflow is not raised. */
+        set_flush_to_zero(true, &status);
+        set_float_ftz_detection(float_ftz_after_rounding, &status);
+    }
+    return status;
+}
+
+static bool pa1_multiply_needs_assist(CPUHPPAState *env,
+                                    const float_status *status, bool single,
+                                    bool multiply, uint64_t a, uint64_t b)
+{
+    if (env->fr0_shadow & R_FPSR_D_MASK) {
+        return false;
+    }
+    if (get_float_exception_flags(status) & float_flag_output_denormal_flushed) {
+        return true;
+    }
+
+    uint64_t sign_mask = single ? INT32_MAX : INT64_MAX;
+    uint64_t min_normal = single ? 0x00800000 : 0x0010000000000000ULL;
+    uint64_t infinity = single ? 0x7f800000 : 0x7ff0000000000000ULL;
+
+    a &= sign_mask;
+    b &= sign_mask;
+    return (a != 0 && a < min_normal && b != infinity &&
+            (!multiply || b != 0)) ||
+           (b != 0 && b < min_normal && a != infinity &&
+            (!multiply || a != 0));
+}
+
+static void pa1_multiply_write_result(CPUHPPAState *env, uint32_t reg,
+                                      bool single, uint64_t result,
+                                      const float_status *status, uintptr_t ra)
+{
+    set_float_exception_flags(get_float_exception_flags(status),
+                              &env->fp_status);
+    update_fr0_op(env, ra);
+    if (single) {
+        unsigned shift = reg & 32 ? 0 : 32;
+
+        reg &= 31;
+        env->fr[reg] = deposit64(env->fr[reg], shift, 32, result);
+    } else {
+        env->fr[reg] = result;
+    }
+}
+
+void HELPER(fmpy_pa1)(CPUHPPAState *env, uint64_t a, uint64_t b,
+                      uint32_t reg, uint32_t insn)
+{
+    bool single = !extract32(insn, 11, 1);
+    float_status status = pa1_multiply_status(env);
+    uint64_t product = single ? float32_mul(a, b, &status)
+                              : float64_mul(a, b, &status);
+
+    if (pa1_multiply_needs_assist(env, &status, single, true, a, b)) {
+        defer_fp_unimplemented(env, insn);
+        return;
+    }
+    pa1_multiply_write_result(env, reg, single, product, &status, GETPC());
+}
+
+void HELPER(fmpyadd_pa1)(CPUHPPAState *env, uint64_t m1, uint64_t m2,
+                        uint64_t a1, uint64_t a2, uint32_t regs, uint32_t insn)
+{
+    bool single = extract32(insn, 5, 1);
+    bool subtract = (insn >> 26) == 0x26;
+    float_status multiply_status = pa1_multiply_status(env);
+    float_status add_status = multiply_status;
+    uint64_t product, sum;
+
+    if (single) {
+        product = float32_mul(m1, m2, &multiply_status);
+        sum = subtract ? float32_sub(a1, a2, &add_status)
+                       : float32_add(a1, a2, &add_status);
+    } else {
+        product = float64_mul(m1, m2, &multiply_status);
+        sum = subtract ? float64_sub(a1, a2, &add_status)
+                       : float64_add(a1, a2, &add_status);
+    }
+
+    if (pa1_multiply_needs_assist(env, &multiply_status, single, true, m1, m2) ||
+        pa1_multiply_needs_assist(env, &add_status, single, false, a1, a2)) {
+        defer_fp_unimplemented(env, insn);
+        return;
+    }
+    pa1_multiply_write_result(env, regs & 63, single, product,
+                              &multiply_status, GETPC());
+    pa1_multiply_write_result(env, regs >> 6, single, sum, &add_status, GETPC());
+}
 #endif
 
 void HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg, uint32_t reg, uint32_t insn)
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 84937ee73f..a1d1dfffd8 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -24,6 +24,12 @@ DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
 
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_FLAGS_5(fmpy_pa1, TCG_CALL_NO_RWG, void, env, i64, i64, i32, i32)
+DEF_HELPER_FLAGS_7(fmpyadd_pa1, TCG_CALL_NO_RWG, void, env, i64, i64, i64, i64,
+                   i32, i32)
+#endif
+
 DEF_HELPER_FLAGS_2(fsqrt_s, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_2(frnd_s, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 67670768d1..c8e2b13c8c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4519,11 +4519,27 @@ static bool trans_fsub_d(DisasContext *ctx, arg_fclass3 *a)
 
 static bool trans_fmpy_f(DisasContext *ctx, arg_fclass3 *a)
 {
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->is_pa20) {
+        fp_nullify_over(ctx);
+        gen_helper_fmpy_pa1(tcg_env, load_frw0_i64(a->r1), load_frw0_i64(a->r2),
+                            tcg_constant_i32(a->t), tcg_constant_i32(ctx->insn));
+        return nullify_end(ctx);
+    }
+#endif
     return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_fmpy_s);
 }
 
 static bool trans_fmpy_d(DisasContext *ctx, arg_fclass3 *a)
 {
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->is_pa20) {
+        fp_nullify_over(ctx);
+        gen_helper_fmpy_pa1(tcg_env, load_frd0(a->r1), load_frd0(a->r2),
+                            tcg_constant_i32(a->t), tcg_constant_i32(ctx->insn));
+        return nullify_end(ctx);
+    }
+#endif
     return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fmpy_d);
 }
 
@@ -4575,6 +4591,18 @@ static bool do_fmpyadd_s(DisasContext *ctx, arg_mpyadd *a, bool is_sub)
     int rm2 = fmpyadd_s_reg(a->rm2);
     int rm1 = fmpyadd_s_reg(a->rm1);
 
+#ifndef CONFIG_USER_ONLY
+    /* A zero addend field in FMPYADD encodes FMPYCFXT on PA7300LC. */
+    if (!ctx->is_pa20 && (is_sub || a->ra != 0)) {
+        fp_nullify_over(ctx);
+        gen_helper_fmpyadd_pa1(tcg_env,
+                              load_frw0_i64(rm1), load_frw0_i64(rm2),
+                              load_frw0_i64(ta), load_frw0_i64(ra),
+                              tcg_constant_i32((ta << 6) | tm),
+                              tcg_constant_i32(ctx->insn));
+        return nullify_end(ctx);
+    }
+#endif
     nullify_over(ctx);
 
     do_fop_weww(ctx, tm, rm1, rm2, gen_helper_fmpy_s);
@@ -4596,6 +4624,17 @@ static bool trans_fmpysub_f(DisasContext *ctx, arg_mpyadd *a)
 
 static bool do_fmpyadd_d(DisasContext *ctx, arg_mpyadd *a, bool is_sub)
 {
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->is_pa20 && (is_sub || a->ra != 0)) {
+        fp_nullify_over(ctx);
+        gen_helper_fmpyadd_pa1(tcg_env,
+                              load_frd0(a->rm1), load_frd0(a->rm2),
+                              load_frd0(a->ta), load_frd0(a->ra),
+                              tcg_constant_i32((a->ta << 6) | a->tm),
+                              tcg_constant_i32(ctx->insn));
+        return nullify_end(ctx);
+    }
+#endif
     nullify_over(ctx);
 
     do_fop_dedd(ctx, a->tm, a->rm1, a->rm2, gen_helper_fmpy_d);
diff --git a/tests/qtest/hppa-fpu-test.c b/tests/qtest/hppa-fpu-test.c
index f49d834e31..7ab28efc8a 100644
--- a/tests/qtest/hppa-fpu-test.c
+++ b/tests/qtest/hppa-fpu-test.c
@@ -510,6 +510,104 @@ static void test_fcnv(const void *opaque)
     qtest_quit(qts);
 }
 
+typedef struct FmpyAssistTest {
+    const char *name;
+    uint32_t instruction;
+    uint32_t er2;
+    uint64_t fr22;
+    uint64_t fr23;
+} FmpyAssistTest;
+
+static const FmpyAssistTest fmpy_assist_tests[] = {
+    {
+        .name = "scalar-tiny",
+        .instruction = 0x33374617, /* fmpy,sgl fr25,fr23,fr23 */
+        .er2 = 0x27374617,
+        .fr22 = 0xb79bae5f8cad057cULL,
+        .fr23 = 0x37d95384fd6b8987ULL,
+    },
+    {
+        .name = "compound-trace",
+        .instruction = 0x19263a26, /* fmpyadd,sgl fr25,fr22,fr22,fr24,fr23 */
+        .er2 = 0x0d263a26,
+        .fr22 = 0xb79bae5f8cad057cULL,
+        .fr23 = 0x004a1020fd6b8987ULL,
+    },
+    {
+        .name = "compound-tiny",
+        .instruction = 0x19263a26,
+        .er2 = 0x0d263a26,
+        .fr22 = 0x380000008cad057cULL, /* Exact subnormal product. */
+        .fr23 = 0x37d95384fd6b8987ULL,
+    },
+    {
+        .name = "double-scalar-tiny",
+        .instruction = 0x33374e17, /* fmpy,dbl fr25,fr23,fr23 */
+        .er2 = 0x27374e17,
+        .fr22 = 0xb79bae5f8cad057cULL,
+        .fr23 = 0x3850000000000000ULL, /* 2^-122. */
+    },
+    {
+        .name = "compound-subtract-tiny",
+        .instruction = 0x99263a26, /* fmpysub,sgl fr25,fr22,fr22,fr24,fr23 */
+        .er2 = 0x8d263a26,
+        .fr22 = 0x380000008cad057cULL,
+        .fr23 = 0x37d95384fd6b8987ULL,
+    },
+    {
+        .name = "compound-denormal",
+        .instruction = 0x19263a26,
+        .er2 = 0x0d263a26,
+        .fr22 = 0x3f8000008cad057cULL, /* Multiply by 1.0f. */
+        .fr23 = 0x004a1020fd6b8987ULL,
+    },
+};
+
+static void test_fmpy_assist(const void *opaque)
+{
+    const FmpyAssistTest *test = opaque;
+    const uint32_t guest[] = {
+        0x34011000, /* ldi 0x800,r1 */
+        0x01c11840, /* mtctl r1,iva */
+        0x34103000, /* ldi 0x1800,r16 */
+        0x34113200, /* ldi 0x1900,r17 */
+        0x34010180, /* ldi 0xc0,r1 */
+        0x01411840, /* mtctl r1,ccr */
+        0x2e001016, /* fldd 0(r16),fr22 */
+        0x2e101017, /* fldd 8(r16),fr23 */
+        0x36100020, /* ldo 16(r16),r16 */
+        0x2e001018, /* fldd 0(r16),fr24 */
+        0x2e101019, /* fldd 8(r16),fr25 */
+        test->instruction,
+        0x2e001200, /* fstd fr0,0(r16) */
+        0x2e101201, /* fstd fr1,8(r16) */
+        0x36100020, /* ldo 16(r16),r16 */
+        0x2e001200, /* fstd fr0,0(r16) */
+        0x2e101216, /* fstd fr22,8(r16) */
+        0x36100020, /* ldo 16(r16),r16 */
+        0x2e001217, /* fstd fr23,0(r16) */
+        0x34010002, /* ldi 1,r1 */
+        0x6a210000, /* stw r1,0(r17): completion */
+    };
+    QTestState *qts = start_guest(false);
+    uint32_t end = CODE + sizeof(guest);
+
+    write_words(qts, CODE, guest, G_N_ELEMENTS(guest));
+    qtest_writel(qts, end, branch(end, HALT));
+    qtest_writeq(qts, DATA, test->fr22);
+    qtest_writeq(qts, DATA + 8, test->fr23);
+    qtest_writeq(qts, DATA + 16, 0x3895c07a1110fe7aULL);
+    qtest_writeq(qts, DATA + 24, 0x07ae7c429facdab0ULL);
+
+    run_guest(qts, 1);
+    g_assert_cmphex(qtest_readq(qts, DATA + 16), ==, 0x0000004000000000ULL);
+    g_assert_cmphex(qtest_readl(qts, DATA + 24), ==, test->er2);
+    g_assert_cmphex(qtest_readq(qts, DATA + 32), ==, 0);
+    g_assert_cmphex(qtest_readq(qts, DATA + 40), ==, test->fr22);
+    g_assert_cmphex(qtest_readq(qts, DATA + 48), ==, test->fr23);
+    qtest_quit(qts);
+}
+
 static const uint32_t fault_guest[] = {
     0x34011000, /* ldi 0x800,r1 */
     0x01c11840, /* mtctl r1,iva */
@@ -586,6 +684,12 @@ int main(int argc, char **argv)
 
         qtest_add_data_func(name, &fcnv_tests[i], test_fcnv);
     }
+    for (size_t i = 0; i < G_N_ELEMENTS(fmpy_assist_tests); i++) {
+        g_autofree char *name = g_strdup_printf("fpu/fmpy-assist/%s",
+                                                fmpy_assist_tests[i].name);
+
+        qtest_add_data_func(name, &fmpy_assist_tests[i], test_fmpy_assist);
+    }
     for (size_t i = 0; i < G_N_ELEMENTS(fault_tests); i++) {
         g_autofree char *name = g_strdup_printf("fpu/%s", fault_tests[i].name);
 
-- 
2.56.1


