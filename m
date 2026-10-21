Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A760A261E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eLHHTUjg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8g-0003dv-Rh; Wed, 21 Oct 2026 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8O-0003JB-UR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8J-0001XU-Rd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so6200115e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592254; x=1793197054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5BEfPc0PaaubsdMqbi/Hs31godyoJBAc0xh/IZrGgxo=;
 b=eLHHTUjgNfbNQS/+U0i32s5FzLtPH+tUF5UdYcfc3p7srZw+PkKlB3FYRNkYzm4m3G
 aGiIfw5OxZFWeDpYaXy6SG9KocXwQSU5wBoo9hiWexNPrfSpELay2+iE3sFU8CshcZe/
 yVSSFBe3dtaNgX7/8imWFF55RuusSNy/P5WPH6yb3HwwBrDTRQiNAL6+Ua3o4MyhjJv/
 KLDsDzM7WQKSxN+Wxd93t7rX6IOqqoe7vbDdiAgdlkBQF+5GUwoSddP+2n+cJd8dBu1v
 U633KvJlTbHO1XkcM+BjS2+vv8jYvAh+weDOcXBRgJaxYnNzzyzbP7cDGdU2I1bN9Ktc
 1xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592254; x=1793197054;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BEfPc0PaaubsdMqbi/Hs31godyoJBAc0xh/IZrGgxo=;
 b=YGBw1BmqElHgpLpR0b2eH4C6FAU4B8iwbn7UqrCJQskUE7qgkVxdTppIgQ6KuUdxNG
 NqW0yhufnMuAeENCLKJCRXKkqQu5lp6azwXEQWOfDMFxhyIxF26RIn4xD2mW7CORubdr
 Q+oehGYXNuXcPeQYsQwueptUxmtTPEO45E2dBX3WOJCn2Ibfjo2GLDauRyedmvAyILVV
 bYgUSfniWYd0KkQjcF7zGJNawXxSZcabkL5xdxSXbVdKG2cehS56c/1xdzNggIJB70Y/
 UZ0FVpPF/AfiT3SEhjIb67zVY8SX4/oWWg5/RSq+Xm/c9G6UsEYGiHzJ+rkshOa6QZH6
 lA1A==
X-Gm-Message-State: AFq9FYKjTvUUr7bcb4es7dTkruR2x3DEKp4BvAaJRgbvfHIBbMv5KgrR
 wdX3waJMsLKM/wSDGZX9pr+WJE2guh8pPHPNaNDV+6Q/FSj+5rIcogrc019KLVkRHHyTQu5igQM
 zhUDH1Q4=
X-Gm-Gg: AYBFou1U+9xgdNSPeQGu5V7QU4p5sI9zitBmx6VI5Fs4ZPlyMh5VT9zOtCFCHZEVzkW
 EfdV+kgdw3su6thIx8OG+Azg8VT7belTKNYXW2GilmNxFbHeMG9hgLBnkD6d3UW/ws56vpeemH9
 2mOWMc1yae3bFQ0jpzfyyT92sdXHkAfh4bc4nxHZ+MQBqK9PRO/zzQJCNZKYV/aocDTubp7jljc
 dIvPnV8bCjmiKZDDTgvMADoBiVK6c3YWm1z0qc5uaXX3BNrj5I1q5A5rsYHKdzoqInVY+oOHgAI
 TdXFP86/2WQj7BvQhsiYGUjQm4uW3Qiw4ksVr9wxkxJsbypqA+byM8xDz2tUk0HA4sjoC1+rT77
 HJMy7R0iDTq0VpypIGssvfQm4RWSduVxSZIAi3TY+xtLNJaFGFvwoSgzWChfbOpQYOUcKPn2XCT
 fzcjT2bDJjRLn8lt6jlWK1lrr5YnDfkmHveUnX192+C0Hxp0YokHE3ylAcXh0Mtm9P9OSXHtodi
 dzhrqogiIhRzyAxYN7I7q7X2cNbEGbaWz+E1icv4b83yUD5dxZjaolaRb+QDZYUDdVaO/3g1TGV
 dOcqDcUxiRbDpZiGJvMENz1dmzo=
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1fdd245bcmr45940895e9.9.1792592253600; 
 Wed, 21 Oct 2026 07:17:33 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 018/100] tcg: Generic expansion of tcg_gen_xor_*
Date: Wed, 21 Oct 2026 16:15:30 +0200
Message-ID: <20261021141652.363109-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9cb9089a90..7ff99a7671 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8dd3929060..ad298b7e30 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,3 +12,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b330d0fdb5..5a0c7246d1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,11 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -472,11 +477,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


