Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB1C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3I5-0003ez-EI; Tue, 12 Mar 2024 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3He-0003YM-GD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HS-0007l6-O6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29c4fe68666so244025a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254341; x=1710859141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5KtrDk5IPnNDG0tAWNMkEiXDVZJDwN45mTz+TeCGBQA=;
 b=GdMEGvaUAI3jnHq49kTWvoiiWe5LDGy3ml45e5dJnDNmXF0Ic5r1iYsV5DS/zTQ4pf
 udfN449lfTbk0DqaRDH4nfuJD0i6aYt/O8GuzT5yVN6BpzHqLaUaNQHtpaa9QLQfozUC
 EQsv45T3XLNPPxJEhHtAzgjrHrkkv6kQaF5+dQwAIZcPJxdu85PPvEmRvgPMlcbem7A0
 Vb4WsiD0IYE+j2Wd2LAyxOcs/vwdKE2hrIm/ZsXVNI/ekmAGaVs8m0xF4OkiGFnFiQOh
 /qAjt2ZdCJvyxsnxOI4p/6RERR/fr3anpE7SBI+15cD+G8vfVYM0Om642f047t75TfuY
 4Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254341; x=1710859141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KtrDk5IPnNDG0tAWNMkEiXDVZJDwN45mTz+TeCGBQA=;
 b=iCOhjnEDB32ORabnIfSOR8xWVCbIT2R4Hmio6HTib0gSoruQ6q2VpSFP0G/jznt1tC
 vWJxoYmbWcL42F1aAQvdBVX42ItHMo/0dc4KusE2QVLekkfAcYLb7u1ZekSP0Ulhj+pt
 TJZwXxOCi+W8fT2AsTLzF5FnTRWEDVmjpom+eVzoSHyExO9F1ephyvCY+3g6VOW49Asf
 pOUVe6E/3K11mi3IcldfSZDGOfEH686hAHaQ+dGGgNKMA8bKE6eHUbuhDYDm2Y72ee1V
 JURUKFLFYAfWHAiI6uBqeOJSkWVhiXJU1YJwpiDj4/nA1uyuQzwaDSB1AE9YCgUpGRKM
 qiwQ==
X-Gm-Message-State: AOJu0YwAHb6BiHzvWgArMXe56QT1AM4CDzjYjxvJq0h/a7PQ+X3vtJRU
 6Ff5HRL/3BGZlRlCbvCUUdbbsOZjfiNPFhkQpGz1xXIQYQ8tKpaQn4cXMh4nvAveMvIrj9PX5Ge
 B
X-Google-Smtp-Source: AGHT+IGu6IfMQkCydRLVGkB/KcOR1hZjtaBiz8+25roD1Zv6WvvtF9fxvyv+DBxAFUBZYfPFGFuUFw==
X-Received: by 2002:a17:90a:f011:b0:29a:8ac0:9fd2 with SMTP id
 bt17-20020a17090af01100b0029a8ac09fd2mr510545pjb.49.1710254341049; 
 Tue, 12 Mar 2024 07:39:01 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.39.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:39:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] tcg/optimize: Fold and to extu during optimize
Date: Tue, 12 Mar 2024 04:38:37 -1000
Message-Id: <20240312143839.136408-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 tcg/optimize.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c6b0ab35c8..39bcd32f72 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1300,11 +1300,46 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     ctx->s_mask = arg_info(op->args[1])->s_mask
                 & arg_info(op->args[2])->s_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer affected bits from it.
-     */
     if (arg_is_const(op->args[2])) {
+        TCGOpcode ext8 = 0, ext16 = 0, ext32 = 0;
+
+        /* Canonicalize as zero-extend, if supported. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+            ext8 = TCG_TARGET_HAS_ext8u_i32 ? INDEX_op_ext8u_i32 : 0;
+            ext16 = TCG_TARGET_HAS_ext16u_i32 ? INDEX_op_ext16u_i32 : 0;
+            break;
+        case TCG_TYPE_I64:
+            ext8 = TCG_TARGET_HAS_ext8u_i64 ? INDEX_op_ext8u_i64 : 0;
+            ext16 = TCG_TARGET_HAS_ext16u_i64 ? INDEX_op_ext16u_i64 : 0;
+            ext32 = TCG_TARGET_HAS_ext32u_i64 ? INDEX_op_ext32u_i64 : 0;
+            break;
+        default:
+            break;
+        }
+
+        switch (arg_info(op->args[2])->val) {
+        case 0xff:
+            if (ext8) {
+                op->opc = ext8;
+            }
+            break;
+        case 0xffff:
+            if (ext16) {
+                op->opc = ext16;
+            }
+            break;
+        case UINT32_MAX:
+            if (ext32) {
+                op->opc = ext32;
+            }
+            break;
+        }
+
+        /*
+         * Known-zeros does not imply known-ones.  Therefore unless
+         * arg2 is constant, we can't infer affected bits from it.
+         */
         ctx->a_mask = z1 & ~z2;
     }
 
-- 
2.34.1


