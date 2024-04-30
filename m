Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D6EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iGy-00051v-N4; Tue, 30 Apr 2024 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1iGm-00050R-RQ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1iGk-0006Sw-VL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714463476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffkG4FbjhFC7K9NSd93I3T40/nsxNmBn3kNpSp66+nQ=;
 b=XGeZHyx2sZHAmvEiJ5tIXYiXULW7kAVV4GmVluIWmX0ANSQ3b7KItfAbxfCWJjF3kb+MR4
 Wb/d1HwpLJgfBxF+CIDhISuWcO0cz7JljuLQnjWPaxgoPi8ciXRoDzT/IGy18qVGM03wGG
 m43NEJTcFhFAO9bSupj7jEWR90YbF74=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-I23yvXB6Ol6Z4hSY5tkYnQ-1; Tue, 30 Apr 2024 03:51:12 -0400
X-MC-Unique: I23yvXB6Ol6Z4hSY5tkYnQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0e381e63cso3620956d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 00:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714463471; x=1715068271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffkG4FbjhFC7K9NSd93I3T40/nsxNmBn3kNpSp66+nQ=;
 b=kFtad9VD0eWmTvhwANWR9W0xmNkfdOGv2/a5gfs64/3IPX3+zJVt39+DBIqGIw/XOO
 YJOAjIpAzHs26WKElsY6EThTATwQnSju1z4AE91V43MlCNnWIdY9eq4IMjZyHa1BrT0r
 vF+BPzluNqS71jtYGh+7MyvmdFYvklcnu4WcSXNDk1tobT4nWHNlc/aJu/oSd0g0XRp5
 yyLX2bdJeqHLKc+g46S85IvmBCng0IkwE6FZX5irHKCAvVcFb/Jt40Xeq0SKWDWfzFjC
 UDL/Toc+7tFM0gpmJ2lzJHyzik62sj81uvoj4WnEK6W14h1xn6MfcdyDTBbUNprALn2O
 1x5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQGIItdBXwNZQt92H8qwAWpjQN1hybLyaWAVBF1sVD114KlSq2UH5wHaurw716uIUNb40AEzr+2oTeB56PkDesYAivubY=
X-Gm-Message-State: AOJu0YyDAzVGj8bvsWVWJVfJDkt+1vmq3UZ1QYnHpVDOuJASKSrV4ORg
 BQh7aCQgIvblzyP0tOyw6IsAIlXBEp49M9MawDl5dEEL86mzxTYcDpRol8BFnMJ+RSCiRSj4oZO
 xIj2D+xsIJczGy1zqmcKhRzpxKteln7BhdlgoYePHP/6IKAmhFQiO
X-Received: by 2002:a05:6214:d08:b0:6a0:67ae:784 with SMTP id
 8-20020a0562140d0800b006a067ae0784mr1355916qvh.65.1714463471699; 
 Tue, 30 Apr 2024 00:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9PC+2eXGSleDkToFljMR1+Js0BXv6DYbXWOBQUSPIWpM4OrvYV68aQ7HcC+xSHyCqyItPeQ==
X-Received: by 2002:a05:6214:d08:b0:6a0:67ae:784 with SMTP id
 8-20020a0562140d0800b006a067ae0784mr1355910qvh.65.1714463471372; 
 Tue, 30 Apr 2024 00:51:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 r1-20020ad44041000000b006a0d4d7ec55sm1183563qvp.88.2024.04.30.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 00:51:10 -0700 (PDT)
Message-ID: <5160adfc-9630-49f0-a2a4-f6987c819bc5@redhat.com>
Date: Tue, 30 Apr 2024 09:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] vfio/container: Introduce
 HostIOMMUDeviceLegacyVFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240429065046.3688701-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> HostIOMMUDeviceLegacyVFIO represents a host IOMMU device under VFIO
> legacy container backend.
> 
> It includes a link to VFIODevice.

I don't see any use of this attribute. May be introduce later when needed.

Thanks,

C.

> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 12 ++++++++++++
>   hw/vfio/container.c           |  6 +++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..aa3abe0a18 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>   #endif
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/host_iommu_device.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -147,6 +148,17 @@ typedef struct VFIOGroup {
>       bool ram_block_discard_allowed;
>   } VFIOGroup;
>   
> +#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
> +OBJECT_DECLARE_SIMPLE_TYPE(HostIOMMUDeviceLegacyVFIO,
> +                           HOST_IOMMU_DEVICE_LEGACY_VFIO)
> +
> +/* Abstract of host IOMMU device with VFIO legacy container backend */
> +struct HostIOMMUDeviceLegacyVFIO {
> +    HostIOMMUDevice parent_obj;
> +
> +    VFIODevice *vdev;
> +};
> +
>   typedef struct VFIODMABuf {
>       QemuDmaBuf buf;
>       uint32_t pos_x, pos_y, pos_updates;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276e..3b6826996a 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1148,7 +1148,11 @@ static const TypeInfo types[] = {
>           .name = TYPE_VFIO_IOMMU_LEGACY,
>           .parent = TYPE_VFIO_IOMMU,
>           .class_init = vfio_iommu_legacy_class_init,
> -    },
> +    }, {
> +        .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
> +        .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HostIOMMUDeviceLegacyVFIO),
> +    }
>   };
>   
>   DEFINE_TYPES(types)


