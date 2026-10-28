Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5A606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7ij4gb8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KM+yXWDF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HC-000227-V4; Wed, 28 Oct 2026 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G5-00009y-6d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G3-0003ry-7T
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCV9MK2tJVwUFYE3aXNQOOiQRc9fHS1Oi59Xhr97czQ=;
 b=P7ij4gb842rfx34TO+h9EHBp1Ws855zlPyjyrcwy9b8zggllWC8E8fhdpAcpFlgWeDcyUD
 8D1E2xv2Q6svkCqqvzSopPcar67Gmc6VUMN0EdhPgRNDkRmiYyg4thi4amwHUOdCdkiedb
 3BU7OYGBrr+tK8te8ObedmahLoYVdAE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-KMn1TFVtM0WSAYheQ5jukw-1; Wed, 28 Oct 2026 13:16:12 -0400
X-MC-Unique: KMn1TFVtM0WSAYheQ5jukw-1
X-Mimecast-MFC-AGG-ID: KMn1TFVtM0WSAYheQ5jukw_1793207772
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e20ed362aso56047f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207771; x=1793812571; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CCV9MK2tJVwUFYE3aXNQOOiQRc9fHS1Oi59Xhr97czQ=;
 b=KM+yXWDFka5JTd6t4w+YAmgHHhDZl3PtfummssPsiD/tmnDi/Ws116foCgMeKJJhVw
 1ZBJ5n8EgaVnm4gI6S3VmhlTgg/kUCI7JpWWgGcXMVy/tIBeA9Fl3L5UEsCd+K13GJ26
 M7R1OaKxWY64sGQw8aD6cWkyTdu1RPUtmA7RXgqGTAsJ1XTkTWUiTOq3P+WxIk+VaKgR
 Gi1APZ8ptUJvf+C1GqaJEnse3FEwV9zkfDtvgnzhxEFrQ/zbzKRiekF7o5BqYAnnCRkj
 b/RTuWA4/0g9uRlxaGv8EYBci5lF0aLHO/rlKXddytT1QEjXVmyrEYmREwIvOh2PKGVu
 +XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207771; x=1793812571;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCV9MK2tJVwUFYE3aXNQOOiQRc9fHS1Oi59Xhr97czQ=;
 b=iieZpN1CV1RerMx/EbTlcDc6+n5OtPBBoxSAPaDVSXdhNQcWzWb2Xt98PjjBOR1HyF
 5PSZTrPkPJPH2hvAdujhWulHi407iZXdJfw8qI9SeTxE1ZlFQfzdicNKoCfJpugzOx1M
 Tft6Ecf9QIPcSBWkSYX/OThU69l7Bp0OnwzTRiy52Qz/5Qzwi9hIIyhZv0O7cHl+EsTF
 BEWG2jciNNixSZyBQo3WqRx/ct7PG7muyeNw8uwiHixFFvZzEUwenn8hqv/J7uZI9WZr
 t8tCSzBfsFL0bwwVZEJtpgkkd+lxaUhVcs0o6WFCc016330oD8Y45V5djgFhtf91zELC
 BuUw==
X-Gm-Message-State: AFq9FYIhRyPfe6rMImbQjU7PqiEDsQFG2f/dRibF7Xc7kltHvrLPoesB
 McvRz+1knF0IlZHdJ82HpQhM6jm79k4UDNGTo8+sGSz4XI+Kshgnqr+I0GrIY3nt2KEpwdo242A
 2m1xUY+7bvfUJagroSdj9DvHa+e786md46utJ37o0rq25kbP141GeAjOBVnTJ5xP1ok95RoOx2m
 UwN/hldYj3jHOFA+AzlzkFeHNMg+fMgMMKbQ==
X-Gm-Gg: AYBFou2vaGYVTpaCIyHqB7vd7kIqVwH5jQNAjbC2c7T6oRI2hPGAiA1eB4SZhpC04OH
 1OYWqvtPEXFvYNOzg9nnuf4puw86xTtn3UCwuAAdrNuoHVeixPDoLbrJS4v1dkU6DY2XOUV6hzW
 0BSE9/qsDGVWX2KnihTEDYSdZ/H/7cRF7e0WOwtdxiw3mTKk5BoKFgKbt76Qbh7bEZob++MorsG
 4sgOWvVH8cdVUfycQzJEjZ3DGkb5EJJXZh4BqIIEsvIqCCuhSnDTBk1Yk6m+eShRQVe/NtGadYa
 HJWeTsmoOo7Yp2fZaLBrmEkjWEXz+k3aqhrC8gxCfEaGAkqmiP+B1xMGcXpmY4O/3M3CT8jwMzY
 Nt4UQyuF1k3fPP3uMu3uXnAinGmVkhoxIYyLQIFBw
X-Received: by 2002:a05:600c:608c:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4a967016833mr64394455e9.23.1793207771486; 
 Wed, 28 Oct 2026 10:16:11 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4a967016833mr64393605e9.23.1793207770954; 
 Wed, 28 Oct 2026 10:16:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92de010bcsm55989725e9.0.2026.10.28.10.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:10 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li RongQing <lirongqing@baidu.com>
Subject: [PULL 50/78] virtio-qmp: Fix out-of-bounds vqs index in vhost queue
 status
Message-ID: <95253c9a9e210c58ea8349644f173c807f2213c5.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Li RongQing <lirongqing@baidu.com>

qmp_x_query_virtio_vhost_queue_status() validates the queue number
against the vhost device's global range (queue < hdev->vq_index +
hdev->nvqs), confirming that 'queue' is a global index.  But it then
indexes hdev->vqs[] directly with that global index.

hdev->vqs is allocated as g_new0(struct vhost_virtqueue, hdev->nvqs),
so valid local indices are 0..nvqs-1.  When hdev->vq_index > 0
(multiqueue vhost-net queue pairs other than the first), every access
hdev->vqs[queue] reads past the end of the array.

Use queue - hdev->vq_index to compute the local index, consistent with
the rest of vhost.c (e.g. vhost_virtqueue_pending/mask).

Fixes: 07536ddda73a ("qmp: add QMP commands for virtio/vhost queue-status")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260912042343.2362-1-lirongqing@baidu.com>
---
 hw/virtio/virtio-qmp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 8b7cd7a310..8d190c4c70 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -789,6 +789,7 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
 
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     struct vhost_dev *hdev = vdc->get_vhost(vdev);
+    int vq = queue - hdev->vq_index;
 
     if (queue < hdev->vq_index || queue >= hdev->vq_index + hdev->nvqs) {
         error_setg(errp, "Invalid vhost virtqueue number %d", queue);
@@ -797,15 +798,15 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
 
     status = g_new0(VirtVhostQueueStatus, 1);
     status->name = g_strdup(vdev->name);
-    status->kick = hdev->vqs[queue].kick;
-    status->call = hdev->vqs[queue].call;
-    status->num = hdev->vqs[queue].num;
-    status->desc_phys = hdev->vqs[queue].desc_phys;
-    status->desc_size = hdev->vqs[queue].desc_size;
-    status->avail_phys = hdev->vqs[queue].avail_phys;
-    status->avail_size = hdev->vqs[queue].avail_size;
-    status->used_phys = hdev->vqs[queue].used_phys;
-    status->used_size = hdev->vqs[queue].used_size;
+    status->kick = hdev->vqs[vq].kick;
+    status->call = hdev->vqs[vq].call;
+    status->num = hdev->vqs[vq].num;
+    status->desc_phys = hdev->vqs[vq].desc_phys;
+    status->desc_size = hdev->vqs[vq].desc_size;
+    status->avail_phys = hdev->vqs[vq].avail_phys;
+    status->avail_size = hdev->vqs[vq].avail_size;
+    status->used_phys = hdev->vqs[vq].used_phys;
+    status->used_size = hdev->vqs[vq].used_size;
 
     return status;
 }
-- 
MST


