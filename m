Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81561C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5qe-0006rR-F1; Sun, 26 Jul 2026 16:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wo5qb-0006r1-JB
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:53:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wo5qZ-0005sS-FA
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XjNFehtKTJKdm6vs8roXQTZv4jBMDx2x6joMN+TcOZI=; b=w4h2MbENx4xKyrhsgASGzl3uib
 jv6LFfToPLPtmlGlxBZBkX+OQsQJZkkGYLBPXdUqnRhDl04aefsT8Qr7mzFogtsEc22d+iSJw8iW3
 53SvkKJZqL+5mSm85mOO33nVp4QkipSIewrKKiJcQoo+BT+DrZttDfRRhvWMSfYGBkhXj1kbvt/rm
 ntXJqdtfuV3nLz2dqAQiql1bIwyIHx3pBxltO4fygqHLS/LuE8usmYlNHZZwybPpBEsyYwCY81OpN
 klFDI9jv1aDQpy5iz2Z7x0cfB2JvB/6vBMWE/yqORdb9gQlLJn1wyq4SKFItFI4HswR5Tv6sIN2DB
 ZyVeTJdcc1bIJbX/HNJ5h0VxN68JSBDeTuthLPkUF4nc4AWA6n+cQwaEpmb14Y2Vegw3JwaNq9zmf
 CobvqeIwISoGYfMnwyNk+MdliMvo4MANEb2Byx87o46edoJ+7qZJFu6CrhyN943wOlIK3xbzpEr57
 Cq3787HAzVh76Oh1UKt15x02u2A2R2lfm5mfFnEOHXkSLU093vzxC13n0TpRPUTsRB1uMy4rOaRPe
 usFAQsI08Knn2JbaCJcrtLqQ5Uvub4+JFEUlp9fQnvwFWx+vy7+1oexGlrdM0UV7H7m7GYggdsuY5
 Fw6yMq1HwigqN2f9HOYXtDs32uFz2Mdra1oA81cqg=;
Received: from [2a02:8012:2f01:0:d527:7a5c:938e:d16d]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wo5qL-004iw2-K5; Sun, 26 Jul 2026 21:53:06 +0100
Message-ID: <4b6f6450-74ce-497f-b487-71fadf97dc3c@ilande.co.uk>
Date: Sun, 26 Jul 2026 21:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: Nathan Chancellor <nathan@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
 <20260722011530.GA2116566@ax162>
 <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d527:7a5c:938e:d16d
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

On 25/07/2026 10:20, Mark Cave-Ayland wrote:

> On 22/07/2026 02:15, Nathan Chancellor wrote:
> 
>> Hi Mark,
>>
>> On Tue, Jul 07, 2026 at 10:32:05PM +0100, Mark Cave-Ayland wrote:
>>> The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:
>>>
>>>    Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into 
>>> staging (2026-07-07 07:09:38 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/mcayland/qemu.git tags/qemu-openbios-20260707
>>>
>>> for you to fetch changes up to 9e3508dce0045de26ec8cab064443c92fdd15288:
>>>
>>>    Update OpenBIOS images to e5ac46dd built from submodule. (2026-07-07 22:07:16 
>>> +0100)
>>>
>>> ----------------------------------------------------------------
>>> qemu-openbios queue
>>>
>>> ----------------------------------------------------------------
>>> Mark Cave-Ayland (1):
>>>        Update OpenBIOS images to e5ac46dd built from submodule.
>>>
>>>   pc-bios/openbios-ppc     | Bin 677200 -> 673104 bytes
>>>   pc-bios/openbios-sparc32 | Bin 382080 -> 382048 bytes
>>>   pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>>>   roms/openbios            |   2 +-
>>>   4 files changed, 1 insertion(+), 1 deletion(-)
>>
>> I bisected a hang that I see when trying to boot a Linux kernel built
>> from pmac32_defconfig to this change.
>>
>>    $ git show 9e3508dce0045de26ec8cab064443c92fdd15288:pc-bios/openbios-ppc 
>> >openbios-ppc-bad
>>
>>    $ git show 9e3508dce0045de26ec8cab064443c92fdd15288^:pc-bios/openbios-ppc 
>> >openbios-ppc-good
>>
>>    $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/ 
>> qemu-9e3508dce0045de26ec8cab064443c92fdd15288/rootfs.cpio.zst | zstd -d >rootfs.cpio
>>
>>    $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/ 
>> qemu-9e3508dce0045de26ec8cab064443c92fdd15288/vmlinux.zst | zstd -d >vmlinux
>>
>>    $ qemu-system-ppc \
>>        -display none \
>>        -nodefaults \
>>        -no-reboot \
>>        -machine mac99 \
>>        -append console=ttyS0 \
>>        -kernel ./vmlinux \
>>        -initrd ./rootfs.cpio \
>>        -m 128m \
>>        -serial mon:stdio \
>>        -bios ./openbios-ppc-good
>>
>>    >> =============================================================
>>    >> OpenBIOS 1.1 [Sep 24 2024 19:56]
>>    >> Configuration device id QEMU version 1 machine id 1
>>    >> CPUs: 1
>>    >> Memory: 128M
>>    >> UUID: 00000000-0000-0000-0000-000000000000
>>    >> CPU type PowerPC,G4
>>    milliseconds isn't unique.
>>    Output device screen not found.
>>    Output device screen not found.
>>    >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 
>> 0x004fb000)
>>    >> [ppc] Kernel command line: console=ttyS0
>>    >> switching to new context:
>>    NULL ihandle
>>    Unexpected client interface exception: -2
>>    printk: legacy console [ttyS0] enabled
>>    printk: legacy bootconsole [udbg0] disabled
>>    pid_max: default: 32768 minimum: 301
>>    Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
>>    Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
>>    VFS: Finished mounting rootfs on nullfs
>>    Memory: 108176K/131072K available (10508K kernel code, 1004K rwdata, 2180K 
>> rodata, 1232K init, 178K bss, 21680K reserved, 0K cma-reserved, 0K highmem)
>>    Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
>>    ...
>>    Starting network: OK
>>    Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 16.1.0, GNU ld 
>> (GNU Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
>>    Stopping network:OK
>>    Stopping klogd: OK
>>    Stopping syslogd: OK
>>    Seeding 256 bits without crediting
>>    seedrng: can't open '/dev/urandom': No such file or directory
>>    The system is going down NOW!
>>    Sent SIGTERM to all processes
>>    Sent SIGKILL to all processes
>>    Requesting system reboot
>>    reboot: Restarting system
>>
>>    $ qemu-system-ppc \
>>        -display none \
>>        -nodefaults \
>>        -no-reboot \
>>        -machine mac99 \
>>        -append console=ttyS0 \
>>        -kernel ./vmlinux \
>>        -initrd ./rootfs.cpio \
>>        -m 128m \
>>        -serial mon:stdio \
>>        -bios ./openbios-ppc-bad
>>
>>    >> =============================================================
>>    >> OpenBIOS 1.1 [Jun 29 2026 21:11]
>>    >> Configuration device id QEMU version 1 machine id 1
>>    >> CPUs: 1
>>    >> Memory: 128M
>>    >> UUID: 00000000-0000-0000-0000-000000000000
>>    >> CPU type PowerPC,G4
>>    milliseconds isn't unique.
>>    Output device screen not found.
>>    Output device screen not found.
>>    >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 
>> 0x004fb000)
>>    >> [ppc] Kernel command line: console=ttyS0
>>    >> switching to new context:
>>    <hangs with no additional output>
>>
>> Presumably this is due to OpenBIOS commit b0267d5 ("ppc: bump SAVE_SPACE
>> to include enough space to store all registers"), as this appears to be
>> the only actual source change to OpenBIOS? I have not had time to try
>> running under gdb to get more information about where it is hanging but
>> I wanted to get this report out sooner rather than later.
> 
> Hi Nathan,
> 
> Thanks for the heads-up: nothing showed up in my local tests before committing, so I 
> will take a look over the next few days.

I've tried to reproduce this, however I cannot get your vmlinux above to work here 
with either the old or new OpenBIOS. Is there anything else about your environment 
needed to reproduce this?

I have seen some recent-ish updates to the Linux open firmware APIs so I'm wondering 
if this is exposing another bug somewhere?


ATB,

Mark.


