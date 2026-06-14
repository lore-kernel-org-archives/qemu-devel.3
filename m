Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F26CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBh-00042i-5U; Sun, 14 Jun 2026 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBf-0003rn-N5
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBd-00024U-Jx
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pt0EyeSxg4/HAYXjOQeT2VvKcIzpOhnnRGb8xdH0H7c=;
 b=Yuc5IEBxySOYFbZN5R1DmGPP1AM907WwOOHQPKX6+X/mOYMisg2++VisFoDtERdIu57BSb
 YzTxqnC51PaCqjl8rYU2rZ9LIPEROirbbdH7zjQMVJnvtO1D8rSwTRecU/yuUUlkqwwTK6
 fI/IUnq85l2dFHbo7oBynb1eAuX0yFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-fuzp1SePOp6ffkH4yLtNbw-1; Sun, 14 Jun 2026 15:07:59 -0400
X-MC-Unique: fuzp1SePOp6ffkH4yLtNbw-1
X-Mimecast-MFC-AGG-ID: fuzp1SePOp6ffkH4yLtNbw_1781464078
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so19275395e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464078; x=1782068878; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pt0EyeSxg4/HAYXjOQeT2VvKcIzpOhnnRGb8xdH0H7c=;
 b=nvlVU7jCSlJh103s08DH2j2XyzYsMH5bXu9WwepXIwgbVl40VNTvxGzhnybUbJvuJX
 eKqlqqW284WG6T1Bc6CCYg0qhDp9N46Qfj6vnkN3yTSU7T4VSKilvxid4HBU6MbGP8L+
 tUcjX+fnJr2VcdfSnj+wm0S46FrAya5Ag9WCTLZ1BFFw/QAQSWuPPxnlFKmLF5dcYwQV
 I0DFfTvY+AHfCLZmsDlzoSx7BaxDGg1cJ7UPZUQvmkZZ+hlvft5aXZqtO9nv3o2DvcIF
 OuoRp/xkmj/7T+il1/TMnRysGBXlWFmQQA8Nfp5J26b8iq6cfeAhC8BAZz8eFLfxpuui
 1HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464078; x=1782068878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pt0EyeSxg4/HAYXjOQeT2VvKcIzpOhnnRGb8xdH0H7c=;
 b=T5xMSsVdr48FlS3Gyfg7kkL0MYvFtVEuvCkZ2T/POV0HaHbzsygJdvXCmpH+VNtf0R
 7AzA45pD29R/V4uwihB2KfWCUgWWU7rgyw9kVJ9cNQrqktX6v4HgsncDpj0SVJSOsw+o
 QseK1Fj3EQuNKV8L+Q9cvSPWaLIF/l5CBN7Px6YKvy/xJhHTDPMSvGgI4xsFQgQTuKry
 O2yRoOyDYzDEKshe0TQzyWKFsA5O8/TdYEDWea27KPK0Dazlcc3jXS/gyS3QA4flMeRg
 zRywM2fZhrAvjsOBbceblRRMTPzs7A9EfQtBK95aJhrjvX8E5Q8EPA2p5Jp0behgk2Sn
 aWXg==
X-Gm-Message-State: AOJu0Yxe1+Y0yGoxqPymeteLWo8thtujZ5ej1H+W2IEgI+F14xb/pFZt
 tknh5lmIXpUaPrtoMHhVfJ38fU84Ut64NQMXNZRlndGNowYMRloIIGWbZsisvB9QkbzvgG0N17H
 8PmxoU5mQvuy0ed7LWX+Y2aujH/YPVF0U56oW3imDge2teBcWjtyKB0+56a3uL/NU+Usu6STc9C
 lfg8Bii2VVl3aubVIKiJ0du2AB6MtrHG/z6A==
X-Gm-Gg: Acq92OFe5Cb+Z7FpWDg1SrcCSjlOIHB/ETlU0z9OPjRDmiaudyLeslRawTmOlGaGUQy
 VsfWyDZKFNPwLUVq3JHSxTCCEa4frx5c22wYRx4bLwa3Z5OZ3YWZnXOGGPT3QfVne3su6dt5UPf
 WLWtw7Lhhkz7v19zXdFzhrU7FbClb6c3xZ8sPyTxPE2BMYuqi2lReD+7ALj2g6wbNncMgQyxdFp
 Bhu11XoIjUAIAxgiKpM/gscaJ4S/Nzx2jbqTklqmN1oX/CaVdJGldxxi0vnb5vwwX5FeuNuoXbg
 W2c2EUOur96+ThkegqUNebaq6XcwloYBRbEAW6m10B4m76ftegpIDMePmn8A8jhHAcuPw8mUpj9
 gxQRNIxjnu9SFSRxXvGC8XK/kIfhNQRS/4RFc1Ql8TgQ=
X-Received: by 2002:a05:600c:a210:b0:490:e60b:5fcd with SMTP id
 5b1f17b1804b1-490ec521002mr87983895e9.32.1781464078154; 
 Sun, 14 Jun 2026 12:07:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a210:b0:490:e60b:5fcd with SMTP id
 5b1f17b1804b1-490ec521002mr87983605e9.32.1781464077509; 
 Sun, 14 Jun 2026 12:07:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037055csm191172275e9.13.2026.06.14.12.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:57 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 050/106] vhost: use consistent naming for backend handlers
Message-ID: <83a2e2ecc108b44e2a49ec44d2ff0150dac984a2.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Most of handlers start from simply .vhost_, except for these
four, starting from .vhost_backend_. Let's rename them to be
consistent.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-3-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-backend.c         |  6 +++---
 hw/virtio/vhost-user.c            |  8 ++++----
 hw/virtio/vhost-vdpa.c            |  6 +++---
 hw/virtio/vhost.c                 | 14 +++++++-------
 include/hw/virtio/vhost-backend.h | 17 ++++++++---------
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index fea88afc39..caeadd069b 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -358,9 +358,9 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
 
 const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
-        .vhost_backend_init = vhost_kernel_init,
-        .vhost_backend_cleanup = vhost_kernel_cleanup,
-        .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
+        .vhost_init = vhost_kernel_init,
+        .vhost_cleanup = vhost_kernel_cleanup,
+        .vhost_memslots_limit = vhost_kernel_memslots_limit,
         .vhost_net_set_backend = vhost_kernel_net_set_backend,
         .vhost_scsi_set_endpoint = vhost_kernel_scsi_set_endpoint,
         .vhost_scsi_clear_endpoint = vhost_kernel_scsi_clear_endpoint,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6978d8ee94..78ffb25d6b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -3115,10 +3115,10 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
-        .vhost_backend_init = vhost_user_backend_init,
-        .vhost_backend_cleanup = vhost_user_backend_cleanup,
-        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
-        .vhost_backend_no_private_memslots = vhost_user_no_private_memslots,
+        .vhost_init = vhost_user_backend_init,
+        .vhost_cleanup = vhost_user_backend_cleanup,
+        .vhost_memslots_limit = vhost_user_memslots_limit,
+        .vhost_no_private_memslots = vhost_user_no_private_memslots,
         .vhost_set_log_base = vhost_user_set_log_base,
         .vhost_set_mem_table = vhost_user_set_mem_table,
         .vhost_set_vring_addr = vhost_user_set_vring_addr,
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 9c7634e243..9347462489 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1590,8 +1590,8 @@ static bool  vhost_vdpa_force_iommu(struct vhost_dev *dev)
 
 const VhostOps vdpa_ops = {
         .backend_type = VHOST_BACKEND_TYPE_VDPA,
-        .vhost_backend_init = vhost_vdpa_init,
-        .vhost_backend_cleanup = vhost_vdpa_cleanup,
+        .vhost_init = vhost_vdpa_init,
+        .vhost_cleanup = vhost_vdpa_cleanup,
         .vhost_set_log_base = vhost_vdpa_set_log_base,
         .vhost_set_vring_addr = vhost_vdpa_set_vring_addr,
         .vhost_set_vring_num = vhost_vdpa_set_vring_num,
@@ -1602,7 +1602,7 @@ const VhostOps vdpa_ops = {
         .vhost_get_features = vhost_vdpa_get_features,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
-        .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
+        .vhost_memslots_limit = vhost_vdpa_memslots_limit,
         .vhost_set_mem_table = vhost_vdpa_set_mem_table,
         .vhost_set_features = vhost_vdpa_set_features,
         .vhost_reset_device = vhost_vdpa_reset_device,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4d42f8bda4..ffd7d404cc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -58,7 +58,7 @@ unsigned int vhost_get_max_memslots(void)
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        max = MIN(max, hdev->vhost_ops->vhost_backend_memslots_limit(hdev));
+        max = MIN(max, hdev->vhost_ops->vhost_memslots_limit(hdev));
     }
     return max;
 }
@@ -69,7 +69,7 @@ unsigned int vhost_get_free_memslots(void)
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+        unsigned int r = hdev->vhost_ops->vhost_memslots_limit(hdev);
         unsigned int cur_free = r - hdev->mem->nregions;
 
         if (unlikely(r < hdev->mem->nregions)) {
@@ -664,8 +664,8 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
          */
         if ((memory_region_get_fd(section->mr) < 0 ||
             !qemu_ram_is_shared(section->mr->ram_block)) &&
-            dev->vhost_ops->vhost_backend_no_private_memslots &&
-            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
+            dev->vhost_ops->vhost_no_private_memslots &&
+            dev->vhost_ops->vhost_no_private_memslots(dev)) {
             trace_vhost_reject_section(mr->name, 2);
             return false;
         }
@@ -1674,7 +1674,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
 
-    r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1691,7 +1691,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
         error_setg(errp, "some memory device (like virtio-mem)"
@@ -1809,7 +1809,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
-        hdev->vhost_ops->vhost_backend_cleanup(hdev);
+        hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 57497e197a..aab6bf3ef7 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -51,10 +51,9 @@ struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
 
-typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque,
-                                  Error **errp);
-typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
-typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
+typedef int (*vhost_init)(struct vhost_dev *dev, void *opaque, Error **errp);
+typedef int (*vhost_cleanup)(struct vhost_dev *dev);
+typedef int (*vhost_memslots_limit)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
@@ -131,7 +130,7 @@ typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
 typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
                                              uint64_t session_id);
 
-typedef bool (*vhost_backend_no_private_memslots_op)(struct vhost_dev *dev);
+typedef bool (*vhost_no_private_memslots_op)(struct vhost_dev *dev);
 
 typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
                                         uint16_t queue_size,
@@ -166,10 +165,10 @@ typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
-    vhost_backend_init vhost_backend_init;
-    vhost_backend_cleanup vhost_backend_cleanup;
-    vhost_backend_memslots_limit vhost_backend_memslots_limit;
-    vhost_backend_no_private_memslots_op vhost_backend_no_private_memslots;
+    vhost_init vhost_init;
+    vhost_cleanup vhost_cleanup;
+    vhost_memslots_limit vhost_memslots_limit;
+    vhost_no_private_memslots_op vhost_no_private_memslots;
     vhost_net_set_backend_op vhost_net_set_backend;
     vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
-- 
MST


