Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B84C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLlra-0004PN-Ba; Sun, 01 Jun 2025 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLlrH-0004Ob-Kc
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLlrF-0003Tx-Ih
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748796503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SXVQ09rwW8rM+Ou2johkXbmIzDvnqBT+4yZTeusayKU=;
 b=YYwX8Cm4pV91qeSvoL3KrplWkXoKDbuBPs1Frfr35PSj4/Mq5ILAOnMjEWf87/FVCTELuK
 2RxC19oVI0dR2AkK+Yb0v+3LhYxn2n4x7uGK4Uxb5agkYELMnqUaYACq2izGm3Q/P/sqfm
 hPh3+wSrhiW/cm4x+J9txdERZ1lIx9c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-el5aEb70NuWzAaCiub2j2g-1; Sun, 01 Jun 2025 12:48:22 -0400
X-MC-Unique: el5aEb70NuWzAaCiub2j2g-1
X-Mimecast-MFC-AGG-ID: el5aEb70NuWzAaCiub2j2g_1748796501
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442dc702850so24477555e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 09:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748796501; x=1749401301;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXVQ09rwW8rM+Ou2johkXbmIzDvnqBT+4yZTeusayKU=;
 b=LIxyQ2o2jDfDJBlTJM4AHc3Ekz5ymywsq+rcEt8RquEWJcyPXklLgTWlDIep1wjKW2
 p0RDS2v+ATydtnL4fdrkBAG6k9hbQSomzqpBY+sD6orFzAE0CSRJis/qCpQjW8NdQ3NT
 ooO3AcSmpXbsgkejU4qxw95JWm0bEGlPeoKOk67xl/fF7BsHRayh2vy5DK27ezz31LJf
 ZtZyS/MrZeKqsa6GXJWCUkMrhy7hQ5M67DGMv4lFEq6lrA4BmiidygtBdxsbedX8mh00
 5eCnAHtyYirFI9ObWxSBmROWltb/SHwAG6rlhRSamkC/E5PehNM3x97JYuyTP7qygk2k
 9Mig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqdzi1T0hyv/XnmovPWmuCGPNp6GD7Uqq/1+wpUPAfZkmzqsftkujg4+QfYjaGqMU/IJNDE8xFPbe7@nongnu.org
X-Gm-Message-State: AOJu0Yz2pxl+b59wDQj1mFS7wTAqm0PK1WnPzxiM0ArzSNs6XGGSkXf/
 /Y4hJlfuJdyaEyJha3vAuGeRv/WQ2842HwycKNVC3Air/ovyAlZ4GCFdLgElnhBUB7Wb7SlvPdv
 i3RbyFIr2d8YvHyYeZJbRQx/DQcqY95vWBa6vqc+FXaM7nC1j6UoJyF9W
X-Gm-Gg: ASbGnctayrw7gHAVGJ22+zgTtV/Jm9Ogu8rCMCrsThd7q1Qgunv0VUd0vx4vxw7HRQq
 qgt9bSLJedoWa5x87Kt0h/+xP4IiWhjq63LEeob0sQ7Y96hjiHdxumXSZhRwP9maq9vbLZ3JJal
 FUyLa/xVAwM4OvAiWgmGuM2ElLuxl+Jz0+Lh9eyaxdSWR2kWZ5tXO/GBfqCX1AcuE9O63uvV+0E
 sUdgTB8i7jVxmXkCZX9MaxIjZSxC6grszn+CziKTTUaypIm47Bywo1yd72/lU2hZI9GwNDwkJ59
 dekYulyagZNNsBQ72IWtsAd3pJBNKD0CX3abprsfgMQRiuOaXw==
X-Received: by 2002:a05:600c:3e0a:b0:450:c9e3:995c with SMTP id
 5b1f17b1804b1-4511ecc28admr49120965e9.12.1748796501131; 
 Sun, 01 Jun 2025 09:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOMr9i2zKgE3mzdNErYcQZDGaUEkZOjylj3QKEtcP7YzAGeaJl0NNRJt3yE9Im6N8okYK76A==
X-Received: by 2002:a05:600c:3e0a:b0:450:c9e3:995c with SMTP id
 5b1f17b1804b1-4511ecc28admr49120745e9.12.1748796500662; 
 Sun, 01 Jun 2025 09:48:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe74111sm12233616f8f.56.2025.06.01.09.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 09:48:20 -0700 (PDT)
Message-ID: <259a8bb5-e2ce-43e6-82a6-9b14c5f1d4bf@redhat.com>
Date: Sun, 1 Jun 2025 18:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 12/43] vfio/container: restore DMA vaddr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-13-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-13-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/29/25 21:24, Steve Sistare wrote:
> In new QEMU, do not register the memory listener at device creation time.
> Register it later, in the container post_load handler, after all vmstate
> that may affect regions and mapping boundaries has been loaded.  The
> post_load registration will cause the listener to invoke its callback on
> each flat section, and the calls will match the mappings remembered by the
> kernel.
> 
> The listener calls a special dma_map handler that passes the new VA of each
> section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
> handler at the end.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-cpr.h |  3 +++
>   hw/vfio/container.c        | 15 ++++++++++--
>   hw/vfio/cpr-legacy.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 5a2e5f6..0462447 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -17,6 +17,9 @@ struct VFIOGroup;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> +    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
> +                         hwaddr iova, ram_addr_t size,
> +                         void *vaddr, bool readonly, MemoryRegion *mr);
>   } VFIOContainerCPR;
>   
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 798abda..f91f2d5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> +    g_assert(!cpr_is_incoming());
> +
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>       }
>       group_was_added = true;
>   
> -    if (!vfio_listener_register(bcontainer, errp)) {
> -        goto fail;
> +    /*
> +     * If CPR, register the listener later, after all state that may
> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
> +     * the listener will invoke its callback on each flat section and call
> +     * dma_map to supply the new vaddr, and the calls will match the mappings
> +     * remembered by the kernel.
> +     */
> +    if (!cpr_is_incoming()) {
> +        if (!vfio_listener_register(bcontainer, errp)) {
> +            goto fail;
> +        }
>       }
>   
>       bcontainer->initialized = true;
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index cf80332..512ef41 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -10,11 +10,13 @@
>   #include "hw/vfio/vfio-container.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "hw/vfio/vfio-device.h"
> +#include "hw/vfio/vfio-listener.h"
>   #include "migration/blocker.h"
>   #include "migration/cpr.h"
>   #include "migration/migration.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   
>   static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>   {
> @@ -31,6 +33,32 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>       return true;
>   }
>   
> +/*
> + * Set the new @vaddr for any mappings registered during cpr load.
> + * The incoming state is cleared thereafter.
> + */
> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
> +                                   bool readonly, MemoryRegion *mr)
> +{
> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> +                                                  bcontainer);
> +    struct vfio_iommu_type1_dma_map map = {
> +        .argsz = sizeof(map),
> +        .flags = VFIO_DMA_MAP_FLAG_VADDR,
> +        .vaddr = (__u64)(uintptr_t)vaddr,
> +        .iova = iova,
> +        .size = size,
> +    };
> +
> +    g_assert(cpr_is_incoming());
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
> +        return -errno;
> +    }
> +
> +    return 0;
> +}
>   
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
> @@ -59,11 +87,34 @@ static int vfio_container_pre_save(void *opaque)
>       return 0;
>   }
>   
> +static int vfio_container_post_load(void *opaque, int version_id)
> +{
> +    VFIOContainer *container = opaque;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOGroup *group;
> +    Error *local_err = NULL;
> +
> +    if (!vfio_listener_register(bcontainer, &local_err)) {
> +        error_report_err(local_err);
> +        return -1;
> +    }
> +
> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +
> +        /* Restore original dma_map function */
> +        vioc->dma_map = container->cpr.saved_dma_map;
> +    }
> +    return 0;
> +}
> +
>   static const VMStateDescription vfio_container_vmstate = {
>       .name = "vfio-container",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>       .pre_save = vfio_container_pre_save,
> +    .post_load = vfio_container_post_load,
>       .needed = cpr_incoming_needed,
>       .fields = (VMStateField[]) {
>           VMSTATE_END_OF_LIST()
> @@ -86,6 +137,12 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> +    /* During incoming CPR, divert calls to dma_map. */
> +    if (cpr_is_incoming()) {
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        container->cpr.saved_dma_map = vioc->dma_map;
> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
> +    }
>       return true;
>   }
>   


