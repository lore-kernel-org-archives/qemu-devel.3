Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDE9C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThAm-0008Hw-QT; Mon, 23 Jun 2025 09:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThAk-0008Hf-5j
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThAh-000299-Ua
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750685114;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2H72+LzXiHDY72YCe/RzAW6CjXgBkD0G6fZg66ZDc18=;
 b=YCwkgvJDQ1MqCTC4mnZ5XoMMYqwVzWwBvZPYkeUJYLiAday2ugy3GbfTZ06nX/xDB+YBZe
 Qx4rkvtkgCSRARUw41Z2CL7GBvi0BOC65pN0r8Cpu1wtP/XwA3sxbxirXYSTKPqe6UVwgY
 3xtAET5uR34axy+2tuCISXCMzFA5LPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-yboKGd-aPz-Opm7M3JIXYQ-1; Mon, 23 Jun 2025 09:25:12 -0400
X-MC-Unique: yboKGd-aPz-Opm7M3JIXYQ-1
X-Mimecast-MFC-AGG-ID: yboKGd-aPz-Opm7M3JIXYQ_1750685112
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4535d300d2dso33470555e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750685111; x=1751289911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2H72+LzXiHDY72YCe/RzAW6CjXgBkD0G6fZg66ZDc18=;
 b=a15Nwea/okRpGfXqiE4B4qYOtRkMWcmOQ6xZn5DDZtCUE5fgA1lByRu6SCG5PBOkPy
 tziRhJ3LA6/E7vKbC4kutfaSfRK3SHbCob4rT+LQIxQgpPptogU8syhfm4XrthTrm+hZ
 Ef8ABX2g8kLhGJc5I9ajCGF794OvA6xsxne2AIbrxpxQUw9We72rG2SjI0dmE0o5ulTR
 jDod6MULt2V9TWqgfiF7Ew6Nrm+0hmBGuPhlABSevlt2IXikH02/HXmYiCWLFanwCP+0
 FazWmQktUXi7EynLeWoZhrjQlObFjBXIv11ZusNW3Wgix8FwZ400y3wo8qQcV48V0XGt
 qiYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQVMC9u/Pn9c66BK2md41CJoT+myJbswJagNnMbGC737RkuedDBwpLbF7zidV+++1QuCTWJCFKbL5c@nongnu.org
X-Gm-Message-State: AOJu0YyJ51YFPZtam9lDBHvrtZULreFv4jpZDyWWpF+qyq7SRFr18OrQ
 nZAlsDPICOJdbDgmvPIlSlP23kWStnSsP7Jz/9tSKu/2f9LR4iu2x+FnttTXo9JFjyY3ooZqM79
 EbuN/oVZpQiUCq9WAaBdtB/26ivMqj+4u++w3iffHfN3amutWboevLUki
X-Gm-Gg: ASbGncvGv09WuR/cIpxDWG/RCoKpAdCBVVn30zWvGIq65LPoaUgl/ibcLv/cXUrjQfk
 bUqv3NeSjWsLBYSimovIUCS+EKolPyyyt6Rp1uoqv4v5G3a8BblWwL1owWFwMGRuoTlca0mzGLg
 XG88WNn82Ok2VMBea5+63w3/IllkbhX3a1Ae4WzYm5Fl0HhlNIAQN35zgPr8jdHTyQx/Q48lt6y
 RtqJXiqwfkXJ1/D5GolGPO6AoO+C1MhBj2IDcMBnpHqzffHtXfZhTXAY8cWlmKy4IMoZ5kdmvYk
 vBVq9psSumGTsA3zROIb9+BTB/1kcDD9vFAYv+7d/XmhV7/r/J1InnGIhfuLnobj1QDudg==
X-Received: by 2002:a05:600c:5026:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-453654ce274mr128239525e9.14.1750685111402; 
 Mon, 23 Jun 2025 06:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPQHUAXv5+uJoGxPm5jSh9DfhRTM5RlZ7TAIBQeUkHH76pkBBbADKUR5eyiIIFirlAcoDG2w==
X-Received: by 2002:a05:600c:5026:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-453654ce274mr128239025e9.14.1750685110937; 
 Mon, 23 Jun 2025 06:25:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470371csm109532785e9.30.2025.06.23.06.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:25:10 -0700 (PDT)
Message-ID: <b3a4374d-36c9-41ab-b7d6-4678ba9e9fd0@redhat.com>
Date: Mon, 23 Jun 2025 15:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/19] intel_iommu: Replay pasid binds after context
 cache invalidation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-16-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This replays guest pasid attachments after context cache invalidation.
> This is a behavior to ensure safety. Actually, programmer should issue
> pasid cache invalidation with proper granularity after issuing a context
> cache invalidation.
so is it mandated to do the invalidation twice?
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 +
>  hw/i386/intel_iommu.c          | 51 ++++++++++++++++++++++++++++++++--
>  hw/i386/trace-events           |  1 +
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 92a533db54..b3e4aa23f1 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -575,6 +575,7 @@ typedef enum VTDPCInvType {
>      VTD_PASID_CACHE_FORCE_RESET = 0,
>      /* pasid cache invalidation rely on guest PASID entry */
>      VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
> +    VTD_PASID_CACHE_DEVSI,      /* pasid cache device selective invalidation */
>      VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
>      VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
>  } VTDPCInvType;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1c94a0033c..621b07aa02 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -92,6 +92,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info);
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  PCIBus *bus, uint16_t devfn);
>  
>  static void vtd_panic_require_caching_mode(void)
>  {
> @@ -2437,6 +2441,8 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
>  
>  static void vtd_context_global_invalidate(IntelIOMMUState *s)
>  {
> +    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
> +
>      trace_vtd_inv_desc_cc_global();
>      /* Protects context cache */
>      vtd_iommu_lock(s);
> @@ -2454,6 +2460,9 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       * VT-d emulation codes.
>       */
>      vtd_iommu_replay_all(s);
> +
> +    pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
> +    vtd_pasid_cache_sync(s, &pc_info);
>  }
>  
>  #ifdef CONFIG_IOMMUFD
> @@ -2696,6 +2705,21 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
>               * happened.
>               */
>              vtd_address_space_sync(vtd_as);
> +            /*
> +             * Per spec, context flush should also followed with PASID
be followed
> +             * cache and iotlb flush. Regards to a device selective
regarding to?
> +             * context cache invalidation:
> +             * if (emaulted_device)
emulatted
> +             *    invalidate pasid cache and pasid-based iotlb
> +             * else if (assigned_device)
> +             *    check if the device has been bound to any pasid
> +             *    invoke pasid_unbind regards to each bound pasid
> +             * Here, we have vtd_pasid_cache_devsi() to invalidate pasid
> +             * caches, while for piotlb in QEMU, we don't have it yet, so
> +             * no handling. For assigned device, host iommu driver would
> +             * flush piotlb when a pasid unbind is pass down to it.
> +             */
> +             vtd_pasid_cache_devsi(s, vtd_as->bus, devfn);
>          }
>      }
>  }
> @@ -3447,6 +3471,11 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
>          /* Fall through */
>      case VTD_PASID_CACHE_GLOBAL_INV:
>          break;
> +    case VTD_PASID_CACHE_DEVSI:
> +        if (pc_info->bus != vtd_as->bus || pc_info->devfn != vtd_as->devfn) {
> +            return false;
> +        }
> +        break;
>      default:
>          error_report("invalid pc_info->type");
>          abort();
> @@ -3640,6 +3669,11 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      case VTD_PASID_CACHE_GLOBAL_INV:
>          /* loop all assigned devices */
>          break;
> +    case VTD_PASID_CACHE_DEVSI:
> +        walk_info.bus = pc_info->bus;
> +        walk_info.devfn = pc_info->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +        return;
>      case VTD_PASID_CACHE_FORCE_RESET:
>          /* For force reset, no need to go further replay */
>          return;
> @@ -3675,8 +3709,7 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>   * It includes updating the pasid cache in vIOMMU and updating the
>   * pasid bindings per guest's latest pasid entry presence.
>   */
> -static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> -                                 VTDPASIDCacheInfo *pc_info)
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>  {
>      if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
>          return;
> @@ -3737,6 +3770,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
>      vtd_replay_guest_pasid_bindings(s, pc_info);
>  }
>  
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  PCIBus *bus, uint16_t devfn)
> +{
> +    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
> +
> +    trace_vtd_pasid_cache_devsi(devfn);
> +
> +    pc_info.type = VTD_PASID_CACHE_DEVSI;
> +    pc_info.bus = bus;
> +    pc_info.devfn = devfn;
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +}
> +
>  static bool vtd_process_pasid_desc(IntelIOMMUState *s,
>                                     VTDInvDesc *inv_desc)
>  {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 1c31b9a873..830b11f68b 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
>  vtd_pasid_cache_gsi(void) ""
>  vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
> +vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev: 0x%"PRIx16
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
Eric


