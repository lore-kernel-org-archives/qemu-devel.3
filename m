Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF0C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jD-0002ih-Ko; Wed, 03 Jul 2024 18:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jB-0002e5-KU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j9-0001FH-NT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cVsXdQI2RthGLy7TxkQZRDMuYIrDeTU2bckWSqVXa0=;
 b=IIg/JPz1NCnNjsYeWOtmuTelRx/An3gyUKOs1T/iIxBg3JF7UGO4rTYJnB1NZdViigosCs
 uQwileXCldQGcln6mNejdFktP0HCp7piBeC+/hDvpLFnTsWZAi1sB6JHcEbXvYzCehZgV5
 wyMURSHAkVccNAnBtUgdU7RP1Y1S6LI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-lJAiBGiKNgyCenagrttjuw-1; Wed, 03 Jul 2024 18:45:24 -0400
X-MC-Unique: lJAiBGiKNgyCenagrttjuw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6fe8b2bcc4so1621066b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046723; x=1720651523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cVsXdQI2RthGLy7TxkQZRDMuYIrDeTU2bckWSqVXa0=;
 b=MNKwbrjd+J7JWkIg0tPbUWf+AJiEfzJd+oTIqStYYeBK1C6+o3e1RPLdfJtoFJaQ9J
 3D3sGVdu9vFVZ/nshC5QRfXmS/BlPyjVTrIpaN06OWHl/0NXqG07ZZiGU8yVHUIa9Jdo
 eAzauCrTH2dN3pah3E+sgOxBh5oH4ZB81SWybh7BvBf/+tQvMQa2+P/UGU1ah7evVgHi
 1eqDzag7YavJOMtCcCYLYk/VeEJOopETt93DRYhkctc+zHHdntgR5FIJglKLmOwSmjYh
 3ct46JK/i/bDuaP8WiG3GEfLZ8HTziDX3VzLCeovlWVtbqgLaGzyVjoZCsdTbzvU4TWt
 DFSA==
X-Gm-Message-State: AOJu0YyXeCEh6Mcw9C93luxKMaj2PeGFAqNx1M0TANJafKXgWB9Irr9/
 pT4zVyqTXQNXANsX0pvXbrxYAjnT1n6rvPSVhwbmDGIUJT2LprUXWwzdn4wqDfV2S3yeLHWbdrp
 XBmXtfaSEITGnr36kEqh1l0AoNaH7rcxIDPLOtadiJ1SZDGJCcYtZAOSNqmDIsyWS1VjTn6tP37
 btC2uTioc0uEKsM5OKEF15a7C+xOxlTw==
X-Received: by 2002:a17:907:6e8c:b0:a77:ae4b:7bf6 with SMTP id
 a640c23a62f3a-a77ae4bb7a7mr91579966b.54.1720046723134; 
 Wed, 03 Jul 2024 15:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaav2fH519aTU8uhRinkPdE+Mm92T90rR0WBIhzL2LiwvcqGmMhx0mQJvjrnmjxGoOse19Hg==
X-Received: by 2002:a17:907:6e8c:b0:a77:ae4b:7bf6 with SMTP id
 a640c23a62f3a-a77ae4bb7a7mr91577066b.54.1720046722161; 
 Wed, 03 Jul 2024 15:45:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18c99sm544904566b.2.2024.07.03.15.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:21 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Feng <fengli@smartx.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org
Subject: [PULL v3 14/85] Revert "vhost-user: fix lost reconnect"
Message-ID: <9569fe0aacbe6c7752935c9ede427ca1e8aafe51.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.

Since the current patch cannot completely fix the lost reconnect
problem, there is a scenario that is not considered:
- When the virtio-blk driver is removed from the guest os,
  s->connected has no chance to be set to false, resulting in
  subsequent reconnection not being executed.

The next patch will completely fix this issue with a better approach.

Signed-off-by: Li Feng <fengli@smartx.com>
Message-Id: <20240516025753.130171-2-fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user.h |  3 +--
 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 +--
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user.c         | 10 ++--------
 5 files changed, 6 insertions(+), 14 deletions(-)

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
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index bc2677dbef..15cc24d017 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -385,7 +385,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_CLOSED:
         /* defer close until later to avoid circular close */
         vhost_user_async_close(dev, &s->chardev, &s->dev,
-                               vhost_user_blk_disconnect, vhost_user_blk_event);
+                               vhost_user_blk_disconnect);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 0b050805a8..421cd654f8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -215,8 +215,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
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
-- 
MST


