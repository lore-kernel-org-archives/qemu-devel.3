Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2789CC282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprl7-0004vL-QT; Wed, 05 Mar 2025 11:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tprl2-0004oV-Ew; Wed, 05 Mar 2025 11:38:09 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tprky-0003YK-B4; Wed, 05 Mar 2025 11:38:08 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 522A44E601A;
 Wed, 05 Mar 2025 17:38:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 84pnArlZaCzq; Wed,  5 Mar 2025 17:37:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3AA7E4E6010; Wed, 05 Mar 2025 17:37:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3800574577C;
 Wed, 05 Mar 2025 17:37:59 +0100 (CET)
Date: Wed, 5 Mar 2025 17:37:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Hab Gallagher <hab.gallagher@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: Adding gamma support to QemuMacDrivers
In-Reply-To: <8957f2ce-5679-467a-ad91-7b96c9d7e11c@ilande.co.uk>
Message-ID: <a55e63ea-4a6d-878e-95b3-599b08afa362@eik.bme.hu>
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
 <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
 <CABLmASFQby0KpR646Vp=7JGsw40_2cvW-gFa49f2G3iMCAz14A@mail.gmail.com>
 <85e1dcb9-f0d7-6ed2-6370-30cd8f31a604@eik.bme.hu>
 <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
 <8957f2ce-5679-467a-ad91-7b96c9d7e11c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="3866299591-94149128-1741192150=:59328"
Content-ID: <c0fddcb4-d938-44ec-0a9d-44282ccb0554@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-94149128-1741192150=:59328
Content-Type: text/plain; CHARSET=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <55085a5e-c26c-3ebc-2d3e-291c30884ff1@eik.bme.hu>

On Wed, 5 Mar 2025, Mark Cave-Ayland wrote:
> On 03/03/2025 17:52, Hab Gallagher wrote:
>
> (added Gerd on CC)
>
>>     That driver is for a VGA device which I think does not support gamma in
>>     hardware. QEMU emulates the hardware so if it does not support gamma 
>> then
>>     there's no place to add it in QEMU. Therefore if you want to emulate 
>> gamma
>>     on VGA this should be done within the guest driver but that may be 
>> slower.
>>     How does this work on real hardware? What graphics device is used there
>>     and does that support gamma in hardware? Maybe that graphics device 
>> needs
>>     to be emulated instead?
>> 
>> 
>> For understanding the MacOS side of things, I have been consulting https:// 
>> developer.apple.com/library/archive/documentation/Hardware/DeviceManagers/pci_srvcs/ 
>> pci_cards_drivers/Designing_PCI_Cards_Drivers.pdf 
>> <https://developer.apple.com/ 
>> library/archive/documentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/ 
>> Designing_PCI_Cards_Drivers.pdf>
>>
>>     To reduce visible flashes resulting from color table changes, the 
>> SetGamma
>>     routine works in conjunction with the SetEntries control routine on 
>> indexed
>>     devices. The SetGamma routine first loads new gamma correction data 
>> into the
>>     driver¢s private storage; the next SetEntries control call applies the 
>> gamma
>>     correction as it changes the CLUT. SetGamma calls are always followed 
>> by
>>     SetEntries control calls on indexed devices.
>>
>>     For direct devices, the SetGamma routine first sets up the gamma 
>> correction data
>>     table. Next, it synthesizes a black-to-white linear ramp color table. 
>> Finally, it
>>     applies the new gamma correction to the color table and sets the data 
>> directly in
>>     the hardware.
>> 
>> 
>> As far as I can tell, the documentation is implying that somewhere between 
>> the driver and the physical hardware, *something* must keep track of the 
>> gamma table (even if indirectly by subsequently applying it to the palette 
>> table) to map the raw framebuffer data to gamma-corrected colors.
>>
>>     Perhaps this is also of interest: 
>> https://github.com/SolraBizna/mac_qfb_driver
>>     <https://github.com/SolraBizna/mac_qfb_driver>The nubus declaration rom 
>> supports
>>     gamma correction.
>> 
>> 
>> This is very much of interest! Thank you. I am hoping to continue to use 
>> the mac99 machine type, but this code is a useful reference.
>> 
>> The most basic support requires cscGetGamma and cscSetGamma to at least 
>> return success: https://github.com/cebix/macemu/ 
>> commit/2676e1bd134703d888788c682fb56e07b5cf56a9 
>> <https://github.com/cebix/macemu/ 
>> commit/2676e1bd134703d888788c682fb56e07b5cf56a9>
>> The patch to SheepShaver was small because most of the functionality was 
>> already present, albeit dead code.
>> 
>> Surprisingly, github can't deal with CR line endings, so I can't (easily) 
>> link to some of the code to cite it: 
>> https://github.com/ozbenh/QemuMacDrivers/blob/master/ 
>> shared/MacDriverUtils.c 
>> <https://github.com/ozbenh/QemuMacDrivers/blob/master/shared/ 
>> MacDriverUtils.c>
>> 
>> Once the gamma table is saved, it's "applied" by cscSetEntries to combine a 
>> color palette and gamma table into the "real" color. QemuMacDrivers does 
>> not seem to keep track of the palette at all, sending it upstream to the 
>> driver by calling this function in a loop:
>> 
>> OSStatus QemuVga_SetColorEntry(UInt32 index, RGBColor *color)
>> {
>> VgaWriteB(0x3c8, index);
>> VgaWriteB(0x3c9, color->red >> 8);
>> VgaWriteB(0x3c9, color->green >> 8);
>> VgaWriteB(0x3c9, color->blue >> 8);
>> return noErr;
>> }
>> 
>> VgaWriteB seems to be doing MMIO to write those values upstream.
>> 
>> Similarly, mac_qfb_driver seems to use MMIO to write back both the palette 
>> table and the gamma table to the driver, saving neither one in emulated 
>> driver state: https:// 
>> github.com/SolraBizna/mac_qfb_driver/blob/e78ba4ccd08d254a10bad7c13d90810b17dbfd87/ 
>> src/control.cc#L48-L62 <https://github.com/SolraBizna/mac_qfb_driver/blob/ 
>> e78ba4ccd08d254a10bad7c13d90810b17dbfd87/src/control.cc#L48-L62>
>
> Implementing the registers to store the gamma table is trivial: the tricky 
> part is updating the VGA framebuffer code to apply the gamma as it is 
> rendered. Have a look at 
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/vga.c?ref_type=heads#L1478 
> (vga_draw_graphic) and 
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/vga.c?ref_type=heads#L1194 
> (vga_draw_text) to see how this is handled.
>
> Gerd: what do you think would be the best way to apply a gamma to the VGA 
> device?

I think that would be similar to what's done here:
https://github.com/SolraBizna/qemu/commit/f551de525360a26df481c5b80876845c323d9303
Maybe add such additional draw routines with alpha and only set those in 
vga_draw_line_table when an alpha is set otherwise use the current ones. 
That should avoid changing current code in case when alpha is not 
used. Alternatively that qfb device could be merged and a PCI version 
added for mac99?

Regards,
BALATON Zoltan
--3866299591-94149128-1741192150=:59328--

