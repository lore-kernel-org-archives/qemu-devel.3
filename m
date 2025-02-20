Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F543C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 19:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBnd-00089V-1x; Thu, 20 Feb 2025 14:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBnZ-000890-4e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBnX-0007zE-Hy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740078080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umpQJP5yN7o8XogxZyufoWT2e0kf3fthQTEJ8kUyg5k=;
 b=gZhV8K6XeV9XLXtpLLCxDgwgp12d2cTXKuT9nGF68pTTMwH1nWHx5YNP457S6SgSdlh7kI
 McoWoMtz33crPvx1gHWuZkyg1Rh5a7hf2BbR4NeMottRrCbnhxryMfarkXYpQl3/d5vymI
 XLNJR0jMuJEI5mcilrNldTn8jucva5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-sZft6mmvPeCcf8uSrlqRAA-1; Thu, 20 Feb 2025 14:01:06 -0500
X-MC-Unique: sZft6mmvPeCcf8uSrlqRAA-1
X-Mimecast-MFC-AGG-ID: sZft6mmvPeCcf8uSrlqRAA_1740078065
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so6489085e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 11:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740078065; x=1740682865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=umpQJP5yN7o8XogxZyufoWT2e0kf3fthQTEJ8kUyg5k=;
 b=WBYV+mP37uT0JYiTyStsulrq+d08LKBvUDP/jkMdNOSHA70afQQ2e7LWlkNF3uDkxK
 Xdu1dH1/ySYolYiKaVhdeV7Ts140g0PWgaxHfNB5chG7bOLuHkVp//957lfUP1IztzNC
 i40P2INyggGylJnkxdrLCE1zSLjAU13lzIUIBmU0Njlw2uxwYT2KV/Wkid6ZLsdiZaQX
 E4Rr9aGybL+hNsy7mBWeS7GSKZdzidOFo6NGQ7A0pDN09w8Uy/n2l09qOnu1BcDxm48P
 kkHCQwFdI/+Vm8zatFymvoi9YkSPNEHbG01ttea0yUztK40UsVCEcm+UBcqHjXIpe9z1
 83tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqAnDfCCmnxlEWSq1F1gXNHH/C0X7pK0Ew9oH8zjOynT7K6E2tCUHSOyHyqfsaOez6y9ILUpLrOCxC@nongnu.org
X-Gm-Message-State: AOJu0YydxnaOVe4TBXdsyNY80rc9+KibhrfBAxqEvXZ+Ttc2mT92LbR3
 vvcZOtzhOi2VfUitRSool4AohrzY5LTfABg933A0UJc+cOkt3XXNTUIeV+L0KpNSI2hmua9f+JW
 aL1t82qtcJR/u8w9GdGlKGUNDcCN02yZ+SUd9BiUXLdYJQj3BdEpt
X-Gm-Gg: ASbGnctl+eFQeV3P17wud0v9oG6YqO58F+EBrhrO7vRBe04OWhxeAaVYigtw6T/8wb/
 RfAyFFXdoPS6jQdu0gSDrD3SMBVEgNcskFoDMdwS07tqhetGN+o0jn2p/3KdiMIZjEoDYrxPWEu
 T5g05wWnxhW6G3JnB6docxkmHGRg1asUhPvKJaKs2rn+dIQ2WBiZvTC8EC183PHEWB7iFA9Gg2t
 Y1VmfzIkZzA7qzMKReWvfipGdDT1T4jfPTpsUi98XFyZuN9gsz6f2ZHQRA9YHi/fw6JMcouYgBn
 LE0bnWbXEfwSlwqUN7faMLdomzeEzrYBf8LWey59dAMtcgb6OZzv
X-Received: by 2002:a05:600c:4f4a:b0:439:98ca:e39e with SMTP id
 5b1f17b1804b1-439ae2160bfmr2730145e9.24.1740078064855; 
 Thu, 20 Feb 2025 11:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrTihrRPFdXxPjfcxBLb60w5SyXis7YsW6ZZrwIVcC4TmTQeg/V79a+cc2B3Wg3EZCr6O4dg==
X-Received: by 2002:a05:600c:4f4a:b0:439:98ca:e39e with SMTP id
 5b1f17b1804b1-439ae2160bfmr2729695e9.24.1740078064406; 
 Thu, 20 Feb 2025 11:01:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a64febasm109975265e9.1.2025.02.20.11.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 11:01:03 -0800 (PST)
Message-ID: <c37e7e15-89a8-4996-9aad-10417a032f14@redhat.com>
Date: Thu, 20 Feb 2025 20:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 07/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP] for IOMMUFD
> backed host IOMMU device.
>
> Query on these two capabilities is not supported for legacy backend
> because there is no plan to support nesting with leacy backend backed
> host device.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  backends/iommufd.c             |  4 ++++
>  hw/vfio/iommufd.c              | 11 +++++++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index e8b211e8b0..2cda744786 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -191,6 +191,7 @@
>  #define VTD_ECAP_PT                 (1ULL << 6)
>  #define VTD_ECAP_SC                 (1ULL << 7)
>  #define VTD_ECAP_MHMV               (15ULL << 20)
> +#define VTD_ECAP_NEST               (1ULL << 26)
>  #define VTD_ECAP_SRS                (1ULL << 31)
>  #define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 574f330c27..0a1a40cbba 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -370,6 +370,10 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>          return caps->type;
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>          return vfio_device_get_aw_bits(hiod->agent);
> +    case HOST_IOMMU_DEVICE_CAP_NESTING:
> +        return caps->nesting;
> +    case HOST_IOMMU_DEVICE_CAP_FS1GP:
> +        return caps->fs1gp;
this is vtd specific so those caps shouldn't be return for other iommus, no?

Eric
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 175c4fe1f4..df6a12d200 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -26,6 +26,7 @@
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
>  #include "exec/ram_addr.h"
> +#include "hw/i386/intel_iommu_internal.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> @@ -843,6 +844,16 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      caps->type = type;
>      caps->hw_caps = hw_caps;
>  
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        caps->nesting = !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
> +        caps->fs1gp = !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
> +        break;
> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
> +    case IOMMU_HW_INFO_TYPE_NONE:
> +        break;
> +    }
> +
>      return true;
>  }
>  


