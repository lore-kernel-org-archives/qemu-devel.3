Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCE9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8gF-00085N-8r; Mon, 05 Aug 2024 21:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZnexZgUKClcIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sb8g9-00084G-Ny
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 21:07:57 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZnexZgUKClcIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sb8g7-0005IQ-E3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 21:07:57 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-7163489149fso272446a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 18:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722906471; x=1723511271; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YKDqBEkcEgbwXXYQYGSpBK/+edTF0cuks2Y9pNIpECw=;
 b=iZMkmoPx0DwNay5FzSTzaLH8JwO3WIUe0n7E7ZETndS3xhxKAvDGhm9LNScNwecNbo
 3fqBw5YgTBfkjlJ9/iO4MTR5r+hFUxb4FlmFaqQBR+2Gu3XibOzW3al0VGEgbADmg+r6
 ATO2sF8LUPt5UlolPzkp0x8ijTIPJC+NV1Z9UFrQJd5dxzluOWRB9Hbchjxzx5gKbWyn
 QflLVgIkntwtDlMrMH9ZgLacTiB2tnu0kZdZhZD4yHdk8YO1SGip89FcZ6YLBIYIg5z2
 GU+mqvr6VrDeXAnteF1sE1Jf7xCF/c0mNqCDPefMRhsp0oTba2VO+kbzVWL89cUV3EIo
 8Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722906471; x=1723511271;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YKDqBEkcEgbwXXYQYGSpBK/+edTF0cuks2Y9pNIpECw=;
 b=c9s5gypV+hPsDrYUfiCYYNvjKlycU8CpEbn0zVPtILwCuL+raJAjg5RSKNVJgMgWHu
 aY4KEO0nl5boOXOykkk2yyhMpnIeLwH12Lmwmt1cIu8v27+W2CxXnwJ7955fJyAgXNrE
 rlPrS9upheSOzJFKQXwNzcDbslkjqFgs7WptC8YwCUr8Aigmwrp8C6zE6kdgxaBMa688
 ChhVDQTky13vF0lRpDshMzWIWzIZM25y+zY+5SCdoKLhYR0Eehx5j12vx7+11fyVq0tX
 2Yf3uKtJW2q31IBHMW8AqEpn/5i5DgnBnXQoGJ6AwvL5plQBmANCyHUP1jLDRaHyopxv
 FrDw==
X-Gm-Message-State: AOJu0YxOCFwMgyXXXIwydTASPn1bBlFKLkxtNyvKgPyyHG63rRsjIui2
 80uLkPHiStETdNPGul9Zvgw+X7m2H2kk8kOnoEopMggBgjAvblFNR+wTYXk7x/uOfzuMv/EmmWM
 p49dYdw0Opu4q4FvM/dAZyMrZjJXnlNsDwpiQo7CYvq/vD200jGL6H51G6B/K9AgOOtaszH+r79
 VK0B73PZIxwZgT9h/tSmFHxdbEaQ==
X-Google-Smtp-Source: AGHT+IH6xE0e4hsgRn/vQs8w/ReU/gNeeMjHTB8IuUXEwjD3KMu9rMytsMJ/MeOhGQmXhtYaupFGQ51QyA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a63:6d47:0:b0:675:12f2:dca9 with
 SMTP id
 41be03b00d2f7-7b74679e34fmr24876a12.1.1722906470700; Mon, 05 Aug 2024
 18:07:50 -0700 (PDT)
Date: Mon,  5 Aug 2024 18:07:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806010735.2450555-1-tavip@google.com>
Subject: [PATCH v4] chardev: add path option for pty backend
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, 
 Octavian Purdila <tavip@google.com>, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3ZnexZgUKClcIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add path option to the pty char backend which will create a symbolic
link to the given path that points to the allocated PTY.

This avoids having to make QMP or HMP monitor queries to find out what
the new PTY device path is.

Based on patch from Paulo Neves:

https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/

Tested with the following invocations that the link is created and
removed when qemu stops:

  qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
  -chardev pty,path=test,id=compat_monitor0

  qemu-system-x86_64 -nodefaults -monitor pty:test

  # check QMP invocation with path set
  qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=on,wait=off
  nc localhost 4444
  > {"execute": "qmp_capabilities"}
  > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
      "type": "pty", "data": {"path": "test" }}}}

  # check QMP invocation with path not set
  qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=on,wait=off
  nc localhost 4444
  > {"execute": "qmp_capabilities"}
  > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
      "type": "pty", "data": {}}}}

Also tested that when a link path is not passed invocations still work, e.g.:

  qemu-system-x86_64 -monitor pty

Co-authored-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
[OP: rebase and address original patch review comments]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
Changes since v3:

  * update documentation with note about user's resposability to check
    and remove the symlink since it can't be removed on crashes or
    certain startup errors

  * use a dedicated ChardevPty structure instead of relying on
    ChardevHostdev

Changes since v2:

 * remove NULL path check, g_strdup() allows NULL inputs 

Changes since v1:

 * Keep the original Signed-off-by from Paulo and add one line
    description with further changes

 * Update commit message with justification for why the new
    functionality is useful

 * Don't close master_fd when symlink creation fails to avoid double
    close

 * Update documentation for clarity
 
 chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
 chardev/char.c     |  5 +++++
 qapi/char.json     | 27 ++++++++++++++++++++++++++-
 qemu-options.hx    | 33 +++++++++++++++++++++++++++------
 4 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cc2f7617fe..cbb21b76ae 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/qemu-print.h"
 
 #include "chardev/char-io.h"
@@ -41,6 +42,7 @@ struct PtyChardev {
 
     int connected;
     GSource *timer_src;
+    char *path;
 };
 typedef struct PtyChardev PtyChardev;
 
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
     Chardev *chr = CHARDEV(obj);
     PtyChardev *s = PTY_CHARDEV(obj);
 
+    /* unlink symlink */
+    if (s->path) {
+        unlink(s->path);
+        g_free(s->path);
+    }
+
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
@@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
     int master_fd, slave_fd;
     char pty_name[PATH_MAX];
     char *name;
+    char *path = backend->u.pty.data->path;
 
     master_fd = qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
@@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
     g_free(name);
     s->timer_src = NULL;
     *be_opened = false;
+
+    /* create symbolic link */
+    if (path) {
+        int res = symlink(pty_name, path);
+
+        if (res != 0) {
+            error_setg_errno(errp, errno, "Failed to create PTY symlink");
+        } else {
+            s->path = g_strdup(path);
+        }
+    }
+}
+
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
+{
+    const char *path = qemu_opt_get(opts, "path");
+    ChardevPty *pty;
+
+    backend->type = CHARDEV_BACKEND_KIND_PTY;
+    pty = backend->u.pty.data = g_new0(ChardevPty, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevPty_base(pty));
+    pty->path = g_strdup(path);
 }
 
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
+    cc->parse = char_pty_parse;
     cc->open = char_pty_open;
     cc->chr_write = char_pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
diff --git a/chardev/char.c b/chardev/char.c
index 3c43fb1278..404c6b8a4f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
         qemu_opt_set(opts, "path", p, &error_abort);
         return opts;
     }
+    if (strstart(filename, "pty:", &p)) {
+        qemu_opt_set(opts, "backend", "pty", &error_abort);
+        qemu_opt_set(opts, "path", p, &error_abort);
+        return opts;
+    }
     if (strstart(filename, "tcp:", &p) ||
         strstart(filename, "telnet:", &p) ||
         strstart(filename, "tn3270:", &p) ||
diff --git a/qapi/char.json b/qapi/char.json
index 777dde55d9..953d519066 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -431,6 +431,20 @@
   'base': 'ChardevCommon',
   'if': 'CONFIG_SPICE_PROTOCOL' }
 
+##
+# @ChardevPty:
+#
+# Configuration info for pty implementation.
+#
+# @path: optional path to create a symbolic link that points to the
+#     allocated PTY
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevPty',
+  'data': { '*path': 'str' },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevBackendKind:
 #
@@ -630,6 +644,17 @@
 { 'struct': 'ChardevRingbufWrapper',
   'data': { 'data': 'ChardevRingbuf' } }
 
+
+##
+# @ChardevPtyWrapper:
+#
+# @data: Configuration info for pty chardevs
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevPtyWrapper',
+  'data': { 'data': 'ChardevPty' } }
+
 ##
 # @ChardevBackend:
 #
@@ -650,7 +675,7 @@
             'pipe': 'ChardevHostdevWrapper',
             'socket': 'ChardevSocketWrapper',
             'udp': 'ChardevUdpWrapper',
-            'pty': 'ChardevCommonWrapper',
+            'pty': 'ChardevPtyWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
             'msmouse': 'ChardevCommonWrapper',
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0..08d8f8c559 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #else
-    "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #ifdef CONFIG_BRLAPI
@@ -3808,12 +3808,22 @@ The available backends are:
 
     ``path`` specifies the name of the serial device to open.
 
-``-chardev pty,id=id``
-    Create a new pseudo-terminal on the host and connect to it. ``pty``
-    does not take any options.
+``-chardev pty,id=id[,path=path]``
+    Create a new pseudo-terminal on the host and connect to it.
 
     ``pty`` is not available on Windows hosts.
 
+    If ``path`` is specified, QEMU will create a symbolic link at
+    that location which points to the new PTY device.
+
+    This avoids having to make QMP or HMP monitor queries to find out
+    what the new PTY device path is.
+
+    Note that while QEMU will remove the symlink when it exits
+    gracefully, it will not do so in case of crashes or on certain
+    startup errors. It is recommended that the user checks and removes
+    the symlink after qemu terminates to account for this.
+
 ``-chardev stdio,id=id[,signal=on|off]``
     Connect to standard input and standard output of the QEMU process.
 
@@ -4171,8 +4181,19 @@ SRST
 
             vc:80Cx24C
 
-    ``pty``
-        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
+    ``pty[:path]``
+        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
+
+        If ``path`` is specified, QEMU will create a symbolic link at
+        that location which points to the new PTY device.
+
+        This avoids having to make QMP or HMP monitor queries to find
+        out what the new PTY device path is.
+
+        Note that while QEMU will remove the symlink when it exits
+        gracefully, it will not do so in case of crashes or on certain
+        startup errors. It is recommended that the user checks and
+        removes the symlink after qemu terminates to account for this.
 
     ``none``
         No device is allocated. Note that for machine types which
-- 
2.46.0.rc2.264.g509ed76dc8-goog


