Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57892CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVX7-0006Tu-Ix; Tue, 16 Sep 2025 09:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVq-0005MW-5Y; Tue, 16 Sep 2025 09:14:27 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVh-0006Y5-BF; Tue, 16 Sep 2025 09:14:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5F982C024E;
 Tue, 16 Sep 2025 16:14:08 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EQRob1Gj0U0-knRr4t0v; Tue, 16 Sep 2025 16:14:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028447;
 bh=lL9NT3QdoPBXUIiDbTg52f0I3fPCeIR3oGxvpY7x4CI=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=OWz/yi+Ml2PFlpJTqIETB5XnB7E76+YTmLjaV57XMxQW4Rfa2EvTKezS/pTLTbE3G
 yjbBW1Iz2bTG5ZkVz7AOkrgFPA5aL1IhLUECttt2+sbzZyHGI3D1CrcAoEpxsDMpbz
 +11oq2+qLM3NHXKj9GeHxkbNMqnMFtrToblxFaVE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 02/13] char-socket: tcp_chr_recv(): add comment
Date: Tue, 16 Sep 2025 16:13:51 +0300
Message-ID: <20250916131403.368343-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add comment, to stress that the order of operation (first drop old fds,
second check read status) is intended.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index b1ce5d01c7..1be078dfc0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -294,7 +294,12 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
     }
 
     if (msgfds_num) {
-        /* close and clean read_msgfds */
+        /*
+         * Close and clean previous read_msgfds, they are obsolete at
+         * this point, regardless result of new call to
+         * qio_channel_readv_full().
+         */
+
         for (i = 0; i < s->read_msgfds_num; i++) {
             close(s->read_msgfds[i]);
         }
-- 
2.48.1


