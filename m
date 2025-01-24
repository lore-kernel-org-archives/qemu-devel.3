Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86B4C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMfu-0005bA-59; Fri, 24 Jan 2025 11:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZM-0005vg-8e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZC-0005nn-VE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1271291f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736196; x=1738340996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=90zJmscshgzp9ZgdoGcA5ll/KJlD0eY0cc5R60hdHPs=;
 b=RuWYvr1S3NUOPhXC8O10QG/OeR9E3Orxn84gacT8jyeexzIId6ks5Sua7nXwV5Y4vh
 2sn3N4NRSMSWkYQQuqQStnGZ0FRDXmIsTk1VWBN2W5my7nzWrxdPuLpfgBacQPXBVctY
 yzcqeUT8WrYaLJ+26VCitMHmxB6rsYT8TuII66pWxG0IIAaSSdQDMpC1an9Ys19hK3dQ
 8jehjPGM6WyKltCnaULzcEZ5Lbva0oXryk+HS8iaaG6BTF+/+g9OLqKFSuqR38EZmw/b
 fO5PnkRzSLf+DK40Kf64dE2ZtWXwLJKU47C0NZszFSMQBAe4G5F8zO0XExIQPo4w0Oac
 tXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736196; x=1738340996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90zJmscshgzp9ZgdoGcA5ll/KJlD0eY0cc5R60hdHPs=;
 b=NM4TY5tMxmmNgrgjM6Kq3fMMrAgVfmBMTEAtPo8Cbfafese+u83EPf+vReZH5IHK1n
 +f4nyGiFgx1RNlv+lx/gZnYZMlspQmJBeJh+tzDTQixTH+AJ54+O0TKBgUklpDBpIZJ+
 o8OO00jj5yfJu6+wuSG9FKHajvUPWjsrQWwrt133yYTcZjQrwZ8uw+VQClckpCmBGnhJ
 uPOlx4M8JjHDr5nZsj+A2A8LQXxYN8tijVvNpiusmvAq8sIQPdNPcHSjIZFxRopqbHmp
 hcoaiKi4yGuE/biQJ07HAgIxfJrxMzffrw6WD4c+lotM0fQ8ZjcPHoecNwmCp6IPKR5L
 vtEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL3kWcxMtj7sa7Dz7tnY0p73FU82JCOPkGK5iP1frz0HXkWBANohEcxq4vVwjXkdcjipJyD8KeK8L+@nongnu.org
X-Gm-Message-State: AOJu0Yzmm0c2vaUDCM6SMi17mr0YHliogzPGu7KqpgSczjsuev66mhj/
 slbrHTsf57veC1awAZ8k3h3HoAmerMCFg5Twx8v4eUzEBr6hetOVBsGqBHkA8p0=
X-Gm-Gg: ASbGncu3puwdHkfVJpfGl95Ynu5xTf0FSl3RljAvDqeck1aIRtOmw5xdd8r613AFptY
 L0AuTYY5bvbBcaq5eF5gEsk3Ti/uiY2wPyttpBV4xl15Vo7Ub1XM+D8M0S8lkhCjltLH281qe5J
 7hVjITXscoNvnOPmrfBZX4t4C8Hzbx59AawBWHGJ2zNGhgh6a+yk8mwkE6KtEajyUlTtwXBHgPh
 MC3p9THYtZjEtvTzWZBhXTWVKAHg3XyeUyUQYyc57ZULWirnVc+DYubu5iT4TGwRHUyqh/vd3j0
 XZpEWrfOE4E=
X-Google-Smtp-Source: AGHT+IFZ3zBd3jB1JeMqB35NpYLhp3Arsr1yG+rC4NYNJYmIWvKNxG7P47pnV/5Pk3JtiPwdNaFhUg==
X-Received: by 2002:a5d:47c7:0:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38c11e4af44mr20629251f8f.21.1737736196287; 
 Fri, 24 Jan 2025 08:29:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 62/76] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS vector
 insns
Date: Fri, 24 Jan 2025 16:28:22 +0000
Message-Id: <20250124162836.2332150-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics
in the vector versions of FRECPS and FRSQRTS, by implementing
new vector wrappers that call the _ah_ scalar helpers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 21 ++++++++++++++++-----
 target/arm/tcg/translate-sve.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    |  8 ++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 29c70f054af..a2e96a498dd 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -980,6 +980,20 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_recps_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_recps_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_recps_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_rsqrts_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ah_fmax_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_fmax_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 977a1589e53..3fe8e041093 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5778,10 +5778,11 @@ static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
     return do_fp3_vector(s, a, data, s->fpcr_ah ? fah : fnormal);
 }
 
-static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
-                             gen_helper_gvec_3_ptr * const f[3])
+static bool do_fp3_vector_ah_2fn(DisasContext *s, arg_qrrr_e *a, int data,
+                                 gen_helper_gvec_3_ptr * const fnormal[3],
+                                 gen_helper_gvec_3_ptr * const fah[3])
 {
-    return do_fp3_vector_with_fpsttype(s, a, data, f,
+    return do_fp3_vector_with_fpsttype(s, a, data, s->fpcr_ah ? fah : fnormal,
                                        select_fpst(s, a->esz));
 }
 
@@ -5924,14 +5925,24 @@ static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector_ah, a, 0, f_vector_frecps)
+static gen_helper_gvec_3_ptr * const f_vector_ah_frecps[3] = {
+    gen_helper_gvec_ah_recps_h,
+    gen_helper_gvec_ah_recps_s,
+    gen_helper_gvec_ah_recps_d,
+};
+TRANS(FRECPS_v, do_fp3_vector_ah_2fn, a, 0, f_vector_frecps, f_vector_ah_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector_ah, a, 0, f_vector_frsqrts)
+static gen_helper_gvec_3_ptr * const f_vector_ah_frsqrts[3] = {
+    gen_helper_gvec_ah_rsqrts_h,
+    gen_helper_gvec_ah_rsqrts_s,
+    gen_helper_gvec_ah_rsqrts_d,
+};
+TRANS(FRSQRTS_v, do_fp3_vector_ah_2fn, a, 0, f_vector_frsqrts, f_vector_ah_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0696192148c..eef3623fd3a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3741,7 +3741,12 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
         NULL, gen_helper_gvec_##name##_h,                           \
         gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
     };                                                              \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz, name##_fns[a->esz], a, 0)
+    static gen_helper_gvec_3_ptr * const name##_ah_fns[4] = {       \
+        NULL, gen_helper_gvec_ah_##name##_h,                        \
+        gen_helper_gvec_ah_##name##_s, gen_helper_gvec_ah_##name##_d    \
+    };                                                              \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz,            \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], a, 0)
 
 DO_FP3(FADD_zzz, fadd)
 DO_FP3(FSUB_zzz, fsub)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index aa42c50f9fe..bf6f6a97636 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1498,6 +1498,14 @@ DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
 DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
 DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 
+DO_3OP(gvec_ah_recps_h, helper_recpsf_ah_f16, float16)
+DO_3OP(gvec_ah_recps_s, helper_recpsf_ah_f32, float32)
+DO_3OP(gvec_ah_recps_d, helper_recpsf_ah_f64, float64)
+
+DO_3OP(gvec_ah_rsqrts_h, helper_rsqrtsf_ah_f16, float16)
+DO_3OP(gvec_ah_rsqrts_s, helper_rsqrtsf_ah_f32, float32)
+DO_3OP(gvec_ah_rsqrts_d, helper_rsqrtsf_ah_f64, float64)
+
 DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
 DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
 DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
-- 
2.34.1


