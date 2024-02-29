Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E86C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbCr-0006K6-TE; Thu, 29 Feb 2024 02:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfbCq-0006JY-Dm
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfbCo-0000Ar-NT
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709193109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYZe/DZW2BzM3r0kIBtLsS/lPvl3VeHQTWZOYH4EiX0=;
 b=LCFMzs808vDvdMaWaMlWULYtd9HYMcS3hv6q8zeL2EVbKPtDwv/2JCFSIpNNgShdWFur68
 setKlIpAgAm9HAZsSchVqqhuigyrZmYAX7+L7C1rumBgb5XJIAqYKxb5/ZcN6CucG9Le0M
 UC1NCo5F5DjWr9rekn1CnX9pK8yTOyA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-_Tu_90FwPXWdKgtc1Mb8BA-1; Thu, 29 Feb 2024 02:51:48 -0500
X-MC-Unique: _Tu_90FwPXWdKgtc1Mb8BA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-290a26e6482so439596a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 23:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709193107; x=1709797907;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYZe/DZW2BzM3r0kIBtLsS/lPvl3VeHQTWZOYH4EiX0=;
 b=H+0SVfkEvgmzpS2H8A/HLE9XBsCwLud1p3E4MQSx5Y/5cCm+geMWwnhLZoQxRXfjCH
 w0kVs6ynWwSby906nxDTaUbMzUqlEFbCRS8j+WvR5aLpZSE+sRUa56ujl/rX0DaoUaOE
 VScAQlxbseQ635kGp3Utfhx5h7Nj8SWIHQImoXzMOK9Ugx5wq+hKuheQSD7JWBA+pI0B
 FuLtjjYp31etmx1DxTjIDHPhI6pmSWjW5K2M0fd48QeRezhETvGjK30pT4SyG1Qvw1zQ
 yFeezVWsvHL4pvvAK4RkIILe8NvysgS5/HlZLgzctoH2U8AKL7pdoRYuPlUQ8jPOee2l
 Mcrw==
X-Gm-Message-State: AOJu0Yyr8dUntPtBOXCRD6kJXV9cijPFdZTe+LGKaubfLej0Iw93Bg8k
 du9M6O2FiMPAUYTzWuLSM/MTYHv8TMmrDjE49AdQ+L4ceL7VfLkWVmz0o49TmJKYqyfXxRqjenh
 D1pJoEDADSFtBSydg+ppI7rSgsfyIU5qb+xjS0XP1kcrjLa6szCwP
X-Received: by 2002:a17:90a:e601:b0:29a:377f:3994 with SMTP id
 j1-20020a17090ae60100b0029a377f3994mr1403254pjy.13.1709193106854; 
 Wed, 28 Feb 2024 23:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkAFvW0nDLfsUD16z1I5sTXUbFchKLIIJSGINX6/hWoDVp3ZnWYVzqx8PyhszXKEzs/gvkmQ==
X-Received: by 2002:a17:90a:e601:b0:29a:377f:3994 with SMTP id
 j1-20020a17090ae60100b0029a377f3994mr1403229pjy.13.1709193106472; 
 Wed, 28 Feb 2024 23:51:46 -0800 (PST)
Received: from smtpclient.apple ([223.191.49.228])
 by smtp.gmail.com with ESMTPSA id
 cc13-20020a17090af10d00b0029681231ae1sm778568pjb.28.2024.02.28.23.51.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Feb 2024 23:51:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 05/19] smbios: get rid of smbios_smp_sockets global
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-6-imammedo@redhat.com>
Date: Thu, 29 Feb 2024 13:21:14 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF2F995D-246B-481E-B3C6-CF95F1BD6B13@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-6-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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



> On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> it makes smbios_validate_table() independent from
> smbios_smp_sockets global, which in turn lets
> smbios_get_tables() avoid using not related legacy code.
>=20
Good cleanup!

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>


> ---
> goal here is to isolate legacy handling from generic =
smbios_get_tables()
> ---
> include/hw/firmware/smbios.h |  2 +-
> hw/i386/fw_cfg.c             |  2 +-
> hw/smbios/smbios.c           | 22 +++++++++-------------
> 3 files changed, 11 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/hw/firmware/smbios.h =
b/include/hw/firmware/smbios.h
> index 6e514982d4..a187fbbd3d 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -296,7 +296,7 @@ void smbios_set_defaults(const char *manufacturer, =
const char *product,
>                          const char *version, bool legacy_mode,
>                          bool uuid_encoded, SmbiosEntryPointType =
ep_type);
> void smbios_set_default_processor_family(uint16_t processor_family);
> -uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
> +uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t =
*length);
> void smbios_get_tables(MachineState *ms,
>                        const struct smbios_phys_mem_area *mem_array,
>                        const unsigned int mem_array_size,
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index a635234e68..fcb4fb0769 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -70,7 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, =
FWCfgState *fw_cfg)
>     /* tell smbios about cpuid version and features */
>     smbios_set_cpuid(cpu->env.cpuid_version, =
cpu->env.features[FEAT_1_EDX]);
>=20
> -    smbios_tables =3D smbios_get_table_legacy(ms, =
&smbios_tables_len);
> +    smbios_tables =3D smbios_get_table_legacy(ms->smp.cpus, =
&smbios_tables_len);
>     if (smbios_tables) {
>         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                          smbios_tables, smbios_tables_len);
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 8e86c62184..15339d8dbe 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -70,7 +70,7 @@ static SmbiosEntryPoint ep;
> static int smbios_type4_count =3D 0;
> static bool smbios_immutable;
> static bool smbios_have_defaults;
> -static uint32_t smbios_cpuid_version, smbios_cpuid_features, =
smbios_smp_sockets;
> +static uint32_t smbios_cpuid_version, smbios_cpuid_features;
>=20
> static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
> static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
> @@ -476,14 +476,11 @@ opts_init(smbios_register_config);
>  */
> #define SMBIOS_21_MAX_TABLES_LEN 0xffff
>=20
> -static void smbios_validate_table(MachineState *ms)
> +static void smbios_validate_table(uint32_t expected_t4_count)
> {
> -    uint32_t expect_t4_count =3D smbios_legacy ?
> -                                        ms->smp.cpus : =
smbios_smp_sockets;
> -
> -    if (smbios_type4_count && smbios_type4_count !=3D =
expect_t4_count) {
> +    if (smbios_type4_count && smbios_type4_count !=3D =
expected_t4_count) {
>         error_report("Expected %d SMBIOS Type 4 tables, got %d =
instead",
> -                     expect_t4_count, smbios_type4_count);
> +                     expected_t4_count, smbios_type4_count);
>         exit(1);
>     }
>=20
> @@ -571,7 +568,7 @@ static void smbios_build_type_1_fields(void)
>     }
> }
>=20
> -uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
> +uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t =
*length)
> {
>     if (!smbios_legacy) {
>         *length =3D 0;
> @@ -581,7 +578,7 @@ uint8_t *smbios_get_table_legacy(MachineState *ms, =
size_t *length)
>     if (!smbios_immutable) {
>         smbios_build_type_0_fields();
>         smbios_build_type_1_fields();
> -        smbios_validate_table(ms);
> +        smbios_validate_table(expected_t4_count);
>         smbios_immutable =3D true;
>     }
>     *length =3D smbios_entries_len;
> @@ -1112,10 +1109,9 @@ void smbios_get_tables(MachineState *ms,
>         smbios_build_type_2_table();
>         smbios_build_type_3_table();
>=20
> -        smbios_smp_sockets =3D ms->smp.sockets;
> -        assert(smbios_smp_sockets >=3D 1);
> +        assert(ms->smp.sockets >=3D 1);
>=20
> -        for (i =3D 0; i < smbios_smp_sockets; i++) {
> +        for (i =3D 0; i < ms->smp.sockets; i++) {
>             smbios_build_type_4_table(ms, i);
>         }
>=20
> @@ -1160,7 +1156,7 @@ void smbios_get_tables(MachineState *ms,
>         smbios_build_type_41_table(errp);
>         smbios_build_type_127_table();
>=20
> -        smbios_validate_table(ms);
> +        smbios_validate_table(ms->smp.sockets);
>         smbios_entry_point_setup();
>         smbios_immutable =3D true;
>     }
> --=20
> 2.39.3
>=20


