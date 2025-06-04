Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C0C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 20:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMuSJ-0002oC-Ur; Wed, 04 Jun 2025 16:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMuSA-0002k2-KX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:11:16 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMuS4-0002ba-S1
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:11:14 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-87df943b6dcso83384241.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749067866; x=1749672666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+17t3fFE31QgbRHY499ZmOYkcvSAVyuBz12D3S3U+lY=;
 b=gY5dfc26mOt51X7feyrBfK/mk6we6FQOpNAB+68OceVGoH4Z+1c0MG1xVDU0kanA2k
 +zb+gwKbn8B9XC9mq6Y52GSXVt/r/LD318RnWahZ2MwPzpArxXjO6gmogSSONZSND7RQ
 kp5plp5v30H0+PPCHPi75Pq8ktKKHaPUhVli7vQezS7c6Odtk4j6tw2MgcGyognUdSUt
 7vZYOJI81E4eA7JFRwA2w5E+66f6KkGQfD6u2PgXxJzWAZEc3CZCn/JGsgXZhADlY71T
 9WQtUz8E9nBeHUY5sOh3AcOXBE3xkkioRQm58HAAzM+01PAdgM7/3agKquXYpalcqmxY
 emlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749067866; x=1749672666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+17t3fFE31QgbRHY499ZmOYkcvSAVyuBz12D3S3U+lY=;
 b=Qv30V39nQbmFrXWHuNg5iGK1mkwfgq1QWJagrt4iUQgyYWbcfv7kQurOP5RIAgSpSs
 9RmDidnZWF0JzYWH8/PvRfvUVYEv870X+VYPRbD1Y29uktlHuorQfQfLPJ2vjWz27GJc
 lob1ZtqfDBObPL8eSelp0Iuhye6UViPKVyZeJW3Nq1UxlZqIfU1Kyzjbyc4pbIgZQu07
 ycZjom9hDHgt+JggZmKFQupfS/7/FSrw2fa43qRv3PwxEg1hPrx7B5y0XcvfmdJDjvwC
 KOxlZFBxIsYgVpw/Tn/5hpYwT9LFvqwalVG2AHD49byFqGvzM69TSXBvY7MTFOxhcWFH
 J0Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1dQdLl4HgsJ1+OwLi9WHVJVUzQBWyQjWaT44Fmxjc/kkm9sY3KAHWJ2zD+qubaNMr/oR4tHgZbg7u@nongnu.org
X-Gm-Message-State: AOJu0Ywej5C8WJF0wuSzWVTvViYUHgBe4SZ3MWzEWT9iZ0gmc7S9mJSo
 MxkfvaKhATm0WShShd/DSwAvg/RicmSKscDdGxOUKBp2oN9v50TTyzhLxPT60S7qLbI=
X-Gm-Gg: ASbGncux6SuiakT1IgISWCe6BLif1BKZVdR5GHeUBmsHZ6ZKYrQBG+oCtUlqWQS1cZc
 goatM31554YqIfui3RA5yjV/LCP1hyFh2q3WN5o346HhRBmEDG2OPa+ANoVD36Uz0DFJFR/J+Ox
 sReEi4kU6I65JOVQl4AUSnw1TJOXC9zpAn0/bpD03YWUiRqSGVVvR1GElJxnZV31WC+IaPM8VeQ
 RGWyFTHRQdC+XYPeJkjzBJ7W8/rtEZhykn+J5yg93fv+CN5BsCZk2MfADdvnhD6qpzvmc1oPUBo
 wRP7DD1cDFR20I1dwJltT+cBomaKNeaJW8cZCKuKrzSP91cmJaFIvWW0IZ23+r+HkKdaH53RZ5X
 DgQ==
X-Google-Smtp-Source: AGHT+IF8AKLzWaJXbViGnGrllMfyzjlaXfVdbyih/KVeKw6B/rzyWjo8oxkoI1TNWdp4x7Tm+Xqk3A==
X-Received: by 2002:a05:6122:828d:b0:52f:4680:1c75 with SMTP id
 71dfb90a1353d-530c739f782mr4483229e0c.6.1749067866185; 
 Wed, 04 Jun 2025 13:11:06 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074bf86c7sm11514129e0c.38.2025.06.04.13.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 13:11:04 -0700 (PDT)
Message-ID: <dbb9a033-6dad-49ad-b5ac-420d35249036@ventanamicro.com>
Date: Wed, 4 Jun 2025 17:11:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>, palmer@dabbelt.com, alistair23@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhangtj@tecorigin.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1747878772.git.lc00631@tecorigin.com>
 <3c7b570e2bb697dda770b4b82cd4adfeac2f189c.1747878772.git.lc00631@tecorigin.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <3c7b570e2bb697dda770b4b82cd4adfeac2f189c.1747878772.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x92b.google.com
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

Hi,

This patch is faling 'make check-functional':


  2/12 qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi                       ERROR            1.25s   exit status 1
  4/12 qemu:func-quick+func-riscv32 / func-riscv32-riscv_opensbi                       ERROR            1.39s   exit status 1
11/12 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv32-riscv32_tuxrun TIMEOUT         90.01s   killed by signal 15 SIGTERM
12/12 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-riscv64_tuxrun TIMEOUT        120.07s   killed by signal 15 SIGTERM


All those tests are timing out with a blank console, as if they're stalled.
I couldn't pinpoint exactly where the issue is, but removing the patch fixes
the test.

I'm afraid we'll need to drop it from riscv-to-apply.next. We'll need a v5
that passes this test.


Thanks,

Daniel

On 5/21/25 11:28 PM, Chao Liu wrote:
> riscv_plic_hart_config_string() when getting CPUState via qemu_get_cpu()
> should be consistent with keeping sifive_plic_realize()
> by hartid_base + cpu_index.
> 
> A better approach is to use cpu_by_arch_id() instead of qemu_get_cpu(),
> in riscv cpu_by_arch_id() uses the mhartid.
> 
> For non-numa or single-cluster machines, hartid_base should be 0.
> 
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> Reviewed-by: Alistair Francis <alistair23@gmail.com>
> ---
>   hw/intc/sifive_plic.c      | 4 ++--
>   hw/riscv/boot.c            | 4 ++--
>   hw/riscv/microchip_pfsoc.c | 2 +-
>   hw/riscv/sifive_u.c        | 5 +++--
>   hw/riscv/virt.c            | 2 +-
>   include/hw/riscv/boot.h    | 2 +-
>   6 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index 3160b216fd..8e7ebc0655 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -399,7 +399,7 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>        * hardware controlled when a PLIC is attached.
>        */
>       for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
> +        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
>           if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
>               error_setg(errp, "SEIP already claimed");
>               return;
> @@ -505,7 +505,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
>   
>       for (i = 0; i < plic->num_addrs; i++) {
>           int cpu_num = plic->addr_config[i].hartid;
> -        CPUState *cpu = qemu_get_cpu(cpu_num);
> +        CPUState *cpu = cpu_by_arch_id(cpu_num);
>   
>           if (plic->addr_config[i].mode == PLICMode_M) {
>               qdev_connect_gpio_out(dev, cpu_num - hartid_base + num_harts,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 828a867be3..aa775e846c 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
>    * Return the per-socket PLIC hart topology configuration string
>    * (caller must free with g_free())
>    */
> -char *riscv_plic_hart_config_string(int hart_count)
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count)
>   {
>       g_autofree const char **vals = g_new(const char *, hart_count + 1);
>       int i;
>   
>       for (i = 0; i < hart_count; i++) {
> -        CPUState *cs = qemu_get_cpu(i);
> +        CPUState *cs = cpu_by_arch_id(hart_base + i);
>           CPURISCVState *env = &RISCV_CPU(cs)->env;
>   
>           if (kvm_enabled()) {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 2e74783fce..6c0e3b22af 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -274,7 +274,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                   l2lim_mem);
>   
>       /* create PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
>   
>       /* PLIC */
>       s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index d69f942cfb..5f94b8d703 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>       MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
>       char *plic_hart_config;
> +    int hartid_base = 1;
>       int i, j;
>   
>       qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base);
>       qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
>       qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
>   
> @@ -829,7 +830,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>                                   l2lim_mem);
>   
>       /* create PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config = riscv_plic_hart_config_string(hartid_base, ms->smp.cpus);
>   
>       /* MMIO */
>       s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cf280a92e5..d094bd186b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1289,7 +1289,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>       g_autofree char *plic_hart_config = NULL;
>   
>       /* Per-socket PLIC hart topology configuration string */
> -    plic_hart_config = riscv_plic_hart_config_string(hart_count);
> +    plic_hart_config = riscv_plic_hart_config_string(base_hartid, hart_count);
>   
>       /* Per-socket PLIC */
>       return sifive_plic_create(
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 7d59b2e6c6..5937298646 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -40,7 +40,7 @@ typedef struct RISCVBootInfo {
>   
>   bool riscv_is_32bit(RISCVHartArrayState *harts);
>   
> -char *riscv_plic_hart_config_string(int hart_count);
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count);
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
>   target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,


