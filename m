Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CA2C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qOg-0004EE-J0; Tue, 30 Apr 2024 12:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOL-0004B1-Q7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:43 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1qOJ-0001Ln-U5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:31:41 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e01d666c88so30383541fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714494698; x=1715099498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCNarZpX3uqPfQyzfPij83XtHCVdaS7zebbTvIEwqqw=;
 b=NjK/MZqhgi42Qtx1v78CB1t8qTJa7UAmM81YlzFYXxkfUXNQLQBOVT8IBDxqTWS7cV
 J+XXrOzSm/Dx9dyPCPkX4fHjo+YhQ09xkDM+kHQBNiFNb6Mv+jYoLmdkBnyGzhtXNWN6
 hYR3OaiiAXdYiF8jR/KeFavghEocneaPRTr+S/akvKpZdKCgcPmNcqwiaik4WxRERRK2
 Vlz0S5/CjMgJvKN7DAX1gOlWSBvS4+uCcOem/INYEWi4a+VoGHQdvi/R1QUIto7acpF/
 gnmkV4hqnJWk9KcpVjzWxCd2o1F5IoFkDLDQ5qbU6Gc4o2+Hne/Zb2793ow2aoj7scKc
 iQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714494698; x=1715099498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCNarZpX3uqPfQyzfPij83XtHCVdaS7zebbTvIEwqqw=;
 b=IO0/qmKhCqm35FqQSjFuN+P8X/HNX0J0Ly2gtbBjSDq2o6ZV+ol8pzItWM5DohGNbX
 CELUySMyCR/PNtpGQItdjGI5GUkfZ0HqiscZ3Hk6CwoZf3jWRqS3wkZznBRbheMTiuR8
 OiYwPYDI+ADP3JmKRAkNGpB1Etiu5ZszXPcoJjtEXpzGWgM40eM8OvgDIiO3KjbrHJCZ
 SrsAE/dCTVtFpPCgxBNL71GimApWg7juRDTrAnOrVYKRjXvSlmq3jspY+gsvmCeoamDa
 f8SEb1TusjQxUQAI3lqLxpmpIVz2urQMqvIz7PNVrivUTgODekdMwP5m7l2ieKZlReUN
 7xpg==
X-Gm-Message-State: AOJu0YyTzV3zffGQ1Jq2ijwOT9rUCnsKTOgHajjskpyCk/THKL2VCDdW
 5V3sz/2Er1yLUIjMKooZZnCgEbVKtd8gjAjY6X61YMW0LWJfwOboRsWh/ehVwta/7gCK9CKOpOn
 E
X-Google-Smtp-Source: AGHT+IFI/gM2S3N9z/Ed86H1vf1JmATjfFI3XIwxI9mB2Zp+2MsK3hqGG77xK4aIhKkydKfM2lq9zw==
X-Received: by 2002:a2e:aa98:0:b0:2d6:ff04:200f with SMTP id
 bj24-20020a2eaa98000000b002d6ff04200fmr105998ljb.33.1714494695717; 
 Tue, 30 Apr 2024 09:31:35 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 je1-20020a05600c1f8100b0041adf358058sm25854005wmb.27.2024.04.30.09.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 09:31:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 1/4] target/sh4: Fix ADDV opcode
Date: Tue, 30 Apr 2024 18:31:22 +0200
Message-ID: <20240430163125.77430-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430163125.77430-1-philmd@linaro.org>
References: <20240430163125.77430-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

  ADDV Rm, Rn        Rn + Rm -> Rn, overflow -> T

But QEMU implementation was:

  ADDV Rm, Rn        Rn + Rm -> Rm, overflow -> T

Fix by filling the correct Rm register.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2317
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-addv.c     | 27 +++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/sh4/test-addv.c

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ebb6c901bf..4a1dd0d1f4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -714,7 +714,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B7_4), t0);
+            tcg_gen_mov_i32(REG(B11_8), t0);
         }
         return;
     case 0x2009: /* and Rm,Rn */
diff --git a/tests/tcg/sh4/test-addv.c b/tests/tcg/sh4/test-addv.c
new file mode 100644
index 0000000000..64f709161f
--- /dev/null
+++ b/tests/tcg/sh4/test-addv.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void addv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("addv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) :);
+
+    if (c != carry || aw != res) {
+        printf("ADDV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    addv(INT_MAX, 1, INT_MIN, 1);
+    addv(INT_MAX - 1, 1, INT_MAX, 0);
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 4d09291c0c..521b8b0a76 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -17,3 +17,6 @@ TESTS += test-macl
 
 test-macw: CFLAGS += -O -g
 TESTS += test-macw
+
+test-addv: CFLAGS += -O -g
+TESTS += test-addv
-- 
2.41.0


