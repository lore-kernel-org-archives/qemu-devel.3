Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0E9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jzi-0004rm-7f; Tue, 30 Apr 2024 05:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzY-0004gU-TM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzX-0005uO-10
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTiu5f5Q6epCtwvAnTpMDZu4maB+2H1i3xvLfPPI7A4=;
 b=FR/RN7IjwG3etCA9A3aqHdJ4Us8EfXgM5d7B26/7RXGZtqOtWkSU9mbOqeD1NH5jyAWzFO
 PH3AnTB13oizrLPjMb5P0eXF+FPLchMMkSy36dLXWQ2xucHLZcjqZfgQGvrlv5ncv4b9OG
 t0b5TVfZLC6FPLszMia6IJu357EwQpA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-P_hoPuxEP2G8ah3zC2chlQ-1; Tue, 30 Apr 2024 05:41:35 -0400
X-MC-Unique: P_hoPuxEP2G8ah3zC2chlQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a51eb0c14c8so205229966b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470094; x=1715074894;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTiu5f5Q6epCtwvAnTpMDZu4maB+2H1i3xvLfPPI7A4=;
 b=Z0U8g90U9fO1+f3htzTUrBOLQJw4TDLKnHdpADAd5KCVryXeNyHPJw8ZHqt44K+hkE
 Y9gflAEsLYIdq/kQI2/WFkRg8LzSqObZE87F/rhT962TJh/gIDrs6k690RB6UA2ZAT/G
 g0m6TcO08klWdzhMQyH6d4DvVMb20Sz3RTuNJcQj6M7XntwQihA2/gjwnoKt1LGngfH1
 1i/BMOvch2CsALkdizrnRbUPG+vchlk/MtCPfNrK49h7diZxzgkmaGs7aDmnhMggyzke
 oqf96WEvbQaF987WovbMwGyGFwN3OBLaSYqsNOzqeW7q5wy1tz6Kv/BiXS7syWNaN0f/
 JvtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc1lS/OoJhnDE+WSEWA1f/qZ+VuKvWWdOvF9VNwSjVXEKhyVNp/oYtjtQt6wb0Egb3gje6cm9B3afuCKTqV/VMvlIxSwI=
X-Gm-Message-State: AOJu0YxhWlV09aZYGd0ESzXST2hq7y6obygxHeTWsRgS0FuNLvkYqfpf
 aiU0aIYXrLhRO5lHoMUwpktHy77lCAUbRrAOMekch4T/Nh2Z2NercndT8C4H37Npf+1P8STlYN2
 ILb3XKczh6AIXEkqm1I6YodCMAOrnklh474X1Y/auJgErs5a2qjht
X-Received: by 2002:a17:906:384:b0:a58:c551:4ea3 with SMTP id
 b4-20020a170906038400b00a58c5514ea3mr1572448eja.48.1714470094396; 
 Tue, 30 Apr 2024 02:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjsMOOLMo9qKqaZyWqc61xtu5cDSsOlnXEqTKVwlCzXE3HErcn17fvsVkxrSGt1hXXvnMLog==
X-Received: by 2002:a17:906:384:b0:a58:c551:4ea3 with SMTP id
 b4-20020a170906038400b00a58c5514ea3mr1572429eja.48.1714470094127; 
 Tue, 30 Apr 2024 02:41:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 gl20-20020a170906e0d400b00a5889ee66d6sm7803905ejb.45.2024.04.30.02.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:33 -0700 (PDT)
Message-ID: <44765b34-c4f7-48e0-9e74-5b8a8d427766@redhat.com>
Date: Tue, 30 Apr 2024 11:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-9-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
In-Reply-To: <20240429065046.3688701-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 4/29/24 08:50, Zhenzhong Duan wrote:
> Introduce a helper function iommufd_backend_get_device_info() to get
> host IOMMU related information through iommufd uAPI.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/iommufd.h |  4 ++++
>   backends/iommufd.c       | 24 +++++++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 6a9fb0007a..e9593637a3 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -17,6 +17,7 @@
>   #include "qom/object.h"
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
> +#include <linux/iommufd.h>
>   #include "sysemu/host_iommu_device.h"
>   
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
> @@ -47,6 +48,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size);
> +int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                    enum iommu_hw_info_type *type,
> +                                    void *data, uint32_t len, Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 19e46194a2..d61209788a 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -19,7 +19,6 @@
>   #include "monitor/monitor.h"
>   #include "trace.h"
>   #include <sys/ioctl.h>
> -#include <linux/iommufd.h>
>   
>   static void iommufd_backend_init(Object *obj)
>   {
> @@ -211,6 +210,29 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> +int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                    enum iommu_hw_info_type *type,
> +                                    void *data, uint32_t len, Error **errp)

When taking an 'Error **' argument, routines preferably return a bool.

Thanks,

C.



  
> +{
> +    struct iommu_hw_info info = {
> +        .size = sizeof(info),
> +        .dev_id = devid,
> +        .data_len = len,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +    int ret;
> +
> +    ret = ioctl(be->fd, IOMMU_GET_HW_INFO, &info);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to get hardware info");
> +    } else {
> +        g_assert(type);
> +        *type = info.out_data_type;
> +    }
> +
> +    return ret;
> +}
> +
>   static const TypeInfo types[] = {
>       {
>           .name = TYPE_IOMMUFD_BACKEND,


