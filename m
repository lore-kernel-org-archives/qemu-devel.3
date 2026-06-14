Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61353CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBk-0004Wo-Sn; Sun, 14 Jun 2026 15:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBj-0004IV-8V
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBh-00025l-Co
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlDgjrdCBxb5NnIPdmBEmzWvRwRkTmziOuRUeAZBzBs=;
 b=e1TlBBOGE57rbQWTvFv7w4Ra2dlqZnE/iKegpC0LTPpJzoQhbA2mKgFaVoq7kDaymxEHWO
 ys33yJ50e7XRbbQiAGXvAnfIztU+3aX8CzNZmRkg4vWojT6DeoKAjoTrDOsv+heNpM3r3f
 zzgc/zbXpvuZAtMVLXXTDJrAwPZgxyY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4C0WhOzuOcSuzIqDeLQkqw-1; Sun, 14 Jun 2026 15:08:03 -0400
X-MC-Unique: 4C0WhOzuOcSuzIqDeLQkqw-1
X-Mimecast-MFC-AGG-ID: 4C0WhOzuOcSuzIqDeLQkqw_1781464082
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef4931de5so2132154f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464082; x=1782068882; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NlDgjrdCBxb5NnIPdmBEmzWvRwRkTmziOuRUeAZBzBs=;
 b=jqykcBOwZVsRnv83XFZ5cUCnvJ2UtJ9l6d7RracCYaYyt75G8U9rruPhtaOH6m08jz
 uIeu4DzxSUF99tdw5BykEraliWd5QvRCz5SyOtfeIF6GJaV2JWjjVenRa9NQNZbW4WCZ
 /3RcuPLRzTZBRy4Xkbi3+vwanMQ/Kql20DKJeJYhik5SEzMgbo9EOilxySETu3yCNmlT
 kjsB7oOj5OjccL33tDg1gXAQ9ADoC3MIP0B+NsiyRTwj8fKq+xf+g9gwW6c983qlCEk9
 /CW2VH/yL8hO623pbgG9E9oQtfopp3k6RkRhEyh00oTHwV6AWKcPxfAHoYetXMOyDBWu
 Lnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464082; x=1782068882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlDgjrdCBxb5NnIPdmBEmzWvRwRkTmziOuRUeAZBzBs=;
 b=TVQgvCQL/2nzOCNF7u1l8rsolL4Y/GA9W4jgyhmMXpDvIj5tgV9ClSX72hy3KLO7nT
 yzqdOpT9lMhHJNXHQvIklhmDdQytJ71g/YOrnApifW2ZwxugHlU936BxPjILIShg4FVw
 b/G5lV5khBcxITkynEXCTfWnChMSTBD/3oZxIVpeYvBql/RA178MkMePaGck9pjCgM79
 zjTZqEXgbNvZUOiWN0CW76ribQCNk53qH6IoeAAeKVjlpixPzAELHvPmRdISGeaXe5YK
 HNWR3ng1+3yqXS/2SKVjw5T4yx6q5FUHW6CNdyJASZbeUZYU1D7+0FbyyM6YlsU+pJMW
 jCyw==
X-Gm-Message-State: AOJu0Yy99n6ra7Gja3eDG2eaUNOfrHz5ULQSQjABqiw0yzwwEi0+c9ds
 0HNuFeEI0FeIw9bPozmKkhBKRkJUIJTvX225cgu1u2ENWZYv4aI5lIIDte7Qp28B8JujFavQaD7
 CwNv8HTsV5ccLF0y8ryekUdhA5zMHfS6fkgPcMcKKXtq01FT/ZvMuHg5w0by5FEwsm03CEo3q3g
 yWGFlK4IIvPmnJ+akrrMK3dPFezJlMEmzMQA==
X-Gm-Gg: Acq92OHOroo6bXBzG9JFsJ/5TiZ1Pw4KJzuFkekpms/Si59ngtVU0QjGNcNMbkS54px
 SNOkAYMvIjana6t1lhu8GDoMsFgk9S7J+JwmHfw7uctOAR2vvrVwpcJzL9z/thkOhTxisauUCn/
 e0xdC6jpFijv5JZe/IXv8k5KH13GIVMR9X5KGVd04PeYE5YCGKArObDKw4B/QuJMfSMhlypUn0m
 oWZ2povCaMt+DfX5Gwb618XGJiUqVw/OsvSSLRdUHYJN1viI/dmdlXkAuvC6szSbB8JkyPxtIqe
 uF37I4JAzj68hsZTj147+BX8JA5rqjaOBdd6kP0gVcpWp2jPxhq+lY+PKAnaiZTg8iA0YzVc9CF
 NBgVtiHMwcR6Ak67eFbzje29CBAh0eonUwdL6GumOLjk=
X-Received: by 2002:a05:600c:1d02:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490ec48fec5mr124792445e9.6.1781464082030; 
 Sun, 14 Jun 2026 12:08:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1d02:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490ec48fec5mr124792085e9.6.1781464081439; 
 Sun, 14 Jun 2026 12:08:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033dd3esm176523705e9.8.2026.06.14.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:01 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 052/106] vhost: replace .vhost_vq_get_addr() with
 .vhost_phys_vring_addr()
Message-ID: <a471e5b50c212d4584b5c742be8a865dfe8bd68c.1781463125.git.mst@redhat.com>
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

Make a simper handler to consolidate the logic in one place. That
helps further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-5-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-vdpa.c            | 13 +++----------
 hw/virtio/vhost.c                 | 12 ++++++------
 include/hw/virtio/vhost-backend.h |  6 ++----
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 9347462489..9e1aa4860a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1571,16 +1571,9 @@ static int vhost_vdpa_set_owner(struct vhost_dev *dev)
     return 0;
 }
 
-static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
-                    struct vhost_vring_addr *addr, struct vhost_virtqueue *vq)
+static bool vhost_vdpa_phys_vring_addr(struct vhost_dev *dev)
 {
-    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
-    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
-    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
-    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
-    trace_vhost_vdpa_vq_get_addr(dev, vq, addr->desc_user_addr,
-                                 addr->avail_user_addr, addr->used_user_addr);
-    return 0;
+    return true;
 }
 
 static bool  vhost_vdpa_force_iommu(struct vhost_dev *dev)
@@ -1617,7 +1610,7 @@ const VhostOps vdpa_ops = {
         .vhost_send_device_iotlb_msg = NULL,
         .vhost_dev_start = vhost_vdpa_dev_start,
         .vhost_get_device_id = vhost_vdpa_get_device_id,
-        .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
+        .vhost_phys_vring_addr = vhost_vdpa_phys_vring_addr,
         .vhost_force_iommu = vhost_vdpa_force_iommu,
         .vhost_set_config_call = vhost_vdpa_set_config_call,
         .vhost_reset_status = vhost_vdpa_reset_status,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ffd7d404cc..564a5d4698 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1093,16 +1093,16 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
                                     struct vhost_virtqueue *vq,
                                     unsigned idx, bool enable_log)
 {
+    bool phys = dev->vhost_ops->vhost_phys_vring_addr &&
+        dev->vhost_ops->vhost_phys_vring_addr(dev);
     struct vhost_vring_addr addr;
     int r;
     memset(&addr, 0, sizeof(struct vhost_vring_addr));
 
-    if (dev->vhost_ops->vhost_vq_get_addr) {
-        r = dev->vhost_ops->vhost_vq_get_addr(dev, &addr, vq);
-        if (r < 0) {
-            VHOST_OPS_DEBUG(r, "vhost_vq_get_addr failed");
-            return r;
-        }
+    if (phys) {
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
     } else {
         addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc;
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index aab6bf3ef7..7cc3bb5441 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -141,9 +141,7 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
 
 typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
 
-typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
-                    struct vhost_vring_addr *addr,
-                    struct vhost_virtqueue *vq);
+typedef bool (*vhost_phys_vring_addr_op)(struct vhost_dev *dev);
 
 typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 
@@ -211,7 +209,7 @@ typedef struct VhostOps {
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
-    vhost_vq_get_addr_op  vhost_vq_get_addr;
+    vhost_phys_vring_addr_op vhost_phys_vring_addr;
     vhost_get_device_id_op vhost_get_device_id;
     vhost_force_iommu_op vhost_force_iommu;
     vhost_set_config_call_op vhost_set_config_call;
-- 
MST


