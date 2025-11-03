Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6974CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFu7x-00039D-72; Mon, 03 Nov 2025 07:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFu7t-00035v-EP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFu7m-0004cW-AP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762174637;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWPqOT9v6PZGzQhxEB3pVdX5Adys5VF6N2rn65Sn1NM=;
 b=fJIUafW1gF0JRGvbJvEsX2w/oC4nK39p6h2Ewwi4AjAFKUTEqS3n1PaGOqsvXdbM03vrGX
 Q91opsmZmLLFD9IUO2KI0ju1XNTuR9HG5ixX+X332znS7CP/m1yGOb/ptyT5jIa3j95US0
 hyhPzzGvpPtTeiDK5FrKsFWPRL2OrHs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-yTZN6NjoPkS6ttinoXtuew-1; Mon, 03 Nov 2025 07:57:16 -0500
X-MC-Unique: yTZN6NjoPkS6ttinoXtuew-1
X-Mimecast-MFC-AGG-ID: yTZN6NjoPkS6ttinoXtuew_1762174635
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477212937eeso31196405e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 04:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762174635; x=1762779435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWPqOT9v6PZGzQhxEB3pVdX5Adys5VF6N2rn65Sn1NM=;
 b=hmtsdnWQ/V3ERBzSj2xKaXLx3Hx9giUjYqKLVd3pFlHuCMENMF+XJAeHKTX1xH2BvN
 fLlCrxTW2iPS8Lri0CfqIv6+hDikeSXb8RrydPkBvHJdzRAyebAnhR4huhUhQ6eC/1T5
 /C1zcCDbF/xQwwD2ge6OKWNSzuEFh20Sv4biwsERFfl8h84JFjz7u8QGQN0t4cru0aF6
 DpWZOPYqg/vQWGZReyChub1QXKwWhZ+DBsvXLGS5eoJ8wh6KjtwRq/smp6/UIYk9U6Cl
 EIkcJd7BPEvIgRkHfsIDgqsBXY2JhyooCiy/gpby+YSi027GqIUrpOYBzvCD8EC5gxnE
 FFIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6mazqJ06/V3Vf/rxtHB4ICsU5PsQd1xCoBmnFz03hbTLvuFSh8fNkHz+RAL6KXgdMPq8gL/yIzc/1@nongnu.org
X-Gm-Message-State: AOJu0YwmO+4ntT1lUYlnJe8fc6NnTIxUR+a7bmKSWqPAGZSJDD8mNfak
 M5X1CBXnl4cERSn0LFtQ35n0Qy2BeMe3ObxqfYAHm/L2cVcaCJRO600G0GK7jEByHThyFFsDP1F
 6db2SYW3P4BMi4u/zoMTAdmmvU5X2VflNmcufNyPqeR1MYq75demppgMa
X-Gm-Gg: ASbGnctM1jtjE0ZFKwrML6OlO9diISqHIOnVvVrhW1HsZKVGazLbUbZXW8Fzx/bXtZJ
 1CeSErYX8/ZF/Q1/5T4WX2WXHamwb1IVIkTLXjzouP/NvmRyFOTg5ROIf3BbE2oqRnRgjfcrF8d
 TLycRUv4TcFGZULSTefpg3HrhgEetmO7ZURvScpjknNDRyz8YwxEYFfyRgTBotglR/kR7MiPHQM
 DhGjH2LK7kB1NBI0D0MpoDeeaub7WfZITbXPIFTaLJBail6XM6ZM0wgwZb5fWnzyt2Taz/LuoFW
 K74na6JMTlFNmc5O2UeQMvKm2+TvXZOUj2OvFI+jevXtQpSewm85rS9ycepdP/mXcdmnXp6pNU1
 slyykShjNpHudp9Ci8w/bmJtE0QU+CbYYn6ALdqc7OI6Uig==
X-Received: by 2002:a05:600c:4591:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-4773087b19bmr101731815e9.26.1762174634785; 
 Mon, 03 Nov 2025 04:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEthRh8uzto4fy6BjMWPdHf4yapNiB8hIsZz3H99RBD6ZMkfxFGHb6vIP9Wqw0EqTovInwI2g==
X-Received: by 2002:a05:600c:4591:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-4773087b19bmr101731545e9.26.1762174634362; 
 Mon, 03 Nov 2025 04:57:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429d2952653sm7061388f8f.8.2025.11.03.04.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 04:57:13 -0800 (PST)
Message-ID: <f2814881-370e-46ea-bd28-2d3993db5be1@redhat.com>
Date: Mon, 3 Nov 2025 13:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-18-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-18-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> In VFIO core, we call iommufd_backend_get_device_info() to return vendor
> specific hardware information data, but it's not good to extract this raw
> data in VFIO core.
>
> Introduce host_iommu_extract_quirks() to help extracting the raw data and
> return a bitmap in iommufd.c because it's the place defining
> iommufd_backend_get_device_info().
>
> The other choice is to put vendor data extracting code in vendor vIOMMU
> emulation file, but that will make those files mixed with vIOMMU
> emulation and host IOMMU extracting code, also need a new callback in
> PCIIOMMUOps. So we choose a simpler way as above.
up to now iommufd.c was arch independent. And on the other hand you
started to put iommufd specific info in intel_iommu.c so I am wondering
whether this is the good place to put this helper. Again, maybe consider
consider creating  an intel_iommu_accel.c or something alike

Eric
>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/hw/iommu.h                 |  5 +++++
>  include/system/host_iommu_device.h | 15 +++++++++++++++
>  backends/iommufd.c                 | 13 +++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> index 9b8bb94fc2..6d61410703 100644
> --- a/include/hw/iommu.h
> +++ b/include/hw/iommu.h
> @@ -22,4 +22,9 @@ enum viommu_flags {
>      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>  };
>  
> +/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> +enum host_iommu_quirks {
> +    HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
> +};
> +
>  #endif /* HW_IOMMU_H */
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82..9ae7f4cc6d 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -39,6 +39,21 @@ typedef struct HostIOMMUDeviceCaps {
>      uint64_t hw_caps;
>      VendorCaps vendor_caps;
>  } HostIOMMUDeviceCaps;
> +
> +/**
> + * host_iommu_extract_quirk: Extract host IOMMU quirks
> + *
> + * This function converts @type specific hardware information data
> + * into a standard bitmap format.
> + *
> + * @type: IOMMU Hardware Info Types
> + *
> + * @VendorCaps: IOMMU @type specific hardware information data
> + *
> + * Returns: bitmap with each representing a host IOMMU quirk defined in
s/each/each bit
> + * enum host_iommu_quirks
> + */
> +uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps);
>  #endif
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 086bd67aea..61b991ec53 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -19,6 +19,7 @@
>  #include "migration/cpr.h"
>  #include "monitor/monitor.h"
>  #include "trace.h"
> +#include "hw/iommu.h"
>  #include "hw/vfio/vfio-device.h"
>  #include <sys/ioctl.h>
>  #include <linux/iommufd.h>
> @@ -411,6 +412,18 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>      return true;
>  }
>  
> +uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps)
> +{
> +    uint64_t quirks = 0;
> +
> +    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
> +        caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
> +        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
> +    }
> +
> +    return quirks;
> +}
> +
>  bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                        uint32_t data_type, uint32_t entry_len,
>                                        uint32_t *entry_num, void *data,


