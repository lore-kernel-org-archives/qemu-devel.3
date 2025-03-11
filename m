Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41A7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5e5-0006yq-8s; Tue, 11 Mar 2025 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5e3-0006yC-0t
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5e0-0007VI-Fk
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso2913775f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722722; x=1742327522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrpL1oseyxb240hBD3z5bIdJcGujCcN61+LmTdzxPbg=;
 b=uI4nO2OQoOU2xPj2jKgsXf6tCVrDX6etPv3AJYg+EiZT0wCVRYxukilM2SU0ZzEBqG
 O7V3iiRJ6+N5fS+qddsRYLr6wAd4OIhOwNXJstFkYUADPb4BP/4SCbsje+xxf7UtQXj1
 SqsWsKO1bSr+ALTFk3MfkDSnLUma9IdiQakoKlFAUxUIAz6aoMzI0Epp8Lopl3eQJClG
 kpIMwwHewkoflnHt7XXpnvc0k+aC49C68KZv0AtxcIxuuAt+PQ0o7BPP7dRj0W3j2HEB
 d1Y2Ey8tPGT84vfYUY7OCRXCpVqyaJdwhKfLhz5Tbhtophjm8gBafQbCBfYOvc77LY5y
 B6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722722; x=1742327522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrpL1oseyxb240hBD3z5bIdJcGujCcN61+LmTdzxPbg=;
 b=gvc0wAYLYfDluh5QJY4b/jBv0xXMgIa4cadjDgS5Hn0fW/VjuRwahAqglAc15SB0tX
 PEex6JKE9ZKH8v9I+XMjq4lJR6STU1w2YUPpHHWFgJouZ8ztR/l08ZpdM0TrVQ0gBo5B
 KImjMtyC51c4A0Rk3jjqxyGDvVLHuUSSvxsiwkJ9MsIcfcCRyH0h00XngaT3HSncbKRw
 udwonmDKyH5v6NFWcxfGk1P5E/poRk3lrrcSQuranK/Qlr7GoyMTVI+CPycG8xJu5gBr
 vwL92bJxJ9bIpUzWdQn+iviFpXF3Z62VZKfeFt7SYI9YiwUXIoEMBt6KARVcCli2X4q4
 9Jow==
X-Gm-Message-State: AOJu0Yzq3Yunjc/N+tzZOYABdqTRsNI3JGEBCCRCxOk4op0JjKAX5yMz
 aOuWcFybnYBTJTOWVe2hNd/8s0KCpvOq4Z3eKnPZkbqtUp1usbApoPDtwkudm8R7J2bijVWcot3
 +/FI=
X-Gm-Gg: ASbGnctgNodpuihxUEY5nn3DTRoLH2UASWdTWNrMJwLDSM56MD1GSHA9yooZJ6XjAdu
 R/XpdAFNZ+x948N9tEV7uZzLz2FM0uqZ5B6m1bETuBDO32wgdtfLrx4t+a3pqEK1HdtIStrbIHU
 KzXTKV8e9ftzciootlPWWCPTbtuB7vL2Ntnkre0B//M5GdUIC0bxRrFaQU7G9OzcPm61KNY8n/n
 XlrnxjN32KiTUulvCkxM1a6ch2c2wdzmdTxdOHKBFQI8shG2TE4GdfoPR6dhNSyzuwkznZ7tG9a
 DEVv0Kg2eRxBJbqEeItPzBWn83urxNl+0ax3XvgxREdldD7LxUYbzJOeb7q/4ZrkP+5KmC9tHRJ
 EEG2z5VobKte55nvK42E=
X-Google-Smtp-Source: AGHT+IEf1zz2JlhDeBgWPLf13iBzEGHx7mr1AgCh/Nwr6uSKIIMvPJwNDATmNe36lLO9adAQ5BcE6w==
X-Received: by 2002:a5d:6482:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-39132dc580amr18313104f8f.43.1741722721857; 
 Tue, 11 Mar 2025 12:52:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf7c82566sm81786055e9.30.2025.03.11.12.52.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/14] system: Extract target-specific globals to their own
 compilation unit
Date: Tue, 11 Mar 2025 20:51:17 +0100
Message-ID: <20250311195123.94212-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We shouldn't use target specific globals for machine properties.
These ones could be desugarized, as explained in [*]. While
certainly doable, not trivial nor my priority for now. Just move
them to a different file to clarify they are *globals*, like the
generic globals residing in system/globals.c.

Since arch_init.c was introduced using the MIT license (see commit
ad96090a01d), retain the same license for the new globals-target.c
file.

[*] https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe-b057-9046c70044dc@redhat.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250305005225.95051-2-philmd@linaro.org>
---
 system/arch_init.c      | 14 --------------
 system/globals-target.c | 24 ++++++++++++++++++++++++
 system/meson.build      |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 system/globals-target.c

diff --git a/system/arch_init.c b/system/arch_init.c
index b1baed18a30..b9147af93cb 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,18 +24,4 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/system/globals-target.c b/system/globals-target.c
new file mode 100644
index 00000000000..989720591e7
--- /dev/null
+++ b/system/globals-target.c
@@ -0,0 +1,24 @@
+/*
+ * Global variables that should not exist (target specific)
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+
+#ifdef TARGET_SPARC
+int graphic_width = 1024;
+int graphic_height = 768;
+int graphic_depth = 8;
+#elif defined(TARGET_M68K)
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 8;
+#else
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 32;
+#endif
diff --git a/system/meson.build b/system/meson.build
index c83d80fa248..eec07a94513 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,7 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
+  'globals-target.c',
   'memory.c',
   'physmem.c',
 )])
-- 
2.47.1


