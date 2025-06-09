Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC855C61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 03:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOTKo-0003QU-QH; Sun, 08 Jun 2025 23:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOTKk-0003Q3-BX
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 23:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOTKg-00055S-O2
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 23:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749440276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Rzx5NiZAd0x4mEjPq8dOiKAZARMPQ5U3iWYsJELvqk=;
 b=XBkCjpTD7A6kHDqjApZksri7YpMJKfNjRDG8hTKk+HTjFktaPOtlOEz7Tg56im3po0sU36
 Xq3UHkM5EdHPtWhI79a0qud+4B0P5mnB0ZOyOpnWy+WjFBM60fG0e9YvJOxMmcN8OxLTg9
 SBEX+2eDe23qc4RTS45cn9d0F+37z8Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-bZsRDNN-MZaS8Hahuf0-Pg-1; Sun, 08 Jun 2025 23:37:55 -0400
X-MC-Unique: bZsRDNN-MZaS8Hahuf0-Pg-1
X-Mimecast-MFC-AGG-ID: bZsRDNN-MZaS8Hahuf0-Pg_1749440274
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31315427249so4814308a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 20:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749440274; x=1750045074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Rzx5NiZAd0x4mEjPq8dOiKAZARMPQ5U3iWYsJELvqk=;
 b=HLG1KF0r/85uoBxKbvRH+pov03w+WJ2k7QkJ6xYgP3/2/sFd63OafAqOrhFsM+tItj
 cJXQh0bsQfl8/bA8pN+F4bc9M96wOky5kPiFfVc0z6yaVJ4CVQH4UJgUkfxZv+69IktN
 4zkMx7T/IZescgfq5ur5W4zo+5QS1F/Z1Bu08s0IYcSTis3tRRpjdbDBx7C3rnyOI5K0
 kO3mDe9qwj3scS83lJ1Yq/kOqNWEnyPvD1xTC37lGDQM5WDwMg6EazMphJChnPRGkntG
 DL3SoJexvdLn4L5FaeQvPfi/0CyaInXM05V4JZlTm0b06iux20bapQY9qNte9O2SXX0g
 EtMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3QYfmhW38ajYAP/H47RLvxK3QnQsJFJ31XCN1LXYHT7f9F1VetFLKoD1HH75u7veB3NgNFvE+zfAE@nongnu.org
X-Gm-Message-State: AOJu0YzhyP/lRAG4/4UwgCep750mof2NPkQB5nzYNWcFJDAmx23Sh5yN
 Ufn2VTIPAakYCkGPBFhmyAFj5UkK90i51ZDjSlDhuePN5H313ETGCou4aH1PWTNaVTGIQaFdSVS
 xI5syDnD0SreIk0rE9LAxNS+B3udBrrFNgVSDLqnf6MoJ5n3lVQySE6DN
X-Gm-Gg: ASbGnct9luMEZeGxsLxxFzkKbfQWJmi9D2oQlx8/P/qS/IJV6nmYLAGuGs6QqzSz64O
 MJ8FPzNupzLh9FXFJt9s4cGxLmM2Z8DGWF8DTee94sdUadAHwxKuld/txfy25NYQG8peAE/uAw2
 2Zz/ekg+c1zs5ydhWlvdjXe41Pjf2/cYzZeqXss8ZeMGIWmHgFGoAiI+kcd0dzsAt6t+6wvLYV2
 NUzCTBp1tXeljypw+YpBcabiDvTdCXWhtI4Lv87GqjNXv3lmG/XPLWcA/pEgdHrOK2GsV+57QPT
 Ayt2ycU16CMriik=
X-Received: by 2002:a17:90b:4e8d:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-313472fc4b5mr16021570a91.13.1749440273968; 
 Sun, 08 Jun 2025 20:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbHC8Sa1du6hZZR09nxMIkQLcTK0BOrOCQIW92Ckr/yU+q75AYd8pTZ/HpTvs39MPj1fv7A==
X-Received: by 2002:a17:90b:4e8d:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-313472fc4b5mr16021552a91.13.1749440273529; 
 Sun, 08 Jun 2025 20:37:53 -0700 (PDT)
Received: from [10.66.193.79] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b0903fcsm5194299a91.21.2025.06.08.20.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 20:37:53 -0700 (PDT)
Message-ID: <3f093907-34d3-40f7-956b-828c0c58f04a@redhat.com>
Date: Mon, 9 Jun 2025 11:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <aEKeNSc8mAZ8vhGj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Daniel,

On 6/6/25 3:52 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>
>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>> for ramfb, so they don't need to load the romfile.
>>
>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
>> device, because the vfio display also use the ramfb_setup() to load
>> the vgabios-ramfb.bin file.
>>
>> After have this property, the machine type can set the compatibility to
>> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Can you make this a series, with an additional patch that updates the
> current in-dev machine types to use this new property, so we're clear
> about the proposed usage.
> 

Ok. Thanks for notification. I will update it in the version 3.

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
>> index 7f1532fbed..4e4759c954 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> +    DEFINE_PROP_BOOL("use_legacy_x86_rom", VFIOPCIDevice, use_legacy_x86_rom, true),
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
>> -- 
>> 2.40.1
>>
> 
> With regards,
> Daniel

-- 
Shaoqin


