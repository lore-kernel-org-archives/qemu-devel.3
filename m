Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC4C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBOG-00041d-Rr; Wed, 29 Jan 2025 11:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBOF-00041Q-6l; Wed, 29 Jan 2025 11:58:11 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBOC-0005jA-DA; Wed, 29 Jan 2025 11:58:10 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D3E594E6027;
 Wed, 29 Jan 2025 17:58:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hmNYkulNGHrh; Wed, 29 Jan 2025 17:58:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DB6184E6014; Wed, 29 Jan 2025 17:58:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D93A674577C;
 Wed, 29 Jan 2025 17:58:01 +0100 (CET)
Date: Wed, 29 Jan 2025 17:58:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
In-Reply-To: <6fa2c0ba-68d7-45ce-86e9-ec9e695cc893@redhat.com>
Message-ID: <7c052173-a661-4892-5427-93be48661b5d@eik.bme.hu>
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
 <9bf6cf01-d8c4-4ed8-808d-03e6ee05bc7b@redhat.com>
 <c2dce6f7-7b76-7531-7013-366c9d7eac4e@eik.bme.hu>
 <6fa2c0ba-68d7-45ce-86e9-ec9e695cc893@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1562982892-1738169881=:21657"
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

--3866299591-1562982892-1738169881=:21657
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jan 2025, Cédric Le Goater wrote:
>>>>> +        self.vm.set_console()
>>>>> +
>>>>> +        self.vm.add_args('-kernel', linux_path,
>>>>> +                         '-append', 'root=/dev/sda',
>>>>> +                         '-drive', f'file={rootfs_path},format=raw',
>>>>> +                         '-net', 'nic,model=sungem', '-net', 'user',
>> 
>> The machine already has a default sungem NIC so maybe you can omit that 
>> too. 
>
> Yes. It works well without it. Will remove the nic.
>
>> The user network used to be the default so even that may not be needed but 
>> I'm not sure if that's still the case since libslirp was moved out. Wasn't 
>> the preferred option -netdev user nowadays and -device for the card?
>> 
>>>>> +                         '-snapshot', '-nographic')
>>>> 
>>>> I just also noticed that we already have "-display none" in 
>>>> python/qemu/machine/machine.py, so you likely don't need the -nographic 
>>>> here (but looks like we've got that wrong in a bunch of tests already).
>>> 
>>> I think we need -nographic else OpenBIOS crashes.  I will check.
>> 
>> It should not crash 
>
> It doesn't crash indeed, but it complains :
>
>  2025-01-28 21:55:24,498: >> CPU type PowerPC,970FX
>  2025-01-28 21:55:24,501: milliseconds isn't unique.
>  2025-01-28 21:55:24,540: Output device screen not found.
>  2025-01-28 21:55:24,545: Output device screen not found.
>  2025-01-28 21:55:24,548: >> [ppc] Kernel already loaded (0x01000000 + 
> 0x014a8b58) (initrd 0x00000000 + 0x00000000)
>  2025-01-28 21:55:24,548: >> [ppc] Kernel command line: root=/dev/sda
>  2025-01-28 21:55:24,560: >> switching to new context:
>  2025-01-28 21:55:24,567: NULL ihandle
>  2025-01-28 21:55:24,567: Unexpected client interface exception: -2
>
> and there is no console ouput. With -nographic :

I think the Linux platform init code outputs something via OpenFirmware 
before it parses the command line and OpenBIOS can't handle that when 
there's no display. So either -vga none or -nographic is needed to remove 
the VGA card and get OpenBIOS to fall back to serial.

Regards,
BALATON Zoltan

>  2025-01-28 22:19:42,938: >> CPU type PowerPC,970FX
>  2025-01-28 22:19:42,941: milliseconds isn't unique.
>  2025-01-28 22:19:42,993: Welcome to OpenBIOS v1.1 built on Sep 24 2024 
> 19:56
>  2025-01-28 22:19:42,997: >> [ppc] Kernel already loaded (0x01000000 + 
> 0x014a8b58) (initrd 0x00000000 + 0x00000000)
>  2025-01-28 22:19:42,997: >> [ppc] Kernel command line: root=/dev/sda
>  2025-01-28 22:19:43,010: >> switching to new context:
>  2025-01-28 22:19:43,018: OF stdout device is: 
> /pci@f0000000/mac-io@c/escc@13000/ch-a@13020
>
>
>> but maybe it displays then on the graphics output so you won't get the 
>> needed feedback on serial? Although -append 'console=tty<whatever it's 
>> called on that machine>' might fix that. 
>
> Nope.
>
>> But using -nographic makes sense for a serial only test.
>
> I will keep -nographic  for this test.
>
> Thanks,
> C.
>
>
>
--3866299591-1562982892-1738169881=:21657--

