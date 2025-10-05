Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5EECCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDr-0007Xr-CV; Sun, 05 Oct 2025 15:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDo-0007V0-TQ
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDn-0006Ns-2u
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLQzZp1MYba5uQ3+BNOy0Y3LASIlZed9Jbbmm8x+esA=;
 b=eOqdzmU4/eeO2jAj9ArPN1UaRsJDJLWE393ALxTJAD3lPTgSx7hIfnWPu7XMSYv7GgZJK8
 ofNyFQp3asoYlO0KFX7EZtgdtvg9sDBYY9V8Ww1wBthAJji0G80sZ3Mkj5Lw84v1GcPASN
 HMVoQlukipOtUBiSec9VZLtv4C/osK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Lgn41wOaPzS-rfqtrXrIxg-1; Sun, 05 Oct 2025 15:16:37 -0400
X-MC-Unique: Lgn41wOaPzS-rfqtrXrIxg-1
X-Mimecast-MFC-AGG-ID: Lgn41wOaPzS-rfqtrXrIxg_1759691796
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so2461039f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691795; x=1760296595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLQzZp1MYba5uQ3+BNOy0Y3LASIlZed9Jbbmm8x+esA=;
 b=R7mwmiAsd82J+rAT8YBYLKX6+KXMYJOFci0gNaB1CkGMZ2i+Lj0MMNZSF4JihspMon
 mRGCE+OlxB5aHraS48p8XE9Og/ldP0VSwVHaeWgmocY++kGZxrwx/xCs0HuLUCYwIP9F
 coORV04NLp++ZTbH2YCEniESJPGMC8m/G+B/3hhSuUdUpGBXF1d9ddLQbPgrfn4yj42j
 rA2y5w0BSx4Hdb4wqD9cYeo5wLeNb6957D79uvMth2vD6i8AH/Cl4UXRibzR8A/WSU8V
 TavcarB7QNDhS5e2dIZP377JtB6Csdmt47VIeJ0uNJK965bM2GjYOsQCW35TQbO3o230
 /tng==
X-Gm-Message-State: AOJu0Yx1UJNo2wcBq9YEnaFkTA9INDiJ9Dn9Ua7KNybwz0WOLDQiYUrM
 FO4Vs3vsTRwcAORL4EGeCvU4ISGVsb8aUaPo1cpxo0l7y4Y92SYxwa2OD3SWCGMx0cavLciuS6L
 0OxS095W/8aNJKFxfTAG9a1DLI0zDaeSiWxY6O8WdQXi4W4cN4znAriP8eSmATc6ePomyMrAY6M
 tHw8X3Jnj1o+WBpcU5JIo9F25Wi39HCj1k9A==
X-Gm-Gg: ASbGncvdwyHJQ3qMW6v8izEqgpeBUFpB+iQvVDXwztF9AW1BlNN7XnVTT4I9x1KEve6
 7Nl6JGEgIxdU/l9Qehm8azFH+oVQ5ELu0ja/9wp7F2ZKQAa+ejk7U7SqPWsvYnByfoZxG0mYjP6
 1d8EKCBRqlSE1OOw4gktCKwUM4D+ROBoRUEN7vu04lIsoVwDMkBphuswv9Y1t6HzN+TIn4H20we
 Sov1yt4FFmDvW83Y5kfFX7OfQ8e3Fh+T/TU5UFXYGvX7bpEFhz2UOGeUpKCMdUdjCycxnxnJPdX
 FWRiF/oEZi1Ro3Ik7fX8WCqTnGX1KEO38PLGU9k=
X-Received: by 2002:a05:6000:1a85:b0:3e9:2fea:6795 with SMTP id
 ffacd0b85a97d-425671c7275mr6447379f8f.53.1759691795173; 
 Sun, 05 Oct 2025 12:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVtyKe2kxMlnMl8+oWf9X6bUdY5wNm9TaGCpRznKZ27aQWYmhtLdFFA7ZJIrYNICJcHo9xRw==
X-Received: by 2002:a05:6000:1a85:b0:3e9:2fea:6795 with SMTP id
 ffacd0b85a97d-425671c7275mr6447361f8f.53.1759691794636; 
 Sun, 05 Oct 2025 12:16:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ac750sm17613636f8f.24.2025.10.05.12.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:34 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 14/75] net: implement UDP tunnel features offloading
Message-ID: <a5289563ad74a2a37e8d2101d82935454c71fef4.1759691708.git.mst@redhat.com>
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

When any host or guest GSO over UDP tunnel offload is enabled the
virtio net header includes the additional tunnel-related fields,
update the size accordingly.

Push the GSO over UDP tunnel offloads all the way down to the tap
device extending the newly introduced NetFeatures struct, and
eventually enable the associated features.

As per virtio specification, to convert features bit to offload bit,
map the extended features into the reserved range.

Finally, make the vhost backend aware of the exact header layout, to
copy it correctly. The tunnel-related field are present if either
the guest or the host negotiated any UDP tunnel related feature:
add them to the kernel supported features list, to allow qemu
transfer to the backend the needed information.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <093b4bc68368046bffbcab2202227632d6e4e83b.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/net/net.h   |  2 ++
 hw/net/virtio-net.c | 34 ++++++++++++++++++++++++++--------
 net/net.c           |  3 ++-
 net/tap-linux.c     |  6 ++++++
 net/tap.c           |  2 ++
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 9a9084690d..72b476ee1d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -43,6 +43,8 @@ typedef struct NetOffloads {
     bool ufo;
     bool uso4;
     bool uso6;
+    bool tnl;
+    bool tnl_csum;
 } NetOffloads;
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f8e2b4823e..33116712eb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -103,6 +103,12 @@
 #define VIRTIO_NET_F2O_SHIFT          (VIRTIO_NET_OFFLOAD_MAP_MIN - \
                                        VIRTIO_NET_FEATURES_MAP_MIN + 64)
 
+static bool virtio_has_tunnel_hdr(const uint64_t *features)
+{
+    return virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
+           virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
+}
+
 static const VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
@@ -659,7 +665,8 @@ static bool peer_has_tunnel(VirtIONet *n)
 }
 
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
-                                       int version_1, int hash_report)
+                                       int version_1, int hash_report,
+                                       int tunnel)
 {
     int i;
     NetClientState *nc;
@@ -667,9 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
     if (version_1) {
-        n->guest_hdr_len = hash_report ?
-            sizeof(struct virtio_net_hdr_v1_hash) :
-            sizeof(struct virtio_net_hdr_mrg_rxbuf);
+        n->guest_hdr_len = tunnel ?
+            sizeof(struct virtio_net_hdr_v1_hash_tunnel) :
+            (hash_report ?
+             sizeof(struct virtio_net_hdr_v1_hash) :
+             sizeof(struct virtio_net_hdr_mrg_rxbuf));
         n->rss_data.populate_hash = !!hash_report;
     } else {
         n->guest_hdr_len = n->mergeable_rx_bufs ?
@@ -803,6 +812,10 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
        .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
        .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
        .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
+       .tnl  = !!(n->curr_guest_offloads &
+                  (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED)),
+       .tnl_csum = !!(n->curr_guest_offloads &
+                      (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED)),
     };
 
     qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
@@ -824,7 +837,9 @@ virtio_net_guest_offloads_by_features(const uint64_t *features)
         (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
         (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
         (1ULL << VIRTIO_NET_F_GUEST_USO4) |
-        (1ULL << VIRTIO_NET_F_GUEST_USO6);
+        (1ULL << VIRTIO_NET_F_GUEST_USO6) |
+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) |
+        (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED);
 
     return guest_offloads_mask & virtio_net_features_to_offload(features);
 }
@@ -937,7 +952,8 @@ static void virtio_net_set_features(VirtIODevice *vdev,
                                virtio_has_feature_ex(features,
                                                   VIRTIO_F_VERSION_1),
                                virtio_has_feature_ex(features,
-                                                  VIRTIO_NET_F_HASH_REPORT));
+                                                  VIRTIO_NET_F_HASH_REPORT),
+                               virtio_has_tunnel_hdr(features));
 
     n->rsc4_enabled = virtio_has_feature_ex(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
@@ -3169,13 +3185,15 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
+    bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
                                                        VIRTIO_F_VERSION_1),
                                virtio_vdev_has_feature(vdev,
-                                                       VIRTIO_NET_F_HASH_REPORT));
+                                                      VIRTIO_NET_F_HASH_REPORT),
+                               has_tunnel_hdr);
 
     /* MAC_TABLE_ENTRIES may be different from the saved image */
     if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
@@ -3995,7 +4013,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
-    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
+    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0, 0);
     n->promisc = 1; /* for compatibility */
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
diff --git a/net/net.c b/net/net.c
index 9536184a0c..27e0d27807 100644
--- a/net/net.c
+++ b/net/net.c
@@ -575,7 +575,8 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
            len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
+           len == sizeof(struct virtio_net_hdr_v1_hash) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash_tunnel));
 
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 98b0ae9602..2a90b58467 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -284,6 +284,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
         if (ol->uso6) {
             offload |= TUN_F_USO6;
         }
+        if (ol->tnl) {
+            offload |= TUN_F_UDP_TUNNEL_GSO;
+        }
+        if (ol->tnl_csum) {
+            offload |= TUN_F_UDP_TUNNEL_GSO_CSUM;
+        }
     }
 
     if (ioctl(fd, TUNSETOFFLOAD, offload) != 0) {
diff --git a/net/tap.c b/net/tap.c
index 5124372316..abe3b2d036 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -62,6 +62,8 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


