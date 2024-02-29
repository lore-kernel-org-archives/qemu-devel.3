Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC70C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfe2y-0000FE-MR; Thu, 29 Feb 2024 05:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfe2w-0000Ek-4H
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfe2p-0005PR-Sw
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709204022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T04YZ+WjGIGT+oF86UZYJmgPRyPQqMGsqGuR8vP+UKY=;
 b=QAFYcUjRdFWsLxfRzxVR3R3vZeqJGuaQkKBA9E1NR7sO6LkZLeUldxxp3TVohuFNEbFwSV
 g1Xdgm9zPJGXHC7TnVpNUgOzRYO4N6ZEXelORlNK85n4F1rLkpHMjDBd5QVPtiZAcAoR0V
 vTr8kgSeF2JZAZyo53jklKDdsrjpZgg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-t9F2nabmP46QbnsSgDKCuw-1; Thu, 29 Feb 2024 05:53:40 -0500
X-MC-Unique: t9F2nabmP46QbnsSgDKCuw-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c79b0aac56so76152639f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709204019; x=1709808819;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T04YZ+WjGIGT+oF86UZYJmgPRyPQqMGsqGuR8vP+UKY=;
 b=AXID0Due+QSAayEmkqhaVA65qcTvA8OdruYCdKOWHfzmka8C/fvxgFOoFUaUYf9zs4
 kiiTo+UqjWauMPmu1WlmBrbgA5B9K9K2Esg2NxlkNlOnX4j/frgBK700lguGfKdiiz+A
 XFgtoNI634yZZAq1exonfm9JfTckUAvYtIQzYzWnkNmWMagfY86uNHJrrm73L2QT/FpZ
 De7Y9wyH4a1PATBcrGjb5/3kgSFDM1T7lmjplX3vXgU3KictGQ2UjQ2QZQ2sthMmNaC3
 prTTct0F71yjGOZFuEZ7Q3C5acoyJaLyYfdLND+oU0qVnAdU3tLODH1A7SC2rynJ9VHM
 v05w==
X-Gm-Message-State: AOJu0Ywd+/8oamqDHRO3vymzeULJA5D86dYtx4ZCfeF9BlauORvzYBQ/
 jSdbveyb2JcUO1qtl2u6OVfw+PS6EjOU9qd8WgNfwQ+puOTUGJgCFKa/QcugvfC2rszJADSnMOU
 5tS9w8q7T2wd2RVBxPqOTMZqmHPZdw+WHwg/GpqZlvmARIIW/IAs6
X-Received: by 2002:a92:c9c1:0:b0:365:e03:df3b with SMTP id
 k1-20020a92c9c1000000b003650e03df3bmr2025455ilq.19.1709204019562; 
 Thu, 29 Feb 2024 02:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUvVAOwIhUukqCTmIr65T0F6R7vSZLr3+i2K7wi+MQm15c/Bcbpaf/fZ+mP1Z+DnFVmyGUIg==
X-Received: by 2002:a92:c9c1:0:b0:365:e03:df3b with SMTP id
 k1-20020a92c9c1000000b003650e03df3bmr2025430ilq.19.1709204019229; 
 Thu, 29 Feb 2024 02:53:39 -0800 (PST)
Received: from smtpclient.apple ([115.96.135.6])
 by smtp.gmail.com with ESMTPSA id
 lp3-20020a056a003d4300b006e553f2b880sm974810pfb.211.2024.02.29.02.53.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Feb 2024 02:53:38 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 06/19] smbios: get rid of smbios_legacy global
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-7-imammedo@redhat.com>
Date: Thu, 29 Feb 2024 16:23:21 +0530
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
Message-Id: <0129FA3E-A566-481A-85A6-439E72C5594B@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-7-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> clean up smbios_set_defaults() which is reused by legacy
> and non legacy machines from being aware of 'legacy' notion
> and need to turn it off. And push legacy handling up to
> PC machine code where it's relevant.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS: I've moved/kept legacy smbios_entries to smbios_get_tables()
> but it at least is not visible to API users. To get rid of it
> as well, it would be necessary to change how '-smbios' CLI
> option is processed. Which is done later in the series.
> ---
> include/hw/firmware/smbios.h |  2 +-
> hw/arm/virt.c                |  2 +-
> hw/i386/fw_cfg.c             |  7 ++++---
> hw/loongarch/virt.c          |  2 +-
> hw/riscv/virt.c              |  2 +-
> hw/smbios/smbios.c           | 35 +++++++++++++++--------------------
> 6 files changed, 23 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/hw/firmware/smbios.h =
b/include/hw/firmware/smbios.h
> index a187fbbd3d..0818184834 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -293,7 +293,7 @@ struct smbios_type_127 {
> void smbios_entry_add(QemuOpts *opts, Error **errp);
> void smbios_set_cpuid(uint32_t version, uint32_t features);
> void smbios_set_defaults(const char *manufacturer, const char =
*product,
> -                         const char *version, bool legacy_mode,
> +                         const char *version,
>                          bool uuid_encoded, SmbiosEntryPointType =
ep_type);
> void smbios_set_default_processor_family(uint16_t processor_family);
> uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t =
*length);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0af1943697..8588681f27 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1633,7 +1633,7 @@ static void virt_build_smbios(VirtMachineState =
*vms)
>     }
>=20
>     smbios_set_defaults("QEMU", product,
> -                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, =
false,
> +                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
>                         true, SMBIOS_ENTRY_POINT_TYPE_64);
>=20
>     /* build the array of physical mem area from base_memmap */
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index fcb4fb0769..c1e9c0fd9c 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -63,15 +63,16 @@ void fw_cfg_build_smbios(PCMachineState *pcms, =
FWCfgState *fw_cfg)
>     if (pcmc->smbios_defaults) {
>         /* These values are guest ABI, do not change */
>         smbios_set_defaults("QEMU", mc->desc, mc->name,
> -                            pcmc->smbios_legacy_mode, =
pcmc->smbios_uuid_encoded,
> +                            pcmc->smbios_uuid_encoded,
>                             pcms->smbios_entry_point_type);
>     }
>=20
>     /* tell smbios about cpuid version and features */
>     smbios_set_cpuid(cpu->env.cpuid_version, =
cpu->env.features[FEAT_1_EDX]);
>=20
> -    smbios_tables =3D smbios_get_table_legacy(ms->smp.cpus, =
&smbios_tables_len);
> -    if (smbios_tables) {
> +    if (pcmc->smbios_legacy_mode) {
> +        smbios_tables =3D smbios_get_table_legacy(ms->smp.cpus,
> +                                                &smbios_tables_len);
>         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                          smbios_tables, smbios_tables_len);
>         return;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 0ad7d8c887..73fb3522ba 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -320,7 +320,7 @@ static void =
virt_build_smbios(LoongArchMachineState *lams)
>         return;
>     }
>=20
> -    smbios_set_defaults("QEMU", product, mc->name, false,
> +    smbios_set_defaults("QEMU", product, mc->name,
>                         true, SMBIOS_ENTRY_POINT_TYPE_64);
>=20
>     smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fd35c74781..e2c9529df2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1235,7 +1235,7 @@ static void virt_build_smbios(RISCVVirtState *s)
>         product =3D "KVM Virtual Machine";
>     }
>=20
> -    smbios_set_defaults("QEMU", product, mc->name, false,
> +    smbios_set_defaults("QEMU", product, mc->name,
>                         true, SMBIOS_ENTRY_POINT_TYPE_64);
>=20
>     if (riscv_is_32bit(&s->soc[0])) {
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 15339d8dbe..c46fc93357 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -54,7 +54,6 @@ struct smbios_table {
>=20
> static uint8_t *smbios_entries;
> static size_t smbios_entries_len;
> -static bool smbios_legacy =3D true;
> static bool smbios_uuid_encoded =3D true;
> /* end: legacy structures & constants for <=3D 2.0 machines */
>=20
> @@ -570,9 +569,16 @@ static void smbios_build_type_1_fields(void)
>=20
> uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t =
*length)
> {
> -    if (!smbios_legacy) {
> -        *length =3D 0;
> -        return NULL;
> +    /* drop unwanted version of command-line file blob(s) */
> +    g_free(smbios_tables);
> +    smbios_tables =3D NULL;
> +
> +    /* also complain if fields were given for types > 1 */
> +    if (find_next_bit(have_fields_bitmap,
> +                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) =
{
> +        error_report("can't process fields for smbios "
> +                     "types > 1 on machine versions < 2.1!");
> +        exit(1);
>     }
>=20
>     if (!smbios_immutable) {
> @@ -1006,28 +1012,13 @@ void =
smbios_set_default_processor_family(uint16_t processor_family)
> }
>=20
> void smbios_set_defaults(const char *manufacturer, const char =
*product,
> -                         const char *version, bool legacy_mode,
> +                         const char *version,
>                          bool uuid_encoded, SmbiosEntryPointType =
ep_type)
> {
>     smbios_have_defaults =3D true;
> -    smbios_legacy =3D legacy_mode;
>     smbios_uuid_encoded =3D uuid_encoded;
>     smbios_ep_type =3D ep_type;
>=20
> -    /* drop unwanted version of command-line file blob(s) */
> -    if (smbios_legacy) {
> -        g_free(smbios_tables);
> -        /* in legacy mode, also complain if fields were given for =
types > 1 */
> -        if (find_next_bit(have_fields_bitmap,
> -                          SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) =
{
> -            error_report("can't process fields for smbios "
> -                         "types > 1 on machine versions < 2.1!");
> -            exit(1);
> -        }
> -    } else {
> -        g_free(smbios_entries);
> -    }
> -
>     SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
>     SMBIOS_SET_DEFAULT(type1.product, product);
>     SMBIOS_SET_DEFAULT(type1.version, version);
> @@ -1103,6 +1094,10 @@ void smbios_get_tables(MachineState *ms,
> {
>     unsigned i, dimm_cnt, offset;
>=20
> +    /* drop unwanted (legacy) version of command-line file blob(s) */
> +    g_free(smbios_entries);
> +    smbios_entries =3D NULL;
> +

Can you please explain why you do this unconditionally without checking =
for legacy mode? Seems wrong?

>     if (!smbios_immutable) {
>         smbios_build_type_0_table();
>         smbios_build_type_1_table();
> --=20
> 2.39.3
>=20


