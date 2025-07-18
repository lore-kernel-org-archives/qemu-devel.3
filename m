Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B33EC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 14:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmDD-0008E3-8l; Fri, 18 Jul 2025 10:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucmDA-00083b-8v
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucmD7-0007xf-NJ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752849436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIvTCGMk5TPQQnybVDu4SfPYtYED0Zn6qyCpds2kKnA=;
 b=egKONe04MJNR5CGLoqPpj4Iz68rMYOGmlwzy5ksyn+8owxUK7rUNZfIaZRpTcQ8h1WbXJc
 j0XPsAsxx63mccB/E7OjszhgG91F/yLHG0nEdLLkh8AGTB5s/x/wAt1wyWYmetYg7HUYd3
 eTaMersFQWGOrF5YRKQ7MrGkgl/T8BQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4L687SMoNNqdi3yS3l_4QA-1; Fri, 18 Jul 2025 10:37:15 -0400
X-MC-Unique: 4L687SMoNNqdi3yS3l_4QA-1
X-Mimecast-MFC-AGG-ID: 4L687SMoNNqdi3yS3l_4QA_1752849435
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6facf4cf5e1so36294396d6.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752849435; x=1753454235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIvTCGMk5TPQQnybVDu4SfPYtYED0Zn6qyCpds2kKnA=;
 b=L1BIOdyIQmcmqIwXzFd3CPaDIkjXJwWSXUlfA+gXs9ongJ+4WAkp24msOuYq52SJdK
 kE+QeXYRmbrjPAYo4FVFfTz7RXpJw4irs+2PW1tSCaCzmy73bAk7ONrlzgwY+ZltU8ud
 8z0q8nP5sxXU2+TDlpieSQG4ar1CVMFGukBHlJvqMRgohgZzLD18PUX+dhWHuoX0LB9J
 eM5NhDYJFKlTx/rOUSSIZ1z7u+9dUYHNNI4jw9Smr2fP93it57hid7K19pnqDNTZzP/A
 BIjcEdlROFYC5IkcGR9FeEusOOjsuGf/oNn944bwyBjrjTXfKv8ZoX6Tv8Ep2mwfHHk3
 xL1Q==
X-Gm-Message-State: AOJu0Yxo4nAZnJqkgMU1W2GeFx5WB/EYLlcMbMAqoTuU81idtM/cGIP2
 XDNJV5RPN1Qoj03cPxVJyMhW2sC45h4QFvCrbxXvV3HuJjHvep/GOpiofi/CBnCmPkIfYdOVHWT
 ZjpHUjxMBXnE+cmqCekUF4+7jfyWVUnVuxfV/gZvnQyDQpf8bp0F6W642
X-Gm-Gg: ASbGncs2LAcjSdfmlGHxRFhmzROEaG15IDT2Oydt/QKPcvQZs4W06vkFoWP6rqnqjv2
 vqPW5lxxWpsmQEACX0xK/6kXerX4Avde28mromWZJXWpoDkA6sqvSV97ZhAtXjLg9Nxkhj6ZFTV
 AvhYsWZR0YV6JfmL3i1tm84Ta/hbP6dN74NNpV4+KNYpgw05gf3h7+BuSD+dE0dRGA9L5+l0Rvc
 rWp8voSfmAInFR7X996wr+t2uCn+mPtJt/HHHbt/BgyXuLNE67WQ/kBFcg/ljepqmTJQe43qF2r
 CmfeeEe8Vtu6wh7+JWW7h6/O7qvePRMBybO789QiE3TdWMundFLEPBOP4rul+vg0dAip87hFTle
 yDv2HEMUFtJr5xuI=
X-Received: by 2002:a05:6214:4498:b0:704:f103:4e52 with SMTP id
 6a1803df08f44-704f6ae2111mr207949456d6.23.1752849434440; 
 Fri, 18 Jul 2025 07:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfFTbh1tPxRXWJssZY5wzU3ak8RpEJqpDQcJg+vkVBz9ZYa1p29MgZ7OPTCU/4EhH3ot7BIA==
X-Received: by 2002:a05:6214:4498:b0:704:f103:4e52 with SMTP id
 6a1803df08f44-704f6ae2111mr207948826d6.23.1752849433963; 
 Fri, 18 Jul 2025 07:37:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bab3782sm8013086d6.102.2025.07.18.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:37:13 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:36:58 +0200
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
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
Message-ID: <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
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

On Fri, Jul 18, 2025 at 10:52:33AM +0200, Paolo Abeni wrote:
>Similar to virtio infra, vhost core maintains the features status
>in the full extended format and allows the devices to implement
>extended version of the getter/setter.
>
>Note that 'protocol_features' are not extended: they are only
>used by vhost-user, and the latter device is not going to implement
>extended features soon.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v2 -> v3:
>  - fix compile warning
>  - _array -> _ex
>
>v1 -> v2:
>  - uint128_t -> uint64_t[]
>  - add _ex() variant of features manipulation helpers
>---
> hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++----
> include/hw/virtio/vhost-backend.h |  6 +++
> include/hw/virtio/vhost.h         | 33 ++++++++++++--
> 3 files changed, 100 insertions(+), 12 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index c30ea1156e..85ae1e4d4c 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> static int vhost_dev_set_features(struct vhost_dev *dev,
>                                   bool enable_log)
> {
>-    uint64_t features = dev->acked_features;
>+    uint64_t features[VIRTIO_FEATURES_DWORDS];
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
>+    if (virtio_features_use_extended(features) &&
>+        !dev->vhost_ops->vhost_set_features_ex) {
>+        VHOST_OPS_DEBUG(r, "extended features without device support");
>+        r = -EINVAL;
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
>@@ -1506,12 +1520,27 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
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
>+    uint64_t features[VIRTIO_FEATURES_DWORDS];
>     unsigned int used, reserved, limit;
>-    uint64_t features;
>     int i, r, n_initialized_vqs = 0;
>
>     hdev->vdev = NULL;
>@@ -1531,7 +1560,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         goto fail;
>     }
>
>-    r = hdev->vhost_ops->vhost_get_features(hdev, &features);
>+    r = vhost_dev_get_features(hdev, features);
>     if (r < 0) {
>         error_setg_errno(errp, -r, "vhost_get_features failed");
>         goto fail;
>@@ -1569,7 +1598,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         }
>     }
>
>-    hdev->features = features;
>+    virtio_features_copy(hdev->features_ex, features);
>
>     hdev->memory_listener = (MemoryListener) {
>         .name = "vhost",
>@@ -1592,7 +1621,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void 
>*opaque,
>     };
>
>     if (hdev->migration_blocker == NULL) {
>-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
>+        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL)) {
>             error_setg(&hdev->migration_blocker,
>                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
>         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
>@@ -1871,6 +1900,20 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>     return features;
> }
>
>+void vhost_get_features_ex(struct vhost_dev *hdev,
>+                           const int *feature_bits,
>+                           uint64_t *features)
>+{
>+    const int *bit = feature_bits;
>+
>+    while (*bit != VHOST_INVALID_FEATURE_BIT) {
>+        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
>+            virtio_clear_feature_ex(features, *bit);
>+        }
>+        bit++;
>+    }
>+}
>+

Can we do something similar of what we do in hw/virtio/virtio.c where
the old virtio_set_features() use the new virtio_set_features_ex()?

> void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                         uint64_t features)
> {
>@@ -1884,6 +1927,18 @@ void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>     }
> }
>
>+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
>+                           const uint64_t *features)
>+{
>+    const int *bit = feature_bits;
>+    while (*bit != VHOST_INVALID_FEATURE_BIT) {
>+        if (virtio_has_feature_ex(features, *bit)) {
>+            virtio_add_feature_ex(hdev->acked_features_ex, *bit);
>+        }
>+        bit++;
>+    }
>+}
>+

Ditto.

Not a strong opinion, but just to reduce code duplication.

Thanks,
Stefano

> int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
>                          uint32_t config_len, Error **errp)
> {
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
>index 66be6afc88..39fbffc6bc 100644
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
>@@ -333,6 +333,21 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
> uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>                             uint64_t features);
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
>+
> /**
>  * vhost_ack_features() - set vhost acked_features
>  * @hdev: common vhost_dev structure
>@@ -344,6 +359,18 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>  */
> void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                         uint64_t features);
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
> unsigned int vhost_get_max_memslots(void);
> unsigned int vhost_get_free_memslots(void);
>
>-- 
>2.50.0
>


