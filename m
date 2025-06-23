Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF94C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfm8-0002lJ-I7; Mon, 23 Jun 2025 07:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTfm4-0002kn-66
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTflx-0005eI-W3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750679734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2+BVcScn3BcK7P3HbciYU0Xg+g1eIHrvNYux3XcxRw=;
 b=hG3BHAuelIF5O9lIe9LOOsu/6S3vzpU/vzyKvaoPKzL8HXnNMt00fzJyVb9Ki8Du59/LXm
 qjOcDWU3cSULqcal59fgoXFo6zd0p2Nkj5f5jZcrMvZFYn5HY4SGCg0vLsQOcSea6VHVWc
 8D8NVG72nkYbEGXdz1KmYYyBp2Aj9AM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-4LsRf-kfMVqXM-sNLNxbew-1; Mon, 23 Jun 2025 07:55:28 -0400
X-MC-Unique: 4LsRf-kfMVqXM-sNLNxbew-1
X-Mimecast-MFC-AGG-ID: 4LsRf-kfMVqXM-sNLNxbew_1750679727
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eed325461so24765395e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679727; x=1751284527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y2+BVcScn3BcK7P3HbciYU0Xg+g1eIHrvNYux3XcxRw=;
 b=ZHHkD3erZgcT4hz82CWCkzfl2gYCIb/oyCsmwXEGHnQatLk8fuxHpy/iJDNepNg4Bo
 sVnpwoES/qwYVVU3jgwm0RHjuLe9NWNv7OMkyYWFa0SzvTrB2+it7arN7WlpnVZUpmM6
 GGekCtUFqBqDpbJqwA7UkjJ0w8AMsCx7HfWV7C8dvgLnlHwcjpnBBZApO7yx7IksE+3g
 r1CcRFX3LUG29xdVFD0o0ySr+xv3tNDz199AbswxZjAmLxeUEyzRy8l/nq/oCaAXRA7+
 HJXJPm53ky9RldS1NJ+5IU/NWMwbG1T2/yVuqGLLIv/PSMb/p7YfDWZNVeYcw/eqiVAc
 YIdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGHzGOnOqDP5a9X//TqfKLMfcQsaOK1LwYJbJnYCX8OX0Drs5IaHTnjuOrQeFZJ7DUxxe9PRC7rDsh@nongnu.org
X-Gm-Message-State: AOJu0YzdJPREcswi4x/djnnYIv4ClLoS27B3vkwpPLor1qfSzx/KnZLk
 l/gHz5RdYJTco/zR5hRU595fVafMOE2jFPePPjgO4DEOERkH4R4ocCL/pyR26WLFOMvWiDzj/D1
 hP7xbGI7kG/zxPFmT1lOTNVo80pK84YiX++kRIYs73a/wgTDErmgxnSQw
X-Gm-Gg: ASbGncsDJFr1F2Ho3+gidYTIDJ7INy2hHa5ptf3UPC/eweAnoKW+xnoeCk3WQBtvJrA
 FJlo1FfAUeet3VI1wdlpiT11/sv96URC1eLEIUSCAGMyI/ZkwOhgYuJIVNZUdq1YQ7uy6XKBKa0
 ZZ0NEDqgXi8fGj2f/QCfHOhZ5F3a+HSlgea/eyz1GyOiHy0gph6hsxKkA/OEC3ooq954P+eKy0J
 Iti99KADumGVl06edhkOO3ZHX/KTJv9MBeVYDZZcryW7SMK1kHuthfNkLhxpKm7vxnSQCqRxKhK
 KMlUfsut+ED0130frBEI9zHO7XDzCR7fKuVeWoQOzxDrNLbc8TET0QaC44yurSydAVZCHw==
X-Received: by 2002:a05:6000:230d:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3a6d12e5e11mr8970999f8f.49.1750679726861; 
 Mon, 23 Jun 2025 04:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWTSYeQAVjiD9/mBm6S4+1F8qFbI8rg+Q6aPb9nZSlZ6bJpY6F9BoJO6MT4O1ncC9xbvnm0Q==
X-Received: by 2002:a05:6000:230d:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3a6d12e5e11mr8970987f8f.49.1750679726488; 
 Mon, 23 Jun 2025 04:55:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d868sm9229381f8f.44.2025.06.23.04.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 04:55:25 -0700 (PDT)
Message-ID: <e402a485-66be-44d4-9cc5-aa7157511f76@redhat.com>
Date: Mon, 23 Jun 2025 13:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/19] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
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
 <20250620071813.55571-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-13-zhenzhong.duan@intel.com>
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
> underlying pasid entry is still valid, it drops all the pasid caches.
>
> FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
> only used internally in system level reset.
this comment shall be put in the code, along with the VTDPCInvType
because the reader may look for that cmd in the spec.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  2 ++
>  hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
>  hw/i386/trace-events           |  1 +
>  3 files changed, 31 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 025787b3b9..5ed76864be 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -564,6 +564,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
>  typedef enum VTDPCInvType {
> +    /* Force reset all */
> +    VTD_PASID_CACHE_FORCE_RESET = 0,
>      /* pasid cache invalidation rely on guest PASID entry */
>      VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
>      VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f4273dc640..ed71bb8ec7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -87,6 +87,8 @@ struct vtd_iotlb_key {
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
> +
>  static void vtd_panic_require_caching_mode(void)
>  {
>      error_report("We need to set caching-mode=on for intel-iommu to enable "
> @@ -391,6 +393,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>      vtd_iommu_lock(s);
>      vtd_reset_iotlb_locked(s);
>      vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset_locked(s);
>      vtd_iommu_unlock(s);
>  }
>  
> @@ -3196,6 +3199,8 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
>      }
>  
>      switch (pc_info->type) {
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        goto remove;
>      case VTD_PASID_CACHE_PASIDSI:
>          if (pc_info->pasid != pasid) {
>              return false;
> @@ -3251,6 +3256,26 @@ remove:
>      return true;
>  }
>  
> +/* Caller of this function should hold iommu_lock */
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info = {};
> +
> +    trace_vtd_pasid_cache_reset();
> +
> +    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
> +
> +    /*
> +     * Reset pasid cache is a big hammer, so use g_hash_table_foreach_remove
> +     * which will free the vtd_as instances. Also, as a big hammer, use
> +     * VTD_PASID_CACHE_FORCE_RESET to ensure all the vtd_as instances are
> +     * dropped, meanwhile the change will be passed to host if
> +     * HostIOMMUDeviceIOMMUFD is available.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces,
> +                                vtd_flush_pasid, &pc_info);
> +}
> +
>  static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
>                                          dma_addr_t pt_base,
>                                          int start,
> @@ -3377,6 +3402,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>      case VTD_PASID_CACHE_GLOBAL_INV:
>          /* loop all assigned devices */
>          break;
> +    case VTD_PASID_CACHE_FORCE_RESET:
> +        /* For force reset, no need to go further replay */
> +        return;
>      default:
>          error_report("invalid pc_info->type for replay");
>          abort();
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ae5bbfcdc0..c8a936eb46 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_reset(void) ""
>  vtd_pasid_cache_gsi(void) ""
>  vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
Eric


