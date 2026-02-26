Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64774FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjxV-0001h9-Uv; Thu, 26 Feb 2026 17:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvjxU-0001gd-5Y
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:35:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvjxR-0000Cx-Ux
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:35:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9ED0D597318;
 Thu, 26 Feb 2026 23:35:40 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DpMWVepZBbJc; Thu, 26 Feb 2026 23:35:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8FD495972DF; Thu, 26 Feb 2026 23:35:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8DF1D5972E2;
 Thu, 26 Feb 2026 23:35:38 +0100 (CET)
Date: Thu, 26 Feb 2026 23:35:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
In-Reply-To: <20260226220226.20164-8-philmd@linaro.org>
Message-ID: <a3e183e3-4196-f3d0-f221-d93652e7d3df@eik.bme.hu>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-679242517-1772145310=:40301"
Content-ID: <45088092-8b40-6013-0f8e-5c2e0943310d@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-679242517-1772145310=:40301
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <9d8d7d34-6db7-a246-79b8-d74509f0234e@eik.bme.hu>

On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
> Use the size of a MR / AS to decide how many address chars
> need to be used.
>
> For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
> to run 'info mtree' displays before:
>
>  address-space: I/O
>    0000000000000000-000000000000ffff (prio 0, i/o): io
>        0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
>        0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
>        0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
>        0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
>        0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
>        0000000000000060-000000000000007f (prio 0, i/o): sm-tco
>      0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
>      0000000000000008-000000000000000f (prio 0, i/o): dma-cont
>      0000000000000020-0000000000000021 (prio 0, i/o): pic
>      0000000000000040-0000000000000043 (prio 0, i/o): pit
>      ...
>  memory-region: pc.ram
>    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
>  memory-region: pc.bios
>    00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>  memory-region: pci
>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>  ...
>
> and after:
>
>  address-space: I/O
>    0000-ffff (prio 0, container): io
>        0000-0003 (prio 0, i/o): acpi-evt
>        0004-0005 (prio 0, i/o): acpi-cnt
>        0008-000b (prio 0, i/o): acpi-tmr
>        0020-002f (prio 0, i/o): acpi-gpe0
>        0030-0037 (prio 0, i/o): acpi-smi
>        0060-007f (prio 0, i/o): sm-tco
>      0000-0007 (prio 0, i/o): dma-chan
>      0008-000f (prio 0, i/o): dma-cont
>      0020-0021 (prio 0, i/o): pic
>      0040-0043 (prio 0, i/o): pit
>      ...
>  memory-region: pc.ram
>    00000000-07ffffff (prio 0, ram): pc.ram
>  memory-region: pc.bios
>    fffc0000-ffffffff (prio 0, rom): pc.bios
>  memory-region: pci
>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>  ...
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> system/memory.c | 27 +++++++++++++++++++++++----
> 1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 4d276307da5..abcbdaadcd7 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>
> #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                            int128_sub((size), int128_one())) : 0)
> -#define MR_ADDR_WIDTH   16
> +
> +static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
> +{
> +    const unsigned int bits = 127 - clz128(mr->size);
> +    unsigned int width;
> +
> +    if (bits <= 8) {
> +        width = 2;
> +    } else if (bits <= 16) {
> +        width = 4;
> +    } else if (bits <= 32) {
> +        width = 8;
> +    } else if (bits <= 64) {
> +        width = 16;
> +    } else {
> +        width = 20;

Why 20? HWADDR_FMT_plx this seems to replace is "%016" PRIx64

Regards,
BALATON Zoltan

> +    }
> +    return width;
> +}
> +
> #define MTREE_INDENT "  "
>
> static void mtree_expand_owner(const char *label, Object *obj)
> @@ -3513,7 +3532,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>         return;
>     }
>
> -    width = MR_ADDR_WIDTH;
> +    width = mr_addr_fmt_width(view->root);
>     while (n--) {
>         const MemoryRegion *mr = range->mr;
>
> @@ -3643,7 +3662,7 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>     MemoryRegion *mr = key;
>     GSList *as_same_root_mr_list = value;
>     struct AddressSpaceInfo *asi = user_data;
> -    const unsigned int width = MR_ADDR_WIDTH;
> +    const unsigned int width = mr_addr_fmt_width(mr);
>
>     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
>     mtree_print_mr(mr, 1, width, -mr->addr, false,
> @@ -3692,7 +3711,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>     /* print aliased regions */
>     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>         const MemoryRegion *mr = ml->mr;
> -        const unsigned int width = MR_ADDR_WIDTH;
> +        const unsigned int width = mr_addr_fmt_width(mr);
>
>         qemu_printf("memory-region: %s\n", memory_region_name(mr));
>         mtree_print_mr(mr, 1, width, 0, false, &ml_head, owner, disabled);
>
--3866299591-679242517-1772145310=:40301--

