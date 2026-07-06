Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4468C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggib-00078a-7K; Mon, 06 Jul 2026 06:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiB-0006zS-Iv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi9-0003Fb-Ed
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso26354655e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334280; x=1783939080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8FUejTYmodH0wqj+6a2DCfVObYS5abMbFRH/NIXkG5c=;
 b=ACKcplgl1UnmF4sXyOtpE0VR8HI25RvrO2J4ziaPEw7V9cVAJsAPixATYkBR6/LVxg
 du9fpo4ymZAotipDviTtebtLkMqESJHUQXDstw/gqBsffii5MKqj7vg2wTUEWMunjpAT
 uMrypBkbGL4cJnLrSmfekuNfcdmjox9kjRj3+tPvNO8iw1pK47CEBP4VnMhprVDQwONm
 W6LUh2H2I2ZL1jSUi5mEdS6PNHR3c9y+IhBhdBv8Yi/NLzKCJhvFt0iVFdIenL2DQWGb
 xkLP3nLADo6M6pPBzjGeEWsR26fqi3RquSE1zqiZa2DgpZzJ6HYfMPqN8PcTjSMKe2qs
 Xj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334280; x=1783939080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8FUejTYmodH0wqj+6a2DCfVObYS5abMbFRH/NIXkG5c=;
 b=QFAC+G12hLesRfXl90uTyJRSHo/Uy7rg3M36FRSGwhCUuki1fy2yMjcAdQHCv7lJRh
 Rw1NH3cgDsu66nsnqyFLQB1BViFo7skKJoybLL7K/BBRBQLdZo5Im73nYxUavacZ+QA4
 H00pYD/kZTCmw3sFrhr2sl7TlEIXdWIJaGCyKSMk0e5uFXjI7nVEexMz3DgnpZP6TUzu
 aIZKYbjRFwDW5oO/Lf8NzcQis+AVEF7aB/d3+g9tZB6KvxcfDOwcVFMQypAO5J4Ik1ih
 ViPTRrqhuDE6KFCYgfiorh84Gg9n/8gtB7kkXBd4u4sa+EZiqfxyFD0P6TOB+lhDwyTI
 z4Ag==
X-Gm-Message-State: AOJu0YyV9L/JAZWCBjxlGxFVAvU52x2ImnHl8+smI06Uf3st/W2/V+Yq
 G5+rm6r+hCYgsgfGjOEMIsDc2u4+wJqVY0laK/e4CE7JE1UQG9prJMKgnGRNInX8qnYbY9tTpvn
 bHtKIn4+yNg==
X-Gm-Gg: AfdE7ck6xVCOkKyqIjqmgr75FTmjQxZccc0rn+RJfSW9VYAlmh5caVk/ISH2pW2lBvM
 P03IYMvkwGRHu/+8DnqgNlLw9XHW15Os/VGVbgm8ReEPeTqc0k0fAeJ+4QAjyIk4w+sDue4WmfG
 64WWQV3m+Y4ZdSE5nyctNjV8dl3TlaTtMYCTT5irZ5wZhjLe6d41Q4VqyY7Hpr4gUOXJrU4ZLA0
 bZDIcsBEyLeahI5gt0yEHuE1uEtiVcaJzn5OafZ0SpsxtsxJ8rhgH7pXxGIKia0UkpGZN90tqI+
 Wfc6ALK7rG1RcRAnuuKpLs694kwTDsE8U7BcRg1vz6eF0SLFLsNrfaPMTvRF/EcZC3Qgo8TO0or
 gDPXnQ9DRJvYegxhoCcZU4CsKxQITfJPCrxrfJYeJTnXPGXMOVPLaa17SJtI8jC0g7FDziEXsg1
 +Bgu2ENAdz550hJgoGcvjzu0/ItJX4418gTioCnnXNv2bOSMm/S2ZRLzQvgR63Db3r6Mesu+EwG
 mUbdD490Wie+SZhKtgI8g==
X-Received: by 2002:a05:600c:8716:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-493d11ceed3mr101859095e9.5.1783334280012; 
 Mon, 06 Jul 2026 03:38:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/49] target/arm/tcg: Allow vector FP conversions with FPRCVT
Date: Mon,  6 Jul 2026 11:37:08 +0100
Message-ID: <20260706103752.320511-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

FEAT_FPRCVT allows the vector forms of FCVTXX and [US]CVTF in streaming
mode which would otherwise only be available in nonstreaming mode.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-2-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


