Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04457CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDl-0007TL-85; Sun, 05 Oct 2025 15:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDd-0007Rn-K2
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDb-0006Me-Gz
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vd4mdDSqlXlP9anYwvuHCBfNnSb8ZvgPYM0HvzpPyDo=;
 b=HttCYaaXeOGSoSVmJ7FIPlus4JQM1ofh2tiylI/W4JeZG/TUey9jWyNB87zynm6s9q97k8
 pGtp94YDfthummM/eyAwejSzVobVYNlWqAao7kFeBLwumQCeEtbUrR4fFfanw+TCjw3Ypm
 3vXw2ALzerlrjmbRb7bejdEJqHNaWtc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Pp3L1QMBPDqQNwBZZOKTKw-1; Sun, 05 Oct 2025 15:16:25 -0400
X-MC-Unique: Pp3L1QMBPDqQNwBZZOKTKw-1
X-Mimecast-MFC-AGG-ID: Pp3L1QMBPDqQNwBZZOKTKw_1759691784
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42421b15185so3097767f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691784; x=1760296584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vd4mdDSqlXlP9anYwvuHCBfNnSb8ZvgPYM0HvzpPyDo=;
 b=jsttjB4M8jB61mo2P1QarAF/0tarIsLgm3sesGHlSlkaxp11DSlQteHyEOUFvU8WRJ
 JRMuqE5GLvJCuXsiuwTV6N55PqwEAl4S5SFSZJ8ZDNKL5BkKqRxIcdst3bin/uXmDfEr
 n8GC4fZRCQfnrBoXDSVodLibigtVhXbXFpWDEETfJh1XwkOa8AGllWuP3zON7N9G5rFf
 4iRA3/AIxAYx+J3cxShJbcE9oC42nz2vowC7d0yxxe/9zOuTahiPl6Q4Uf1Cl0/AutyG
 C656BLZDtfFhxcu+4g/LzQTuI1ttpsxiRrVsV/T7FF5CjlNxl03bFVPRZuBO+0HFO6qu
 Iy/Q==
X-Gm-Message-State: AOJu0Yyd0I4bBas82kPZb7CrS/znXKbxLw/849VftfOzjhU+T33kK82U
 HTqBDrG5tvbx+uh8uODJii5BQyzhQD4eiY0lOKKpZ1I+9MGTvC8HB7Xos58vcNltR+pOy08ic97
 OeUrz4AJdD0t3TFQ6MEbNr+WkHdxhFxVSpgZNGOVbfhZXPADciWqirnuK/HVqvaEvOsBaZp/R1t
 aFT5Kh+4NTtQy0QFp7X9gWwUv60kO8YEvXAA==
X-Gm-Gg: ASbGnct+khwyhLsdvbEiZDEffWKzQ3hDZwvK84U/jaK0h6AcvCKshpuaUdaYOi/g8St
 x8Y7cnp/jKH8mK7Yj5opM2iLQ9tq+vdQv/MNtNkxvPmdZknEQqIzE+46VJaMmUZ7F4qERM3xGne
 DRJt1mCB/TdtpFEvZ3y73J2bm5Bxs6GXYSDsz5aeFKlAy9L/1inlzVSDoHySg2bxjvMRxbm+4SD
 4pA7krQQwRkT4Lfa/bz6g1BXr06SZ8ufnhqYNxEjvs0EMOW4ERMoIAntZS7eLMz08ewKZE9qOlz
 tLPMJV+2ZoLQz//UuPWRXKJr/BMsKPTCQ4gZj2k=
X-Received: by 2002:a05:6000:2282:b0:401:e7a8:5ca2 with SMTP id
 ffacd0b85a97d-425671a31e7mr6303241f8f.33.1759691783993; 
 Sun, 05 Oct 2025 12:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXcbBfZ5c4zHoG1hZwR0SpEHYB3p+3cWzFl+zyJANyMlYfbetynLbuFEEmwIJ+7XbPc76ksQ==
X-Received: by 2002:a05:6000:2282:b0:401:e7a8:5ca2 with SMTP id
 ffacd0b85a97d-425671a31e7mr6303215f8f.33.1759691783381; 
 Sun, 05 Oct 2025 12:16:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c3esm17614126f8f.1.2025.10.05.12.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:22 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 09/75] qmp: update virtio features map to support extended
 features
Message-ID: <a76f5b795cab8ea0654e4813caa694470d7250a9.1759691708.git.mst@redhat.com>
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

Extend the VirtioDeviceFeatures struct with an additional u64
to track unknown features in the 64-127 bit range and decode
the full virtio features spaces for vhost and virtio devices.

Also add entries for the soon-to-be-supported virtio net GSO over
UDP features.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <e51969f94d89045b333f1bc5ef5fca9e12fc371a.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/virtio.json            |  9 +++-
 hw/virtio/virtio-qmp.h      |  3 +-
 hw/virtio/virtio-hmp-cmds.c |  3 +-
 hw/virtio/virtio-qmp.c      | 91 +++++++++++++++++++++++++------------
 4 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9d652fe4a8..05295ab665 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -247,6 +247,7 @@
 #              },
 #              "host-features": {
 #                  "unknown-dev-features": 1073741824,
+#                  "unknown-dev-features2": 0,
 #                  "dev-features": [],
 #                  "transports": [
 #                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
@@ -490,14 +491,18 @@
 #     unique features)
 #
 # @unknown-dev-features: Virtio device features bitmap that have not
-#     been decoded
+#     been decoded (bits 0-63)
+#
+# @unknown-dev-features2: Virtio device features bitmap that have not
+#     been decoded (bits 64-127) (since 10.2)
 #
 # Since: 7.2
 ##
 { 'struct': 'VirtioDeviceFeatures',
   'data': { 'transports': [ 'str' ],
             '*dev-features': [ 'str' ],
-            '*unknown-dev-features': 'uint64' } }
+            '*unknown-dev-features': 'uint64',
+            '*unknown-dev-features2': 'uint64' } }
 
 ##
 # @VirtQueueStatus:
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 245a446a56..e0a1e49035 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -18,6 +18,7 @@
 VirtIODevice *qmp_find_virtio_device(const char *path);
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
 VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          const uint64_t *bitmap);
 
 #endif
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 7d8677bcf0..1daae482d3 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
     }
 
     if (features->has_unknown_dev_features) {
-        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
+        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
+                       features->unknown_dev_features2,
                        features->unknown_dev_features);
     }
 }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d..b338344c6c 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
             "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
             "negotiation supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
+            "UDP tunnel packets"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
+            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
+            "UDP tunnel packets requiring checksum offload for the outer "
+            "header"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
+            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
+            "UDP tunnel packets"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
+            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM: Device can receive GSO over "
+            "UDP tunnel packets requiring checksum offload for the outer "
+            "header"),
     { -1, "" }
 };
 #endif
@@ -510,6 +524,24 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
         list;                                            \
     })
 
+#define CONVERT_FEATURES_EX(type, map, bitmap)           \
+    ({                                                   \
+        type *list = NULL;                               \
+        type *node;                                      \
+        for (i = 0; map[i].virtio_bit != -1; i++) {      \
+            bit = map[i].virtio_bit;                     \
+            if (!virtio_has_feature_ex(bitmap, bit)) {   \
+                continue;                                \
+            }                                            \
+            node = g_new0(type, 1);                      \
+            node->value = g_strdup(map[i].feature_desc); \
+            node->next = list;                           \
+            list = node;                                 \
+            virtio_clear_feature_ex(bitmap, bit);        \
+        }                                                \
+        list;                                            \
+    })
+
 VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
 {
     VirtioDeviceStatus *status;
@@ -545,109 +577,112 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
     return vhu_protocols;
 }
 
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
+VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
+                                          const uint64_t *bmap)
 {
+    uint64_t bitmap[VIRTIO_FEATURES_NU64S];
     VirtioDeviceFeatures *features;
     uint64_t bit;
     int i;
 
+    virtio_features_copy(bitmap, bmap);
     features = g_new0(VirtioDeviceFeatures, 1);
     features->has_dev_features = true;
 
     /* transport features */
-    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
-                                            bitmap);
+    features->transports = CONVERT_FEATURES_EX(strList, virtio_transport_map,
+                                               bitmap);
 
     /* device features */
     switch (device_id) {
 #ifdef CONFIG_VIRTIO_SERIAL
     case VIRTIO_ID_CONSOLE:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_BLK
     case VIRTIO_ID_BLOCK:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_GPU
     case VIRTIO_ID_GPU:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_NET
     case VIRTIO_ID_NET:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_SCSI
     case VIRTIO_ID_SCSI:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_BALLOON
     case VIRTIO_ID_BALLOON:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_IOMMU
     case VIRTIO_ID_IOMMU:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_INPUT
     case VIRTIO_ID_INPUT:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_USER_FS
     case VIRTIO_ID_FS:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_VSOCK
     case VIRTIO_ID_VSOCK:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_CRYPTO
     case VIRTIO_ID_CRYPTO:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_MEM
     case VIRTIO_ID_MEM:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_I2C_ADAPTER
     case VIRTIO_ID_I2C_ADAPTER:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VIRTIO_RNG
     case VIRTIO_ID_RNG:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
         break;
 #endif
 #ifdef CONFIG_VHOST_USER_GPIO
     case VIRTIO_ID_GPIO:
         features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+            CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
         break;
 #endif
     /* No features */
@@ -680,10 +715,9 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         g_assert_not_reached();
     }
 
-    features->has_unknown_dev_features = bitmap != 0;
-    if (features->has_unknown_dev_features) {
-        features->unknown_dev_features = bitmap;
-    }
+    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
+    features->unknown_dev_features = bitmap[0];
+    features->unknown_dev_features2 = bitmap[1];
 
     return features;
 }
@@ -743,11 +777,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
     status->guest_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->guest_features);
+                                                 vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
-                                                vdev->host_features);
+                                                vdev->host_features_ex);
     status->backend_features = qmp_decode_features(vdev->device_id,
-                                                   vdev->backend_features);
+                                                 vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -785,11 +819,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
         status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
+            qmp_decode_features(vdev->device_id, hdev->features_ex);
         status->vhost_dev->acked_features =
-            qmp_decode_features(vdev->device_id, hdev->acked_features);
+            qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
         status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
+            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
+
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
-- 
MST


