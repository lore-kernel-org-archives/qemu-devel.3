Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B06CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEe6-0003WG-Oq; Mon, 12 Oct 2026 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe1-0003TF-A1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdz-0002N8-Hl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so15501755e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806198; x=1792410998; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JvLqMsGvjzAWD1K/QlTWpgu40ptVWfQKoWJa7G40lnM=;
 b=g4QuVZquKz1EyhTcyfO7xBYoE4QssofvWOSlzEvTyNSWe61LsGPTVfdodTTG+QqfDf
 elK1/HtfvsolDUycGSGcbE4qZ7bwzpYlQfrgRvYZ1g6AuKCevWWJu7LQERyktFoJ3Sof
 lnGLWoL0l18Ro14yGH3mRVv5GE/hHufdqznwJ5b9QbTJY/GWXrONxPh2oS6F6V30ou0f
 NV15TLneZ+jBAn6EhoSF0NND0SVKwyluuMkTt/c/CUyZBOBw3KmPg4XQ9qfCzQwgnh2C
 XbU9QgUEx4BCtHmzPzj1TJYuKvJATq1LgYExxZ1uyVA1CeWJvXn4W4ci6I5HWcO1iSTl
 1uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806198; x=1792410998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JvLqMsGvjzAWD1K/QlTWpgu40ptVWfQKoWJa7G40lnM=;
 b=JRdMn0yVeOws6d+ALfrz3TOWOW/sCK4fdzlee5YXIIKSETQ5QcPIoy82/XlYkxu/rl
 VHi/xzrOqrK/4+ohnXKzcpf4ETSLfHBmxDQO43V/qvM2VBrYdk+SFvE50l8vK1ekYsKy
 y8YKwYtD/za0H5qp9qfqbD2LCpEyn++lNibhtoFv0r8mY3IVZklczC7L2kRLf3ep6OvX
 XmIIjc4qTXO6aUb94QZlOBsbBpZ3QbHzoA/vxb+PCRoyTluRVYEMvkD1X5OSZmZNrwad
 9oAtQWsXH05iuLxYbmlSZBgmJ0oYZAqR/Bq++44N+Zn5DC3DgdjiE1vojqo+5XTVc9T0
 LRfA==
X-Gm-Message-State: AFq9FYKNlmILSLiBKdb74/ojco9NOnW9P5fNw320x78Qub8SaKdvjz1u
 6Ap1AW5MKPkQ6wDAX5VZQbv9RAyRWvs27ZFXeEWWNTaALOkelx/x6Ppo
X-Gm-Gg: AYBFou2Y6wb48tqeHcIVPUfi1XmU9I38m2tZXBMYiC1cm+YADMyxN4aipLWC7mUW2I4
 PO5ADqVQfwwE4ck/E1OOI+55XF0Kp+YTjj3BwhppM3ODjuEqlvPHRfSPlEIBhOJgJAVirZPtu2m
 ka1grzIm0MDxEGdI5TMpo/E4i8jnRxKYaoFpCyg4OzldefHK8mu8HWyhsG/jmQVutK8X7/FedC6
 Vs4C+HrbiWzbYw84cQadoqgL/gpW4QAot161P9coRX3wbN6WDW+yFQfo9AHkH3meoCn+ynYpleI
 eLk1q6yEzCBXRW1nriY4lG5j82+jaR2tK9HiGKYXaPONmLs1SFibaytdrWr2JsPItOi529jcUFj
 mQMziuxlkc0dRilOWvXdxNbc/6lajhoFKgpU+91mfeXuj8U9Cih/rg7PIf7MP3x/wOi5Yfrn6bS
 sKuLAJJtsuZY6hr3uCci7EpPf7Wu2FbmDRaSSJad9eVkD/YMdlA4HFkoKMv/baWmpnpa1lXwoS1
 h8VfMz45HBa63tca3J8itOFzlDSHycwsiONCg==
X-Received: by 2002:a05:600c:548d:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a18e49c128mr174244545e9.13.1791806197974; 
 Mon, 12 Oct 2026 04:56:37 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1a1feb78csm72951965e9.0.2026.10.12.04.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:37 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:56 +0200
Subject: [PATCH v9 05/12] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v9-5-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=4151;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=plm5BVcHLYihzTF0mY8oXYksy9OWYhEWKZaHvV1IPs0=;
 b=Up/b08cwMjhjJZUiqZo4PLvqfgT4QdcjhSazS7P9GcDUa4itvKZwQRgxm+TpMwniikMvxLyMN
 K148n+8x5u2Dbnl0Q3v/8eujg4siCzLWHstwgrzZaejKbQtt5kMlUL0
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
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
[Filip: add sigwinch_remove_notifier, call it in curses_cleanup]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 include/qemu/main-loop.h |  5 +++++
 ui/curses.c              | 21 +++++++++++++++------
 util/main-loop.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 8c1241a2c1..533d4c2be4 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -449,4 +449,9 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+void sigwinch_remove_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index 4db32b6168..9079bfbee4 100644
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
@@ -172,21 +173,28 @@ static void curses_winch_check(void)
     invalidate = 1;
 }
 
-static void curses_winch_handler(int signum)
+static void curses_winch_handler(Notifier *n, void *data)
 {
     got_sigwinch = true;
 }
 
+static Notifier winch_notifier = {
+    .notify = curses_winch_handler
+};
+
 static void curses_winch_init(void)
 {
-    struct sigaction old, winch = {
-        .sa_handler  = curses_winch_handler,
-    };
-    sigaction(SIGWINCH, &winch, &old);
+    sigwinch_add_notifier(&winch_notifier);
+}
+
+static void curses_winch_cleanup(void)
+{
+    sigwinch_remove_notifier(&winch_notifier);
 }
 #else
 static void curses_winch_check(void) {}
 static void curses_winch_init(void) {}
+static void curses_winch_cleanup(void) {}
 #endif
 
 static void curses_cursor_position(DisplayChangeListener *dcl,
@@ -417,6 +425,7 @@ static void curses_cleanup(void)
         return;
     }
 
+    curses_winch_cleanup();
     endwin();
     qemu_console_unregister_listener(dcl);
     g_clear_pointer(&dcl, g_free);
diff --git a/util/main-loop.c b/util/main-loop.c
index 65e5dbcc94..e59af0e270 100644
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
@@ -124,6 +125,38 @@ static int qemu_signal_init(Error **errp)
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
+void sigwinch_remove_notifier(Notifier *n)
+{
+    notifier_remove(n);
+
+    if (notifier_list_empty(&sigwinch_notifiers)) {
+        struct sigaction action = {
+            .sa_handler = SIG_DFL,
+        };
+        sigaction(SIGWINCH, &action, NULL);
+    }
+}
+
 #else /* _WIN32 */
 
 static int qemu_signal_init(Error **errp)

-- 
2.56.0


