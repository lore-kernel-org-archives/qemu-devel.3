Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D2AEB104D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuap-00072Y-ST; Tue, 10 Mar 2026 06:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuao-000721-4B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuam-0005ml-DQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so2776425f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139534; x=1773744334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xvcbVnQK7TqEbDYcqZDEeDs6/ajmpdQvJ51L+fPuY3k=;
 b=AmZrE4Dk+32wxAQZua7dWv9HrgYoedlH6M6GgrDJNO4+YMVchBhVF8n2WoGeSPqJa4
 EQfAxPGycD5+OYm+biQE2P/Jaxc2Gwtj958o3mzxN6D/ODmoTV+AApAeqGvfswalSdCb
 6gy0iRGN75e1OyRINfNEMPBZwlKFdBlFbAC5aeKOcCanGhLd9NxjBxwI+AtaunbVUeOg
 /UWnyMgY7JwVVVbMPTxbpTKc+6dS4rWOadQ1yuGQCr1fPrMivs0D/VLt87zu/2QfoJ6C
 i9wrUCt8tB8ib5XiT3K/nf+uFQYc2zzhFP7acrrWCFEEkx2Uef7B88Lxhg3g8ESnWCru
 CLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139534; x=1773744334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xvcbVnQK7TqEbDYcqZDEeDs6/ajmpdQvJ51L+fPuY3k=;
 b=k7W51ZP2F/kch0WQ245jz3Op87D3yzkqZ8jt2xM+4YO37XosTXO56DtlDSOJ8w0NW2
 Wg7d/THwBHNRGG+vpZs3yYxmqwBooF6TtlZWOhh+tLYBaecfOYauV9qJ2wY1A9kQkerV
 lw1vViZ4YqNim1X/bLVOi67fBlGC8oB6wv8heNytjaYO/dn5FVPo+nj88HOfHar4QVP7
 zWPjQKEsD06Lf6NNJnjdP7Tf/iciQZObohJW0VlGrZusp6VI8NTrUzfiAeAufsXsC6ka
 sLjcUUIZ7+AR009npfNRJFQkXZtjGxbWCZE9bCp/KkZDJ34J+c961tpx1lXOi+7A3sR6
 U9hA==
X-Gm-Message-State: AOJu0YyoiU/j7uYgDw9z5EGZn1Zyb0O4LZLsE87S+SNJcZoq51AacFYc
 PYzJzKt7ivEOkzuo+62BWnzmRqjihrtB1TYZm83dlvukbcQ1YMJvlDDymWVgWIfT9I0x+T4buZG
 XipGCu4Q=
X-Gm-Gg: ATEYQzyvTKh98cZYuRsmhXi1w0QqoInJZV/QH/3Bf4tfLFChUNU0CWbsYQ1dlpi/Wxx
 rn7uag+pSDzwNZB6LoJ5zlPWlRlMDVbVIjL2Zg7tR8dmNbPnQUdqiC1XdFU5gdbznufv17DVdKJ
 nvkj3zj3RabieUkvaEJQtQu/EZU+FATEIvBewXhNh0TTQguMizGuhgjgwMTAb2Z6S84NlXWOGmA
 R15rgI5FeEoV4//H2sIlAp1W44kvSOUVkxE3LPIl+dBX7vlNX9z15zZxfEAbCkmMfYcFsgsc8od
 EmU1/2GYt+Sx+BbOURyLbQW4oxNQV0//NoefqFFumqrlotRPRktBCw7sfqkbLw5atj5MQLPs6AY
 EwOTYOtI1yU+l8b0D53MCSDkWvAlsER4Nsj8tn4Zk/0C+ex+3RUtHR6aiWJP9d49YbAYaqngjQj
 W7G04u0pzG1Sjn006ZLoNviSZm+25zjTensh2O++IBKHlj5ZacMEzJZR+ma7urJoaPTj/pPhTk
X-Received: by 2002:a05:600c:8708:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-4853c8fe526mr79876795e9.17.1773139533739; 
 Tue, 10 Mar 2026 03:45:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aad45fsm75314235e9.15.2026.03.10.03.45.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] tcg/optimize: Lower unsupported extract2 during optimize
Date: Tue, 10 Mar 2026 11:44:58 +0100
Message-ID: <20260310104511.12670-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The expansions that we chose in tcg-op.c may be less than optimal.
Delay lowering until optimize, so that we have propagated constants
and have computed known zero/one masks.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260303010833.1115741-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 tcg/tcg-op.c   | 14 ++---------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 42637c12fa1..59761c2c844 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1918,21 +1918,74 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
     uint64_t z2 = t2->z_mask;
     uint64_t o1 = t1->o_mask;
     uint64_t o2 = t2->o_mask;
+    uint64_t zr, or;
     int shr = op->args[3];
+    int shl;
 
     if (ctx->type == TCG_TYPE_I32) {
         z1 = (uint32_t)z1 >> shr;
         o1 = (uint32_t)o1 >> shr;
-        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
-        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
+        shl = 32 - shr;
+        z2 = (uint64_t)((int32_t)z2 << shl);
+        o2 = (uint64_t)((int32_t)o2 << shl);
     } else {
         z1 >>= shr;
         o1 >>= shr;
-        z2 <<= 64 - shr;
-        o2 <<= 64 - shr;
+        shl = 64 - shr;
+        z2 <<= shl;
+        o2 <<= shl;
+    }
+    zr = z1 | z2;
+    or = o1 | o2;
+
+    if (zr == or) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], zr);
     }
 
-    return fold_masks_zo(ctx, op, z1 | z2, o1 | o2);
+    if (z2 == 0) {
+        /* High part zeros folds to simple right shift. */
+        op->opc = INDEX_op_shr;
+        op->args[2] = arg_new_constant(ctx, shr);
+    } else if (z1 == 0) {
+        /* Low part zeros folds to simple left shift. */
+        op->opc = INDEX_op_shl;
+        op->args[1] = op->args[2];
+        op->args[2] = arg_new_constant(ctx, shl);
+    } else if (!tcg_op_supported(INDEX_op_extract2, ctx->type, 0)) {
+        TCGArg tmp = arg_new_temp(ctx);
+        TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_shr, 3);
+
+        op2->args[0] = tmp;
+        op2->args[1] = op->args[1];
+        op2->args[2] = arg_new_constant(ctx, shr);
+
+        if (TCG_TARGET_deposit_valid(ctx->type, shl, shr)) {
+            /*
+             * Deposit has more arguments than extract2,
+             * so we need to create a new TCGOp.
+             */
+            op2 = opt_insert_before(ctx, op, INDEX_op_deposit, 5);
+            op2->args[0] = op->args[0];
+            op2->args[1] = tmp;
+            op2->args[2] = op->args[2];
+            op2->args[3] = shl;
+            op2->args[4] = shr;
+
+            tcg_op_remove(ctx->tcg, op);
+            op = op2;
+        } else {
+            op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+            op2->args[0] = op->args[0];
+            op2->args[1] = op->args[2];
+            op2->args[2] = arg_new_constant(ctx, shl);
+
+            op->opc = INDEX_op_or;
+            op->args[1] = op->args[0];
+            op->args[2] = tmp;
+        }
+    }
+
+    return fold_masks_zo(ctx, op, zr, or);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 96f72ba381c..fc2254f54a7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1000,13 +1000,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_shri_i32(t0, al, ofs);
-        tcg_gen_deposit_i32(ret, t0, ah, 32 - ofs, ofs);
-        tcg_temp_free_i32(t0);
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     }
 }
 
@@ -2221,13 +2216,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t0, al, ofs);
-        tcg_gen_deposit_i64(ret, t0, ah, 64 - ofs, ofs);
-        tcg_temp_free_i64(t0);
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     }
 }
 
-- 
2.53.0


