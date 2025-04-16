Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0195C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53RM-0005c6-Rc; Wed, 16 Apr 2025 10:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u53RB-0005ab-Rt; Wed, 16 Apr 2025 10:08:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u53R9-0001zV-9R; Wed, 16 Apr 2025 10:08:25 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 07B624E601D;
 Wed, 16 Apr 2025 16:08:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0R9bl3JWV48j; Wed, 16 Apr 2025 16:08:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F421A4E600F; Wed, 16 Apr 2025 16:08:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F1B5674577C;
 Wed, 16 Apr 2025 16:08:16 +0200 (CEST)
Date: Wed, 16 Apr 2025 16:08:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Andr=E9_from_Negmaster?= <andre@negmaster.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-discuss@nongnu.org, qemu-ppc@nongnu.org, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: PPC MacOS9 SCSI PCI Passthrough
In-Reply-To: <529770bb-3026-403d-b6f2-24efea26122d@linaro.org>
Message-ID: <5b3d61f7-3029-664f-2b36-ccc6918d48b3@eik.bme.hu>
References: <339F0125-96C3-49FD-8088-185570DAE412@negmaster.com>
 <529770bb-3026-403d-b6f2-24efea26122d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-612314375-1744812496=:76743"
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

--3866299591-612314375-1744812496=:76743
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hello,

On Wed, 16 Apr 2025, Philippe Mathieu-Daudé wrote:
> adding more PPC developers.

Maybe they are more likely to be found on qemu-ppc list and adding Howard 
who may have some guide on this.

> On 16/4/25 10:42, André from Negmaster wrote:
>> First of all many thanks for your work on PPC emulation.
>> 
>> I would like to request SCSI/PCI passthrough to MacOS9 if possible.
>> 
>> I spent the last two days trying to get this working to no avail. To me it 
>> seems QEMU can't do that. The PPC documentation is missing information 
>> about passthrough. I would like to see some more information there. Because 
>> i am still not sure if it would work or not. I passed all hurdles, like 
>> IOMMU groups, IRQ issues etc...but still no SCSI card or scanner in the 
>> system profiler.

There's not enough information here to give more than generic advice 
(details such as which qemu-system-ppc -machine, MacOS version, SCSI card, 
etc. may be needed to see what you tried). In general it should work. Some 
people successfully passed through video cards, usb and network cards for 
qemu-system-ppc so QEMU can do that but this may not be plug and play 
especially with MacOS if it needs an FCode ROM to be run as OpenBIOS does 
not do that by default and may not be able to run it even if you try 
manually. We needed patches for video card ROMs before.

There are two ways to pass through a SCSI device: passing through the SCSI 
card and letting the host handle SCSI and only pass through the SCSI 
device. For the latter you need an emulated SCSI card that's recognised by 
the guest. Most guides talk about virtio-scsi but I don't think MacOS has 
a driver for that and don't know if any of the emulated SCSI adapters 
would work. Classic Macs have an ESP SCSI adapter AFAIK and dc390 seems to 
be a PCI version of that so maybe that could work but if MacOS needs 
anything in device-tree that would be added by an FCode ROM then it's 
again the same problem as with a passed through card. If you don't want to 
dig deeper and change anything in OpenBIOS and QEMU to make it work what 
you could do is try all the emulated SCSI devices and try to find MacOS 
drivers for them and see if any of those works then if you get a SCSI 
adapter in the guest you could try passing through the device only. For 
passing through the card I'd check first if it has an FCode ROM and then 
try to run that in OpenBIOS manually (I forgot how to do that but sombody 
may remember or dig up old messages on this) and then maybe patch OpenBIOS 
to work with that.

So it may not be easy to set up and may require fixing some issues here 
and there but generally it's possible and was done for some cards before 
so there's no theretical limit that would prevent it from working.

Regards,
BALATON Zoltan
--3866299591-612314375-1744812496=:76743--

