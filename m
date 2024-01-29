Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC80C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUSFn-00013N-Ll; Mon, 29 Jan 2024 09:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaobo55x@gmail.com>)
 id 1rUPxH-0001D0-Sd; Mon, 29 Jan 2024 06:37:35 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiaobo55x@gmail.com>)
 id 1rUPxF-0002dB-Dv; Mon, 29 Jan 2024 06:37:35 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-510221ab3ebso3373924e87.1; 
 Mon, 29 Jan 2024 03:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706528250; x=1707133050; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKXuOTmPQIT5ilguHC+Z35QQSxFntSutB+C3yQegR+A=;
 b=CPZUfcOUj2t8BJqGoB/clFxOtN1YR968YHpWYxOnisIqFR3XFdcCiQta0BsRn2fCTm
 8nCrulPpu7tViLaiat4ltTq9TehyO/WBdFwB85RA0JgRXjoLoOGVFOmkyWDGEb0h0v9s
 7oU9jjM1iiavCqi53XTdO2Enms5kLIAa0sPurS/T9MruruQGhGwx9JaXi41lfymteXDG
 I/Xyli7tRAiYhkYBsK6OUI8IvgAN+NlLsjGntGCMuQDyMUdDqC7OnyHokwZ+vosqDgFd
 NpUJT+PAaTRo9jsemxF3Fe1GLC+o/xGulShBUDGrm8xiMaF95YVbGjZkitPzokV0Ne0q
 aQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706528250; x=1707133050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKXuOTmPQIT5ilguHC+Z35QQSxFntSutB+C3yQegR+A=;
 b=JkMduL4yxnUoXyLop1X9wBarcPjuv9vWY0UVeZg0EjRW5ka61jiwKqmI+CYvq4v6uz
 lJ+f7x68hDlFKTWzx+IuJQdTeGwgqHJcuR9bgWAHGGAPFT3vlNzRblZ4qjBjhl3LhUP3
 3Mf9ONbGtmqJroJ3uX1L4stCElLnCaaXhIs/lNnOqRDCM6stPYAfBK6d/jjVEbJqu9wD
 A6Lp5mhCoqCh0wYn8YwLKyj5l2+CTxD0BHsOzdYGgLS08/ilCRi+Usn5AfJspT0vQAQD
 11jCu8gAlIs47Rso7vcSkfzTy5vwrAlHVn/anESWln0I0eTGYebNwsIEelCxWiJJVxvl
 mpKg==
X-Gm-Message-State: AOJu0YzsV28QL2ayDyTxHXTrSGFNUmPVYnjJSQImiiy3j/9SQhvBuSyl
 KZC/Cj6xn56fs0fhDbS3EIAK1ocOT+S5ud1uIGI4ViebB4OPUL6kYdg9Jst3Osdlg/EDYty/JQJ
 v1YxvKXAkaPkZU5YwO+oXTbaakKpAZkrc
X-Google-Smtp-Source: AGHT+IFb3HKf5n14KmQqA3vzJM4csTyyNThQW7+iKaHO7tSjP4eKoI/akgyahV4DdOnOb99Gr2IQ1WQkctF3xV25MNM=
X-Received: by 2002:ac2:42c2:0:b0:510:f47:b3f1 with SMTP id
 n2-20020ac242c2000000b005100f47b3f1mr3034432lfl.16.1706528249457; Mon, 29 Jan
 2024 03:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20240129094200.3581037-1-haibo1.xu@intel.com>
 <20240129-57c26b01f7115ac2706d7c8d@orel>
In-Reply-To: <20240129-57c26b01f7115ac2706d7c8d@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 29 Jan 2024 19:37:17 +0800
Message-ID: <CAJve8onHNCDx_QZKi=AtvpAJjnEWu+X==GrmXb30a=+e=WOLbg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 sunilvl@ventanamicro.com, palmer@dabbelt.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=xiaobo55x@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jan 2024 09:04:47 -0500
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

On Mon, Jan 29, 2024 at 5:47=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Jan 29, 2024 at 05:42:00PM +0800, Haibo Xu wrote:
> > Enable ACPI NUMA support by adding the following 2 ACPI tables:
> > SRAT: provides the association for memory/Harts and Proximity Domains
> > SLIT: provides the relative distance between Proximity Domains
> >
> > The SRAT RINTC Affinity Structure definition[1] was based on the recent=
ly
> > approved ACPI CodeFirst ECR[2].
> >
> > [1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
> > [2] https://mantis.uefi.org/mantis/view.php?id=3D2433
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  hw/riscv/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 26c7e4482d..f0a6b61747 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -528,11 +528,61 @@ static void build_madt(GArray *table_data,
> >      acpi_table_end(linker, &table);
> >  }
> >
> > +/*
> > + * ACPI spec, Revision 6.5+
> > + * 5.2.16 System Resource Affinity Table (SRAT)
> > + * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
> > + *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS0=
8tX/view
> > + */
> > +static void
> > +build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms=
)
> > +{
> > +    int i;
> > +    uint64_t mem_base;
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> > +    MachineState *ms =3D MACHINE(vms);
> > +    const CPUArchIdList *cpu_list =3D mc->possible_cpu_arch_ids(ms);
> > +    AcpiTable table =3D { .sig =3D "SRAT", .rev =3D 3, .oem_id =3D vms=
->oem_id,
> > +                        .oem_table_id =3D vms->oem_table_id };
> > +
> > +    acpi_table_begin(&table, table_data);
> > +    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
> > +
> > +    for (i =3D 0; i < cpu_list->len; ++i) {
> > +        uint32_t nodeid =3D cpu_list->cpus[i].props.node_id;
> > +        /*
> > +         * 5.2.16.8 RINTC Affinity Structure
> > +         */
> > +        build_append_int_noprefix(table_data, 7, 1);      /* Type */
> > +        build_append_int_noprefix(table_data, 20, 1);     /* Length */
> > +        build_append_int_noprefix(table_data, 0, 2);        /* Reserve=
d */
> > +        build_append_int_noprefix(table_data, nodeid, 4); /* Proximity=
 Domain */
> > +        build_append_int_noprefix(table_data, i, 4); /* ACPI Processor=
 UID */
> > +        /* Flags, Table 5-70 */
> > +        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */, =
4);
> > +        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain *=
/
> > +    }
> > +
> > +    mem_base =3D vms->memmap[VIRT_DRAM].base;
> > +    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
> > +        if (ms->numa_state->nodes[i].node_mem > 0) {
> > +            build_srat_memory(table_data, mem_base,
> > +                              ms->numa_state->nodes[i].node_mem, i,
> > +                              MEM_AFFINITY_ENABLED);
> > +            mem_base +=3D ms->numa_state->nodes[i].node_mem;
> > +        }
> > +    }
> > +
> > +    acpi_table_end(linker, &table);
> > +}
> > +
> >  static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables=
)
> >  {
> >      GArray *table_offsets;
> >      unsigned dsdt, xsdt;
> >      GArray *tables_blob =3D tables->table_data;
> > +    MachineState *ms =3D MACHINE(s);
> >
> >      table_offsets =3D g_array_new(false, true,
> >                                  sizeof(uint32_t));
> > @@ -565,6 +615,16 @@ static void virt_acpi_build(RISCVVirtState *s, Acp=
iBuildTables *tables)
> >                     s->oem_table_id);
> >      }
> >
> > +    if (ms->numa_state->num_nodes > 0) {
> > +        acpi_add_table(table_offsets, tables_blob);
> > +        build_srat(tables_blob, tables->linker, s);
> > +        if (ms->numa_state->have_numa_distance) {
> > +            acpi_add_table(table_offsets, tables_blob);
> > +            build_slit(tables_blob, tables->linker, ms, s->oem_id,
> > +                       s->oem_table_id);
> > +        }
> > +    }
> > +
> >      /* XSDT is pointed to by RSDP */
> >      xsdt =3D tables_blob->len;
> >      build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
> > --
> > 2.34.1
> >
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks for the review, Andrew!

