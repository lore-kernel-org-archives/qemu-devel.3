Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7RMG-0002dr-Vq; Wed, 15 May 2024 23:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RLr-0002U7-Ci
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:00:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RLm-0005zG-HF
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:00:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso6129896b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 19:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715828289; x=1716433089;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTX+ubSu9OGm/BIrT1IWFwhZHo7w0Wog7yNHRRYCkA4=;
 b=CB4pHKaNT+54IdrXHq6/ysEubs9/B6Xb0CDop3WIF3QDjO6DggBfQXYvvF2mQyLj/Q
 IpOi8aKXOS2DOARagUEzhFG3p2VG4Inuhi6yIYwgfNfIS5WKrRL5er2cTt0pCgIYTsLM
 0MY6L5+YikmoG2pvAJSUWOPiIJ0K3vHSbczLxEO0QqtCu6SVFrUXVMetT7aGttk5pFN1
 2sntmd2Br7GEnAKBObvFu/loee4eYtbDyIn6vNVVX7TqTfiP1dQZLw7jjSA1V28LE8kL
 supws5Hu1x0Q18jtF7Tb4UQoJoQE184BOFLjWDUUos8kqlGk86gi1+8O8Mf89jVJY7wv
 GxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715828289; x=1716433089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTX+ubSu9OGm/BIrT1IWFwhZHo7w0Wog7yNHRRYCkA4=;
 b=UiGu+U+bZO6TyBGNCkwzwIrffNWPw2wObuab7ckgSe77HmuKwLaQEjfPgX+rZJNopQ
 YU1c1gxqUQ/1GoQbHDxOwlPnDFrvrbR5L2PyAYkBwmifKaygULmw60xslqpUmzS2VkNN
 ueNICxzAnJ07vNMls6EuJcgmfzQ7+g7DJQDB8ZicxZINickhsXkJiIHSVtI1leNOPL3o
 X7Tm71BrhAo+5YgF77Hhd09uK6z+Ibn5xqP9YICpco7A+ad/CxipK9OuPICTR0xrA9KM
 OPlvFdeLwZw5BLsmLtAQe/G+7N7DLd37BkzJ33GmY+yfITTSZ5cu8ABLLZZOOL6t2oXN
 sHDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX88PTkAvsg8YW0p8t2WJ7gLIk1CKgY9aHG54S9+OqKrloC+rWKEtbBaWqDHTblpiO2GHu4gf0RYQskFDwJ1d5LqNI0nMw=
X-Gm-Message-State: AOJu0YwvTE21SXOKpyreOeEnVsFp/KdzAcNUWwMnNZAncp3A3ZMJN1yW
 +X7lmB4O8hmsvBvqmFD075JC/qcrzR32z5P9NjaY2zXveRICboxP5ML+Z7JhuuA=
X-Google-Smtp-Source: AGHT+IHrHdAnx1CNQUFZgnmgiP4pb00Nk8VmdRwIoX4drHXwPM67F67jkB4Gm1sCExxi2TumGAluAQ==
X-Received: by 2002:a05:6a00:4b4c:b0:6f3:c10a:7bdd with SMTP id
 d2e1a72fcca58-6f4e02d36a4mr26190042b3a.18.1715828289008; 
 Wed, 15 May 2024 19:58:09 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f6751f8434sm2320878b3a.184.2024.05.15.19.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 19:58:08 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Yajun Wu <yajunw@nvidia.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/2] vhost-user: fix lost reconnect again
Date: Thu, 16 May 2024 10:57:46 +0800
Message-ID: <20240516025753.130171-3-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516025753.130171-1-fengli@smartx.com>
References: <20240516025753.130171-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

We need to ensure that even if vhost_dev_init initialization fails, the event
handler still needs to be reinstalled when s->connected is false.

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


