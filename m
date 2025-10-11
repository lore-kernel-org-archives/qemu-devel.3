Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3752ECCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a7X-0006Ez-BA; Sat, 11 Oct 2025 09:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7P-0006B3-MX; Sat, 11 Oct 2025 09:58:43 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a78-0004hC-1q; Sat, 11 Oct 2025 09:58:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E07D1C00D6;
 Sat, 11 Oct 2025 16:58:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-si4h6nqr; Sat, 11 Oct 2025 16:58:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191082;
 bh=XaNPKEYFvprDxxt9TryZMmnN05KO5P9DtdGM+QisyJ4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mwOKmVgJPR/s0LkPlyYL9bvDTeW9k9eVzvJkhqBRZ8wOWgsAMVKaPp0EWs7sp1BV3
 IVKfVGgcWQmLln1ABFLBUmI8U0JDHsGD5FNyC3elnfq7RhfTNyTMUb4EDhHd+pv4uZ
 JdGp7zhSqZVrjXtl93r7wGEnvIwxw8lywAK5NeeE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 06/33] qapi/block.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:56:52 +0300
Message-ID: <20251011135754.294521-12-vsementsov@yandex-team.ru>
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/block.json | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e..4398c801ee 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -240,7 +240,8 @@
 #          "arguments": { "id": "ide0-1-0" } }
 #
 #     <- { "error": { "class": "GenericError",
-#                     "desc": "Tray of device 'ide0-1-0' is not open" } }
+#                     "desc": "Tray of device 'ide0-1-0' is not open"
+#     } }
 #
 #     -> { "execute": "blockdev-open-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -350,7 +351,8 @@
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "ide0-1-0",
-#                         "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
+#                         "filename":
+#                           "/srv/images/Fedora-12-x86_64-DVD.iso",
 #                         "format": "raw" } }
 #     <- { "return": {} }
 #
@@ -359,17 +361,17 @@
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
-#                         "filename": "/srv/images/ro.img",
+#                         "filename": "ro.img",
 #                         "format": "raw",
 #                         "read-only-mode": "retain" } }
 #
 #     <- { "error":
 #          { "class": "GenericError",
-#            "desc": "Could not open '/srv/images/ro.img': Permission denied" } }
+#            "desc": "Could not open 'ro.img': Permission denied" } }
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
-#                         "filename": "/srv/images/ro.img",
+#                         "filename": "ro.img",
 #                         "format": "raw",
 #                         "read-only-mode": "read-only" } }
 #
@@ -407,7 +409,8 @@
 #                    "id": "/machine/unattached/device[22]",
 #                    "tray-open": true
 #          },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
@@ -430,7 +433,8 @@
 #          "data": { "id": "pr-helper0",
 #                    "connected": true
 #          },
-#          "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1519840375,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
-- 
2.48.1


