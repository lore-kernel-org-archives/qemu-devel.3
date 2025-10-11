Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AB2CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aAS-0001KQ-Hn; Sat, 11 Oct 2025 10:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a8P-0006VB-S5; Sat, 11 Oct 2025 09:59:46 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a81-0004nL-72; Sat, 11 Oct 2025 09:59:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A83CBC0196;
 Sat, 11 Oct 2025 16:58:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-9ZXnbFjJ; Sat, 11 Oct 2025 16:58:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191104;
 bh=EjDlYN/YV/1Al0fTsGpd9EuPX946XXrIIrx4bLAmmms=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=k+EuZkrq3qIUBvHC4Iv9LGb6ZHou/5GJvEBk4QUnoMo59eUV2oFsPsXQemA7UCzfZ
 br1Gdd220lALcfo/j1ZHHpyGHr4h7XCsAIYsYbBd2fMvg75nrUm6AN9Yx/db8X9m70
 5FD0ixNc3T6+RdNo7mUdxV97Mxug5yYl6ObBWm/o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 28/33] qapi/transaction.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:35 +0300
Message-ID: <20251011135754.294521-55-vsementsov@yandex-team.ru>
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
 qapi/transaction.json | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf3..f43da7f30d 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -250,21 +250,24 @@
 #
 #     -> { "execute": "transaction",
 #          "arguments": { "actions": [
-#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd0",
-#                                          "snapshot-file": "/some/place/my-image",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-sync", "data" : { "node-name": "myfile",
-#                                          "snapshot-file": "/some/place/my-image2",
-#                                          "snapshot-node-name": "node3432",
-#                                          "mode": "existing",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd1",
-#                                          "snapshot-file": "/some/place/my-image2",
-#                                          "mode": "existing",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-internal-sync", "data" : {
-#                                          "device": "ide-hd2",
-#                                          "name": "snapshot0" } } ] } }
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "device": "ide-hd0",
+#                            "snapshot-file": "/some/place/my-image",
+#                            "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "node-name": "myfile",
+#                           "snapshot-file": "/some/place/my-image2",
+#                           "snapshot-node-name": "node3432",
+#                           "mode": "existing",
+#                           "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "device": "ide-hd1",
+#                           "snapshot-file": "/some/place/my-image2",
+#                           "mode": "existing",
+#                           "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-internal-sync",
+#                "data" : { "device": "ide-hd2",
+#                           "name": "snapshot0" } } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'transaction',
-- 
2.48.1


