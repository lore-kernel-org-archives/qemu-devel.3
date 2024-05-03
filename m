Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7016C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sNP-0008E9-0I; Fri, 03 May 2024 08:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2sNM-0008DV-Ba
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:50:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2sNK-0005d9-GF
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:50:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a595199cb9bso462973866b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714740652; x=1715345452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ETsEuXWkbdZU6HzMd0bGeQZo4WUCHUxUaaxOhcft2bk=;
 b=VmmJMwxt/AaoO/qHJRJ4O8XSZl7j82LCZP8CE/ONEXke5LoePLvQAi2DXvYgzgnspn
 ZbtTTdWmbl6tUqYQW4fLNrKkSmq/m1YWplJVerbDKXGRHzz69o7e58oDZbdUJkjO/VwF
 V2sjWHJw0caJGkz90YoRG4iJCfkR9aHONgEpxS52u3rLT2Mqta+9CYIOTmxhDHjIYNtw
 n8oMVaCFfibA5JnQgmMixbA2wj8+CcgjozZbQeb+/GlwUjHYSobUxhFSUYL25ZDoH7lu
 pOcMHtJvWbqvINwQMv8QBVl7lTGk+TA7KRZ/tWncmeZz+mUwV0KNCtviuX1yETBBgfY9
 DIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740652; x=1715345452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETsEuXWkbdZU6HzMd0bGeQZo4WUCHUxUaaxOhcft2bk=;
 b=UkN2C6iBV2iE4su9hcDg+JMp6Z4YBz9fMQBWmCOOY1af/i+xD3CunHm1NnZsgZT3CX
 i/qUFYkZ0VzW4rnEhwt7FeV4PygCuX8WMQN1ciqLdLRLi86q2RO+Z2OH6ePsJNXP/Oeq
 gvaT3gtwfC6b0qmLjFDw2vAQ+IXymEIXdKyspq0WwFQtKBc/rPv0LHgjJ1MIdfAAS3+R
 8JafOBlhcypO8dSW+kxOvFrh/pCmmXH4ZxMT5GZSOBwgUkqSz8pvdhMLkg9alxLHgKjF
 Rsj1Ljn9pmBiPMymiak9MCgpmJrm6WP6m2y6fcqGwyhYp680sQSooAgjwrIud2HD1yb3
 lxLg==
X-Gm-Message-State: AOJu0Yyr5P/laAlO/xcd0q68ZQZhw73WbRdF/YkpphM983OEOhgNBiGP
 6N6MkxqYNRP96bjj86JIU+25BPz3E9q9m2wfHuBkffDir2Qeg+qK9Q+VWY2rBHgpiUgJrFtCIxS
 OxDCo+L9Ad0F1CcApXtCtUQmcI9+S+r7+9noU2aWVa+CTQVRo
X-Google-Smtp-Source: AGHT+IH8FiyAbNbB82dKKkN8BVrDBrY3da7tBorCMoqnZoHKyIpPDTXenOrkcWRAtF6s9W3uwQUyeUlkylNd3gfJOaw=
X-Received: by 2002:a50:875e:0:b0:572:1b5a:2a07 with SMTP id
 30-20020a50875e000000b005721b5a2a07mr1357663edv.32.1714740652605; Fri, 03 May
 2024 05:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230616100158.1845239-1-gaosong@loongson.cn>
 <20230616100158.1845239-4-gaosong@loongson.cn>
In-Reply-To: <20230616100158.1845239-4-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 13:50:41 +0100
Message-ID: <CAFEAcA_iu05EA+XZ4ENW_5QZ4uxLNzmY5FV9W_Ev1KFaZaJ+hw@mail.gmail.com>
Subject: Re: [PULL 3/5] hw/loongarch: Add numa support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Tianrui Zhao <zhaotianrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 16 Jun 2023 at 11:03, Song Gao <gaosong@loongson.cn> wrote:
>
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>
> 1. Implement some functions for LoongArch numa support;
> 2. Implement fdt_add_memory_node() for fdt;
> 3. build_srat() fills node_id and adds build numa memory.
>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20230613122613.2471743-1-zhaotianrui@loongson.cn>

Hi; Coverity has pointed out a memory leak in this commit
(CID 1544773):

> @@ -799,17 +823,43 @@ static void loongarch_init(MachineState *machine)
>          machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
>      }
>      fdt_add_cpu_nodes(lams);
> -    /* Add memory region */
> -    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.lowram",
> -                             machine->ram, 0, 256 * MiB);
> -    memory_region_add_subregion(address_space_mem, offset, &lams->lowmem);
> -    offset += 256 * MiB;
> -    memmap_add_entry(0, 256 * MiB, 1);
> -    highram_size = ram_size - 256 * MiB;
> -    memory_region_init_alias(&lams->highmem, NULL, "loongarch.highmem",
> -                             machine->ram, offset, highram_size);
> -    memory_region_add_subregion(address_space_mem, 0x90000000, &lams->highmem);
> -    memmap_add_entry(0x90000000, highram_size, 1);
> +
> +    /* Node0 memory */
> +    memmap_add_entry(VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 1);
> +    fdt_add_memory_node(machine, VIRT_LOWMEM_BASE, VIRT_LOWMEM_SIZE, 0);
> +    memory_region_init_alias(&lams->lowmem, NULL, "loongarch.node0.lowram",
> +                             machine->ram, offset, VIRT_LOWMEM_SIZE);
> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->lowmem);
> +
> +    offset += VIRT_LOWMEM_SIZE;
> +    if (nb_numa_nodes > 0) {
> +        assert(numa_info[0].node_mem > VIRT_LOWMEM_SIZE);
> +        highram_size = numa_info[0].node_mem - VIRT_LOWMEM_SIZE;
> +    } else {
> +        highram_size = ram_size - VIRT_LOWMEM_SIZE;
> +    }
> +    phyAddr = VIRT_HIGHMEM_BASE;
> +    memmap_add_entry(phyAddr, highram_size, 1);
> +    fdt_add_memory_node(machine, phyAddr, highram_size, 0);
> +    memory_region_init_alias(&lams->highmem, NULL, "loongarch.node0.highram",
> +                              machine->ram, offset, highram_size);
> +    memory_region_add_subregion(address_space_mem, phyAddr, &lams->highmem);
> +
> +    /* Node1 - Nodemax memory */
> +    offset += highram_size;
> +    phyAddr += highram_size;
> +
> +    for (i = 1; i < nb_numa_nodes; i++) {
> +        MemoryRegion *nodemem = g_new(MemoryRegion, 1);
> +        ramName = g_strdup_printf("loongarch.node%d.ram", i);
> +        memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
> +                                 offset,  numa_info[i].node_mem);
> +        memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
> +        memmap_add_entry(phyAddr, numa_info[i].node_mem, 1);
> +        fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
> +        offset += numa_info[i].node_mem;
> +        phyAddr += numa_info[i].node_mem;

In this loop, we allocate memory via g_strdup_printf(),
but never free it. The nicest fix for this is to use the
g_autofree mechanism so that the memory is automatically
freed when execution reaches the end of the block:
   g_autofree ramName = g_strdup_printf("....", ...);

thanks
-- PMM

