Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3EFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HSl-000387-AI; Fri, 26 Apr 2024 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSf-00036X-NF
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSc-0000do-Sr
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1308515a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1714121977; x=1714726777;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=No65J7OaHylFCFp1ID5znDksi4BJaL2IkYdC72xkf0I=;
 b=fhq1BY0fC9s6nu6BkjcVMfShr/WIOXw5Ttjgzb1Xs/RpQd8lQIB61bsa0UlhW6in6w
 zEVlS+XQgUBZEI7pdrcz77tse50+4PFy5kLwWrvameKq5lnZO3fAe5+v15ilRrxhsYWl
 Jw3GKQ7AjhX9cM6FLq5YGWTi7xATpT5IpLq068dOrDlLzHKsCkkZoLL1xOkRtisG+9g6
 spZ7NyZkkG3r+1GSwJeRFKr0vpW8rz3QJ1slksCnSMe+wwB5R0aVE7alPA011zr7Veda
 4WiCxiPANakyMFpP6IvHofG4l13jafttWdL9R+XPpF5GdjcTTIXocASr6w1Yqxdka6I6
 p5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714121977; x=1714726777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=No65J7OaHylFCFp1ID5znDksi4BJaL2IkYdC72xkf0I=;
 b=vbEOKDPN3sbI/WlPi5pW7BtBzCQQf6ik52ynLU0BNjD2JZ4i/Aw+I5eyuDyhI7+sQD
 GBgDyQsmw8W1pJiEtYwOA9ANe4k21l5zQwjNrhbD9gnSMO0IqNPfkLX8hE++9g/2jvsO
 zyGDkC5cmxlkcFr0YQdxWZPk0A4Np1HoLUfv9TiW78SBmxF0yizyebHZR4dYmiERcaJa
 j7grJvJns4rdyokUsqrON7mAzpXMXGNasn3mkAHkjP3RestsjWOa+9Dym8MZh/m68y3i
 x9CfeG4dbpITuH5Z7E2qv4NWAI8hVzp+GpvEcgz2oUE9dAipLRelWpc8X471gVjkxy2w
 YkvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYpalHiLELzyB4fGBLhkwMPnrW5sP560xzKQPa+l3Jfpx2u2yKGHuGgyyVBQSPkmS8BXu5uXlpEh2IG4u4StREoz/RRg8=
X-Gm-Message-State: AOJu0Yzt6P4sWN3SluKaM+imQNV7oiK2fV9em5Lb3u5NvWngrVA+UmDr
 ej4Q0XhoywaoTgxfa1SjesP1hQQKiUlau63rsi/ZU1ckerxGI2ZFYGSvhyhuo1w=
X-Google-Smtp-Source: AGHT+IE3c1/qWY+RD01c/u37zBI9iHSicIpGyX9aPCIj6zCNVMqsyO9IZF+eHSNt11rAdgrAwHX2/g==
X-Received: by 2002:a05:6a20:431e:b0:1ac:3b5d:a3f4 with SMTP id
 h30-20020a056a20431e00b001ac3b5da3f4mr2705703pzk.3.1714121977236; 
 Fri, 26 Apr 2024 01:59:37 -0700 (PDT)
Received: from localhost.localdomain.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a63e44d000000b005d8b89bbf20sm14038848pgk.63.2024.04.26.01.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 01:59:36 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Li Feng <fengli@smartx.com>
Subject: [PATCH 1/2] Revert "vhost-user: fix lost reconnect"
Date: Fri, 26 Apr 2024 16:58:38 +0800
Message-ID: <20240426085855.665813-2-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426085855.665813-1-fengli@smartx.com>
References: <20240426085855.665813-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 +--
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++--------
 include/hw/virtio/vhost-user.h |  3 +--
 5 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..41d1ac3a5a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &s->chardev, &s->dev,
-                               vhost_user_blk_disconnect, vhost_user_blk_event);
+                               vhost_user_blk_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a63b1f4948..48a59e020e 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
-                               vhost_user_scsi_disconnect,
-                               vhost_user_scsi_event);
+                               vhost_user_scsi_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a83167191e..4b54255682 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
-                               vub_disconnect, vub_event);
+                               vub_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..c929097e87 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2776,7 +2776,6 @@ typedef struct {
     DeviceState *dev;
     CharBackend *cd;
     struct vhost_dev *vhost;
-    IOEventHandler *event_cb;
 } VhostAsyncCallback;
 
 static void vhost_user_async_close_bh(void *opaque)
@@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void *opaque)
      */
     if (vhost->vdev) {
         data->cb(data->dev);
-    } else if (data->event_cb) {
-        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
-                                 NULL, data->dev, NULL, true);
-   }
+    }
 
     g_free(data);
 }
@@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void *opaque)
  */
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb,
-                            IOEventHandler *event_cb)
+                            vu_async_close_fn cb)
 {
     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
         /*
@@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
         data->dev = d;
         data->cd = chardev;
         data->vhost = vhost;
-        data->event_cb = event_cb;
 
         /* Disable any further notifications on the chardev */
         qemu_chr_fe_set_handlers(chardev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index d7c09ffd34..324cd8663a 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState *cb);
 
 void vhost_user_async_close(DeviceState *d,
                             CharBackend *chardev, struct vhost_dev *vhost,
-                            vu_async_close_fn cb,
-                            IOEventHandler *event_cb);
+                            vu_async_close_fn cb);
 
 #endif
-- 
2.44.0


