Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE2C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0O-0002zR-0j; Sat, 14 Sep 2024 21:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0M-0002xA-KE
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:46 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0K-0005RR-R9
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:46 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so1351972a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363483; x=1726968283;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WvHdtNnpckdi13gtOboMnLaoaTSIzoZUIyp9BN86gnQ=;
 b=e7leI3xgJ9owQSoOFzjKxr0+FIEsbi6iKCEh+6fpD97DVTsRepDH0aCptrX4JfPZEp
 Z8sY3jVBeKTgBfIVq6EwPUx6kwSV8iwUow++pYmnwfh5GMlJDLRuOB4KrqV2pe6u2rtz
 9pcnWxYmb3Lx9x2Xcl5EVBrzCmtMIf4UoYpMoaM0qJkOeD5YHfj1Bi27I3QqZRau5BdP
 WlP8/xjrHo41su5oobHnU97U6+v+6SeNAQBWyX9erKMgqX/6SVyO6hjB+MEMqfQsc2mp
 YA0oC4Do5Cy19w8dUSZ5wZ5yTOzU+wsCFvMaYz+LoNYwYkr9NpLdBjbhamF8aFoCRfNs
 GrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363483; x=1726968283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvHdtNnpckdi13gtOboMnLaoaTSIzoZUIyp9BN86gnQ=;
 b=Yg5ik3uhTwUJtgDhUV7xuLhG1xx/dPfoXtKYv8rHii6LrR+MvH7Z7w8L4dhAgOP/9g
 31pjjVwLnFqg6Udt93HQ8u5uoBsitlm3fWugQYe1J5tqE5YX5rQ8Plv6FTDH1Pbdyjl1
 0b1VdGD/1vnhe4hvrmFdLIoaNYNtF2TK7iwIvuX1n86TxWuho2vTaphaXHs+Rqge7y13
 0tvWNmdg6OM0XYlCH5StHiaJBH7ognCdf+unsnHt7LPM4wqXm7g7ECpzWDgzXMwLpPmr
 VqnD5AN4/fl1DEeiViWipwGoKdRuGiwN4C2kM86e+cusSAufNEnL1ZtqBFisqSL9BtQy
 G+JQ==
X-Gm-Message-State: AOJu0Ywx742AqcFJ6hOCORQKfNPVQG8w5bpDP4XJuM8CP+5JrBEQIJzN
 iPsBSaV+yQd811+S3pPBMFeyJz7YMm6miMwpp6/PtHuGq9PKw7VAL6NyycLoXijw5c5YRwPqu4J
 aZZA=
X-Google-Smtp-Source: AGHT+IE64j8WVDCJalKgzDLgIPGNcBPxjAqxdPPIiQf+Cb2xR3T/OHB1bA6rXEK0/ykSFhSGWJA4/A==
X-Received: by 2002:a05:6a20:b58b:b0:1d1:17c6:7a34 with SMTP id
 adf61e73a8af0-1d117c67a4dmr7864491637.45.1726363483290; 
 Sat, 14 Sep 2024 18:24:43 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944b7aed3sm1531402b3a.114.2024.09.14.18.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:44 +0900
Subject: [PATCH RFC v3 03/11] virtio-net: Move virtio_net_get_features() down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-3-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

Move virtio_net_get_features() to the later part of the file so that
it can call other functions.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 146 ++++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b4a3fb575c7c..206b0335169d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -750,79 +750,6 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc = qemu_get_queue(n->nic);
-
-    /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
-
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
-
-    if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-    }
-
-    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
-    }
-
-    if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-    }
-
-    if (!get_vhost_net(nc->peer)) {
-        return features;
-    }
-
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
-
-    if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
-        features |= (1ULL << VIRTIO_NET_F_MTU);
-    }
-
-    /*
-     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
-     * enabled. This happens in the vDPA case.
-     *
-     * Make sure the feature set is not incoherent, as the driver could refuse
-     * to start.
-     *
-     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
-     * helping guest to notify the new location with vDPA devices that does not
-     * support it.
-     */
-    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
-    }
-
-    return features;
-}
-
 static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 {
     uint64_t features = 0;
@@ -3041,6 +2968,79 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     virtio_net_set_queue_pairs(n);
 }
 
+static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    /* Firstly sync all virtio-net possible supported features */
+    features |= n->host_features;
+
+    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+
+    if (!peer_has_vnet_hdr(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+    }
+
+    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+    }
+
+    if (!peer_has_uso(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    }
+
+    if (!get_vhost_net(nc->peer)) {
+        return features;
+    }
+
+    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    }
+    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    vdev->backend_features = features;
+
+    if (n->mtu_bypass_backend &&
+            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+        features |= (1ULL << VIRTIO_NET_F_MTU);
+    }
+
+    /*
+     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
+     * enabled. This happens in the vDPA case.
+     *
+     * Make sure the feature set is not incoherent, as the driver could refuse
+     * to start.
+     *
+     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
+     * helping guest to notify the new location with vDPA devices that does not
+     * support it.
+     */
+    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+    }
+
+    return features;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;

-- 
2.46.0


