Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00204C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ouI-00030J-FP; Tue, 30 Apr 2024 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouG-0002z4-L4
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouE-0006gY-PR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34c1fff534fso4313795f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488989; x=1715093789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5GYC8zc5JQkgTrRsykKZZUmjjs/NibwLlEPBMjg85Y=;
 b=SE/hrI6kGgtTAw+1wizBXRubyo89gx6YmSG+xto29c9fsghWH6KHXqZodoWKKX0msA
 tuxRKMLX39AETAT3PSn+nqog12/JDQPMDlbP4LPJzksHhtBaP1Gaut+5cTU9CzwpP7oa
 c/pgGlwP6ekMz++uanxKBql6sJ/rozaAL6mjaaBhUoCwMgyFzlqSItVFD2/A5hfp6tXd
 PVy4QGBNRRj4O3QVV0O6iugPULpwLJnNSqUkpa25oBvZbGg7i5oaHPMey915/sMwkEfx
 6W4U9SCCg76/M/COLgwpJkP+X1496RXRE2Sv6oDzYWPC5UmL++igIRPXpWs4XBs7NDU1
 6RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488989; x=1715093789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5GYC8zc5JQkgTrRsykKZZUmjjs/NibwLlEPBMjg85Y=;
 b=SdizMR9FpB+Z2j9s0/JlIuNBsRdzzgKjq0GxABFEbbscgwD62buXDWRdRDCEnbaOV5
 6S8GcRZDvSebGJaZBRdizEdRM3WazfeoDXOxID5DCH2AqD8cp3RwTSjG7Y5+HcePzEpt
 tAsPuyXs5Rim/BI7zuuw/6mHYHD/msWfWhi8n0O3K0GneHVcwKm2Q7kZgJYb/0UVyBuB
 3St0saMIImiqEthuSMezWMC31jsOAiGLp9AB1IcxYKf9L3WYYt6Gfp/K0IdERZ4eijWG
 hVV+DQgNWIcgcIPHoxJseSWcNvl4pG/Ryj6SzS2dqDDzsDFR7YJcO9qGey+H7QwLodN6
 A4yg==
X-Gm-Message-State: AOJu0YxL1ShwGS9JkG86sUUiV3LrDi7U/cHVCVKXkqwjGG2S7hq2JVh0
 niS6E65uwsBK0ym9ASWlle0Z7kDM7hhcLghf4BT8k1TxiXTjLKfXVgKydHQRemaohgN3rVe/PP7
 0
X-Google-Smtp-Source: AGHT+IH0NtE3Q6xlBaXKoEbWZMHZwcUiYb/g78atKrSqLQYyuh6fcqsk7rSxEre9qHWlPJGwaLuhSw==
X-Received: by 2002:adf:e58b:0:b0:34c:6677:b7de with SMTP id
 l11-20020adfe58b000000b0034c6677b7demr8337614wrm.2.1714488987605; 
 Tue, 30 Apr 2024 07:56:27 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 d1-20020adfef81000000b0034a7a95c8cfsm28542875wro.9.2024.04.30.07.56.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:56:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 2/4] target/sh4: Fix SUBV opcode
Date: Tue, 30 Apr 2024 16:56:12 +0200
Message-ID: <20240430145614.76475-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430145614.76475-1-philmd@linaro.org>
References: <20240430145614.76475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-subv.c     | 26 ++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 30 insertions(+), 1 deletion(-)
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
index 0000000000..d28a9f8f89
--- /dev/null
+++ b/tests/tcg/sh4/test-subv.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+#include <limits.h>
+
+static void subv(int a, int b, int res, int carry)
+{
+    unsigned int c;
+
+    asm volatile("subv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(a), "=r"(c) : "r"(b) :);
+
+    assert(c == carry && a == res);
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


