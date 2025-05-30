Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4ABC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRi-0001l9-Mh; Fri, 30 May 2025 00:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRM-0001N8-9F
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrR1-0005KN-34
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742af848148so1027174b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579613; x=1749184413;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Zxy0RFU8N4trMrRBRmAFZjrhHTvZ0aptypNMIJeX1M=;
 b=p3zymd+cv1sE7swfsyoSZpG1X16lHTzaiP5nYwLuFvPzNOejHqiQBNBrdizc7kxgwo
 mIEv+ENcS5y6PkK4z/NhZzP1IG0N8lSlCGPPJKE4oQ7EThMEmq+HcICZvcUDy+SrA7r0
 zfVWLaRlKiUrF1WGsWe37b8Jnp0NLLYswTHtE1Fv5lZXSv4hkqKY1w7NVfC6BIZOttL+
 iKBw019VhEWHOflC/ozjcMNKSPSPZMwZVVAg7sAd7uxerEnSnnybDxkFkFprH5LkPmd1
 4SSPME3gZbhbLE1eJKrYpJUhB8nS/TrDtU4qGpOhEoUa99sdSFM3LQXXEW31FGdSdJ/m
 SIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579613; x=1749184413;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Zxy0RFU8N4trMrRBRmAFZjrhHTvZ0aptypNMIJeX1M=;
 b=bwGhVHystKM4372fy9uma+z5RJoNts7tMU87I7hLjWvrG6rrwPC9S/aIoPr75D+MTR
 tNjgPd2b2yGJk+LtkvzNILB6rCYfARgkHeba+FavBQ36u1fGsmCwfr3SR6ex0TGv20ob
 GOVmXkOUtrOYq87s6w2hEat9QJdnX+MC5kyHVArfH2aEIhknN6l765F2rQOXMzLjAJ+/
 ngu3IGE91pcvWOV41gZ8b5f/zrhYNoFxqCWm3F+17Kho0zfMqwrV37vcleIEr9skOhjQ
 zVknOwcyAYmUqz+ozYXynLv6M7mc7p7KpqKGfjwKXXs2MwLweGkj/2M2dDB5ZRpeCDy/
 x4xw==
X-Gm-Message-State: AOJu0Yz5TmE8/RDeQEbR5h9sJr2RbzUCurUDgBHBXoDch/BMElt1f6oC
 jgeyuvMAjhthovpiGcSrmUWqZKxnTwdINPq/oIfAAL0SyFQoE4cNy6sPW9F4GVSN+IY9tH87Mcr
 AQbXu
X-Gm-Gg: ASbGncvtu7lJLhAiSHEcfVepWJBEiM3xBmRYoBExgSmqWkK5XWrqpUhf4YCjg94KKNq
 ZinssJ2nE6s1nUlIAbIckxD9QsS6uhcWius5/nfeQe5PUKZowwmdSyXLAozqgioUtn0NIkTF7bT
 H9b8es2VOd0OFyvbiaUrycl5JhUu2iKDHgUDp9Tze53Km6zAaE1xTAGQGP0jgvDU48RvOzNdx0m
 S+8hPLNZSa2dVioxcKbuYiPPh6lg/Y5HO7JNREK/e3UZriTcqgHH5guRiaHpCgwMis0VDGuCrHK
 Fg+2Sg4okX8goUBM/oE9Ievu1V81QA/2DQvdcg5LtA6Lrxzaq8Qx
X-Google-Smtp-Source: AGHT+IH8J2ctCk1Nf99Bkb/RlH65K7izPe+rVX2Ae7kQadke9xuZ8vxvZDvwrS4MaV5F17e9VU++iA==
X-Received: by 2002:a05:6a20:d045:b0:21a:b9d4:ad73 with SMTP id
 adf61e73a8af0-21ad98f00b2mr3764881637.40.1748579613575; 
 Thu, 29 May 2025 21:33:33 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b2eceb048dcsm766608a12.12.2025.05.29.21.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:18 +0900
Subject: [PATCH 3/6] virtio-net: Move virtio_net_get_features() down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-3-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 221252e00a50..4ebe7f93f5c3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -752,79 +752,6 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
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
@@ -3076,6 +3003,79 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev)
     return 0;
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
2.49.0


