Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46B5C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JnT-0006Bj-Ct; Tue, 07 May 2024 08:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4JnG-0005ug-F2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4JnC-0001hD-Bh
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715084372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyGGF1HvbF55+p/3LNi1+TMdzNz5G/G+/Yw3OuORKf8=;
 b=M6q+/4uYjsjRzaWYSx3oYCmB1Roa456dRXcM1yt3Nc7VXA5icYsz7v2fJrlVVfp1vh75Vo
 O/J/83nJyXG0DAY4Y7XTstyvCnjFgR/6lHpIHbRUKiZAen65a6eCGS9xpICKcn/TU9cPTK
 xsIzT/uTCHofU9IIJeoZLazO21ndmvU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-SF-gNSvOMwGgZrqxtBuyXA-1; Tue, 07 May 2024 08:19:31 -0400
X-MC-Unique: SF-gNSvOMwGgZrqxtBuyXA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-417fb8195d7so13196955e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084369; x=1715689169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyGGF1HvbF55+p/3LNi1+TMdzNz5G/G+/Yw3OuORKf8=;
 b=Q/aKKtg2H0sj/LtKBuyMIOK4+2dwHAVxsMRI3ZQBOGeXB6ulVIiFCr7Tfy8j0+pnCe
 GIhBgfQ4SRmbdvsvJWRzB6EUw/FgLdZWEOxIQ81vJ0dSuJjL246Fjo1X+Ch4jXp4DZGf
 7v5ujJX6fSlFVu4gCdzKUH9Au5+ja28S4Mg6vnZHP9+Ggc/74pP37V/mwZzMHQx+y+u5
 Jxw2mlhH9Fo/LHRw0pjVgsVNIV3NUQxgOw8c647mBzRLsB6CFqbcGN0eCwqv+Hfb6yW1
 w+w2NjPMgMQvobTpledtpenH/O022ia7eilmEN/PiuzhRjOANUB8JFA23oFj0GLAIutY
 bDCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgNXd5XTZLyoFwtQ3pRtUBJl/RwAsEodMkIFL5c/cN5vP2BYWDGayGTnVBMttLYgzeeJxLRsBWmdtLt7InYx+O2gSmUN0=
X-Gm-Message-State: AOJu0YynX0CEYmqwUX35QthiBMtpuLsNBrc8GIzbf4+W/oszVwE/TONe
 l59wWCKWbLdjTulnHtU1VznZEIOUcQf7Xbuy3wLOPayS6h6uzcj0L+S/2CsxzCmm/PgVhpWPNH7
 x4cLXbbO6hxiVLB4VSz1nA2/h22pula3/eXi9dbBHR/30DD/5ARRnvKq6qWAq
X-Received: by 2002:a05:600c:4fc3:b0:418:969a:b316 with SMTP id
 o3-20020a05600c4fc300b00418969ab316mr9337516wmq.1.1715084369254; 
 Tue, 07 May 2024 05:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfeGL06yE5eaulJIfcSh7dfBFsxkGm5WIUA1mtfRQtYFa/Gdf3UElJnp7g/3/kgvN4BTP+w==
X-Received: by 2002:a05:600c:4fc3:b0:418:969a:b316 with SMTP id
 o3-20020a05600c4fc300b00418969ab316mr9337501wmq.1.1715084368910; 
 Tue, 07 May 2024 05:19:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ka21-20020a05600c585500b0041a9c3444a6sm22893755wmb.28.2024.05.07.05.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:19:28 -0700 (PDT)
Message-ID: <b4ba9a82-738d-481e-8d22-3fe6a1586fe9@redhat.com>
Date: Tue, 7 May 2024 14:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] vfio/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-5-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507092043.1172717-5-zhenzhong.duan@intel.com>
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

On 5/7/24 11:20, Zhenzhong Duan wrote:
> TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO represents a host IOMMU device under
> VFIO iommufd backend. It will be created during VFIO device attaching
> and passed to vIOMMU.
> 
> It will have its own .realize() implementation.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 3 +++
>   hw/vfio/iommufd.c             | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 05a199ce65..affb73f209 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -32,6 +32,7 @@
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
>   #include "sysemu/host_iommu_device.h"
> +#include "sysemu/iommufd.h"

I don't think you need this include.


Thanks,

C.


>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -149,6 +150,8 @@ typedef struct VFIOGroup {
>   } VFIOGroup;
>   
>   #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
> +#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>   
>   typedef struct VFIODMABuf {
>       QemuDmaBuf buf;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 554f9a6292..e4a507d55c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -624,7 +624,10 @@ static const TypeInfo types[] = {
>           .name = TYPE_VFIO_IOMMU_IOMMUFD,
>           .parent = TYPE_VFIO_IOMMU,
>           .class_init = vfio_iommu_iommufd_class_init,
> -    },
> +    }, {
> +        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
> +        .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
> +    }
>   };
>   
>   DEFINE_TYPES(types)


