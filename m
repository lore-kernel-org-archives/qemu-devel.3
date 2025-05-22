Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3380C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBEp-0000uy-NB; Thu, 22 May 2025 15:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEm-0000uF-W5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:53 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEk-0006Rg-Nm
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso163539b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940749; x=1748545549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N4C9DptqevA9wK4usU3+DxvuKBaI+3ZGbXSlc09sfk=;
 b=fvMtgx0rHhSJPe7Jicc2QMVNTB54yhnZj7Ncz3EZgTdP/IAXwNvS5b3HNALTkzv6vv
 Z5RAo1cBmWq+41y6ATIlV5CxKYEaq9oJH8s9ERcRJtds5JdkQyZ9PtEHaN6f6U55V2T4
 4WE5R7KClIU5iIchgmt4nzv2au7P/9Ner41Al7IMPe83xyKr9xSmqoOLNU9JoOiAcmwm
 HcnTV+kZQ6Bklbz/UJX9OIkgasIa5cRNuZAT3tULMmte3ixzpWRV6i0MGOL1PCJbdLao
 v4kO/63gP2A+w9cLxKCbsZZuU2pcgcczp6E3pzTn1xN99h605TbslQEKATMT99macJKG
 mUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940749; x=1748545549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N4C9DptqevA9wK4usU3+DxvuKBaI+3ZGbXSlc09sfk=;
 b=UczxtQTXhUhCgmDtIqqgvKVSGVIo2sHZhcZoNgKI1g9wFlVj3obfI4dHYN7gtS6dM4
 LZ3VQcxw7g94XslTAs2CmH4jXCQdddVvJyvZezjxhRDZSXsmZzTWdhWqG46ysgHkFUSJ
 ZR3PVOrDfx0BKaSYC83DPuQbL5CGNM4zqfHFbBP7B5yFa6dAuzcbyNRKkMVnYCKF6HAs
 oESgDLSZ58hj9Hb0T+WXZvFyO6pN35H4HF2xg/nJn9vk3pu5tAuE6FCuu2PmaLOW0RIm
 PNQtTb4oyCVexOVcyS6nbRIKS1JBDjKWeJBlMP+5t7g9N/6a1yyWcS3M+8AsAVyHbc1a
 p4yQ==
X-Gm-Message-State: AOJu0YzyvDqpGWrIC+QrCwws2CPNweyHL3d7QNLKo981nO4ciWon5ieU
 EAPTUbLM4vaZnEm8O62T6+C9825YLwe6WCji53gIQuVcf1E9GRfisznUHi9we/atx8Gw3Kt0dU7
 wEhmJ
X-Gm-Gg: ASbGncvLnKucg1l8bQFX1MFXcUFFcv8KXm4IcMn95UK8GNk8QbUZA4eV7/QAU7cqwJD
 LmvRwvFrNUvvTNEyKFkCDLkKnVUOcdEnFaHBnt8vUexxa/8fmUpjmR/Svv8mGuIDDCUYk9I/1Ny
 CXS9KW6Z2KcvjE5ogTaerJrag6SyrPsSwBRmEs80gm8jFJosf9+aNZMSSgRlxNM8uvS7S/CWjgH
 xlkl8C/k/YVnQgElp0p0zi7zarx5EIdZ9oI/i19VARvKKBBXDOoTdWsY0syOEvF3rwu5LB1+tdP
 7aYLJRZ8dpe5RPTgOmakYZr1MM+uXgrw3LCBkAAZnnhTHxroJfI=
X-Google-Smtp-Source: AGHT+IGghbpf45jURXSgeAZKpf/Mx7qzD3TVIR4LIiuvQG7JLGuXxL6vD3c29NWUI5S6MpOSZjn4ag==
X-Received: by 2002:a05:6a00:e06:b0:742:b31e:e9c1 with SMTP id
 d2e1a72fcca58-745ece8e3c9mr778740b3a.11.1747940749349; 
 Thu, 22 May 2025 12:05:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 01/15] qapi: expose rtc-reset-reinjection command
 unconditionally
Date: Thu, 22 May 2025 12:05:28 -0700
Message-ID: <20250522190542.588267-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_I386 condition from the rtc-reset-reinjection
command. This requires providing a QMP command stub for non-i386 target.
This in turn requires moving the command out of misc-target.json, since
that will trigger symbol poisoning errors when built from target
independent code.

Rather than putting the command into misc.json, it is proposed to create
misc-$TARGET.json files to hold commands whose impl is conceptually
only applicable to a single target. This gives an obvious docs hint to
consumers that the command is only useful in relation a specific target,
while misc.json is for commands applicable to 2 or more targets.

The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
RTC is disabled in Kconfig, or if the running machine type lack any
RTC device.

The stub impl for non-i386 targets retains this no-op behaviour.
However, it is now reporting an Error mentioning this command is not
available for current target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json      | 24 ++++++++++++++++++++++++
 qapi/misc-target.json    | 17 -----------------
 qapi/qapi-schema.json    |  1 +
 hw/i386/monitor.c        |  2 +-
 stubs/monitor-i386-rtc.c | 12 ++++++++++++
 qapi/meson.build         |  1 +
 stubs/meson.build        |  1 +
 7 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 qapi/misc-i386.json
 create mode 100644 stubs/monitor-i386-rtc.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
new file mode 100644
index 00000000000..d5bfd91405e
--- /dev/null
+++ b/qapi/misc-i386.json
@@ -0,0 +1,24 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# @rtc-reset-reinjection:
+#
+# This command will reset the RTC interrupt reinjection backlog.  Can
+# be used if another mechanism to synchronize guest time is in effect,
+# for example QEMU guest agent's guest-set-time command.
+#
+# Use of this command is only applicable for x86 machines with an RTC,
+# and on other machines will silently return without performing any
+# action.
+#
+# Since: 2.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "rtc-reset-reinjection" }
+#     <- { "return": {} }
+##
+{ 'command': 'rtc-reset-reinjection' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index f7ec695caad..c5f9f6be7e1 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,23 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @rtc-reset-reinjection:
-#
-# This command will reset the RTC interrupt reinjection backlog.  Can
-# be used if another mechanism to synchronize guest time is in effect,
-# for example QEMU guest agent's guest-set-time command.
-#
-# Since: 2.1
-#
-# .. qmp-example::
-#
-#     -> { "execute": "rtc-reset-reinjection" }
-#     <- { "return": {} }
-##
-{ 'command': 'rtc-reset-reinjection',
-  'if': 'TARGET_I386' }
-
 ##
 # @SevState:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 7bc600bb768..96f6aa44133 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -61,6 +61,7 @@
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
+{ 'include': 'misc-i386.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1921e4d52e9..79df96562f6 100644
--- a/hw/i386/monitor.c
+++ b/hw/i386/monitor.c
@@ -26,7 +26,7 @@
 #include "monitor/monitor.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "hw/i386/x86.h"
 #include "hw/rtc/mc146818rtc.h"
 
diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
new file mode 100644
index 00000000000..8420d7c93c2
--- /dev/null
+++ b/stubs/monitor-i386-rtc.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    error_setg(errp,
+               "RTC interrupt reinjection backlog reset is not available for"
+               "this machine");
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db307..3a9bd061047 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -64,6 +64,7 @@ if have_system
     'qdev',
     'pci',
     'rocker',
+    'misc-i386',
     'tpm',
     'uefi',
   ]
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e785..9907b54c1e6 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -77,6 +77,7 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('monitor-i386-rtc.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


