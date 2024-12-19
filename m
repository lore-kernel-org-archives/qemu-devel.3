Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFFAE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCkn-0007PP-15; Thu, 19 Dec 2024 04:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tOCka-0007Oi-54
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:23:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tOCkY-0008K3-3M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:23:19 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D5DD4E603D;
 Thu, 19 Dec 2024 10:23:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id sZgvGM-YMqRf; Thu, 19 Dec 2024 10:23:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 458A04E602D; Thu, 19 Dec 2024 10:23:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 43070746F60;
 Thu, 19 Dec 2024 10:23:13 +0100 (CET)
Date: Thu, 19 Dec 2024 10:23:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Phil Dennis-Jordan <phil@philjordan.eu>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
In-Reply-To: <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
Message-ID: <ba2749f3-8cc4-0ea6-57dd-aa122403b937@eik.bme.hu>
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
 <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
 <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
 <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1970095062-1734600039=:17436"
Content-ID: <4e633835-7238-657b-1b1a-92cf03bb4659@eik.bme.hu>
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

--3866299591-1970095062-1734600039=:17436
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <a713be01-ed2c-2c3b-024b-12eaa37482f1@eik.bme.hu>

On Wed, 18 Dec 2024, Phil Dennis-Jordan wrote:
> On Wed, 18 Dec 2024 at 02:19, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote:
>>> Hey Nicholas,
>>>
>>> I'm not an XHCI & PCI expert (yet?) so apologies if I've got some of this
>>> wrong, but I've asked some questions and made some comments inline:
>>
>> Hey Phil,
>>
>> Thanks for the review, looks like you are the expert now :)
>>
>
> The "hot potato" method for determining maintainership. :-)

That's how I got some parts I'm maintainer of now. :-)

[...]
>>> On Thu, 12 Dec 2024 at 09:52, Nicholas Piggin <npiggin@gmail.com> wrote:
>>> Surely we should only propagate the error and fail realize() iff s->msix
>> is
>>> ON_OFF_AUTO_ON?
>>>
>>> For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical error.
>>
>> Yep you're right... you had been testing with msix disabled. I wonder if
>> there is a good way to force fail this in qtests?
>>
>
> I'm really the wrong person to ask about qtest, I'm only just beginning to
> get to grips with it. It seems the only real reason msix_init fails other
> than misconfiguration of the device/BAR is when msi_nonbroken = false.
>
> At least on x86(-64), msi_nonbroken=true is unconditionally set in
> apic_realize(). (I think real hardware would not support MSI(-X) on the
> i440FX chipset - I was fairly certain it was the PCI root/southbridge
> catching the writes to the reserved memory region, and I didn't think the
> PIIX did this; but at least in QEMU it doesn't seem to be implemented in a
> chipset-dependent way.) I'm not sure it's possible to run QEMU without an
> APIC?

There's isapc but you can't attach PCI card to that. It seems according to 
-machine pc,help that there's a PIC=<OnOffAuto> option but no similar for 
APIC. Maybe that could be added but not sure it would work. (Adding 
Bernhard to cc to quickly pass on the potato.)

Regards,
BALATON Zoltan

> On aarch64, the GICv3 needs to explicitly enable support (via the ITS), so
> perhaps it's possible to set up an aarch64 qtest with ITS disabled? It
> looks like the 'virt' machine type only supports the ITS from version 6.2,
> so older versions will disable it.
>
> Sorry, clutching at straws here.
>
>
>>>> +
>>>> +        pci_register_bar(dev, s->msix_bar_nr,
>>>> +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
>>>> +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
>>>> +                         msix_bar);
>>>>
>>>
>>> Is it safe to call pci_register_bar() again for the msix_bar_nr = 0 case?
>>> Even if it is safe, is it sensible? If we're calling it twice for the
>> same
>>> BAR, and the arguments of either of the calls changes in future, the
>> other
>>> needs to change too. Doesn't seem ideal.
>>
>> Good catch. It looks like it "works" so long as the bar wasn't mapped,
>> but I'm sure bad practice... Interesting there is no assertion in
>> there though. I'll fix it though.
>>
>
> I notice there's a msix_init_exclusive_bar()… I wonder if it'd be simpler
> to use that and modify it so it allows you to choose a size and layout for
> the BAR, rather than adding all that extra code to deal with the extra BAR
> in the XHCI?
> (It already calls pci_register_bar() and msix_init() internally, but seems
> to set the BAR's size to 4096 and places the PBA at halfway through the
> BAR. Perhaps rename it to something like
> msix_init_exclusive_bar_with_layout and pass the bar_size and
> bar_pba_offset in as parameters; then make msix_init_exclusive_bar() a
> wrapper for that function with the existing defaults for those variables?)
>
> Just kicking around some ideas here, I have no idea if that actually ends
> up making things simpler…
>
>
>> Thanks,
>> Nick
>>
>
--3866299591-1970095062-1734600039=:17436--

