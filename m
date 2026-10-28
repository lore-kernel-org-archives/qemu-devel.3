Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=z6msvdlt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6a8-0006R2-4J; Wed, 28 Oct 2026 12:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a6-0006Pv-Jf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:54 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a4-0007Vp-Mj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:54 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6f5a0893610so1010419eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205171; x=1793809971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=592OvYlsDPOvpeaaM3tWp55SFH77481VstyWeJdhzWs=;
 b=z6msvdltZGMzb75PV3YGMu/Es0UoL5gJfEpTCoySSbRN70ftYzN224pAf7jhXbk1g3
 HE2/O0ZMgzMagDlGbLTIHtLHIFL6wTPWZUESXwERiesFFD0kAE+gTcWll6eJgsazBwO8
 SYiQulFxUnd2Sl8NDxEQlzlTMZhvno+IzH73QBcMfZWxj4zjKlSIsT/fa6W6ht4UWY7X
 Y/hPkyXHBmFkuorfd3JN1gA2uUI8xcQHKzpJ07RPzLOgs2MbOtelwh5Es5kNrZexuolI
 S7+mHAhg4WsyOuqy+7HBVmlWEiisilUmWvwNgNDSe057u0OahfGWuEYFc1d47JZRZKk7
 dLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205171; x=1793809971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=592OvYlsDPOvpeaaM3tWp55SFH77481VstyWeJdhzWs=;
 b=gMKjq8oGQ/mNBAMpTsdYolTEIczmzfyf56Wjf5My1R3BCqq0v0yPvLasnYABGjJJ4s
 d3s6pSlSblEupS/ODGG8mlaNr39vptbNQgYB2ZgEkZV9LnLpsY04pgmefaXwLpTcwHlp
 w1lzBnpX3DeCffclTZPa/zFG0+d9qPnqYhK/Qa4R2ISlilQgVJWiYUboIdXcj9eadazK
 UoQqiODdZgd9bkbUnW6Uf8JG3mJfzKlxwYXqGf83h0XI1+JQQCQ4UHeY8/LS8iNAea7S
 DJwkOZ87wCoWkkzQgCMUrpAQ8Cp6HlVHZW7YNp1mo6Cvr2NI0lDVAVW7Xvj/1wRno5Py
 /mxg==
X-Gm-Message-State: AFq9FYLEKGuNyDFjj3S8wxcQ+lnou67rylYwCIcgynfcPWG7GzMBDhrl
 mhNH5kPO/sM7/plu5gQ5VGnjx+WOx1xEZuudzpDio+ZU4yjni3UB0N6LEkHS8PWbzxKi686VrDC
 pPixU
X-Gm-Gg: AYBFou22hp4fELkTizFS40G1yBa0SuqsW6eD9p37pxVgHwisL8f7W44IlTsIYEzAcFF
 InI4ZTojJS+6x4+aC/yTi7K0oBZBPsjHxT9mqLeLw2pVfJ8caI97ECukEZ+egbrNPyy72s6TjTX
 RUpRP8vt1svOWcIJ+I+2EMFZ8hSR81GJxUYOfefpDCxfAXZk0jbmiQDUraH3pJyQRSsAbj3YsSF
 Wt/od0K6KI6H2ynJ7IL1aM9+STnaEIV4lW8jRTlzKKf2mbjeuymjb/Lxb36fItuUwR2oZNStPKp
 L97z441YD4ONKr6k8bz478uG18xsiPo8gZhcfXCdfDNYTHhxkO+z2Gn5qPHBWshHuzYVEOuIwrQ
 A/jpRU0zOt/8E5psT6iIrjTKJXvsMwHP+HnOGH2m0UXCvkl+X6E+Jck70sQPIbJkQP65C4keCwI
 aHJwKeDptLDnJQ2KJeEPfxEyyDjkt863x6gRBhM4D0R0ejLJgJxr06A2Fy71gOrzitTRERt/42D
 xK6EQDzAdkRUXrj2quOxgO4yNgdg3DzUX1hXNr2XxewViSPtSzQYoYotjfEivDeCox5PPN8p13c
 RKy1KIFmKx1gr1rEIG00Dg0h4/P0gaQvlA==
X-Received: by 2002:a05:6820:f002:b0:6e0:1599:a4b with SMTP id
 006d021491bc7-713ee089ed9mr1694263eaf.18.1793205171365; 
 Wed, 28 Oct 2026 09:32:51 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 03/16] tcg/optimize: Handle INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:32 -0500
Message-ID: <20261028163245.1031673-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 294eb5ed29..a518707887 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2106,6 +2106,68 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
     return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
+static bool fold_shift(OptContext *ctx, TCGOp *op);
+static bool fold_lea(OptContext *ctx, TCGOp *op)
+{
+    TCGArg sh = op->args[3];
+    TCGArg imm = op->args[4];
+    int var_mask = 0;
+
+    if (arg_is_const(op->args[1])) {
+        imm += arg_const_val(op->args[1]);
+    } else {
+        var_mask |= 1;
+    }
+    if (arg_is_const(op->args[2])) {
+        imm += arg_const_val(op->args[2]) << sh;
+    } else {
+        var_mask |= 2;
+    }
+
+    switch (var_mask) {
+    case 0:
+        return tcg_opt_gen_movi(ctx, op, op->args[0], imm);
+
+    case 1:
+        if (imm == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        op->opc = INDEX_op_add;
+        op->args[2] = arg_new_constant(ctx, imm);
+        break;
+
+    case 2:
+        if (sh == 0) {
+            if (imm == 0) {
+                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+            }
+            op->opc = INDEX_op_add;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, imm);
+            break;
+        }
+        if (imm == 0) {
+            op->opc = INDEX_op_shl;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, sh);
+            return fold_shift(ctx, op);
+        }
+
+        /* If arg1 was not already 0, fold the immediates. */
+        if (arg_const_val(op->args[1]) != 0) {
+            if (TCG_TARGET_lea_imm_valid(ctx->type, imm)) {
+                op->args[1] = arg_new_constant(ctx, 0);
+                op->args[4] = imm;
+            } else {
+                op->args[1] = arg_new_constant(ctx, imm);
+                op->args[4] = 0;
+            }
+        }
+        break;
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_mb(OptContext *ctx, TCGOp *op)
 {
     /* Eliminate duplicate and redundant fence instructions.  */
@@ -2218,7 +2280,6 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_shift(OptContext *ctx, TCGOp *op);
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
@@ -3220,6 +3281,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_st_vec:
             done = fold_tcg_st_memcopy(&ctx, op);
             break;
+        case INDEX_op_lea:
+            done = fold_lea(&ctx, op);
+            break;
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-- 
2.53.0


