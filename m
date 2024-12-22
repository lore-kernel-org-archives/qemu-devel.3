Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD00E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002wB-AK; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlL-0002ai-6l
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:04 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlI-0002z2-92
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:01 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso31420805ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884698; x=1735489498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQvwlGRTQIrrP2cNu/4FfpMBStYCT1hRoRZv9KuG4DI=;
 b=cMMu4335/5ZKXKAVIwO0p3GGilGP20wnGmFsypeNWLEzcNvHe6EvaSGpz5J3fGU8lZ
 NUxY2TSjVrBj/4ht6jQTKTHD+BW+XT6vc0rqa22zCPPtVXyU7jn43D+6+dhApWNefOzT
 PSZ1d8zC6iM28nb2gu30Ahx1mOPH4iXVoJiA0XcUEIg9m+W0ZPaxoq2dNJi9KB+TkCFB
 MLfsjoVtMDxJSf9CUeRW7XzHixdHOMJQG1689gm22I8OC3WPCBl85xIzYIIJzBS+ro6s
 TZbbJS+rAY20kxqeHPZXsRPOBdmLygJc2LU8Idu51BoZcJqB82CVNN/H6B36suyCvCcq
 fG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884698; x=1735489498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQvwlGRTQIrrP2cNu/4FfpMBStYCT1hRoRZv9KuG4DI=;
 b=IwMt6a5+0BqXMj7HMn7he9L3ACqPEKHi5e1CG+8+Zb2f3+Z0gTUfyJFPgF3LQe4O9m
 d9uv0ep5mfcl8T5zIsNDvGgIYMCj26a14d+AGEsQUqUlUQHDfGUP4/tQOKWCWSdaMef7
 6Th2AGlYDDAbhD51Q3PRFuPLNn/D0Z884icLceZLCokBvPeW2d5qSYk6C2cfVPFkFne/
 /zKp7dNxOu4/Ut5zwiHYgTGng+AuTdvt+MPZe/qV5aH6pneX4jckqtGMbMGsdQRse8W3
 FY9wm5StA6D5x7IdmXrEbkP/T6gMu66iBDbahLkLoMHfbzRf5kMYoWNYlNgbXG23hMGh
 /o+Q==
X-Gm-Message-State: AOJu0YxKKWGhYaAGN52E1QmLowpJx61OrvmYurRw9f9Ul3egIHQNvwIA
 VLrEfZ0RVEowviCLd5ADY6EWeFsYDCRQleckozGutub/p2xI1yNs97lrlvVDDmojY5CkymOGdty
 AwJs=
X-Gm-Gg: ASbGncuVIw2wHRlXNG7CGPO3lDlTFfQNAzjCo1ElIwuhp35NvmmEdZ12MT3hAFhSWD8
 lgWIR4lnpuPrAFYrqBEx+K8Hv7CDoqpMmtunRB2wAmc9PYVS7CtC6NDbKoVGC4IOnT2qb0obfV6
 W06PD2cTHLUUy5TeW2gWAg19mK7ZnUmSmg8V7/6CmFYy8iJQEdFH7jefV593RV2cWPBSZKb/V2Q
 70C1rm/AIKHJypTdGC/C5daHBbXbfF8aVrIP5Eb+vfLbxHlEtoTn0YAX4ESsbg=
X-Google-Smtp-Source: AGHT+IFJaKT2Nldicfday1K6xrYaCJy6TaCtO8yoJ3+D21ExiD4PLt2pmFwPsyVU3bKDIppHGrz2Pg==
X-Received: by 2002:a17:902:ce83:b0:216:5b8b:9062 with SMTP id
 d9443c01a7336-219e70dd21cmr147198925ad.54.1734884698551; 
 Sun, 22 Dec 2024 08:24:58 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 17/51] tcg/optimize: Use fold_masks_s in fold_eqv
Date: Sun, 22 Dec 2024 08:24:12 -0800
Message-ID: <20241222162446.2415717-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Add fold_masks_s as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9906f370de..9c1fba00fb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1058,6 +1058,11 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
     return fold_masks_zs(ctx, op, z_mask, 0);
 }
 
+static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
+{
+    return fold_masks_zs(ctx, op, -1, s_mask);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1701,15 +1706,17 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
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
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


