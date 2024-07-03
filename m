Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55D7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jL-00033b-9p; Wed, 03 Jul 2024 18:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jI-000330-Gt
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jG-0001Gn-L2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cwZ47LpotxgqMUotTFYaru0nOsyfZI/sw2MfKtbkph8=;
 b=C/gR0BEN4ADc/AAe0ze/6FfuF7dHwXHXWcnE6tVAt2gMRNblv3P4MdILn/faJIRM4ZvXUN
 UwwpeHkJ9YpUTByR8fjhyHvI86YZoB3VijHJ9K/pp/xS5Txc/cZtOIsXPJgc0k3X+Bh3G5
 RPY8NXiKwRZ9xs8xfB5o5mwNPrBVp9s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-UWxIRvh9O2C6Xh4-I9MF_A-1; Wed, 03 Jul 2024 18:45:32 -0400
X-MC-Unique: UWxIRvh9O2C6Xh4-I9MF_A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a725b0f8ba9so405666b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046730; x=1720651530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwZ47LpotxgqMUotTFYaru0nOsyfZI/sw2MfKtbkph8=;
 b=fc1j+9MKRcXlhIT24qyEsjXT3mQyJAmRvozcP7EwsRuS/rQhrz3kPrUuYn++nPOkb5
 sj6shEjDVaPZAuR+/zzhOgxFppzQJ9fq8nFg2+vME7El9ionUgKExx7scChKtG7dX8f+
 JUcsCmhvVAWTCzUFd2e5Bo1OOyXlKnpXor+Fhq0eqjUYR7yKHx054vZWAaB/P4pa/oJt
 Zq1QzsG67p1j3lO2OQewoEAgZpCzjRfZn327NyzJGdr2cxLuUmo9VXOUN6oJN1nQDWcB
 OG9Im+CgHnExOIq3WV5gnfZEcXhxOhOdAe+Tc5S2FFWpT0MlCu6cDUIfztDJ/QJUd/GN
 85Xw==
X-Gm-Message-State: AOJu0Ywgjbv9HxCsKAolfyBc165nOoQMUNQhyINsNaJduIFOoZ0KY0uy
 8V/4uj+gSnOD032T6AK+vzhk6txu9bIM3XPE6haz/iwWfsAgE2f/f+w68tWJcMyq0RRG6LGjI5I
 3lAYRvoEsowNR1m27v9VE7/1KI+/GlUlSxzJAfK/65du/7Bw9Ly9DmQ59rTHxKv0Xg4fFVghiUv
 szpcFuW6aH02hHRKt1Jx1Wue/mA/cv8w==
X-Received: by 2002:a05:6402:1cc1:b0:57c:7c44:74df with SMTP id
 4fb4d7f45d1cf-587a0822c1dmr9303822a12.29.1720046729807; 
 Wed, 03 Jul 2024 15:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf+u9KR/aVkIEBTVVLe5R5Xz/bgzPvtsMH1bviz8Q/1691IGmyGyBEIxKJ8pw7FHj6XvNFGw==
X-Received: by 2002:a05:6402:1cc1:b0:57c:7c44:74df with SMTP id
 4fb4d7f45d1cf-587a0822c1dmr9303800a12.29.1720046729079; 
 Wed, 03 Jul 2024 15:45:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d50c4dad9sm1053214a12.10.2024.07.03.15.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:28 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org
Subject: [PULL v3 15/85] vhost-user: fix lost reconnect again
Message-ID: <6eaf0e612b415877d1c411b95bed2ecb53b546bb.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Li Feng <fengli@smartx.com>

When the vhost-user is reconnecting to the backend, and if the vhost-user fails
at the get_features in vhost_dev_init(), then the reconnect will fail
and it will not be retriggered forever.

The reason is:
When the vhost-user fail at get_features, the vhost_dev_cleanup will be called
immediately.

vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.

The reconnect path is:
vhost_user_blk_event
   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
     qemu_chr_fe_set_handlers <----- clear the notifier callback
       schedule vhost_user_async_close_bh

The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
called, then the event fd callback will not be reinstalled.

We need to ensure that even if vhost_dev_init initialization fails, the event
handler still needs to be reinstalled when s->connected is false.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20240516025753.130171-3-fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c   |  3 ++-
 hw/scsi/vhost-user-scsi.c   |  3 ++-
 hw/virtio/vhost-user-base.c |  3 ++-
 hw/virtio/vhost-user.c      | 10 +---------
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 15cc24d017..fdbc30b9ce 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -354,7 +354,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
 
     if (!s->connected) {
-        return;
+        goto done;
     }
     s->connected = false;
 
@@ -362,6 +362,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
 
     vhost_dev_cleanup(&s->dev);
 
+done:
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
                              NULL, dev, NULL, true);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 421cd654f8..cc91ade525 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -182,7 +182,7 @@ static void vhost_user_scsi_disconnect(DeviceState *dev)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
 
     if (!s->connected) {
-        return;
+        goto done;
     }
     s->connected = false;
 
@@ -190,6 +190,7 @@ static void vhost_user_scsi_disconnect(DeviceState *dev)
 
     vhost_dev_cleanup(&vsc->dev);
 
+done:
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
                              vhost_user_scsi_event, NULL, dev, NULL, true);
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 4b54255682..11e72b1e3b 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -225,13 +225,14 @@ static void vub_disconnect(DeviceState *dev)
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
 
     if (!vub->connected) {
-        return;
+        goto done;
     }
     vub->connected = false;
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
 
+done:
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&vub->chardev,
                              NULL, NULL, vub_event,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c929097e87..c407ea8939 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2781,16 +2781,8 @@ typedef struct {
 static void vhost_user_async_close_bh(void *opaque)
 {
     VhostAsyncCallback *data = opaque;
-    struct vhost_dev *vhost = data->vhost;
 
-    /*
-     * If the vhost_dev has been cleared in the meantime there is
-     * nothing left to do as some other path has completed the
-     * cleanup.
-     */
-    if (vhost->vdev) {
-        data->cb(data->dev);
-    }
+    data->cb(data->dev);
 
     g_free(data);
 }
-- 
MST


