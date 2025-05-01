Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A6C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAc5r-0006R9-QD; Thu, 01 May 2025 18:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAc5q-0006QM-Bd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:09:22 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAc5n-00041Z-Ns
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:09:21 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so11815205ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746137358; x=1746742158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWmMiDY8TFl7wwOMJcO6U4oeMej4HU5gLJxrfCzO5k8=;
 b=YWfWdjYIjwxUVIIE7zLnLBVLJTHpXrmqkNc6J7Hbtzuo3mPLic0hZClVBJDEGqatzD
 veeCL3SwaKyNljOUKM3eAn4+rOCm31sKFDf6y6eO+xFFsi42x7VQE6z5eyoaDiLP0KFa
 zDbK6bS18zXgSw8TEXlgS/hPyE826M4fNu5D9qCV1uPMhnGCY36TaqNyxMbPzM5dK6nn
 eZyULG/KYKyWdwRTte+VAElqRJJBZ5KXwuCteHh4mJ6XA4VCRmt5lPKJXIo2bzCjgekn
 l29kzCE3Grnb2bo3pBYjEUwyTJWcwPh0i6SZ1Mn006AyEmkwEtZgJPBzdVn2V5flAef0
 sq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746137358; x=1746742158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bWmMiDY8TFl7wwOMJcO6U4oeMej4HU5gLJxrfCzO5k8=;
 b=j7kIMRzoKdGOJz9eCNA+7PvEBg9uY8gG3ZpdaxIBdcI2iBY0fASR/wlBYTgynEqqsF
 kzvhWkAFwFiwAUJ9DgmqWR3zTUcd1na32u8STkMuK6/3fHPnwg0GMoxcf7iur8ACtbzd
 cqH34qKayiolv9eCKglalBj2BUhdmr32k/PmgGHaRyh3j8QNrR2tJCyBOP7FyJO0gf5O
 4U25fNrqbjm2j9w+2RwM+a+/B9ETxopLI9syxDCssM5jpdRr6OTMnxZ7zynC5/Z69Jw7
 OoLXOTx9BrH/d3Tl9+YEBaXP173HslDGSREKT2jmVAVWVdkuRYcAWZCuwe4iFJAqp1pc
 I2Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpvHD2HOSDr1lNIeI43nL4ojyAHYgVHYT+fVPFlehLkLWuDxvqmoPp/vgfYzSXezQPbcNg69qhNmYE@nongnu.org
X-Gm-Message-State: AOJu0YwtdaBnBVdqQXj45XDhzX6hjzOjVzcvS4f3ogB7CeIqBpAWykPX
 GrEEcq/AHNYPg2MUIsMxhI0pAM2ioBvnt/t8xbZdcC/eKwIaiH07T0Wzd26sfQ4=
X-Gm-Gg: ASbGncucfQ5iY2SUMCRMXH3U2ae60S4WLt0rq4RchIuUQDmtOL1LlTgem0+aASqzrGR
 +Qzm296YRTxeTv+X2fM9PIL5DALZKzirm75NKk6zcLnFAy756eVDWOw+CEAvQ9mJpsxW26s/dka
 tQ4a+5Pyfrps9UCwmRxwh9qCuXkrFMIxkd0QsTdm+npzpbrb2X7MB4dQFHL3PPySlNcP1i2ejsy
 SZUmpRyVaYVeQkplmlqTsf4f8FyzeAjJqGzTMDz+kc1HaEAYKZfxyJHOEtP8tvrFrOrkGWhBGxh
 fi4b4BQCcWm6EGI2fkmfj3E0SG5oGMChVdQy1V4Qe6lpdaM6DUiy52R4nhyTwaHce871Olna5Tf
 kMxZKsWpvV9Zg2/4lJpq7+ORR
X-Google-Smtp-Source: AGHT+IHvtxeVxIIOYwCQgzblUCwYTfvQnNgFezEvBJ2dYMDBavfKyEeUvmb9ksaZfz9W6z79GrPMEA==
X-Received: by 2002:a05:6e02:258f:b0:3d8:20f0:4006 with SMTP id
 e9e14a558f8ab-3d97c1344femr7972375ab.4.1746137358018; 
 Thu, 01 May 2025 15:09:18 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e80457sm3408605ab.29.2025.05.01.15.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 15:09:17 -0700 (PDT)
Message-ID: <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
Date: Fri, 2 May 2025 00:09:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/6] qmp: add QMP command x-query-virtio-status
To: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
Cc: mst@redhat.com, qemu_oss@crudebyte.com, kraxel@redhat.com,
 si-wei.liu@oracle.com, joao.m.martins@oracle.com, eblake@redhat.com,
 qemu-block@nongnu.org, david@redhat.com, arei.gonglei@huawei.com,
 marcandre.lureau@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 michael.roth@amd.com, groug@kaod.org, dgilbert@redhat.com,
 eric.auger@redhat.com, stefanha@redhat.com, boris.ostrovsky@oracle.com,
 kwolf@redhat.com, mathieu.poirier@linaro.org, raphael.norwitz@nutanix.com,
 pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello,

(patch merged as commit 90c066cd682).

On 11/8/22 14:24, Jonah Palmer wrote:
> From: Laurent Vivier <lvivier@redhat.com>
> 
> This new command shows the status of a VirtIODevice, including
> its corresponding vhost device's status (if active).
> 
> Next patch will improve output by decoding feature bits, including
> vhost device's feature bits (backend, protocol, acked, and features).
> Also will decode status bits of a VirtIODevice.
> 
> [Jonah: From patch v12; added a check to @virtio_device_find to ensure
>   synchronicity between @virtio_list and the devices in the QOM
>   composition tree.]
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>   hw/virtio/virtio-stub.c |   5 +
>   hw/virtio/virtio.c      | 104 +++++++++++++++++++
>   qapi/virtio.json        | 222 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 331 insertions(+)
> 
> diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
> index 05a81edc92..0b432e8de7 100644
> --- a/hw/virtio/virtio-stub.c
> +++ b/hw/virtio/virtio-stub.c
> @@ -12,3 +12,8 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>   {
>       return qmp_virtio_unsupported(errp);
>   }
> +
> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
> +{
> +    return qmp_virtio_unsupported(errp);
> +}
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index bdfa82e9c0..3e0a484660 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3939,6 +3939,110 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>       return list;
>   }
>   
> +static VirtIODevice *virtio_device_find(const char *path)
> +{
> +    VirtIODevice *vdev;
> +
> +    QTAILQ_FOREACH(vdev, &virtio_list, next) {
> +        DeviceState *dev = DEVICE(vdev);
> +
> +        if (strcmp(dev->canonical_path, path) != 0) {
> +            continue;
> +        }
> +
> +        Error *err = NULL;
> +        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
> +        if (err == NULL) {
> +            GString *is_realized = qobject_to_json_pretty(obj, true);
> +            /* virtio device is NOT realized, remove it from list */
> +            if (!strncmp(is_realized->str, "false", 4)) {
> +                g_string_free(is_realized, true);
> +                qobject_unref(obj);
> +                QTAILQ_REMOVE(&virtio_list, vdev, next);
> +                return NULL;
> +            }
> +            g_string_free(is_realized, true);
> +        } else {
> +            /* virtio device doesn't exist in QOM tree */
> +            QTAILQ_REMOVE(&virtio_list, vdev, next);
> +            qobject_unref(obj);
> +            return NULL;
> +        }
> +        /* device exists in QOM tree & is realized */
> +        qobject_unref(obj);
> +        return vdev;
> +    }
> +    return NULL;
> +}
> +
> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
> +{
> +    VirtIODevice *vdev;
> +    VirtioStatus *status;
> +
> +    vdev = virtio_device_find(path);
> +    if (vdev == NULL) {
> +        error_setg(errp, "Path %s is not a VirtIODevice", path);
> +        return NULL;
> +    }
> +
> +    status = g_new0(VirtioStatus, 1);
> +    status->name = g_strdup(vdev->name);
> +    status->device_id = vdev->device_id;
> +    status->vhost_started = vdev->vhost_started;
> +    status->guest_features = vdev->guest_features;
> +    status->host_features = vdev->host_features;
> +    status->backend_features = vdev->backend_features;
> +
> +    switch (vdev->device_endian) {
> +    case VIRTIO_DEVICE_ENDIAN_LITTLE:
> +        status->device_endian = g_strdup("little");
> +        break;
> +    case VIRTIO_DEVICE_ENDIAN_BIG:
> +        status->device_endian = g_strdup("big");
> +        break;
> +    default:
> +        status->device_endian = g_strdup("unknown");
> +        break;
> +    }
> +
> +    status->num_vqs = virtio_get_num_queues(vdev);
> +    status->status = vdev->status;
> +    status->isr = vdev->isr;
> +    status->queue_sel = vdev->queue_sel;
> +    status->vm_running = vdev->vm_running;
> +    status->broken = vdev->broken;
> +    status->disabled = vdev->disabled;
> +    status->use_started = vdev->use_started;
> +    status->started = vdev->started;
> +    status->start_on_kick = vdev->start_on_kick;
> +    status->disable_legacy_check = vdev->disable_legacy_check;
> +    status->bus_name = g_strdup(vdev->bus_name);
> +    status->use_guest_notifier_mask = vdev->use_guest_notifier_mask;
> +    status->has_vhost_dev = vdev->vhost_started;
> +
> +    if (vdev->vhost_started) {
> +        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> +        struct vhost_dev *hdev = vdc->get_vhost(vdev);
> +
> +        status->vhost_dev = g_new0(VhostStatus, 1);
> +        status->vhost_dev->n_mem_sections = hdev->n_mem_sections;
> +        status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
> +        status->vhost_dev->nvqs = hdev->nvqs;
> +        status->vhost_dev->vq_index = hdev->vq_index;
> +        status->vhost_dev->features = hdev->features;
> +        status->vhost_dev->acked_features = hdev->acked_features;
> +        status->vhost_dev->backend_features = hdev->backend_features;
> +        status->vhost_dev->protocol_features = hdev->protocol_features;
> +        status->vhost_dev->max_queues = hdev->max_queues;
> +        status->vhost_dev->backend_cap = hdev->backend_cap;
> +        status->vhost_dev->log_enabled = hdev->log_enabled;
> +        status->vhost_dev->log_size = hdev->log_size;
> +    }
> +
> +    return status;
> +}
> +
>   static const TypeInfo virtio_device_info = {
>       .name = TYPE_VIRTIO_DEVICE,
>       .parent = TYPE_DEVICE,
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 03896e423f..c86b3bc635 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -66,3 +66,225 @@
>   { 'command': 'x-query-virtio',
>     'returns': [ 'VirtioInfo' ],
>     'features': [ 'unstable' ] }

When a structure is only used by an unstable command, is it considered
unstable too? IOW is it OK to modify it?

> +
> +##
> +# @VhostStatus:
> +#
> +# Information about a vhost device. This information will only be
> +# displayed if the vhost device is active.
> +#
> +# @n-mem-sections: vhost_dev n_mem_sections
> +#
> +# @n-tmp-sections: vhost_dev n_tmp_sections
> +#
> +# @nvqs: vhost_dev nvqs (number of virtqueues being used)
> +#
> +# @vq-index: vhost_dev vq_index
> +#
> +# @features: vhost_dev features
> +#
> +# @acked-features: vhost_dev acked_features
> +#
> +# @backend-features: vhost_dev backend_features
> +#
> +# @protocol-features: vhost_dev protocol_features
> +#
> +# @max-queues: vhost_dev max_queues
> +#
> +# @backend-cap: vhost_dev backend_cap
> +#
> +# @log-enabled: vhost_dev log_enabled flag
> +#
> +# @log-size: vhost_dev log_size
> +#
> +# Since: 7.1
> +#
> +##
> +
> +{ 'struct': 'VhostStatus',
> +  'data': { 'n-mem-sections': 'int',
> +            'n-tmp-sections': 'int',
> +            'nvqs': 'uint32',
> +            'vq-index': 'int',
> +            'features': 'uint64',
> +            'acked-features': 'uint64',
> +            'backend-features': 'uint64',
> +            'protocol-features': 'uint64',
> +            'max-queues': 'uint64',
> +            'backend-cap': 'uint64',
> +            'log-enabled': 'bool',
> +            'log-size': 'uint64' } }
> +
> +##
> +# @VirtioStatus:
> +#
> +# Full status of the virtio device with most VirtIODevice members.
> +# Also includes the full status of the corresponding vhost device
> +# if the vhost device is active.
> +#
> +# @name: VirtIODevice name
> +#
> +# @device-id: VirtIODevice ID
> +#
> +# @vhost-started: VirtIODevice vhost_started flag
> +#
> +# @guest-features: VirtIODevice guest_features
> +#
> +# @host-features: VirtIODevice host_features
> +#
> +# @backend-features: VirtIODevice backend_features
> +#
> +# @device-endian: VirtIODevice device_endian
> +#
> +# @num-vqs: VirtIODevice virtqueue count. This is the number of active
> +#           virtqueues being used by the VirtIODevice.
> +#
> +# @status: VirtIODevice configuration status (VirtioDeviceStatus)
> +#
> +# @isr: VirtIODevice ISR
> +#
> +# @queue-sel: VirtIODevice queue_sel
> +#
> +# @vm-running: VirtIODevice vm_running flag
> +#
> +# @broken: VirtIODevice broken flag
> +#
> +# @disabled: VirtIODevice disabled flag
> +#
> +# @use-started: VirtIODevice use_started flag
> +#
> +# @started: VirtIODevice started flag
> +#
> +# @start-on-kick: VirtIODevice start_on_kick flag
> +#
> +# @disable-legacy-check: VirtIODevice disabled_legacy_check flag
> +#
> +# @bus-name: VirtIODevice bus_name
> +#
> +# @use-guest-notifier-mask: VirtIODevice use_guest_notifier_mask flag
> +#
> +# @vhost-dev: Corresponding vhost device info for a given VirtIODevice.
> +#             Present if the given VirtIODevice has an active vhost
> +#             device.
> +#
> +# Since: 7.1
> +#
> +##
> +
> +{ 'struct': 'VirtioStatus',
> +  'data': { 'name': 'str',
> +            'device-id': 'uint16',
> +            'vhost-started': 'bool',
> +            'device-endian': 'str',
> +            'guest-features': 'uint64',
> +            'host-features': 'uint64',
> +            'backend-features': 'uint64',
> +            'num-vqs': 'int',
> +            'status': 'uint8',
> +            'isr': 'uint8',
> +            'queue-sel': 'uint16',
> +            'vm-running': 'bool',
> +            'broken': 'bool',
> +            'disabled': 'bool',
> +            'use-started': 'bool',
> +            'started': 'bool',
> +            'start-on-kick': 'bool',
> +            'disable-legacy-check': 'bool',
> +            'bus-name': 'str',
> +            'use-guest-notifier-mask': 'bool',
> +            '*vhost-dev': 'VhostStatus' } }
> +
> +##
> +# @x-query-virtio-status:
> +#
> +# Poll for a comprehensive status of a given virtio device
> +#
> +# @path: Canonical QOM path of the VirtIODevice
> +#
> +# Features:
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: VirtioStatus of the virtio device
> +#
> +# Since: 7.1
> +#
> +# Examples:
> +#
> +# 1. Poll for the status of virtio-crypto (no vhost-crypto active)
> +#
> +# -> { "execute": "x-query-virtio-status",
> +#      "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
> +#    }
> +# <- { "return": {
> +#          "device-endian": "little",
> +#          "bus-name": "",
> +#          "disable-legacy-check": false,
> +#          "name": "virtio-crypto",
> +#          "started": true,
> +#          "device-id": 20,
> +#          "backend-features": 0,
> +#          "start-on-kick": false,
> +#          "isr": 1,
> +#          "broken": false,
> +#          "status": 15,
> +#          "num-vqs": 2,
> +#          "guest-features": 5100273664,
> +#          "host-features": 6325010432,
> +#          "use-guest-notifier-mask": true,
> +#          "vm-running": true,
> +#          "queue-sel": 1,
> +#          "disabled": false,
> +#          "vhost-started": false,
> +#          "use-started": true
> +#      }
> +#    }
> +#
> +# 2. Poll for the status of virtio-net (vhost-net is active)
> +#
> +# -> { "execute": "x-query-virtio-status",
> +#      "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
> +#    }
> +# <- { "return": {
> +#          "device-endian": "little",
> +#          "bus-name": "",
> +#          "disabled-legacy-check": false,
> +#          "name": "virtio-net",
> +#          "started": true,
> +#          "device-id": 1,
> +#          "vhost-dev": {
> +#              "n-tmp-sections": 4,
> +#              "n-mem-sections": 4,
> +#              "max-queues": 1,
> +#              "backend-cap": 2,
> +#              "log-size": 0,
> +#              "backend-features": 0,
> +#              "nvqs": 2,
> +#              "protocol-features": 0,
> +#              "vq-index": 0,
> +#              "log-enabled": false,
> +#              "acked-features": 5100306432,
> +#              "features": 13908344832
> +#          },
> +#          "backend-features": 6337593319,
> +#          "start-on-kick": false,
> +#          "isr": 1,
> +#          "broken": false,
> +#          "status": 15,
> +#          "num-vqs": 3,
> +#          "guest-features": 5111807911,
> +#          "host-features": 6337593319,
> +#          "use-guest-notifier-mask": true,
> +#          "vm-running": true,
> +#          "queue-sel": 2,
> +#          "disabled": false,
> +#          "vhost-started": true,
> +#          "use-started": true
> +#      }
> +#    }
> +#
> +##
> +
> +{ 'command': 'x-query-virtio-status',
> +  'data': { 'path': 'str' },
> +  'returns': 'VirtioStatus',
> +  'features': [ 'unstable' ] }


