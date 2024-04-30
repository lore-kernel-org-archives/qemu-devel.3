Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81363C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qOs-0004HZ-Ee; Tue, 30 Apr 2024 12:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOa-0004D3-78
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOQ-0001Ms-6w
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so48497615e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714494704; x=1715099504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3Dvy0wvVxKNBXh21IDmsrC5sWJZyoTg3iWrcJY72Ng=;
 b=kLr90zxLjOBy+I8pNRg+k+iYhUpFVWF5nvx+AI4r8SqYHk9l5mGNzoCXC9qziiMCxG
 RPcIGC7eVP4zgYbjLM751VcUQ/6g6fjTYVNt8EcFBNHOI5qyJZ1kv9fUsH9Y3vDcPrR1
 ljuL3SoEPriv8sn40D8TuaDlpzNvwW1HDY8aKOFTU3KiA94mMVenzKr80qO8RHze4Tm+
 BKE9cowxQ1Ev+fXigeHr9zW6ioIEp2Y7FgHNhVVNU8cWzyq2rUT72aSvuKsdLtQWy68S
 ME4irtvIqNbheMlUiUV4bmSWCmbVx9HTf6+FgzAy2wpPEQ9T+b07zR36uEO9sNuaKGX+
 sEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714494704; x=1715099504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y3Dvy0wvVxKNBXh21IDmsrC5sWJZyoTg3iWrcJY72Ng=;
 b=uCWUlOjUOebcIQxGzBL173DtnZLZ0yJ1fPkNljGe22dqHjVhazush21HdXB2vouLcw
 cEJp73NpFkljotjE62G2lnlRyjlAATXJ43CdFRlrsnA4+jxZJcKA5LrNc3p083lENGbq
 rwXru3zGRDQShxtcp+rfOw2SsT2Bnaar+OPUdhM+qI4aubcYHNr8CTQabvuZQqWg3rKb
 IaOwowBb6yI3j/UQ4B8CEXACi+rDQQJOtIc6BRDKd7JsdDk15K++ctSrxYtvyfsja2cK
 IBsEKhc9ViUW+aCjoO+B4w9a4935sRjw6dSk6bHtliPtrv/tMIxdY/owIpdHTMMqy8UT
 BV4g==
X-Gm-Message-State: AOJu0Yy4d+xkucjmvJFe5kLz8ahLZKBrrABtH2V3nukooFULtxRFBvz3
 JLrGIFxjpoi6kfNYjxeAVh6E7AzzLnloVfJTpuwpqTkK+V0tbQfjHn/7fkxPJzfImmFY3lP21fV
 P
X-Google-Smtp-Source: AGHT+IGhhXF0l5OMACQKTVhNESdbFWWNdjxBRaneM6YJOl8WeYVM3/XfHQT9LSLiWbU2n5VA5mD+UQ==
X-Received: by 2002:a05:600c:4e11:b0:41c:8754:8793 with SMTP id
 b17-20020a05600c4e1100b0041c87548793mr21902wmq.41.1714494703775; 
 Tue, 30 Apr 2024 09:31:43 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05600c500700b0041bc412899fsm14286158wmr.42.2024.04.30.09.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 09:31:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/4] target/sh4: Fix SUBV opcode
Date: Tue, 30 Apr 2024 18:31:23 +0200
Message-ID: <20240430163125.77430-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430163125.77430-1-philmd@linaro.org>
References: <20240430163125.77430-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The documentation says:

  SUBV Rm, Rn        Rn - Rm -> Rn, underflow -> T

The overflow / underflow can be calculated as:

  T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31

However we were using the incorrect:

  T = ((Rn ^ Rm) & (Result ^ Rm)) >> 31

Fix by using the Rn register instead of Rm.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-subv.c     | 30 ++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/sh4/test-subv.c

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4a1dd0d1f4..3e013b7c7c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -933,7 +933,7 @@ static void _decode_opc(DisasContext * ctx)
             t0 = tcg_temp_new();
             tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B7_4));
+            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
             tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
             tcg_gen_and_i32(t1, t1, t2);
diff --git a/tests/tcg/sh4/test-subv.c b/tests/tcg/sh4/test-subv.c
new file mode 100644
index 0000000000..0dd8fcdaac
--- /dev/null
+++ b/tests/tcg/sh4/test-subv.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void subv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("subv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) :);
+
+    if (c != carry || o != res) {
+        printf("SUBV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    subv(INT_MIN, 1, INT_MAX, 1);
+    subv(INT_MAX, -1, INT_MIN, 1);
+    subv(INT_MAX, 1, INT_MAX - 1, 0);
+    subv(0, 1, -1, 0);
+    subv(-1, -1, 0, 0);
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 521b8b0a76..7852fa62d8 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -20,3 +20,6 @@ TESTS += test-macw
 
 test-addv: CFLAGS += -O -g
 TESTS += test-addv
+
+test-subv: CFLAGS += -O -g
+TESTS += test-subv
-- 
2.41.0


