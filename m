Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D2CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8A-0006QE-65; Sat, 11 Oct 2025 09:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7h-0006HX-Ld
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:03 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7T-0004kb-HQ
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 65D1FC017D;
 Sat, 11 Oct 2025 16:58:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-Jj6xlju8; Sat, 11 Oct 2025 16:58:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191094;
 bh=UIcniQdwd/ae/0mlqDqWCCJREenQAzGUtQQWDB4sJo8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ygULDRxNhi8oUmD1Z7AB6iyFrjFZ21exdxg0HgJQYfV8zQ7pAokuUnuYNCIXdme3T
 tAT2sPjSeIkOC7X1QWBg57hG8IlWJeerTqBWN5yn0HYA6yEdmnVwsdcIm1PaVhoVq5
 bhT0/KHELCZx06SuhjgYeN3wZvU7+zf1O04lO3Rk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 18/33] qapi/net.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:16 +0300
Message-ID: <20251011135754.294521-36-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/net.json | 61 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 60d196afe5..834a9abb9d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -51,8 +51,9 @@
 # .. qmp-example::
 #
 #     -> { "execute": "netdev_add",
-#          "arguments": { "type": "user", "id": "netdev1",
-#                         "dnssearch": [ { "str": "example.org" } ] } }
+#          "arguments": {
+#            "type": "user", "id": "netdev1",
+#            "dnssearch": [ { "str": "example.org" } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'netdev_add', 'data': 'Netdev', 'boxed': true,
@@ -119,9 +120,11 @@
 #
 # Unprivileged user-mode network connectivity using passt
 #
-# @path: Filename of the passt program to run (by default 'passt', and use PATH)
+# @path: Filename of the passt program to run (by default 'passt',
+#     and use PATH)
 #
-# @quiet: don't print informational messages (default, passed as '--quiet')
+# @quiet: don't print informational messages
+#    (default, passed as '--quiet')
 #
 # @vhost-user: enable vhost-user
 #
@@ -281,8 +284,8 @@
 #
 # @smbserver: IP address of the built-in SMB server
 #
-# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to guest
-#     endpoints
+# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to
+#     guest endpoints
 #
 # @guestfwd: forward guest TCP connections
 #
@@ -569,7 +572,8 @@
 #     (default: 0).
 #
 # @inhibit: Don't load a default XDP program, use one already loaded
-#     to the interface (default: false).  Requires @sock-fds or @map-path.
+#     to the interface (default: false).  Requires @sock-fds or
+#     @map-path.
 #
 # @sock-fds: A colon (:) separated list of file descriptors for
 #     already open but not bound AF_XDP sockets in the queue order.
@@ -582,7 +586,8 @@
 #     mutually exclusive.  Requires @inhibit.  (Since 10.1)
 #
 # @map-start-index: Use @map-path to insert xsk sockets starting from
-#     this index number (default: 0).  Requires @map-path.  (Since 10.1)
+#     this index number (default: 0).  Requires @map-path.
+#     (Since 10.1)
 #
 # Since: 8.2
 ##
@@ -774,10 +779,10 @@
 #     attempt a reconnect after the given number of seconds.  Setting
 #     this to zero disables this function.  (default: 0) (since 8.0)
 #
-# @reconnect-ms: For a client socket, if a socket is disconnected, then
-#     attempt a reconnect after the given number of milliseconds.  Setting
-#     this to zero disables this function.  This member is mutually
-#     exclusive with @reconnect.  (default: 0) (Since: 9.2)
+# @reconnect-ms: For a client socket, if a socket is disconnected,
+#     then attempt a reconnect after the given number of milliseconds.
+#     Setting this to zero disables this function.  This member is
+#     mutually exclusive with @reconnect.  (default: 0) (Since: 9.2)
 #
 # Only `SocketAddress` types 'unix', 'inet' and 'fd' are supported.
 #
@@ -985,7 +990,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
+#     -> { "execute": "query-rx-filter",
+#          "arguments": { "name": "vnet0" } }
 #     <- { "return": [
 #             {
 #                 "promiscuous": true,
@@ -1031,9 +1037,11 @@
 # .. qmp-example::
 #
 #     <- { "event": "NIC_RX_FILTER_CHANGED",
-#          "data": { "name": "vnet0",
-#                    "path": "/machine/peripheral/vnet0/virtio-backend" },
-#          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#          "data": {
+#            "name": "vnet0",
+#            "path": "/machine/peripheral/vnet0/virtio-backend" },
+#          "timestamp": { "seconds": 1368697518,
+#                         "microseconds": 326866 } }
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
@@ -1108,7 +1116,8 @@
 #
 #     <- { "event": "FAILOVER_NEGOTIATED",
 #          "data": { "device-id": "net1" },
-#          "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#          "timestamp": { "seconds": 1368697518,
+#                         "microseconds": 326866 } }
 ##
 { 'event': 'FAILOVER_NEGOTIATED',
   'data': {'device-id': 'str'} }
@@ -1130,14 +1139,17 @@
 #          "data": { "netdev-id": "netdev0",
 #                    "addr": { "port": "47666", "ipv6": true,
 #                              "host": "::1", "type": "inet" } },
-#          "timestamp": { "seconds": 1666269863, "microseconds": 311222 } }
+#          "timestamp": { "seconds": 1666269863,
+#                         "microseconds": 311222 } }
 #
 # .. qmp-example::
 #
 #     <- { "event": "NETDEV_STREAM_CONNECTED",
 #          "data": { "netdev-id": "netdev0",
-#                    "addr": { "path": "/tmp/qemu0", "type": "unix" } },
-#          "timestamp": { "seconds": 1666269706, "microseconds": 413651 } }
+#                    "addr": { "path": "/tmp/qemu0",
+#                              "type": "unix" } },
+#          "timestamp": { "seconds": 1666269706,
+#                         "microseconds": 413651 } }
 ##
 { 'event': 'NETDEV_STREAM_CONNECTED',
   'data': { 'netdev-id': 'str',
@@ -1156,7 +1168,8 @@
 #
 #     <- { "event": "NETDEV_STREAM_DISCONNECTED",
 #          "data": {"netdev-id": "netdev0"},
-#          "timestamp": {"seconds": 1663330937, "microseconds": 526695} }
+#          "timestamp": {"seconds": 1663330937,
+#                        "microseconds": 526695} }
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
@@ -1174,7 +1187,8 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
+#     <- { "timestamp": {"seconds": 1739538638,
+#                        "microseconds": 354181 },
 #          "event": "NETDEV_VHOST_USER_CONNECTED",
 #          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
 #
@@ -1193,7 +1207,8 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
+#     <- { "timestamp": { "seconds": 1739538634,
+#                         "microseconds": 920450 },
 #          "event": "NETDEV_VHOST_USER_DISCONNECTED",
 #          "data": { "netdev-id": "netdev0" } }
 #
-- 
2.48.1


