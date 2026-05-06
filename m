Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE1FCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcqZ-0008EF-O9; Wed, 06 May 2026 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcov-0006f7-J3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcot-0000px-MB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso2915567f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076105; x=1778680905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sl8U+jIyL1fkwOEzNfG5NMotGUs+7jdu5vaCYnmkv1o=;
 b=sKs/wZ8DCJMLpS+qUJhHJULZWT8QV9rsEbgAK99llILB7qTvtInGfb2R0PO1G1ML3N
 Ysj+j/SIC8wiH0+J7QNTMoTpbJIYNzile1AhLRqJ8sclKc8CVAS6tDiK6nWFfBGHBb1b
 /PUVY9ahn3R+kW/hhJczFSJQa4mMkkkbxlAkBuA4WeRKZdVHp9TDyz44aydPaa8NHcy3
 zBjrPwzYNY+GZKw8juhk3WtNpo+vzxSIlm4PONF+6fdLOP6eM/p8xf0FIKx68KlZDzpf
 T7uwVt3O5I0ipEwrrU9NlAFtF4je6iKm9oN0hxZM9f8Aao5YSxR6SzTG6dOZvf1Lgy0b
 3aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076105; x=1778680905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sl8U+jIyL1fkwOEzNfG5NMotGUs+7jdu5vaCYnmkv1o=;
 b=bdqV694m5n9hUeHfdGJFSDQUIFJI7SKXrGJaua5hEAdwCbdf7ah6qyDwup9Sk3cljY
 hrx61T3DWSqENbRo7Gt2sUR+duhOIsVRXqTSG3ALg/jxPEnzlA2oDhLDWN7VoHwWe93m
 LpGjFZ5BxuRL03elXktwQzdg41WLsVwPpjJ1xRAJXuGOAut3HDZYkSWlpAOAV6EVHfor
 BX+N5OMYVCxDDWFB/LlvkTKA6vFoxtUwlQFY/Pjrpy9PMYKrye5XufWXtJUGopb1MWk5
 U534rIN+ldAC3WUwBcxs33l3w+QvBIsOJcDR9qkxFtOeP6x/IBISVN5jYwFtKQIqUNC0
 P2sw==
X-Gm-Message-State: AOJu0YxqKoZvRL19KNbnvZrRBO2fXDVRkF47GGnHqC5Cmi+hj2zsF6mb
 /OQiyaauOLS/aNzyUxovaj34WpP91hnucMO8ZBg7dGxUCrQjxe4Ok/D4MLyRCYOIPKemD7hChge
 mHx+7GHc=
X-Gm-Gg: AeBDietdJ8iOg4QJAG0MqrK9jK6Gle5GpgxSZ3jh9T9o4qh+J1/hHjzYk4r74AhfnsA
 9ebn7M8/I7CJPL/K8r5bFWMtr6DCnlERoz+SfM8k4c2K+8lVpvIfKynix7PEAFB4TVyb9Nqq8i8
 tToO1B+NSY+zjeZID+/AIqPrAmFai//OPbq0HWfnXWvxrY28wIInuM6Gj2Ao7Y0deAfwri4ynrY
 WB3IKlW6LSVKd3ESSxaQpwWioH6pN+e46ckSCl3EdjRv3zy0jocnIqt23PJQVSPvLFFxPM6X99b
 tiypN6z2VUMXJ2qIqKolHkC1NDnQmK6qa6YvjXhgfAsmShZ8Ufki8rm7TH7NKdNfBV3MdD1AYCV
 BT1STHU02ERKV1SOKxXdABnirtfqL/MQlEYKNTGeQ5F/9gKE2MnqmmJEiLDE/FA92hms80tMYQK
 cW1ZL4E03MewFoNbSgyKXY3qhS16N6Xo52FmgBU9KzWbrVw/jxwqLzJshzajuj5PDaR8NmIgm6d
 unaE53OTH0=
X-Received: by 2002:a05:6000:2c05:b0:44a:a729:9f51 with SMTP id
 ffacd0b85a97d-4515b056af4mr6001485f8f.3.1778076104405; 
 Wed, 06 May 2026 07:01:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960aa2sm12316026f8f.29.2026.05.06.07.01.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 049/110] monitor: Do not check TARGET_S390X to build s390x
 commands
Date: Wed,  6 May 2026 15:54:21 +0200
Message-ID: <20260506135524.20617-50-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

These commands are filtered at build-time for s390x binary.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since the methods are used inconditionally within hw/s390x/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260427080738.77138-14-philmd@linaro.org>
---
 MAINTAINERS               |  1 +
 include/monitor/hmp.h     |  7 +++++++
 monitor/hmp-target.c      |  5 -----
 stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
 hmp-commands-info.hx      |  6 ++----
 hmp-commands.hx           |  6 ++----
 stubs/meson.build         |  1 +
 7 files changed, 28 insertions(+), 13 deletions(-)
 create mode 100644 stubs/hmp-cmds-hw-s390x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b05e4d2097e..c57a01131c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -122,6 +122,7 @@ F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: stubs/qmp-cpu-s390x.c
+F: stubs/hmp-cmds-hw-s390x.c
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 3ba17008255..930ffa31aba 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,6 +16,13 @@
 
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
+#include "monitor/monitor.h"
+
+#define HMP_STUB(cmd) \
+    void hmp_##cmd(Monitor *mon, const QDict *qdict) \
+    { \
+        g_assert_not_reached(); \
+    }
 
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index f6dce326cf5..a222fd4c96a 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -36,11 +36,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
 
-#if defined(TARGET_S390X)
-#include "hw/s390x/storage-keys.h"
-#include "hw/s390x/storage-attributes.h"
-#endif
-
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
diff --git a/stubs/hmp-cmds-hw-s390x.c b/stubs/hmp-cmds-hw-s390x.c
new file mode 100644
index 00000000000..2b4f4cac79f
--- /dev/null
+++ b/stubs/hmp-cmds-hw-s390x.c
@@ -0,0 +1,15 @@
+/*
+ * Human Monitor hw/s390x stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(dump_skeys)
+HMP_STUB(info_cmma)
+HMP_STUB(info_skeys)
+HMP_STUB(migrationmode)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 0138c7ec4e7..b1e2bf3c059 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -710,30 +710,28 @@ SRST
     Show rocker OF-DPA groups.
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "skeys",
         .args_type  = "addr:l",
         .params     = "address",
         .help       = "Display the value of a storage key",
         .cmd        = hmp_info_skeys,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
   ``info skeys`` *address*
     Display the value of a storage key (s390 only)
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "cmma",
         .args_type  = "addr:l,count:l?",
         .params     = "address [count]",
         .help       = "Display the values of the CMMA storage attributes for a range of pages",
         .cmd        = hmp_info_cmma,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
   ``info cmma`` *address*
diff --git a/hmp-commands.hx b/hmp-commands.hx
index dd6243bf2da..b41f44f5ad4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1139,30 +1139,28 @@ SRST
 
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "dump-skeys",
         .args_type  = "filename:F",
         .params     = "",
         .help       = "Save guest storage keys into file 'filename'.\n",
         .cmd        = hmp_dump_skeys,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
 ``dump-skeys`` *filename*
   Save guest storage keys to a file.
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "migration_mode",
         .args_type  = "mode:i",
         .params     = "mode",
         .help       = "Enables or disables migration mode\n",
         .cmd        = hmp_migrationmode,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
 ``migration_mode`` *mode*
diff --git a/stubs/meson.build b/stubs/meson.build
index af4051e6c5e..99a89c00066 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -87,6 +87,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


