Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4860C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3x3A-0007vd-FZ; Mon, 06 May 2024 08:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3x2x-0007mH-ML
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3x2t-0006Ik-1A
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714996934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7W7H3TuqDun6usvve/cdmKuSvY7zlK15x7QkD+hOz4=;
 b=XJj1opNiuOwO3Pic9Dc4CRBYqMnDxUnYfWjIv7I8ycqhJtBB4Wa75HxZCS33fRyjrwUY+P
 /RpTFDYkRHkZ5MoGngYnD+ZKQ+TilUf92mJ8PYLAqMg7P5+SyH9KcMmUwX/YCyDPCMRH54
 dKN48PH8AQpI5uGRNtKHuu7RQh8K/hs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-0haSe2GyPrqdOAXkroQdFw-1; Mon, 06 May 2024 08:02:11 -0400
X-MC-Unique: 0haSe2GyPrqdOAXkroQdFw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41bd87bb458so14534885e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714996931; x=1715601731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7W7H3TuqDun6usvve/cdmKuSvY7zlK15x7QkD+hOz4=;
 b=vYD++sF2xTX6pxPSIsGbF4A67TmGixlvcoZGoQQq/KPVmDZoiEUiyGD5WBts/DDlbN
 x7RC0trWoLg/zSAh3Id8vC5DHT63R9j6YS1bRrQ4Pcz++o0RjJB/J1TXqqOPW0cqRPfA
 T+LAY7IGSaaj5+JuXA/sVDbfTsQQh7RI0nfZ13M+2aUG3X0LClR8v6IkSDaUXFEReafb
 t9/NfKBQ0oc/b9XG4q3r/DU8vBv8IV25oDV3+1nEmbicoXW92f83+eSuaOIizLZGlwov
 sWnilrlCMOvoX4xRtLjDnIPg+CujeAMHUXhUyjMF7vFeF8opQeIzGR4jt2phXTu5jSk9
 xQxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy2eW3Bk2ixhqc2JFt9PID6iBqZmwUGUyTEpkWgjXkO1fbPS58jQW9zmCe4iGOpo4r6vRhwBvcg5ErkzZMXA6idGzfvLo=
X-Gm-Message-State: AOJu0YwJf2Hc07LzCsQZCMb3l1coyjLvLix8GpI0EnX9GDNZ1bZRQ1N7
 hhA59UxUf8af9Kh+AVjjUbv0td1Icbg/PrRocUkAKAaAO3hGEPC7DPtiYgdZwkElw250YViQxA9
 TuNDENtqRCzrvFVi/ccVB3k5LwE9aLp3/5n5HkYZKbnzsYOw/OuWM
X-Received: by 2002:a05:600c:450e:b0:41b:edf4:4071 with SMTP id
 t14-20020a05600c450e00b0041bedf44071mr10059545wmo.35.1714996930815; 
 Mon, 06 May 2024 05:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFITuaymAIClcJ8JOarmves1tFZ/8mda3exmwGtoE3+8YKfGfwc+1t9pvpLdwFUbopAAa/9Ow==
X-Received: by 2002:a05:600c:450e:b0:41b:edf4:4071 with SMTP id
 t14-20020a05600c450e00b0041bedf44071mr10059486wmo.35.1714996929786; 
 Mon, 06 May 2024 05:02:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 ay35-20020a05600c1e2300b00419f419236fsm15960212wmb.41.2024.05.06.05.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 05:02:09 -0700 (PDT)
Message-ID: <82621e4a-b17f-4ed5-b13a-1bf1ffab5fd2@redhat.com>
Date: Mon, 6 May 2024 14:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio: Make VFIOIOMMUClass::setup() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
 <20240506083352.4037226-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240506083352.4037226-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/6/24 10:33, Zhenzhong Duan wrote:
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h |  2 +-
>   hw/vfio/container.c                   | 10 +++++-----
>   hw/vfio/spapr.c                       | 12 +++++-------
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index c839cfd9cb..68539e3bed 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -111,7 +111,7 @@ struct VFIOIOMMUClass {
>       InterfaceClass parent_class;
>   
>       /* basic feature */
> -    int (*setup)(VFIOContainerBase *bcontainer, Error **errp);
> +    bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index ea3b145913..85a8a369dc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -505,7 +505,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>       }
>   }
>   
> -static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
> +static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>   {
>       VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                               bcontainer);
> @@ -515,7 +515,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       ret = vfio_get_iommu_info(container, &info);
>       if (ret) {
>           error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
> -        return ret;
> +        return false;
>       }
>   
>       if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
> @@ -531,7 +531,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
>       vfio_get_info_iova_range(info, bcontainer);
>   
>       vfio_get_iommu_info_migration(container, info);
> -    return 0;
> +    return true;
>   }
>   
>   static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> @@ -633,8 +633,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>       assert(bcontainer->ops->setup);
>   
> -    ret = bcontainer->ops->setup(bcontainer, errp);
> -    if (ret) {
> +    if (!bcontainer->ops->setup(bcontainer, errp)) {
> +        ret = -EINVAL;
>           goto enable_discards_exit;
>       }
>   
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 0d949bb728..148b257c9c 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -458,8 +458,8 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>       }
>   }
>   
> -static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
> -                                      Error **errp)
> +static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
> +                                       Error **errp)
>   {
>       VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                               bcontainer);
> @@ -480,7 +480,7 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>           ret = ioctl(fd, VFIO_IOMMU_ENABLE);
>           if (ret) {
>               error_setg_errno(errp, errno, "failed to enable container");
> -            return -errno;
> +            return false;
>           }
>       } else {
>           scontainer->prereg_listener = vfio_prereg_listener;
> @@ -488,7 +488,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>           memory_listener_register(&scontainer->prereg_listener,
>                                    &address_space_memory);
>           if (bcontainer->error) {
> -            ret = -1;
>               error_propagate_prepend(errp, bcontainer->error,
>                       "RAM memory listener initialization failed: ");
>               goto listener_unregister_exit;
> @@ -500,7 +499,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>       if (ret) {
>           error_setg_errno(errp, errno,
>                            "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
> -        ret = -errno;
>           goto listener_unregister_exit;
>       }
>   
> @@ -527,13 +525,13 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>                             0x1000);
>       }
>   
> -    return 0;
> +    return true;
>   
>   listener_unregister_exit:
>       if (v2) {
>           memory_listener_unregister(&scontainer->prereg_listener);
>       }
> -    return ret;
> +    return false;
>   }
>   
>   static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)


