Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC0E6BF10
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 21:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlvpD-0006ua-Ac; Fri, 30 Jan 2026 16:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlvpA-0006uB-Ua
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:14:40 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlvp8-0004gC-T3
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:14:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 469345969FD;
 Fri, 30 Jan 2026 22:14:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FkCUMGT4R3qH; Fri, 30 Jan 2026 22:14:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 28BFB5969F6; Fri, 30 Jan 2026 22:14:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1FCF35969F2;
 Fri, 30 Jan 2026 22:14:33 +0100 (CET)
Date: Fri, 30 Jan 2026 22:14:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
In-Reply-To: <a4344aef-8eb7-42f4-bb2e-ab87fbd21f97@ilande.co.uk>
Message-ID: <dd23e078-c377-9e04-bd94-62698ede3b9f@eik.bme.hu>
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
 <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
 <CAFEAcA9htbxy0fHZAvdX6Rneina-r_a1ajN3w3FHUL=hykcyug@mail.gmail.com>
 <69ca374e-960f-89a7-0f74-b42977a51d3e@eik.bme.hu>
 <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
 <a4344aef-8eb7-42f4-bb2e-ab87fbd21f97@ilande.co.uk>
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

On Fri, 30 Jan 2026, Mark Cave-Ayland wrote:
> On 29/01/2026 20:22, Peter Maydell wrote:
>> On Thu, 29 Jan 2026 at 19:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> 
>>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>>> On Thu, 29 Jan 2026 at 17:20, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>>>>> On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> 
>>>>>> wrote:
>>>>>> This is a migration compatibility break, because the
>>>>>> memory_region_init_rom() function registers the MR
>>>>>> for migration via vmstate_register_ram(), which picks
>>>>>> an ID string for the memory that includes the path
>>>>>> of the device, whereas vmstate_register_ram_global()
>>>>>> picks an ID string for the memory that does not include
>>>>>> the path of any device. It is this difference that is the
>>>>>> reason why they're still using the _nomigrate functions.
>>>>> 
>>>>> I thought it might be the case but wasn't sure. How was this handled in
>>>>> all other machines where they were converted to not use _nomigrate? Only
>>>>> some Sun machines still seem to use this and this may be a good
>>>>> opportunity to bring them inline with all other machines.
>>>> 
>>>> If I remember correctly, we converted all the machines where
>>>> we were happy at the time to have a compat break. The remainder
>>>> are not only Sun machines -- you can see in your patch 4 that xtensa
>>>> and vga are also affected.
>>> 
>>> Well, almost all of the usages are because of the Sun machines and those
>>> could be easily converted accepting one time migration break. The VGA one
>>> seems to be because of isa cards which may not have been QOM'ified so
>>> could not be converted before but maybe could be now but I haven't checked
>> 
>> We can't change the the vga usage, because it's a migration compat
>> break, and you can use vga on x86 PC machines, where we do care
>> about not breaking migration.
>
> Yeah. Whilst we don't necessarily guarantee Sun machine migration between 
> QEMU versions, I'd still like to keep it if possible. If the Sun machines 
> were the last holdout here then I'd say let's just accept the break: however 
> given that it's impossible to remove these functions because of VGA then the 
> reasons for breaking migration compatibility become much less compelling.

The Sun machines are pretty much the last ones using these. The 
memory_region_init_rom_nomigrate() function is only used by cg3 and tcx 
and nothing else so if we remove those we already have a migration break 
for these devices so it would be a good time to also convert the Sun 
machines now. The memory_region_init_ram_nomigrate() function is used by 
cg3, tcx, sun4m, sun4u, xtfpga and vga so most of the usage is in Sun 
machines and related devices. I think we could also convert xtfpga used by 
xtensa as that's also not versioned so no migration guarantee but I know 
nothing about that so I'm waiting for some opinion from the maintainers of 
that machine.

In vga the memory_region_init_ram_nomigrate function is used only to keep 
compatibility for old machines based on the global-vmstate property which 
is recognised by VGA, vmware-svga, cirrus-vga and qxl but defaults to 
false for all of these so all machines where we care about migration 
already use the new way and would not break when we converted vga to 
memory_region_init_ram. The global-vmstate property is only set to true in 
hw_compat_2_12 (which probably can be removed because due to auto 
deprecation and Philippe's previous work the oldest visible pc and q35 
machine is currently 5.1). Apart from that global-vmstate is also set to 
true by isa-vga, isa-cirrus-vga and vga-mmio (the last of which is used by 
mips/jazz machine) so we don't have any machines with migration 
compatibility requirement that would prevent removing the usage from vga 
as well if we accept migration break for isa-pc and mips/jazz which I 
think we could but I'd leave that for later to untangle this after at 
least the old no longer needed hw_compat settings are removed from 
hw/core/machine.c.

So besides the vga and xtensa which I think could also be converted all 
remaining usages are in the Sun machines and their display devices and 
converting those are easy that I'm willing to do in this series. In light 
of that would you accept the migration break for the Sun machines to 
remove most of the still active usages of these functions? If I hear back 
from xtensa I can convert that too and vga could be done separately 
afterwards as I think that does not fit the scope of this series but 
there's nothing that makes it impossible to do as no active versioned 
machines still depend on this feature of vga.

Do you know about anybody using migration with these Sun machines that 
would be affected by this change? As we make no guarantee about migration 
compatibility for these it would still not prevent us from changing it but 
if we don't even know about any active users then it's even less critical 
to keep to the old way for these machines when all other machines were 
long converted.

Regards,
BALATON Zoltan

