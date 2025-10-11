Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F9CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a93-00072m-6b; Sat, 11 Oct 2025 10:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7p-0006Il-Ad
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:14 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7X-0004lL-W0
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id F09C4C0183;
 Sat, 11 Oct 2025 16:58:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-0IBV8t43; Sat, 11 Oct 2025 16:58:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191097;
 bh=IB5WctOaaDS5QjV9UsCfoJSKTXKFLtlmFJsXAiDAbRw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BGC3XI3pY/+XtiCrsOViV1CH9Yzzm3kxn8cpzfAfrX5XOKxb0vyNx6K08LQsN0+Lp
 zKB7y0PhzvHU6RC+s/uK+mIJtokS+1gj9CVNJEeDGSUcSDFdETdMppXTDwwH3/mfa3
 ngi7zbe6Uf+QLr09zu8GebdHW07Jjxhn28zSLBrk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 21/33] qapi/replay.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:57:21 +0300
Message-ID: <20251011135754.294521-41-vsementsov@yandex-team.ru>
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
 qapi/replay.json | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68e..0f1398e9b6 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -59,7 +59,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-replay" }
-#     <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#     <- { "return": { "mode": "play", "filename": "log.rr",
+#                      "icount": 220414 } }
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
@@ -80,7 +81,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "replay-break", "arguments": { "icount": 220414 } }
+#     -> { "execute": "replay-break",
+#          "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
 ##
 { 'command': 'replay-break', 'data': { 'icount': 'int' } }
@@ -116,7 +118,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "replay-seek", "arguments": { "icount": 220414 } }
+#     -> { "execute": "replay-seek",
+#          "arguments": { "icount": 220414 } }
 #     <- { "return": {} }
 ##
 { 'command': 'replay-seek', 'data': { 'icount': 'int' } }
-- 
2.48.1


