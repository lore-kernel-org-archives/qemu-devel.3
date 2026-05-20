Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA299CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfiV-0000fR-AK; Wed, 20 May 2026 08:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPfiI-0000cW-0W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPfiF-0005o2-VT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779278865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN42IBfyXnJUM2cD0Bm5P7r/NowDgDYcr0jUKHtffx8=;
 b=SPpMwjqXvSeUIkeJp4y53ODJsajjM5LThBBf12ge6cGrXSGLYlS8QaPyx9CXrBnjOUvgqy
 H/AA2d46hwCzPj+9teULTjwFLiJPedPZdWqqo6kFgcqTYu5jdWy9QA72CpOp1i5GAFysBH
 EyXg46tATYgakzfTpLCU0Tjw0RwSnFQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-pR3mXbvaPRKMukYT7phfuw-1; Wed, 20 May 2026 08:07:43 -0400
X-MC-Unique: pR3mXbvaPRKMukYT7phfuw-1
X-Mimecast-MFC-AGG-ID: pR3mXbvaPRKMukYT7phfuw_1779278863
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so3980195f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779278863; x=1779883663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gN42IBfyXnJUM2cD0Bm5P7r/NowDgDYcr0jUKHtffx8=;
 b=fqlCa+Gb6KLItC2oCGbZyG4dhO15rgEoS82spaRm224qxtIq9z7NEiVMmErmCygi+U
 Xn3FIe1CGuVG/94CtQ8JZhhqBakpsYq4QBJl4m9eb+2+BsgpBriLfUqgETv5uryxnFli
 TxjvIl78uJbsm2A6wGn98cM9T6jrdieA5uS+1ukO6x/93ekohlOp9f9L14ALLBI4cuRk
 qI7CmK8xWDTtXwLsjRIGPO70YM6Nwg/lfjef0KbggEuCxEHv7rsHcjMwgMKroS+Jhs8T
 U9If8GA+xi2s/oj9saRFYtZEqZI58yV4FhdNzbuNYd3w60hq8dYNjop95Cf/kjpmdFIW
 0jIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5R20i/elYBcGYbtJgI7v8phedjl/zvPqS7pN/N6n9ksMhY+PTuYG3EFY0MZyl5/HBNjo3jgobtvgy@nongnu.org
X-Gm-Message-State: AOJu0YyXnZBCKs+u9hCbljZRt4UValTcmJKsMUmrOKeXS5RY6LnnDAD+
 SvYX/iCtENwoqh5Fgyfln87uD4vI9G0QMUxqknxOUa+QQM/RMbmy/zQoTswbPckq9y2dZJl9xDy
 ucPCoimMJx5jY7cSZTNymnIMj1upvNvlIXPnJTwMw9SOjytif35VWUzbn
X-Gm-Gg: Acq92OEVdtDsficbC5tlC6RjnjydjWZg8dXdt2Ua3qpBkF1D1N0XcvoEr8xb4DOU6+/
 DaNLZJVXTWc2QNESah/UxkXDVPNpbVxTZrb9BzSgLld9fhDkCGmKs6qD+gMnN/qboSavSXqpd8A
 Mg1QjYSqMd6e7WNR7yqhknqttW8KTAN9AWuwHHEeY7PTYSAx2QwRvV9w0acc3gDDvb8o5jL+khH
 zRepXCtgxnoDlm3EQv7x5unDdkuMvtgKwl469j2fM2Msj3Sx1y0aor0lCQ0a4g3P4vHVj0YmsB4
 Qud8Q5EOBsonbyWlTRJ/p3L7ezfMEQ7buZJnhFcGUMf0nmU0Ri8xq7ZZZ3301ZDB6wTeLJ0qb2K
 UoTzCdcoY5l1VWRzkoQnFiEb+CKUQnPoZ/LWF3kW2hwK8pthFy/wPdHQK9HpOd8gNQZUc/g==
X-Received: by 2002:a5d:588f:0:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-45e5c5aefe4mr37464353f8f.10.1779278862284; 
 Wed, 20 May 2026 05:07:42 -0700 (PDT)
X-Received: by 2002:a5d:588f:0:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-45e5c5aefe4mr37464156f8f.10.1779278860887; 
 Wed, 20 May 2026 05:07:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm50403675f8f.0.2026.05.20.05.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:07:40 -0700 (PDT)
Message-ID: <2d49ceda-4416-4044-8323-18104cc52e1d@redhat.com>
Date: Wed, 20 May 2026 14:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
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
 <20260519103727.899332-17-skolothumtho@nvidia.com>
 <73b4f204-41d5-4997-8d02-5fc9ba3d0c67@redhat.com>
 <CH3PR12MB7548A230C9165D12CDD2EEF2AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548A230C9165D12CDD2EEF2AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/20/26 11:54 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 20 May 2026 08:54
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ
>> register writes
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 5/19/26 12:36 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> This is the write side counterpart of the VCMDQ read emulation. Add
>>> write handling for both the direct VCMDQ aperture and the VINTF
>>> logical aperture using the same index decoding and VINTF-to-VCMDQ
>>> translation logic as the read path.
>>>
>>> VINTF aperture writes are translated to their direct-aperture
>>> equivalent and update the same cached state. Page 1 registers
>>> (BASE, CONS_INDX_BASE) always update the cache. Once
>>> IOMMU_HW_QUEUE_ALLOC and viommu_mmap are wired up in a
>> subsequent
>>> patch, Page 0 register writes will be forwarded to the hardware-
>>> backed mmap'd page.
>>>
>>> Ignore VCMDQ BASE writes if the VCMDQ is already enabled.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.c | 164
>> +++++++++++++++++++++++++++++++++++++++-
>>>  hw/arm/trace-events     |   2 +
>>>  2 files changed, 164 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index f859126ad6..5d2d9d2e26 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -16,6 +16,16 @@
>>>  #include "tegra241-cmdqv.h"
>>>  #include "trace.h"
>>>
>>> +/*
>>> + * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
>>> + */
>>> +static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
>>> +{
>>> +    uint32_t status = cmdqv->vcmdq_status[index];
>>> +
>>> +    return status & R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +}
>>> +
>>>  /*
>>>   * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
>>>   *
>>> @@ -116,6 +126,108 @@ static uint64_t
>> tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>>>      }
>>>  }
>>>
>>> +/*
>>> + * Write a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
>>> + *
>>> + * The caller normalizes the MMIO offset such that @offset0 always refers
>>> + * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
>>> + *
>>> + * Page 0 registers are all 32-bit; this helper is only called for 4-byte
>>> + * writes.
>>> + */
>>> +static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV
>> *cmdqv,
>>> +                                             hwaddr offset0, int index,
>>> +                                             uint32_t value)
>>> +{
>>> +    switch (offset0) {
>>> +    case A_VCMDQ0_CONS_INDX:
>>> +        cmdqv->vcmdq_cons_indx[index] = value;
>>> +        break;
>>> +    case A_VCMDQ0_PROD_INDX:
>>> +        cmdqv->vcmdq_prod_indx[index] = value;
>> so there is no cmd consumption triggered by an increment of the producer
>> index as opposed to std smmu emulation. This shall at least be explained
>> in the commit msg and maybe in the code, + the justification. It is a
>> bit strange to emulate the MMIO accesses while not doing anything
>> functional out of them.
> There is indeed a difference here w.r.t. std SMMU emulation. CMDQV
> is a hardware-accelerated feature, and   there isn't much value in emulating
> the queue functionality without the HW backing.
>
> From Spec, p.176:
>
> "While the software can program the Virtual CMDQ(s) directly using the direct
> VCMDQ aperture  (and not through the Virtual Interface), it is required that the
> VCMDQ be allocated to a Virtual Interface before it is used to send commands
> to the SMMU"
>
> So no actual command processing can happen until the VCMDQ is allocated to
> a Virtual Interface. Until then, reads/writes only update the register cache.
>
> I will make this clear in the commit log.

Yes this helps
>
>>> +        break;
>>> +    case A_VCMDQ0_CONFIG:
>>> +        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
>>> +            cmdqv->vcmdq_status[index] |=
>> R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +        } else {
>>> +            cmdqv->vcmdq_status[index] &=
>> ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>>> +        }
>>> +        cmdqv->vcmdq_config[index] = value;
>>> +        break;
>>> +    case A_VCMDQ0_GERRORN:
>>> +        cmdqv->vcmdq_gerrorn[index] = value;
>> shouldn't it do something functional besides storing the value
>> on std SMMU we resume consuming cmds. interaction with interrupts,
>> CONS_INDX?
> Same rationale as above. In the pre-allocation state there is no real queue
> function to drive, so there is nothing functional for QEMU to do on a GERRORN
> write.
also I would add a comment in the code
>
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP,
>>> +                      "%s unhandled write access at 0x%" PRIx64 "\n",
>>> +                      __func__, offset0);
>>> +    }
>>> +    trace_tegra241_cmdqv_write_vcmdq_page0(index, offset0, value);
>>> +}
>>> +
>>> +/*
>>> + * Write a VCMDQ Page 1 register (base / DRAM address) - 4-byte access.
>>> + */
>>> +static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV
>> *cmdqv,
>>> +                                             hwaddr offset0, int index,
>>> +                                             uint32_t value)
>>> +{
>>> +    switch (offset0) {
>>> +    case A_VCMDQ0_BASE_L:
>>> +        if (tegra241_vcmdq_enabled(cmdqv, index)) {
>>> +            return;
>>> +        }
>>> +        cmdqv->vcmdq_base[index] =
>>> +            deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
>>> +        break;
>>> +    case A_VCMDQ0_BASE_H:
>>> +        if (tegra241_vcmdq_enabled(cmdqv, index)) {
>> where is it documented in the spec? I don't see this restriction in the
>> reg doc. Then "Enabling the virtual CMDQ" paragraph describes a std
>> setup but does not say - afaics- that it should be ignored -
>> worth commenting
> Right. I don’t think it is explicitly there in the spec.
>
> However, Nicolin mentioned about such a restriction during v4 discussion:
> https://lore.kernel.org/qemu-devel/afuF+sJtEApWisp+@nvidia.com/
>
> AFAICS, it looks like an implied assumption based on the "Enabling the virtual
> CMDQ" sequence or I missed it.
>
> I will double check.
OK

Thanks

Eric
>
> Thanks,
> Shameer


