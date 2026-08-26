Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D198BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeI-0000ER-0n; Wed, 26 Aug 2026 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdu-0008WL-FZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:30 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdr-0004mp-Sa
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:29 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbedf318752so1031413a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766146; x=1788370946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afR4L8NBYUNtzXNAlwfRDdnQW+anBIGEEKMFSgwhsCQ=;
 b=DRnBT2Xj0UUqSEHysxQlCqkDgPuXBAHNC0T97tnzq7Z5+T1Qlul4YKcHNrrqLQuL71
 aZRGUBo4BjvHt0cBSWQgj8W5zeBeRuNZHD7PlnrQBBZQo0xTgf6MgjKfZlHPd3WHTclC
 Ccj63GDMSWKm2POa3Ifh1lz1Tlp5BKWcJzPqgNsz06UBXae5L0PRmuvW85UquyOnCBsd
 DOrAAiIdYQdp0Qnoh0zsUJsAPemOh99wXCYfJ4GE976OqKn4v9ei/UD8ZHLqWZUeeO5g
 zD1SJBpWx26X+h4HWU41IKNnCiUp1s5siXkfrzze8ASjbHn0FPXjn/n2ch3NOF/hlvGr
 FrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766146; x=1788370946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=afR4L8NBYUNtzXNAlwfRDdnQW+anBIGEEKMFSgwhsCQ=;
 b=R/NAgkggwdRT7UcXPgT+t5UGfHZo6wAI+XE+e3e8zSGgBJyAWgw/1glEZsZEfDSH+b
 fJPgzG5xfc5p8FW/BDTUzpuLMlCpAXdShk/0nmhcy2tVQkaD1l8YawppL6pjqx6zi0kd
 be7doMtlLriLIwnQi7mwrLKneKJ/BdqxjDYhSBaCTNhcqYCqENe/wIzqXN/4lOxsMD8m
 aOaqAP8e//e4sluoElvJ++bQMdU/gdGdaYi2j+jBrQFtPgf6ByOET0BlzVCQOqQHvCoL
 85/Lmzh8M8ket1NvfCm3NYB51690vWaF5zNPMVicB2Sgij1HmvT8KtWrjRWaG701l3ym
 VNWQ==
X-Gm-Message-State: AFuF++kJH3EYesSZeDKvg7AHqq8H48wKlk77wHZCxhYmJPBt7RlxHkB6
 k2YBgSz4h5ep+j6PK+OdswcaySbzybu6ClN6tgkXcRf1WDXOaZBd1DwlGYqefdUh3z90N/SX5g+
 nXDQOAlQ=
X-Gm-Gg: AR+sD1278wRGiEQ/v6AvIimy+aJCS7xUfgSCDwrYYKsbPwGOM8WzWnLLDoIpoUeWzxU
 rEc6cRgJXx52fOtp4f3vZ9N9M/pe057Z0mvc7d5vyPnc1oeVfj1FnSl+Ymm9XtphI/jRaUW7eY5
 ObZCUttmqE2tJtyZQMaVry15YzcV4D4E0YAsj+sRpqxENEo7XfE2pJv4JheLOT6C+Y+JaGBUIqO
 ybt33Pn/k228+Al0OwAzvGI3kOMQHhEFkDO4yElJtObdHPoewD1HtWrkCT9OWE5Bc9xRoBu5LJM
 M8Q6zaxXFJVBuVYUU+4SCfpbm19NPo0pxKEXO7D0nGfn/tBmFSt3eH+/PC9XBqfroXfjmTGzpdV
 R8o/3iRBppwVSoOERe64kmAbZ8+L02LDSxeK4RjObSp0hNHj9Xh6fZrYZXIWslFJtpwXMH/ouej
 ZhoPMdsDyf2eqlh3lm6JH/YVqjvKBOn8VkwY1XHVSWHWcN2Jz9svJJ0pdIIqe4gy67PuFzXDm8U
 erY26ZVVF6zCZTaFg==
X-Received: by 2002:a05:6a21:a95:b0:3c1:657:4c95 with SMTP id
 adf61e73a8af0-3cf84459271mr18796131637.15.1787766146305; 
 Wed, 26 Aug 2026 10:42:26 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/25] target/arm: Remove DO_ZPZZ_AH_FP_B16 from
 translate-sme.c
Date: Wed, 26 Aug 2026 10:41:56 -0700
Message-ID: <20260826174213.614571-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
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

Expand the macro at each use site.
Merge the two arrays and index by fpcr_ah.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6e984d02f82..f65c2b0af53 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4425,19 +4425,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  *** SVE Floating Point Arithmetic - Predicated Group
  */
 
-#define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
-        gen_helper_##name##_b16, gen_helper_##name##_h,                 \
-        gen_helper_##name##_s, gen_helper_##name##_d                    \
-    };                                                                  \
-    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
-        gen_helper_##ah_name##_b16, gen_helper_##ah_name##_h,           \
-        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
-    };                                                                  \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
-               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
-               name##_zpzz_fns[a->esz], a)
-
 static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
     gen_helper_sve_fadd_b16,
     gen_helper_sve_fadd_h,
@@ -4465,8 +4452,23 @@ static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
 TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmul_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
-DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
+static gen_helper_gvec_4_ptr * const sve_fmin_fns[4][2] = {
+    { gen_helper_sve_fmin_b16, gen_helper_sve_ah_fmin_b16 },
+    { gen_helper_sve_fmin_h, gen_helper_sve_ah_fmin_h },
+    { gen_helper_sve_fmin_s, gen_helper_sve_ah_fmin_s },
+    { gen_helper_sve_fmin_d, gen_helper_sve_ah_fmin_d },
+};
+TRANS_FEAT(FMIN_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmin_fns[a->esz][s->fpcr_ah], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmax_fns[4][2] = {
+    { gen_helper_sve_fmax_b16, gen_helper_sve_ah_fmax_b16 },
+    { gen_helper_sve_fmax_h, gen_helper_sve_ah_fmax_h },
+    { gen_helper_sve_fmax_s, gen_helper_sve_ah_fmax_s },
+    { gen_helper_sve_fmax_d, gen_helper_sve_ah_fmax_d },
+};
+TRANS_FEAT(FMAX_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmax_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
     gen_helper_sve_fmaxnum_b16,
-- 
2.53.0


