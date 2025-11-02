Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE14CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFW40-0001lw-Qy; Sun, 02 Nov 2025 06:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFW3z-0001lm-1H
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFW3v-0006tI-VA
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762082150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/JCyuLMpFVaUEw/jK3dWUPqojQiuXcpRWgCSXY+MUk=;
 b=eWZeHZ2rXsAv3J3f2RCsJtA3im1s+gxJrKfQyAQZARxoCqp/RWfupuz2YGxFVKQ8ZELSgR
 BMCPAD7ci/rFjyik074cOB0F7ylapOoOpiaR91saBzChsz7see2UhEguWq/PZ6uwYIzs4b
 IUKgDIkMGvwW4ElpfdmuKRXtvD4KFk8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-VQGL13eEM5OV8K0WXM84Hw-1; Sun, 02 Nov 2025 06:15:38 -0500
X-MC-Unique: VQGL13eEM5OV8K0WXM84Hw-1
X-Mimecast-MFC-AGG-ID: VQGL13eEM5OV8K0WXM84Hw_1762082138
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c5da68e5so1047068f8f.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762082138; x=1762686938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/JCyuLMpFVaUEw/jK3dWUPqojQiuXcpRWgCSXY+MUk=;
 b=XjsFxQGN+C4DfmC4E0UbqD2PvS0pMWpNippqlIDq58Bj1IQUGi7pNgGeLhIHFVTNWJ
 HdvxEAZdz8qn8sZZsLc33nqzoUYGkunWz4tNSNHmvAnTZpknB65p3k9Eg9G7Ys8hCebu
 z/zldSd2j4x+HlcDWgBb3iKihdz3HF6RoPp2ncmHJgD8+kAHVXp77afjG+/kS6yaBZOQ
 vMnU3ZTP6NgWENIILgE8Lh+IPKRJdghHIuFKJPTU1JD+tW5rIb4aOb7viNLvSjheMZfV
 /nInGinz3/0RtM96zzOTfUxpPFXmR6S1infKzwxvofqMbpG5njFQMnhpaCjFAiWgocIh
 m2oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr7n5gcSH1ZsBIUIR5nnYEyomhpykRDVgAaCLAe4mViCt1qaKP6UeoN0hSh6Ysn4SYaVNcSDxyCyIj@nongnu.org
X-Gm-Message-State: AOJu0Yy1nCaT6B/gSYxfYMniwtHi/4C4TGUbZLjBQ67WtMw1zSbwLPyJ
 Q0tjkh2cZZHZyXg65VuTgJusSXyyP7N7fZTlGparBLhbxmNpdZGoWog2I+a8Vr6OhwJE44/V2NL
 3Si5aSqfQAtykPJe0mxiFMY1r31cAY3+lpVBER5Q5WuTiH8bDy2V4Xksx
X-Gm-Gg: ASbGncv1ZX6RweoQFDOXkRyV774lXmavnfiWIGP+gjvIcedoGbSqLwX/QK3pDcTn1m6
 Uc1ydUUk/vPCCsoH6Mdy6ocH13hT2usEwvnrc5dFXIWhPmf9sRnWJTz4avkf+ui47O0HKQq93Ah
 qxBJSMbLxlH7ZxcfErGioY1qDLhYVpzHJLNqgtCgrTrsFC5J3b7OfqF+Egm/wHEazQN/9aMuGCf
 oMHWS4PHzP84vwUZTelRrilMM64zW3NvcWH4hFlVLxt/wHpK6t1S/IkXCmBStNXHs1RH2wcSk0v
 D1PUsW9i7dMyx1b33XG36wrp60P/eZdTs/pvbvRwsYpZTwRg8zmZhbsL1UpIMdxmoujptaXU/G4
 1FkT5U0vB1IeefDw6+FmOvyPwBJDTpLYlkxA+r7CIRI+64Q==
X-Received: by 2002:a05:6000:4210:b0:429:c15f:806d with SMTP id
 ffacd0b85a97d-429c15f85bbmr7445596f8f.16.1762082137596; 
 Sun, 02 Nov 2025 03:15:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeteaI/X3Jz+WW/jeqEj8ACMuRlDJSDJrbw8+be2OeaYFGYiGPEcR9CXIkL75fld81Evo6EQ==
X-Received: by 2002:a05:6000:4210:b0:429:c15f:806d with SMTP id
 ffacd0b85a97d-429c15f85bbmr7445564f8f.16.1762082137140; 
 Sun, 02 Nov 2025 03:15:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm13728117f8f.47.2025.11.02.03.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 03:15:36 -0800 (PST)
Message-ID: <1c750d64-efd9-4942-af00-a36267715837@redhat.com>
Date: Sun, 2 Nov 2025 12:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> Add some macros and inline functions that will be used by following
> patch.
>
> This patch also make a cleanup to change macro VTD_SM_PASID_ENTRY_DID
> and VTD_SM_PASID_ENTRY_FSPM to use extract64() just like what smmu does,
> because they are either used in following patches or used indirectly by
> new introduced inline functions. But we doesn't aim to change the huge
> amount of bit mask style macro definitions in this patch, that should be
> in a separate patch.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  8 +++++--
>  hw/i386/intel_iommu.c          | 38 +++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 09edba81e2..df80af839d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -642,10 +642,14 @@ typedef struct VTDPASIDCacheInfo {
>  #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>  
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>  
> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
>  #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
the above comment is not that useful along with bitmask definition. I
would rather move it along with VTD_PE_GET_FS_LEVEL(pe)
> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
I would get rid of _BIT suffix to make it consistent with other fields.
>  
>  /* First Stage Paging Structure */
>  /* Masks for First Stage Paging Entry */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 56abbb991d..871e6aad19 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -52,8 +52,7 @@
>  
>  /* pe operations */
>  #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FS_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>  #define VTD_PE_GET_SS_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>  
> @@ -837,6 +836,31 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>      }
>  }
>  
> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;

also introduce a define for FSPPTR using extract64((x)->val[2]

> +}
> +
> +/*
> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                                 57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
can you add a comment refering to the spec here?
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -1625,7 +1649,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>  
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>      }
>  
>      return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -1707,7 +1731,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>               */
>              return false;
>          }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
>      }
>  
>      return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> @@ -3146,9 +3170,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>          /* Fall through */
>      case VTD_INV_DESC_PASIDC_G_DSI:
>          if (pc_entry->valid) {
> -            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>          } else {
> -            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pe);
>          }
>          if (pc_info->did != did) {
>              return;
> @@ -5267,7 +5291,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>          return -EINVAL;
>      }
>      pgtt = VTD_PE_GET_TYPE(&pe);
> -    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
>      ret = 0;
>      switch (pgtt) {
>      case VTD_SM_PASID_ENTRY_FST:
Otherwise looks good to me

Thanks

Eric


