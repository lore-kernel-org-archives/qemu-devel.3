Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FEFC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlv-0008Fa-P1; Sun, 26 May 2024 15:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlu-0008Ey-CS
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJls-0007f3-8C
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b441b08so18562195ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752586; x=1717357386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgucXLg1pZJZPGsx4EXjLigGn2nj5OF6pY/xQSWaTTs=;
 b=s8Zw++qVb5RmDZPfkEW+0AgyH5I3lHcqihAPxtiYLEK+okIhz4rS0kOSvStlZbINo6
 I/ZsqhbZDGUo5qOFhLu7AfTLWCohPw+RRq/E8qpYYiQcZHXWWJTBfY8FsY07P0XMMXRJ
 Q79meitu6YQ38s4jWaqQuMWhpHv76f3FBQLmd5e4xFeXvK4Zn1lV3+R3XfNP+UWTpLI4
 NLRYz48eP5vJ95qYhP0bYY9zWmYtgX9vckFoDfm7sTPSo3ddzuRkSeIygofazYLg6gTQ
 rT4jE59WFGIoTDCnVPkVnBgzU4WGNfTaiZB7syzeR1JYa114VCaJcBz4/Aja/ivaPWA1
 JxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752586; x=1717357386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RgucXLg1pZJZPGsx4EXjLigGn2nj5OF6pY/xQSWaTTs=;
 b=HdmhfX0v98S46Ochl3N+4KDy9gzlLvOhhq7wnIuRUjpLbEqN4KTrGN/J/iNv/9VEzt
 WMTBFMX24figqPBA788Bgx1sTL0TnV8+4axHfKRt9OPbSZVXRlWrxUEuEkqPbj0Z5BsR
 2xB0CEG/ftIYnw/sTLorYk3Vkl5fD1U9rn/xyQPuMONkdvRUSuv2SoLE8CfGYdHSPx4k
 IOrxNKGP6SV9hvfTPQh1HTsB/Bb1KR0bsL6rGa2CyeZ5kCaB4xi+4KbOivW8VmZIzYco
 H+wFBjwGkCwYyDLaBTSKqhsBetz7rEhG2thjPdEhp4Ci6qqu2ec9zkYo4Y7UuCwG7THP
 4WEA==
X-Gm-Message-State: AOJu0Yya1rS7yizWyG9rZK4YeT23l7vkVFg1oRaw8pLTS5bhNogYQFKw
 RLhVzcTrpQg7dFXnKgcqQye95GlYuBEy6auLlbRfk5CESxe1EsTnlQWvsXSjKtAMmoiBi+eTtEz
 G
X-Google-Smtp-Source: AGHT+IEro5++ZDxnto1ijJdH5YGOz57Pu+bzbVPaFiKqgFuq8IQCw6aYJ+iB3c4/kldLatsnWQ3cJA==
X-Received: by 2002:a17:902:e805:b0:1f4:a026:4895 with SMTP id
 d9443c01a7336-1f4a0264a4bmr6885035ad.60.1716752586424; 
 Sun, 26 May 2024 12:43:06 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/37] target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD,
 FNMUL
Date: Sun, 26 May 2024 12:42:31 -0700
Message-Id: <20240526194254.459395-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  5 +++
 target/sparc/insns.decode | 11 ++++++
 target/sparc/fop_helper.c | 68 +++++++++++++++++++++++++++++++++++
 target/sparc/translate.c  | 76 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index e59307efc2..15f0907a1b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -57,6 +57,8 @@ DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
+DEF_HELPER_FLAGS_3(fnaddd, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fnmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 
 DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_WG, i128, env, i128, i128)
@@ -68,8 +70,11 @@ DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
+DEF_HELPER_FLAGS_3(fnadds, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fnmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
+DEF_HELPER_FLAGS_3(fnsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_WG, i128, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_WG, f64, env, s32)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 18d068d2af..6ec3838865 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -307,8 +307,19 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @q_q_q
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @d_d_d
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @q_q_q
+FNADDs      10 ..... 110100 ..... 0 0101 0001 .....        @r_r_r
+FNADDd      10 ..... 110100 ..... 0 0101 0010 .....        @d_d_d
+FNMULs      10 ..... 110100 ..... 0 0101 1001 .....        @r_r_r
+FNMULd      10 ..... 110100 ..... 0 0101 1010 .....        @d_d_d
+FHADDs      10 ..... 110100 ..... 0 0110 0001 .....        @r_r_r
+FHADDd      10 ..... 110100 ..... 0 0110 0010 .....        @d_d_d
+FHSUBs      10 ..... 110100 ..... 0 0110 0101 .....        @r_r_r
+FHSUBd      10 ..... 110100 ..... 0 0110 0110 .....        @d_d_d
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @d_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
+FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
+FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
+FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 1de44d79c1..08b5f96f95 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -359,6 +359,74 @@ float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
     return ret;
 }
 
+float32 helper_fnadds(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_add(src1, src2, &env->fp_status);
+
+    /*
+     * NaN inputs or result do not get a sign change.
+     * Nor, apparently, does zero: on hardware, -(x + -x) yields +0.
+     */
+    if (!float32_is_any_nan(ret) && !float32_is_zero(ret)) {
+        ret = float32_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float32 helper_fnmuls(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float32 ret = float32_mul(src1, src2, &env->fp_status);
+
+    /* NaN inputs or result do not get a sign change. */
+    if (!float32_is_any_nan(ret)) {
+        ret = float32_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fnaddd(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_add(src1, src2, &env->fp_status);
+
+    /*
+     * NaN inputs or result do not get a sign change.
+     * Nor, apparently, does zero: on hardware, -(x + -x) yields +0.
+     */
+    if (!float64_is_any_nan(ret) && !float64_is_zero(ret)) {
+        ret = float64_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fnmuld(CPUSPARCState *env, float64 src1, float64 src2)
+{
+    float64 ret = float64_mul(src1, src2, &env->fp_status);
+
+    /* NaN inputs or result do not get a sign change. */
+    if (!float64_is_any_nan(ret)) {
+        ret = float64_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
+float64 helper_fnsmuld(CPUSPARCState *env, float32 src1, float32 src2)
+{
+    float64 ret = float64_mul(float32_to_float64(src1, &env->fp_status),
+                              float32_to_float64(src2, &env->fp_status),
+                              &env->fp_status);
+
+    /* NaN inputs or result do not get a sign change. */
+    if (!float64_is_any_nan(ret)) {
+        ret = float64_chs(ret);
+    }
+    check_ieee_exceptions(env, GETPC());
+    return ret;
+}
+
 static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
 {
     check_ieee_exceptions(env, ra);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 48ee1abd68..4515886590 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1234,6 +1234,51 @@ static void gen_op_fnmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
     gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
 }
 
+/* Use muladd to compute (1 * src1) + src2 / 2 with one rounding. */
+static void gen_op_fhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+/* Use muladd to compute (1 * src1) - src2 / 2 with one rounding. */
+static void gen_op_fhsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_negate_c | float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fhsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_negate_c | float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+/* Use muladd to compute -((1 * src1) + src2 / 2) with one rounding. */
+static void gen_op_fnhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    TCGv_i32 one = tcg_constant_i32(float32_one);
+    int op = float_muladd_negate_result | float_muladd_halve_result;
+    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
+static void gen_op_fnhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
+{
+    TCGv_i64 one = tcg_constant_i64(float64_one);
+    int op = float_muladd_negate_result | float_muladd_halve_result;
+    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+}
+
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
 {
     /*
@@ -4710,6 +4755,10 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
 TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
 TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
 
+TRANS(FHADDs, VIS3, do_fff, a, gen_op_fhadds)
+TRANS(FHSUBs, VIS3, do_fff, a, gen_op_fhsubs)
+TRANS(FNHADDs, VIS3, do_fff, a, gen_op_fnhadds)
+
 static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
@@ -4730,6 +4779,8 @@ TRANS(FADDs, ALL, do_env_fff, a, gen_helper_fadds)
 TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
+TRANS(FNADDs, VIS3, do_env_fff, a, gen_helper_fnadds)
+TRANS(FNMULs, VIS3, do_env_fff, a, gen_helper_fnmuls)
 
 static bool do_dff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i32))
@@ -4823,6 +4874,10 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
+TRANS(FHSUBd, VIS3, do_ddd, a, gen_op_fhsubd)
+TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
+
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
 {
@@ -4872,6 +4927,8 @@ TRANS(FADDd, ALL, do_env_ddd, a, gen_helper_faddd)
 TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
 TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
 TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
+TRANS(FNADDd, VIS3, do_env_ddd, a, gen_helper_fnaddd)
+TRANS(FNMULd, VIS3, do_env_ddd, a, gen_helper_fnmuld)
 
 static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
 {
@@ -4893,6 +4950,25 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
     return advance_pc(dc);
 }
 
+static bool trans_FNsMULd(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (!avail_VIS3(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    dst = tcg_temp_new_i64();
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_fnsmuld(dst, tcg_env, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_ffff(DisasContext *dc, arg_r_r_r_r *a,
                     void (*func)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32))
 {
-- 
2.34.1


