Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117DBCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrI6-0006Tr-Ta; Wed, 17 Sep 2025 08:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrI4-0006TC-05
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrI1-0001QD-I8
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758112176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVg9lzBlwJmtLvEZRUbXOi28CZd+sKgnb8v5YHrZTd8=;
 b=Uu2c+DHJE0xs5b+35dxIPadD3n7v6aM4z/HGbaxDoOI3J2ILG0dgLaLW+G3dHttVAnMvHD
 8UNT481MztLZ4eVqFEIbBlEooJcf83V1uWBmU2RkC+CX+pnbJ8h8AuD+fJc6h6mf9PNAVQ
 fX/KWClJTG+sq00sMLCoMtyOZgtEg0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-RBU5gDknPL-6kQwxNsGCEw-1; Wed, 17 Sep 2025 08:29:34 -0400
X-MC-Unique: RBU5gDknPL-6kQwxNsGCEw-1
X-Mimecast-MFC-AGG-ID: RBU5gDknPL-6kQwxNsGCEw_1758112174
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45df7e734e0so40509265e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112173; x=1758716973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVg9lzBlwJmtLvEZRUbXOi28CZd+sKgnb8v5YHrZTd8=;
 b=Ar2hQ3zWxfvl9gQTKrkKuvC9PkzeEHo6ckvh8JYB87DkBaPcvEoIdQ+Lzi7tIs2uWk
 pwRp/fn08f+sMPdggwpjKGloMXws/x6umSXvUJoHIqhFBrO+O/C+VCA1a1/gM6IAdGYY
 1I1duJUBMk14h9OAVJPL/2INl9HJl2YwU0JUI2IkJ/SS9lK39DmHv7/M+7Uc+ivBMTKp
 RjKjzcyiST/qaN7swaWEACQ/rmsRrVKi91KhgKZ56f9+Gez+5CPaROAbfUu7y9mPoW2v
 u2f6g0L4C2BeOLEb5BxPuYRpNURFXg/0hExFV2F6Kj7RCj/zY9DEXDEJsJksWLrDkWNR
 +9NQ==
X-Gm-Message-State: AOJu0Yzm4h3wemRTPNrYmq1GSgEXkFOpzN5YvUwKQ4YbDh6jRlXa13wN
 72zihLQ3i6XaBOMHmd8GPlAr7LeN3YcyJr0csShTLLyYg0eDg+fS0j9bqBlb0H6slyJi8uWyhqL
 xOAI/7+24oqUAZ+cCd/QheGIxFSZh0BQurDAd6wlUkKI9RlydLkRPlbyv
X-Gm-Gg: ASbGncs/3P+W37ZcATqar9FVM+VHj8jkZHa9gN8Mi8hpuHBbVMrIRQ+YuoeK1ufMXmv
 4KUhwDOXr0cZa1GKDoPhFDb9ouyXTh2zc2kCUpqj32/YYxLqxNRLe7JPL21O/KQg+aM2pvGEcRy
 GD8kwdVGWFqmelUV9n6s5jgk9+P2fSt8aH6RDenPhCPGzi9YrvUix4AiLlog9wqaZGDQTweofzz
 DtXVjg2haysdZUF8mV8jAn31Y8jCSWX+uBK3/Y/Cphogz1eeB4skb3CXZv83rmFuwVhvmInrPJj
 0Esingyu1eK8ajRWmER83GsTgOfJOvRTCB9TqvN5eHyt
X-Received: by 2002:a05:600c:1549:b0:45d:cfc6:5166 with SMTP id
 5b1f17b1804b1-46205eb142emr20747445e9.23.1758112173509; 
 Wed, 17 Sep 2025 05:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwqlsYuIdk+UkguMDbU97Vr95ENkKAEivZmD7l47fH/+OA3Hfoq29bfBb3K0AFH3aLl6OSSQ==
X-Received: by 2002:a05:600c:1549:b0:45d:cfc6:5166 with SMTP id
 5b1f17b1804b1-46205eb142emr20747005e9.23.1758112172932; 
 Wed, 17 Sep 2025 05:29:32 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613869528bsm35682525e9.14.2025.09.17.05.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:29:32 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:29:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 08/14] vhost: add support for negotiating extended
 features
Message-ID: <bfqz5lugh6mhr45enggp5rrvjm3lwwppwk4hbbaqko2l4sdtmy@essbkol3nxru>
References: <cover.1757676218.git.pabeni@redhat.com>
 <d5da8b7725f2db9faba1133f6a6d6abf62f3fe35.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d5da8b7725f2db9faba1133f6a6d6abf62f3fe35.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 12, 2025 at 03:06:59PM +0200, Paolo Abeni wrote:
>Similar to virtio infra, vhost core maintains the features status
>in the full extended format and allows the devices to implement
>extended version of the getter/setter.
>
>Note that 'protocol_features' are not extended: they are only
>used by vhost-user, and the latter device is not going to implement
>extended features soon.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v3 -> v4:
>  - fix compile warning for real :(
>  - de-duplicate code from vhost_{get,ack}_features and
>    vhost_{get,ack}_features_ex
>  - use new virtio_features macro names
>
>v2 -> v3:
>  - fix compile warning
>  - _array -> _ex
>
>v1 -> v2:
>  - uint128_t -> uint64_t[]
>  - add _ex() variant of features manipulation helpers
>---
> hw/virtio/vhost.c                 | 68 ++++++++++++++++++++++---------
> include/hw/virtio/vhost-backend.h |  6 +++
> include/hw/virtio/vhost.h         | 56 +++++++++++++++++++++----
> 3 files changed, 103 insertions(+), 27 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6557c58d12..5f485ad6cb 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> static int vhost_dev_set_features(struct vhost_dev *dev,
>                                   bool enable_log)
> {
>-    uint64_t features = dev->acked_features;
>+    uint64_t features[VIRTIO_FEATURES_NU64S];
>     int r;
>+
>+    virtio_features_copy(features, dev->acked_features_ex);
>     if (enable_log) {
>-        features |= 0x1ULL << VHOST_F_LOG_ALL;
>+        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
>     }
>     if (!vhost_dev_has_iommu(dev)) {
>-        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
>+        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>     }
>     if (dev->vhost_ops->vhost_force_iommu) {
>         if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
>-            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
>+            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>        }
>     }
>-    r = dev->vhost_ops->vhost_set_features(dev, features);
>+
>+    if (virtio_features_use_ex(features) &&
>+        !dev->vhost_ops->vhost_set_features_ex) {
>+        r = -EINVAL;
>+        VHOST_OPS_DEBUG(r, "extended features without device support");
>+        goto out;
>+    }
>+
>+    if (dev->vhost_ops->vhost_set_features_ex) {
>+        r = dev->vhost_ops->vhost_set_features_ex(dev, features);
>+    } else {
>+        r = dev->vhost_ops->vhost_set_features(dev, features[0]);
>+    }
>     if (r < 0) {
>         VHOST_OPS_DEBUG(r, "vhost_set_features failed");
>         goto out;
>@@ -1508,12 +1522,27 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>     }
> }
>
>+static int vhost_dev_get_features(struct vhost_dev *hdev,
>+                                  uint64_t *features)
>+{
>+    uint64_t features64;
>+    int r;
>+
>+    if (hdev->vhost_ops->vhost_get_features_ex) {
>+        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
>+    }
>+
>+    r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
>+    virtio_features_from_u64(features, features64);
>+    return r;
>+}
>+
> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>                    Error **errp)
> {
>+    uint64_t features[VIRTIO_FEATURES_NU64S];
>     unsigned int used, reserved, limit;
>-    uint64_t features;
>     int i, r, n_initialized_vqs = 0;
>
>     hdev->vdev = NULL;
>@@ -1533,7 +1562,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         goto fail;
>     }
>
>-    r = hdev->vhost_ops->vhost_get_features(hdev, &features);
>+    r = vhost_dev_get_features(hdev, features);
>     if (r < 0) {
>         error_setg_errno(errp, -r, "vhost_get_features failed");
>         goto fail;
>@@ -1571,7 +1600,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         }
>     }
>
>-    hdev->features = features;
>+    virtio_features_copy(hdev->features_ex, features);
>
>     hdev->memory_listener = (MemoryListener) {
>         .name = "vhost",
>@@ -1594,7 +1623,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>     };
>
>     if (hdev->migration_blocker == NULL) {
>-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
>+        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL)) {
>             error_setg(&hdev->migration_blocker,
>                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
>         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
>@@ -1859,28 +1888,27 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
>     }
> }
>
>-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>-                            uint64_t features)
>+void vhost_get_features_ex(struct vhost_dev *hdev,
>+                           const int *feature_bits,
>+                           uint64_t *features)
> {
>     const int *bit = feature_bits;
>+
>     while (*bit != VHOST_INVALID_FEATURE_BIT) {
>-        uint64_t bit_mask = (1ULL << *bit);
>-        if (!(hdev->features & bit_mask)) {
>-            features &= ~bit_mask;
>+        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
>+            virtio_clear_feature_ex(features, *bit);
>         }
>         bit++;
>     }
>-    return features;
> }
>
>-void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>-                        uint64_t features)
>+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
>+                           const uint64_t *features)
> {
>     const int *bit = feature_bits;
>     while (*bit != VHOST_INVALID_FEATURE_BIT) {
>-        uint64_t bit_mask = (1ULL << *bit);
>-        if (features & bit_mask) {
>-            hdev->acked_features |= bit_mask;
>+        if (virtio_has_feature_ex(features, *bit)) {
>+            virtio_add_feature_ex(hdev->acked_features_ex, *bit);
>         }
>         bit++;
>     }
>diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>index d6df209a2f..ff94fa1734 100644
>--- a/include/hw/virtio/vhost-backend.h
>+++ b/include/hw/virtio/vhost-backend.h
>@@ -95,6 +95,10 @@ typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
>                                    struct vhost_worker_state *worker);
> typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
>                                     struct vhost_worker_state *worker);
>+typedef int (*vhost_set_features_ex_op)(struct vhost_dev *dev,
>+                                        const uint64_t *features);
>+typedef int (*vhost_get_features_ex_op)(struct vhost_dev *dev,
>+                                        uint64_t *features);
> typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
>                                      uint64_t features);
> typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
>@@ -186,6 +190,8 @@ typedef struct VhostOps {
>     vhost_free_worker_op vhost_free_worker;
>     vhost_get_vring_worker_op vhost_get_vring_worker;
>     vhost_attach_vring_worker_op vhost_attach_vring_worker;
>+    vhost_set_features_ex_op vhost_set_features_ex;
>+    vhost_get_features_ex_op vhost_get_features_ex;
>     vhost_set_features_op vhost_set_features;
>     vhost_get_features_op vhost_get_features;
>     vhost_set_backend_cap_op vhost_set_backend_cap;
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index 66be6afc88..08bbb4dfe9 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -107,9 +107,9 @@ struct vhost_dev {
>      * future use should be discouraged and the variable retired as
>      * its easy to confuse with the VirtIO backend_features.
>      */
>-    uint64_t features;
>-    uint64_t acked_features;
>-    uint64_t backend_features;
>+    VIRTIO_DECLARE_FEATURES(features);
>+    VIRTIO_DECLARE_FEATURES(acked_features);
>+    VIRTIO_DECLARE_FEATURES(backend_features);
>
>     /**
>      * @protocol_features: is the vhost-user only feature set by
>@@ -320,6 +320,20 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
> void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                           bool mask);
>
>+/**
>+ * vhost_get_features_ex() - sanitize the extended features set
>+ * @hdev: common vhost_dev structure
>+ * @feature_bits: pointer to terminated table of feature bits
>+ * @features: original features set, filtered out on return
>+ *
>+ * This is the extended variant of vhost_get_features(), supporting the
>+ * the extended features set. Filter it with the intersection of what is
>+ * supported by the vhost backend (hdev->features) and the supported
>+ * feature_bits.
>+ */
>+void vhost_get_features_ex(struct vhost_dev *hdev,
>+                           const int *feature_bits,
>+                           uint64_t *features);
> /**
>  * vhost_get_features() - return a sanitised set of feature bits
>  * @hdev: common vhost_dev structure
>@@ -330,8 +344,28 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>  * is supported by the vhost backend (hdev->features), the supported
>  * feature_bits and the requested feature set.
>  */
>-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>-                            uint64_t features);
>+static inline uint64_t vhost_get_features(struct vhost_dev *hdev,
>+                                          const int *feature_bits,
>+                                          uint64_t features)
>+{
>+    uint64_t features_ex[VIRTIO_FEATURES_NU64S];
>+
>+    virtio_features_from_u64(features_ex, features);
>+    vhost_get_features_ex(hdev, feature_bits, features_ex);
>+    return features_ex[0];
>+}
>+
>+/**
>+ * vhost_ack_features_ex() - set vhost full set of acked_features
>+ * @hdev: common vhost_dev structure
>+ * @feature_bits: pointer to terminated table of feature bits
>+ * @features: requested feature set
>+ *
>+ * This sets the internal hdev->acked_features to the intersection of
>+ * the backends advertised features and the supported feature_bits.
>+ */
>+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
>+                           const uint64_t *features);
>
> /**
>  * vhost_ack_features() - set vhost acked_features
>@@ -342,8 +376,16 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>  * This sets the internal hdev->acked_features to the intersection of
>  * the backends advertised features and the supported feature_bits.
>  */
>-void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>-                        uint64_t features);
>+static inline void vhost_ack_features(struct vhost_dev *hdev,
>+                                      const int *feature_bits,
>+                                      uint64_t features)
>+{
>+    uint64_t features_ex[VIRTIO_FEATURES_NU64S];
>+
>+    virtio_features_from_u64(features_ex, features);
>+    vhost_ack_features_ex(hdev, feature_bits, features_ex);
>+}
>+
> unsigned int vhost_get_max_memslots(void);
> unsigned int vhost_get_free_memslots(void);
>
>-- 
>2.51.0
>


