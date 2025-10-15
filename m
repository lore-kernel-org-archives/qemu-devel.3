Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E4CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96pb-0003U8-W1; Wed, 15 Oct 2025 15:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v96pa-0003Tx-Cf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:06:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v96pP-0006k6-AX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=alxVnQo6RTMNhUpheea8qHlmpzaD86UhzFG2F+tLOJU=; b=PvE1gUdewypYeLzHAWAb2t6laN
 I0Ry0sO3PVBpvHwWaKx3MOj+sC0lKq6AS9pZCUfTC4tqYYPUZQDili+VVsjq/YslkEnRMiZInkCG+
 OdCXjMdGGH4FEsUu7wzeuHvl8N6jQUIWwHC4syV1Uzkp7xeVnHzzbl1keYZr2VpraA+qCPBH/HcP7
 V+zUBLqxmE71u/jgrTx0mVfIG7S//CsFR4P0K9NCnVJhPRpy9CkFgPlzJntKiAKGqjQ166ArMaxwS
 XPeu1eX5EebTkpKRegZwmhQROdOB90YLy61BADYs/hcuRtYM0gN/u3TsLD8Fg0wj+5KLfFrP1BWPI
 OKGCRHjf49qDh8eBGrRbE9ExieXYDQi4+zxGz5Ka1dKR33SP3NEgXnGxdalFoEyW21bacIqCKHLMI
 4LqJ9CW6sdxZ9U8+oG+bWudLO2yQaBI+Ir98jwPxLvUn8JUGPmyzaIQMkMFSdHVrYsKYb6nZTQ9lc
 P3XEJ4W7XVX1e4lVFtk7MiTvzHJU5bJ53kj4sjFwHCug/d5R2JG1Y9PikcQ5k5aBkVgIc74UqGIij
 QdiRCaLS3ualp0RWKhxvQe8wfVPh7Kr6MdD8YgSiErxBUEW4dKX700eZ9OKiBCaLIQHXZYjgxU8PX
 Rlpahu85DaVG3De7eNSxGUAeNPaPo2AmRQ8Dskjy0=;
Received: from [2a02:8012:2f01:0:fdd2:5974:452d:adcc]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v96mv-000CRd-IS; Wed, 15 Oct 2025 20:03:57 +0100
Message-ID: <30f3c816-83d7-4a2b-8107-de5c433d183a@ilande.co.uk>
Date: Wed, 15 Oct 2025 20:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
 <20250711204636.542964-8-mark.cave-ayland@ilande.co.uk>
 <43ef15f9-1225-4416-9d04-eefc4f6eb952@tls.msk.ru>
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
In-Reply-To: <43ef15f9-1225-4416-9d04-eefc4f6eb952@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fdd2:5974:452d:adcc
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 7/7] esp.c: only allow ESP commands permitted in the
 current asc_mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/10/2025 18:31, Michael Tokarev wrote:

> 11.07.2025 23:46, Mark Cave-Ayland wrote:
>> If an ESP command is issued in an incorrect mode then an illegal command
>> interrupt should be generated. Add a new esp_cmd_is_valid() function to
>> indicate whether the ESP command is valid for the current mode, and if not
>> then raise the illegal command interrupt.
>>
>> This fixes WinNT MIPS which issues ICCS after a Chip Reset which is not
>> permitted, but will fail with an INACCESSIBLE_BOOT_DEVICE error unless an
>> interrupt is generated.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Fixes: 83428f7a97 ("esp.c: move write_response() non-DMA logic to esp_do_nodma()")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2464
> 
> This is commit 6f8ce26bb00 which landed between v10.0.0 and v10.1.0,
> and after seabios update to 1.17.0.
> 
> This commit - bisectable - breaks qemu's cdrom test.
>  
> $ PYTHON=python3 QTEST_QEMU_BINARY=./qemu-system-i386 tests/qtest/cdrom-test --tap -k 
> -p /i386/cdrom/boot/am53c974
> TAP version 14
> # random seed: R02S10a5ccc054a33d854e7868e868e33d3c
> xorriso 1.5.6 : RockRidge filesystem manipulator, libburnia project.
> 
> xorriso 1.5.6
> ISO 9660 Rock Ridge filesystem manipulator and CD/DVD/BD burn program
> Copyright (C) 2023, Thomas Schmitt <scdbackup@gmx.net>, libburnia project.
> xorriso version   :  1.5.6
> Version timestamp :  2023.06.07.180001
> Build timestamp   :  -none-given-
> libisofs   in use :  1.5.6  (min. 1.5.6)
> libjte     in use :  2.0.0  (min. 2.0.0)
> libburn    in use :  1.5.6  (min. 1.5.6)
> libburn OS adapter:  internal GNU/Linux SG_IO adapter sg-linux
> libisoburn in use :  1.5.6  (min. 1.5.6)
> Provided under GNU GPL version 3 or later, due to libreadline license.
> There is NO WARRANTY, to the extent permitted by law.
> xorriso 1.5.6 : RockRidge filesystem manipulator, libburnia project.
> 
> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1823149.sock -qtest- 
> log /dev/null -chardev socket,path=/tmp/qtest-1823149.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -audio none -machine none -accel qtest
> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1823149.sock -qtest- 
> log /dev/null -chardev socket,path=/tmp/qtest-1823149.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -audio none -machine none -accel qtest
> # Start of i386 tests
> # Start of cdrom tests
> # Start of boot tests
> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1823149.sock -qtest- 
> log /dev/null -chardev socket,path=/tmp/qtest-1823149.qmp,id=char0 -mon 
> chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -no- 
> shutdown -device am53c974 -device scsi-cd,drive=cd1 -drive 
> if=none,id=cd1,format=raw,file=cdrom-boot-iso-b5O01H -accel qtest
> 
> [long pause - I guess qemu binary just times out after a few minutes]
> 
> ERROR:../../build/qemu/10.1/tests/qtest/boot-sector.c:173:boot_sector_test: assertion 
> failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
> 
> 
> Mark, it looks you were right on IRC - this is one of your ESP changes :)
> 
> But I also wonder why we haven't noticed this in the CI on gitlab.  I only
> come across it on my local system when I installed xorriso for an unrelated
> reason, and this test started to fail - I thought it's my staging-10.1
> regression :)

Yeah that's an odd one. I just tested master here and it works fine here on Debian 
bookworm:


$ PYTHON=python3 QTEST_QEMU_BINARY=./qemu-system-i386 tests/qtest/cdrom-test --tap -k 
-p /i386/cdrom/boot/am53c974
# random seed: R02Sa8c7bf5b1a18b3b0358cc0699bb45534
xorriso 1.5.4 : RockRidge filesystem manipulator, libburnia project.

xorriso 1.5.4
ISO 9660 Rock Ridge filesystem manipulator and CD/DVD/BD burn program
Copyright (C) 2019, Thomas Schmitt <scdbackup@gmx.net>, libburnia project.
xorriso version   :  1.5.4
Version timestamp :  2021.01.30.150001
Build timestamp   :  -none-given-
libisofs   in use :  1.5.4  (min. 1.5.4)
libjte     in use :  2.0.0  (min. 2.0.0)
libburn    in use :  1.5.4  (min. 1.5.4)
libburn OS adapter:  internal GNU/Linux SG_IO adapter sg-linux
libisoburn in use :  1.5.4  (min. 1.5.4)
Provided under GNU GPL version 3 or later, due to libreadline license.
There is NO WARRANTY, to the extent permitted by law.
xorriso 1.5.4 : RockRidge filesystem manipulator, libburnia project.

# starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1253673.sock 
-qtest-log /dev/null -chardev socket,path=/tmp/qtest-1253673.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine none -accel qtest
# starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1253673.sock 
-qtest-log /dev/null -chardev socket,path=/tmp/qtest-1253673.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine none -accel qtest
# Start of i386 tests
# Start of cdrom tests
# Start of boot tests
# starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-1253673.sock 
-qtest-log /dev/null -chardev socket,path=/tmp/qtest-1253673.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg 
-no-shutdown -device am53c974 -device scsi-cd,drive=cd1 -drive 
if=none,id=cd1,format=raw,file=cdrom-boot-iso-gLvZnQ -accel qtest
ok 1 /i386/cdrom/boot/am53c974
# End of boot tests
# End of cdrom tests
# End of i386 tests
1..1


Could it be related to the newer xorriso version? And are you sure there isn't an 
older copy of SeaBIOS lying around somewhere that is getting picked up by accident?


ATB,

Mark.


