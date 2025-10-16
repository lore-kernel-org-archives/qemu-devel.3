Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F44CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNL-0007Gs-5U; Thu, 16 Oct 2025 07:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMa-000757-IW; Thu, 16 Oct 2025 07:41:44 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMS-0003Tt-5y; Thu, 16 Oct 2025 07:41:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id F2BFBC01CF;
 Thu, 16 Oct 2025 14:41:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-Tij31T1z; Thu, 16 Oct 2025 14:41:30 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614890;
 bh=PJRYSlh/MYnWxyKJiwlYbe6xhlYoS+CYlv2eltv+hYU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=P0Ux5ni957+92wSL4EifqrF03NrY30VNtyIlretVkHgJOf3CdaqX8BbK7FmX6aH94
 +gGTx4uzS9gEQ+7zfuL4qaYEBGRJaLFRZsnGSaK7m84uyaxtDmz+Rs6pROYZGaSya+
 zRwSM/XegeZgvB3YNg4i8kga2tYfu/i4ex5+yrJw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 09/25] vhost-user-blk: rename vhost_user_blk_connect to
 vhost_user_blk_init
Date: Thu, 16 Oct 2025 14:40:46 +0300
Message-ID: <20251016114104.1384675-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
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

The function does both vhost_dev_init() and vhost_dev_connect().
Following interface of vhost_dev_init(), and preparing to further
refactoring, let's rename to _init() and add boolean "connect"
parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/trace-events     |  2 ++
 hw/block/vhost-user-blk.c | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index dbaa5ca6cb..9f00412a99 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -63,6 +63,8 @@ vhost_user_blk_start_in(void *vdev) "vdev %p"
 vhost_user_blk_start_out(void *vdev) "vdev %p"
 vhost_user_blk_stop_in(void *vdev) "vdev %p"
 vhost_user_blk_stop_out(void *vdev) "vdev %p"
+vhost_user_blk_init_in(void *vdev) "vdev %p"
+vhost_user_blk_init_out(void *vdev) "vdev %p"
 vhost_user_blk_connect_in(void *vdev) "vdev %p"
 vhost_user_blk_connect_out(void *vdev) "vdev %p"
 vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f2ecf81e4d..c31c265a0e 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -344,13 +344,16 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
     vhost_dev_free_inflight(s->inflight);
 }
 
-static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
+static int vhost_user_blk_init(DeviceState *dev, bool connect, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     int ret = 0;
 
-    trace_vhost_user_blk_connect_in(vdev);
+    trace_vhost_user_blk_init_in(vdev);
+
+    /* TODO: implement support for connect=false */
+    assert(connect);
 
     assert(!s->connected);
 
@@ -380,7 +383,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
         ret = vhost_user_blk_start(vdev, errp);
     }
 
-    trace_vhost_user_blk_connect_out(vdev);
+    trace_vhost_user_blk_init_out(vdev);
 
     return ret;
 }
@@ -415,7 +418,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     switch (event) {
     case CHR_EVENT_OPENED:
         if (!s->connected) {
-            if (vhost_user_blk_connect(dev, &local_err) < 0) {
+            if (vhost_user_blk_init(dev, true, &local_err) < 0) {
                 error_report_err(local_err);
                 qemu_chr_fe_disconnect(&s->chardev);
                 return;
@@ -447,7 +450,7 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
         return ret;
     }
 
-    ret = vhost_user_blk_connect(dev, errp);
+    ret = vhost_user_blk_init(dev, true, errp);
     if (ret < 0) {
         qemu_chr_fe_disconnect(&s->chardev);
         return ret;
-- 
2.48.1


