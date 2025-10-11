Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0520CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8J-0006SF-5s; Sat, 11 Oct 2025 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7y-0006KP-A3
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7e-0004mI-1i
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6828AC018A;
 Sat, 11 Oct 2025 16:58:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-tUoPADV2; Sat, 11 Oct 2025 16:58:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191101;
 bh=4ZFS7VeU5sKpFc5IFb6anQVAn3TG0buI2JtzIiCbrd4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=T59l/AogPiShWsVS7QWnlEPlyAjf7bSKemA3EcC86/UhA5bpnkdoBGv8aB788d29T
 qU7K5/D8GzUlS/+nSYJJMxeFvDU5rx0ePCdaLdSX77h3AyH9g0Y5fNTrAel3WEQCgP
 9HgWWcscmDVZBwuT5w7Gl+wIoSY8JVVNlfv/6Pyw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/33] qapi/sockets.json: reflow docs to width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 16:57:28 +0300
Message-ID: <20251011135754.294521-48-vsementsov@yandex-team.ru>
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
 qapi/sockets.json | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 32fac51728..473be2ac58 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -58,24 +58,26 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
 #     IPv6
 #
-# @keep-alive: enable keep-alive when connecting to/listening on this socket.
+# @keep-alive: enable keep-alive when connecting to/listening on this
+#     socket.
 #     (Since 4.2, not supported for listening sockets until 10.1)
 #
-# @keep-alive-count: number of keep-alive packets sent before the connection is
-#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
-#     socket option is defined (this includes Linux, Windows, macOS, FreeBSD,
-#     but not OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
-#
-# @keep-alive-idle: time in seconds the connection needs to be idle before
-#     sending a keepalive packet.  Only supported for TCP sockets on systems
-#     where TCP_KEEPIDLE socket option is defined (this includes Linux,
-#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0, system setting
-#     is used.  (Since 10.1)
-#
-# @keep-alive-interval: time in seconds between keep-alive packets.  Only
-#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined (this
-#     includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).  When set to
-#     0, system setting is used.  (Since 10.1)
+# @keep-alive-count: number of keep-alive packets sent before the
+#     connection is closed.  Only supported for TCP sockets on systems
+#     where TCP_KEEPCNT socket option is defined (this includes Linux,
+#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0,
+#     system setting is used.  (Since 10.1)
+#
+# @keep-alive-idle: time in seconds the connection needs to be idle
+#     before sending a keepalive packet.  Only supported for TCP
+#     sockets on systems where TCP_KEEPIDLE socket option is defined
+#     (this includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).
+#     When set to 0, system setting is used.  (Since 10.1)
+#
+# @keep-alive-interval: time in seconds between keep-alive packets.
+#     Only supported for TCP sockets on systems where TCP_KEEPINTVL is
+#     defined (this includes Linux, Windows, macOS, FreeBSD, but not
+#     OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
 #
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
-- 
2.48.1


