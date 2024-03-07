Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A47C54E5C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riISf-0001E8-Dn; Thu, 07 Mar 2024 13:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISd-0001DP-R0
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISc-0000cL-8i
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:19 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dd0d46ecc3so9508845ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709836036; x=1710440836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8huhRHNOBYWkXgN/4/yH0cLjdQL8crIEtN89AF3mvM=;
 b=QjuhTniCu+O6egwC7OuADAoVOOK24tezDqkvR+cdOjNjCyvAS3d+oSQpmS4XpdvnSD
 24wYtYR/8YFDryVtM8/qhQ0b/tfnILeDFQN5wLbI8TycjUkRZtnPzI2d0zmtxgSncfni
 ECSGLoa4ZiRx/It+NtrCvWc5xDBQ/+cFi2zcjX1AHOzA+O2jz8T8/znGAk+gDKNc2J1Z
 kyZTHTb2iQ6TROVHwf0eNRb0vSkt6uT3AKMvIa2EFZiYqpa8SnzakIXv550m5ftdya9F
 v30GHhEuqQ9LFD5e6+c69a6uO72hHDvaNhBDAgN/ByC0v+Jvwfeem+/yk+ufCfyc0xH2
 xSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709836036; x=1710440836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8huhRHNOBYWkXgN/4/yH0cLjdQL8crIEtN89AF3mvM=;
 b=wkWkya4/zT/C0aTu+HWC01NqinEqQYLTrvzJGU17IuiOPUS++f2zpYNUXd8I7/pt3A
 jDXdlomjkOIk3l7JPM6ozyMV3BVb2b7XtGgnC+W44dDVqud1pcOar3ZdUNW7plUn2WkF
 4GoZrdHSg8NW8penb86hlOKus6dPYKZiW2/FRwtbxS3+R1LL+euU0Q0Tr5D/6KU4k5Id
 w9xnUyMK0Lzzz1fZ4JajRVaOiATJfFZyR514zfQVN+ZarO5E50qqqJG0O4hZsc3UYxA0
 Kl+cBkSw6NDd7XGPMNSAVzf3i+zd5wfB+nenv5by1RqXcIt1IbE+Ml8DYii7qdXRaPo/
 X3Bg==
X-Gm-Message-State: AOJu0Yza/Xu33NuLPewkFB0Q3qaEyQPotomeE0Bv4xaXY3ChZmNihaq4
 dCuBQA2wxnGAN4xrZV5Ndvs6rwAVg8XTbY917oCtaCDHGCuIHGwcQhmXmQbvab8F1BY5agOB+Dq
 842g=
X-Google-Smtp-Source: AGHT+IF7zfGjNUHvOU1sQnq2Px1J3l7zeCc3mOT096hKzCdg/VI20kizBNtzgthO+xFQCzzgG81pQQ==
X-Received: by 2002:a17:902:d2c5:b0:1dc:b003:ed7a with SMTP id
 n5-20020a170902d2c500b001dcb003ed7amr10982899plc.5.1709836036537; 
 Thu, 07 Mar 2024 10:27:16 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm14939068plb.197.2024.03.07.10.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:27:16 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v2 5/5] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
Date: Thu,  7 Mar 2024 18:26:23 +0000
Message-Id: <20240307182623.1450717-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org>
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x633.google.com
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

Add multiarch test for testing if Xfer:siginfo:read query is properly
handled by gdbstub.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/multiarch/Makefile.target           | 10 ++++++-
 .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++++++++++
 tests/tcg/multiarch/segfault.c                | 14 ++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
 create mode 100644 tests/tcg/multiarch/segfault.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f11f3b084d..5ab4ba89b2 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -71,6 +71,13 @@ run-gdbstub-qxfer-auxv-read: sha1
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
 	basic gdbstub qXfer:auxv:read support)
 
+run-gdbstub-qxfer-siginfo-read: segfault
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
+	basic gdbstub qXfer:siginfo:read support)
+
 run-gdbstub-proc-mappings: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(GDB) \
@@ -113,7 +120,8 @@ endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls
+	      run-gdbstub-catch-syscalls \
+	      run-gdbstub-qxfer-siginfo-read
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
new file mode 100644
index 0000000000..862596b07a
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
@@ -0,0 +1,26 @@
+from __future__ import print_function
+#
+# Test gdbstub Xfer:siginfo:read stub.
+#
+# The test runs a binary that causes a SIGSEGV and then looks for additional
+# info about the signal through printing GDB's '$_siginfo' special variable,
+# which sends a Xfer:siginfo:read query to the gdbstub.
+#
+# The binary causes a SIGSEGV at dereferencing a pointer with value 0xdeadbeef,
+# so the test looks for and checks if this address is correctly reported by the
+# gdbstub.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+from test_gdbstub import main, report
+
+def run_test():
+    "Run through the test"
+
+    gdb.execute("continue", False, True)
+    resp = gdb.execute("print/x $_siginfo", False, True)
+    report(resp.find("si_addr = 0xdeadbeef"), "Found fault address.")
+
+main(run_test)
diff --git a/tests/tcg/multiarch/segfault.c b/tests/tcg/multiarch/segfault.c
new file mode 100644
index 0000000000..e6c8ff31ca
--- /dev/null
+++ b/tests/tcg/multiarch/segfault.c
@@ -0,0 +1,14 @@
+#include <stdio.h>
+#include <string.h>
+
+/* Cause a segfault for testing purposes. */
+
+int main(int argc, char *argv[])
+{
+    int *ptr = (void *)0xdeadbeef;
+
+    if (argc == 2 && strcmp(argv[1], "-s") == 0) {
+        /* Cause segfault. */
+        printf("%d\n", *ptr);
+    }
+}
-- 
2.34.1


