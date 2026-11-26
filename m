Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02043606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=P41NjJHK;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=/1t43leL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgNh-0000xK-0T; Thu, 26 Nov 2026 15:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNf-0000w1-0Y
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:47 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xWgNc-0006Hz-A0
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:47:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=aD0Zddy
 IwjAv9x+c1rZzTl8ovHBRyZUEC4qaKyV/hsNtzlq6/i0efJClxxhT0I+S+xhKEmw4/37C1
 GKM13BQQQPvFlQSufLXTM6JgQ+OsTEmxz6i5tDoNf2xkpy71GZQNNsO6rI+Vz3BRfRjFKI
 dGTZz4FPc7Fr4jO4kypRug6shTPz4eD6XSksknB/NVsJr1idDQ3AZZsvrywq6Hzenx5f9e
 6qG7kuPTF08abtNTQCuY+aFWmOXKVmapwlXGzmM+qrOh+kqDXVsY+/TZxY95wzMtOR9JAM
 7yfRdTQHdpWdPqpDRxKdsoDID2e9onIsnAPmo9xU9kcHqXpqKiYQppA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=I
 ZvJVKL71yV2YWlyN5Xj521fBe/jW/9ZZrWrVwyBj8s=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=RFujMlrepOk7gnnWz0OA3pjkCyR3gPCSZnJNy7R26n9GmWP5txvfsv9+BfCyam55zyuP
 q3YEZofFqk+fwTmsDbtmDkf+DnJddNfwFoiHgaAiJ8/A8G1Sj4A6JUd46nleg05JSh2ZuZ
 M+nyO1IVAQgCdIBjlaX5aBjWIYnZFg5hmSIu3XT3TB7XcuTe8+ZA2SE7Ur4XghU2yt1RlP
 a9g/W/Pjsk8V3394WMFdXKOtUfdfHaFPhNB6dvNOv06aP55Wc+s+uFuKtTk56ZhYV/JHtD
 gnowdSxMRT9bModFtvjAZ3s3LngXs3Gfa+dF3Euam6Ij4gWMiV2zNRuSm6r96Jsw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=P41NjJHK; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=/1t43leL;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=IZvJVKL7
 1yV2YWlyN5Xj521fBe/jW/9ZZrWrVwyBj8s=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=P41NjJHKfcorq2Q660ycxh7ydkbNmwL1/MW
 mcHcAtDnyjcLWzpUrFnqBWXkROPk/IxQSFA3yXpwXPLKfv/Jwy+MQav4h9YKdBIPqKm1BX
 E/zpeeULj3oIZgkyfxbEmDyhwhksEAF8QaNiUUOemRfWNhdg251txomLBPQBiiwhFOxIUz
 sU0CGWo2akP0UXvn/AFX85WGwQ6EOxW8ziVx5KbmWCDZY+NTrmIgtqY433owVdp58uZsif
 YmO1pd/lEemYSvQdtrLTC9cLNnMtS9so+GTFHn5LhC6DmU5yiFb05G1GxvjWfGUilv8V+F
 KUpVMyddX6yjSkDeSKvovCJkccw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=IZvJVKL71yV2YWlyN5Xj521fBe/jW/9ZZrWrVwyBj8s=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=/1t43leLSSDDkBKMb3
 ck5pLTUpQZV6y9wvlqjgwwq0obO6G0+LJuipbp6L36PStef3TJgMIfFiLWbqmK4uyoDQ==
Received: by mx1.catap.net (OpenSMTPD) id b9d565dd;
 Thu, 26 Nov 2026 21:47:39 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id e0fe966b;
 Thu, 26 Nov 2026 21:47:36 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH 2/3] target/hppa: Defer PA7300LC FCNVFF on NaNs
Date: Thu, 26 Nov 2026 21:39:21 +0100
Message-ID: <20261126204733.9423-3-kirill@korins.ky>
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

QEMU passed PA7300LC FCNVFF NaN operands to SoftFloat, bypassing the
deferred assist exercised by OpenBSD/hppa's fmaxmin_test-11.

For a NaN operand, leave the destination intact, record the
instruction in ER2 and set FPSR.T so the next active floating point
instruction takes assist vector 14 before execution. FSTD FR0 can
save the pending status first, clearing T only after the store
succeeds.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/hppa/cpu.h           |   1 +
 target/hppa/fpu_helper.c    |  47 ++++++++++++--
 target/hppa/helper.h        |   4 +-
 target/hppa/int_helper.c    |   4 ++
 target/hppa/translate.c     |  79 +++++++++++++++++------
 tests/qtest/hppa-fpu-test.c | 121 ++++++++++++++++++++++++++++++++++++
 6 files changed, 228 insertions(+), 28 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7b708a564b..842964074a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -97,6 +97,7 @@
 
 /* Emulated hardware TOC button */
 #define EXCP_TOC                 32 /* TOC = Transfer of control (NMI) */
+#define EXCP_ASSIST_DELAYED      33 /* Internal, delivered through vector 14 */
 
 const char *hppa_exception_name(int excp);
 
diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index f42044cdef..82ad6da34d 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -113,6 +113,10 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
         shadow = FIELD_DP32(shadow, FPSR, T, 1);
         /* fill exception register #1, which is lower 32-bits of fr[0] */
 #if !defined(CONFIG_USER_ONLY)
+        if (!hppa_is_pa20(env)) {
+            /* Drop any retained ER2 record before an immediate trap. */
+            env->fr[1] = (uint32_t)env->fr[1];
+        }
         if (hard_exp & (R_FPSR_ENA_O_MASK | R_FPSR_ENA_U_MASK)) {
             /* over- and underflow both set overflow flag only */
             fr1 = FIELD_DP32(fr1, FPSR, C, 1);
@@ -233,18 +237,49 @@ float64 HELPER(frem_d)(CPUHPPAState *env, float64 a, float64 b)
     return ret;
 }
 
-float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
+#ifndef CONFIG_USER_ONLY
+static void defer_fp_unimplemented(CPUHPPAState *env, uint32_t insn)
+{
+    uint32_t code = (insn >> 26) == 0x0c ? 0x09 : 0x0b;
+    uint32_t record = deposit32(insn, 26, 6, code);
+
+    /* PA7300LC records the original operation in exception register 2. */
+    env->fr[1] = deposit64(env->fr[1], 32, 32, record);
+    env->fr0_shadow |= R_FPSR_T_MASK;
+    env->fr[0] = deposit64(env->fr[0], 32, 32, env->fr0_shadow);
+}
+#endif
+
+void HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg, uint32_t reg, uint32_t insn)
 {
-    float64 ret = float32_to_float64(arg, &env->fp_status);
+    float64 ret;
+
+#ifndef CONFIG_USER_ONLY
+    if (!hppa_is_pa20(env) && float32_is_any_nan(arg)) {
+        defer_fp_unimplemented(env, insn);
+        return;
+    }
+#endif
+    ret = float32_to_float64(arg, &env->fp_status);
     update_fr0_op(env, GETPC());
-    return ret;
+    env->fr[reg] = ret;
 }
 
-float32 HELPER(fcnv_d_s)(CPUHPPAState *env, float64 arg)
+void HELPER(fcnv_d_s)(CPUHPPAState *env, float64 arg, uint32_t reg, uint32_t insn)
 {
-    float32 ret = float64_to_float32(arg, &env->fp_status);
+    float32 ret;
+    unsigned shift = reg & 32 ? 0 : 32;
+
+#ifndef CONFIG_USER_ONLY
+    if (!hppa_is_pa20(env) && float64_is_any_nan(arg)) {
+        defer_fp_unimplemented(env, insn);
+        return;
+    }
+#endif
+    ret = float64_to_float32(arg, &env->fp_status);
     update_fr0_op(env, GETPC());
-    return ret;
+    reg &= 31;
+    env->fr[reg] = deposit64(env->fr[reg], shift, 32, ret);
 }
 
 float32 HELPER(fcnv_w_s)(CPUHPPAState *env, int32_t arg)
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index b99e298ee8..84937ee73f 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -40,8 +40,8 @@ DEF_HELPER_FLAGS_3(fmpy_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(frem_d, TCG_CALL_NO_RWG, f64, env, f64, f64)
 
-DEF_HELPER_FLAGS_2(fcnv_s_d, TCG_CALL_NO_RWG, f64, env, f32)
-DEF_HELPER_FLAGS_2(fcnv_d_s, TCG_CALL_NO_RWG, f32, env, f64)
+DEF_HELPER_FLAGS_4(fcnv_s_d, TCG_CALL_NO_RWG, void, env, f32, i32, i32)
+DEF_HELPER_FLAGS_4(fcnv_d_s, TCG_CALL_NO_RWG, void, env, f64, i32, i32)
 
 DEF_HELPER_FLAGS_2(fcnv_w_s, TCG_CALL_NO_RWG, f32, env, s32)
 DEF_HELPER_FLAGS_2(fcnv_dw_s, TCG_CALL_NO_RWG, f32, env, s64)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index da9c7c6457..8a19232062 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -162,6 +162,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
+        case EXCP_ASSIST_DELAYED:
             /* IIR set via translate.c.  */
             break;
 
@@ -223,6 +224,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     }
 
     /* step 7 */
+    if (i == EXCP_ASSIST_DELAYED) {
+        i = EXCP_ASSIST;
+    }
     if (i == EXCP_TOC) {
         hwaddr pdc_toc_addr = FIRMWARE_START;
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0713112063..67670768d1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1692,13 +1692,32 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
     return nullify_end(ctx);
 }
 
+static void gen_fp_assist_check(DisasContext *ctx)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->is_pa20) {
+        TCGv_i32 fpsr = tcg_temp_new_i32();
+        DisasDelayException *e = delay_excp(ctx, EXCP_ASSIST_DELAYED);
+
+        tcg_gen_ld_i32(fpsr, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
+        tcg_gen_brcondi_i32(TCG_COND_TSTNE, fpsr, R_FPSR_T_MASK, e->lab);
+    }
+#endif
+}
+
+static void fp_nullify_over(DisasContext *ctx)
+{
+    nullify_over(ctx);
+    gen_fp_assist_check(ctx);
+}
+
 static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
                       unsigned rx, int scale, int64_t disp,
                       unsigned sp, int modify)
 {
     TCGv_i32 tmp;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
     do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
@@ -1745,7 +1764,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
 {
     TCGv_i64 tmp;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
     do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
@@ -1782,7 +1801,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
 {
     TCGv_i32 tmp;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
     do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
@@ -1807,8 +1826,22 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
 
     nullify_over(ctx);
 
+    if (rt != 0) {
+        gen_fp_assist_check(ctx);
+    }
     tmp = load_frd(rt);
     do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
+#ifndef CONFIG_USER_ONLY
+    if (rt == 0 && !ctx->is_pa20) {
+        TCGv_i32 fpsr = tcg_temp_new_i32();
+
+        /* FSTD FR0 saves T in memory and clears it only after the store. */
+        tcg_gen_andi_i64(tmp, tmp, ~((uint64_t)R_FPSR_T_MASK << 32));
+        save_frd(0, tmp);
+        tcg_gen_extrh_i64_i32(fpsr, tmp);
+        tcg_gen_st_i32(fpsr, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
+    }
+#endif
 
     return nullify_end(ctx);
 }
@@ -1827,7 +1860,7 @@ static bool do_fop_wew(DisasContext *ctx, unsigned rt, unsigned ra,
 {
     TCGv_i32 tmp;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     tmp = load_frw0_i32(ra);
 
     func(tmp, tcg_env, tmp);
@@ -1842,7 +1875,7 @@ static bool do_fop_wed(DisasContext *ctx, unsigned rt, unsigned ra,
     TCGv_i32 dst;
     TCGv_i64 src;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     src = load_frd(ra);
     dst = tcg_temp_new_i32();
 
@@ -1857,7 +1890,7 @@ static bool do_fop_ded(DisasContext *ctx, unsigned rt, unsigned ra,
 {
     TCGv_i64 tmp;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     tmp = load_frd0(ra);
 
     func(tmp, tcg_env, tmp);
@@ -1872,7 +1905,7 @@ static bool do_fop_dew(DisasContext *ctx, unsigned rt, unsigned ra,
     TCGv_i32 src;
     TCGv_i64 dst;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     src = load_frw0_i32(ra);
     dst = tcg_temp_new_i64();
 
@@ -1888,7 +1921,7 @@ static bool do_fop_weww(DisasContext *ctx, unsigned rt,
 {
     TCGv_i32 a, b;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     a = load_frw0_i32(ra);
     b = load_frw0_i32(rb);
 
@@ -1904,7 +1937,7 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 {
     TCGv_i64 a, b;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     a = load_frd0(ra);
     b = load_frd0(rb);
 
@@ -4133,7 +4166,7 @@ static bool trans_fid_f(DisasContext *ctx, arg_fid_f *a)
         ret = 0x0f080000000000ULL; /* PA7300LC (PCX-L2) */
     }
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     save_frd(0, tcg_constant_i64(ret));
     return nullify_end(ctx);
 }
@@ -4239,12 +4272,18 @@ static bool trans_fnegabs_d(DisasContext *ctx, arg_fclass01 *a)
 
 static bool trans_fcnv_d_f(DisasContext *ctx, arg_fclass01 *a)
 {
-    return do_fop_wed(ctx, a->t, a->r, gen_helper_fcnv_d_s);
+    fp_nullify_over(ctx);
+    gen_helper_fcnv_d_s(tcg_env, load_frd(a->r), tcg_constant_i32(a->t),
+                       tcg_constant_i32(ctx->insn));
+    return nullify_end(ctx);
 }
 
 static bool trans_fcnv_f_d(DisasContext *ctx, arg_fclass01 *a)
 {
-    return do_fop_dew(ctx, a->t, a->r, gen_helper_fcnv_s_d);
+    fp_nullify_over(ctx);
+    gen_helper_fcnv_s_d(tcg_env, load_frw0_i32(a->r), tcg_constant_i32(a->t),
+                       tcg_constant_i32(ctx->insn));
+    return nullify_end(ctx);
 }
 
 static bool trans_fcnv_w_f(DisasContext *ctx, arg_fclass01 *a)
@@ -4375,7 +4414,7 @@ static bool trans_fcmp_f(DisasContext *ctx, arg_fclass2 *a)
 {
     TCGv_i32 ta, tb, tc, ty;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     ta = load_frw0_i32(a->r1);
     tb = load_frw0_i32(a->r2);
@@ -4392,7 +4431,7 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
     TCGv_i64 ta, tb;
     TCGv_i32 tc, ty;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     ta = load_frd0(a->r1);
     tb = load_frd0(a->r2);
@@ -4412,9 +4451,6 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 
     nullify_over(ctx);
 
-    t = tcg_temp_new_i64();
-    tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
-
     if (a->y == 1) {
         switch (a->c) {
         case 0: /* simple */
@@ -4450,6 +4486,9 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
         mask = R_FPSR_CA0_MASK >> cbit;
     }
 
+    gen_fp_assist_check(ctx);
+    t = tcg_temp_new_i64();
+    tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
     ctx->null_cond = cond_make_ti(tc, t, mask);
     return nullify_end(ctx);
 }
@@ -4512,7 +4551,7 @@ static bool trans_xmpyu(DisasContext *ctx, arg_xmpyu *a)
 {
     TCGv_i64 x, y;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
 
     x = load_frw0_i64(a->r1);
     y = load_frw0_i64(a->r2);
@@ -4580,7 +4619,7 @@ static bool trans_fmpyfadd_f(DisasContext *ctx, arg_fmpyfadd_f *a)
 {
     TCGv_i32 x, y, z;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     x = load_frw0_i32(a->rm1);
     y = load_frw0_i32(a->rm2);
     z = load_frw0_i32(a->ra3);
@@ -4599,7 +4638,7 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
 {
     TCGv_i64 x, y, z;
 
-    nullify_over(ctx);
+    fp_nullify_over(ctx);
     x = load_frd0(a->rm1);
     y = load_frd0(a->rm2);
     z = load_frd0(a->ra3);
diff --git a/tests/qtest/hppa-fpu-test.c b/tests/qtest/hppa-fpu-test.c
index 40e097dbbe..f49d834e31 100644
--- a/tests/qtest/hppa-fpu-test.c
+++ b/tests/qtest/hppa-fpu-test.c
@@ -394,6 +394,122 @@ static void test_frem(const void *opaque)
     qtest_quit(qts);
 }
 
+typedef struct FcnvTest {
+    const char *name;
+    uint32_t instruction;
+    uint64_t operand;
+    uint64_t result;
+    uint64_t result_mask;
+    uint32_t er2;
+    bool result_first;
+} FcnvTest;
+
+static const FcnvTest fcnv_tests[] = {
+    {
+        .name = "status-first",
+        .instruction = 0x3180220c, /* fcnvff,sgl,dbl fr12,fr12 */
+        .operand = 0x7fa0000012345678ULL,
+        .result = 0x7fa0000000000000ULL,
+        .result_mask = 0xffffffff00000000ULL,
+        .er2 = 0x2580220c,
+    },
+    {
+        .name = "result-first",
+        .instruction = 0x3180220c,
+        .operand = 0x7fa0000012345678ULL,
+        .result = 0x7fa0000000000000ULL,
+        .result_mask = 0xffffffff00000000ULL,
+        .er2 = 0x2580220c,
+        .result_first = true,
+    },
+    {
+        .name = "finite",
+        .instruction = 0x3180220c,
+        .operand = 0x4000000012345678ULL, /* 2.0f in the left half */
+        .result = 0x4000000000000000ULL, /* 2.0 */
+        .result_mask = UINT64_MAX,
+    },
+    {
+        .name = "extended-status-first",
+        .instruction = 0x39800a4c, /* fcnvff,dbl,sgl fr12,fr12R */
+        .operand = 0x7ff4000001234567ULL,
+        .result = 0x7ff4000001234567ULL,
+        .result_mask = UINT64_MAX,
+        .er2 = 0x2d800a4c,
+    },
+    {
+        .name = "extended-finite",
+        .instruction = 0x39800a4c,
+        .operand = 0x4004000000000000ULL, /* 2.5 */
+        .result = 0x4004000040200000ULL, /* 2.5f in the right half */
+        .result_mask = UINT64_MAX,
+    },
+};
+
+static const uint32_t fcnv_save[] = {
+    0x2e101200, /* fstd fr0,8(r16) */
+    0x36100020, /* ldo 16(r16),r16 */
+    0x2e001201, /* fstd fr1,0(r16) */
+    0x2e101200, /* fstd fr0,8(r16) */
+    0x36100020, /* ldo 16(r16),r16 */
+    0x2e00120c, /* fstd fr12,0(r16) */
+};
+
+static void test_fcnv(const void *opaque)
+{
+    const FcnvTest *test = opaque;
+    const uint32_t guest[] = {
+        0x34011000, /* ldi 0x800,r1 */
+        0x01c11840, /* mtctl r1,iva */
+        0x34103000, /* ldi 0x1800,r16 */
+        0x34113200, /* ldi 0x1900,r17 */
+        0x34123050, /* ldi 0x1828,r18 */
+        0x34010180, /* ldi 0xc0,r1 */
+        0x01411840, /* mtctl r1,ccr */
+        0x2e00100c, /* fldd 0(r16),fr12 */
+        test->instruction,
+        0x08002880, /* cmpclr,= r0,r0,r0 */
+        0x2e40120c, /* fstd fr12,0(r18): nullified */
+    };
+    static const uint32_t complete[] = {
+        0x34010002, /* ldi 1,r1 */
+        0x6a210000, /* stw r1,0(r17): completion */
+    };
+    QTestState *qts = start_guest(false);
+    uint32_t pc = CODE + sizeof(guest);
+    uint64_t fr0 = test->er2 ? 0x0000004000000000ULL : 0;
+
+    write_words(qts, CODE, guest, G_N_ELEMENTS(guest));
+    if (test->result_first) {
+        uint32_t vector_branch = 0x800 + 14 * 32 + 4;
+        uint32_t end = ASSIST + sizeof(fcnv_save);
+
+        qtest_writel(qts, pc, 0x2e40120c); /* fstd fr12,0(r18) */
+        pc += 4;
+        qtest_writel(qts, vector_branch, branch(vector_branch, ASSIST));
+        write_words(qts, ASSIST, fcnv_save, G_N_ELEMENTS(fcnv_save));
+        qtest_writel(qts, end, branch(end, UNEXPECTED));
+    }
+    write_words(qts, pc, fcnv_save, G_N_ELEMENTS(fcnv_save));
+    pc += sizeof(fcnv_save);
+    write_words(qts, pc, complete, G_N_ELEMENTS(complete));
+    pc += sizeof(complete);
+    qtest_writel(qts, pc, branch(pc, HALT));
+    qtest_writeq(qts, DATA, test->operand);
+
+    run_guest(qts, test->result_first ? 0x10e : 1);
+    if (test->result_first) {
+        g_assert_cmphex(qtest_readl(qts, RESULT + 8), ==, CODE + sizeof(guest));
+    }
+    g_assert_cmphex(qtest_readq(qts, DATA + 8), ==, fr0);
+    g_assert_cmphex(qtest_readl(qts, DATA + 16), ==, test->er2);
+    g_assert_cmphex(qtest_readq(qts, DATA + 24), ==, 0);
+    g_assert_cmphex(qtest_readq(qts, DATA + 32) & test->result_mask, ==,
+                    test->result);
+    g_assert_cmphex(qtest_readq(qts, DATA + 40), ==, 0);
+    qtest_quit(qts);
+}
+
 static const uint32_t fault_guest[] = {
     0x34011000, /* ldi 0x800,r1 */
     0x01c11840, /* mtctl r1,iva */
@@ -465,6 +581,11 @@ int main(int argc, char **argv)
 
         qtest_add_data_func(name, &frem_tests[i], test_frem);
     }
+    for (size_t i = 0; i < G_N_ELEMENTS(fcnv_tests); i++) {
+        g_autofree char *name = g_strdup_printf("fpu/fcnv/%s", fcnv_tests[i].name);
+
+        qtest_add_data_func(name, &fcnv_tests[i], test_fcnv);
+    }
     for (size_t i = 0; i < G_N_ELEMENTS(fault_tests); i++) {
         g_autofree char *name = g_strdup_printf("fpu/%s", fault_tests[i].name);
 
-- 
2.56.1


