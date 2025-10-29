Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B026CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE24T-0004La-PI; Wed, 29 Oct 2025 05:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24O-0004JE-KH; Wed, 29 Oct 2025 05:02:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE24F-00032S-Bu; Wed, 29 Oct 2025 05:02:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7CAE163E5F;
 Wed, 29 Oct 2025 12:01:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D11D93084A6;
 Wed, 29 Oct 2025 12:01:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/7] net/stream: remove deprecated 'reconnect' option
Date: Wed, 29 Oct 2025 12:01:40 +0300
Message-ID: <20251029090148.648212-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029090148.648212-1-mjt@tls.msk.ru>
References: <20251029090148.648212-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

It was deprecated in 9.2, time to remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/deprecated.rst       |  9 ---------
 docs/about/removed-features.rst | 10 ++++++++++
 net/stream.c                    | 20 +++++---------------
 qapi/net.json                   | 13 +------------
 4 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index aff3f13163..bd86c036fb 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -469,15 +469,6 @@ Backend ``memory`` (since 9.0)
 ``memory`` is a deprecated synonym for ``ringbuf``.
 
 
-Net device options
-''''''''''''''''''
-
-Stream ``reconnect`` (since 9.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``reconnect`` option only allows specifying second granularity timeouts,
-which is not enough for all types of use cases, use ``reconnect-ms`` instead.
-
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 269f6bb654..88ea0dc4ed 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1379,4 +1379,14 @@ Character device options
 The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
 better precision.
 
+Net device options
+''''''''''''''''''
+
+Stream ``reconnect`` (removed in 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` has been replaced by ``reconnect-ms``, which provides
+better precision.
+
+
 .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
diff --git a/net/stream.c b/net/stream.c
index 94f823a2a7..ea83f4a763 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -274,23 +274,13 @@ int net_init_stream(const Netdev *netdev, const char *name,
     sock = &netdev->u.stream;
 
     if (!sock->has_server || !sock->server) {
-        uint32_t reconnect_ms = 0;
-
-        if (sock->has_reconnect && sock->has_reconnect_ms) {
-            error_setg(errp, "'reconnect' and 'reconnect-ms' are mutually "
-                             "exclusive");
-            return -1;
-        } else if (sock->has_reconnect_ms) {
-            reconnect_ms = sock->reconnect_ms;
-        } else if (sock->has_reconnect) {
-            reconnect_ms = sock->reconnect * 1000u;
-        }
-
         return net_stream_client_init(peer, "stream", name, sock->addr,
-                                      reconnect_ms, errp);
+                                      sock->has_reconnect_ms ?
+                                          sock->reconnect_ms : 0,
+                                      errp);
     }
-    if (sock->has_reconnect || sock->has_reconnect_ms) {
-        error_setg(errp, "'reconnect' and 'reconnect-ms' options are "
+    if (sock->has_reconnect_ms) {
+        error_setg(errp, "'reconnect-ms' option is "
                          "incompatible with socket in server mode");
         return -1;
     }
diff --git a/qapi/net.json b/qapi/net.json
index 60d196afe5..7f62f8cc39 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -770,29 +770,18 @@
 #
 # @server: create server socket (default: false)
 #
-# @reconnect: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of seconds.  Setting
-#     this to zero disables this function.  (default: 0) (since 8.0)
-#
 # @reconnect-ms: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of milliseconds.  Setting
-#     this to zero disables this function.  This member is mutually
-#     exclusive with @reconnect.  (default: 0) (Since: 9.2)
+#     this to zero disables this function.  (default: 0) (Since: 9.2)
 #
 # Only `SocketAddress` types 'unix', 'inet' and 'fd' are supported.
 #
-# Features:
-#
-# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
-#     instead.
-#
 # Since: 7.2
 ##
 { 'struct': 'NetdevStreamOptions',
   'data': {
     'addr':   'SocketAddress',
     '*server': 'bool',
-    '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
     '*reconnect-ms': 'int' } }
 
 ##
-- 
2.47.3


