Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69650CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBd-0003eT-2N; Sun, 14 Jun 2026 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBb-0003Ti-Ad
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBY-00023P-Hu
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0/ph/T6xtd6OrEATvYJH2TDT/erooqTl4Flj5mUGIs=;
 b=R651euGbt143G/9IvYUKIIjZoLgqka7hODVpddLEKnXHHY9WN6JGy8RG53jZowCPbLwDXe
 ANcxHFsDJ90j16HbFvrDeSzR6xBxoPNrg+ktbjGSVgYn5vVXm5+mX22vN+oayLv/c4xlQV
 MaFWfPPO0doGIFYp+DoBtzQGb7L96Go=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-blDkCfSvO8WynIcb5IRK_Q-1; Sun, 14 Jun 2026 15:07:54 -0400
X-MC-Unique: blDkCfSvO8WynIcb5IRK_Q-1
X-Mimecast-MFC-AGG-ID: blDkCfSvO8WynIcb5IRK_Q_1781464073
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490ae3bcf4cso12096055e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464073; x=1782068873; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k0/ph/T6xtd6OrEATvYJH2TDT/erooqTl4Flj5mUGIs=;
 b=hbOEpd8mlD7Dgr2AWMDQ26AfpmN46WkIZsSPFQT6y5/Au+E8R24Oo8BAkovFew2sxg
 ypXPfK5ZVMUQBGbyUnO95A2cLkERNHRC6iFon8zV3pvkPOG3dwE1lTiHeCZGF0BPxBTX
 MK4NC9NzZl2suHuQ9H/6jZbx8Ed6yHIcmmRUepmHWdZBUtrCQmom/hmJfIRBJzS9+M5B
 V7Utm5gIheHGPznGEtERrBCQPHo1vlmzs8bezKtr+aMDw9JBnU4RbgVC7Ln5dSFNHANl
 wRx6QPibrknoftwkLiXxMZLMDI/4ckaMB1LVb/bRUQNzNJE5O3D+xW1MO9SVD6i54qYl
 +Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464073; x=1782068873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0/ph/T6xtd6OrEATvYJH2TDT/erooqTl4Flj5mUGIs=;
 b=ZzLST11KzzQa30pvyfsD7csyW9M0lcx0/c0sbqEYrTAxT+eZigiMDC72/4bEnlH5GC
 VC9aTcpBTV6QavXLc8e3ZRjMsWt/Cbw18C59Vlbd4Rl8zvZS1rim5O/Q2oRnsXyvHwOJ
 1Kud8JuCYIF2MZkqBOdpo0dR8F29Vu04el5/3m5wkdAfwomli/CfM1KzpXF5I44iByCK
 p50OVE/qWzWUW8eaK5f4WnbDGBC2DGURjBIkwDNE3uaNrkznsALEJuVRCgzquvLROSIH
 3LR4x7TBU4rr25Bp1vo579+BVasvq1KyfD5YIG3ix7dDdoivfDk6X1s0+UPKqn8XgfCj
 h8bw==
X-Gm-Message-State: AOJu0Yw5+viXDzJXsIscQ8rNC00tIpSR1NxQ0l7DpXSHwhQxUG99zl6v
 sKaX4BVE9JE+tuAPUKKp8VJrK/XHJYzKOW0pvy/pLVXTV+GWbklHXGsPPdprcodH176SowTaacJ
 +DtQ313y4DFKCQwfoWnMXQRVh7UywiWkQcTWIfuuk2M/LDSlt8niVACh27y9XRX5H7uEZS15C9j
 HWPdMRy6oAQ982vHZo7Q4Fhva5cjJN+GhjWw==
X-Gm-Gg: Acq92OFrqlU5gPF91nb/SkHXosLNnB8NFZcuxasAG4LuD93oGnegH3q1fRFTIT59R+3
 GaeskhULEimplFf5WWeTrKqNeZ78roY2G4DphPY5T1n/s2x7PDjlkmziW8vtnxcIHxSkxgaayGJ
 5AbIDGdh9y5R4HulA7vQdqma74/2Jn0UcjD1oJj9O13GMMDccELAfHGJ4XJ5Hk7wqS7U4MYTHvO
 uwpB5moiFN15mhuRNy9jtWIoEfIMBYDaq5uDBsgIJ0kR6Wffp79wywQdbUCpEUDrbMoB/q1Ugo7
 A4IuNU9GokOOUU0adfK2wm6MoDWheo8JDjPM0l9yy+Qx27dTn352AHrk5ofGuBdD5MaFz9hoGQj
 PgiTWS9fn/xPuNesXxlLkbzN8x4/GCy7aHLdCCFL2u/w=
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49220093459mr69075115e9.15.1781464073015; 
 Sun, 14 Jun 2026 12:07:53 -0700 (PDT)
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49220093459mr69074895e9.15.1781464072532; 
 Sun, 14 Jun 2026 12:07:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203dd0b9sm181871995e9.15.2026.06.14.12.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 048/106] vhost: add some useful trace-points
Message-ID: <2d5e87062b6fc283c1effe58ae81d902a57097b8.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-23-vsementsov@yandex-team.ru>
---
 hw/virtio/trace-events | 12 ++++++++++--
 hw/virtio/vhost.c      | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index aa1ffa5e94..2a57edc21e 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -9,8 +9,16 @@ vhost_section(const char *name) "%s"
 vhost_reject_section(const char *name, int d) "%s:%d"
 vhost_iotlb_miss(void *dev, int step) "%p step %d"
 vhost_dev_cleanup(void *dev) "%p"
-vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
-vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_start_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_start_out(void *dev, const char *name) "%p:%s"
+vhost_dev_stop_in(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
+vhost_dev_stop_out(void *dev, const char *name) "%p:%s"
+vhost_virtqueue_start_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_start_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_stop_in(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_virtqueue_stop_out(void *dev, const char *name, int idx) "%p:%s %d"
+vhost_dev_init_in(void *dev) "%p"
+vhost_dev_init_out(void *dev) "%p"
 
 
 # vhost-user.c
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 93c6a5f5e9..c610007e81 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1337,6 +1337,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
+    trace_vhost_virtqueue_start_in(dev, vdev->name, idx);
+
     r = vhost_vrings_map(dev, vdev, vq, idx);
     if (r <= 0) {
         return r;
@@ -1397,6 +1399,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
+    trace_vhost_virtqueue_start_out(dev, vdev->name, idx);
+
     return 0;
 
 fail:
@@ -1415,6 +1419,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     };
     int r = 0;
 
+    trace_vhost_virtqueue_stop_in(dev, vdev->name, idx);
+
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
@@ -1448,6 +1454,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     }
 
     vhost_vrings_unmap(dev, vq, true);
+
+    trace_vhost_virtqueue_stop_out(dev, vdev->name, idx);
     return r;
 }
 
@@ -1581,6 +1589,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
+    trace_vhost_dev_init_in(hdev);
+
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
@@ -1694,6 +1704,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    trace_vhost_dev_init_out(hdev);
+
     return 0;
 
 fail:
@@ -2098,7 +2110,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
-    trace_vhost_dev_start(hdev, vdev->name, vrings);
+    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
 
     vdev->vhost_started = true;
     hdev->started = true;
@@ -2183,6 +2195,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         }
     }
     vhost_start_config_intr(hdev);
+
+    trace_vhost_dev_start_out(hdev, vdev->name);
     return 0;
 fail_iotlb:
     if (vhost_dev_has_iommu(hdev) &&
@@ -2232,7 +2246,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-    trace_vhost_dev_stop(hdev, vdev->name, vrings);
+    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
 
     if (hdev->vhost_ops->vhost_dev_start) {
         hdev->vhost_ops->vhost_dev_start(hdev, false);
@@ -2262,6 +2276,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     hdev->started = false;
     vdev->vhost_started = false;
     hdev->vdev = NULL;
+
+    trace_vhost_dev_stop_out(hdev, vdev->name);
     return rc;
 }
 
-- 
MST


