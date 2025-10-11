Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FA7CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aA5-0008KR-DY; Sat, 11 Oct 2025 10:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a8B-0006QR-0I
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:32 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7l-0004oE-G1
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BF038C019E;
 Sat, 11 Oct 2025 16:58:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-XgPtueZF; Sat, 11 Oct 2025 16:58:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191107;
 bh=Bgh0I22tjtIDyexIumg/uvSCP31Lm0cC6x+V9gfgWiY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PaWigYbaCeYDGghuUqA+0kQEl0yO2RbcSfZImm6EdAxMw6EMusf5p57HoOp4wvTOh
 i4hq9nhy1WzhhpfoxL9sTn/6rUssLq/8DFem/BK80X7PvUh/FCVsu9lDzlf2nN8rg6
 NWSYX8v0tQiHXUSzkijGrhHdenv7UmQanZfNGcrA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 31/33] qapi/virtio.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:57:41 +0300
Message-ID: <20251011135754.294521-61-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

For x-query-virtio-status just drop the examples. No idea how
to bring them into 70 columns width. And the command is unstable
anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/virtio.json | 269 ++++-------------------------------------------
 1 file changed, 20 insertions(+), 249 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 05295ab665..5e5250944c 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -42,23 +42,23 @@
 #     <- { "return": [
 #              {
 #                  "name": "virtio-input",
-#                  "path": "/machine/peripheral-anon/device[4]/virtio-backend"
+#                  "path": "/machine/peripheral-anon/device[4]/vir..."
 #              },
 #              {
 #                  "name": "virtio-crypto",
-#                  "path": "/machine/peripheral/crypto0/virtio-backend"
+#                  "path": "/machine/peripheral/crypto0/virtio-bac..."
 #              },
 #              {
 #                  "name": "virtio-scsi",
-#                  "path": "/machine/peripheral-anon/device[2]/virtio-backend"
+#                  "path": "/machine/peripheral-anon/device[2]/vir..."
 #              },
 #              {
 #                  "name": "virtio-net",
-#                  "path": "/machine/peripheral-anon/device[1]/virtio-backend"
+#                  "path": "/machine/peripheral-anon/device[1]/vir..."
 #              },
 #              {
 #                  "name": "virtio-serial",
-#                  "path": "/machine/peripheral-anon/device[0]/virtio-backend"
+#                  "path": "/machine/peripheral-anon/device[0]/vir..."
 #              }
 #          ]
 #        }
@@ -204,239 +204,6 @@
 # Returns: Status of the virtio device
 #
 # Since: 7.2
-#
-# .. qmp-example::
-#    :annotated:
-#
-#    Poll for the status of virtio-crypto (no vhost-crypto active)
-#    ::
-#
-#     -> { "execute": "x-query-virtio-status",
-#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
-#        }
-#     <- { "return": {
-#              "device-endian": "little",
-#              "bus-name": "",
-#              "disable-legacy-check": false,
-#              "name": "virtio-crypto",
-#              "started": true,
-#              "device-id": 20,
-#              "backend-features": {
-#                  "transports": [],
-#                  "dev-features": []
-#              },
-#              "start-on-kick": false,
-#              "isr": 1,
-#              "broken": false,
-#              "status": {
-#                  "statuses": [
-#                      "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                      "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                      "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                      "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#                  ]
-#              },
-#              "num-vqs": 2,
-#              "guest-features": {
-#                  "dev-features": [],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                  ]
-#              },
-#              "host-features": {
-#                  "unknown-dev-features": 1073741824,
-#                  "unknown-dev-features2": 0,
-#                  "dev-features": [],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                  ]
-#              },
-#              "use-guest-notifier-mask": true,
-#              "vm-running": true,
-#              "queue-sel": 1,
-#              "disabled": false,
-#              "vhost-started": false,
-#              "use-started": true
-#          }
-#        }
-#
-# .. qmp-example::
-#    :annotated:
-#
-#    Poll for the status of virtio-net (vhost-net is active)
-#    ::
-#
-#     -> { "execute": "x-query-virtio-status",
-#          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
-#        }
-#     <- { "return": {
-#              "device-endian": "little",
-#              "bus-name": "",
-#              "disabled-legacy-check": false,
-#              "name": "virtio-net",
-#              "started": true,
-#              "device-id": 1,
-#              "vhost-dev": {
-#                  "n-tmp-sections": 4,
-#                  "n-mem-sections": 4,
-#                  "max-queues": 1,
-#                  "backend-cap": 2,
-#                  "log-size": 0,
-#                  "backend-features": {
-#                      "dev-features": [],
-#                      "transports": []
-#                  },
-#                  "nvqs": 2,
-#                  "protocol-features": {
-#                      "protocols": []
-#                  },
-#                  "vq-index": 0,
-#                  "log-enabled": false,
-#                  "acked-features": {
-#                      "dev-features": [
-#                          "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                      ],
-#                      "transports": [
-#                          "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                          "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                          "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                      ]
-#                  },
-#                  "features": {
-#                      "dev-features": [
-#                          "VHOST_F_LOG_ALL: Logging write descriptors supported",
-#                          "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
-#                      ],
-#                      "transports": [
-#                          "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                          "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                          "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
-#                          "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                          "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                          "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                      ]
-#                  }
-#              },
-#              "backend-features": {
-#                  "dev-features": [
-#                      "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                      "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                      "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                  ]
-#              },
-#              "start-on-kick": false,
-#              "isr": 1,
-#              "broken": false,
-#              "status": {
-#                  "statuses": [
-#                      "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
-#                      "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
-#                      "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
-#                      "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
-#                  ]
-#              },
-#              "num-vqs": 3,
-#              "guest-features": {
-#                  "dev-features": [
-#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
-#                 ]
-#              },
-#              "host-features": {
-#                  "dev-features": [
-#                      "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
-#                      "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
-#                      "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
-#                      "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
-#                      "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
-#                      "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
-#                      "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
-#                      "VIRTIO_NET_F_CTRL_VQ: Control channel available",
-#                      "VIRTIO_NET_F_STATUS: Configuration status field available",
-#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
-#                      "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
-#                      "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
-#                      "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
-#                      "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
-#                      "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
-#                      "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
-#                      "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
-#                      "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
-#                      "VIRTIO_NET_F_MAC: Device has given MAC address",
-#                      "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
-#                      "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
-#                      "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
-#                  ],
-#                  "transports": [
-#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
-#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
-#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
-#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
-#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
-#                 ]
-#              },
-#              "use-guest-notifier-mask": true,
-#              "vm-running": true,
-#              "queue-sel": 2,
-#              "disabled": false,
-#              "vhost-started": true,
-#              "use-started": true
-#          }
-#        }
 ##
 { 'command': 'x-query-virtio-status',
   'data': { 'path': 'str' },
@@ -588,8 +355,9 @@
 #    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
-#          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
-#                         "queue": 1 }
+#          "arguments": {
+#            "path": "/machine/peripheral/vsock0/virtio-backend",
+#            "queue": 1 }
 #        }
 #     <- { "return": {
 #              "signalled-used": 0,
@@ -615,8 +383,9 @@
 #    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
-#          "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
-#                         "queue": 20 }
+#          "arguments": {
+#            "path": "/machine/peripheral-anon/device[0]/virtio-b...",
+#            "queue": 20 }
 #        }
 #     <- { "return": {
 #              "signalled-used": 0,
@@ -713,8 +482,9 @@
 #    :title: Get vhost_virtqueue status for vhost-crypto
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
-#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
-#                         "queue": 0 }
+#          "arguments": {
+#            "path": "/machine/peripheral/crypto0/virtio-backend",
+#            "queue": 0 }
 #        }
 #     <- { "return": {
 #              "avail-phys": 5216124928,
@@ -737,8 +507,9 @@
 #    :title: Get vhost_virtqueue status for vhost-vsock
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
-#          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
-#                         "queue": 0 }
+#          "arguments": {
+#            "path": "/machine/peripheral/vsock0/virtio-backend",
+#            "queue": 0 }
 #        }
 #     <- { "return": {
 #              "avail-phys": 5182261248,
@@ -860,7 +631,7 @@
 #    :title: Introspect on virtio-net's VirtQueue 0 at index 5
 #
 #     -> { "execute": "x-query-virtio-queue-element",
-#          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
+#          "arguments": { "path": "/machine/peripheral-anon/...",
 #                         "queue": 0,
 #                         "index": 5 }
 #        }
@@ -890,7 +661,7 @@
 #    :title: Introspect on virtio-crypto's VirtQueue 1 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
-#          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
+#          "arguments": { "path": "/machine/peripheral/crypto0/...",
 #                         "queue": 1 }
 #        }
 #     <- { "return": {
@@ -919,7 +690,7 @@
 #    :title: Introspect on virtio-scsi's VirtQueue 2 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
-#          "arguments": { "path": "/machine/peripheral-anon/device[2]/virtio-backend",
+#          "arguments": { "path": "/machine/peripheral-anon/...",
 #                         "queue": 2 }
 #        }
 #     <- { "return": {
-- 
2.48.1


