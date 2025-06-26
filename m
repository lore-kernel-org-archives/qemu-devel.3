Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38554C7EE2A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 02:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUbzL-0002J4-EM; Wed, 25 Jun 2025 22:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUbzJ-0002Ic-Ks
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 22:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUbzH-00009o-TK
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 22:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750903515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsVwtbTXgN1sTCzxD8a29D3ttCsgaT/KYDol/Mtl0o8=;
 b=hGvum1sO8RD77nZPsSRoFHAPVnnshTu2Y9ej+1c+SNaBhNSgyLHfQXq8GfuPPh3n/ETYTP
 nWm20TqucAG5Du/YVkujpIjhBioTSfA76Hg+mbCQDJRsyXDM10t1SQ5g+7bLmfgGl7+H78
 XEbboySVwlcxXbxWJ2pKq2J6xgV9jAQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-EOh29H34MB-gdWjAUmkeuA-1; Wed, 25 Jun 2025 22:05:13 -0400
X-MC-Unique: EOh29H34MB-gdWjAUmkeuA-1
X-Mimecast-MFC-AGG-ID: EOh29H34MB-gdWjAUmkeuA_1750903508
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b31e1ef8890so275298a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 19:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750903508; x=1751508308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CsVwtbTXgN1sTCzxD8a29D3ttCsgaT/KYDol/Mtl0o8=;
 b=P84C7tCaXkAY1J5ZMJPJbZ7qG7le92FIYqfeKqiiDr91eqNpXswKkPIqseA5IUJAmi
 bC7rILhNmPFPhdW3DOw8mpXUw+nlmEZyBuT3VLIwwQSatI0adI1j0Qb0HbfIR6evM3E6
 vgy+Cp48crTvCCCCyzFsCwUCo/dtSgVWKiI1wjjn0bEUevMt6/GSWFFAfZoRqopXeKHz
 vNfHsnUm6L/GDyLjttOVqi9oByozNpXIHVs3fGY5YsAbaR690Cjr4BFiQuAmc3F+8eQs
 e4UH3wnqfR94wUoGquLyco+CbjNI7PwEGExY8BKNBp6P3YTXV0PtYttPdcL1RwHOg87e
 yhlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNk0ARjWDLfmMxyzaoWIfGJgJlr8SZp7EXaWERYuP4tcEjUL/EOukeJGoQ4Z7GbSEpZpGHA63KZ2eq@nongnu.org
X-Gm-Message-State: AOJu0Yxx9FQ9eYp6pGwlWQHCIMOiuFyeFdQuholnlKTRwy95B7KNTFJn
 s3r0D68WU7e0y4XUj80Xe2lHDCUkP8IztMhG/j8NPZXW13yScZIULF8LNf1r+DVBZKqc1UfJL1A
 D/xCzUYm13TrYULdApXs4XrjFELQOe4qYLh9aH89xoId8Lqk6psYN5fVY
X-Gm-Gg: ASbGncsoWCh0qLv+g/7y8YJRmGnD0/TeGARPCZGfQUJQhmFKggoK2+nsbLsTGTGxDTw
 1tcNXUNA3T0X/1qXAk/agefaecg/lpRMPNh6kKCw7MifTlc7iDLfoK8Gg/zOtKAnBRxBX1+Lg2d
 OhTA//yCziJ4D0XOePs5ZUlM1u9hy0t2gvcTp5qFXSvq8PruW+UcB0g4uXv8KHFV2O1J6ocO+V4
 k55GHKQ5hqhPHnRJuKVdRMuWnFRCxkVix5MYrJdgH7LegMNpH/cLY6i3EYzxrNVT/RVRRIkZmTP
 lOubiErdZ3ZcxWMNj6iinnvnajo=
X-Received: by 2002:a17:903:1664:b0:234:e655:a618 with SMTP id
 d9443c01a7336-2382403e012mr72256835ad.25.1750903508151; 
 Wed, 25 Jun 2025 19:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHelO7mdUh0svdHc4xpgyydIZqdRSEIgld+yf0B+DhC0qVL8vwyAQ7bpgC8y5sBT1II1U7bwA==
X-Received: by 2002:a17:903:1664:b0:234:e655:a618 with SMTP id
 d9443c01a7336-2382403e012mr72256515ad.25.1750903507787; 
 Wed, 25 Jun 2025 19:05:07 -0700 (PDT)
Received: from [10.72.116.141] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d839389esm145484855ad.41.2025.06.25.19.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 19:05:07 -0700 (PDT)
Message-ID: <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
Date: Thu, 26 Jun 2025 10:05:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
 <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 6/23/25 5:20 PM, Eric Auger wrote:
> 
> 
> On 6/17/25 5:05 AM, Shaoqin Huang wrote:
>> Set the "use-legacy-x86-rom" property to false by default, and only set
>> it to true on x86 since only x86 will need it.
> s/compatatibility/compatibility in the title

Ok. Will fix it.

>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   hw/display/ramfb-standalone.c | 2 +-
>>   hw/i386/pc_q35.c              | 3 +++
>>   hw/vfio/pci.c                 | 2 +-
>>   3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index af1175bf96..ddbf42f181 100644
>> --- a/hw/display/ramfb-standalone.c
>> +++ b/hw/display/ramfb-standalone.c
>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>   
>>   static const Property ramfb_properties[] = {
>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>>   };
>>   
>>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index fd96d0345c..f6d89578d0 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -45,6 +45,7 @@
>>   #include "hw/i386/pc.h"
>>   #include "hw/i386/amd_iommu.h"
>>   #include "hw/i386/intel_iommu.h"
>> +#include "hw/vfio/pci.h"
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/display/ramfb.h"
>>   #include "hw/ide/pci.h"
>> @@ -67,6 +68,8 @@
>>   
>>   static GlobalProperty pc_q35_compat_defaults[] = {
>>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> this will only keep the legacy behavior along with q35 machine type but
> not on other machines being used for x86. what about pc-i440fx? Doesn't
> it apply to it as well? Are there other machine types also impacted.

Ok I will also add it with pc-i440fx. I think only q35 and i440fx are 
impacted.

> 
> Also what about Daniel's comment in v3:
> https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
> "For non-x86, historical versioned machine types will need
> likely it set to true, in order to avoid the memory layout
> being changed IIUC."
> 
> Is it actually needed?

If those machine types need to set it to true. I think they can set it 
after they have this property.

Thanks,
Shaoqin

> 
> Thanks
> 
> Eric
>>   };
>>   static const size_t pc_q35_compat_defaults_len =
>>       G_N_ELEMENTS(pc_q35_compat_defaults);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ff0d93fae0..a529500b70 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };
> 

-- 
Shaoqin


