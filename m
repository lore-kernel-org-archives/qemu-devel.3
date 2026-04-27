Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618D1FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1y-0001ie-Sk; Mon, 27 Apr 2026 04:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1o-0001O2-22
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1l-0001vJ-P8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so52116325e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277351; x=1777882151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0N5garPfkGQjAeUEzsjLtjevClXnBOjQBVGcUSmAQTU=;
 b=hUt31tiRtYBDDfMeg/P7McYqmi84LYz2qin14TvGwE+MbxvCUvpVAwqYAYNI66XDS7
 sVGJap+KbPFxbUJBuDjkAEByEP6n0H4z47CVlHEBEVHHCBRf4sF5hyKSfp+5eMQYZ4oE
 7kCxf39L7KF8iJ+TWsGy18ocyWgMS4Xkk+2UOh6Ct+4yOCrAlKEd+pk4MH+ceaoXPobl
 XPa8cB0xmzsFAzsC9MWpvZZMZhq7W4L958NjbmZMaAEm/Quyx8zgQQo9qEAEiITQetSe
 kvGyIDkbM3i4quxDq0ZeFXfhc+mzCsAKXLqWU8QXf3R4l61NzI79ffugm5LrqwjqP7ii
 z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277351; x=1777882151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0N5garPfkGQjAeUEzsjLtjevClXnBOjQBVGcUSmAQTU=;
 b=FtYCpxCEcB3AhRuNASVIxwWJrOcYhPKAilQjz/dNS8S3z35kfkzfEeea4NcvtpolFK
 KDwUdSr2mvTsdbwbFMlJj9rl/9Y+ePrkgnV7S/5a1mPJotwNDCzUlQrUCZgK4H50Etz3
 ASLX3kmxjjIsXaV9trpQFFFtOPi4JFWbE3CPJgt9LJxewZj5598Zh4qoVYMmxcfsaaKS
 FzDLG1N3JbNIvUadm0kR21ZwCFjrCGH9sG/U/a+lm9P8SOVW21a/n3bTkuLmhM7vJ9Dh
 lqUcI1UUDekrzsSVLA8hwQW9YX+meEAz9QY1ji+X0xp4VnQKXGJGBRrGiasOII97TVAD
 Wdow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jjDJh+ZM8EMFR2oI+EnTiwETWflqef8Cwy12C3TS2OD8ZDTHPecTcwZujfsR6XlnJBUAMx477VUuy@nongnu.org
X-Gm-Message-State: AOJu0Yy1lMuySIkyDvcvuT7SCq0shuy8dVDCxBXpI8LRgb9Z77mblyCn
 cvJgkZmRR9m0OvErJVPPpdAGAuP4PbCIZ9SuBTJwwDXaUj5thCWKvFyVSg3wEtCFLR6xMIIeat9
 LxbGUdAs=
X-Gm-Gg: AeBDieuE9I/v9xCn4Li9qp+BDtGNvy4nRilOdP92WndJImUVAyiN8lysrZ3ZEW8xnrJ
 7OoDy0fcN2z41pOXFqsSaqiXkMwzP4eCyRnbL0+k4Yidr6bv9yfdM/hlVK2PQZ8EflD0c1h9CP/
 YozhRu4Nmku7gPVX04QEOpuqK5ypaxbJWqNrQ3Ek2vWEO6VNazKPUO/jBkIh0OPeeSx2PoasZfR
 N7KXZCyXzWyhhM8YBznz6ORtSYAR9mGOkc6OTvDQ+VqEF3RM3Vxo55LC4rKiVtCUcFlZVn70f/d
 mkzFcvjEkyaj3JGAp9/szKPbupVMgCNsirga9VkJCFMKXq7H0es98NVkZ5WDV2qr6hT+8//zx2z
 0EnQEKXMkE/08JzuiVXigOOzj56PVa+pj0ZMqXds/03F1FE2ovT9m4z8wMQhMR95bBpqvfjUCuf
 bfaAwzk9LhquWDeMFz58gUMaeXPsaWZc5kzts0zOFehllwk1yyON40oEQmL1JffcZYG6yEMNxml
 Pzy3T3c3jE=
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488fb8b91a7mr543470445e9.12.1777277351292; 
 Mon, 27 Apr 2026 01:09:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4899dc95920sm167976405e9.6.2026.04.27.01.09.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 13/32] monitor: Do not check TARGET_S390X to build s390x
 commands
Date: Mon, 27 Apr 2026 10:07:19 +0200
Message-ID: <20260427080738.77138-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since the methods are used unconditionally within hw/s390x/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
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
index 8ed6648d094..5583df5087f 100644
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
index d694bfdf768..a29185741b8 100644
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


