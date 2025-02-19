Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1607C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpbz-00033j-Ty; Wed, 19 Feb 2025 14:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tkpbx-000330-DJ; Wed, 19 Feb 2025 14:19:57 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tkpbt-0001rQ-Ih; Wed, 19 Feb 2025 14:19:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a1f:0:640:483e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6127F60E66;
 Wed, 19 Feb 2025 22:19:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:15::1:1c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FJcUR80IfGk0-CEFKZB0s; Wed, 19 Feb 2025 22:19:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739992779;
 bh=+QzzFMdVAU7BFU7mGK97qGFy6y3Sr7ek3VwaCSDm5YY=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=vzmgdBuOibEIbj7YDu3Ox+lgtfB5CvNurSLiRB857wSTJZoOKwpTHZJ+X+CLHorTC
 oikzvvQ9nw4gSlXrsBGXNZo9n26PAuNwHr4jscPOdUW0miZSGq60OXbVAenWK5zBlL
 eckHc9TPSifcnqO/RV8K+oHBR1NwnOCm2AXOzD50=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, vsementsov@yandex-team.ru,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v2] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
Date: Wed, 19 Feb 2025 22:19:14 +0300
Message-ID: <20250219191914.440451-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Instead of comment
"Keep this type consistent with the nbd-server-start arguments", we
can simply merge these things.

Note that each field of new base already has "since" tag, equal in both
original copies. So "since" information is saved.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v2: rebase on master, and improve docummentation handling

 blockdev-nbd.c         |  4 +--
 qapi/block-export.json | 72 ++++++++++++++++++------------------------
 2 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 3f6f4ef92b..1e3e634b87 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -219,12 +219,12 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
                      arg->tls_authz, arg->max_connections, errp);
 }
 
-void qmp_nbd_server_start(SocketAddressLegacy *addr,
-                          bool has_handshake_max_secs,
+void qmp_nbd_server_start(bool has_handshake_max_secs,
                           uint32_t handshake_max_secs,
                           const char *tls_creds,
                           const char *tls_authz,
                           bool has_max_connections, uint32_t max_connections,
+                          SocketAddressLegacy *addr,
                           Error **errp)
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 68dcec7edc..c783e01a53 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -9,17 +9,11 @@
 { 'include': 'block-core.json' }
 
 ##
-# @NbdServerOptions:
-#
-# Keep this type consistent with the nbd-server-start arguments.  The
-# only intended difference is using SocketAddress instead of
-# SocketAddressLegacy.
-#
-# @addr: Address on which to listen.
+# @NbdServerOptionsBase:
 #
 # @handshake-max-seconds: Time limit, in seconds, at which a client
 #     that has not completed the negotiation handshake will be
-#     disconnected, 0 for no limit (since 10.0; default: 10).
+#     disconnected, or 0 for no limit (since 10.0; default: 10).
 #
 # @tls-creds: ID of the TLS credentials object (since 2.6).
 #
@@ -32,47 +26,47 @@
 # @max-connections: The maximum number of connections to allow at the
 #     same time, 0 for unlimited.  Setting this to 1 also stops the
 #     server from advertising multiple client support (since 5.2;
-#     default: 100)
-#
-# Since: 4.2
+#     default: 100).
 ##
-{ 'struct': 'NbdServerOptions',
-  'data': { 'addr': 'SocketAddress',
-            '*handshake-max-seconds': 'uint32',
+{ 'struct': 'NbdServerOptionsBase',
+  'data': { '*handshake-max-seconds': 'uint32',
             '*tls-creds': 'str',
             '*tls-authz': 'str',
             '*max-connections': 'uint32' } }
 
 ##
-# @nbd-server-start:
+# @NbdServerOptions:
 #
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using @nbd-server-add.  The NBD server
-# will present them as named exports; for example, another QEMU
-# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
+# Keep this type consistent with the NbdServerOptionsLegacy type.  The
+# only intended difference is using SocketAddress instead of
+# SocketAddressLegacy.
+#
+# @addr: Address on which to listen (since 4.2).
+##
+{ 'struct': 'NbdServerOptions',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddress' } }
+
+##
+# @NbdServerOptionsLegacy:
 #
 # Keep this type consistent with the NbdServerOptions type.  The only
 # intended difference is using SocketAddressLegacy instead of
 # SocketAddress.
 #
-# @addr: Address on which to listen.
-#
-# @handshake-max-seconds: Time limit, in seconds, at which a client
-#     that has not completed the negotiation handshake will be
-#     disconnected, or 0 for no limit (since 10.0; default: 10).
-#
-# @tls-creds: ID of the TLS credentials object (since 2.6).
-#
-# @tls-authz: ID of the QAuthZ authorization object used to validate
-#     the client's x509 distinguished name.  This object is is only
-#     resolved at time of use, so can be deleted and recreated on the
-#     fly while the NBD server is active.  If missing, it will default
-#     to denying access (since 4.0).
+# @addr: Address on which to listen (since 1.3).
+##
+{ 'struct': 'NbdServerOptionsLegacy',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddressLegacy' } }
+
+##
+# @nbd-server-start:
 #
-# @max-connections: The maximum number of connections to allow at the
-#     same time, 0 for unlimited.  Setting this to 1 also stops the
-#     server from advertising multiple client support (since 5.2;
-#     default: 100).
+# Start an NBD server listening on the given host and port.  Block
+# devices can then be exported using @nbd-server-add.  The NBD server
+# will present them as named exports; for example, another QEMU
+# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
 #
 # Errors:
 #     - if the server is already running
@@ -80,11 +74,7 @@
 # Since: 1.3
 ##
 { 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*handshake-max-seconds': 'uint32',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str',
-            '*max-connections': 'uint32' },
+  'data': 'NbdServerOptionsLegacy',
   'allow-preconfig': true }
 
 ##
-- 
2.48.1


