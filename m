Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DF3C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnYYq-0003wG-P3; Sat, 25 Jul 2026 05:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYYk-0003vx-5r
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:20:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYYh-0001fm-9x
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dG83efNC3hmSzmXmoLmEgJZX0pGJFpgGwZEumYJk4/8=; b=xSwYtIiAHU+ofOFFCUCZ7rq8nB
 2nky7mKFXyqQJpjW1quWirQmO1LANZNJQHbMvkZxYUzq6eMIEpRqYs+FNgKqa3hkP57Z2cMgbi4Qo
 Jrlay81NHveYwXI8ZVEsZjGlEt7JD1ww5BDWJxGIOSJNCO8KrCkKJekNbNpYo7cLmQcWIWsEL+0FT
 5JpweuvCxFOvA4qomYHxXQaOywEA0s0Nj9SIENvjE1TXU0ByVpA9krZojyS96hRczHdwocIKggqSo
 /7evEZGyMd+SrPk1h+f9CQrPl6v/e7IrXVsePElT5efHPm2TgllCHhN51PAlypKy0e/tRbKFZW7W5
 EquxSvGGJKLyJ9RZ/lNRVLWRmN8gzD10R//8Yo3isvXVRgM3j6vfdpTt/n0ELMTc2kgfmL3mgc4gd
 mkymUtqjsGTnzllsqY/rEknxptXH6CdAeZdTbfcHxtP1PD8c8LdE4IBsiQXqNQBSiCqzM6alRiz/0
 EqEgNuEv1N01fzWpyQX/MhUMwuaprjvWsMApvOys5ha53fdv2LPC0eGUvOzRRGUYQSeYV79FLt+oa
 hJ1s9ue35HNI+IGEtfPWp8JNCcE68nCueTz5rolXVwhh7gDgRmkNeuWcRJd01bRDyNJMDx8c/Ilj5
 l2qMQRrtc9/6GS0XXQzH1zAGb63sIPNrUsgBF5/9c=;
Received: from [2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYYV-004Ula-1p; Sat, 25 Jul 2026 10:20:27 +0100
Message-ID: <f4be0cc9-68ae-4f83-a40b-9af84109c54f@ilande.co.uk>
Date: Sat, 25 Jul 2026 10:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Chancellor <nathan@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
 <20260722011530.GA2116566@ax162>
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
In-Reply-To: <20260722011530.GA2116566@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e
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

On 22/07/2026 02:15, Nathan Chancellor wrote:

> Hi Mark,
> 
> On Tue, Jul 07, 2026 at 10:32:05PM +0100, Mark Cave-Ayland wrote:
>> The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:
>>
>>    Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/mcayland/qemu.git tags/qemu-openbios-20260707
>>
>> for you to fetch changes up to 9e3508dce0045de26ec8cab064443c92fdd15288:
>>
>>    Update OpenBIOS images to e5ac46dd built from submodule. (2026-07-07 22:07:16 +0100)
>>
>> ----------------------------------------------------------------
>> qemu-openbios queue
>>
>> ----------------------------------------------------------------
>> Mark Cave-Ayland (1):
>>        Update OpenBIOS images to e5ac46dd built from submodule.
>>
>>   pc-bios/openbios-ppc     | Bin 677200 -> 673104 bytes
>>   pc-bios/openbios-sparc32 | Bin 382080 -> 382048 bytes
>>   pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>>   roms/openbios            |   2 +-
>>   4 files changed, 1 insertion(+), 1 deletion(-)
> 
> I bisected a hang that I see when trying to boot a Linux kernel built
> from pmac32_defconfig to this change.
> 
>    $ git show 9e3508dce0045de26ec8cab064443c92fdd15288:pc-bios/openbios-ppc >openbios-ppc-bad
> 
>    $ git show 9e3508dce0045de26ec8cab064443c92fdd15288^:pc-bios/openbios-ppc >openbios-ppc-good
> 
>    $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/qemu-9e3508dce0045de26ec8cab064443c92fdd15288/rootfs.cpio.zst | zstd -d >rootfs.cpio
> 
>    $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/qemu-9e3508dce0045de26ec8cab064443c92fdd15288/vmlinux.zst | zstd -d >vmlinux
> 
>    $ qemu-system-ppc \
>        -display none \
>        -nodefaults \
>        -no-reboot \
>        -machine mac99 \
>        -append console=ttyS0 \
>        -kernel ./vmlinux \
>        -initrd ./rootfs.cpio \
>        -m 128m \
>        -serial mon:stdio \
>        -bios ./openbios-ppc-good
> 
>    >> =============================================================
>    >> OpenBIOS 1.1 [Sep 24 2024 19:56]
>    >> Configuration device id QEMU version 1 machine id 1
>    >> CPUs: 1
>    >> Memory: 128M
>    >> UUID: 00000000-0000-0000-0000-000000000000
>    >> CPU type PowerPC,G4
>    milliseconds isn't unique.
>    Output device screen not found.
>    Output device screen not found.
>    >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 0x004fb000)
>    >> [ppc] Kernel command line: console=ttyS0
>    >> switching to new context:
>    NULL ihandle
>    Unexpected client interface exception: -2
>    printk: legacy console [ttyS0] enabled
>    printk: legacy bootconsole [udbg0] disabled
>    pid_max: default: 32768 minimum: 301
>    Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
>    Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
>    VFS: Finished mounting rootfs on nullfs
>    Memory: 108176K/131072K available (10508K kernel code, 1004K rwdata, 2180K rodata, 1232K init, 178K bss, 21680K reserved, 0K cma-reserved, 0K highmem)
>    Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
>    ...
>    Starting network: OK
>    Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 16.1.0, GNU ld (GNU Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
>    Stopping network:OK
>    Stopping klogd: OK
>    Stopping syslogd: OK
>    Seeding 256 bits without crediting
>    seedrng: can't open '/dev/urandom': No such file or directory
>    The system is going down NOW!
>    Sent SIGTERM to all processes
>    Sent SIGKILL to all processes
>    Requesting system reboot
>    reboot: Restarting system
> 
>    $ qemu-system-ppc \
>        -display none \
>        -nodefaults \
>        -no-reboot \
>        -machine mac99 \
>        -append console=ttyS0 \
>        -kernel ./vmlinux \
>        -initrd ./rootfs.cpio \
>        -m 128m \
>        -serial mon:stdio \
>        -bios ./openbios-ppc-bad
> 
>    >> =============================================================
>    >> OpenBIOS 1.1 [Jun 29 2026 21:11]
>    >> Configuration device id QEMU version 1 machine id 1
>    >> CPUs: 1
>    >> Memory: 128M
>    >> UUID: 00000000-0000-0000-0000-000000000000
>    >> CPU type PowerPC,G4
>    milliseconds isn't unique.
>    Output device screen not found.
>    Output device screen not found.
>    >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 0x004fb000)
>    >> [ppc] Kernel command line: console=ttyS0
>    >> switching to new context:
>    <hangs with no additional output>
> 
> Presumably this is due to OpenBIOS commit b0267d5 ("ppc: bump SAVE_SPACE
> to include enough space to store all registers"), as this appears to be
> the only actual source change to OpenBIOS? I have not had time to try
> running under gdb to get more information about where it is hanging but
> I wanted to get this report out sooner rather than later.

Hi Nathan,

Thanks for the heads-up: nothing showed up in my local tests before committing, so I 
will take a look over the next few days.


ATB,

Mark.


