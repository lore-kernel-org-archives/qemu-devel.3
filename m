Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3699E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26M-0004Ir-F5; Tue, 10 Dec 2024 10:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL269-0004Gu-Ai
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:29 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL267-0008Kq-DB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:28 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb5ac06111so1062918b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844266; x=1734449066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gk2JP6ZZJS4eu6oOzldT8vCgXwvZiyxtE0PFUuuyddU=;
 b=ys8tE3brnlgtGbo50w8zmaMk1jObmh7b+1aoeXGqOYObg2+eDBUDAn180vJH9/kRAu
 p2tnUToUPxA9MkSddYY4fTwYqjAnXKloKxwKpRs23rEqyg/2DMT0gbmsNCfmfMNXDxzA
 Dj4ZO0zipAc/j0EoTSsV7wR0WKEwS9TquI7wtaLjSWEmPRw/BLPLwWVOv2i6tkFsI5EX
 31pLAbCEl/lHjbTAW3ftPr6JVFHkgI43U3E++W8sP8l1HxlZWjb3XXsZcDhBTSDZ/F1z
 huoyCDyIm09x8b42QAZCou7yr0QZRc+bLuIXExRLFeX35Empfr+lds3bz7aONJ+UG6Gn
 80wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844266; x=1734449066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gk2JP6ZZJS4eu6oOzldT8vCgXwvZiyxtE0PFUuuyddU=;
 b=gFl6FBNZdPhBRzf/IssqpxM5IKNQktLIWtCCVy+lDkZiX8z/wFgOUvWV6DEu/4BzNz
 88gb6RtBvkXJgW/DQjG2sNaQbT9+PyqDn8I0Nad40QXpeEskCbNrxITOUfogYIa/cKj9
 wwnTdd+dHRKcu1laqwFHtbOoC5OIhVVoHR7wTgnEMhG/oURxO3ltgPZU3iYNs5Ey8Wel
 rPtFT1zzbGIeoAyLdwcnceMSLI/NRW+YAzvj9n1vXYLi0+BSQsgeJBk4gysUG7EpvnmB
 G2RcDoi5eB6gCXEGTpqX+FfXIe4uPWCKJbkoJBsWwKv7Rfw5ZBfv1HKRIj6/UsiFZMJn
 flfg==
X-Gm-Message-State: AOJu0YydVLYaoLINGWwHkl5B/nCdsqW43tHI+bfSq2T0a/M1ydAqi4l1
 TnOkT/Pit2Mi0+iYp4xQqxhrYcSfLLuiA2NogSLrEdyqjR/yuZmvkuTqScf8YnB1e/LOwMmGdfn
 v6M8y4gYm
X-Gm-Gg: ASbGnctkuwPbrOQvCcJavRGvAdpBV6CY4XYJeBR9QcaUiAl+SXbyfJLBQ/NVEFVhEvI
 JExUsqq8hLkDSRbVflznqlaJwFEuyV7L5gAMkCYnkpa2aMwiHSQH6OsLB4qw5GQ7QrY2AnM7J+T
 07F3J7wY78AkcZGbtFNM/r54b4P8XvKZJrxmSrlm16U9Cv0dTSeJW75Dv0gaffP/0EiJv6X3nKe
 i1l4cEY0ZLdczdg/TKCNRDj5loBaeIyELo6cPnqvK4AAijexXB95hsW9ywX1A==
X-Google-Smtp-Source: AGHT+IH0D95jZPOKnWCPqygkRh0wpeW7vNkSvIxmySjwn4HnLD/eEgoB33ulMcO5ph/Ny+MEprvQIA==
X-Received: by 2002:a05:6808:1493:b0:3ea:443e:d1cd with SMTP id
 5614622812f47-3eb66f09b78mr3408831b6e.34.1733844266444; 
 Tue, 10 Dec 2024 07:24:26 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/46] tcg/optimize: Use fold_masks_zs in fold_eqv
Date: Tue, 10 Dec 2024 09:23:29 -0600
Message-ID: <20241210152401.1823648-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e6dc9f2e28..5f3a824a07 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1701,15 +1701,17 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


