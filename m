Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5478CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 05:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV1my-0004ml-Vc; Fri, 27 Jun 2025 01:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uV1mw-0004mS-SV
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 01:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uV1mu-0000tf-Vf
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 01:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751002687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cu4usQ2gQdBazm6/4Ep90beuN7im2paUHjG6ZOfKXEA=;
 b=flb0vDabacMKIEjg4dJ80taihx962wgve6iTaIXZ/fhyFVOwpEUiN6LdquGSEH0r2F/Hlx
 zRN6fQN+D8TDzhny5DlulYFV1V7Y5wK6uVN5RW4L8ezAe3HnnzOJBPd7PTmKgmef0WK3Oa
 6zVIRV4qZLNXe722UlyQBfluPpZ6Bl0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-WyFJFZ5sMHyhCsJkd5bvow-1; Fri, 27 Jun 2025 01:38:03 -0400
X-MC-Unique: WyFJFZ5sMHyhCsJkd5bvow-1
X-Mimecast-MFC-AGG-ID: WyFJFZ5sMHyhCsJkd5bvow_1751002683
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so19796665ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 22:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751002683; x=1751607483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cu4usQ2gQdBazm6/4Ep90beuN7im2paUHjG6ZOfKXEA=;
 b=Pv6Lbdxg1fGSvandd2zvbj9GBqPNzmpA+E1dLP3v19TZT+VQQxINOe7CJtEVZCk58w
 Sc9GQ2DTwnJ3UXgduvP5auRdosF7Rdr7ZA/HWRgIS+YzmX6Ww6FFUC3y3O1/waSGcU4l
 VcZIszr5Gbee7v7msN3eIEtCPJ9Dsuk5ybhBRGDHJ4xq3ix1qr50Fy1ZcXyC2bHwXjMG
 QueTKgeiZZc8IXVe+YLa3YFI+vPy9bH+an7Zg1f6gvwlEiCudjIwccHiPQswWs9OSaUk
 A14GfnzIUoqZZKRl7z72IE33gPSkN3x24e3fmontWcqntuF+mKnxHruGJNyPKiZM/+cY
 TKEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN0oyc5ARyjrwZC8q6+/rZsuErM3w4YrkAVl3Dhq2cSr0gzeDBGsy0JajnC1M69EL8U35ReQGLP2co@nongnu.org
X-Gm-Message-State: AOJu0YwDV9oG9LLUpWROIghkj2f4IcRMRfmMPAHZaxgoP0SzJk0zaKbQ
 tHrCZKvQOBF09IC6PbWOmSo9r5mxPcK91WmbqlneyCH+rTi6s0SJK6RARgaTctCrK4ddfzOq7H2
 Lj3z2jFcOaywSQIXh/T3jwKZAzJrkM/NB7xAeJQrp3RlfRxB/yyctgdNs
X-Gm-Gg: ASbGncu1YklMJSi9LW1Dn/9w4h9Ij1QNtwzHRzE7f5XQJ7bbk+WLvxCHc0BjSiREWdY
 oRkjq2riaqr0iYOshxTzDltc4Yu/74GP9KtMuAUK4/Qau8hIKiMxSYtF2bpR7icKTSUN4UJKfW1
 5PD40dVqZO56N0SVy+UXjD3ucxcFPeKgg7kxE/W0vCAf/fqGC/Gd5yYOuZS0HfDgVs4+fEGvUWs
 gc1f6t9a5cGGVseCEJCS5gZivasu48xYKhFfZF9IrplmQFWOJa22UFjeY0xAyTtXfTWqAbyD8Wb
 3lUjSDDol5QUgMqWcmqSIZpDyA==
X-Received: by 2002:a17:902:e54b:b0:234:a66d:ccf5 with SMTP id
 d9443c01a7336-23ac463faeamr30548245ad.49.1751002682766; 
 Thu, 26 Jun 2025 22:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuBhmO135o0z3Ow875lJZiiFFghLuUuJuPuD88zVBGs5Qe33d6gVyMbQNTP0tFuMWDh97eug==
X-Received: by 2002:a17:902:e54b:b0:234:a66d:ccf5 with SMTP id
 d9443c01a7336-23ac463faeamr30547915ad.49.1751002682397; 
 Thu, 26 Jun 2025 22:38:02 -0700 (PDT)
Received: from [10.72.116.80] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c49casm7126755ad.215.2025.06.26.22.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 22:38:01 -0700 (PDT)
Message-ID: <0d59875a-88a0-41f2-99d4-4e7a19de0e14@redhat.com>
Date: Fri, 27 Jun 2025 13:37:55 +0800
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
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
 <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Eric,

On 6/26/25 4:01 PM, Eric Auger wrote:
> 
> 
> On 6/26/25 4:05 AM, Shaoqin Huang wrote:
>> Hi Eric,
>>
>> On 6/23/25 5:20 PM, Eric Auger wrote:
>>>
>>>
>>> On 6/17/25 5:05 AM, Shaoqin Huang wrote:
>>>> Set the "use-legacy-x86-rom" property to false by default, and only set
>>>> it to true on x86 since only x86 will need it.
>>> s/compatatibility/compatibility in the title
>>
>> Ok. Will fix it.
>>
>>>>
>>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>>> ---
>>>>    hw/display/ramfb-standalone.c | 2 +-
>>>>    hw/i386/pc_q35.c              | 3 +++
>>>>    hw/vfio/pci.c                 | 2 +-
>>>>    3 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-
>>>> standalone.c
>>>> index af1175bf96..ddbf42f181 100644
>>>> --- a/hw/display/ramfb-standalone.c
>>>> +++ b/hw/display/ramfb-standalone.c
>>>> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>>>      static const Property ramfb_properties[] = {
>>>>        DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,
>>>> true),
>>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>>> use_legacy_x86_rom, true),
>>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
>>>> use_legacy_x86_rom, false),
>>>>    };
>>>>      static void ramfb_class_initfn(ObjectClass *klass, void *data)
>>>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>>>> index fd96d0345c..f6d89578d0 100644
>>>> --- a/hw/i386/pc_q35.c
>>>> +++ b/hw/i386/pc_q35.c
>>>> @@ -45,6 +45,7 @@
>>>>    #include "hw/i386/pc.h"
>>>>    #include "hw/i386/amd_iommu.h"
>>>>    #include "hw/i386/intel_iommu.h"
>>>> +#include "hw/vfio/pci.h"
>>>>    #include "hw/virtio/virtio-iommu.h"
>>>>    #include "hw/display/ramfb.h"
>>>>    #include "hw/ide/pci.h"
>>>> @@ -67,6 +68,8 @@
>>>>      static GlobalProperty pc_q35_compat_defaults[] = {
>>>>        { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
>>>> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
>>>> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
>>> this will only keep the legacy behavior along with q35 machine type but
>>> not on other machines being used for x86. what about pc-i440fx? Doesn't
>>> it apply to it as well? Are there other machine types also impacted.
>>
>> Ok I will also add it with pc-i440fx. I think only q35 and i440fx are
>> impacted.
>>
>>>
>>> Also what about Daniel's comment in v3:
>>> https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
>>> "For non-x86, historical versioned machine types will need
>>> likely it set to true, in order to avoid the memory layout
>>> being changed IIUC."
>>>
>>> Is it actually needed?
>>
>> If those machine types need to set it to true. I think they can set it
>> after they have this property.
> nope it does not work like that. In case we really need to take care of
> this, this must be handled by compats.

If so. Why don't we still keep the "use-legacy-x86-rom" default to true, 
and only set it to false to those arch which doesn't need it just like 
my original implementation.

Because I don't really know how other arch's memoery layout was impacted 
by this property set to false. I think keep their original behavior and 
only change it on arm64 is a good idea.

How do you think about it?

Thanks,
Shaoqin

> 
> Thanks
> 
> Eric
>>
>> Thanks,
>> Shaoqin
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>    };
>>>>    static const size_t pc_q35_compat_defaults_len =
>>>>        G_N_ELEMENTS(pc_q35_compat_defaults);
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index ff0d93fae0..a529500b70 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>>>      static const Property vfio_pci_dev_nohotplug_properties[] = {
>>>>        DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>>>> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>>>> use_legacy_x86_rom, true),
>>>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>>>> use_legacy_x86_rom, false),
>>>>        DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice,
>>>> ramfb_migrate,
>>>>                                ON_OFF_AUTO_AUTO),
>>>>    };
>>>
>>
> 

-- 
Shaoqin


