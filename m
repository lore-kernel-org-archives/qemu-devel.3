Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BB1C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 19:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRbjZ-0000dp-KH; Tue, 17 Jun 2025 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uRbjX-0000d4-8e
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uRbjU-0003Vq-Lc
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750187549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gygR1+tTMe1iS51p2byOm8gyoI1notM5PdioMtDYE/k=;
 b=LqDcuUu++/94uuMSVyXUaDvLhWXtxw8Enzb0T8cVV6VPICGWHO7zKPyb89iohYa3s2RtsS
 1n39rf0mmnYc4J45Tql3yJMJp/H5sXxqJHtghGoP/nLMsAIKbUQrPLk8zPN2lBBJLEBNoI
 KhSWFtky4hZ5k+SP17p0qNG3C6f0Nd0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-Ap4m3pOtPUq7qRWGaEOCpg-1; Tue, 17 Jun 2025 15:12:27 -0400
X-MC-Unique: Ap4m3pOtPUq7qRWGaEOCpg-1
X-Mimecast-MFC-AGG-ID: Ap4m3pOtPUq7qRWGaEOCpg_1750187546
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-234b133b428so44844585ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 12:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750187546; x=1750792346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gygR1+tTMe1iS51p2byOm8gyoI1notM5PdioMtDYE/k=;
 b=A8rGzZ7JJZ89H9MJHMG8uV/wiZXqfFMEgQCvL3Xlwo9dmsB+wghZWL4SVdSamGYOOY
 reUyO7dqNL3M46AMEiv8O/SBoBP8xzI5v3A0qnUiEPgG+vIofDQqhM2iK4fcj0QGa+d8
 v5nrC2I0K90qOAHxdLhsQBM8zxQgTgHvRgKzcHe6I7ACVKpFBIEr5fEswSXiOW5rs+/e
 K2tdcLNAPiV62gmld5kkm2f9OcbCUUQgmYfIigmyouAK9Xk13S3dtq16+8PfetXSZ1Vg
 5/Y1FaksKl+vsI4xPGJeQT1boZUf2SnwIr/qRvGRXqFeUyoUDq1VHSq00APsJ+CLkG0S
 dctg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsozKFCrISSz5m0DcztKKKivmHeJzXlGzf+MNZYP2PwKMbMAMmP9NkGpklVfuGqtLIXMFfPm4SutoM@nongnu.org
X-Gm-Message-State: AOJu0YwgO8lPkbyYNiFomQkdxwrsRajX4JloSi3PwgtYkA8D4wl32ZiY
 bkC95j2HHXhI2CVOUxNHHkNRpTgetQnz/PwysNG8JwscS11hCd0QoGA+UU4AOl9v3/Kct5s/F89
 lvP12GcmWDipz1WYJrujecCl7GOL/qGT3cytsOkYfexJVeXkO40n2CK2l
X-Gm-Gg: ASbGnct81XfZuh7G9JIPvZpPARzUOcDqEZ7oaC4sM0krNO9WEJ7tB/Fp31vT5fxVMl7
 XCsoSPx0/FBiHYXOR8Is2N++fVYuntg1sgihmGOc05dQz5NluQo3R6mpjXYViOgF6BrnbhNQkkn
 22e10eF/bNNc6xRLjkWovuzjpJW/Nbt5RdFEYi3KY/Y56++JChcWv2Q0uI0zqzyu9FjEYX0QROl
 XM80xbE5TwjDlZ9loiF3n4g5X9fQgTtQbuVgXaKlnNTPMxe47CxIxxmZ5yBy34Q9FogasdHuvty
 TcTwP6oYEVJrcygmcwTSenI=
X-Received: by 2002:a17:902:cec6:b0:234:9052:2be6 with SMTP id
 d9443c01a7336-2366b145439mr219343145ad.41.1750187546404; 
 Tue, 17 Jun 2025 12:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGABPhqJqhEoRPTe5fIBvTVzJGgWNwcxDl2RKmNsaKDWjDs/0Ocne2XKxf7QDAXMgOCvx143g==
X-Received: by 2002:a17:902:cec6:b0:234:9052:2be6 with SMTP id
 d9443c01a7336-2366b145439mr219342785ad.41.1750187545999; 
 Tue, 17 Jun 2025 12:12:25 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236934a9be9sm17241315ad.47.2025.06.17.12.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 12:12:25 -0700 (PDT)
Message-ID: <942c316e-47d4-4337-992b-d7bfb67810ae@redhat.com>
Date: Tue, 17 Jun 2025 15:11:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linuxarm@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 berrange@redhat.com, imammedo@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, zhangfei.gao@linaro.org
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250617175247.00007d43@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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



On 6/17/25 12:52 PM, Jonathan Cameron wrote:
> On Tue, 17 Jun 2025 09:49:54 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> On 6/16/25 12:20 PM, Jonathan Cameron wrote:
>>> On Fri, 13 Jun 2025 15:44:43 +0100
>>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>>>   
>>>> Although this change does not affect functionality at present, it is
>>> Patch title says PCIe.  This check is vs PCI host bridge.
>>>
>>> No idea which one you wanted, but if it is PCIe needs to be
>>> TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
>>> I think.
>> I think we need TYPE_PCI_HOST_BRIDGE as we want to check against pxb
>>
>> pci-bridge/pci_expander_bridge.c:    .parent        = TYPE_PCI_HOST_BRIDGE,
> 
> Hmm. That's awkward and I'd forgotten that wrinkle.
> Need a stronger test but which one?  The PXB root bus has a parent of
> TYPE_PCIE_BUS.  Maybe we can check that?
> 
Yeah, rooted in the problem that we should have pci-switches or pci-rp's,
not just 'pxb'.


> 
>>
>> Besides the commit title/desc suggested by Jonathan you may also refine
>> the error msg which can stem now from 2 different causes
>>
>> Thanks
>>
>> Eric
>>>   
>>>> required when we add support for user-creatable SMMUv3 devices in
>>>> future patches.
>>>>
>>>> Tested-by: Nathan Chen <nathanc@nvidia.com>
>>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>>> ---
>>>>   hw/arm/smmu-common.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>>> index f39b99e526..7890aa12c1 100644
>>>> --- a/hw/arm/smmu-common.c
>>>> +++ b/hw/arm/smmu-common.c
>>>> @@ -20,6 +20,7 @@
>>>>   #include "trace.h"
>>>>   #include "exec/target_page.h"
>>>>   #include "hw/core/cpu.h"
>>>> +#include "hw/pci/pci_bridge.h"
>>>>   #include "hw/qdev-properties.h"
>>>>   #include "qapi/error.h"
>>>>   #include "qemu/jhash.h"
>>>> @@ -937,7 +938,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>>>>                                        g_free, g_free);
>>>>       s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>>>>   
>>>> -    if (s->primary_bus) {
>>>> +    if (s->primary_bus && object_dynamic_cast(OBJECT(s->primary_bus)->parent,
>>>> +                                              TYPE_PCI_HOST_BRIDGE)) {
>>>>           pci_setup_iommu(s->primary_bus, &smmu_ops, s);
>>>>       } else {
>>>>           error_setg(errp, "SMMU is not attached to any PCI bus!");
>>
>>
> 


