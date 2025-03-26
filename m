Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C483C36010
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txUlB-0001Ek-4n; Wed, 26 Mar 2025 13:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txUjq-00070y-6K
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txUjk-0005Zl-VX
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743010820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTJ0C7Goe9kJnjrceh72nLA7Q8PYNzitscojKrqHVDg=;
 b=Csv4PwNsEW3SnxvY8cR3Ut2pJ+71t8RygIT4NN/OtQ3VOvN0XtP4t4qFHRV38agN1R/HNl
 oNCuZdqNtmUsH6YHNEylbJKauNjw6PCdIj80mkcYmAZ3ynFGB2xAquwMB7l2PG8nSiKOOR
 eYCRjmDXml6S8Rr3aEXPy13RTyPvASA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-vD4poEYFMFOCZQ8x8N_whA-1; Wed, 26 Mar 2025 13:40:14 -0400
X-MC-Unique: vD4poEYFMFOCZQ8x8N_whA-1
X-Mimecast-MFC-AGG-ID: vD4poEYFMFOCZQ8x8N_whA_1743010813
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so708175e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 10:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010813; x=1743615613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTJ0C7Goe9kJnjrceh72nLA7Q8PYNzitscojKrqHVDg=;
 b=UF9bXcejFQxjnYKZAi8VTKpiuyQJIlrh7qu4gGOS/kQzalkKImTedugCCQEktqWw9S
 z+84949M/ZsO7HjMI3m60qVjw6naqyXS06nuB0crXnwMLwAId+/qVG/uuDdKvMJDUdKA
 72GImSon+myA6nd2T8CXJjLyZG+PUj8WqEC6ZrPkp3J48tKXIWBbrW86voEsT/qClcS9
 URBm2RNtTvXHukwoEqdbsOpfqCadk9p+Fm5JZdGt0foVOntg+AoNRDEFcnOxQ4aZlYkk
 q142C8hWV0f/tFTziLiT/nkMzgnKqH8Rz4plg3OWFMtoScX8he/tIKor95jUQgWD2B1M
 oncA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfrNOEXFwW4v//a4oIohZahDFO+vklp87mI89Rpwi2AZxQUPpvalL05eB8rEnG2fOUpmF31sd+y+rN@nongnu.org
X-Gm-Message-State: AOJu0YxMmcANv8SplPkGge7RKImFH8oWhClSrusw5J3IJ+XWYW3loKPg
 60io4xd0miJD+z3aOSPZ7oIHw8pSXM5TTp0X34FEjQaJz8l8mINTDx/S+DedgJ18M9rT9z+6Pe0
 D8gX3oGq1e3fJGgicL5hn58CIdnLeKwaEApxFnThP83ykKuuMocCy
X-Gm-Gg: ASbGncuKrpULCQuS9rT+TMkvuTulnYFvJWpO1tQfGVEmiCAWD38uDESeLaV62mytPZi
 FKpkif3++YhGr0Oigy/YSP+IWBB0G68lTIldktcZTy7nMf62gmidX7tlDS1nIug1SKjUe9anzXi
 3cvxlVvHZyiWYaFLjrN/WvYtdF8omN8lC6oIrYww5+/FJ951T/8Nj4yxDG1qbwSDR3j+rKNUjwU
 /Kv3RwA5Ym7LlKFwDUSuDidnaPo37mHo3UPfwtJLkN09uJjfouxKYnd451qUwxe5jRhkPfGz/gr
 sYrIUouyqZrJJ5YFqV6Gj1sOemfdU4h8BTCSzmBwl4xfToG1jmiF6CCzAipq99Y=
X-Received: by 2002:a05:600c:3483:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43d84fba8d5mr4382025e9.13.1743010812802; 
 Wed, 26 Mar 2025 10:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA3BMpKwKS98UNk3Hs5oOcXnkPUGKgeFeAheraTP84qAdHpZq5Unub/EXcMxqjqGGXJI+Uuw==
X-Received: by 2002:a05:600c:3483:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43d84fba8d5mr4381585e9.13.1743010812307; 
 Wed, 26 Mar 2025 10:40:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b9e9sm8886385e9.37.2025.03.26.10.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 10:40:11 -0700 (PDT)
Message-ID: <4a6103cd-a007-4cb2-bd3b-1bc39c0ecd9e@redhat.com>
Date: Wed, 26 Mar 2025 18:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/20] hw/arm/smmu-common: Bypass emulated IOTLB
 for a accel SMMUv3
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-19-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-19-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> If a vSMMU is configured as a accelerated one, HW IOTLB will be used
> and all cache invalidation should be done to the HW IOTLB too, v.s.
> the emulated iotlb. In this case, an iommu notifier isn't registered,
> as the devices behind a SMMUv3-accel would stay in the system address
> space for stage-2 mappings.
>
> However, the KVM code still requests an iommu address space to translate
> an MSI doorbell gIOVA via get_msi_address_space() and translate().
In case we you flat MSI mapping, can't we get rid about that problematic?

Sorry but I don't really understand the problematic here. Please can
elaborate?

Thanks

Eric
>
> Since a SMMUv3-accel doesn't register an iommu notifier to flush emulated
> iotlb, bypass the emulated IOTLB and always walk through the guest-level
> IO page table.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 9fd455baa0..fd10df8866 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -77,6 +77,17 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>      uint8_t level = 4 - (inputsize - 4) / stride;
>      SMMUTLBEntry *entry = NULL;
>  
> +    /*
> +     * Stage-1 translation with a accel SMMU in general uses HW IOTLB. However,
> +     * KVM still requests for an iommu address space for an MSI fixup by looking
> +     * up stage-1 page table. Make sure we don't go through the emulated pathway
> +     * so that the emulated iotlb will not need any invalidation.
> +     */
> +
> +    if (bs->accel) {
> +        return NULL;
> +    }
> +
>      while (level <= 3) {
>          uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
>          uint64_t mask = subpage_size - 1;
> @@ -142,6 +153,16 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>      SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
>      uint8_t tg = (new->granule - 10) / 2;
>  
> +    /*
> +     * Stage-1 translation with a accel SMMU in general uses HW IOTLB. However,
> +     * KVM still requests for an iommu address space for an MSI fixup by looking
> +     * up stage-1 page table. Make sure we don't go through the emulated pathway
> +     * so that the emulated iotlb will not need any invalidation.
> +     */
> +    if (bs->accel) {
> +        return;
> +    }
> +
>      if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
>          smmu_iotlb_inv_all(bs);
>      }


