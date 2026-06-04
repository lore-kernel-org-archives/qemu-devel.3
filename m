Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C86CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6SM-00047M-P5; Thu, 04 Jun 2026 07:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6SL-000460-N4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6SJ-000252-IF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780573305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcmSAGisqIDvUO5AfpYKctsfH+OmKdETMmTTHyuh5BI=;
 b=gOkeeLjfegB6dxrZH1EsdGiQjR/0EldyF3Uerg1lWmSwhJULEmUJzPA5koeIAHUtJEygIH
 GsxwOQbYackbbzhJhwMBqfoBiuMv+ey+nfsMiWRbMLuc4V0bAFQggRInujmMEt3m3MsmcL
 0yAWq0dEJO65vDRH5inApUVhPjsgfLo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-LENBr5FxNaWDBIsxel0z8Q-1; Thu, 04 Jun 2026 07:41:44 -0400
X-MC-Unique: LENBr5FxNaWDBIsxel0z8Q-1
X-Mimecast-MFC-AGG-ID: LENBr5FxNaWDBIsxel0z8Q_1780573303
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46010bc0f1eso381008f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573303; x=1781178103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcmSAGisqIDvUO5AfpYKctsfH+OmKdETMmTTHyuh5BI=;
 b=GmrB8RLBzyGDqYghPya9XzGAWVYsqhRsVVHT3PH+oBHPiMG1vCHeOzguwuHddRDIXG
 I0ONVMr8pZFqP9D5kpJ6hEsvRjuJN5HL2LcVa9Tzs8FQJzg236pF1guZE0lt20c+TEcF
 nODurUDnEaumFeCUJhxvjocTvZbOkU0VbK0APdBs+b4RfamBPLnkraMd7ZLaosYb5TSK
 TN/lde+fGCp8glkurfROOzH5nfkKi0oVsISBRB0mjKtezjy+dmId3WpB2EAEEJwN+2Zk
 tR8yn9B6BVBLXbDlEQIMJ/XTHMW1rF/Sna0jF5eUC/LBhjp5MhG9Q+yJcCRkINqf8fy7
 3SRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92KOTl4Bf4hfXOazFobSL728WaeIvIOBzZ3ooDjtihQXYtfIuOiOc3sKJrOXTFDayAnMoEkXmY7Ptj@nongnu.org
X-Gm-Message-State: AOJu0Yzo/d/WSwo3nI5a+ro4GwH7363jVS4Mz1wNHSk37XqJQY42yT16
 eyesgJOWLKf7dsxJRQpoUj4gpIs2iX9DrNs62uON9+PMbUultVZ5EbbAfxq7A9ITyPZk+aGY/D1
 L2D47kGTyak6gjepV0Sgt3NWG2HkI6IP9OCe5ln3dura7c7ljcgXcuAsi
X-Gm-Gg: Acq92OHIrkVCJ6lvZlqFjb6FS1QoBCnhazHCyYbGEH9wiLBJ0GL/Hpj1fc3ykVVDGtR
 WwcYRje7OoWat8j36ZmXPPIRrD2TxsGXewYsAUPxdwM3+u7811UahBmyjzvASQbPcfce+FVPxwS
 YptH+7TJM7bNdJ91AwytCHfUAFzjQPZWXGfZsWWhigMs2Kj9Ymcc9ceUrq9M+kbZAtHcAViDvNa
 SMJsn+0aGGP4XZnZVODFBGeq4wpoZOtwk4mwbjMpDcwgVfB35tTZICKQcaRUXMVWAjGUzhEqiuq
 yUHKIjiPuljchhkv1G3f53snGM3MWREc8SO5JCmaVkf2KPbDtKW6Ch90c3dgPwz//6VQiJ6iOhX
 f2Mso6ftvCq65CRPEj6X5pAXrSNYDO0yN4IV7jMz8JfmyjXnXAwGAP0DzVJyo8mA2HxES5Ucc0O
 xioCe1
X-Received: by 2002:a05:600c:630f:b0:490:b025:f324 with SMTP id
 5b1f17b1804b1-490b60e41a8mr129162345e9.32.1780573302836; 
 Thu, 04 Jun 2026 04:41:42 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:490:b025:f324 with SMTP id
 5b1f17b1804b1-490b60e41a8mr129161945e9.32.1780573302408; 
 Thu, 04 Jun 2026 04:41:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344558sm15865331f8f.18.2026.06.04.04.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 04:41:41 -0700 (PDT)
Message-ID: <5057c259-5027-4fdc-ba44-ea6b375b983b@redhat.com>
Date: Thu, 4 Jun 2026 13:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-19-skolothumtho@nvidia.com>
 <8e656872-4991-4e44-a64a-c055efbb311a@redhat.com>
 <CH3PR12MB75482ED309FA7824C69D8E4BAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75482ED309FA7824C69D8E4BAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 6/4/26 12:16 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 04 June 2026 10:37
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW
>> VCMDQs once configured
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 6/1/26 1:42 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Add support for allocating IOMMUFD hardware queues when the guest
>>> programs the VCMDQ BASE registers.
>>>
>>> VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
>>> that a later patch installs into guest MMIO - so QEMU won't trap its
>>> writes. Allocate the hardware queue instead once all of these are
>>> set: BASE programmed, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
>>> enabled. Each precondition write retries the allocation, so the
>>> guest may program them in any order.
>>>
>>> iommufd_backend_alloc_hw_queue() needs the guest physical address of
>>> the VCMDQ ring buffer, so allocation is deferred until the guest has
>>> populated BASE.
>>>
>>> If a hardware queue was previously allocated for the same VCMDQ,
>>> free it before reallocation. All allocated VCMDQs are freed when
>>> CMDQV or VINTF is disabled, or when the ALLOC bit is cleared.
>>>
>>> On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
>>> cache so trapped guest reads see the failure rather than a queue
>>> that looks live. Clear them on a later successful allocation.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.h |  11 +++
>>>  hw/arm/tegra241-cmdqv.c | 154
>> +++++++++++++++++++++++++++++++++++++---
>>>  2 files changed, 156 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>> index c4d327a9a5..84499b840d 100644
>>> --- a/hw/arm/tegra241-cmdqv.h
>>> +++ b/hw/arm/tegra241-cmdqv.h
>>> @@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
>>>      MemoryRegion mmio_cmdqv;
>>>      qemu_irq irq;
>>>      IOMMUFDVeventq *veventq;
>>> +    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>>>      void *vintf_page0;
>>>
>>>      /* CMDQ-V Config page register cache */
>>> @@ -364,6 +365,16 @@ SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
>>>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
>>>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
>>>
>>> +static inline bool tegra241_cmdqv_enabled(Tegra241CMDQV *cmdqv)
>>> +{
>>> +    return cmdqv->status & R_STATUS_CMDQV_ENABLED_MASK;
>>> +}
>>> +
>>> +static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdqv)
>>> +{
>>> +    return cmdqv->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
>>> +}
>>> +
>>>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>>>
>>>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index a52e153501..54d95f4e4e 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -18,6 +18,96 @@
>>>  #include "tegra241-cmdqv.h"
>>>  #include "trace.h"
>>>
>>> +static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int
>> index)
>>> +{
>>> +    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
>>> +    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
>>> +
>>> +    if (!vcmdq) {
>>> +        return;
>>> +    }
>>> +    iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
>>> +    g_free(vcmdq);
>>> +    cmdqv->vcmdq[index] = NULL;
>>> +}
>>> +
>>> +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
>>> +{
>>> +    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending
>> @index. */
>>> +    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
>>> +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
>>> +    }
>> basically the same comment as previous patch. I would add in the exit
>> phase reset at this stage too.
> Yes. I get that now. Will populate the rest handler.
>
>>> +}
>>> +
>>> +/*
>>> + * Allocate a host HW VCMDQ from the current cached BASE / size for
>> @index.
>>> + *
>>> + * Setup is a no-op (returns true) when any of the following preconditions
>>> + * isn't met yet:
>>> + *  - BASE not prgrammed yet.
>>> + *  - VCMDQ is not mapped to a VINTF (CMDQ_ALLOC_MAP.ALLOC == 0)
>>> + *  - BASE / size don't resolve to a RAM region
>>> + *  - CMDQV global enable or VINTF enable is not yet asserted
>>> + */
>>> +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int
>> index,
>>> +                                       Error **errp)
>>> +{
>>> +    SMMUv3AccelState *accel = cmdqv->s_accel;
>>> +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
>>> +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
>>> +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
>>> +    uint64_t log2 = cmdqv->vcmdq_base[index] &
>> R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
>>> +    uint64_t size = 1ULL << (log2 + 4);
>>> +    IOMMUFDViommu *viommu = accel->viommu;
>>> +    IOMMUFDHWqueue *hw_queue;
>>> +    uint32_t hw_queue_id;
>>> +
>>> +    /* BASE not programmed yet. */
>>> +    if (!cmdqv->vcmdq_base[index]) {
>>> +        return true;
>>> +    }
>>> +
>>> +    /* VCMDQ not yet mapped to a VINTF. */
>>> +    if (!(cmdqv->cmdq_alloc_map[index] &
>> R_CMDQ_ALLOC_MAP_0_ALLOC_MASK)) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!tegra241_cmdqv_enabled(cmdqv) ||
>> !tegra241_vintf_enabled(cmdqv)) {
>>> +        return true;
>>> +    }
>> nit: I think I would introduce an helper
>> vcmdq_hw_queue_ready_to_be_allocated(cmdqv, index)
>> where you could put a proper doc comment.
> Sure.
>
>> Not that once flag the base is set it returns true. ie. you do not check
>> that both L & H are set.
>>
>> But anyway the queue will be reallocated
> That's true. I will capture it in comments.
>
>>> +
>>> +    tegra241_cmdqv_free_vcmdq(cmdqv, index);
>>> +
>>> +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu-
>>> viommu_id,
>>> +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
>>> +                                        index, addr, size, &hw_queue_id,
>>> +                                        errp)) {
>>> +        /* Record the failure in the cache. */
>>> +        cmdqv->vcmdq_gerror[index] |=
>> R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
>>> +        cmdqv->vcmdq_status[index] &=
>> ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +        return false;
>>> +    }
>>> +    hw_queue = g_new(IOMMUFDHWqueue, 1);
>>> +    hw_queue->hw_queue_id = hw_queue_id;
>>> +    hw_queue->viommu = viommu;
>>> +    cmdqv->vcmdq[index] = hw_queue;
>>> +
>>> +    cmdqv->vcmdq_gerror[index] &=
>> ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
>>> +    cmdqv->vcmdq_status[index] |=
>> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
>>> +                                           Error **errp)
>>> +{
>>> +    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
>>> +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
>>> +            return;
>>> +        }
>>> +    }
>> nit: you you could after the tegra241_cmdqv_free_all_vcmdq helper
>>> +}
>>> +
>>>  /*
>>>   * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
>>>   *
>>> @@ -145,7 +235,12 @@ static void
>> tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>>>          break;
>>>      case A_VCMDQ0_CONFIG:
>>>          if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
>>> -            cmdqv->vcmdq_status[index] |=
>> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +            /* Report init error if any. */
>>> +            if (!(cmdqv->vcmdq_gerror[index] &
>>> +                  R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK)) {
>>> +                cmdqv->vcmdq_status[index] |=
>>> +                    R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +            }
>> does it really belong to this patch?
> I put it here because this is the patch that sets that error in the 
> first place.  Commit log kind of mentions it. I could explain it better in
> commit log if that's enough. The other option is splitting the error 
> handling into a separate patch, but THB don't see a need for that.
OK Thanks

Eric
>
> Thanks,
> Shameer
>


