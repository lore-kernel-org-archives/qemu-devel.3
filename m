Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9650C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4UT-0001ac-1K; Fri, 27 Jun 2025 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uV4UK-0001ZO-BP
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uV4UF-0003CE-HL
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751013061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9vNAbrfTapzjaXOc4keS/GfzjK59G3vSxEWRyMAHZo=;
 b=Vs/utAAqGSOHVbIRi6jl8FN4A1Bgz0cPh94NhrmBqHs4EQmq8WX0D+RSQUCxBkwEGrlpme
 LIPXk1wcrKtAtW75QMERUslpr2qw/85loNbv85sJzCzLFnFgM96Fa+KH5A0yNC3glMMwpN
 BlZsSjSr+ai/zwX2KI0luTQz8TNq4Sw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-3rIvjF2DMee1dotRFzlXSQ-1; Fri, 27 Jun 2025 04:30:59 -0400
X-MC-Unique: 3rIvjF2DMee1dotRFzlXSQ-1
X-Mimecast-MFC-AGG-ID: 3rIvjF2DMee1dotRFzlXSQ_1751013059
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so3573545a91.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 01:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751013059; x=1751617859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9vNAbrfTapzjaXOc4keS/GfzjK59G3vSxEWRyMAHZo=;
 b=tK7AzhWle2HRq9r9cldLQ9Z9Qk/4kuHm9ui3ujJIwyxkMuK5oG5cXJSrhxNGBAc5a1
 tMTJSPMOuTZJoQbKm9wACX4tiQcWpnR35Cd0LA7RK7A6vq8uooIv8XSxRlQFnQEliWAz
 cD59e7RiDb0CB1oYE3OvdLtwevUV7v21a6T96d6NPSZUSgCeRkDyiJj/BWdhr1bPhxgv
 lVVVklea5q996fQsyAb7G5jTaMwbgawsnl+NUbrzmwk05pF0SLL7HROwPM8jZAwd4zGy
 rqj+5Q9jdQytRdr5Nmh6Ga02qghZMtO+QJ6O9si2HQJrYIno9isXLKyG6XU3dPXxgK7J
 srkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLzGc4NSu1XAqjj02+Gz6UzK91p5m7QPhu8lrw+JZ8xoT1Np8PXlNNCVIvl8n7ixCC+K9JWCfhQ1Tm@nongnu.org
X-Gm-Message-State: AOJu0Yzf8xkGFCXjdf+rLz21NwqE2xrUOBq9FKyh6YHyEtdtjG+YNaq2
 Z7lcG1jO8/HJpag/xJ3jEctuzzMOM+w4mDJXkTqKtTo05wP8NEdhzRU6BkxVT3zq8z2vyl2p6VE
 l6kxU8GjCYU0zPXUFs/C6qkZZ3S3bwp8aZHeIZPKYL13yViBvwV7rjDFd
X-Gm-Gg: ASbGncu79nhpaP7SHTNQWcGsja9SQ5PMTPGsbTQ5ufv4y7oKtQM+UQxobVXWja3sTY+
 giwh+HV7F/aO81hJD2GJGArfxGUUQ8tVCyqwCc87Yk+luUNJcOq3DwHlhBQ0ZqwLONd5641CiBM
 scMOA74YlF+PMcGpIIp4cUQIaz/QpI6vsn0J8liePfgj1n65b8esGPy1cNhbQ1PPoWAH2ELh8xv
 4lxtXFK9yuMGjZVo8rpMM24sPeY8ldPCYykrTKAv1BEyXHBanqy/aHe1xZd5gAt6NxiloKVq9RI
 1gn4dfdg7K9kmp4yZnDr/wqqiQ==
X-Received: by 2002:a17:90b:3fce:b0:312:1d2d:18df with SMTP id
 98e67ed59e1d1-318c9264529mr2855507a91.23.1751013058777; 
 Fri, 27 Jun 2025 01:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEVMXjgFxzAqgibAZdIYPyXT6tUhoah/Yx+zHYN8j8wT1Ie6AytNINPA/Up8VURegKkTV4JQ==
X-Received: by 2002:a17:90b:3fce:b0:312:1d2d:18df with SMTP id
 98e67ed59e1d1-318c9264529mr2855466a91.23.1751013058435; 
 Fri, 27 Jun 2025 01:30:58 -0700 (PDT)
Received: from [10.72.116.80] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318c14e23aesm1771080a91.31.2025.06.27.01.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 01:30:57 -0700 (PDT)
Message-ID: <3000f15b-9296-44ac-81aa-c95b7c6d3a7e@redhat.com>
Date: Fri, 27 Jun 2025 16:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org,
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
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
 <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
 <0d59875a-88a0-41f2-99d4-4e7a19de0e14@redhat.com>
 <aF5FD-mvsh5-eMcX@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <aF5FD-mvsh5-eMcX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Daniel,

On 6/27/25 3:15 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 27, 2025 at 01:37:55PM +0800, Shaoqin Huang wrote:
>> Hi Eric,
>>
>> On 6/26/25 4:01 PM, Eric Auger wrote:
>>>
>>>
>>> On 6/26/25 4:05 AM, Shaoqin Huang wrote:
>>>> Hi Eric,
>>>>
>>>> On 6/23/25 5:20 PM, Eric Auger wrote:
>>>>>
>>>>>
>>>>> On 6/17/25 5:05 AM, Shaoqin Huang wrote:
>>>>>> Set the "use-legacy-x86-rom" property to false by default, and only set
>>>>>> it to true on x86 since only x86 will need it.
>>>>> s/compatatibility/compatibility in the title
>>>>
>>>> Ok. Will fix it.
>>>>
>>>>>>
>>>>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>>>>> ---
>>>>>>     hw/display/ramfb-standalone.c | 2 +-
>>>>>>     hw/i386/pc_q35.c              | 3 +++
>>>>>>     hw/vfio/pci.c                 | 2 +-
>>>>>>     3 files changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-
>>>>>> standalone.c
>>>>>> index af1175bf96..ddbf42f181 100644
>>>>>> --- a/hw/display/ramfb-standalone.c
>>>>>> +++ b/hw/display/ramfb-standalone.c
>>>>>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>>>>>       static const Property ramfb_properties[] = {
>>>>>>         DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,
>>>>>> true),
>>>>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>>>>> use_legacy_x86_rom, true),
>>>>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>>>>> use_legacy_x86_rom, false),
>>>>>>     };
>>>>>>       static void ramfb_class_initfn(ObjectClass *klass, void *data)
>>>>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>>>>> index fd96d0345c..f6d89578d0 100644
>>>>>> --- a/hw/i386/pc_q35.c
>>>>>> +++ b/hw/i386/pc_q35.c
>>>>>> @@ -45,6 +45,7 @@
>>>>>>     #include "hw/i386/pc.h"
>>>>>>     #include "hw/i386/amd_iommu.h"
>>>>>>     #include "hw/i386/intel_iommu.h"
>>>>>> +#include "hw/vfio/pci.h"
>>>>>>     #include "hw/virtio/virtio-iommu.h"
>>>>>>     #include "hw/display/ramfb.h"
>>>>>>     #include "hw/ide/pci.h"
>>>>>> @@ -67,6 +68,8 @@
>>>>>>       static GlobalProperty pc_q35_compat_defaults[] = {
>>>>>>         { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>>>>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>>>>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>>>> this will only keep the legacy behavior along with q35 machine type but
>>>>> not on other machines being used for x86. what about pc-i440fx? Doesn't
>>>>> it apply to it as well? Are there other machine types also impacted.
>>>>
>>>> Ok I will also add it with pc-i440fx. I think only q35 and i440fx are
>>>> impacted.
>>>>
>>>>>
>>>>> Also what about Daniel's comment in v3:
>>>>> https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
>>>>> "For non-x86, historical versioned machine types will need
>>>>> likely it set to true, in order to avoid the memory layout
>>>>> being changed IIUC."
>>>>>
>>>>> Is it actually needed?
>>>>
>>>> If those machine types need to set it to true. I think they can set it
>>>> after they have this property.
>>> nope it does not work like that. In case we really need to take care of
>>> this, this must be handled by compats.
>>
>> If so. Why don't we still keep the "use-legacy-x86-rom" default to true, and
>> only set it to false to those arch which doesn't need it just like my
>> original implementation.
>>
>> Because I don't really know how other arch's memoery layout was impacted by
>> this property set to false. I think keep their original behavior and only
>> change it on arm64 is a good idea.
>>
>> How do you think about it?
> 
> No, the default value of the property shoudl reflect the long
> term desired behaviour - in this case 'use-legacy-x86-rom = false'.

Ok I understand your thoughts.

> 
> We must then reverse this default to 'true' for ALL historical versioned
> machine types on ALL architectures, where this device is built, or any
> specific machines where we want to keep the historical behaviour going
> forward.

But how do we implement that?

Maybe set the 'use-legacy-x86-rom = true' in hw_compat_9_2 ?

I'm not sure about that, could you give some hints about how to reverse 
the default to 'true' for ALL historical versioned machine types?

Thanks a lot.

> 
> 
> With regards,
> Daniel

-- 
Shaoqin


