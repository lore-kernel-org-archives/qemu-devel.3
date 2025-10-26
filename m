Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B55CCD1A5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 13:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vD0eL-0006H7-DH; Sun, 26 Oct 2025 09:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vD0eI-0006GO-WF
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 09:19:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vD0eC-0003Ue-A8
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 09:19:05 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b63e5da0fdeso325840a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 Oct 2025 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761484738; x=1762089538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DC0pMwkmIg0Vk/iZYerMDWH0JGX6W6XKzJLcDNgUpSg=;
 b=mdyu3novTeLPWZ7f49kcerN7bMsZ/bs3cPDZY3xwpXmNY68Fd+SXYx71X9JyQv0ajy
 oSdSt0+86tUVAmXzkv8yVdh3MDuyFJaq1ZalLQKbXCDEc45zAc6o06pCIIoJJPPBD+aL
 iTuS/udz98ldzCNcWjbvXvSt6Flv5YfIr0pjRzBd3NgL49ay9nTdosA/bchspvuWstRB
 jLo1lv2Jy3PNH1q+VwlRkcW5pmUYLQAU795hPxhS4qGNlMhy4gU26AaM6FW3ugzNopvl
 wZFxJotbjZSqM+wke7ccz1J/WHT03kA3yBL++JrOECYg2jyfAX82rjuVLpNdQMN8dY8B
 KQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761484738; x=1762089538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DC0pMwkmIg0Vk/iZYerMDWH0JGX6W6XKzJLcDNgUpSg=;
 b=RCvm3QkElk1Tj3j/pwr6hatwjWbpDjDcNbFyG/k2c31j2CloRTvXYC5NtZKnfR82eH
 KhyL3uDxF11qFFmwm2JsjM67nopYNLmKRLQMZo50xh0LgBmOUwfdUZZlATwT9IJ1nSnz
 0SeKdXYwz7qIs8MCvnEDSmdbJVBQVS+VnF5fdz6Qll7ejFb/n1iRkdJT1mAV/9F8y5St
 I/DGLOSoHqJUM8tE/p0JwRF9NLis9sdWRphq6eoMlbRWmkTo1VWzcS9PHIG+ezNGK6vo
 iNBbxHvciZTYfCFuTRqwhFpCRAprbhzQOTc7y/DOY7H9Lv3l1EIQ6eETjkP8U9gIkAnQ
 5pDA==
X-Gm-Message-State: AOJu0Yyp9jRgdj2nfzHB+StWtzEwTqQlD6bCDLtopWHz4hMp6SQ75TYW
 Xgb2TNY0C9hRB9R80Q/X6dOVKgiryOecDEQAKj1D1b3IY04MQh02xOJc
X-Gm-Gg: ASbGncsc3BpeCLXkA3noFoWcU96AaNa+EB5+q+AZfqwblYVtcJjbH2g7InADd+MLmf+
 mILAt9JkuQZumEKqLhX4eYVDJ0Smu+QqEFYlykZgUdGyYVyt4ZIQtzMa4TV1RaaenIOk5vblcU8
 7jPrH4dLv53n/btcxwJPNq5DXSnIE5zB30PdxYEXuWv9NflCMks6C0AEyvQ55rTOEGSYcvWmlSa
 FzgscaJMRUDP1ZoYiyn2AnYW0j5WayRN4u9l9gA3IoXxicCjH2juhnKFUelGF2YGGtYDWWx2DIR
 yv28FsOs8v08FvNgoppX68h1Bhrscyj8E/I+nKOwdms1+9EhUfDeekTJ/CmEKiy8iBLFnAum/dm
 m4rrHFw4zF4y6P9A5K7qjrTFFNMtrCyuA7pQEOJapu1MtHC6iBxJDhMOzJ4dYrHWgzEdxh1Y3Nt
 Frnn/xgEMSAph57K42mOTCztW1sohuXtmw+VMXjXuQ6bM4SIeYZDQDfe9gZeO4j2OE2QYS8Fp7
X-Google-Smtp-Source: AGHT+IG/j70cc6xDtSPQoON/IP+qZ67TCQVavMUt3EB8BsHvqrJg9+7cdL4kdmPGdVOOv1pf1+3LDw==
X-Received: by 2002:a05:6a00:244d:b0:7a2:864b:9c8e with SMTP id
 d2e1a72fcca58-7a2864b9cf8mr5707052b3a.3.1761484738366; 
 Sun, 26 Oct 2025 06:18:58 -0700 (PDT)
Received: from ?IPV6:2409:40f2:116b:b390:f34d:aca1:36fe:8380?
 ([2409:40f2:116b:b390:f34d:aca1:36fe:8380])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012a1dsm4947971b3a.10.2025.10.26.06.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Oct 2025 06:18:57 -0700 (PDT)
Message-ID: <26f74e6c-a89f-4be0-aa6c-78ad88e2cba3@gmail.com>
Date: Sun, 26 Oct 2025 18:48:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
 <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
 <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
Content-Language: en-US
From: Yogesh Vyas <yvyas1991@gmail.com>
In-Reply-To: <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=yvyas1991@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 10/26/25 4:39 PM, BALATON Zoltan wrote:
> On Sun, 26 Oct 2025, Yogesh Vyas wrote:
>> On Sun, Oct 19, 2025 at 5:37 PM BALATON Zoltan <balaton@eik.bme.hu> 
>> wrote:
>>> On Sun, 19 Oct 2025, Yogesh Vyas wrote:
>>>> When I run QEMU with the ROM option, the machine boots successfully 
>>>> with
>>>> the below command:
>>>>
>>>> qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
>>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso \
>>>>                  -device VGA,romfile="" -serial stdio
>>>>
>>>> However, when I try to boot the machine without the ROM using VOF, the
>>>> machine does not come up and no logs appear on stdout:
>>>>
>>>> qemu-system-ppc64 -machine pegasos2 -serial stdio \
>>>>                  -kernel vmlinuz-chrp.initrd -append "---" \
>>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso
>>>>
>>>> Please let me know if I am missing any parameters or setup required 
>>>> for
>>>> booting via VOF on Pegasos2.
>>>>
>>>> Documentation referred: qemu/docs/system/ppc/amigang.rst
>>>
>>> Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 
>>> 32 bit
>>> machine so you need /install/powerpc/vmlinuz-chrp.initrd for it (see in
>>> the /install/pegasos script that is used with firmware). Even if you 
>>> call
>>> it from qemu-system-ppc64 which includes both 32 bit and 64 bit 
>>> machines
>>> but does not make 32 bit machines 64 bit so you still need the 32 
>>> bit OS.
>>>
>>>
>> Hi Balaton,
>> I am using 32bit images only and looks like VOF boot works with the 
>> distro
>> provided Qemu (both ppc and pp64), however doesn't work with upstream 
>> Qemu
>> for VOF.
>
> That's odd, it works for me with QEMU master so I can't reproduce this.
>
>> yogi@fedora:~/work/images$ file vmlinuz-chrp.initrd
>> vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or cisco 4500,
>> version 1 (SYSV), statically linked, not stripped
>
> The file command says 32-bit for both 
> /install/powerpc/vmlinuz-chrp.initrd and 
> /install/powerpc64/vmlinuz-chrp.initrd but only the first one should 
> work. Can you double check you have the right vmlinuz-chrp.initrd 
> file? But if you say the same file works with 9.2.4 I have no idea 
> why. I see these files on the CD
>
>   9301172 Jun 19  2018 /install/powerpc/vmlinuz-chrp.initrd
>  10534888 Jun 19  2018 /install/powerpc64/vmlinuz-chrp.initrd


I am also using the same file:

yogi@fedora:~/work/images$ ls -lrt vmlinuz-chrp.initrd
-r--r--r--. 1 yogi yogi 9301172 Oct 18 23:50 vmlinuz-chrp.initrd

>
> File command says:
>
> vmlinuz-chrp.initrd:   ELF 32-bit MSB executable, PowerPC or cisco 
> 4500, version 1 (SYSV), statically linked, not stripped
> vmlinuz-chrp.initrd64: ELF 32-bit MSB executable, PowerPC or cisco 
> 4500, version 1 (SYSV), statically linked, not stripped
>
> but only the first from the powerpc directory is supposed to work and 
> it does boot for me with QEMU master. You can also check following the 
> other way described in qemu/docs/system/ppc/amigang.rst using -bios 
> pegasos2.rom which loads the correct image from the CD. Does that work?

Yes, I had mentioned it in my first mail that ROM option works as 
expected. It is only an issue when using VOF with upstream Qemu.

Could you please share your Qemu command line if it's different from the 
one mentioned in the documentation.

Regards,

Yogesh Vyas

>
> Regards,
> BALATON Zoltan

