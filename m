Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE92C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqUJ-0003p4-Rf; Thu, 22 Jan 2026 03:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTv-0003Wz-NJ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTt-0006K8-PS
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso397251f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072156; x=1769676956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JRmPUs0ajk0K+cVHrH+IMdZaakrlwGHZLGfwrs1xfgo=;
 b=eize3+13qnOZMuMmFMlOuN5lSXor9AC5HKLnWA3JipNo3hDHdoSpfmwonXGKCzoDNC
 qvgSppxBDWRMKlE9QijJHhpF7mwzXo9hLeKAB5azYY7S/aNh9I8ZFJkyJCc9nJs6nzyy
 Pt9Z+/U9Wbci3D4aYTBHGTyWADpoL9s8Vzdl7YfpdcM7B4rA2exwYHl9R2yC6vgLvLjU
 nb7zyLsGnWqDdQBFcMAps8qPIluJYBW+3wRP2+ykRQqbOccC7TpJuwKcNWKa3hc//piK
 M8QVtTKHbtWVXmcduVDXLBkOflInxsOO19fzaxVWXXucgJ0GVAHoNQxqzVlEOZhbPAVd
 +c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072156; x=1769676956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JRmPUs0ajk0K+cVHrH+IMdZaakrlwGHZLGfwrs1xfgo=;
 b=w4rahSmuyu/p/JzhvTN7TSEdcaiZXoNIFN1DshpR+6Fzrn5uUD7I8xj4a5e3OXVVz9
 d4yMrgeH3fRbJU8bwaAC5l/Og0a2IoUIqu8ecxRQFjlh/zfoxZInJy0OBDruK8dkr5v3
 erN1S/Nmam/hp+Rq45hNk25xaM4TTV2ms43vovmuK5cVj43Wsbbl1+iQU8/BaEydwgSn
 1JB4FB6lS86W9WMN37dAoWxW0S8oX5WNSNt0Xd4z+v/k/y0BdSi7AIyY6cKsBDFCcld9
 4qsSvpcjjPxn7DvD1W5g6px8WGgfOMhJEuhJAJwbD5qxu7nG8usbKH/GQRNAkEMJmgtA
 qoSA==
X-Gm-Message-State: AOJu0YwSbQkvL/T+JyJbtpAQG0g0JdGWEW9dNEs1fKW/7okhAusCzRFw
 zdp7pGNv/4kVKAAvlttS9gmu4aCW9DuYvEixnO52Tb5772KDBKkKmfxoZ4inzcbE0f+wCvBHLBH
 nov9iwuA=
X-Gm-Gg: AZuq6aIbO5yFovwaJzrqzc7NFgh7/6UCH8FBkn1FvMcMcAwNAbeJqSLGqW0dh4arIy2
 mnk3rlH6r+oP8IQil5IfUEfMyM8SKdg9bWhaKozcdxGyZffKFxtF0pqVE73XdK3mw1eFcMsSwLW
 +CXR61dnuZoI/90C/31MhZKKfkSF00FBCiz00bfbz4uKpFktB+nKLY9iG0OhbZTkg3AjZUbP7KO
 XuT9598Ca4VU6IiKFCqILgPwYn5HfsPTRSzlQitWELXl5NwIcHLcz0Sms/XWBvQtYaS09rI1wDj
 tFEqBqrQOTjC0q7wH65SX7xV7gyVTZeh3qn9Wx422khZ+JcPV2e9HjixFs17lfPb0TIddFKYIda
 mUeeTSVp1Zi2nM3gHrrBRN7Pto7mBJoZUzy9CM6bTyZYpMq2+AZgQd1qBOnwFFMQSJvtiN4Qv5j
 Oi4yV46bf4+3KASLs8yx02IY6EzjQGb1QCH5kM3OI1m5fPeq095J/5O2HsANYp
X-Received: by 2002:a5d:5f96:0:b0:435:9770:9eb6 with SMTP id
 ffacd0b85a97d-4359770a259mr11505855f8f.53.1769072155543; 
 Thu, 22 Jan 2026 00:55:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435a575c396sm6759296f8f.9.2026.01.22.00.55.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/31] dump: Build stubs once for non-x86 targets
Date: Thu, 22 Jan 2026 09:52:50 +0100
Message-ID: <20260122085255.95035-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Rather than compiling the same content for all targets (unused
most of the time, i.e. qemu-system-avr ...), extract the non
x86 specific parts to a stub file and build it once for all
non-x86 targets.

Add a Kconfig symbol to only select the target-specific file
with the x86 target (rename this file with '-x86' suffix).

Since Kconfig symbols aren't evaluated for user emulation,
the file unit is only built for system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260121215622.92966-3-philmd@linaro.org>
---
 dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
 dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
 Kconfig                             |  1 +
 dump/Kconfig                        |  6 ++++++
 dump/meson.build                    |  3 ++-
 5 files changed, 31 insertions(+), 20 deletions(-)
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 dump/Kconfig

diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
new file mode 100644
index 00000000000..96c1095c4e1
--- /dev/null
+++ b/dump/win_dump-stubs.c
@@ -0,0 +1,21 @@
+/*
+ * Windows crashdump stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "win_dump.h"
+
+bool win_dump_available(Error **errp)
+{
+    error_setg(errp, "x86-64 Windows guest dump not built-in");
+
+    return false;
+}
+
+void create_win_dump(DumpState *s, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/dump/win_dump.c b/dump/win_dump-x86.c
similarity index 97%
rename from dump/win_dump.c
rename to dump/win_dump-x86.c
index 6e07913dfb4..d893dea7f19 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump-x86.c
@@ -1,5 +1,5 @@
 /*
- * Windows crashdump (target specific implementations)
+ * Windows crashdump (x86 specific implementations)
  *
  * Copyright (c) 2018 Virtuozzo International GmbH
  *
@@ -18,8 +18,6 @@
 #include "win_dump.h"
 #include "cpu.h"
 
-#if defined(TARGET_X86_64)
-
 bool win_dump_available(Error **errp)
 {
     return true;
@@ -477,19 +475,3 @@ out_free:
 out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
 }
-
-#else /* !TARGET_X86_64 */
-
-bool win_dump_available(Error **errp)
-{
-    error_setg(errp, "Windows dump is only available for x86-64");
-
-    return false;
-}
-
-void create_win_dump(DumpState *s, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif
diff --git a/Kconfig b/Kconfig
index 63ca7f46df7..26388c12838 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,6 +1,7 @@
 source Kconfig.host
 source backends/Kconfig
 source accel/Kconfig
+source dump/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
diff --git a/dump/Kconfig b/dump/Kconfig
new file mode 100644
index 00000000000..4b59dbb5fce
--- /dev/null
+++ b/dump/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config WINDUMP
+    bool
+    default y if X86_64
+    depends on X86_64
diff --git a/dump/meson.build b/dump/meson.build
index 4277ce9328a..26e1561ed48 100644
--- a/dump/meson.build
+++ b/dump/meson.build
@@ -1,2 +1,3 @@
 system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
+specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-x86.c'))
+system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-stubs.c'))
-- 
2.52.0


