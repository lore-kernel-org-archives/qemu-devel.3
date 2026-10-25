Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FF606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p0DyBgjZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWD-0006Fo-P7; Sun, 25 Oct 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWA-0006Ek-Mt
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW9-0003iN-0e
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1227128f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912783; x=1793517583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yEiHVW8CbPby3eVHbhaymh9jUeIciwA1XU3tn+pB+B0=;
 b=p0DyBgjZ5XKoFInT5uEDJcTamimpA2Z/3Gp01Cng1NId9ypN0kqBInqnyoGfjV91ei
 /ylE0TM2Efe9k5a5ArNX7j5BPXm/RSO9++Pb0l8w2FJwH+xXEZF/M67TQMlQVUalgaX9
 9PMIeE05bHs4Cr0YWq4Aa+iaZJGX62Cai1+cgnMlwH1K3LdeD2ac8FgZqXb0idHovh1X
 hm71RVkbQmoEXKKfuKqnfGTs8Ndcce9AGwETtnmL5JcsXFfdHq/sSJFTMjU7cf+Rh+nu
 f7MZVkP7FISHlqd85R48dw+gA+RT0CZTAmfax6lzxPuMAY1ACrDeCx+Z2Ww0JRTX4uPi
 4PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912783; x=1793517583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yEiHVW8CbPby3eVHbhaymh9jUeIciwA1XU3tn+pB+B0=;
 b=c/KCIUzSdDqvcwACaF1NVAdnBG3i22hdV19wjvRYLrRT8VrJwmC40kG4FqoLZKUSYV
 X03ztHdX/S0bVHMNM6JAya4ZkdG+oZyEWDHVfxdqoLfb7JK52DLLYtqqU+vausqxBmvh
 +VMKJuzc5xeFd8MOpPldlnmeDwCjSPs79+yVUTR7Z0JwITUPA9G/HDxrMfSl3m54wGTt
 wx58ipaaAn68+BanbLlmZHQt1JoKRct8TmyQm9WLuV9YNpQnSk1bgbszPKEMEqg8tqT9
 gi0uujGMwx+PCxAoMWgHtxRfOZ4TZtRWz2L2EBrIcV4xUdGCgiNpeZB9PaN5qjfTbvkt
 FByA==
X-Gm-Message-State: AFq9FYKCHc48l4o4H+IRnvc9WdZsHpvRJEyrtRE7/C+VAWrDobKCxIwk
 43k6bQK0xLf7JcjusirLVHb20aFntEzfrHbyZkyMHcJ9MfIJHW3+WOLQpkjxgDCuK6/SsCw7IJ6
 b1o5CQlI=
X-Gm-Gg: AYBFou1R3QGd/AjCqjfjD6MOYr7QZA8atIcPmRkXzlAdSAMklVlyEM/6IwzVP0hqv36
 TeucXpuF6+YCdeZBmT/OOf9trrjbZBEw22nyAAeicbtfXbaTpQu6ImskXmM+UePrXXVPJJPfO1S
 p3E5KZuKfQ5aqLAfg0+MdFdvGCO7BEd1ggJqLqaeuEWPWzI14+lduYnREyqznGEbesFJnB1dkoz
 IjYZoBgSXgJstO6xoVdZYIgcJWNpck8XhHAIPVogPSF2uTzFxPvu6cRzJg1502WORIUhtwGNutb
 w6Yuc/8137FW1GzOckYgNhxE8vY6NYgnxMfdX7NCFTF/NomiXw4d/snol4nX+WSAi8QnWIapQkB
 griP2QUfSFgaPvip4rmT2czuQ2t3v918ss9DF9vPjxW861C4XetYm3BmxSnJptNt/fiPMLeEZ58
 0ADhCutaYvD+mSzfO6eUf9Za+XJTobyQklo9DarIwH+VHuJIriSlH/BWqIKT+smCug1xVHU4TZv
 yWN8Lej0um/DFPbah0mgv9ZXEJOqNQK04tRj4YVLW8Y/JJarg3X8LJesT1dV2hozzKh0jwsNch6
 Hfg=
X-Received: by 2002:a05:6000:288b:b0:48b:451:4f19 with SMTP id
 ffacd0b85a97d-48e3eba5e21mr6658550f8f.51.1792912783237; 
 Sun, 25 Oct 2026 00:19:43 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 021/100] tcg: Generic expansion of tcg_gen_sar_*
Date: Sun, 25 Oct 2026 08:17:56 +0100
Message-ID: <20261025071915.1123867-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96d351e634..74cff518ce 100644
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
index 573a4963b4..96bd6abd74 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3c98d204d4..07e7c83ffb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,6 +409,11 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -530,11 +535,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
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
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


