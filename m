Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB153D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vKK-0004SE-P4; Mon, 04 Nov 2024 06:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7vKF-0004Rs-By
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:32:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7vKC-0000GO-DD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:32:51 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8979C4E6004;
 Mon, 04 Nov 2024 12:32:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 68sI4BiDc3IG; Mon,  4 Nov 2024 12:32:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B0544E6000; Mon, 04 Nov 2024 12:32:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 377EB746F60;
 Mon, 04 Nov 2024 12:32:42 +0100 (CET)
Date: Mon, 4 Nov 2024 12:32:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PULL 00/14] MIPS patches for 2024-10-31
In-Reply-To: <e0679432-64ae-435a-9b1e-03c4c710c485@linaro.org>
Message-ID: <4a226a11-4db1-8220-07ac-dc25be4930cb@eik.bme.hu>
References: <20241031042130.98450-1-philmd@linaro.org>
 <CAFEAcA9iGx7haujfFsmiZLtVH0SCgcVFbt90BYB-dWQgHnkGZg@mail.gmail.com>
 <e0679432-64ae-435a-9b1e-03c4c710c485@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1865007110-1730719962=:41513"
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

--3866299591-1865007110-1730719962=:41513
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 4 Nov 2024, Philippe Mathieu-Daudé wrote:
> Hi,
>
> TL;DR: I will repost the PR will the typo fixed.
>
> On 1/11/24 13:44, Peter Maydell wrote:
>> On Thu, 31 Oct 2024 at 04:22, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>> 
>>> The following changes since commit 
>>> 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:
>>>
>>>    Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into 
>>> staging (2024-10-29 14:00:43 +0000)
>>> 
>>> are available in the Git repository at:
>>>
>>>    https://github.com/philmd/qemu.git tags/mips-20241031
>>> 
>>> for you to fetch changes up to dcc3c68c844fef7bc018ab53f0993b8d44137d77:
>>>
>>>    target/mips: Remove unused CPUMIPSState::current_fpu field (2024-10-31 
>>> 00:48:45 -0300)
>>> 
>>> ----------------------------------------------------------------
>>> MIPS patches queue
>>> 
>>> - Migrate missing CP0 TLB MemoryMapID register (Yongbok)
>>> - Enable MSA ASE for mips32r6-generic (Aleksandar)
>>> - Convert Loongson LEXT opcodes to decodetree (Phil)
>>> - Introduce ase_3d_available and disas_mt_available helpers (Phil)
>>> 
>>> ----------------------------------------------------------------
>> 
>> Hi; it looks like this breaks the foolong2e functional test:
>> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/8249048723
>> 
>> 12/15 qemu:func-thorough+func-mips64el-thorough+thorough /
>> func-mips64el-mips64el_fuloong2e ERROR 2.54s
>> 
>> Guest kernel panics rather than booting.
>
> Oops. At least we have a test. I suppose I missed it because the job
> isn't run by default and has been renamed due to the avocado ->
> functional conversion.
>
> The bug is a due to a typo:
>
> -- >8 --
> --- a/target/mips/tcg/loong_translate.c
> +++ b/target/mips/tcg/loong_translate.c
> @@ -68,7 +68,7 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, 
> int rt)
>
> static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
> {
> -    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd);
> +    return gen_lext_DIV_G(s, a->rd, a->rs, a->rt);
> }
> ---
>
> But then the test fail later:
>
> $ ninja qemu-system-mips64el && ./qemu-system-mips64el -kernel 
> boot/vmlinux-3.16.0-6-loongson-2e -machine fuloong2e -append 'console=ttyS0' 
> -serial mon:stdio -d int -trace pci\*
> ...
> [    0.000000] Kernel command line: console=ttyS0
> [    0.436000] PCI host bridge to bus 0000:00
> [    0.436000] pci_bus 0000:00: root bus resource [mem 0x14000000-0x1c000000]
> [    0.440000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
> [    0.440000] pci_bus 0000:00: No busn resource found for root bus, will use 
> [bus 00-ff]
> ...
> pci_cfg_read ati-vga 00:06.0 @0x0 -> 0x51591002
> pci_cfg_read ati-vga 00:06.0 @0xc -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x8 -> 0x3000000
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x3c -> 0x100
> pci_cfg_read ati-vga 00:06.0 @0x3c -> 0x100
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x10 -> 0x8
> pci_cfg_write ati-vga 00:06.0 @0x10 <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x10 -> 0xff000008
> pci_cfg_write ati-vga 00:06.0 @0x10 <- 0x8
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x14 -> 0x1
> pci_cfg_write ati-vga 00:06.0 @0x14 <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x14 -> 0xffffff01
> pci_cfg_write ati-vga 00:06.0 @0x14 <- 0x1
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x18 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x18 <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x18 -> 0xffffc000
> pci_cfg_write ati-vga 00:06.0 @0x18 <- 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x1c -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x1c <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x1c -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x1c <- 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x20 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x20 <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x20 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x20 <- 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x24 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x24 <- 0xffffffff
> pci_cfg_read ati-vga 00:06.0 @0x24 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x24 <- 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x30 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x30 <- 0xfffff800
> pci_cfg_read ati-vga 00:06.0 @0x30 -> 0xffff0000
> pci_cfg_write ati-vga 00:06.0 @0x30 <- 0x0
> pci_cfg_read ati-vga 00:06.0 @0x2c -> 0x11001af4
> pci_cfg_read ati-vga 00:06.0 @0x2c -> 0x11001af4
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> [    0.464000] vgaarb: device added: 
> PCI:0000:00:06.0,decodes=io+mem,owns=none,locks=none
> ...
> [    0.472000] pci 0000:00:06.0: BAR 0: assigned [mem 0x14000000-0x14ffffff 
> pref]
> pci_cfg_write ati-vga 00:06.0 @0x10 <- 0x14000008
> pci_cfg_read ati-vga 00:06.0 @0x10 -> 0x14000008
> [    0.472000] pci 0000:00:07.0: BAR 6: assigned [mem 0x15000000-0x1503ffff 
> pref]
> [    0.472000] pci 0000:00:06.0: BAR 6: assigned [mem 0x15040000-0x1504ffff 
> pref]
> [    0.472000] pci 0000:00:06.0: BAR 2: assigned [mem 0x15050000-0x15053fff]
> pci_cfg_write ati-vga 00:06.0 @0x18 <- 0x15050000
> pci_cfg_read ati-vga 00:06.0 @0x18 -> 0x15050000
> [    0.472000] pci 0000:00:05.5: BAR 0: assigned [io  0x4000-0x40ff]
> ...
> [    0.476000] pci 0000:00:06.0: BAR 1: assigned [io  0x4400-0x44ff]
> pci_cfg_write ati-vga 00:06.0 @0x14 <- 0x4401
> pci_cfg_read ati-vga 00:06.0 @0x14 -> 0x4401
> ...
> pci_cfg_read ati-vga 00:06.0 @0x3c -> 0x100
> pci_cfg_read ati-vga 00:06.0 @0x3c -> 0x100
> pci_cfg_write ati-vga 00:06.0 @0x3c <- 0x13a
> ...
> pci_cfg_read ati-vga 00:06.0 @0xc -> 0x0
> ...
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> [    0.864000] PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x0
> pci_cfg_write ati-vga 00:06.0 @0x4 <- 0x3
> pci_update_mappings_add ati-vga 00:06.0 0,0x14000000+0x1000000
> pci_update_mappings_add ati-vga 00:06.0 1,0x4400+0x100
> pci_update_mappings_add ati-vga 00:06.0 2,0x15050000+0x4000
> pci_cfg_read ati-vga 00:06.0 @0x3c -> 0x13a
> pci_cfg_read ati-vga 00:06.0 @0x4 -> 0x3
> do_raise_exception_err: 28 (data bus error) 0
> mips_cpu_do_interrupt enter: PC ffffffff8045aed8 EPC ffffffff8043ae88 data 
> bus error exception
> mips_cpu_do_interrupt: PC ffffffff80000180 EPC ffffffff8045aed8 cause 7
>    S 1400a4e3 C 0000001c A c000000000010000 D 0000000000000000
> [    0.868000] Data bus error, epc == ffffffff8045aed8, ra == 
> ffffffff8045aeb8
> [    0.868000] Oops[#1]:
> [    0.868000] CPU: 0 PID: 1 Comm: swapper Not tainted 3.16.0-6-loongson-2e 
> #1 Debian 3.16.56-1+deb8u1
> [    0.868000] task: 980000000e06f580 ti: 980000000e078000 task.ti: 
> 980000000e078000
> [    0.868000] $ 0   : 0000000000000000 ffffffff80428db0 9000000000000000 
> 0000000015050000
> [    0.868000] $ 4   : 9000000015050000 ffffffff80430000 0000000015053fff 
> 0000000000000070
> [    0.868000] $ 8   : 0000000000000000 ffffffff8079b190 0000000000000001 
> fffffffffffffff8
> [    0.868000] $12   : 0000000000000000 ffffffff803fd67c 0000000000000000 
> 0000000000000082
> [    0.868000] $16   : 980000000e278000 980000000e336000 980000000e336428 
> 0000000000000000
> [    0.868000] $20   : ffffffff8087f918 0000000000000000 ffffffff80929cf0 
> ffffffff80800000
> [    0.868000] $24   : 0000000000000018 0000000000000000 
> [    0.868000] $28   : 980000000e078000 980000000e07bbc0 0000000000000074 
> ffffffff8045aeb8
> [    0.868000] Hi    : 0000000000d2f000
> [    0.868000] Lo    : 0000000000fa7d00
> [    0.868000] epc   : ffffffff8045aed8 radeonfb_pci_register+0x1b0/0x1ad0
> [    0.868000]     Not tainted
> [    0.868000] ra    : ffffffff8045aeb8 radeonfb_pci_register+0x190/0x1ad0
> [    0.868000] Status: 1400a4e3	KX SX UX KERNEL EXL IE
> [    0.868000] Cause : 0000001c
> [    0.868000] PrId  : 00006302 (ICT Loongson-2)
> [    0.868000] Modules linked in:
> [    0.868000] Process swapper (pid: 1, threadinfo=980000000e078000, 
> task=980000000e06f580, tls=0000000000000000)
> [    0.868000] Stack : 980000000e336748 980000000e278090 000000001400a4e1 
> ffffffff8087f670
> 	  ffffffff8087f918 0000000000000000 980000000e278090 ffffffff8087f6d8
> 	  980000000e278000 ffffffff8087f670 ffffffff8087f918 0000000000000000
> 	  ffffffff80929cf0 ffffffff80800000 0000000000000074 ffffffff8042e718
> 	  980000000e278090 ffffffff809b0000 980000000e2780f0 ffffffff8087f6d8
> 	  ffffffff809b0000 ffffffff804a3dcc 980000000e355380 980000000e278090
> 	  ffffffff8087f6d8 980000000e2780f0 0000000000000000 ffffffff80810000
> 	  0000000000000000 ffffffff804a4238 0000000000000000 ffffffff8087f6d8
> 	  ffffffff804a4168 ffffffff804a1a04 980000000e1c6090 980000000e1cbde0
> 	  ffffffff8087f6d8 980000000e355380 ffffffff8087e8f0 ffffffff804a3218
> 	  ...
> [    0.868000] Call Trace:
> [    0.868000] [<ffffffff8045aed8>] radeonfb_pci_register+0x1b0/0x1ad0
> [    0.868000] [<ffffffff8042e718>] pci_device_probe+0xb8/0x130
> [    0.868000] [<ffffffff804a3dcc>] driver_probe_device+0xdc/0x400
> [    0.868000] [<ffffffff804a4238>] __driver_attach+0xd0/0xd8
> [    0.868000] [<ffffffff804a1a04>] bus_for_each_dev+0x7c/0xc8
> [    0.868000] [<ffffffff804a3218>] bus_add_driver+0x1a0/0x288
> [    0.868000] [<ffffffff804a4c10>] driver_register+0x90/0x138
> [    0.868000] [<ffffffff808e2444>] radeonfb_init+0x60/0x230
> [    0.868000] [<ffffffff801005c0>] do_one_initcall+0x110/0x220
> [    0.868000] [<ffffffff808b8e3c>] kernel_init_freeable+0x194/0x250
> [    0.868000] [<ffffffff80661f98>] kernel_init+0x20/0x118
> [    0.868000] [<ffffffff80103ed0>] ret_from_kernel_thread+0x14/0x1c
> [    0.868000]
> [    0.868000]
> Code: 0082202d  108005ae  fe440368 <8c850148> 924207d8  00052c00 0005283c 
> 0005283e  fe450378
> [    0.888000] ---[ end trace 2fdf3be6a36f9b46 ]---
> [    0.892000] Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b
> [    0.892000]
> [    0.892000] ---[ end Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b
> [    0.892000]
>
> I don't recall this failure. Zoltan, does it ring a bell?
> Anyway I'll open a gitlab issue to track it, and will repost the
> PR will the typo fixed.

Hello,

No, I haven't seen this before. There were no changes to ati-vga for a 
long time so it's unlikely it was broken by that recently. The ati-vga 
does have a 60Hz vblank interrupt added in b7105d280cab so maybe you could 
try disabling that for testing to see if this has anything to do with the 
above but if it broke recently maybe it's more related to some MIPS change 
than ati-vga.

Regards,
BALATON Zoltan
--3866299591-1865007110-1730719962=:41513--

