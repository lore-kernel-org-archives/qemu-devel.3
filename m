Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD1FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNi7-0006p3-Bk; Tue, 06 Feb 2024 10:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXNi5-0006oD-Ks
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXNi2-00025a-6a
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707234605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R3ReFXiCIdvBamqAj0aVeUk3USItY7Y+8AjsKLQNz7I=;
 b=AHWeHQPUrCXWzrSa6Hl+CM20DGVT25y9bs60zvL776FKXU3ho24zmrRVJEYXA6BBFNd9PR
 vVsX+xtneKWz7Mw+sjgo9FB29CAVz1md6eP8havUIn7Ktj08Ju65m+cQGGKdc64yb/hMU1
 IH/kGMIviZt7L6R2E7vQpRE2Vruz86k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-dHUvnTs2OXamBgzY1D7UPA-1; Tue,
 06 Feb 2024 10:50:01 -0500
X-MC-Unique: dHUvnTs2OXamBgzY1D7UPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DEAF3813F2C;
 Tue,  6 Feb 2024 15:50:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E82522026D06;
 Tue,  6 Feb 2024 15:49:59 +0000 (UTC)
Date: Tue, 6 Feb 2024 15:49:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jens Nyberg <jens.nyberg@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [RFC] hw/i386/multiboot2: add multiboot2 support
Message-ID: <ZcJVJYj-Ovcs_xL0@redhat.com>
References: <20240206135231.234184-1-jens.nyberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206135231.234184-1-jens.nyberg@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 06, 2024 at 02:52:31PM +0100, Jens Nyberg wrote:
> This is the first very rough version of what is supposed to be support for
> multiboot2. This is a continuation of work that was started years ago but
> never saw fruition for reasons unknown.

Since you've picked up work orignially started by someone else,
there's a little complexity wrt the Signed-off-by.

As a general rule we would expect to see a 'Signed-off-by' by
the person whose work you continued. Unfortunately it looks
like they didn't add their S-o-B when attaching their proposed
patch to

https://bugs.debian.org/cgi-bin/bugreport.cgi?att=2;bug=621529;filename=multiboot2.patch;msg=15

Did you try to contact Goswin von Brederlow <goswin-v-b@web.de>
to see if their email addr is still active, and ask if they're
willing to add their Signed-off-by, for their part in developing
this patch ?

It isn't a 100% blocker to not have their S-o-B, it just means
you have to be comfortable with the fact that you're effectively
signing off work done by them. The fact that their added this
patch to the Debian bug tracker with the explicit intention it
get incorporated into QEMU is positive.

It is still worth emailing them to see if we can get the easy
answer directly.

> This is submitted as an RFC only for now. It would be nice if someone would
> be willing to guide me into further improving this code
> 
> Any ideas on how to properly test this would also be nice!
> 
> Signed-off-by: Jens Nyberg <jens.nyberg@gmail.com>
> ---
>  hw/i386/meson.build                          |   1 +
>  hw/i386/multiboot2.c                         | 552 +++++++++++++++++++
>  hw/i386/multiboot2.h                         |  16 +
>  hw/i386/x86.c                                |   8 +
>  include/standard-headers/linux/qemu_fw_cfg.h |   2 +
>  pc-bios/optionrom/Makefile                   |   2 +-
>  pc-bios/optionrom/multiboot2.S               | 324 +++++++++++
>  pc-bios/optionrom/optionrom.h                |   1 +
>  8 files changed, 905 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/multiboot2.c
>  create mode 100644 hw/i386/multiboot2.h
>  create mode 100644 pc-bios/optionrom/multiboot2.S
> 
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 369c6bf823..3ccf9d7398 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -4,6 +4,7 @@ i386_ss.add(files(
>    'kvmvapic.c',
>    'e820_memory_layout.c',
>    'multiboot.c',
> +  'multiboot2.c',
>    'x86.c',
>  ))
>  
> diff --git a/hw/i386/multiboot2.c b/hw/i386/multiboot2.c
> new file mode 100644
> index 0000000000..6d1c07cc40
> --- /dev/null
> +++ b/hw/i386/multiboot2.c
> @@ -0,0 +1,552 @@
> +/*
> + * QEMU PC System Emulator
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/option.h"
> +#include "cpu.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "multiboot2.h"
> +#include "hw/loader.h"
> +#include "elf.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +/* Show multiboot debug output */
> +/* #define DEBUG_MULTIBOOT2 */
> +
> +#ifdef DEBUG_MULTIBOOT2
> +#define mb_debug(a...) error_report(a)
> +#else
> +#define mb_debug(a...)
> +#endif
> +
> +#define MULTIBOOT_MEM 0x8000
> +
> +#if MULTIBOOT_MEM > 0xf0000
> +#error multiboot struct needs to fit in 16 bit real mode
> +#endif
> +
> +/* How many bytes from the start of the file we search for the header.  */
> +#define MULTIBOOT_SEARCH                32768
> +#define MULTIBOOT_HEADER_ALIGN          8
> +
> +/* The magic field should contain this.  */
> +#define MULTIBOOT2_HEADER_MAGIC         0xe85250d6
> +
> +/* This should be in %eax.  */
> +#define MULTIBOOT2_BOOTLOADER_MAGIC     0x36d76289
> +
> +/* Alignment of multiboot modules.  */
> +#define MULTIBOOT_MOD_ALIGN             0x00001000
> +
> +/* Alignment of the multiboot info structure.  */
> +#define MULTIBOOT_INFO_ALIGN            0x00000008
> +
> +/* Flags set in the 'flags' member of the multiboot header.  */
> +
> +#define MULTIBOOT_TAG_ALIGN                 8
> +#define MULTIBOOT_TAG_TYPE_END              0
> +#define MULTIBOOT_TAG_TYPE_CMDLINE          1
> +#define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME 2
> +#define MULTIBOOT_TAG_TYPE_MODULE           3
> +#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO    4
> +#define MULTIBOOT_TAG_TYPE_BOOTDEV          5
> +#define MULTIBOOT_TAG_TYPE_MMAP             6
> +#define MULTIBOOT_TAG_TYPE_VBE              7
> +#define MULTIBOOT_TAG_TYPE_FRAMEBUFFER      8
> +#define MULTIBOOT_TAG_TYPE_ELF_SECTIONS     9
> +#define MULTIBOOT_TAG_TYPE_APM              10
> +#define MULTIBOOT_TAG_TYPE_EFI32            11
> +#define MULTIBOOT_TAG_TYPE_EFI64            12
> +#define MULTIBOOT_TAG_TYPE_SMBIOS           13
> +#define MULTIBOOT_TAG_TYPE_ACPI_OLD         14
> +#define MULTIBOOT_TAG_TYPE_ACPI_NEW         15
> +#define MULTIBOOT_TAG_TYPE_NETWORK          16
> +
> +#define MULTIBOOT_HEADER_TAG_END                    0
> +#define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST    1
> +#define MULTIBOOT_HEADER_TAG_ADDRESS                2
> +#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS          3
> +#define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS          4
> +#define MULTIBOOT_HEADER_TAG_FRAMEBUFFER            5
> +#define MULTIBOOT_HEADER_TAG_MODULE_ALIGN           6
> +
> +#define MULTIBOOT_ARCHITECTURE_I386     0
> +#define MULTIBOOT_ARCHITECTURE_X86_64   1
> +#define MULTIBOOT_ARCHITECTURE_MIPS32   4
> +#define MULTIBOOT_HEADER_TAG_OPTIONAL   1
> +
> +#define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED    1
> +#define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED  2
> +
> +typedef unsigned char multiboot_uint8_t;
> +typedef unsigned short multiboot_uint16_t;
> +typedef unsigned int multiboot_uint32_t;
> +typedef unsigned long long multiboot_uint64_t;
> +
> +struct multiboot_header {
> +    /* Must be MULTIBOOT_MAGIC - see above.  */
> +    multiboot_uint32_t magic;
> +    /* ISA */
> +    multiboot_uint32_t architecture;
> +    /* Total header length.  */
> +    multiboot_uint32_t header_length;
> +    /* The above fields plus this one must equal 0 mod 2^32. */
> +    multiboot_uint32_t checksum;
> +};
> +
> +struct multiboot_header_tag {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +};
> +
> +struct multiboot_header_tag_information_request {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t requests[0];
> +};
> +
> +struct multiboot_header_tag_address {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t header_addr;
> +    multiboot_uint32_t load_addr;
> +    multiboot_uint32_t load_end_addr;
> +    multiboot_uint32_t bss_end_addr;
> +};
> +
> +struct multiboot_header_tag_entry_address {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t entry_addr;
> +};
> +
> +struct multiboot_header_tag_console_flags {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t console_flags;
> +};
> +
> +struct multiboot_header_tag_framebuffer {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t width;
> +    multiboot_uint32_t height;
> +    multiboot_uint32_t depth;
> +};
> +
> +struct multiboot_header_tag_module_align {
> +    multiboot_uint16_t type;
> +    multiboot_uint16_t flags;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t width;
> +    multiboot_uint32_t height;
> +    multiboot_uint32_t depth;
> +};
> +
> +struct multiboot_color {
> +    multiboot_uint8_t red;
> +    multiboot_uint8_t green;
> +    multiboot_uint8_t blue;
> +};
> +
> +struct multiboot_mmap_entry {
> +    multiboot_uint64_t addr;
> +    multiboot_uint64_t len;
> +#define MULTIBOOT_MEMORY_AVAILABLE          1
> +#define MULTIBOOT_MEMORY_RESERVED           2
> +#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE   3
> +#define MULTIBOOT_MEMORY_NVS                4
> +#define MULTIBOOT_MEMORY_BADRAM             5
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t zero;
> +} __attribute__((packed));
> +
> +typedef struct multiboot_mmap_entry multiboot_memory_map_t;
> +
> +struct multiboot_tag {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +};
> +
> +struct multiboot_tag_string {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    char string[0];
> +};
> +
> +struct multiboot_tag_module {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t mod_start;
> +    multiboot_uint32_t mod_end;
> +    char cmdline[0];
> +};
> +
> +struct multiboot_tag_basic_meminfo {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t mem_lower;
> +    multiboot_uint32_t mem_upper;
> +};
> +
> +struct multiboot_tag_bootdev {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t biosdev;
> +    multiboot_uint32_t slice;
> +    multiboot_uint32_t part;
> +};
> +
> +struct multiboot_tag_mmap {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t entry_size;
> +    multiboot_uint32_t entry_version;
> +    struct multiboot_mmap_entry entries[0];
> +};
> +
> +struct multiboot_vbe_info_block {
> +    multiboot_uint8_t external_specification[512];
> +};
> +
> +struct multiboot_vbe_mode_info_block {
> +    multiboot_uint8_t external_specification[256];
> +};
> +
> +struct multiboot_tag_vbe {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint16_t vbe_mode;
> +    multiboot_uint16_t vbe_interface_seg;
> +    multiboot_uint16_t vbe_interface_off;
> +    multiboot_uint16_t vbe_interface_len;
> +    struct multiboot_vbe_info_block vbe_control_info;
> +    struct multiboot_vbe_mode_info_block vbe_mode_info;
> +};
> +
> +struct multiboot_tag_framebuffer_common {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint64_t framebuffer_addr;
> +    multiboot_uint32_t framebuffer_pitch;
> +    multiboot_uint32_t framebuffer_width;
> +    multiboot_uint32_t framebuffer_height;
> +    multiboot_uint8_t framebuffer_bpp;
> +#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED  0
> +#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB      1
> +#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT 2
> +    multiboot_uint8_t framebuffer_type;
> +    multiboot_uint16_t reserved;
> +};
> +
> +struct multiboot_tag_framebuffer {
> +    struct multiboot_tag_framebuffer_common common;
> +
> +    union {
> +        struct {
> +            multiboot_uint16_t framebuffer_palette_num_colors;
> +            struct multiboot_color framebuffer_palette[0];
> +        };
> +        struct {
> +            multiboot_uint8_t framebuffer_red_field_position;
> +            multiboot_uint8_t framebuffer_red_mask_size;
> +            multiboot_uint8_t framebuffer_green_field_position;
> +            multiboot_uint8_t framebuffer_green_mask_size;
> +            multiboot_uint8_t framebuffer_blue_field_position;
> +            multiboot_uint8_t framebuffer_blue_mask_size;
> +        };
> +    };
> +};
> +
> +struct multiboot_tag_elf_sections {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t num;
> +    multiboot_uint32_t entsize;
> +    multiboot_uint32_t shndx;
> +    char sections[0];
> +};
> +
> +struct multiboot_tag_apm {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint16_t version;
> +    multiboot_uint16_t cseg;
> +    multiboot_uint32_t offset;
> +    multiboot_uint16_t cseg_16;
> +    multiboot_uint16_t dseg;
> +    multiboot_uint16_t flags;
> +    multiboot_uint16_t cseg_len;
> +    multiboot_uint16_t cseg_16_len;
> +    multiboot_uint16_t dseg_len;
> +};
> +
> +struct multiboot_tag_efi32 {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint32_t pointer;
> +};
> +
> +struct multiboot_tag_efi64 {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint64_t pointer;
> +};
> +
> +struct multiboot_tag_smbios {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint8_t major;
> +    multiboot_uint8_t minor;
> +    multiboot_uint8_t reserved[6];
> +    multiboot_uint8_t tables[0];
> +};
> +
> +struct multiboot_tag_old_acpi {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint8_t rsdp[0];
> +};
> +
> +struct multiboot_tag_new_acpi {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint8_t rsdp[0];
> +};
> +
> +struct multiboot_tag_network {
> +    multiboot_uint32_t type;
> +    multiboot_uint32_t size;
> +    multiboot_uint8_t dhcpack[0];
> +};
> +
> +typedef struct {
> +    /* buffers holding kernel and boot info tags */
> +    void *mb_buf;
> +    void *mb_tags;
> +    /* address in target */
> +    hwaddr mb_buf_phys;
> +    /* size of mb_buf in bytes */
> +    unsigned mb_buf_size;
> +    /* size of tags in bytes */
> +    unsigned mb_tags_size;
> +} MultibootState;
> +
> +static void mb_add_cmdline(MultibootState *s, const char *cmdline)
> +{
> +    int len = strlen(cmdline) + 1;
> +    struct multiboot_tag_string *tag;
> +    unsigned new_size = s->mb_tags_size;
> +
> +    new_size += sizeof(struct multiboot_tag_string) + len;
> +    new_size = (new_size + 7) & ~7;
> +
> +    s->mb_tags = g_realloc(s->mb_tags, new_size);
> +    tag = (struct multiboot_tag_string *)(s->mb_tags + s->mb_tags_size);
> +    s->mb_tags_size = new_size;
> +
> +    tag->type = MULTIBOOT_TAG_TYPE_CMDLINE;
> +    tag->size = sizeof(struct multiboot_tag_string) + len;
> +
> +    strncpy((char *)tag->string, cmdline, len);
> +}
> +
> +static void mb_add_basic_meminfo(MultibootState *s,
> +                                 uint32_t mem_lower,
> +                                 uint32_t mem_upper)
> +{
> +    struct multiboot_tag_basic_meminfo *tag;
> +    unsigned new_size = s->mb_tags_size;
> +
> +    new_size += sizeof(struct multiboot_tag_basic_meminfo);
> +    new_size = (new_size + 7) & ~7;
> +
> +    s->mb_tags = g_realloc(s->mb_tags, new_size);
> +    tag = (struct multiboot_tag_basic_meminfo *)(s->mb_tags + s->mb_tags_size);
> +    s->mb_tags_size = new_size;
> +
> +    tag->type = MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
> +    tag->size = sizeof(struct multiboot_tag_basic_meminfo);
> +    tag->mem_lower = mem_lower;
> +    tag->mem_upper = mem_upper;
> +}
> +
> +int load_multiboot2(X86MachineState *x86ms,
> +                    FWCfgState *fw_cfg,
> +                    FILE *f,
> +                    const char *kernel_filename,
> +                    const char *initrd_filename,
> +                    const char *kernel_cmdline,
> +                    int kernel_file_size,
> +                    uint8_t *header)
> +{
> +    MultibootState mbs;
> +    uint32_t architecture = 0;
> +    uint32_t header_length = 0;
> +    uint32_t mh_entry_addr;
> +    uint32_t mh_load_addr;
> +    uint32_t mb_kernel_size;
> +    int is_multiboot = 0;
> +    int i;
> +
> +    /* The header is in the first 32k with alignment 8. */
> +    for (i = 0; (i < 32768 - 15) && (i < kernel_file_size - 15); i += 8) {
> +        if (ldl_p(header + i) == MULTIBOOT2_HEADER_MAGIC) {
> +            uint32_t checksum = ldl_p(header + i + 12);
> +            architecture = ldl_p(header + i + 4);
> +            header_length = ldl_p(header + i + 8);
> +            checksum += MULTIBOOT2_HEADER_MAGIC;
> +            checksum += architecture;
> +            checksum += header_length;
> +
> +            if (!checksum) {
> +                is_multiboot = 1;
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (!is_multiboot) {
> +        return 0;
> +    }
> +
> +    switch (architecture) {
> +    case MULTIBOOT_ARCHITECTURE_I386:
> +        mb_debug("architecture i386\n");
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BIT, 0);
> +        break;
> +    case MULTIBOOT_ARCHITECTURE_X86_64:
> +        mb_debug("architecture x86_64\n");
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_64BIT, 1);
> +        break;
> +    default:
> +        error_report("multiboot2 architecture must be i386 or x86_64.");
> +        exit(1);
> +    }
> +
> +    mb_debug("I believe we found a multiboot2 image!\n");
> +    memset(&mbs, 0, sizeof(mbs));
> +
> +    /* Add size field to multiboot info */
> +    mbs.mb_tags = g_malloc(8);
> +    mbs.mb_tags_size = 8;
> +
> +    /* Commandline support */
> +    char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + 2];
> +
> +    snprintf(kcmdline, sizeof(kcmdline), "%s %s",
> +             kernel_filename, kernel_cmdline);
> +    mb_add_cmdline(&mbs, kcmdline);
> +
> +    /* Basic memory info */
> +    mb_add_basic_meminfo(&mbs, 640, (x86ms->above_4g_mem_size / 1024) - 1024);
> +
> +    /* Load kernel */
> +    /* FIXME: only elf support for now */
> +    {
> +        uint64_t elf_entry;
> +        uint64_t elf_low, elf_high;
> +        int kernel_size;
> +        int size;
> +
> +        fclose(f);
> +
> +        if (((struct elf64_hdr *)header)->e_machine == EM_X86_64) {
> +            mb_debug("64bit elf, I hope you know what you are doing\n");
> +        }
> +
> +        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
> +                               &elf_low, &elf_high, NULL, 0, I386_ELF_MACHINE,
> +                               0, 0);
> +
> +        if (kernel_size < 0) {
> +            error_report("Error while loading elf kernel");
> +            exit(1);
> +        }
> +
> +        mh_load_addr = elf_low;
> +        mb_kernel_size = elf_high - elf_low;
> +        mh_entry_addr = elf_entry;
> +        mbs.mb_buf = g_malloc(mb_kernel_size);
> +        size = rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size);
> +
> +        if (size != mb_kernel_size) {
> +            error_report("Error while fetching elf kernel from rom");
> +            exit(1);
> +        }
> +
> +        mb_debug("loading multiboot-elf kernel (0x%x bytes)"
> +                 " with entry 0x%zx\n",
> +                 mb_kernel_size, (size_t)mh_entry_addr);
> +    }
> +
> +    /* Align to next page */
> +    /* FIXME: honor align header tag */
> +    mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_kernel_size);
> +
> +    /* FIXME: load modules */
> +    /* FIXME: add other tags */
> +
> +    /* The multiboot2 bootrom will add the mmap and end tags. */
> +
> +    /* Set size of multiboot infos */
> +    multiboot_uint64_t *size = mbs.mb_tags;
> +    *size = mbs.mb_tags_size;
> +
> +    /* Display infos */
> +    mb_debug("kernel_entry = 0x%zx\n", (size_t)mh_entry_addr);
> +    mb_debug("kernel_addr  = 0x%zx\n", (size_t)mh_load_addr);
> +    mb_debug("kernel_size  = 0x%zx\n", (size_t)mbs.mb_buf_size);
> +    mb_debug("initrd_addr  = 0x%zx\n", (size_t)MULTIBOOT_MEM);
> +    mb_debug("initrd_size  = 0x%zx\n", (size_t)mbs.mb_tags_size);
> +
> +    /* Add extra space for dynamic tags */
> +    mbs.mb_tags_size += 4096;
> +    mbs.mb_tags = g_realloc(mbs.mb_tags, mbs.mb_tags_size);
> +
> +    /* Pass variables to option rom */
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, mbs.mb_buf_size);
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA,
> +                     mbs.mb_buf, mbs.mb_buf_size);
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, MULTIBOOT_MEM);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, mbs.mb_tags_size);
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mbs.mb_tags,
> +                     mbs.mb_tags_size);
> +
> +    option_rom[nb_option_roms].name = "multiboot2.bin";
> +    option_rom[nb_option_roms].bootindex = 0;
> +    nb_option_roms++;
> +
> +    return 1; /* yes, we are multiboot */
> +}
> diff --git a/hw/i386/multiboot2.h b/hw/i386/multiboot2.h
> new file mode 100644
> index 0000000000..d98d4723c7
> --- /dev/null
> +++ b/hw/i386/multiboot2.h
> @@ -0,0 +1,16 @@
> +#ifndef QEMU_MULTIBOOT2_H
> +#define QEMU_MULTIBOOT2_H
> +
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/i386/x86.h"
> +
> +int load_multiboot2(X86MachineState *x86ms,
> +                    FWCfgState *fw_cfg,
> +                    FILE *f,
> +                    const char *kernel_filename,
> +                    const char *initrd_filename,
> +                    const char *kernel_cmdline,
> +                    int kernel_file_size,
> +                    uint8_t *header);
> +
> +#endif
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 2b6291ad8d..f40f0ad8ec 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -53,6 +53,7 @@
>  #include "hw/nmi.h"
>  #include "hw/loader.h"
>  #include "multiboot.h"
> +#include "multiboot2.h"
>  #include "elf.h"
>  #include "standard-headers/asm-x86/bootparam.h"
>  #include CONFIG_DEVICES
> @@ -845,6 +846,13 @@ void x86_load_linux(X86MachineState *x86ms,
>                             kernel_cmdline, kernel_size, header)) {
>              return;
>          }
> +        /*
> +         * Check multiboot2 kernel.
> +         */
> +        if (load_multiboot2(x86ms, fw_cfg, f, kernel_filename, initrd_filename,
> +                            kernel_cmdline, kernel_size, header)) {
> +            return;
> +        }
>          /*
>           * Check if the file is an uncompressed kernel file (ELF) and load it,
>           * saving the PVH entry point used by the x86/HVM direct boot ABI.
> diff --git a/include/standard-headers/linux/qemu_fw_cfg.h b/include/standard-headers/linux/qemu_fw_cfg.h
> index cb93f6678d..f9b877e14d 100644
> --- a/include/standard-headers/linux/qemu_fw_cfg.h
> +++ b/include/standard-headers/linux/qemu_fw_cfg.h
> @@ -37,6 +37,8 @@
>  #define FW_CFG_FILE_FIRST	0x20
>  #define FW_CFG_FILE_SLOTS_MIN	0x10
>  
> +#define FW_CFG_KERNEL_64BIT	0x21
> +
>  #define FW_CFG_WRITE_CHANNEL	0x4000
>  #define FW_CFG_ARCH_LOCAL	0x8000
>  #define FW_CFG_ENTRY_MASK	(~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LOCAL))
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 30d07026c7..21094232e0 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -2,7 +2,7 @@ include config.mak
>  SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
>  VPATH = $(SRC_DIR)
>  
> -all: multiboot.bin multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
> +all: multiboot.bin multiboot_dma.bin multiboot2.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
>  # Dummy command so that make thinks it has done something
>  	@true
>  
> diff --git a/pc-bios/optionrom/multiboot2.S b/pc-bios/optionrom/multiboot2.S
> new file mode 100644
> index 0000000000..a27c2a1f3c
> --- /dev/null
> +++ b/pc-bios/optionrom/multiboot2.S
> @@ -0,0 +1,324 @@
> +/*
> + * Multiboot2 Option ROM
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * Original Multiboot Option ROM:
> + * Copyright Novell Inc, 2009
> + *   Authors: Alexander Graf <agraf@suse.de>
> + *
> + * Adaption to Multiboot2 specs:
> + * Copyright Goswin von Brederlow, 2011
> + *   Authors: Goswin von Brederlow <goswin-v-b@web.de>
> + *
> + * Cleaned up and merged by:
> + * Copyright Jens Nyberg, 2024
> + *   Authors: Jens Nyberg <jens.nyberg@gmail.com>
> + *
> + */
> +
> +#include "optionrom.h"
> +
> +#define BOOT_ROM_PRODUCT "multiboot2 loader"
> +
> +#define MULTIBOOT_MAGIC		0x36d76289
> +
> +#define GS_PROT_JUMP		0
> +#define GS_GDT_DESC		8
> +
> +/* Memory layout (page tables only for 64 bit):
> + * 0x2000 L4 page table
> + * 0x3000 L3 page table
> + * 0x4000 L2 page table
> + * ...
> + * 0x7000 L2 page table
> + * 0x8000 bootinfo tags
> + */
> +
> +#define PGTABLE			0x2000
> +
> +BOOT_ROM_START
> +
> +run_multiboot:
> +
> +	cli
> +	cld
> +
> +	mov		%cs, %eax
> +	shl		$0x4, %eax
> +	mov		%eax, %ebp /* used below to jump to 64bit */
> +
> +	/* set up a long jump descriptor that is PC relative */
> +
> +	/* move stack memory to %gs */
> +	mov		%ss, %ecx
> +	shl		$0x4, %ecx
> +	mov		%esp, %ebx
> +	add		%ebx, %ecx
> +	sub		$0x20, %ecx
> +	sub		$0x30, %esp
> +	shr		$0x4, %ecx
> +	mov		%cx, %gs
> +
> +	/* now push the indirect jump decriptor there */
> +	mov		(prot_jump), %ebx
> +	add		%eax, %ebx
> +	movl		%ebx, %gs:GS_PROT_JUMP
> +	mov		$8, %bx
> +	movw		%bx, %gs:GS_PROT_JUMP + 4
> +
> +	/* fix the gdt descriptor to be PC relative */
> +	movw		(gdt_desc), %bx
> +	movw		%bx, %gs:GS_GDT_DESC
> +	movl		(gdt_desc+2), %ebx
> +	add		%eax, %ebx
> +	movl		%ebx, %gs:GS_GDT_DESC + 2
> +
> +	xor		%eax, %eax
> +	mov		%eax, %es
> +
> +	/* Read the bootinfo struct into RAM */
> +	read_fw_blob(FW_CFG_INITRD)
> +
> +	/* FS = bootinfo_struct */
> +	read_fw		FW_CFG_INITRD_ADDR
> +	shr		$4, %eax
> +	mov		%ax, %fs
> +	mov		%ax, %es	/* for int 0x15 */
> +
> +	/* %fs:%edi = bootinfo size = offset of mmap tag */
> +	movl 		%fs:0, %edi
> +
> +#define MULTIBOOT_TAG_TYPE_MMAP              6
> +	/* Create mmap tag */
> +	movl		$6, %fs:0(%edi)		/* type mmap */
> +	movl		$24, %fs:8(%edi)	/* entry_size */
> +	movl		$0, %fs:12(%edi)	/* entry_version */
> +
> +	/* Initialize multiboot mmap structs using int 0x15(e820) */
> +	xor		%ebx, %ebx
> +	/* mmap starts at byte 16 */
> +	addl		$16, %edi
> +
> +mmap_loop:
> +	/* entry size (mmap struct) & max buffer size (int15) */
> +	movl		$20, %ecx
> +	/* e820 */
> +	movl		$0x0000e820, %eax
> +	/* 'SMAP' magic */
> +	movl		$0x534d4150, %edx
> +	int		$0x15
> +
> +mmap_check_entry:
> +	/* last entry? then we're done */
> +	jb		mmap_done
> +	and		%bx, %bx
> +	jz		mmap_done
> +	/* valid entry, so let's loop on */
> +
> +mmap_next_entry:
> +	/* Advance %edi by sizeof(struct multiboot_mmap_entry) = 24 */
> +	addl		$24, %edi
> +	jmp		mmap_loop
> +
> +mmap_done:
> +	addl		$24, %edi		/* advance past entry */
> +	/* Create end tag */
> +	movl		$0, %fs:0(%edi)		/* type */
> +	movl		$8, %fs:4(%edi)		/* size */
> +	leal		8(%edi), %ebx		/* size of all tags */
> +
> +	/* set mmap tag size */
> +	mov		%edi, %eax	/* save offset after mmap */
> +	mov 		%fs:0, %edi	/* offset of mmap tag */
> +	sub		%edi, %eax	/* size of mmap tag */
> +	movl		%eax, %fs:4(%edi) /* size */
> +
> +	/* Store size of all tags */
> +	movl		%ebx, %fs:0
> +
> +real_to_prot:
> +	/* Load the GDT before going into protected mode */
> +lgdt:
> +	data32 lgdt	%gs:GS_GDT_DESC
> +
> +	/* get us to protected mode now */
> +	movl		$1, %eax
> +	movl		%eax, %cr0
> +
> +	/* the LJMP sets CS for us and gets us to 32-bit */
> +ljmp32:
> +	data32 ljmp	*%gs:GS_PROT_JUMP
> +
> +prot_mode:
> +.code32
> +	/* initialize all other segments */
> +	movl		$0x10, %eax
> +	movl		%eax, %ss
> +	movl		%eax, %ds
> +	movl		%eax, %es
> +	movl		%eax, %fs
> +	movl		%eax, %gs
> +
> +	/* Read the kernel and modules into RAM */
> +	read_fw_blob(FW_CFG_KERNEL)
> +
> +	/* 32bit or 64bit mode? */
> +	read_fw		FW_CFG_KERNEL_64BIT
> +	cmpl		$0, %eax
> +	jne		ljmp64
> +
> +	/* Jump off to the kernel */
> +	read_fw		FW_CFG_KERNEL_ENTRY
> +	mov		%eax, %ecx
> +
> +	/* EBX contains a pointer to the bootinfo struct */
> +	read_fw		FW_CFG_INITRD_ADDR
> +	movl		%eax, %ebx
> +
> +	/* EAX has to contain the magic */
> +	movl		$MULTIBOOT_MAGIC, %eax
> +ljmp2:
> +	/* Jump to kernel in 32bit mode */
> +	jmp		*%ecx
> +
> +/******************************************************************/
> +/* Set up 64bit mode                                              */
> +/******************************************************************/
> +ljmp64:
> +	/* Enable PAE */
> +	movl	%cr4, %eax
> +	btsl	$5, %eax
> +	movl	%eax, %cr4
> +
> + /*
> +  * Build early 4G boot pagetable
> +  */
> +	/* Initialize Page tables to 0 */
> +	leal	PGTABLE, %edi
> +	xorl	%eax, %eax
> +	movl	$((4096*6)/4), %ecx
> +	rep	stosl
> +
> +	/* Build Level 4 */
> +	leal	PGTABLE + 0, %edi
> +	leal	0x1007 (%edi), %eax
> +	movl	%eax, 0(%edi)
> +
> +	/* Build Level 3 */
> +	leal	PGTABLE + 0x1000, %edi
> +	leal	0x1007(%edi), %eax
> +	movl	$4, %ecx
> +1:	movl	%eax, 0x00(%edi)
> +	addl	$0x00001000, %eax
> +	addl	$8, %edi
> +	decl	%ecx
> +	jnz	1b
> +
> +	/* Build Level 2 */
> +	leal	PGTABLE + 0x2000, %edi
> +	movl	$0x00000183, %eax
> +	movl	$2048, %ecx
> +1:	movl	%eax, 0(%edi)
> +	addl	$0x00200000, %eax
> +	addl	$8, %edi
> +	decl	%ecx
> +	jnz	1b
> +
> +	/* Load Level 4 page table (page 128) */
> +	leal	PGTABLE, %eax
> +	movl	%eax, %cr3
> +
> +	/* Enable long mode */
> +	movl	$0xc0000080, %ecx
> +	rdmsr
> +	btsl	$8, %eax
> +	wrmsr
> +
> +	/* enable paging to activate long mode */
> +	movl	%cr0, %eax
> +	btsl	$1, %eax	/* protected mode */
> +	btsl	$31, %eax	/* paging */
> +	movl	%eax, %cr0
> +
> +	/* Jump off to the kernel */
> +	read_fw		FW_CFG_KERNEL_ENTRY
> +	movl		%eax, %ebx
> +
> +	/* pointer to the bootinfo struct */
> +	read_fw		FW_CFG_INITRD_ADDR
> +	movl		%eax, %ecx
> +
> +	/* jump to 64bit mode */
> +	pushl	$0x28
> +	leal	startup_64(%ebp), %eax
> +	pushl	%eax
> +	lret
> +
> +	.code64
> +startup_64:
> +_startup_64:
> +	/* EDI has to contain the magic, ESI the boot info */
> +	movl	%ebx, %eax	/* kernel entry address */
> +	movl	%ecx, %esi	/* pointer to boot info */
> +	movl	$MULTIBOOT_MAGIC, %edi
> +	jmp	*%rax
> +
> +color:	/* collor me silly */
> +	addl	$0x1,0xb8000
> +	jmp	color
> +
> +/******************************************************************/
> +
> +
> +/* Variables */
> +.align 4, 0
> +prot_jump:	.long prot_mode
> +		.short 8
> +
> +.align 4, 0
> +gdt:
> +	/* 0x00: null segment */
> +.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +
> +	/* 0x08: code segment */
> +	/* base=0, limit=0xfffff, type=32bit code exec/read, DPL=0, 4k */
> +.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
> +
> +	/* 0x10: data segment */
> +	/* base=0, limit=0xfffff, type=32bit data read/write, DPL=0, 4k */
> +.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
> +
> +	/* 0x18: code segment */
> +	/* base=0, limit=0x0ffff, type=16bit code exec/read/conf, DPL=0, 1b */
> +.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00
> +
> +	/* 0x20: data segment */
> +	/* base=0, limit=0x0ffff, type=16bit data read/write, DPL=0, 1b */
> +.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0x00, 0x00
> +
> +	/* 0x28: code segment */
> +	/* base=0, limit=0xfffff, type=64bit code exec/read, DPL=0, 4k */
> +.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xaf, 0x00
> +
> +	/* 0x30: ts descriptor */
> +.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x89, 0x80, 0x00
> +	/* 0x38: ts continued */
> +.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +
> +gdt_desc:
> +.short	(8 * 8) - 1
> +.long	gdt
> +
> +BOOT_ROM_END
> diff --git a/pc-bios/optionrom/optionrom.h b/pc-bios/optionrom/optionrom.h
> index 7bcdf0eeb2..6f758c58be 100644
> --- a/pc-bios/optionrom/optionrom.h
> +++ b/pc-bios/optionrom/optionrom.h
> @@ -33,6 +33,7 @@
>  #define FW_CFG_SETUP_ADDR       0x16
>  #define FW_CFG_SETUP_SIZE       0x17
>  #define FW_CFG_SETUP_DATA       0x18
> +#define FW_CFG_KERNEL_64BIT     0x21
>  
>  #define BIOS_CFG_IOPORT_CFG    0x510
>  #define BIOS_CFG_IOPORT_DATA   0x511
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


