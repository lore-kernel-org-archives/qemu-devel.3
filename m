Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFE7CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLIO-0004NU-D5; Sun, 22 Sep 2024 08:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHJ-0000vk-Hj
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0002Na-KC
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so757458666b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006480; x=1727611280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=A5WIVbUe9sWhZiblHzOYQR5NqVm9ELlEpwB78G8ZFZCEr/DYez59UbZddo7LCKBX5x
 kiBHtw0g1mlDuw4vcMbJ8l+kGBp9HbXdz9/FrVDFjhuZ+Qt5WkD7FPMNsGBQW1ptFcUI
 6z8SO5fjzI3EvzhihjlasveaYx7nMaYuJpfERtwyGufwdnoyo1Nivg7AG5wbtgRPgMMq
 Ueqa+DuaAfuISE6+l1Uv+WqY9XbnQt0o7FKREgN57BW7h5TvokVxZxyqYemdtaMZ97Q9
 lUJWnwA66jPxQUHBTHa9vEx5SdyVEBNV9Ky/juzj6lV9GniUCo4ypyssRJANbJnrkvlW
 mQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006480; x=1727611280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=uxNu2+/i03FORhXmZiYDMSQEOMWqM6Pj/ClI2UwRUWSQXDrQGhPqxUrj0vi1sUQU1S
 4qJOFpZAYEJrCj/D0cURNPWYkbwyRhEhAnatCFd7cxXpfTIUB1uFg/HvyB2ziTqFCmwS
 o6xZgDRI1InE0S32XwvC4bbKII/n0Rk2Hv1vKqohGKC5gzBfXOGA/vgPIo0PmYlaTNTP
 JxXc3eshOYsneoJ4Qp0kmTEhXYzoRvNlwe1kyFb1h+QA4o4vfsVzbRKPVaSsj6NOJorW
 0FnqvNx0k8ZnWl5y6HS88lugjt/sNzngD46Mfo+h9LpV/gYQJ5iSKO9dZKe/FyFvuGph
 PjMw==
X-Gm-Message-State: AOJu0YyegvTput6eBo3msNDwxf1MOYO5GT7fGvrAxEAOgGHPPgRBpRHp
 AoAvnsN1gzIFoRtCZ6emFgedcYeMDVBGO44Olt/8eJrpIHdKXGzWQJ3ZrbS6fKVrr2n/VpLygNW
 71CA=
X-Google-Smtp-Source: AGHT+IFlTFiLDMReLzgT1AUA6p1qXDG445FXaLOAF0UNnQtK3E8aBtH58B08xNsNOFkqZD9YtpSOtQ==
X-Received: by 2002:a17:907:3ea2:b0:a8b:58e3:ac1f with SMTP id
 a640c23a62f3a-a90d3510a4amr858043666b.12.1727006480395; 
 Sun, 22 Sep 2024 05:01:20 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 11/31] tcg/optimize: Optimize cmp_vec and cmpsel_vec
Date: Sun, 22 Sep 2024 14:00:52 +0200
Message-ID: <20240922120112.5067-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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


