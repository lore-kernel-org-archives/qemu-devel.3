Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2D6E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBA1-0002oR-5z; Tue, 24 Dec 2024 15:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9k-0002jW-66
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9i-0002Vj-J5
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:27 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21644e6140cso59036495ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070725; x=1735675525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=W4nI2Ds2quteX6Et2TlbzRKDIrAwJuQSnBaXNatDUIhhqPQoFfDusMKGmZWGQTs4L+
 mtEZ1hyUvjQRxf5fOrDPFIz9tqZE4nJBLHs07cHJsEvl0+A68+ldn1NODh/gcg/Drryl
 ThpJI5d02hOg/2HnkGT1ZzGSycki8sVu3NyUsDIfWuUXKk9+bvmBWd2oQAo6s53pbtXP
 ha2S7IdAUnzXfnV+uEiahuvlwYCOdbDiKF9A5aK4bW1KhBtfpOnBQ2K795ihcNyXlLC/
 3RAf2loDnCUXCkmTAJbpjSQqpCFEKwrS7d+XZnXHAnUY1aVDzjbzMd3lRXnDkPrA3nm6
 0paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070725; x=1735675525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=HNBpa8q0zFQs0uIrR1aIO17hYpKefD3y3v2v48W4VkLvioh3ZXE37tMx6SHU0pKD9Q
 +naSc3bW8qHdV9HXqBstqFLs+qAi8z0g36+fTxUoA36QhCMs0mzKPdtZjtELk+7Tvhs3
 FQj1TknknPtQh2XHmbO3aGG/0Oa9znGK+dXT33PHJy0hqRydGIeB9hU57gQW6SC60Ru3
 9xspiP2xZl9j5Mh1epTGaU5Q6FBgIv8ckQgmSXmvU6BbNXldFfVyoePp8K+Nn19oTxKO
 cZ+D92ehnqopy9lni+17v+huzoYPE55VDPbGoSH3/mfOl+42+cMwEy6i9ZIrVuwpHFFy
 9WmA==
X-Gm-Message-State: AOJu0YzTTTqyuCG6nb1xu2Z0uCdcGYbIvnlyJkd0VipBUQyTzanr+YHU
 3h0BqE4hCTsR9ZVF0ffbElJ2oF8uQqb5RXBtIow2YS2jcbep/rU7X4pN4P52FKlrP2DoIIPUxD5
 wDkI=
X-Gm-Gg: ASbGnctnlPvGmMOYxJWhc2LI1fOtyz6gIJrdn5vzx0K9i6bwY1j2hGQ4/XRqXjb3jn4
 n4uhdbpnTwlHbq5vNY2aKQ+QQtWXPa75lJTr9LnmBTLtbQiFsIhv6gof1tN6cNXQbzbcEsaKt5x
 SLHPSERWeM7h47XzWKi33YZhGU1x5Qzi0QmTY+Ds0vpqicvSf8j0VWYwScy37cXGQGxklQ64OEd
 sMQ6gmRVuE+c5u4YuEvG7TfgkjgKZgaO/bNTdtuCw29FEAyeP0/rVvGaN/sYYd7ddeGbVEmBiPy
 yYLsoemopPKdmp3GaaIF0dAFtA==
X-Google-Smtp-Source: AGHT+IEJhtGzb5grS1teMnZupHJGmViLG1uhDx4sk3FeLbNd2Bjm/NuRpr0ruv4CcQ7iWbnrcskb+Q==
X-Received: by 2002:a05:6a00:3cc2:b0:71e:4cff:2654 with SMTP id
 d2e1a72fcca58-72abdd6eb8cmr21763038b3a.6.1735070725198; 
 Tue, 24 Dec 2024 12:05:25 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/72] tcg/optimize: Split out finish_bb, finish_ebb
Date: Tue, 24 Dec 2024 12:04:12 -0800
Message-ID: <20241224200521.310066-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Call them directly from the opcode switch statement in tcg_optimize,
rather than in finish_folding based on opcode flags.  Adjust folding
of conditional branches to match.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e9ef16b3c6..453e8c43bd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -964,24 +964,25 @@ static void copy_propagate(OptContext *ctx, TCGOp *op,
     }
 }
 
+static void finish_bb(OptContext *ctx)
+{
+    /* We only optimize memory barriers across basic blocks. */
+    ctx->prev_mb = NULL;
+}
+
+static void finish_ebb(OptContext *ctx)
+{
+    finish_bb(ctx);
+    /* We only optimize across extended basic blocks. */
+    memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+    remove_mem_copy_all(ctx);
+}
+
 static void finish_folding(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     int i, nb_oargs;
 
-    /*
-     * We only optimize extended basic blocks.  If the opcode ends a BB
-     * and is not a conditional branch, reset all temp data.
-     */
-    if (def->flags & TCG_OPF_BB_END) {
-        ctx->prev_mb = NULL;
-        if (!(def->flags & TCG_OPF_COND_BRANCH)) {
-            memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
-            remove_mem_copy_all(ctx);
-        }
-        return;
-    }
-
     nb_oargs = def->nb_oargs;
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
@@ -1351,8 +1352,11 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
     if (i > 0) {
         op->opc = INDEX_op_br;
         op->args[0] = op->args[3];
+        finish_ebb(ctx);
+    } else {
+        finish_bb(ctx);
     }
-    return false;
+    return true;
 }
 
 static bool fold_brcond2(OptContext *ctx, TCGOp *op)
@@ -1443,9 +1447,12 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
         }
         op->opc = INDEX_op_br;
         op->args[0] = label;
-        break;
+        finish_ebb(ctx);
+        return true;
     }
-    return false;
+
+    finish_bb(ctx);
+    return true;
 }
 
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
@@ -3037,6 +3044,14 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(xor):
             done = fold_xor(&ctx, op);
             break;
+        case INDEX_op_set_label:
+        case INDEX_op_br:
+        case INDEX_op_exit_tb:
+        case INDEX_op_goto_tb:
+        case INDEX_op_goto_ptr:
+            finish_ebb(&ctx);
+            done = true;
+            break;
         default:
             break;
         }
-- 
2.43.0


