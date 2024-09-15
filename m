Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED81C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0W-0003Bk-Ai; Sat, 14 Sep 2024 21:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0T-0003Ac-Vp
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0S-0005Rf-0e
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2055136b612so42142525ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363490; x=1726968290;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yN4IPLpzUJOoQP0bUmbKLVptw/fXWtyeCd8LXlwgVCQ=;
 b=ogrsUlW6BS2PRXcPqBoHHUKz2IfZxRVMWpIk954m5X/poWe7F42yRS+lXy3E0rogjK
 SwxgQi/SpoS7rCV1oE/IrLiip0prOKqlxC11/IyPhqAMXlqTrE3rDSMA1PO18crL0aR2
 Ykz1TtgRqw+vEt23+NJ12FA1GYrxXwm2ToMtUuOhuyNV0QwrM4q3qSl3ry5QYfU2d4el
 OGVdITVwXMiUTDhLNi0moXPAE5wNeNgaU0gHtsdNLuxo+WhK9Xcc2FxbbNIMJvooo1bS
 3/CO/X0dxQE/yX0UxbAhSSiQ5U1RKqFCnQd81QTIzAg2FNTq3cL7QfkD1ndURSy2WCV6
 hvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363490; x=1726968290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yN4IPLpzUJOoQP0bUmbKLVptw/fXWtyeCd8LXlwgVCQ=;
 b=Ah5VLujA2r9csWc3NyIkv/hoyXHH5VSEceiXnsOdNE59iqVDU9hJ/kFAz1rOU5gbbX
 AUWineG8nl7OY84LFbRbaJunFIJ8NEnzVGtVs8FHfuX2+tBDJRSvxkX98uJ+J2as3Bt1
 00zjgExUiP7V3MEo2oDbJo6qgLJeE2gRqaTbtSCj59BjsFzbtLrpTHloqbYqjoXHv+kD
 Js5CIro6Ebl6PWM0YbhHothIRCpgoyUK/7W88gDspzVVqMuotdKsd56OxaC+YwEs56p9
 A2gp+Ro5HNFbKlx7NKU9wi2DC+J9Auple8rkK5ZSibX82SLQuVaTdj+/9VQoEOGe4SdF
 n61w==
X-Gm-Message-State: AOJu0YyDNp7kKwu6zDLNDWA5LYUWg0u72wPhqN5UCHjABSEZVwrKzIqX
 5ZwEj06OxRsALCuqcWEfjTnP64pdjmUcfQ9r7jRayse0OOoOTZYMq7A4Jt1WDbo2CIE4RJjCXf3
 3Sfw=
X-Google-Smtp-Source: AGHT+IEav6YWKN0VQVTWJi66uSrLCzrhGoJkfnF7L8prqH/KGhWA3/i9bwAHx8iDuV5K/HwYXzgvRQ==
X-Received: by 2002:a17:902:d510:b0:206:b4cf:3107 with SMTP id
 d9443c01a7336-2076e422055mr184255655ad.49.1726363490522; 
 Sat, 14 Sep 2024 18:24:50 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-207946010e4sm14933415ad.73.2024.09.14.18.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:45 +0900
Subject: [PATCH RFC v3 04/11] virtio-net: Retrieve peer hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-4-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Retrieve peer hashing capability instead of hardcoding.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  5 +++-
 hw/net/virtio-net.c            | 67 ++++++++++++++++++++++++++++++++++--------
 net/vhost-vdpa.c               |  4 +--
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d2d..202016ec74fc 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -144,7 +144,10 @@ typedef struct VirtioNetRssData {
     bool    enabled_software_rss;
     bool    redirect;
     bool    populate_hash;
-    uint32_t hash_types;
+    bool    peer_hash_available;
+    uint32_t runtime_hash_types;
+    uint32_t supported_hash_types;
+    uint32_t peer_hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
     uint16_t *indirections_table;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 206b0335169d..3da15a60eaa5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -157,7 +157,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  virtio_host_has_feature(vdev, VIRTIO_NET_F_RSS) ?
                  VIRTIO_NET_RSS_MAX_TABLE_LEN : 1);
     virtio_stl_p(vdev, &netcfg.supported_hash_types,
-                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
+                 n->rss_data.supported_hash_types);
     memcpy(config, &netcfg, n->config_size);
 
     /*
@@ -1175,7 +1175,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
 {
     config->redirect = data->redirect;
     config->populate_hash = data->populate_hash;
-    config->hash_types = data->hash_types;
+    config->hash_types = data->runtime_hash_types;
     config->indirections_len = data->indirections_len;
     config->default_queue = data->default_queue;
 }
@@ -1209,6 +1209,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
+    if (n->rss_data.peer_hash_available) {
+        return;
+    }
+
     if (n->rss_data.enabled) {
         n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
         if (n->rss_data.populate_hash) {
@@ -1222,7 +1226,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
             }
         }
 
-        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+        trace_virtio_net_rss_enable(n->rss_data.runtime_hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
@@ -1324,7 +1328,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.runtime_hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     n->rss_data.indirections_len++;
@@ -1387,12 +1391,12 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = temp.b;
         goto error;
     }
-    if (!temp.b && n->rss_data.hash_types) {
+    if (!temp.b && n->rss_data.runtime_hash_types) {
         err_msg = "No key provided";
         err_value = 0;
         goto error;
     }
-    if (!temp.b && !n->rss_data.hash_types) {
+    if (!temp.b && !n->rss_data.runtime_hash_types) {
         virtio_net_disable_rss(n);
         return queue_pairs;
     }
@@ -1793,7 +1797,7 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
-                                             n->rss_data.hash_types);
+                                             n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
             hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
@@ -2973,6 +2977,14 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
+    uint32_t supported_hash_types = n->rss_data.supported_hash_types;
+    uint32_t peer_hash_types = n->rss_data.peer_hash_types;
+    bool use_own_hash =
+        (supported_hash_types & VIRTIO_NET_RSS_SUPPORTED_HASHES) ==
+        supported_hash_types;
+    bool use_peer_hash =
+        n->rss_data.peer_hash_available &&
+        (supported_hash_types & peer_hash_types) == supported_hash_types;
 
     /* Firstly sync all virtio-net possible supported features */
     features |= n->host_features;
@@ -3009,12 +3021,24 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
+        if (!use_own_hash) {
+            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+            virtio_net_load_ebpf(n);
+        }
+
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    if (!use_peer_hash) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+
+        if (!use_own_hash || !virtio_net_load_ebpf(n)) {
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        }
     }
+
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -3279,6 +3303,17 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     },
 };
 
+static int virtio_net_rss_post_load(void *opaque, int version_id)
+{
+    VirtIONet *n = VIRTIO_NET(opaque);
+
+    if (version_id == 1) {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
+    }
+
+    return 0;
+}
+
 static bool virtio_net_rss_needed(void *opaque)
 {
     return VIRTIO_NET(opaque)->rss_data.enabled;
@@ -3286,14 +3321,16 @@ static bool virtio_net_rss_needed(void *opaque)
 
 static const VMStateDescription vmstate_virtio_net_rss = {
     .name      = "virtio-net-device/rss",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = virtio_net_rss_post_load,
     .needed = virtio_net_rss_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
         VMSTATE_BOOL(rss_data.redirect, VirtIONet),
         VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
-        VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
+        VMSTATE_UINT32(rss_data.runtime_hash_types, VirtIONet),
+        VMSTATE_UINT32_V(rss_data.supported_hash_types, VirtIONet, 2),
         VMSTATE_UINT16(rss_data.indirections_len, VirtIONet),
         VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
         VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
@@ -3768,8 +3805,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+    if (qemu_get_vnet_hash_supported_types(qemu_get_queue(n->nic)->peer,
+                                           &n->rss_data.peer_hash_types)) {
+        n->rss_data.peer_hash_available = true;
+        n->rss_data.supported_hash_types = n->rss_data.peer_hash_types;
+    } else {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index af0c3c448c1f..4af87ea226b4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -884,13 +884,13 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
      * configuration only at live migration.
      */
     if (!n->rss_data.enabled ||
-        n->rss_data.hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
+        n->rss_data.runtime_hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
         return 0;
     }
 
     table = g_malloc_n(n->rss_data.indirections_len,
                        sizeof(n->rss_data.indirections_table[0]));
-    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
+    cfg.hash_types = cpu_to_le32(n->rss_data.runtime_hash_types);
 
     if (do_rss) {
         /*

-- 
2.46.0


