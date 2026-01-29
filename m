Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27351D73E9C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlaVJ-0003Nm-EM; Thu, 29 Jan 2026 17:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlaVH-0003MB-SI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:28:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlaVF-0003yI-Ty
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 17:28:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA770596A38;
 Thu, 29 Jan 2026 23:28:37 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wVcUCgKu58eL; Thu, 29 Jan 2026 23:28:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 98755596A29; Thu, 29 Jan 2026 23:28:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 964A9596A0B;
 Thu, 29 Jan 2026 23:28:35 +0100 (CET)
Date: Thu, 29 Jan 2026 23:28:35 +0100 (CET)
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
In-Reply-To: <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
Message-ID: <7538d8b1-e217-a7ee-95c2-93e08286f678@eik.bme.hu>
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
 <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
 <CAFEAcA9htbxy0fHZAvdX6Rneina-r_a1ajN3w3FHUL=hykcyug@mail.gmail.com>
 <69ca374e-960f-89a7-0f74-b42977a51d3e@eik.bme.hu>
 <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
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
> On Thu, 29 Jan 2026 at 19:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>> On Thu, 29 Jan 2026 at 17:20, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>>>> On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>> This is a migration compatibility break, because the
>>>>> memory_region_init_rom() function registers the MR
>>>>> for migration via vmstate_register_ram(), which picks
>>>>> an ID string for the memory that includes the path
>>>>> of the device, whereas vmstate_register_ram_global()
>>>>> picks an ID string for the memory that does not include
>>>>> the path of any device. It is this difference that is the
>>>>> reason why they're still using the _nomigrate functions.
>>>>
>>>> I thought it might be the case but wasn't sure. How was this handled in
>>>> all other machines where they were converted to not use _nomigrate? Only
>>>> some Sun machines still seem to use this and this may be a good
>>>> opportunity to bring them inline with all other machines.
>>>
>>> If I remember correctly, we converted all the machines where
>>> we were happy at the time to have a compat break. The remainder
>>> are not only Sun machines -- you can see in your patch 4 that xtensa
>>> and vga are also affected.
>>
>> Well, almost all of the usages are because of the Sun machines and those
>> could be easily converted accepting one time migration break. The VGA one
>> seems to be because of isa cards which may not have been QOM'ified so
>> could not be converted before but maybe could be now but I haven't checked
>
> We can't change the the vga usage, because it's a migration compat
> break, and you can use vga on x86 PC machines, where we do care
> about not breaking migration.

I think pc machines use PCI which would not change so it would only break 
isapc where we probably don't care but I don't intend to change that now. 
Just getting rid of what we can do safely to simplify the 
memory_region_init API is enough for me. The remaining few can be 
considered later but we will likely need some _nomigrate option for 
backends/hostmem-ram.c so we probably can't get rid of them all.

Regards,
BALATON Zoltan

