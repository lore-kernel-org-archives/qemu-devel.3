Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E814ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDm-0007U0-ER; Sun, 05 Oct 2025 15:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDi-0007Sk-Uh
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDf-0006NC-UC
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aOYwDQG7HKglv+vhXRjMfO1BIIi6ZI2WVuVvxD+8eTc=;
 b=et/zI0tSJxLvOGoHB6v1K8/1q9xX4rdnqKvIoIhPdDaItwSuJXD8aIT/fLUI9ZHNym8Fkl
 6ZwQrN+xTVBj2S+TWlodwlz4B0/qWM8EpbVJpRvfaCBQlxBAVMXO3j4ShBa97i3ImTHPxk
 2GY5E0S/sIL+i2dmkLvUAlLkZoFZMS8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vwZSlVtcPu-xpep50_NXRg-1; Sun, 05 Oct 2025 15:16:29 -0400
X-MC-Unique: vwZSlVtcPu-xpep50_NXRg-1
X-Mimecast-MFC-AGG-ID: vwZSlVtcPu-xpep50_NXRg_1759691788
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so24948715e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691788; x=1760296588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOYwDQG7HKglv+vhXRjMfO1BIIi6ZI2WVuVvxD+8eTc=;
 b=BObmu/Ox8XUmduYL3OkjERTqD5MHUvZIXKP5D2OPuTHOkN5dgCjL/PKMTIyTSRyapB
 RU01YsDRytH+yz301y0p/AyDBgrI0LIB4vP58CLUYRg5F5N/tiK/li2g0YX6nfgn/dxB
 pGLIKPBqYsAQIQabqVqvNkferymHeoYuZOzz30eGAGydY7+t6pZeS682FZf4Al9d5uVP
 Pmca0mCHSlEMnzckonRMFKbcQbCmxcTYkoevPPhegMWhkCIcJKnbRLttMat9WMhcDqQ6
 fkf0Ug3w5ivRubluawC64hLNI2Y5nKPYchyck6Oo90lJY3LiDGXvZZd0dqXqHKgeXSww
 b31w==
X-Gm-Message-State: AOJu0YyeK378qjFn97jUq6rcgSoowgyRtw6Txjf4GRrmsKYf7Ss7M8nc
 QNTaMXrRsJ1yxvKUUco8SM3hRyBQjCbPJHxbl1A/LRf2Xj/JBulUP0KF9gefEjJaNgbbGfprbMB
 Gzp8zXOL89iCre2ZddkTno4RwEbzsC53fdRIh2+pXY6LVnWZqM3+iYV6j+kb1oBoMX6EpTWMeFg
 p4xr03vVRhryEm2Q2M45Bf7klygsrEsctHQQ==
X-Gm-Gg: ASbGncsytRlC6Ctnmt6qr5Ob7Q6kf3Bp7dxzb02KR8x7ZS6fq0cbgPuHL/xcF8+0eRv
 7Ukc1uGMtlWHv6abv6+Zw9s20jP6UBm+4r5o7jGRJlVbOySgrzSUgeY13seHz4VLNdqXjxGD52b
 XUnDxu0oqOaE36kad1uMTgis09D5cENp+Hl2qXUCXBPH/yZ083FAm2n4WHYNLLS/YMgGeHz4u0j
 41WGatzhqi6lF/aC8PTFBBUPEwdAxW0mycYme1KRKDxeQH7q4wZqKkphlRF7X4NUnqSskYUhUGZ
 ORORNG68I8MPuYlpc1ftqisKMxw8OpKbSqtkhis=
X-Received: by 2002:a05:6000:616:b0:3fe:efa8:7f1d with SMTP id
 ffacd0b85a97d-42567137428mr5510432f8f.7.1759691788011; 
 Sun, 05 Oct 2025 12:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb+eHdLYkl7KmOdHavVhcGdeWtlpJiwkjIb0MIBqsoJ3t7i7a7zT7rzHDACsIqtxnmfEqXcg==
X-Received: by 2002:a05:6000:616:b0:3fe:efa8:7f1d with SMTP id
 ffacd0b85a97d-42567137428mr5510416f8f.7.1759691787461; 
 Sun, 05 Oct 2025 12:16:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4bdcsm17534137f8f.54.2025.10.05.12.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:27 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 11/75] vhost-net: implement extended features support
Message-ID: <d55ad8c9a9a5edd8152f13fc97879d66972f103e.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Provide extended version of the features manipulation helpers,
and let the device initialization deal with the full features space,
adjusting the relevant format strings accordingly.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <69c78c432e28e146a8874b2a7d00e9cbd111b1ba.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/net/vhost_net.h | 33 +++++++++++++++++++++++++++---
 hw/net/vhost_net-stub.c |  8 +++-----
 hw/net/vhost_net.c      | 45 +++++++++++++++++++++++------------------
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 879781dad7..0225207491 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -2,6 +2,7 @@
 #define VHOST_NET_H
 
 #include "net/net.h"
+#include "hw/virtio/virtio-features.h"
 #include "hw/virtio/vhost-backend.h"
 
 struct vhost_net;
@@ -33,8 +34,26 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
 
 void vhost_net_cleanup(VHostNetState *net);
 
-uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
-void vhost_net_ack_features(VHostNetState *net, uint64_t features);
+void vhost_net_get_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_features(VHostNetState *net,
+                                              uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_get_features_ex(net, features_array);
+    return features_array[0];
+}
+
+void vhost_net_ack_features_ex(VHostNetState *net, const uint64_t *features);
+static inline void vhost_net_ack_features(VHostNetState *net,
+                                          uint64_t features)
+{
+    uint64_t features_array[VIRTIO_FEATURES_NU64S];
+
+    virtio_features_from_u64(features_array, features);
+    vhost_net_ack_features_ex(net, features_array);
+}
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len);
@@ -51,7 +70,15 @@ VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_net_set_vring_enable(NetClientState *nc, int enable);
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net);
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features);
+static inline uint64_t vhost_net_get_acked_features(VHostNetState *net)
+{
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+
+    vhost_net_get_acked_features_ex(net, features);
+    assert(!virtio_features_use_ex(features));
+    return features[0];
+}
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
 
diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 7d49f82906..0740d5a2eb 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -46,9 +46,8 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return features;
 }
 
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
@@ -62,13 +61,12 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return 0;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return 0;
 }
 
 bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 540492b37d..a8ee18a912 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -35,10 +35,9 @@
 #include "hw/virtio/virtio-bus.h"
 #include "linux-headers/linux/vhost.h"
 
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
-    return vhost_get_features(&net->dev, net->feature_bits,
-            features);
+    vhost_get_features_ex(&net->dev, net->feature_bits, features);
 }
 int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
                          uint32_t config_len)
@@ -51,10 +50,11 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
 }
 
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
-    net->dev.acked_features = net->dev.backend_features;
-    vhost_ack_features(&net->dev, net->feature_bits, features);
+    virtio_features_copy(net->dev.acked_features_ex,
+                         net->dev.backend_features_ex);
+    vhost_ack_features_ex(&net->dev, net->feature_bits, features);
 }
 
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
@@ -62,9 +62,9 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return net->dev.max_queues;
 }
 
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
 {
-    return net->dev.acked_features;
+    virtio_features_copy(features, net->dev.acked_features_ex);
 }
 
 void vhost_net_save_acked_features(NetClientState *nc)
@@ -234,7 +234,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     int r;
     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
     struct vhost_net *net = g_new0(struct vhost_net, 1);
-    uint64_t features = 0;
+    uint64_t missing_features[VIRTIO_FEATURES_NU64S];
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     Error *local_err = NULL;
 
     if (!options->net_backend) {
@@ -247,6 +248,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->save_acked_features = options->save_acked_features;
     net->max_tx_queue_size = options->max_tx_queue_size;
     net->is_vhost_user = options->is_vhost_user;
+    virtio_features_clear(features);
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
@@ -261,7 +263,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        net->dev.backend_features = 0;
+        virtio_features_clear(net->dev.backend_features_ex);
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -281,26 +283,29 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
             net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
-        if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                   " for backend\n",
-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
+
+        if (virtio_features_andnot(missing_features,
+                                   net->dev.backend_features_ex,
+                                   net->dev.features_ex)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
 
     /* Set sane init value. Override when guest acks. */
     if (options->get_acked_features) {
-        features = options->get_acked_features(net->nc);
-        if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
-                    " for backend\n",
-                    (uint64_t)(~net->dev.features & features));
+        virtio_features_from_u64(features,
+                                 options->get_acked_features(net->nc));
+        if (virtio_features_andnot(missing_features, features,
+                                   net->dev.features_ex)) {
+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
+                    " for backend\n", VIRTIO_FEATURES_PR(missing_features));
             goto fail;
         }
     }
 
-    vhost_net_ack_features(net, features);
+    vhost_net_ack_features_ex(net, features);
 
     return net;
 
-- 
MST


