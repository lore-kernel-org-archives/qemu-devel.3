Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3520D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 15:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSAF-0007iP-9X; Tue, 02 Dec 2025 10:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQSAE-0007i3-BC
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 10:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQSAB-0007x2-UL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 10:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764688774;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j500ZfWAcLcqWOvQJChvD4/q+ql06LYNDxDqWJYiYGI=;
 b=jWnsfBoe+8adu8Fbuy+COu/YTrmOtMzIxaWXXLz/6KxFv3XZbNygsPWcqaQhkYynrew7EB
 rCjlISEUNRL5tVJwf8YAZjog0cJ36salP80L+shhcmdlrAWn4nRDmgk8i8hIcwL7uoVHbT
 XAqCV8cNfJk7SQhn/cvEaOMOGTsZZEU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jNZTnjbOPeahFRpxrLj8yA-1; Tue, 02 Dec 2025 10:19:32 -0500
X-MC-Unique: jNZTnjbOPeahFRpxrLj8yA-1
X-Mimecast-MFC-AGG-ID: jNZTnjbOPeahFRpxrLj8yA_1764688772
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b24a25cff5so1019475685a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 07:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764688771; x=1765293571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j500ZfWAcLcqWOvQJChvD4/q+ql06LYNDxDqWJYiYGI=;
 b=omVKXa9MzIXewQzFdC0VhHzrOZMLsMreusz/9CdXSPXpbUIRAYaFgiZvJmkx33wDMY
 Syoc76yGJcK3J0dSAyjTxcWWBbnp9UvtrVqPVCOFOCOp1Bg5+QGbcB3c+kjEG6OWuOv/
 jy+sa5MoULRAINFByNjItvV9HyL/pCK+Smk22lZHCddI+Kb/dFTKZc3tYzILTlyszotl
 D49G+Bdr4Dp93vHyFPWSUYYb4nTi3zfqcxQ5HHPUnuPuEobKeuJu2p/YUpm5TIXkzibT
 ZnimmY41dOOL0bTBbD4GdUrf1CZt39+Eb+58yg6sHz8SyPiKWbqSgJoG4+34t68sr8af
 dkeQ==
X-Gm-Message-State: AOJu0YxoUEloFolTEPIpzSRcqGO1V7NQCyG35MlUFyEOM185Y4+2up29
 faLYxzb7fxZxNFj6STMBDKsXwiJ9zOi3rUatCZx6clAsu8XA+Z1gmx+Br4+snTe1b7NZpDqbnEm
 FEVdYMZmkqDKbTRe5vIICRQ02PH6WYue9ajxpcyzVRN9CH/TrNeFa5VgH
X-Gm-Gg: ASbGncsZM/Gsg39HNlcYzNuHDf7sxyZQaa6AAo31LfYfv5AB7QE4NXEXUyXxJwn7gH5
 SpuesXD7YM2GPIoNQvHp7rt+UwRx5iqgElg3Lyt6x0YwQSn5ZPvKosV8fhSR9d0AICkGzy7SbMW
 1z+szNFgINO/1Pme+Mm/A+X4wsSIwc0+GqKW0k0L7QTSfiODfF0LPK+NKpEl9HqsGmpTFHopHXy
 84cJkvufxGOHeCb6tQ6D/77+2bvS7LxgoU8sssCmNdYmO161X6H50AyX8HthUxA1J3j4xr2pCDE
 GxnlAeskfLpYaVuzExdJab9u5GMwzM2JkGuLFW5+ah8CQ0M8SOgiOBM1gnuC+7X7NCI1jA9EQKV
 kV7NZijbB88FgB+lMtD1QVVxsMKPfiDc3rDHUhJ28DcOQ2ZhoIxlvipRFMQ==
X-Received: by 2002:a05:620a:3194:b0:8a1:21a6:e054 with SMTP id
 af79cd13be357-8b33d23b160mr5580377685a.4.1764688771304; 
 Tue, 02 Dec 2025 07:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHL85Rx8w4n1LCapLONifPJOe3WyI/lgWLd96TCzy2AGRhoi7a0c7AkJ0p+xDbfExhjUFezg==
X-Received: by 2002:a05:620a:3194:b0:8a1:21a6:e054 with SMTP id
 af79cd13be357-8b33d23b160mr5580373185a.4.1764688770823; 
 Tue, 02 Dec 2025 07:19:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b6f72sm1078979285a.29.2025.12.02.07.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 07:19:30 -0800 (PST)
Message-ID: <6173cde1-ee30-45b5-a8dc-0cdb09a4b1f1@redhat.com>
Date: Tue, 2 Dec 2025 16:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 11/21] hw/arm/smmuv3: Decode security attributes from
 descriptors
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-12-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-12-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Tao,

On 10/12/25 5:06 PM, Tao Tang wrote:
> As the first step in implementing secure page table walks, this patch
> introduces the logic to decode security-related attributes from various
> SMMU structures.
>
> The NSCFG bits from the Context Descriptor are now decoded and stored.
> These bits control the security attribute of the starting-level
> translation table, which is crucial for managing secure and non-secure
> memory accesses.
>
> The SMMU_S_IDR1.SEL2 bit is read to determine if Secure stage 2
> translations are supported. This capability is cached in the
> SMMUTransCfg structure for the page table walker's use.
>
> Finally, new macros (PTE_NS, PTE_NSTABLE) are added to prepare for
> extracting attributes from page and table descriptors. To improve
> clarity, these different attribute bits are organized into distinct
> subsections in the header file.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-internal.h       | 16 ++++++++++++++--
>  hw/arm/smmuv3-internal.h     |  2 ++
>  hw/arm/smmuv3.c              |  2 ++
>  include/hw/arm/smmu-common.h |  3 +++
>  4 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index d143d296f3..a0454f720d 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -58,16 +58,28 @@
>      ((level == 3) &&                                                    \
>       ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>  
> +/* Block & page descriptor attributes */
> +/* Non-secure bit */
> +#define PTE_NS(pte) \
> +    (extract64(pte, 5, 1))
> +
>  /* access permissions */
>  
>  #define PTE_AP(pte) \
>      (extract64(pte, 6, 2))
>  
> +/* access flag */
> +#define PTE_AF(pte) \
> +    (extract64(pte, 10, 1))
> +
> +
> +/* Table descriptor attributes */
>  #define PTE_APTABLE(pte) \
>      (extract64(pte, 61, 2))
>  
> -#define PTE_AF(pte) \
> -    (extract64(pte, 10, 1))
> +#define PTE_NSTABLE(pte) \
> +    (extract64(pte, 63, 1))
> +
>  /*
>   * TODO: At the moment all transactions are considered as privileged (EL1)
>   * as IOMMU translation callback does not pass user/priv attributes.
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 99fdbcf3f5..1e757af459 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -703,6 +703,8 @@ static inline int oas2bits(int oas_field)
>  #define CD_R(x)          extract32((x)->word[1], 13, 1)
>  #define CD_A(x)          extract32((x)->word[1], 14, 1)
>  #define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
> +#define CD_NSCFG0(x)     extract32((x)->word[2], 0, 1)
> +#define CD_NSCFG1(x)     extract32((x)->word[4], 0, 1)
>  
>  /**
>   * tg2granule - Decodes the CD translation granule size field according
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 55f4ad1757..3686056d8e 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -812,6 +812,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>              tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>          }
>  
> +        tt->nscfg = i ? CD_NSCFG1(cd) : CD_NSCFG0(cd);
>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> @@ -915,6 +916,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>              cfg = NULL;
>              return cfg;
>          }
> +        cfg->sel2 = FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2);
I don't get why we store sel2 in the cfg as it does not vary.

Thanks

Eric
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>              SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index bccbbe0115..90a37fe32d 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -109,6 +109,7 @@ typedef struct SMMUTransTableInfo {
>      uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
>      uint8_t granule_sz;        /* granule page shift */
>      bool had;                  /* hierarchical attribute disable */
> +    int nscfg;                /* Non-secure attribute of Starting-level TT */
>  } SMMUTransTableInfo;
>  
>  typedef struct SMMUTLBEntry {
> @@ -116,6 +117,7 @@ typedef struct SMMUTLBEntry {
>      uint8_t level;
>      uint8_t granule;
>      IOMMUAccessFlags parent_perm;
> +    SMMUSecSID sec_sid;
>  } SMMUTLBEntry;
>  
>  /* Stage-2 configuration. */
> @@ -156,6 +158,7 @@ typedef struct SMMUTransCfg {
>      struct SMMUS2Cfg s2cfg;
>      MemTxAttrs txattrs;        /* cached transaction attributes */
>      AddressSpace *as;          /* cached address space */
> +    int sel2;                 /* Secure EL2 and Secure stage 2 support */
>  } SMMUTransCfg;
>  
>  typedef struct SMMUDevice {


