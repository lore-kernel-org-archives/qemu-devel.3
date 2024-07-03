Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B5BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP40R-0003NG-H7; Wed, 03 Jul 2024 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP40A-0003J1-JT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:42 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP405-0005Lr-Rw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:39 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c961b5f215so1380011a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028555; x=1720633355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7spuBkQx1Mu7jCpv4kzIy4W/rs9oZa5KoZssRj5BGLM=;
 b=uSjzt9lvjqd+BjeB3PxVHjSymKjuwLspoalAFkrwN/zeXpU7JR/2COFbOzEyqImXCu
 1exnMwWEAYcZVesVuacIgaeUCCGLSXKDw4PFFqxcQpFJFXPFBJtFoGlqckc8+IftQhqx
 FqZ/Cl09Gx9dOQjmZNUGD4emmDkN9LGiQL1Tqfpv83AchdVlErxikk6THkE6MAtZ6TR5
 QNtrx37QMgohQI7oOjwtLQp/PL1/q7qSdHrebeK52EBpnef1n/S6p33Ie4QD4ainLFEQ
 cKcXljuvQG0KbnznBLAJfjeXAVpdJ1qM3PLn1VO3n7AK7o/9m2hG/six1OyXUSEtE833
 QjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028555; x=1720633355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7spuBkQx1Mu7jCpv4kzIy4W/rs9oZa5KoZssRj5BGLM=;
 b=SRHufD4e7UKWjLcLlReAJes525JCU7vHHSPqwOHZ4u+8zlLM9UKG5MnIDYeiReWqMB
 wfTOjbVomHPaY+XlrIWTyUGxeoHRaNlsOIpejZ3W4YONKyMTbWcFZcb/Ns6aA0ao7h47
 hNK+cvIRb7IQGuaDwLOm34LzTh+xXE8CpyW71/fZiVNCZ0mCy3TkNppB03J48DqAODgl
 91yd4siHWZqhxWnsi3HoSqt6DVK7nK0oCV3JCc9so6ga3wZkXvQH2Xv0lxdjKfp1G8Zt
 xQ21AY7/jeLO8robH5anZ1FpzAq4zXG4/lu8bVrq1YH3ciQab3kghQtM2EK0qYXSnbKW
 Rjgg==
X-Gm-Message-State: AOJu0YwQ7dvVMebQh4doFzd0bDlVWnNELmjE/ZdJ1f7+7K5VamhXRIuu
 wG3X5VGzlM2+lOrAmYX+WN9YecVb+UjuyPtksyvN1OiYMs+jA/4C+MTv7vtgZemABV6MYGgwzOL
 7
X-Google-Smtp-Source: AGHT+IENfYBdzqgRlMiDpUzjBk/rXepj9Ae3rm1N8d8sGkopqcLdCB7bRRNLoBu2C0mUOQorRd98dg==
X-Received: by 2002:a17:90a:4214:b0:2c6:dc3b:d6fd with SMTP id
 98e67ed59e1d1-2c93d767707mr8395488a91.31.1720028554450; 
 Wed, 03 Jul 2024 10:42:34 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 7/7] tcg/optimize: Fix TCG_COND_TST* simplification of setcond2
Date: Wed,  3 Jul 2024 10:42:26 -0700
Message-Id: <20240703174226.2117169-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Argument ordering for setcond2 is:

  output, a_low, a_high, b_low, b_high, cond

The test is supposed to be against b_low, not a_high.

Cc: qemu-stable@nongnu.org
Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240701024623.1265028-1-richard.henderson@linaro.org>
---
 tcg/optimize.c                   |  2 +-
 tests/tcg/x86_64/test-2413.c     | 30 ++++++++++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/x86_64/test-2413.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8886f7037a..ba16ec27e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2384,7 +2384,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
-        if (arg_is_const_val(op->args[2], 0)) {
+        if (arg_is_const_val(op->args[3], 0)) {
             goto do_setcond_high;
         }
         if (arg_is_const_val(op->args[4], 0)) {
diff --git a/tests/tcg/x86_64/test-2413.c b/tests/tcg/x86_64/test-2413.c
new file mode 100644
index 0000000000..456e5332fc
--- /dev/null
+++ b/tests/tcg/x86_64/test-2413.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2024 Linaro, Ltd. */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2413 */
+
+#include <assert.h>
+
+void test(unsigned long *a, unsigned long *d, unsigned long c)
+{
+    asm("xorl %%eax, %%eax\n\t"
+        "xorl %%edx, %%edx\n\t"
+        "testb $0x20, %%cl\n\t"
+        "sete %%al\n\t"
+        "setne %%dl\n\t"
+        "shll %%cl, %%eax\n\t"
+        "shll %%cl, %%edx\n\t"
+        : "=a"(*a), "=d"(*d)
+        : "c"(c));
+}
+
+int main(void)
+{
+    unsigned long a, c, d;
+
+    for (c = 0; c < 64; c++) {
+        test(&a, &d, c);
+        assert(a == (c & 0x20 ? 0 : 1u << (c & 0x1f)));
+        assert(d == (c & 0x20 ? 1u << (c & 0x1f) : 0));
+    }
+    return 0;
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 5fedf22117..eda9bd7396 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -8,6 +8,8 @@
 
 include $(SRC_PATH)/tests/tcg/i386/Makefile.target
 
+X86_64_TESTS += test-2413
+
 ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 X86_64_TESTS += vsyscall
 X86_64_TESTS += noexec
-- 
2.34.1


