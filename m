Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C968BC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkj-0007Ge-Do; Mon, 27 May 2024 17:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhki-0007Fu-7D
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkg-0003fr-KZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso133307b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844769; x=1717449569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pY1AqDmFwzHRKrYxWyYh9P2mS4HwwxqubFK5uFR9FTk=;
 b=FfvTa/IZGZNyLNZce1RDQtDKiNXpFgx55PyLTKy+gCjZUZz3zXXeS7aSboerWQgTan
 pZD7LDMa2xKnXHQFbumlcCm6pWvhXb1wtqwnestCZ+WeFmoxwRpOcY4f6Lkj9b3KH2aD
 ZoLvrZzzy+tTYudNaekYsA2KLjGcwdKLYRBkYmdEfJRY7zAnjVTBF172X79mXRBIG0zb
 TzDVE8RkqD4WgNax9UnDg/fr0iDP30iq3vQPC/mOZ2uE+ZzqvzODoFnvaD7ec0y7ztg0
 qF9oCQ2oKqLmcjgLpUy7kzgapv4ub0VMqExnI2dmTd5/v8eLa5RE5hbuMVpEe3Z0giML
 bREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844769; x=1717449569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pY1AqDmFwzHRKrYxWyYh9P2mS4HwwxqubFK5uFR9FTk=;
 b=jnWxJ8Qndr6fRzIK5ucEPaidM+o6UoX+ZeNwTWSegLSyz5OmTYNjJcETNqcQwh4OIj
 lN2GMHgDA5pB7yRppAPgAjnCKT615+VhxNglj/2cnWwz6AvOAVRXxXzjbnFvkfXI6HIj
 wyTKz8tDdXbVRv0R3Uie/4f9sKoDsWlGFaRj28nWyfq5gU2UVQVxg5dG0RiStnBG0s+B
 0mmOebxAJX12DNNdwpsp9tqRES+THsuu/hNbm8DarnI6MYbRrNmOGdCRQrqCADkzPHZa
 /e1T0DNLg842LrUtqYDzIsTJZerkuOs+aTLUc+Nb6YCWVMCga3Rc3Qlr4VJ8enw9Nypv
 g7Vg==
X-Gm-Message-State: AOJu0YwxrL4nWYEHbpGOOQuduzRrJHac6GSJJcxv+KEXbGONZWq1VNEE
 QFbSUS69XBy6FOGQvkGoa8lDp4wFWEIeHiMAMBLQE9I8LGvHqHcY1SBq4XLEfGyu90YjO8KPaEA
 z
X-Google-Smtp-Source: AGHT+IFcmdn8Yg7z/PLGxyR0oTUr+c5y0l9kFqRnA+WA5asJylezXOGAspKjp/S6z7d4qhZpXvNuKg==
X-Received: by 2002:a05:6a00:7c8:b0:6f4:74b8:3d57 with SMTP id
 d2e1a72fcca58-6f7726eb231mr13940661b3a.7.1716844769334; 
 Mon, 27 May 2024 14:19:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 18/18] tcg/loongarch64: Enable v256 with LASX
Date: Mon, 27 May 2024 14:19:12 -0700
Message-Id: <20240527211912.14060-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 990bad1d51..58bd7d258e 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -173,7 +173,7 @@ typedef enum {
 
 #define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
 
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e2b5aad5e3..0b41b807e3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2484,9 +2484,14 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
-    if (cpuinfo & CPUINFO_LSX) {
-        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
-        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+    if (cpuinfo & (CPUINFO_LSX | CPUINFO_LASX)) {
+        if (cpuinfo & CPUINFO_LSX) {
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+        }
+        if (cpuinfo & CPUINFO_LASX) {
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
+        }
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V26);
-- 
2.34.1


