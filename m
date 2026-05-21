Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C07ACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Qy-0006mR-F7; Thu, 21 May 2026 09:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3Qx-0006lx-2a
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3Qt-0003QL-A2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370046;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBU0RmhVsjEI/ftPAq3yUSYkLVBipJIEzUT12Oo1K4Q=;
 b=aPPlG22Ky5t/BNkNoPA6gd1TBbnOfDhgFbCSKCU1A17a2+QgI47t/+Ua5Q7cJNQ8ue/vew
 hXsnJMlzi85lRLQMvEuPiK2DD78spHfJgPxndlpZDPZra0rPY3C6rd3Wzy+cNRXlTUREa/
 sS5fh99raeQGv9pYmO7PF5LHPjqdiCY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-YgdFIbewNXCe8vQiKYm6mQ-1; Thu, 21 May 2026 09:27:22 -0400
X-MC-Unique: YgdFIbewNXCe8vQiKYm6mQ-1
X-Mimecast-MFC-AGG-ID: YgdFIbewNXCe8vQiKYm6mQ_1779370042
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe24773c8so33149445e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370041; x=1779974841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBU0RmhVsjEI/ftPAq3yUSYkLVBipJIEzUT12Oo1K4Q=;
 b=bhK2O94VDB4KgRKwovUpw65pI61sD4oXKvCHpr0PmQ1LyQTT4b03qHaoWgP2x6/AZj
 L1Okuy+yKIimcwZV8t1bVdLDfpMATKN+qu7RC9dWbyyFcMfg18NwQfZBsNCxOd474SvA
 7hwjpZPukgBHIeDRtvgEgxNZvrKwXcOKKwQx1MG93zrRpSbFRhCovNgF/61MkEXzmWeV
 5jL8U6Lp9QEuC++xtsccgujDcovgpiDSZlp7Af+kZoUUziQwUDpCWapmtALCXGtlPXwJ
 OgVzfUX0vDaxWcWF9bUgixlLh3fPs4YEZF0yANREyYgsBOCzRI+HQTn2+2of23rZrAJF
 +PnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RPcAhbtnAxqExJ9lzlWx9zh+17K/4f7thgFqMauYtsS86nyG7V21zXUuyhEQxjcjVFt5GRjZ+UG5u@nongnu.org
X-Gm-Message-State: AOJu0YynkeBOWpNVwVHRE+2f9fErh0PKjQjSEDqz1gdLGqDE4OIXPuKu
 /i7m6tx3nv7huBhR7lhlcYZZTTUQTKBFaVng/Gl3G5P5gOl9FNlimk98Ro5FGY8yTkmvxC6CC9p
 YHqWL6x1oAzA+HMAZO49U2OCk/xwobcQ9PBW1PDfSb/00zMOXV0+jay3b
X-Gm-Gg: Acq92OG1cSJ0VDaPh/o68LQxtVjqFsZUdjbKfn3pgtiaxP0X/Urh1ZfCsRVCv+5HfEr
 kkh1oZahpCi+EM0s7850yXGtkoE5ev5iqtGREP5V/80hh4/gGvI0d80Stg2xcIA0JCGTZkQBuEi
 8jUXDpeJoHjl2HfigQIbL0BbP4OfiXLtzAQ4RKZHw01ajRMfMNav71HKOGHu/niw83oEzs/YEuv
 DRLdN8+M0ZNgVHDZVs5lO/hr3gbQuA922ayrgW8WkyxqxcILzKfxgL2GD/W0QDW2jm6wYzGf92m
 6SriaglEtbRiY+NNKFcvVjMLNwmF+NnOXlt3rmpOzOIhvbjLhT0oNHr84r0tPqNbTM+XNbXKl83
 jzpW/cykKb43fU+AUNbtCDWsn+EBFvZIVLzL7ds5Lb0DVZoM1RqGLTvATMnE4aB93bVJNPQ==
X-Received: by 2002:a05:600c:c098:b0:490:3d2e:b67d with SMTP id
 5b1f17b1804b1-4903d2eb78emr15456175e9.30.1779370041481; 
 Thu, 21 May 2026 06:27:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c098:b0:490:3d2e:b67d with SMTP id
 5b1f17b1804b1-4903d2eb78emr15455645e9.30.1779370040976; 
 Thu, 21 May 2026 06:27:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cdcc3sm3189524f8f.8.2026.05.21.06.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:27:20 -0700 (PDT)
Message-ID: <69ec35de-1f7c-40ae-9ea5-3727c047c590@redhat.com>
Date: Thu, 21 May 2026 15:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
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
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-20-skolothumtho@nvidia.com>
 <166c5efb-0fa3-49f6-a1e7-faec85a6ec44@redhat.com>
 <CH3PR12MB7548314422301EA66803DD40AB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548314422301EA66803DD40AB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/21/26 2:26 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 21 May 2026 10:30
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW
>> VCMDQs once configured
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi,
>>
>> On 5/19/26 12:36 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Add support for allocating IOMMUFD hardware queues when the guest
>>> programs the VCMDQ BASE registers.
>> You should add the fact that
>>
>> iommufd_backend_alloc_hw_queue() requires the GPA of the VCMDQ. This
>> explains why you need to those operations once the GPA has been populated.
> Ok.
>
>>> VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
>>> that a later patch maps directly into the guest — so QEMU won't trap
>>> its writes. Allocate the hardware queue instead once all of these
>>> are set: a RAM-backed BASE, CMDQ_ALLOC_MAP.ALLOC, and CMDQV /
>> VINTF
>>> enabled. Each precondition write retries the allocation, so the
>>> guest may program them in any order.
>>> If a hardware queue was previously allocated for the same VCMDQ,
>>> free it before reallocation.
>>>
>>> Writes with invalid addresses are ignored.
>>>
>>> All allocated VCMDQs are freed when CMDQV or VINTF is disabled, or
>>> when the ALLOC bit is cleared.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.h |  11 ++++
>>>  hw/arm/tegra241-cmdqv.c | 138
>> ++++++++++++++++++++++++++++++++++++++--
>>>  2 files changed, 143 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>> index f0b031b4dc..7a8cb2ebc7 100644
>>> --- a/hw/arm/tegra241-cmdqv.h
>>> +++ b/hw/arm/tegra241-cmdqv.h
>>> @@ -45,6 +45,7 @@ typedef struct Tegra241CMDQV {
>>>      MemoryRegion mmio_cmdqv;
>>>      qemu_irq irq;
>>>      IOMMUFDVeventq *veventq;
>>> +    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>>>      void *vintf_page0;
>>>
>>>      /* CMDQ-V Config page register cache */
>>> @@ -361,6 +362,16 @@
>> SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
>>>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
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
>>> index 4d9f094b2a..f4968520f3 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -18,6 +18,95 @@
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
>>> +    /* Ignore any invalid address. This may come as part of reset etc. */
>>> +    if (!address_space_range_is_ram(&address_space_memory, addr, size)) {
>> why do you need to test the whole range and not only the start address
> That was to make it more defensive based on v4 discussion here:
> https://lore.kernel.org/qemu-devel/aft%2FDTFLqQnufzWl@nvidia.com/
>
> Please let me know if there is a better way.
Well it is unclear to me. You want to make sure the GPA was fully set
through the H and L regs. To me that's enough. As far as I understand
Nicolin's reply, the kernel checks the rest. But please sync with Jason
or Nicolin

Eric
>
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!tegra241_cmdqv_enabled(cmdqv) ||
>> !tegra241_vintf_enabled(cmdqv)) {
>>> +        return true;
>>> +    }
>>> +
>>> +    tegra241_cmdqv_free_vcmdq(cmdqv, index);
>>> +
>>> +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu-
>>> viommu_id,
>>> +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
>>> +                                        index, addr, size, &hw_queue_id,
>>> +                                        errp)) {
>>> +        return false;
>>> +    }
>>> +    hw_queue = g_new(IOMMUFDHWqueue, 1);
>>> +    hw_queue->hw_queue_id = hw_queue_id;
>>> +    hw_queue->viommu = viommu;
>>> +    cmdqv->vcmdq[index] = hw_queue;
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
>>> +                                           Error **errp)
>>> +{
>>> +    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
>>> +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
>> if case of failure,what is the functional consequence. Can you comment
>> on this in the commit msg or here.
> Today QEMU only logs the error:
>
>  qemu-system-aarch64: IOMMU_HW_QUEUE_ALLOC failed: error -22
>
> The guest visible behaviour then depends on whether VINTF0 Page 0 was
> mapped into guest memory before this failure:
>
> Case 1: setup_vcmdq() succeeds for vcmdq0, fails for vcmdq1:
>
>   - VINTF0 Page 0 was mapped to the guest after vcmdq0's success.
>   - Guest writes VCMDQ1_CONFIG go directly to HW.
>   - Guest reads VCMDQ1_STATUS directly from HW:
>
>     ...
>     tegra241_cmdqv: VINTF0: VCMDQ1/LVCMDQ1: failed to enable, STATUS=0x00000000
>     tegra241_cmdqv: VINTF0: VCMDQ1/LVCMDQ1: GERRORN=0x0, GERROR=0x0, CONS=0x0
>     ...
> 	
> Case 2: setup_vcmdq() fails for vcmdq0:
>
>   - VINTF0 Page 0 is not mapped to the guest.
>   - Guest writes VCMDQ0_CONFIG. Trapped by QEMU.
>   - Guest reads VCMDQ0_STATUS. Trapped by QEMU.
>  - Both served from the register cache. The cache currently doesn't
>    reflect the failure,  so the guest thinks the queue is enabled and
>    proceeds to issue commands, eventually:
>
>     arm-smmu-v3 arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000002 [hwprod 0x00000002, hwcons 0x00000000]
>     arm-smmu-v3 arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000004 [hwprod 0x00000004, hwcons 0x00000000]
>
> Case 2 needs fixing. I'll fix the register cache on the error path
> for v6 and document it. 
OK ;-)

Thanks

Eric
>
> Thanks,
> Shameer


