Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9821C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlVr-0004b6-OP; Mon, 21 Jul 2025 04:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlVV-0004LV-Qw
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlVS-0005U2-Kb
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753085057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/uOJt9PoGyZw9NpNNuaVKeGYdVzrEJ/owlzZHZgPL0=;
 b=jWVmDCitcaWRAFf+U+1gqbVPTDciFCRKoGwjVhQEFKhg4uoyU2dfxBodMuh2F9ZnUl830i
 SFQVi+uybCsHNIQUX74RVkX+22/FIaArb9y21AiWL7D0kcuE2QjBQagTFSBhoAI8/LD651
 xFmxgRm+O7o5EJW69Y0e730PCtLDZSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-kR4yVDhZNhSU69k_jyYwUQ-1; Mon, 21 Jul 2025 04:04:13 -0400
X-MC-Unique: kR4yVDhZNhSU69k_jyYwUQ-1
X-Mimecast-MFC-AGG-ID: kR4yVDhZNhSU69k_jyYwUQ_1753085052
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so20898345e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753085052; x=1753689852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/uOJt9PoGyZw9NpNNuaVKeGYdVzrEJ/owlzZHZgPL0=;
 b=aQNTYlxSRxLGCOyf9dj0pUUWZ7EfpAWGvxqMJ59cJ9cAjtAj3XovUmP0/BY0fiHBUF
 I7cfmD7mMAg42Gs6qnRkFUsox0rIOdxUWKMeBYnQysspUGtJ3zA1p501idWGNT8tiZlm
 RnhjFuTNdWkbDbsDblK93pqoPa/tYrcn/XtNUOiodikX1t/UWtL/4nIEwG1kCSlKKKZe
 4hd6YNuXtFQtW1Z7iJQI4k3QVGHag+yGz7zy3j66V4v3VXAXlRb1cwtumySxN3JH4uz3
 SX3ytoFXrL95x7LSxN3Q9RJ08nCiBskH1zB/xa09iSTgMdK06pzobKSoBGGhcIr/4YxJ
 3QXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxU/f/KPk0pFyUcl1v4QdxZeLDU2kmzGrGjzt7q/oSFLHMKWxyeGLdkuadm4oIWtx927QlV+q8jVcd@nongnu.org
X-Gm-Message-State: AOJu0YxU8w3OEnK8RgWmX/sZ35kETCl8+bbUD+95+xaJLkGZmQw11paR
 sy5OUnk50AKxDDXmk1gW1NgJi7BkG7ycR5I9Py12MRnKf62PzeCAagS6gTLzh7Jeld0EkjZC8kn
 zJsL0emmrnnZTZ5d8OYEnGHaTcN1hn46ON3PGK8s8CY38ZTt8X6uv4R9Q
X-Gm-Gg: ASbGnctN4dAknFtYjcpsM9FxsHIVWd3nEXnOn6d4fP9LwLCSyn8fwFBHzRYMfX3p899
 LCXjIREJKNkzlr9mwAtIA/BRrRUZ8fxdGXpPljh1qRPjZhWrcnpmOXk8w2TEULMD9cIco8K0Y+a
 ruoXY1V5TZEKb76v9JYKbjuFt6tjRFmMa7cbFoegpJco9ntxjZv/wEHT8+7XDuLTlO2pQOGfn/t
 wMnHZFbJLlgxjR9HVI1bDvc/6q2aFfzgSrF0EepBiTzdgKt6v5S1NHplpeLBWbXFCjQzKJGyUAN
 BgMXLp1HWWlJkSDyyV7rmQsi2IIdqfXgpAumNH2xiM7+rZerN8c5xrMQW2nnhhW/5xG6N4W4MEA
 o3V6vFvnRS2E=
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45636ba6679mr171676375e9.10.1753085052118; 
 Mon, 21 Jul 2025 01:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqdrwd7NvAeKHaVLGzEEm+HPRQJlkHCfwU0x7YxG7YH4N19YeOWSeuB7+z7N8/FE0G+tlITw==
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45636ba6679mr171675835e9.10.1753085051525; 
 Mon, 21 Jul 2025 01:04:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5b78d0sm94861425e9.8.2025.07.21.01.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:04:11 -0700 (PDT)
Message-ID: <c9a7889b-190f-4bff-bb62-4396ee4d0e56@redhat.com>
Date: Mon, 21 Jul 2025 10:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 <e17fdd28-b8a7-42cf-a4c0-bc04ffeb3eea@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e17fdd28-b8a7-42cf-a4c0-bc04ffeb3eea@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/21/25 9:23 AM, Akihiko Odaki wrote:
> On 2025/07/18 17:52, Paolo Abeni wrote:
>> Extend the VirtioDeviceFeatures struct with an additional u64
>> to track unknown features in the 64-127 bit range and decode
>> the full virtio features spaces for vhost and virtio devices.
>>
>> Also add entries for the soon-to-be-supported virtio net GSO over
>> UDP features.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>    - unknown-dev-features-dword2 -> unknown-dev-features2
>>    - _array -> _ex
>>    - fixed typos in entries description
>>
>> v1 -> v2:
>>    - uint128_t -> uint64_t[]
>> ---
>>   hw/virtio/virtio-hmp-cmds.c |  3 +-
>>   hw/virtio/virtio-qmp.c      | 89 ++++++++++++++++++++++++++-----------
>>   hw/virtio/virtio-qmp.h      |  3 +-
>>   qapi/virtio.json            |  8 +++-
>>   4 files changed, 73 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
>> index 7d8677bcf0..1daae482d3 100644
>> --- a/hw/virtio/virtio-hmp-cmds.c
>> +++ b/hw/virtio/virtio-hmp-cmds.c
>> @@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
>>       }
>>   
>>       if (features->has_unknown_dev_features) {
>> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
>> +        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
>> +                       features->unknown_dev_features2,
>>                          features->unknown_dev_features);
>>       }
>>   }
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index 3b6377cf0d..03c6163cf4 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>       FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>>               "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>>               "negotiation supported"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>> +            "UDP tunnel packets"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>> +            "UDP tunnel packets requiring checksum offload for the outer "
>> +            "header"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>> +            "UDP tunnel packets"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>> +            "UDP tunnel packets requiring checksum offload for the outer "
>> +            "header"),
>>       { -1, "" }
>>   };
>>   #endif
>> @@ -510,6 +524,24 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
>>           list;                                            \
>>       })
>>   
>> +#define CONVERT_FEATURES_EX(type, map, bitmap)           \
>> +    ({                                                   \
>> +        type *list = NULL;                               \
>> +        type *node;                                      \
>> +        for (i = 0; map[i].virtio_bit != -1; i++) {      \
>> +            bit = map[i].virtio_bit;                     \
>> +            if (!virtio_has_feature_ex(bitmap, bit)) {   \
>> +                continue;                                \
>> +            }                                            \
>> +            node = g_new0(type, 1);                      \
>> +            node->value = g_strdup(map[i].feature_desc); \
>> +            node->next = list;                           \
>> +            list = node;                                 \
>> +            virtio_clear_feature_ex(bitmap, bit);        \
>> +        }                                                \
>> +        list;                                            \
>> +    })
>> +
>>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
>>   {
>>       VirtioDeviceStatus *status;
>> @@ -545,109 +577,112 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
>>       return vhu_protocols;
>>   }
>>   
>> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
>> +                                          const uint64_t *bmap)
>>   {
>> +    uint64_t bitmap[VIRTIO_FEATURES_DWORDS];
>>       VirtioDeviceFeatures *features;
>>       uint64_t bit;
>>       int i;
>>   
>> +    virtio_features_copy(bitmap, bmap);
>>       features = g_new0(VirtioDeviceFeatures, 1);
>>       features->has_dev_features = true;
>>   
>>       /* transport features */
>> -    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
>> -                                            bitmap);
>> +    features->transports = CONVERT_FEATURES_EX(strList, virtio_transport_map,
>> +                                               bitmap);
>>   
>>       /* device features */
>>       switch (device_id) {
>>   #ifdef CONFIG_VIRTIO_SERIAL
>>       case VIRTIO_ID_CONSOLE:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_BLK
>>       case VIRTIO_ID_BLOCK:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_GPU
>>       case VIRTIO_ID_GPU:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_NET
>>       case VIRTIO_ID_NET:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_SCSI
>>       case VIRTIO_ID_SCSI:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_BALLOON
>>       case VIRTIO_ID_BALLOON:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_IOMMU
>>       case VIRTIO_ID_IOMMU:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_INPUT
>>       case VIRTIO_ID_INPUT:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VHOST_USER_FS
>>       case VIRTIO_ID_FS:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VHOST_VSOCK
>>       case VIRTIO_ID_VSOCK:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_CRYPTO
>>       case VIRTIO_ID_CRYPTO:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_MEM
>>       case VIRTIO_ID_MEM:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_I2C_ADAPTER
>>       case VIRTIO_ID_I2C_ADAPTER:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VIRTIO_RNG
>>       case VIRTIO_ID_RNG:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
>>           break;
>>   #endif
>>   #ifdef CONFIG_VHOST_USER_GPIO
>>       case VIRTIO_ID_GPIO:
>>           features->dev_features =
>> -            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
>> +            CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
>>           break;
>>   #endif
>>       /* No features */
>> @@ -680,9 +715,10 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>           g_assert_not_reached();
>>       }
>>   
>> -    features->has_unknown_dev_features = bitmap != 0;
>> +    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
>>       if (features->has_unknown_dev_features) {
>> -        features->unknown_dev_features = bitmap;
>> +        features->unknown_dev_features = bitmap[0];
>> +        features->unknown_dev_features2 = bitmap[1];
>>       }
>>   
>>       return features;
>> @@ -743,11 +779,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>       status->device_id = vdev->device_id;
>>       status->vhost_started = vdev->vhost_started;
>>       status->guest_features = qmp_decode_features(vdev->device_id,
>> -                                                 vdev->guest_features);
>> +                                                 vdev->guest_features_ex);
>>       status->host_features = qmp_decode_features(vdev->device_id,
>> -                                                vdev->host_features);
>> +                                                vdev->host_features_ex);
>>       status->backend_features = qmp_decode_features(vdev->device_id,
>> -                                                   vdev->backend_features);
>> +                                                 vdev->backend_features_ex);
>>   
>>       switch (vdev->device_endian) {
>>       case VIRTIO_DEVICE_ENDIAN_LITTLE:
>> @@ -785,11 +821,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>           status->vhost_dev->nvqs = hdev->nvqs;
>>           status->vhost_dev->vq_index = hdev->vq_index;
>>           status->vhost_dev->features =
>> -            qmp_decode_features(vdev->device_id, hdev->features);
>> +            qmp_decode_features(vdev->device_id, hdev->features_ex);
>>           status->vhost_dev->acked_features =
>> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
>> +            qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
>>           status->vhost_dev->backend_features =
>> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
>> +            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
>> +
>>           status->vhost_dev->protocol_features =
>>               qmp_decode_protocols(hdev->protocol_features);
>>           status->vhost_dev->max_queues = hdev->max_queues;
>> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>> index 245a446a56..e0a1e49035 100644
>> --- a/hw/virtio/virtio-qmp.h
>> +++ b/hw/virtio/virtio-qmp.h
>> @@ -18,6 +18,7 @@
>>   VirtIODevice *qmp_find_virtio_device(const char *path);
>>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>   VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
>> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
>> +                                          const uint64_t *bitmap);
>>   
>>   #endif
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 9d652fe4a8..f2e2dd6e97 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -490,14 +490,18 @@
>>   #     unique features)
>>   #
>>   # @unknown-dev-features: Virtio device features bitmap that have not
>> -#     been decoded
>> +#     been decoded (bits 0-63)
>> +#
>> +# @unknown-dev-features2: Virtio device features bitmap that have not
>> +#     been decoded (bits 64-127)
> 
> This documentation should contain "(since 10.1)" as described in:
> docs/devel/qapi-code-gen.rst

Just to be pedant, since there is a little ambiguity between the
examples in docs/devel/qapi-code-gen.rst and the actual code e.g. in
qapi/qom.json, I'll use:

# @unknown-dev-features2: Virtio device features bitmap that have not
#     been decoded (bits 64-127) (since 10.2)

/P


