Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF1D3F098
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8lc-0008Dl-T5; Wed, 28 Jan 2026 11:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8lZ-0008Aa-Ti
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:51:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8lX-0008ET-TI
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:51:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so995385e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769619098; x=1770223898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=990MEqV4bZdXmnDCvnk5OysCsWbIa5aoxjqYjwa/Xh8=;
 b=Pe2zjNwhQKvKtHpLCR6r3I/a1ifLXVZVoWMJRNGkaYihbQyQbWNlUG2Bqdpak/mmrb
 blIWgX953uvHI7akK6+5OxVcoM7O1dKHpd2qJb7OT7xzeQvl7zwmJpT5wEpWYtshnU5g
 K487TAUJo426Jemhv6SmEnkJvnG20g1wEEflp1w+nE8DU0TUD48DdPOq5GC0JQC8wmX1
 z6Y4DckyWOvZiJXoJ5n40tkIRML9jOQ/xor41NdOq5SERLmJOwVQ3Ww22Ow5nrn4JhZM
 D+kPReb1KhHn+gbHQSvquEDZoiWsg/OPtUOr57bFH7D070HnmmnUBZBSzwv6ias2T44I
 NAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619098; x=1770223898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=990MEqV4bZdXmnDCvnk5OysCsWbIa5aoxjqYjwa/Xh8=;
 b=XuuEdWFexhBJJTPZFBgpxPZ5zF8FzVt82Ag6wWhewprLwDoI3UUCNyR+w8cb1MkEnR
 XJF+e3hQYHfo1/IOX6Lx6HHvOqv8G9IQCOJW8ffh1GOE8rK/07L2vVRR1NjA7jQ1m2xF
 +kCseUe2nTQrjVJTqxb2ZAzMY7pFAY/iOIyrg7ujUDV/q8oHm0Q56SLRCjLCRlN4B1dX
 gCHcqkndV9RTWQ2vxg6k0UG6sJjPI5shE2C4DndwgKJ+30daT8xRFdV/TDs8QRNhQfvD
 NnU3hWtlCi4HnTyh+wAIIp9+HaGhq93D4Xc7aECmXfuXOrhM1FpxVpfn95SqJWJTVIav
 ws6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIDCN9mhb4N4Q49XpCOxOE4QVaYOfuYqileN/NZmWJiWdfzJd9Z3JusrBH93YVilVMEIYCFOjUQKmZ@nongnu.org
X-Gm-Message-State: AOJu0Yy75jkcGmse16z1i3zgYYt2VlraP84yylohGwKsHXhHQwjcv+OU
 Hn7Ld1L6ZEFItgQWwF9a0kWQNzvsUUBQFb7Wtp9kkqW1r95hh2e4L0L83OO0AsCazdIAcEOhv36
 N6aWNirU=
X-Gm-Gg: AZuq6aJoFqzoMd8Lsx0x1Ytxq/6hksXRUB5ZL9Kv5N9kT8rS5wSWep6N+MyxRAP6Goa
 mmDS3EHZlGNdBi1HBWAVTIr6gCxl2ln9k6UhvcbJ7rkmYao1HadPcHET8662ViRCB7izEFXZN3v
 4NEYQanJTE/MHZxJWlzmE1Qs1so6fxqQ1fXq6Wc5C7+fMCC94m56ukcBZHVOUOhf3MPmVdQXjbN
 yasABnR/h26pF1QCMyBLSAnHoYc8GeBqNEoKkeJEjSySaNTDodpUHOxfrmvbOtDSwHBTAeEFQdF
 S+LbOwy2ykS2/N8c4MKgc1SXt/d16XTtGc6sCVRNALNa6VNmmMWYRKLnIsvyewJt0EEhDL1uRn2
 A8ELcTaUE86IXOUPNzmSk2j6EMnAmRK8JADolT3kTEK1QTDq/IyYbtuUG55qpAxQK6NAbS04kN/
 SfnP9huIGJPqQ4mObVZT8MsdQqDehxTHANZk8Kkkg+j86Gxhe64Lw9uA==
X-Received: by 2002:a05:600c:1909:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-48069c793a2mr73990275e9.32.1769619097948; 
 Wed, 28 Jan 2026 08:51:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806e2bd243sm3632445e9.11.2026.01.28.08.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:51:37 -0800 (PST)
Message-ID: <73168048-9a29-4b7c-a3a8-be44e495eaf8@linaro.org>
Date: Wed, 28 Jan 2026 17:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-3-jim.shu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260128152348.2095427-3-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 28/1/26 16:23, Jim Shu wrote:
> 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> find the correct section when CPU access the IO region over the IOTLB.
> However, section_index is only unique inside single AddressSpace. If
> address space translation is over IOMMUMemoryRegion, it could return
> section from other AddressSpace. 'iotlb_to_section()' API only finds the
> sections from CPU's AddressSpace so that it couldn't find section in
> other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> wrong section and QEMU will have wrong load/store access.
> 
> To fix this bug of iotlb_to_section(), store complete MemoryRegionSection
> pointer in CPUTLBEntryFull to replace the section_index in xlat_section.
> Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
> inside. Also, since we directly use section pointer in the
> CPUTLBEntryFull (full->section), we can remove the unused functions:
> iotlb_to_section(), memory_region_section_get_iotlb().
> 
> This bug occurs only when
> (1) IOMMUMemoryRegion is in the path of CPU access.
> (2) IOMMUMemoryRegion returns different target_as and the section is in
> the IO region.
> 
> Common IOMMU devices don't have this issue since they are only in the
> path of DMA access. Currently, the bug only occurs when ARM MPC device
> (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> handling. Upcoming RISC-V wgChecker [1] and IOPMP [2] devices are also
> affected by this bug.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Also implicit on v1:
Tested-by: Mark Burton <mburton@qti.qualcomm.com>

> ---
>   accel/tcg/cputlb.c        | 22 ++++++++++------------
>   include/accel/tcg/iommu.h | 15 ---------------
>   include/exec/cputlb.h     |  4 ++--
>   include/hw/core/cpu.h     | 17 +++++++++--------
>   system/physmem.c          | 25 -------------------------
>   5 files changed, 21 insertions(+), 62 deletions(-)


> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> index 90cfd6c0ed1..547f8ea0ef0 100644
> --- a/include/accel/tcg/iommu.h
> +++ b/include/accel/tcg/iommu.h
> @@ -14,18 +14,6 @@
>   #include "exec/hwaddr.h"
>   #include "exec/memattrs.h"
>   
> -/**
> - * iotlb_to_section:
> - * @cpu: CPU performing the access
> - * @index: TCG CPU IOTLB entry
> - *
> - * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> - * it refers to. @index will have been initially created and returned
> - * by memory_region_section_get_iotlb().
> - */
> -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                      hwaddr index, MemTxAttrs attrs);

Glad you removed this, we should not had involved CPUState here.

> -
>   MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
>                                                          int asidx,
>                                                          hwaddr addr,
> @@ -34,8 +22,5 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
>                                                          MemTxAttrs attrs,
>                                                          int *prot);
>   
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section);
> -
>   #endif
>   
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 0d1d46429c9..3a9603a6965 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -44,8 +44,8 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>    * @full: the details of the tlb entry
>    *
>    * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
> - * @full must be filled, except for xlat_section, and constitute
> - * the complete description of the translated page.
> + * @full must be filled, except for xlat_offset & section, and
> + * constitute the complete description of the translated page.
>    *
>    * This is generally called by the target tlb_fill function after
>    * having performed a successful page table walk to find the physical
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 61da2ea4331..98678704a64 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -219,15 +219,16 @@ typedef uint32_t MMUIdxMap;
>    */
>   struct CPUTLBEntryFull {
>       /*
> -     * @xlat_section contains:
> -     *  - in the lower TARGET_PAGE_BITS, a physical section number
> -     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
> -     *    must be added to the virtual address to obtain:
> -     *     + the ram_addr_t of the target RAM (if the physical section
> -     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> -     *     + the offset within the target MemoryRegion (otherwise)
> +     * @xlat_offset: TARGET_PAGE_BITS aligned offset which must be added to
> +     * the virtual address to obtain:
> +     *   + the ram_addr_t of the target RAM (if the physical section
> +     *     number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
> +     *   + the offset within the target MemoryRegion (otherwise)
>        */
> -    hwaddr xlat_section;
> +    hwaddr xlat_offset;
> +
> +    /* @section contains physical section. */
> +    MemoryRegionSection *section;

LGTM!

