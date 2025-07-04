Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B778C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhIt-0006uy-Ih; Fri, 04 Jul 2025 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI3-0004nM-0s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:24 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI1-0005If-9t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:22 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso925819fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638880; x=1752243680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmz/p7GaB8icfuoUSX82GiopD2WLwMfn+lK0i48knrc=;
 b=hOKuzM4pkzE14IWLgNLRgjMZJbvoW7iqOudf2nzxm9DMWeEhQql27wJAmrSDa3o5db
 CrrwqI9PQ7ukWWK7bNsOeA7uIJIMAjRHm9jOnyRxvEg0594mEH/aLFbkOil7pUSpJ3wl
 nFduKGg7Zc+5DW36eSPQ7ueRZY3mJm1JDrfnACj2g2foRb7KLfrEHKD5ErhR96jUgc7K
 jvI23T+477+7ryR3xX8Bf3kGkL34uVC4V8MW7+4Rt/LUm/Wof+k7YCfwsZUG9vSd3KnE
 JnXanQ+SZ51emAdLXcRg36s/geEqV345tEpwiEtMzgs+x9gGWBVNkOwQQ38zGHcJlRMJ
 wPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638880; x=1752243680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmz/p7GaB8icfuoUSX82GiopD2WLwMfn+lK0i48knrc=;
 b=sKqT6cmLjl0RvZ9xRVS1oU9+HpMxnzvHe63mS2e57jgzur/5uxWSS4XODO3NNkSJPO
 1vZhe99D9RYmBsDTwAXBUXJnBKtpqqjO0gXlMSfyDcyD3v2S2MvJJ5RNShzRmgjSfKQR
 +ZCwmwz0jcsrkfLfGnedlqHgpDFydMRTjQVfvSt+k6dlILNtSV1AkF3rjIVlGsdx15PW
 TSAFn1ylaHBI/NRN1vU8L7wBmEb23Bqcovd8D3LXwEhrh1KmRX4fmTpk24WmKZ59cC46
 b9Zj6C9qBy2JTt3u3boXehxV5lmEWRd2/YS3tFNNqwEuEBbZ9hF0CcvxhTjgXqKGL7Ur
 ptjA==
X-Gm-Message-State: AOJu0YzrDYA7uxZa1EIfCJTYvkr9VO9wRKt3B2L/vtJGqJ7cE2OXF8ao
 Tkcd9CiFcc/3d6a7/32rItX5Q0pqapadnkJZY0ODpQxRYe2Tk/s5WtzN17AYjUHZk/dcGMVv2X5
 F7Sz2pk4=
X-Gm-Gg: ASbGncss+ayOqoeCf4S//YSSmPY9TVfMqROpzve0Qw0f4JaXQCWEtt74nRWdDmL41eZ
 iPIBFsYncHHMocKnL3IRhoULPvS4kITpuj6sAoK2QCR4/YGfLZD7xaeOB8D1kGI6bqHNF9ltDJM
 SNI/jzmxMfjZxiXuAw/QhkLeo0rto0mNcFVL0ZMOeJYMuaRCSBi8mczHAOyIkZ/OBcE2nu38Dvo
 sNBMhytNzSpbXJm9rk5n+fGl9/KpNAqdQ2Gf/VykArCi9G7sd+AnY/DM21SbvVLeo3GlFbz3DUJ
 9OqdaP051sw0b8EpWgjlbc7qKllmaNQLkizLznugM0Jz5ohH92vf7ij+x+HeFzXABM+VAlmH1pE
 sVOTORV66QiXtS5RjB7qGApTc2mLSUFAGr1DwBlMTwUC1Vefc
X-Google-Smtp-Source: AGHT+IHgwTE1QrfgGOgCG5B8PO+nKbWz1RHH6IUM/bQ3ob8xAyS1F8IBz4vrHqcQks51SYTcME6rRA==
X-Received: by 2002:a05:6871:2313:b0:29e:5dfd:1e17 with SMTP id
 586e51a60fabf-2f796da2715mr1696687fac.23.1751638879865; 
 Fri, 04 Jul 2025 07:21:19 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 005/108] target/arm: Fix FMMLA (64-bit element) for 128-bit
 VL
Date: Fri,  4 Jul 2025 08:19:28 -0600
Message-ID: <20250704142112.1018902-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 588a5b006b..a0de5b488d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7025,17 +7025,26 @@ DO_ZPZZ_FP(FMINNMP, aa64_sve2, sve2_fminnmp_zpzz)
 DO_ZPZZ_FP(FMAXP, aa64_sve2, sve2_fmaxp_zpzz)
 DO_ZPZZ_FP(FMINP, aa64_sve2, sve2_fminp_zpzz)
 
+static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
+                     gen_helper_gvec_4_ptr *fn)
+{
+    if (sve_access_check(s)) {
+        if (vec_full_reg_size(s) < 4 * memop_size(a->esz)) {
+            unallocated_encoding(s);
+        } else {
+            gen_gvec_fpst_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, 0, FPST_A64);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, do_fmmla, a, gen_helper_fmmla_s)
+TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, do_fmmla, a, gen_helper_fmmla_d)
+
 /*
  * SVE Integer Multiply-Add (unpredicated)
  */
 
-TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, gen_gvec_fpst_zzzz,
-                        gen_helper_fmmla_s, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_A64)
-TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, gen_gvec_fpst_zzzz,
-                        gen_helper_fmmla_d, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_A64)
-
 static gen_helper_gvec_4 * const sqdmlal_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlal_zzzw_h,
     gen_helper_sve2_sqdmlal_zzzw_s, gen_helper_sve2_sqdmlal_zzzw_d,
-- 
2.43.0


