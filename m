Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512EFC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhYo-0002De-Cu; Fri, 04 Jul 2025 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPG-0002WD-3p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPD-0001RP-Hw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:49 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso748963fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639325; x=1752244125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxuhX7jAE01wypOCiSa4edSMsIBxfbscXCFO5YQqXuQ=;
 b=dCd9yaEljcC4kA5vrbABv86ELmBZkQiE2E7rGc2CIraIy80aOJPVO/QIaKMbzdKN7y
 5gd9DzmnbPPbhWYY1UWCqJs0OM9LkAIbkq+rnDLBNU0Dv4b3k4oJ/Vm9q0CToQ9xsOcX
 FgshwUuBYhK7QNcvu8OilnQlzXK8jnSIZF+7Z4DkbdhsdSXZBan5IDu56BriX2aAF0Km
 4IgwiqLfM996+yu61vvcg+6d4rGaT2S3+gpSn0GfQdMTjtxxMbTV67qfr9igjD84070o
 ImD6qHPBVOXVzCUZmDHoePt3wevhMA1kj2pc4pPpWas5AR1NaMXmncDgt96oZw7aC8do
 8F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639325; x=1752244125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxuhX7jAE01wypOCiSa4edSMsIBxfbscXCFO5YQqXuQ=;
 b=s/3UgLGe7nZJxVqoId+/6oAlmaC0caSfriiJY5heSYKxbDe5GPxUteGZNhEyFJ0qbh
 KMuBjnSZ9yzOsToNuogJ15slhmoWOTCpGdoS5bSQeafJ7+w3aWxj6rSv9aUrHWtMtNwm
 c9cMD0Pzo/n0zZLKmM3UTNtr+rq3ILxR/8V0ptUVe3vDwe3ZXpjrX28jE4aj+60dw9Wx
 0w2debQvCejycOqMiwjWkKD4NSBILvqfVqsXXzTGm/fQlhy/vxLZ/mCe6Q9j0XzJE6hr
 3KPryZzZor8kNU5xXV4m6Yuo5KgYe7yQ6cLvOqOMhl7Rkr/UazzYES8DDf/RmfIDZAp7
 j0Xw==
X-Gm-Message-State: AOJu0Yy+zP9aCq1+NhTvrIp8Vdm8w7XYoAskNVqJ2aVWqRGnkBFQ2cnd
 UnEEYY1jzbUyL/CvuH7mMMcKcS5YzNzXAd0LScWUzVFTJlwG9Kvzbc9QOsss76MkCVdI7TKlMUr
 rvw5mEQA=
X-Gm-Gg: ASbGncsRqqfu+lVvYHI012EZ6y7poQggBhL0NuKeWc+wpJd+7vOsODPJHmEquCVz+qe
 fFBjLkNI6a1ADZDwgyEekfgI/Y5EzN2lP2I3QLySI8BF6Jah5pnnjNS8Fn49xMRFI2+2XDJfoBG
 ZRx9Nf25tLNWUJDLBwuKl2dwjMp0kvvIcdsnZ1gYZPzQaalrH1qUSuE1g0DUcqD5seEWWE9jgpv
 5KfYLXyQPYWBuqTVBVynTRWvAWI3xFngKQ1bJe2+lhXDFnTOWjy+NStXH5DQSV2AyW8eY890uzc
 /OPUdZ4hwXnBseug0nhmAff/mipHcVY2aLW8F2nc7xORN8VCPKWQKiVesa8/MV25eLmEzGiRQLd
 sV1QKFOo4i16v28MDIqE8ePHs0jkXJJeyIr3BHSFBA2Ow97DK
X-Google-Smtp-Source: AGHT+IHoo4bLpHQrvEJOfvWAVSHKpqYJ27zhJU7DMwp/hsnOEqkcISUGCUN2C+vWk3hLStmlGZRl6w==
X-Received: by 2002:a05:6870:d207:b0:2d4:ef88:97af with SMTP id
 586e51a60fabf-2f796b86111mr1649502fac.3.1751639325343; 
 Fri, 04 Jul 2025 07:28:45 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 086/108] target/arm: Implement BFMLSLB{L, T} for SME2/SVE2p1
Date: Fri,  4 Jul 2025 08:20:49 -0600
Message-ID: <20250704142112.1018902-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 05c0fc948a..079d310960 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7421,6 +7421,36 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
 TRANS_FEAT(BFMLALT_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, true)
 
+static bool do_BFMLSL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl,
+                                  a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, false)
+TRANS_FEAT(BFMLSLT_zzzw, aa64_sme2_or_sve2p1, do_BFMLSL_zzzw, a, true)
+
+static bool do_BFMLSL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
+{
+    if (s->fpcr_ah) {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_ah_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_AH);
+    } else {
+        return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlsl_idx,
+                                  a->rd, a->rn, a->rm, a->ra,
+                                  (a->index << 1) | sel, FPST_A64);
+    }
+}
+
+TRANS_FEAT(BFMLSLB_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, false)
+TRANS_FEAT(BFMLSLT_zzxw, aa64_sme2_or_sve2p1, do_BFMLSL_zzxw, a, true)
+
 static bool trans_PSEL(DisasContext *s, arg_psel *a)
 {
     int vl = vec_full_reg_size(s);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 10cac2de22..0df3312739 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1727,18 +1727,24 @@ FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
+BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
+
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 FMLALT_zzxw     01100100 10 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 FMLSLB_zzxw     01100100 10 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 FMLSLT_zzxw     01100100 10 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
+
 BFMLALB_zzxw    01100100 11 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
 BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
+BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
+BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
 ### SVE2 floating-point dot-product (indexed)
 
-- 
2.43.0


