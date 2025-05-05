Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4B4C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBupi-0004RF-VQ; Mon, 05 May 2025 08:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBupV-0004IH-FY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBupR-00006Q-Sv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746447707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ipDkQxPUOpxMJimrc2O4HzgYKKO2gaox10P8cW0pjuA=;
 b=Dd/GwTJ4cq+pDS7aSKL5umDDJHiyv8jR1h/FWIV3NnPsfrpXz5NicpE1FymhkfiAW1wYoK
 T13JJhoozNfOFq8E4OnDoHUidKJyMJJ35zwFrYtQj6tVDLUb30vQZFiQa23yLA+FuADc9p
 XkzjzxlJB7R401kGR1lgK0kA0avmXU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-PMnI6ttdNt6GkwEK6n-MRw-1; Mon, 05 May 2025 08:21:46 -0400
X-MC-Unique: PMnI6ttdNt6GkwEK6n-MRw-1
X-Mimecast-MFC-AGG-ID: PMnI6ttdNt6GkwEK6n-MRw_1746447705
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so31299275e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746447705; x=1747052505;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipDkQxPUOpxMJimrc2O4HzgYKKO2gaox10P8cW0pjuA=;
 b=D23M95HgyC065FFMavsX1SRJGyrkLTt4d157rD6uY9UnFe1lpWrofNKuBZFoDh43M5
 Nbw+83/G/pwhA0vbKM05sxsIkIFFqJ6gVtCES5f14vTWI/7WsRncwhABwHzxnfsLTRvG
 8sQKuzWQ+223yqGY8LmgJBTeVkDB+rzaUcvhDaX/sLDSpONdSt5+IT+3D52hhpvLAXd5
 fQomT4rkc2B9Kb7FzowBmC7ZZCRyRi7rvLK8gH016X3S4y3v8q2Z5BD/uVu0VdcJ3ld5
 HDxEcMXCGiBOgLI3RCZvad6of1Q826IMfoYW93fOJJN9TnoIJ5TdXXKm6BrrZCzcBd8i
 IgEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYVQRFuB7lxTLCrTq2XbiadDj6pWpANOwDevZIqyn5JCBj4RfSx2Sh+pn14LGp32LFNrk8kXYD8FGx@nongnu.org
X-Gm-Message-State: AOJu0Yx8wk/N3AwcgGPRDfrClWhSyvDY9vOJvMX4vyam2t6b+PdswMG9
 RNT27I8ZrX7w2lP54dn7LN+UItOey9dTExqil869hBd2qXuLPUMNXUSKtJjcX6PQEZWywjwkFz9
 yv0a6hn0I6aS0DL9drzqH8g3307CJPUKcGwMp3hsxXkrRGJnVp2kp
X-Gm-Gg: ASbGncuNkTu6+ts2GODG201kREFGjcUeHkSfEE0XYqmMqUG38sAeSGubZZa3YHcXSMP
 SV5n2rZB5BRJVJ68i7N8j6TG7P/i5aOWRUbq6Aitn40bHvsjDTA40OvsDpv5vhifrPgIDUrd7z0
 vtvvETe0V1jkBDoJ4GV+3eNnpeIm36VEL45dkcUiIOU3Z1CP5qccrP96huJz+MKGk8/WwdUDoAJ
 dqU8H18TNUKWiQm/QvXlpksQsWFFs0Gyk/EYcXNuFtlQE19Hs0KjJlxZ/Q8sJLQXT373ATl66ff
 WHDgXpyWvRVak6q7PpsWNlQxDKfyJhYots0irUIozI1AxYelrQ==
X-Received: by 2002:a05:600c:4ec7:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441c1d73a7emr68935215e9.29.1746447704881; 
 Mon, 05 May 2025 05:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYCIQ3NtZiGJzvaI1Z7DM3KTUwVwqYSLvnL4h25+DNw+7fDw43WqkIhmmyHtA6AsFZXsPrlw==
X-Received: by 2002:a05:600c:4ec7:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-441c1d73a7emr68934795e9.29.1746447704322; 
 Mon, 05 May 2025 05:21:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a3113csm130956085e9.33.2025.05.05.05.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:21:43 -0700 (PDT)
Message-ID: <d56d6565-0839-4f7d-9100-e1bcf03ebc60@redhat.com>
Date: Mon, 5 May 2025 14:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] vfio: add device IO ops vector
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-11-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-11-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 21:39, John Levon wrote:
> For vfio-user, device operations such as IRQ handling and region
> read/writes are implemented in userspace over the control socket, not
> ioctl() to the vfio kernel driver; add an ops vector to generalize this,
> and implement vfio_device_io_ops_ioctl for interacting with the kernel
> vfio driver.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container-base.c      |  6 +--
>   hw/vfio/device.c              | 77 ++++++++++++++++++++++++++++++-----
>   hw/vfio/listener.c            | 13 +++---
>   hw/vfio/pci.c                 | 10 ++---
>   include/hw/vfio/vfio-device.h | 38 +++++++++++++++++
>   5 files changed, 117 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 3ff473a45c..1c6ca94b60 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>       feature->flags = VFIO_DEVICE_FEATURE_GET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        return -errno;
> -    }
> -
> -    return 0;
> +    return vbasedev->io_ops->device_feature(vbasedev, feature);
>   }
>   
>   static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 5d837092cb..468fb50eac 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
>           .count = 0,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
> @@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
> @@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
>           .count = 1,
>       };
>   
> -    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
> +    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
>   }
>   
>   static inline const char *action_to_str(int action)
> @@ -155,6 +155,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       int argsz;
>       const char *name;
>       int32_t *pfd;
> +    int ret;

Why adding a 'ret' variable here ?

The rest looks good.


Thanks,

C.



>       argsz = sizeof(*irq_set) + sizeof(*pfd);
>   
> @@ -167,7 +168,9 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +    ret = vbasedev->io_ops->set_irqs(vbasedev, irq_set);
> +
> +    if (!ret) {
>           return true;
>       }
>   
> @@ -188,22 +191,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                struct vfio_irq_info *info)
>   {
> -    int ret;
> -
>       memset(info, 0, sizeof(*info));
>   
>       info->argsz = sizeof(*info);
>       info->index = index;
>   
> -    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> -
> -    return ret < 0 ? -errno : ret;
> +    return vbasedev->io_ops->get_irq_info(vbasedev, info);
>   }
>   
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info)
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
> +    int ret;
>   
>       *info = g_malloc0(argsz);
>   
> @@ -211,10 +211,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   retry:
>       (*info)->argsz = argsz;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
> +    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
> +    if (ret != 0) {
>           g_free(*info);
>           *info = NULL;
> -        return -errno;
> +        return ret;
>       }
>   
>       if ((*info)->argsz > argsz) {
> @@ -320,11 +321,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>       vbasedev->fd = fd;
>   }
>   
> +static VFIODeviceIOOps vfio_device_io_ops_ioctl;
> +
>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>                         DeviceState *dev, bool ram_discard)
>   {
>       vbasedev->type = type;
>       vbasedev->ops = ops;
> +    vbasedev->io_ops = &vfio_device_io_ops_ioctl;
>       vbasedev->dev = dev;
>       vbasedev->fd = -1;
>   
> @@ -442,3 +446,54 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       QLIST_REMOVE(vbasedev, global_next);
>       vbasedev->bcontainer = NULL;
>   }
> +
> +/*
> + * Traditional ioctl() based io
> + */
> +
> +static int vfio_device_io_device_feature(VFIODevice *vbasedev,
> +                                         struct vfio_device_feature *feature)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
> +                                          struct vfio_region_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
> +                                       struct vfio_irq_info *info)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
> +                                   struct vfio_irq_set *irqs)
> +{
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
> +
> +    return ret < 0 ? -errno : ret;
> +}
> +
> +static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
> +    .device_feature = vfio_device_io_device_feature,
> +    .get_region_info = vfio_device_io_get_region_info,
> +    .get_irq_info = vfio_device_io_get_irq_info,
> +    .set_irqs = vfio_device_io_set_irqs,
> +};
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index e7ade7d62e..2b93ca55b6 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -794,13 +794,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>   
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        int ret;
> +
>           if (!vbasedev->dirty_tracking) {
>               continue;
>           }
>   
> -        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
> +
> +        if (ret != 0) {
>               warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> -                        vbasedev->name, -errno, strerror(errno));
> +                        vbasedev->name, -ret, strerror(-ret));
>           }
>           vbasedev->dirty_tracking = false;
>       }
> @@ -901,10 +905,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>               continue;
>           }
>   
> -        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
>           if (ret) {
> -            ret = -errno;
> -            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
>                                vbasedev->name);
>               goto out;
>           }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8455010d62..bbf95215cc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
>   static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   {
>       g_autofree struct vfio_irq_set *irq_set = NULL;
> -    int ret = 0, argsz;
> +    int argsz;
>       int32_t *fd;
>   
>       argsz = sizeof(*irq_set) + sizeof(*fd);
> @@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>       fd = (int32_t *)&irq_set->data;
>       *fd = -1;
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -
> -    return ret < 0 ? -errno : ret;
> +    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
>   }
>   
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> @@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>           fds[i] = fd;
>       }
>   
> -    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> +    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
>   
>       g_free(irq_set);
>   
> -    return ret < 0 ? -errno : ret;
> +    return ret;
>   }
>   
>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 5b833868c9..e89ed02c0e 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -41,6 +41,7 @@ enum {
>   };
>   
>   typedef struct VFIODeviceOps VFIODeviceOps;
> +typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>   typedef struct VFIOMigration VFIOMigration;
>   
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
> @@ -66,6 +67,7 @@ typedef struct VFIODevice {
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
> +    VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
>       unsigned int flags;
> @@ -141,6 +143,42 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   
>   #ifdef CONFIG_LINUX
> +/*
> + * How devices communicate with the server.  The default option is through
> + * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
> + * process.
> + */
> +struct VFIODeviceIOOps {
> +    /**
> +     * @device_feature
> +     *
> +     * Fill in feature info for the given device.
> +     */
> +    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
> +
> +    /**
> +     * @get_region_info
> +     *
> +     * Fill in @info with information on the region given by @info->index.
> +     */
> +    int (*get_region_info)(VFIODevice *vdev,
> +                           struct vfio_region_info *info);
> +
> +    /**
> +     * @get_irq_info
> +     *
> +     * Fill in @irq with information on the IRQ given by @info->index.
> +     */
> +    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
> +
> +    /**
> +     * @set_irqs
> +     *
> +     * Configure IRQs as defined by @irqs.
> +     */
> +    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
> +};
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,


