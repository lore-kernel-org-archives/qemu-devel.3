Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCL2B-0007En-36; Wed, 29 May 2024 11:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCL28-0007Dx-RT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCL26-0000vQ-Jx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0t3xXpqAaqwMSKdvkYYb7qtWlrtdBfWcjxQJVuC+ofI=;
 b=d1thXeUq8Ufx4NTFOVOgNVyzUQmjVI8PF5rlutk0CLfwZYedbaKycD8gaBXr5NFJMcBPqa
 1RgY58/T1Ky4UANdkU5fsFDd7UO7cCvme6uxzOyEQotZ70SSSP+IzKPnBjejw7+Tgk1noj
 gQ4GlnHJQ6nrgRloOUCG9wcLsuQ4+o4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-FfcSh3QUPF2wijL-h80joA-1; Wed, 29 May 2024 11:16:02 -0400
X-MC-Unique: FfcSh3QUPF2wijL-h80joA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-357ad1f7b08so1195422f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995761; x=1717600561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0t3xXpqAaqwMSKdvkYYb7qtWlrtdBfWcjxQJVuC+ofI=;
 b=QifuSiPZJKAuBIWQN1VakHo656ldl3oYqeIIRdDldd7pllY7mPdY8q5tyJOp7W8nGn
 MJ23H4oiBum+WuhjhfY8BOVkkRj7MMpdjGLyKn8DwOymIYwgMU6PhzJmPleAOwa/AZxj
 4ITy0VlW5T6BAxY56FJx2y3OEYRpjGTtv1zsA+V+n2Vsl7LqzeG5yuq5FztLX8SoaOpQ
 49eW9v6dgTujXLmUicv4bgWdr3ZJ/4e57isdSQj0gOQjrROaHFkNh1nfOA708x/1jgw5
 SsiBTBp8rps/Otudk5lGOa2ENEX6bfARWKbKDfJSOz3ufnxWlyYV/rz0+GETWce9YWY7
 P0+A==
X-Gm-Message-State: AOJu0YwyIO7JscAUII5a9QRVHvrbDP8Q7bfvdM3KQdnAU0hydLEr4N7v
 qGlBuhMQzDBzQSR65sAt0ORWJXGkrBkjzIuAo8Ryav2LcLSTnVr+2/VeboOM7bUrmyq4YG+es9D
 Zmmc0hh+ppLg4xq3EGbeUcuSROuZfaTgGEJrDxfLxM/SV/1EKi3FS
X-Received: by 2002:a5d:6651:0:b0:354:f474:6f68 with SMTP id
 ffacd0b85a97d-3552fdc7cb4mr15486566f8f.54.1716995761586; 
 Wed, 29 May 2024 08:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCa11h4IK+SBNg5q75ze2802GhvI8YQHDIwYYu/DVEOY2Yp1taEA6eZISUHQIPAnG4bGy9Mg==
X-Received: by 2002:a5d:6651:0:b0:354:f474:6f68 with SMTP id
 ffacd0b85a97d-3552fdc7cb4mr15486538f8f.54.1716995761121; 
 Wed, 29 May 2024 08:16:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dd33sm15054140f8f.11.2024.05.29.08.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:16:00 -0700 (PDT)
Date: Wed, 29 May 2024 17:15:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 23/23] hw/i386/pc: Replace
 PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
Message-ID: <20240529171559.34c4a1af@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-24-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-24-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:39 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::acpi_data_size was only used by the pc-i440fx-2.0
> machine, which got removed. Since it is constant, replace the class
> field by a definition (local to hw/i386/pc.c, since not used
> elsewhere).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/hw/i386/pc.h |  4 ----
>  hw/i386/pc.c         | 19 ++++++++++++-------
>  hw/i386/pc_piix.c    |  7 -------
>  3 files changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 63568eb9e9..db26368ace 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -74,9 +74,6 @@ typedef struct PCMachineState {
>   *
>   * Compat fields:
>   *
> - * @acpi_data_size: Size of the chunk of memory at the top of RAM
> - *                  for the BIOS ACPI tables and other BIOS
> - *                  datastructures.
>   * @gigabyte_align: Make sure that guest addresses aligned at
>   *                  1Gbyte boundaries get mapped to host
>   *                  addresses aligned at 1Gbyte boundaries. This
> @@ -100,7 +97,6 @@ struct PCMachineClass {
> =20
>      /* ACPI compat: */
>      bool has_acpi_build;
> -    unsigned acpi_data_size;
>      int pci_root_uid;
> =20
>      /* SMBIOS compat: */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b84c8ddba0..9dca3f0354 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -264,6 +264,16 @@ GlobalProperty pc_compat_2_4[] =3D {
>  };
>  const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
> =20
> +/*
> + * @PC_ACPI_DATA_SIZE:
> + * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
> + * and other BIOS datastructures.
> + *
> + * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
> + * reported to be used at the moment, 32K should be enough for a while.
> + */
> +#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)

PC_FW_DATA would be a better name,
with a correspond x86_load_linux() argument rename

> +
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> @@ -645,8 +655,7 @@ void xen_load_linux(PCMachineState *pcms)
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>      rom_set_fw(fw_cfg);
> =20
> -    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                   pcmc->pvh_enabled);
> +    x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
>      for (i =3D 0; i < nb_option_roms; i++) {
>          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -980,8 +989,7 @@ void pc_memory_init(PCMachineState *pcms,
>      }
> =20
>      if (linux_boot) {
> -        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                       pcmc->pvh_enabled);
> +        x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabl=
ed);
>      }
> =20
>      for (i =3D 0; i < nb_option_roms; i++) {
> @@ -1737,9 +1745,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->has_reserved_memory =3D true;
>      pcmc->enforce_amd_1tb_hole =3D true;
>      pcmc->isa_bios_alias =3D true;
> -    /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K r=
eported
> -     * to be used at the moment, 32K should be enough for a while.  */
> -    pcmc->acpi_data_size =3D 0x20000 + 0x8000;
>      pcmc->pvh_enabled =3D true;
>      pcmc->kvmclock_create_always =3D true;
>      x86mc->apic_xrupt_override =3D true;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e7f51a5f2c..e4930b7f48 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -414,13 +414,6 @@ static void pc_set_south_bridge(Object *obj, int val=
ue, Error **errp)
>      pcms->south_bridge =3D PCSouthBridgeOption_lookup.array[value];
>  }



> -/* Looking for a pc_compat_2_4() function? It doesn't exist.
> - * pc_compat_*() functions that run on machine-init time and
> - * change global QEMU state are deprecated. Please don't create
> - * one, and implement any pc-*-2.4 (and newer) compat code in
> - * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
> - */
>=20

misplaced hunk, should be a part of [21/23]

>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {


