Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0796C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFG-0003Ir-I0; Fri, 04 Jul 2025 12:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEo-0001Qv-VX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEm-0006WV-EQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9792055e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646366; x=1752251166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e4vy0WANG/EUmmYhw+UyOKc+Ub3sneFb8rRPaIkIhDM=;
 b=y79SvlmcM6vJ8RHHEKmDfv3TwmAihi8XWTmk9vJMq6zTJJ4h6R2X3v64QHSpT3mrME
 DeyZ3cuygkWYhiAKV9AJBTpP9CWvI5B8zsI1CuWbTKVupu4a/1GFfipY2w2D75rnMSVw
 COyV2vmcUaDFqwCgwfcLsG4x0m4Mcke2E1HfOj/cISB09xoHN8Ca9YSjXrpTVIJxP8fP
 dTRyDS092YKmj+UIxd4NAzoeTHi4pgKIevusKU7RG1dW+Wro+4y55SQRMhSM+R/ixw7v
 +roNoztXslNaB5FdWWMaVygHECnV0CbRve4yS7OcTgMebX5RjG4P+ClbVLniD/g9NQs6
 /d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646366; x=1752251166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4vy0WANG/EUmmYhw+UyOKc+Ub3sneFb8rRPaIkIhDM=;
 b=pBfAaU2hAHO8on6CBYk2dw49ljYCFTVQ5srkmzl/hQjUTgF0TVBC/Hyczks/zwICbM
 +kNLoWPyeKZ6SHrAxeQCFQBc13WDPg++Wwi4rONL/zJz69DP45R+8akaDjlvHU1FUMj/
 /pPe8W7ctXhRF04FUZ8B9CYY5/+f7jMuhhuSP7FI9KUOjcZIKQAXl4N43ps2cOptVwI+
 pCMTLOpbYG5Cwt0YX+8B5/HUq5nulBZcZ0+D4lB5LcL9LRKSL/wCG2nA5nMULGbPXBHF
 WY375FJRJpDLzUSLYAD4AU6kPAUW0r03UCHxKBdS1eH87ANAHYRm913Gyk07iLiYSLy9
 Jczg==
X-Gm-Message-State: AOJu0YzgRinYxScdxUY1FqRFXyDRHqlK1triTnUA4v+ncx2hGV3TsdEL
 y8tu6xXQIzNHIvE3dx8irdG6ZPolU/gX2YliSt1psfHdgNNe1qcs9oqeNsajHZbmndE03oqGwou
 6j9yi
X-Gm-Gg: ASbGncuJvFc98DvpUYndDdhsoajaCvOIsXIvwoXob5VyeqhGKXLKOVG3s6jg5In52Ww
 OVnl4M9jyp9fscUK1sf3jwR1Ngju+iDmjDwypiABDepX5EML9Dmto4dvBnJH0T8yQd6jUDj/bmG
 jmChfmn2c3lOhizZR0KABvksqMG3jejo2Ttd+10IyNLw1O7e+BEhQw6/bPgmUlOhJJykelgX9Uh
 x/lxLyUdpGTDpjfOZIG5ue1fDWxQBpWYdnTIfFniqPtS945iB37IAvFDRvuejb/VWmEFgPYiLvu
 KBY3pTxprYDBX53Wx1b7nVqdCG1+CRLyZQfiFp/sH+NYnhCDXGq/oPXr9sa/Fld8aGcX
X-Google-Smtp-Source: AGHT+IGU8p0GT0Nom75Akn2pGrqOj2DTFfGARAoMqGTCgA36eEXcdR+KbiFqrtdq5s5s4F5TVyOd8w==
X-Received: by 2002:a05:600c:3554:b0:448:e8c0:c778 with SMTP id
 5b1f17b1804b1-454b4ea5dc1mr26158555e9.22.1751646366518; 
 Fri, 04 Jul 2025 09:26:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 067/119] target/arm: Implement SME2 SCVTF, UCVTF
Date: Fri,  4 Jul 2025 17:24:07 +0100
Message-ID: <20250704162501.249138-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-56-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/sme.decode      |  5 +++++
 target/arm/tcg/sme_helper.c    | 22 ++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index be4621f2d9d..6314ad7e012 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -219,3 +219,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_scvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_ucvtf, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 79df2dcd2b0..449d97bd28b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -746,3 +746,8 @@ FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
 FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
 FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
 FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
+
+SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
+SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
+UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
+UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c696246d15d..d3841400ee5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1636,3 +1636,25 @@ void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d1[H4(i)] = v1;
     }
 }
+
+void HELPER(sme2_scvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    int32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = int32_to_float32(s[i], fpst);
+    }
+}
+
+void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    uint32_t *d = vd;
+    float32 *s = vs;
+
+    for (i = 0; i < n; ++i) {
+        d[i] = uint32_to_float32(s[i], fpst);
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3bf2b6935f3..dce3b56de2f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1370,3 +1370,8 @@ TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fs)
 TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_rz_fu)
+
+TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_scvtf)
+TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_ucvtf)
-- 
2.43.0


