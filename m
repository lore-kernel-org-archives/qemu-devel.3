Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6AFC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5d-0006Va-NB; Tue, 11 Feb 2025 11:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5X-0006TW-7F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:19 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5V-00037N-J8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso2440192f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291176; x=1739895976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5pvvdwtaRAuWUBeLXdtYT01E90XaKGN2JSz829Nr8n8=;
 b=bDUGGj0zbEogxUTb0nzpzjAZwUH1JTA3yoNQQimLy5ykdQ0/4aezIBA585Isfelbwh
 AhJ0vmk4Y0FqtfVI5Ei/Ab+ZBe17QptGIFHM4QpaBVaQFnsBWUL0A2m/PlIlfBwLtc4s
 Fa6T/sEF1bVHObbeMNOSTm9HocS8HAbtMnI1OixcYUHSBGtThwWYTaosvBFpeVDGiuyh
 6R7mXVXpZNL822L8Xp9jP33VvVLgGAbIJ13MBNkf6UE/WDMBH1gOiCCPAPZQh+2fFtiT
 RZ02MCzzXyemwtQ3Bnuuy19mTEGGaWFAZJZXdWTm0d3yXqfUCoVJCLUKbf55U7uhn2wU
 gL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291176; x=1739895976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pvvdwtaRAuWUBeLXdtYT01E90XaKGN2JSz829Nr8n8=;
 b=CtSzR7bMbxKleLV9thNWGBfjZTAhFo9a7PnMeZYcq3nCJnwp5v/0Zmqg7Crxmc9OBZ
 R2ZaETgL/8N7iw3d9eZDLvFbJPRoisGgMbm8EcCXHFQWr+pZoqXplceHRf1kb5+WkxSo
 PWtDG069SUYalyBbCmybUdDfNoifjYuI268l08uJSEdgF9j7NvzmHYL9zDTNh7pnb3rT
 xnBdFdkg0B2cWyvRb1y3II8qNeEZs0hHeqXRhNc/YImwy+OQK0SRqQLSWluzxM8tjT2U
 vK7mDMzoKCWhWhd36ZMa0OWdGfrcSj5VRW5C6Sn2XF6uEu5Q48WFelzUwqt5/4EycRDC
 6L1A==
X-Gm-Message-State: AOJu0YxsUQa6A9Bj0Uyr+fV8mGCsIYRVICbgNoXOcAXhfgwj516qiQ4M
 V5acCYfg5d/JYO9RsVhLd4YMQtm0Dfnlt4eAgvOIRwc9xWon/8wZCzfCSYSQ3igYfiZAl4IcvCm
 p
X-Gm-Gg: ASbGncupINDFO8MXKXtyqvYR3LUnrwSB/8GauFXmkUrqv1x7x4mrSc4yFopRwalFRu3
 0F+U60419mf7YQyt+KuNC/TcmPz8UMD097FgTUYJFqcL+n9juxsM+xU736T9Ll5ez+eXRqCEclr
 5ZFwX/vKisJpgAl7zopv1F4/138JLkNXh1v0YThLwMJT11ppqLElmLAZjS8VKMedB1feOhm3PUx
 8yJIa9t1hFRGxq1ok8sl73UfxeUYY1XotnLwVf95IvuVFsxTf4E3qkj6rkWS+OSy3ZZaDDwNGF8
 wwp0FvZvmbaGq1smRoC+
X-Google-Smtp-Source: AGHT+IEGmze+eYALL8JET2t+gFwP8XbotwaTNRdbvUOpe6hLcqT4bbkPQf+pa9Um4y8d2ntKPgxzxg==
X-Received: by 2002:a5d:47a3:0:b0:38c:5fbf:10ca with SMTP id
 ffacd0b85a97d-38dc9edb1c3mr16607779f8f.39.1739291175783; 
 Tue, 11 Feb 2025 08:26:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/68] target/arm: Handle FPCR.NEP for BFCVT scalar
Date: Tue, 11 Feb 2025 16:25:03 +0000
Message-Id: <20250211162554.4135349-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Currently we implement BFCVT scalar via do_fp1_scalar().  This works
even though BFCVT is a narrowing operation from 32 to 16 bits,
because we can use write_fp_sreg() for float16. However, FPCR.NEP
support requires that we use write_fp_hreg_merging() for float16
outputs, so we can't continue to borrow the non-narrowing
do_fp1_scalar() function for this. Split out trans_BFCVT_s()
into its own implementation that honours FPCR.NEP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3f6e31d36a5..61ea2bb9f75 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8571,10 +8571,27 @@ static const FPScalar1 f_scalar_frintx = {
 };
 TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
-static const FPScalar1 f_scalar_bfcvt = {
-    .gen_s = gen_helper_bfcvt,
-};
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
+static bool trans_BFCVT_s(DisasContext *s, arg_rr_e *a)
+{
+    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_AH : FPST_A64;
+    TCGv_i32 t32;
+    int check;
+
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    t32 = read_fp_sreg(s, a->rn);
+    gen_helper_bfcvt(t32, t32, fpstatus_ptr(fpsttype));
+    write_fp_hreg_merging(s, a->rd, a->rd, t32);
+    return true;
+}
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
-- 
2.34.1


