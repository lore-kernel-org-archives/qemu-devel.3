Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E0ECCD18C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8X-0006Xp-8o; Sat, 11 Oct 2025 09:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a87-0006PA-8x
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:28 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7k-0004np-SN
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A7FABC0198;
 Sat, 11 Oct 2025 16:58:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-2nADVqBZ; Sat, 11 Oct 2025 16:58:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191105;
 bh=op/F/a+q5XtB4ZnnC6MhqsiuvWj4SvJ8ypU7mVjAOp8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=AX/qoVWMes11zaoUystNEGsACoHuRuwkD+J1CtlRiq89qC0woiyCugOPxVg0b46KU
 ptET/fsj6z+7yEZSeWbPQubToz9OMClbXnYU56X8al0xM9vF2lm9OWoewMrsNqa4Lw
 dcwDUVX1s66LGuy1v1078ZsBDQ/rWVv6qXGf0PVQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 29/33] qapi/ui.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:57:37 +0300
Message-ID: <20251011135754.294521-57-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/ui.json | 108 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 41 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 1b2f4a4769..ab64c6372a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -87,8 +87,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
-#                                                    "password": "secret" } }
+#     -> { "execute": "set_password",
+#          "arguments": { "protocol": "vnc", "password": "secret" } }
 #     <- { "return": {} }
 ##
 { 'command': 'set_password', 'boxed': true, 'data': 'SetPasswordOptions' }
@@ -149,8 +149,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
-#                                                       "time": "+60" } }
+#     -> { "execute": "expire_password",
+#          "arguments": { "protocol": "vnc", "time": "+60" } }
 #     <- { "return": {} }
 ##
 { 'command': 'expire_password', 'boxed': true, 'data': 'ExpirePasswordOptions' }
@@ -381,11 +381,14 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#     <- { "timestamp": { "seconds": 1290688046,
+#                         "microseconds": 388707},
 #          "event": "SPICE_CONNECTED",
 #          "data": {
-#            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#            "server": { "port": "5920", "family": "ipv4",
+#                        "host": "127.0.0.1" },
+#            "client": { "port": "52873", "family": "ipv4",
+#                        "host": "127.0.0.1" }
 #        }}
 ##
 { 'event': 'SPICE_CONNECTED',
@@ -407,13 +410,16 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#     <- { "timestamp": {"seconds": 1290688046,
+#                        "microseconds": 417172},
 #          "event": "SPICE_INITIALIZED",
 #          "data": {"server": {"auth": "spice", "port": "5921",
 #                              "family": "ipv4", "host": "127.0.0.1"},
-#                   "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
-#                              "connection-id": 1804289383, "host": "127.0.0.1",
-#                              "channel-id": 0, "tls": true}
+#                   "client": { "port": "49004", "family": "ipv4",
+#                               "channel-type": 3,
+#                               "connection-id": 1804289383,
+#                               "host": "127.0.0.1",
+#                               "channel-id": 0, "tls": true}
 #        }}
 ##
 { 'event': 'SPICE_INITIALIZED',
@@ -434,11 +440,14 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#     <- { "timestamp": {"seconds": 1290688046,
+#                        "microseconds": 388707},
 #          "event": "SPICE_DISCONNECTED",
 #          "data": {
-#            "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#            "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#            "server": { "port": "5920", "family": "ipv4",
+#                        "host": "127.0.0.1"},
+#            "client": { "port": "52873", "family": "ipv4",
+#                        "host": "127.0.0.1"}
 #        }}
 ##
 { 'event': 'SPICE_DISCONNECTED',
@@ -455,7 +464,8 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#     <- { "timestamp": {"seconds": 1290688046,
+#                        "microseconds": 417172},
 #          "event": "SPICE_MIGRATE_COMPLETED" }
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED',
@@ -727,11 +737,14 @@
 #
 #     <- { "event": "VNC_CONNECTED",
 #          "data": {
-#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
+#                "server": { "auth": "sasl", "family": "ipv4",
+#                            "websocket": false,
 #                            "service": "5901", "host": "0.0.0.0" },
 #                "client": { "family": "ipv4", "service": "58425",
-#                            "host": "127.0.0.1", "websocket": false } },
-#          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#                            "host": "127.0.0.1",
+#                            "websocket": false } },
+#          "timestamp": { "seconds": 1262976601,
+#                         "microseconds": 975795 } }
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -754,11 +767,15 @@
 #
 #     <-  { "event": "VNC_INITIALIZED",
 #           "data": {
-#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
+#                "server": { "auth": "sasl", "family": "ipv4",
+#                            "websocket": false,
 #                            "service": "5901", "host": "0.0.0.0"},
-#                "client": { "family": "ipv4", "service": "46089", "websocket": false,
-#                            "host": "127.0.0.1", "sasl_username": "luiz" } },
-#           "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#                "client": { "family": "ipv4", "service": "46089",
+#                            "websocket": false,
+#                            "host": "127.0.0.1",
+#                            "sasl_username": "luiz" } },
+#           "timestamp": { "seconds": 1263475302,
+#                          "microseconds": 150772 } }
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
@@ -780,11 +797,14 @@
 #
 #     <- { "event": "VNC_DISCONNECTED",
 #          "data": {
-#                "server": { "auth": "sasl", "family": "ipv4", "websocket": false,
-#                            "service": "5901", "host": "0.0.0.0" },
-#                "client": { "family": "ipv4", "service": "58425", "websocket": false,
-#                            "host": "127.0.0.1", "sasl_username": "luiz" } },
-#          "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#                "server": { "auth": "sasl", "family": "ipv4",
+#                            "websocket": false, "service": "5901",
+#                            "host": "0.0.0.0" },
+#                "client": { "family": "ipv4", "service": "58425",
+#                            "websocket": false, "host": "127.0.0.1",
+#                            "sasl_username": "luiz" } },
+#          "timestamp": { "seconds": 1262976601,
+#                         "microseconds": 975795 } }
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
@@ -1023,10 +1043,10 @@
 #
 # Send keys to guest.
 #
-# @keys: An array of `KeyValue` elements.  All @KeyValues in this array
-#     are simultaneously sent to the guest.  A `KeyValue`.number value
-#     is sent directly to the guest, while `KeyValue`.qcode must be a
-#     valid `QKeyCode` value
+# @keys: An array of `KeyValue` elements.  All @KeyValues in this
+#     array are simultaneously sent to the guest.  A `KeyValue`.number
+#     value is sent directly to the guest, while `KeyValue`.qcode must
+#     be a valid `QKeyCode` value
 #
 # @hold-time: time to delay key up events, milliseconds.  Defaults to
 #     100
@@ -1039,9 +1059,10 @@
 # .. qmp-example::
 #
 #     -> { "execute": "send-key",
-#          "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
-#                                   { "type": "qcode", "data": "alt" },
-#                                   { "type": "qcode", "data": "delete" } ] } }
+#          "arguments": { "keys": [
+#            { "type": "qcode", "data": "ctrl" },
+#            { "type": "qcode", "data": "alt" },
+#            { "type": "qcode", "data": "delete" } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'send-key',
@@ -1278,13 +1299,15 @@
 #     -> { "execute": "input-send-event",
 #         "arguments": { "device": "video0",
 #                        "events": [ { "type": "btn",
-#                        "data" : { "down": true, "button": "left" } } ] } }
+#                        "data" : { "down": true,
+#                                   "button": "left" } } ] } }
 #     <- { "return": {} }
 #
 #     -> { "execute": "input-send-event",
 #         "arguments": { "device": "video0",
 #                        "events": [ { "type": "btn",
-#                        "data" : { "down": false, "button": "left" } } ] } }
+#                        "data" : { "down": false,
+#                                   "button": "left" } } ] } }
 #     <- { "return": {} }
 #
 # .. qmp-example::
@@ -1305,8 +1328,10 @@
 #
 #     -> { "execute": "input-send-event" ,
 #       "arguments": { "events": [
-#                    { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
-#                    { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
+#                    { "type": "abs",
+#                      "data" : { "axis": "x", "value" : 20000 } },
+#                    { "type": "abs",
+#                      "data" : { "axis": "y", "value" : 400 } } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'input-send-event',
@@ -1335,10 +1360,11 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
-# @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
-#     resizing host window.  Defaults to "on". (Since 10.1)
+# @keep-aspect-ratio: Keep width/height aspect ratio of guest content
+#     when resizing host window.  Defaults to "on". (Since 10.1)
 #
-# @scale: Set preferred scale of the display.  Defaults to 1.0.  (Since 10.1)
+# @scale: Set preferred scale of the display.  Defaults to 1.0.
+#     (Since 10.1)
 #
 # Since: 2.12
 ##
-- 
2.48.1


