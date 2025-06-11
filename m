Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446A6C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3D-0006Gk-MT; Wed, 11 Jun 2025 11:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN3A-0005zR-MX
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN38-0007DL-RQ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFq26DYsWLmzPImzHrGHSPD9KDvKkjwHURprqDjb7nI=;
 b=YrVwhwtPSttFmCSfPobqDyuVCcJAeqrJTivcv7vYBY69ChUjyks4stHyDSo/tJY2L8hrvT
 LXqe4hZnt80ZCreJPmO+IlFgDRMMSM9TCwDBDupPMmNyJr7mh7R9vIk9EYc30O5Zyl/ksU
 tL34/HsefeVhBY1q8X0DR9Gkijt1UCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-ik5SPssXNCWP2hS7YfhWdQ-1; Wed,
 11 Jun 2025 11:07:30 -0400
X-MC-Unique: ik5SPssXNCWP2hS7YfhWdQ-1
X-Mimecast-MFC-AGG-ID: ik5SPssXNCWP2hS7YfhWdQ_1749654449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4BF11801BD8; Wed, 11 Jun 2025 15:07:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E524E180045B; Wed, 11 Jun 2025 15:07:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/27] vfio: improve VFIODeviceIOOps docs
Date: Wed, 11 Jun 2025 17:06:19 +0200
Message-ID: <20250611150620.701903-28-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

Explicitly describe every parameter rather than summarizing.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250611104753.1199796-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 52 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f39259406bdd7b4577c4c54cfb3ac0dbbcedccb2..d45e5a68a24e7990fa93ce6549f5710b4f25a037 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -168,14 +168,25 @@ struct VFIODeviceIOOps {
      * @device_feature
      *
      * Fill in feature info for the given device.
+     *
+     * @vdev: #VFIODevice to use
+     * @feat: feature information to fill in
+     *
+     * Returns 0 on success or -errno.
      */
-    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *feat);
 
     /**
      * @get_region_info
      *
-     * Fill in @info (and optionally @fd) with information on the region given
-     * by @info->index.
+     * Get the information for a given region on the device.
+     *
+     * @vdev: #VFIODevice to use
+     * @info: set @info->index to the region index to look up; the rest of the
+     *        struct will be filled in on success
+     * @fd: pointer to the fd for the region; will be -1 if not found
+     *
+     * Returns 0 on success or -errno.
      */
     int (*get_region_info)(VFIODevice *vdev,
                            struct vfio_region_info *info, int *fd);
@@ -183,22 +194,38 @@ struct VFIODeviceIOOps {
     /**
      * @get_irq_info
      *
-     * Fill in @irq with information on the IRQ given by @info->index.
+     * @vdev: #VFIODevice to use
+     * @irq: set @irq->index to the IRQ index to look up; the rest of the struct
+     *       will be filled in on success
+     *
+     * Returns 0 on success or -errno.
      */
     int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
 
     /**
      * @set_irqs
      *
-     * Configure IRQs as defined by @irqs.
+     * Configure IRQs.
+     *
+     * @vdev: #VFIODevice to use
+     * @irqs: IRQ configuration as defined by VFIO docs.
+     *
+     * Returns 0 on success or -errno.
      */
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
 
     /**
      * @region_read
      *
-     * Read @size bytes from the region @nr at offset @off into the buffer
-     * @data.
+     * Read part of a region.
+     *
+     * @vdev: #VFIODevice to use
+     * @nr: region index
+     * @off: offset within the region
+     * @size: size in bytes to read
+     * @data: buffer to read into
+     *
+     * Returns number of bytes read on success or -errno.
      */
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                        void *data);
@@ -206,8 +233,15 @@ struct VFIODeviceIOOps {
     /**
      * @region_write
      *
-     * Write @size bytes to the region @nr at offset @off from the buffer
-     * @data; if @post, the write is posted.
+     * Write part of a region.
+     *
+     * @vdev: #VFIODevice to use
+     * @nr: region index
+     * @off: offset within the region
+     * @size: size in bytes to write
+     * @data: buffer to write from
+     *
+     * Returns number of bytes write on success or -errno.
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                         void *data, bool post);
-- 
2.49.0


