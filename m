Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A1C7EE2A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 01:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUbq9-0000MM-5Y; Wed, 25 Jun 2025 21:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUbq8-0000M1-1q
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 21:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUbq6-0005cT-7P
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 21:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750902944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olB+v+aEdQZVypCDUMnDbe8D4vsPLXJDiRReSjccnd4=;
 b=XUSKWBVfmauDuu7TTykG/i2U/G+iXYFh8Dnb8T8xlH+XpssNX1diUSwy4MMqchmZJDmxM3
 HiL68N7DMNUHAhdtuTDI6/6nNIZyNb2g7v+fPCkqJz1RyRViSALP1apoQ1BJJ/LOXs7Y/Z
 c1ZfRzMju5yCYUl5TSnOOnP/+0nfEHE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-fALhdk9XMgWYSN5rWiuJrw-1; Wed, 25 Jun 2025 21:55:41 -0400
X-MC-Unique: fALhdk9XMgWYSN5rWiuJrw-1
X-Mimecast-MFC-AGG-ID: fALhdk9XMgWYSN5rWiuJrw_1750902941
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so5312195ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 18:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750902941; x=1751507741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=olB+v+aEdQZVypCDUMnDbe8D4vsPLXJDiRReSjccnd4=;
 b=b73FvxYR3f4Ny3dyz8TG+VBSL3kBfxGo4EWCBCiOBA6CuID+Cb+YQpdak+umbNtMsf
 D6jFq6LwM7wKAqwg0WSBWTyazrOIHqgysPZvwkBPs2WXM+OHUWjgDzEwwZbgKpTdKOCc
 MtCsVGLzMT6xuUxyxwNKgAYRsSN/5FpgZPXEAb4GMiQbigjnlRXfs8pd/zncsp9mmuus
 bDunfp/LCDIz+YN7+lxo2kOPXrc6sdfaJrn/sI2On9+JXOouqdjT0aQHWZW6Hj2p1BHm
 s+rcyyEgh5chxQhlv+sfoD180gvxRfcZWz8oH3P12sg2igG8/Omtfu2fJgt8e7IAJuAC
 q5KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCkyq5tH0CZ9U2mwxfZnO9JRnSN45H7RcsO2KpFs1gcmu3CtkVjoIE1nGT/1NEXsRaIKYE6nQSyCcs@nongnu.org
X-Gm-Message-State: AOJu0YwXHlVKtAkrBA0MjXGCc7jv6mzUjhp75m222xnLejBXCthhJoRP
 SEGUZR5MrwDmwcVD5v8IQI9HS+Tl73bitJf/8ffhx58ia3w540YNHhLoNluBSgnpPR53Xo4DQZf
 ZvlZhcJft0onYS+jEY4/BBdw+MH7H2jAn/B/sf5NakLW6R5N+OtEgY0bS
X-Gm-Gg: ASbGncsdckQJNTr1D4OIHozbnn52swNT4mL/4YOkDZ+M/brojF8Tk9ZkFOe8HEnwNnU
 CxkeaP0AyjiF8/ZSH88p1pq0NMzXNZmXsqNKHJE7T0UE8xmAj8UqM9agKM4s8QwVxqf2UNAgFrZ
 yLXteMGufmCyPUOPPhgMfwN9LCPR/K7ePsnBz0vfY12fa6o2ppLmD7vd0AGSISzz0gz0adHH16I
 zmBhuftqEiJnu6kqiiWSIpMUj8gH7ONeKf1XmzOTLnJ0CW3v7qinpWNn2SgKJMb5g7AQK1bX8vl
 mROmEzCVJF+CDVb/EE/+AAXGFDI=
X-Received: by 2002:a17:903:2bce:b0:234:1163:ff99 with SMTP id
 d9443c01a7336-238e9de5175mr24103075ad.43.1750902940693; 
 Wed, 25 Jun 2025 18:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoasfRFqQm5DiBlBSYj/+nAC3PgkrOJtAi9dIjJhsK6776NDP0QOR/6QKkumk68d3+YMKTcA==
X-Received: by 2002:a17:903:2bce:b0:234:1163:ff99 with SMTP id
 d9443c01a7336-238e9de5175mr24102855ad.43.1750902940312; 
 Wed, 25 Jun 2025 18:55:40 -0700 (PDT)
Received: from [10.72.116.141] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f54412c6sm2814742a91.43.2025.06.25.18.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 18:55:39 -0700 (PDT)
Message-ID: <f964e9e0-f641-47d8-89d4-c70b6c81f52b@redhat.com>
Date: Thu, 26 Jun 2025 09:55:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ramfb: Add property to control if load the romfile
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-2-shahuang@redhat.com>
 <8c1870b3-d13d-4918-b0f6-6f41659a807d@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <8c1870b3-d13d-4918-b0f6-6f41659a807d@redhat.com>
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

On 6/23/25 5:20 PM, Eric Auger wrote:
> Hi Shaoqin,
> On 6/17/25 5:05 AM, Shaoqin Huang wrote:
>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> Currently the ramfb device loads ...

Ok, will change it.

>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>
>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>> for ramfb, so they don't need to load the romfile.
>>
>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
> was renamed with - instead of _

Ok, will fix it.

>> device, because the vfio display also use the ramfb_setup() to load
>> the vgabios-ramfb.bin file.
>>
>> After have this property, the machine type can set the compatibility to
>> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Please add in the commit message that for now the default value is true
> but it will be turned off by default in subsequent patch when compats
> get properly handled.

Got it.

Thanks.

>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   hw/display/ramfb-standalone.c | 4 +++-
>>   hw/display/ramfb-stubs.c      | 2 +-
>>   hw/display/ramfb.c            | 6 ++++--
>>   hw/vfio/display.c             | 4 ++--
>>   hw/vfio/pci.c                 | 1 +
>>   hw/vfio/pci.h                 | 1 +
>>   include/hw/display/ramfb.h    | 2 +-
>>   7 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
>> index 1be106b57f..af1175bf96 100644
>> --- a/hw/display/ramfb-standalone.c
>> +++ b/hw/display/ramfb-standalone.c
>> @@ -17,6 +17,7 @@ struct RAMFBStandaloneState {
>>       QemuConsole *con;
>>       RAMFBState *state;
>>       bool migrate;
>> +    bool use_legacy_x86_rom;
>>   };
>>   
>>   static void display_update_wrapper(void *dev)
>> @@ -39,7 +40,7 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>>       RAMFBStandaloneState *ramfb = RAMFB(dev);
>>   
>>       ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
>> -    ramfb->state = ramfb_setup(errp);
>> +    ramfb->state = ramfb_setup(ramfb->use_legacy_x86_rom, errp);
>>   }
>>   
>>   static bool migrate_needed(void *opaque)
>> @@ -62,6 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>>   
>>   static const Property ramfb_properties[] = {
>>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
>>   };
>>   
>>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
>> diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
>> index cf64733b10..b83551357b 100644
>> --- a/hw/display/ramfb-stubs.c
>> +++ b/hw/display/ramfb-stubs.c
>> @@ -8,7 +8,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>>   {
>>   }
>>   
>> -RAMFBState *ramfb_setup(Error **errp)
>> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>>   {
>>       error_setg(errp, "ramfb support not available");
>>       return NULL;
>> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
>> index 8c0f907673..9a17d97d07 100644
>> --- a/hw/display/ramfb.c
>> +++ b/hw/display/ramfb.c
>> @@ -135,7 +135,7 @@ const VMStateDescription ramfb_vmstate = {
>>       }
>>   };
>>   
>> -RAMFBState *ramfb_setup(Error **errp)
>> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>>   {
>>       FWCfgState *fw_cfg = fw_cfg_find();
>>       RAMFBState *s;
>> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>>   
>>       s = g_new0(RAMFBState, 1);
>>   
>> -    rom_add_vga("vgabios-ramfb.bin");
>> +    if (romfile) {
>> +        rom_add_vga("vgabios-ramfb.bin");
>> +    }
>>       fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>>                                NULL, ramfb_fw_cfg_write, s,
>>                                &s->cfg, sizeof(s->cfg), false);
>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>> index ea87830fe0..8bfd8eb1e3 100644
>> --- a/hw/vfio/display.c
>> +++ b/hw/vfio/display.c
>> @@ -365,7 +365,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>>                                             &vfio_display_dmabuf_ops,
>>                                             vdev);
>>       if (vdev->enable_ramfb) {
>> -        vdev->dpy->ramfb = ramfb_setup(errp);
>> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>>           if (!vdev->dpy->ramfb) {
>>               return false;
>>           }
>> @@ -494,7 +494,7 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>>                                             &vfio_display_region_ops,
>>                                             vdev);
>>       if (vdev->enable_ramfb) {
>> -        vdev->dpy->ramfb = ramfb_setup(errp);
>> +        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
>>           if (!vdev->dpy->ramfb) {
>>               return false;
>>           }
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 7f1532fbed..ff0d93fae0 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index d94ecaba68..713956157e 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>>       bool no_kvm_ioeventfd;
>>       bool no_vfio_ioeventfd;
>>       bool enable_ramfb;
>> +    bool use_legacy_x86_rom;
>>       OnOffAuto ramfb_migrate;
>>       bool defer_kvm_irq_routing;
>>       bool clear_parent_atomics_on_exit;
>> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
>> index a7e0019144..172aa6dc89 100644
>> --- a/include/hw/display/ramfb.h
>> +++ b/include/hw/display/ramfb.h
>> @@ -6,7 +6,7 @@
>>   /* ramfb.c */
>>   typedef struct RAMFBState RAMFBState;
>>   void ramfb_display_update(QemuConsole *con, RAMFBState *s);
>> -RAMFBState *ramfb_setup(Error **errp);
>> +RAMFBState *ramfb_setup(bool romfile, Error **errp);
>>   
>>   extern const VMStateDescription ramfb_vmstate;
>>   
> Thanks
> 
> Eric
> 

-- 
Shaoqin


