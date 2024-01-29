Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8917C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOEs-0007a3-At; Mon, 29 Jan 2024 04:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUOEo-0007YX-3w
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:47:36 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUOEj-0003Cx-SY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:47:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55f12332350so487202a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706521647; x=1707126447; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2SdD70UvXwqqaIxa5zWTxE0Ee/ACRppVD/9fjnRK5yw=;
 b=AxV9w2KgabhBdAIV3Jwd4p/lQyMt0pGfunFFl7DRISqIk5qFADWzYWKl+NfYyFQ3GY
 wifK4eVC/yk6XdiWSEK0BV8KTDyvnf6wDRam9gTdnGGk98r5VyHsIUCdaqpuowldDIZK
 +ooVZZJ3jRhMYwHg79Z3mQ+/CQvH8fOVqG5NLo3nElr5g9MEDOPe2Xl9tC1xenug31nT
 A6diTf6J7BhsSpKy/I7qanne1dE0LAZgh1IdTmoN96n+3+AkBPXkgxAaLOBlpzgNWsGs
 EDsuX92HDEWRUnrnHtZGJkwom7vygtm+1IXNLZTyVAayi1e8plLg2hfUnyo1k9DUSXf6
 jBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706521647; x=1707126447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SdD70UvXwqqaIxa5zWTxE0Ee/ACRppVD/9fjnRK5yw=;
 b=h0pbDwvGF8Elc5aq8Uub1N5sa6Vb+iT+HXjHzjMcQKY6WrwNCmsGEoDzOROCm7OLzW
 c2rADgCRlAzQksxG2mq7n4hY18T5seO3uM1t5UOk9l8TZwD3f3DgFafJXE+GPTTUDaAo
 iinvtCRum4ZRVIB+FUu9DpDUUh6oybKA/cOQnZrY7DbcnGdVMeuKXQ/E0DsffBxgp8hQ
 B0uJsyLXYKlE/QYm20mHiXbjWO8M1a+n+cHCxSyZLmNFxh5pi3kqKje6JeIpyMi13vM4
 FveFL+i8tcnGlJA5Vtt2V2IpsZ7QV93YBF/YlF9/1BVYMJtYIGTEUiWTQj+Pf7ZSbp99
 xVtg==
X-Gm-Message-State: AOJu0Yw5+jA1J96ZbBvHnhh1vkxPST3lEjOun9ty6WpFTJoBeBfAqPAi
 VBTq3s1vfeUVJblFc4OMM/d64ZBXvPkmg3PTTfZDEQANtaCCvpWrhuH/fof5ZFc=
X-Google-Smtp-Source: AGHT+IF7OiQUdugifWG+5OTQ+vV/9paViPfwvWgswhX4ydJiABfvv6WrqxyW9Y0XauqcBx/2C1ADrQ==
X-Received: by 2002:a17:906:2c16:b0:a35:dd48:760d with SMTP id
 e22-20020a1709062c1600b00a35dd48760dmr638042ejh.44.1706521647234; 
 Mon, 29 Jan 2024 01:47:27 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ss6-20020a170907c00600b00a3533f17981sm2761030ejc.219.2024.01.29.01.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 01:47:26 -0800 (PST)
Date: Mon, 29 Jan 2024 10:47:25 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, xiaobo55x@gmail.com
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
Message-ID: <20240129-57c26b01f7115ac2706d7c8d@orel>
References: <20240129094200.3581037-1-haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129094200.3581037-1-haibo1.xu@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 29, 2024 at 05:42:00PM +0800, Haibo Xu wrote:
> Enable ACPI NUMA support by adding the following 2 ACPI tables:
> SRAT: provides the association for memory/Harts and Proximity Domains
> SLIT: provides the relative distance between Proximity Domains
> 
> The SRAT RINTC Affinity Structure definition[1] was based on the recently
> approved ACPI CodeFirst ECR[2].
> 
> [1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
> [2] https://mantis.uefi.org/mantis/view.php?id=2433
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  hw/riscv/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 26c7e4482d..f0a6b61747 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -528,11 +528,61 @@ static void build_madt(GArray *table_data,
>      acpi_table_end(linker, &table);
>  }
>  
> +/*
> + * ACPI spec, Revision 6.5+
> + * 5.2.16 System Resource Affinity Table (SRAT)
> + * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
> + *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view
> + */
> +static void
> +build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
> +{
> +    int i;
> +    uint64_t mem_base;
> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    MachineState *ms = MACHINE(vms);
> +    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
> +    AcpiTable table = { .sig = "SRAT", .rev = 3, .oem_id = vms->oem_id,
> +                        .oem_table_id = vms->oem_table_id };
> +
> +    acpi_table_begin(&table, table_data);
> +    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
> +
> +    for (i = 0; i < cpu_list->len; ++i) {
> +        uint32_t nodeid = cpu_list->cpus[i].props.node_id;
> +        /*
> +         * 5.2.16.8 RINTC Affinity Structure
> +         */
> +        build_append_int_noprefix(table_data, 7, 1);      /* Type */
> +        build_append_int_noprefix(table_data, 20, 1);     /* Length */
> +        build_append_int_noprefix(table_data, 0, 2);        /* Reserved */
> +        build_append_int_noprefix(table_data, nodeid, 4); /* Proximity Domain */
> +        build_append_int_noprefix(table_data, i, 4); /* ACPI Processor UID */
> +        /* Flags, Table 5-70 */
> +        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */, 4);
> +        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain */
> +    }
> +
> +    mem_base = vms->memmap[VIRT_DRAM].base;
> +    for (i = 0; i < ms->numa_state->num_nodes; ++i) {
> +        if (ms->numa_state->nodes[i].node_mem > 0) {
> +            build_srat_memory(table_data, mem_base,
> +                              ms->numa_state->nodes[i].node_mem, i,
> +                              MEM_AFFINITY_ENABLED);
> +            mem_base += ms->numa_state->nodes[i].node_mem;
> +        }
> +    }
> +
> +    acpi_table_end(linker, &table);
> +}
> +
>  static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>  {
>      GArray *table_offsets;
>      unsigned dsdt, xsdt;
>      GArray *tables_blob = tables->table_data;
> +    MachineState *ms = MACHINE(s);
>  
>      table_offsets = g_array_new(false, true,
>                                  sizeof(uint32_t));
> @@ -565,6 +615,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                     s->oem_table_id);
>      }
>  
> +    if (ms->numa_state->num_nodes > 0) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_srat(tables_blob, tables->linker, s);
> +        if (ms->numa_state->have_numa_distance) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_slit(tables_blob, tables->linker, ms, s->oem_id,
> +                       s->oem_table_id);
> +        }
> +    }
> +
>      /* XSDT is pointed to by RSDP */
>      xsdt = tables_blob->len;
>      build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
> -- 
> 2.34.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

