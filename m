Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F1E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDd-0007N9-Ay; Tue, 24 Dec 2024 15:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDU-0006og-OW
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:21 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDS-0002y6-Kg
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:20 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso5478455a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070957; x=1735675757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WWVUuFJ12NWX3hZBTm/nR+nuzYhMWj/gdswxVh+HzA=;
 b=nRW6mibawrPYbgl5GP5Q4Bd0hil2z3UINtVaPUbH1lMVTimLBXKivYIvbPE/xtvfkz
 AD4QJQg38I2Yt1EWQnNrQI6pNrByW4yuKGcwzRKmld0QubLTjUyMWn7PwmwRIRFUZ2JE
 3Cbz+fjf3/1Ss5K4RpEyTOlf0UTICCzuhpXQR6np7HiVnymbaeEaz29vHRgO5MsjPDoV
 egFML7YtwVJA6DLilV/sjd7xHZvBchOkDvcuvVnoTnCWHiku1sZnGLOsK7WBOW5sHzzX
 5bAFzKY+tiUThFyX3yzNpADfPrDwpNthz3s2xm1FeDTRFvgjUGyU8TcHEPTB4NbT8krb
 1y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070957; x=1735675757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WWVUuFJ12NWX3hZBTm/nR+nuzYhMWj/gdswxVh+HzA=;
 b=TYsKCtk6Qq9HW+Elu5pgAJRTP9jrF/aaDukuuFBWvk4Bs9wfKVKhMl2Aj25NckLCMo
 P68u9WtDAWRYb+p2kSkR7eZnw9aU1hQJ/sCTB7YqHsOtM1SpUMqzDFFH7atQ4M881XCK
 mIScbUpbpViwF8Fcmyrje/sOzN6qFN0RF5JA1McNCxz5kJ3xCeXEl6Oio4ztvjEQTGip
 dxfTBB33lDEy2g+8GWHOYOSklVo5yd7IhLloqhc+ke1duSpbrZNrwkrFcZibpbQ1rRAg
 xduw3IhHGR1dibRzvP1NeXsmtALxTzGKuyuk17p53kBAGmjOH94V8xVmqgtSJc8xjrRX
 13PQ==
X-Gm-Message-State: AOJu0Yyu1P/TtwhKbrmHkxZNPyidZHNMaE4m2bePmwhQuXPGG2hloZ60
 nHFcciXwN4rFeHrHmAc3J4l64kZwFIY2Tv3BnRY5loWm8Jwtxa+AKXi9Yi+fN1n3h8rrHXj9CxM
 A+Ug=
X-Gm-Gg: ASbGnct7UZD4np8dSBu0HZKXxOdTNtYvbvJH0kkuU2tedFy3j0Ot030Gk9VwNalf2s3
 u/tDayR2KzRWRG0VsY9TiJ08SdK+dYQ2bkZP2YCWDEtNMSywIGuN5FV4ZzJHfpjaSVHhwJyWV9c
 LQcYYNr2edHzmjk8+DQh/YrKvknpC69wNzIPRqhJy3UTVvuM1L0K/ySsUxL0YJUB4ytzaTvpj08
 rGc86kFE0h60b76+QH7+AzSktZKY3cJJ1tFQ8JNOnjV4d8HBtkItvzfsVkbw5Xtk9Jp4PEuBKu8
 ci6JaQ6UxAG2EvWhcuWx5XfPzg==
X-Google-Smtp-Source: AGHT+IGfx+7TMDPx5mydqtgWJjVpEb5zqmuUKVyvm6Gy5oCxPlE89VoTN3lEm/ZgVooGalHoO/PFgw==
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72abdeb6e80mr26145144b3a.21.1735070957102; 
 Tue, 24 Dec 2024 12:09:17 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 57/72] target/sparc: Use float*_muladd_scalbn
Date: Tue, 24 Dec 2024 12:05:06 -0800
Message-ID: <20241224200521.310066-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Use the scalbn interface instead of float_muladd_halve_result.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  4 +-
 target/sparc/fop_helper.c |  8 ++--
 target/sparc/translate.c  | 80 +++++++++++++++++++++++----------------
 3 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 1ae3f0c467..3a7f7dc129 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -59,7 +59,7 @@ DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
+DEF_HELPER_FLAGS_6(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, s32, i32)
 DEF_HELPER_FLAGS_3(fnaddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fnmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 
@@ -72,7 +72,7 @@ DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
+DEF_HELPER_FLAGS_6(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, s32, i32)
 DEF_HELPER_FLAGS_3(fnadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fnmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 236d27b19c..c25097d07f 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -344,17 +344,17 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 }
 
 float32 helper_fmadds(CPUSPARCState *env, float32 s1,
-                      float32 s2, float32 s3, uint32_t op)
+                      float32 s2, float32 s3, int32_t sc, uint32_t op)
 {
-    float32 ret = float32_muladd(s1, s2, s3, op, &env->fp_status);
+    float32 ret = float32_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
 float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
-                      float64 s2, float64 s3, uint32_t op)
+                      float64 s2, float64 s3, int32_t sc, uint32_t op)
 {
-    float64 ret = float64_muladd(s1, s2, s3, op, &env->fp_status);
+    float64 ret = float64_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9be26c804e..465e20f4f3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1359,93 +1359,109 @@ static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
 
 static void gen_op_fmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+    TCGv_i32 z = tcg_constant_i32(0);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, z);
 }
 
 static void gen_op_fmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+    TCGv_i32 z = tcg_constant_i32(0);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, z);
 }
 
 static void gen_op_fmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_c;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_c;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_c | float_muladd_negate_result;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c |
+                                   float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_c | float_muladd_negate_result;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c |
+                                   float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_result;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_result;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 /* Use muladd to compute (1 * src1) + src2 / 2 with one rounding. */
 static void gen_op_fhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(0);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(0);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 /* Use muladd to compute (1 * src1) - src2 / 2 with one rounding. */
 static void gen_op_fhsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_negate_c | float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fhsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_negate_c | float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 /* Use muladd to compute -((1 * src1) + src2 / 2) with one rounding. */
 static void gen_op_fnhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_negate_result | float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fnhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_negate_result | float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
-- 
2.43.0


