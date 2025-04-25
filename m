Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECEFC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R12-0007YZ-Rl; Fri, 25 Apr 2025 17:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0u-0007Rt-NE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0s-0000Xs-Q8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739be717eddso2232138b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618113; x=1746222913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgJC28VvOixH4vZGXDHrx/8RFZ1n1/6FrcSY3uOuzEw=;
 b=eA6NQ+4iO/lItVe1S71Df8+GSXa9mUD8l7ZXXdBDuQloOupIguXOqKIKO4Ir0nLxFQ
 Xw8tEhaKiaL8UpcwO3Er3rR0wQcaFl0zMjVvaStvxqFHI/h6BGaKHm6v4676lUzTnPqa
 THhKkQLxx0xNuDNePrXgQvmPaVYOJBZ9G1XQiQQWs4o31hVC4HZvzHKOSaxUDJWYK1K1
 5UN2qU8FVvd5MlG+rvkZkR5VEZgHB3kKjHqb7HsRwglTWk6oOdEanRNBBqk3LZDzpkvi
 S+FJuzNe/C3CaKuCXYVj4r7iLRE4Zh1qmEa3w3DaKpBX/uSitUaKLjwZoWslXJ1SWJ/A
 rNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618113; x=1746222913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgJC28VvOixH4vZGXDHrx/8RFZ1n1/6FrcSY3uOuzEw=;
 b=B3UpOgxHreYzkScU0nkIuCRQHiRQJVs5a4c05nPpT4CG6NznBKgUoFMIe6O4vuZPQr
 fdTbx6KzMRrzRZ6e8oQYeLjCnl2uycPooi3uPhRUZ2YbkCEXK062LLZG7ZtUdzDJOZWU
 XpidjXXJMCF5SNVJMizVbqrkp+QgZfHcyJZo+RT5zEYGWLBUdLbbX0HefXfEGfBmnP9x
 fgsx8U5iUo62N7maPZb5MJJqIa5ol1qggudZzAlm/5+8Huz5a3Eg5qDj/ltCPO19Mgwx
 7Gdzt9C18bQUvFVrQOektyiDv1vz0uyBy+055kD+end/CnxizF1ZksbBKaC60KZvPnSl
 tAEQ==
X-Gm-Message-State: AOJu0Yz121/zpLs+deq05fhEREwG8DKeImfE4xzY7uAzxWTwdJhkNFUG
 1qJDpcH/SQqJexzU7WFHyxdeAIMa8bkRbrxjR0KpsYaDT920J68UNh32XMvIs51b8BgLqXekBXv
 5
X-Gm-Gg: ASbGncv3BHuVoQ+6CfFfVQtBnhncWH43bZG5StJy+8dePj+c8Sc8RyNho7gN75cuCfp
 2LJQYDfaLHRsAocGAfXgqCrp4vXQng15b2NfySnRv5GEvf5mcZs8TkPeB/tj0UlNUZcsLOgK8RI
 62ick+JwfbXYlu+VQFsLYfNd55mHHpq0ZYQPS2UA5ohXA18vDKcEp5qfn5So5OdyNvsy3zSUhOh
 kXGh6Yj33ok3r/zn/c0SURCGcEvl5KwdvAfR91YObW5KmWJFz83IdQS+PFM1lZvZJgDgX9NZuwB
 nt8E94cs2DmHNUrBSjJ0tHfFqnvVMPNEsX1aWLUSa7ocAMwKAfWNXjaaRUJzxrSt+NxDpFd+lsM
 =
X-Google-Smtp-Source: AGHT+IHl35Nbr8r6/U2j5fiVwgFphkuBzL10K6go+iiJbkboR41dqhZG3cvDc9c2QewNNLKpPlN6ag==
X-Received: by 2002:a05:6a00:230c:b0:736:5544:7ad7 with SMTP id
 d2e1a72fcca58-73fd75c4cc5mr5003749b3a.14.1745618112933; 
 Fri, 25 Apr 2025 14:55:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 024/159] tcg/optimize: Fold eqv with immediate to xor
Date: Fri, 25 Apr 2025 14:52:38 -0700
Message-ID: <20250425215454.886111-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9303bb5b64..e18fe37ad2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1807,6 +1807,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -1814,8 +1815,28 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold eqv r,x,i to xor r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_xor;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_xor_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_xor(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0


