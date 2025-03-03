Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DB8C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCNU-00065i-Sa; Mon, 03 Mar 2025 15:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpCNR-00064P-KP; Mon, 03 Mar 2025 15:27:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpCNI-00007F-MD; Mon, 03 Mar 2025 15:26:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF9424E6014;
 Mon, 03 Mar 2025 21:26:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id DXIYitEZW0MF; Mon,  3 Mar 2025 21:26:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8AC884E6010; Mon, 03 Mar 2025 21:26:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 887F074577C;
 Mon, 03 Mar 2025 21:26:46 +0100 (CET)
Date: Mon, 3 Mar 2025 21:26:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Hab Gallagher <hab.gallagher@gmail.com>
cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: Adding gamma support to QemuMacDrivers
In-Reply-To: <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
Message-ID: <cf5f0f6b-61bc-a5e5-2f4a-b0473c65a350@eik.bme.hu>
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
 <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
 <CABLmASFQby0KpR646Vp=7JGsw40_2cvW-gFa49f2G3iMCAz14A@mail.gmail.com>
 <85e1dcb9-f0d7-6ed2-6370-30cd8f31a604@eik.bme.hu>
 <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1397181022-1741033606=:42273"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1397181022-1741033606=:42273
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Mar 2025, Hab Gallagher wrote:
>> That driver is for a VGA device which I think does not support gamma in
>> hardware. QEMU emulates the hardware so if it does not support gamma then
>> there's no place to add it in QEMU. Therefore if you want to emulate gamma
>> on VGA this should be done within the guest driver but that may be slower.
>> How does this work on real hardware? What graphics device is used there
>> and does that support gamma in hardware? Maybe that graphics device needs
>> to be emulated instead?
>
>
> For understanding the MacOS side of things, I have been consulting
> https://developer.apple.com/library/archive/documentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/Designing_PCI_Cards_Drivers.pdf
>
> To reduce visible flashes resulting from color table changes, the SetGamma
>> routine works in conjunction with the SetEntries control routine on indexed
>> devices. The SetGamma routine first loads new gamma correction data into
>> the
>> driver’s private storage; the next SetEntries control call applies the
>> gamma
>> correction as it changes the CLUT. SetGamma calls are always followed by
>> SetEntries control calls on indexed devices.
>>
>
>
> For direct devices, the SetGamma routine first sets up the gamma correction
>> data
>> table. Next, it synthesizes a black-to-white linear ramp color table.
>> Finally, it
>> applies the new gamma correction to the color table and sets the data
>> directly in
>> the hardware.
>
>
> As far as I can tell, the documentation is implying that somewhere between
> the driver and the physical hardware, *something* must keep track of the
> gamma table (even if indirectly by subsequently applying it to the palette
> table) to map the raw framebuffer data to gamma-corrected colors.

As I understand that doc it says that the driver should not apply the 
gamma values immediately but store it in the driver and apply it only on 
the subsequent SetEntries call so it does not change the current palette 
but only takes effect when the palette changes the next time. For indexed 
colors when there is a palette this could be done in the driver so it 
calculates the corrected palette on SetEntries and send that to QEMU not 
the color values it gets from the guest. For that it needs to remember the 
gamma table from the SetGamma call preceeding SetEntries which can be 
stored in an array in the driver. For direct color modes this does not 
work because then the values in the frame buffer need to be gamma 
corrected. This is what the qfb device seems to do. So I think you could 
support gamma for indexed (256 colors) in QEMU VGA driver but for modes 
with more colors you may need qfb or similar device because VGA does not 
support gamma. You could theoretically do it in the driver in a shadow 
frame buffer but that does not seem to be the best way and might be slow 
doing it in the guest.

>> Perhaps this is also of interest:
>> https://github.com/SolraBizna/mac_qfb_driver
>> The nubus declaration rom supports gamma correction.
>
>
> This is very much of interest! Thank you. I am hoping to continue to use
> the mac99 machine type, but this code is a useful reference.
>
> The most basic support requires cscGetGamma and cscSetGamma to at least
> return success:
> https://github.com/cebix/macemu/commit/2676e1bd134703d888788c682fb56e07b5cf56a9
> The patch to SheepShaver was small because most of the functionality was
> already present, albeit dead code.
>
> Surprisingly, github can't deal with CR line endings, so I can't (easily)
> link to some of the code to cite it:
> https://github.com/ozbenh/QemuMacDrivers/blob/master/shared/MacDriverUtils.c
>
> Once the gamma table is saved, it's "applied" by cscSetEntries to combine a
> color palette and gamma table into the "real" color. QemuMacDrivers does
> not seem to keep track of the palette at all, sending it upstream to the
> driver by calling this function in a loop:
>
> OSStatus QemuVga_SetColorEntry(UInt32 index, RGBColor *color)
> {
> VgaWriteB(0x3c8, index);
> VgaWriteB(0x3c9, color->red >> 8);
> VgaWriteB(0x3c9, color->green >> 8);
> VgaWriteB(0x3c9, color->blue >> 8);
> return noErr;
> }
>
> VgaWriteB seems to be doing MMIO to write those values upstream.

These would end up in qemu/hw/display/vga.c::vga_ioport_write() cases 
PEL_IW and PEL_D and set the palette in the VGA card (you can see these 
with -trace enable="vga_*") but I think that's only used for indexed modes 
and you could gamma correct these values in the driver as said above 
without changes in QEMU. Direct color modes use the VBE_DISPI interface 
(this comes from Bochs and probably documented somewhere there) and linear 
frame buffer. In this case gamma correction should be done by whatever 
writes the frame buffer (I don't know if MacOS has support for that in 
software for gfx cards that don't do it, maybe if there is then that could 
be used) or whatever reads it when displaying which is what qfb does which 
is like a gfx chip that supports gamma. (I think ATI chips support gamma 
but QEMU emulation uses VGA DISPI interface too so it's not emulated. 
There could be two ways to implement that, either add gamma support for 
vga which may get some resistance if most real chips don't do that but 
could be considered and submit an RFC patch as this might be useful for 
other devices too, or ati-vga may need to use it's own gfx_update routine 
when not in VGA mode which may eventually be needed but to keep it simple 
I'm using the VGA facilites for now.)

> Similarly, mac_qfb_driver seems to use MMIO to write back both the palette
> table and the gamma table to the driver, saving neither one in emulated
> driver state:
> https://github.com/SolraBizna/mac_qfb_driver/blob/e78ba4ccd08d254a10bad7c13d90810b17dbfd87/src/control.cc#L48-L62

Look at the corresponding QEMU device which is here:
https://github.com/SolraBizna/qemu/commit/f551de525360a26df481c5b80876845c323d9303
I think these would be handled in qfb_ctrl_write().

> I'm not sure where either driver's MMIO is received on the qemu end. At
> least in SheepShaver, that gamma table is indeed used in the cscSetEntries
> handler to create the true color mapping handed to its video driver:
> https://github.com/cebix/macemu/blob/96e512bd6376e78a2869f16dcc8a9028bce5ee72/SheepShaver/src/video.cpp#L299-L320
>
> If mac_qfb_driver is, as indicated in its README, able to interoperate with
> an unpatched qemu, that makes me think that *potentially* qemu itself

No it says it needs patched QEMU that adds the qfb device. I think what it 
means is that this qfb device can be present with macfb and allows both to 
be used but unpatched QEMU only has macfb and not the qfb this driver 
wants to talk to.

Regards,
BALATON Zoltan

> doesn't need to be patched, depending on what qemu-side code any driver is
> sending its MMIO to.
>
> I have an article on AmigaOS gfx here:
>> https://codeberg.org/qmiga/pages/wiki/AmigaOSGfx
>> that discusses similar issue and most of it may be applicable to MacOS
>> too. There's also a DeveloperTips link with some QEMU getting started
>> links that may help you. I have started an ati-vga emulation that could do
>> all this and more but it's quite complex and I could take some help with
>> it. Maybe that could be interesting to you as well as these ATI chips were
>> used on real Macs so MacOS has support for it. I also have an article
>> linked from the above about that.
>
>
> I'm continuing to read this now.
>
> Thanks already, y'all.
>
--3866299591-1397181022-1741033606=:42273--

