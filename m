Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKaA-0008MG-ML; Fri, 24 Oct 2025 12:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKa7-0008M2-Kx
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCKa4-0001Rz-SV
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761323033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bEieLM2wRe2acHyhEyrwtVa5DnM7infQQONZi6bJBys=;
 b=dmViFvGLvbNCcpKMkorQEdOlqaB1+74nwwLCzRfCisR/9zJnOX4SCqL7u9gOlf/JXUt4WE
 F0UBbG1soSRxL1ci6Cn3K6j5V9TTyhMW6S+DUad4esstGavwGBASn2uNTGFlqnc72pvIup
 YTVfk40cx9sKNhoOtjsbrJ/4yRxkcFQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-OLyalvYtMOWiAOZm-DXUkQ-1; Fri, 24 Oct 2025 12:23:50 -0400
X-MC-Unique: OLyalvYtMOWiAOZm-DXUkQ-1
X-Mimecast-MFC-AGG-ID: OLyalvYtMOWiAOZm-DXUkQ_1761323029
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47107fcb257so15606375e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323029; x=1761927829;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bEieLM2wRe2acHyhEyrwtVa5DnM7infQQONZi6bJBys=;
 b=CDqroxHA87+/NoNLx4tlMncmaSyMABNfe3mz/NgU7HB/oPK/uwc1cgBerKiKeBwFC1
 99TKWTfFPxqwJ6Xc9OyJq+adzvbcRO+3oo+t00IDtSI1CEaPyAktm+F5qMoxg/LcjZNu
 njkZaSWb5h71xQB4XxH91PyMNdUiKCd+lweZGtbMJKHLHDre5sSu1hHRhisepCjGyDCa
 jOPVnAkHYN+iMAXMx9DWveGWdwmDnhaGC6CY6VyCE+YZOtsV+W0IRzhKm5/a2heopKDk
 CqxbSL67bU2s40wTmGHzBIXbvm3Asyt/dMuZmIGuSiFDh40pbnvO3Lf3RcHD4JGjnT3Z
 uMrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKeDdJtgH0efdhFgQdO/KmswL+fxG3fbFrCK0w0CzOX7h/3J5MDShgXbEIPTuvAhjMRlADwW6RqLv@nongnu.org
X-Gm-Message-State: AOJu0YwZTQkWYuS29RPdWOdDbSxiT/PdhHqeqUuQ+TVyvpSO3TaVJdO/
 6CkyguP7DXPBraYANavx/hfdcjApaxnaaP5k+M+7WDUxmjFxXoOqMPUm5B7LKeM49VD8R+nlZWV
 fFw905NcJZZDveSJ521sXNpfFOydY0QQJO/E1/J+liXrHYkrHO/ajlLbL
X-Gm-Gg: ASbGnctqcn/2P0uQHvewf2b84Srh3DVYxLa38OsPPa2qoqUpU0XgT7DKp7Nqpc+uk/I
 D8ZhIrv6OKOHwN7S8RWbBoHluXK+IjrMpqOiQSEqDB7OHPwpOr7sFX56QO1/N6a7Pv2daKwI2B/
 EdqpVIFV7Y98ilWUGiDlS7ZtiAL0iaNZfY4MijhnrE7PXTSju4uW3Dm8iYLsyOHhkKCNFU40kXx
 ThckZcUHg9AjGn/4nTYFl/inVHFIwaMbjkV7ytuhhSvRh9obLG3tWuwBLc0BGGyC1Foj2R7hjlS
 85bx13rhuIrFFl7/Y8haTo7cnTbwwNAN6e8vfNuzaN+36WweQAH0/n0Hli7NOmFm2/f3hXU3
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id
 5b1f17b1804b1-4711791dc89mr212200335e9.41.1761323029252; 
 Fri, 24 Oct 2025 09:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpj1z58FQj+R3Pp3wBhXckigh/Tt60paUCmqjWTFmHlQ4ak+kt4l1EtWUGhFBezJBr4fjIkw==
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id
 5b1f17b1804b1-4711791dc89mr212200135e9.41.1761323028838; 
 Fri, 24 Oct 2025 09:23:48 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496cf3b45sm86518345e9.7.2025.10.24.09.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 09:23:47 -0700 (PDT)
Message-ID: <00cf41c9-3683-42de-84ce-fce2ca5babfb@redhat.com>
Date: Fri, 24 Oct 2025 18:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/23] vfio/iommufd: Force creating nesting parent HWPT
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-9-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_flags() to get if vIOMMU supports
> VIOMMU_FLAG_WANT_NESTING_PARENT.
> 
> If yes, create a nesting parent HWPT and add it to the container's hwpt_list,
> letting this parent HWPT cover the entire second stage mappings (GPA=>HPA).
> 
> This allows a VFIO passthrough device to directly attach to this default HWPT
> and then to use the system address space and its listener.
> 
> Introduce a vfio_device_get_viommu_flags_want_nesting() helper to facilitate
> this implementation.
> 
> It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
> call, if something else related to the VFIO device or vIOMMU isn't compatible.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  2 ++
>   hw/vfio/device.c              | 12 ++++++++++++
>   hw/vfio/iommufd.c             |  9 +++++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index a0b8fc2eb6..48d00c7bc4 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -267,6 +267,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev);
>   
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +
>   int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_region_info **info);
>   int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 5ed3103e72..be94947623 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -23,6 +23,7 @@
>   
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
> +#include "hw/iommu.h"
>   #include "hw/hw.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> @@ -521,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       vbasedev->bcontainer = NULL;
>   }
>   
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(&vdev->parent_obj) &

Using PCI_DEVICE(vdev) would be more appropriate. It can come later.

Thanks,

C.



> +                  VIOMMU_FLAG_WANT_NESTING_PARENT);
> +    }
> +    return false;
> +}
> +
>   /*
>    * Traditional ioctl() based io
>    */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8de765c769..f9d0926274 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -404,6 +404,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>       }
>   
> +    /*
> +     * If vIOMMU requests VFIO's cooperation to create nesting parent HWPT,
> +     * force to create it so that it could be reused by vIOMMU to create
> +     * nested HWPT.
> +     */
> +    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +    }
> +
>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;


