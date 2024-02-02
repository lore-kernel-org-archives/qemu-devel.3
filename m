Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5225BC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVucj-0007G6-Bt; Fri, 02 Feb 2024 09:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVuch-0007Ep-CF
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVuce-0003XE-3H
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:31 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1992016a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706884346; x=1707489146;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pJNeY96w15YfW/OEvT/UPCTY5B/xrdsNQqzfTzuXso=;
 b=ijnwwujG7qoZEomK9Xu1WMhi3YhKmjYgI0QoV33fajLlUOv+RgFy6soQWKQY7ydVQu
 cn1HDhj81or7s9BSkW8Q7WqGoPYXw6Oq00XwNdMGuvCg62VKgezjx1AqqoBhKp0RhpyD
 6d5EuAFIWqJImL1f/4eUPWDfaJWmnRuGSNjTlyFa+NRSYw45HZBtbIYdAtoFv3IHkUZi
 5H/o6WIFIl9R+JqBTH6d98xMsfMqZCou+mxLukDMeB2sfu9DOfGTnhQXe8D9F6lwHdBo
 aVwDf1H6bRhbt9MdFZsUh2N/mYHmlk4EibwXcRp/T+tNg1/+PTWllIkppddzlRWiC/JZ
 uYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706884346; x=1707489146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pJNeY96w15YfW/OEvT/UPCTY5B/xrdsNQqzfTzuXso=;
 b=wVItkMPjZfHC2KILrrihcJHCA2PIDdz5iJOzi9DbiapsKGUmOCOb+mJZHdszZ60PWR
 7JKsct3+0Of183k1PBXXrVdH8vGuPA5GtpoFtVABuFpDIeYTOQt9TGY4SR7WEdLca8sW
 FnuRv5t/3iqP7iDQb9hJnNeKWq4Y0/M/twvPAbggpN2dk4eLXsBKKDAbsmMq3wAS6DXF
 AjudNTGZ8YcWTWexDTNkI+aGMmB3F6MuNJX3/9HqPitev3dO+Zc5JgZnOYOUaR5LrvdP
 LEkFP5/XxWjw5GSwwFi+cL1vJPYt8EqF+FKMru2uETBHeWmyefZJJq6ub4M675PonGp9
 2arg==
X-Gm-Message-State: AOJu0YxC2VyP3qQQxsViYwzQbFjJtT5ueeAMVP9vRljhIZMpiRV75O1y
 tlqgoC4cVcArYanbbT2JhoWp89+lQqhoIZbf6oUta3uKv5JTrug683nKzav3fPI976fnn7dRViL
 3v58s0A==
X-Google-Smtp-Source: AGHT+IEVUXs7YCrFvOcB1uA+70kPXR/sTtCztSkK8724mqf9BcbTjCwYTXCCvmoDQ6yNDkUGyX0ycw==
X-Received: by 2002:a05:6a21:9214:b0:19c:ac7f:c3e4 with SMTP id
 tl20-20020a056a21921400b0019cac7fc3e4mr8826176pzb.42.1706884345053; 
 Fri, 02 Feb 2024 06:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUXT/kAxV3YO03fFksI6XJamKGccWHu8uudipZDC5NScyyU5J3A6PA+Ai3kiUyV4uFzAAwdLAL+XuJK1NxEjV1AMjlpPINM1Aa3MLVUErOYjv5bvgj8Zn2F/sMz0y1qU7f8VHNluZLbxw==
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a056a000b2000b006dde023cce8sm1684703pfu.57.2024.02.02.06.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:32:24 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to numeric
 encoding
Date: Fri,  2 Feb 2024 22:32:15 +0800
Message-Id: <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706883915.git.yong.huang@smartx.com>
References: <cover.1706883915.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

x-query-virtio-status returns several sets of virtio feature and
status flags.  It goes back to v7.2.0.

In the initial commit 90c066cd682 (qmp: add QMP command
x-query-virtio-status), we returned them as numbers, using virtio's
well-known binary encoding.

The next commit f3034ad71fc (qmp: decode feature & status bits in
virtio-status) replaced the numbers by objects.  The objects represent
bits QEMU knows symbolically, and any unknown bits numerically just like
before.

Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command
"info virtio" (and a few more, which aren't relevant here).

The symbolic representation uses lists of strings.  The string format is
undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
explanation".

This symbolic representation is nice for humans.  Machines it can save
the trouble of decoding virtio's well-known binary encoding.

However, we sometimes want to compare features and status bits without
caring for their exact meaning.  Say we want to verify the correctness
of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
QMP command x-query-virtio-status to retrieve vhost-user net device
features, and the "ovs-vsctl list interface" command to retrieve
interface features.  Without commit f3034ad71fc, we could then simply
compare the numbers.  With this commit, we first have to map from the
strings back to the numeric encoding.

Revert the decoding for QMP, but keep it for HMP.

This makes the QMP command easier to use for use cases where we
don't need to decode, like the comparison above.  For use cases
where we need to decode, we replace parsing undocumented strings by
decoding virtio's well-known binary encoding.

Incompatible change; acceptable because x-query-virtio-status does
comes without a stability promise.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-hmp-cmds.c |  25 +++--
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 45 insertions(+), 195 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..721c630ab0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "virtio-qmp.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
@@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  endianness:              %s\n",
                    s->device_endian);
     monitor_printf(mon, "  status:\n");
-    hmp_virtio_dump_status(mon, s->status);
+    hmp_virtio_dump_status(mon,
+        qmp_decode_status(s->status));
     monitor_printf(mon, "  Guest features:\n");
-    hmp_virtio_dump_features(mon, s->guest_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->guest_features));
     monitor_printf(mon, "  Host features:\n");
-    hmp_virtio_dump_features(mon, s->host_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->host_features));
     monitor_printf(mon, "  Backend features:\n");
-    hmp_virtio_dump_features(mon, s->backend_features);
+    hmp_virtio_dump_features(mon,
+        qmp_decode_features(s->device_id, s->backend_features));
 
     if (s->vhost_dev) {
         monitor_printf(mon, "  VHost:\n");
@@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "    log_size:       %"PRId64"\n",
                        s->vhost_dev->log_size);
         monitor_printf(mon, "    Features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->features));
         monitor_printf(mon, "    Acked features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
         monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
+        hmp_virtio_dump_features(mon,
+            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
         monitor_printf(mon, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
+        hmp_virtio_dump_protocols(mon,
+            qmp_decode_protocols(s->vhost_dev->protocol_features));
     }
 
     qapi_free_VirtioStatus(s);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..1660c17653 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     status->name = g_strdup(vdev->name);
     status->device_id = vdev->device_id;
     status->vhost_started = vdev->vhost_started;
-    status->guest_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->guest_features);
-    status->host_features = qmp_decode_features(vdev->device_id,
-                                                vdev->host_features);
-    status->backend_features = qmp_decode_features(vdev->device_id,
-                                                   vdev->backend_features);
+    status->guest_features = vdev->guest_features;
+    status->host_features = vdev->host_features;
+    status->backend_features = vdev->backend_features;
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
     }
 
     status->num_vqs = virtio_get_num_queues(vdev);
-    status->status = qmp_decode_status(vdev->status);
+    status->status = vdev->status;
     status->isr = vdev->isr;
     status->queue_sel = vdev->queue_sel;
     status->vm_running = vdev->vm_running;
@@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
         status->vhost_dev->nvqs = hdev->nvqs;
         status->vhost_dev->vq_index = hdev->vq_index;
-        status->vhost_dev->features =
-            qmp_decode_features(vdev->device_id, hdev->features);
-        status->vhost_dev->acked_features =
-            qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
+        status->vhost_dev->features = hdev->features;
+        status->vhost_dev->acked_features = hdev->acked_features;
+        status->vhost_dev->backend_features = hdev->backend_features;
+        status->vhost_dev->protocol_features = hdev->protocol_features;
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 19c7c36e36..26516fb29c 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -102,10 +102,10 @@
             'n-tmp-sections': 'int',
             'nvqs': 'uint32',
             'vq-index': 'int',
-            'features': 'VirtioDeviceFeatures',
-            'acked-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
-            'protocol-features': 'VhostDeviceProtocols',
+            'features': 'uint64',
+            'acked-features': 'uint64',
+            'backend-features': 'uint64',
+            'protocol-features': 'uint64',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
             'log-enabled': 'bool',
@@ -170,11 +170,11 @@
             'device-id': 'uint16',
             'vhost-started': 'bool',
             'device-endian': 'str',
-            'guest-features': 'VirtioDeviceFeatures',
-            'host-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
+            'guest-features': 'uint64',
+            'host-features': 'uint64',
+            'backend-features': 'uint64',
             'num-vqs': 'int',
-            'status': 'VirtioDeviceStatus',
+            'status': 'uint8',
             'isr': 'uint8',
             'queue-sel': 'uint16',
             'vm-running': 'bool',
@@ -217,41 +217,14 @@
 #          "name": "virtio-crypto",
 #          "started": true,
 #          "device-id": 20,
-#          "backend-features": {
-#              "transports": [],
-#              "dev-features": []
-#          },
+#          "backend-features": 0,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 2,
-#          "guest-features": {
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#              ]
-#          },
-#          "host-features": {
-#              "unknown-dev-features": 1073741824,
-#              "dev-features": [],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
-#          },
+#          "guest-features": 5100273664,
+#          "host-features": 6325010432,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 1,
@@ -279,147 +252,22 @@
 #              "max-queues": 1,
 #              "backend-cap": 2,
 #              "log-size": 0,
-#              "backend-features": {
-#                  "dev-features": [],
-#                  "transports": []
-#              },
+#              "backend-features": 0,
 #              "nvqs": 2,
-#              "protocol-features": {
-#                  "protocols": []
-#              },
+#              "protocol-features": 0,
 #              "vq-index": 0,
 #              "log-enabled": false,
-#              "acked-features": {
-#                  "dev-features": [
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                  ]
-#              },
-#              "features": {
-#                  "dev-features": [
-#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                  ]
-#              }
-#          },
-#          "backend-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#              ]
+#              "acked-features": 5100306432,
+#              "features": 13908344832,
 #          },
+#          "backend-features": 6337593319,
 #          "start-on-kick": false,
 #          "isr": 1,
 #          "broken": false,
-#          "status": {
-#              "statuses": [
-#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#              ]
-#          },
+#          "status": 15,
 #          "num-vqs": 3,
-#          "guest-features": {
-#              "dev-features": [
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#             ]
-#          },
-#          "host-features": {
-#              "dev-features": [
-#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#              ],
-#              "transports": [
-#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#             ]
-#          },
+#          "guest-features": 5111807911,
+#          "host-features": 6337593319,
 #          "use-guest-notifier-mask": true,
 #          "vm-running": true,
 #          "queue-sel": 2,
-- 
2.31.1


