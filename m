Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7587C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJs-0001EG-1Z; Wed, 16 Sep 2026 09:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJe-00016B-QS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:48 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJc-0000K3-TW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:46 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-483c65c2fa7so600669fac.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563883; x=1790168683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oogL5M0LRU/7QsuBliPckFPoTq3H08Xfq5xmzOdRTQU=;
 b=VwTB2fPNPA60mPDGFWPKx+CMpFhmnzlzmjvwNnQ7jLkuPUiiptlMaukt9aZFiZpm1K
 jzkECYIusxQRaEMaAkCk8aHqn3SBLAazAn7TMki4VR0mSU4RAaCOuacUw8zWF8QZEzwC
 Z9e1ItNzHFgFrPuCU8CIlZYoO9hbp+vaX1z/AS0xczVCFvgM8VaVrBStxPB83CecvTp3
 d+2Au4YysST4OYJomPvh1oEk8e/QZ4p55nPX7JQefi7GLYyqrX7pGTF+/npMI2KUZclN
 QrDxQyk1akWaaciAAK6zuuJuENnrsCU0ER+R/umLopjUWrW+oJP5NGzN8BkLUYJNK0SE
 bCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563883; x=1790168683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oogL5M0LRU/7QsuBliPckFPoTq3H08Xfq5xmzOdRTQU=;
 b=2mnB2Yo5tqNTKMtniTB0y/oYTTSQD46Oq/IcEm9f5ucsqNW5HIVTyXfTqKAPZdzNLv
 jSkapjVf6MpSHTW2gNg4KSmFX6yygXNvmPl3cwi8J9eOiqgaJBGKGOlKw47pxfURx3ea
 dBWbXcjG3v2Dw4bTVWvrpoqlXhNOfeJ2G/ldgfryjXlobATkFb55DnZmn9rbIsGEQFOm
 C/2RHTYUC6ncsihRVrvAbrqrm5/ts02JMQWTfuk52g8n3QJXoIyJJ7KecqDC39lqjsxh
 IyScJz3Y5jxFTebA1vbL3Wt8+UzB14bvkpX2ckkSI756VWRwHzBJC9tP8Efa+8hw8qJB
 GIRA==
X-Gm-Message-State: AFuF++nnRwMI7VKxcQR4sGPiALZ1w4DAgKxpFM3oJLuXqnMa8voqx/20
 EwLEyWykyvtm/RkdKTyEh91hQgSfwPlVmEWgNWcRA0jf+id/oVFd35voaXQ3XqVm1rzcUsC0Yll
 Ps7vzet4=
X-Gm-Gg: AYBFou0/knLKkcM+HEUonQVcuqSxfGSiJygRMYwGlpnw3aYjQfxB3GLhVm5X02s13cP
 6tLmWDcxPj0iQvjybmL06S/szwJWWCLjehJ5A+ofmeNeE9Usq9IT5jm/eX75TRpMRENuU6tQmFF
 YlNIcJ7etxCPIvyk/nL8UHxuQjMelnAsXK8feqnmY1PHpTPurjeI17WoVwB8yfvCxSNiAdsfonq
 1M0Z/nX6ELnaLERAY1qZC4AVrI90X2eB6PZZpXGhnOsXEb9mLZpFecUlhWpkKQYgApGv5Z5A9pJ
 Mgs9mAsN2C0tXu6v/VxJ9XyReg6DOl8WXv7TdyYTbvKE9yIt2WjZVaza8KJdt28YQEZrx/Js018
 KMC2fyRncgFZsoIBFuylrVTZl26g17XJhO49UJB+KuT0bIqwLY20/amJMgG8bUE3kc1sbj1lgAm
 Oa4MmVGz25a88dZrrqyT9qNSq1+OuIimCIS3ws6BL3cGfL65i7hZeMsCHpC5Ki9l5NYGxl0l6Mh
 NvLLWQR38WwexrvEw==
X-Received: by 2002:a05:6820:1846:b0:6be:456c:c443 with SMTP id
 006d021491bc7-6c7d50f55c5mr2362135eaf.65.1789563883478; 
 Wed, 16 Sep 2026 06:04:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/92] tcg: Generic expansion of tcg_gen_sar_*
Date: Wed, 16 Sep 2026 03:02:55 -1000
Message-ID: <20260916130409.3382710-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9bb5dd22496..eff7bf11d6f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -312,7 +311,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3f928d4cb8f..247d35bdc14 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6f6ab0a0e5e..c7e95dba241 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,6 +443,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -564,11 +569,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-- 
2.53.0


