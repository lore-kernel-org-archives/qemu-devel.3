Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E0BD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 05:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwBO-0007hM-Uy; Mon, 02 Mar 2026 00:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwwBN-0007gd-G4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:51:05 -0500
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwwBL-0002AH-M2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:51:05 -0500
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1273349c56bso4787532c88.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 21:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772430662; x=1773035462; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9wKx+HGzxuqK00ScCUg1ZjPfdtKGt9VZ3eEjqM8Ywc=;
 b=P5PXNq7YuDGRG2xqw1yG93TrtHq9eDqCBbQN2QkTRq9cWBXBeRcFsZItJCDcqUfuY3
 XVP/p6yvn7vVm+FjVlTOlXh/X30OIpfz10qfvZqN/d2oDGuMpuN6UqCRozx5Z//V6cvA
 paikPp6EjJhs3VdYEiE1EKSdeWkSHUwM3ZJIq7o/y/Q6uDZDtCS1aq+xS0sorsNOURDt
 mT9D10jXF0UEPIKrUqmaEa75QTdnz9ptkzU0I7+49rN2RSWgEgVAogsQ+qQi76Ioj4fx
 5f1LYYgSW3HBFm83HqhqZebB5Dt4aV9A1jmTqdJJ6vibUz6l6jtPBc6Ybvu0tYAWnbZc
 /8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772430662; x=1773035462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9wKx+HGzxuqK00ScCUg1ZjPfdtKGt9VZ3eEjqM8Ywc=;
 b=UFWSpk+7Ekfk4/DbyYNy3DuqUWiter9LZgCHDg9GNHjoT9uWlcj3qsOikqNaKdpAlk
 oHoHyJfmWyJlSZvGfke40z4kTTXB55Tp7Cnl+u0tvIE1Ugnfx1OzGJ52/Gh7AQKqtcuC
 6hV6UAL6XtUxHOyGKHdfyf3Q5qzh9S78gZ0DTwAPq8mIIi7iGFNKaqQedoq7c7hle4i5
 WSt2Yy8WJRh48ekRSUSF0iM+WR3xfw+LnvvyjbuaEumavLwGp+Zbrf1DK9+tZmVlhd/H
 8XEfIB9O75S19GFChY+ry8g+sJ4YNQAJv2babriDnjDEDu0YQDhFfD//2L20DizIuaRp
 Kvsw==
X-Gm-Message-State: AOJu0YztP70rf7Lq50Vfw5mlnxbXGq/s8W1pXW1toTZhlOuMM9U3jH86
 ODTA2QyS6+qD32rdvDBAHwkmfmQm7kCUt6HxSqaG0CKmQ1oaMuHPFqup
X-Gm-Gg: ATEYQzwyncf0B+I7UNtnSq3eGCTWBhFdAZ0CCCnPcmGxrt5kvdHvZc5dRiZdHxFK+ot
 nyZ5v876szJnyyZW1ZsZFCjQ3uaUBquUgT++pCosw8CkfKq73W6KopvzfvFq0Oq/Zh1uqfezUFj
 ZLzw1Zu1wln99lJDX5LPTeBe74eKmJIq/mRSN6k5ke+QFNpxM4uD99sHs8yPFMagNpYuCMSnO/i
 cifHYpLGTtTNggAAXawMx55SooOT1y88CylwTG+uqkeWdJdJDhDOj0SwzK0p8VWniMdge/XX3Cl
 Lt13n68nUS0VdMOTdKj0Xqt/YFoQlFdG6xJxRK7ZNCR0ht5el6YoEUOuoQzQkRuB0jbhWDHRjRA
 aIwJGenSPymuQrCa55ZG4u9SNOSb9lKnOANktXrl+uayQCodlPUqv9nKDdjxmoIfYRtNKj5NKnj
 M6HSBfmZQlRH7GaKcjarjAe/MfjqtdnqDLZXRvZyIUbw6E8iTfmSymLwo5rvHae8TuTtjk1BjnP
 gnhgmwDFrFLhHc8imcXcr9JnyVewt0=
X-Received: by 2002:a05:7022:68d:b0:123:330b:398 with SMTP id
 a92af1059eb24-1278fb94324mr4467112c88.19.1772430662100; 
 Sun, 01 Mar 2026 21:51:02 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32dabsm14731591c88.11.2026.03.01.21.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 21:51:01 -0800 (PST)
Date: Mon, 2 Mar 2026 13:50:43 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 2/2] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
Message-ID: <aaUkfa3DfURTV83t@ZEVORN-PC.localdomain>
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-3-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202075358.2137740-3-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jim,

On Mon, Feb 02, 2026 at 03:53:58PM +0800, Jim Shu wrote:
> Instead of IOMMU_NONE, address_space_translate_for_iotlb() now can pass
> the correct iommu_flags to the IOMMU translate function from the
> access_type.
> 
> Since RISC-V wgChecker [1] could permit access in RO or WO permission
> only, the IOMMUMemoryRegion could return different section for
> read and write access. To support this kind of IOMMUMemoryRegion
> in the path of CPU access, we should pass correct iommu_flags here.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  accel/tcg/cputlb.c        |  3 ++-
>  include/accel/tcg/iommu.h |  3 ++-
>  system/physmem.c          | 16 +++++++++++-----
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2a0f4cfff62..404a8607b9b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1050,7 +1050,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>      prot = full->prot;
>      asidx = cpu_asidx_from_attrs(cpu, full->attrs);
>      section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
> -                                                &xlat, &sz, full->attrs, &prot);
> +                                                &xlat, &sz, full->attrs, &prot,
> +                                                access_type);
>      assert(sz >= TARGET_PAGE_SIZE);
>  
>      tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> index 547f8ea0ef0..2a79f859834 100644
> --- a/include/accel/tcg/iommu.h
> +++ b/include/accel/tcg/iommu.h
> @@ -20,7 +20,8 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
>                                                         hwaddr *xlat,
>                                                         hwaddr *plen,
>                                                         MemTxAttrs attrs,
> -                                                       int *prot);
> +                                                       int *prot,
> +                                                       MMUAccessType access_type);
>  
>  #endif
>  
> diff --git a/system/physmem.c b/system/physmem.c
> index 2fb0c25c93b..337137489de 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -683,12 +683,14 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
>  MemoryRegionSection *
>  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
>                                    hwaddr *xlat, hwaddr *plen,
> -                                  MemTxAttrs attrs, int *prot)
> +                                  MemTxAttrs attrs, int *prot,
> +                                  MMUAccessType access_type)
>  {
>      MemoryRegionSection *section;
>      IOMMUMemoryRegion *iommu_mr;
>      IOMMUMemoryRegionClass *imrc;
>      IOMMUTLBEntry iotlb;
> +    IOMMUAccessFlags iommu_flags;
>      int iommu_idx;
>      hwaddr addr = orig_addr;
>      AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
> @@ -705,10 +707,14 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
>  
>          iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
>          tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
> -        /* We need all the permissions, so pass IOMMU_NONE so the IOMMU
> -         * doesn't short-cut its translation table walk.
> -         */
> -        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
> +
> +        if (access_type == MMU_DATA_STORE) {
> +            iommu_flags = IOMMU_WO;
> +        } else {
> +            iommu_flags = IOMMU_RO;
> +        }
This maps both MMU_INST_FETCH and MMU_DATA_LOAD to IOMMU_RO. Is this intentional?
Some IOMMU implementations might want to distinguish between instruction fetch and data read.

Or is the current mapping sufficient for your use case (RISC-V wgChecker)?

Thanks,
Chao
> +
> +        iotlb = imrc->translate(iommu_mr, addr, iommu_flags, iommu_idx);
>          addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
>          /* Update the caller's prot bits to remove permissions the IOMMU
> -- 
> 2.43.0
> 
> 

