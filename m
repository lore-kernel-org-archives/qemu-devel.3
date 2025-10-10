Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2189CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrI-00015q-Ax; Fri, 10 Oct 2025 09:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqu-00089e-Ef
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpk-000443-9Y
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso1426261f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101609; x=1760706409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6v6hOcOHDggmkiaDV77PZmhbEfhoJVgBwmXFKtv68nQ=;
 b=OH+YgjYPxrw26v1jY27VxOvUOqQ9tifb5S5+mfS46Z/iRgsLSYmabKOKrKrLrZckO6
 Wfhz/XCpafHf+hawO7bzoWxz1C1qxr+9tAh/ogiC/aNPY2Ojxw0W8Ilbvk9bOV82ij9N
 KXiNby8Lo3cTvHML+YXOZqKdWu+eeZ8j43n4Le9B/6uJZ+lc3i/z5sv7iw6etlaU1gjx
 uZa4+MOodoUmy7IS6TcuQFynoSDCfMPaegAkEpUD7mNyUUjuDeLRvUrnWuckdOCQlDlj
 JEmggbM8FEgWVBcx4rKsUVuMcPp+2mAwNvyviM2cZJBbhWhBWuV0/OZp/u6JfYPx6RGj
 0MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101609; x=1760706409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v6hOcOHDggmkiaDV77PZmhbEfhoJVgBwmXFKtv68nQ=;
 b=ZrXWwTIz8bdA6LcaHGCMapZY/q5LdL9HsOrQ0OIIEuaPrLsFfgLqbvVM3BdARMyhS3
 DPgpf+F3dhxk0BXctsjkHne3IR00ymZ0+ibINcd4Th189jUylDBq5XbBszeiwtid4iWn
 gaeJ1VJzE/C8TFdn0Srf4yGhhQHMKsltxxCU5KfdFDNm6h3QCCPD1KdzVCsa83iCjSWR
 NmMdVaFNwE/mngyPrINUmv+0nxGMCoIeU6ziQe0Rd8ftmybjSxTtN8GH3gOTIz4YkxP5
 FmKvITPERgxPBlbqfDd198oHVcAbAzE86b7JYjjZ6fZTMTFAfT/gyF+DYrb6upfTjC/V
 uigw==
X-Gm-Message-State: AOJu0YwHZmUPInDrAraK+xolMhgCroSPDwtwerj3b81HMu7TWQlxJ1Hu
 fx11tuZEM1J/OGLTCYwLMEL2LW5oFBdMQTekFzOMwroJ3vNC2Rn5HN2kTqXRB1qfIefgaIh7s06
 XwxfX
X-Gm-Gg: ASbGncsBN3NwlOBH9J/F1u4zhgjGk59cx8uqxem5w44ql7IkKi/DhSBLUY+O9XebheQ
 q7tPWyBJHUrQ6d9Z9Q6dcS02G3T0IFJU9WyEct4BkWHf8qQgjl4FGNzlC3DMB+GiCbn1e0DAHWr
 u5dexW3oCpEfPuPagPY58bM1kl6che8Bz7H5clFcubFI2CNH77DpkkuX5AJkGGeQT7hcsypDP7D
 LIws3NV2vegckMaieXBX94/2edaGPRbdY7BADQjqiRujzKCR9qwn3oLv1xxS6rU+Hzpj9weP5NN
 5my3N1b3S9wYf5zJMoWOTX8IGgTRJkFpeLeVBW4UFZ8wlSiCi2FcpLYSf8dNzj7an6LShZN5lle
 2JxZdwSVT1CPNz6BahcCi22fBfQx0pqCPvnRpgkLoHMPdvNR1pUg=
X-Google-Smtp-Source: AGHT+IEdVPTQMAbnYwenkKRHs8WtHIFJzPInRcpcOQ7mqtrwCLc5uty3xPx5w+7k/HkA11zIHe+40A==
X-Received: by 2002:a5d:64c3:0:b0:3e7:4197:c99d with SMTP id
 ffacd0b85a97d-42667363e76mr7236930f8f.15.1760101608965; 
 Fri, 10 Oct 2025 06:06:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 72/76] tests/tcg/aarch64: Add gcspushm
Date: Fri, 10 Oct 2025 14:05:23 +0100
Message-ID: <20251010130527.3921602-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Validate successful and trapped executions of GCSPUSHM, GCSPOPM.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-73-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/gcspushm.c      | 71 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcspushm.c

diff --git a/tests/tcg/aarch64/gcspushm.c b/tests/tcg/aarch64/gcspushm.c
new file mode 100644
index 00000000000..c330417a2fa
--- /dev/null
+++ b/tests/tcg/aarch64/gcspushm.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+
+#define GCSPUSHM  "sys #3, c7, c7, #0, %[push]"
+#define GCSPOPM   "sysl %[pop], #3, c7, c7, #1"
+
+static void test_sigsegv(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigsegv;
+
+    __asm__("adr %0, inst_sigsegv" : "=r"(inst_sigsegv));
+    assert(uc->uc_mcontext.pc == inst_sigsegv);
+    assert(info->si_code == SEGV_CPERR);
+    /* TODO: Dig for ESR and verify syndrome. */
+    uc->uc_mcontext.pc += 4;
+}
+
+static void test_sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t inst_sigill;
+
+    __asm__("adr %0, inst_sigill" : "=r"(inst_sigill));
+    assert(uc->uc_mcontext.pc == inst_sigill);
+    assert(info->si_code == ILL_ILLOPC);
+    uc->uc_mcontext.pc += 4;
+}
+
+int main()
+{
+    struct sigaction sa = { .sa_flags = SA_SIGINFO };
+    uint64_t old, new;
+
+    sa.sa_sigaction = test_sigsegv;
+    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    sa.sa_sigaction = test_sigill;
+    if (sigaction(SIGILL, &sa, NULL) < 0) {
+        perror("sigaction");
+        exit(1);
+    }
+
+    /* Pushm is disabled -- SIGILL via EC_SYSTEMREGISTERTRAP */
+    asm volatile("inst_sigill:\t" GCSPUSHM
+                 : : [push] "r" (1));
+
+    enable_gcs(PR_SHADOW_STACK_PUSH);
+
+    /* Valid value -- low 2 bits clear */
+    old = 0xdeadbeeffeedcaec;
+    asm volatile(GCSPUSHM "\n\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (old)
+                 : "memory");
+    assert(old == new);
+
+    /* Invalid value -- SIGSEGV via EC_GCS */
+    asm volatile(GCSPUSHM "\n"
+                 "inst_sigsegv:\t" GCSPOPM
+                 : [pop] "=r" (new)
+                 : [push] "r" (1)
+                 : "memory");
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 5e1b3a33851..fddb7bc9cdc 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr
+GCS_TESTS += gcsstr gcspushm
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


