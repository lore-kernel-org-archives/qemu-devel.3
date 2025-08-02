Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D60C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLI9-0000T0-JK; Sat, 02 Aug 2025 19:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLI5-0000QF-DO
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:25 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLI3-00012q-Dj
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:25 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61997c8e2a1so386203eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175921; x=1754780721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B26XEzTuyDyoyfRXGAI8azHJHvfTHmvtHQG/o3LWCYo=;
 b=qI2Mnzvoctuxj4ifpKCdnytcpFvUuoeyd6PyVZ8ZtseryOwYrHdY6DBHkOltTcd5uO
 TxCR8mZJMjwIzUlp5Py9pHdF0tLdxqqOtcyw4r19uI4kOo2F6Blxm3sQcoXQAZdHsi0/
 yto9/7a5xMGB/ok/+PF8f6JszHGJ+lfettSqC0gsutIvH28wT0nZlpDJJTKfwrY6d1Su
 txow0A2ErDfPvHpUWEzKOVj1XpCHT2sYBYMbj15ZohvRMNn4x6zOBoXU6VvkZcjPDpDQ
 x7OmipOCJzJXwtw1w5mBHmOcnxhM6HVI69UPa0jv1EfIDrsKh02tUAPLbCedlQJzDVhr
 ZkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175921; x=1754780721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B26XEzTuyDyoyfRXGAI8azHJHvfTHmvtHQG/o3LWCYo=;
 b=ee+AlB9rT1jGJ8aAJ4+kghYgR6uhDLAl43WJnb0BA9lJ77uVIJUMIqWJg9xnY0W8gR
 2HW6c2hIMaOQgxA9g1NnkWri3A/ijaR3u0RXDh2nnq7AM72B7b0YDhnA/eeoxOTF1BDa
 ARxwCRQCk1gP3cBWkrzWFpXluEsQMkk5LesHoVjzEZvLAR1Ekj/m3wh5bDUYixVeO5aH
 qa8WxdiwOiQqmRiR+WJpb/572jLb5id1VGrnGC9dTidCUdtp6CS0TijaQZ1J4iIGJBOY
 zSLVuyYIKMRMPDe5S2u5fYpCdkbXqYveOdhk10uP5Jok3RlcrlM1CYgrlC5qybq8pY16
 p5xw==
X-Gm-Message-State: AOJu0Yw6TO9R3uDkEhykgSg4lrUaxdkh5+RuN0MsRcsPZbBpK3uDo+mj
 AjRjbASVxV6QLhxEQ82gvRinEsrNMsVLL77XjsPVn89n6upPsaU8Q0pLsaPcUAkPP6KsB6014xL
 pyr8vQN4=
X-Gm-Gg: ASbGncs+OPxG0c9OJJwClNc954kabDDfhpFMPnXzVGPWcJf0xhU9hbWGx+UMTt+hYWz
 0I8nXEIsj2dJlYubwSds0LfEMitpLUlpcJt9S7e0HzYXdydqWZBLopK+e9zv+s9rNq4fsvqmxES
 tLsPi3hXl6STyvvV7TNIJ54uY/y+dik22K66AeD1VhFj98Yjibms2mfqsY1qQxSaJ25ZCgiL4H8
 mwljsaJs0y2Ot1jxX84WHARPmnWG79waCW9+HseZov6GF5/CrdA1E0eXQ4TrUDXhnfbot+CHkjN
 /XR1SIz9/7LcP8zNWpBNeNWXbBir7DH9noEgAPapeMSYM1lJ4xnlIwHexx4wXvgAJeH+GPLOdpo
 aV9wPmjoqIdi4JqdOoMpVLrPuMvXfFwgZLygeTIqxzoUxvxn7AmLq
X-Google-Smtp-Source: AGHT+IF78d4SzmDD8oMO453uYrlE3nC1gu34XE+LlT36ilo0Z2HByPhOy7U6s93ilRxP+NX+IU68AA==
X-Received: by 2002:a05:6820:c314:b0:615:85cc:339 with SMTP id
 006d021491bc7-619706fb096mr5028373eaf.2.1754175920853; 
 Sat, 02 Aug 2025 16:05:20 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 03/95] linux-user: Create target/elfload.c files
Date: Sun,  3 Aug 2025 09:03:27 +1000
Message-ID: <20250802230459.412251-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Prepare to split the main linux-user/elfload.c.
Create empty files for each target, and add the common build rule.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c     | 1 +
 linux-user/alpha/elfload.c       | 1 +
 linux-user/arm/elfload.c         | 1 +
 linux-user/hexagon/elfload.c     | 1 +
 linux-user/hppa/elfload.c        | 1 +
 linux-user/i386/elfload.c        | 1 +
 linux-user/loongarch64/elfload.c | 1 +
 linux-user/m68k/elfload.c        | 1 +
 linux-user/microblaze/elfload.c  | 1 +
 linux-user/mips/elfload.c        | 1 +
 linux-user/mips64/elfload.c      | 1 +
 linux-user/openrisc/elfload.c    | 1 +
 linux-user/ppc/elfload.c         | 1 +
 linux-user/riscv/elfload.c       | 1 +
 linux-user/s390x/elfload.c       | 1 +
 linux-user/sh4/elfload.c         | 1 +
 linux-user/sparc/elfload.c       | 1 +
 linux-user/x86_64/elfload.c      | 1 +
 linux-user/xtensa/elfload.c      | 1 +
 meson.build                      | 6 +++++-
 20 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/aarch64/elfload.c
 create mode 100644 linux-user/alpha/elfload.c
 create mode 100644 linux-user/arm/elfload.c
 create mode 100644 linux-user/hexagon/elfload.c
 create mode 100644 linux-user/hppa/elfload.c
 create mode 100644 linux-user/i386/elfload.c
 create mode 100644 linux-user/loongarch64/elfload.c
 create mode 100644 linux-user/m68k/elfload.c
 create mode 100644 linux-user/microblaze/elfload.c
 create mode 100644 linux-user/mips/elfload.c
 create mode 100644 linux-user/mips64/elfload.c
 create mode 100644 linux-user/openrisc/elfload.c
 create mode 100644 linux-user/ppc/elfload.c
 create mode 100644 linux-user/riscv/elfload.c
 create mode 100644 linux-user/s390x/elfload.c
 create mode 100644 linux-user/sh4/elfload.c
 create mode 100644 linux-user/sparc/elfload.c
 create mode 100644 linux-user/x86_64/elfload.c
 create mode 100644 linux-user/xtensa/elfload.c

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/aarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/alpha/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/arm/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hexagon/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hppa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/i386/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/loongarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/m68k/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/microblaze/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/mips/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips64/elfload.c b/linux-user/mips64/elfload.c
new file mode 100644
index 0000000000..b719555e65
--- /dev/null
+++ b/linux-user/mips64/elfload.c
@@ -0,0 +1 @@
+#include "../mips/elfload.c"
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/openrisc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/ppc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/riscv/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/s390x/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sh4/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sparc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/x86_64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/xtensa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/meson.build b/meson.build
index e53cd5b413..516b1a43c3 100644
--- a/meson.build
+++ b/meson.build
@@ -4325,7 +4325,11 @@ foreach target : target_dirs
     )
     if 'CONFIG_LINUX_USER' in config_target
       dir = base_dir / abi
-      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+      arch_srcs += files(
+        dir / 'cpu_loop.c',
+        dir / 'elfload.c',
+        dir / 'signal.c',
+      )
       if config_target.has_key('TARGET_SYSTBL_ABI')
         arch_srcs += \
           syscall_nr_generators[abi].process(base_dir / abi / config_target['TARGET_SYSTBL'],
-- 
2.43.0


