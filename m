Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ebo-0003aK-By; Sun, 28 Apr 2024 20:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=/G2x=MC=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1s1Ebm-0003a5-TP
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:11:02 -0400
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]
 helo=sonata.ens-lyon.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=/G2x=MC=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1s1Ebb-0007SD-Cn
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:11:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 29421A0332;
 Mon, 29 Apr 2024 02:10:47 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkMLusw6JTdX; Mon, 29 Apr 2024 02:10:47 +0200 (CEST)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr
 [83.192.234.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 9E78AA0337;
 Mon, 29 Apr 2024 02:10:46 +0200 (CEST)
Received: from samy by begin with local (Exim 4.97)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1s1EbV-000000096po-2cy3; Mon, 29 Apr 2024 02:10:45 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Nicholas Ngai <nicholas@ngai.me>, stefanha@redhat.com,
 jan.kiszka@siemens.com, thomas.weissschuh@linutronix.de,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Breno Leitao <leitao@debian.org>
Subject: [PULL 1/1] net/slirp: Use newer slirp_*_hostxfwd API
Date: Mon, 29 Apr 2024 02:10:42 +0200
Message-ID: <20240429001042.2171151-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001042.2171151-1-samuel.thibault@ens-lyon.org>
References: <20240429001042.2171151-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=/G2x=MC=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

From: Nicholas Ngai <nicholas@ngai.me>

libslirp provides a newer slirp_*_hostxfwd API meant for
address-agnostic forwarding instead of the is_udp parameter which is
limited to just TCP/UDP.

This paves the way for IPv6 and Unix socket support.

Signed-off-by: Nicholas Ngai <nicholas@ngai.me>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Breno Leitao <leitao@debian.org>
Message-Id: <20210925214820.18078-1-nicholas@ngai.me>
---
 net/slirp.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 25b49c4526..eb9a456ed4 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -718,7 +718,12 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *id)
 
 void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 {
-    struct in_addr host_addr = { .s_addr = INADDR_ANY };
+    struct sockaddr_in host_addr = {
+        .sin_family = AF_INET,
+        .sin_addr = {
+            .s_addr = INADDR_ANY,
+        },
+    };
     int host_port;
     char buf[256];
     const char *src_str, *p;
@@ -755,15 +760,21 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         goto fail_syntax;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr)) {
+    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
         goto fail_syntax;
     }
 
     if (qemu_strtoi(p, NULL, 10, &host_port)) {
         goto fail_syntax;
     }
+    host_addr.sin_port = htons(host_port);
 
-    err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr, host_port);
+#if SLIRP_CHECK_VERSION(4, 5, 0)
+    err = slirp_remove_hostxfwd(s->slirp, (struct sockaddr *) &host_addr,
+            sizeof(host_addr), is_udp ? SLIRP_HOSTFWD_UDP : 0);
+#else
+    err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr.sin_addr, host_port);
+#endif
 
     monitor_printf(mon, "host forwarding rule for %s %s\n", src_str,
                    err ? "not found" : "removed");
@@ -775,13 +786,24 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
-    struct in_addr host_addr = { .s_addr = INADDR_ANY };
-    struct in_addr guest_addr = { .s_addr = 0 };
+    struct sockaddr_in host_addr = {
+        .sin_family = AF_INET,
+        .sin_addr = {
+            .s_addr = INADDR_ANY,
+        },
+    };
+    struct sockaddr_in guest_addr = {
+        .sin_family = AF_INET,
+        .sin_addr = {
+            .s_addr = 0,
+        },
+    };
+    int err;
     int host_port, guest_port;
     const char *p;
     char buf[256];
     int is_udp;
-    char *end;
+    const char *end;
     const char *fail_reason = "Unknown reason";
 
     p = redir_str;
@@ -802,7 +824,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Missing : separator";
         goto fail_syntax;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr)) {
+    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
         fail_reason = "Bad host address";
         goto fail_syntax;
     }
@@ -811,29 +833,41 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Bad host port separator";
         goto fail_syntax;
     }
-    host_port = strtol(buf, &end, 0);
-    if (*end != '\0' || host_port < 0 || host_port > 65535) {
+    err = qemu_strtoi(buf, &end, 0, &host_port);
+    if (err || host_port < 0 || host_port > 65535) {
         fail_reason = "Bad host port";
         goto fail_syntax;
     }
+    host_addr.sin_port = htons(host_port);
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         fail_reason = "Missing guest address";
         goto fail_syntax;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &guest_addr)) {
+    if (buf[0] != '\0' && !inet_aton(buf, &guest_addr.sin_addr)) {
         fail_reason = "Bad guest address";
         goto fail_syntax;
     }
 
-    guest_port = strtol(p, &end, 0);
-    if (*end != '\0' || guest_port < 1 || guest_port > 65535) {
+    err = qemu_strtoi(p, &end, 0, &guest_port);
+    if (err || guest_port < 1 || guest_port > 65535) {
         fail_reason = "Bad guest port";
         goto fail_syntax;
     }
+    guest_addr.sin_port = htons(guest_port);
+
+#if SLIRP_CHECK_VERSION(4, 5, 0)
+    err = slirp_add_hostxfwd(s->slirp,
+            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &guest_addr, sizeof(guest_addr),
+            is_udp ? SLIRP_HOSTFWD_UDP : 0);
+#else
+    err = slirp_add_hostfwd(s->slirp, is_udp,
+            host_addr.sin_addr, host_port,
+            guest_addr.sin_addr, guest_port);
+#endif
 
-    if (slirp_add_hostfwd(s->slirp, is_udp, host_addr, host_port, guest_addr,
-                          guest_port) < 0) {
+    if (err < 0) {
         error_setg(errp, "Could not set up host forwarding rule '%s'",
                    redir_str);
         return -1;
-- 
2.43.0


