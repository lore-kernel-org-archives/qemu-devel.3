Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FABEC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 07:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhlhM-0007Cu-I6; Wed, 06 Mar 2024 02:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhlhI-0007C9-GN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhlhG-0003FF-2X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709710093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFsYZDlrERx+FL9j9xIiMQijsJBRwzfY9+l04hsVCzY=;
 b=YU4jZLiLPwVmMuqDlu/WZblEYDlXanTGNh2X+4i/orXZ3eOaeQ74+hoPThulO70PVPeJ0N
 B79ZNz4+x4qEYWQtO3pfL025SDo/hFi34sDUW+xsCk/kKTKL6tEcuz3TBvn14Hj6jkGB+L
 iCoJqHMWqRmJhGNrdAOhot1T4161xIE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-g9z-fi-yNQ-ikVSpEZDpIA-1; Wed, 06 Mar 2024 02:28:11 -0500
X-MC-Unique: g9z-fi-yNQ-ikVSpEZDpIA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e635098a20so1706986b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 23:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709710085; x=1710314885;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFsYZDlrERx+FL9j9xIiMQijsJBRwzfY9+l04hsVCzY=;
 b=eOFKykc/naRAxubzMhHyFfbKe6uAkLFeRpufM5OqULjG2RWNKsvwtf0z4l+lhTVwy9
 ObhbnygTzkD0vHY63iidDv36/eGxR1/zcRiJUrV2/RZkiDjQ7jxp+6JoLENMW+laXBaJ
 q1AI1ulYilETs06JvQEICm8aH904lPswrgCYNbegqQi+OIUDnsVja5JufHj8MOReFzS8
 Frt1aGjlQl/VizT8BI5FPIbuG2lppyK7vxJH8tiK4CtsmeP0Skg1VMYuf/NefvvcQ3DK
 K8HXBfQWpE/9bbO3LSyhIjzHZLLHmr+R4kJBvwsGTUQVMdfP5WSn3ywMhkyphIcaQEKa
 WB7g==
X-Gm-Message-State: AOJu0Yyef6d1fvjnjitEpRdk+9VmVnDkHz80zmWzs+ylYlIXhp1JRCTZ
 dpWm4W/flcbWggsNOkpqgxPnNIz9f1qimAOjamLZYkkdTrwiqCpPAsKjttFEnU4+VnFe2NKEi6U
 /C9iHEZAdj+AXHhRqOeabdM3YcY1DLrjWY3iubLH7BMv1nfhoJnke
X-Received: by 2002:a05:6a20:c4a8:b0:1a1:4ec7:d3fb with SMTP id
 eo40-20020a056a20c4a800b001a14ec7d3fbmr3235211pzb.58.1709710085516; 
 Tue, 05 Mar 2024 23:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGItsiVmF5NpxEAIIhx6CC7mPhBFMGq7HAEKjYESoNwmzruO6EFB9FC5e7Mh2SrlcEQJmYseQ==
X-Received: by 2002:a05:6a20:c4a8:b0:1a1:4ec7:d3fb with SMTP id
 eo40-20020a056a20c4a800b001a14ec7d3fbmr3235200pzb.58.1709710085153; 
 Tue, 05 Mar 2024 23:28:05 -0800 (PST)
Received: from smtpclient.apple ([115.96.30.47])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a62e410000000b006e46047fe04sm10126410pfh.204.2024.03.05.23.27.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Mar 2024 23:28:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 11/20] smbios: build legacy mode code only for 'pc'
 machine
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240305155724.2047069-12-imammedo@redhat.com>
Date: Wed, 6 Mar 2024 12:57:47 +0530
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
Message-Id: <DE550091-7675-40D6-9651-97E090DF767B@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-12-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 05-Mar-2024, at 21:27, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> basically moving code around without functional change.
> And exposing some symbols so that they could be shared
> between smbbios.c and new smbios_legacy.c
>=20
> plus some meson magic to build smbios_legacy.c only
> for 'pc' machine and otherwise replace it with stub
> if not selected.

When I apply this, I get:

Applying: smbios: build legacy mode code only for 'pc' machine
.git/rebase-apply/patch:483: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Can you please look into this? Modulo that,

>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> v2:
>  moved type0/type1/have_binfile_bitmap/have_fields_bitmap rename into
>  a separate patch
> ---
> include/hw/firmware/smbios.h   |   5 +
> hw/i386/Kconfig                |   1 +
> hw/smbios/Kconfig              |   2 +
> hw/smbios/meson.build          |   4 +
> hw/smbios/smbios.c             | 164 +-----------------------------
> hw/smbios/smbios_legacy.c      | 179 +++++++++++++++++++++++++++++++++
> hw/smbios/smbios_legacy_stub.c |  16 +++
> 7 files changed, 208 insertions(+), 163 deletions(-)
> create mode 100644 hw/smbios/smbios_legacy.c
> create mode 100644 hw/smbios/smbios_legacy_stub.c
>=20
> diff --git a/include/hw/firmware/smbios.h =
b/include/hw/firmware/smbios.h
> index bea5c3f1b1..7f47475aa4 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -17,6 +17,9 @@
>  *
>  */
>=20
> +extern uint8_t *usr_blobs;
> +extern GArray *usr_blobs_sizes;
> +
> typedef struct {
>     const char *vendor, *version, *date;
>     bool have_major_minor, uefi;
> @@ -306,6 +309,8 @@ struct smbios_type_127 {
>     struct smbios_structure_header header;
> } QEMU_PACKED;
>=20
> +void smbios_validate_table(void);
> +void smbios_add_usr_blob_size(size_t size);
> void smbios_entry_add(QemuOpts *opts, Error **errp);
> void smbios_set_cpuid(uint32_t version, uint32_t features);
> void smbios_set_defaults(const char *manufacturer, const char =
*product,
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index a1846be6f7..a6ee052f9a 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -76,6 +76,7 @@ config I440FX
>     select PIIX
>     select DIMM
>     select SMBIOS
> +    select SMBIOS_LEGACY
>     select FW_CFG_DMA
>=20
> config ISAPC
> diff --git a/hw/smbios/Kconfig b/hw/smbios/Kconfig
> index 553adf4bfc..8d989a2f1b 100644
> --- a/hw/smbios/Kconfig
> +++ b/hw/smbios/Kconfig
> @@ -1,2 +1,4 @@
> config SMBIOS
>     bool
> +config SMBIOS_LEGACY
> +    bool
> diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
> index 7046967462..a59039f669 100644
> --- a/hw/smbios/meson.build
> +++ b/hw/smbios/meson.build
> @@ -4,5 +4,9 @@ smbios_ss.add(when: 'CONFIG_IPMI',
>               if_true: files('smbios_type_38.c'),
>               if_false: files('smbios_type_38-stub.c'))
>=20
> +smbios_ss.add(when: 'CONFIG_SMBIOS_LEGACY',
> +              if_true: files('smbios_legacy.c'),
> +              if_false: files('smbios_legacy_stub.c'))
> +
> system_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
> system_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 86cf66b5ce..fb1f05fcde 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -31,38 +31,12 @@
> #include "hw/pci/pci_device.h"
> #include "smbios_build.h"
>=20
> -/* legacy structures and constants for <=3D 2.0 machines */
> -struct smbios_header {
> -    uint16_t length;
> -    uint8_t type;
> -} QEMU_PACKED;
> -
> -struct smbios_field {
> -    struct smbios_header header;
> -    uint8_t type;
> -    uint16_t offset;
> -    uint8_t data[];
> -} QEMU_PACKED;
> -
> -struct smbios_table {
> -    struct smbios_header header;
> -    uint8_t data[];
> -} QEMU_PACKED;
> -
> -#define SMBIOS_FIELD_ENTRY 0
> -#define SMBIOS_TABLE_ENTRY 1
> -
> -static uint8_t *smbios_entries;
> -static size_t smbios_entries_len;
> static bool smbios_uuid_encoded =3D true;
> -/* end: legacy structures & constants for <=3D 2.0 machines */
> -
> /*
>  * SMBIOS tables provided by user with '-smbios file=3D<foo>' option
>  */
> uint8_t *usr_blobs;
> size_t usr_blobs_len;
> -static GArray *usr_blobs_sizes;
> static unsigned usr_table_max;
> static unsigned usr_table_cnt;
>=20
> @@ -483,7 +457,7 @@ static void smbios_check_type4_count(uint32_t =
expected_t4_count)
>     }
> }
>=20
> -static void smbios_validate_table(void)
> +void smbios_validate_table(void)
> {
>     if (smbios_ep_type =3D=3D SMBIOS_ENTRY_POINT_TYPE_32 &&
>         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
> @@ -493,134 +467,6 @@ static void smbios_validate_table(void)
>     }
> }
>=20
> -
> -/* legacy setup functions for <=3D 2.0 machines */
> -static void smbios_add_field(int type, int offset, const void *data, =
size_t len)
> -{
> -    struct smbios_field *field;
> -
> -    if (!smbios_entries) {
> -        smbios_entries_len =3D sizeof(uint16_t);
> -        smbios_entries =3D g_malloc0(smbios_entries_len);
> -    }
> -    smbios_entries =3D g_realloc(smbios_entries, smbios_entries_len +
> -                                                  sizeof(*field) + =
len);
> -    field =3D (struct smbios_field *)(smbios_entries + =
smbios_entries_len);
> -    field->header.type =3D SMBIOS_FIELD_ENTRY;
> -    field->header.length =3D cpu_to_le16(sizeof(*field) + len);
> -
> -    field->type =3D type;
> -    field->offset =3D cpu_to_le16(offset);
> -    memcpy(field->data, data, len);
> -
> -    smbios_entries_len +=3D sizeof(*field) + len;
> -    (*(uint16_t *)smbios_entries) =3D
> -            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + =
1);
> -}
> -
> -static void smbios_maybe_add_str(int type, int offset, const char =
*data)
> -{
> -    if (data) {
> -        smbios_add_field(type, offset, data, strlen(data) + 1);
> -    }
> -}
> -
> -static void smbios_build_type_0_fields(void)
> -{
> -    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, =
vendor_str),
> -                         smbios_type0.vendor);
> -    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, =
bios_version_str),
> -                         smbios_type0.version);
> -    smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
> -                                     bios_release_date_str),
> -                         smbios_type0.date);
> -    if (smbios_type0.have_major_minor) {
> -        smbios_add_field(0, offsetof(struct smbios_type_0,
> -                                     system_bios_major_release),
> -                         &smbios_type0.major, 1);
> -        smbios_add_field(0, offsetof(struct smbios_type_0,
> -                                     system_bios_minor_release),
> -                         &smbios_type0.minor, 1);
> -    }
> -}
> -
> -static void smbios_build_type_1_fields(void)
> -{
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
manufacturer_str),
> -                         smbios_type1.manufacturer);
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
product_name_str),
> -                         smbios_type1.product);
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
version_str),
> -                         smbios_type1.version);
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
serial_number_str),
> -                         smbios_type1.serial);
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
sku_number_str),
> -                         smbios_type1.sku);
> -    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
family_str),
> -                         smbios_type1.family);
> -    if (qemu_uuid_set) {
> -        /* We don't encode the UUID in the "wire format" here because =
this
> -         * function is for legacy mode and needs to keep the guest =
ABI, and
> -         * because we don't know what's the SMBIOS version advertised =
by the
> -         * BIOS.
> -         */
> -        smbios_add_field(1, offsetof(struct smbios_type_1, uuid),
> -                         &qemu_uuid, 16);
> -    }
> -}
> -
> -uint8_t *smbios_get_table_legacy(size_t *length)
> -{
> -    int i;
> -    size_t usr_offset;
> -
> -    /* also complain if fields were given for types > 1 */
> -    if (find_next_bit(smbios_have_fields_bitmap,
> -                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) =
{
> -        error_report("can't process fields for smbios "
> -                     "types > 1 on machine versions < 2.1!");
> -        exit(1);
> -    }
> -
> -    if (test_bit(4, smbios_have_binfile_bitmap)) {
> -        error_report("can't process table for smbios "
> -                     "type 4 on machine versions < 2.1!");
> -        exit(1);
> -    }
> -
> -    g_free(smbios_entries);
> -    smbios_entries_len =3D sizeof(uint16_t);
> -    smbios_entries =3D g_malloc0(smbios_entries_len);
> -
> -    for (i =3D 0, usr_offset =3D 0; usr_blobs_sizes && i < =
usr_blobs_sizes->len;
> -         i++)
> -    {
> -        struct smbios_table *table;
> -        struct smbios_structure_header *header;
> -        size_t size =3D g_array_index(usr_blobs_sizes, size_t, i);
> -
> -        header =3D (struct smbios_structure_header *)(usr_blobs + =
usr_offset);
> -        smbios_entries =3D g_realloc(smbios_entries, =
smbios_entries_len +
> -                                                   size + =
sizeof(*table));
> -        table =3D (struct smbios_table *)(smbios_entries + =
smbios_entries_len);
> -        table->header.type =3D SMBIOS_TABLE_ENTRY;
> -        table->header.length =3D cpu_to_le16(sizeof(*table) + size);
> -        memcpy(table->data, header, size);
> -        smbios_entries_len +=3D sizeof(*table) + size;
> -        (*(uint16_t *)smbios_entries) =3D
> -            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + =
1);
> -        usr_offset +=3D size;
> -    }
> -
> -    smbios_build_type_0_fields();
> -    smbios_build_type_1_fields();
> -    smbios_validate_table();
> -    *length =3D smbios_entries_len;
> -    return smbios_entries;
> -}
> -/* end: legacy setup functions for <=3D 2.0 machines */
> -
> -
> bool smbios_skip_table(uint8_t type, bool required_table)
> {
>     if (test_bit(type, smbios_have_binfile_bitmap)) {
> @@ -1279,14 +1125,6 @@ static bool save_opt_list(size_t *ndest, char =
***dest, QemuOpts *opts,
>     return true;
> }
>=20
> -static void smbios_add_usr_blob_size(size_t size)
> -{
> -    if (!usr_blobs_sizes) {
> -        usr_blobs_sizes =3D g_array_new(false, false, =
sizeof(size_t));
> -    }
> -    g_array_append_val(usr_blobs_sizes, size);
> -}
> -
> void smbios_entry_add(QemuOpts *opts, Error **errp)
> {
>     const char *val;
> diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
> new file mode 100644
> index 0000000000..21f143e738
> --- /dev/null
> +++ b/hw/smbios/smbios_legacy.c
> @@ -0,0 +1,179 @@
> +/*
> + * SMBIOS legacy support
> + *
> + * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
> + * Copyright (C) 2013 Red Hat, Inc.
> + *
> + * Authors:
> + *  Alex Williamson <alex.williamson@hp.com>
> + *  Markus Armbruster <armbru@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  =
See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "hw/firmware/smbios.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +struct smbios_header {
> +    uint16_t length;
> +    uint8_t type;
> +} QEMU_PACKED;
> +
> +struct smbios_field {
> +    struct smbios_header header;
> +    uint8_t type;
> +    uint16_t offset;
> +    uint8_t data[];
> +} QEMU_PACKED;
> +
> +struct smbios_table {
> +    struct smbios_header header;
> +    uint8_t data[];
> +} QEMU_PACKED;
> +
> +#define SMBIOS_FIELD_ENTRY 0
> +#define SMBIOS_TABLE_ENTRY 1
> +
> +static uint8_t *smbios_entries;
> +static size_t smbios_entries_len;
> +GArray *usr_blobs_sizes;
> +
> +void smbios_add_usr_blob_size(size_t size)
> +{
> +    if (!usr_blobs_sizes) {
> +        usr_blobs_sizes =3D g_array_new(false, false, =
sizeof(size_t));
> +    }
> +    g_array_append_val(usr_blobs_sizes, size);
> +}
> +
> +static void smbios_add_field(int type, int offset, const void *data, =
size_t len)
> +{
> +    struct smbios_field *field;
> +
> +    if (!smbios_entries) {
> +        smbios_entries_len =3D sizeof(uint16_t);
> +        smbios_entries =3D g_malloc0(smbios_entries_len);
> +    }
> +    smbios_entries =3D g_realloc(smbios_entries, smbios_entries_len +
> +                                                  sizeof(*field) + =
len);
> +    field =3D (struct smbios_field *)(smbios_entries + =
smbios_entries_len);
> +    field->header.type =3D SMBIOS_FIELD_ENTRY;
> +    field->header.length =3D cpu_to_le16(sizeof(*field) + len);
> +
> +    field->type =3D type;
> +    field->offset =3D cpu_to_le16(offset);
> +    memcpy(field->data, data, len);
> +
> +    smbios_entries_len +=3D sizeof(*field) + len;
> +    (*(uint16_t *)smbios_entries) =3D
> +            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + =
1);
> +}
> +
> +static void smbios_maybe_add_str(int type, int offset, const char =
*data)
> +{
> +    if (data) {
> +        smbios_add_field(type, offset, data, strlen(data) + 1);
> +    }
> +}
> +
> +static void smbios_build_type_0_fields(void)
> +{
> +    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, =
vendor_str),
> +                         smbios_type0.vendor);
> +    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, =
bios_version_str),
> +                         smbios_type0.version);
> +    smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
> +                                     bios_release_date_str),
> +                         smbios_type0.date);
> +    if (smbios_type0.have_major_minor) {
> +        smbios_add_field(0, offsetof(struct smbios_type_0,
> +                                     system_bios_major_release),
> +                         &smbios_type0.major, 1);
> +        smbios_add_field(0, offsetof(struct smbios_type_0,
> +                                     system_bios_minor_release),
> +                         &smbios_type0.minor, 1);
> +    }
> +}
> +
> +static void smbios_build_type_1_fields(void)
> +{
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
manufacturer_str),
> +                         smbios_type1.manufacturer);
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
product_name_str),
> +                         smbios_type1.product);
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
version_str),
> +                         smbios_type1.version);
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
serial_number_str),
> +                         smbios_type1.serial);
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
sku_number_str),
> +                         smbios_type1.sku);
> +    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, =
family_str),
> +                         smbios_type1.family);
> +    if (qemu_uuid_set) {
> +        /*
> +         * We don't encode the UUID in the "wire format" here because =
this
> +         * function is for legacy mode and needs to keep the guest =
ABI, and
> +         * because we don't know what's the SMBIOS version advertised =
by the
> +         * BIOS.
> +         */
> +        smbios_add_field(1, offsetof(struct smbios_type_1, uuid),
> +                         &qemu_uuid, 16);
> +    }
> +}
> +
> +uint8_t *smbios_get_table_legacy(size_t *length)
> +{
> +    int i;
> +    size_t usr_offset;
> +
> +    /* complain if fields were given for types > 1 */
> +    if (find_next_bit(smbios_have_fields_bitmap,
> +                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) =
{
> +        error_report("can't process fields for smbios "
> +                     "types > 1 on machine versions < 2.1!");
> +        exit(1);
> +    }
> +
> +    if (test_bit(4, smbios_have_binfile_bitmap)) {
> +        error_report("can't process table for smbios "
> +                     "type 4 on machine versions < 2.1!");
> +        exit(1);
> +    }
> +
> +    g_free(smbios_entries);
> +    smbios_entries_len =3D sizeof(uint16_t);
> +    smbios_entries =3D g_malloc0(smbios_entries_len);
> +
> +    for (i =3D 0, usr_offset =3D 0; usr_blobs_sizes && i < =
usr_blobs_sizes->len;
> +         i++)
> +    {
> +        struct smbios_table *table;
> +        struct smbios_structure_header *header;
> +        size_t size =3D g_array_index(usr_blobs_sizes, size_t, i);
> +
> +        header =3D (struct smbios_structure_header *)(usr_blobs + =
usr_offset);
> +        smbios_entries =3D g_realloc(smbios_entries, =
smbios_entries_len +
> +                                                   size + =
sizeof(*table));
> +        table =3D (struct smbios_table *)(smbios_entries + =
smbios_entries_len);
> +        table->header.type =3D SMBIOS_TABLE_ENTRY;
> +        table->header.length =3D cpu_to_le16(sizeof(*table) + size);
> +        memcpy(table->data, header, size);
> +        smbios_entries_len +=3D sizeof(*table) + size;
> +        (*(uint16_t *)smbios_entries) =3D
> +            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + =
1);
> +        usr_offset +=3D size;
> +    }
> +
> +    smbios_build_type_0_fields();
> +    smbios_build_type_1_fields();
> +    smbios_validate_table();
> +    *length =3D smbios_entries_len;
> +    return smbios_entries;
> +}
> diff --git a/hw/smbios/smbios_legacy_stub.c =
b/hw/smbios/smbios_legacy_stub.c
> new file mode 100644
> index 0000000000..91e6c75029
> --- /dev/null
> +++ b/hw/smbios/smbios_legacy_stub.c
> @@ -0,0 +1,16 @@
> +/*
> + * IPMI SMBIOS firmware handling
> + *
> + * Copyright (c) 2024 Igor Mammedov, Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/firmware/smbios.h"
> +
> +void smbios_add_usr_blob_size(size_t size)
> +{
> +}
> +
> --=20
> 2.39.3
>=20


