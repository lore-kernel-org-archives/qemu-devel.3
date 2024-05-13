Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A63EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PsM-0006Af-Pt; Mon, 13 May 2024 03:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6Ps6-00068t-En
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:13:21 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6Ps0-0003Il-36
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:13:14 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5b279e04391so2215011eaf.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715584270; x=1716189070;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzHwXd5rAuGL7sHHNS+hdDBoLK+U/OepNXP6dTW3cz8=;
 b=Hr2vxAqlS0w+6WxbgSuNi+SEx/hxkkPip6nMeBg4FVWexdnRvh+VbB33UpiFHqntB0
 SRINWynV44ebGlNTlFo1jbSfzakCRaw5egexwRRKmzwjrxwJaau0bmOIAeymGzdB/hQ1
 Tc1e+hiIwETDFtWSHe8S4QDBsurYST8c4RFq7SrCsx5ReehI0XGqDs96t1+l4d43/P6R
 YyhYgI6pc8pB45Byt1TgotDvq/VmCxLLfgln+fAwsvdZfN/ltx4mDh1Z463C0ENeiXm5
 rfMeMwpGxBwPvQnNDvczHs+KB3kWVZexjUHzYZFrKOdpsGOsT0CShT3xhfNzyLSrBCux
 /miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715584270; x=1716189070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzHwXd5rAuGL7sHHNS+hdDBoLK+U/OepNXP6dTW3cz8=;
 b=rdjnpIlNzaj/RoPny7NB++cnuhWrVxgbIW/m5LqgwjShy223mnZl8/41yGWBWkC2wG
 9Tswl1Bt+e9edsJfHxbXSRt2AvLfhiicfavj82YsWCnBs83OhbFi1i0FTgcYDEC84zbx
 5xoINUvNITWbcc7bkAKh7VY8nZA4DgMIewGM9kp72j66G8IHATOYy5/9MHw41SlCgfhe
 vt+29RDPmJgWL8PJvy1nYTICToQYtn5/i3mmHlMmcGcMND70ONuGnkEPOH4K66x8wuL0
 E/3PnrKAcY68x9h9sfDzfYxtT9N1euyH6IBI+NFHzTHuY2Q2ORfeBHxsfjVVAnLkPoOd
 +6Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk7tDYZIl58/0Tz84b45rgMjYnJ4+IW4tm/MNPDzY6oEDh2jqUW0VUI9IX0qdWDXH/GgDwNm/h/Q0WK+/7cx1nh7sWNzU=
X-Gm-Message-State: AOJu0YwwGZlmqaP8T830kAG07es2jvn1DN2TSezUODzwGUmx4xHNLoD3
 ypOFp9Rkz5oq2F8WqrCKMIKh/IEcKYS+wM9qSg4JHgPVSrBWG4cKTevNfMqpzBU=
X-Google-Smtp-Source: AGHT+IFi6fdYlDsBVDVEJXJHeN20luU5xnHf5pVVbvfQR8ZdOD76r1BZGh7PASUCr7kJDfc4s0TM0A==
X-Received: by 2002:a05:6358:280c:b0:183:f634:104 with SMTP id
 e5c5f4694b2df-193bb50c50emr934159355d.7.1715584269075; 
 Mon, 13 May 2024 00:11:09 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c99bd26sm7194006a12.55.2024.05.13.00.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:11:08 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Yajun Wu <yajunw@nvidia.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/2] vhost-user: fix lost reconnect again
Date: Mon, 13 May 2024 15:10:48 +0800
Message-ID: <20240513071052.129581-3-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513071052.129581-1-fengli@smartx.com>
References: <20240513071052.129581-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=fengli@smartx.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

With this patch, the vhost_user_blk_disconnect will call the
vhost_dev_cleanup() again, it's safe.

In addition, the CLOSE event may occur in a scenario where connected is false.
At this time, the event handler will be cleared. We need to ensure that the
event handler can remain installed.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c   |  3 ++-
 hw/scsi/vhost-user-scsi.c   |  3 ++-
 hw/virtio/vhost-user-base.c |  3 ++-
 hw/virtio/vhost-user.c      | 10 +---------
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 41d1ac3a5a..c6842ced48 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -353,7 +353,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
 
     if (!s->connected) {
-        return;
+        goto done;
     }
     s->connected = false;
 
@@ -361,6 +361,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
 
     vhost_dev_cleanup(&s->dev);
 
+done:
     /* Re-instate the event handler for new connections */
     qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
                              NULL, dev, NULL, true);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 48a59e020e..b49a11d23b 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -181,7 +181,7 @@ static void vhost_user_scsi_disconnect(DeviceState *dev)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
 
     if (!s->connected) {
-        return;
+        goto done;
     }
     s->connected = false;
 
@@ -189,6 +189,7 @@ static void vhost_user_scsi_disconnect(DeviceState *dev)
 
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
2.45.0


