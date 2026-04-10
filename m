Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7CBF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxT-0006hg-KN; Fri, 10 Apr 2026 15:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxR-0006XL-Ot
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxO-0003bO-IC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso25629685e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850957; x=1776455757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ns/VNhECUVMMVKjm49BzmvODa90VglcciVurHoSA27A=;
 b=N8tYr4dnvRwEFXBVQ1UIzZnyXtt/F5Bo4hZFdAmWl8HxWaS8OLhvdnYf3h884MQ4Sy
 hauLUX7ehGcsTUp6nKL0DN9Lpk6ZH0v64N+0JLmQ0KLXbnBINiSwaJ+xS0L+TMklSO0W
 8kHmLldVMaeDcmECM1DZ2bZqyJpZUGJH7YfVNPEe58JQqRMwrtTtj7oBT0yKej5Odb7Q
 gEgsxD/t0KLwwjzzG4lJ8xQajkz0/vYiO32zfQWNYAMtDgmJbg6D2yp46Zk6BU+pIsVw
 /gLPDO69y3pDEV+l/zeQLPvRkRoWnDE2FDu370PPg/fvDYgZiqDUiZMRwlALwJtRRsLk
 54eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850957; x=1776455757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ns/VNhECUVMMVKjm49BzmvODa90VglcciVurHoSA27A=;
 b=SHJEouHScAUKtQq5TzbHY6eMUSmKTKvKXBee2CyiYGw4i9Uthreg8Fp/Jo80+EZVkH
 ogitdKMY5OaVkkbu01uKFA0HmtOZ+mTiMhAing6UM/YVvD4addWp/QIUgyVbZG6uGscL
 2Y8RNsbO0j98TY435nbLlxptWianhYNaMqZ+1J0qK4brCtgq2teZc8YFh9zzOJ6TCeak
 apIMsCJ9LFlc/aSj4ffIi7n43C/1Jg+pUxUKGvNZN/ko2PIK9bwlC0+rc5UOwVC9A0Ib
 SgU9s7bpUQE+89LOeVlSEITCPO1Vz5ICNmFRzoTKriDILhj9eea/ccjbh2nKma0XgC9E
 abZw==
X-Gm-Message-State: AOJu0Yy1mDAc0jqEWVSQ0fNLd1kUh6BDKdDgbqnqS64tZ+PpJaSRxg2G
 7j95rjYgl6+SibwQpmgMJHwk8zub9DAnIJwhCvQTncOXcBlXgdEXK47VP27oofmKh8kpTR6vfW4
 FULP+8x4=
X-Gm-Gg: AeBDiesyUT0g0VZDE3LxNCLHSAgsu3qAqlaxnRzQ2soJMVy5Zx6Qz9TPWingz5BZKme
 gLQAApD9S4nDeUvFyl7dlwhOXOXS9OoPo3kJYDVKtGkjpwSN4bfFanSshgkVtXCAjbDgUursQfe
 cr+LqyrpyMLVzGuOVcSzQmVfTOY959pqqdLo4EhrRBeMwdZRFoLmK6kKjCGEsTW++FaP6z0CZgp
 6LCuPhBxOQ2/UXNYuO9nULC0gvv3/RIJh+T6nR8FhVRwXYS94L8Vh0PLN5tMTfLqkZo/VmGYY2C
 Gym7uFD7F+UIiNqxQTmz6wCn83h3ymV3mmjdvHA7PiIVU4rM6dVp+Vu2BwB7ngOaNB/Q/mDAv7i
 Rf12JfcKy5B+WjkCmz7Mpj29wNzzd5kULrpKzGcAN1BCvksBGMkQXPYjtOE7GaGHDQ8mbInSp5D
 cq3Qn95vGaI+We8FZ3+nC8l8vFse4c654wXihozEZAJtsxwvv+13kUS+5Hm9q+n96nS5x6oyya
X-Received: by 2002:a05:600c:64c4:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488d68c2c56mr54818125e9.22.1775850956615; 
 Fri, 10 Apr 2026 12:55:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm109936675e9.3.2026.04.10.12.55.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 21/27] monitor: Do not check TARGET_S390X to build s390x
 commands
Date: Fri, 10 Apr 2026 21:53:15 +0200
Message-ID: <20260410195323.17937-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
index 1810625eb1e..e53158143a8 100644
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
index a0a063db8e4..c8ce8579424 100644
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
 
 struct MonitorDef {
     const char *name;
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 9d8dcb8835a..4968d511101 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -35,11 +35,6 @@
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
index 463038c302a..28dec25642d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -717,30 +717,28 @@ SRST
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
index 06d7b17bf25..ff65b39b454 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1125,30 +1125,28 @@ SRST
 
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
index 356d7800760..d4a6bc0dde4 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


