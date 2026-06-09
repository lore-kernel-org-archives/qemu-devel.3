Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9683CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wb-00065m-2v; Tue, 09 Jun 2026 15:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wT-000627-5G
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wR-0006K9-DW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso49407565e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032609; x=1781637409; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Lfe6LFdLVNOGpPU3ziss9O+P1hifgFDq9+jCMVKyio=;
 b=MrvbFIL24wMKhrp5/f6gfaxyKf5ARbI2zPuruI4yQwQKmEEhXqZuGohCzG6dafLuDM
 69bDBLzKVp39ufCX8/DX1D2+AO0iXIF1JH8sCLXRuNMqx0nOBNkT1c2qgN+XKvA1M6BP
 BLnwGAcv+5ua6xacx4+Sc3+6sdzz6kC+ejCH/M29vEoLtBBTBYPmofmY40dGz0WUTZ57
 ZzH21Bwcm75cilnBWDmeEQTtotzC6Sj4z9AbbbOF2DbRP1Tvj71UGdPZEgikDfMVA/M8
 I1k/X12ny8Wn6WbVvE9lTeGxso1GrkcMBNRZ304CYKmTzJ2+fBt4RtP8BQmlVRGPhLNB
 5knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032609; x=1781637409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8Lfe6LFdLVNOGpPU3ziss9O+P1hifgFDq9+jCMVKyio=;
 b=RZiC2IhqrgHs55uct73GC+wMVF/jCZw8giwoc7kKAl7l8Y++etGOxEIiawejAQbzwV
 sqSnbS2A0jnafehgfgagJwiIn8oOhdvgpGvgdIjiU5nlz2fd8tFg4RW3vXbhtAa0oRkn
 5axmDPdFKKP9rJYuQgJOkK5nb66P1D/J4dqe44H2+BmRGjw4b+vVewGnq6GC+NmRKxU+
 xhyDNvYYwpLNptUicf04P/CDGE0r2Q0WT4X1jbOxbPVK/YKDeQzE6i9zC7iZaemTHvrw
 I64ngKvKhIEn5GGHGA1+Brdks3z7ZEyp37J9735Vokroo0lFpXOIF+Rfu1Wm4DhU4z4Q
 IWxQ==
X-Gm-Message-State: AOJu0YybluCSOiidghXhV2dL1ysveMzq0pnD3MBdnhoj6N/WPAUkRrzF
 wwaiGvS/wHTzfMXQhJ4CVab+y/jdM4bO12fhno7fVF3Ig2rQ/X1oZFqE
X-Gm-Gg: Acq92OHemijqQKFNj4qNAq/KsSkJ/jGt5HhO0sEKrPSbDc4becHs3zYZNJuCiG9Xdv+
 NeuSD26EDA50Vlv9qPBVKIuCyV5pTKdLgPgzKwOu4EG+UylFhSatXo/FVQuszU0vtPopSdpvEA+
 zyPqG1Qqs53xaWNvd8irsvqekspe89xyLKV/xnqX2TCr14OIKhokm1ybjrLDOn9Hr9x2dt64HdV
 1x3cDDOapS0XQ84p0tzxvh6t8t/4oTlR6jqMhzZJkqPm1WJCUW5woEawIS4kjvFuULD8LI9O1YQ
 R/l7bIvUmORXnhxUqDc5qBCOoMfQQFMwaDTpHwJwTa2LR7h+KMc/WDKp7Anpfjnzr6FEh8Ep6Fc
 ZGxKCAcXnj0F7AOeLa5v/2zVhgykELeEUnYczty0obI1ADn8eGqHIFqSKUm54xA5ZjaIHW+zbOq
 4gdCWipgrYEMCaTg6KyBc0iQf/AAwGUVSAyS7Gf0oOQfJVpJYWEIJf0TSzfNbWBu0=
X-Received: by 2002:a05:600c:3f0a:b0:490:be1e:6ce6 with SMTP id
 5b1f17b1804b1-490d71fa51cmr52247975e9.9.1781032609422; 
 Tue, 09 Jun 2026 12:16:49 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm62218513f8f.16.2026.06.09.12.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:49 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:15 +0200
Subject: [PATCH v7 05/12] main-loop: change the handling of SIGWINCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-5-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=3291;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=F2toV5Jkz/m648aoZpamMhXSKmY5U/TELmEzMUEgOa4=;
 b=BLIuA6Itqs9hzzZWNj+YsRrrAoLUlAL2lG0jDmg/XqibM03emIxTOf2QPFVzw/djkkhmZ1hbN
 +IIQP1yEaxTARxqyQT9jM0upQO8T7aKOeM8knCziaeetKSeSSC6gBuE
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x335.google.com
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
index 24d3713e57..04feaeb390 100644
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
2.54.0


