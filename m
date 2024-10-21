Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A6D3C927
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2hYH-00021Y-Ly; Sun, 20 Oct 2024 21:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t2hYF-00021I-KR
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:49:43 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1t2hYD-00089X-BX
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 21:49:43 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso2684564a12.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729475380; x=1730080180; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=op8TfLoiYFxU/F+ntY+tsPUX1WAROi3xaVa62F62vxw=;
 b=PzU6OGXWQW/psVw2m5JepZ4nJNedbRh2Zm1OIQqHG+ELc6EhYevv0LooZpDWMO19MQ
 HgBhEkBgUDDslPpG99vz+FzgRJgh+SjM9ETD8yftor1uUWr8D85ezY7rcdja/3v5VrWN
 k2M68i9K+CL1TC+ODPLNkB+fty8pX3F4+bazQNUdfq1Q0wFaS7HcSW7Rzs3XiFUz/+h5
 GJqOCydQBVXAIkSxDY42TrskWnXF1p+747GgpwrH0krI3zZSbBsZS32vWDAyIdC87+gB
 UM4sjlaolQE5Q7r5dneb4JjzO9qEPHacF53b3vitex4Eqa6Z/mPuBxwUoFb/nw8KhsHI
 Ynjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729475380; x=1730080180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=op8TfLoiYFxU/F+ntY+tsPUX1WAROi3xaVa62F62vxw=;
 b=M+ytKg6p21F9aY/Zfuh7KZvBeUP9QDmeYmQ/H3r/9Zb6nhKJ5WpEtJPubr2DyB7Ffs
 OVaThUkd2kJk61sL8G55KaZCIHBEFcChkB3OQ9Rm2vQ1Wr01S5/Ve2nVOwYPw4JFVoOZ
 j8L4L+LqwTIbyWodrd+sk6I4LGgoq6QT1dVi9DHAGeBfqyorWO4X9BPfLxT3g50YdCx1
 uEg+uvlKafFXrRGuVPCQdU8lwoXVrAbg2sxayrmsQJ+CcAK2+TyqtlPTK2fIwvNeeDBs
 E+cwFwHa/IUX08+y/qZr/R9Y70+kZHXLmwvPN213bcnQpLwMAO92qm7/RF6f43dW5003
 axVg==
X-Gm-Message-State: AOJu0YyxUz12quZjbzKcuv1yGOxODWwBkzWPYrNUozfGCCr/+qIyXp0d
 zHJugk5gDCmITS4I4UEOUjQhjrFcxK9QhPphl0HmbQVJ1UCqVFhEWT//sQ==
X-Google-Smtp-Source: AGHT+IGsO6tnRH48n81rIaTuJBF4o4qysBqPJ2rNNk6Nb9OFeptmci6fUsKHN7n6OGL4p5IABAGHog==
X-Received: by 2002:a05:6a21:78d:b0:1d9:9b2:8c2a with SMTP id
 adf61e73a8af0-1d92c56dd3dmr13207321637.34.1729475379459; 
 Sun, 20 Oct 2024 18:49:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad367848sm2270031a91.23.2024.10.20.18.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 18:49:38 -0700 (PDT)
Date: Sun, 20 Oct 2024 18:49:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/25] target/i386: finish converting 0F AE to the new
 decoder
Message-ID: <8076e922-1839-4e8e-9dbf-35c064a439fc@roeck-us.net>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608084113.2770363-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Sat, Jun 08, 2024 at 10:40:58AM +0200, Paolo Bonzini wrote:
> This is already partly implemented due to VLDMXCSR and VSTMXCSR; finish
> the job.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

While testing qemu v9.1, I noticed the following crash when testing qemu-system-i386
with pentium3 CPU.

Oops: invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
EIP: raid6_sse12_gen_syndrome+0xfa/0x10c
Code: 83 e8 01 73 bf 8b 4d ec 0f e7 53 f8 0f e7 1b 0f e7 61 f8 0f e7 31 8b 45 e8 83 c6 10 83 c3 10 83 c1 10 39 c6 0f 82 6a ff ff ff <0f> 9
EAX: 00001000 EBX: c1367008 ECX: c1368008 EDX: c119deb0
ESI: 00001000 EDI: 00000ff8 EBP: c119de84 ESP: c119de68
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
CR0: 80050033 CR2: ffd39000 CR3: 06144000 CR4: 000006d0
Call Trace:
 ? show_regs+0x4d/0x54
 ? die+0x2f/0x88
 ? do_trap+0xc6/0xc8
 ? do_error_trap+0x6c/0x100
 ? raid6_sse12_gen_syndrome+0xfa/0x10c
 ? exc_overflow+0x50/0x50
 ? exc_invalid_op+0x5b/0x70
 ? raid6_sse12_gen_syndrome+0xfa/0x10c
 ? handle_exception+0x14b/0x14b
 ? exc_overflow+0x50/0x50
 ? raid6_sse12_gen_syndrome+0xfa/0x10c
 ? exc_overflow+0x50/0x50
 ? raid6_sse12_gen_syndrome+0xfa/0x10c
 ? raid6_sse11_gen_syndrome+0xfc/0xfc
 raid6_select_algo+0x144/0x420
 ? libcrc32c_mod_init+0x24/0x24
 do_one_initcall+0x63/0x284
 ? rdinit_setup+0x40/0x40
 ? parse_args+0x14b/0x3f4
 kernel_init_freeable+0x238/0x44c
 ? rdinit_setup+0x40/0x40
 ? rest_init+0x164/0x164
 kernel_init+0x15/0x1dc
 ? schedule_tail+0x50/0x64
 ret_from_fork+0x38/0x44
 ? rest_init+0x164/0x164
 ret_from_fork_asm+0x12/0x18
 entry_INT80_32+0x108/0x108
Modules linked in:
---[ end trace 0000000000000000 ]---

Bisect points to this patch. Bisect log as well as the decoded stacktrace
is attached below.

The problem is still seen in qemu mainline (v9.1.0-997-g72b0b80714).

Reverting the patch is not straightforward and results in a number of conflicts,
so I was not able to test qemu with the patch reverted.

Guenter

---
Bisect log:

# bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
# good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
git bisect start 'v9.1.0' 'v9.0.0'
# bad: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
git bisect bad 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
# good: [544595e73007c824b7435b52519cc578586783a6] tests/plugin/inline: add test for conditional callback
git bisect good 544595e73007c824b7435b52519cc578586783a6
# good: [039003995047b2f7911142c7c5cfb845fda044fd] hw/riscv/boot.c: Support 64-bit address for initrd
git bisect good 039003995047b2f7911142c7c5cfb845fda044fd
# good: [a73f7a00eea15c75fe9cfbeeaff5228f5ee24b61] tests/qtest: Add numa test for loongarch system
git bisect good a73f7a00eea15c75fe9cfbeeaff5228f5ee24b61
# bad: [11ffaf8c73aae1a70f4640ada14a437a78d06efb] target/i386: convert LZCNT/TZCNT/BSF/BSR/POPCNT to new decoder
git bisect bad 11ffaf8c73aae1a70f4640ada14a437a78d06efb
# good: [fc00123f3abeb027cd51eb58ea8845377794b3bc] python: mkvenv: remove ensure command
git bisect good fc00123f3abeb027cd51eb58ea8845377794b3bc
# good: [593aab332f048347bd19893071caf44e1fb742ff] Merge tag 'pull-hex-20240608' of https://github.com/quic/qemu into staging
git bisect good 593aab332f048347bd19893071caf44e1fb742ff
# good: [c2b6b6a65a227d2bb45e1b2694cf064b881543e4] target/i386: change X86_ENTRYr to use T0
git bisect good c2b6b6a65a227d2bb45e1b2694cf064b881543e4
# good: [10340080cd501b1aba23c3e502e2e0aa7c825fbf] target/i386: fix bad sorting of entries in the 0F table
git bisect good 10340080cd501b1aba23c3e502e2e0aa7c825fbf
# bad: [ae541c0eb47f2fbcfd975c8e2fcb0e3a2613dc1c] target/i386: convert non-grouped, helper-based 2-byte opcodes
git bisect bad ae541c0eb47f2fbcfd975c8e2fcb0e3a2613dc1c
# bad: [556c4c5cc44c3454f78d796b6050c6d574a35dd2] target/i386: split X86_CHECK_prot into PE and VM86 checks
git bisect bad 556c4c5cc44c3454f78d796b6050c6d574a35dd2
# bad: [ea89aa895e98fd8a1b9ebf7e3dc8bfcd863b9466] target/i386: finish converting 0F AE to the new decoder
git bisect bad ea89aa895e98fd8a1b9ebf7e3dc8bfcd863b9466
# first bad commit: [ea89aa895e98fd8a1b9ebf7e3dc8bfcd863b9466] target/i386: finish converting 0F AE to the new decoder

---
Decoded stacktrace:

CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
EIP: raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
Code: 83 e8 01 73 bf 8b 4d ec 0f e7 53 f8 0f e7 1b 0f e7 61 f8 0f e7 31 8b 45 e8 83 c6 10 83 c3 10 83 c1 10 39 c6 0f 82 6a ff ff ff <0f> 9
All code
========
   0:	83 e8 01             	sub    $0x1,%eax
   3:	73 bf                	jae    0xffffffffffffffc4
   5:	8b 4d ec             	mov    -0x14(%rbp),%ecx
   8:	0f e7 53 f8          	movntq %mm2,-0x8(%rbx)
   c:	0f e7 1b             	movntq %mm3,(%rbx)
   f:	0f e7 61 f8          	movntq %mm4,-0x8(%rcx)
  13:	0f e7 31             	movntq %mm6,(%rcx)
  16:	8b 45 e8             	mov    -0x18(%rbp),%eax
  19:	83 c6 10             	add    $0x10,%esi
  1c:	83 c3 10             	add    $0x10,%ebx
  1f:	83 c1 10             	add    $0x10,%ecx
  22:	39 c6                	cmp    %eax,%esi
  24:	0f 82 6a ff ff ff    	jb     0xffffffffffffff94
  2a:*	0f 09                	wbinvd 		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	0f 09                	wbinvd
EAX: 00001000 EBX: c1367008 ECX: c1368008 EDX: c119deb0
ESI: 00001000 EDI: 00000ff8 EBP: c119de84 ESP: c119de68
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
CR0: 80050033 CR2: ffd39000 CR3: 06144000 CR4: 000006d0
Call Trace:
? show_regs (arch/x86/kernel/dumpstack.c:479)
? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
? do_trap (arch/x86/kernel/traps.c:156 arch/x86/kernel/traps.c:197)
? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:218)
? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
? exc_overflow (arch/x86/kernel/traps.c:301)
? exc_invalid_op (arch/x86/kernel/traps.c:316)
? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
? handle_exception (arch/x86/entry/entry_32.S:1055)
? exc_overflow (arch/x86/kernel/traps.c:301)
? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
? exc_overflow (arch/x86/kernel/traps.c:301)
? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
? raid6_sse11_gen_syndrome (lib/raid6/sse1.c:100)
raid6_select_algo (lib/raid6/algos.c:179 (discriminator 2) lib/raid6/algos.c:273 (discriminator 2))
? libcrc32c_mod_init (lib/raid6/algos.c:243)
do_one_initcall (init/main.c:1269)
? rdinit_setup (init/main.c:1317)
? parse_args (kernel/params.c:153 kernel/params.c:186)
kernel_init_freeable (init/main.c:1330 (discriminator 1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator 1) init/main.c:1580 (discrim
? rdinit_setup (init/main.c:1317)
? rest_init (init/main.c:1461)
kernel_init (init/main.c:1471)
? schedule_tail (kernel/sched/core.c:5266)
ret_from_fork (arch/x86/kernel/process.c:153)
? rest_init (init/main.c:1461)
ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
entry_INT80_32 (arch/x86/entry/entry_32.S:945)

