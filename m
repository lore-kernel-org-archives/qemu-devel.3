Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9FECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDl-0007TI-1x; Sun, 05 Oct 2025 15:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDd-0007Rj-5q
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDa-0006MQ-AT
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WH77u1+96mDkB/R2j+jCbflBTMYfZQxMDJ7RQLEIVkk=;
 b=DPerjUJ5fIlXa56YU9iK5gXmr8jm7+Fx9yy0G8DIe97mfNKreON0nsOCnjIu5XB3yBNFC5
 5ypKGtZQ+VzXfQfBEHv4MzgNUkn+A0j9iOZTpFMQuY+ms7p9ppt1oO3iH43EwXASmkgg7t
 fdPOKpmPlPjp4acR9UVcxFcXYLaGSa4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-pc4qlaD4OZ67nJTk8gdkdA-1; Sun, 05 Oct 2025 15:16:23 -0400
X-MC-Unique: pc4qlaD4OZ67nJTk8gdkdA-1
X-Mimecast-MFC-AGG-ID: pc4qlaD4OZ67nJTk8gdkdA_1759691782
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ef9218daf5so3095961f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691782; x=1760296582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WH77u1+96mDkB/R2j+jCbflBTMYfZQxMDJ7RQLEIVkk=;
 b=K7VPZuuZM3fqxOMnJyhP7Jh7VdMMLBxSnVtBgaU+QrcgkJ2QO4rCX7kr2ZntPr9Wt7
 LUBIVLiRwT0dkFTHqbWYRWhNRi2ki9qScQWaB39iF/aDtA8CzeVzaUMYYq/wIt6ocR+p
 /hgq0zB7EI1HF0x1aOpCO1h3Qiv/60loD7Y+LeNFqmUi2b3HubX6m2baq6rVFzDH/pCT
 bXzpuNnAn6iPSd4szzxNKkKEDc+HfyIPzY+iuWlUdGu7CD+Iq8wh+6fm3VN1ZOxgcX13
 0h3hWZUP1QRvUCLM3b9aI99P8OHlGJWc5RTljv+YCvFMqoZoBq/kzrLh94IGNV8qhnlM
 3dwg==
X-Gm-Message-State: AOJu0YxQIsyocqeInSeJu7Vh9BrvRz7LCQVTFgEopsKa/OWZ/Gw4MYyn
 W6Upp4EYvjQhfQzqGGD/Sqlr4R3hV0zqyJPKGYMynBBvzSiF627kQY+cJEvwW1N06c8nVdPhgo2
 aQd3wH9NQQVXykF4szMzvhoAzouiEiMazDM6+FMnk7C9fE4B1HCkKR3NknoT8h/QUb8ku0jQIDN
 rY52WBFkjN8DG16v2xlIyoXkbpT5USnKAyEA==
X-Gm-Gg: ASbGncvhBUEEquBwVvRPK2UyU7pOh1PwIw77jYg2V8TSV8cX40yqszLGjJFSggu+wK8
 5Xu+9GxK9PFhfy2ZrIIKCmV2qrVwWxPNKVSXp35MZB08KBRouvoUTIhM9tWP0GgQYBUGEqokgBy
 +YuZ6cdBWO1FP8iuiTHu9BVvH5cxMUHaMPYPFdtVVHG68sL5llZAT2tfhM6UKZkw4w8jQnnp9Mv
 oskkzNYHlLc0xjZ21sEM66AGxVFdiREhTsFwx3BzDRA+bdF8DBHDJiLSHxO+KPL12hvQj4CmFDh
 tylGKZuZYx7iCYvq5tGK6GyoGW5eT0skokZ7Xrs=
X-Received: by 2002:a05:6000:2386:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-425671a92f2mr5277708f8f.30.1759691781698; 
 Sun, 05 Oct 2025 12:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKgr6PbFMDjTuF2vhS8IJwprAbxR4/bkSVCIkxkTOFjrlPH4LoWJrOVxW/Xoh+BnUpmTcIjg==
X-Received: by 2002:a05:6000:2386:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-425671a92f2mr5277693f8f.30.1759691781122; 
 Sun, 05 Oct 2025 12:16:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm17440523f8f.6.2025.10.05.12.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:20 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 08/75] vhost: add support for negotiating extended features
Message-ID: <9f979ef0e01a2dd47d167c482a9e2d1dcdff2d3f.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

Similar to virtio infra, vhost core maintains the features status
in the full extended format and allows the devices to implement
extended version of the getter/setter.

Note that 'protocol_features' are not extended: they are only
used by vhost-user, and the latter device is not going to implement
extended features soon.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <a0062c3b1847fb2baedd6cd8f6ef13b051d6beb2.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h |  6 +++
 include/hw/virtio/vhost.h         | 56 +++++++++++++++++++++----
 hw/virtio/vhost.c                 | 68 ++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 27 deletions(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209a2f..ff94fa1734 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -95,6 +95,10 @@ typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
                                    struct vhost_worker_state *worker);
 typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
                                     struct vhost_worker_state *worker);
+typedef int (*vhost_set_features_ex_op)(struct vhost_dev *dev,
+                                        const uint64_t *features);
+typedef int (*vhost_get_features_ex_op)(struct vhost_dev *dev,
+                                        uint64_t *features);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -186,6 +190,8 @@ typedef struct VhostOps {
     vhost_free_worker_op vhost_free_worker;
     vhost_get_vring_worker_op vhost_get_vring_worker;
     vhost_attach_vring_worker_op vhost_attach_vring_worker;
+    vhost_set_features_ex_op vhost_set_features_ex;
+    vhost_get_features_ex_op vhost_get_features_ex;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 66be6afc88..08bbb4dfe9 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -107,9 +107,9 @@ struct vhost_dev {
      * future use should be discouraged and the variable retired as
      * its easy to confuse with the VirtIO backend_features.
      */
-    uint64_t features;
-    uint64_t acked_features;
-    uint64_t backend_features;
+    VIRTIO_DECLARE_FEATURES(features);
+    VIRTIO_DECLARE_FEATURES(acked_features);
+    VIRTIO_DECLARE_FEATURES(backend_features);
 
     /**
      * @protocol_features: is the vhost-user only feature set by
@@ -320,6 +320,20 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
 void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
                           bool mask);
 
+/**
+ * vhost_get_features_ex() - sanitize the extended features set
+ * @hdev: common vhost_dev structure
+ * @feature_bits: pointer to terminated table of feature bits
+ * @features: original features set, filtered out on return
+ *
+ * This is the extended variant of vhost_get_features(), supporting the
+ * the extended features set. Filter it with the intersection of what is
+ * supported by the vhost backend (hdev->features) and the supported
+ * feature_bits.
+ */
+void vhost_get_features_ex(struct vhost_dev *hdev,
+                           const int *feature_bits,
+                           uint64_t *features);
 /**
  * vhost_get_features() - return a sanitised set of feature bits
  * @hdev: common vhost_dev structure
@@ -330,8 +344,28 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
  * is supported by the vhost backend (hdev->features), the supported
  * feature_bits and the requested feature set.
  */
-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-                            uint64_t features);
+static inline uint64_t vhost_get_features(struct vhost_dev *hdev,
+                                          const int *feature_bits,
+                                          uint64_t features)
+{
+    uint64_t features_ex[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_ex, features);
+    vhost_get_features_ex(hdev, feature_bits, features_ex);
+    return features_ex[0];
+}
+
+/**
+ * vhost_ack_features_ex() - set vhost full set of acked_features
+ * @hdev: common vhost_dev structure
+ * @feature_bits: pointer to terminated table of feature bits
+ * @features: requested feature set
+ *
+ * This sets the internal hdev->acked_features to the intersection of
+ * the backends advertised features and the supported feature_bits.
+ */
+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
+                           const uint64_t *features);
 
 /**
  * vhost_ack_features() - set vhost acked_features
@@ -342,8 +376,16 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
  * This sets the internal hdev->acked_features to the intersection of
  * the backends advertised features and the supported feature_bits.
  */
-void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-                        uint64_t features);
+static inline void vhost_ack_features(struct vhost_dev *hdev,
+                                      const int *feature_bits,
+                                      uint64_t features)
+{
+    uint64_t features_ex[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_ex, features);
+    vhost_ack_features_ex(hdev, feature_bits, features_ex);
+}
+
 unsigned int vhost_get_max_memslots(void);
 unsigned int vhost_get_free_memslots(void);
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12..5f485ad6cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
 static int vhost_dev_set_features(struct vhost_dev *dev,
                                   bool enable_log)
 {
-    uint64_t features = dev->acked_features;
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     int r;
+
+    virtio_features_copy(features, dev->acked_features_ex);
     if (enable_log) {
-        features |= 0x1ULL << VHOST_F_LOG_ALL;
+        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
     }
     if (!vhost_dev_has_iommu(dev)) {
-        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
+        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
     }
     if (dev->vhost_ops->vhost_force_iommu) {
         if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
-            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
+            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
        }
     }
-    r = dev->vhost_ops->vhost_set_features(dev, features);
+
+    if (virtio_features_use_ex(features) &&
+        !dev->vhost_ops->vhost_set_features_ex) {
+        r = -EINVAL;
+        VHOST_OPS_DEBUG(r, "extended features without device support");
+        goto out;
+    }
+
+    if (dev->vhost_ops->vhost_set_features_ex) {
+        r = dev->vhost_ops->vhost_set_features_ex(dev, features);
+    } else {
+        r = dev->vhost_ops->vhost_set_features(dev, features[0]);
+    }
     if (r < 0) {
         VHOST_OPS_DEBUG(r, "vhost_set_features failed");
         goto out;
@@ -1508,12 +1522,27 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
+static int vhost_dev_get_features(struct vhost_dev *hdev,
+                                  uint64_t *features)
+{
+    uint64_t features64;
+    int r;
+
+    if (hdev->vhost_ops->vhost_get_features_ex) {
+        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
+    }
+
+    r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
+    virtio_features_from_u64(features, features64);
+    return r;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     unsigned int used, reserved, limit;
-    uint64_t features;
     int i, r, n_initialized_vqs = 0;
 
     hdev->vdev = NULL;
@@ -1533,7 +1562,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_get_features(hdev, &features);
+    r = vhost_dev_get_features(hdev, features);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_get_features failed");
         goto fail;
@@ -1571,7 +1600,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    hdev->features = features;
+    virtio_features_copy(hdev->features_ex, features);
 
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
@@ -1594,7 +1623,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     };
 
     if (hdev->migration_blocker == NULL) {
-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
+        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL)) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
@@ -1859,28 +1888,27 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
     }
 }
 
-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-                            uint64_t features)
+void vhost_get_features_ex(struct vhost_dev *hdev,
+                           const int *feature_bits,
+                           uint64_t *features)
 {
     const int *bit = feature_bits;
+
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        uint64_t bit_mask = (1ULL << *bit);
-        if (!(hdev->features & bit_mask)) {
-            features &= ~bit_mask;
+        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
+            virtio_clear_feature_ex(features, *bit);
         }
         bit++;
     }
-    return features;
 }
 
-void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-                        uint64_t features)
+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
+                           const uint64_t *features)
 {
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        uint64_t bit_mask = (1ULL << *bit);
-        if (features & bit_mask) {
-            hdev->acked_features |= bit_mask;
+        if (virtio_has_feature_ex(features, *bit)) {
+            virtio_add_feature_ex(hdev->acked_features_ex, *bit);
         }
         bit++;
     }
-- 
MST


