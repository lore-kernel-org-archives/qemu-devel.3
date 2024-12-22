Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F051E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlr-0002uo-VZ; Sun, 22 Dec 2024 11:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlG-0002ZW-Ee
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:59 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlF-0002y6-2C
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso29192525ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884695; x=1735489495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orGIi3JyNJ61WgKl0adLXiU5mTOG/lWk8OxYIjK5OkA=;
 b=iBByO94ECgcN7fCiU2EGhtWYs8u6uhUjibaPwlOjIu0mpzmR22y7IWDL/ChUa2DcKv
 RueOO1InWF1x0enySQj9XFjXOE5xfTQRInTmobxwWQqvAPZpn8WHW3WjJdQttdXxgu7t
 5D0nIgFoi7xC5uGfVTMu2r9x9uCJZ8EMcA2xUCGYBnJFAmtT6433n9kYp1r/yUpvNFB3
 pscKOPL4AcX1ROv0xYm7rHZOhTbES8M4N1k8N1HcoSE3GYrquFIr+gJwZChnFw58kbfL
 NdboqiNF1Hpg+LwoIwDwNR/i9BNQFEYrOXgf0MpF9SM00WtNFKeljpL9ix42wSY2pOsV
 ACIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884695; x=1735489495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orGIi3JyNJ61WgKl0adLXiU5mTOG/lWk8OxYIjK5OkA=;
 b=U9Wc++mXIFHyNsMpXNYlrCf6hvRpvl5gWpDi+pSz1oMcu7HvMbuGhTrsk0zl/hzB1t
 JWFxyBAKXnmZSHpcNoDi3ICAZLB/WIA8tpN3sykRmzX/0ul2L3TaljQ1xeRpTnIBBRhj
 WvxZLLwYiJfAQTCVysWXbWmyfUk459E6H6wnuSUsiK2Qlacvp6ntRbjtKwkG3hQNuZ3w
 ODQQz19vUKQ47Kc5UsK+X1M1VROW4N2dAvJXu0gIkmfBOftWrVtLtQCaO1vYPkGxH4Xj
 GKJVwrWbrZWtJJu8hKWlFWg93ysmkB/x3ezpi0NoqjgzAyZTRupiuwAqsZaFYH8uvUQR
 G0Jw==
X-Gm-Message-State: AOJu0Yyj8722Nw4JvcbP40IGUaK536I0u+clbCAdowBdw3o8SPhYa3kh
 AA0Rj+RNrG8Ep5uLekyC1nDkOApRmyplUeW4Nt/t31WmwQb8gLJWKw5GWcEP9CoBiz8wPSXQ6nr
 +TrM=
X-Gm-Gg: ASbGncu1M78YI5j+A3Th8S9JaLJlT9h4gKnufdgMHjTzbZiU1ea4efZvRBCovl3EKux
 TvpYC49tjpajO5S41gkkXgIhXK2aaQydGELg2uAfzxNMTwi7o6emt3nhXRK5fxsLltAuE1Icg3l
 MfNFakgshvETr0/AJKgn8VV5g9/0k7Z009VNAuqs6iYED6Tx5Hs8qEnAePocvMrhLix5Dn4C03X
 vuIWOEYA1F9BrTKZnv/cEcFUEyLkmACOSa0lnKtAKWAGCaC2w9anmL0PX+CV74=
X-Google-Smtp-Source: AGHT+IEHEkMSptmQvtQPnxpjfa5aPeIVrgeYwEWalrb4GgkQTxcDp07XdEKK59fhDDNSwczGNAAUEQ==
X-Received: by 2002:a17:902:cf09:b0:216:7175:41bd with SMTP id
 d9443c01a7336-219e6f10aadmr152414445ad.39.1734884695510; 
 Sun, 22 Dec 2024 08:24:55 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 12/51] tcg/optimize: Use fold_masks_z in fold_ctpop
Date: Sun, 22 Dec 2024 08:24:07 -0800
Message-ID: <20241222162446.2415717-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Add fold_masks_z as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b98597f500..eb982b73cf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1053,6 +1053,11 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
     return true;
 }
 
+static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
+{
+    return fold_masks_zs(ctx, op, z_mask, 0);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1583,21 +1588,23 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        ctx->z_mask = 32 | 31;
+        z_mask = 32 | 31;
         break;
     case TCG_TYPE_I64:
-        ctx->z_mask = 64 | 63;
+        z_mask = 64 | 63;
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
-- 
2.43.0


