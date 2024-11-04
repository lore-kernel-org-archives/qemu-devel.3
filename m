Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63525D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84I8-00073r-Hr; Mon, 04 Nov 2024 16:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hy-0006hg-88
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hv-0005MV-UW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Slo8inP3wfhQ8BQeJ7PzLcu289R4kk15rIf298sgC9c=;
 b=PlBrkgp8u/kP15xQP3nI4y8Dsnl7DPmqz90KH6bti/JzZdcim18UXINk6kDyyMEiydUlqH
 ZxirTl69nmbG86RAh07Jdcseb+Se1zbs/UI3cymoh1JiWLvqGKn9L8GA6LE9oamaQDIOrO
 Z1RfUcRij3rnsizbgs0533OP2RXS8Lk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-_VuhjJMEMZqvJSPfUNnqEQ-1; Mon, 04 Nov 2024 16:07:02 -0500
X-MC-Unique: _VuhjJMEMZqvJSPfUNnqEQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so2327174f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754421; x=1731359221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Slo8inP3wfhQ8BQeJ7PzLcu289R4kk15rIf298sgC9c=;
 b=Rl9mhcYVVY+rpGM32xwOrSEoqXFSadt/iLrStSlQdakif4tYPI+9XrtUVGs9gs0vJS
 MJScP4EimfZHckyTgi5mwSsspRumMCb84Wdvf+zATvrt7idhd9EVymKJAArGrOqb+ilO
 fH4TjnIM0ynGuH0bkiINyqxAGzJuUBr2K2NCJ9/ezNvcN/5XsFIy6toW0iG3SfxU06ey
 5L5/wcSVASfNy/UapakuCQsrFHozPCFH6i/93z4np8AOy3xAwc/M9UuxqS74vuskPqGQ
 /z8FOBwJJq0tKHOrNDt8V3ln9H2wBayY2Jvo5U2vlzf0VuM9N/ZSqscUWZjuDj29pmYD
 WXjA==
X-Gm-Message-State: AOJu0YyYblLELsoQ4v/HlUoqmi3Z1zdK7Y3Z8wVEk2iUmcexdy/a9B+M
 TEMbsH6jLU65jRD/9AOLQ4iEZgmzGrru1grUBLGFZCh57BkwUkqGgib6foq3WsfsxF/ZTgy1S/6
 avBk9Jx2nOuIIbktmuNwYiluQvxppQIw6eSzmUPQV9uNNwkJ1lvV8K5tFz7LoP5xTTyZMHqSpAW
 pVrx6tyf6/jfRxJftF/luNKMy2gjD0Jg==
X-Received: by 2002:a5d:584b:0:b0:37d:4a2d:6948 with SMTP id
 ffacd0b85a97d-381c7a5f380mr10897305f8f.33.1730754420705; 
 Mon, 04 Nov 2024 13:07:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc02Gp0IfB70ewwAjdeWFTiRunun32RxFC9DdX3HW1N8jOmhnYvR7tfcMzjXL5ahqZKw2S7A==
X-Received: by 2002:a5d:584b:0:b0:37d:4a2d:6948 with SMTP id
 ffacd0b85a97d-381c7a5f380mr10897288f8f.33.1730754420212; 
 Mon, 04 Nov 2024 13:07:00 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1167f20sm14109508f8f.90.2024.11.04.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:59 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 22/65] vhost-user-blk: split vhost_user_blk_sync_config()
Message-ID: <4dfa12731439c4a3cbfd9d1767acddfbf79549fd.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Split vhost_user_blk_sync_config() out from
vhost_user_blk_handle_config_change(), to be reused in the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Message-Id: <20240920094936.450987-3-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 5b7f46bbb0..48b3dabb8d 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -90,27 +90,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     s->blkcfg.wce = blkcfg->wce;
 }
 
+static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
+{
+    int ret;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                               vdev->config_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(vdev);
+
+    return 0;
+}
+
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    VirtIODevice *vdev = dev->vdev;
-    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
 
     if (!dev->started) {
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
-                               vdev->config_len, &local_err);
+    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-    virtio_notify_config(dev->vdev);
-
     return 0;
 }
 
-- 
MST


