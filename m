Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F1AC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6zV-0001Rv-1p; Mon, 03 Jun 2024 08:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6zT-0001R7-7B
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6zR-0007aW-2A
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717418438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFKmdorU0mGFeeU/GFo0MJgjVehYRKxknK523coC3Ag=;
 b=Y/YqECxQmLD+69ftqqZb5fknw+4/d4DajF/u1tlXPBNBDmwzqO7YxB3dZm6eV48qsN4bDP
 MQ8o49my4rkaxsbeQYxc9a+2ldKQ9BxVxgLqkNg9ug16WIih1jF5jHYDMxuWaolPwt+jF9
 W9izi4cC/ROOmo00sg0Mz6TrQ7pm4O4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-SwtM6OrsMyW2VJ3HFs5uQw-1; Mon, 03 Jun 2024 08:40:37 -0400
X-MC-Unique: SwtM6OrsMyW2VJ3HFs5uQw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fe73f5b4aso48089431cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418437; x=1718023237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFKmdorU0mGFeeU/GFo0MJgjVehYRKxknK523coC3Ag=;
 b=mBVy+OHWhDMh9ckXw9opSg7CwwshEdcItWRTWwNCKoXge1nV/gufRs67WvkhHmPoyy
 8sbaz4nfTL2zZlkfZX4wgLYhbRiCxGkY7eSFE3WgR6/Pn9JOvkFF2/mALq9Stn8JlGg8
 r72g21UDdhYjZ0AOs1yQgrE/ZWct2DoHgMDY/T1ma7A2VIkgdrBzVu5jIS1Gy1DC8uyU
 iPIh5OGFxCrURH843OeYwgeS7X9UBlzvl5H5lDWPQ4n0WQeMDOUSwsoymh3FGOCR0dtc
 gJzfGZfBam6msoQRdVN+5ioL7KDCK6opLM6XSXrdD174UH+bAPiLHxOOAUZAH+FOFVIJ
 skSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAEX+/YMzvc1hQ7+xZhY1QJ4F5/CAeSSLVHETSvMmI777UxvoqwKOFgIQd4F/QgmzI+LJ8fvkuqMNVZhJG9kuaFvSCnJg=
X-Gm-Message-State: AOJu0YwTCLhgRZ3EXZ8LDWZj9CNKzRMmaXq/3tvxmfZUK9cVx/FLp5qS
 VPGNxTEmIypvhuSbEI5l1oScv38N3fF0pcKueVkR6IUUvYGa1F1s2yDQT46RhXhFvtljjG950ga
 f7b2OXZer5C2gwxorGaK+InnsJE48eziDJq+jiy8oKPK1A5qjTdHj
X-Received: by 2002:ac8:5994:0:b0:43a:f4ce:121b with SMTP id
 d75a77b69052e-43ff52add4emr92098501cf.41.1717418436411; 
 Mon, 03 Jun 2024 05:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHspfiZ1bHKEU1jbuEqKgfU4QbbH1C9laNDakztSbaT4Tyj+5sDtIUxz9J4jpAvfpbbKt35Gg==
X-Received: by 2002:ac8:5994:0:b0:43a:f4ce:121b with SMTP id
 d75a77b69052e-43ff52add4emr92098181cf.41.1717418435822; 
 Mon, 03 Jun 2024 05:40:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44001a76ad4sm25379871cf.87.2024.06.03.05.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:40:35 -0700 (PDT)
Message-ID: <72ffb4f6-6c96-43de-a999-ce7f4c3ef5df@redhat.com>
Date: Mon, 3 Jun 2024 14:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-6-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240603061023.269738-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 08:10, Zhenzhong Duan wrote:
> HostIOMMUDeviceCaps's elements map to the host IOMMU's capabilities.
> Different platform IOMMU can support different elements.
> 
> Currently only two elements, type and aw_bits, type hints the host
> platform IOMMU type, i.e., INTEL vtd, ARM smmu, etc; aw_bits hints
> host IOMMU address width.
> 
> Introduce .get_cap() handler to check if HOST_IOMMU_DEVICE_CAP_XXX
> is supported.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/host_iommu_device.h | 37 ++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 2b58a94d62..d47d1034b1 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -15,11 +15,25 @@
>   #include "qom/object.h"
>   #include "qapi/error.h"
>   
> +/**
> + * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @aw_bits: host IOMMU address width. 0xff if no limitation.

Could we introduce a define for the special value 0xff ? This would answer
Eric's question.


Thanks,

C.



> + */
> +typedef struct HostIOMMUDeviceCaps {
> +    uint32_t type;
> +    uint8_t aw_bits;
> +} HostIOMMUDeviceCaps;
> +
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>   OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
>   
>   struct HostIOMMUDevice {
>       Object parent_obj;
> +
> +    HostIOMMUDeviceCaps caps;
>   };
>   
>   /**
> @@ -47,5 +61,28 @@ struct HostIOMMUDeviceClass {
>        * Returns: true on success, false on failure.
>        */
>       bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +    /**
> +     * @get_cap: check if a host IOMMU device capability is supported.
> +     *
> +     * Optional callback, if not implemented, hint not supporting query
> +     * of @cap.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @cap: capability to check.
> +     *
> +     * @errp: pass an Error out when fails to query capability.
> +     *
> +     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
> +     * 1 or some positive value for some special @cap,
> +     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
> +     */
> +    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>   };
> +
> +/*
> + * Host IOMMU device capability list.
> + */
> +#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    0
> +#define HOST_IOMMU_DEVICE_CAP_AW_BITS       1
>   #endif


