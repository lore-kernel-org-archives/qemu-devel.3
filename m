Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B8CC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYB-0006JA-8O; Sat, 01 Feb 2025 11:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY7-0006GD-TP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:52 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY6-0001A5-93
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so20932565e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428049; x=1739032849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZABGaocUKPORi0DB8OtUcbfDfzDv6nNeQO0oGgc3SPA=;
 b=iUOekpCdHbrJqeSuAVLX+sh5yMBrPvKazyTzlJr8I3mDqAvuga7JxsQg/pE2KhqJsK
 k1rJNFSDWpUQ2cUMt9+1GP/0DgHjSXjWseIRpEHrCmiWA01HBJQkw3wJk8Sli913qv5L
 Zy00rIPf/FEn4H/11cKdW0h3k2e853u7zUbNlPWxESHKltabYkf53kE+269XzCtISDnm
 YuDlZOXCBGpQ6FNkFi2ARYWxJKV+X9y5KNntOPlujFS0KxG35D39amaGWiptfTu9hC0b
 odHO+8ky5ajwfd/8KlFkl8PvbQ53t8J3V+iFVUeEHk7+OD7dH6h3JjAiZ4hlJBvt8O3H
 Ef2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428049; x=1739032849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZABGaocUKPORi0DB8OtUcbfDfzDv6nNeQO0oGgc3SPA=;
 b=drws78CYfSYCs28YbKhijT5zJ7TASpT1/3AX/I+gBvM6ARMfytDk8Vu2YuguSvqRFv
 KxYek6bHOd6HAbz8DJj0b6hEc6GZ0XNu8XJpSlXE1tvIcv2eqHWYecxSNmD1K3BG4S2d
 Rcj6ITB6pkXM2BxW6zhh0rFA3sb5W4PSQxJ5UtfeKeX5SJ6K58clSl4En+USvSL50Gzz
 DFIQ7uwbzk5CCr4J3hP2ZLNrZgb8TlrOd0mcEFYUT3Vtw+Y9KHhgSRG3tXF0ccOZ0EWn
 1BJhUtnxI6ggfG0QRbi/JL8xBgXrh/obT6rmVIV5Bss+He+kKJLRl3JoT2qZM8SlbnBh
 4Vew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp9FG4y63cMaWkwRfIOkJiwuaJRd0XMF6XwL1+cCg0mSDfewZM+d8boMAY6YGnjWQafkepVBFoPwl+@nongnu.org
X-Gm-Message-State: AOJu0YwUuEihILV6gkvoqlY07vqLdLgQKxlDST2jK7s9Njf8yHR4knuw
 GJa9L8YNMh/iMRYu7Eoun7MqnlIZ0NJm2wrh1USQDCSNcC4lm/NWN7/fep0lAn6M6J+5OFWF1gH
 d
X-Gm-Gg: ASbGncudSN13gclGE6r5fUJPoqMoFRSglOUBJ5Lx2gS81YcklFQfmIgYnZa8cFDF7Zf
 bK5F7vpbX9lridLMh93htKq5owwrBs3AIsGydN40dcP2u2PWUNCgU8MFRNW5tdPcQGWin+bnM8T
 syP4Eq/n8G36/yJ1JpGNseRZyA9cblzVhVj3mSNBQlYDSPg2Gh1Rj9Q5jQmStHjQL4NxPuN5cVb
 PvDlsFcXvM910AC+YXZ+iwVjAVAq6F2j7GShWKnvd61bOpa6V1xQE4GY4b5/iRVxTw+WvB6dxvp
 AZDxzjFWbXv6uIdNVUFE
X-Google-Smtp-Source: AGHT+IGrFvx7Ebw67LlJpQChUTujDim7jucqLqi0ZYLX2oKc9L39XUmqmXVTwgzi5JpOJzvRlJYdRA==
X-Received: by 2002:a05:600c:4fd6:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-438dc34cc47mr155915775e9.0.1738428048613; 
 Sat, 01 Feb 2025 08:40:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 25/69] target/arm: Implement FPCR.AH semantics for vector
 FMIN/FMAX
Date: Sat,  1 Feb 2025 16:39:28 +0000
Message-Id: <20250201164012.1660228-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement the FPCR.AH == 1 semantics for vector FMIN/FMAX, by
creating new _ah_ versions of the gvec helpers which invoke the
scalar fmin_ah and fmax_ah helpers on each element.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 21 +++++++++++++++++++--
 target/arm/tcg/vec_helper.c    |  8 ++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index fea43b319c3..f1b4606f763 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -972,6 +972,20 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ae3f3d32f45..cad9883f7dc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5607,6 +5607,13 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
                                        FPST_A64_F16 : FPST_A64);
 }
 
+static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
+                              gen_helper_gvec_3_ptr * const fnormal[3],
+                              gen_helper_gvec_3_ptr * const fah[3])
+{
+    return do_fp3_vector(s, a, data, s->fpcr_ah ? fah : fnormal);
+}
+
 static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
                              gen_helper_gvec_3_ptr * const f[3])
 {
@@ -5647,14 +5654,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[3] = {
     gen_helper_gvec_fmax_s,
     gen_helper_gvec_fmax_d,
 };
-TRANS(FMAX_v, do_fp3_vector, a, 0, f_vector_fmax)
+static gen_helper_gvec_3_ptr * const f_vector_fmax_ah[3] = {
+    gen_helper_gvec_ah_fmax_h,
+    gen_helper_gvec_ah_fmax_s,
+    gen_helper_gvec_ah_fmax_d,
+};
+TRANS(FMAX_v, do_fp3_vector_2fn, a, 0, f_vector_fmax, f_vector_fmax_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[3] = {
     gen_helper_gvec_fmin_h,
     gen_helper_gvec_fmin_s,
     gen_helper_gvec_fmin_d,
 };
-TRANS(FMIN_v, do_fp3_vector, a, 0, f_vector_fmin)
+static gen_helper_gvec_3_ptr * const f_vector_fmin_ah[3] = {
+    gen_helper_gvec_ah_fmin_h,
+    gen_helper_gvec_ah_fmin_s,
+    gen_helper_gvec_ah_fmin_d,
+};
+TRANS(FMIN_v, do_fp3_vector_2fn, a, 0, f_vector_fmin, f_vector_fmin_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[3] = {
     gen_helper_gvec_fmaxnum_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7330b373c38..9f77aa6b919 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1448,6 +1448,14 @@ DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
 DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
 DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 
+DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
+DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
+DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
+
+DO_3OP(gvec_ah_fmin_h, helper_vfp_ah_minh, float16)
+DO_3OP(gvec_ah_fmin_s, helper_vfp_ah_mins, float32)
+DO_3OP(gvec_ah_fmin_d, helper_vfp_ah_mind, float64)
+
 #endif
 #undef DO_3OP
 
-- 
2.34.1


