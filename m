Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB2F1125807
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JTD-0003vI-Ge; Wed, 11 Mar 2026 09:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0JTA-0003uK-L8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0JT7-0001Kg-Py
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773235159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuaAW2AHAYzMhRw5yC3+ESLaUmqtdPfzeYuRui7Kus0=;
 b=h6SCKcGMyhgUqVYYGascxmtl3OrQ4i2wnfjvrO0k6hpsfbNz8MDvM0W0vJVymnp1bCRbGE
 I2QItNMGEFK4FR914z6Y1IOM+VoZ8un8xaARdOMI/DGkjHyl8fcc8NmtX8p7Zr+1H/gWMU
 cRd+vtrxw31jNoHwirx9eGfHlivOczA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-RJicDJSnNKSbuxFYROtCqg-1; Wed, 11 Mar 2026 09:19:18 -0400
X-MC-Unique: RJicDJSnNKSbuxFYROtCqg-1
X-Mimecast-MFC-AGG-ID: RJicDJSnNKSbuxFYROtCqg_1773235157
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485335f4466so32498765e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 06:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235157; x=1773839957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuaAW2AHAYzMhRw5yC3+ESLaUmqtdPfzeYuRui7Kus0=;
 b=xRJQm4B2T5oWL3ne1eaAmqhjhQCY05i3azXbEeJU1eXZ1G2GfVCwAGKE3/NfzThNSW
 4KuTPmDjUenINgzacR83ERSPMAjCH7Uv8X6ERoTtOEX5PwoUs+hoaH/ZWiLvAjheGw1A
 /d7HFJ6a0eQ/Bp3JUfgmib0idDYfWj1v3xDsdWjszb4VsaXmSlYaCF6Shl8LU+pJ2+73
 TKfZxRI2CWNj9c2tOYK+IfsKOp/xwURV/oiaCQ2Dp/vb6DXaoT2aJe4wkyqd7JZ6SMYk
 Cj4dUdPxULTSVdO5XHxgCKNDyYxsAw7vGP08mzzr5WpQCnqH1tBIZiEBYXmqFZPYGWZq
 jFdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmgiMHaGfBa5w1nbuFLs8UxK7OCDV5hmnLcJoq1i+a+9DSZuMP9pO/jzcN4qL3RIx5LGmvM/Gk8b9b@nongnu.org
X-Gm-Message-State: AOJu0YzWUsrsd/PbnwYKUpt1pNiCeSep7GrnxB4NqZBCNAGNV/HVDSSj
 o+3bV8Cm5Uw+OJkV8KcWCiRXFzkD78aYl7gI5l6lOXKIqsQzvPV7bOPz144e8XmM9kskYY6v5rb
 Kdy+YD7/RcFYCbc4WS3hD3coZsQM6fuGDkWe4E9TUPzl6DD4FVbaPrZqu
X-Gm-Gg: ATEYQzxjbGYHaC0BrZ1v2xkAjV8eoNRb6fz/pDKJwfbZ/XSp52wHR+MvGvIzwIbkFWr
 WJZE3FMSlTGb53FtYVs+tk6BJBaPY/ionEBN81e56qkVRdmBKZ4tm3F90ULUTaEfvrxnvt5+fH7
 sgZDMEO8DnGRddJEhRXi8WtFflvrputrJ8Pig79JCqojK9105hai2A8q23eklgK+JC5hncF9MQS
 bQK4KkibR3VkKYxII8EV019VLeUk1TGje4rCeZG4XLjOdvOI9DowtU2LqVtyqeuZ/8Ixqcx16a6
 BsOaoBEDqcoCLSSb5qnZTG+53aa/Gxi1sJXk0kKQ6Wx31WKd4nc2ioaKsV5pmrZBYjqCOgbcJsG
 vlFc5CxbXbG7Ud8GVfwZuAP7iRvkZFlauPPVoiPpeHvbvM2KeM15/Q7tcgCT/D09T7CChuw==
X-Received: by 2002:a05:600c:1e86:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-4854b1112eemr43621665e9.17.1773235157336; 
 Wed, 11 Mar 2026 06:19:17 -0700 (PDT)
X-Received: by 2002:a05:600c:1e86:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-4854b1112eemr43621065e9.17.1773235156834; 
 Wed, 11 Mar 2026 06:19:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f818d4c8sm7409614f8f.7.2026.03.11.06.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 06:19:16 -0700 (PDT)
Message-ID: <641d5a7b-e487-49c5-abcd-4efce4cfd56d@redhat.com>
Date: Wed, 11 Mar 2026 14:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-18-skolothumtho@nvidia.com>
 <22acfd93-72cd-49ca-b2f6-a080bf66104c@redhat.com>
 <CH3PR12MB754885F68C4F08CC39732EB2AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <8ee0ec15-bf22-473e-85f4-96426a9e763d@redhat.com>
 <CH3PR12MB7548CED599FE7D572486BD6AAB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548CED599FE7D572486BD6AAB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/11/26 1:34 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 11 March 2026 10:05
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0
>> for CMDQV
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 3/11/26 10:26 AM, Shameer Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: 11 March 2026 07:55
>>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>>>> arm@nongnu.org; qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>>>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>>>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>>>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>>>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>>>> <kjaju@nvidia.com>; phrdina@redhat.com
>>>> Subject: Re: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF
>> Page0
>>>> for CMDQV
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 2/26/26 11:50 AM, Shameer Kolothum wrote:
>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>>
>>>>> Global VCMDQ pages provide a VM wide view of all VCMDQs, while the
>>>>> VINTF pages expose a logical view local to a given VINTF. Although real
>>>>> hardware may support multiple VINTFs, the kernel currently exposes a
>>>>> single VINTF per VM.
>>>>>
>>>>> The kernel provides an mmap offset for the VINTF Page0 region during
>>>>> vIOMMU allocation. However, the logical-to-physical association between
>>>>> VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
>>>>> to that, the mapped Page0 does not back any real VCMDQ state.
>>>>>
>>>>> When VINTF is enabled, mmap the kernel provided Page0 region and
>>>>> unmap it when VINTF is disabled. This prepares the VINTF mapping
>>>>> in advance of subsequent patches that add VCMDQ allocation support.
>>>> So at some point we transition from something that is purely emulated
>>>> (page 1 global cmdq) to something that is mmapped on a host page. How
>> do
>>>> we transfer the state of the cmdq from one to the other?
>>> Right. If a guest uses both the "Global VCMDQ registers Page0" and the
>>> "VINTF0 Logical VCMDQ registers Page0" interchangeably (and I see
>>> nothing in the spec that forbids this), then we need to keep the two
>>> views in sync.
>> Also assuming the global VCMDQs are accessible and thus used, I guess we
>> shall properly handle the actual commands (equivalent of
>> smmuv3_cmdq_consume()), no?
>> I don't see it done at the moment.
>>
>> By the way, do we want support of VCMDQs in fully emulated mode. I guess
>> it would be sensible?
> Yes, command handling is not implemented now.
>
> Since this is part of the accelerated SMMUv3 feature, I am not sure it
> makes sense to implement full command handling in QEMU and then forward
> the supported invalidation commands back to the host again.
>
> The idea here is to accelerate the CMDQ processing through the hardware.
> I am not sure a guest would have a real use case for VCMDQ in a fully
> emulated mode.

OK but really the whole user model is really confusing. One starts using
a "global" vcmdq and then switches to a logical one.
On real HW I guess they are synced. But on emulation, currently they are
not. Also when the guest is using the global vcmdq, it can
access the registers but they actually do not trigger any commands. This
really needs to be clarified.

Then I understand we want to focus on accel mode but above points need
to be clatified. I just wanted to mention that vcmdq should logically
also work in fully emulated mode (and you seemed to implement a mix
actually when you have emulated access to vi vcmdq) as it replaces the
SMMU standard cmdq, if I understand correctly

Eric


>
> Thanks,
> Shameer
>
>> Thanks
>>
>> Eric
>>> So when the mapping between a global VCMDQ and a logical VCMDQ is
>>> created through the HW_QUEUE ioctl, we should sync the state between
>>> the Global VCMDQ Page0 and the VINTF0 Logical VCMDQ Page0.
>>>
>>> I will double check this.
>>>
>>> Thanks,
>>> Shameer
>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>>> ---
>>>>>  hw/arm/tegra241-cmdqv.h |  3 +++
>>>>>  hw/arm/tegra241-cmdqv.c | 44
>>>> +++++++++++++++++++++++++++++++++++++++--
>>>>>  2 files changed, 45 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>>>> index d379b8860c..3ce9f539ae 100644
>>>>> --- a/hw/arm/tegra241-cmdqv.h
>>>>> +++ b/hw/arm/tegra241-cmdqv.h
>>>>> @@ -18,6 +18,8 @@
>>>>>  #define TEGRA241_CMDQV_MAX_CMDQ            (1U <<
>>>> TEGRA241_CMDQV_NUM_CMDQ_LOG2)
>>>>>  #define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
>>>>>
>>>>> +#define VINTF_PAGE_SIZE 0x10000
>>>>> +
>>>>>  /*
>>>>>   * Tegra241 CMDQV MMIO layout (64KB pages)
>>>>>   *
>>>>> @@ -34,6 +36,7 @@ typedef struct Tegra241CMDQV {
>>>>>      SMMUv3AccelState *s_accel;
>>>>>      MemoryRegion mmio_cmdqv;
>>>>>      qemu_irq irq;
>>>>> +    void *vintf_page0;
>>>>>
>>>>>      /* Register Cache */
>>>>>      uint32_t config;
>>>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>>>> index e1f1562c44..a3767a85a3 100644
>>>>> --- a/hw/arm/tegra241-cmdqv.c
>>>>> +++ b/hw/arm/tegra241-cmdqv.c
>>>>> @@ -151,6 +151,39 @@ static uint64_t tegra241_cmdqv_read(void
>>>> *opaque, hwaddr offset, unsigned size)
>>>>>      }
>>>>>  }
>>>>>
>>>>> +static bool
>>>>> +tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv,
>> Error
>>>> **errp)
>>>>> +{
>>>>> +    if (!cmdqv->vintf_page0) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
>>>>> +        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
>>>>> +        return false;
>>>>> +    }
>>>>> +    cmdqv->vintf_page0 = NULL;
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV
>>>> *cmdqv, Error **errp)
>>>>> +{
>>>>> +    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
>>>>> +
>>>>> +    if (cmdqv->vintf_page0) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu-
>>>>> viommu_id,
>>>>> +                                     VINTF_PAGE_SIZE,
>>>>> +                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
>>>>> +                                     &cmdqv->vintf_page0, errp)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * Write a VCMDQ register using VCMDQ0_* offsets.
>>>>>   *
>>>>> @@ -216,7 +249,7 @@
>> tegra241_cmdqv_write_vcmdq(Tegra241CMDQV
>>>> *cmdqv, hwaddr offset0, int index,
>>>>>  }
>>>>>
>>>>>  static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv,
>> hwaddr
>>>> offset,
>>>>> -                                       uint64_t value)
>>>>> +                                       uint64_t value, Error **errp)
>>>>>  {
>>>>>      int i;
>>>>>
>>>>> @@ -227,8 +260,10 @@ static void
>>>> tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
>>>>>          cmdqv->vintf_config = value;
>>>>>          if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
>>>>> +            tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp);
>>>>>              cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
>>>>>          } else {
>>>>> +            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>>>>>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
>>>>>          }
>>>>>          break;
>>>>> @@ -251,6 +286,7 @@ static void tegra241_cmdqv_write(void *opaque,
>>>> hwaddr offset, uint64_t value,
>>>>>                                   unsigned size)
>>>>>  {
>>>>>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
>>>>> +    Error *local_err = NULL;
>>>>>      int index;
>>>>>
>>>>>      if (offset >= TEGRA241_CMDQV_IO_LEN) {
>>>>> @@ -276,7 +312,7 @@ static void tegra241_cmdqv_write(void *opaque,
>>>> hwaddr offset, uint64_t value,
>>>>>          cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] =
>>>> value;
>>>>>          break;
>>>>>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
>>>>> -        tegra241_cmdqv_write_vintf(cmdqv, offset, value);
>>>>> +        tegra241_cmdqv_write_vintf(cmdqv, offset, value, &local_err);
>>>>>          break;
>>>>>      case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
>>>>>          /* Same decoding as read() case: See comments above */
>>>>> @@ -300,6 +336,10 @@ static void tegra241_cmdqv_write(void
>> *opaque,
>>>> hwaddr offset, uint64_t value,
>>>>>          qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%"
>>>> PRIx64 "\n",
>>>>>                        __func__, offset);
>>>>>      }
>>>>> +
>>>>> +    if (local_err) {
>>>>> +        error_report_err(local_err);
>>>>> +    }
>>>>>  }
>>>>>
>>>>>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)


