Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C2DECE577
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dW-0003Pv-QX; Sat, 07 Sep 2024 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dU-0003GG-QB
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:44 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dT-00051L-A6
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:44 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2da4ea59658so2358911a91.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762402; x=1726367202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=rbW7uDKULEpLP6dC06hrDi0HpQ81gLwoLSWkjtetpgxdmt1DscLfXomdHdUUOpgwfH
 uMZGSrWrV9Frayz8Pzp29GUY9ZRqwciIFe3fO5a03VmrgwUK9zp1Sg2sC/muIHZJ1Qfy
 4K0eFCQ6Ls5fm/O5xAjW+3hpCfpaApgyxdElTSXfzIHYamnXBvFituCLjDj93b8V9nmk
 /eUeEv9ZQFeii5bdNLtY+xVKEymenwUhLbPeKHpldwP0oMF0C4Hulz7NaUaUlksdVrgZ
 e7BuSnajTCCwJTVCbqtHkV+km3hTxBcTDxrhWo9tuqKrwJiN1ORNH+Gsjmiabwh1nstJ
 teWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762402; x=1726367202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tk0wGAYaA1BFCH8Bi5mZsOhd6+SwTodI8yFR1/zj/XA=;
 b=YwA7KSQi5QTS0zXyCG4zdcuFJuh5S6cx2J7Mj/mRL1Dj2r9jMKWWSKHX8hyNFczmcB
 9QWLLm2d2O3v7YILECll9M7f3z/83v8b8YvbL8R+NTwRo3EBhNspOzfK9mm0FZS58a2j
 IvfcV4FOznVWpw4rhZg0F3dPxlbajAFyDn5oL+DNlbcVChzbjoSgpbNCI4V2lWAy18pj
 up8CfZBHvFmmFqU5btZWvdbFHGJ6e/nPtEdSonaYvVjYKG39jhnOaVCA+Ct3fCGPEBa2
 UhLnDR2wIx6QgEClOC2IrCRB0Vf2zXY43oiOGhHmO+0oTlAzmreSjhFOnzJK4azE0dpN
 x4hA==
X-Gm-Message-State: AOJu0YzKj36WTP63K4muhUvqAd2GN5oRyhpuLmXD3yxeGGhV9+fOdFot
 bod1dA8YbcRJO8owFT3R2es2mcl4xWUr8ZNH1C+MABY8OztxS4x1Lp3lYUteA1WuAY2+6fH20zC
 7
X-Google-Smtp-Source: AGHT+IHuXrKEZmk4TmwHjWsaZ7xwLfaUeqxpeG8iHvFUHwUiJQDQposs4PvIWELoMupL25ZCASBalQ==
X-Received: by 2002:a17:90a:ee87:b0:2c8:858:7035 with SMTP id
 98e67ed59e1d1-2dad50cbcb1mr7287239a91.25.1725762401715; 
 Sat, 07 Sep 2024 19:26:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 07/12] tcg/optimize: Optimize cmp_vec and cmpsel_vec
Date: Sat,  7 Sep 2024 19:26:27 -0700
Message-ID: <20240908022632.459477-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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


