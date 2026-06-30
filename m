Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8095EC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYLJ-0007bI-RB; Tue, 30 Jun 2026 09:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYLH-0007Zb-BJ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:17:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1weYLF-0005sc-GB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:17:35 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697ebe536b6so7222800a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782825452; x=1783430252; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EnmqstppYm7egx9WxBfPh12eLYDVWurF4oPXVuOIX+c=;
 b=wfbLrV4K1jnK2eEaTRXS5qsOev0V7soNcWKDSIFadOVyy6emzYXuCQAQ3J4dgFl5Aw
 eTKZHGDArpxyPnIKumqhroxawEKg1aITgPjlBDlJ5aJzdMv3No7xAlYHIjCcLTIOnhXV
 ylVCi/5OjMSgW0ENkVsgJAjEWP3sti6cNT82BCf1+J7/FNxB1PYPVP4FmyBpyc9v8jBF
 YHkDwo1M+7v6lmUHPHOnvF9m0U+diU1fErqGLf9mqkI5zFMtqf7Qtb6BSlS4/rpTjJDn
 nOMcEP5cqCGo8xjpGwlVuRtqzzrWSsHyosM8Ywm5GninWw7sRZX266hQ2jHoTNa8dPoL
 coRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825452; x=1783430252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EnmqstppYm7egx9WxBfPh12eLYDVWurF4oPXVuOIX+c=;
 b=lOp4UFpz0RlYw1p7g/Ao7210VK+gAxXhOp+fLyqOxsM5pUe76yalSTC5Px2nEBmFsq
 681RypHAoCyWPzzMACtjqqB9i7QnDKPvqNT/7eLzPOkQNdGIaKUMPS7wFnK6PwKIkI9X
 qO36txXUUzT/GPBPaf/R7i+NyDcNpSdYsuQ39Dfxb9Iceq5J9Skn1gnyMG+oEQfiPMkR
 X7svQc16gyomxLJ4VkQN0tVqpPJA+pVYPbedAVlctLTk4irunC3mGKVoPumoE9LLw8px
 v8da7d6I/hcKbTrGZospmoeCmPnHMZHvgioUhlUIYJF49W0HTD/ZXsUX8wwUmNqnwr9y
 3pww==
X-Gm-Message-State: AOJu0YxSFSWBRfSoVNpnKYzDWqt5okwHXs43xTk6eDxpTT88AmelBDY+
 ZnqNcFjYkLWrHyqj0yE3FG05a4ygv1AEDHk8B6Ng5ZIMO1c323ZcOViEIUOi0S+83Uc=
X-Gm-Gg: AfdE7ckAKne8yqSggqzqxXbeZQqXXQOyvP9TRqfMjoQQ5goMq8XO14NHKGV/7Np2DhF
 2s5WWcKlxKn+Q4rwECi5LaDCQK+8yQ4uWD4lCy2YXq/kwRhAm9KeMoZkMS32fgXD4IlgsRnFsBw
 ubJk4E/Ak5W4Xaqpe5DlWvYUD4UaxGP3tHSxhW6PPCcMvlM13Rt1W4WfljAmlBqGScmMh0XPNXU
 dAg4PSyiP9uh1c4J9dGUZgDsxeRpWlqcSrz+Uq82+ywRGhbA0W9fvwO++atYHxMcwqDKg+bYZCl
 ashullSMvO6l5bd0HTB+7zQ5ychJpjVx/XugJ/egANyzi1UAaNO2xEaap7ftOuBqKYgqQDKuIQH
 DDp6dEerUjmRoeQlLzPY5tZ5AFW1V++UAqQ4ZwdzW+HnfZD/D4mbRCfyIT8UUJ+QqNmWJSnNH6v
 jG0BKF8KBxg+T9SFg=
X-Received: by 2002:a05:6402:1f01:b0:697:fc6b:10c2 with SMTP id
 4fb4d7f45d1cf-69879de6968mr1354762a12.16.1782825452064; 
 Tue, 30 Jun 2026 06:17:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:a648:9a45:1aff:ca47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c3a42f6sm1201535a12.6.2026.06.30.06.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:17:31 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 30 Jun 2026 14:16:33 +0100
Subject: [PATCH v3 2/6] target/arm/tcg: Allow vector FP conversions with FPRCVT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-jmac-fprcvt-v3-2-f4840d5e0a7f@linaro.org>
References: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
In-Reply-To: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x534.google.com
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

FEAT_FPRCVT allows the vector forms of FCVTXX and [US]CVTF in streaming
mode which would otherwise only be available in nonstreaming mode.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0da365e345..2821c84843 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9915,7 +9915,14 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp src_mop_int,
                       bool is_signed)
 {
     TCGv_i64 tcg_int;
-    int check = fp_access_check_scalar_hsd(s, a->esz);
+    int check;
+
+    /* FEAT_FPRCVT allows vector forms in streaming mode */
+    if (dc_isar_feature(aa64_fprcvt, s)) {
+        s->is_nonstreaming = false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
 
     if (check <= 0) {
         return check == 0;
@@ -10073,7 +10080,14 @@ static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
                       ARMFPRounding rmode, MemOp dst_mop_int, bool is_signed)
 {
     TCGv_i64 tcg_int;
-    int check = fp_access_check_scalar_hsd(s, a->esz);
+    int check;
+
+    /* FEAT_FPRCVT allows vector forms in streaming mode */
+    if (dc_isar_feature(aa64_fprcvt, s)) {
+        s->is_nonstreaming = false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
 
     if (check <= 0) {
         return check == 0;

-- 
2.43.0


