Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314AEB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFu-0000Jk-SU; Mon, 02 Mar 2026 20:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFt-0000Hf-1g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:57 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFr-00072f-D1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:56 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82742aa5a3eso2411480b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500134; x=1773104934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4H0tu3d5++g1zytIQ8nF+cxa9Xqa73woawx4zTJDf8=;
 b=pPl/RzEcxUTo88HtbC6ajxSLjKbcqAGwrD7o5tzIqGcV89aN4M2FBVhHp7TRkbi6bp
 gjfeBSJ/Okfc9IDDpH27QkITDqxPanj0boBLefc2Xse25EI6jcPca5Yz01LJQ068Js+8
 Zri0ygI57Q2HtigqVrnFAOZIvx/Pmjn+mhxpVf0DxS71Ju/g+xuR8k4W7WOPMNQcMSaf
 Wh8RKpLMaP4ihdn/EFmUil4PyY+yuNmMBk5VE5dcLPV4eolccVnkGx1oT+yDcknjH5w5
 G1hLMak5bHLdmr9eiB17jn+30LOBVPYAhMrzEfaxjE99XHbQZ5duagdCarr/r+2PXIsq
 FUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500134; x=1773104934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c4H0tu3d5++g1zytIQ8nF+cxa9Xqa73woawx4zTJDf8=;
 b=G+PFLb8jTM+mL0ozhnPxwP41wPkIESU5yeeQYmsEKgmhyIiGechItpwTAPeELj7F4N
 SkPxU89rUQPpItMTQMkZL0FA00lQ/S33MQQ9WieSmwM02w9nzbbD2bWbn4IZPmmt3o5C
 dAaY+cYemiZTXFTnlvv9VFlyHOBnizmg2nZl0mQyWkCm15xQR6r1uoF92y6UNNMOm44X
 E9kqocpuP6rtV1Hx5yOWPtUa/qT0WT3mq/JE6fDutMgdCzRGRX9O3ymGN6MT7G4lEwOs
 qcQwEvBXee7gM+eCbbhR0xxilpsHFY4ulbsKwMc5BFvgVQ77NQmrZDH9bK+PMSwIeUlm
 qKKg==
X-Gm-Message-State: AOJu0Ywv22AxfFrA5PV9JG8wICwI+bkjeGfpSZmddsXXlJNP4o171sFd
 VeH3A2HWnO9wq9AHxRBBaFlYMHS3SwK5AviSPg893lR/swOmL+njpqLPL/wDeDhheKL38LStxm5
 rA1V7UPk=
X-Gm-Gg: ATEYQzy5BnV6rMvVtSAGFQiFkBrMJT/E6OY533M4LKEtF1EsI4RR3WApu+1tuJUdIxb
 Cmcd/6iEJSgP/2kkhPppMYsSYj96DaePyUMa2gfGMeawKdzZC3UGDq02ATnptu7Jqjo1pVWf7F4
 c/H0v4jd1Iv9v6AqNKum5grGyBIhp9CGPlE4Bk0ORk9kl5y+V6JNHTVou2+PXAyWL5IoWj9HNrv
 Xn8XPcqmnKqyO38LZGHxGttH9Hl9MPGll8Lh7pxeTs3XakuMyrxe6bsrnVCF2xwgwOPoUVHl4Pi
 tPMNV5z7SmZp+qPIvB1l7UEpHz9fNuSL5+pU/IbRV3v3+8gzh11v+ZwXV5ffuh1F8KoA3JVWxEU
 8STJ3PpT2ukM8XYP0B3EOn5aeD7k5mIY8ewp5gDdUJoEndBYquJzZjQQti8UuVCdgejqmHQyjlD
 9l/ZuA59sw8mDWGmdWHSoQObTsg5OoreAc833/W3mb
X-Received: by 2002:a05:6a00:2c94:b0:81f:4164:79b0 with SMTP id
 d2e1a72fcca58-8274d9e9b3bmr12625288b3a.31.1772500133894; 
 Mon, 02 Mar 2026 17:08:53 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 6/7] tcg: target-dependent lowering of extract to shr/and
Date: Tue,  3 Mar 2026 12:08:31 +1100
Message-ID: <20260303010833.1115741-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of assuming only small immediates are available for AND,
consult the backend in order to decide between SHL/SHR and SHR/AND.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 13a56d89fa..d8ae57d604 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -907,6 +907,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint32_t mask;
+
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -922,8 +924,10 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1u << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        tcg_gen_andi_i32(ret, arg, mask);
         return;
     }
 
@@ -934,18 +938,12 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special case of 16,
-       so that we get ext8u, ext16u.  */
-    switch (len) {
-    case 1 ... 8: case 16:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i32(ret, ret, mask);
+    } else {
         tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
         tcg_gen_shri_i32(ret, ret, 32 - len);
-        break;
     }
 }
 
@@ -2121,6 +2119,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint64_t mask;
+
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2136,8 +2136,10 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1ull << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        tcg_gen_andi_i64(ret, arg, mask);
         return;
     }
 
@@ -2148,18 +2150,12 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special cases of 16 and 32,
-       so that we get ext8u, ext16u, and ext32u.  */
-    switch (len) {
-    case 1 ... 8: case 16: case 32:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i64(ret, ret, mask);
+    } else {
         tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
         tcg_gen_shri_i64(ret, ret, 64 - len);
-        break;
     }
 }
 
-- 
2.43.0


