Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqof-0007Ea-PX; Tue, 26 May 2026 08:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqob-0007ED-1C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqoZ-0002jl-0J
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779798198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcWiWnssDtm0NRgR5p21ra5xS/uoQBhKYvYOhGUUuHI=;
 b=MOwf5Fe4o6LO1cTHP5TAuiPOvJIUNSzN72n89CiEW0ZkH2NzK5DFRkx6QkPa6rE9S/ebmR
 UFBJJo8xhTDhmJQjDbu8Jg7TvpsbOx8DrkTf9RfQqV1wDb2ZIa/ujg8jCHPYwdV04yw7qW
 +fyushPxVxcEyNUkdUW6wO3ZpBKEzrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-E9Az_4nhNXamkvTAhI2xdQ-1; Tue, 26 May 2026 08:23:15 -0400
X-MC-Unique: E9Az_4nhNXamkvTAhI2xdQ-1
X-Mimecast-MFC-AGG-ID: E9Az_4nhNXamkvTAhI2xdQ_1779798194
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4411a36715dso6855992f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798194; x=1780402994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcWiWnssDtm0NRgR5p21ra5xS/uoQBhKYvYOhGUUuHI=;
 b=GlZyXcCU15bxwff5/VA0v7RE/WMUDjtK440s222Ok8WWGRdGK8kg2cllG0hrZqB91u
 Cf4qjsWJg0icfigjrArHWBAHtYBKQJ4urO2q87Odw8K+Ukd4dcovltnII52ybLX4Sx3N
 iJq24pEFHQ/sPevOkXs9Ls3IIzwdmQKat/Dxv7BFdBK7eMSUDHsD7weDhUNY64zaIzU2
 VI/1OZzcApnrStmSihzfWZZvBUH2HkRv1geb78gg/KkIdAyM3HBFub0U+2rXkDRV1LmD
 0mUEjZzYTPap72WZYHO9Zj4o3Jzo6LFjgqnfxctdG4sebR1rLa6aY2UT0xTL5o/SLLVu
 vo8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NvPqItGOCGi74fFWA6tmk9naBJJhXGFbz/Ie1o7YBr5deK2JeWOe7hCzebeI010Xn1G0Lo3uIfWiP@nongnu.org
X-Gm-Message-State: AOJu0Ywz9y41xYCXFPxK9HggXAWwEa1eZcjceVLmoBIay3UMpYrPFfo5
 WwZjQJ7INaHEBBYsfFXvpZjdAee4FsCuIwG5+KyV9YI0V33+CCZQbnHZwJMx2dJeUeQD0bLIg3Q
 LDMr36RUjkM4chEDZngLola4SndeNwg5QrUS1zrZpZ2SLBQBTfsXBYVsF
X-Gm-Gg: Acq92OH7bRIMemFG6k6xNBPLORZpaGpaNHIu+lhylCTdSNaV9OHKFAsYUL1I/oKyEOK
 Yq4N5BABMRKiZ6E32f5PO85+E4ZUM62bKtCScj/hwo/g/C9n8trxIo9rSJVI2lUEBG9CJ7ic22h
 bTqUajYDCw2fGTPkF3Sjemj7M4EZiHPh30RChhfTnSRT3bqI4/4BIaZIW5v4yeaf/t4Ltw9NwKM
 Xx/Fl+RZQ8qv1bz2nUl1JyYM7DE+s+pzwk7yBWRYZMcq+UNa4TFv2jucBs9rBQFFwTqvexdi+W5
 AFAmOmM446AM7N7V/wlRh7VXUn7PXrT8DKHjwE6qzSPTggIUgyEeU1QZm2mpDgXFLh5a7jAHCVo
 ZeARcWVGK5Qqu+KJSWuQjr8Aei2zIiZzv5TD9Q6QjNTdYlXRZ7ddY8spZocJ6RXN0yXomUxPw/j
 Kjf2L0
X-Received: by 2002:a5d:6f18:0:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-45eb38a83bbmr32103736f8f.6.1779798193913; 
 Tue, 26 May 2026 05:23:13 -0700 (PDT)
X-Received: by 2002:a5d:6f18:0:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-45eb38a83bbmr32103687f8f.6.1779798193377; 
 Tue, 26 May 2026 05:23:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm35208408f8f.24.2026.05.26.05.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:23:12 -0700 (PDT)
Message-ID: <16a8a487-9998-4e36-9fc6-897c1bcc4ced@redhat.com>
Date: Tue, 26 May 2026 14:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/32] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
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
 <20260519103727.899332-25-skolothumtho@nvidia.com>
 <8183d160-d588-4124-886d-a37dc4f92620@redhat.com>
 <CH3PR12MB75483B20E508737D529F1214AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75483B20E508737D529F1214AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/26/26 11:51 AM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 26 May 2026 09:27
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>; phrdina@redhat.com
>> Subject: Re: [PATCH v5 24/32] hw/arm/tegra241-cmdqv: Read and propagate
>> Tegra241 CMDQV errors
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 5/19/26 12:37 PM, Shameer Kolothum wrote:
>>> Install an event handler on the CMDQV vEVENTQ fd to read and propagate
>>> host received CMDQV errors to the guest.
>>>
>>> The handler runs in QEMU's main loop, using a non-blocking fd registered
>>> via qemu_set_fd_handler().
>>>
>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.c | 60
>> +++++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/trace-events     |  1 +
>>>  2 files changed, 61 insertions(+)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index 853c548e58..0bba2c1801 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -14,6 +14,7 @@
>>>
>>>  #include "hw/arm/smmuv3.h"
>>>  #include "hw/arm/smmuv3-common.h"
>>> +#include "hw/core/irq.h"
>>>  #include "smmuv3-accel.h"
>>>  #include "tegra241-cmdqv.h"
>>>  #include "trace.h"
>>> @@ -736,6 +737,48 @@ out:
>>>      trace_tegra241_cmdqv_write_mmio(offset, value, size);
>>>  }
>>>
>>> +static void tegra241_cmdqv_event_read(void *opaque)
>>> +{
>>> +    Tegra241CMDQV *cmdqv = opaque;
>>> +    IOMMUFDVeventq *veventq = cmdqv->veventq;
>>> +    struct {
>>> +        struct iommufd_vevent_header hdr;
>>> +        struct iommu_vevent_tegra241_cmdqv vevent;
>>> +    } buf;
>>> +    Error *local_err = NULL;
>>> +
>>> +    if (!smmuv3_accel_event_read_validate(veventq,
>>> +                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
>>> +                                          &buf, sizeof(buf), &local_err)) {
>>> +        warn_report_err_once(local_err);
>>> +        return;
>>> +    }
>>> +
>>> +    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
>>> +        cmdqv->vintf_cmdq_err_map[0] =
>>> +            extract64(buf.vevent.lvcmdq_err_map[0], 0, 32);
>>> +        cmdqv->vintf_cmdq_err_map[1] =
>>> +            extract64(buf.vevent.lvcmdq_err_map[0], 32, 32);
>>> +        cmdqv->vintf_cmdq_err_map[2] =
>>> +            extract64(buf.vevent.lvcmdq_err_map[1], 0, 32);
>>> +        cmdqv->vintf_cmdq_err_map[3] =
>>> +            extract64(buf.vevent.lvcmdq_err_map[1], 32, 32);
>>> +        /*
>>> +         * CMDQV_CMDQ_ERR_MAP and VINTF0_LVCMDQ_ERR_MAP are
>> distinct
>>> +         * registers (different MMIO offsets). With only VINTF0 exposed
>>> +         * they carry the same data, so mirror.
>>> +         */
>>> +        for (int i = 0; i < 4; i++) {
>>> +            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
>>> +        }
>>> +        cmdqv->vi_err_map[0] |= 0x1;
>>> +        qemu_irq_pulse(cmdqv->irq);
>> I don't see SMMU_CMDQV_VI_ERR_MAP_0 updated anywhere. If I
>> understand
>> correctly, if you get an error on any VCMDQ you should update it.
> This one above does that:
> cmdqv->vi_err_map[0] |= 0x1; it sets bit 0, which is the
> error bit for VINTF0 (the only VINTF QEMU exposes).
>
> I will add a comment to make it clear.
Ah OK. Let's add a comment then.

Eric
>
>  Also
>> the triggering of the irq should depnd on SMMU_CMDQ_VI_INT_MASK0, no?
> Right. will add:
>
> if (!(cmdqv->vi_int_mask[0] & BIT(0))) {
>         qemu_irq_pulse(cmdqv->irq);
>     }
>
> Thanks,
> Shameer
>


