Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C918D1D480
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsdF-0007kK-Ie; Thu, 08 Jan 2026 11:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsd9-000700-GB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsd5-0002vu-Qf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so23774095e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888773; x=1768493573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PK+zL9VijewfOEn/KKAzudCPx9ckXj3dsbGsolAKk8=;
 b=sxYGZz3TpXzmAYOlXNnePii6DEfK9oIOruY488LE95ngqmH78ycOS0VmqUCbEDJO4b
 bkjpvyjO0bs+dgDXrhGCKDNMieBsim/r+dqiLnIh4MOjFgCrLhNIS//wlCyPpL8rR0Tb
 qtUeZ530QsbSNbBh5liNyU2Cb9cYT4JGP1m5+v5Se/RxxXnjiJKDTlPM4kvMyU3TCjU8
 2IuOFEitKfG8qmNh2cg3gM/DuqoEBbv8mHkKFm6U37EWfPycxhCeGshVi8WrHmWxUIhv
 g1wIJNSRwno6Yy3db8xVzyf0UtUpGZirR4abL7aC2MzaLyvit6rn/lSSDnxlCQTMujpM
 2+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888773; x=1768493573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3PK+zL9VijewfOEn/KKAzudCPx9ckXj3dsbGsolAKk8=;
 b=uTfte2ehGNcOetYO5OnvGVoncsv6AYVXac7fVbg0ttKa9fd2VL8ldqKhtPmJ0/kDpE
 j8VH1OEX1MlxLBUE6Wy4QT2ztCcyMVUbiK6OatJzIQwfHAwH4H1F0OOhzsOHXp+Ag8M5
 TKPLwhYYiX10YWhE2k58hm3Eet0TEUkzNwPoYHSBVZ8U3vwecqO2hVhKV40XNjy0x27j
 /B5DidwNCbIx07aL12H7DySwcMzCS14oU/YbPYay8MdWPhEAg1eNuj/p7Of79UALsumR
 jjnYcBipkVWETBGZlQFQnVE+clmQOWDpix0dDzovc6wKL68wdh6OwgcVvMkDaHRkgkkt
 DK3g==
X-Gm-Message-State: AOJu0YygJgZ4IS3EdOYLjAp8gdp41FdbX7/PCNgf/zcCNepDk3D/N4Ez
 I0Tr47redi9tTgiMChYO0aIHtQAuOEp5dIBh0R0UNjD19CvUo9smfAxfKPMRKzn9O1p0ZX/3N5/
 darukdE4=
X-Gm-Gg: AY/fxX4/JXUKUIVBxMlJ6URncZelz1rRTRKH4Mlf0SgTXpfjx0AHH7ZUQdnON43elPx
 5o7K4SY1oakTYSPNgoE0XKhLbyICn77IgOw+CIxEd3vZ0QddLQ8N7SKorPcs60KuR6pjK8t1Io0
 4WRZbBxgHQEMLDyAr5+Gf7kyMFlW5Dm764gI6JTloRjRkRuU1jYgpjCuN17QED1DEpVXqZtuw4k
 Smpte+MD80W3wwJl2E8xdvrzcYp5uXxpBYkbshFb322RdevCht73D1niqmYODKc3hErZhvqSrGb
 kHFXVHFZSL+m5hpqUk0DUdFPwHyZFP+ZyKtYAzoevomGKOuS1BqjKGdZEDilv0gUC0Q1/JxzZUe
 ssh8Q7VqAMYGSi01GqwstySt4We3jOnrVhBTLjqGclPumjb5wcVdVY7wFue32ZBOeut8upTl92A
 vmLjYZIlqPS3eNuLxGn4RHK9LcWj8tex9aziTinvVQ1RQ31tG3Ujc+fdlwfkvb
X-Google-Smtp-Source: AGHT+IGQKi2Xh4akMjOmnIdNPDmoNJbrSgOUjVVEkZMWj28ZHTLugqlvxnfjzKNAeqPOHExakGxqdw==
X-Received: by 2002:a05:600c:8b09:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47d8f284036mr10302735e9.29.1767888773044; 
 Thu, 08 Jan 2026 08:12:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dadcfsm17075386f8f.3.2026.01.08.08.12.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:12:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] dump: Build stubs once for non-x86 targets
Date: Thu,  8 Jan 2026 17:12:19 +0100
Message-ID: <20260108161220.15146-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161220.15146-1-philmd@linaro.org>
References: <20260108161220.15146-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Rather than compiling the same content for all targets (unused
most of the time, i.e. qemu-system-avr ...), extract the non
x86 specific parts to a stub file and build it once for all
non-x86 targets.
Add a Kconfig symbol to only select the target-specific file
with the x86 target (rename this file with '-x86' suffix).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
 dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
 Kconfig                             |  1 +
 dump/Kconfig                        |  4 ++++
 dump/meson.build                    |  3 ++-
 5 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 dump/Kconfig

diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
new file mode 100644
index 00000000000..07d1a0c5ea9
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
+bool win_dump_available(DumpState *s, Error **errp)
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
index e5fdc12ad34..4f8bcc356fc 100644
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
 static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
 
 bool win_dump_available(DumpState *s, Error **errp)
@@ -494,19 +492,3 @@ out_free:
 out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
 }
-
-#else /* !TARGET_X86_64 */
-
-bool win_dump_available(DumpState *s, Error **errp)
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
index 00000000000..99f99ff4a4f
--- /dev/null
+++ b/dump/Kconfig
@@ -0,0 +1,4 @@
+config WINDUMP
+    bool
+    default y if I386
+    depends on I386
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


