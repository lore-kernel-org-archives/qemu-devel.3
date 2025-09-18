Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6DACAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLZg-0001VB-Vt; Thu, 18 Sep 2025 16:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLZa-0001UR-Cf; Thu, 18 Sep 2025 16:49:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLZY-0007Py-Gh; Thu, 18 Sep 2025 16:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wySVsPliL+9a3J5l0F8RfbJrt0kiTQe6u8vNGVXiW4U=; b=yOk1Q1V9WboTF4YxdxzMpbd+5q
 mpqU3MacfGlQQAKzNqJoOh1Gg0YNAcbggjgolrgruDJhjJRwak/VjgQQL8OE30CkggR2kLxp25Ff3
 d9kaasm2/kupejpAQK49RH4Igq1CytETs4KMydOhf/FOJoTV5XDW1u2Htx+jTo5FLfWeEaUp8CeBe
 /vavpZuXRbnjJT0QxpwKpVvb4dMOWdBu7oCM6MNcivLfu46sR99l/+kwXfs6q3S1oZ7r5xg9Cs3ry
 xGnoAPXP092g1Z0nLb0UZ8Zsg18d4yu1zpJf8jeoKP3do70AdDWAeExvpenyaww5m3lwoUgIidZJ2
 rtGVkcDBqs3R45edxJUIM5HsKFYD03j4UKSwj9DBo7IzWJobsBxmzJ6f4PvNBCkHkVLpUYgqKUgQj
 H/GF/yA86/jbXcZEFBt8DRI9GXS/MRwbL9jNwLcpBA3B4RqhKeDyyks43Y+zbtC7pVQ6aLXvWFxLp
 p3Qxe0jriReiX1Y/L4DeC0NaWwNioweovl4NcPhkMaG6B4xfiLIjZDYc/HlhyXmYkwqWxf1PmHRiw
 JGbOku+U+YUPKvyR0OWK3+U3Th/KPA4BXMXBhpmpGymIw2HOJH/UZDdcXT6YZTzdSd7Imo27cS+B3
 vFgBg08OhHisXn8sWw6nNqhTiZYgxL4AT6NSAuS1Q=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLXW-0006w3-8f; Thu, 18 Sep 2025 21:47:38 +0100
Message-ID: <c20c8e3c-dd4f-4331-a2aa-0faa01eb2b6c@ilande.co.uk>
Date: Thu, 18 Sep 2025 21:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <1ce9e69c55653d66dd2ead1a19ee779937847caa.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <1ce9e69c55653d66dd2ead1a19ee779937847caa.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 11/14] hw/pci-host/raven: Simpify discontiguous IO
 access
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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

On 18/09/2025 19:50, BALATON Zoltan wrote:

> PREP allows remapping of the 64k ISA IO addresses from the normal
> contiguous IO space into a discontiguous 8MB region and can switch
> between the two modes. We can implement this in a simpler way than is
> done currently using an io region that forwards access to the
> contiguous pci_io region and enabling/disabling the discontiguous
> region as needed.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 88 ++++++++++++---------------------------------
>   1 file changed, 22 insertions(+), 66 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index bb0be40eb4..bf4f4b7f71 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -42,17 +42,14 @@ struct PREPPCIState {
>       PCIHostState parent_obj;
>   
>       qemu_irq irq;
> -    AddressSpace pci_io_as;
>       MemoryRegion pci_io;
> -    MemoryRegion pci_io_non_contiguous;
> +    MemoryRegion pci_discontiguous_io;
>       MemoryRegion pci_memory;
>       MemoryRegion pci_intack;
>       MemoryRegion bm;
>       MemoryRegion bm_ram_alias;
>       MemoryRegion bm_pci_memory_alias;
>       AddressSpace bm_as;
> -
> -    int contiguous_map;
>   };
>   
>   #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
> @@ -103,63 +100,28 @@ static const MemoryRegionOps raven_intack_ops = {
>       },
>   };
>   
> -static inline hwaddr raven_io_address(PREPPCIState *s,
> -                                      hwaddr addr)
> +/* Convert 8 MB non-contiguous address to 64k ISA IO address */
> +static inline hwaddr raven_io_addr(hwaddr addr)
>   {
> -    if (s->contiguous_map == 0) {
> -        /* 64 KB contiguous space for IOs */
> -        addr &= 0xFFFF;
> -    } else {
> -        /* 8 MB non-contiguous space for IOs */
> -        addr = (addr & 0x1F) | ((addr & 0x007FFF000) >> 7);
> -    }
> -
> -    /* FIXME: handle endianness switch */
> -
> -    return addr;
> +    return ((addr & 0x007FFF000) >> 7) | (addr & 0x1F);
>   }
>   
> -static uint64_t raven_io_read(void *opaque, hwaddr addr,
> -                              unsigned int size)
> +static uint64_t raven_io_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    uint8_t buf[4];
> -
> -    addr = raven_io_address(s, addr);
> -    address_space_read(&s->pci_io_as, addr + PCI_IO_BASE_ADDR,
> -                       MEMTXATTRS_UNSPECIFIED, buf, size);
> -
> -    if (size == 1) {
> -        return buf[0];
> -    } else if (size == 2) {
> -        return lduw_le_p(buf);
> -    } else if (size == 4) {
> -        return ldl_le_p(buf);
> -    } else {
> -        g_assert_not_reached();
> -    }
> +    uint64_t val = 0xffffffffULL;
> +
> +    memory_region_dispatch_read(opaque, raven_io_addr(addr), &val,
> +                                size_memop(size) | MO_LE,
> +                                MEMTXATTRS_UNSPECIFIED);
> +    return val;
>   }

I'm guessing the dispatch target is guaranteed not to be a RAM-backed memory region?

> -static void raven_io_write(void *opaque, hwaddr addr,
> -                           uint64_t val, unsigned int size)
> +static void raven_io_write(void *opaque, hwaddr addr, uint64_t val,
> +                           unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    uint8_t buf[4];
> -
> -    addr = raven_io_address(s, addr);
> -
> -    if (size == 1) {
> -        buf[0] = val;
> -    } else if (size == 2) {
> -        stw_le_p(buf, val);
> -    } else if (size == 4) {
> -        stl_le_p(buf, val);
> -    } else {
> -        g_assert_not_reached();
> -    }
> -
> -    address_space_write(&s->pci_io_as, addr + PCI_IO_BASE_ADDR,
> -                        MEMTXATTRS_UNSPECIFIED, buf, size);
> +    memory_region_dispatch_write(opaque, raven_io_addr(addr), val,
> +                                 size_memop(size) | MO_LE,
> +                                 MEMTXATTRS_UNSPECIFIED);
>   }
>   
>   static const MemoryRegionOps raven_io_ops = {
> @@ -208,7 +170,7 @@ static void raven_change_gpio(void *opaque, int n, int level)
>   {
>       PREPPCIState *s = opaque;
>   
> -    s->contiguous_map = level;
> +    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>   }
>   
>   static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
> @@ -254,23 +216,17 @@ static void raven_pcihost_initfn(Object *obj)
>       MemoryRegion *address_space_mem = get_system_memory();
>   
>       memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
> -    memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
> -                          "pci-io-non-contiguous", 0x00800000);
> +    memory_region_init_io(&s->pci_discontiguous_io, obj,
> +                          &raven_io_ops, &s->pci_io,
> +                          "pci-discontiguous-io", 8 * MiB);

Again I think passing the device as the opaque is easier to understand.

>       memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
> -    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
> -
> -    /*
> -     * Raven's raven_io_ops use the address-space API to access pci-conf-idx
> -     * (which is also owned by the raven device). As such, mark the
> -     * pci_io_non_contiguous as re-entrancy safe.
> -     */
> -    s->pci_io_non_contiguous.disable_reentrancy_guard = true;
>   
>       /* CPU address space */
>       memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
>                                   &s->pci_io);
>       memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
> -                                        &s->pci_io_non_contiguous, 1);
> +                                        &s->pci_discontiguous_io, 1);
> +    memory_region_set_enabled(&s->pci_discontiguous_io, false);
>       memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
>   
>       /* Bus master address space */

Out of curiosity do you have an image or firmware that tests this?


ATB,

Mark.


