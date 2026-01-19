Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED1C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx7-000766-1R; Sun, 18 Jan 2026 22:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwe-00072g-8W
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:49 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwa-0004B0-CM
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:47 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso648064366b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793323; x=1769398123; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KOxHrDkh7/Td6NrYlRMgCWmk9a51ZdxVFAmtZjzdmGU=;
 b=PrKsf+ZUVwZyULYnoLM2zr/0wsWgBTYEir+yE720a7CUIQDYH3pGDHV/1pTgcTMzD0
 zU3AJPCT5DIvj3VWxTuI9j6D3Ulb63extD5k03kuoKBgjUAxDQtaP9aFt3nFdhwBOigs
 dqoj0U/GaUorkKqeBoYmFTebZ4aFig9sSImvja8tdHojbQJ0Chp8PXZzvKjOIfajx4Kd
 Gkxi5DkjzOU65De6Em8RfnsRnYu0UM6Q2smnzG7QxyqLvwcbFUplSikSseL17EM5q6q0
 Z7NJbDW/O4FSfXd0Hvz2fXoSVZpI20ziAcJEqCd2UoN2eiWG6fbTEtsf9MVZgQ+Pd8IQ
 eRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793323; x=1769398123;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KOxHrDkh7/Td6NrYlRMgCWmk9a51ZdxVFAmtZjzdmGU=;
 b=H7eCpF/NnCM1i2iJqqDY0mazIvtF6/dEd2MfMgINPHs2BKFDcXWX7hdcTyxh7b/Hnh
 xyUoyzPVKcrEZb7+nOnQ8lerGYIxYL0h39QJgBvytaMq2Mz6wbOKGmZt8eh2nPJ6W8V+
 7RIdOxTAJSw6xzbT66BXSvFHHHfXU3qg0/bNSLmG+MYluoMQvuzJAZ/miaFWnv0wUpFF
 Kz35HVegdGaXVDTN0Wv6tlXfH+CP3d7FM65hfiJNJi82low7AD44yIEYAuPoAC1poy6L
 EB8NaLwM4ZheOC9M/hrHrlHBGmZuCeDMWbiNtjWBEaK4tP6b071Yr0zKp7XN7/yQF11R
 3zag==
X-Gm-Message-State: AOJu0YzNOEnra58xbIP457fPA3NsLf7+R2ZGgMzFHvR2CwOK4cTNbngd
 Fty5RoOASpcZLDNLHRNHyClkP6X9+7HWwhORnLEaKLWq2XzoOzcdjd35
X-Gm-Gg: AY/fxX5GSFmMFL5AY3WCLIMNnlGtWQpXykz6yzJ12gbxjDLsFFWZUd3czssrWyuhewE
 XF6Fs0vdLdvYYguHbgCfCpdP8Jii5sJCFBd1hWRRcFy3qG7EM2+KNTBlc4ykAuND15c2hyvOSWT
 rbprLEX0uoLybkqm8ufY5YxaRNnNXKhm9S/Dhj/xC02cv28SaXeJRg2GVCXPTDJs5OZdq4XK28F
 Qxp7+UMjngyvIILB52GDVZCICIJVfUU+RH6DKYRHvyS13EaQsepzGyHc/9MVAtsSnzVSqNHaDiA
 HgMjYXgouNa2dLpORNNKilwNBa+4Ef9ajqv6csun/wEPYpcQo0Cp/HuQ7DsmsJVk920FKSHgUJL
 H5fuDEpNgjyJaJrmLQyJ0sC+GDysWa0z3a/FV1vSekx1o0bH0WD/qLNfpY0OuJpQOvzJU5YqnG6
 2Am3fsJDpOmEhn+HGlH//h91L8Ix5ctCsbFC527LjO
X-Received: by 2002:a17:907:724d:b0:b87:124c:5f54 with SMTP id
 a640c23a62f3a-b87932b6908mr879973266b.59.1768793322649; 
 Sun, 18 Jan 2026 19:28:42 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879e2c1be7sm895132966b.67.2026.01.18.19.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:42 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:48 +0100
Subject: [PATCH v6 05/12] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-5-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=3291;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Wpb+Av6dyfCrnZRtwb26zXMQvGbITtEVXsGaT2s43Mc=;
 b=cPctFHleyR0v5L0I/ML24SyWZLAmGxINF9qsB+ueQJ/7yel93Xs+Hdp2OZUPnDYq2gprHBiQs
 v3uBvTfuaQDAbo1ddieFG8WIHNBTrnClyXZDi3Ygp5kQZ1GvIXoYrs/
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

Block SIGWINCH, so it is delivered only via signalfd.
Install a handler that uses NotifierList to tell
interested parties about SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 include/qemu/main-loop.h |  4 ++++
 ui/curses.c              | 11 ++++++-----
 util/main-loop.c         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 8c1241a2c1..ff41346b0b 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -449,4 +449,8 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index 161f78c35c..d1b308d5f8 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -33,6 +33,7 @@
 #include <iconv.h>
 
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -149,7 +150,7 @@ static void curses_resize(DisplayChangeListener *dcl,
 }
 
 #if !defined(_WIN32) && defined(SIGWINCH) && defined(KEY_RESIZE)
-static volatile sig_atomic_t got_sigwinch;
+static bool got_sigwinch;
 static void curses_winch_check(void)
 {
     struct winsize {
@@ -172,17 +173,17 @@ static void curses_winch_check(void)
     invalidate = 1;
 }
 
-static void curses_winch_handler(int signum)
+static void curses_winch_handler(Notifier *n, void *data)
 {
     got_sigwinch = true;
 }
 
 static void curses_winch_init(void)
 {
-    struct sigaction old, winch = {
-        .sa_handler  = curses_winch_handler,
+    static Notifier n = {
+        .notify = curses_winch_handler
     };
-    sigaction(SIGWINCH, &winch, &old);
+    sigwinch_add_notifier(&n);
 }
 #else
 static void curses_winch_check(void) {}
diff --git a/util/main-loop.c b/util/main-loop.c
index ad8645c30a..136886e4ee 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -100,6 +100,7 @@ static int qemu_signal_init(Error **errp)
     sigaddset(&set, SIGIO);
     sigaddset(&set, SIGALRM);
     sigaddset(&set, SIGBUS);
+    sigaddset(&set, SIGWINCH);
     /* SIGINT cannot be handled via signalfd, so that ^C can be used
      * to interrupt QEMU when it is being run under gdb.  SIGHUP and
      * SIGTERM are also handled asynchronously, even though it is not
@@ -124,6 +125,26 @@ static int qemu_signal_init(Error **errp)
     return 0;
 }
 
+static NotifierList sigwinch_notifiers =
+    NOTIFIER_LIST_INITIALIZER(sigwinch_notifiers);
+
+static void sigwinch_handler(int signum)
+{
+    notifier_list_notify(&sigwinch_notifiers, NULL);
+}
+
+void sigwinch_add_notifier(Notifier *n)
+{
+    if (notifier_list_empty(&sigwinch_notifiers)) {
+        struct sigaction action = {
+            .sa_handler = sigwinch_handler,
+        };
+        sigaction(SIGWINCH, &action, NULL);
+    }
+
+    notifier_list_add(&sigwinch_notifiers, n);
+}
+
 #else /* _WIN32 */
 
 static int qemu_signal_init(Error **errp)

-- 
2.52.0


