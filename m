Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF74C3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVth0-00044S-Ev; Mon, 22 Jul 2024 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtgy-00043z-Vp
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtgx-0000ti-4P
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721657222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqZbVelAlCFJGooPdCewvrNKd0HonHuJj1MSWr5GNJI=;
 b=WpJW50/l5ataPd5sX7fHC8NRT0GWU+bpkX58inQBgV5/Zgd0vyjKff9aItuWWRKFPiw1iQ
 yGEwvc6GNNCjyvK+eNRudJb6TlKPqpdocQFretdbWCowx7thdCODVbChkPghxHVRgFIZKp
 HCgvHCtWuhP/zb89SiaVlpQulZUuvm0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-80fS1DOXMkGY2CzpJo6ivg-1; Mon, 22 Jul 2024 10:06:57 -0400
X-MC-Unique: 80fS1DOXMkGY2CzpJo6ivg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-79f00fbac96so655950685a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721657217; x=1722262017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqZbVelAlCFJGooPdCewvrNKd0HonHuJj1MSWr5GNJI=;
 b=jJYpCcmu/WBaVauFomuBlFkQuJbpC6d1J+YNZslmBYaCxQypxLHI6qKuao5LJrzDzo
 7b5WXTPvR9/V/zrUeN1kL54pReX9jYqs866rvccI3Vk+l/4BSJ8mA605I9ABXXE21pZe
 iNga4mUNFRqxprRE9uA2y0+9gma+pr/nM+3JcdPYyNcFKkHzsXYhdfWxFILb1IQCPERV
 PXvdAarD3Vge9C/Wj3nd9saS8fVJRZ8OHHwgfs6mXWsZy4x72acLge+H3xWiHUGQwRZX
 L7dTk/DLA+mnBuNNhl2cCLfJzFh2gJTWI2kO6WQ7Y1OX/4TrQ/mH4yqxZ+lJz4tKX3yq
 y88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS8TIJiq9FF3PEPtsub7/WwF5/u01FT5LRlAaurOiz0gqq0oIWbHiWHTmI5SoXgPQv9zGZ+fsDusRvOu7MLorjMIRRFno=
X-Gm-Message-State: AOJu0YwNwdUFYpnXEFnc7s+UPwnBjue/7rYXvfJU5LDvWF0kxrfkdFgt
 higrUwM04XpJPekFLpcSrc/jI/zNEtAGUJoB4JDJvnQSB5lQV14sO4R8qs5qI3ZcGaNXWw/ea2q
 GA0gRc+4lhHLsEbUw3jp/xiPF7RwfnTjuG1C9EIitFjpF7sbxNxZw
X-Received: by 2002:a05:6214:f0f:b0:6b5:4aa9:9687 with SMTP id
 6a1803df08f44-6b961116423mr97436636d6.50.1721657216663; 
 Mon, 22 Jul 2024 07:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELP9LkvxiRTwqzy+npNYTyySxeDjYqhvX9wghUl7DoR3AO9C+uzp0uWk9Lrna8ewwosQo+nw==
X-Received: by 2002:a05:6214:f0f:b0:6b5:4aa9:9687 with SMTP id
 6a1803df08f44-6b961116423mr97436286d6.50.1721657216273; 
 Mon, 22 Jul 2024 07:06:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b95cf17789sm24860176d6.7.2024.07.22.07.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:06:55 -0700 (PDT)
Message-ID: <0c6e2b4d-d466-4ef7-96be-2d0044010d46@redhat.com>
Date: Mon, 22 Jul 2024 16:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] vfio/iommufd: Add hw_caps field to
 HostIOMMUDeviceCaps
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-8-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719120501.81279-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/19/24 14:04, Joao Martins wrote:
> Store the value of @caps returned by iommufd_backend_get_device_info()
> in a new field HostIOMMUDeviceCaps::hw_caps. Right now the only value is
> whether device IOMMU supports dirty tracking (IOMMU_HW_CAP_DIRTY_TRACKING).
> 
> This is in preparation for HostIOMMUDevice::realize() being called early
> during attach_device().
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/host_iommu_device.h | 4 ++++
>   hw/vfio/iommufd.c                  | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index cdeeccec7671..fd03ce766522 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -19,9 +19,13 @@
>    * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>    *
>    * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
>    */
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
> +    uint64_t hw_caps;
>   } HostIOMMUDeviceCaps;
>   
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 028533bc39b9..7a10b1e90a6f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -724,6 +724,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>   
>       hiod->name = g_strdup(vdev->name);
>       caps->type = type;
> +    caps->hw_caps = hw_caps;
>   
>       return true;
>   }


