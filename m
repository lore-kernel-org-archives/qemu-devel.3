Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84998C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Hj-0003YN-6K; Tue, 12 Mar 2024 10:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HY-0003Wq-2N
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HG-0007jd-WD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:02 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29b9f258cd9so3749757a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254328; x=1710859128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UlKx6mBylhjK+QdjE0ijHuQmNK+qb5/whrN67puRMnA=;
 b=BsGiqLqc0NQw+VkQFAH6Gn6UKq104TsDyj9edqN+o1Ie3m0cvymqpkueyMLHksYM28
 xDkPFiQbfsz2+BWeou0TkeVgQR6BxJyCqQJaJevu9lkcWSqbn8AOwGrlssPW4U5jGYMd
 vYlKScUEW3Xppm/p4E+BNhLoJmVGM15D9urfdJxyk5sYmNem5glwVW8zKquOeULZ+3a0
 u7V5iIkWN0zQ7lBHzNpT+uJYrXjuc5/gwhUvDvpxHxsZdDPhtwVWG2sg6QaUDgjgkUgJ
 0JikBdJpZUABJcUa29f5WQvGes2GbOSzEXzjJ+JbALy9v1lNCN6QTkRRQqfzErh3f6md
 GuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254328; x=1710859128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlKx6mBylhjK+QdjE0ijHuQmNK+qb5/whrN67puRMnA=;
 b=WGn1hS6zzagFcZo+dsR+Rr1q2A7G0MfEAWL7sDWa3eECswOhIykeeSfRZTlR0v9to3
 WyrWkqbp66Wi7gJWurxOlGWmUJMy29M7UYlCsrsFIyfAsMO0rIrDrjEyi5HFi+sJW0Q9
 AZ8ygA9rVCh7NIz6tqjK7cdWLzBvDlfH/ei/gYhtrQjf9AlYT04i2OrEdAQeR6T8Bm+G
 lbFlTD7C/P6Xzfazktfj8jZAtnNtX7etHPIozlTzensQi/Mp/x7OD7nxk+5eRgvR1mzM
 WVS+key4s2smDY9fZKoLaDBSjBwQufXBlIoaoS4P9of4BGBo3AYVWMOUy6MoW1Z5LXjO
 Yw4A==
X-Gm-Message-State: AOJu0YyIvq1QaqQwU36IfhbILCMVGJkz3JEirlS5QQbtvwTTzt+oSMXs
 mPzIdWmTaYOg14Y4blPEHm3OCJvHG/60LfkM/Qoi4xnncUIqvdU8bnWVP30d8TjYTOP+2laDREM
 c
X-Google-Smtp-Source: AGHT+IGd6D4siOHpMaxb79mZ3fOIoUhRm4B32YyGvaQbvpzb3rApXzrTIjwjHI6TAVXbx3MMpehvug==
X-Received: by 2002:a17:90a:fd8e:b0:29b:c13d:457f with SMTP id
 cx14-20020a17090afd8e00b0029bc13d457fmr6619187pjb.19.1710254327779; 
 Tue, 12 Mar 2024 07:38:47 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/15] tcg/optimize: Fold eqv with immediate to xor
Date: Tue, 12 Mar 2024 04:38:27 -1000
Message-Id: <20240312143839.136408-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5729433548..c6b0ab35c8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1687,6 +1687,15 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
         return true;
     }
 
+    /* Fold eqv r,x,i to xor r,x,~i. */
+    if (arg_is_const(op->args[2])) {
+        uint64_t val = ~arg_info(op->args[2])->val;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_xor_i32 : INDEX_op_xor_i64);
+        op->args[2] = arg_new_constant(ctx, val);
+    }
+
     ctx->s_mask = arg_info(op->args[1])->s_mask
                 & arg_info(op->args[2])->s_mask;
     return false;
-- 
2.34.1


