Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C43C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uO0-00069b-QP; Wed, 16 Sep 2026 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNt-00068i-3L
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:32 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6uNp-0008Ml-5X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:29:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1d84:0:640:ba03:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 822B381186;
 Wed, 16 Sep 2026 21:29:22 +0300 (MSK)
Received: from i115954770.. (185.215.60.179.mosline.ru [185.215.60.179])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id JTaLWK3cWGk0-mjpvx8WJ; Wed, 16 Sep 2026 21:29:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789583361;
 bh=3g3l58hlqrWpuGiwuF8BMNMQ7k8gG1JoZgGJOlMzL/k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=upuLs7Tp4u1NCGE2MNABx0O+J3DcNGMNW5x+/giHOvvRE1dYyeq2eu+PB10mtKhmL
 MSCzzSJV5sjoYY/cWqX+5KoMhtQQMhJ6h0ichjR5rqcMDKUVU9mVk05WBZbc5Bx2Lq
 rYrJsR04QXCKsPmhdaoKd+IskSeSUe9IG2VRhPl0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 2/2] vhost-user: drop extra "else" in
 vhost_user_set_mem_table_postcopy()
Date: Wed, 16 Sep 2026 21:29:17 +0300
Message-ID: <20260916182917.820031-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916182917.820031-1-vsementsov@yandex-team.ru>
References: <20260916182917.820031-1-vsementsov@yandex-team.ru>
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

The "else" after "return" is redundant. Let's reduce indentation level.
No logic change here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 135 ++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index da7e3f149c1..addbc59e704 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -915,84 +915,81 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
         error_report(
             "vhost-user: postcopy is not supported with CONFIGURE_MEM_SLOTS");
         return -ENOTSUP;
-    } else {
-        ret = vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
-                                                true);
-        if (ret < 0) {
-            return ret;
-        }
+    }
 
-        ret = vhost_user_write(dev, &msg, fds, fd_num);
-        if (ret < 0) {
-            return ret;
-        }
+    ret = vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num, true);
+    if (ret < 0) {
+        return ret;
+    }
 
-        ret = vhost_user_read(dev, &msg_reply);
-        if (ret < 0) {
-            return ret;
-        }
+    ret = vhost_user_write(dev, &msg, fds, fd_num);
+    if (ret < 0) {
+        return ret;
+    }
 
-        if (msg_reply.hdr.request != VHOST_USER_SET_MEM_TABLE) {
-            error_report("%s: Received unexpected msg type."
-                         "Expected %d received %d", __func__,
-                         VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
-            return -EPROTO;
-        }
+    ret = vhost_user_read(dev, &msg_reply);
+    if (ret < 0) {
+        return ret;
+    }
 
-        /*
-         * We're using the same structure, just reusing one of the
-         * fields, so it should be the same size.
-         */
-        if (msg_reply.hdr.size != msg.hdr.size) {
-            error_report("%s: Unexpected size for postcopy reply "
-                         "%d vs %d", __func__, msg_reply.hdr.size,
-                         msg.hdr.size);
-            return -EPROTO;
-        }
+    if (msg_reply.hdr.request != VHOST_USER_SET_MEM_TABLE) {
+        error_report("%s: Received unexpected msg type."
+                     "Expected %d received %d", __func__,
+                     VHOST_USER_SET_MEM_TABLE, msg_reply.hdr.request);
+        return -EPROTO;
+    }
 
-        memset(u->postcopy_client_bases, 0,
-               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
+    /*
+     * We're using the same structure, just reusing one of the
+     * fields, so it should be the same size.
+     */
+    if (msg_reply.hdr.size != msg.hdr.size) {
+        error_report("%s: Unexpected size for postcopy reply "
+                     "%d vs %d", __func__, msg_reply.hdr.size,
+                     msg.hdr.size);
+        return -EPROTO;
+    }
 
-        /*
-         * They're in the same order as the regions that were sent
-         * but some of the regions were skipped (above) if they
-         * didn't have fd's
-         */
-        for (msg_i = 0, region_i = 0;
-             region_i < dev->mem->nregions;
-             region_i++) {
-            if (msg_i < fd_num &&
-                msg_reply.payload.memory.regions[msg_i].guest_phys_addr ==
-                dev->mem->regions[region_i].guest_phys_addr) {
-                u->postcopy_client_bases[region_i] =
-                    msg_reply.payload.memory.regions[msg_i].userspace_addr;
-                trace_vhost_user_set_mem_table_postcopy(
-                    msg_reply.payload.memory.regions[msg_i].userspace_addr,
-                    msg.payload.memory.regions[msg_i].userspace_addr,
-                    msg_i, region_i);
-                msg_i++;
-            }
-        }
-        if (msg_i != fd_num) {
-            error_report("%s: postcopy reply not fully consumed "
-                         "%d vs %zd",
-                         __func__, msg_i, fd_num);
-            return -EIO;
-        }
+    memset(u->postcopy_client_bases, 0,
+           sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
 
-        /*
-         * Now we've registered this with the postcopy code, we ack to the
-         * client, because now we're in the position to be able to deal
-         * with any faults it generates.
-         */
-        /* TODO: Use this for failure cases as well with a bad value. */
-        msg.hdr.size = sizeof(msg.payload.u64);
-        msg.payload.u64 = 0; /* OK */
-        ret = vhost_user_write(dev, &msg, NULL, 0);
-        if (ret < 0) {
-            return ret;
+    /*
+     * They're in the same order as the regions that were sent
+     * but some of the regions were skipped (above) if they
+     * didn't have fd's
+     */
+    for (msg_i = 0, region_i = 0; region_i < dev->mem->nregions; region_i++) {
+        if (msg_i < fd_num &&
+            msg_reply.payload.memory.regions[msg_i].guest_phys_addr ==
+            dev->mem->regions[region_i].guest_phys_addr) {
+            u->postcopy_client_bases[region_i] =
+                msg_reply.payload.memory.regions[msg_i].userspace_addr;
+            trace_vhost_user_set_mem_table_postcopy(
+                msg_reply.payload.memory.regions[msg_i].userspace_addr,
+                msg.payload.memory.regions[msg_i].userspace_addr,
+                msg_i, region_i);
+            msg_i++;
         }
     }
+    if (msg_i != fd_num) {
+        error_report("%s: postcopy reply not fully consumed "
+                     "%d vs %zd",
+                     __func__, msg_i, fd_num);
+        return -EIO;
+    }
+
+    /*
+     * Now we've registered this with the postcopy code, we ack to the
+     * client, because now we're in the position to be able to deal
+     * with any faults it generates.
+     */
+    /* TODO: Use this for failure cases as well with a bad value. */
+    msg.hdr.size = sizeof(msg.payload.u64);
+    msg.payload.u64 = 0; /* OK */
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
 
     return 0;
 }
-- 
2.43.0


