Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BBBD358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVhF-0007rd-FF; Thu, 29 Jan 2026 12:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlVhC-0007rL-RF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:20:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlVh9-00053T-UB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:20:42 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B51B596A0B;
 Thu, 29 Jan 2026 18:20:32 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id K70y4U-mQAgP; Thu, 29 Jan 2026 18:20:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 49DB45969F2; Thu, 29 Jan 2026 18:20:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47A3F5969F0;
 Thu, 29 Jan 2026 18:20:30 +0100 (CET)
Date: Thu, 29 Jan 2026 18:20:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
In-Reply-To: <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
Message-ID: <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 29 Jan 2026, Peter Maydell wrote:
> On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Nothing else does this, convert to regular memory_region_init_rom().
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/cg3.c | 5 ++---
>>  hw/display/tcx.c | 5 ++---
>>  2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
>> index 568d6048a6..61bdb0552e 100644
>> --- a/hw/display/cg3.c
>> +++ b/hw/display/cg3.c
>> @@ -282,8 +282,8 @@ static void cg3_initfn(Object *obj)
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>      CG3State *s = CG3(obj);
>>
>> -    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
>> -                                     FCODE_MAX_ROM_SIZE, &error_fatal);
>> +    memory_region_init_rom(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
>> +                           &error_fatal);
>>      sysbus_init_mmio(sbd, &s->rom);
>>
>>      memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
>> @@ -299,7 +299,6 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
>>      char *fcode_filename;
>>
>>      /* FCode ROM */
>> -    vmstate_register_ram_global(&s->rom);
>>      fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
>>      if (fcode_filename) {
>>          ret = load_image_mr(fcode_filename, &s->rom);
>
> This is a migration compatibility break, because the
> memory_region_init_rom() function registers the MR
> for migration via vmstate_register_ram(), which picks
> an ID string for the memory that includes the path
> of the device, whereas vmstate_register_ram_global()
> picks an ID string for the memory that does not include
> the path of any device. It is this difference that is the
> reason why they're still using the _nomigrate functions.

I thought it might be the case but wasn't sure. How was this handled in 
all other machines where they were converted to not use _nomigrate? Only 
some Sun machines still seem to use this and this may be a good 
opportunity to bring them inline with all other machines.

> I think it's reasonable to accept a compat break for the purposes
> of cleaning up the codebase, because these are used on sparc machine
> types and we don't version those, but the commit message needs to
> note that this is a compat break.

If we accept that then the other memory_region_init_ram_nomigrate usages 
in Sun machines could also be converted. If Mark is not open to that I'm 
inclined to convert these two rom_nomigrate usages to 
memory_region_init_ram_flags_nomigrate + memory_region_set_readonly 
instead but get rid of these other _nomigrate variants anyhow. Let me know 
which way you prefer.

Regards,
BALATON Zoltan

