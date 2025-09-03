Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A0CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw0-0005xm-KP; Wed, 03 Sep 2025 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvv-0005vz-6Y
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:51 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvr-0000lh-5u
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4ECA2C0185;
 Wed, 03 Sep 2025 15:49:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-V6NBRckk; Wed, 03 Sep 2025 15:49:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903780;
 bh=4PJCnEyWGkfTAqF7UdeAVKuZQl5YlHcPZXor1iy/2ag=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=JtwdaOb3kfFntE1aWOvOqs6ICV0vHNNPfF0UEJraUDZKz037dGN8mcdqSd56Z0jwG
 isMSKve9mKzwx7KvVINTEQTcZIscJLSZeHYTqkiRfLRuFJmkdHTsdG7wMuMR82noQb
 Wzy4tZuyGuZaYN14Cia31f12D4+6CGQ7+Xh6WUpg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 07/19] net/tap: move local variables related to the latter
 case to else branch
Date: Wed,  3 Sep 2025 15:49:21 +0300
Message-ID: <20250903124934.1169899-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 8e6a276e4b..a1a315a9f0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -790,19 +790,11 @@ static int get_fds(char *str, char *fds[], int max)
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
@@ -848,7 +840,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         ret = net_init_tap_one(tap, peer, "tap", name, NULL,
-                               script, downscript,
+                               NULL, NULL,
                                tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
             return -1;
@@ -902,8 +894,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
-                                   script, downscript,
+            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                                   NULL, NULL,
                                    tap->vhostfds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
             if (ret < 0) {
@@ -944,16 +936,21 @@ free_fail:
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


