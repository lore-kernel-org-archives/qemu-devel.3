Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9E0C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUQ2-0000NT-0M; Thu, 30 Jan 2025 08:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUPJ-0007dC-Br
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUPH-0000ET-C8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pshK2Ey+q4fDFoUmhnoyXLEPn/qTg5QOL7jnr+Gvu+w=;
 b=N6Z5jskF0JOiSSLr1+TRxvB1vpwqZOidS8awX4dBhIE0L3KkGL/ylyJE9JvLBBJGF/J91I
 YFeF5BpiF9WJjYGBctWpITEPW+wE9gl/D1wcJ7ywKK5jUphHMVM0algWoGLRdSi7EmvwHf
 5IZP7/X96Ut00So6/sHeRLwQPshuLLM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-gXTqlDbGPGuRDIHfAaRaoA-1; Thu,
 30 Jan 2025 08:16:29 -0500
X-MC-Unique: gXTqlDbGPGuRDIHfAaRaoA-1
X-Mimecast-MFC-AGG-ID: gXTqlDbGPGuRDIHfAaRaoA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E857719560AB; Thu, 30 Jan 2025 13:16:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 051E530001BE; Thu, 30 Jan 2025 13:16:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PULL 20/20] net/slirp: libslirp 4.9.0 compatibility
Date: Thu, 30 Jan 2025 14:15:34 +0100
Message-ID: <20250130131535.91297-21-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

Update the code in net/slirp.c to be compatible with
libslirp 4.9.0, which deprecated slirp_pollfds_fill()
and started using slirp_os_socket type for sockets
(which is a 64-bit integer on win64) for all callbacks
starting with version 6 of the interface.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20250130123253.864681-1-mjt@tls.msk.ru>
[thuth: Added some spaces to make checkpatch.pl happy]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/slirp.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 49dc62f776..97d08ed1fb 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -247,7 +247,14 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
     timer_mod(&t->timer, expire_timer);
 }
 
-static void net_slirp_register_poll_fd(int fd, void *opaque)
+#if !SLIRP_CHECK_VERSION(4, 9, 0)
+# define slirp_os_socket int
+# define slirp_pollfds_fill_socket slirp_pollfds_fill
+# define register_poll_socket register_poll_fd
+# define unregister_poll_socket unregister_poll_fd
+#endif
+
+static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     AioContext *ctxt = qemu_get_aio_context();
@@ -260,7 +267,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
 #endif
 }
 
-static void net_slirp_unregister_poll_fd(int fd, void *opaque)
+static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     if (WSAEventSelect(fd, NULL, 0) != 0) {
@@ -286,8 +293,8 @@ static const SlirpCb slirp_cb = {
 #endif
     .timer_free = net_slirp_timer_free,
     .timer_mod = net_slirp_timer_mod,
-    .register_poll_fd = net_slirp_register_poll_fd,
-    .unregister_poll_fd = net_slirp_unregister_poll_fd,
+    .register_poll_socket = net_slirp_register_poll_sock,
+    .unregister_poll_socket = net_slirp_unregister_poll_sock,
     .notify = net_slirp_notify,
 };
 
@@ -314,7 +321,7 @@ static int slirp_poll_to_gio(int events)
     return ret;
 }
 
-static int net_slirp_add_poll(int fd, int events, void *opaque)
+static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
 {
     GArray *pollfds = opaque;
     GPollFD pfd = {
@@ -363,8 +370,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
 
     switch (poll->state) {
     case MAIN_LOOP_POLL_FILL:
-        slirp_pollfds_fill(s->slirp, &poll->timeout,
-                           net_slirp_add_poll, poll->pollfds);
+        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
+                                  net_slirp_add_poll, poll->pollfds);
         break;
     case MAIN_LOOP_POLL_OK:
     case MAIN_LOOP_POLL_ERR:
@@ -629,7 +636,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
 
     s = DO_UPCAST(SlirpState, nc, nc);
 
-    cfg.version = SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
+    cfg.version =
+         SLIRP_CHECK_VERSION(4, 9, 0) ? 6 :
+         SLIRP_CHECK_VERSION(4, 7, 0) ? 4 : 1;
     cfg.restricted = restricted;
     cfg.in_enabled = ipv4;
     cfg.vnetwork = net;
-- 
2.48.1


