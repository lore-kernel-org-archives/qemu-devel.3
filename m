Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D490BC54E58
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rin6t-0000yR-UQ; Fri, 08 Mar 2024 22:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6d-0000u6-6w
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:40 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6b-0004AS-JL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:38 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c2313de2ceso610697b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709953835; x=1710558635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNibj7GeqOVAWR9r/zV93h8cU6ZpKh+4GZhI7/K8upo=;
 b=tfqGqg+aOdEetvBGqy25S33KHmS9Nk2ZxA6cJO06boPn7mMM7qHpfd7lEgpwvR0nwO
 K146YB1owlalZBNHFsBvxdyJ4KGzti6u45F7ejxNIED6NvSYfaPtiaTyl98DbaNc7KGi
 qEuNZ+7Q2OmBU9/5ThtK1b45jyD3hsst6Jcfmi8VzeMVmUAq1UcIkKgSWEFneCCfjPGB
 I3IysZpgq9O30e9RkuTVdB54eCYs6Z7dQRl6+R1iqmmUPoRr2RfCncnSPRJuGWa7Um5h
 aSqwYw+YbF/WuZcqXQOx7tiiDBRdxzEKT3pH030aTpCJs3ODyGdyvadjZs4UC9mstA5c
 kkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709953835; x=1710558635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNibj7GeqOVAWR9r/zV93h8cU6ZpKh+4GZhI7/K8upo=;
 b=PJdUo1EB0JBU6tXESpUB7alb1sUv1/9/CSimB+bqPOYbfMVjL6/PWmKQPYsxHjeYjp
 LnP2Em0oMoMrFQUJgBklSovBbd79Dm77+KQquwZYVlTTSPefvveK4bQJbrvxfc4Gh0rP
 SUwUSoUCRyqOhOeP3sBSqB6GkbzPk9XCydHvCemvjeZ+FSCOZ39an2ThhKJLnyeDIZKu
 S1ZCwCmBpf1TpCFAbWHHFUt3wJW+YxjJ4Cd/xPEJbVvJfMjgyNyV1b+ZQufzFh3YkCHM
 lOBtD9kMZP3s+eriwq2pvtOUtkTLg/n31pTIbNIIgwK957vpHl42Wtr4NDmO+YDgPcD9
 /uPQ==
X-Gm-Message-State: AOJu0Yxg+noAkLzFalzOoGtK5FABh4UOGmH6jx1wR+9vo08yqO8g6mfL
 mX2J6hrsTMGGziutGNrOkp3RnzuVbJoJjRlL9fPa4owfc3p1PaVB0xareah00hlsgqKcu/uBWQ8
 /T/E=
X-Google-Smtp-Source: AGHT+IHRimvnBR/wyLhtkIwunOHerYCdZFbwV0cdRgFkXoxLAW6UMCHSGys0bLB6OAcxMog6IwCzsQ==
X-Received: by 2002:a05:6808:118c:b0:3c2:1868:d9cf with SMTP id
 j12-20020a056808118c00b003c21868d9cfmr1151769oil.16.1709953835423; 
 Fri, 08 Mar 2024 19:10:35 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:7e8e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001dd707d5fe6sm349566plb.158.2024.03.08.19.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 19:10:34 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v3 5/5] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
Date: Sat,  9 Mar 2024 03:09:01 +0000
Message-Id: <20240309030901.1726211-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309030901.1726211-1-gustavo.romero@linaro.org>
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x22e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


