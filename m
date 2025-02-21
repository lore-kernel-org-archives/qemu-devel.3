Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813E5C021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 00:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlGfS-00053B-BZ; Thu, 20 Feb 2025 19:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tlGfG-00051k-76; Thu, 20 Feb 2025 19:13:10 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tlGfE-0000sg-4x; Thu, 20 Feb 2025 19:13:09 -0500
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tlGf8-000KOX-0n; Fri, 21 Feb 2025 01:13:02 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tlGf7-000JRD-1T; Fri, 21 Feb 2025 01:13:02 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id A0FA348005E;
 Fri, 21 Feb 2025 01:13:01 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ijG22iZnNhgk; Fri, 21 Feb 2025 01:13:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 22744480068;
 Fri, 21 Feb 2025 01:13:01 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FgRWrhI-TE-R; Fri, 21 Feb 2025 01:13:01 +0100 (CET)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id F0AD548005E;
 Fri, 21 Feb 2025 01:13:00 +0100 (CET)
Date: Fri, 21 Feb 2025 01:13:00 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Bin Meng <bin.meng@windriver.com>, 
 alistair francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Message-ID: <1920480470.18351.1740096780484.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <ade78f31-5279-4862-acdd-15f083a000e2@linaro.org>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250220-reggae-hardness-907e385516d8@spud>
 <ade78f31-5279-4862-acdd-15f083a000e2@linaro.org>
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - FF128
 (Linux)/10.1.5_GA_4734)
Thread-Topic: Improve Microchip Polarfire SoC customization
Thread-Index: GvfhjsHXoypQemeuaUOQEk72XQRo9Q==
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27555/Thu Feb 20 10:43:53 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
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

----- Am 20. Feb 2025 um 23:29 schrieb Philippe Mathieu-Daud=C3=A9 philmd@l=
inaro.org:

> Hi Conor,
>=20
> On 20/2/25 19:30, Conor Dooley wrote:
>> +cc qemu-riscv, Alistar.
>>=20
>> On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
>>> Booting the microchip-icicle-kit machine using the latest PolarFire SoC
>>> Hart Software Services (HSS) no longer works since Qemu lacks support
>>> for several registers (clocks, DRAM controller). Also reading from the
>>> SDCard does not work currently.
>>=20
>> On that note, I think the inaccurate docs about polarfire should be
>> removed. There's a wiki page here with dead links, or links to things
>> that do not work anymore:
>> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_=
SoC_Icicle_Kit
>> I think the whole section should be removed, find it kinda odd that
>> there's a polarfire section but not for any other board. Either way,
>> it's talking about something that just does not work, the current HSS
>> and Yocto don't boot.
>>=20
>> There's also a docs page here:
>> https://www.qemu.org/docs/master/system/riscv/microchip-icicle-kit.html
>> that has a copy of the table your patch 4 modifies, that probably should
>> be updated to match your changes.
>>=20
>> In a similar vein to the wiki, it talks about the HSS and booting a
>> yocto wic image. I think those should be deleted since they don't work.
>>=20
>> Alistar/Other RISC-V folks, what do you think? Bin wrote the port but
>> seems to be AFK and I don't have the capacity to fix any of that stuff
>> on top of what I already do in my spare time - do you agree that
>> deleting the now inaccurate docs makes sense?
>>=20
>>> In order to allow tests runs for real-time kernels such as RTEMS and
>>> Zephyr, improve the boot customization. This patch set enables a direct
>>> run of kernel executables, for example:
>>>
>>> qemu-system-riscv64 -no-reboot -nographic \
>>>    -serial null -serial mon:stdio \
>>>    -smp 2 \
>>>    -bios none \
>>>    -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000 \
>>>    -kernel rtos.elf
>>=20
>> The series breaks my usage:
>> qemu//build/qemu-system-riscv64 -M microchip-icicle-kit \
>>          -m 3G -smp 5 \
>>          -kernel vmlinux.bin \
>>          -dtb riscvpc.dtb \
>>          -initrd initramfs.cpio.gz \
>>          -display none -serial null \
>>          -serial mon:stdio \
>>          -D qemu.log -d unimp
>> opensbi-riscv64-generic-fw_dynamic.bin: No such file or directory
>> qemu-system-riscv64: could not load firmware
>> 'opensbi-riscv64-generic-fw_dynamic.bin'
>> make: *** [Makefile:305: qemu-icicle] Error 1
>>=20
>> Figure it is likely to be your patch 4? The file does exist, so probably
>> some sort of path-to-it issues?
>=20
> Maybe missing the -L option?
>=20
>   -L path         set the directory for the BIOS, VGA BIOS and keymaps

It was an error in patch 4/5. I sent a v2 version of it.

You have to find the firmware, before you can load it.

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

