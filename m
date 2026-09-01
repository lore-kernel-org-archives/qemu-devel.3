Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026FEC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONU-0001Ba-0s; Tue, 01 Sep 2026 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONS-0001Al-IQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONQ-0007HV-Mr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a611ba5130so6742386a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268691; x=1788873491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k2CZXSiNU7H5DW2oCoy9Ap7uGD+odcUNSVonkrvQp/U=;
 b=RYbbMt40GHi+H2CEiJKOJA4+A1skHXqXdukLKsJpEnXYKbH8T8FflNFXNr2Y5E6tDZ
 RkUhFKCNXoS83prGPdYzz0O73HC1KsY7xZeE/Us/DVHltsmecppnWZSXAzZ51A39zu76
 TzNM4XiTNxvRTUXKfyTdYi3+6M3RcQaBUuncXOROBeqysTEFMi2CeqoIHhwHerHC25dY
 oKTLvXM5FInbliOQPXiU/3UAvRpMLytSGVO/66rkQ3r8faRlfe/3/TMmfwu2WTmMFCev
 pH199x42yOuBsP1pujN0a8oQ8tnZCWgK5b1IPii9hFiVbxOT5jWNNSKyJ2RqeUwKSKuL
 cJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268691; x=1788873491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k2CZXSiNU7H5DW2oCoy9Ap7uGD+odcUNSVonkrvQp/U=;
 b=Z8XLOw6HhWnYAhKupm3lKjLDlW0xBMidzaqzJUuYpjWGTRco101IhJIpYyuZLyhvSx
 i/nj9zj2nTITgHNby5TspdHIkabqAZAsYuf8j5b+gprMUY+9Sza3bq0PUMEdVc0PMaCt
 b6hThrXGbMdEHWc+41h3HE56goMzRYFc5UAohDHJ83F1B+CvGoIvykl1XuLGxWKqoegU
 1tMUil0LF7FWXpG+3pZDQy5AKvsq0s2nlqtNdGJaQGdWNh81qm2hXOEelfc9XrlVG4Kr
 p5Lm7DWinP9tc3PUC8h0Bmunl/nQe9Rhc/Gw+WtelLuyAWfSf6miOFC/nVVwoeQ9BdLG
 LzbA==
X-Gm-Message-State: AFuF++l7xyhCfxz/5imMo4WEPj+t+jkNyS6FoUOUUVPAvrFLacOANiq4
 ZMh7mDTRDGqxk8tRKjsjsbeTGTWF6GjRcoj3PbVxjezo90sdy2Z7rC+03r/0pcFDDDzZN2eBo7s
 sLWpGD64=
X-Gm-Gg: AR+sD13cvRkMD3fp4HZn/6fEVqHvJk5nyxR7mzIgFXO5hPz5K6yOdZAk4w+ZSm4P8ob
 JJOID+6WsRw35oE46nezHmGU+8tfMXgvstCi/HWVMdx25QkHobj4VUSuQMgpnnY1N5VsAapFrPx
 uqJ4PWRH/ZPlwoA7fF64HLI/gAGWI7DvbDCjG2LDiNqYiJOeEDdgfWvvO6Eea1l4Qvx64Gvkocv
 UrxLXCpj99TSBqODTlbvMLjmbu79sP899TYLK+0lEmBwltpmQ66wXxHzpwCr4phk+RulE/FkPjS
 tLHXAqDA2LpoNzq2e1v2ZQuxwz+DCildB3tUESsXPrbJ8hlq5A1wOu4bbj60y+mpE7HUtxpGQ1T
 spgoQ766pwX+SEPL58V2ZuHJKk5SOzqHg4QGRmbPOK6ownz/PujTPp6W/Q/Hlm+z2Alt+RtEyc2
 o0Rd8yHc8nTAtjLw3TUIlpN5tPrD2HJcJYSbFQwKH2WC695nbxFVNhIcXq8/9b+U9Sg/sXgeULe
 Yw1ahvuDFPR65QL7+oa4ZnPmBMDqy+QkRvJZI8QOXwDOyuQOinfw75gMt8beA1X3t7uUg==
X-Received: by 2002:a17:907:c1f:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c25b3d6fd4amr456526666b.18.1788268691193; 
 Tue, 01 Sep 2026 06:18:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/58] target/arm: Implement FMUL (multiple/multiple and single
 vectors)
Date: Tue,  1 Sep 2026 14:17:11 +0100
Message-ID: <20260901131732.2263947-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260826174213.614571-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 15 ++++++++++++---
 target/arm/tcg/translate-sme.c |  9 +++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e1bef9987b0..60c7cacc10e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -219,6 +219,8 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 
 %zd_ax2         1:4 !function=times_2
 %zd_ax4         2:3 !function=times_4
+%zn_ax2         6:4 !function=times_2
+%zn_ax4         7:3 !function=times_4
 
 &zzz_en         zd zn zm esz n
 
@@ -288,6 +290,11 @@ SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
 FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 
+FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
+FMUL_n1        1100000 1 esz:2 1 zm:4 1 111010 ...00 ...00 \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -361,6 +368,11 @@ FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
 FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
 
+FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
+               &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
+FMUL_nn        1100000 1 esz:2 1 ...01 111001 ...00 ...00  \
+               &zzz_en n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
@@ -521,9 +533,6 @@ FDOT_n1_hb      11000001 001 1 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=4
 
 ### SME2 Multi-vector Multiple Array Vectors
 
-%zn_ax2         6:4 !function=times_2
-%zn_ax4         7:3 !function=times_4
-
 @azz_2x2_o3     ........ ... ..... . .. ... ..... .. off:3  \
                 &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2
 @azz_4x4_o3     ........ ... ..... . .. ... ..... .. off:3  \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index db1950f407b..463754b057f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -891,6 +891,15 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
 
+static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
+    NULL,
+    gen_helper_gvec_fmul_h,
+    gen_helper_gvec_fmul_s,
+    gen_helper_gvec_fmul_d,
+};
+TRANS_FEAT(FMUL_n1, aa64_sme2p2, do_zzz_n1_fpst, a, f_vector_fmul[a->esz])
+TRANS_FEAT(FMUL_nn, aa64_sme2p2, do_zzz_nn_fpst, a, f_vector_fmul[a->esz])
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
-- 
2.43.0


