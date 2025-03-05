Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4FFC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpr1A-00052a-QF; Wed, 05 Mar 2025 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tpr18-00052A-5o; Wed, 05 Mar 2025 10:50:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tpr15-0004CA-PG; Wed, 05 Mar 2025 10:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4mh+0ykTD/iNdoCIrvBMb/N3ggMQ+6PSgMzxpFz3Kws=; b=v2DmFWB1WPHVZ6UE+KVAU/9b/C
 2GCO57f3KAutA7mPa8OOI54MYaGPZx66GV3OAusS0xUrXF6yL94CPRHe2ShKFx8o1nptPm8P7CVV4
 bmInDN9epyGre9BLmY891OxS2bBHloBJPuFpyox/1TCF0ugpBpxKYjKDM9TGJlMzhqkAjofHGl/73
 Do94P4N2+N/vj+fpp+vFIKMVlzpoSQr2Y4eHm2Fe/uly6/7dOYpqWtGDhT2EQFoSfzo4zy7C6eOc7
 MDGUueAZs9XukWcheLjPgqrOXqhcLR50kId1kYre0fJKSUc6JWO0hj+u7lhr8f0P8uek+2B/iTGkw
 fwCk9lHITOD22Dy/aR9FWdQTv2iL86R7FPAftPEM93BV1LORkvO5RGxqc5VzU9sTRi1Y4NQunHrN+
 YMASIEX8h8zlUj9Jw0vlht9M5usX1AabdvPc/4O4mkD53WocfFB1O5jk2rKHaYELdEmeKxg5FCRew
 RjFXoIFpkMDTL3dvepT5xPQH52g7o8CGR6zuPfdecAsZogwMB3EftEB5996vKTp/+bgb/j17LcxWc
 HP04ZbM0CjJOSU2YEiIq/+IZ7utPbJf0cVECrpE/Pz4SDXktL14TqroNcTvr6AkAQFr7OMnJrFj+I
 ybiqChfDcQ+Ik+T3zh+VwQoMlFBllc60cv3LgGrXY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tpqzy-0002Ro-TM; Wed, 05 Mar 2025 15:49:34 +0000
Message-ID: <8957f2ce-5679-467a-ad91-7b96c9d7e11c@ilande.co.uk>
Date: Wed, 5 Mar 2025 15:50:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hab Gallagher <hab.gallagher@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
 <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
 <CABLmASFQby0KpR646Vp=7JGsw40_2cvW-gFa49f2G3iMCAz14A@mail.gmail.com>
 <85e1dcb9-f0d7-6ed2-6370-30cd8f31a604@eik.bme.hu>
 <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Adding gamma support to QemuMacDrivers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/03/2025 17:52, Hab Gallagher wrote:

(added Gerd on CC)

>     That driver is for a VGA device which I think does not support gamma in
>     hardware. QEMU emulates the hardware so if it does not support gamma then
>     there's no place to add it in QEMU. Therefore if you want to emulate gamma
>     on VGA this should be done within the guest driver but that may be slower.
>     How does this work on real hardware? What graphics device is used there
>     and does that support gamma in hardware? Maybe that graphics device needs
>     to be emulated instead?
> 
> 
> For understanding the MacOS side of things, I have been consulting https:// 
> developer.apple.com/library/archive/documentation/Hardware/DeviceManagers/pci_srvcs/ 
> pci_cards_drivers/Designing_PCI_Cards_Drivers.pdf <https://developer.apple.com/ 
> library/archive/documentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/ 
> Designing_PCI_Cards_Drivers.pdf>
> 
>     To reduce visible flashes resulting from color table changes, the SetGamma
>     routine works in conjunction with the SetEntries control routine on indexed
>     devices. The SetGamma routine first loads new gamma correction data into the
>     driver’s private storage; the next SetEntries control call applies the gamma
>     correction as it changes the CLUT. SetGamma calls are always followed by
>     SetEntries control calls on indexed devices.
> 
>     For direct devices, the SetGamma routine first sets up the gamma correction data
>     table. Next, it synthesizes a black-to-white linear ramp color table. Finally, it
>     applies the new gamma correction to the color table and sets the data directly in
>     the hardware.
> 
> 
> As far as I can tell, the documentation is implying that somewhere between the driver 
> and the physical hardware, *something* must keep track of the gamma table (even if 
> indirectly by subsequently applying it to the palette table) to map the raw 
> framebuffer data to gamma-corrected colors.
> 
>     Perhaps this is also of interest: https://github.com/SolraBizna/mac_qfb_driver
>     <https://github.com/SolraBizna/mac_qfb_driver>The nubus declaration rom supports
>     gamma correction.
> 
> 
> This is very much of interest! Thank you. I am hoping to continue to use the mac99 
> machine type, but this code is a useful reference.
> 
> The most basic support requires cscGetGamma and cscSetGamma to at least return 
> success: https://github.com/cebix/macemu/ 
> commit/2676e1bd134703d888788c682fb56e07b5cf56a9 <https://github.com/cebix/macemu/ 
> commit/2676e1bd134703d888788c682fb56e07b5cf56a9>
> The patch to SheepShaver was small because most of the functionality was already 
> present, albeit dead code.
> 
> Surprisingly, github can't deal with CR line endings, so I can't (easily) link to 
> some of the code to cite it: https://github.com/ozbenh/QemuMacDrivers/blob/master/ 
> shared/MacDriverUtils.c <https://github.com/ozbenh/QemuMacDrivers/blob/master/shared/ 
> MacDriverUtils.c>
> 
> Once the gamma table is saved, it's "applied" by cscSetEntries to combine a color 
> palette and gamma table into the "real" color. QemuMacDrivers does not seem to keep 
> track of the palette at all, sending it upstream to the driver by calling this 
> function in a loop:
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
> 
> Similarly, mac_qfb_driver seems to use MMIO to write back both the palette table and 
> the gamma table to the driver, saving neither one in emulated driver state: https:// 
> github.com/SolraBizna/mac_qfb_driver/blob/e78ba4ccd08d254a10bad7c13d90810b17dbfd87/ 
> src/control.cc#L48-L62 <https://github.com/SolraBizna/mac_qfb_driver/blob/ 
> e78ba4ccd08d254a10bad7c13d90810b17dbfd87/src/control.cc#L48-L62>

Implementing the registers to store the gamma table is trivial: the tricky part is 
updating the VGA framebuffer code to apply the gamma as it is rendered. Have a look 
at 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/vga.c?ref_type=heads#L1478 
(vga_draw_graphic) and 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/vga.c?ref_type=heads#L1194 
(vga_draw_text) to see how this is handled.

Gerd: what do you think would be the best way to apply a gamma to the VGA device?


ATB,

Mark.


