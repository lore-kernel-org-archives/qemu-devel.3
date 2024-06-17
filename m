Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52313C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAFk-0003Nm-VI; Mon, 17 Jun 2024 07:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJAFj-0003NS-B0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJAFh-0008KG-8S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718622619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDywrmYdlgFV66SK+f+/iLFYcm7wdaGC2acfNRgX258=;
 b=ORUsmn4H9t70fi265jBYPMfS6HG81JdBs+3rjvoumxaK3ZG6TN20SK4wouQ5kF17ugvk4C
 cHfDLYW/DnjPOt8yT0zD3w0a5Lv4e0rMyROMw1lbriVRaEza9a1OuRjkqyawqzUq0LdgcM
 tkOyaNDAD1xgpHF0ED33dN90nMV8SG8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-D04e2goGMiCTaZL7hAjaRA-1; Mon, 17 Jun 2024 07:10:18 -0400
X-MC-Unique: D04e2goGMiCTaZL7hAjaRA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c844aec2eso3287578e87.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718622616; x=1719227416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDywrmYdlgFV66SK+f+/iLFYcm7wdaGC2acfNRgX258=;
 b=rEJOlaL/hDRmXcafPEHJCZ+vHJXeaYBOXlJylxV9QqquKMvCAaAiFRcP5f+vXVnI66
 aRvl6dgf7tfPcOh/Cst4eZsgjJKzgTKTCo9F5q1T3LlNkQJHUYhDloDVgbU7nrOo7v7A
 ABTvSrr3M98t2my3+ul+aSdsur74CzDKvRWKCwcYSzKHQRNejDTtzhWmZ040uZusGDBV
 3UZ4Fze1WRRZ7r3uRfThP1uSMP2PRgGTPwvA89cLao0a8tJTY3h8rYv0W5ZBCMVPQh8N
 89vBh9jm2rf32jKHWR2luJzvOZyMFtPBMbaEAfMIAcpfYIQhKZF8y+MC4ZpN3Rueuk0M
 0PMA==
X-Gm-Message-State: AOJu0Yy8Rmc5MDsJHUOQu5ViUHV9lZDt6sraKOh6aHgeRUQP1k8ZaLeq
 ikn7vC/A5b8LZQ7MTp0h6egLbJVO9iQudWJSC34b8Fq/idqdWusJLAbawQ8lV2fXFOXVlATHN75
 pDTaCOFE34g4ci2lGlqV4mH5aJbUzbgmqONbRdQmrJYlP/34Pzhzb
X-Received: by 2002:ac2:4578:0:b0:52c:983f:8ad with SMTP id
 2adb3069b0e04-52ca6e93015mr7413696e87.47.1718622616493; 
 Mon, 17 Jun 2024 04:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRsr40sl0ZpBmUvS+akGa8/XI4daYl+SAsZ7Mv63prKoSP1RluXQPivBGzCTbvMq2xHAwUkg==
X-Received: by 2002:ac2:4578:0:b0:52c:983f:8ad with SMTP id
 2adb3069b0e04-52ca6e93015mr7413687e87.47.1718622616051; 
 Mon, 17 Jun 2024 04:10:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b74sm11575518f8f.107.2024.06.17.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 04:10:15 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:10:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v6 23/23] hw/i386/pc: Replace
 PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
Message-ID: <20240617131014.6123d6dd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240617071118.60464-24-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
 <20240617071118.60464-24-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, 17 Jun 2024 09:11:18 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::acpi_data_size was only used by the pc-i440fx-2.0
> machine, which got removed. Since it is constant, replace the class
> field by a definition (local to hw/i386/pc.c, since not used
> elsewhere).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  4 ----
>  hw/i386/pc.c         | 19 ++++++++++++-------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 0b7a18a882..46bc411063 100644
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
> index 819a164373..77415064c6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -265,6 +265,16 @@ GlobalProperty pc_compat_2_4[] =3D {
>  };
>  const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
> =20
> +/*
> + * @PC_FW_DATA:
> + * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
> + * and other BIOS datastructures.
> + *
> + * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
> + * reported to be used at the moment, 32K should be enough for a while.
> + */
> +#define PC_FW_DATA (0x20000 + 0x8000)
> +
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
> @@ -646,8 +656,7 @@ void xen_load_linux(PCMachineState *pcms)
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>      rom_set_fw(fw_cfg);
> =20
> -    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                   pcmc->pvh_enabled);
> +    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
>      for (i =3D 0; i < nb_option_roms; i++) {
>          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -986,8 +995,7 @@ void pc_memory_init(PCMachineState *pcms,
>      }
> =20
>      if (linux_boot) {
> -        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                       pcmc->pvh_enabled);
> +        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
>      }
> =20
>      for (i =3D 0; i < nb_option_roms; i++) {
> @@ -1743,9 +1751,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
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


