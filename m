Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64802CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkW1-00037z-Le; Thu, 11 Sep 2025 12:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVv-0002t3-5n
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:15 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVr-0004As-DO
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 925BA807B0;
 Thu, 11 Sep 2025 19:51:08 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-aFGvYJGI; Thu, 11 Sep 2025 19:51:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609468;
 bh=eJ3HD6jryrgptt1wCimqF9otPGpP21C0gDC98NJaLv0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lmcr2AUyOSDfB4HYuk/PbC6Jwa1GQ7v+TDLxmgLA5zAytbKd+yNr22BsGvifIUfcK
 xbvPzJZMPImZVBmMmbEkVhtJ3sj3VpzySU1nV20xfmHOX0xUtRWimf9/08zx7QB347
 uybLFaKDoLDOTBhOGmRkq6iLwOfNxud9kQ7wPl6U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 8/8] net/tap: move local variables related to the latter
 case to else branch
Date: Thu, 11 Sep 2025 19:51:01 +0300
Message-ID: <20250911165101.1637608-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 70ebe0c752..ce090582e0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -801,19 +801,11 @@ static int get_fds(char *str, char *fds[], int max)
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
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
-                              script, downscript,
+                              NULL, NULL,
                               tap->vhostfd, vnet_hdr, fd, errp)) {
             return -1;
         }
@@ -916,8 +908,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
-                                  script, downscript,
+            if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+                                  NULL, NULL,
                                   tap->vhostfds ? vhost_fds[i] : NULL,
                                   vnet_hdr, fd, errp)) {
                 ret = -1;
@@ -958,15 +950,20 @@ free_fail:
             return -1;
         }
 
-        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
-                              script, downscript, tap->vhostfd,
+        if (!net_init_tap_one(tap, peer, "bridge", name, NULL,
+                              NULL, NULL, tap->vhostfd,
                               vnet_hdr, fd, errp)) {
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


