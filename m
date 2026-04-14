Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CBF531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgT-00020u-SN; Mon, 13 Apr 2026 20:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgS-0001oq-2L
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgP-0003Bm-H2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso83638825e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126670; x=1776731470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyVhBxhNqIKQm4mEyhy8i6F7z6Ge4ld3eF+gEeCDR2s=;
 b=DfeoilOnivvmryKNscefH+nzIR5AHUbtGeCB3W8MzaoXayzVVznRnoUpHaUBzNA2b9
 KAOtEhEmTkQJmcVL0XVn/6nokuiwq4N384YAfaeKFSJLEOx7Vb7UKnOeJcJL4pL/Y1pi
 J9L/7dk816o9Cb9NAMfhgPBWFma2E2GxpQf1cZP5wy9lawHEw34zj3gZXjxzUFuuIlI5
 gM9r3mSyRscX1tguLCEkwUGrlibPEPM6pNJQ2cr4Bnr9vtW1Q+L5xwH3llBZUoX/PDDe
 EJIRpxcYonbEh6We3kkBuyjbQZ25XNltxiE16nvApP48xzlot+dXmVe5pIyic65vFdAz
 FKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126670; x=1776731470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QyVhBxhNqIKQm4mEyhy8i6F7z6Ge4ld3eF+gEeCDR2s=;
 b=r0Y5KWPIXvNL+aKyP7/cttUXs82Mqyk8u3DR2OBWvaW2hutcGvaC9NQBByfYCoQjOm
 lCSq6+QUD5XhDXe9KBzZ2tXKm0xEVfZZSbXnTo6UpPpbsilqMNVirxvsvpm9EHkHmrUV
 /hd91YSs2wQIZDM73sT/YnNuv0wVM8VebDQmbNl5Tu2JfA9KorQ5y20OJabSqrOgOOHF
 HHbp1fXZpelawuAUPGYeDO+g1yNzajS6OVuLeLKXaz89u7NwlH03Grgk7iIiIwhhOUPl
 RAct7a3wUODCwOyboW8yzO+x2uXqOp9aqTLjOu6V0sqZk4u4eLhviv0IoLQI5KndQAKU
 2uWQ==
X-Gm-Message-State: AOJu0YwQZ7xskD39k2L2Xk93KMrLCpA4fWXegdWaawdKjStLqZzOfIo9
 y50+aXZYYhtEFAf0/CG6SWJZZlj1j4CC8YiS5oGIGBscstyxDb1QVrBbBABEwsEOYXnz5n7cdDl
 MDOyeNRc=
X-Gm-Gg: AeBDiet6jNCz356xthC1nsEUVhx2BfZqLvPwgxEx9VYfEVvu+7uS0SP0ARUPija7cWe
 UKdQ1lft/oabUAAlp+2LulJsNhFEGg+Gc89t9iZdB6atxRAWf8nUjnAMicBwyVaZYhI8mgjllN9
 BRpiFwDqIyQ4FCJS1uwZdxY6GulzgkKI7BqFYObR94OrEBzIbxyxBJKcmHcaThyC0KSqsIom4k5
 KHF513Q/iQpWMd55SFffpYl6Qqcg1+9ZwbGfZhgpX1jBb0nIEEKEDhNp3vVDsD7oLrTXsukxfQl
 nXEB49Wqf9jeZt7cPXrm+EcXEB+ujci6tmhByjzyBsGAoJmvSEo06AftJvXdZhrPniRmdRxVsPJ
 7IzHAB+G3tgbNk6nMREd9x/RtkiLpDL7Ab7gXYb3LR8aY5iKdo6gYhOGxBrRFuCqOks7CsaCBri
 xpPpjIlCDUFY6N/KTpeu6rgwmmhfVzFsMqPKThkDogbQF61mbpf8YiI/ljZvLUcCmFz55Flffo
X-Received: by 2002:a05:600c:331e:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-488d684323amr118458355e9.15.1776126670568; 
 Mon, 13 Apr 2026 17:31:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1de4asm15084895e9.4.2026.04.13.17.31.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH v3 09/27] monitor: Do not check TARGET_S390X to build s390x
 commands
Date: Tue, 14 Apr 2026 02:29:41 +0200
Message-ID: <20260414003001.97571-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index cf462793a79..306835ff678 100644
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
index 2d334a5a8f3..32c16209543 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


