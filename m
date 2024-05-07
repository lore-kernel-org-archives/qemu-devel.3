Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AC6C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JkE-0002rV-SU; Tue, 07 May 2024 08:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Jjx-0002hA-5P
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Jju-0001BM-IZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715084169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgZwf+OJofzKjlUr04LDgMXG05JK4FwCCbz2PQ0UvOY=;
 b=BHXxb/qsm8hgB2Ts0NtydHkI64YQI0hvKNDyoTTqqdG2Qpr33C8QioUNm35AgcjMvBZDOR
 lZtVatovguXJ4b8XHM7a/P2W+7XjFzBj5MNDQiPBRFtLS2OZ5YugdyuVWP67ljlzTkKzvt
 Xa7aR0HX88zcQby/KOt3dI0cxRzupsg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-qjNxqft7PFaDpQ6izA_rBA-1; Tue, 07 May 2024 08:16:08 -0400
X-MC-Unique: qjNxqft7PFaDpQ6izA_rBA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41bf6751b28so11242805e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084167; x=1715688967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgZwf+OJofzKjlUr04LDgMXG05JK4FwCCbz2PQ0UvOY=;
 b=LuJxAE3nb49coT0mUYar+4s58cEMg1csevxcU4vpMR852lrWjjDGXvKvNL9fxFOMsz
 xva61nDUURXS4ofCtu+J3igzYUWVdKLOrb+/wPiMy4dVReovjJWQPv6fwGDy4MT+IWKm
 MUQgBuPA8cnH8qMUI27ENkmRJ3u0tVWuTjJFaogjH+vRYHJkobrqpe31+WFKzLL/bPxf
 JcyTNEJWAdOJBFwkdR1b0vzSATvVznjhPt8Tt1wfsGYv9I6cQBQLGcaIchMTaLl7um7F
 KhdC9h6m3X//v9s0nvCqAcb+dFkWT7n4ph2Txg7+27hn0s0dE/YHkJoKQDk7YZ1qtl5w
 dWuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7xG423cAX5XfrRFGam92hWcSXZ9ViJvZSxWPQhpxZ/iC38SoPLTqrjM1f2AhTRzKXpLsCsGTk71dT010K4czl5EM3fBU=
X-Gm-Message-State: AOJu0YznHRD5yTsjyTYxQzww9sYhFJaveMywij6UgUCJ301KLMM3BgJT
 XP+MG7DW1/AqmYBAPqXWQCqpKvr+XAmmQO7fgz+oxREaCwUbx77qpeWat9xHMznPToHST759N2D
 btzZG8Mqyc86NR9ZL3BCR657UH23/zijcuZ487dkWHfRIKFh4snUE
X-Received: by 2002:a05:600c:154d:b0:41d:7c48:5558 with SMTP id
 f13-20020a05600c154d00b0041d7c485558mr9942349wmg.4.1715084167368; 
 Tue, 07 May 2024 05:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7w3ShEFozqTWFC4/DOgKfFqUgSgkwC2sz2Uo8Rsuq1sTpp6rHjIgh5njg2knGBps2I9wvMg==
X-Received: by 2002:a05:600c:154d:b0:41d:7c48:5558 with SMTP id
 f13-20020a05600c154d00b0041d7c485558mr9942336wmg.4.1715084166998; 
 Tue, 07 May 2024 05:16:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c469100b0041b083e16e2sm23385788wmo.2.2024.05.07.05.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:16:06 -0700 (PDT)
Message-ID: <63fd5fb0-7176-4e86-bf11-4e5e35b4b2fd@redhat.com>
Date: Tue, 7 May 2024 14:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/19] vfio/container: Introduce
 TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507092043.1172717-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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
> TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO represents a host IOMMU device under
> VFIO legacy container backend.
> 
> It will have its own realize implementation.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 3 +++
>   hw/vfio/container.c           | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e4c60374fa..05a199ce65 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>   #endif
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/host_iommu_device.h"

This breaks build on windows because <linux/iommufd.h> is included
by <sysemu/host_iommu_device.h>. See patch 5.


Thanks,

C.


>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -147,6 +148,8 @@ typedef struct VFIOGroup {
>       bool ram_block_discard_allowed;
>   } VFIOGroup;
>   
> +#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
> +
>   typedef struct VFIODMABuf {
>       QemuDmaBuf buf;
>       uint32_t pos_x, pos_y, pos_updates;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 86266f3b83..1b4fc2f3e8 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1139,7 +1139,10 @@ static const TypeInfo types[] = {
>           .name = TYPE_VFIO_IOMMU_LEGACY,
>           .parent = TYPE_VFIO_IOMMU,
>           .class_init = vfio_iommu_legacy_class_init,
> -    },
> +    }, {
> +        .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
> +        .parent = TYPE_HOST_IOMMU_DEVICE,
> +    }
>   };
>   
>   DEFINE_TYPES(types)


