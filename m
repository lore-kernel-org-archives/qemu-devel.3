Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0BCCD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGN-0000Wm-JE; Tue, 09 Apr 2024 15:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGM-0000Wa-Eu
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGK-0004ch-Mq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso44162425ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691367; x=1713296167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0/ekaTyyBHEzg2gMKpvUq/mv6Nl9iOhi1rhUNF8qDbI=;
 b=Vupl/HD7D60CsOuas8d1rhFSjgblZaHPdwrS4MOwkUzlAl6UGBAUDbAWA0cLir+V4U
 4QAOvbSZ8fNpgoJVuWdmPqG9tsaflo+Uo7SJ2ahzGd2O9SNlCiqvUFYqzeySus4m4Njs
 bB+BGyGCeZQ+DK2dZuKXtaalqr/dT4GtmQ/aXEHBg+1YnF5i6bItkCPrZ+Te0X6FqAGD
 qlMw6BsHNd/SjANVfQwhtQZovzixqAGLMxlpK/gtyp61jjxvG/fmyARv7Keio9AhdIag
 QksbIBTvU4vqugeL9Unzold0pmkQWBd4uxkJ7moiIM56depruhS7j5eoLpGhYVDIarEn
 wuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691367; x=1713296167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/ekaTyyBHEzg2gMKpvUq/mv6Nl9iOhi1rhUNF8qDbI=;
 b=fJcliDiQ2TsB6Awp7hcGKa4mE6sQhmqPET4Cbr1Y7bL32tmF2AGBKh/SiPRAHHJDhU
 erwlzZB3YZT8rdIgOBKATczTbWVIVtZZyc+JTrJLnuumTL3Yj5C+kgjh76ZoCTivE5a3
 AUza7AP/T25r1JAgPc33FEc15cFWjU/21/+pwqbAzJDgrr+Xv51EbHTIfj4b6a8FyQ50
 GPPXgEaGYWR756UMxaIwbPH8HAD5dougGm8ZnmgVoNFvzinBBKCWdD96P6wA8htBbskf
 V604DjgDZkQxDwdhIDQUKwDDqdw4ELO23XFtdVrA/06n6/O937mwde3aD0YC0b/3LZdQ
 O/Qw==
X-Gm-Message-State: AOJu0YyJQgNgDMWQa39BaFGZLjqWmDbCGZ70ErZLj/axktdnv3WuekLd
 iApDLEYkQoC7mFmQOsiFJW0cjQ4Ou4Qb+COCEXKh36+qJWpZmGdN2min12IObuJ9x3q5LkobLy5
 y
X-Google-Smtp-Source: AGHT+IHA3RfLLR3DsHquCjRYlwclSDo3jybSQ5kXXbsXwW0LXzdB7GJxk/07oZtvLxT1rtH//e7RpA==
X-Received: by 2002:a17:902:e944:b0:1e3:e093:b5f0 with SMTP id
 b4-20020a170902e94400b001e3e093b5f0mr766918pll.8.1712691367109; 
 Tue, 09 Apr 2024 12:36:07 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/20] tcg/optimize: Do not attempt to constant fold neg_vec
Date: Tue,  9 Apr 2024 09:35:44 -1000
Message-Id: <20240409193603.1703216-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Split out the tail of fold_neg to fold_neg_no_const so that we
can avoid attempting to constant fold vector negate.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2150
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c                    | 17 ++++++++---------
 tests/tcg/aarch64/test-2150.c     | 12 ++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/aarch64/test-2150.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 275db77b42..2e9e5725a9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1990,16 +1990,10 @@ static bool fold_nand(OptContext *ctx, TCGOp *op)
     return false;
 }
 
-static bool fold_neg(OptContext *ctx, TCGOp *op)
+static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
-
-    if (fold_const1(ctx, op)) {
-        return true;
-    }
-
     /* Set to 1 all bits to the left of the rightmost.  */
-    z_mask = arg_info(op->args[1])->z_mask;
+    uint64_t z_mask = arg_info(op->args[1])->z_mask;
     ctx->z_mask = -(z_mask & -z_mask);
 
     /*
@@ -2010,6 +2004,11 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_neg(OptContext *ctx, TCGOp *op)
+{
+    return fold_const1(ctx, op) || fold_neg_no_const(ctx, op);
+}
+
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -2418,7 +2417,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     if (have_neg) {
         op->opc = neg_op;
         op->args[1] = op->args[2];
-        return fold_neg(ctx, op);
+        return fold_neg_no_const(ctx, op);
     }
     return false;
 }
diff --git a/tests/tcg/aarch64/test-2150.c b/tests/tcg/aarch64/test-2150.c
new file mode 100644
index 0000000000..fb86c11958
--- /dev/null
+++ b/tests/tcg/aarch64/test-2150.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2150 */
+
+int main()
+{
+    asm volatile(
+        "movi     v6.4s, #1\n"
+        "movi     v7.4s, #0\n"
+        "sub      v6.2d, v7.2d, v6.2d\n"
+        : : : "v6", "v7");
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0efd565f05..70d728ae9a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,7 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
-AARCH64_TESTS += test-2248
+AARCH64_TESTS += test-2248 test-2150
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


