Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6793CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26W-0004XR-Fj; Tue, 10 Dec 2024 10:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26P-0004Jq-H0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26M-0008NG-TJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:45 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb790888c6so136063b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844279; x=1734449079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vaVhD4pwusuN3ySvT55EuegkiqGpEF+hb7CVAo3aOGM=;
 b=c/iNKPYiSfjlMYdOtSo8lldgR1mfiOGK6ZaFPrxlAgO1M9HF7L7F+8n/6PIqCfeP3W
 EUncK+FmXmOxPxYlchTSJ+ucIu1bsZUzbcJ9RblGblklNV9Br3doM4UwxbFoGByBP7on
 a9Z1QrZiZU8C0ZgdU42k0axS+W/QrSCkO99Fn+I6c6qT9EP6t6vPSJ4Uir2GtzBQ6Wpi
 iBAqi8fe39MrVRsTixMl1qHzrR/nHWB721+N5WUSXDc5e8ya5FLB8zg8tCrzhxPMAKyj
 48yTaZ0SNYoDpjZM4dDEH5ySUkSf/LLg113Yg0+D4dbNYLrn+IWnOzjMgTRqJ94Q6VQ+
 Lnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844279; x=1734449079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaVhD4pwusuN3ySvT55EuegkiqGpEF+hb7CVAo3aOGM=;
 b=u9QwU8IriSzLqFS1w9PyU5/7slV+Y+wA4511iPEbmbPU4ScshAXEqzpcq+9pOQYvBF
 fYRGaI9eAItNRl/XLseWLh6akChg7X0eHv8RxnBfclJlcN9Nb5kRDQ1D3cX5qWALHaXz
 ExsVQnWo4end5bNEGUgYDfPGa1Heoi/90AnbBKkB2nvGCK3fnmA9JKeUfl/4DoEmzvLJ
 2aR1Z2jx/Ji5J5LWkCNUET7sgwn5QH1kiI9M1Rt+DyEjU7qaxPKcVJJsOLVCFh7THPB9
 Cug6im20GEFYKIaY9zSCL4hbDF3tCZ1BtqUyZ3PkHJqt8qZgmy/bMEP1DVKUsTuaMFPL
 +Ekg==
X-Gm-Message-State: AOJu0YxT4DX6Ag9pX33bM+yZuSvxYc4seKYT53OX/2FgfT9VisXgj1x7
 bM5SAJuRuy7qjhzkXf5EoumGaJ5KV0ISHzTE2H/kv2yVD/Lk1B+3y79la84jz60e8QzY8gx/Lr7
 qR1fkXvp2
X-Gm-Gg: ASbGnct1kfrVzJi2/hdF5zFYy99ANZMmqO4egteXx1z+7fLT+GVDv4n/NfXFeI5pSw1
 LHcQCTLv1MgndedKLyZOI11oLPTUTWqTzQtIL4io6eo3I5dfLzENXiQ/li73dnE/VudUc/AVBJr
 9ZY2XvlZdnE5HhFf9d6Axreu9dBs5p+rUhPJqVYvG5i2wivcPheSDGlVhIAFg+R2B0XfM22FrHA
 JgZt4P7RwcSh4iSCG4E0lNERJV+XwAJQdBpPjPp9Bd/G8GzaleU7VuhZRseMA==
X-Google-Smtp-Source: AGHT+IEF7Wz1cGrVt/6XdY3K/T5I75WgZq7bIP2/CrttjMTz/i2wA7n4/sDkAiKKphCCnjvnqCgFYg==
X-Received: by 2002:a05:6808:1815:b0:3e6:3a82:f790 with SMTP id
 5614622812f47-3eb66dab5dfmr3490885b6e.6.1733844279085; 
 Tue, 10 Dec 2024 07:24:39 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/46] tcg/optimize: Use fold_masks_zs in fold_not
Date: Tue, 10 Dec 2024 09:23:39 -0600
Message-ID: <20241210152401.1823648-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index aa5242a380..ae1386c681 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2056,12 +2056,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
     if (fold_const1(ctx, op)) {
         return true;
     }
-
-    ctx->s_mask = arg_info(op->args[1])->s_mask;
-
-    /* Because of fold_to_not, we want to always return true, via finish. */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_zs(ctx, op, -1, arg_info(op->args[1])->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


