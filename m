Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26ABC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOWv-0001Hr-7M; Tue, 06 Feb 2024 11:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jens.nyberg@gmail.com>)
 id 1rXOWt-0001Hi-Pg
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:42:39 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jens.nyberg@gmail.com>)
 id 1rXOWn-0005CK-HQ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:42:39 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so1530685a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707237752; x=1707842552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XqidL7m3D8mubLhTsh0nHWN4uvniWPU5Rk9Pcy+EdoA=;
 b=HbIcZVvVNdcnC61hG5zBJKIjFO91nj68bvkxvkCla6YRFbf6ULE2Mg+opaHCRI9hM0
 lmp8knK+J19+o+pHQc7EHuzrNmhRYxyK7dz1MWucl4aSvxz32R8a3+xJjeudHF7QrVBY
 2q/hJz5qM6rtD3DxgXMcuwUc5FIuxJWAYjGxLEnfda4X8PlIvHR/QmmjscqP2mQlUrfq
 8qYeeNH/8pn8LkDUD4H4jDlRgrxEAiah4fKnpCjpYlW+0owRhYEtHeh0LAGniCSJ6D95
 ab2Cu0kOcNestKKA+mk0C3OH6H16eIzQnHGwzDGI6Bmo61PLW88aC9Qu2y41aC9lM2Hp
 t+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237752; x=1707842552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqidL7m3D8mubLhTsh0nHWN4uvniWPU5Rk9Pcy+EdoA=;
 b=ZSlKH9B44DAVoL/LZl83jvkVH1+hpHw+iQeldnUssPQh/83GosL8QJ/rPuJ3oJ2eOZ
 RDtG7jM5LtykItjGvAm4CA22z+l5xrAQUcdoqr9e51437z50r83W6QpIEEq7fFlFTB7E
 m0IYdn5rxQXl7bmccSe4kiMKMvfZfZjFQZILxMnOnhQRM7j3EaN5rYm8ctAjLyYC3OH4
 papoeLpJPaTie/VMtsUregeIeMoQUR/m1sCaxyHxxWsaYGZAFWrXpfaHzRNwxIArymod
 ekHaBKJdZCHL7Lpd4PnP/jUORWVFynXeFZ/AOpGQRMD4t5/WuITf0IOuRK2e2s77OBAw
 xFJg==
X-Gm-Message-State: AOJu0YzsWMcigCXOgzex818acTesylJJeaEag8RagBv+ShCez+ttGtgt
 S4BjOFUo36FRsymFVahkAgh8mJAEMGEn050NI5CPqgg+J3aiFW8PynXPmppWo18r6oJ9+dUfJGF
 fXg1pYzsfl11T2M/H3Hrsiv4PALjUywYP4T2QbA==
X-Google-Smtp-Source: AGHT+IGDOPKSGIXmT3vj/ONCI53j3R5GZRQAfEN2i6qTfAfI62gxAszmSLFWd0Ifw6r0oXMa0FpcsTLJ4e2Mm5VNZZ4=
X-Received: by 2002:a50:c04f:0:b0:55f:ce14:337a with SMTP id
 u15-20020a50c04f000000b0055fce14337amr10707113edd.11.1707237751511; Tue, 06
 Feb 2024 08:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20240206135231.234184-1-jens.nyberg@gmail.com>
 <ZcJVJYj-Ovcs_xL0@redhat.com>
In-Reply-To: <ZcJVJYj-Ovcs_xL0@redhat.com>
From: Jens Nyberg <jens.nyberg@gmail.com>
Date: Tue, 6 Feb 2024 17:42:19 +0100
Message-ID: <CALXW-VCERSFcnN1+7yBo0+JuQofOXKfx6c5G6V4zEGfujL3Yng@mail.gmail.com>
Subject: Re: [RFC] hw/i386/multiboot2: add multiboot2 support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net
Content-Type: multipart/alternative; boundary="000000000000b9dedf0610b94365"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jens.nyberg@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000b9dedf0610b94365
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have sent an email now asking him if he wants to sign off on it, in which
case I will add him as well.

Jens

Den tis 6 feb. 2024 16:50Daniel P. Berrang=C3=A9 <berrange@redhat.com> skre=
v:

> On Tue, Feb 06, 2024 at 02:52:31PM +0100, Jens Nyberg wrote:
> > This is the first very rough version of what is supposed to be support
> for
> > multiboot2. This is a continuation of work that was started years ago b=
ut
> > never saw fruition for reasons unknown.
>
> Since you've picked up work orignially started by someone else,
> there's a little complexity wrt the Signed-off-by.
>
> As a general rule we would expect to see a 'Signed-off-by' by
> the person whose work you continued. Unfortunately it looks
> like they didn't add their S-o-B when attaching their proposed
> patch to
>
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D2;bug=3D621529;filena=
me=3Dmultiboot2.patch;msg=3D15
>
> Did you try to contact Goswin von Brederlow <goswin-v-b@web.de>
> to see if their email addr is still active, and ask if they're
> willing to add their Signed-off-by, for their part in developing
> this patch ?
>
> It isn't a 100% blocker to not have their S-o-B, it just means
> you have to be comfortable with the fact that you're effectively
> signing off work done by them. The fact that their added this
> patch to the Debian bug tracker with the explicit intention it
> get incorporated into QEMU is positive.
>
> It is still worth emailing them to see if we can get the easy
> answer directly.
>
> > This is submitted as an RFC only for now. It would be nice if someone
> would
> > be willing to guide me into further improving this code
> >
> > Any ideas on how to properly test this would also be nice!
> >
> > Signed-off-by: Jens Nyberg <jens.nyberg@gmail.com>
> > ---
> >  hw/i386/meson.build                          |   1 +
> >  hw/i386/multiboot2.c                         | 552 +++++++++++++++++++
> >  hw/i386/multiboot2.h                         |  16 +
> >  hw/i386/x86.c                                |   8 +
> >  include/standard-headers/linux/qemu_fw_cfg.h |   2 +
> >  pc-bios/optionrom/Makefile                   |   2 +-
> >  pc-bios/optionrom/multiboot2.S               | 324 +++++++++++
> >  pc-bios/optionrom/optionrom.h                |   1 +
> >  8 files changed, 905 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/i386/multiboot2.c
> >  create mode 100644 hw/i386/multiboot2.h
> >  create mode 100644 pc-bios/optionrom/multiboot2.S
> >
> > diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> > index 369c6bf823..3ccf9d7398 100644
> > --- a/hw/i386/meson.build
> > +++ b/hw/i386/meson.build
> > @@ -4,6 +4,7 @@ i386_ss.add(files(
> >    'kvmvapic.c',
> >    'e820_memory_layout.c',
> >    'multiboot.c',
> > +  'multiboot2.c',
> >    'x86.c',
> >  ))
> >
> > diff --git a/hw/i386/multiboot2.c b/hw/i386/multiboot2.c
> > new file mode 100644
> > index 0000000000..6d1c07cc40
> > --- /dev/null
> > +++ b/hw/i386/multiboot2.c
> > @@ -0,0 +1,552 @@
> > +/*
> > + * QEMU PC System Emulator
> > + *
> > + * Copyright (c) 2003-2004 Fabrice Bellard
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/option.h"
> > +#include "cpu.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "multiboot2.h"
> > +#include "hw/loader.h"
> > +#include "elf.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qemu/error-report.h"
> > +
> > +/* Show multiboot debug output */
> > +/* #define DEBUG_MULTIBOOT2 */
> > +
> > +#ifdef DEBUG_MULTIBOOT2
> > +#define mb_debug(a...) error_report(a)
> > +#else
> > +#define mb_debug(a...)
> > +#endif
> > +
> > +#define MULTIBOOT_MEM 0x8000
> > +
> > +#if MULTIBOOT_MEM > 0xf0000
> > +#error multiboot struct needs to fit in 16 bit real mode
> > +#endif
> > +
> > +/* How many bytes from the start of the file we search for the header.
> */
> > +#define MULTIBOOT_SEARCH                32768
> > +#define MULTIBOOT_HEADER_ALIGN          8
> > +
> > +/* The magic field should contain this.  */
> > +#define MULTIBOOT2_HEADER_MAGIC         0xe85250d6
> > +
> > +/* This should be in %eax.  */
> > +#define MULTIBOOT2_BOOTLOADER_MAGIC     0x36d76289
> > +
> > +/* Alignment of multiboot modules.  */
> > +#define MULTIBOOT_MOD_ALIGN             0x00001000
> > +
> > +/* Alignment of the multiboot info structure.  */
> > +#define MULTIBOOT_INFO_ALIGN            0x00000008
> > +
> > +/* Flags set in the 'flags' member of the multiboot header.  */
> > +
> > +#define MULTIBOOT_TAG_ALIGN                 8
> > +#define MULTIBOOT_TAG_TYPE_END              0
> > +#define MULTIBOOT_TAG_TYPE_CMDLINE          1
> > +#define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME 2
> > +#define MULTIBOOT_TAG_TYPE_MODULE           3
> > +#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO    4
> > +#define MULTIBOOT_TAG_TYPE_BOOTDEV          5
> > +#define MULTIBOOT_TAG_TYPE_MMAP             6
> > +#define MULTIBOOT_TAG_TYPE_VBE              7
> > +#define MULTIBOOT_TAG_TYPE_FRAMEBUFFER      8
> > +#define MULTIBOOT_TAG_TYPE_ELF_SECTIONS     9
> > +#define MULTIBOOT_TAG_TYPE_APM              10
> > +#define MULTIBOOT_TAG_TYPE_EFI32            11
> > +#define MULTIBOOT_TAG_TYPE_EFI64            12
> > +#define MULTIBOOT_TAG_TYPE_SMBIOS           13
> > +#define MULTIBOOT_TAG_TYPE_ACPI_OLD         14
> > +#define MULTIBOOT_TAG_TYPE_ACPI_NEW         15
> > +#define MULTIBOOT_TAG_TYPE_NETWORK          16
> > +
> > +#define MULTIBOOT_HEADER_TAG_END                    0
> > +#define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST    1
> > +#define MULTIBOOT_HEADER_TAG_ADDRESS                2
> > +#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS          3
> > +#define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS          4
> > +#define MULTIBOOT_HEADER_TAG_FRAMEBUFFER            5
> > +#define MULTIBOOT_HEADER_TAG_MODULE_ALIGN           6
> > +
> > +#define MULTIBOOT_ARCHITECTURE_I386     0
> > +#define MULTIBOOT_ARCHITECTURE_X86_64   1
> > +#define MULTIBOOT_ARCHITECTURE_MIPS32   4
> > +#define MULTIBOOT_HEADER_TAG_OPTIONAL   1
> > +
> > +#define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED    1
> > +#define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED  2
> > +
> > +typedef unsigned char multiboot_uint8_t;
> > +typedef unsigned short multiboot_uint16_t;
> > +typedef unsigned int multiboot_uint32_t;
> > +typedef unsigned long long multiboot_uint64_t;
> > +
> > +struct multiboot_header {
> > +    /* Must be MULTIBOOT_MAGIC - see above.  */
> > +    multiboot_uint32_t magic;
> > +    /* ISA */
> > +    multiboot_uint32_t architecture;
> > +    /* Total header length.  */
> > +    multiboot_uint32_t header_length;
> > +    /* The above fields plus this one must equal 0 mod 2^32. */
> > +    multiboot_uint32_t checksum;
> > +};
> > +
> > +struct multiboot_header_tag {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +};
> > +
> > +struct multiboot_header_tag_information_request {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t requests[0];
> > +};
> > +
> > +struct multiboot_header_tag_address {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t header_addr;
> > +    multiboot_uint32_t load_addr;
> > +    multiboot_uint32_t load_end_addr;
> > +    multiboot_uint32_t bss_end_addr;
> > +};
> > +
> > +struct multiboot_header_tag_entry_address {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t entry_addr;
> > +};
> > +
> > +struct multiboot_header_tag_console_flags {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t console_flags;
> > +};
> > +
> > +struct multiboot_header_tag_framebuffer {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t width;
> > +    multiboot_uint32_t height;
> > +    multiboot_uint32_t depth;
> > +};
> > +
> > +struct multiboot_header_tag_module_align {
> > +    multiboot_uint16_t type;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t width;
> > +    multiboot_uint32_t height;
> > +    multiboot_uint32_t depth;
> > +};
> > +
> > +struct multiboot_color {
> > +    multiboot_uint8_t red;
> > +    multiboot_uint8_t green;
> > +    multiboot_uint8_t blue;
> > +};
> > +
> > +struct multiboot_mmap_entry {
> > +    multiboot_uint64_t addr;
> > +    multiboot_uint64_t len;
> > +#define MULTIBOOT_MEMORY_AVAILABLE          1
> > +#define MULTIBOOT_MEMORY_RESERVED           2
> > +#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE   3
> > +#define MULTIBOOT_MEMORY_NVS                4
> > +#define MULTIBOOT_MEMORY_BADRAM             5
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t zero;
> > +} __attribute__((packed));
> > +
> > +typedef struct multiboot_mmap_entry multiboot_memory_map_t;
> > +
> > +struct multiboot_tag {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +};
> > +
> > +struct multiboot_tag_string {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    char string[0];
> > +};
> > +
> > +struct multiboot_tag_module {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t mod_start;
> > +    multiboot_uint32_t mod_end;
> > +    char cmdline[0];
> > +};
> > +
> > +struct multiboot_tag_basic_meminfo {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t mem_lower;
> > +    multiboot_uint32_t mem_upper;
> > +};
> > +
> > +struct multiboot_tag_bootdev {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t biosdev;
> > +    multiboot_uint32_t slice;
> > +    multiboot_uint32_t part;
> > +};
> > +
> > +struct multiboot_tag_mmap {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t entry_size;
> > +    multiboot_uint32_t entry_version;
> > +    struct multiboot_mmap_entry entries[0];
> > +};
> > +
> > +struct multiboot_vbe_info_block {
> > +    multiboot_uint8_t external_specification[512];
> > +};
> > +
> > +struct multiboot_vbe_mode_info_block {
> > +    multiboot_uint8_t external_specification[256];
> > +};
> > +
> > +struct multiboot_tag_vbe {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint16_t vbe_mode;
> > +    multiboot_uint16_t vbe_interface_seg;
> > +    multiboot_uint16_t vbe_interface_off;
> > +    multiboot_uint16_t vbe_interface_len;
> > +    struct multiboot_vbe_info_block vbe_control_info;
> > +    struct multiboot_vbe_mode_info_block vbe_mode_info;
> > +};
> > +
> > +struct multiboot_tag_framebuffer_common {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint64_t framebuffer_addr;
> > +    multiboot_uint32_t framebuffer_pitch;
> > +    multiboot_uint32_t framebuffer_width;
> > +    multiboot_uint32_t framebuffer_height;
> > +    multiboot_uint8_t framebuffer_bpp;
> > +#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED  0
> > +#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB      1
> > +#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT 2
> > +    multiboot_uint8_t framebuffer_type;
> > +    multiboot_uint16_t reserved;
> > +};
> > +
> > +struct multiboot_tag_framebuffer {
> > +    struct multiboot_tag_framebuffer_common common;
> > +
> > +    union {
> > +        struct {
> > +            multiboot_uint16_t framebuffer_palette_num_colors;
> > +            struct multiboot_color framebuffer_palette[0];
> > +        };
> > +        struct {
> > +            multiboot_uint8_t framebuffer_red_field_position;
> > +            multiboot_uint8_t framebuffer_red_mask_size;
> > +            multiboot_uint8_t framebuffer_green_field_position;
> > +            multiboot_uint8_t framebuffer_green_mask_size;
> > +            multiboot_uint8_t framebuffer_blue_field_position;
> > +            multiboot_uint8_t framebuffer_blue_mask_size;
> > +        };
> > +    };
> > +};
> > +
> > +struct multiboot_tag_elf_sections {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t num;
> > +    multiboot_uint32_t entsize;
> > +    multiboot_uint32_t shndx;
> > +    char sections[0];
> > +};
> > +
> > +struct multiboot_tag_apm {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint16_t version;
> > +    multiboot_uint16_t cseg;
> > +    multiboot_uint32_t offset;
> > +    multiboot_uint16_t cseg_16;
> > +    multiboot_uint16_t dseg;
> > +    multiboot_uint16_t flags;
> > +    multiboot_uint16_t cseg_len;
> > +    multiboot_uint16_t cseg_16_len;
> > +    multiboot_uint16_t dseg_len;
> > +};
> > +
> > +struct multiboot_tag_efi32 {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint32_t pointer;
> > +};
> > +
> > +struct multiboot_tag_efi64 {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint64_t pointer;
> > +};
> > +
> > +struct multiboot_tag_smbios {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint8_t major;
> > +    multiboot_uint8_t minor;
> > +    multiboot_uint8_t reserved[6];
> > +    multiboot_uint8_t tables[0];
> > +};
> > +
> > +struct multiboot_tag_old_acpi {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint8_t rsdp[0];
> > +};
> > +
> > +struct multiboot_tag_new_acpi {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint8_t rsdp[0];
> > +};
> > +
> > +struct multiboot_tag_network {
> > +    multiboot_uint32_t type;
> > +    multiboot_uint32_t size;
> > +    multiboot_uint8_t dhcpack[0];
> > +};
> > +
> > +typedef struct {
> > +    /* buffers holding kernel and boot info tags */
> > +    void *mb_buf;
> > +    void *mb_tags;
> > +    /* address in target */
> > +    hwaddr mb_buf_phys;
> > +    /* size of mb_buf in bytes */
> > +    unsigned mb_buf_size;
> > +    /* size of tags in bytes */
> > +    unsigned mb_tags_size;
> > +} MultibootState;
> > +
> > +static void mb_add_cmdline(MultibootState *s, const char *cmdline)
> > +{
> > +    int len =3D strlen(cmdline) + 1;
> > +    struct multiboot_tag_string *tag;
> > +    unsigned new_size =3D s->mb_tags_size;
> > +
> > +    new_size +=3D sizeof(struct multiboot_tag_string) + len;
> > +    new_size =3D (new_size + 7) & ~7;
> > +
> > +    s->mb_tags =3D g_realloc(s->mb_tags, new_size);
> > +    tag =3D (struct multiboot_tag_string *)(s->mb_tags + s->mb_tags_si=
ze);
> > +    s->mb_tags_size =3D new_size;
> > +
> > +    tag->type =3D MULTIBOOT_TAG_TYPE_CMDLINE;
> > +    tag->size =3D sizeof(struct multiboot_tag_string) + len;
> > +
> > +    strncpy((char *)tag->string, cmdline, len);
> > +}
> > +
> > +static void mb_add_basic_meminfo(MultibootState *s,
> > +                                 uint32_t mem_lower,
> > +                                 uint32_t mem_upper)
> > +{
> > +    struct multiboot_tag_basic_meminfo *tag;
> > +    unsigned new_size =3D s->mb_tags_size;
> > +
> > +    new_size +=3D sizeof(struct multiboot_tag_basic_meminfo);
> > +    new_size =3D (new_size + 7) & ~7;
> > +
> > +    s->mb_tags =3D g_realloc(s->mb_tags, new_size);
> > +    tag =3D (struct multiboot_tag_basic_meminfo *)(s->mb_tags +
> s->mb_tags_size);
> > +    s->mb_tags_size =3D new_size;
> > +
> > +    tag->type =3D MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
> > +    tag->size =3D sizeof(struct multiboot_tag_basic_meminfo);
> > +    tag->mem_lower =3D mem_lower;
> > +    tag->mem_upper =3D mem_upper;
> > +}
> > +
> > +int load_multiboot2(X86MachineState *x86ms,
> > +                    FWCfgState *fw_cfg,
> > +                    FILE *f,
> > +                    const char *kernel_filename,
> > +                    const char *initrd_filename,
> > +                    const char *kernel_cmdline,
> > +                    int kernel_file_size,
> > +                    uint8_t *header)
> > +{
> > +    MultibootState mbs;
> > +    uint32_t architecture =3D 0;
> > +    uint32_t header_length =3D 0;
> > +    uint32_t mh_entry_addr;
> > +    uint32_t mh_load_addr;
> > +    uint32_t mb_kernel_size;
> > +    int is_multiboot =3D 0;
> > +    int i;
> > +
> > +    /* The header is in the first 32k with alignment 8. */
> > +    for (i =3D 0; (i < 32768 - 15) && (i < kernel_file_size - 15); i +=
=3D
> 8) {
> > +        if (ldl_p(header + i) =3D=3D MULTIBOOT2_HEADER_MAGIC) {
> > +            uint32_t checksum =3D ldl_p(header + i + 12);
> > +            architecture =3D ldl_p(header + i + 4);
> > +            header_length =3D ldl_p(header + i + 8);
> > +            checksum +=3D MULTIBOOT2_HEADER_MAGIC;
> > +            checksum +=3D architecture;
> > +            checksum +=3D header_length;
> > +
> > +            if (!checksum) {
> > +                is_multiboot =3D 1;
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +    if (!is_multiboot) {
> > +        return 0;
> > +    }
> > +
> > +    switch (architecture) {
> > +    case MULTIBOOT_ARCHITECTURE_I386:
> > +        mb_debug("architecture i386\n");
> > +        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BIT, 0);
> > +        break;
> > +    case MULTIBOOT_ARCHITECTURE_X86_64:
> > +        mb_debug("architecture x86_64\n");
> > +        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BIT, 1);
> > +        break;
> > +    default:
> > +        error_report("multiboot2 architecture must be i386 or x86_64."=
);
> > +        exit(1);
> > +    }
> > +
> > +    mb_debug("I believe we found a multiboot2 image!\n");
> > +    memset(&mbs, 0, sizeof(mbs));
> > +
> > +    /* Add size field to multiboot info */
> > +    mbs.mb_tags =3D g_malloc(8);
> > +    mbs.mb_tags_size =3D 8;
> > +
> > +    /* Commandline support */
> > +    char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + 2=
];
> > +
> > +    snprintf(kcmdline, sizeof(kcmdline), "%s %s",
> > +             kernel_filename, kernel_cmdline);
> > +    mb_add_cmdline(&mbs, kcmdline);
> > +
> > +    /* Basic memory info */
> > +    mb_add_basic_meminfo(&mbs, 640, (x86ms->above_4g_mem_size / 1024) =
-
> 1024);
> > +
> > +    /* Load kernel */
> > +    /* FIXME: only elf support for now */
> > +    {
> > +        uint64_t elf_entry;
> > +        uint64_t elf_low, elf_high;
> > +        int kernel_size;
> > +        int size;
> > +
> > +        fclose(f);
> > +
> > +        if (((struct elf64_hdr *)header)->e_machine =3D=3D EM_X86_64) =
{
> > +            mb_debug("64bit elf, I hope you know what you are doing\n"=
);
> > +        }
> > +
> > +        kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
> &elf_entry,
> > +                               &elf_low, &elf_high, NULL, 0,
> I386_ELF_MACHINE,
> > +                               0, 0);
> > +
> > +        if (kernel_size < 0) {
> > +            error_report("Error while loading elf kernel");
> > +            exit(1);
> > +        }
> > +
> > +        mh_load_addr =3D elf_low;
> > +        mb_kernel_size =3D elf_high - elf_low;
> > +        mh_entry_addr =3D elf_entry;
> > +        mbs.mb_buf =3D g_malloc(mb_kernel_size);
> > +        size =3D rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size);
> > +
> > +        if (size !=3D mb_kernel_size) {
> > +            error_report("Error while fetching elf kernel from rom");
> > +            exit(1);
> > +        }
> > +
> > +        mb_debug("loading multiboot-elf kernel (0x%x bytes)"
> > +                 " with entry 0x%zx\n",
> > +                 mb_kernel_size, (size_t)mh_entry_addr);
> > +    }
> > +
> > +    /* Align to next page */
> > +    /* FIXME: honor align header tag */
> > +    mbs.mb_buf_size =3D TARGET_PAGE_ALIGN(mb_kernel_size);
> > +
> > +    /* FIXME: load modules */
> > +    /* FIXME: add other tags */
> > +
> > +    /* The multiboot2 bootrom will add the mmap and end tags. */
> > +
> > +    /* Set size of multiboot infos */
> > +    multiboot_uint64_t *size =3D mbs.mb_tags;
> > +    *size =3D mbs.mb_tags_size;
> > +
> > +    /* Display infos */
> > +    mb_debug("kernel_entry =3D 0x%zx\n", (size_t)mh_entry_addr);
> > +    mb_debug("kernel_addr  =3D 0x%zx\n", (size_t)mh_load_addr);
> > +    mb_debug("kernel_size  =3D 0x%zx\n", (size_t)mbs.mb_buf_size);
> > +    mb_debug("initrd_addr  =3D 0x%zx\n", (size_t)MULTIBOOT_MEM);
> > +    mb_debug("initrd_size  =3D 0x%zx\n", (size_t)mbs.mb_tags_size);
> > +
> > +    /* Add extra space for dynamic tags */
> > +    mbs.mb_tags_size +=3D 4096;
> > +    mbs.mb_tags =3D g_realloc(mbs.mb_tags, mbs.mb_tags_size);
> > +
> > +    /* Pass variables to option rom */
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, mbs.mb_buf_size);
> > +    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA,
> > +                     mbs.mb_buf, mbs.mb_buf_size);
> > +
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, MULTIBOOT_MEM);
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, mbs.mb_tags_size);
> > +    fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mbs.mb_tags,
> > +                     mbs.mb_tags_size);
> > +
> > +    option_rom[nb_option_roms].name =3D "multiboot2.bin";
> > +    option_rom[nb_option_roms].bootindex =3D 0;
> > +    nb_option_roms++;
> > +
> > +    return 1; /* yes, we are multiboot */
> > +}
> > diff --git a/hw/i386/multiboot2.h b/hw/i386/multiboot2.h
> > new file mode 100644
> > index 0000000000..d98d4723c7
> > --- /dev/null
> > +++ b/hw/i386/multiboot2.h
> > @@ -0,0 +1,16 @@
> > +#ifndef QEMU_MULTIBOOT2_H
> > +#define QEMU_MULTIBOOT2_H
> > +
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "hw/i386/x86.h"
> > +
> > +int load_multiboot2(X86MachineState *x86ms,
> > +                    FWCfgState *fw_cfg,
> > +                    FILE *f,
> > +                    const char *kernel_filename,
> > +                    const char *initrd_filename,
> > +                    const char *kernel_cmdline,
> > +                    int kernel_file_size,
> > +                    uint8_t *header);
> > +
> > +#endif
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 2b6291ad8d..f40f0ad8ec 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -53,6 +53,7 @@
> >  #include "hw/nmi.h"
> >  #include "hw/loader.h"
> >  #include "multiboot.h"
> > +#include "multiboot2.h"
> >  #include "elf.h"
> >  #include "standard-headers/asm-x86/bootparam.h"
> >  #include CONFIG_DEVICES
> > @@ -845,6 +846,13 @@ void x86_load_linux(X86MachineState *x86ms,
> >                             kernel_cmdline, kernel_size, header)) {
> >              return;
> >          }
> > +        /*
> > +         * Check multiboot2 kernel.
> > +         */
> > +        if (load_multiboot2(x86ms, fw_cfg, f, kernel_filename,
> initrd_filename,
> > +                            kernel_cmdline, kernel_size, header)) {
> > +            return;
> > +        }
> >          /*
> >           * Check if the file is an uncompressed kernel file (ELF) and
> load it,
> >           * saving the PVH entry point used by the x86/HVM direct boot
> ABI.
> > diff --git a/include/standard-headers/linux/qemu_fw_cfg.h
> b/include/standard-headers/linux/qemu_fw_cfg.h
> > index cb93f6678d..f9b877e14d 100644
> > --- a/include/standard-headers/linux/qemu_fw_cfg.h
> > +++ b/include/standard-headers/linux/qemu_fw_cfg.h
> > @@ -37,6 +37,8 @@
> >  #define FW_CFG_FILE_FIRST    0x20
> >  #define FW_CFG_FILE_SLOTS_MIN        0x10
> >
> > +#define FW_CFG_KERNEL_64BIT  0x21
> > +
> >  #define FW_CFG_WRITE_CHANNEL 0x4000
> >  #define FW_CFG_ARCH_LOCAL    0x8000
> >  #define FW_CFG_ENTRY_MASK    (~(FW_CFG_WRITE_CHANNEL |
> FW_CFG_ARCH_LOCAL))
> > diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> > index 30d07026c7..21094232e0 100644
> > --- a/pc-bios/optionrom/Makefile
> > +++ b/pc-bios/optionrom/Makefile
> > @@ -2,7 +2,7 @@ include config.mak
> >  SRC_DIR :=3D $(TOPSRC_DIR)/pc-bios/optionrom
> >  VPATH =3D $(SRC_DIR)
> >
> > -all: multiboot.bin multiboot_dma.bin linuxboot.bin linuxboot_dma.bin
> kvmvapic.bin pvh.bin
> > +all: multiboot.bin multiboot_dma.bin multiboot2.bin linuxboot.bin
> linuxboot_dma.bin kvmvapic.bin pvh.bin
> >  # Dummy command so that make thinks it has done something
> >       @true
> >
> > diff --git a/pc-bios/optionrom/multiboot2.S
> b/pc-bios/optionrom/multiboot2.S
> > new file mode 100644
> > index 0000000000..a27c2a1f3c
> > --- /dev/null
> > +++ b/pc-bios/optionrom/multiboot2.S
> > @@ -0,0 +1,324 @@
> > +/*
> > + * Multiboot2 Option ROM
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + *
> > + * Original Multiboot Option ROM:
> > + * Copyright Novell Inc, 2009
> > + *   Authors: Alexander Graf <agraf@suse.de>
> > + *
> > + * Adaption to Multiboot2 specs:
> > + * Copyright Goswin von Brederlow, 2011
> > + *   Authors: Goswin von Brederlow <goswin-v-b@web.de>
> > + *
> > + * Cleaned up and merged by:
> > + * Copyright Jens Nyberg, 2024
> > + *   Authors: Jens Nyberg <jens.nyberg@gmail.com>
> > + *
> > + */
> > +
> > +#include "optionrom.h"
> > +
> > +#define BOOT_ROM_PRODUCT "multiboot2 loader"
> > +
> > +#define MULTIBOOT_MAGIC              0x36d76289
> > +
> > +#define GS_PROT_JUMP         0
> > +#define GS_GDT_DESC          8
> > +
> > +/* Memory layout (page tables only for 64 bit):
> > + * 0x2000 L4 page table
> > + * 0x3000 L3 page table
> > + * 0x4000 L2 page table
> > + * ...
> > + * 0x7000 L2 page table
> > + * 0x8000 bootinfo tags
> > + */
> > +
> > +#define PGTABLE                      0x2000
> > +
> > +BOOT_ROM_START
> > +
> > +run_multiboot:
> > +
> > +     cli
> > +     cld
> > +
> > +     mov             %cs, %eax
> > +     shl             $0x4, %eax
> > +     mov             %eax, %ebp /* used below to jump to 64bit */
> > +
> > +     /* set up a long jump descriptor that is PC relative */
> > +
> > +     /* move stack memory to %gs */
> > +     mov             %ss, %ecx
> > +     shl             $0x4, %ecx
> > +     mov             %esp, %ebx
> > +     add             %ebx, %ecx
> > +     sub             $0x20, %ecx
> > +     sub             $0x30, %esp
> > +     shr             $0x4, %ecx
> > +     mov             %cx, %gs
> > +
> > +     /* now push the indirect jump decriptor there */
> > +     mov             (prot_jump), %ebx
> > +     add             %eax, %ebx
> > +     movl            %ebx, %gs:GS_PROT_JUMP
> > +     mov             $8, %bx
> > +     movw            %bx, %gs:GS_PROT_JUMP + 4
> > +
> > +     /* fix the gdt descriptor to be PC relative */
> > +     movw            (gdt_desc), %bx
> > +     movw            %bx, %gs:GS_GDT_DESC
> > +     movl            (gdt_desc+2), %ebx
> > +     add             %eax, %ebx
> > +     movl            %ebx, %gs:GS_GDT_DESC + 2
> > +
> > +     xor             %eax, %eax
> > +     mov             %eax, %es
> > +
> > +     /* Read the bootinfo struct into RAM */
> > +     read_fw_blob(FW_CFG_INITRD)
> > +
> > +     /* FS =3D bootinfo_struct */
> > +     read_fw         FW_CFG_INITRD_ADDR
> > +     shr             $4, %eax
> > +     mov             %ax, %fs
> > +     mov             %ax, %es        /* for int 0x15 */
> > +
> > +     /* %fs:%edi =3D bootinfo size =3D offset of mmap tag */
> > +     movl            %fs:0, %edi
> > +
> > +#define MULTIBOOT_TAG_TYPE_MMAP              6
> > +     /* Create mmap tag */
> > +     movl            $6, %fs:0(%edi)         /* type mmap */
> > +     movl            $24, %fs:8(%edi)        /* entry_size */
> > +     movl            $0, %fs:12(%edi)        /* entry_version */
> > +
> > +     /* Initialize multiboot mmap structs using int 0x15(e820) */
> > +     xor             %ebx, %ebx
> > +     /* mmap starts at byte 16 */
> > +     addl            $16, %edi
> > +
> > +mmap_loop:
> > +     /* entry size (mmap struct) & max buffer size (int15) */
> > +     movl            $20, %ecx
> > +     /* e820 */
> > +     movl            $0x0000e820, %eax
> > +     /* 'SMAP' magic */
> > +     movl            $0x534d4150, %edx
> > +     int             $0x15
> > +
> > +mmap_check_entry:
> > +     /* last entry? then we're done */
> > +     jb              mmap_done
> > +     and             %bx, %bx
> > +     jz              mmap_done
> > +     /* valid entry, so let's loop on */
> > +
> > +mmap_next_entry:
> > +     /* Advance %edi by sizeof(struct multiboot_mmap_entry) =3D 24 */
> > +     addl            $24, %edi
> > +     jmp             mmap_loop
> > +
> > +mmap_done:
> > +     addl            $24, %edi               /* advance past entry */
> > +     /* Create end tag */
> > +     movl            $0, %fs:0(%edi)         /* type */
> > +     movl            $8, %fs:4(%edi)         /* size */
> > +     leal            8(%edi), %ebx           /* size of all tags */
> > +
> > +     /* set mmap tag size */
> > +     mov             %edi, %eax      /* save offset after mmap */
> > +     mov             %fs:0, %edi     /* offset of mmap tag */
> > +     sub             %edi, %eax      /* size of mmap tag */
> > +     movl            %eax, %fs:4(%edi) /* size */
> > +
> > +     /* Store size of all tags */
> > +     movl            %ebx, %fs:0
> > +
> > +real_to_prot:
> > +     /* Load the GDT before going into protected mode */
> > +lgdt:
> > +     data32 lgdt     %gs:GS_GDT_DESC
> > +
> > +     /* get us to protected mode now */
> > +     movl            $1, %eax
> > +     movl            %eax, %cr0
> > +
> > +     /* the LJMP sets CS for us and gets us to 32-bit */
> > +ljmp32:
> > +     data32 ljmp     *%gs:GS_PROT_JUMP
> > +
> > +prot_mode:
> > +.code32
> > +     /* initialize all other segments */
> > +     movl            $0x10, %eax
> > +     movl            %eax, %ss
> > +     movl            %eax, %ds
> > +     movl            %eax, %es
> > +     movl            %eax, %fs
> > +     movl            %eax, %gs
> > +
> > +     /* Read the kernel and modules into RAM */
> > +     read_fw_blob(FW_CFG_KERNEL)
> > +
> > +     /* 32bit or 64bit mode? */
> > +     read_fw         FW_CFG_KERNEL_64BIT
> > +     cmpl            $0, %eax
> > +     jne             ljmp64
> > +
> > +     /* Jump off to the kernel */
> > +     read_fw         FW_CFG_KERNEL_ENTRY
> > +     mov             %eax, %ecx
> > +
> > +     /* EBX contains a pointer to the bootinfo struct */
> > +     read_fw         FW_CFG_INITRD_ADDR
> > +     movl            %eax, %ebx
> > +
> > +     /* EAX has to contain the magic */
> > +     movl            $MULTIBOOT_MAGIC, %eax
> > +ljmp2:
> > +     /* Jump to kernel in 32bit mode */
> > +     jmp             *%ecx
> > +
> > +/******************************************************************/
> > +/* Set up 64bit mode                                              */
> > +/******************************************************************/
> > +ljmp64:
> > +     /* Enable PAE */
> > +     movl    %cr4, %eax
> > +     btsl    $5, %eax
> > +     movl    %eax, %cr4
> > +
> > + /*
> > +  * Build early 4G boot pagetable
> > +  */
> > +     /* Initialize Page tables to 0 */
> > +     leal    PGTABLE, %edi
> > +     xorl    %eax, %eax
> > +     movl    $((4096*6)/4), %ecx
> > +     rep     stosl
> > +
> > +     /* Build Level 4 */
> > +     leal    PGTABLE + 0, %edi
> > +     leal    0x1007 (%edi), %eax
> > +     movl    %eax, 0(%edi)
> > +
> > +     /* Build Level 3 */
> > +     leal    PGTABLE + 0x1000, %edi
> > +     leal    0x1007(%edi), %eax
> > +     movl    $4, %ecx
> > +1:   movl    %eax, 0x00(%edi)
> > +     addl    $0x00001000, %eax
> > +     addl    $8, %edi
> > +     decl    %ecx
> > +     jnz     1b
> > +
> > +     /* Build Level 2 */
> > +     leal    PGTABLE + 0x2000, %edi
> > +     movl    $0x00000183, %eax
> > +     movl    $2048, %ecx
> > +1:   movl    %eax, 0(%edi)
> > +     addl    $0x00200000, %eax
> > +     addl    $8, %edi
> > +     decl    %ecx
> > +     jnz     1b
> > +
> > +     /* Load Level 4 page table (page 128) */
> > +     leal    PGTABLE, %eax
> > +     movl    %eax, %cr3
> > +
> > +     /* Enable long mode */
> > +     movl    $0xc0000080, %ecx
> > +     rdmsr
> > +     btsl    $8, %eax
> > +     wrmsr
> > +
> > +     /* enable paging to activate long mode */
> > +     movl    %cr0, %eax
> > +     btsl    $1, %eax        /* protected mode */
> > +     btsl    $31, %eax       /* paging */
> > +     movl    %eax, %cr0
> > +
> > +     /* Jump off to the kernel */
> > +     read_fw         FW_CFG_KERNEL_ENTRY
> > +     movl            %eax, %ebx
> > +
> > +     /* pointer to the bootinfo struct */
> > +     read_fw         FW_CFG_INITRD_ADDR
> > +     movl            %eax, %ecx
> > +
> > +     /* jump to 64bit mode */
> > +     pushl   $0x28
> > +     leal    startup_64(%ebp), %eax
> > +     pushl   %eax
> > +     lret
> > +
> > +     .code64
> > +startup_64:
> > +_startup_64:
> > +     /* EDI has to contain the magic, ESI the boot info */
> > +     movl    %ebx, %eax      /* kernel entry address */
> > +     movl    %ecx, %esi      /* pointer to boot info */
> > +     movl    $MULTIBOOT_MAGIC, %edi
> > +     jmp     *%rax
> > +
> > +color:       /* collor me silly */
> > +     addl    $0x1,0xb8000
> > +     jmp     color
> > +
> > +/******************************************************************/
> > +
> > +
> > +/* Variables */
> > +.align 4, 0
> > +prot_jump:   .long prot_mode
> > +             .short 8
> > +
> > +.align 4, 0
> > +gdt:
> > +     /* 0x00: null segment */
> > +.byte        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> > +
> > +     /* 0x08: code segment */
> > +     /* base=3D0, limit=3D0xfffff, type=3D32bit code exec/read, DPL=3D=
0, 4k */
> > +.byte        0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
> > +
> > +     /* 0x10: data segment */
> > +     /* base=3D0, limit=3D0xfffff, type=3D32bit data read/write, DPL=
=3D0, 4k */
> > +.byte        0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
> > +
> > +     /* 0x18: code segment */
> > +     /* base=3D0, limit=3D0x0ffff, type=3D16bit code exec/read/conf, D=
PL=3D0,
> 1b */
> > +.byte        0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
> > +
> > +     /* 0x20: data segment */
> > +     /* base=3D0, limit=3D0x0ffff, type=3D16bit data read/write, DPL=
=3D0, 1b */
> > +.byte        0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0x00, 0x00
> > +
> > +     /* 0x28: code segment */
> > +     /* base=3D0, limit=3D0xfffff, type=3D64bit code exec/read, DPL=3D=
0, 4k */
> > +.byte        0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xaf, 0x00
> > +
> > +     /* 0x30: ts descriptor */
> > +.byte        0x00, 0x00, 0x00, 0x00, 0x00, 0x89, 0x80, 0x00
> > +     /* 0x38: ts continued */
> > +.byte        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> > +
> > +gdt_desc:
> > +.short       (8 * 8) - 1
> > +.long        gdt
> > +
> > +BOOT_ROM_END
> > diff --git a/pc-bios/optionrom/optionrom.h
> b/pc-bios/optionrom/optionrom.h
> > index 7bcdf0eeb2..6f758c58be 100644
> > --- a/pc-bios/optionrom/optionrom.h
> > +++ b/pc-bios/optionrom/optionrom.h
> > @@ -33,6 +33,7 @@
> >  #define FW_CFG_SETUP_ADDR       0x16
> >  #define FW_CFG_SETUP_SIZE       0x17
> >  #define FW_CFG_SETUP_DATA       0x18
> > +#define FW_CFG_KERNEL_64BIT     0x21
> >
> >  #define BIOS_CFG_IOPORT_CFG    0x510
> >  #define BIOS_CFG_IOPORT_DATA   0x511
> > --
> > 2.43.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000b9dedf0610b94365
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I have sent an email now asking him if he wants to sign o=
ff on it, in which case I will add him as well.<div dir=3D"auto"><br></div>=
<div dir=3D"auto">Jens</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Den tis 6 feb. 2024 16:50Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =
skrev:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On Tue, Feb 06, 2024 at 02:5=
2:31PM +0100, Jens Nyberg wrote:<br>
&gt; This is the first very rough version of what is supposed to be support=
 for<br>
&gt; multiboot2. This is a continuation of work that was started years ago =
but<br>
&gt; never saw fruition for reasons unknown.<br>
<br>
Since you&#39;ve picked up work orignially started by someone else,<br>
there&#39;s a little complexity wrt the Signed-off-by.<br>
<br>
As a general rule we would expect to see a &#39;Signed-off-by&#39; by<br>
the person whose work you continued. Unfortunately it looks<br>
like they didn&#39;t add their S-o-B when attaching their proposed<br>
patch to<br>
<br>
<a href=3D"https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D2;bug=3D6215=
29;filename=3Dmultiboot2.patch;msg=3D15" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">https://bugs.debian.org/cgi-bin/bugreport.cgi?att=3D2;bug=3D6=
21529;filename=3Dmultiboot2.patch;msg=3D15</a><br>
<br>
Did you try to contact Goswin von Brederlow &lt;<a href=3D"mailto:goswin-v-=
b@web.de" target=3D"_blank" rel=3D"noreferrer">goswin-v-b@web.de</a>&gt;<br=
>
to see if their email addr is still active, and ask if they&#39;re<br>
willing to add their Signed-off-by, for their part in developing<br>
this patch ?<br>
<br>
It isn&#39;t a 100% blocker to not have their S-o-B, it just means<br>
you have to be comfortable with the fact that you&#39;re effectively<br>
signing off work done by them. The fact that their added this<br>
patch to the Debian bug tracker with the explicit intention it<br>
get incorporated into QEMU is positive.<br>
<br>
It is still worth emailing them to see if we can get the easy<br>
answer directly.<br>
<br>
&gt; This is submitted as an RFC only for now. It would be nice if someone =
would<br>
&gt; be willing to guide me into further improving this code<br>
&gt; <br>
&gt; Any ideas on how to properly test this would also be nice!<br>
&gt; <br>
&gt; Signed-off-by: Jens Nyberg &lt;<a href=3D"mailto:jens.nyberg@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">jens.nyberg@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/i386/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/i386/multiboot2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 552 +++++++++++++++++++<b=
r>
&gt;=C2=A0 hw/i386/multiboot2.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +<br>
&gt;=C2=A0 hw/i386/x86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A08 +<br>
&gt;=C2=A0 include/standard-headers/linux/qemu_fw_cfg.h |=C2=A0 =C2=A02 +<b=
r>
&gt;=C2=A0 pc-bios/optionrom/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 pc-bios/optionrom/multiboot2.S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 324 +++++++++++<br>
&gt;=C2=A0 pc-bios/optionrom/optionrom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 8 files changed, 905 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 hw/i386/multiboot2.c<br>
&gt;=C2=A0 create mode 100644 hw/i386/multiboot2.h<br>
&gt;=C2=A0 create mode 100644 pc-bios/optionrom/multiboot2.S<br>
&gt; <br>
&gt; diff --git a/hw/i386/meson.build b/hw/i386/meson.build<br>
&gt; index 369c6bf823..3ccf9d7398 100644<br>
&gt; --- a/hw/i386/meson.build<br>
&gt; +++ b/hw/i386/meson.build<br>
&gt; @@ -4,6 +4,7 @@ i386_ss.add(files(<br>
&gt;=C2=A0 =C2=A0 &#39;kvmvapic.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;e820_memory_layout.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;multiboot.c&#39;,<br>
&gt; +=C2=A0 &#39;multiboot2.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;x86.c&#39;,<br>
&gt;=C2=A0 ))<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/i386/multiboot2.c b/hw/i386/multiboot2.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6d1c07cc40<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/i386/multiboot2.c<br>
&gt; @@ -0,0 +1,552 @@<br>
&gt; +/*<br>
&gt; + * QEMU PC System Emulator<br>
&gt; + *<br>
&gt; + * Copyright (c) 2003-2004 Fabrice Bellard<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
&gt; + * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
&gt; + * in the Software without restriction, including without limitation =
the rights<br>
&gt; + * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell<br>
&gt; + * copies of the Software, and to permit persons to whom the Software=
 is<br>
&gt; + * furnished to do so, subject to the following conditions:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL<br>
&gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER<br>
&gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,<br>
&gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN<br>
&gt; + * THE SOFTWARE.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/option.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +#include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt; +#include &quot;multiboot2.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;elf.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +<br>
&gt; +/* Show multiboot debug output */<br>
&gt; +/* #define DEBUG_MULTIBOOT2 */<br>
&gt; +<br>
&gt; +#ifdef DEBUG_MULTIBOOT2<br>
&gt; +#define mb_debug(a...) error_report(a)<br>
&gt; +#else<br>
&gt; +#define mb_debug(a...)<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#define MULTIBOOT_MEM 0x8000<br>
&gt; +<br>
&gt; +#if MULTIBOOT_MEM &gt; 0xf0000<br>
&gt; +#error multiboot struct needs to fit in 16 bit real mode<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +/* How many bytes from the start of the file we search for the header=
.=C2=A0 */<br>
&gt; +#define MULTIBOOT_SEARCH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 32768<br>
&gt; +#define MULTIBOOT_HEADER_ALIGN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br=
>
&gt; +<br>
&gt; +/* The magic field should contain this.=C2=A0 */<br>
&gt; +#define MULTIBOOT2_HEADER_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xe8=
5250d6<br>
&gt; +<br>
&gt; +/* This should be in %eax.=C2=A0 */<br>
&gt; +#define MULTIBOOT2_BOOTLOADER_MAGIC=C2=A0 =C2=A0 =C2=A00x36d76289<br>
&gt; +<br>
&gt; +/* Alignment of multiboot modules.=C2=A0 */<br>
&gt; +#define MULTIBOOT_MOD_ALIGN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00001000<br>
&gt; +<br>
&gt; +/* Alignment of the multiboot info structure.=C2=A0 */<br>
&gt; +#define MULTIBOOT_INFO_ALIGN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x00000008<br>
&gt; +<br>
&gt; +/* Flags set in the &#39;flags&#39; member of the multiboot header.=
=C2=A0 */<br>
&gt; +<br>
&gt; +#define MULTIBOOT_TAG_ALIGN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A08<br>
&gt; +#define MULTIBOOT_TAG_TYPE_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0<br>
&gt; +#define MULTIBOOT_TAG_TYPE_CMDLINE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
1<br>
&gt; +#define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME 2<br>
&gt; +#define MULTIBOOT_TAG_TYPE_MODULE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A03<br>
&gt; +#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO=C2=A0 =C2=A0 4<br>
&gt; +#define MULTIBOOT_TAG_TYPE_BOOTDEV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
5<br>
&gt; +#define MULTIBOOT_TAG_TYPE_MMAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A06<br>
&gt; +#define MULTIBOOT_TAG_TYPE_VBE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 7<br>
&gt; +#define MULTIBOOT_TAG_TYPE_FRAMEBUFFER=C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define MULTIBOOT_TAG_TYPE_ELF_SECTIONS=C2=A0 =C2=A0 =C2=A09<br>
&gt; +#define MULTIBOOT_TAG_TYPE_APM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 10<br>
&gt; +#define MULTIBOOT_TAG_TYPE_EFI32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 11<br>
&gt; +#define MULTIBOOT_TAG_TYPE_EFI64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 12<br>
&gt; +#define MULTIBOOT_TAG_TYPE_SMBIOS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A013<br>
&gt; +#define MULTIBOOT_TAG_TYPE_ACPI_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
14<br>
&gt; +#define MULTIBOOT_TAG_TYPE_ACPI_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
15<br>
&gt; +#define MULTIBOOT_TAG_TYPE_NETWORK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
16<br>
&gt; +<br>
&gt; +#define MULTIBOOT_HEADER_TAG_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST=C2=A0 =C2=A0 1<br>
&gt; +#define MULTIBOOT_HEADER_TAG_ADDRESS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt; +#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 3<br>
&gt; +#define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 4<br>
&gt; +#define MULTIBOOT_HEADER_TAG_FRAMEBUFFER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 5<br>
&gt; +#define MULTIBOOT_HEADER_TAG_MODULE_ALIGN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06<br>
&gt; +<br>
&gt; +#define MULTIBOOT_ARCHITECTURE_I386=C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define MULTIBOOT_ARCHITECTURE_X86_64=C2=A0 =C2=A01<br>
&gt; +#define MULTIBOOT_ARCHITECTURE_MIPS32=C2=A0 =C2=A04<br>
&gt; +#define MULTIBOOT_HEADER_TAG_OPTIONAL=C2=A0 =C2=A01<br>
&gt; +<br>
&gt; +#define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED=C2=A0 =C2=A0 1<br>
&gt; +#define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED=C2=A0 2<br>
&gt; +<br>
&gt; +typedef unsigned char multiboot_uint8_t;<br>
&gt; +typedef unsigned short multiboot_uint16_t;<br>
&gt; +typedef unsigned int multiboot_uint32_t;<br>
&gt; +typedef unsigned long long multiboot_uint64_t;<br>
&gt; +<br>
&gt; +struct multiboot_header {<br>
&gt; +=C2=A0 =C2=A0 /* Must be MULTIBOOT_MAGIC - see above.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t magic;<br>
&gt; +=C2=A0 =C2=A0 /* ISA */<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t architecture;<br>
&gt; +=C2=A0 =C2=A0 /* Total header length.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t header_length;<br>
&gt; +=C2=A0 =C2=A0 /* The above fields plus this one must equal 0 mod 2^32=
. */<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t checksum;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_information_request {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t requests[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_address {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t header_addr;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t load_addr;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t load_end_addr;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t bss_end_addr;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_entry_address {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t entry_addr;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_console_flags {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t console_flags;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_framebuffer {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t width;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t height;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t depth;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_header_tag_module_align {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t width;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t height;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t depth;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_color {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t red;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t green;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t blue;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_mmap_entry {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint64_t addr;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint64_t len;<br>
&gt; +#define MULTIBOOT_MEMORY_AVAILABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
1<br>
&gt; +#define MULTIBOOT_MEMORY_RESERVED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A02<br>
&gt; +#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE=C2=A0 =C2=A03<br>
&gt; +#define MULTIBOOT_MEMORY_NVS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 4<br>
&gt; +#define MULTIBOOT_MEMORY_BADRAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t zero;<br>
&gt; +} __attribute__((packed));<br>
&gt; +<br>
&gt; +typedef struct multiboot_mmap_entry multiboot_memory_map_t;<br>
&gt; +<br>
&gt; +struct multiboot_tag {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_string {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 char string[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_module {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t mod_start;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t mod_end;<br>
&gt; +=C2=A0 =C2=A0 char cmdline[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_basic_meminfo {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t mem_lower;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t mem_upper;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_bootdev {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t biosdev;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t slice;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t part;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_mmap {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t entry_size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t entry_version;<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_mmap_entry entries[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_vbe_info_block {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t external_specification[512];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_vbe_mode_info_block {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t external_specification[256];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_vbe {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t vbe_mode;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t vbe_interface_seg;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t vbe_interface_off;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t vbe_interface_len;<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_vbe_info_block vbe_control_info;<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_vbe_mode_info_block vbe_mode_info;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_framebuffer_common {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint64_t framebuffer_addr;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t framebuffer_pitch;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t framebuffer_width;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t framebuffer_height;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t framebuffer_bpp;<br>
&gt; +#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED=C2=A0 0<br>
&gt; +#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB=C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT 2<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t framebuffer_type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t reserved;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_framebuffer {<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_tag_framebuffer_common common;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 union {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint16_t framebuf=
fer_palette_num_colors;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct multiboot_color fram=
ebuffer_palette[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_red_field_position;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_red_mask_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_green_field_position;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_green_mask_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_blue_field_position;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multiboot_uint8_t framebuff=
er_blue_mask_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_elf_sections {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t num;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t entsize;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t shndx;<br>
&gt; +=C2=A0 =C2=A0 char sections[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_apm {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t version;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t cseg;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t offset;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t cseg_16;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t dseg;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t flags;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t cseg_len;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t cseg_16_len;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint16_t dseg_len;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_efi32 {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t pointer;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_efi64 {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint64_t pointer;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_smbios {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t major;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t minor;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t reserved[6];<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t tables[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_old_acpi {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t rsdp[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_new_acpi {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t rsdp[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct multiboot_tag_network {<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint32_t size;<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint8_t dhcpack[0];<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 /* buffers holding kernel and boot info tags */<br>
&gt; +=C2=A0 =C2=A0 void *mb_buf;<br>
&gt; +=C2=A0 =C2=A0 void *mb_tags;<br>
&gt; +=C2=A0 =C2=A0 /* address in target */<br>
&gt; +=C2=A0 =C2=A0 hwaddr mb_buf_phys;<br>
&gt; +=C2=A0 =C2=A0 /* size of mb_buf in bytes */<br>
&gt; +=C2=A0 =C2=A0 unsigned mb_buf_size;<br>
&gt; +=C2=A0 =C2=A0 /* size of tags in bytes */<br>
&gt; +=C2=A0 =C2=A0 unsigned mb_tags_size;<br>
&gt; +} MultibootState;<br>
&gt; +<br>
&gt; +static void mb_add_cmdline(MultibootState *s, const char *cmdline)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int len =3D strlen(cmdline) + 1;<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_tag_string *tag;<br>
&gt; +=C2=A0 =C2=A0 unsigned new_size =3D s-&gt;mb_tags_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 new_size +=3D sizeof(struct multiboot_tag_string) + len=
;<br>
&gt; +=C2=A0 =C2=A0 new_size =3D (new_size + 7) &amp; ~7;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mb_tags =3D g_realloc(s-&gt;mb_tags, new_size);<b=
r>
&gt; +=C2=A0 =C2=A0 tag =3D (struct multiboot_tag_string *)(s-&gt;mb_tags +=
 s-&gt;mb_tags_size);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mb_tags_size =3D new_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;type =3D MULTIBOOT_TAG_TYPE_CMDLINE;<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;size =3D sizeof(struct multiboot_tag_string) + =
len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 strncpy((char *)tag-&gt;string, cmdline, len);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mb_add_basic_meminfo(MultibootState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mem_lower,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mem_upper)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct multiboot_tag_basic_meminfo *tag;<br>
&gt; +=C2=A0 =C2=A0 unsigned new_size =3D s-&gt;mb_tags_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 new_size +=3D sizeof(struct multiboot_tag_basic_meminfo=
);<br>
&gt; +=C2=A0 =C2=A0 new_size =3D (new_size + 7) &amp; ~7;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mb_tags =3D g_realloc(s-&gt;mb_tags, new_size);<b=
r>
&gt; +=C2=A0 =C2=A0 tag =3D (struct multiboot_tag_basic_meminfo *)(s-&gt;mb=
_tags + s-&gt;mb_tags_size);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mb_tags_size =3D new_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;type =3D MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;size =3D sizeof(struct multiboot_tag_basic_memi=
nfo);<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;mem_lower =3D mem_lower;<br>
&gt; +=C2=A0 =C2=A0 tag-&gt;mem_upper =3D mem_upper;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int load_multiboot2(X86MachineState *x86ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FWCfgState *fw_cfg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FILE *f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *kernel_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *initrd_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *kernel_cmdline,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 int kernel_file_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 uint8_t *header)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MultibootState mbs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t architecture =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t header_length =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t mh_entry_addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t mh_load_addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t mb_kernel_size;<br>
&gt; +=C2=A0 =C2=A0 int is_multiboot =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* The header is in the first 32k with alignment 8. */<=
br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; (i &lt; 32768 - 15) &amp;&amp; (i &lt; ke=
rnel_file_size - 15); i +=3D 8) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ldl_p(header + i) =3D=3D MULTIBOOT2_H=
EADER_MAGIC) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t checksum =3D ldl_p=
(header + i + 12);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 architecture =3D ldl_p(head=
er + i + 4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 header_length =3D ldl_p(hea=
der + i + 8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checksum +=3D MULTIBOOT2_HE=
ADER_MAGIC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checksum +=3D architecture;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checksum +=3D header_length=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!checksum) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_multiboot =
=3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!is_multiboot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (architecture) {<br>
&gt; +=C2=A0 =C2=A0 case MULTIBOOT_ARCHITECTURE_I386:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mb_debug(&quot;architecture i386\n&quot;)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BI=
T, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MULTIBOOT_ARCHITECTURE_X86_64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mb_debug(&quot;architecture x86_64\n&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BI=
T, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;multiboot2 architectur=
e must be i386 or x86_64.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;I believe we found a multiboot2 image!\n=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;mbs, 0, sizeof(mbs));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Add size field to multiboot info */<br>
&gt; +=C2=A0 =C2=A0 mbs.mb_tags =3D g_malloc(8);<br>
&gt; +=C2=A0 =C2=A0 mbs.mb_tags_size =3D 8;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Commandline support */<br>
&gt; +=C2=A0 =C2=A0 char kcmdline[strlen(kernel_filename) + strlen(kernel_c=
mdline) + 2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 snprintf(kcmdline, sizeof(kcmdline), &quot;%s %s&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_filename, kern=
el_cmdline);<br>
&gt; +=C2=A0 =C2=A0 mb_add_cmdline(&amp;mbs, kcmdline);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Basic memory info */<br>
&gt; +=C2=A0 =C2=A0 mb_add_basic_meminfo(&amp;mbs, 640, (x86ms-&gt;above_4g=
_mem_size / 1024) - 1024);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Load kernel */<br>
&gt; +=C2=A0 =C2=A0 /* FIXME: only elf support for now */<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t elf_entry;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t elf_low, elf_high;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int kernel_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(f);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((struct elf64_hdr *)header)-&gt;e_ma=
chine =3D=3D EM_X86_64) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mb_debug(&quot;64bit elf, I=
 hope you know what you are doing\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_size =3D load_elf(kernel_filename,=
 NULL, NULL, NULL, &amp;elf_entry,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;elf_low, &amp;elf_high, NULL=
, 0, I386_ELF_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kernel_size &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Error wh=
ile loading elf kernel&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mh_load_addr =3D elf_low;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mb_kernel_size =3D elf_high - elf_low;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mh_entry_addr =3D elf_entry;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mbs.mb_buf =3D g_malloc(mb_kernel_size);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D rom_copy(mbs.mb_buf, mh_load_add=
r, mb_kernel_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D mb_kernel_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Error wh=
ile fetching elf kernel from rom&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mb_debug(&quot;loading multiboot-elf kern=
el (0x%x bytes)&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; =
with entry 0x%zx\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mb_kern=
el_size, (size_t)mh_entry_addr);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Align to next page */<br>
&gt; +=C2=A0 =C2=A0 /* FIXME: honor align header tag */<br>
&gt; +=C2=A0 =C2=A0 mbs.mb_buf_size =3D TARGET_PAGE_ALIGN(mb_kernel_size);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* FIXME: load modules */<br>
&gt; +=C2=A0 =C2=A0 /* FIXME: add other tags */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* The multiboot2 bootrom will add the mmap and end tag=
s. */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Set size of multiboot infos */<br>
&gt; +=C2=A0 =C2=A0 multiboot_uint64_t *size =3D mbs.mb_tags;<br>
&gt; +=C2=A0 =C2=A0 *size =3D mbs.mb_tags_size;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Display infos */<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;kernel_entry =3D 0x%zx\n&quot;, (size_t)=
mh_entry_addr);<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;kernel_addr=C2=A0 =3D 0x%zx\n&quot;, (si=
ze_t)mh_load_addr);<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;kernel_size=C2=A0 =3D 0x%zx\n&quot;, (si=
ze_t)mbs.mb_buf_size);<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;initrd_addr=C2=A0 =3D 0x%zx\n&quot;, (si=
ze_t)MULTIBOOT_MEM);<br>
&gt; +=C2=A0 =C2=A0 mb_debug(&quot;initrd_size=C2=A0 =3D 0x%zx\n&quot;, (si=
ze_t)mbs.mb_tags_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Add extra space for dynamic tags */<br>
&gt; +=C2=A0 =C2=A0 mbs.mb_tags_size +=3D 4096;<br>
&gt; +=C2=A0 =C2=A0 mbs.mb_tags =3D g_realloc(mbs.mb_tags, mbs.mb_tags_size=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Pass variables to option rom */<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_ad=
dr);<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr=
);<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, mbs.mb_buf_s=
ize);<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mbs.mb_buf, mbs.mb_buf_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, MULTIBOOT_ME=
M);<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, mbs.mb_tags_=
size);<br>
&gt; +=C2=A0 =C2=A0 fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mbs.mb_tag=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mbs.mb_tags_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 option_rom[nb_option_roms].name =3D &quot;multiboot2.bi=
n&quot;;<br>
&gt; +=C2=A0 =C2=A0 option_rom[nb_option_roms].bootindex =3D 0;<br>
&gt; +=C2=A0 =C2=A0 nb_option_roms++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 1; /* yes, we are multiboot */<br>
&gt; +}<br>
&gt; diff --git a/hw/i386/multiboot2.h b/hw/i386/multiboot2.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..d98d4723c7<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/i386/multiboot2.h<br>
&gt; @@ -0,0 +1,16 @@<br>
&gt; +#ifndef QEMU_MULTIBOOT2_H<br>
&gt; +#define QEMU_MULTIBOOT2_H<br>
&gt; +<br>
&gt; +#include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt; +#include &quot;hw/i386/x86.h&quot;<br>
&gt; +<br>
&gt; +int load_multiboot2(X86MachineState *x86ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FWCfgState *fw_cfg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 FILE *f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *kernel_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *initrd_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *kernel_cmdline,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 int kernel_file_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 uint8_t *header);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/hw/i386/x86.c b/hw/i386/x86.c<br>
&gt; index 2b6291ad8d..f40f0ad8ec 100644<br>
&gt; --- a/hw/i386/x86.c<br>
&gt; +++ b/hw/i386/x86.c<br>
&gt; @@ -53,6 +53,7 @@<br>
&gt;=C2=A0 #include &quot;hw/nmi.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 #include &quot;multiboot.h&quot;<br>
&gt; +#include &quot;multiboot2.h&quot;<br>
&gt;=C2=A0 #include &quot;elf.h&quot;<br>
&gt;=C2=A0 #include &quot;standard-headers/asm-x86/bootparam.h&quot;<br>
&gt;=C2=A0 #include CONFIG_DEVICES<br>
&gt; @@ -845,6 +846,13 @@ void x86_load_linux(X86MachineState *x86ms,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_cmdline, kernel_size, header)) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check multiboot2 kernel.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (load_multiboot2(x86ms, fw_cfg, f, ker=
nel_filename, initrd_filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_cmdline, kernel_size, header)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check if the file is an unco=
mpressed kernel file (ELF) and load it,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* saving the PVH entry point u=
sed by the x86/HVM direct boot ABI.<br>
&gt; diff --git a/include/standard-headers/linux/qemu_fw_cfg.h b/include/st=
andard-headers/linux/qemu_fw_cfg.h<br>
&gt; index cb93f6678d..f9b877e14d 100644<br>
&gt; --- a/include/standard-headers/linux/qemu_fw_cfg.h<br>
&gt; +++ b/include/standard-headers/linux/qemu_fw_cfg.h<br>
&gt; @@ -37,6 +37,8 @@<br>
&gt;=C2=A0 #define FW_CFG_FILE_FIRST=C2=A0 =C2=A0 0x20<br>
&gt;=C2=A0 #define FW_CFG_FILE_SLOTS_MIN=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br=
>
&gt;=C2=A0 <br>
&gt; +#define FW_CFG_KERNEL_64BIT=C2=A0 0x21<br>
&gt; +<br>
&gt;=C2=A0 #define FW_CFG_WRITE_CHANNEL 0x4000<br>
&gt;=C2=A0 #define FW_CFG_ARCH_LOCAL=C2=A0 =C2=A0 0x8000<br>
&gt;=C2=A0 #define FW_CFG_ENTRY_MASK=C2=A0 =C2=A0 (~(FW_CFG_WRITE_CHANNEL |=
 FW_CFG_ARCH_LOCAL))<br>
&gt; diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile<b=
r>
&gt; index 30d07026c7..21094232e0 100644<br>
&gt; --- a/pc-bios/optionrom/Makefile<br>
&gt; +++ b/pc-bios/optionrom/Makefile<br>
&gt; @@ -2,7 +2,7 @@ include config.mak<br>
&gt;=C2=A0 SRC_DIR :=3D $(TOPSRC_DIR)/pc-bios/optionrom<br>
&gt;=C2=A0 VPATH =3D $(SRC_DIR)<br>
&gt;=C2=A0 <br>
&gt; -all: multiboot.bin multiboot_dma.bin linuxboot.bin linuxboot_dma.bin =
kvmvapic.bin pvh.bin<br>
&gt; +all: multiboot.bin multiboot_dma.bin multiboot2.bin linuxboot.bin lin=
uxboot_dma.bin kvmvapic.bin pvh.bin<br>
&gt;=C2=A0 # Dummy command so that make thinks it has done something<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@true<br>
&gt;=C2=A0 <br>
&gt; diff --git a/pc-bios/optionrom/multiboot2.S b/pc-bios/optionrom/multib=
oot2.S<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a27c2a1f3c<br>
&gt; --- /dev/null<br>
&gt; +++ b/pc-bios/optionrom/multiboot2.S<br>
&gt; @@ -0,0 +1,324 @@<br>
&gt; +/*<br>
&gt; + * Multiboot2 Option ROM<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program; if not, see &lt;<a href=3D"http://www.gnu=
.org/licenses/" rel=3D"noreferrer noreferrer" target=3D"_blank">http://www.=
gnu.org/licenses/</a>&gt;.<br>
&gt; + *<br>
&gt; + * Original Multiboot Option ROM:<br>
&gt; + * Copyright Novell Inc, 2009<br>
&gt; + *=C2=A0 =C2=A0Authors: Alexander Graf &lt;<a href=3D"mailto:agraf@su=
se.de" target=3D"_blank" rel=3D"noreferrer">agraf@suse.de</a>&gt;<br>
&gt; + *<br>
&gt; + * Adaption to Multiboot2 specs:<br>
&gt; + * Copyright Goswin von Brederlow, 2011<br>
&gt; + *=C2=A0 =C2=A0Authors: Goswin von Brederlow &lt;<a href=3D"mailto:go=
swin-v-b@web.de" target=3D"_blank" rel=3D"noreferrer">goswin-v-b@web.de</a>=
&gt;<br>
&gt; + *<br>
&gt; + * Cleaned up and merged by:<br>
&gt; + * Copyright Jens Nyberg, 2024<br>
&gt; + *=C2=A0 =C2=A0Authors: Jens Nyberg &lt;<a href=3D"mailto:jens.nyberg=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">jens.nyberg@gmail.com</a>&=
gt;<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;optionrom.h&quot;<br>
&gt; +<br>
&gt; +#define BOOT_ROM_PRODUCT &quot;multiboot2 loader&quot;<br>
&gt; +<br>
&gt; +#define MULTIBOOT_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x36d76289<br>
&gt; +<br>
&gt; +#define GS_PROT_JUMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define GS_GDT_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +<br>
&gt; +/* Memory layout (page tables only for 64 bit):<br>
&gt; + * 0x2000 L4 page table<br>
&gt; + * 0x3000 L3 page table<br>
&gt; + * 0x4000 L2 page table<br>
&gt; + * ...<br>
&gt; + * 0x7000 L2 page table<br>
&gt; + * 0x8000 bootinfo tags<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define PGTABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x2000<br>
&gt; +<br>
&gt; +BOOT_ROM_START<br>
&gt; +<br>
&gt; +run_multiboot:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cli<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cld<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%cs, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0shl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x4, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %ebp /* used below to jump to 64bit */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* set up a long jump descriptor that is PC relat=
ive */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* move stack memory to %gs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%ss, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0shl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x4, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%esp, %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0add=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%ebx, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sub=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x20, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sub=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x30, %esp<br>
&gt; +=C2=A0 =C2=A0 =C2=A0shr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x4, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%cx, %gs<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* now push the indirect jump decriptor there */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(prot_jump), %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0add=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %eb=
x, %gs:GS_PROT_JUMP<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$8, %bx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %bx=
, %gs:GS_PROT_JUMP + 4<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* fix the gdt descriptor to be PC relative */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0movw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gd=
t_desc), %bx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %bx=
, %gs:GS_GDT_DESC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gd=
t_desc+2), %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0add=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %eb=
x, %gs:GS_GDT_DESC + 2<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0xor=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %es<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Read the bootinfo struct into RAM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw_blob(FW_CFG_INITRD)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* FS =3D bootinfo_struct */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_I=
NITRD_ADDR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0shr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$4, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%ax, %fs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%ax, %es=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for int 0x15 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* %fs:%edi =3D bootinfo size =3D offset of mmap =
tag */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %fs=
:0, %edi<br>
&gt; +<br>
&gt; +#define MULTIBOOT_TAG_TYPE_MMAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Create mmap tag */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $6,=
 %fs:0(%edi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* type mmap */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $24=
, %fs:8(%edi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* entry_size */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0,=
 %fs:12(%edi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* entry_version */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Initialize multiboot mmap structs using int 0x=
15(e820) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0xor=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%ebx, %ebx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* mmap starts at byte 16 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $16=
, %edi<br>
&gt; +<br>
&gt; +mmap_loop:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* entry size (mmap struct) &amp; max buffer size=
 (int15) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $20=
, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* e820 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0x=
0000e820, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* &#39;SMAP&#39; magic */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0x=
534d4150, %edx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$0x15<br>
&gt; +<br>
&gt; +mmap_check_entry:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* last entry? then we&#39;re done */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmap_done<br>
&gt; +=C2=A0 =C2=A0 =C2=A0and=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%bx, %bx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jz=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmap_done<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* valid entry, so let&#39;s loop on */<br>
&gt; +<br>
&gt; +mmap_next_entry:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Advance %edi by sizeof(struct multiboot_mmap_e=
ntry) =3D 24 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $24=
, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jmp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mmap_loop<br>
&gt; +<br>
&gt; +mmap_done:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $24=
, %edi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* advance pas=
t entry */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Create end tag */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0,=
 %fs:0(%edi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* type */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $8,=
 %fs:4(%edi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* size */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8(%=
edi), %ebx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* size of all tags */<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* set mmap tag size */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%edi, %eax=C2=A0 =C2=A0 =C2=A0 /* save offset after mmap */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%fs:0, %edi=C2=A0 =C2=A0 =C2=A0/* offset of mmap tag */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sub=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%edi, %eax=C2=A0 =C2=A0 =C2=A0 /* size of mmap tag */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %fs:4(%edi) /* size */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Store size of all tags */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %eb=
x, %fs:0<br>
&gt; +<br>
&gt; +real_to_prot:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Load the GDT before going into protected mode =
*/<br>
&gt; +lgdt:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data32 lgdt=C2=A0 =C2=A0 =C2=A0%gs:GS_GDT_DESC<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* get us to protected mode now */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $1,=
 %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %cr0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* the LJMP sets CS for us and gets us to 32-bit =
*/<br>
&gt; +ljmp32:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data32 ljmp=C2=A0 =C2=A0 =C2=A0*%gs:GS_PROT_JUMP<=
br>
&gt; +<br>
&gt; +prot_mode:<br>
&gt; +.code32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* initialize all other segments */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0x=
10, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %ss<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %ds<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %es<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %fs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %gs<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Read the kernel and modules into RAM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw_blob(FW_CFG_KERNEL)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 32bit or 64bit mode? */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_K=
ERNEL_64BIT<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmpl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $0,=
 %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jne=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ljmp64<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Jump off to the kernel */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_K=
ERNEL_ENTRY<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mov=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0%eax, %ecx<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EBX contains a pointer to the bootinfo struct =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_I=
NITRD_ADDR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %ebx<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EAX has to contain the magic */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $MU=
LTIBOOT_MAGIC, %eax<br>
&gt; +ljmp2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Jump to kernel in 32bit mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jmp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*%ecx<br>
&gt; +<br>
&gt; +/******************************************************************/<=
br>
&gt; +/* Set up 64bit mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +/******************************************************************/<=
br>
&gt; +ljmp64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Enable PAE */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %cr4, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0btsl=C2=A0 =C2=A0 $5, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, %cr4<br>
&gt; +<br>
&gt; + /*<br>
&gt; +=C2=A0 * Build early 4G boot pagetable<br>
&gt; +=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Initialize Page tables to 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 PGTABLE, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0xorl=C2=A0 =C2=A0 %eax, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $((4096*6)/4), %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rep=C2=A0 =C2=A0 =C2=A0stosl<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Build Level 4 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 PGTABLE + 0, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 0x1007 (%edi), %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, 0(%edi)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Build Level 3 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 PGTABLE + 0x1000, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 0x1007(%edi), %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $4, %ecx<br>
&gt; +1:=C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, 0x00(%edi)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 $0x00001000, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 $8, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0decl=C2=A0 =C2=A0 %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jnz=C2=A0 =C2=A0 =C2=A01b<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Build Level 2 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 PGTABLE + 0x2000, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $0x00000183, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $2048, %ecx<br>
&gt; +1:=C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, 0(%edi)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 $0x00200000, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 $8, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0decl=C2=A0 =C2=A0 %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jnz=C2=A0 =C2=A0 =C2=A01b<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Load Level 4 page table (page 128) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 PGTABLE, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, %cr3<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Enable long mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $0xc0000080, %ecx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rdmsr<br>
&gt; +=C2=A0 =C2=A0 =C2=A0btsl=C2=A0 =C2=A0 $8, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wrmsr<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* enable paging to activate long mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %cr0, %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0btsl=C2=A0 =C2=A0 $1, %eax=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* protected mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0btsl=C2=A0 =C2=A0 $31, %eax=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* paging */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %eax, %cr0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Jump off to the kernel */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_K=
ERNEL_ENTRY<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %ebx<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* pointer to the bootinfo struct */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0read_fw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FW_CFG_I=
NITRD_ADDR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %ea=
x, %ecx<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* jump to 64bit mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pushl=C2=A0 =C2=A0$0x28<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leal=C2=A0 =C2=A0 startup_64(%ebp), %eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pushl=C2=A0 =C2=A0%eax<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lret<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.code64<br>
&gt; +startup_64:<br>
&gt; +_startup_64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EDI has to contain the magic, ESI the boot inf=
o */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %ebx, %eax=C2=A0 =C2=A0 =C2=A0 =
/* kernel entry address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 %ecx, %esi=C2=A0 =C2=A0 =C2=A0 =
/* pointer to boot info */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 $MULTIBOOT_MAGIC, %edi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jmp=C2=A0 =C2=A0 =C2=A0*%rax<br>
&gt; +<br>
&gt; +color:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* collor me silly */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0addl=C2=A0 =C2=A0 $0x1,0xb8000<br>
&gt; +=C2=A0 =C2=A0 =C2=A0jmp=C2=A0 =C2=A0 =C2=A0color<br>
&gt; +<br>
&gt; +/******************************************************************/<=
br>
&gt; +<br>
&gt; +<br>
&gt; +/* Variables */<br>
&gt; +.align 4, 0<br>
&gt; +prot_jump:=C2=A0 =C2=A0.long prot_mode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.short 8<br>
&gt; +<br>
&gt; +.align 4, 0<br>
&gt; +gdt:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x00: null segment */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x08: code segment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* base=3D0, limit=3D0xfffff, type=3D32bit code e=
xec/read, DPL=3D0, 4k */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, =
0xcf, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x10: data segment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* base=3D0, limit=3D0xfffff, type=3D32bit data r=
ead/write, DPL=3D0, 4k */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, =
0xcf, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x18: code segment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* base=3D0, limit=3D0x0ffff, type=3D16bit code e=
xec/read/conf, DPL=3D0, 1b */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, =
0x00, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x20: data segment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* base=3D0, limit=3D0x0ffff, type=3D16bit data r=
ead/write, DPL=3D0, 1b */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, =
0x00, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x28: code segment */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* base=3D0, limit=3D0xfffff, type=3D64bit code e=
xec/read, DPL=3D0, 4k */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, =
0xaf, 0x00<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x30: ts descriptor */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x89, =
0x80, 0x00<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 0x38: ts continued */<br>
&gt; +.byte=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00, 0x00<br>
&gt; +<br>
&gt; +gdt_desc:<br>
&gt; +.short=C2=A0 =C2=A0 =C2=A0 =C2=A0(8 * 8) - 1<br>
&gt; +.long=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdt<br>
&gt; +<br>
&gt; +BOOT_ROM_END<br>
&gt; diff --git a/pc-bios/optionrom/optionrom.h b/pc-bios/optionrom/optionr=
om.h<br>
&gt; index 7bcdf0eeb2..6f758c58be 100644<br>
&gt; --- a/pc-bios/optionrom/optionrom.h<br>
&gt; +++ b/pc-bios/optionrom/optionrom.h<br>
&gt; @@ -33,6 +33,7 @@<br>
&gt;=C2=A0 #define FW_CFG_SETUP_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A00x16<br>
&gt;=C2=A0 #define FW_CFG_SETUP_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x17<br>
&gt;=C2=A0 #define FW_CFG_SETUP_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A00x18<br>
&gt; +#define FW_CFG_KERNEL_64BIT=C2=A0 =C2=A0 =C2=A00x21<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define BIOS_CFG_IOPORT_CFG=C2=A0 =C2=A0 0x510<br>
&gt;=C2=A0 #define BIOS_CFG_IOPORT_DATA=C2=A0 =C2=A00x511<br>
&gt; -- <br>
&gt; 2.43.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000b9dedf0610b94365--

