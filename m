Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FB6EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubH-0007JT-FO; Tue, 10 Mar 2026 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubF-0007GC-Hg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubD-0005qN-3N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so19960645e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139561; x=1773744361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q7Z/vQB+lFLKsxa63Yt8nB8oPVKn+DTUu+uQwmHZnEY=;
 b=vqiOwgGrzJV4bqYmYaQLZLa+SyHLTAyqLvrK1kNOSWfspYc3bFm5jzWNuh6ExtPPnh
 TXKf/uZ3L//q/u4ISJyiKwoxyuZ0atyi8t1UjBxZFq1KINYDcOo1JIFgvF7s2qg42LlJ
 5oyxwDKq33VdM/uJvGFNvaXwCX+FVTH2yj95gplP4Snar8n9gjO2jyQe83sOLUIZKOaG
 HWxhntt0gj2Hs0mQBi1pXggFZTojV5fIJXrDI5QGQFn27C/LnMG7zmr8SzURvK7oVdz7
 27uFyWNx780T1qbK4ChTeo03rMAy6jksll9nkgnFWAY3onT3wPGqlzXIh/z7u+rGSTBS
 lubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139561; x=1773744361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q7Z/vQB+lFLKsxa63Yt8nB8oPVKn+DTUu+uQwmHZnEY=;
 b=k+PaqdA1F8ai7cI3uvEA8VrFbhQ7bdkIy0me8AcVmUYFfGIBeNBdu/GrQOITmLxu4g
 yyvWZz3kt9TgY5UUUmLJxGoq6eMjh/91Z0VQXiEzeVO7rP9CZa4/8uZc0dMqpiG8e6nG
 rLsvNNnptF7fvjoFroCu859042gmYkKi6/p3hZ4zR/DPUYLcibcirGpoqyCFrvjZp/JU
 KOlvJPPKJTPAAXMDMyYIxL+xfEh5GZhYC/0+lKnr2zhaioslq4SCJS4W+EGThMoRFafJ
 Nc09Hda17nT6rVdL3TCBE0cxK3XzKa8j4/hQaRX7Y37VqD28DAObtV1YenglEu/0/gEX
 zB4w==
X-Gm-Message-State: AOJu0Yxc/f9fUQYzp5k1UINQwWfyH+SGypCi9RjFrUeTf67/CpnqNAXB
 9RX3bMkc3VNr54pChBYOgszofVKF3pG8KxgQjTlMRZYMgnHkDkRQpL0P37nANWmtLUm3QJFffRH
 5KYakl8s=
X-Gm-Gg: ATEYQzxzG0sKNqCiydd9zF854fqUmXXfhUvNKGlMPz2tavZVFvUu87guCaoDnq+eXzS
 6upoYW+R0KwBsw9eeit456S4ZBKAIlryICRD50x0fCm3ES5iMSYJCSQUpzDmDFBrHqIlYbwHjgO
 ynd6O8E9KCxG8gnj8pA4hteWkl3k8mlqSz8D3/k9Z6ODzyZqhzP4aA5vKvIzpcMI9UOM/E1Jjwq
 QspOOK6zpgJ3fcKP8UMbUdBtCYgsF0dt7VJZj64PX6zdtllabie7/EWcLrK3vfuDqRshqeVTfs8
 rSuSKhe5lA1/zTKEeC55YANMzfEjd5yjRkjCu1YETMCqdWTKqVJzmCMEf39lYjewg9u3qk7+v79
 Yb7rofiC37EytzQ0dplTijcVjXgTeIKBaxphhkDbIbkuFXxDnzP2AO6zWhJrmE0YcmjVq2tBwSh
 P/2n0Se28jZYyunbYor37YINN0d9anq+CHuqVWqkC3J0Ji9U0W30eKYXF4E0oYaRab8opMUod26
 C02rYsVFFs=
X-Received: by 2002:a05:600c:1c25:b0:485:3e6c:aacb with SMTP id
 5b1f17b1804b1-4853e6cae44mr95993085e9.4.1773139560818; 
 Tue, 10 Mar 2026 03:46:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm171964975e9.4.2026.03.10.03.45.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] tcg/optimize: possibly expand deposit into zero with
 shifts
Date: Tue, 10 Mar 2026 11:45:02 +0100
Message-ID: <20260310104511.12670-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260303010833.1115741-8-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 59761c2c844..b1abec69a5d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1743,14 +1743,38 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
             goto done;
         }
 
-        /* Lower invalid deposit into zero as AND + SHL. */
+        /* Lower invalid deposit into zero as AND + SHL or SHL + SHR. */
         if (!valid) {
-            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
-            op2->args[0] = ret;
-            op2->args[1] = arg2;
-            op2->args[2] = arg_new_constant(ctx, len_mask);
-            fold_and(ctx, op2);
+            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                /* EXTRACT (at 0) + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = 0;
+                op2->args[3] = len;
+            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type, len_mask)) {
+                /* AND + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, len_mask);
+            } else {
+                /* SHL + SHR */
+                int shl = width - len;
+                int shr = width - len - ofs;
 
+                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, shl);
+
+                op->opc = INDEX_op_shr;
+                op->args[1] = ret;
+                op->args[2] = arg_new_constant(ctx, shr);
+                goto done;
+            }
+
+            /* Finish the (EXTRACT|AND) + SHL cases. */
             op->opc = INDEX_op_shl;
             op->args[1] = ret;
             op->args[2] = arg_new_constant(ctx, ofs);
-- 
2.53.0


