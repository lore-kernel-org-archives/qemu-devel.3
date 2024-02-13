Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB3C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZq07-0008Kg-KN; Tue, 13 Feb 2024 05:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZq06-0008KT-8O
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZq03-0008PW-TB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JEanw8ro9UdbVW7cUPSFsxtIdTQDXYZyaK0X5KsCsfg=;
 b=V7f4iXVDPpmTsjivqqUqZpR4MgY7jk0JVQjy7aMH+UXN9FJ0ErnMjn2PEnFsCcBbTVrS8z
 bEuPBjuzI5+ovZ/tVUgDQ/ukMI+e3Lul7qyMLDjKLKEfIS3wVL96fwbTNF0wcDmTXPu9rW
 90C89gmsOrx3LG9YA7jtgryrlhKbhH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-yvpX8msMMMu9GWl8rEBl7A-1; Tue, 13 Feb 2024 05:26:49 -0500
X-MC-Unique: yvpX8msMMMu9GWl8rEBl7A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3d130eb757so14547866b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820008; x=1708424808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEanw8ro9UdbVW7cUPSFsxtIdTQDXYZyaK0X5KsCsfg=;
 b=Pl6o5+oak5pKlJIJa4lmSKdqbzbV0LIM7H6ou/EipniYy9pqYKTvihljETG8U7/SKV
 E0VYNIZrqpMAowkf128b18+xhRZGuI094L5CEjlms1hX8WwVaIIDvWoR4DZzQH1q1rlh
 2xuKsE+4iBiBkR/hp1ZcVA7ixTQYBVmweOIU9sPMJtrx0EtJKMUdDD37oPymaMZdshHN
 3b1N/TK+KKMVT+5UFEN/eGZ8I0E6YF/bo/K7h4jbMnkO9lzSZpmVJ/MqDeYkXB4fNQ8Q
 Sc2GIKO/edtHmPQynfdLN8LzDyk/TxNjQjka2et+jPeJ55vApooOs9nH36JEMDKf57OI
 AH5w==
X-Gm-Message-State: AOJu0Yz9NWkNZP345fqZcoAYPeI2+rbarhPicTomR9msHlT9Vl34LK0C
 QE2l5cuHONC9FO/iCQavNNKy87DtoSEcPsgylpbHZOM1PlEAViEfxbS6mC26Ei2Hsu+GWWCHB79
 oec2W288/6MUIx6YCAgqUWeT08tKYssyGJ8LLtcF1jUr3OEnXiKqz
X-Received: by 2002:a17:906:4104:b0:a3c:f4d6:657e with SMTP id
 j4-20020a170906410400b00a3cf4d6657emr1543550ejk.69.1707820008298; 
 Tue, 13 Feb 2024 02:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIi2NRpuXNFVFRpJJ3KWmj5cJyShzNP6br4GIn+/jgTx2awm2YGm2mIX/ud4c2w07sqUnsOQ==
X-Received: by 2002:a17:906:4104:b0:a3c:f4d6:657e with SMTP id
 j4-20020a170906410400b00a3cf4d6657emr1543533ejk.69.1707820007840; 
 Tue, 13 Feb 2024 02:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ7gwlMl/J2EynGklacTOHqLT002wHpJK1v1cQiMSlYpI3QItd/b9pKxu+UXc5YbiX8NM/6SZ4UOixkrSVxVnhaQXeDIlW6cir5sswMp3Z5uwg1/Q=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 n12-20020a170906378c00b00a3916c1f708sm1155939ejc.173.2024.02.13.02.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:26:47 -0800 (PST)
Date: Tue, 13 Feb 2024 05:26:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to numeric
 encoding
Message-ID: <20240213052542-mutt-send-email-mst@kernel.org>
References: <cover.1706883915.git.yong.huang@smartx.com>
 <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 10:32:15PM +0800, Hyman Huang wrote:
> x-query-virtio-status returns several sets of virtio feature and
> status flags.  It goes back to v7.2.0.
> 
> In the initial commit 90c066cd682 (qmp: add QMP command
> x-query-virtio-status), we returned them as numbers, using virtio's
> well-known binary encoding.
> 
> The next commit f3034ad71fc (qmp: decode feature & status bits in
> virtio-status) replaced the numbers by objects.  The objects represent
> bits QEMU knows symbolically, and any unknown bits numerically just like
> before.
> 
> Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command
> "info virtio" (and a few more, which aren't relevant here).
> 
> The symbolic representation uses lists of strings.  The string format is
> undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
> explanation".
> 
> This symbolic representation is nice for humans.  Machines it can save
> the trouble of decoding virtio's well-known binary encoding.
> 
> However, we sometimes want to compare features and status bits without
> caring for their exact meaning.  Say we want to verify the correctness
> of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
> QMP command x-query-virtio-status to retrieve vhost-user net device
> features, and the "ovs-vsctl list interface" command to retrieve
> interface features.  Without commit f3034ad71fc, we could then simply
> compare the numbers.  With this commit, we first have to map from the
> strings back to the numeric encoding.
> 
> Revert the decoding for QMP, but keep it for HMP.

Is there a way to maybe have both decoded and numerical one?
E.g. I mostly use QMP even when I read it myself.

> This makes the QMP command easier to use for use cases where we
> don't need to decode, like the comparison above.  For use cases
> where we need to decode, we replace parsing undocumented strings by
> decoding virtio's well-known binary encoding.
> 
> Incompatible change; acceptable because x-query-virtio-status does
> comes without a stability promise.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/virtio/virtio-hmp-cmds.c |  25 +++--
>  hw/virtio/virtio-qmp.c      |  23 ++---
>  qapi/virtio.json            | 192 ++++--------------------------------
>  3 files changed, 45 insertions(+), 195 deletions(-)
> 
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 477c97dea2..721c630ab0 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "virtio-qmp.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
>  #include "qapi/qapi-commands-virtio.h"
> @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "  endianness:              %s\n",
>                     s->device_endian);
>      monitor_printf(mon, "  status:\n");
> -    hmp_virtio_dump_status(mon, s->status);
> +    hmp_virtio_dump_status(mon,
> +        qmp_decode_status(s->status));
>      monitor_printf(mon, "  Guest features:\n");
> -    hmp_virtio_dump_features(mon, s->guest_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->guest_features));
>      monitor_printf(mon, "  Host features:\n");
> -    hmp_virtio_dump_features(mon, s->host_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->host_features));
>      monitor_printf(mon, "  Backend features:\n");
> -    hmp_virtio_dump_features(mon, s->backend_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->backend_features));
>  
>      if (s->vhost_dev) {
>          monitor_printf(mon, "  VHost:\n");
> @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "    log_size:       %"PRId64"\n",
>                         s->vhost_dev->log_size);
>          monitor_printf(mon, "    Features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->features));
>          monitor_printf(mon, "    Acked features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
>          monitor_printf(mon, "    Backend features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
>          monitor_printf(mon, "    Protocol features:\n");
> -        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
> +        hmp_virtio_dump_protocols(mon,
> +            qmp_decode_protocols(s->vhost_dev->protocol_features));
>      }
>  
>      qapi_free_VirtioStatus(s);
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 1dd96ed20f..1660c17653 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -733,12 +733,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      status->name = g_strdup(vdev->name);
>      status->device_id = vdev->device_id;
>      status->vhost_started = vdev->vhost_started;
> -    status->guest_features = qmp_decode_features(vdev->device_id,
> -                                                 vdev->guest_features);
> -    status->host_features = qmp_decode_features(vdev->device_id,
> -                                                vdev->host_features);
> -    status->backend_features = qmp_decode_features(vdev->device_id,
> -                                                   vdev->backend_features);
> +    status->guest_features = vdev->guest_features;
> +    status->host_features = vdev->host_features;
> +    status->backend_features = vdev->backend_features;
>  
>      switch (vdev->device_endian) {
>      case VIRTIO_DEVICE_ENDIAN_LITTLE:
> @@ -753,7 +750,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      }
>  
>      status->num_vqs = virtio_get_num_queues(vdev);
> -    status->status = qmp_decode_status(vdev->status);
> +    status->status = vdev->status;
>      status->isr = vdev->isr;
>      status->queue_sel = vdev->queue_sel;
>      status->vm_running = vdev->vm_running;
> @@ -775,14 +772,10 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>          status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>          status->vhost_dev->nvqs = hdev->nvqs;
>          status->vhost_dev->vq_index = hdev->vq_index;
> -        status->vhost_dev->features =
> -            qmp_decode_features(vdev->device_id, hdev->features);
> -        status->vhost_dev->acked_features =
> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
> -        status->vhost_dev->backend_features =
> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
> -        status->vhost_dev->protocol_features =
> -            qmp_decode_protocols(hdev->protocol_features);
> +        status->vhost_dev->features = hdev->features;
> +        status->vhost_dev->acked_features = hdev->acked_features;
> +        status->vhost_dev->backend_features = hdev->backend_features;
> +        status->vhost_dev->protocol_features = hdev->protocol_features;
>          status->vhost_dev->max_queues = hdev->max_queues;
>          status->vhost_dev->backend_cap = hdev->backend_cap;
>          status->vhost_dev->log_enabled = hdev->log_enabled;
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 19c7c36e36..26516fb29c 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -102,10 +102,10 @@
>              'n-tmp-sections': 'int',
>              'nvqs': 'uint32',
>              'vq-index': 'int',
> -            'features': 'VirtioDeviceFeatures',
> -            'acked-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
> -            'protocol-features': 'VhostDeviceProtocols',
> +            'features': 'uint64',
> +            'acked-features': 'uint64',
> +            'backend-features': 'uint64',
> +            'protocol-features': 'uint64',
>              'max-queues': 'uint64',
>              'backend-cap': 'uint64',
>              'log-enabled': 'bool',
> @@ -170,11 +170,11 @@
>              'device-id': 'uint16',
>              'vhost-started': 'bool',
>              'device-endian': 'str',
> -            'guest-features': 'VirtioDeviceFeatures',
> -            'host-features': 'VirtioDeviceFeatures',
> -            'backend-features': 'VirtioDeviceFeatures',
> +            'guest-features': 'uint64',
> +            'host-features': 'uint64',
> +            'backend-features': 'uint64',
>              'num-vqs': 'int',
> -            'status': 'VirtioDeviceStatus',
> +            'status': 'uint8',
>              'isr': 'uint8',
>              'queue-sel': 'uint16',
>              'vm-running': 'bool',
> @@ -217,41 +217,14 @@
>  #          "name": "virtio-crypto",
>  #          "started": true,
>  #          "device-id": 20,
> -#          "backend-features": {
> -#              "transports": [],
> -#              "dev-features": []
> -#          },
> +#          "backend-features": 0,
>  #          "start-on-kick": false,
>  #          "isr": 1,
>  #          "broken": false,
> -#          "status": {
> -#              "statuses": [
> -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
> -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
> -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
> -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> -#              ]
> -#          },
> +#          "status": 15,
>  #          "num-vqs": 2,
> -#          "guest-features": {
> -#              "dev-features": [],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#              ]
> -#          },
> -#          "host-features": {
> -#              "unknown-dev-features": 1073741824,
> -#              "dev-features": [],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#              ]
> -#          },
> +#          "guest-features": 5100273664,
> +#          "host-features": 6325010432,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 1,
> @@ -279,147 +252,22 @@
>  #              "max-queues": 1,
>  #              "backend-cap": 2,
>  #              "log-size": 0,
> -#              "backend-features": {
> -#                  "dev-features": [],
> -#                  "transports": []
> -#              },
> +#              "backend-features": 0,
>  #              "nvqs": 2,
> -#              "protocol-features": {
> -#                  "protocols": []
> -#              },
> +#              "protocol-features": 0,
>  #              "vq-index": 0,
>  #              "log-enabled": false,
> -#              "acked-features": {
> -#                  "dev-features": [
> -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
> -#                  ],
> -#                  "transports": [
> -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#                  ]
> -#              },
> -#              "features": {
> -#                  "dev-features": [
> -#                      "VHOST_F_LOG_ALL: Logging write descriptors supported",
> -#                      "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"
> -#                  ],
> -#                  "transports": [
> -#                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                      "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                      "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform",
> -#                      "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                      "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                      "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#                  ]
> -#              }
> -#          },
> -#          "backend-features": {
> -#              "dev-features": [
> -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
> -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#              ]
> +#              "acked-features": 5100306432,
> +#              "features": 13908344832,
>  #          },
> +#          "backend-features": 6337593319,
>  #          "start-on-kick": false,
>  #          "isr": 1,
>  #          "broken": false,
> -#          "status": {
> -#              "statuses": [
> -#                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
> -#                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
> -#                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
> -#                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
> -#              ]
> -#          },
> +#          "status": 15,
>  #          "num-vqs": 3,
> -#          "guest-features": {
> -#              "dev-features": [
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"
> -#             ]
> -#          },
> -#          "host-features": {
> -#              "dev-features": [
> -#                  "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features negotiation supported",
> -#                  "VIRTIO_NET_F_GSO: Handling GSO-type packets supported",
> -#                  "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control channel",
> -#                  "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets supported",
> -#                  "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported",
> -#                  "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported",
> -#                  "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported",
> -#                  "VIRTIO_NET_F_CTRL_VQ: Control channel available",
> -#                  "VIRTIO_NET_F_STATUS: Configuration status field available",
> -#                  "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers",
> -#                  "VIRTIO_NET_F_HOST_UFO: Device can receive UFO",
> -#                  "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6",
> -#                  "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4",
> -#                  "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO",
> -#                  "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN",
> -#                  "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6",
> -#                  "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4",
> -#                  "VIRTIO_NET_F_MAC: Device has given MAC address",
> -#                  "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading reconfig. supported",
> -#                  "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial checksum supported",
> -#                  "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum supported"
> -#              ],
> -#              "transports": [
> -#                  "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> -#                  "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported",
> -#                  "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)",
> -#                  "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts",
> -#                  "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. descs. on VQ"
> -#             ]
> -#          },
> +#          "guest-features": 5111807911,
> +#          "host-features": 6337593319,
>  #          "use-guest-notifier-mask": true,
>  #          "vm-running": true,
>  #          "queue-sel": 2,
> -- 
> 2.31.1


