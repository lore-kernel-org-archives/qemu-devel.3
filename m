Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D776EC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jzB-0004NL-Lv; Tue, 30 Apr 2024 05:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jz9-0004LO-Ez
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jz5-0005qv-3i
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSXs9HmHDRtiS8JnCSht0QSlfU9qaWhyWI7WPDLQjos=;
 b=GbxbOLt+UkuNWOWIHVI6ALqBxQ0C4ybnt5jq03zZWVBfmQsjqCmXWdy74U+Ro0RO8zvJVZ
 w5xvyEMCU4gD2933KK1KETsKF6Juf3o2WuLnykRzhIzPEPQe+YufsborG8fg2xsJD45N4n
 iMo6C3LB5KFGjTk0wEFj5QCTYOFgV+A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-xDhMRyatNQupOpsYsolxRQ-1; Tue, 30 Apr 2024 05:41:08 -0400
X-MC-Unique: xDhMRyatNQupOpsYsolxRQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572a0c5ece9so109752a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470067; x=1715074867;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSXs9HmHDRtiS8JnCSht0QSlfU9qaWhyWI7WPDLQjos=;
 b=s6dRMe5mgEoNbCK1T75CXmOmFYSIWpX2MmkIKuDoBxG7p6RLX4446GM2Q+nBszDXhM
 VlcpRFn7Ot6PvXvX45md3Y6jhffU5gV7WaDNKUKUqbuJesFH5/Tiy4bs9ldeh7IZ6Eji
 6m++9ABsQ6MfCr+duTLAKUNiabb+e3cK+7VFaolAQyIYVtJkjXSOYn5xK6oHURHVzWdO
 dhJN6vijXOxd7RKtzVhWqrhUV0HIkN5qbH7MFsYbFB1qQZcgX4B07heAhl1lcXtOPyLA
 Oky1MxUcJfd+COuSGizzkj4wFpGswnUPZ2HB83LpbxR1Uz92bSW9gK5xGc5pBjDdvu/j
 PimQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2aDI6oCnkaUXPYL5oLszhgqsROhvT9XxTTLwrHuaUObfw3zVJHUHEZvMZaE+Qe1vIf8SFoeROdekwRCUmaKv7lal4cFA=
X-Gm-Message-State: AOJu0Yw5Fq0BWcMoAxPhRGIBHYMI5Rytufi2FsqsrL37EzjClCOwj7C4
 SFNaGm0+rTfftJdxhGNMp9m1aZUAOcLRm2iE3OlyH2pG1j/cztb4/3zb/ped3AGmdCfNoPZPNHO
 W6FrufDLECsfmd2xA7njf3/nRjTQZLMARBlzfP+EJJxkz9FEe50kE
X-Received: by 2002:a50:c34f:0:b0:56e:42e0:e53c with SMTP id
 q15-20020a50c34f000000b0056e42e0e53cmr6942791edb.34.1714470067177; 
 Tue, 30 Apr 2024 02:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhHmVK2kauYAUDy0sWt4SY7PE9qA38Qe+PgyD0n7Pkhi9YDrgidAPs14zzCFlvUYewjWkSaw==
X-Received: by 2002:a50:c34f:0:b0:56e:42e0:e53c with SMTP id
 q15-20020a50c34f000000b0056e42e0e53cmr6942772edb.34.1714470066760; 
 Tue, 30 Apr 2024 02:41:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a0564020e0900b005729337f955sm838975edh.97.2024.04.30.02.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:06 -0700 (PDT)
Message-ID: <1495f7b1-d3f3-4bd9-93de-34767cfa5b26@redhat.com>
Date: Tue, 30 Apr 2024 11:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
In-Reply-To: <20240429065046.3688701-6-zhenzhong.duan@intel.com>
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

Since we have an 'Error **errp', we could return a bool instead,
unless this is a 'get_cap' routine ?

Thanks,

C.


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


