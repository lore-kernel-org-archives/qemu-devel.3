Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A04CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2z-0002E7-A2; Fri, 22 May 2026 18:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1W-0006sU-5g
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1O-0002uY-HE
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so39162785ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487626; x=1780092426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axueN2q8mn3qRCfoeqYJwXIA/rovvl2ryGFKh2CkQC8=;
 b=wxoSNMgQxFKQQyVFkl3fMVYSA4YTuJnULmcRRfqYTumIQjlVW4cvFDi1EpCwiEz/Ld
 yoaDgd32jn2ptxH9+Y2fGwALG2JeoYKQhoAjJWfJgns44/GnG0lRy37h0gt+RJ0NDr4e
 7KdNqyD3OS5rzuWBf9GmE/u6QbpWwyoGiRjB4jOLrYSqhYIjvy+JH1IM31S2mydw68fE
 iEwcfs7tpcj/w+wRS73XK2lQh4M60xmr+J5/r92poXCoQm/d/+BEPlOaDDxccS3Y6rEE
 UnXT97tnmGS8tr1JxajxaBh3bk0gVZsVDWOXH9PjKKP/Z0CFnQhMYNk3s57JxIK4ZpHo
 amiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487626; x=1780092426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axueN2q8mn3qRCfoeqYJwXIA/rovvl2ryGFKh2CkQC8=;
 b=XYdzDHt3Tm3/IOcutLvKDjhqGTfpp1cDHzScnChcGiNQvAuEOyRrDJtlbV+vMs5aJw
 I1Ei9+ngvTjeU+G3+siGqDWJxXPPwKyBAB+fwhB6LB6zuR1fcBhpUsIOQztKcQEnMnI1
 4dwoBjdnpLmIneKQy+Iv2DGJltchIuEIDDayHL/Nr84T1OzHaQuhzcZbcUzZJn+YvhjA
 Z/mLm7fC6NLyL8/+oVwy3occfwxrgC1mI0EQowm3WZkuWSI3OQcInGFGplKe5Xi+WQJ8
 ThTxmEKoPW1K4iXQkkoFrAGcCfLcag5WH/v14C1VbV9LiE712jvWp4nKeVP5yQyiImeE
 AMmw==
X-Gm-Message-State: AOJu0Yzjy9cWZ0mPyS4om4KDqF/hOwn7wRXKTND17XH4iDME2hyUqHKc
 92/ery1uxdkvAbFqRKtEHPCLciqxvYhJzDSm2q+YEx+e7aOcbkeB+xnIurxnQGYd9v9J8rqMM+A
 MTEW9
X-Gm-Gg: Acq92OG8MjgvEoX/GH4munvO1SoJnz7eOFMmjVkhTAvDuLoO/QzktYSbGjxtBR7Sn7s
 w+BNyoPXQ+qqU3feqB8rpJT139jjoLriEOnkwGrbvAOgmTpV27xlTkJl1AlxJHodpjJS7WMiceK
 07SY7UAibmN0hnXhsTy+P1sOl2vIniQjoNXQARlo4W0Ezm9TdRlFPSvEs41S+f2DeWelkV3oPt3
 xAIYP7mdHfp4bGUEIQKZiqLU5nCcsXAYBihyVYe+WR+lyqH82L0CAizwTsYaIyo+KPN6RILIJAr
 3JAMN30BTNAAeuuq1JOSe+p2cFBmKgis2FyXtHNilKCdKN3KRDWeZl5WRn7o3K1OCR8gcU8XX9J
 MymiB8G9r+mnSLYxJZIF1NbC9UtK0yTjUOnS4JkwnD1T+P3hB7XzlxnvJHWldYBxLscZVfY3jFC
 2OWREjMpX0rq1YslwTKPtdUxYJzSQo
X-Received: by 2002:a17:903:1a84:b0:2be:3850:297e with SMTP id
 d9443c01a7336-2beb07726a8mr54009755ad.31.1779487626102; 
 Fri, 22 May 2026 15:07:06 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 63/64] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Fri, 22 May 2026 15:03:05 -0700
Message-ID: <20260522220306.235200-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fce38dfbb0..3eb08da6df 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1703,6 +1703,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 510d8ed3e0..ed0792da71 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8476,3 +8476,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
-- 
2.43.0


