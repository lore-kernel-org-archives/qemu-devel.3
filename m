Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C02C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvjQ-0002Dz-Fo; Wed, 05 Jun 2024 14:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3q7NgZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com>)
 id 1sEvjO-0002DH-Ir
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:51:30 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3q7NgZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com>)
 id 1sEvjM-00022e-4q
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:51:30 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2c2093beba8so111367a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717613486; x=1718218286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rw16J338q1iRQjJspl1aKD/yjirgoJZEY3xjA4fyXto=;
 b=r3jhq4C8czV5DT8T+55sTvHH+Nnfksto9b1E2Hf2Fyzwfws9QB+PrRkJgM5g+nXOVo
 Z02NDcSSzK7ZYLEdMxbbZslYf6H8wLghWbCwVBJVSADsWfHELnxZ8/DJ/zMA3/yBkp+l
 uLmIUr6mQ1F19oEzGYkVANFaxhGtIkMaTY4LQfUBZY4zUOa9inmaUkXbRNTKtJm2QaSJ
 WYLircl00+CqDJDzJY6hX8KcYta1Kdmt/gFY05lIGE3PsacIbaAGomxP70vMVYnrJLY4
 1us1PBlgzDb63qEcXw001V0yA6nk/j6FKSc9bSQJpoxToafqgONL0PSOCfuGV88qrt+s
 KAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613486; x=1718218286;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw16J338q1iRQjJspl1aKD/yjirgoJZEY3xjA4fyXto=;
 b=q46Qg1ctjuRVMIXmbuywkk2qRDxPR9ETJ8iEoMU88dyzDwAmdqXnRS+KGGrjC+1Hcl
 r87iAXO7g9WuMMl3UuoO5aUiBISvAZ+LJG0bEl7FF/Teii8L4hcbMia4HQ9vYP2vb/p0
 iLw1FbrXtbOabRb/qfelvNkUC0R2vqVo2V5G3pOGf2SNM78XwuD+JBKPdfd0EV97zUEP
 qS+sHMG3y+5OLyewXX3LQFQ9b1+46JCFQTyP6NcLdCVFm3EbliAimNvnikKveaHaC37T
 A1SXuCej8mNqsEs+wsnMDJQX88cPih/ow4WxzvAnKW7bZyIEUV+mwnvlT2Uk2wdl+tGa
 cMXg==
X-Gm-Message-State: AOJu0Yw8Zoa8kLPdqQ7yPlyMt6eDhswcNc8uHjxgU7kuLo0QoZ7E4v6c
 YodyEwp9lcTbXvdAOjulVn6ADaChpndvcFxI8AkVPRGhu/wwNHQRYalvEICBTYxTYH78YiN3V/X
 Av8N9rgvVg3fAV2jmdnvc6/N8K/ZtpS9WKTiqCPFvMKM8B8KSF9uk9tWn8J9sxdAv3b73aZNGvn
 CX/VxGSzCxRHUrqeAsXBJ7KhqEqg==
X-Google-Smtp-Source: AGHT+IEgV+qObZis44oi0x8WfsHhh7M5Ee22T/I/bVbP8LecOOfq3wDtC0IStLUjE/fGUi9ImOR/iuBFBw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90a:5403:b0:2c0:1fe6:b10c
 with SMTP id
 98e67ed59e1d1-2c27daf5182mr8612a91.1.1717613483669; Wed, 05 Jun 2024 11:51:23
 -0700 (PDT)
Date: Wed,  5 Jun 2024 11:50:50 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605185050.1678102-1-tavip@google.com>
Subject: [PATCH v3] chardev: add path option for pty backend
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, 
 Octavian Purdila <tavip@google.com>, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3q7NgZgUKCs4DuF2908805y.w86Ay6E-xyFy578707E.8B0@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.c=
om/

Tested with the following invocations that the link is created and
removed when qemu stops:

  qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
  -chardev pty,path=3Dtest,id=3Dcompat_monitor0

  qemu-system-x86_64 -nodefaults -monitor pty:test

Also tested that when a link path is not passed invocations still work, e.g=
.:

  qemu-system-x86_64 -monitor pty

Co-authored-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
[OP: rebase and address original patch review comments]
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
Changes since v2:

 * remove NULL path check, g_strdup() allows NULL inputs =20

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
index cc2f7617fe..5c6172ddba 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
 #include "qemu/qemu-print.h"
=20
 #include "chardev/char-io.h"
@@ -41,6 +42,7 @@ struct PtyChardev {
=20
     int connected;
     GSource *timer_src;
+    char *symlink_path;
 };
 typedef struct PtyChardev PtyChardev;
=20
@@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
     Chardev *chr =3D CHARDEV(obj);
     PtyChardev *s =3D PTY_CHARDEV(obj);
=20
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
+    char *symlink_path =3D backend->u.pty.data->device;
=20
     master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
@@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
     g_free(name);
     s->timer_src =3D NULL;
     *be_opened =3D false;
+
+    /* create symbolic link */
+    if (symlink_path) {
+        int res =3D symlink(pty_name, symlink_path);
+
+        if (res !=3D 0) {
+            error_setg_errno(errp, errno, "Failed to create PTY symlink");
+        } else {
+            s->symlink_path =3D g_strdup(symlink_path);
+        }
+    }
+}
+
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                           Error **errp)
+{
+    const char *path =3D qemu_opt_get(opts, "path");
+    ChardevHostdev *dev;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
+    dev =3D backend->u.pty.data =3D g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
+    dev->device =3D g_strdup(path);
 }
=20
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
+    cc->parse =3D char_pty_parse;
     cc->open =3D char_pty_open;
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
diff --git a/chardev/char.c b/chardev/char.c
index 3c43fb1278..404c6b8a4f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, con=
st char *filename,
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
     "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
     "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
 #else
-    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|=
off]\n"
+    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH][,l=
ogappend=3Don|off]\n"
     "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3DPA=
TH][,logappend=3Don|off]\n"
 #endif
 #ifdef CONFIG_BRLAPI
@@ -3808,12 +3808,18 @@ The available backends are:
=20
     ``path`` specifies the name of the serial device to open.
=20
-``-chardev pty,id=3Did``
-    Create a new pseudo-terminal on the host and connect to it. ``pty``
-    does not take any options.
+``-chardev pty,id=3Did[,path=3Dpath]``
+    Create a new pseudo-terminal on the host and connect to it.
=20
     ``pty`` is not available on Windows hosts.
=20
+    If ``path`` is specified, QEMU will create a symbolic link at
+    that location which points to the new PTY device.
+
+    This avoids having to make QMP or HMP monitor queries to find out
+    what the new PTY device path is.
+
+
 ``-chardev stdio,id=3Did[,signal=3Don|off]``
     Connect to standard input and standard output of the QEMU process.
=20
@@ -4171,8 +4177,14 @@ SRST
=20
             vc:80Cx24C
=20
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
=20
     ``none``
         No device is allocated. Note that for machine types which
--=20
2.45.1.467.gbab1589fc0-goog


