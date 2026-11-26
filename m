Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13280606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=zNBOEa8E;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=gceer0M9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgNf-0000w9-FP; Thu, 26 Nov 2026 15:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNe-0000vZ-09
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:46 -0500
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNb-0006Hw-KT
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=lxB1N0x
 9ZBHt+NR+lATDwVwrDzarQIrU4mtO+lZPoCdgTa4yuANGS5JTpSRk45Rb0ibjw0W3vqht9
 u0OQyWcrjpsmzzu+a3JYvlijGtG3PRz0R9kFm59HyIISqTeUlRvTHfZmalG2bEKm67Pdqa
 L+ocBctN/Q7W5TiMGXyeTsuNT4sXcJRBUt06AOSHqiPCBwrKS18I34EMscRPoMxu/RE/An
 58h70eP+KPiPzklTaHvQ5BXc4IJWZ/ko82qb4HAFMKXFQwXKhUelcZ/mOMq8ehm9i+5QMB
 C+N+IQ72JEpquG6nI/fzz+k7P8TGdUmHAei7pTH4GpqCmTkgIKOsk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=f
 TZj8KzVqBRt5yab9n31u+3o2YGWKyai2HO8h+keKJ0=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Y/nC0cpPCDWSEpPuv37j7xhTVoyOgEP3CoO4dTT6KD+oMxLj+kwRFobkQcMRQ7VihprZ
 pfbXeMtYtWPTRqSvwg6TGJGvXvxlQHVf6wWaQf7fb4zfwpAiyLRyUApYkIgsDqn5oM5AL8
 lfuJXwuhU5ONTPO5qwG3zn5DnKBnvLSJtGwu2JctLCJUW0RAgZ0nalb34embR/e/h7X5Sf
 +dAmvjl4GO06TwMWoSG+dkI/HmFAZlI6aPWsHa8azgz/AJHCeSa8HaSfo4XqlxNtvV7NuU
 FQN/dc8I/hPysdsjr44VMO9jDPxOMzLP2NiyeTgxG9XY+Dt4d8WKd61EqDdHA8GQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=zNBOEa8E; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=gceer0M9;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=fTZj8KzV
 qBRt5yab9n31u+3o2YGWKyai2HO8h+keKJ0=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=zNBOEa8ESqq2DlrsQxAY8NHm3LtC1k02/PD
 qsQ+SCyInyOfkXGQytJONU6Zry2Xl9up2+56r6RpBojv0KubecRMLI3tmUvVLFw9tBjCxz
 JWaYCwQhApK+Pnd/bBkS84RYTkad1/G5wHtnec4oDedlvUz31k+MWSine0GI5SduZM9YL7
 QhPxSIAmdChKI9uwtT5Mlz2QbvZSfBSATd91+Z3xDnA8RcSVBfYcHFnNOohP944GxipzEp
 OVgiUNiyZrx179RkIJDbaJ2TlBtcB6i2nPqk339B2HKBQhyzD1bwNN74CPsP3jvms2gj8J
 d/ES2hgo1tMh4XF0I8ni34Sm8KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=fTZj8KzVqBRt5yab9n31u+3o2YGWKyai2HO8h+keKJ0=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=gceer0M9g6fhT7TCls
 o7UKsoYB2m4qHu7ffVJ2lINWLkB8dtvhiGFUvbNyb+3qnGCYbp9pwZCKaHLZeqx0MlCw==
Received: by mx1.catap.net (OpenSMTPD) id 9f5b88fd;
 Thu, 26 Nov 2026 21:47:38 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 980267ce;
 Thu, 26 Nov 2026 21:47:36 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH 1/3] target/hppa: Emulate FREM
Date: Thu, 26 Nov 2026 21:39:20 +0100
Message-ID: <20261126204733.9423-2-kirill@korins.ky>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126204733.9423-1-kirill@korins.ky>
References: <20261126204733.9423-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
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

OpenBSD/hppa's libm remainder tests terminate with SIGILL on FREM
because QEMU's HPPA decoder omits class 3 subopcode 4 under both
major opcodes, 0x0c and 0x0e, sending both encodings through
gen_illegal() to raise EXCP_ILL when the FPU is enabled.

Decode both encodings and compute IEEE remainder in single and
double precision with SoftFloat, with qtest coverage for exact
result bits at quotient ties under directed rounding and for the
FPSR invalid operation flag on zero divisors and infinite dividends.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/hppa/fpu_helper.c    |  14 +++++
 target/hppa/helper.h        |   2 +
 target/hppa/insns.decode    |   4 ++
 target/hppa/translate.c     |  10 ++++
 tests/qtest/hppa-fpu-test.c | 105 +++++++++++++++++++++++++++++++++++-
 5 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index a0c8c91ee5..f42044cdef 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -177,6 +177,13 @@ float32 HELPER(fdiv_s)(CPUHPPAState *env, float32 a, float32 b)
     return ret;
 }
 
+float32 HELPER(frem_s)(CPUHPPAState *env, float32 a, float32 b)
+{
+    float32 ret = float32_rem(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
 float64 HELPER(fsqrt_d)(CPUHPPAState *env, float64 arg)
 {
     float64 ret = float64_sqrt(arg, &env->fp_status);
@@ -219,6 +226,13 @@ float64 HELPER(fdiv_d)(CPUHPPAState *env, float64 a, float64 b)
     return ret;
 }
 
+float64 HELPER(frem_d)(CPUHPPAState *env, float64 a, float64 b)
+{
+    float64 ret = float64_rem(a, b, &env->fp_status);
+    update_fr0_op(env, GETPC());
+    return ret;
+}
+
 float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
 {
     float64 ret = float32_to_float64(arg, &env->fp_status);
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index f6c7e16f0f..b99e298ee8 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -30,6 +30,7 @@ DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsub_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmpy_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdiv_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(frem_s, TCG_CALL_NO_RWG, f32, env, f32, f32)
 
 DEF_HELPER_FLAGS_2(fsqrt_d, TCG_CALL_NO_RWG, f64, env, f64)
 DEF_HELPER_FLAGS_2(frnd_d, TCG_CALL_NO_RWG, f64, env, f64)
@@ -37,6 +38,7 @@ DEF_HELPER_FLAGS_3(fadd_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsub_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmpy_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(frem_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fcnv_s_d, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fcnv_d_s, TCG_CALL_NO_RWG, f32, env, f64)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 135f563c88..ebc290d830 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -620,21 +620,25 @@ fadd_f          001100 ..... ..... 000 00 ...... .....  @f0c_3
 fsub_f          001100 ..... ..... 001 00 ...... .....  @f0c_3
 fmpy_f          001100 ..... ..... 010 00 ...... .....  @f0c_3
 fdiv_f          001100 ..... ..... 011 00 ...... .....  @f0c_3
+frem_f          001100 ..... ..... 100 00 ...... .....  @f0c_3
 
 fadd_d          001100 ..... ..... 000 01 ...... .....  @f0c_3
 fsub_d          001100 ..... ..... 001 01 ...... .....  @f0c_3
 fmpy_d          001100 ..... ..... 010 01 ...... .....  @f0c_3
 fdiv_d          001100 ..... ..... 011 01 ...... .....  @f0c_3
+frem_d          001100 ..... ..... 100 01 ...... .....  @f0c_3
 
 fadd_f          001110 ..... ..... 000 ..... ... .....  @f0e_f_3
 fsub_f          001110 ..... ..... 001 ..... ... .....  @f0e_f_3
 fmpy_f          001110 ..... ..... 010 ..... ... .....  @f0e_f_3
 fdiv_f          001110 ..... ..... 011 ..... ... .....  @f0e_f_3
+frem_f          001110 ..... ..... 100 ..... ... .....  @f0e_f_3
 
 fadd_d          001110 ..... ..... 000 ..... ... .....  @f0e_d_3
 fsub_d          001110 ..... ..... 001 ..... ... .....  @f0e_d_3
 fmpy_d          001110 ..... ..... 010 ..... ... .....  @f0e_d_3
 fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
+frem_d          001110 ..... ..... 100 ..... ... .....  @f0e_d_3
 
 xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ab3505f9c9..0713112063 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4498,6 +4498,16 @@ static bool trans_fdiv_d(DisasContext *ctx, arg_fclass3 *a)
     return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_fdiv_d);
 }
 
+static bool trans_frem_f(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_weww(ctx, a->t, a->r1, a->r2, gen_helper_frem_s);
+}
+
+static bool trans_frem_d(DisasContext *ctx, arg_fclass3 *a)
+{
+    return do_fop_dedd(ctx, a->t, a->r1, a->r2, gen_helper_frem_d);
+}
+
 static bool trans_xmpyu(DisasContext *ctx, arg_xmpyu *a)
 {
     TCGv_i64 x, y;
diff --git a/tests/qtest/hppa-fpu-test.c b/tests/qtest/hppa-fpu-test.c
index af4ff2a162..40e097dbbe 100644
--- a/tests/qtest/hppa-fpu-test.c
+++ b/tests/qtest/hppa-fpu-test.c
@@ -1,5 +1,5 @@
 /*
- * HPPA CCR floating-point enable and lazy context switching tests.
+ * HPPA floating-point instruction and context switching tests.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -296,6 +296,104 @@ static void test_lazy(void)
     qtest_quit(qts);
 }
 
+typedef struct FremTest {
+    const char *name;
+    uint32_t instruction;
+    uint64_t dividend;
+    uint64_t divisor;
+    uint64_t result;
+    uint32_t fpsr;
+    uint32_t flags;
+} FremTest;
+
+static const FremTest frem_tests[] = {
+    {
+        .name = "single-tie",
+        .instruction = 0x318d860e, /* frem,sgl fr12,fr13,fr14 */
+        .dividend = 0x40e0000000000000ULL, /* 7.0f */
+        .divisor = 0x4000000000000000ULL, /* 2.0f */
+        .result = 0xbf80000089abcdefULL, /* -1.0f */
+        .fpsr = 0x200, /* round toward zero */
+    },
+    {
+        .name = "double-tie",
+        .instruction = 0x318d8e0e, /* frem,dbl fr12,fr13,fr14 */
+        .dividend = 0x4014000000000000ULL, /* 5.0 */
+        .divisor = 0x4000000000000000ULL, /* 2.0 */
+        .result = 0x3ff0000000000000ULL, /* 1.0 */
+        .fpsr = 0x400, /* round upward */
+    },
+    {
+        .name = "single-extended-subnormal",
+        .instruction = 0x398d96ce, /* frem,sgl fr12R,fr13R,fr14R */
+        .dividend = 0x0000000000000001ULL, /* smallest subnormal */
+        .divisor = 0x000000003f800000ULL, /* 1.0f */
+        .result = 0x0123456700000001ULL,
+        .fpsr = 0x600, /* round downward */
+    },
+    {
+        .name = "double-extended-negative-zero",
+        .instruction = 0x398d8e0e, /* frem,dbl fr12,fr13,fr14 */
+        .dividend = 0xc010000000000000ULL, /* -4.0 */
+        .divisor = 0x4000000000000000ULL, /* 2.0 */
+        .result = 0x8000000000000000ULL, /* -0.0 */
+    },
+    {
+        .name = "single-zero-divisor",
+        .instruction = 0x318d860e,
+        .dividend = 0x3f80000000000000ULL, /* 1.0f */
+        .divisor = 0,
+        .result = 0x7fa0000089abcdefULL, /* quiet NaN */
+        .flags = 0x80000000, /* invalid operation */
+    },
+    {
+        .name = "double-infinite-dividend",
+        .instruction = 0x398d8e0e,
+        .dividend = 0x7ff0000000000000ULL, /* infinity */
+        .divisor = 0x3ff0000000000000ULL, /* 1.0 */
+        .result = 0x7ff4000000000000ULL, /* quiet NaN */
+        .flags = 0x80000000, /* invalid operation */
+    },
+};
+
+static void test_frem(const void *opaque)
+{
+    const FremTest *test = opaque;
+    const uint32_t guest[] = {
+        0x34011000, /* ldi 0x800,r1 */
+        0x01c11840, /* mtctl r1,iva */
+        0x34103000, /* ldi 0x1800,r16 */
+        0x34113200, /* ldi 0x1900,r17 */
+        0x34010180, /* ldi 0xc0,r1 */
+        0x01411840, /* mtctl r1,ccr */
+        0x2e00100c, /* fldd 0(r16),fr12 */
+        0x2e10100d, /* fldd 8(r16),fr13 */
+        0x36100020, /* ldo 16(r16),r16 */
+        0x2e001000, /* fldd 0(r16),fr0 */
+        0x2e10100e, /* fldd 8(r16),fr14 */
+        test->instruction,
+        0x2e10120e, /* fstd fr14,8(r16) */
+        0x2e001200, /* fstd fr0,0(r16) */
+        0x34010002, /* ldi 1,r1 */
+        0x6a210000, /* stw r1,0(r17): completion */
+    };
+    QTestState *qts = start_guest(false);
+    uint32_t end = CODE + sizeof(guest);
+
+    write_words(qts, CODE, guest, G_N_ELEMENTS(guest));
+    qtest_writel(qts, end, branch(end, HALT));
+    qtest_writeq(qts, DATA, test->dividend);
+    qtest_writeq(qts, DATA + 8, test->divisor);
+    qtest_writeq(qts, DATA + 16, (uint64_t)test->fpsr << 32);
+    /* A single-precision write must preserve the other half of FR14. */
+    qtest_writeq(qts, DATA + 24, 0x0123456789abcdefULL);
+
+    run_guest(qts, 1);
+    g_assert_cmphex(qtest_readq(qts, DATA + 24), ==, test->result);
+    g_assert_cmphex(qtest_readl(qts, DATA + 16), ==, test->fpsr | test->flags);
+    qtest_quit(qts);
+}
+
 static const uint32_t fault_guest[] = {
     0x34011000, /* ldi 0x800,r1 */
     0x01c11840, /* mtctl r1,iva */
@@ -362,6 +460,11 @@ int main(int argc, char **argv)
         qtest_add_data_func(name, &fp_tests[i], test_fp);
     }
     qtest_add_func("fpu/lazy-contexts", test_lazy);
+    for (size_t i = 0; i < G_N_ELEMENTS(frem_tests); i++) {
+        g_autofree char *name = g_strdup_printf("fpu/frem/%s", frem_tests[i].name);
+
+        qtest_add_data_func(name, &frem_tests[i], test_frem);
+    }
     for (size_t i = 0; i < G_N_ELEMENTS(fault_tests); i++) {
         g_autofree char *name = g_strdup_printf("fpu/%s", fault_tests[i].name);
 
-- 
2.56.1


