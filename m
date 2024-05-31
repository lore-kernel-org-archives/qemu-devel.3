Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B23CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 21:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD9fo-0006vU-Vp; Fri, 31 May 2024 17:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PQ5aZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sD6Q5-0007f5-SJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:52:01 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PQ5aZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sD6Q3-0000PO-Ry
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:52:01 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-6658175f9d4so2220835a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717177918; x=1717782718; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2vX1Xo5qzCmhtSaFeLVNwS3lQHCjtkEO53EeOrUQ9/g=;
 b=p4iQnaccH7Ux+acv/qAhebcAOQUt69hNPGuCYRzBK14GZTk3K7qRTjjQsF5pNHg2RC
 YGhz65akq6zB2AVmqn8HatXS0SvAMaC/yMsMBGUN5Yaxoe1E1SMaHQMb+rs4wzd1z+tB
 avErdl53EDX/slLp+QJ48BoSk8eBWxiz2JA52W0sOPWRu5DaD34o77E8jqGla4tsdpvs
 emqqY2lVc8pOAmMy/T2iA8KSHQGChHE9YjTCzLqcRCD4xX/bjhMMd5DVWtkvYdL8c0aQ
 THIt2RNpTailaAbNrRnKrW1Iajzx35eue46vghQiix59WjDbiCcl8BwAlfmTCgwBxw0Y
 D3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177918; x=1717782718;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2vX1Xo5qzCmhtSaFeLVNwS3lQHCjtkEO53EeOrUQ9/g=;
 b=L6PDi/zWu3ve2E5H1iVb536weo2zuI3DfQW3A+ux1DBfeOTTzm9N2Bcj0tFopXspAT
 WR8XioRNJyNa+KE2ISBRYRRK2AD/YXZECjl19noLc211Sab+xzVKNAB/bh/N4kei3Xj1
 BMTZ32SWPsbyA/X+3HseaHPegM9PtkaI9aiRBJm8uv9hq9IOzzXI5NbRvzRk9rFQx/cv
 OLM2NK7yJvxIULbsML41G8wCANY8ycFSwswRyY8iC3k8r74LNtuBn+yeoKQqSgxsqt5R
 NYbYwd4E+PjeQJW7t6zxl4tGUAtoPkCmxflPF770i5WIwGrSL7g0ZLimLzA1tvhpwytV
 bezQ==
X-Gm-Message-State: AOJu0Yxd8BNpMa0WFWecU1YnAyU0jice1PRmnUH9O+HgnC9CeSi2PelC
 cEk79aPutIxIG9r2JSedZ+cdPJv6EnEXRQ9hHHCNwpp+9NGeRvTjo7l56hZVlyxovKy/oIIO5AB
 nb602LsO/B73TYzgEJFpHlO/NPGM6l4s2UvHn4FuNDg2WjWGbLdvej38iwv0r3fPIl2EpkGzaap
 Ha9VsXHOvSHtPpVB2aaYr/k6LBuw==
X-Google-Smtp-Source: AGHT+IEvfMoUMhIJ2WANbVYcgly126HmjoEIDG6d1cJg0QggKm+CN1nA1uNPFLdNiByVBsuyKYCglw1Agw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a65:6712:0:b0:6bc:b210:c1dd with
 SMTP id
 41be03b00d2f7-6c41507f678mr6965a12.8.1717177917232; Fri, 31 May 2024 10:51:57
 -0700 (PDT)
Date: Fri, 31 May 2024 10:51:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531175153.2716309-1-tavip@google.com>
Subject: [PATCH] chardev: add path option for pty backend
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 Octavian Purdila <tavip@google.com>, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3PQ5aZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 May 2024 17:20:27 -0400
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
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 chardev/char-pty.c | 34 ++++++++++++++++++++++++++++++++++
 chardev/char.c     |  5 +++++
 qapi/char.json     |  4 ++--
 qemu-options.hx    | 14 ++++++++++----
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cc2f7617fe..7cd5d34851 100644
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
@@ -354,12 +363,37 @@ static void char_pty_open(Chardev *chr,
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
+            close(master_fd);
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
index 8ca7f34ef0..5eec194242 100644
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
@@ -3808,12 +3808,16 @@ The available backends are:
 
     ``path`` specifies the name of the serial device to open.
 
-``-chardev pty,id=id``
+``-chardev pty,id=id[,path=path]``
     Create a new pseudo-terminal on the host and connect to it. ``pty``
     does not take any options.
 
     ``pty`` is not available on Windows hosts.
 
+    ``path`` specifies the symbolic link path to be created that
+    points to the pty device.
+
+
 ``-chardev stdio,id=id[,signal=on|off]``
     Connect to standard input and standard output of the QEMU process.
 
@@ -4171,8 +4175,10 @@ SRST
 
             vc:80Cx24C
 
-    ``pty``
-        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
+    ``pty[:path]``
+        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
+        Optionally a path can be given to create a symbolic link to
+        the allocated PTY.
 
     ``none``
         No device is allocated. Note that for machine types which
-- 
2.45.1.288.g0e0cd299f1-goog


