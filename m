Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF2C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vidrU-0000MX-B5; Wed, 21 Jan 2026 14:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrS-0000Km-Q4
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:26 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrP-0001l7-Ub
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 42A2280874;
 Wed, 21 Jan 2026 22:27:19 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d28::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HRhSvR2A7Os0-uUwM26Ib; Wed, 21 Jan 2026 22:27:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769023638;
 bh=mlgEG61VHRtAfyJ6TqLdDuu61mW8exrCMJ3s6oN9LFg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eXvB+64U0luwtAZyaAWWf/z2JvNe3e0rnqPJCjxEzW10M8NH1RJIKrpez+hnb7bBh
 nO9X7clavwNXCQ7TpNaNHTXBUBjPhSn7CY8t7+1Rgzz4jb5UwNSONe9TVwsb5JEdkB
 1V8kf+UApNIzbRPBlGSttDHOEFFeNAu4uNOjlWtY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 2/3] net/tap: net_init_tap(): drop extra vhostfdname variable
Date: Wed, 21 Jan 2026 22:27:12 +0300
Message-ID: <20260121192713.133470-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121192713.133470-1-vsementsov@yandex-team.ru>
References: <20260121192713.133470-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 net/tap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 72464a416d..7a108f45e5 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -823,14 +823,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *vhostfdname;
     char ifname[128];
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
-    vhostfdname = tap->vhostfd;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -872,7 +870,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
-                              vhostfdname, vnet_hdr, fd, errp)) {
+                              tap->vhostfd, vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -973,7 +971,7 @@ free_fail:
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
-                              NULL, NULL, vhostfdname,
+                              NULL, NULL, tap->vhostfd,
                               vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
@@ -1013,7 +1011,7 @@ free_fail:
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
-                                  vhostfdname, vnet_hdr, fd, errp)) {
+                                  tap->vhostfd, vnet_hdr, fd, errp)) {
                 close(fd);
                 return -1;
             }
-- 
2.52.0


