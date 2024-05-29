Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DC7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKuU-00021O-7O; Wed, 29 May 2024 11:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKuS-00020u-ST
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKuR-0007ge-62
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnmQZMiF1RiodqDsVYuN/scesM+R72wJ54PU8s+oiqQ=;
 b=AcoUm7lSALS/x+wixPOZ2Dubtc0kOs2LDtkK09dYgyuGNxyIE479p4W9ZAYg+JbXZZe+Nk
 gwhK3PacMY3rD2y4X57cMbNu+XJcRd2cta80VeJMSCPf4b/aydzWuSugAkPR+UlDXMR5+F
 L4LbhUfvIKWyoZqqI3oTXqqq+Mu3xks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-VN0p5TYRNMOB0DJqBvysFQ-1; Wed, 29 May 2024 11:08:08 -0400
X-MC-Unique: VN0p5TYRNMOB0DJqBvysFQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42024ca94d0so13397685e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995286; x=1717600086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnmQZMiF1RiodqDsVYuN/scesM+R72wJ54PU8s+oiqQ=;
 b=wSnhVLa1SObPM4vfbtS+PTjui03MAyrtAtaNbe18WkjZ3g4hLEits4N2q0f01VVynH
 g3cTcxlw7+DR5L946rh3NCXX5JKozB9+F8wjWPZuqWNYhqh6KevluB6L3HIWDQ5vf6hf
 oILC4HqLyNJvlwvClElbzZdSP4lKzps7HuY5tJmmYidfL1hj/29/WklGmHVKQkO0TTj7
 rAHJAKCe8l/fgM/aPvLiU3NdwyRkMEIs1gbzjuYT5eyA7mf0Yx64HH4qE0PHXYxkMzW9
 KFVR9Fpbybsb+CBZlB/0F692b+ZNsY4wBNvmK7DonuCPkGYkMnBdFsLjGHqwI6mHvIrQ
 w2Wg==
X-Gm-Message-State: AOJu0Yy4WE5CnQg9cePyw8CBPBbQWJRIsWbl6yLIQBWWCPUEDpVS1y98
 W4P+D9DJehjgGfuSQ5RMCEIFFk547xJx9z7AyU8W4KtKcs2x4Q5yi/O8DfjDd6vGP+uYsNMpUoR
 frLrKhtUQ7eMUQjtMycMjvChs9gU5oExqVmmkhts1F7rSjH/Ik7krDK63Cz3A
X-Received: by 2002:a05:600c:45c5:b0:41a:a521:9699 with SMTP id
 5b1f17b1804b1-421089d389dmr119995705e9.4.1716995286695; 
 Wed, 29 May 2024 08:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKt7Ko32FqH52s485xesMMx9yuvrjjWESBLxDcHcS3aAtY5QQfZlg1+HE5xeaB98lhB2VIw==
X-Received: by 2002:a05:600c:45c5:b0:41a:a521:9699 with SMTP id
 5b1f17b1804b1-421089d389dmr119995515e9.4.1716995286375; 
 Wed, 29 May 2024 08:08:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42122299300sm35006665e9.42.2024.05.29.08.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:08:05 -0700 (PDT)
Date: Wed, 29 May 2024 17:08:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 18/23] hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
Message-ID: <20240529170805.39f1e5c3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-19-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-19-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed, 29 May 2024 07:15:34 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::rsdp_in_ram was only used by the
> pc-i440fx-2.2 machine, which got removed. It is
> now always true. Remove it, simplifying acpi_setup().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  1 -
>  hw/i386/acpi-build.c | 35 ++++-------------------------------
>  hw/i386/pc.c         |  1 -
>  3 files changed, 4 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 808de4eca7..63568eb9e9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -100,7 +100,6 @@ struct PCMachineClass {
> =20
>      /* ACPI compat: */
>      bool has_acpi_build;
> -    bool rsdp_in_ram;
>      unsigned acpi_data_size;
>      int pci_root_uid;
> =20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ab2d4d8dcb..ed0adb0e82 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2495,7 +2495,6 @@ static
>  void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(machine);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      X86MachineState *x86ms =3D X86_MACHINE(machine);
>      DeviceState *iommu =3D pcms->iommu;
>      GArray *table_offsets;
> @@ -2667,16 +2666,6 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>              .rsdt_tbl_offset =3D &rsdt,
>          };
>          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> -        if (!pcmc->rsdp_in_ram) {
> -            /* We used to allocate some extra space for RSDP revision 2 =
but
> -             * only used the RSDP revision 0 space. The extra bytes were
> -             * zeroed out and not used.
> -             * Here we continue wasting those extra 16 bytes to make sur=
e we
> -             * don't break migration for machine types 2.2 and older due=
 to
> -             * RSDP blob size mismatch.
> -             */
> -            build_append_int_noprefix(tables->rsdp, 0, 16);
> -        }
>      }
> =20
>      /* We'll expose it all to Guest so we want to reduce
> @@ -2755,7 +2744,6 @@ static const VMStateDescription vmstate_acpi_build =
=3D {
>  void acpi_setup(void)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
> @@ -2817,25 +2805,10 @@ void acpi_setup(void)
>                             tables.vmgenid);
>      }
> =20
> -    if (!pcmc->rsdp_in_ram) {
> -        /*
> -         * Keep for compatibility with old machine types.
> -         * Though RSDP is small, its contents isn't immutable, so
> -         * we'll update it along with the rest of tables on guest access.
> -         */
> -        uint32_t rsdp_size =3D acpi_data_len(tables.rsdp);
> -
> -        build_state->rsdp =3D g_memdup(tables.rsdp->data, rsdp_size);
> -        fw_cfg_add_file_callback(x86ms->fw_cfg, ACPI_BUILD_RSDP_FILE,
> -                                 acpi_build_update, NULL, build_state,
> -                                 build_state->rsdp, rsdp_size, true);
> -        build_state->rsdp_mr =3D NULL;
> -    } else {
> -        build_state->rsdp =3D NULL;
> -        build_state->rsdp_mr =3D acpi_add_rom_blob(acpi_build_update,
> -                                                 build_state, tables.rsd=
p,
> -                                                 ACPI_BUILD_RSDP_FILE);
> -    }
> +    build_state->rsdp =3D NULL;
> +    build_state->rsdp_mr =3D acpi_add_rom_blob(acpi_build_update,
> +                                             build_state, tables.rsdp,
> +                                             ACPI_BUILD_RSDP_FILE);
> =20
>      qemu_register_reset(acpi_build_reset, build_state);
>      acpi_build_reset(build_state);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fae21f75aa..8e51d1f1bb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1757,7 +1757,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
> =20
>      pcmc->pci_enabled =3D true;
>      pcmc->has_acpi_build =3D true;
> -    pcmc->rsdp_in_ram =3D true;
>      pcmc->smbios_defaults =3D true;
>      pcmc->gigabyte_align =3D true;
>      pcmc->has_reserved_memory =3D true;


