Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B672CEE57C7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYa-0002U8-Is; Wed, 11 Sep 2024 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYX-0002Ft-1q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:01 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYV-0003fk-D8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:00 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-277c742307fso761038fac.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073458; x=1726678258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=aSuj+BuU9IXLkS1fISfjs6vBo67MaHDFyv2kTvaGry/gL/ML4xgQKUXXvbjWLDgm3j
 huoCk8RY37Gz7AKisSAe2hPCBr4rtXeLZuVVXNMbdAf6p5Nj98v7HMOlo7L806nJ7DSa
 F7+NMGqF89SQBb2Dm3TdZwXqhbqdMnmB+U4Sn9ZdNg9RWV6glagu794uU9FT8DTA0oRd
 yTpQO9l+vSKR0Dy2yDiYTrmTn9as1wMEP6N9GgT3Tzmeq/hapUcCl/EXsJcnVYLTnH57
 zm2zLmUbUTOnNlf+XvYyFIM2c0AJIro/qg2tCrXpDiDTdS1yKQxiZFw61TiQuj49FjK4
 wxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073458; x=1726678258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=WR2vAofLfQ5Zv9xZ8sT2P60XbQm5J6igtIfpAOx9pmkQHw4446+UmVcq2339K62UOy
 wS/yD7jls7KO3+x0ATmz5V6LcnQAs4HNx+GhY7EMUF0VgeXD9N6zDHWB3bvWiebhLlOl
 7QNlBM1YK2jkUS3W9Gtr7pnwHzkW7ut6gYSZI5EI+wwYx+94fC0FsOoiP3OMpfbK3dp6
 3toaLbGmX3eJRTWy8c2Qo0zP4sSQtTJw3x13lJItpcU0yfscmK0DEq+s/N5YC9dkSx3K
 BEZQ5he+Z31uoi/B2mkuHevH+ZZnqhc6pXFepzmqstcWv6LGl2kV+l5W3LwvdnCGhzQc
 RtXA==
X-Gm-Message-State: AOJu0YwYLgsb1gzkPD+KDgAhWpXHsclCfa8k76yCEjgjvIJ/DdeNrUBt
 kOH+p5XdOcsxDnJntS8Lho6sDDCGJ3t3ZGe2NtbFbpaswuNJcXHmVFijUiUXqiO0WnQDc8MBhAB
 1
X-Google-Smtp-Source: AGHT+IHuRXHhtD77WFfmeAFubyLtFkBWZJiGbfZsyo4rs84lAxbagniW6JV/l62Eq+sNyVxProCHuA==
X-Received: by 2002:a05:6870:288e:b0:278:234e:6e3f with SMTP id
 586e51a60fabf-27c1b53e12emr2798404fac.25.1726073457524; 
 Wed, 11 Sep 2024 09:50:57 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 09/18] tcg/optimize: Optimize bitsel_vec
Date: Wed, 11 Sep 2024 09:50:38 -0700
Message-ID: <20240911165047.1035764-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Fold matching true/false operands.
Fold true/false operands with 0/-1 to simpler logicals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f11f576fd4..e9ef16b3c6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2737,6 +2737,61 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
     return fold_masks(ctx, op);
 }
 
+static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[2], op->args[3])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+    }
+
+    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        uint64_t fv = arg_info(op->args[3])->val;
+
+        if (tv == -1 && fv == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        if (tv == 0 && fv == -1) {
+            if (TCG_TARGET_HAS_not_vec) {
+                op->opc = INDEX_op_not_vec;
+                return fold_not(ctx, op);
+            } else {
+                op->opc = INDEX_op_xor_vec;
+                op->args[2] = arg_new_constant(ctx, -1);
+                return fold_xor(ctx, op);
+            }
+        }
+    }
+    if (arg_is_const(op->args[2])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        if (tv == -1) {
+            op->opc = INDEX_op_or_vec;
+            op->args[2] = op->args[3];
+            return fold_or(ctx, op);
+        }
+        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
+            op->opc = INDEX_op_andc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_andc(ctx, op);
+        }
+    }
+    if (arg_is_const(op->args[3])) {
+        uint64_t fv = arg_info(op->args[3])->val;
+        if (fv == 0) {
+            op->opc = INDEX_op_and_vec;
+            return fold_and(ctx, op);
+        }
+        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            op->opc = INDEX_op_orc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_orc(ctx, op);
+        }
+    }
+    return false;
+}
+
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
@@ -2964,6 +3019,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_cmpsel_vec:
             done = fold_cmpsel_vec(&ctx, op);
             break;
+        case INDEX_op_bitsel_vec:
+            done = fold_bitsel_vec(&ctx, op);
+            break;
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-- 
2.43.0


