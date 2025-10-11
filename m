Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C7CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7F-000662-TX; Sat, 11 Oct 2025 09:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7C-000659-1p
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:30 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a75-0004hy-GB
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id DE05BC0139;
 Sat, 11 Oct 2025 16:58:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-MRMBCQk0; Sat, 11 Oct 2025 16:58:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191083;
 bh=SMshwY7iNroE9KHjRmndU4fpWnM0HeoNxchRExZSkZ0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Iuu/TflwCJsgqfL+GoBNqANGtO8bWVJnTATpDi2TSMoH52q7+01ldIVmuK8O0SPkX
 HzpPa4EkGry/6zy7bM1f2LA5E4qx2LUbz7YdIXMgDzwIvfYRGpVzdePKnFonBM8zmZ
 7e7zz+HCW2QzZgh2Nip4YfeOgMJFWrKqTri+lh5s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/33] qapi/char.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:54 +0300
Message-ID: <20251011135754.294521-14-vsementsov@yandex-team.ru>
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
 qapi/char.json | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index f0a53f742c..52cca8da67 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -47,12 +47,14 @@
 #           "return": [
 #              {
 #                 "label": "charchannel0",
-#                 "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agent,server=on",
+#                 "filename":
+#                   "unix:/.../seabios.rhel6.agent,server=on",
 #                 "frontend-open": false
 #              },
 #              {
 #                 "label": "charmonitor",
-#                 "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.monitor,server=on",
+#                 "filename":
+#                   "unix:/.../seabios.rhel6.monitor,server=on",
 #                 "frontend-open": true
 #              },
 #              {
@@ -272,7 +274,8 @@
 # @reconnect: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of seconds.  Setting
 #     this to zero disables this function.  The use of this member is
-#     deprecated, use @reconnect-ms instead.  (default: 0) (Since: 2.2)
+#     deprecated, use @reconnect-ms instead.
+#     (default: 0) (Since: 2.2)
 #
 # @reconnect-ms: For a client socket, if a socket is disconnected,
 #     then attempt a reconnect after the given number of milliseconds.
@@ -776,22 +779,25 @@
 #
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "foo",
-#                          "backend" : { "type" : "null", "data" : {} } } }
+#                          "backend" : { "type" : "null",
+#                                        "data" : {} } } }
 #     <- { "return": {} }
 #
 # .. qmp-example::
 #
 #     -> { "execute" : "chardev-add",
-#          "arguments" : { "id" : "bar",
-#                          "backend" : { "type" : "file",
-#                                        "data" : { "out" : "/tmp/bar.log" } } } }
+#          "arguments" : {
+#            "id" : "bar",
+#            "backend" : { "type" : "file",
+#                          "data" : { "out" : "/tmp/bar.log" } } } }
 #     <- { "return": {} }
 #
 # .. qmp-example::
 #
 #     -> { "execute" : "chardev-add",
 #          "arguments" : { "id" : "baz",
-#                          "backend" : { "type" : "pty", "data" : {} } } }
+#                          "backend" : { "type" : "pty",
+#                                        "data" : {} } } }
 #     <- { "return": { "pty" : "/dev/pty/42" } }
 ##
 { 'command': 'chardev-add',
@@ -814,7 +820,8 @@
 #
 #     -> { "execute" : "chardev-change",
 #          "arguments" : { "id" : "baz",
-#                          "backend" : { "type" : "pty", "data" : {} } } }
+#                          "backend" : { "type" : "pty",
+#                                        "data" : {} } } }
 #     <- { "return": { "pty" : "/dev/pty/42" } }
 #
 # .. qmp-example::
@@ -851,7 +858,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
+#     -> { "execute": "chardev-remove",
+#          "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
 ##
 { 'command': 'chardev-remove',
@@ -868,7 +876,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
+#     -> { "execute": "chardev-send-break",
+#          "arguments": { "id" : "foo" } }
 #     <- { "return": {} }
 ##
 { 'command': 'chardev-send-break',
@@ -891,7 +900,8 @@
 #
 #     <- { "event": "VSERPORT_CHANGE",
 #          "data": { "id": "channel0", "open": true },
-#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#          "timestamp": { "seconds": 1401385907,
+#                         "microseconds": 422329 } }
 ##
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
-- 
2.48.1


