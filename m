Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E007C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJxP-0002gz-BW; Tue, 20 Feb 2024 01:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaobo55x@gmail.com>)
 id 1rcJxM-0002fk-VC; Tue, 20 Feb 2024 01:50:20 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiaobo55x@gmail.com>)
 id 1rcJxK-0004t2-T0; Tue, 20 Feb 2024 01:50:20 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d21a68dd3bso47669961fa.1; 
 Mon, 19 Feb 2024 22:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708411814; x=1709016614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jerEFqeV8dlegpb7wXd2GUyRoRNtR5Zj2wny2aiCEz8=;
 b=DUzn6RRWLtDBEJ5xSPz1cdKRoPnRAZWoWhu9g6gNX1LCcedfnNOnxOgGI5KWmKuKkP
 sg8bTpG2ko8bCedSzaIoaV6PW8xEH34BBFR00UgQQM5c5N1fmZnnKdqKX8FbnwCRSw+p
 x4XOPpZ96EP8tSuAQstEuaeBc35ckDgZACPPZCuor2PX7F9bLQIhaVoJc+PSiigz9sgc
 PXzdNADLeN64rc81yu6wVT1qMEJhZKP0wYP6IqDWrM+TXHHgLcUqn0yYiRVZ41eu3SuE
 v4FvaZ0IbKoVxv59q0Uioarig7lhvu1YAQmYWw+Uzhry3UNw6rjI1DPp2HmCC8d9o0Kj
 VqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411814; x=1709016614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jerEFqeV8dlegpb7wXd2GUyRoRNtR5Zj2wny2aiCEz8=;
 b=Ss9x2o5bf/U5M8AFoX8fnNumyo3m2nzLgwexfm2Go1Xb0S/zGZKD0Wq9hYWdbwgKUH
 VVS2k9tMeKiGFDHPHwhrm/pFcCJ+x/bcsVZi/9N41Ea+mz4zOTQQbdWdpbbwHE6oEnzD
 7JuZUWHax5e9wIoggHabPouO7/XNumLq73GfT5VY/4sA7S8YYSZXtAXFclqSqP3n6rTH
 PpDsaF6ChYhN/43cViti8YaUqtWCJJE3Gi2Z8jj0Crj/ayllNeSol/+ikxdMiZRlPHT3
 Av5n/Y01dCVab4JUFcp4wpxayaQSYLUefYORphdBUVPctzrUkF0edJviXdV+TJiwyuF/
 KP9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK0UXOPRZioE62DowZaa1IfUkLCq9FzGs5OTmlYvPvllgWHgzZn7m3t26l/0D4N2DxxWnmvi/LMOC0gO8WQIRWl1hJ6o+V3TKwHdQMnlyoTMGs6IoAd9C8BlQOcg==
X-Gm-Message-State: AOJu0YydlRLWMEhTqIpUPuNV56TBguEaLuPjPTyoiLxRoXIDVJ8dhxwc
 iZ2YPn83V9d3S+NORdNuzymIUQPBQAE7ODA+frxlY43TmKySSvZvJgABEA/BCyFVBO6BuUW/AuT
 hwgyT2+6AMkkEliuVjbPe4nQlK8M=
X-Google-Smtp-Source: AGHT+IEM4BgDbXD68XOHYEmQa7kX5zqJ4ZYWEDmZULvjDApSBpS7FACKXhbstN3sI6W0tZzgPc6srKotMOEbJtUkpgk=
X-Received: by 2002:a2e:a54a:0:b0:2d2:4cb2:59e4 with SMTP id
 e10-20020a2ea54a000000b002d24cb259e4mr360965ljn.31.1708411813798; Mon, 19 Feb
 2024 22:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20240129094200.3581037-1-haibo1.xu@intel.com>
 <20240129-57c26b01f7115ac2706d7c8d@orel>
 <CAJve8onHNCDx_QZKi=AtvpAJjnEWu+X==GrmXb30a=+e=WOLbg@mail.gmail.com>
In-Reply-To: <CAJve8onHNCDx_QZKi=AtvpAJjnEWu+X==GrmXb30a=+e=WOLbg@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 20 Feb 2024 14:50:02 +0800
Message-ID: <CAJve8o=kxLck5qJVXi_WDf2QYM8H=7CFDc11WdYnGyyGD+TuAw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add SRAT and SLIT ACPI tables
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 sunilvl@ventanamicro.com, palmer@dabbelt.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=xiaobo55x@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

++Alistair.

Sorry for that! It seems some typo or paste issue occurred when
pushing the patch.

Hi Alistair,

Could you help review this patch?

Thanks,
Haibo

On Mon, Jan 29, 2024 at 7:37=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wrot=
e:
>
> On Mon, Jan 29, 2024 at 5:47=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Mon, Jan 29, 2024 at 05:42:00PM +0800, Haibo Xu wrote:
> > > Enable ACPI NUMA support by adding the following 2 ACPI tables:
> > > SRAT: provides the association for memory/Harts and Proximity Domains
> > > SLIT: provides the relative distance between Proximity Domains
> > >
> > > The SRAT RINTC Affinity Structure definition[1] was based on the rece=
ntly
> > > approved ACPI CodeFirst ECR[2].
> > >
> > > [1] https://github.com/riscv-non-isa/riscv-acpi/issues/25
> > > [2] https://mantis.uefi.org/mantis/view.php?id=3D2433
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  hw/riscv/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 60 insertions(+)
> > >
> > > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > > index 26c7e4482d..f0a6b61747 100644
> > > --- a/hw/riscv/virt-acpi-build.c
> > > +++ b/hw/riscv/virt-acpi-build.c
> > > @@ -528,11 +528,61 @@ static void build_madt(GArray *table_data,
> > >      acpi_table_end(linker, &table);
> > >  }
> > >
> > > +/*
> > > + * ACPI spec, Revision 6.5+
> > > + * 5.2.16 System Resource Affinity Table (SRAT)
> > > + * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
> > > + *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtg=
S08tX/view
> > > + */
> > > +static void
> > > +build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *v=
ms)
> > > +{
> > > +    int i;
> > > +    uint64_t mem_base;
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> > > +    MachineState *ms =3D MACHINE(vms);
> > > +    const CPUArchIdList *cpu_list =3D mc->possible_cpu_arch_ids(ms);
> > > +    AcpiTable table =3D { .sig =3D "SRAT", .rev =3D 3, .oem_id =3D v=
ms->oem_id,
> > > +                        .oem_table_id =3D vms->oem_table_id };
> > > +
> > > +    acpi_table_begin(&table, table_data);
> > > +    build_append_int_noprefix(table_data, 1, 4); /* Reserved */
> > > +    build_append_int_noprefix(table_data, 0, 8); /* Reserved */
> > > +
> > > +    for (i =3D 0; i < cpu_list->len; ++i) {
> > > +        uint32_t nodeid =3D cpu_list->cpus[i].props.node_id;
> > > +        /*
> > > +         * 5.2.16.8 RINTC Affinity Structure
> > > +         */
> > > +        build_append_int_noprefix(table_data, 7, 1);      /* Type */
> > > +        build_append_int_noprefix(table_data, 20, 1);     /* Length =
*/
> > > +        build_append_int_noprefix(table_data, 0, 2);        /* Reser=
ved */
> > > +        build_append_int_noprefix(table_data, nodeid, 4); /* Proximi=
ty Domain */
> > > +        build_append_int_noprefix(table_data, i, 4); /* ACPI Process=
or UID */
> > > +        /* Flags, Table 5-70 */
> > > +        build_append_int_noprefix(table_data, 1 /* Flags: Enabled */=
, 4);
> > > +        build_append_int_noprefix(table_data, 0, 4); /* Clock Domain=
 */
> > > +    }
> > > +
> > > +    mem_base =3D vms->memmap[VIRT_DRAM].base;
> > > +    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
> > > +        if (ms->numa_state->nodes[i].node_mem > 0) {
> > > +            build_srat_memory(table_data, mem_base,
> > > +                              ms->numa_state->nodes[i].node_mem, i,
> > > +                              MEM_AFFINITY_ENABLED);
> > > +            mem_base +=3D ms->numa_state->nodes[i].node_mem;
> > > +        }
> > > +    }
> > > +
> > > +    acpi_table_end(linker, &table);
> > > +}
> > > +
> > >  static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tabl=
es)
> > >  {
> > >      GArray *table_offsets;
> > >      unsigned dsdt, xsdt;
> > >      GArray *tables_blob =3D tables->table_data;
> > > +    MachineState *ms =3D MACHINE(s);
> > >
> > >      table_offsets =3D g_array_new(false, true,
> > >                                  sizeof(uint32_t));
> > > @@ -565,6 +615,16 @@ static void virt_acpi_build(RISCVVirtState *s, A=
cpiBuildTables *tables)
> > >                     s->oem_table_id);
> > >      }
> > >
> > > +    if (ms->numa_state->num_nodes > 0) {
> > > +        acpi_add_table(table_offsets, tables_blob);
> > > +        build_srat(tables_blob, tables->linker, s);
> > > +        if (ms->numa_state->have_numa_distance) {
> > > +            acpi_add_table(table_offsets, tables_blob);
> > > +            build_slit(tables_blob, tables->linker, ms, s->oem_id,
> > > +                       s->oem_table_id);
> > > +        }
> > > +    }
> > > +
> > >      /* XSDT is pointed to by RSDP */
> > >      xsdt =3D tables_blob->len;
> > >      build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id=
,
> > > --
> > > 2.34.1
> > >
> > >
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks for the review, Andrew!

