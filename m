Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A3CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 21:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEF8m-0006Wz-Vj; Mon, 03 Jun 2024 17:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JjReZgUKCkEwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sEF8l-0006WR-IR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 17:22:51 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JjReZgUKCkEwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sEF8j-0007kO-B9
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 17:22:51 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-df4da3446beso7756589276.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717449766; x=1718054566; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Lg4xUM17oschW62JzPfhAYzJugfbWUqBce9stAiuRo=;
 b=yPlwM436wr8sYWKtax78YuR7u9xOKGk6XrJSYmzo89OJUe8ote8NCNg52tBBuqkBIQ
 JxfHYivFEWElSouEy1j3l/s1fYucKl9U/p1z0Z/5SSH33EItcw7n+EEXjsgGxVXjb9py
 Gjca9mtU1jxXFpJ54Qs4zSnxAP03Fmh3KIUNzhN7hsLcH7liMrJrf0cuY5bqQWOYPWIZ
 4s18KBPIl/NhmcWeBQzbIf74kWM47tHr5T6U3MBRPfKnsqevqASchPBA4kUnjObH6i2T
 zJXdA6uiZ+TQkKpfSv3hA54v2kytX9jgMGxKpu1PPYG7SgWGditau9rCRFbf5rwzyD5Y
 9+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717449766; x=1718054566;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Lg4xUM17oschW62JzPfhAYzJugfbWUqBce9stAiuRo=;
 b=VBELlwXVoBZUQa9BV0zR0TDC9eYrHbSZLuTMITFGgrxS8eR+l4B1e+/5D50ASxm/Eh
 BdFAydQFyczyy3MCjhPin/LbXJwCkD6/FeoUnRg4yfuJVKONf7hy7/qgGRgLNrw6h5Mu
 xFBSmG4PdDX2LzHdLqyJl2W94N/EqFwR+tcM77H7nQ5pxMymD4RhAUXT6jrOBoj0XA4k
 lPJhBFvjiqj2t2m8vfpvn45gi3jSH9v4mOgKOXDdz+CPVx7+CMVmXv87KLnG9kqxNW7x
 7yXNg38uDKJHFbk2wlV3harkU07/InMHtIkdHHI0+WqOnHS8Fk4KNo4ZPnDq1R1RPOTS
 1Xmg==
X-Gm-Message-State: AOJu0YxdZyVqKS0i6N53P98z+9XPEPKMIVneB7udLEFoOW3Oinjs6PpG
 veTN5V69zDegkMOcYDk/zA2K1+Bps83tWIlPErxPLqGHzob1djyahfaD8fqZDVhEy7hj3+7dQnS
 LioTa3Yo5t6ir6pbxYNkZUwXzjbXfPbE6RLccVZ/t+jIq5z15wEeD5EUKLNVaDEafWGw9aI/JkL
 rcxtKAqG6a3ce2W0adZCy1jLwfmw==
X-Google-Smtp-Source: AGHT+IHyCWu+p9clRn9FYP9k6mmVjwhU2ESyR+xKfOc/Nxcu7XbGLqOE/J+O4lGO84hjI8kb8/lykM2aog==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:72d:b0:dfa:b3bf:b073
 with SMTP id
 3f1490d57ef6-dfab3bfb23fmr353615276.11.1717449766226; Mon, 03 Jun 2024
 14:22:46 -0700 (PDT)
Date: Mon,  3 Jun 2024 14:22:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240603212228.3878836-1-tavip@google.com>
Subject: [PATCH v2] chardev: add path option for pty backend
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, 
 Octavian Purdila <tavip@google.com>, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3JjReZgUKCkEwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Also tested that when a link path is not passed invocations still work, e.g.:

  qemu-system-x86_64 -monitor pty

Co-authored-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
[OP: rebase and address original patch review comments]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
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
 qapi/char.json     |  4 ++--
 qemu-options.hx    | 24 ++++++++++++++++++------
 4 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cc2f7617fe..b5a4eb59fc 100644
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
+    char *symlink_path;
 };
 typedef struct PtyChardev PtyChardev;
 
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
     Chardev *chr = CHARDEV(obj);
     PtyChardev *s = PTY_CHARDEV(obj);
 
+    /* unlink symlink */
+    if (s->symlink_path) {
+        unlink(s->symlink_path);
+        g_free(s->symlink_path);
+    }
+
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
@@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
     int master_fd, slave_fd;
     char pty_name[PATH_MAX];
     char *name;
+    char *symlink_path = backend->u.pty.data->device;
 
     master_fd = qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
@@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
     g_free(name);
     s->timer_src = NULL;
     *be_opened = false;
+
+    /* create symbolic link */
+    if (symlink_path) {
+        int res = symlink(pty_name, symlink_path);
+
+        if (res != 0) {
+            error_setg_errno(errp, errno, "Failed to create PTY symlink");
+        } else {
+            s->symlink_path = g_strdup(symlink_path);
+        }
+    }
+}
+
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
+{
+    const char *path = qemu_opt_get(opts, "path");
+    ChardevHostdev *dev;
+
+    backend->type = CHARDEV_BACKEND_KIND_PTY;
+    dev = backend->u.pty.data = g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
+    dev->device = path ? g_strdup(path) : NULL;
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
index 777dde55d9..4c74bfc437 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -509,7 +509,7 @@
 ##
 # @ChardevHostdevWrapper:
 #
-# @data: Configuration info for device and pipe chardevs
+# @data: Configuration info for device, pty and pipe chardevs
 #
 # Since: 1.4
 ##
@@ -650,7 +650,7 @@
             'pipe': 'ChardevHostdevWrapper',
             'socket': 'ChardevSocketWrapper',
             'udp': 'ChardevUdpWrapper',
-            'pty': 'ChardevCommonWrapper',
+            'pty': 'ChardevHostdevWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
             'msmouse': 'ChardevCommonWrapper',
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0..94ffb1a605 100644
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
@@ -3808,12 +3808,18 @@ The available backends are:
 
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
+
 ``-chardev stdio,id=id[,signal=on|off]``
     Connect to standard input and standard output of the QEMU process.
 
@@ -4171,8 +4177,14 @@ SRST
 
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
 
     ``none``
         No device is allocated. Note that for machine types which
-- 
2.45.1.288.g0e0cd299f1-goog


