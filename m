Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D311C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3HN-0003Vw-MO; Tue, 12 Mar 2024 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HL-0003V3-KR
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:38:55 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HD-0007iL-Qb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:38:55 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dc949f998fso5126932a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254325; x=1710859125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+H4gb0JZklIT8hGflGjARBk523KJUlTbHGv63Qa3NVo=;
 b=L5VtP5TBMzfW6z190PqZObdPrXZIvMQGknkJRBgCmYZ8hK4Gh3GItTE6o0YsZFraWe
 hS3Mhk6SqH8rtEsrOiq7yaMabTkogJn7OT04tqudTAyu/C/cKtUIueKQXwaN9LZqP7S/
 TeXW/y6wvandxsE5gtQ6AneyuQSazMOq3ULbkIiGPygZzvy9NRai0OXnqbEc7c64DOBx
 thyOoPEIpjc2qTbf4ejw6OgCGHF9ShnOvSnk6eiUQ3iz4KDeVBjWG9XRRPc7PFnkwqF4
 5t3H2Ca6unZ63//zI/E5c5Hod/OoYsLf1ISjOebfxggWrPelL1WQK9/e96Fu7I8nOBRj
 XFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254325; x=1710859125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H4gb0JZklIT8hGflGjARBk523KJUlTbHGv63Qa3NVo=;
 b=FiSMXem3GjD6O8DKgIkFYUBZ322j2p2zFcETEMmXc3cdF00XKX8AX+lfosjB1UsVn2
 PqlYYc1zPW94It7JmTrBqVN9t4+4KoQp+qSA0Gw2i2886ft6ThR4y9jW48T5G9TouMQU
 6kZDiiHc3ig4dviLkuBqMpTpPMgjPq69sXBbOAOqdPa2SifjwHbcJhVTNiiL5HYwwNWT
 1uLa/GopWsqIWTwHL7/lP75h3so3j5/Kdv02BXAvktz1/0xEBey7KqyO4ZUp43SGZ+yV
 YAmoQAOPUy77uz8bZKWNhb5CTBOS2Ee3AngYIBlyLC2QsJjA2JslIgdh6X+6voizM5FH
 LTKg==
X-Gm-Message-State: AOJu0YyI5uZ6dleuaSu6hNhcF9mtZOyx5TQc5sg8pvkPAX1zeRnxxUQm
 Uf0G1ND3YAQ23REZqGDWMGgCf1IMLQRabKnyfzp47EgT0SbH/CP+mc5RKtbCORf77oCNvl4WUAy
 A
X-Google-Smtp-Source: AGHT+IGTpWip/BLsisPEtx6zSjrRYDA9hCDrR8obtFb2GrDS7YZvoENFAVJrNYKU8yoxignOJ8dS9Q==
X-Received: by 2002:a17:90a:390c:b0:29b:a509:30aa with SMTP id
 y12-20020a17090a390c00b0029ba50930aamr2148609pjb.14.1710254324815; 
 Tue, 12 Mar 2024 07:38:44 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/15] tcg/optimize: Fold andc with immediate to and
Date: Tue, 12 Mar 2024 04:38:25 -1000
Message-Id: <20240312143839.136408-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 tcg/optimize.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 752cc5c56b..2ec52df368 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1324,17 +1324,23 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
     z1 = arg_info(op->args[1])->z_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer anything from it.
-     */
     if (arg_is_const(op->args[2])) {
-        uint64_t z2 = ~arg_info(op->args[2])->z_mask;
-        ctx->a_mask = z1 & ~z2;
-        z1 &= z2;
-    }
-    ctx->z_mask = z1;
+        uint64_t val = ~arg_info(op->args[2])->val;
 
+        /* Fold andc r,x,i to and r,x,~i. */
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_and_i32 : INDEX_op_and_i64);
+        op->args[2] = arg_new_constant(ctx, val);
+
+        /*
+         * Known-zeros does not imply known-ones.  Therefore unless
+         * arg2 is constant, we can't infer anything from it.
+         */
+        ctx->a_mask = z1 & ~val;
+        z1 &= val;
+    }
+
+    ctx->z_mask = z1;
     ctx->s_mask = arg_info(op->args[1])->s_mask
                 & arg_info(op->args[2])->s_mask;
     return fold_masks(ctx, op);
-- 
2.34.1


