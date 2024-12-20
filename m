Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C667FE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMW-0008WM-Bm; Thu, 19 Dec 2024 23:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMS-0008UE-NM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMR-0006Pb-8A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:36 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fd4998b0dbso1172795a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667894; x=1735272694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ic/XAXWDqyq8gqlT8LhIvS1MArK08ZpPNDJQ4rUACM=;
 b=hhA1kuzzQ6O1lfn/lE8/WNLuplL///QZgH5TodYOhSCsFqAUowQHDlzjsolw6+AcG4
 EUcyV7gUqqBkb2bj4NnK7qOxFwmDceKvATsKxSL2YB+jYvUy017TbQWsPr+0lfAiobKG
 4TK+iL2TaSt30KB5mq0UBxCd5R+XAn71BGALP0Fya5kifAS3s0Azzor4bWuYaXEfmcNW
 kH7QM8q3b5m2e5MaC4gDNbU3AIqm57jipZLrFSgP4pp51VZvCvrAGi6Qlk0d71teeIjH
 EP4D+izkbuL0x636GVOjms5HhqXlXqXxLH4iGnKxWetCxPeAGJcNDLxJ5a5afhZIQC5A
 7nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667894; x=1735272694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ic/XAXWDqyq8gqlT8LhIvS1MArK08ZpPNDJQ4rUACM=;
 b=S5sGiMiG3J0lLvJvmR5BePKOrY1OalhUsil6c4ktAnV9HJ+rDo4dMF+L5yDXZQAEym
 0Wj7/14Zn0W81rt9TaGCHhCbxV9/LbUu8io3WQcFVLsC8FpQARFIIKA9cv5qfAT92RQN
 wbF1casD7mJgxTtkCbhIg417V8vRhjr8/hRFjfWSETRC5UR7nQY5ikfPbCCRvpUq5bxo
 OMDStKa+3ocpBBxKbDC8fyFIzYRyUOUbT4pXf7tOCX0bxt9Wc7yNRhKDxj8pO6y/26+U
 /OedF4e9Phn5gLKEZyYfed5WKgnP56zlgUdbWCBeFQh2yAnn6olxTBLLYa51cTrBEji5
 VVZQ==
X-Gm-Message-State: AOJu0YzcffRjfKKZvLr/J3OqGrnaGUGm6ZB1nT3Qq0Bki6g5bC0Hk/ei
 hsp/99kx6riwgXCqyt3STsz3vRh4iXOLcmmDCgl5AeOHWiYbewTyJ25in1evabgU/9JUzlCZvVw
 V
X-Gm-Gg: ASbGncvWQLLFd2a2TEt5tJvp2lDak+7ro5hdvwmJgCrEqsxU1JS/+KKM41zuvOM31Ls
 aHZzj/W+U0FwKkJVsFqzpGD+wv6wZcLOfYYUfAzEjJzB0Q0Dnz/I+T19nLIT2Lp3Wq0OniCU92y
 kfVQbvUMaZLL6sKAtoq4q2TvnW1VQS8gK4Qwg2Q7Mph3+G6EU+W8VVUvw2o1CLRrsp3KZ4QaVgr
 esQGhHLhFCQu15Od3vnGAp1KcKjvkcTz7HWUw/g0uHU+j+MirnuqzgrHEsH1lg=
X-Google-Smtp-Source: AGHT+IHzbP5UDfjXtI6qZUnEPkUii0wv7fvgbR1ZdVmcU9NDz4e9DhOI07pN6/ONRNh1vIVLtK9gnQ==
X-Received: by 2002:a17:90b:2b8f:b0:2ee:f1e3:fd21 with SMTP id
 98e67ed59e1d1-2f452eb3cecmr2111623a91.25.1734667893807; 
 Thu, 19 Dec 2024 20:11:33 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 39/51] tcg/optimize: Use fold_masks_zs in fold_sextract
Date: Thu, 19 Dec 2024 20:10:51 -0800
Message-ID: <20241220041104.53105-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index fae6a29685..d0a9ea1ee4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2524,31 +2524,25 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = sextract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                sextract64(t1->val, pos, len));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-    z_mask = sextract64(z_mask, pos, len);
-    ctx->z_mask = z_mask;
-
-    s_mask_old = arg_info(op->args[1])->s_mask;
+    s_mask_old = t1->s_mask;
     s_mask = sextract64(s_mask_old, pos, len);
     s_mask |= MAKE_64BIT_MASK(len, 64 - len);
-    ctx->s_mask = s_mask;
 
     if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = sextract64(t1->z_mask, pos, len);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


