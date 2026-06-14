Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB09CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAv-0001YE-Vp; Sun, 14 Jun 2026 15:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAu-0001NB-FK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAs-0001vV-40
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SJcS+9UqaVjBAPSUcIsntYvZkpRpH6gZNVtlSqPFRY=;
 b=BeMpAjBJagjVIkD28Nn/grHpynfXq352enk2Rsi418DnnUHOU6LgcQBxXFSCIlOzEuWEPa
 6lL3Ec1YtNNxpD6lD/O7Ga8VI8KbMg2OicGs17KcazXtidbPPEap6VBgfrLRBMQx29v8kC
 afKfhsNIXUmX7rVcKfD2O9OwQW7SfRY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-9bEKXCnlN0mbwwiBhBTmCg-1; Sun, 14 Jun 2026 15:07:12 -0400
X-MC-Unique: 9bEKXCnlN0mbwwiBhBTmCg-1
X-Mimecast-MFC-AGG-ID: 9bEKXCnlN0mbwwiBhBTmCg_1781464031
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b9318944so16617675e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464031; x=1782068831; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8SJcS+9UqaVjBAPSUcIsntYvZkpRpH6gZNVtlSqPFRY=;
 b=D6g0doRVGiII8UsJ3frOLOkQW4MdFI+FAwc1cuSMxo7LtwefxFG8ACkKbWn4BMdhrX
 vIYykJd4Cw4nvpS6/t7jUMEJMnSaWjjntJcKMJGuMaO6qU2EW6sOT+Ua91PAblDLzzoK
 +W0zPliFmkpHMEJ93CkIXd2+qVoga7Y/eWBFMW1EyTsk2tL9CnkRHeykK0j1Y18/ONbM
 GVjJmITNOta6XN5hohr+Yt0KPO+xYmQUL7zaZ5JJX0AUjeyRhGPWiBuX2Zr4Yuhx9ful
 v1IrYDZ6XQMxwCyK2/18c0IznOTYDeRc37zZma5c9czKNe6cFuY9akoZ23Fw8QOJ0Wqi
 CmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464031; x=1782068831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SJcS+9UqaVjBAPSUcIsntYvZkpRpH6gZNVtlSqPFRY=;
 b=n0GTcnXfyGyAv937xCPqef0zdlSxbCOdyT3L9VloGh1fCYxhPHVFaKX3ObTRMgBYX0
 Q1uaMvNcsf2NdDrCqFZ3mqHvdLlEaucqJD3NmtlJ2dUUIbv2pGSUy1BiMzQVUJES7DN5
 mRGCWpN9+takxAUzURgO52xb16M1G4iBxwkSR42fMtr7sr4dqedbKB9oqd+4L/bz2T/r
 zpCzj9xKysNDpHYAW5PAlzaHaQBxhAPMaBgdwrp8DAcgnApI/sqfKWho1ivjH/e+sM4J
 cVqI8yH7yyy7Mi8d0a5l889qw5wv5OBujBmNEMkq1a3OQzE9EcyCdUde8DCSICaub2hD
 UfEg==
X-Gm-Message-State: AOJu0YwoftvZLosHctLsQApyMg3llbpNBoBeoKMtZJ1lj1nsugdzWajP
 8yZQaaagUMVYD9gMeKtjvEd5cP0DPfueGUMM4bgZvF8UpJh9i/7FPp1zqEDbMpHtiqWxoSq1bS+
 iXgK74UjMXPF5YCyPq+vfKnKMJxsVJdkWebnCV/pFFrviLmNi1Hnk/l+lrsDuSG4mKjweVjvpTh
 CGMjv7NX3ow3eFbzIDNe7mQCvPrJoN0f/mpQ==
X-Gm-Gg: Acq92OGHruKgEYvYo5AKGbXeoXMeejuuCeS91C11AgAzE4aVVYdPr4H2DeJVuEGN0eT
 QA2d76ZpaTU6XWT0gk+2uqLiabUPEoZ2YpXP8LObSuiDfwWzM1T0zbim9z/fvGUeGlxXVXktN3X
 wITfTMu8cNNWMftI3/3xW2jWDJKWI/vqMfOG7K1eYwxAJSKWJLOPA3u92nGJX9ZuDctCVDBCR5m
 /t8vNz6P/VBsQ0+xCS0EeWVJwDCZNpMHPUcgEb/YIQNVlGAbyGjRuycXezsyeKxFfLtYJxw0SkC
 bIfLg+6hh1sDU9Vl6rPYk2df1ohyv3CWlHQ8V8QPgb3S86Wiy2EbaFDzr25aSrr7NBVmAYFZvWD
 C+0KqPvZOFwlWEMYrOLzBEnIXfTBYqj1+ZfWPo0VZl0g=
X-Received: by 2002:a05:600c:4712:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490ec4dc8d8mr152520505e9.12.1781464030564; 
 Sun, 14 Jun 2026 12:07:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490ec4dc8d8mr152520055e9.12.1781464029952; 
 Sun, 14 Jun 2026 12:07:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203bfb27sm210030865e9.11.2026.06.14.12.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:09 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 032/106] vhost: make vhost_dev.features private
Message-ID: <ddbae214b1874ef97bda6cd7bf3a3cfbf9ceb82b.1781463125.git.mst@redhat.com>
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

It's hard to control where and how do we use this field. Let's
cover all usages by getters/setters, and keep direct access to the
field only in vhost.c. It will help to control migration of this
field in further commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-7-vsementsov@yandex-team.ru>
---
 hw/display/vhost-user-gpu.c |  7 +++----
 hw/net/vhost_net.c          | 18 ++++++++---------
 hw/virtio/vdpa-dev.c        |  2 +-
 hw/virtio/vhost-user-base.c |  8 ++++++--
 hw/virtio/vhost-user.c      |  4 ++--
 hw/virtio/vhost.c           |  6 +++---
 hw/virtio/virtio-qmp.c      |  2 +-
 include/hw/virtio/vhost.h   | 39 +++++++++++++++++++++++++++++++++++--
 net/vhost-vdpa.c            |  7 +++----
 9 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 6f02314356..57360898ca 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -631,17 +631,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     /* existing backend may send DMABUF, so let's add that requirement */
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED;
-    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_VIRGL)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_VIRGL)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED;
     }
-    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_EDID)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_EDID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_EDID_ENABLED;
     } else {
         error_report("EDID requested but the backend doesn't support it.");
         g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
     }
-    if (virtio_has_feature(g->vhost->dev.features,
-        VIRTIO_GPU_F_RESOURCE_UUID)) {
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index ca19983126..323d117735 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -54,8 +54,8 @@ void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
     virtio_features_clear(net->dev.acked_features_ex);
     if (net->backend == -1) {
-        net->dev.acked_features =
-           net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+        net->dev.acked_features = (vhost_dev_features(&net->dev) &
+            (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
     } else if (!qemu_has_vnet_hdr(net->nc)) {
         net->dev.acked_features = 1ULL << VHOST_NET_F_VIRTIO_NET_HDR;
     }
@@ -282,15 +282,15 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     if (backend_kernel) {
         if (!qemu_has_vnet_hdr_len(options->net_backend,
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
-            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
+            vhost_dev_clear_feature(&net->dev, VIRTIO_NET_F_MRG_RXBUF);
         }
 
         if (!qemu_has_vnet_hdr(options->net_backend) &&
-            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
-            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
-                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
-             goto fail;
-         }
+            !vhost_dev_has_feature(&net->dev, VHOST_NET_F_VIRTIO_NET_HDR)) {
+            fprintf(stderr, "vhost lacks VHOST_NET_F_VIRTIO_NET_HDR "
+                    "feature for backend\n");
+            goto fail;
+        }
     }
 
     /* Set sane init value. Override when guest acks. */
@@ -298,7 +298,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         virtio_features_from_u64(features,
                                  options->get_acked_features(net->nc));
         if (virtio_features_andnot(missing_features, features,
-                                   net->dev.features_ex)) {
+                                   vhost_dev_features_ex(&net->dev))) {
             fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
                     " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 06179e402e..94188d37bb 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -224,7 +224,7 @@ static uint64_t vhost_vdpa_device_get_features(VirtIODevice *vdev,
                                                Error **errp)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
-    uint64_t backend_features = s->dev.features;
+    uint64_t backend_features = vhost_dev_features(&s->dev);
 
     if (!virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM)) {
         virtio_clear_feature(&backend_features, VIRTIO_F_IOMMU_PLATFORM);
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 01ab9ca56b..5bbf4a7367 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -118,9 +118,13 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
                                  uint64_t requested_features, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    uint64_t backend_features = vhost_dev_features(&vub->vhost_dev);
+
     /* This should be set when the vhost connection initialises */
-    g_assert(vub->vhost_dev.features);
-    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+    g_assert(backend_features);
+    virtio_clear_feature(&backend_features, VHOST_USER_F_PROTOCOL_FEATURES);
+
+    return backend_features;
 }
 
 /*
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fc2ed1f17e..68dd89cd8f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1249,7 +1249,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
 {
     int i;
 
-    if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (!vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
         /*
          * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
          * been negotiated, the rings start directly in the enabled state,
@@ -1488,7 +1488,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
      * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
      * specific.
      */
-    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
         features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
     }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b89797df95..e39e0676e0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1612,7 +1612,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    virtio_features_copy(hdev->features_ex, features);
+    virtio_features_copy(hdev->_features_ex, features);
 
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
@@ -1635,7 +1635,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     };
 
     if (hdev->migration_blocker == NULL) {
-        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL)) {
+        if (!vhost_dev_has_feature_ex(hdev, VHOST_F_LOG_ALL)) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
@@ -1909,7 +1909,7 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
     const int *bit = feature_bits;
 
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
+        if (!vhost_dev_has_feature_ex(hdev, *bit)) {
             virtio_clear_feature_ex(features, *bit);
         }
         bit++;
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index c8bf702d38..51e3a42c4c 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -747,7 +747,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
         status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features_ex);
+            qmp_decode_features(vdev->device_id, vhost_dev_features_ex(hdev));
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 4a9bd3effe..54862f9b44 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -98,10 +98,11 @@ struct vhost_dev {
      * offered by a backend which may be a subset of the total
      * features eventually offered to the guest.
      *
-     * @features: available features provided by the backend
+     * @_features: available features provided by the backend, private,
+     *             direct access only in vhost.h/vhost.c
      * @acked_features: final negotiated features with front-end driver
      */
-    VIRTIO_DECLARE_FEATURES(features);
+    VIRTIO_DECLARE_FEATURES(_features);
     VIRTIO_DECLARE_FEATURES(acked_features);
 
     uint64_t max_queues;
@@ -403,6 +404,40 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
 bool vhost_dev_has_iommu(struct vhost_dev *dev);
 
+static inline bool vhost_dev_has_feature(struct vhost_dev *dev,
+                                         uint64_t feature)
+{
+    return virtio_has_feature(dev->_features, feature);
+}
+
+static inline bool vhost_dev_has_feature_ex(struct vhost_dev *dev,
+                                            uint64_t feature)
+{
+    return virtio_has_feature_ex(dev->_features_ex, feature);
+}
+
+static inline uint64_t vhost_dev_features(struct vhost_dev *dev)
+{
+    return dev->_features;
+}
+
+static inline const uint64_t *vhost_dev_features_ex(struct vhost_dev *dev)
+{
+    return dev->_features_ex;
+}
+
+static inline void vhost_dev_clear_feature(struct vhost_dev *dev,
+                                           uint64_t feature)
+{
+    virtio_clear_feature(&dev->_features, feature);
+}
+
+static inline void vhost_dev_clear_feature_ex(struct vhost_dev *dev,
+                                              uint64_t feature)
+{
+    virtio_clear_feature_ex(dev->_features_ex, feature);
+}
+
 #ifdef CONFIG_VHOST
 int vhost_reset_device(struct vhost_dev *hdev);
 #else
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f1523697e2..c85956a04b 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -257,15 +257,14 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    uint64_t features = s->vhost_vdpa.dev->features;
     int fd = s->vhost_vdpa.shared->device_fd;
     struct {
         struct vhost_vdpa_config hdr;
         uint32_t supported_hash_types;
     } config;
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
-        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+    if (!vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_HASH_REPORT) &&
+        !vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_RSS)) {
         return false;
     }
 
@@ -586,7 +585,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
      * If we early return in these cases SVQ will not be enabled. The migration
      * will be blocked as long as vhost-vdpa backends will not offer _F_LOG.
      */
-    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
+    if (!vhost_vdpa_net_valid_svq_features(vhost_dev_features(v->dev), NULL)) {
         return 0;
     }
 
-- 
MST


