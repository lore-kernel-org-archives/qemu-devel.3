Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C57C71136
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 02:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQGLa-0003le-0L; Fri, 13 Jun 2025 22:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGLU-0003gp-Ne
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:10:13 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGLS-0006pB-3Q
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:10:12 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 4BD3F5FC7
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749867007;
 cv=none;
 b=bhvZ8mpx4k1SzEDKRPPUBS1UWvvZ9v3YUD5lk7/WWJbKyKoaCFk4KuQ36xe10mKzAUZtjJWhc3GNIfqB4r6f+xPrbrjJV+Qvf+7fFzjO1IwBE80rKa4tMdkXXIgAZthoAM43xLovvpwInoB3oMew+9i+cjL5Zkl1u/3VUg4pW2YZ2C2Li+iAXrlQn5vb2VvAt197dKKSzSWNbp1iFyNEjfOlIUe0JYH91KifUViNh6uQZ0pldHnYa9XOAm9tlwx2KMfmzqK2LHT3qJQbGUG7lvrR26p6dER+8dEg1nFJkm4IFT5N+9qXEh3RxkXSDdM1WH1RYo0r2K4XMI2P/0ahAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749867007; c=relaxed/simple;
 bh=VZLRDdSa1IIQmngleoD4NcU4WOkdN9IiCFAoz1wV0Eg=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=W9HX+4biOs6RBzsbnYPM1MImsLhq69z+NXq0OPauQ4BCS4ij7QlV4HEiBaarB9usldtXXuERQIQzxxzgpX4Dm0ptkDNjPsv4VrCTYIyl6IjNYSezl1hXm+p+S0NSE3K3Remb40I+o5Kl6nvk6UOKz113hb9DR1yhLEBu0AY8r0q6Nzrk+qB5zorniTjOBSLJJFbua1ROfKcX9dkw6zLFC3G/5YYG+1U04CsF7+88bbRcvk8aVEJSu331v7n/eowpmaJPbsd20vP0q4GDkltOEBmXg2tPN6c/YzPrp60h3+Yo1oRaIAN0/XKp9qTUvuGRm04RSQ20JmKY4/+7WVeQ/Q==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749867006;
 bh=VZLRDdSa1IIQmngleoD4NcU4WOkdN9IiCFAoz1wV0Eg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SEaryxXbzaEJw3DiL2zxTn0voLj2aLdVkNNvaFnRDTScyKJUk9Og3M7grAYS/keU7
 fd413v/jSYeexuKczZwrKz9dOKs35ZtIX0VrS8AaXi+5lF+nm8Qz/oSitOdJaQ1mLK
 ijzbRsh1CevXMnC/wQC2cNYQnrClkOUzOLT9KtgsxqtppxfVEYBDxe4oSivvWgBbaG
 DEW2wFSkPC1A2f4qRK0DQaXZ4U+vgCurXa87KGDyXdyvAJ/Fzuylf76kw+SvePkHYq
 KhMXanVLKJoegMhiIRphVPWQFsQnjI6kUmQVGNv9Qs1cZILb4Y0yglfsDAtXwP1yUi
 qBN5GCPAQKLRw==
Received: from Mac.home.lla.com (unknown [207.191.242.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 4BD3F5FC7;
 Sat, 14 Jun 2025 10:10:04 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>
Subject: [PoC] show header-vs-source G_GNUC_PRINTF behavior
Date: Fri, 13 Jun 2025 22:09:50 -0400
Message-ID: <20250613.qemu.9p.poc@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.9p@sean.taipei>
References: <20250613.qemu.9p@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch is NOT meant for merge.
Just a simple proof-of-concept so reviewers can quickly reproduce
the difference between placing a G_GNUC_PRINTF attribute in *.c versus
*.h file.

What it tests
-------------

* Two identical printf-style helpers (my_printf) are provided:
  - v1: attribute lives in foo-v1.c
  - v2: attribute lives in foo-v2.h
* Two callers (bar-v1.c, bar-v2.c) intentionally pass too few
  arguments: `my_printf("%d %d %d\n", 1)`.
* A trivial Makefile builds each variant and shows whether GCC emits
  the missing-argument warning.

Expected result
---------------

$ make -C poc run
// Compiling version 1 (Place G_GNUC_PRINTF in 'foo-v1.c')
No warning will appear, sliently cause security flaw

// Compiling version 2 (Place G_GNUC_PRINTF in 'foo-v2.h')
bar-v2.c:4:17: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]



Signed-off-by: Sean Wei <me@sean.taipei>
---
 poc/foo-v1.h  |  3 +++
 poc/foo-v1.c  | 10 ++++++++++
 poc/bar-v1.c  |  6 ++++++
 poc/foo-v2.h  |  3 +++
 poc/foo-v2.c  | 10 ++++++++++
 poc/bar-v2.c  |  6 ++++++
 poc/Makefile  | 39 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+)
 create mode 100644 poc/foo-v1.h
 create mode 100644 poc/foo-v1.c
 create mode 100644 poc/bar-v1.c
 create mode 100644 poc/foo-v2.h
 create mode 100644 poc/foo-v2.c
 create mode 100644 poc/bar-v2.c
 create mode 100644 poc/Makefile

diff --git a/poc/foo-v1.h b/poc/foo-v1.h
new file mode 100644
index 0000000000..37b5403ba6
--- /dev/null
+++ b/poc/foo-v1.h
@@ -0,0 +1,3 @@
+#define G_GNUC_PRINTF(n, m) __attribute__((format(printf, n, m)))
+
+void my_printf(const char *fmt, ...);
diff --git a/poc/foo-v1.c b/poc/foo-v1.c
new file mode 100644
index 0000000000..ce89f95e3e
--- /dev/null
+++ b/poc/foo-v1.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+#include <stdarg.h>
+#include "foo-v2.h"
+
+void G_GNUC_PRINTF(1, 2) my_printf(const char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+}
diff --git a/poc/bar-v1.c b/poc/bar-v1.c
new file mode 100644
index 0000000000..6e707e13b4
--- /dev/null
+++ b/poc/bar-v1.c
@@ -0,0 +1,6 @@
+#include "foo-v1.h"
+
+int main() {
+	my_printf("%d %d %d\n", 1);  // missing arguments
+	return 0;
+}
diff --git a/poc/foo-v2.h b/poc/foo-v2.h
new file mode 100644
index 0000000000..8bb56d3181
--- /dev/null
+++ b/poc/foo-v2.h
@@ -0,0 +1,3 @@
+#define G_GNUC_PRINTF(n, m) __attribute__((format(printf, n, m)))
+
+void G_GNUC_PRINTF(1, 2) my_printf(const char *fmt, ...);
diff --git a/poc/foo-v2.c b/poc/foo-v2.c
new file mode 100644
index 0000000000..3f18632ee6
--- /dev/null
+++ b/poc/foo-v2.c
@@ -0,0 +1,10 @@
+#include <stdio.h>
+#include <stdarg.h>
+#include "foo-v1.h"
+
+void my_printf(const char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+}
diff --git a/poc/bar-v2.c b/poc/bar-v2.c
new file mode 100644
index 0000000000..e06fd87056
--- /dev/null
+++ b/poc/bar-v2.c
@@ -0,0 +1,6 @@
+#include "foo-v2.h"
+
+int main() {
+	my_printf("%d %d %d\n", 1);  // missing arguments
+	return 0;
+}
diff --git a/poc/Makefile b/poc/Makefile
new file mode 100644
index 0000000000..5725c9ff63
--- /dev/null
+++ b/poc/Makefile
@@ -0,0 +1,39 @@
+CC ?= gcc
+CFLAGS ?= -Wall
+
+TARGET = prog-v1 prog-v2
+SRCS   = foo-v1.c foo-v2.c bar-v1.c bar-v2.c
+OBJS   = $(SRCS:.c=.o)
+
+.PHONY: run
+
+run: clean prog-v1 prog-v2
+
+
+prog-v1:
+	@echo
+	@echo
+	@echo "### Compiling version 1 ###"
+	@echo "Place G_GNUC_PRINTF in 'foo.c' only"
+	@echo "No warning will appear, sliently cause security flaw"
+	@echo
+	$(CC) $(CFLAGS) -c foo-v1.c -o foo-v1.o
+	$(CC) $(CFLAGS) -c bar-v1.c -o bar-v1.o
+	@echo
+	$(CC) foo-v1.o bar-v1.o -o $@
+
+prog-v2:
+	@echo
+	@echo
+	@echo "### Compiling version 2###"
+	@echo "Place G_GNUC_PRINTF in 'foo.h' instead"
+	@echo "Show warning for missing arguments"
+	@echo
+	$(CC) $(CFLAGS) -c foo-v2.c -o foo-v2.o
+	$(CC) $(CFLAGS) -c bar-v2.c -o bar-v2.o
+	@echo
+	$(CC) foo-v2.o bar-v2.o -o $@
+
+clean:
+	@echo "### Clean all artifacts ###"
+	rm -f $(TARGET) $(OBJS)
-- 
2.49.0

