Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62491C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukOFk-0007Zu-B3; Fri, 08 Aug 2025 10:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ukOFc-0007ES-Ic
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:39:23 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ukOFa-0004eT-AJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:39:20 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-55ba26abd62so2492066e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754663954; x=1755268754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ny/qF1Omn1AISxU4yIwudednICrDn3cNU1oxD+SbCwE=;
 b=bpvY2YXpueuJq1XNvwCwUg8XnKvpmIsImhcFXd409yA+jrzlpeV7NJm6JNkfXkg/j/
 DxSgGW+ghqBVO5ElY0G9kCGWJBvFRpQdgJ7QJXu08WYRMSCtgLili3ZXO/fxWxfdQZI7
 wiaQaD1HSxNqsGPkMrbCb9r2DnF7dWwfJw56PbZMJiABwTd4+2ZrxVXbV0PjcWPn8HmG
 Bh7GXuk1Myf43npEFV2w6vfWI36zFZTIxfxAM+P1fJ7aaXNCs06VEP0E3pmcRL+II2Lk
 k7qEnPvPk3Zr7z0OUcHpt9Qq7jQUWoeRRUQYE4W6F4F6vAJvw4acBlChM5mQT0wXGH4h
 QGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754663954; x=1755268754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ny/qF1Omn1AISxU4yIwudednICrDn3cNU1oxD+SbCwE=;
 b=Ixo08Jo2WZUJb6nBTsoLgj2FhoDygXbtyiYtiiekbsevhCpG/hM5S4/PhXRc4+e85I
 k4OBODLJRDxorngex1wSupNNK4jSCMLKjjDECqIXJKFOvTFtLKpNqdiL4fCwO1TVL4bP
 j9U3pbisht5zk7QieH3Mpjom7uTbJ59f1sjviEHjSD2fV5lHyDLpJuvw5ELE4cO9pm8/
 hBc1DYbiWjpEPHIHf//aPnwI6PcHnGJ0mJctmaP9Le3gkyntS4VGjax+ARLDwD0RNIVG
 +ACS76YH5Q1fD+mVuyHbP5Nx4Z1zQaJr6A+4nCwUcyCnJzZ9L3osmygcxm1ygDk76rkl
 w0kQ==
X-Gm-Message-State: AOJu0Yzhz+W1Cr2BvfdG4HcYWc5bsiK/ePTsMM1KO0rEdz1FJZUXVN0s
 qCOxSKwdNbKcCNWc0NOHpzLOSJQB1H/fpO30jldTerTNzhm6KPk66XBiizUprSTzwQA=
X-Gm-Gg: ASbGnctRir16hZOgTVXfGw9HOEXn73NnR0Ntl5P50GFBcdCoV5oC1O9uC0cpKjqYCOj
 VyCcexYrCa+oip8ogy8gw2R8vnq6zM4+k4aqf+mt69ZNbxiJ6w8absfc40SOsos1ekeGeXamUXC
 X0PzYfrpVK8r4UMjesL/AfY4nwMRM9Dw+eFS6Sk/fT9ZeyqU0AslFnEMGq6xBP52oD9PjdOsDhr
 pcMUFhX19fPQEwfIcoLnxgvnMKewyamfbZiyBe63y0zM9v9cs9ignj9El48f7kBAakCL7BZYCbF
 REgooOweZViH9fG77T8ieBydL4gfo0Qt0zS/mnS446xMRh7Yk1obQq38Lqy1EBd1HMw7DlfLya5
 SU60Fcfwmh9j8ACzh1ROLYjgtXFrKdUeObpZIrazPpsuRQhF26Xn1zYKJ
X-Google-Smtp-Source: AGHT+IFxAcICAmKzeM1dhV+92TSmpbccnnxdyPJvIaNdbK1+h4WyZcLiCPFHFBej84X1SVp+cPUo2w==
X-Received: by 2002:a05:6512:124f:b0:55b:9388:f140 with SMTP id
 2adb3069b0e04-55cc014c860mr936251e87.50.1754663953620; 
 Fri, 08 Aug 2025 07:39:13 -0700 (PDT)
Received: from MURLOC (l37-193-36-68.novotelecom.ru. [37.193.36.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b88cabb67sm3143736e87.152.2025.08.08.07.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 07:39:13 -0700 (PDT)
From: Viktor Kurilko <murlockkinght@gmail.com>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org,
	Viktor Kurilko <murlockkinght@gmail.com>
Subject: [PATCH v5] Add a feature for mapping a host unix socket to a guest
 tcp socket
Date: Fri,  8 Aug 2025 21:29:25 +0700
Message-ID: <20250808143904.363907-1-murlockkinght@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=murlockkinght@gmail.com; helo=mail-lf1-x12d.google.com
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

This patch adds the ability to map a host unix socket to a guest tcp socket when
using the slirp backend. This feature was added in libslirp version 4.7.0.

A new syntax for unix socket: -hostfwd=unix:hostpath-[guestaddr]:guestport

Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
---
Separator parsing has been moved to protocol-specific blocks.
Fixed overwriting of sin_addr.
`
 docs/system/devices/net.rst |   2 +-
 hmp-commands.hx             |   4 +-
 net/slirp.c                 | 110 +++++++++++++++++++++++++++---------
 qapi/net.json               |   2 +-
 qemu-options.hx             |  11 +++-
 5 files changed, 97 insertions(+), 32 deletions(-)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 7d76fe88c4..13199a44fd 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -79,7 +79,7 @@ those sockets. To allow ping for GID 100 (usually users group)::
 
 When using the built-in TFTP server, the router is also the TFTP server.
 
-When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
+When using the ``'-netdev user,hostfwd=...'`` option, TCP, UDP or UNIX
 connections can be redirected from the host to the guest. It allows for
 example to redirect X11, telnet or SSH connections.
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index d0e4f35a30..64a463b15b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1357,8 +1357,8 @@ ERST
     {
         .name       = "hostfwd_add",
         .args_type  = "arg1:s,arg2:s?",
-        .params     = "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport",
-        .help       = "redirect TCP or UDP connections from host to guest (requires -net user)",
+        .params     = "[netdev_id] [tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport",
+        .help       = "redirect TCP, UDP or UNIX connections from host to guest (requires -net user)",
         .cmd        = hmp_hostfwd_add,
     },
 #endif
diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..1b5e67f9d1 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -795,12 +795,13 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
-    struct sockaddr_in host_addr = {
-        .sin_family = AF_INET,
-        .sin_addr = {
-            .s_addr = INADDR_ANY,
-        },
-    };
+    union {
+        struct sockaddr_in in;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+        struct sockaddr_un un;
+#endif
+    } host_addr = {0};
+
     struct sockaddr_in guest_addr = {
         .sin_family = AF_INET,
         .sin_addr = {
@@ -811,9 +812,13 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     int host_port, guest_port;
     const char *p;
     char buf[256];
-    int is_udp;
+    int is_udp = 0;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    int is_unix = 0;
+#endif
     const char *end;
     const char *fail_reason = "Unknown reason";
+    socklen_t host_addr_size;
 
     p = redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
@@ -824,30 +829,83 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         is_udp = 0;
     } else if (!strcmp(buf, "udp")) {
         is_udp = 1;
-    } else {
-        fail_reason = "Bad protocol name";
-        goto fail_syntax;
     }
-
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
-        fail_reason = "Missing : separator";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    else if (!strcmp(buf, "unix")) {
+        is_unix = 1;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
-        fail_reason = "Bad host address";
+#endif
+    else {
+        fail_reason = "Bad protocol name";
         goto fail_syntax;
     }
 
-    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
-        fail_reason = "Bad host port separator";
-        goto fail_syntax;
-    }
-    err = qemu_strtoi(buf, &end, 0, &host_port);
-    if (err || host_port < 0 || host_port > 65535) {
-        fail_reason = "Bad host port";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    if (is_unix) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+            fail_reason = "Missing - separator";
+            goto fail_syntax;
+        }
+        if (buf[0] == '\0') {
+            fail_reason = "Missing unix socket path";
+            goto fail_syntax;
+        }
+        if (buf[0] != '/') {
+            fail_reason = "unix socket path must be absolute";
+            goto fail_syntax;
+        }
+
+        size_t path_len = strlen(buf);
+        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
+            fail_reason = "Unix socket path is too long";
+            goto fail_syntax;
+        }
+
+        struct stat st;
+        if (stat(buf, &st) == 0) {
+            if (!S_ISSOCK(st.st_mode)) {
+                fail_reason = "file exists and it's not unix socket";
+                goto fail_syntax;
+            }
+
+            if (unlink(buf) < 0) {
+                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
+                goto fail_syntax;
+            }
+        }
+        host_addr.un.sun_family = AF_UNIX;
+        memcpy(host_addr.un.sun_path, buf, path_len);
+        host_addr_size = sizeof(host_addr.un);
+    } else
+#endif
+    {
+        host_addr.in.sin_family = AF_INET;
+        host_addr.in.sin_addr.s_addr = INADDR_ANY;
+
+        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+            fail_reason = "Missing : separator";
+            goto fail_syntax;
+        }
+
+        if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {
+            fail_reason = "Bad host address";
+            goto fail_syntax;
+        }
+
+        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+            fail_reason = "Bad host port separator";
+            goto fail_syntax;
+        }
+
+        err = qemu_strtoi(buf, &end, 0, &host_port);
+        if (err || host_port < 0 || host_port > 65535) {
+            fail_reason = "Bad host port";
+            goto fail_syntax;
+        }
+
+        host_addr.in.sin_port = htons(host_port);
+        host_addr_size = sizeof(host_addr.in);
     }
-    host_addr.sin_port = htons(host_port);
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         fail_reason = "Missing guest address";
@@ -867,7 +925,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..60d196afe5 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -281,7 +281,7 @@
 #
 # @smbserver: IP address of the built-in SMB server
 #
-# @hostfwd: redirect incoming TCP or UDP host connections to guest
+# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to guest
 #     endpoints
 #
 # @guestfwd: forward guest TCP connections
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..86a70e0315 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3317,8 +3317,8 @@ SRST
 
         Note that a SAMBA server must be installed on the host OS.
 
-    ``hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
-        Redirect incoming TCP or UDP connections to the host port
+    ``hostfwd=[tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport``
+        Redirect incoming TCP, UDP or UNIX connections to the host port
         hostport to the guest IP address guestaddr on guest port
         guestport. If guestaddr is not specified, its value is x.x.x.15
         (default first address given by the built-in DHCP server). By
@@ -3348,6 +3348,13 @@ SRST
         Then when you use on the host ``telnet localhost 5555``, you
         connect to the guest telnet server.
 
+        To redirect host unix socket /tmp/vm to guest tcp socket 23 use
+        following:
+
+        .. parsed-literal::
+            # on the host
+            |qemu_system| -nic user,hostfwd=unix:/tmp/vm-:23
+
     ``guestfwd=[tcp]:server:port-dev``; \ ``guestfwd=[tcp]:server:port-cmd:command``
         Forward guest TCP connections to the IP address server on port
         port to the character device dev or to a program executed by
-- 
2.50.1


