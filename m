Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48917C25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ouB-0002yP-MI; Tue, 30 Apr 2024 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouA-0002y2-Ok
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ou8-0006dn-AN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:26 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51acb95b892so7186752e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488982; x=1715093782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0X80mS9yZh3HbIdA8l9s4NtXPfqvlI+J4uan4HO+FY=;
 b=Cljq54H6VZ+OsZ+Bfl5IGDso0eqP3uE0EvEU6dfHQQY9Yd2mbAFV6lvC7t7xo0YErJ
 2G3PekTUnpQglaDBnC2RPUy8cDi7s98rAYx+0kk1pmBwwcuC8NVYFXo8Crjg9NKWYzRt
 9hLWoxvDyv0W9yp7xFivZ1PWji/utqg898288sxZVd86m5AHb9esNlRZgUyQLrKlnxeO
 P2NfGchPu9gvzvm9Utf57JfOEGQrL6kaP5wL8IrzZTIBPC3VEv11GE0BdTcNdAFugeSJ
 AHtQ+bEhq5QVL6HNdTTQUqDLODfsZ8Ga4vFWlUXtIq1gZOs1+X1Lzj6q0EVa9NWpPB2n
 uWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488982; x=1715093782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0X80mS9yZh3HbIdA8l9s4NtXPfqvlI+J4uan4HO+FY=;
 b=oqX0loldzYgHxOsp64sq+ye8R1cPRGMnW9Qk79SPhSWKITWuXeFNOxpFJ2fX0nKeBM
 3mF/RDlkxAGLWTr9yf3oF5l6uX6JmoKVjPFgmajODMc3hiQkj5pPeqjsupXjAP684/Zp
 LQDQkpc020peaboLEpVElUWt2U6Yshj80G1l61Dh9XSIfT8w32hRO7J4Oyhcjh5Egw+5
 T4KlrdOJpeZ4lU/oG9ZkanbbmAZMyVg1YndsFPwS9EOnB879KLZ/zrsa44Q5HtgSdykN
 O6r8WfAE/5Fum5RXhEc8Y+jLmGTYum0q0WxbxyKIh2llu29E8NRWUTWmL2PR7lCULgaM
 9fhQ==
X-Gm-Message-State: AOJu0YxXCJhRiCJGjpUma3PnlNEGhPA7UtCQnqLrnz73KawEcH9ZOfkl
 6eguvj+tGbRq3v7UgcpLaiZH7hw6W5mseWCc+/Mn4l+s4nRI6kD0Mi21kF5aURx/9Kwvv+HB/U+
 c
X-Google-Smtp-Source: AGHT+IFJIK2MlneiRdgBiRgbQ0fAHVd4Q5Ftnv73CfmMMfgI5Fj6DQmEcoHCXFAffIf+iEADPX+PMg==
X-Received: by 2002:a05:6512:1592:b0:51d:5ffd:efe4 with SMTP id
 bp18-20020a056512159200b0051d5ffdefe4mr8042664lfb.1.1714488982217; 
 Tue, 30 Apr 2024 07:56:22 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 w5-20020a5d6805000000b0034c8b0354a6sm9626938wru.106.2024.04.30.07.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:56:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 1/4] target/sh4: Fix ADDV opcode
Date: Tue, 30 Apr 2024 16:56:11 +0200
Message-ID: <20240430145614.76475-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430145614.76475-1-philmd@linaro.org>
References: <20240430145614.76475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-addv.c     | 23 +++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 27 insertions(+), 1 deletion(-)
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
index 0000000000..54ac77b867
--- /dev/null
+++ b/tests/tcg/sh4/test-addv.c
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+#include <limits.h>
+
+static void addv(int a, int b, int res, int carry)
+{
+    unsigned int c;
+
+    asm volatile("addv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(a), "=r"(c) : "r"(b) :);
+
+    assert(c == carry && a == res);
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


