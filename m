Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D2DCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7L-00068e-I7; Sat, 11 Oct 2025 09:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7G-00066a-OP; Sat, 11 Oct 2025 09:58:35 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a6x-0004cZ-Kc; Sat, 11 Oct 2025 09:58:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 68C02C019B;
 Sat, 11 Oct 2025 16:58:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-ESYgHuXl; Sat, 11 Oct 2025 16:58:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191081;
 bh=0thFphHwZBRGYyoK4iTbQ6WBNY93AwWkUFuAz/JTb9E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Uj8Vs/f8PCOKQXAvue9jIrtDpyiiwtRk0sWUwGk7phfZTTKoXz3ejBhKn3DVCiJX7
 J82uxzhrD6k1csCw7AwqR7O1fNPPd3wYfvNdlyOm7YWyrdGUtvnfidvTuJakNRcHaD
 DgNZTHUEnaEZLHGwiSfgO4HDdPD9y3GqpgRXGy4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 05/33] qapi/block-export.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:49 +0300
Message-ID: <20251011135754.294521-9-vsementsov@yandex-team.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 qapi/block-export.json | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 6878b89dcf..076954ef1a 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -38,8 +38,8 @@
 ##
 # @NbdServerOptions:
 #
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.  The
-# only intended difference is using `SocketAddress` instead of
+# Keep this type consistent with the `NbdServerOptionsLegacy` type.
+# The only intended difference is using `SocketAddress` instead of
 # `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
@@ -51,8 +51,8 @@
 ##
 # @NbdServerOptionsLegacy:
 #
-# Keep this type consistent with the `NbdServerOptions` type.  The only
-# intended difference is using `SocketAddressLegacy` instead of
+# Keep this type consistent with the `NbdServerOptions` type.  The
+# only intended difference is using `SocketAddressLegacy` instead of
 # `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
@@ -125,8 +125,8 @@
 # A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
-#     'fd' `SocketAddress` types are supported.  Passed fds must be UNIX
-#     domain sockets.
+#     'fd' `SocketAddress` types are supported.  Passed fds must be
+#     UNIX domain sockets.
 #
 # @logical-block-size: Logical block size in bytes.  Defaults to 512
 #     bytes.
@@ -373,11 +373,12 @@
 #     cannot be moved to the iothread.  The default is false.
 #     (since: 5.2)
 #
-# @allow-inactive: If true, the export allows the exported node to be inactive.
-#     If it is created for an inactive block node, the node remains inactive.  If
-#     the export type doesn't support running on an inactive node, an error is
-#     returned.  If false, inactive block nodes are automatically activated before
-#     creating the export and trying to inactivate them later fails.
+# @allow-inactive: If true, the export allows the exported node to be
+#     inactive.  If it is created for an inactive block node, the node
+#     remains inactive.  If the export type doesn't support running on
+#     an inactive node, an error is returned.  If false, inactive
+#     block nodes are automatically activated before creating the
+#     export and trying to inactivate them later fails.
 #     (since: 10.0; default: false)
 #
 # Since: 4.2
@@ -460,7 +461,8 @@
 # @node-name: The node name of the block node that is exported
 #
 # @shutting-down: True if the export is shutting down (e.g. after a
-#     `block-export-del` command, but before the shutdown has completed)
+#     `block-export-del` command, but before the shutdown has
+#     completed)
 #
 # Since: 5.2
 ##
-- 
2.48.1


