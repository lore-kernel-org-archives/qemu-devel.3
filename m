Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC340C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lRU-000644-LJ; Tue, 14 May 2024 02:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6lRS-000639-UL
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:15:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6lRE-00020T-9I
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:15:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44881ad9eso4107071b3a.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715667178; x=1716271978;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzHwXd5rAuGL7sHHNS+hdDBoLK+U/OepNXP6dTW3cz8=;
 b=VPIZ11AM8mpzVIk8ls+DCECsmGhLrXP6p3QQZicfCNcqT7Cnhr+zjvlXaSw/xuO3Ay
 vktBzuLB3x5b6bVNnhoN046JDv7qEijxGsYYLlQUjT5osXCHS0tzaBzL1toFcigTywH5
 5TiUybY7Mk08KqR3funwB6raQsA1phj4riNiQ2+AGYBw8KxgbzdTEBmbe4wub32sQPSd
 S844tKu/22NPg5OWH/dUduaXl5+/VNm7sHNt+D6TQwDZaFPwDrFL/aJQP07GvSUbDX4M
 gqhnShuMtnw7BF3hFKgdQqo8YWu0RwChkhz1UeR9whRP069riF073b2u/l0UbqMcLtGc
 HL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715667178; x=1716271978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzHwXd5rAuGL7sHHNS+hdDBoLK+U/OepNXP6dTW3cz8=;
 b=DjNzuiZZNldu4VFF8EY5FeC1MEX/qhi8jdZ0685flv7R8LX80tE87pq+730tcFr8Lu
 1s+WQEpFn912zH7XCneg+ubRynnhvudQ9aLrHT+iLgGs0UK8HU6uNCMFDglWqdVsTcpz
 eGukF2JliNeVDdn3HigVPv7aXc5HtsfcOtT4tWOGs2wtfE7opinXadnAjP2wSoEOpOyK
 8kKiJU3IxiZTpb6R/8hNeV3nrS4ER5gaCHXbLhz/7IfOAR5RRNwxJ8urgWrL26zRAye3
 VxnjRqL3QEgOHqgidWdvF6nADb/MJetu/EnGlaYlvXk3q1cKRvoTWWQPBpAVfaaI4Tiv
 j2XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgaLnNVjTOuO1aP4MV6etzRg+P38aLC8+zKBDDBv9cD1fqrAPyFyYIm4D9jNCyjOTYHnJPPzujSQu2kQdU8sKNqOXPyG0=
X-Gm-Message-State: AOJu0YxDH0r6SV2NZh9LhAIoSETIgwC5TOO9dQAoPXghsqxZzGC7VH0K
 Rv19m2n5OAh8i3ZZFFDnUS5wrfUcF38mbQtBWgqXRY6dORQi9bzsgoGdIERKVGw=
X-Google-Smtp-Source: AGHT+IHGSTvBS4PE7SQRPAzT1EN1I+5d4jUvjq2DhQ1abL03yup60vx0Hkq37RVssbjGxcMkXJvqZQ==
X-Received: by 2002:a05:6a20:d807:b0:1af:f927:55db with SMTP id
 adf61e73a8af0-1aff9275760mr4663942637.59.1715667178112; 
 Mon, 13 May 2024 23:12:58 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d94csm8624098b3a.95.2024.05.13.23.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 23:12:57 -0700 (PDT)
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
Subject: [PATCH v3 2/2] vhost-user: fix lost reconnect again
Date: Tue, 14 May 2024 14:12:28 +0800
Message-ID: <20240514061239.86461-3-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514061239.86461-1-fengli@smartx.com>
References: <20240514061239.86461-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x433.google.com
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


