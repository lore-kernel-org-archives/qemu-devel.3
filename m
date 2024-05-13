Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C16BC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PsN-0006BJ-Vl; Mon, 13 May 2024 03:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6Ps2-00068g-PC
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:13:17 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s6Prx-0003G2-9Y
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:13:11 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b283d2b1b4so1547413eaf.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715584265; x=1716189065;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXHsVpeKC0J52kISewC9IoOyZdUgqMeIayHwZ1BBc0E=;
 b=sPyi0D44JaXShxq9pdTU6P1GRKqpzBgRH6yAbhqx9DPCOyl2f0fFDF/AmblJhPE1hB
 5NKyqfte32Fvv+6k8LgD437o+NPsbWc/SENTwLgg2x672JCZ3atyBajkR+UKAviNE9Y1
 nlQKlBqZqYpP8nHe8+XJiqTlgnMbMlL9YoT9OYhJEbWID81VE3EbziGxDi+TG/bv9Wx3
 kHz8iIu/sjihoxoCm7yry0WG1VDjkCmVaMGLNX05zYNSwBvkkmlAdlNt3xk+lLlM/MEw
 MT1LjN9+C+mx0qbuN6cnlvGrSVh2vQWO9bZy1ZXYu53Cu51zmyi69PCSgjoINK2HfaQr
 qJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715584265; x=1716189065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXHsVpeKC0J52kISewC9IoOyZdUgqMeIayHwZ1BBc0E=;
 b=fMRYZ3O7eQFgZRDh8XlINws0QyFv91Xp9qQ1DynymfGG1nw4O4AuqGOFI7oauSuKJc
 mQL37wrjcdn+95fmtc63HRWyvwyXc+sFtqf/ZyvhkIjm7Cw9CCXKUYMIlSC2La8bbrIb
 5k2Ii2ZRj0kPFueCvbehcN5cf02lq2tK10R8wMPY34w6QJMxkRTtGss3MDlJslqUVADL
 Ik5+i359BhvxytBOvSo2oXQQGVHnHbp+WdHe4wF+ZEMtZ1d6Cu8Sr89QB1Hq5yNXSpLJ
 2VJ6pzfKLEufU/g9rkmSj8fFDEM5068R74DX2Sew7GSYJkCrYWYoWpRfxjUi78bpPJ6b
 oIUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgkVIHekxLZg6lawdOc7JXt6q8NDaadYV8lApZkcl0E50bm5M0Frk0IX2aA7JqPQOTKZBFzqSTNBWahPWSPGRG2FFM2V4=
X-Gm-Message-State: AOJu0YywzoRuZ+EMM+1LFs4EtMZ0vCLgyNU0000QZuVfmXF0fUfBlBem
 pvPaaKMiJPRTO0pUlfRjk2o0WO6NDhty41TioileaNQHrk1K/OVCXxfNS4TdWy4=
X-Google-Smtp-Source: AGHT+IG4r+DZXDGQccEhSqhnoNwn4IKYLCxigo0jHIHre/9JmugHSAfS3Vnr+QUL24DV9lPQpfrYUQ==
X-Received: by 2002:a05:6358:61c1:b0:186:1f9a:1771 with SMTP id
 e5c5f4694b2df-193bcff4cfamr1293606255d.29.1715584264764; 
 Mon, 13 May 2024 00:11:04 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c99bd26sm7194006a12.55.2024.05.13.00.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:11:04 -0700 (PDT)
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
Subject: [PATCH v2 1/2] Revert "vhost-user: fix lost reconnect"
Date: Mon, 13 May 2024 15:10:47 +0800
Message-ID: <20240513071052.129581-2-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513071052.129581-1-fengli@smartx.com>
References: <20240513071052.129581-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=fengli@smartx.com; helo=mail-oo1-xc29.google.com
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
2.45.0


