Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15010C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDoo-0007ay-8e; Wed, 12 Feb 2025 09:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiDok-0007Yf-OJ; Wed, 12 Feb 2025 09:34:22 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiDoe-0006ks-4r; Wed, 12 Feb 2025 09:34:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7e14:0:640:9fc8:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AE9E660C1C;
 Wed, 12 Feb 2025 17:34:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b51c::1:4])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXQb590Il4Y0-G5eBQcOd; Wed, 12 Feb 2025 17:34:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739370851;
 bh=Ldc30azz94cHzovhysNSozAgUt0AcCoVWKQBbPPr20g=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=ZeTUt+Os8q8T4Jf3Qef2i+mqDTfntpihxBCmulV+pbHNAHYo9aqjcabb2QmM4NirO
 RFoS1s7N+hqSF48LTrMfW4yI4cxs39MhaIphOf3Ega1BaW6JBQYA6knIxox0U8G7XY
 l/lAo6kL42c71xcZlGmiRZ/4jMKvxLHYYxG4se2E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, vsementsov@yandex-team.ru,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
Date: Wed, 12 Feb 2025 17:33:51 +0300
Message-ID: <20250212143351.274931-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Instead of comment
"Keep this type consistent with the nbd-server-start arguments", we
can simply merge these things.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

No problem for me to rebase on top of
[PATCH 0/2] nbd: Allow debugging tuning of handshake limit
if it goes earlier.

Also, not that order of nbd-server-start is changed. I think the order
could not be a contract of JSON interface.

We could instead of making common base structure go another way
and define two structures with same data=NbdServerOptionsCommon, and
different bases (will have to define additional base strucutres with
SocketAddress and SocketAddressLegacy fields). But it would look a bit
unusual in QAPI.

 blockdev-nbd.c         |  4 +--
 qapi/block-export.json | 57 ++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 9e61fbaf2b..b0b8993a1b 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -215,10 +215,10 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
                      arg->max_connections, errp);
 }
 
-void qmp_nbd_server_start(SocketAddressLegacy *addr,
-                          const char *tls_creds,
+void qmp_nbd_server_start(const char *tls_creds,
                           const char *tls_authz,
                           bool has_max_connections, uint32_t max_connections,
+                          SocketAddressLegacy *addr,
                           Error **errp)
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 117b05d13c..5eb94213db 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -9,13 +9,7 @@
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
 # @tls-creds: ID of the TLS credentials object (since 2.6).
 #
@@ -30,14 +24,35 @@
 #     server from advertising multiple client support (since 5.2;
 #     default: 100)
 #
-# Since: 4.2
+# Since: 10.0
 ##
-{ 'struct': 'NbdServerOptions',
-  'data': { 'addr': 'SocketAddress',
-            '*tls-creds': 'str',
+{ 'struct': 'NbdServerOptionsBase',
+  'data': { '*tls-creds': 'str',
             '*tls-authz': 'str',
             '*max-connections': 'uint32' } }
 
+##
+# @NbdServerOptions:
+#
+# @addr: Address on which to listen.
+#
+# Since: 10.0
+##
+{ 'struct': 'NbdServerOptions',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddress' } }
+
+##
+# @NbdServerOptionsLegacy:
+#
+# @addr: Address on which to listen.
+#
+# Since: 10.0
+##
+{ 'struct': 'NbdServerOptionsLegacy',
+  'base': 'NbdServerOptionsBase',
+  'data': { 'addr': 'SocketAddressLegacy' } }
+
 ##
 # @nbd-server-start:
 #
@@ -50,31 +65,13 @@
 # intended difference is using SocketAddressLegacy instead of
 # SocketAddress.
 #
-# @addr: Address on which to listen.
-#
-# @tls-creds: ID of the TLS credentials object (since 2.6).
-#
-# @tls-authz: ID of the QAuthZ authorization object used to validate
-#     the client's x509 distinguished name.  This object is is only
-#     resolved at time of use, so can be deleted and recreated on the
-#     fly while the NBD server is active.  If missing, it will default
-#     to denying access (since 4.0).
-#
-# @max-connections: The maximum number of connections to allow at the
-#     same time, 0 for unlimited.  Setting this to 1 also stops the
-#     server from advertising multiple client support (since 5.2;
-#     default: 100).
-#
 # Errors:
 #     - if the server is already running
 #
 # Since: 1.3
 ##
 { 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str',
-            '*max-connections': 'uint32' },
+  'data': 'NbdServerOptionsLegacy',
   'allow-preconfig': true }
 
 ##
-- 
2.48.1


