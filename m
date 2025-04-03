Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2425C369A0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MLD-0007eX-Sn; Thu, 03 Apr 2025 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLB-0007dy-O8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLA-0000QF-2R
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso7482785e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693526; x=1744298326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otH5kJZDaqXFqi3K0/tLZ6a2mur9OK5+mhfeGaUByik=;
 b=tKL8E6jTsXSSFPJieviyKjKwhYMk6R51K4noAf5+p2FCAOI2WJNEG0PZZJ9MqZhYAd
 tJljaR51Xvi5I3s0VYmttWMo1UfucEhHVhIfFAmizaszr+k6TVr61Cxzg0gXSILfSr7m
 +9rOXynmUXHWqfY48mvlHs/SQZbD5cCbxswMAq6LOTmsXB3B3tvIiaJCvCN8LmaOWJzS
 C8VKK4lpbWc/WcADt1MYQg7rSxHSB3O3anMk+TvYBDC/rc1B9pocS7CpT4pVNsvjo+UX
 RFvutrvWw7zDw+vGK7yUDG99EEo7UciFkwFkywED6Za5ikia4WeLuwHbRvDqz6TykohB
 SflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693526; x=1744298326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otH5kJZDaqXFqi3K0/tLZ6a2mur9OK5+mhfeGaUByik=;
 b=eon6/I3jSle0gtXqIG3D2aZQJcxkngsrDoVC5g72yL8Vvs1v3iDC4XNXEwq7ODWqfO
 k/oRogTkHT3UM2rOA4/IkFyP2vWTtMUHuiTftcIenm58TOl9w8ER6r9onH3vRP7V97sJ
 v82c7C7MSexpurbFez6+8axgYMaqwJNUNGzjYUuFv18zI5q1ajRZPAiAR2coogBUvfj6
 flqno4uUfeH5qRD8XjLXIZJjgmecrudqBYTb7cOl3qgP9046NmME2CHj+ZGpSa1MHiRP
 kYdKCJeY18FXYS8ZKsXJWJyEZMWnr6lqKbNv/+xJbifi7cV2113XGYDR9oTsVKEY50w3
 G6Xw==
X-Gm-Message-State: AOJu0YwjS8fI9roJ9Zrmir78g9mTLko5/JR55O+rTfb0vBImNwYJ89NF
 r2K4pAUY6kz1m7NalkHozLDo/xZFIUEXwl0dYT6OUNtFAIYDAx2Aw0G0l6cS99P88BsN71JDbBZ
 W
X-Gm-Gg: ASbGncsAgj7PED+qGnEwlZscqSQaFXT8latBUrKFW7us97NzoWuHEqz2TXEzMaEmbKT
 9Qx23egowdijogoZCzRiWmqG4bnhcLbIEZs8JzArk44tqgf0JGJCuIVXeCClsV6vDbK2hYLCp3L
 3k0CF8f3XXXvsInH985GXmhBQ3M+nHjudIYxZD3og8WAu5Mk4pyvN51eUPDWEJ3EzRt840bP+Se
 ncuUVuUpfdAIGe5ckas3avTCCGjDdILxw+rMjHM7q5oWv8PEPu7jpaV/YCqu2FTmEwkGhBHNzG4
 yWig/GCnqbjPkrsOvN6gXT1lw7vNTn4Cr5rFfMm0oR7yJv6mGfTm8oEq11ZVsYxH+ZRhq+PrIkF
 QaGWyHZsVArkCzI+jerg=
X-Google-Smtp-Source: AGHT+IHoC2ABwdCihgWB9S8Qq/GhhLEkiEXJhNqBUtphXBgPIEXlYdIM/RzIDba7lPE6rjWOQxTheg==
X-Received: by 2002:a05:6000:250f:b0:39c:1f10:c736 with SMTP id
 ffacd0b85a97d-39c1f10c765mr13657417f8f.43.1743693525801; 
 Thu, 03 Apr 2025 08:18:45 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a732asm2084187f8f.30.2025.04.03.08.18.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:18:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0 v2 02/14] tests/functional: Add a decorator for
 skipping tests on particular OS
Date: Thu,  3 Apr 2025 17:18:17 +0200
Message-ID: <20250403151829.44858-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since tests might be failing on some operating systems,
introduce the skipIfOperatingSystem() decorator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 45f7befa374..af41c2c6a22 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,6 +15,6 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports
+    skipIfMissingImports, skipIfOperatingSystem
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 1651eb739a7..b6a1d41c55c 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,7 +5,7 @@
 import importlib
 import os
 import platform
-from unittest import skipUnless
+from unittest import skipIf, skipUnless
 
 from .cmd import which
 
@@ -26,6 +26,19 @@ def skipIfMissingCommands(*args):
     return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
                                 ", ".join(args))
 
+'''
+Decorator to skip execution of a test if the current
+host operating system does not match one of the permitted
+ones.
+Example
+
+  @skipIfOperatingSystem("Linux", "Darwin")
+'''
+def skipIfOperatingSystem(*args):
+    return skipIf(platform.system() in args,
+                  'not running on one of the required OS(s) "%s"' %
+                  ", ".join(args))
+
 '''
 Decorator to skip execution of a test if the current
 host machine does not match one of the permitted
-- 
2.47.1


