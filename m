Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C081CA0EED
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqif-0005P4-VJ; Sat, 23 Aug 2025 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiR-0005L5-35
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiM-0000IB-55
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 63A17804EC;
 Sat, 23 Aug 2025 19:03:31 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-M9en8nDj; Sat, 23 Aug 2025 19:03:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965011;
 bh=/jmgRZlvnyx5qMTtkk0yR8vFuAW4SpHDfPYvvSqnSc0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=z+WY3dVWLF3nhLZ6isW8oqQ9HYJSNHHv8coNsYzF6m98iFmAWkjx6wybnNTgXzr8w
 Vu8NNxbst/tjURz0BnbZI+UDYZLWQpXKKTJPVW0jpLjTDyztJGNJliFPUjhryd17k5
 POTx4boTlzZ/Jdrvx3xSDrnZyB6Tte0EdUbYfY+c=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 08/20] net/tap: move local variables related to the latter
 case to else branch
Date: Sat, 23 Aug 2025 19:03:11 +0300
Message-ID: <20250823160323.20811-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
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

This makes more obvious, where the variables make sense.

Note that ifname, script and downscript variables are not used in
net_init_tap_one() for fd/fds/helper cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ade58826c8..80ec54f914 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -803,19 +803,11 @@ static int get_fds(char *str, char *fds[], int max)
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    const NetdevTapOptions *tap;
-    int fd, vnet_hdr = 0, i = 0, queues;
-    /* for the no-fd, no-helper case */
-    const char *script;
-    const char *downscript;
-    char ifname[128];
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    int fd, vnet_hdr = 0, i = 0;
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-    tap = &netdev->u.tap;
-    queues = tap->has_queues ? tap->queues : 1;
-    script = tap->script;
-    downscript = tap->downscript;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -861,7 +853,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         ret = net_init_tap_one(tap, peer, "tap", name, NULL,
-                               script, downscript,
+                               NULL, NULL,
                                tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
             return -1;
@@ -915,8 +907,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
-                                   script, downscript,
+            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                                   NULL, NULL,
                                    tap->vhostfds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
             if (ret < 0) {
@@ -957,16 +949,21 @@ free_fail:
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
-                               script, downscript, tap->vhostfd,
+        ret = net_init_tap_one(tap, peer, "bridge", name, NULL,
+                               NULL, NULL, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
             close(fd);
             return -1;
         }
     } else {
+        const char *script = tap->script;
+        const char *downscript = tap->downscript;
+        int queues = tap->has_queues ? tap->queues : 1;
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
+        char ifname[128];
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
-- 
2.48.1


