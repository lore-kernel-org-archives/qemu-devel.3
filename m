Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F58E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlx-0002yP-Mj; Sun, 22 Dec 2024 11:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0002dw-Dk
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0003CK-O9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:10 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2165448243fso36705735ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884707; x=1735489507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dR1ZJoylRY0HbnfbKvrZnityRIGONMEzA8Dkw7xL+N8=;
 b=hfsFOujuquOPOnOzFcRlIlUeuEJ0Q38MBlB2Z3cKoif5w2cmWCkoexshlBBUZd/AlT
 n6Tk9+20oy9QY6rvXse2A56dlYpJBUwvpWBVETylBXyutEXTtMM/nB9KuEJZ2+1emX81
 2p8VvChCkmyYBdXkC1IABF7mIegUFTRrqD5u6i/jZA3gHm8VriaHpKD5zYQt9VOum1jw
 mP8Y9DHZTGSYfgJ8AkS1JUU5UY8/9lXitqJkCPUXJv5tR8CCYaEKZqrVXZ0rNOQz4wow
 YxPwDdbAbNGpX8dDgNExYwnJNpXjywUG8bOWC4v/R4rYLdfLr1EGoWw6jxD8e031/dbL
 Sj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884707; x=1735489507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dR1ZJoylRY0HbnfbKvrZnityRIGONMEzA8Dkw7xL+N8=;
 b=cS1HjMfj4v8QezCOmfESe9vQjBQct2E+kHFklJ3iJ46OtI5VnBWWcHHs6NxPzmUfPT
 a2xVXDfsdVo2ZCD/bvCE+gracbgKaHB2iioPc0jQhfcqnWNYPin2Atw30Etsp4rBBxZD
 1bG9nDwZTWvxjx17BXjUSNKgxDE4izG+YFL3MjZi6mKzqLS6doJYFaZdXxNjnULaRdgC
 E0GWa1fvXWYE0rbsP9C5544JuLPkmc0kHG9ipBH9Z6Su9S2LAs+mzA2gebqDq9yESvVn
 ofARws19jYVa1Rlae0iY+tuxsz1VwDtL3YJz5KH50AFU2VZ6Eh/9eoW4/n6r1cus0cet
 MB/A==
X-Gm-Message-State: AOJu0YzpXeFOzXkbFjfPe2h+RYoFx/qQGA+MUDbkJZ4DjjtmStPn8J46
 6tgnBkUgVjFjRb6XESCGatFlFk/NyKVtW/HQR0lRXheaQK2KhvilSIWWu90+pBrX6xGEQgR5RFG
 m8Mg=
X-Gm-Gg: ASbGnctkzlDmNqb0yr166ZgkdkrzxYXaAW0oMJaTJ+yo885R5y63lPgBWs7eM5Bzrvr
 P0ssoFCMSXD5ovuyvE2D4dk3Hd3UDSd/KXSjLgiuAIWhSC7FNLC3LRmJq+H/X91dqN2ZLVc4NWS
 bs5jxc88UPhN9SD2dcG7nIXsGilDMTAJf4iCFEh9lsL8nsfCfYh1m+e8aTwSYEl8m6VQ6CTU50J
 v373vNm98Ulq6907Qd39K9UX1MGueB37vgfwCH/ZZHDJtcyQGbreIeHolnFWbQ=
X-Google-Smtp-Source: AGHT+IHL2DZO0S++edcls+HpI1TqtVaxaDIdp1Pr+WYYDSBFZmUBYpXoNnOP3rFpM2KcVjTBix0OWw==
X-Received: by 2002:a17:903:2cc:b0:212:5786:7bb6 with SMTP id
 d9443c01a7336-219e6e887d0mr124235135ad.3.1734884707433; 
 Sun, 22 Dec 2024 08:25:07 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 31/51] tcg/optimize: Return true from fold_qemu_st,
 fold_tcg_st
Date: Sun, 22 Dec 2024 08:24:26 -0800
Message-ID: <20241222162446.2415717-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Stores have no output operands, and so need no further work.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0eeff6c6b4..dce68ff2cd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2126,7 +2126,7 @@ static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
 {
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+    return true;
 }
 
 static bool fold_remainder(OptContext *ctx, TCGOp *op)
@@ -2689,7 +2689,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
         remove_mem_copy_all(ctx);
-        return false;
+        return true;
     }
 
     switch (op->opc) {
@@ -2713,7 +2713,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     remove_mem_copy_in(ctx, ofs, ofs + lm1);
-    return false;
+    return true;
 }
 
 static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
@@ -2723,8 +2723,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        fold_tcg_st(ctx, op);
-        return false;
+        return fold_tcg_st(ctx, op);
     }
 
     src = arg_temp(op->args[0]);
@@ -2746,7 +2745,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-    return false;
+    return true;
 }
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
-- 
2.43.0


