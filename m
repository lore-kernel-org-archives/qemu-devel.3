Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F676CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPg-000842-KW; Sat, 16 May 2026 20:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOb-0007AL-RC
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOX-0004md-9x
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so357559a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977805; x=1779582605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igH1Orszu/DZI1tTbnaIoUTxsqOZEnj+4FQPvhRK6EI=;
 b=yu/RZ2QT7Jl8vc4Eo6tYUh7OJjxrmo01OkB7MpAODaC2rohP5IpktGbqwIcK3rVbyq
 1spslMNedQ5htQV6304rOlitFhIVXOvw2nC6RWaEnOBUA0ZJvbhOfCvLoCW7yI0H9QTA
 fjgL6ftz28afGGz4YVgGUsf1QMA1ZZ/CJkbIg6jR47iJd8SF0NJgLEpwWoOy1lOC+3SP
 NJDbLNmbw/kmeWVpZqv6DKgR+CuKVwqv19Zfuy5919TU5JkgArfVgXbYWRSzuErS9lHk
 XGwXBxcndtK4WYpqmoA+Dzhr48PamiGOZo+bvakvoH3GAF49pEjiVIspYhCnqdxFcxtQ
 tMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977805; x=1779582605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igH1Orszu/DZI1tTbnaIoUTxsqOZEnj+4FQPvhRK6EI=;
 b=DQx95a1caAlO3D7n4Yhkw2ew3AVm/tF4mtC6cR6Hij0Hlfp393okdX7dPG/+j2eL+h
 nreLO00+4PFp6G0N40qz/cXlgjORK1gMnHUebfCMwE8OBwhsbfR7N39fyjQwa3UL5T8m
 cUpMTmXs8iB1kw4zlA/4JG5IoNKUilhhxLK4zEHS7NHG/RueYqXpbsqR71TmFVHehXgH
 yLJtTJC8tNYZ6y6ieauXGCzmYi1uMok14fR6oIkpPcrx+DccpeyM4nCr6mEGpyfC9Bu2
 dpLHKbPeHg/uckrEIXwsEwTBFYZ7m1PwYLAb1OSpJ4Uc6mISxO7hJH/eOJNhKpzVFrfF
 C7sw==
X-Gm-Message-State: AOJu0YyYqpvNVl4OPbljnB/CXa/0DVhUA/7VHOuxld1qwkkhEmCyaL6k
 ntVTBNr9eRNvq9qfmzFD9y406nou4dVrFgQ8YpEFAtFrQn0+wuqAwvIR3yzuZPZJEsRBm630xt1
 Z/ZED
X-Gm-Gg: Acq92OFGtayLS9SC1pc5ZMX2pA6HnJhOUQ491iWhJQAH8F1VwnSnqJboRNFDL1CQafe
 mEUxMmTWKKsIMGhpJRVELLl1N7bhc2h8KIqGU58vIZOgzxXHXhyTHrtStsFKvbxwu3ZJZ7lp3k4
 lMWSRLZOeF4g7sgNKGs4tTEGL1P/yNLpwaPnsUl2sqxBrqaohbOXQjND5Vxf9V8CfWG0qqrBTSV
 bVU0w0gX2OrYTF/7ahZQIHtAKO3Vb349j6iuIceZqeeEAq1z1HM2H49Y9eBRTMVuvbEx49F2bGo
 HQYBfS/6WleNBIaIMHbXIliFtzvDeWA3i7aUuWHtH0W3Y0btHZhOMxI438iOent4oTMaguz2kG9
 tALATVnX8YjpJI2Tj8jidIxTfBHSTvFu3t+x16BcpK8oDorAbjmiWbqeO5EgXTx+HNi1NNtIv+C
 8uJsmG9T/syvHyZ5oTuLO20ZlZvkHB
X-Received: by 2002:a05:6a00:3005:b0:837:db9d:9606 with SMTP id
 d2e1a72fcca58-83f33d26f5cmr10487952b3a.23.1778977805244; 
 Sat, 16 May 2026 17:30:05 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 03/63] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
Date: Sat, 16 May 2026 17:29:02 -0700
Message-ID: <20260517003002.321430-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  7 +++++++
 target/arm/tcg/vec_internal.h    |  7 +++++++
 target/arm/tcg/translate-a64.c   | 14 +++++++++++++
 target/arm/tcg/vec_helper64.c    | 34 ++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  5 +++++
 6 files changed, 72 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 50776347a5..21a1f941dd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1062,6 +1062,11 @@ static inline bool isar_feature_aa64_ats1a(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, ATS1A);
 }
 
+static inline bool isar_feature_aa64_faminmax(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR3, FAMINMAX) != 0;
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 3c3c5dddb7..215df1201b 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -145,6 +145,13 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_famax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index c7ccb28b18..cc2691b2f6 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -338,6 +338,13 @@ bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
+float16 float16_famax(float16, float16, float_status *);
+float16 float16_famin(float16, float16, float_status *);
+float32 float32_famax(float32, float32, float_status *);
+float32 float32_famin(float32, float32, float_status *);
+float64 float64_famax(float64, float64, float_status *);
+float64 float64_famin(float64, float64, float_status *);
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec..3c6559964b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6478,6 +6478,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[3] = {
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 249a257177..4a5b0782d1 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -140,3 +140,37 @@ void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
     memcpy(vd, &result, 16);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+/*
+ * Use float_minmax_ismag to get the absolute value min/max.
+ * Avoid float_minmax_is{num,number} so that we get normal NaN processing.
+ * If the result is not a nan, take the absolute value.
+ */
+#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
+TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
+{                                                                       \
+    float_status local = *s;                                            \
+    set_flush_to_zero(0, &local);                                       \
+    set_flush_inputs_to_zero(0, &local);                                \
+    TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
+    if (!TYPE##_is_any_nan(r)) {                                        \
+        r = TYPE##_abs(r);                                              \
+    }                                                                   \
+    float_raise(get_float_exception_flags(&local)                       \
+                & ~float_flag_input_denormal_used, s);                  \
+    return r;                                                           \
+}
+
+DO_FAMINMAX(famax, float16, 0)
+DO_FAMINMAX(famin, float16, float_minmax_ismin)
+DO_FAMINMAX(famax, float32, 0)
+DO_FAMINMAX(famin, float32, float_minmax_ismin)
+DO_FAMINMAX(famax, float64, 0)
+DO_FAMINMAX(famin, float64, float_minmax_ismin)
+
+DO_3OP(gvec_famax_h, float16_famax, float16)
+DO_3OP(gvec_famin_h, float16_famin, float16)
+DO_3OP(gvec_famax_s, float32_famax, float32)
+DO_3OP(gvec_famin_s, float32_famin, float32)
+DO_3OP(gvec_famax_d, float64_famax, float64)
+DO_3OP(gvec_famin_d, float64_famin, float64)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38b..666a293540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1193,6 +1193,11 @@ RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
 PMULL_p8        0.00 1110 001 ..... 11100 0 ..... ..... @qrrr_b
 PMULL_p64       0.00 1110 111 ..... 11100 0 ..... ..... @qrrr_b
 
+FAMAX           0.00 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


