Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D42C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFn-0001RV-1v; Mon, 14 Jul 2025 19:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFk-0001O5-Q4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFi-0005Lb-SN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oh92UO1fq7giggZS3iJdAbKSiUem3Rj0QL6NYcmrhqo=;
 b=SNWAPitPhd0/9/nwTD1Z2q+YlySoeImvTD398JB/qK3o4RPIl8/LkAHFUVqbqd1XLCkat4
 XyYh6fy/fopOZ8iwWTgoYsUuuVHutcJgf0UkZxYFtKQRKTDHbGqVExO/zI7M4GLL1OObdN
 uqPzuPfOhTFmaBn2OrX83f5ZcMmdaDs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-I0DDYzgXNkugz1Kb9NLaCg-1; Mon, 14 Jul 2025 19:06:28 -0400
X-MC-Unique: I0DDYzgXNkugz1Kb9NLaCg-1
X-Mimecast-MFC-AGG-ID: I0DDYzgXNkugz1Kb9NLaCg_1752534388
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so2378673f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534387; x=1753139187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oh92UO1fq7giggZS3iJdAbKSiUem3Rj0QL6NYcmrhqo=;
 b=BDfGywz5QZo3TJI079T87SY+WXjtz+TFE68hbtgB379zqZv61Q9OVShl+5hs0g/fXX
 M+9H4kqiSt0UNFxN1K20V6Hefje3PMxkWos3oIaO3hzqW8vZKXla5GEtF9jfKz9bUAyC
 PLYDaJNu6AIwGmIrYpJxM9ApAhstDBG10wp9IZaOGo5q2HDgmEQ6r9FbaJt5AQpyyDHX
 SCR+K3NVaZwB6Y+/4fOqepsnjUftc/ZwnkS+BvB03jKuOglGPiSGnOagNVAuMcblnT9j
 yhoOvs7vOgKr4wZiBowd6eeOyjLG54MajFkmGoyVcUYgcA2sTJaJyS2oSkmb+nSS+oq5
 bRCw==
X-Gm-Message-State: AOJu0YxUHswlzjtb1j87MVNnQwI5ZDavA3CL+MAXt2m3O5QjU8dcHQQc
 CR5TTcQln55R0e/tWENnjxkwQ7NCtMZF21GpRCwB0dvaKGDtuF4fEQueqgohhvtiSuJdgDmUBIX
 pOpKn/jRNQ3yC7pEAxhpMPi2M73D6Wwwt9TIohCYfM8/JMApNUdgs75hBTznjUK6mvbt1Umk80w
 SjGKY+DH/XmyI4x+5KhgqB+rJnGSgEeV7lTg==
X-Gm-Gg: ASbGncv8l5mFRp2k5WU+PozmNkDcEQG0rDw8eVVpvfMr4/hMuy9TV5RqcOKPQLvc/eK
 zUG5s88epU1buqIWP6FLqulONYettLabC3MikLsFdvE1mntf379Bz/3JiGEqSfXZKwBbbDS4w7t
 S9xesMwQrgw2XlfgIu+MyfiA7zjDPBpqJsekiOeaJCgx4v34OCsRR4ngsRLZ2xvv1jmVPm1vSIb
 DdEARRpggsyaYmTbu3YovGHhNsE9A44v+CqIF9s5/mKJT7JcjnZnY6chXOrJc3ZnD4Jiek9YdoS
 yWjuu7RvszQKxgzSFVLsQhN5VhR+Myr1
X-Received: by 2002:a5d:64cc:0:b0:3a4:d98d:76b9 with SMTP id
 ffacd0b85a97d-3b5f358567emr9811363f8f.41.1752534387172; 
 Mon, 14 Jul 2025 16:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHls3U2TziYi9zjRa+UpyGNvsL3Gj81CzXJBSAPO3w9ufb077+PE3BPZ9kifJg9zV4DKgKJhw==
X-Received: by 2002:a5d:64cc:0:b0:3a4:d98d:76b9 with SMTP id
 ffacd0b85a97d-3b5f358567emr9811348f8f.41.1752534386706; 
 Mon, 14 Jul 2025 16:06:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456101b616csm72711185e9.4.2025.07.14.16.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:26 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/97] virtio-net: Retrieve peer hashing capability
Message-ID: <7b6e7e49905d0682f67ae4d02fc9edc4a2ec7df5.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Retrieve peer hashing capability instead of hardcoding.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-4-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h |  5 ++-
 hw/net/virtio-net.c            | 71 +++++++++++++++++++++++++++-------
 net/vhost-vdpa.c               |  4 +-
 3 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b9ea9e824e..c4957c44c0 100644
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
index 34fe5909c5..9888ff22bd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -158,7 +158,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  virtio_host_has_feature(vdev, VIRTIO_NET_F_RSS) ?
                  VIRTIO_NET_RSS_MAX_TABLE_LEN : 1);
     virtio_stl_p(vdev, &netcfg.supported_hash_types,
-                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
+                 n->rss_data.supported_hash_types);
     memcpy(config, &netcfg, n->config_size);
 
     /*
@@ -1178,7 +1178,7 @@ static void rss_data_to_rss_config(struct VirtioNetRssData *data,
 {
     config->redirect = data->redirect;
     config->populate_hash = data->populate_hash;
-    config->hash_types = data->hash_types;
+    config->hash_types = data->runtime_hash_types;
     config->indirections_len = data->indirections_len;
     config->default_queue = data->default_queue;
 }
@@ -1213,6 +1213,10 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
+    if (n->rss_data.peer_hash_available) {
+        return;
+    }
+
     if (n->rss_data.enabled) {
         n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
         if (n->rss_data.populate_hash) {
@@ -1227,7 +1231,7 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
         }
 
         trace_virtio_net_rss_enable(n,
-                                    n->rss_data.hash_types,
+                                    n->rss_data.runtime_hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
@@ -1338,7 +1342,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.runtime_hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     if (!do_rss) {
@@ -1401,12 +1405,12 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
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
@@ -1808,7 +1812,7 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_rx_pkt_set_protocols(pkt, &iov, 1, n->host_hdr_len);
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     net_hash_type = virtio_net_get_hash_type(hasip4, hasip6, l4hdr_proto,
-                                             n->rss_data.hash_types);
+                                             n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
             hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
@@ -3008,6 +3012,14 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
@@ -3044,12 +3056,28 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
+        if (!use_own_hash) {
+            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+            virtio_net_load_ebpf(n, errp);
+        }
+
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    if (!use_peer_hash) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+
+        if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+            if (!virtio_net_load_ebpf(n, errp)) {
+                return features;
+            }
+
+            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+        }
     }
+
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -3314,6 +3342,17 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
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
@@ -3321,14 +3360,16 @@ static bool virtio_net_rss_needed(void *opaque)
 
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
@@ -3915,8 +3956,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     net_rx_pkt_init(&n->rx_pkt);
 
-    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n, errp);
+    if (qemu_get_vnet_hash_supported_types(qemu_get_queue(n->nic)->peer,
+                                           &n->rss_data.peer_hash_types)) {
+        n->rss_data.peer_hash_available = true;
+        n->rss_data.supported_hash_types = n->rss_data.peer_hash_types;
+    } else {
+        n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cb63e09453..3452835ca9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -865,13 +865,13 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
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
MST


