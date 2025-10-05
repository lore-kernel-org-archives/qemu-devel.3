Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C93CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDn-0007UK-S6; Sun, 05 Oct 2025 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDk-0007T2-59
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDi-0006NJ-1y
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bor2WhW2cNfFK9zamYg8ijHD2QP5w9JCub0cS59gaDM=;
 b=CMV0JYrgfQvWOvYcGPTObC3OUWNmspt4+E7VHF4QJhxS4j+BAkTwC3Ss+lI1q1eMIerEbu
 R8BBKq/K7W6Yb+KvEh5KWe7NFtBOcg52qJH7FdBVCYxGR5ZyztT6UiG19UKsU4tUoy64Nl
 UVJVPGA1yz9IwdH+0OAWnayYXcd2Juw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Wg6EeoHeM4SrgHYKga0LLw-1; Sun, 05 Oct 2025 15:16:32 -0400
X-MC-Unique: Wg6EeoHeM4SrgHYKga0LLw-1
X-Mimecast-MFC-AGG-ID: Wg6EeoHeM4SrgHYKga0LLw_1759691791
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e46486972so11980365e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691790; x=1760296590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bor2WhW2cNfFK9zamYg8ijHD2QP5w9JCub0cS59gaDM=;
 b=tyiqx+Zwygoz7sUJC3yvaVfPZPi6bhY+7C5aG2Cmp7Y4JcArHaV2r6TUB75cJiPS5V
 GD5p5FKfphqtZR+LRUe0dw4cP+Ga70AI3NJOLis7mQtupC/0Pbsppqjwov0urVSn9mcc
 0tDWimQjAihOeWR2ifguKe8CDfajpfSecwYG2TipkTt3UKbOJ4RIh6jyGpXArS1rArtk
 gCtJlVvdZVHR/aE7WQ53eWWkMWGWHPfO34WfZ/nhuQPixaJ4nk/B8/Tpka2HL7Kf6p3K
 NaQYZfC+mXWN5IDdkwZbcQXZg+/ErlSySgsKXwN7XLYx162yaLW/AymRr6+g/tplhRs/
 YYLQ==
X-Gm-Message-State: AOJu0Yynnc1bq5VE3+KdwJwQqsqUZH06yd2/bxkC7+nUXMoW7kd1TJBa
 22cYBGda0st7q8+xsH9NUbQkzxsEXQcEVHC1OMZ9epTi38x9uLSeJjkVsL04Am9pUsX9oKb7og1
 6w+kAU41sG0U+gHx4ZYr8937hNm8X6kHL9qqynF0WM1xXXIlVuUJ15VJL9GWGxLT9FLIK/Zng5Y
 ySmWNCuZEDm7yxB2DlB6mFe61Gdo9zn53hGQ==
X-Gm-Gg: ASbGnctOZwvd+VDfPxIvIkF61t2/GusUeaeXscEBMRp7IgpycaOKW6elmaUYs8ZFiJp
 l/3avIviOKZn6eA9l5EbfQIPunIDeu2x67zkS36ycvLRl5t4Xuq85jf18ujfzZ8TbyMmCdLrb5+
 I40S4AvQmODyPdb/qaZcCUOh8wkIMcF3SqapcDwv4C2SgNY6KYiQTidmX2K1VqWVTDCv4hO6d5D
 8+ccRT1MIWLqSZuxQsKuesGvR5J0sjuGauRgwTJu3rFJe0FXooH2TC5vDAD9SH7G2/SE0FuxuFk
 FB2ZyQxgmiok/VxqhpcypUr3CLHkK68cV8nDWQE=
X-Received: by 2002:a05:600c:4746:b0:46e:506b:20c9 with SMTP id
 5b1f17b1804b1-46e71109f22mr72336665e9.12.1759691790275; 
 Sun, 05 Oct 2025 12:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3s0ZN7BayOIhpfkyuY1dr9uMESvVR/g22PJbgGMSvmQQ6HlEgClWGMCtYAIQxnVyt6a+PAQ==
X-Received: by 2002:a05:600c:4746:b0:46e:506b:20c9 with SMTP id
 5b1f17b1804b1-46e71109f22mr72336445e9.12.1759691789606; 
 Sun, 05 Oct 2025 12:16:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7236267bsm134160155e9.16.2025.10.05.12.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:29 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 12/75] virtio-net: implement extended features support
Message-ID: <3a7741c3bdc3537de4159418d712debbd22e4df6.1759691708.git.mst@redhat.com>
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

Use the extended types and helpers to manipulate the virtio_net
features.

Note that offloads are still 64bits wide, as per specification,
and extended offloads will be mapped into such range.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <bc5afdc5c1cb1a37238dd2b36004db3d46cbf211.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h |   2 +-
 hw/net/virtio-net.c            | 140 +++++++++++++++++++--------------
 2 files changed, 83 insertions(+), 59 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 73fdefc0dc..5b8ab7bda7 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -182,7 +182,7 @@ struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint64_t host_features;
+    VIRTIO_DECLARE_FEATURES(host_features);
     uint32_t rsc_timeout;
     uint8_t rsc4_enabled;
     uint8_t rsc6_enabled;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 129bebd82e..39f2a8c987 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -90,6 +90,19 @@
                                          VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
 
+/*
+ * Features starting from VIRTIO_NET_FEATURES_MAP_MIN bit correspond
+ * to guest offloads in the VIRTIO_NET_OFFLOAD_MAP range
+ */
+#define VIRTIO_NET_OFFLOAD_MAP_MIN    46
+#define VIRTIO_NET_OFFLOAD_MAP_LENGTH 4
+#define VIRTIO_NET_OFFLOAD_MAP        MAKE_64BIT_MASK(                    \
+                                              VIRTIO_NET_OFFLOAD_MAP_MIN, \
+                                              VIRTIO_NET_OFFLOAD_MAP_LENGTH)
+#define VIRTIO_NET_FEATURES_MAP_MIN   65
+#define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
+                                       VIRTIO_NET_FEATURES_MAP_MIN + 64)
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -786,7 +799,14 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
 }
 
-static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
+static uint64_t virtio_net_features_to_offload(const uint64_t *features)
+{
+    return (features[0] & ~VIRTIO_NET_OFFLOAD_MAP) |
+           ((features[1] << VIRTIO_NET_F2O_SHIFT) & VIRTIO_NET_OFFLOAD_MAP);
+}
+
+static uint64_t
+virtio_net_guest_offloads_by_features(const uint64_t *features)
 {
     static const uint64_t guest_offloads_mask =
         (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
@@ -797,13 +817,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
         (1ULL << VIRTIO_NET_F_GUEST_USO6);
 
-    return guest_offloads_mask & features;
+    return guest_offloads_mask & virtio_net_features_to_offload(features);
 }
 
 uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
-    return virtio_net_guest_offloads_by_features(vdev->guest_features);
+    return virtio_net_guest_offloads_by_features(vdev->guest_features_ex);
 }
 
 typedef struct {
@@ -882,34 +902,39 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
     error_propagate(errp, err);
 }
 
-static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
+static void virtio_net_set_features(VirtIODevice *vdev,
+                                    const uint64_t *in_features)
 {
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     VirtIONet *n = VIRTIO_NET(vdev);
     Error *err = NULL;
     int i;
 
+    virtio_features_copy(features, in_features);
     if (n->mtu_bypass_backend &&
             !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
-        features &= ~(1ULL << VIRTIO_NET_F_MTU);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
     virtio_net_set_multiqueue(n,
-                              virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
-                              virtio_has_feature(features, VIRTIO_NET_F_MQ));
+                              virtio_has_feature_ex(features,
+                                                    VIRTIO_NET_F_RSS) ||
+                              virtio_has_feature_ex(features,
+                                                    VIRTIO_NET_F_MQ));
 
     virtio_net_set_mrg_rx_bufs(n,
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_NET_F_MRG_RXBUF),
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_F_VERSION_1),
-                               virtio_has_feature(features,
+                               virtio_has_feature_ex(features,
                                                   VIRTIO_NET_F_HASH_REPORT));
 
-    n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
-        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
-    n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
-        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
-    n->rss_data.redirect = virtio_has_feature(features, VIRTIO_NET_F_RSS);
+    n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
+        virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
+    n->rsc6_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
+        virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
+    n->rss_data.redirect = virtio_has_feature_ex(features, VIRTIO_NET_F_RSS);
 
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
@@ -923,7 +948,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         if (!get_vhost_net(nc->peer)) {
             continue;
         }
-        vhost_net_ack_features(get_vhost_net(nc->peer), features);
+        vhost_net_ack_features_ex(get_vhost_net(nc->peer), features);
 
         /*
          * keep acked_features in NetVhostUserState up-to-date so it
@@ -932,12 +957,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
-        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+    if (virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN) !=
+        virtio_has_feature_ex(vdev->guest_features_ex,
+                              VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature_ex(features, VIRTIO_NET_F_CTRL_VLAN);
         memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
-    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+    if (virtio_has_feature_ex(features, VIRTIO_NET_F_STANDBY)) {
         qapi_event_send_failover_negotiated(n->netclient_name);
         qatomic_set(&n->failover_primary_hidden, false);
         failover_add_primary(n, &err);
@@ -1908,10 +1935,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                 virtio_error(vdev, "virtio-net unexpected empty queue: "
                              "i %zd mergeable %d offset %zd, size %zd, "
                              "guest hdr len %zd, host hdr len %zd "
-                             "guest features 0x%" PRIx64,
+                             "guest features 0x" VIRTIO_FEATURES_FMT,
                              i, n->mergeable_rx_bufs, offset, size,
                              n->guest_hdr_len, n->host_hdr_len,
-                             vdev->guest_features);
+                             VIRTIO_FEATURES_PR(vdev->guest_features_ex));
             }
             err = -1;
             goto err;
@@ -3018,8 +3045,8 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
     return 0;
 }
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
+static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
+                                    Error **errp)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
@@ -3033,68 +3060,67 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         (supported_hash_types & peer_hash_types) == supported_hash_types;
 
     /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
+    virtio_features_or(features, features, n->host_features_ex);
 
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+    virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
     if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
 
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
     }
-
     if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
     }
 
     if (!get_vhost_net(nc->peer)) {
         if (!use_own_hash) {
-            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
+        } else if (virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
             virtio_net_load_ebpf(n, errp);
         }
 
-        return features;
+        return;
     }
 
     if (!use_peer_hash) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
 
         if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
             if (!virtio_net_load_ebpf(n, errp)) {
-                return features;
+                return;
             }
 
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
         }
     }
 
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
+    vhost_net_get_features_ex(get_vhost_net(nc->peer), features);
+    virtio_features_copy(vdev->backend_features_ex, features);
 
     if (n->mtu_bypass_backend &&
             (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
-        features |= (1ULL << VIRTIO_NET_F_MTU);
+        virtio_add_feature_ex(features, VIRTIO_NET_F_MTU);
     }
 
     /*
@@ -3109,10 +3135,8 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
      * support it.
      */
     if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ANNOUNCE);
     }
-
-    return features;
 }
 
 static int virtio_net_post_load_device(void *opaque, int version_id)
@@ -4244,8 +4268,8 @@ static void virtio_net_class_init(ObjectClass *klass, const void *data)
     vdc->unrealize = virtio_net_device_unrealize;
     vdc->get_config = virtio_net_get_config;
     vdc->set_config = virtio_net_set_config;
-    vdc->get_features = virtio_net_get_features;
-    vdc->set_features = virtio_net_set_features;
+    vdc->get_features_ex = virtio_net_get_features;
+    vdc->set_features_ex = virtio_net_set_features;
     vdc->bad_features = virtio_net_bad_features;
     vdc->reset = virtio_net_reset;
     vdc->queue_reset = virtio_net_queue_reset;
-- 
MST


