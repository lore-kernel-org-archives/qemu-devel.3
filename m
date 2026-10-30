Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D01606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GuA8LrQD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTd-0004oV-Gx; Fri, 30 Oct 2026 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSq-0002io-8K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:17 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0005VP-7e
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:06 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4a75171af39so160892fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366162; x=1793970962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=592OvYlsDPOvpeaaM3tWp55SFH77481VstyWeJdhzWs=;
 b=GuA8LrQDVs4O8rzX1ppQY4zua0rD4hoikn0ISN7wzpcFZVChzvMiPPGV22uwtdE4vb
 sobwNRhu/I09kQYE3Oj6K+K6pXwP/r0EBNrfZU22s7ib+2gpkjgMbXt0FLU0fkfJzhou
 JWHqCnxHv6kEMv+kB42ReoU14kmq2ZnlU1WoBbhiY8xX4m6AvzFzZREVDlr3L3qzxAvu
 +xPXqI6c7A+y503BaF+rAVshqxtgKzvrF8i+TdokYZyXD+kbPfcFv5Pi+UCrbnlJcUGl
 BGHvYCe+NpZx6u7ldMPF34c0pNJJ6tOR/elv5TMg9eRTUBA+/Xpez7e1zoOXKrua1Xjp
 +iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366162; x=1793970962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=592OvYlsDPOvpeaaM3tWp55SFH77481VstyWeJdhzWs=;
 b=vPLzGP0eg9jMd5zK9v8X2yhJIBTYFeEzMziGZl6gTI7ain8ObNBfCokfrKXBr0UKbL
 bZykbRJEtZq+ROu3CWuGClNrhFfXsOT5iuA23ZIFPMALfMMmCD6Dk4zvmPoeipyWNg9k
 KicV2fP1SDamL9fTZkwgWstVErSFAlAA1Cn1EooFt2mQWgZbChSarnU2ClPDuw2DeSBH
 BJSaXs6jHBATHOG1A37vxXx2LkS6u1YDG2fsNu0ypHzWaMe77qj2uDj5D/k2HUGMxZtn
 OyGNp+QNVf8iA+JbEoZLEthAEr1UEZRbBYmoAjU6GrOTbP7hyKatFEwZr5oC1ru0WCBc
 ZT9g==
X-Gm-Message-State: AFq9FYL6SlgWL4sHUZtb9Ti6psJELk0GFOuEVoNOP59U8stqmfdN1jbP
 xbxVLyyPoetWPl3lBKoUzr80RzgVhUGtkqgjBI84U2zDGJ4wez4Ew29xOfL4V30zUT5MEAWCBxc
 0fqtt
X-Gm-Gg: AYBFou3kim779oH+hbo/cb7USKeQyZ/qwQR99bulyW9GowyD+VGlF9rAQacpQNgHct/
 7WQgvglwZd8ZiIsGVm8XuLkHH74iS4pNtRRD7jhUYNEZ69gy6A76BK+Rz0slHSwVyiuUWglDGJv
 nJ4yUPU8FLDTbGv0ut7rVaQ9lEZqB4XgXWX+sqFEDrATxikm7RLCBid/oGeXUj7whQJPXYJAY7J
 Ho36pKFhx8s7A0jDFxTrAj1nGhUJtzEDikNe5E6dPE+ir0f6TnJpF9VTtsALxlLZG4NPRBqDFj5
 7znDSYsgFcCCnu/MjUWpLGDh7yI9nTArs6Gmvo9Fr5/r1g2vMddxcjia+u6kr5fhM48pvGEnPU0
 mbh0Zx7Au66ntOsTkY2TPMhxq6B7Tjwh05rOVbYl6AZPtQ8CBjgDjwXhsyvo/ZQbFZNYmLObTDx
 EyXnSArnflTdNv/7lmIa4uTyg0nJn9dupHVkd8McBj9BFLcITmzZqgeTvVoEHKH0VtcT4wzuaaN
 TSUQniv+HLufABSgPhnoUvTmpU7xmV78WpnelFpIY5WDnfJV/yZ3YZgNlArZHvq669HsPCk6wM+
 K5dA86hdunxIe8Q4DK7emXD0iC++sQ==
X-Received: by 2002:a05:6870:828e:b0:494:b587:7fb9 with SMTP id
 586e51a60fabf-4a90778017dmr1355255fac.54.1793366161811; 
 Fri, 30 Oct 2026 06:16:01 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 06/19] tcg/optimize: Handle INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:41 -0500
Message-ID: <20261030131554.41208-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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


