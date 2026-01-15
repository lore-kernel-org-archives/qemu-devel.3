Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D4D44C7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQSU-0003kw-9W; Thu, 15 Jan 2026 11:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQSJ-0003g4-Eg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:44:19 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQSG-0001pE-Lb
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:44:18 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8c537b9fcbfso114884085a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768495456; x=1769100256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o0+gOSRqlp7DyayT0/HW1gwqciLXbSm8CoSAJ3Ka0ec=;
 b=jSlPhBAyJJZNGujXR7BoBSdr7aaooMtFG7BFgdAjiGbm+FKQjY4QruveUzy8awQ6K+
 oJyk8ZLOLUUeRtWQTn7k7/9zD9EY2yEgg7lj07Co8CRi4qHWLlwfJBf6+i811rdbf1u0
 BD6cbGd6ArkBL7/qm4qMj+GZbHq22F03cmj3bq1FKAv+UGxMYP1Q8UK0x339QPBvh4RC
 iW6PC1vdF8U+gSfCb6kVoS1tJ78cMCL2DZBiNdk+bKLeCSbLQNGOhrxgsiioBx+VQOl3
 lKXJO0WsRQzviPiIc+q3wTM6jrTDHN636AqvObHYzwQ0MHwpjqrqMLoaWRghl8RmKFUY
 3/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495456; x=1769100256;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0+gOSRqlp7DyayT0/HW1gwqciLXbSm8CoSAJ3Ka0ec=;
 b=Rv5SinaY/QKNa97xtw1Ro94O5vI/A7aZUjIRynTmqC9TH14Aowf6dN89MX+xvVFtdk
 pt7wfbWO3y48/W2w7irCHQjETpRdYnYLj7N9dJ8bOfP+89AGazjcks2G7H+2YGzgGT7g
 5ONubQt++OHEy+vlRZVmKCbJKPRoUVtyoayyUO4+QHPgu1FNSBNIJEapK9ybjvAZ61no
 M7VBDzP7KcfEqdCAtxtaPwqrb203ig42flKHcSzT7Grw4OFUKixQYHwvTucNGiz+WidP
 neWw0KFbG33Lm2s8kL7XH4dEkAwryzd4A6UnbPLeR5Nk17dVb0sDhqO8KlAz7Gq4C5pO
 f3Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWChrnzz1zvhzKFqh7a3pUBOHHCO9Ps3o5HQ5tYomilRCKzi7aZBMEaKzcZx9RtgzSezlKUQ/8rHyOu@nongnu.org
X-Gm-Message-State: AOJu0YwnFjUIKvPArTySNM1lBNHOSmdtU4dLrVKiFUwUy5NVe1tzCg4+
 lJpbMgyFkAC0Gg1URHmKiWeMNnBKfAshqijdRBwvP5uWZUdtj0C6iCaovUYwbljEhNg=
X-Gm-Gg: AY/fxX6xZepq9R945O/DtYeTXBRqNSg29d4qwd8YK2QeLcHOnPdIelFNjNERcZAjFcH
 5aJNwCvAcdhheK78aRkC6J8tpuWqPt2and/jeEu6jXIHJt3m5YcvYdwdyMjZOp7laRDMPwemcAp
 4ekzruUzocJ4wqBw/L9v2UBn83cl3xqpZFPK8yXZEQR3zcnvnF58GbxOpPE45P43syQiEMEny2E
 Ulva4gBopFQq2ZWnEttNd9WNcmfJh/KPmAIkEz4RttMYcqigHoBTxi9GBjPkpyT4E4AuZJmda1q
 rSjz+JKo1DQ93A3sGMvxS9koGymWkfXU++472tEUeoBi+rqKUPVTG5uAo/480zVvsA0NCDvOAoD
 thb7UWv/tmgTBgraEPVWBz1diZFDhVZGUqQiVjC7eMYu9OrVlB9OhfR0GMGrzJtINOCp9EgNAXT
 OPgx1Dl+WDMMYJwnpGSyw5mg1Dm9DmfhnrxaFQCYTH
X-Received: by 2002:a05:620a:3947:b0:8c5:3045:854f with SMTP id
 af79cd13be357-8c5919fe2cdmr489549485a.30.1768495455595; 
 Thu, 15 Jan 2026 08:44:15 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530bacb43sm448785185a.41.2026.01.15.08.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:44:15 -0800 (PST)
Message-ID: <e0031103-64aa-4ffd-b1ea-0d1aa932c8fd@ventanamicro.com>
Date: Thu, 15 Jan 2026 13:44:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/riscv/boot: Account for discontiguous memory when
 loading firmware
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109131657.396794-1-joel@jms.id.au>
 <20260109131657.396794-3-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109131657.396794-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x736.google.com
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



On 1/9/2026 10:16 AM, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> This loads firmware into the first (low) memory range,
> accounting for machines having discontiguous memory regions.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/boot.h    |  5 ++++-
>   hw/riscv/boot.c            | 18 ++++++++++++------
>   hw/riscv/microchip_pfsoc.c |  6 ++++--
>   hw/riscv/opentitan.c       |  6 ++++--
>   hw/riscv/shakti_c.c        |  6 +++++-
>   hw/riscv/sifive_u.c        |  3 ++-
>   hw/riscv/spike.c           |  6 ++++--
>   hw/riscv/virt.c            |  7 ++++---
>   hw/riscv/xiangshan_kmh.c   |  6 +++++-
>   9 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 115e3222174f..fb90bf12399e 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
>   vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr);
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                       const char *default_machine_firmware,
>                                       hwaddr *firmware_load_addr,
>                                       symbol_fn_t sym_cb);
>   const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>   char *riscv_find_firmware(const char *firmware_filename,
>                             const char *default_machine_firmware);
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                              hwaddr *firmware_load_addr,
>                              symbol_fn_t sym_cb);
>   void riscv_load_kernel(MachineState *machine,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 9babb85b0458..f3857e984240 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -145,6 +145,7 @@ char *riscv_find_firmware(const char *firmware_filename,
>   }
>   
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                       const char *default_machine_firmware,
>                                       hwaddr *firmware_load_addr,
>                                       symbol_fn_t sym_cb)
> @@ -157,7 +158,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
>   
>       if (firmware_filename) {
>           /* If not "none" load the firmware */
> -        firmware_end_addr = riscv_load_firmware(firmware_filename,
> +        firmware_end_addr = riscv_load_firmware(machine, info,
> +                                                firmware_filename,
>                                                   firmware_load_addr, sym_cb);
>           g_free(firmware_filename);
>       }
> @@ -165,10 +167,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
>       return firmware_end_addr;
>   }
>   
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                              hwaddr *firmware_load_addr,
>                              symbol_fn_t sym_cb)
>   {
> +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
>       uint64_t firmware_entry, firmware_end;
>       ssize_t firmware_size;
>   
> @@ -183,7 +188,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
>   
>       firmware_size = load_image_targphys_as(firmware_filename,
>                                              *firmware_load_addr,
> -                                           current_machine->ram_size, NULL,
> +                                           mem_size, NULL,
>                                              NULL);
>   
>       if (firmware_size > 0) {
> @@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
>   static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
>   {
>       const char *filename = machine->initrd_filename;
> -    uint64_t mem_size = machine->ram_size;
> +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
>       void *fdt = machine->fdt;
>       hwaddr start, end;
>       ssize_t size;
> @@ -243,6 +248,7 @@ void riscv_load_kernel(MachineState *machine,
>                          bool load_initrd,
>                          symbol_fn_t sym_cb)
>   {
> +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
>       const char *kernel_filename = machine->kernel_filename;
>       ssize_t kernel_size;
>       void *fdt = machine->fdt;
> @@ -274,7 +280,7 @@ void riscv_load_kernel(MachineState *machine,
>       }
>   
>       kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
> -                                         current_machine->ram_size, NULL, NULL);
> +                                         mem_size, NULL, NULL);
>       if (kernel_size > 0) {
>           info->kernel_size = kernel_size;
>           info->image_low_addr = kernel_start_addr;
> @@ -370,7 +376,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
>       dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
>   
>       if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
> -        error_report("No enough memory to place DTB after kernel/initrd");
> +        error_report("Not enough memory to place DTB after kernel/initrd");
>           exit(1);
>       }
>   
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4ff83e494034..8905ed0ba190 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -615,18 +615,20 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>           firmware_load_addr = RESET_VECTOR;
>       }
>   
> +    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> +
>       /* Load the firmware if necessary */
>       firmware_end_addr = firmware_load_addr;
>       if (firmware_name) {
>           char *filename = riscv_find_firmware(firmware_name, NULL);
>           if (filename) {
> -            firmware_end_addr = riscv_load_firmware(filename,
> +            firmware_end_addr = riscv_load_firmware(machine, &boot_info,
> +                                                    filename,
>                                                       &firmware_load_addr, NULL);
>               g_free(filename);
>           }
>       }
>   
> -    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>       if (machine->kernel_filename) {
>           kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
>                                                            firmware_end_addr);
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 309125e854bc..8cd660dd4154 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -99,12 +99,14 @@ static void opentitan_machine_init(MachineState *machine)
>       memory_region_add_subregion(sys_mem,
>           memmap[IBEX_DEV_RAM].base, machine->ram);
>   
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
>       if (machine->firmware) {
>           hwaddr firmware_load_addr = memmap[IBEX_DEV_RAM].base;
> -        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
> +        riscv_load_firmware(machine, &boot_info, machine->firmware,
> +                            &firmware_load_addr, NULL);
>       }
>   
> -    riscv_boot_info_init(&boot_info, &s->soc.cpus);
>       if (machine->kernel_filename) {
>           riscv_load_kernel(machine, &boot_info,
>                             memmap[IBEX_DEV_RAM].base,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 49a39b30212d..eb720d9cdf5d 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
>   {
>       ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
>       MemoryRegion *system_memory = get_system_memory();
> +    RISCVBootInfo boot_info;
>       hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
>   
>       /* Initialize SoC */
> @@ -57,8 +58,11 @@ static void shakti_c_machine_state_init(MachineState *mstate)
>                                   shakti_c_memmap[SHAKTI_C_RAM].base,
>                                   mstate->ram);
>   
> +    riscv_boot_info_init(&boot_info, &sms->soc.cpus);
> +
>       if (mstate->firmware) {
> -        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL);
> +        riscv_load_firmware(mstate, &boot_info, mstate->firmware,
> +                            &firmware_load_addr, NULL);
>       }
>   
>       /* ROM reset vector */
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7ec67b256514..4c526f73edf6 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -590,7 +590,8 @@ static void sifive_u_machine_init(MachineState *machine)
>       }
>   
>       firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
> -    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
> +    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
> +                                                     firmware_name,
>                                                        &start_addr, NULL);
>   
>       riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 1493b928dad3..86b06a173565 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -289,9 +289,12 @@ static void spike_board_init(MachineState *machine)
>           }
>       }
>   
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
>       /* Load firmware */
>       if (firmware_name) {
> -        firmware_end_addr = riscv_load_firmware(firmware_name,
> +        firmware_end_addr = riscv_load_firmware(machine, &boot_info,
> +                                                firmware_name,
>                                                   &firmware_load_addr,
>                                                   htif_symbol_callback);
>           g_free(firmware_name);
> @@ -301,7 +304,6 @@ static void spike_board_init(MachineState *machine)
>       create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
>   
>       /* Load kernel */
> -    riscv_boot_info_init(&boot_info, &s->soc[0]);
>       if (machine->kernel_filename) {
>           kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
>                                                            firmware_end_addr);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bd8608ea5bfd..a907ca359e09 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1466,7 +1466,10 @@ static void virt_machine_done(Notifier *notifier, void *data)
>           }
>       }
>   
> -    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
> +    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
> +                                                     firmware_name,
>                                                        &start_addr, NULL);
>   
>       pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
> @@ -1489,8 +1492,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
>           }
>       }
>   
> -    riscv_boot_info_init(&boot_info, &s->soc[0]);
> -
>       if (machine->kernel_filename && !kernel_entry) {
>           kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
>                                                            firmware_end_addr);
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index 436e51c1c593..247a0b5d1f21 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -166,6 +166,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
>       const MemMapEntry *memmap = xiangshan_kmh_memmap;
>       MemoryRegion *system_memory = get_system_memory();
>       hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
> +    RISCVBootInfo boot_info;
>   
>       /* Initialize SoC */
>       object_initialize_child(OBJECT(machine), "soc", &s->soc,
> @@ -177,13 +178,16 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
>                                   memmap[XIANGSHAN_KMH_DRAM].base,
>                                   machine->ram);
>   
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
>       /* ROM reset vector */
>       riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
>                                 start_addr,
>                                 memmap[XIANGSHAN_KMH_ROM].base,
>                                 memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
>       if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware, &start_addr, NULL);
> +        riscv_load_firmware(machine, &boot_info, machine->firmware,
> +                            &start_addr, NULL);
>       }
>   
>       /* Note: dtb has been integrated into firmware(OpenSBI) when compiling */


