Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD9C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJfc-0004bZ-2L; Wed, 29 May 2024 09:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJfV-0004Zx-GA
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJfS-0002fE-K3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716990516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+tT3D1nTHmFTCUYgf+wGiaEuS/6ZxHigSiyJ4lmghU=;
 b=iZqy5arjHgm0wcdTs6Z4ANxuYkEjtHjsXydNiqH7Mnz1rhf89X9/ZkLAMuMs+nnaTiTeXT
 B/i3Iug4wYnz3yoPY0phTovQzP6a0g5IvLt6atZ22Xsp+TZy+uxS3WZJgXmVk/bVGqcL+c
 jMw0gnNui8vWOhk0uv4IDdl49uYrgbc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-WwgkjyfiPoWufaHE_ue8yw-1; Wed, 29 May 2024 09:48:33 -0400
X-MC-Unique: WwgkjyfiPoWufaHE_ue8yw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95877b88fso20021451fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990511; x=1717595311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+tT3D1nTHmFTCUYgf+wGiaEuS/6ZxHigSiyJ4lmghU=;
 b=h/l/7MGprrRFYN11PGSi4W7nT0S/PXUtHjV413IrDVEr8g3I75TflIWsA8gtS5zGD0
 c6F8u2K797G98KR5c55Mkpat4RBoA5tNT8nbE3D5tB6sIlj0+OYGffAZRZi+vmSU4ltj
 OKlL7jH6Sk356dM5GeGja7BeMYl/CCOMUmyRE7EUNjJ5TQelBu8ETjE9fjK54ZXbu+Ca
 cgbqBW1xb4jNsVUqrG3eyaxQ/bp5gewzsOLpcmBHxZXkMrCd5MDQGgPFrwHLSj/+3eF3
 UwKDbquF/frDmuvn/HbnpewXaWuzhd+ciESW3aTYSbqskeO/LvtUQ46pQCFC2km/NxyD
 DR5A==
X-Gm-Message-State: AOJu0Yz9aNpnBFz3oAZJa6C78IsECSPkJrI9X+M7tnglbd/e6JOJk2uu
 AVrq5CKMJbfQxNuzEZBSJ2xOc6AFbB2SPxwDBmLhxFui01laUO5dktN3v+VYQHuMxvZMFD9it6t
 25yrGow6W91gqDrhV7NUjM+7JajppBPsyF29U7YnWmkKEoWvqIflOYrs6pcUR
X-Received: by 2002:a2e:9bc6:0:b0:2e9:7417:bb0a with SMTP id
 38308e7fff4ca-2e97417bbe0mr61751891fa.3.1716990511503; 
 Wed, 29 May 2024 06:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcyp5qq04jLhqsNBUJezOYwedhG27vz82xaIZvv7gUBszGkJjQzHTJ12FZJ2aYMCeyowyPsA==
X-Received: by 2002:a2e:9bc6:0:b0:2e9:7417:bb0a with SMTP id
 38308e7fff4ca-2e97417bbe0mr61751731fa.3.1716990511010; 
 Wed, 29 May 2024 06:48:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212278b24dsm14557425e9.0.2024.05.29.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 06:48:30 -0700 (PDT)
Date: Wed, 29 May 2024 15:48:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 05/23] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Message-ID: <20240529154828.788575b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-6-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-6-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 29 May 2024 07:15:21 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::legacy_acpi_table_size was only used by the
> pc-i440fx-2.0 machine, which got removed. Remove it and simplify
> acpi_build().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

nit below
otherwise

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  1 -
>  hw/i386/acpi-build.c | 62 +++++++++-----------------------------------
>  2 files changed, 12 insertions(+), 51 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 7347636d47..01fdcfaeb6 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -103,7 +103,6 @@ struct PCMachineClass {
>      /* ACPI compat: */
>      bool has_acpi_build;
>      bool rsdp_in_ram;
> -    int legacy_acpi_table_size;
>      unsigned acpi_data_size;
>      int pci_root_uid;
> =20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53f804ac16..a6f8203460 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2499,13 +2499,12 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>      DeviceState *iommu =3D pcms->iommu;
>      GArray *table_offsets;
> -    unsigned facs, dsdt, rsdt, fadt;
> +    unsigned facs, dsdt, rsdt;
>      AcpiPmInfo pm;
>      AcpiMiscInfo misc;
>      AcpiMcfgInfo mcfg;
>      Range pci_hole =3D {}, pci_hole64 =3D {};
>      uint8_t *u;
> -    size_t aml_len =3D 0;
>      GArray *tables_blob =3D tables->table_data;
>      AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
>      Object *vmgenid_dev;
> @@ -2551,19 +2550,12 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>      build_dsdt(tables_blob, tables->linker, &pm, &misc,
>                 &pci_hole, &pci_hole64, machine);
> =20
> -    /* Count the size of the DSDT and SSDT, we will need it for legacy
> -     * sizing of ACPI tables.
> -     */
> -    aml_len +=3D tables_blob->len - dsdt;
> -
>      /* ACPI tables pointed to by RSDT */
> -    fadt =3D tables_blob->len;
>      acpi_add_table(table_offsets, tables_blob);
>      pm.fadt.facs_tbl_offset =3D &facs;
>      pm.fadt.dsdt_tbl_offset =3D &dsdt;
>      pm.fadt.xdsdt_tbl_offset =3D &dsdt;
>      build_fadt(tables_blob, tables->linker, &pm.fadt, oem_id, oem_table_=
id);
> -    aml_len +=3D tables_blob->len - fadt;
> =20
>      acpi_add_table(table_offsets, tables_blob);
>      acpi_build_madt(tables_blob, tables->linker, x86ms,
> @@ -2694,49 +2686,19 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>       * too simple to be enough.  4k turned out to be too small an
>       * alignment very soon, and in fact it is almost impossible to
>       * keep the table size stable for all (max_cpus, max_memory_slots)
> -     * combinations.  So the table size is always 64k for pc-i440fx-2.1
> -     * and we give an error if the table grows beyond that limit.
> -     *
> -     * We still have the problem of migrating from "-M pc-i440fx-2.0".  =
For
> -     * that, we exploit the fact that QEMU 2.1 generates _smaller_ tables
> -     * than 2.0 and we can always pad the smaller tables with zeros.  We=
 can
> -     * then use the exact size of the 2.0 tables.
> -     *
> -     * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migratio=
n.
> +     * combinations.
>       */
> -    if (pcmc->legacy_acpi_table_size) {
> -        /* Subtracting aml_len gives the size of fixed tables.  Then add=
 the
> -         * size of the PIIX4 DSDT/SSDT in QEMU 2.0.
> -         */
> -        int legacy_aml_len =3D
> -            pcmc->legacy_acpi_table_size +
> -            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;

missed removal of ACPI_BUILD_LEGACY_CPU_AML_SIZE definition at the beginnin=
g of the file.

> -        int legacy_table_size =3D
> -            ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
> -                     ACPI_BUILD_ALIGN_SIZE);
> -        if ((tables_blob->len > legacy_table_size) &&
> -            !pcmc->resizable_acpi_blob) {
> -            /* Should happen only with PCI bridges and -M pc-i440fx-2.0.=
  */
> -            warn_report("ACPI table size %u exceeds %d bytes,"
> -                        " migration may not work",
> -                        tables_blob->len, legacy_table_size);
> -            error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.\n");
> -        }
> -        g_array_set_size(tables_blob, legacy_table_size);
> -    } else {
> -        /* Make sure we have a buffer in case we need to resize the tabl=
es. */
> -        if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> -            !pcmc->resizable_acpi_blob) {
> -            /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory =
slots.  */
> -            warn_report("ACPI table size %u exceeds %d bytes,"
> -                        " migration may not work",
> -                        tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> -            error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.\n");
> -        }
> -        acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> +    /* Make sure we have a buffer in case we need to resize the tables. =
*/
> +    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> +        !pcmc->resizable_acpi_blob) {
> +        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slot=
s.  */
> +        warn_report("ACPI table size %u exceeds %d bytes,"
> +                    " migration may not work",
> +                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> +        error_printf("Try removing CPUs, NUMA nodes, memory slots"
> +                     " or PCI bridges.\n");
>      }
> +    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> =20
>      acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
> =20


