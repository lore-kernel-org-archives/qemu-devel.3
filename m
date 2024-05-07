Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C43C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4E35-0006Fi-5K; Tue, 07 May 2024 02:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4E30-0006Ba-Ec
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4E2u-0006J1-1I
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715062283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrD013TmYKZGduMcIKADW6trSIiATDoiCtRDlH6BWhE=;
 b=bXQ9Q+GX3iClhi/6qJnNlL5HaemTAvtkj/12NtBSJ1ql94dp6szpicipbKMq6D4g3Ug25V
 esrvoJTWnl/f4NdC9NeF43JN1QPlcl61UU7/Ue/ZGOKxyubNgCcnx88NkAyOTtVE075IQf
 dlHl0Q9RysgVZfjcau/ZaOPKSVR2OyQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-9LwRByVPPvekC6fM82tpaA-1; Tue, 07 May 2024 02:11:21 -0400
X-MC-Unique: 9LwRByVPPvekC6fM82tpaA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c864184db5so2475955b6e.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 23:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715062280; x=1715667080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrD013TmYKZGduMcIKADW6trSIiATDoiCtRDlH6BWhE=;
 b=Q+HNsQXZgahglP2dpwRoCnY5qhdybQfPP6o76yWoEqM9szsqD/2t2+1NRgQEfEtF6Z
 ROUvNTZqFTEY2nk5CQUnMynfMD46Ndhgru0pL6l4VI8dclyREmyJUZhYHjtdQh63WAeC
 h+WGQoUFdFQc3MCl6Hg8lRXKLHsB1S+O32rnCuJ/lV56Cqe6+XCOV0pYvb/k1QXhNerh
 El5Q7BlfKM8q2tEyOrqgWcoyUnJTB943YOkmUmOGxoE4M/cuX3Q9srQLVk7oAXKG1nyO
 hmboMQwmJY2BSFuKbN8zjo9zZ8/VolHAvu8QUyZr62tVFa0BIAIHOroGCJIHhueRPTA3
 dB4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVklsUBDzonbqRGgCibu7XEVByFiccT1jhCBOs8kS8OAu7v5iSJr64jIEIMsrAFFuQR3owpZqJve5RmU0ZPjWJBLjV8SNo=
X-Gm-Message-State: AOJu0YxLPqCRxRmwYDqgutARSVvu+JaAjzFZ85gucicPqMe1srwEZWQM
 YxQGqCKAP+xkABH3VK39YjWJb6w1Yv4MRjZvqejeD5ywAuHi1pbGmnxSM6ybfHscD9iOXjhgbfR
 Qp1vuWnM2WLKQsLdYbd9eyJo9j0r3r+WHo0NUffoZo6C/RbwkF86e
X-Received: by 2002:a05:6808:150b:b0:3c6:13c8:28a with SMTP id
 u11-20020a056808150b00b003c613c8028amr17253171oiw.40.1715062280468; 
 Mon, 06 May 2024 23:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqvxIF1DZVKMHByLM1+7lRHy7aGLc+RRobBleA/bTtn3v7RXxhdyzy1R47E0EXByCuqJpRew==
X-Received: by 2002:a05:6808:150b:b0:3c6:13c8:28a with SMTP id
 u11-20020a056808150b00b003c613c8028amr17253150oiw.40.1715062280181; 
 Mon, 06 May 2024 23:11:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 dg9-20020a056214084900b006a0dd95babdsm4396584qvb.96.2024.05.06.23.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 23:11:19 -0700 (PDT)
Message-ID: <462b4000-888b-4f89-bb0d-0cdbc0496a02@redhat.com>
Date: Tue, 7 May 2024 08:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-6-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240429065046.3688701-6-zhenzhong.duan@intel.com>
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

Hello Zhenzhong,

On 4/29/24 08:50, Zhenzhong Duan wrote:
> HostIOMMUDeviceCaps's elements map to the host IOMMU's capabilities.
> Different platform IOMMU can support different elements.
> 
> Currently only two elements, type and aw_bits, type hints the host
> platform IOMMU type, i.e., INTEL vtd, ARM smmu, etc; aw_bits hints
> host IOMMU address width.
> 
> Introduce .check_cap() handler to check if HOST_IOMMU_DEVICE_CAP_XXX
> is supported.
> 
> Introduce a HostIOMMUDevice API host_iommu_device_check_cap() which
> is a wrapper of .check_cap().
> 
> Introduce a HostIOMMUDevice API host_iommu_device_check_cap_common()
> to check common capabalities of different host platform IOMMUs.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/host_iommu_device.h | 44 ++++++++++++++++++++++++++++++
>   backends/host_iommu_device.c       | 29 ++++++++++++++++++++
>   2 files changed, 73 insertions(+)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 2b58a94d62..12b6afb463 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -14,12 +14,27 @@
>   
>   #include "qom/object.h"
>   #include "qapi/error.h"
> +#include "linux/iommufd.h"


Please use instead :

    #include <linux/iommufd.h>


Thanks,

C.


> +
> +/**
> + * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @aw_bits: host IOMMU address width. 0xff if no limitation.
> + */
> +typedef struct HostIOMMUDeviceCaps {
> +    enum iommu_hw_info_type type;
> +    uint8_t aw_bits;
> +} HostIOMMUDeviceCaps;
>   
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
> @@ -47,5 +62,34 @@ struct HostIOMMUDeviceClass {
>        * Returns: true on success, false on failure.
>        */
>       bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +    /**
> +     * @check_cap: check if a host IOMMU device capability is supported.
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
> +    int (*check_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>   };
> +
> +/*
> + * Host IOMMU device capability list.
> + */
> +#define HOST_IOMMU_DEVICE_CAP_IOMMUFD       0
> +#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    1
> +#define HOST_IOMMU_DEVICE_CAP_AW_BITS       2
> +
> +
> +int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp);
> +int host_iommu_device_check_cap_common(HostIOMMUDevice *hiod, int cap,
> +                                       Error **errp);
>   #endif
> diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
> index 41f2fdce20..b97d008cc7 100644
> --- a/backends/host_iommu_device.c
> +++ b/backends/host_iommu_device.c
> @@ -28,3 +28,32 @@ static void host_iommu_device_init(Object *obj)
>   static void host_iommu_device_finalize(Object *obj)
>   {
>   }
> +
> +/* Wrapper of HostIOMMUDeviceClass:check_cap */
> +int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> +{
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc->check_cap) {
> +        error_setg(errp, ".check_cap() not implemented");
> +        return -EINVAL;
> +    }
> +
> +    return hiodc->check_cap(hiod, cap, errp);
> +}
> +
> +/* Implement check on common IOMMU capabilities */
> +int host_iommu_device_check_cap_common(HostIOMMUDevice *hiod, int cap,
> +                                       Error **errp)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    switch (cap) {
> +    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
> +        return caps->type;
> +    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> +        return caps->aw_bits;
> +    default:
> +        error_setg(errp, "Not support query cap %x", cap);
> +        return -EINVAL;
> +    }
> +}


