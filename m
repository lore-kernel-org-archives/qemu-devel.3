Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6587FEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYX-0002JI-U3; Wed, 11 Sep 2024 12:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYV-0002An-Oc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:59 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYU-0003fR-5h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:59 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db174f9050so30673a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073457; x=1726678257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=FlXBPM95djXqNx3Cm/ZUu/skoabuT4/rvdoEIgRp+jdM+Whfwczis24DJyL28ibXAG
 3lKAZW0fVBA47XqunI6+DRHrFqWetkE46Nt0dMG/SpR9+ucSj8eUox2KwBApJDggdl40
 uu+5tPRBgb2MWZ4lTU68aj5eJFDYsny+U1qQKTGYz1DuOlkNZqjpXMcS8le3lKt2yP7L
 0i5taD+z4pOWt8MmSpAwlHyMSgj511YLzovK+p24mddpYx/P/3AchQpN7IFK66gHH7R3
 X0tsQtGEJWUExbmR59i0iHe/cg+IIPJo9MjPWUZat1HcHsTvvJeXEkGEkLJhwVcL886b
 lmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073457; x=1726678257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=vzNMcmEPtAHbo2uHzyZqAQPGjeBjymD3aCAxdt5lUjQ7UuO6umlj0UfLSm222E/6Hs
 u2adYoeM6YidjhFeh+nq9269pRGqTatODrJGa19VQuBnbh4WJYwDPIXeha644WkivMAw
 z5O+5+J2jlmdU24Q1P1OieDd16yp0khkCleqZxCdtH67Iz0FswRsJXOUaVW6rAtCUkb0
 wGQ37CF/RWtUyEBLMqHrGd9ZfzZdCELrZ8FGUS3ivQa/78ZXqdp+cBjoCdYOfkGRMODh
 0vgzglvSb+GVtUviPHEAGNDJTdqcy5+FG2kf3mbeFNivvWwLT61lTkEholKl/DKHXKki
 mcJg==
X-Gm-Message-State: AOJu0YzBVRcvavn+fr99Uy1LDkuD0azLmos+qvM7VsJpU+ZuV3X1UnfV
 vTFUr3MjHOGu0rnu66/m9SaNoBVtrkLR2Oxf9VbPTUvF/uEWlhJ6xxgkx3IrdoWTvqEaFrUn9xV
 +
X-Google-Smtp-Source: AGHT+IFOMOY//SS+VRTmGq00IjikX+qfk2DEF+o3pPHtEd10lPMxlyL5IBu9kJxGIO4uUzaKC+xIqQ==
X-Received: by 2002:a05:6a21:3318:b0:1cf:54bd:393a with SMTP id
 adf61e73a8af0-1cf5e15780fmr5944984637.37.1726073456480; 
 Wed, 11 Sep 2024 09:50:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 08/18] tcg/optimize: Optimize cmp_vec and cmpsel_vec
Date: Wed, 11 Sep 2024 09:50:37 -0700
Message-ID: <20240911165047.1035764-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Place immediate values second in the comparison.
Place destination matches first in the true/false values.
All of this mirrors what we do for integer setcond and movcond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cf311790e0..f11f576fd4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2422,6 +2422,36 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
 }
 
+static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
+{
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[3] = tcg_swap_cond(op->args[3]);
+    }
+    return false;
+}
+
+static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[5] = tcg_swap_cond(op->args[5]);
+    }
+    /*
+     * Canonicalize the "false" input reg to match the destination,
+     * so that the tcg backend can implement "move if true".
+     */
+    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
+        op->args[5] = tcg_invert_cond(op->args[5]);
+    }
+    return false;
+}
+
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
@@ -2928,6 +2958,12 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_setcond2_i32:
             done = fold_setcond2(&ctx, op);
             break;
+        case INDEX_op_cmp_vec:
+            done = fold_cmp_vec(&ctx, op);
+            break;
+        case INDEX_op_cmpsel_vec:
+            done = fold_cmpsel_vec(&ctx, op);
+            break;
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-- 
2.43.0


