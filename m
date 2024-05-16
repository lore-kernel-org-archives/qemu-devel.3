Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB66AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7RMF-0002VY-RQ; Wed, 15 May 2024 23:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RLo-0002Tp-9H
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:00:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RLk-0005yn-PV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:00:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f4302187c0so5843380b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715828285; x=1716433085;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U88MQ1EYnI1xEBI7BtZA3bCgLHI2CS0/Ml/sSklTY0=;
 b=sCYR3zb5P1pJkUJGxmcUeXOZp0UlHCx2ekK69FitEUMEYX4NhJ116fHe1nNsopZcqf
 qa27WIiDxifcYk3koIWgk/AQFV5I3VrBGuamSFfsbwlTLJigzBN6nmn9t8fhuqQZSse1
 f6aAFN0Yl7TxXv4EnHSdc/Csn/Z0QJoTbfC0cPjPBjnwcR+/GrzpCaMLAHv6E74ATaPe
 33aSLnqVVy9LECyAvx5u7NOF6kPgBf4RQT1urVrrC2SvcrOC93NcpL9kqEe/jPnta02E
 Uctybls+pF9kxiBsx4Tz3Omd80TMAomCeeGNCMv/2wMdlNcSRga/03R0xzZhOsxm/umj
 nTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715828285; x=1716433085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U88MQ1EYnI1xEBI7BtZA3bCgLHI2CS0/Ml/sSklTY0=;
 b=qfvXtE9OkTfGbQmhnVqodcK4QxeZsHr0LXXWa5P771mSMzfvc4+8SmhDqFWWcMrq8M
 WnA5yUOn50OjhxrffspyyzPg+x1GzbFsK+x6htQCsfA6Qgxo3uLhit+VBghlRDo0odWa
 b/0L02JbAMPs4cQUU+P80C2PY6mSGwTpFYmBdolo1XpXZ4elujj/n1ZcdgV6TLvBxLVu
 eb+YLasFWKbMGJncKx8fIoFspPpFYTOHj1ZGHgpaHwgGRVRp+e7mJQi3So0yWrwtOEPh
 vgiBo7w/rmlnIR0L+I1aWLyMvjal1kQ/aaeS7aESjL8SieZtBnw+7NHDschFRB9fRJAZ
 RgfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGJn4R3MbZBIlTLD2ai24UdEzp0ghBOcK25cLBSEEk1MReVt6rl6Ac2P0M+RAEZe0vRAvHYNGrBcFd1xs/52prUE5GEJU=
X-Gm-Message-State: AOJu0YxNLWKep2o7Rwy5E5/qX/c8V8+t0yuzcblBrlm2lq8GwwrnxtgJ
 qnqcortW7iS+XRafNHDC3QMTeFU70BFgdZde82nF7Afz1fN5uFZ5iTOSajOUOboQK7GUiwRWxlN
 J33L/lQ==
X-Google-Smtp-Source: AGHT+IEnBCbYVNKIzxif7Pw5AVWDaPLaHQoVtjQss0IkuEKEOK4COPQFI2+QBQ6FS2QcyY4e5dp9Jw==
X-Received: by 2002:a05:6a20:4323:b0:1af:58f8:1190 with SMTP id
 adf61e73a8af0-1afde0d5a81mr24471380637.12.1715828285222; 
 Wed, 15 May 2024 19:58:05 -0700 (PDT)
Received: from localhost.localdomain.cc (vps-bd302c4a.vps.ovh.ca.
 [15.235.142.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f6751f8434sm2320878b3a.184.2024.05.15.19.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 19:58:04 -0700 (PDT)
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
Subject: [PATCH v4 1/2] Revert "vhost-user: fix lost reconnect"
Date: Thu, 16 May 2024 10:57:45 +0800
Message-ID: <20240516025753.130171-2-fengli@smartx.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516025753.130171-1-fengli@smartx.com>
References: <20240516025753.130171-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x434.google.com
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

Since the current patch cannot completely fix the lost reconnect
problem, there is a scenario that is not considered:
- When the virtio-blk driver is removed from the guest os,
  s->connected has no chance to be set to false, resulting in
  subsequent reconnection not being executed.

The next patch will completely fix this issue with a better approach.

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


