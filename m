Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DAFC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujXk-0005g1-Tj; Tue, 18 Mar 2025 22:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tujXh-0005fY-Uf
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tujXg-0006dc-7P
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742352746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2lKt23Z4OvefEdLmqoGguD9K0yVsAxIdMYhuArjey8=;
 b=BjUB5lFtlRjtHWaoQZKvQcRyiCYz7sH/uCH9laCO3Iz/NHyx2kIgeJQZ1YM3CzRtTWxWab
 snGrHH3vEzcO5VI/Z0FonitGvm4LiH31TTl7OJ8lSISKuUUD9ZljYoxlbBvod4wcjNFvcW
 yuJHx9clrjrPU+1jmLMJxbwsY//X7VU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wnhrKVSEMkiTrFuWR6PILg-1; Tue, 18 Mar 2025 22:52:24 -0400
X-MC-Unique: wnhrKVSEMkiTrFuWR6PILg-1
X-Mimecast-MFC-AGG-ID: wnhrKVSEMkiTrFuWR6PILg_1742352744
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3d4578fbaf4so125009905ab.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 19:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742352743; x=1742957543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2lKt23Z4OvefEdLmqoGguD9K0yVsAxIdMYhuArjey8=;
 b=rvG02WUf+CJ/tRVl5fCIzGOTXpZSLuXAr6kQfvMzl+YDOEHxdN5gTY3P6vAzV2dezn
 V+RscTciwKLkcHPFwpxFxgxsOFS+teFeeDtMzf0EHkbHrkuaSKK24GxRPW7D8BWl4Q+C
 Kr1VPcCNdAEXtvuHbY3w7+00ZUiAJOmFCn3TnH8VCHIpbgB9Jz2tb1qFWuccfzkvo5Nk
 HGFUY8ZKoaLDOEje73nmea0OIS/kn2MVWYYpLPe3RgNd+H1flgHzWM0YbSzrZAfeZzaN
 h1KjvA7BmkQKkIchldglp8E3vEp9YDn46+91E5aYJKG13DfGn8Bj8TKmrW3r5pAep0TL
 nkRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbot0jGceROn4LbZi4zcuPMj/QzlPCFo1J3IRiiljMe+5AjSxC8EEkMTAZ6RAjPktfmpElODKwAcFV@nongnu.org
X-Gm-Message-State: AOJu0Yyjje1HufrMUsEPmF/j4+BWK/vi40GR68xuSarUzcoNIBREkz91
 ZgQuVcOu0iped9MQ8OC8d4NQxXIJRWy/fdIn57MBt9ZUXoW2hE91NqDo7QlZGvaWVC7dRrgeiri
 s2PVdxzSVduoUXs45OLZ7dX4klVfGALZnP8iLEVBPafACuXrwJvh7
X-Gm-Gg: ASbGnctgiH/mP1IqVpobq6PLVQNFTzyAQ5P0EGQijXongwnX5GXCcxMX/TH0Vp27di1
 /wpvDes6qbGGxZUnyqaaNjZswEXxUtgJZ0EU/WzbD935Kd1Q7DWS5VmPb9owMnn8PdiL5aWqfqH
 S78d3aT5Qkb++YWVg7TUBR9WcJoztZeMQskR09tHV8lmkEG38I0c/Vsp47lKTamld9YoFzivKDc
 tuktVcAXlpyP6+g2Gu7lEjNqpKrFcMiC5h8XGXdWfPmoIrB3pw4moxEkG/S9haoFfCDOHLIiDRy
 lGkxvCvt+2amJwQ7
X-Received: by 2002:a05:6e02:2163:b0:3d3:fdcc:8fb0 with SMTP id
 e9e14a558f8ab-3d586bda3bcmr12046845ab.20.1742352743525; 
 Tue, 18 Mar 2025 19:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYNvrnUkX7uQYijV6o5jqwwdlO/XrVCt4VLuEPhNyCTFSkYLv55z1brda0HW6Lu0hd1iQdqA==
X-Received: by 2002:a05:6e02:2163:b0:3d3:fdcc:8fb0 with SMTP id
 e9e14a558f8ab-3d586bda3bcmr12046665ab.20.1742352743270; 
 Tue, 18 Mar 2025 19:52:23 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d47a647222sm35937545ab.4.2025.03.18.19.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 19:52:22 -0700 (PDT)
Message-ID: <4fddf86b-4481-4ca2-8610-732929f8593d@redhat.com>
Date: Tue, 18 Mar 2025 22:52:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/20] hw/arm/smmu-common: Bypass emulated IOTLB
 for a accel SMMUv3
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-19-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-19-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/25 10:10 AM, Shameer Kolothum wrote:
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
> 
> Since a SMMUv3-accel doesn't register an iommu notifier to flush emulated
> iotlb, bypass the emulated IOTLB and always walk through the guest-level
> IO page table.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmu-common.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 9fd455baa0..fd10df8866 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -77,6 +77,17 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>       uint8_t level = 4 - (inputsize - 4) / stride;
>       SMMUTLBEntry *entry = NULL;
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
>       while (level <= 3) {
>           uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
>           uint64_t mask = subpage_size - 1;
> @@ -142,6 +153,16 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>       SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
>       uint8_t tg = (new->granule - 10) / 2;
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
>       if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
>           smmu_iotlb_inv_all(bs);
>       }

Ah! ... if 'accel', skip emulated code since hw handling it... in common smmu code... I like it! :)
- Don


