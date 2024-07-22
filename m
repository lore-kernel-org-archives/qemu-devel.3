Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmf-000197-4P; Sun, 21 Jul 2024 20:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgll-0003yk-5E
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglj-00061n-AN
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=csYPPQ6V3Zw3B+Skv6+vmMgGos87nUcKxMNRDL7UsyQ=;
 b=PL6cjX7G/t1EEuqDmWB7+hGjFdIj9nP/Q6XYp0HB7wcB1iNisxnD3oCOFpcIdDa+UB1zCY
 Jq6W/KuVqIfnwuA+arZTsZjYHEQNyTPTk4UUdWFtolPkOfr8h5tHxmmL+LG6t8C7t1fnjg
 V8kdZLeg8cXR5cAxyLIMt3LMLSX38/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-TxGAVbfKNZe_CSYm3y6u5A-1; Sun, 21 Jul 2024 20:19:08 -0400
X-MC-Unique: TxGAVbfKNZe_CSYm3y6u5A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42668699453so37772155e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607547; x=1722212347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csYPPQ6V3Zw3B+Skv6+vmMgGos87nUcKxMNRDL7UsyQ=;
 b=u2p+sXkYXDFSpfz39wlpnW8jCVzW2ppLoyiQjegd6vrnG2qYuGfN4YUlqMz4hW/CBM
 r8Jt5dMUPI2+cwbCvDgH7ca8rIm/BkUD5u5ICb23sHeIgTU29mzwvwNigc/ZO2rfWiL8
 sIDLVn5gMADP0tmlf11xaNKolkGEiHKSRsYcmOJdhkP3PvCq4/UULeSpWZJRga8EFC+n
 sdNOoLxVciYWAzizNVd6c0fc/ClHCotbRLiGOErNzHpjMUgp7tlCnCxO/0D/z3lkUZYn
 /ja06blalhuQbmrNRnDzY9m/+DxQYJVVsI/jVjvzKEP/LZ9zS8sEe+jqEAJVaCtisQGN
 dv7w==
X-Gm-Message-State: AOJu0YxprMzXXB5++Jwi4/1zAUGT3+Gin6X082RmMG20lO4L2+gD/7zA
 maFdOBaKTWqnRW2h0QtnuSd4eHC0WSTnXAAIe7cHOq87v4zqaqlL/4y4sWjO3iIXbgcbMsRFxJP
 GSVX6GanDxVrU7HG16u11f871grxIRdvgTv9bvnpnI21+bCXh8d1Qq1JNIw60v7U/znRx1ItpuB
 KUXxB1K0t+sWAMLk1kJLPJ6p1yJVsZrQ==
X-Received: by 2002:a05:600c:4452:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-427dc56b427mr32415075e9.33.1721607547295; 
 Sun, 21 Jul 2024 17:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEhg98lL2fJAKGAldy02gl285EAdjgl11w2DXscYdCLR+LWILqoX1SqFzzHKLblz+m1yPWQg==
X-Received: by 2002:a05:600c:4452:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-427dc56b427mr32414955e9.33.1721607546723; 
 Sun, 21 Jul 2024 17:19:06 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692977asm106911665e9.31.2024.07.21.17.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:19:06 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:19:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 63/63] virtio: Always reset vhost devices
Message-ID: <67d834362c55d6fca6504975bc34755606f17cf2.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Hanna Czenczek <hreitz@redhat.com>

Requiring `vhost_started` to be true for resetting vhost devices in
`virtio_reset()` seems like the wrong condition: Most importantly, the
preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
up in `vhost_dev_stop()` (through vhost devices' `.set_status`
implementations), setting `vdev->vhost_started = false`.  Therefore, the
gated `vhost_reset_device()` call is unreachable.

`vhost_started` is not documented, so it is hard to say what exactly it
is supposed to mean, but judging from the fact that `vhost_dev_start()`
sets it and `vhost_dev_stop()` clears it, it seems like it indicates
whether there is a vhost back-end, and whether that back-end is
currently running and processing virtio requests.

Making a reset conditional on whether the vhost back-end is processing
virtio requests seems wrong; in fact, it is probably better to reset it
only when it is not currently processing requests, which is exactly the
current order of operations in `virtio_reset()`: First, the back-end is
stopped through `virtio_set_status(vdev, 0)`, then we want to send a
reset.

Therefore, we should drop the `vhost_started` condition, but in its
stead we then have to verify that we can indeed send a reset to this
vhost device, by not just checking `k->get_vhost != NULL` (introduced by
commit 95e1019a4a9), but also that the vhost back-end is connected
(`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20240710112310.316551-1-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 397c261c3c..624fdcae91 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2275,8 +2275,12 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started && k->get_vhost) {
-        vhost_reset_device(k->get_vhost(vdev));
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
     }
 
     if (k->reset) {
-- 
MST


