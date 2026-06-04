Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C48DCD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4YN-0002nu-UW; Thu, 04 Jun 2026 05:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4YL-0002n9-93
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4YI-0006GY-Gx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780565989;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQ5akJp7NOL4PtF7Yr9lnOvFOpLSVlpSKdcaZwkQkyA=;
 b=DaueJL9mX7YHxZ1dbfVHSEMNVSo/wkVItozbOyHRAWUCJYOlpVMui4Piw2/bhW6EZAQtAK
 pgo64GPvaV0E9m+Vic7zf1R+YVJibzr5y6QyhRBUiAvoOquLiZRFUh65dz2P7QncD3zaem
 l49EGXej40EJeVzRQqT05avH2fyDa9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-JL7myuj8N0u9xkGV5ldWWg-1; Thu, 04 Jun 2026 05:39:46 -0400
X-MC-Unique: JL7myuj8N0u9xkGV5ldWWg-1
X-Mimecast-MFC-AGG-ID: JL7myuj8N0u9xkGV5ldWWg_1780565986
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46016bedbaaso311141f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565985; x=1781170785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ5akJp7NOL4PtF7Yr9lnOvFOpLSVlpSKdcaZwkQkyA=;
 b=Y+mtJ8IBBYJzGhxI+wdZ5Wj1X6G9rk1GTxpNy7PzV6TNIkn+2ZspeLyJH6WK9oF3jW
 v8H55evNP6Jle16YSUY0hu9OEmevqykK9NUgNZ9GgCCNkuzWzPVx//8BajgMkpYQiCWI
 UqJp+uqAmw1QaRcgkeEFiL6Q80ZAI/uVY74TqBul0od0jbRhcKkSejP8xfIELhNOBtzS
 Tzqq5il6tJGAVyay8dhOmW22zYdz9LoVAfDOfNLd4K/Oq+gBN+QRzr/Gdo4S7Sq2XGPY
 wyUjQ06VkMNB0b+DReWbClZQ8T9S0J/7//T1BRbQgSmBXOP2LFtxic5tJskzHglD9tio
 EIhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b0rFz4ZQCbYr/dg1pf+dUeOrjebC1Xv0CeSIde4kJ94E8K7yXGUf4OPHHPyjYu5g5ZSGuN4mBiogs@nongnu.org
X-Gm-Message-State: AOJu0Yz/E11IMqCakaNDLZcYGXdclSMOrjoteIcIlxgGpy421THx8lG+
 PpjNhMxgo7nW6C/qzIcoeeribV/mCU03FNUYosSIdZe/o+g5rVW+gxZpw9pcLWYWMeASmmRIJh2
 DV344fPGuy4MuMhtYSk9I5WGPdAYTUzcnKzpxdiDIhTfUjzj+P6RqevBj
X-Gm-Gg: Acq92OHphTa0A3Khnuv3m7BXDHlazd29JtxKVBYCwpUp4zyitxWgOagWFzK85vwrScK
 HiRDt1/lnlGNyQgj289HREAuOTzm1QJMraXp/13BsU2D2EPjjCZCwZ8H0woqYoOjAefoWDEwweG
 S2A/6ii4wcTo19pxznEMO5+Zg1Hcujc7ptfTWRJbb/ovbmRblCQ4z6heV058Qqlppvy6Tomxl6y
 UIdNLp0t2esxswTnZoPRj1GmH7Pd0Xey/VkR+yT8spV/0CXHW14W0tdMeHX+Dio7CtBtYS+TQ7X
 SvilmfBl65P4PGudgeKC+i0jIOGoCeMEYXaDoYzwtL0DUzciEVcFBYqrY0l12MHb3/gzLKo47S0
 AiLSqMHwgj6WntZIao7JrjPmc4lyrheVzUNwf1RJKCZvzzkYGO0lofaQNqZrnsJAvDZtSRq0g6M
 1kgHB7
X-Received: by 2002:a5d:4a49:0:b0:45e:f5bf:6c25 with SMTP id
 ffacd0b85a97d-46021854d8fmr7405771f8f.32.1780565985395; 
 Thu, 04 Jun 2026 02:39:45 -0700 (PDT)
X-Received: by 2002:a5d:4a49:0:b0:45e:f5bf:6c25 with SMTP id
 ffacd0b85a97d-46021854d8fmr7405720f8f.32.1780565984813; 
 Thu, 04 Jun 2026 02:39:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f5612sm14592414f8f.15.2026.06.04.02.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 02:39:44 -0700 (PDT)
Message-ID: <9a6f3936-7b88-4bba-b55d-71a9086e48e4@redhat.com>
Date: Thu, 4 Jun 2026 11:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
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
 <20260601114221.457995-18-skolothumtho@nvidia.com>
 <1a9b7bf7-cb1f-4826-a225-3346ba0debcb@redhat.com>
 <CH3PR12MB75482617D7EC570D8D4F0AFFAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75482617D7EC570D8D4F0AFFAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
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



On 6/4/26 11:26 AM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 04 June 2026 10:01
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v6 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0
>> for CMDQV
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 6/1/26 1:42 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> The kernel currently exposes a single VINTF per emulated SMMUv3
>>> instance. IOMMU_VIOMMU_ALLOC returns an mmap offset for the host
>>> VINTF Page0 allocated for this SMMU. However, VCMDQs only become
>>> bound to that VINTF after IOMMU_HW_QUEUE_ALLOC, so until then the
>>> mapped Page0 does not back any real VCMDQ state.
>>>
>>> When VINTF is enabled, mmap the kernel-provided Page0 region and set
>>> STATUS.ENABLE_OK only if the mmap succeeds; unmap it when VINTF is
>>> disabled. This prepares the VINTF mapping in advance of subsequent
>>> patches that add VCMDQ allocation and the guest MMIO install.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.h |  3 +++
>>>  hw/arm/tegra241-cmdqv.c | 50
>> ++++++++++++++++++++++++++++++++++++++---
>>>  2 files changed, 50 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>> index ad7fb8725f..c4d327a9a5 100644
>>> --- a/hw/arm/tegra241-cmdqv.h
>>> +++ b/hw/arm/tegra241-cmdqv.h
>>> @@ -37,6 +37,8 @@
>>>  #define CMDQV_VINTF_PAGE1_BASE  0x40000
>>>  #define CMDQV_VCMDQ_STRIDE      0x80
>>>
>>> +#define VINTF_PAGE_SIZE 0x10000
>>> +
>>>  struct iommu_viommu_tegra241_cmdqv;
>>>
>>>  typedef struct Tegra241CMDQV {
>>> @@ -45,6 +47,7 @@ typedef struct Tegra241CMDQV {
>>>      MemoryRegion mmio_cmdqv;
>>>      qemu_irq irq;
>>>      IOMMUFDVeventq *veventq;
>>> +    void *vintf_page0;
>>>
>>>      /* CMDQ-V Config page register cache */
>>>      uint32_t config;
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index 3cb1b45575..a52e153501 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -9,6 +9,8 @@
>>>
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/log.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qapi/error.h"
>>>
>>>  #include "hw/arm/smmuv3.h"
>>>  #include "hw/arm/smmuv3-common.h"
>>> @@ -218,8 +220,42 @@ static void
>> tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
>>>                                             offset0, value);
>>>  }
>>>
>>> +static bool
>>> +tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error
>> **errp)
>>> +{
>>> +    if (!cmdqv->vintf_page0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
>>> +        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
>>> +        return false;
>>> +    }
>>> +    cmdqv->vintf_page0 = NULL;
>>> +    return true;
>>> +}
>>> +
>>> +static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV
>> *cmdqv, Error **errp)
>>> +{
>>> +    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
>>> +
>>> +    if (cmdqv->vintf_page0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu-
>>> viommu_id,
>>> +                                     VINTF_PAGE_SIZE,
>>> +                                     cmdqv->cmdqv_data->out_vintf_mmap_offset,
>>> +                                     &cmdqv->vintf_page0, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>  static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>>> -                                              hwaddr offset, uint64_t value)
>>> +                                              hwaddr offset, uint64_t value,
>>> +                                              Error **errp)
>>>  {
>>>      int i;
>>>
>>> @@ -234,8 +270,11 @@ static void
>> tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>>>          cmdqv->vintf_config = value;
>>>          if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
>>> -            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
>>> +            if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
>>> +                cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
>>> +            }
>>>          } else {
>>> +            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>> the munmap is only done upon guest action in this patch. Later on, it is
>> also done on reset (in smmuv3_accel_reset called on smmu_reset_exit
>> called in exit phase). So I think we are good overall but it is a bit
>> annoying to leave it done only upon guest action in this patch. What do
>> you think?
> Though I didn’t really get the concern here, there is a suggestion to
> move the mmap just after IOMMU_VIOMMU_ALLOC as it doesn't
> need to be tied to VINTF enable.
>
> https://lore.kernel.org/qemu-devel/20260601114221.457995-1-skolothumtho@nvidia.com/T/#m972247a4652b09e3d86def921d9a8551b7620341
>
> If we do that it will keep mapped until VIOMMU is alive. 
> Does that address the concern above?
my concern is the munmap shall be eventually done on exit even if the
guest does not issue the associated command, no? This is done later in
the patch that introduces the reset. My concern is about patch
sequencing. I think this is unrelated to Nicolin's suggestion.

Thanks

Eric
>
> Thanks,
> Shameer
>
>
>
>


