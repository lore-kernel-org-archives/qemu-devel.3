Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E1BCCD193
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 11:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCydQ-0002mK-Jz; Sun, 26 Oct 2025 07:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCydO-0002ly-KN; Sun, 26 Oct 2025 07:10:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCydM-0002Vu-EC; Sun, 26 Oct 2025 07:10:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8FAE15972FE;
 Sun, 26 Oct 2025 12:09:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id bAYSc6P4nRAk; Sun, 26 Oct 2025 12:09:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6B9275972FB; Sun, 26 Oct 2025 12:09:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65F505972F3;
 Sun, 26 Oct 2025 12:09:55 +0100 (CET)
Date: Sun, 26 Oct 2025 12:09:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yogesh Vyas <yvyas1991@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
In-Reply-To: <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
Message-ID: <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
 <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-5853053-1761476995=:17833"
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

--3866299591-5853053-1761476995=:17833
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 26 Oct 2025, Yogesh Vyas wrote:
> On Sun, Oct 19, 2025 at 5:37 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Sun, 19 Oct 2025, Yogesh Vyas wrote:
>>> When I run QEMU with the ROM option, the machine boots successfully with
>>> the below command:
>>>
>>> qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso \
>>>                  -device VGA,romfile="" -serial stdio
>>>
>>> However, when I try to boot the machine without the ROM using VOF, the
>>> machine does not come up and no logs appear on stdout:
>>>
>>> qemu-system-ppc64 -machine pegasos2 -serial stdio \
>>>                  -kernel vmlinuz-chrp.initrd -append "---" \
>>>                  -cdrom debian-8.11.0-powerpc-netinst.iso
>>>
>>> Please let me know if I am missing any parameters or setup required for
>>> booting via VOF on Pegasos2.
>>>
>>> Documentation referred: qemu/docs/system/ppc/amigang.rst
>>
>> Maybe you did not use the right vmlinuz-chrp.initrd. Pegasos2 is a 32 bit
>> machine so you need /install/powerpc/vmlinuz-chrp.initrd for it (see in
>> the /install/pegasos script that is used with firmware). Even if you call
>> it from qemu-system-ppc64 which includes both 32 bit and 64 bit machines
>> but does not make 32 bit machines 64 bit so you still need the 32 bit OS.
>>
>>
> Hi Balaton,
> I am using 32bit images only and looks like VOF boot works with the distro
> provided Qemu (both ppc and pp64), however doesn't work with upstream Qemu
> for VOF.

That's odd, it works for me with QEMU master so I can't reproduce this.

> yogi@fedora:~/work/images$ file vmlinuz-chrp.initrd
> vmlinuz-chrp.initrd: ELF 32-bit MSB executable, PowerPC or cisco 4500,
> version 1 (SYSV), statically linked, not stripped

The file command says 32-bit for both /install/powerpc/vmlinuz-chrp.initrd 
and /install/powerpc64/vmlinuz-chrp.initrd but only the first one should 
work. Can you double check you have the right vmlinuz-chrp.initrd file? 
But if you say the same file works with 9.2.4 I have no idea why. I see 
these files on the CD

   9301172 Jun 19  2018 /install/powerpc/vmlinuz-chrp.initrd
  10534888 Jun 19  2018 /install/powerpc64/vmlinuz-chrp.initrd

File command says:

vmlinuz-chrp.initrd:   ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, not stripped
vmlinuz-chrp.initrd64: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, not stripped

but only the first from the powerpc directory is supposed to work and it 
does boot for me with QEMU master. You can also check following the other 
way described in qemu/docs/system/ppc/amigang.rst using -bios pegasos2.rom 
which loads the correct image from the CD. Does that work?

Regards,
BALATON Zoltan
--3866299591-5853053-1761476995=:17833--

