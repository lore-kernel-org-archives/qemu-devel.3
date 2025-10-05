Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A01CCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDo-0007Up-L0; Sun, 05 Oct 2025 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDZ-0007RD-96
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDX-0006MD-4R
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYadMOaENieYb148icK+VaNmWm4vj/PKt597pX2AzBE=;
 b=DT1q2XlXoIL3+iC4eP3mOQXqkAMU4xSS9JhDEey3GjxyHO+qCwHRQbv76b7ke73vV1/LXV
 ra8foS6NLxSXK/HREU+xpkdeevZGW0UwkfM4cXnxKcEnSB/u4knZWkbECbKE97SQ+zmwqH
 eFJk8sOGyHrGeeT2r+MuolTHVDcWb/U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-f1f9_LJENjyTO6ZX_CGNHQ-1; Sun, 05 Oct 2025 15:16:20 -0400
X-MC-Unique: f1f9_LJENjyTO6ZX_CGNHQ-1
X-Mimecast-MFC-AGG-ID: f1f9_LJENjyTO6ZX_CGNHQ_1759691779
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e41c32209so19661805e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691779; x=1760296579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYadMOaENieYb148icK+VaNmWm4vj/PKt597pX2AzBE=;
 b=ca/c5HjXdvc7FN/0iXijJTSNbH8SsE2IM4eHJBDJGZsDBE5LVYjzWypwxAE3KuZkEO
 LiFA+271kfKmjYxiRPoImisPW9bXpdg0hBjheXkPXvv/YHs6XOw/nI0ulnX6qf3Ma7Dw
 mw2ChICgkF/VQFP5ltycNJeY8hz/WjE6e8MRF+Z7ESkhnk9O6Cdylp2/3VLqjqr6yonw
 MnHq4Nbg/sH4KQnPnKk4UkqLdb8H3KYCVGGpDILjsnoFCR5yW2tnNbxblOX+tR406I/+
 UE9BxLEmLhb8Am+w1S2CEEsoc6fUmNT2jJ8ajVDzT/RFd4vEDYm856zUYlmTiN9GRZuB
 ZYbg==
X-Gm-Message-State: AOJu0YzNmZBjC2I4MhP/qVn2TmZNHyrFy8OvEN3dlAF/88Gtoz3hbAlQ
 yBhyF/93uWH+CugDmr+u7j2EoxM3I/OqiaiSKQVmmn4sbYEVmA8h9jvojXRjWgJjwzzqjTtzsKv
 Fv3m6UsA4PvpaDqmfUG+eDCb9AMER14xfDbdGq0Kc4UVJZotEgGOLpepEllhpIf2Fvy6nuF+4kB
 KM8F7XH7Ox+m+xB98QXp65lwoMxqmrRP/UTQ==
X-Gm-Gg: ASbGncv0C8WZfw+z/Qfuc8CG6MGdE6NmixYUFhltn6NgcBgqHkgmk0hN0QEzLUoQBR3
 TV79WKqEeCaKMa1ih4seMEpj9pM0qXwRbeGGJOOfsaeluOFWn+I+h9lwU8wgmYmYFMTVYU53Q+4
 0crWVTPH9BPIzqUobs1U26h0ft7gLOeV/S45YDtpBKzmdT1c5NMPgaIjINqPgeXvNxrZl5eqQFV
 TLT9ecleXIS6HGv7/YhdtB/gmWL+pi7otAWsgIJQUXtgRfbo4Bo2Cobls5DAUbsWN54FUzyidvF
 jSjJcKFrhoTKjGndr9zjwOZLmBTlejHNaRQ6PRM=
X-Received: by 2002:a05:600c:8185:b0:468:7a5a:1494 with SMTP id
 5b1f17b1804b1-46e710f6c7amr58387995e9.1.1759691779209; 
 Sun, 05 Oct 2025 12:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWPKvvenOMbUd1eVy/txA2vZ0SV/DPwJyyKrRQzLERmJditeSADYlFiEOHf7tbmEjv5f+Eg==
X-Received: by 2002:a05:600c:8185:b0:468:7a5a:1494 with SMTP id
 5b1f17b1804b1-46e710f6c7amr58387875e9.1.1759691778776; 
 Sun, 05 Oct 2025 12:16:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm217403965e9.7.2025.10.05.12.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:18 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 07/75] virtio-pci: implement support for extended features
Message-ID: <712c79d6d374e7abe94599de5ba2d155d5a79955.1759691708.git.mst@redhat.com>
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

Extend the features configuration space to 128 bits. If the virtio
device supports any extended features, allow the common read/write
operation to access all of it, otherwise keep exposing only the
lower 64 bits.

On migration, save the 128 bit version of the features only if the
upper bits are non zero. Relay on reset to clear all the feature
space before load.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <c0b81601f65b41ca8310eba8f05e2dcf3702de89.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-pci.h |  2 +-
 hw/virtio/virtio-pci.c         | 76 ++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index eab5394898..639752977e 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -158,7 +158,7 @@ struct VirtIOPCIProxy {
     uint32_t nvectors;
     uint32_t dfselect;
     uint32_t gfselect;
-    uint32_t guest_features[2];
+    uint32_t guest_features[VIRTIO_FEATURES_NU32S];
     VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
 
     VirtIOIRQFD *vector_irqfd;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..01e4fecaf4 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -109,6 +109,29 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
     }
 };
 
+static bool virtio_pci_modern_state_features128_needed(void *opaque)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    uint32_t features = 0;
+    int i;
+
+    for (i = 2; i < ARRAY_SIZE(proxy->guest_features); ++i) {
+        features |= proxy->guest_features[i];
+    }
+    return features;
+}
+
+static const VMStateDescription vmstate_virtio_pci_modern_state_features128 = {
+    .name = "virtio_pci/modern_state/features128",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_pci_modern_state_features128_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 2, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool virtio_pci_modern_state_needed(void *opaque)
 {
     VirtIOPCIProxy *proxy = opaque;
@@ -116,6 +139,12 @@ static bool virtio_pci_modern_state_needed(void *opaque)
     return virtio_pci_modern(proxy);
 }
 
+/*
+ * Avoid silently breaking migration should the feature space increase
+ * even more in the (far away) future
+ */
+QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU32S != 4);
+
 static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .name = "virtio_pci/modern_state",
     .version_id = 1,
@@ -124,11 +153,15 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
-        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 0, 2),
         VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
                              vmstate_virtio_pci_modern_queue_state,
                              VirtIOPCIQueue),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_virtio_pci_modern_state_features128,
+        NULL
     }
 };
 
@@ -1477,6 +1510,19 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
     return virtio_pci_add_mem_cap(proxy, &cap.cap);
 }
 
+static int virtio_pci_select_max(const VirtIODevice *vdev)
+{
+    int i;
+
+    for (i = VIRTIO_FEATURES_NU64S - 1; i > 0; i--) {
+        if (vdev->host_features_ex[i]) {
+            return (i + 1) * 2;
+        }
+    }
+
+    return 2;
+}
+
 static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
@@ -1494,18 +1540,21 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
         val = proxy->dfselect;
         break;
     case VIRTIO_PCI_COMMON_DF:
-        if (proxy->dfselect <= 1) {
+        if (proxy->dfselect < virtio_pci_select_max(vdev)) {
             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
-            val = (vdev->host_features & ~vdc->legacy_features) >>
-                (32 * proxy->dfselect);
+            val = vdev->host_features_ex[proxy->dfselect >> 1] >>
+                  (32 * (proxy->dfselect & 1));
+            if (proxy->dfselect <= 1) {
+                val &= (~vdc->legacy_features) >> (32 * proxy->dfselect);
+            }
         }
         break;
     case VIRTIO_PCI_COMMON_GFSELECT:
         val = proxy->gfselect;
         break;
     case VIRTIO_PCI_COMMON_GF:
-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
             val = proxy->guest_features[proxy->gfselect];
         }
         break;
@@ -1588,11 +1637,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         proxy->gfselect = val;
         break;
     case VIRTIO_PCI_COMMON_GF:
-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
+            uint64_t features[VIRTIO_FEATURES_NU64S];
+            int i;
+
             proxy->guest_features[proxy->gfselect] = val;
-            virtio_set_features(vdev,
-                                (((uint64_t)proxy->guest_features[1]) << 32) |
-                                proxy->guest_features[0]);
+            virtio_features_clear(features);
+            for (i = 0; i < ARRAY_SIZE(proxy->guest_features); ++i) {
+                uint64_t cur = proxy->guest_features[i];
+
+                features[i >> 1] |= cur << ((i & 1) * 32);
+            }
+            virtio_set_features_ex(vdev, features);
         }
         break;
     case VIRTIO_PCI_COMMON_MSIX:
@@ -2311,6 +2367,8 @@ static void virtio_pci_reset(DeviceState *qdev)
     virtio_bus_reset(bus);
     msix_unuse_all_vectors(&proxy->pci_dev);
 
+    memset(proxy->guest_features, 0, sizeof(proxy->guest_features));
+
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
         proxy->vqs[i].reset = 0;
-- 
MST


