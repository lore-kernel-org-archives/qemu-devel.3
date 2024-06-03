Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72775C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5uW-0000ap-Vm; Mon, 03 Jun 2024 07:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5uG-0000YY-KI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5u2-0001bl-Rm
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717414260;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALnXEDHSBz84fipAFkbNolUOY3wKa5jLw8M+eReov04=;
 b=Shm0TT0kssd+1euZbxD7Xn/r2IexZxexOO5qb0xNfYXGxuHOg2JDkdwY/r0UB5VL1ZhZWb
 5URM6t26IArHe661tLqcbKd7Pr9rNeUkHLjHbBQqMaEzqq5Z08dpaIs65nCDCF4dPx2CjP
 5o9hQkoMEWTWM2vDXx3tTiMnzhdEYAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Xj5eiPYLPCK-9zwQAPOTtQ-1; Mon, 03 Jun 2024 07:30:58 -0400
X-MC-Unique: Xj5eiPYLPCK-9zwQAPOTtQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42117a61bccso31322175e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414257; x=1718019057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALnXEDHSBz84fipAFkbNolUOY3wKa5jLw8M+eReov04=;
 b=vYXcBkZuTMynpg8CtSodNTJQCZlbMQWoVr5FtUYgqYYNcZpM/rEFNTCdZrizF8CnCa
 DpfE5BpKQ/uFZ0rsX1E5MlkxM1zxyX0P6iuoy6iuMP1BrJ/Ht2VhNJNsC7jgCoSkCLOK
 LykjEcL6vLB4qWiC/+tubYcDa14PPiB21S5XFwZahy0O1u2Dmj1GNjhyBGDj9+jw6oqG
 xDRzIU+zRUIw9negsUa7oxhxoVfZzDpV9RHI/SpNRLkB0sRzonuoWUKNoAn3aRcrHpF0
 9SGeZV3RS7Xi1U9AcK3jdP0YDQqKkz1AdL+39Y3ImKHg7CtAduII6Fh8FCVDT6fWrFmu
 L4JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe6o/HcwlUgp9Ti1R11dAxyQJ8fNc8J2C6pjKCaGc7hIV+dkdjuRVfbOdn3UOwL4lfy2au2rh7sc3LT5iSUo9WV8e1O70=
X-Gm-Message-State: AOJu0YyHSklpVMrI+rK6SATGbdHLbBEhbfvWR7MXFTeDGWRG9zWdQJHr
 BtiOPQFCmsGDwDB4MZ0IJuoKZwMw2y+YTueJfkUjHn0zoljdz/JFlbpZYhSAuqVtNsNdoz44Z7O
 A598xH22E7czxdNrUo9W1z+r5MR/Tp/B3m3OmERXwWzUJYlO9gUhc
X-Received: by 2002:a05:600c:3c91:b0:418:f760:abfb with SMTP id
 5b1f17b1804b1-4212e0461cemr68573865e9.5.1717414257450; 
 Mon, 03 Jun 2024 04:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfrY0KpMeZ1WQyUoFx5IAcxhohjxvvPGR+H6q4sQcYT1dDMJXnuQlPOh9sYeToBDBBJvItLA==
X-Received: by 2002:a05:600c:3c91:b0:418:f760:abfb with SMTP id
 5b1f17b1804b1-4212e0461cemr68573635e9.5.1717414257097; 
 Mon, 03 Jun 2024 04:30:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212709d362sm145870755e9.33.2024.06.03.04.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:30:56 -0700 (PDT)
Message-ID: <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
Date: Mon, 3 Jun 2024 13:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/3/24 08:10, Zhenzhong Duan wrote:
> It calls iommufd_backend_get_device_info() to get host IOMMU
> related information and translate it into HostIOMMUDeviceCaps
> for query with .get_cap().
>
> Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
> (aw_bits - 1).
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |  1 +
>  hw/vfio/iommufd.c             | 37 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..7d694b0813 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
>  #define VTD_HOST_AW_48BIT           48
>  #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
> +#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
>  
>  #define DMAR_REPORT_F_INTR          (1)
>  
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e4a507d55c..9d2e95e20e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> +#include "hw/i386/intel_iommu_internal.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> @@ -619,6 +620,41 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>  };
>  
> +static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> +                                      Error **errp)
> +{
> +    VFIODevice *vdev = opaque;
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    enum iommu_hw_info_type type;
> +    union {
> +        struct iommu_hw_info_vtd vtd;
> +    } data;
> +
> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> +                                         &type, &data, sizeof(data), errp)) {
> +        return false;
> +    }
> +
> +    caps->type = type;
> +
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
Please can you remind me of why you can't reuse the iova_ranges method.
isn't it generic enough?
> +        break;
> +    case IOMMU_HW_INFO_TYPE_NONE:
so what about other types?

Eric
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hiodc->realize = hiod_iommufd_vfio_realize;
> +};
> +
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
> @@ -627,6 +663,7 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>          .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
> +        .class_init = hiod_iommufd_vfio_class_init,
>      }
>  };
>  


