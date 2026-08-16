Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DF8C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvZMt-0001oM-OP; Sun, 16 Aug 2026 07:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSb1-0000le-Us
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSb0-0003Gk-Bz
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so18817515e9.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786854941; x=1787459741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O1q1TMFyF//zhxzhHPJ+eLgFtmqB4YMCiYqMQiDtR3E=;
 b=NKGZqC90VyFgnh7EXIO3j3SYximp6X90EjLx6wizHRzut1hCIv0FenW8hLup5FeeM5
 MJPX4jPfjUdH8OaY3KDb722XgUcL/c81v9fohE/oLKfmnoUtsWoTYzhjXoxyqwOKid63
 rbXJYFRGZxclCDkOCb4omsYWRe9zRQWLnxyrajLesEsCPBdcx6CBx2SycdIJAkqutbuK
 XEyeomnD6FWWwXPD5yBF+XQtPXcuf3DokemLOCamEz+6Goqmwz86FrH9Ps9zueEDHmt4
 hrzbfN/IBgbd0uNHX9uFxWt0DpFSIWMmsuvI/Vu/Ry2DvQ0VqsL9ehOAxHWUx5PVzN+b
 BItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786854941; x=1787459741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O1q1TMFyF//zhxzhHPJ+eLgFtmqB4YMCiYqMQiDtR3E=;
 b=jSraKsNNMX3GeIazD47oX2JW6s1BmTZxKoqsJNlrUCeuYdFUECed2/e2n1pMH/HQdx
 pqLq96E7K8KyND8jHRC/BDfKgCBIrtS7fbsCQp26yDodiSyaKIW24kpJR9aCz83vqv3l
 QnSPW0EmpcSRU2OUwXr6I7cEnIfNBUv3FDbFuGVf+0afMgmEILeiLknvUD5loRVpQ3Rc
 HCyJd9j47F+9U4kg+hwF3jJxGGYOjba52xTo2Y2zCefhR8gyGzWYLy6rVgUEvo37fzYz
 kWm3uontSnSIvmh3l2mFw12IjXAnkzb3OUqaxuC9wFIFtwvUaz5PYeQtgC4Oqmnz6Iub
 y0Tw==
X-Gm-Message-State: AOJu0YwQs45tUH43v4ItctV+FSZmje0vhsX9UPWvqx9+eAicN+ucFEwL
 d52MLeue7SFT4Q4DaAGQdQm0MsyBM88kK+9Ia2sJq0OEOQXtZHUPUtqiaIQ3lFwE
X-Gm-Gg: AR+sD10MJlG9ZNeJBnbc4J7GByjT/n9oWxBEdlWrQTRkKsKzCx3zusMEAodfC1HT5aS
 lHZMkUG+6MdnawxbZEXILiiER4KizKkwzgzyQNPo28X8xTIl1mk6db/ESCxHAqZYQiK/WTnhCeI
 T8Em8AXyQaHvxVW6aJm4bhebtyttrVcHELnc172Kt4Bz+qGODPSbRxvYwIyMBJXWsZ/b6gGfGAC
 PkIXP4kUJll+MRUAwkmNlWoHgbIK50Y3koquob4cPMgSa0v1P8l9yzwBo+h+mSc4psuBlvo8FH2
 5Qc0Jh52jtW/9FndG7rX+Ego01e49GmJLI7uXp2Ne4RVTatPt/mv7gEO7s0DztvneIaoN/sHotW
 a3ETthBEl5R/CDoEbRthj0Mi8s0230MBEdN3AaKyRiZ7U6PgzBBg6AwHLoigSwZC9Fp0rCGYUMf
 UxcSGQRshwlVfmi4Fjnpbt7+TUDKJEE72hRyXsly6wcbljG8zoG/guVMwYU+BYgCYzLD2V2TxQO
 Xrn/Zs+4KEpmQ==
X-Received: by 2002:a05:600c:620a:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-499879b9c2fmr269157485e9.17.1786854940704; 
 Sat, 15 Aug 2026 21:35:40 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.67.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b27bfsm22971471f8f.23.2026.08.15.21.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 21:35:40 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH 3/3] virtio-net: add mtu-from-tap property for automatic MTU
 detection
Date: Sun, 16 Aug 2026 07:34:51 +0300
Message-Id: <20260816043451.2547-4-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816043451.2547-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 16 Aug 2026 07:49:20 -0400
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

Currently, exposing the host tap device's MTU to the guest via
VIRTIO_NET_F_MTU requires manually specifying host_mtu= on the
virtio-net-pci device, duplicating the MTU already configured on
the host's tap interface.

Add a new mtu-from-tap boolean property (default off, preserving
existing behavior). When enabled and the device's netdev peer is
a tap client, the host tap's MTU is queried via tap_get_mtu() and
used to set net_conf.mtu and enable VIRTIO_NET_F_MTU.

This detection must happen in virtio_net_device_realize(), before
virtio_net_set_config_size() computes the virtio config space
size from host_features. Performing the detection later (e.g. in
the get_features_ex() callback, which runs after the NIC and its
config space are already sized) results in the mtu config field
falling outside the sized config space, and the guest reading
back an unmapped garbage value (0xffff) instead of the intended
MTU.

Since qemu_new_nic() has not yet been called at this point in
realize(), the tap peer is accessed via n->nic_conf.peers.ncs[0]
(populated during property parsing, before realize() runs, via
the netdev= property) rather than through n->nic.

Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
---
 hw/net/virtio-net.c            | 12 ++++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d..6faeca87d4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3901,6 +3901,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->net_conf.mtu_from_tap) {
+        NetClientState *tap_peer = n->nic_conf.peers.ncs[0];
+        if (tap_peer && tap_peer->info->type == NET_CLIENT_DRIVER_TAP) {
+            int mtu = tap_get_mtu(tap_peer);
+            if (mtu > 0) {
+                n->net_conf.mtu = mtu;
+                n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
+            }
+        }
+    }
+
     if (n->net_conf.duplex_str) {
         if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
             n->net_conf.duplex = DUPLEX_HALF;
@@ -4275,6 +4286,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
                        VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
+    DEFINE_PROP_BOOL("mtu-from-tap", VirtIONet, net_conf.mtu_from_tap, false),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..11044b6d27 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -52,6 +52,7 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    bool mtu_from_tap;
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
-- 
2.34.1


