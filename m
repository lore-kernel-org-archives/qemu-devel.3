Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944FEC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNhp-0008PR-80; Fri, 23 Feb 2024 00:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNhn-0008P5-FJ; Fri, 23 Feb 2024 00:02:39 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNhl-00086m-99; Fri, 23 Feb 2024 00:02:39 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d698a8d93cso243930241.3; 
 Thu, 22 Feb 2024 21:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708664555; x=1709269355; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Bhr4Lnn6M1GXFmf87eK649RhlULSBlPbmKNI0yHS+s=;
 b=NdDyK89NrXmSrj4RIKUFDL+pvyqwIQuN7rR4zx+kN61aZYgxfHho5ZgZTSgYf96nr0
 4X58uce8Yz8DWT1Moz0CEdjiHswNyL1h9Rmtq8Zd9mPhGCpwlTeyyzolu6buuCLya3YS
 gImySIcVH/UoMMvDYHwWOny6amLS/hCIxQ/jEStfHsz3lNghBGqMJ+/DG1L6nnMnoACS
 hs30KV3wFp62irkp/zkv8H/TaXXgUj6JN3RHGfNv+Zxy2pvUDLW5ZAgUHwY49E6mOe8Y
 whCp9wOk2O/wPB5Kzr6AeqHpeaR+ykdSiPesgA1nU+Xh/pD9drxNyi6h1m7c/ua9aFcB
 JY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708664555; x=1709269355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Bhr4Lnn6M1GXFmf87eK649RhlULSBlPbmKNI0yHS+s=;
 b=TZfSt6O5LLZQSdE93C4WW+Ln8tHb6utwXcu5X7hMqsFKkXOkjUM/+r3cOMEzdiY6nC
 ej5P4c1LOxWrymRLxgXY8KYmSB/fr+9Kvxs8c6ffcuN5x2q4wnD6E68qW2aEyuIwwZn3
 fBnmRoG0ZPV/SqwJdWUOOW0JxPbGeFldVV/B5Tfkq5gZiOfnIM6ZYfyuzrm4JtyWGsyH
 XtL4akXA4M3cgDech/E+jhvPbVB9TG0e090GjIqwZrL2HZ7gtKGpC2C5NLl1fCyLB20r
 fnCGzh7WOt67Dns5i8+85ZxNqdvWC8Rtv+Yy+YK8UvgWShY/ZOVd6mmVzWO6cPmV3Qne
 nszg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWINB4PaKE6PQr8E7tC3sMK6Io/wl3xcYy2Mf1xCkXGYbvB29zVrvXRBzmCKoJFsWknePMrGbM4CfnVmHf+Lm0b0PML9qM=
X-Gm-Message-State: AOJu0YwC21tXlT4JcXlNhpQgqlCI2R+kXLFavASoyS31LigQEa7hBug2
 tqUSXladaKet2JKnRtBqhh6k+KTjEUEyA3aEVgToQ2lawf8cH9OKVGj/xZlzJuLq9VjJZq50jyk
 sCN1Qf7MupQrIt3HewCvNPNRLvRw=
X-Google-Smtp-Source: AGHT+IG7uNZNet8vgt9Wg17reeNwfCBJhnEfRYqn18j5UkgX4ETHny58lQFL6cZ8oUgH//qMCNXqwTL3modX8KoQ2NA=
X-Received: by 2002:a05:6102:30ac:b0:470:489c:5a29 with SMTP id
 y12-20020a05610230ac00b00470489c5a29mr1004537vsd.2.1708664555607; Thu, 22 Feb
 2024 21:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20240129094200.3581037-1-haibo1.xu@intel.com>
In-Reply-To: <20240129094200.3581037-1-haibo1.xu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Feb 2024 15:02:08 +1000
Message-ID: <CAKmqyKOfojvnVxBHk82M86Sd-SJrNFweE_UE=AL6wG_cvgu6yA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
To: Haibo Xu <haibo1.xu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, xiaobo55x@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 30, 2024 at 12:05=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wro=
te:
>
> Enable ACPI NUMA support by adding the following 2 ACPI tables:
> SRAT: provides the association for memory/Harts and Proximity Domains
> SLIT: provides the relative distance between Proximity Domains
>
> The SRAT RINTC Affinity Structure definition[1] was based on the recently
> approved ACPI CodeFirst ECR[2].
>
> [1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
> [2] https://mantis.uefi.org/mantis/view.php?id=3D2433
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

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
> + *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08t=
X/view
> + */
> +static void
> +build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
> +{
> +    int i;
> +    uint64_t mem_base;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> +    MachineState *ms =3D MACHINE(vms);
> +    const CPUArchIdList *cpu_list =3D mc->possible_cpu_arch_ids(ms);
> +    AcpiTable table =3D { .sig =3D "SRAT", .rev =3D 3, .oem_id =3D vms->=
oem_id,
> +                        .oem_table_id =3D vms->oem_table_id };
> +
> +    acpi_table_begin(&table, table_data);
> +    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
> +
> +    for (i =3D 0; i < cpu_list->len; ++i) {
> +        uint32_t nodeid =3D cpu_list->cpus[i].props.node_id;
> +        /*
> +         * 5.2.16.8 RINTC Affinity Structure
> +         */
> +        build_append_int_noprefix(table_data, 7, 1);      /* Type */
> +        build_append_int_noprefix(table_data, 20, 1);     /* Length */
> +        build_append_int_noprefix(table_data, 0, 2);        /* Reserved =
*/
> +        build_append_int_noprefix(table_data, nodeid, 4); /* Proximity D=
omain */
> +        build_append_int_noprefix(table_data, i, 4); /* ACPI Processor U=
ID */
> +        /* Flags, Table 5-70 */
> +        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */, 4)=
;
> +        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain */
> +    }
> +
> +    mem_base =3D vms->memmap[VIRT_DRAM].base;
> +    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
> +        if (ms->numa_state->nodes[i].node_mem > 0) {
> +            build_srat_memory(table_data, mem_base,
> +                              ms->numa_state->nodes[i].node_mem, i,
> +                              MEM_AFFINITY_ENABLED);
> +            mem_base +=3D ms->numa_state->nodes[i].node_mem;
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
>      GArray *tables_blob =3D tables->table_data;
> +    MachineState *ms =3D MACHINE(s);
>
>      table_offsets =3D g_array_new(false, true,
>                                  sizeof(uint32_t));
> @@ -565,6 +615,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiB=
uildTables *tables)
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
>      xsdt =3D tables_blob->len;
>      build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
> --
> 2.34.1
>
>

