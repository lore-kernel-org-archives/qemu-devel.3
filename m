Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM7-0008Lu-4W; Thu, 19 Dec 2024 23:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM5-0008LN-Gf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:13 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM3-0006Gt-Ep
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:13 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso13176365ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667870; x=1735272670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9/02VItWnKuXE48s/sX8jbBZgUlVlj7VS3J2PwQvow=;
 b=hwNDdDIeHUwsokUfkP+ivW7VYxRqUcF7j1LFin2cAn/OGPuBTOkYED6j+J0EaBAFPo
 9edP4U+NfZCekYUh4p7Yxv83/uMxzeGHz2bSnVdpchc7eVljesD1Au0yLu+XOleT6wCO
 VmDZi1lVoAaA5pgM0YcUkVgZpz4qGNQ9jJyJjwAkJzYHyt6cqPSHGzBQkAQs9aHrgsRb
 kOdnEYp6Gezdrf/GsdW2wSNREMyuQbgkU65Dn05S58fewBQkLy2tbtZ+RT28Z0tROMjW
 32eVxnMUj9IuaDr/vodIeZMJThn/0c3YReL9+MFwPVg+Znz+IXKAIfEXBY9e9DIDaRU0
 1Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667870; x=1735272670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9/02VItWnKuXE48s/sX8jbBZgUlVlj7VS3J2PwQvow=;
 b=gQ6KMyX6zXP2yTS/yrNQm0ipwKzn8D0s/Sdn2ZlPIZT75kbfQVlgMFwdx772oXeBjj
 e73DhqVXcJeUGRJvp4Wi4jLxNnvgCWyxGE9HeeXYFczNwGcs6yQNVDAumHl7NYa7wzbY
 GvK2AYHJhROTTNJ2SjIcToojukNdqp6UaMrx05ZIS/fkLhuj3iMoqJrhhA/mK1nb1eex
 ai0/1JqHjSj84nCaW6m9Kn0kbHLiQhDLYrE4rvtmbxN/Jy2km0n8IkZpChLSAZ9t61VI
 nP69J4ibGEqKcrz+7yEhBPURV7uTdd2QlGmbKybLmdJePsruvZC5Mk3EpPdvmfQAP2Ap
 HxKg==
X-Gm-Message-State: AOJu0YzwNJ3DZCpE+MRFET5VxsbYm/aa5Oh7DzRzZ4ZNxdR1A1u19DFh
 yJ6ZDkYDqSXVj/vefqGxMTuywlGwMPjfJJmyN6RDBHIT3xbYF07jS4M0K3X6lbX7m49RHkPtg9y
 N
X-Gm-Gg: ASbGnctgcO+X80dl/HbX0XM9GDMgqbi3sslmW3UKDmSEUCUc3KMsYtDlbpQ+IARAsKN
 co8E2QCEb+WtxlgdXm2LYasCPd2i9kvBlCTcKUWO0flVTKz1/r5FAzSTjgUhH7qK7SXW5PSW3z0
 t0m/TEA27b/IIH/9cAc12Yizp+Ik0DIu4VLyzsbn6qjS40Al26S58bgPNuasH1U1oYWEYfS4WF3
 iRpmwIhffFw/9+nPK05/76C3pfIm7hKoWxeGW2tdZAL0E1NIpPAynOjwx8bD8Y=
X-Google-Smtp-Source: AGHT+IGl3FjmRdwUD2Hq9QFLUu+eNQRkiXS4Id2z+jWJd/zDVV57nZOqcJ6ukDOdGEoXsJveW8bPBQ==
X-Received: by 2002:a17:90b:514d:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2f452ec1ceemr2003756a91.26.1734667870127; 
 Thu, 19 Dec 2024 20:11:10 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/51] tcg/optimize: Use fold_masks_zs in fold_and
Date: Thu, 19 Dec 2024 20:10:19 -0800
Message-ID: <20241220041104.53105-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
Sink mask computation below fold_affected_mask early exit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 41fd69365b..52c785472f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1313,7 +1313,8 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2;
+    uint64_t z1, z2, z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
@@ -1322,27 +1323,28 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
-    z2 = arg_info(op->args[2])->z_mask;
-    ctx->z_mask = z1 & z2;
-
-    /*
-     * Sign repetitions are perforce all identical, whether they are 1 or 0.
-     * Bitwise operations preserve the relative quantity of the repetitions.
-     */
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z1 = t1->z_mask;
+    z2 = t2->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer affected bits from it.
      */
-    if (arg_is_const(op->args[2]) &&
-        fold_affected_mask(ctx, op, z1 & ~z2)) {
+    if (t2->is_const && fold_affected_mask(ctx, op, z1 & ~z2)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = z1 & z2;
+
+    /*
+     * Sign repetitions are perforce all identical, whether they are 1 or 0.
+     * Bitwise operations preserve the relative quantity of the repetitions.
+     */
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


