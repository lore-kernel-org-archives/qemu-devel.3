Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D9E9A779
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50cn-0000v6-QZ; Tue, 24 Mar 2026 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w50cj-0000up-S4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w50cg-0005Xd-RY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774354356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aX3NhCPw94KulqSpmqGAmSB9e67MnLbv6jqeNr65QXE=;
 b=eP1gs0RqM7/zn87T/SCkh5hkEhRAsjhd5S5a84JjEoMYqOP2EMkLP8WZi6/V4Msn9api8c
 l6UAUXdHBJFA31kF/YApyBH9chzrm+H6L64jT2KBtOYgyufYUe/SwbtBBRnEaOoeSv+ueY
 PdDbTcijKNvlin20GoQem8UzHf84dz4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-GRWW85SGMKGp7VsfSlBGtA-1; Tue,
 24 Mar 2026 08:12:33 -0400
X-MC-Unique: GRWW85SGMKGp7VsfSlBGtA-1
X-Mimecast-MFC-AGG-ID: GRWW85SGMKGp7VsfSlBGtA_1774354352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6363819560AF; Tue, 24 Mar 2026 12:12:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF59D300019F; Tue, 24 Mar 2026 12:12:29 +0000 (UTC)
Date: Tue, 24 Mar 2026 12:12:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 16/41] hw/i386: Remove linuxboot.bin
Message-ID: <acJ_qqzYMKqvrShH@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212144244.22579-17-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=1.981, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 12, 2026 at 03:42:18PM +0100, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> All machines now use the linuxboot_dma.bin binary, so it's safe to
> remove the non-DMA version (linuxboot.bin).
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Link: https://lore.kernel.org/r/20260108033051.777361-16-zhao1.liu@intel.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc.c                  |   3 +-
>  pc-bios/meson.build           |   1 -
>  pc-bios/optionrom/Makefile    |   2 +-
>  pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
>  4 files changed, 2 insertions(+), 199 deletions(-)
>  delete mode 100644 pc-bios/optionrom/linuxboot.S

The pre-built  pc-bios/linuxboot_dma.bin  still exists in the tree,
shouldn't that have been deleted too ?

> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b033fc67cf9..c0e6a23bec1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -669,8 +669,7 @@ void xen_load_linux(PCMachineState *pcms)
>  
>      x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
>      for (i = 0; i < nb_option_roms; i++) {
> -        assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
> -               !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> +        assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
>                 !strcmp(option_rom[i].name, "pvh.bin") ||
>                 !strcmp(option_rom[i].name, "multiboot_dma.bin"));
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index efe45c16705..2f470ed1294 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -63,7 +63,6 @@ blobs = [
>    'efi-vmxnet3.rom',
>    'qemu-nsis.bmp',
>    'multiboot_dma.bin',
> -  'linuxboot.bin',
>    'linuxboot_dma.bin',
>    'kvmvapic.bin',
>    'pvh.bin',
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 963a77a3298..f1c1b9efc21 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -2,7 +2,7 @@ include config.mak
>  SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
>  VPATH = $(SRC_DIR)
>  
> -all: multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
> +all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
>  # Dummy command so that make thinks it has done something
>  	@true
>  
> diff --git a/pc-bios/optionrom/linuxboot.S b/pc-bios/optionrom/linuxboot.S
> deleted file mode 100644
> index ba821ab922d..00000000000
> --- a/pc-bios/optionrom/linuxboot.S
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -/*
> - * Linux Boot Option ROM
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - * Copyright Novell Inc, 2009
> - *   Authors: Alexander Graf <agraf@suse.de>
> - *
> - * Based on code in hw/pc.c.
> - */
> -
> -#include "optionrom.h"
> -
> -#define BOOT_ROM_PRODUCT "Linux loader"
> -
> -BOOT_ROM_START
> -
> -run_linuxboot:
> -
> -	cli
> -	cld
> -
> -	jmp		copy_kernel
> -boot_kernel:
> -
> -	read_fw		FW_CFG_SETUP_ADDR
> -
> -	mov		%eax, %ebx
> -	shr		$4, %ebx
> -
> -	/* All segments contain real_addr */
> -	mov		%bx, %ds
> -	mov		%bx, %es
> -	mov		%bx, %fs
> -	mov		%bx, %gs
> -	mov		%bx, %ss
> -
> -	/* CX = CS we want to jump to */
> -	add		$0x20, %bx
> -	mov		%bx, %cx
> -
> -	/* SP = cmdline_addr-real_addr-16 */
> -	read_fw		FW_CFG_CMDLINE_ADDR
> -	mov		%eax, %ebx
> -	read_fw		FW_CFG_SETUP_ADDR
> -	sub		%eax, %ebx
> -	sub		$16, %ebx
> -	mov		%ebx, %esp
> -
> -	/* Build indirect lret descriptor */
> -	pushw		%cx		/* CS */
> -	xor		%ax, %ax
> -	pushw		%ax		/* IP = 0 */
> -
> -	/* Clear registers */
> -	xor		%eax, %eax
> -	xor		%ebx, %ebx
> -	xor		%ecx, %ecx
> -	xor		%edx, %edx
> -	xor		%edi, %edi
> -	xor		%ebp, %ebp
> -
> -	/* Jump to Linux */
> -	lret
> -
> -
> -copy_kernel:
> -	/* Read info block in low memory (0x10000 or 0x90000) */
> -	read_fw		FW_CFG_SETUP_ADDR
> -	shr		$4, %eax
> -	mov		%eax, %es
> -	xor		%edi, %edi
> -	read_fw_blob_addr32_edi(FW_CFG_SETUP)
> -
> -	cmpw            $0x203, %es:0x206      // if protocol >= 0x203
> -	jae             1f                     // have initrd_max
> -	movl            $0x37ffffff, %es:0x22c // else assume 0x37ffffff
> -1:
> -
> -	/* Check if using kernel-specified initrd address */
> -	read_fw		FW_CFG_INITRD_ADDR
> -	mov		%eax, %edi             // (load_kernel wants it in %edi)
> -	read_fw		FW_CFG_INITRD_SIZE     // find end of initrd
> -	add		%edi, %eax
> -	xor		%es:0x22c, %eax        // if it matches es:0x22c
> -	and		$-4096, %eax           // (apart from padding for page)
> -	jz		load_kernel            // then initrd is not at top
> -					       // of memory
> -
> -	/* pc.c placed the initrd at end of memory.  Compute a better
> -	 * initrd address based on e801 data.
> -	 */
> -	mov		$0xe801, %ax
> -	xor		%cx, %cx
> -	xor		%dx, %dx
> -	int		$0x15
> -
> -	/* Output could be in AX/BX or CX/DX */
> -	or		%cx, %cx
> -	jnz		1f
> -	or		%dx, %dx
> -	jnz		1f
> -	mov		%ax, %cx
> -	mov		%bx, %dx
> -1:
> -
> -	or		%dx, %dx
> -	jnz		2f
> -	addw		$1024, %cx            /* add 1 MB */
> -	movzwl		%cx, %edi
> -	shll		$10, %edi             /* convert to bytes */
> -	jmp		3f
> -
> -2:
> -	addw		$16777216 >> 16, %dx  /* add 16 MB */
> -	movzwl		%dx, %edi
> -	shll		$16, %edi             /* convert to bytes */
> -
> -3:
> -	read_fw         FW_CFG_INITRD_SIZE
> -	subl            %eax, %edi
> -	andl            $-4096, %edi          /* EDI = start of initrd */
> -	movl		%edi, %es:0x218       /* put it in the header */
> -
> -load_kernel:
> -	/* We need to load the kernel into memory we can't access in 16 bit
> -	   mode, so let's get into 32 bit mode, write the kernel and jump
> -	   back again. */
> -
> -	/* Reserve space on the stack for our GDT descriptor. */
> -	mov             %esp, %ebp
> -	sub             $16, %esp
> -
> -	/* Now create the GDT descriptor */
> -	movw		$((3 * 8) - 1), -16(%bp)
> -	mov		%cs, %eax
> -	movzwl		%ax, %eax
> -	shl		$4, %eax
> -	addl		$gdt, %eax
> -	movl		%eax, -14(%bp)
> -
> -	/* And load the GDT */
> -	data32 lgdt	-16(%bp)
> -	mov		%ebp, %esp
> -
> -	/* Get us to protected mode now */
> -	mov		$1, %eax
> -	mov		%eax, %cr0
> -
> -	/* So we can set ES to a 32-bit segment */
> -	mov		$0x10, %eax
> -	mov		%eax, %es
> -
> -	/* We're now running in 16-bit CS, but 32-bit ES! */
> -
> -	/* Load kernel and initrd */
> -	read_fw_blob_addr32_edi(FW_CFG_INITRD)
> -	read_fw_blob_addr32(FW_CFG_KERNEL)
> -	read_fw_blob_addr32(FW_CFG_CMDLINE)
> -
> -	/* And now jump into Linux! */
> -	mov		$0, %eax
> -	mov		%eax, %cr0
> -
> -	/* ES = CS */
> -	mov		%cs, %ax
> -	mov		%ax, %es
> -
> -	jmp		boot_kernel
> -
> -/* Variables */
> -
> -.align 4, 0
> -gdt:
> -	/* 0x00 */
> -.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> -
> -	/* 0x08: code segment (base=0, limit=0xfffff, type=32bit code exec/read, DPL=0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
> -
> -	/* 0x10: data segment (base=0, limit=0xfffff, type=32bit data read/write, DPL=0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
> -
> -BOOT_ROM_END
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


