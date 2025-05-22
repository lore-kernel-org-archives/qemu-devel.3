Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB5BC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHzYg-0003ss-QU; Thu, 22 May 2025 02:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHzYd-0003sa-Sz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHzYb-0000tc-E0
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747895851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cu8PdhXzUL/bgjmSaBCz+bbWUSoYSxlgBPcraC7B77E=;
 b=B0vVSGGdJwNO+f3hcU9gawEE5wiWSBwtGF0K9NVhyexx0xW/tdN+VjIvcAkOgrwtRHBP+D
 pyF1YkE7Ul+2Q/vxdWM/OlWAyrVUACsDgeEz5J901si6odDhJIGbiFhKvEI+I2oNxObD7E
 YMT59S5nvBvzIotpewDyxTMoa+qHGec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-sqaZIApFNJyWNMK_0OT9jw-1; Thu, 22 May 2025 02:37:28 -0400
X-MC-Unique: sqaZIApFNJyWNMK_0OT9jw-1
X-Mimecast-MFC-AGG-ID: sqaZIApFNJyWNMK_0OT9jw_1747895848
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a36a4c70b4so1780150f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 23:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747895847; x=1748500647;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cu8PdhXzUL/bgjmSaBCz+bbWUSoYSxlgBPcraC7B77E=;
 b=KwqHfjhMQs6JBoXvhm7jvJabfJIpg6oKiYDmyvHDF/aB1hw2wy258E+EUaYla8BQJD
 ZCcH3FGflxGuQBSv9nm13PtIZhIWQz5WxipVG1Z630RAG6oPI7rC3TOSkQJYFgmaTB13
 RgW0kjG/2YYlo8ukEQj/FMtpgJq6R4XQ5M9jZWdU6BDFdaaDedm448cNAmcQrVTrD4LO
 MojiGQ6fGiL5jcO0bPBgjN+95v6H+pRMv/6nOw/zw2YtyLWUZjCvxb1WTs23PbDplgPx
 mbE/BMRFHBXok/H5m5oOCxmlpfnxNZi1myMxx86kIaaaWqtgr8w/T9umwTsRRpSlyga2
 btXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtpo4xdEqWsfxyjjEMNhiwIz0X5lFCyXFGUjEqiTGS3VT+39w72yq1K2QpEgXk7wEaVRHsADaTi/Mx@nongnu.org
X-Gm-Message-State: AOJu0YwOPHFYbAi7c6oHY9RmjnjtuhstiQRidyuA3GyOz3YkoZYnblM2
 0z89W6VqrtjdPpXnlloje+pSZonrVeSy7sJohVlSFiMLG7Q1t0D/uzB6mJFsESJftd8g9v3RNE/
 qtZislwPIId1hMocya1N9igJl5wb+tsMfRBKQ0NzSUaXqFc3py7NiHrFQ
X-Gm-Gg: ASbGncuLk19Wm/46MvxcPjDLVO2krDQ8w+uwJ7iA3OEw+5VDF//k6PzGVqNn9gX7Zy1
 3WIE5PqYDRsjSwrAQs82QD2qLP6DJhqiGq0USyJVIXhRssiPPX7vKHTD2wIlS/F/AyaypCmbaj9
 gBPdL/YXG9M8Mr7ElZ56Ls0pRdfCHG9ISo4c5RhgQeN7h6PK7ByytjKsG5deZcwLyBM2VWD5Yw8
 VupuPTOYSIuiSrr2/q8bzRejG7QgL85t73uhs59Toe3w851NPQ/jvp/V49Pygop+oewuO1nSidH
 +woQkECELWbZtS1oCPTOlDFBwmbsF91HFGLdLDSos3DWsESJHA==
X-Received: by 2002:a05:6000:2008:b0:3a4:79e8:cdfc with SMTP id
 ffacd0b85a97d-3a479e8cf38mr4857819f8f.30.1747895847455; 
 Wed, 21 May 2025 23:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfc0v3f8OxAVBnBgSf8PtnsmCPGEQvI+OKgaq07JF8G+6X1wgfJhzKkUPPuJbappx1jl2P9A==
X-Received: by 2002:a05:6000:2008:b0:3a4:79e8:cdfc with SMTP id
 ffacd0b85a97d-3a479e8cf38mr4857792f8f.30.1747895847010; 
 Wed, 21 May 2025 23:37:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d310sm22127304f8f.17.2025.05.21.23.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 23:37:26 -0700 (PDT)
Message-ID: <b6ef4b4b-6f10-4640-8668-77976ed0076e@redhat.com>
Date: Thu, 22 May 2025 08:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/42] vfio/container: restore DMA vaddr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
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
> ---
>   hw/vfio/container.c  | 15 +++++++++++++--
>   hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a554683..0e02726 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> +    assert(!container->cpr.reused);

assert -> g_assert

this can be called at runtime, which would mean crashing QEMU in case
of error. Doing an error_report() call is more friendly.


Thanks,

C.


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
> +     * If reused, register the listener later, after all state that may
> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
> +     * the listener will invoke its callback on each flat section and call
> +     * dma_map to supply the new vaddr, and the calls will match the mappings
> +     * remembered by the kernel.
> +     */
> +    if (!cpr_reused) {
> +        if (!vfio_listener_register(bcontainer, errp)) {
> +            goto fail;
> +        }
>       }
>   
>       bcontainer->initialized = true;
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 519d772..bbcf71e 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -11,11 +11,13 @@
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
> @@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>       return true;
>   }
>   
> +/*
> + * Set the new @vaddr for any mappings registered during cpr load.
> + * Reused is cleared thereafter.
> + */
> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
> +                                   bool readonly)
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
> +    assert(container->cpr.reused);
> +> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
> +        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
> +                     iova, size, vaddr, strerror(errno));
> +        return -errno;
> +    }
> +
> +    return 0;
> +}
>   
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
> @@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
>   static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIOGroup *group;
>       VFIODevice *vbasedev;
> +    Error *err = NULL;
> +
> +    if (!vfio_listener_register(bcontainer, &err)) {
> +        error_report_err(err);
> +        return -1;
> +    }
>   
>       container->cpr.reused = false;
>   
>       QLIST_FOREACH(group, &container->group_list, container_next) {
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +
> +        /* Restore original dma_map function */
> +        vioc->dma_map = vfio_legacy_dma_map;
> +
>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>               vbasedev->cpr.reused = false;
>           }
> @@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
>       .name = "vfio-container",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>       .pre_save = vfio_container_pre_save,
>       .post_load = vfio_container_post_load,
>       .needed = cpr_needed_for_reuse,
> @@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> +    /* During incoming CPR, divert calls to dma_map. */
> +    if (container->cpr.reused) {
> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
> +    }
>       return true;
>   }
>   


