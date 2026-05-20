Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C2BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYB-0001N8-4P; Wed, 20 May 2026 15:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXe-0001BH-D0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXc-0002Et-9q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso2962728f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305114; x=1779909914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FHjCZ7KVIxzeg05WmD+TUQ0R2S/YJeIXd2CK/WPq1eM=;
 b=dUOwBC6IWy8FJyA9tj6ngHV2Uoi9ocGbJdCuoiDR8fOmr00SddWoOMGwYcZZ4gYlJd
 yK3Jij7xQ093HB91Sk2IYeWOIyzds0bgESIvPMPZT24tYVoa8lYix06wvADG/ndYzwfo
 4H52dCPzZqekfFIRBtUj+ajAxi2UgNC6NZp0GwBy/GCb9CIEIA7RyUkooJMN2np+JuzE
 IIiMBWvPDvPp8EAW+rt7efEw8kwNpMcaWWLmxhOUJ/CkzOhpFmeOZ/ZhuSF3ZoWtZTI6
 40rV4yM3zqMLkKQeD+9o4aqWr/5/P2CRoEPxzY2L3LDtkewgWsznXeH+gpPWr5rmv6mk
 UK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305114; x=1779909914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FHjCZ7KVIxzeg05WmD+TUQ0R2S/YJeIXd2CK/WPq1eM=;
 b=mS+N3psLetIvI7CArHBCAYh5OiN+3C9WGniHvgCtQVz9k2Dg79fJUlVqYsaZ/pIHj7
 X9NA2qBK9EZb6G88BOQy/jwPnNuTYApkRu0RUHUE8TVYNbhask+b/b1t4Zu+PyOQfZ18
 uydL/yOaynTqFbV0YxCayMCLzjZRYQ0UjpSwZlnk3G/YJLFd5NkacmJLc6thYv2unY+C
 fVGUUjNabrFXKUyAFcjy0Thec7yDWfhFo+fuEO4+V1ZrDXxpOZNrdVcP2n+JotCqF6zU
 CuIol/0E5q/atBT2kIsUHIJ4ocGNHBaymF5Q/ubzYCklw0ZwKgKKOSpoX9Zs8roPfcCE
 VBxg==
X-Gm-Message-State: AOJu0YycJSZYQrCK4jQQC8iF7kdfaafvg7J2hX6+ZSBAU2tU8VS/VwtN
 8g+INi5cLmcw3Y9/RUnuIVVwAJX4VLMSB2s/YjoM7OcLiLvSMIF2zv69hDugOIO0tRFIb95hSiD
 Z70Sw4sk=
X-Gm-Gg: Acq92OHaGvPkbSvPWy+NRWiXTywK0Lou3r9wQHYmRAWCT0Rb+1dud00p4ia0sMmACrc
 V1diZ2hTXE3vPeKhcsqSpPmbbabevMCM5Ocu08zOtzJak9KcAUKi3u8eIT/Pu6mu1BZQZc8aGF3
 XyvOp+3Ue8x0GWbfdtGGTTl24jJbSQESbZgmPnuEP5bMGXqmBIJbetAP3jvZMb062Peb2A+HHpL
 T+BHv8dMxXcNzCAZTcy9Q+WFKjbaStWzJCBmNT9zZafOUzjvTiBLrijfz9ZBHctz/FjREsegwwG
 qEFaK67jbzCKgH1/TerwbglfSpy077uykqny5Ib1xGJ++xWiShqS7GxLlmxxlmfyrxuYHl6Adum
 NIGESqTRPJ8js2JmgwH3jUiWgaqto5xuMiyqEsRx5RvdRaIqAHOdGEy83Wo5bSpBkZQHc/s/Xez
 T5TZyPiqVrr2Iq7j7CXmXfV/ONIK20natMdwdEAQ56Ipt5Q2vR+tLRqXNDBSRoELGNeXZFbDlW
X-Received: by 2002:a05:6000:2503:b0:45e:93ac:769e with SMTP id
 ffacd0b85a97d-45e93ac76ddmr7663708f8f.6.1779305114270; 
 Wed, 20 May 2026 12:25:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3acf7sm57181146f8f.12.2026.05.20.12.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/33] tests/tcg/mips: add Octeon instruction smoke test
Date: Wed, 20 May 2026 21:23:18 +0200
Message-ID: <20260520192338.40036-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon instruction paths.

Run the test with -cpu Octeon68XX and share the source between the
mips64 and mips64el target directories.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260520172313.23777-6-philmd@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 13 ++++++++++++
 tests/tcg/mips64/Makefile.target              | 20 +++++++++++++++++++
 tests/tcg/mips64el/Makefile.target            |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target

diff --git a/MAINTAINERS b/MAINTAINERS
index 7496ace6d5a..0600d494588 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -310,7 +310,7 @@ S: Odd Fixes
 F: target/mips/
 F: disas/*mips.c
 F: docs/system/cpu-models-mips.rst.inc
-F: tests/tcg/mips/
+F: tests/tcg/mips*/
 
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 00000000000..aef23fb9465
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,13 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 00000000000..042855844a8
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 00000000000..dbc5f8dc5fe
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.53.0


