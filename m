Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9669CC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 04:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4yw-00059y-O8; Wed, 06 Mar 2024 23:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ri4yu-00057b-Lz
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 23:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ri4ys-00018a-Lg
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 23:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709784221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wenKE+MVTcK8m6UPJnyls0Ib8nxNGHTk5ssV3xWvL58=;
 b=JUfuKB5gwED9ZBiaFs/tjhNssG/TUszPUPaQTGiX3F7nnvAG8E+csFTe80jCfbh9DplnjN
 zA6NDm3WSYbsAu5LVTsAllatKBq8K4BlIm2HgCjphjVg97A1VOaEtT0AxBgN1vwtKNPDaH
 OjrsUFL3+wYoNfejT8kPr1upth1tL10=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-0vq-uUKoPZOAQxHouAIHJQ-1; Wed, 06 Mar 2024 23:03:37 -0500
X-MC-Unique: 0vq-uUKoPZOAQxHouAIHJQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c2283e13deso72123b6e.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 20:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709784216; x=1710389016;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wenKE+MVTcK8m6UPJnyls0Ib8nxNGHTk5ssV3xWvL58=;
 b=wSdHWNfc3HtYhLpXAkThn5YVJpD0rzWPiWJ+Cfcc4rDg5SOTwnZIusfiGE9dz3mpVZ
 q33tjYt41YfEdQBcfeLguW2F7UMwVDy/wRhZmXsI628wifzIj3uI53cYSf1sHmVo0NYB
 OBcNlDkiaCwFEWAb1weaklEfLQFhzKeANyT5JacRrrrh1RNL5bMuKYcNmwzCYgiuksgd
 5v84b7eSmoBLzrdVz55qSQLbmOa7uaudF3MqovSFvBlZj1qBvTVyWToi7Wpc9+hSjRrw
 aaesXWZA5Jfupz5XIqkEbBeq7ygMu5X7cQQAb2pURPJHCj+/JB9i8av5LGTtlTp889uJ
 Ppww==
X-Gm-Message-State: AOJu0Yw0y8T+Cv/gtqC4jF01l1KoNKQSfVxxM65Z+vANKlskbZA6TwzZ
 OffBI2kyx9Gs0rzMwus762RgUsKI4a/JK+yij61WSLxClI9bLUO43iHAEIp3RshYq326+0x4KDv
 /q0YV4M6qr58MWbRZWqkMXhYe0jkRULeXQKfDFRxGOZAVk8qzc+e5
X-Received: by 2002:a05:6808:6297:b0:3c2:154f:7716 with SMTP id
 du23-20020a056808629700b003c2154f7716mr5048228oib.43.1709784215616; 
 Wed, 06 Mar 2024 20:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2h/4nOjekEMJlxbi4X3ooN7C2+MMXjeZW+K/GAlX65DMAOzdfTfKsiBfU4CpgFBPiC7aW8g==
X-Received: by 2002:a05:6808:6297:b0:3c2:154f:7716 with SMTP id
 du23-20020a056808629700b003c2154f7716mr5048210oib.43.1709784215194; 
 Wed, 06 Mar 2024 20:03:35 -0800 (PST)
Received: from smtpclient.apple ([116.73.135.231])
 by smtp.gmail.com with ESMTPSA id
 r31-20020a63fc5f000000b005dc3fc53f19sm11566107pgk.7.2024.03.06.20.03.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2024 20:03:34 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 07/20] smbios: avoid mangling user provided tables
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0eeed9a2-cd7b-bdde-6346-3357dc430835@redhat.com>
Date: Thu, 7 Mar 2024 09:33:17 +0530
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
Message-Id: <97A9187B-2BB6-4819-AB28-679C0DE04501@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-8-imammedo@redhat.com>
 <0eeed9a2-cd7b-bdde-6346-3357dc430835@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 06-Mar-2024, at 12:11, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
> On Tue, 5 Mar 2024, Igor Mammedov wrote:
>=20
>> currently smbios_entry_add() preserves internally '-smbios type=3D'
>> options but tables provided with '-smbios file=3D' are stored =
directly
>> into blob that eventually will be exposed to VM. And then later
>> QEMU adds default/'-smbios type' entries on top into the same blob.
>>=20
>> It makes impossible to generate tables more than once, hence
>> 'immutable' guard was used.
>> Make it possible to regenerate final blob by storing user provided
>> blobs into a dedicated area (usr_blobs) and then copy it when
>> composing final blob. Which also makes handling of -smbios
>> options consistent.
>>=20
>> As side effect of this and previous commits there is no need to
>> generate legacy smbios_entries at the time options are parsed.
>> Instead compose smbios_entries on demand from  usr_blobs like
>> it is done for non-legacy SMBIOS tables.
>>=20
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>=20
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>=20
>> ---
>> hw/smbios/smbios.c | 179 =
+++++++++++++++++++++++----------------------
>> 1 file changed, 92 insertions(+), 87 deletions(-)
>>=20
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index c46fc93357..aa2cc5bdbd 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -57,6 +57,14 @@ static size_t smbios_entries_len;
>> static bool smbios_uuid_encoded =3D true;
>> /* end: legacy structures & constants for <=3D 2.0 machines */
>>=20
>> +/*
>> + * SMBIOS tables provided by user with '-smbios file=3D<foo>' option
>> + */
>> +uint8_t *usr_blobs;
>> +size_t usr_blobs_len;
>> +static GArray *usr_blobs_sizes;
>> +static unsigned usr_table_max;
>> +static unsigned usr_table_cnt;
>>=20
>> uint8_t *smbios_tables;
>> size_t smbios_tables_len;
>> @@ -67,7 +75,6 @@ static SmbiosEntryPointType smbios_ep_type =3D =
SMBIOS_ENTRY_POINT_TYPE_32;
>> static SmbiosEntryPoint ep;
>>=20
>> static int smbios_type4_count =3D 0;
>> -static bool smbios_immutable;
>> static bool smbios_have_defaults;
>> static uint32_t smbios_cpuid_version, smbios_cpuid_features;
>>=20
>> @@ -569,9 +576,8 @@ static void smbios_build_type_1_fields(void)
>>=20
>> uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t =
*length)
>> {
>> -    /* drop unwanted version of command-line file blob(s) */
>> -    g_free(smbios_tables);
>> -    smbios_tables =3D NULL;
>> +    int i;
>> +    size_t usr_offset;
>>=20
>>     /* also complain if fields were given for types > 1 */
>>     if (find_next_bit(have_fields_bitmap,
>> @@ -581,12 +587,33 @@ uint8_t *smbios_get_table_legacy(uint32_t =
expected_t4_count, size_t *length)
>>         exit(1);
>>     }
>>=20
>> -    if (!smbios_immutable) {
>> -        smbios_build_type_0_fields();
>> -        smbios_build_type_1_fields();
>> -        smbios_validate_table(expected_t4_count);
>> -        smbios_immutable =3D true;
>> +    g_free(smbios_entries);
>> +    smbios_entries_len =3D sizeof(uint16_t);
>> +    smbios_entries =3D g_malloc0(smbios_entries_len);
>> +
>> +    for (i =3D 0, usr_offset =3D 0; usr_blobs_sizes && i < =
usr_blobs_sizes->len;
>> +         i++)
>> +    {
>> +        struct smbios_table *table;
>> +        struct smbios_structure_header *header;
>> +        size_t size =3D g_array_index(usr_blobs_sizes, size_t, i);
>> +
>> +        header =3D (struct smbios_structure_header *)(usr_blobs + =
usr_offset);
>> +        smbios_entries =3D g_realloc(smbios_entries, =
smbios_entries_len +
>> +                                                   size + =
sizeof(*table));
>> +        table =3D (struct smbios_table *)(smbios_entries + =
smbios_entries_len);
>> +        table->header.type =3D SMBIOS_TABLE_ENTRY;
>> +        table->header.length =3D cpu_to_le16(sizeof(*table) + size);
>> +        memcpy(table->data, header, size);
>> +        smbios_entries_len +=3D sizeof(*table) + size;
>> +        (*(uint16_t *)smbios_entries) =3D
>> +            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + =
1);
>=20
> I know this comes from existing code but can you please explain why we =
add
> 1 to it? This is confusing and a comment here would be nice.
>=20
>> +        usr_offset +=3D size;
>=20
> It would be better if we could add a comment here describing a bit =
what
> this is all about.
>=20
> user blobs are an array of smbios_structure_header entries whereas =
legacy
> tables are an array of smbios_table structures where
> smbios_table->data represents the a single user provided table blob in
> smbios_structure_header.

Igor, are you going to send a v3 for this with the comments added?

>=20
>>     }
>> +
>> +    smbios_build_type_0_fields();
>> +    smbios_build_type_1_fields();
>> +    smbios_validate_table(expected_t4_count);
>>     *length =3D smbios_entries_len;
>>     return smbios_entries;
>> }
>> @@ -1094,67 +1121,67 @@ void smbios_get_tables(MachineState *ms,
>> {
>>     unsigned i, dimm_cnt, offset;
>>=20
>> -    /* drop unwanted (legacy) version of command-line file blob(s) =
*/
>> -    g_free(smbios_entries);
>> -    smbios_entries =3D NULL;
>> +    g_free(smbios_tables);
>> +    smbios_tables =3D g_memdup2(usr_blobs, usr_blobs_len);
>=20
> Again a comment describing here would be nice as to why memdup is ok.
>=20
>> +    smbios_tables_len =3D usr_blobs_len;
>> +    smbios_table_max =3D usr_table_max;
>> +    smbios_table_cnt =3D usr_table_cnt;
>>=20
>> -    if (!smbios_immutable) {
>> -        smbios_build_type_0_table();
>> -        smbios_build_type_1_table();
>> -        smbios_build_type_2_table();
>> -        smbios_build_type_3_table();
>> +    smbios_build_type_0_table();
>> +    smbios_build_type_1_table();
>> +    smbios_build_type_2_table();
>> +    smbios_build_type_3_table();
>>=20
>> -        assert(ms->smp.sockets >=3D 1);
>> +    assert(ms->smp.sockets >=3D 1);
>>=20
>> -        for (i =3D 0; i < ms->smp.sockets; i++) {
>> -            smbios_build_type_4_table(ms, i);
>> -        }
>> +    for (i =3D 0; i < ms->smp.sockets; i++) {
>> +        smbios_build_type_4_table(ms, i);
>> +    }
>>=20
>> -        smbios_build_type_8_table();
>> -        smbios_build_type_11_table();
>> +    smbios_build_type_8_table();
>> +    smbios_build_type_11_table();
>>=20
>> #define MAX_DIMM_SZ (16 * GiB)
>> #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
>>                                         : ((current_machine->ram_size =
- 1) % MAX_DIMM_SZ) + 1)
>>=20
>> -        dimm_cnt =3D QEMU_ALIGN_UP(current_machine->ram_size, =
MAX_DIMM_SZ) / MAX_DIMM_SZ;
>> +    dimm_cnt =3D QEMU_ALIGN_UP(current_machine->ram_size, =
MAX_DIMM_SZ) /
>> +               MAX_DIMM_SZ;
>>=20
>> -        /*
>> -         * The offset determines if we need to keep additional space =
between
>> -         * table 17 and table 19 header handle numbers so that they =
do
>> -         * not overlap. For example, for a VM with larger than 8 TB =
guest
>> -         * memory and DIMM like chunks of 16 GiB, the default space =
between
>> -         * the two tables (T19_BASE - T17_BASE =3D 512) is not =
enough.
>> -         */
>> -        offset =3D (dimm_cnt > (T19_BASE - T17_BASE)) ? \
>> -                 dimm_cnt - (T19_BASE - T17_BASE) : 0;
>> +    /*
>> +     * The offset determines if we need to keep additional space =
between
>> +     * table 17 and table 19 header handle numbers so that they do
>> +     * not overlap. For example, for a VM with larger than 8 TB =
guest
>> +     * memory and DIMM like chunks of 16 GiB, the default space =
between
>> +     * the two tables (T19_BASE - T17_BASE =3D 512) is not enough.
>> +     */
>> +    offset =3D (dimm_cnt > (T19_BASE - T17_BASE)) ? \
>> +             dimm_cnt - (T19_BASE - T17_BASE) : 0;
>>=20
>> -        smbios_build_type_16_table(dimm_cnt);
>> +    smbios_build_type_16_table(dimm_cnt);
>>=20
>> -        for (i =3D 0; i < dimm_cnt; i++) {
>> -            smbios_build_type_17_table(i, GET_DIMM_SZ);
>> -        }
>> +    for (i =3D 0; i < dimm_cnt; i++) {
>> +        smbios_build_type_17_table(i, GET_DIMM_SZ);
>> +    }
>>=20
>> -        for (i =3D 0; i < mem_array_size; i++) {
>> -            smbios_build_type_19_table(i, offset, =
mem_array[i].address,
>> -                                       mem_array[i].length);
>> -        }
>> +    for (i =3D 0; i < mem_array_size; i++) {
>> +        smbios_build_type_19_table(i, offset, mem_array[i].address,
>> +                                   mem_array[i].length);
>> +    }
>>=20
>> -        /*
>> -         * make sure 16 bit handle numbers in the headers of tables =
19
>> -         * and 32 do not overlap.
>> -         */
>> -        assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
>> +    /*
>> +     * make sure 16 bit handle numbers in the headers of tables 19
>> +     * and 32 do not overlap.
>> +     */
>> +    assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
>>=20
>> -        smbios_build_type_32_table();
>> -        smbios_build_type_38_table();
>> -        smbios_build_type_41_table(errp);
>> -        smbios_build_type_127_table();
>> +    smbios_build_type_32_table();
>> +    smbios_build_type_38_table();
>> +    smbios_build_type_41_table(errp);
>> +    smbios_build_type_127_table();
>>=20
>> -        smbios_validate_table(ms->smp.sockets);
>> -        smbios_entry_point_setup();
>> -        smbios_immutable =3D true;
>> -    }
>> +    smbios_validate_table(ms->smp.sockets);
>> +    smbios_entry_point_setup();
>>=20
>>     /* return tables blob and entry point (anchor), and their sizes =
*/
>>     *tables =3D smbios_tables;
>> @@ -1254,13 +1281,10 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>> {
>>     const char *val;
>>=20
>> -    assert(!smbios_immutable);
>> -
>>     val =3D qemu_opt_get(opts, "file");
>>     if (val) {
>>         struct smbios_structure_header *header;
>> -        int size;
>> -        struct smbios_table *table; /* legacy mode only */
>> +        size_t size;
>>=20
>>         if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
>>             return;
>> @@ -1277,9 +1301,9 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>>          * (except in legacy mode, where the second '\0' is implicit =
and
>>          *  will be inserted by the BIOS).
>>          */
>> -        smbios_tables =3D g_realloc(smbios_tables, smbios_tables_len =
+ size);
>> -        header =3D (struct smbios_structure_header *)(smbios_tables =
+
>> -                                                    =
smbios_tables_len);
>> +        usr_blobs =3D g_realloc(usr_blobs, usr_blobs_len + size);
>> +        header =3D (struct smbios_structure_header *)(usr_blobs +
>> +                                                    usr_blobs_len);
>>=20
>>         if (load_image_size(val, (uint8_t *)header, size) !=3D size) =
{
>>             error_setg(errp, "Failed to load SMBIOS file %s", val);
>> @@ -1300,34 +1324,15 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>>             smbios_type4_count++;
>>         }
>>=20
>> -        smbios_tables_len +=3D size;
>> -        if (size > smbios_table_max) {
>> -            smbios_table_max =3D size;
>> +        if (!usr_blobs_sizes) {
>> +            usr_blobs_sizes =3D g_array_new(false, false, =
sizeof(size_t));
>>         }
>> -        smbios_table_cnt++;
>> -
>> -        /* add a copy of the newly loaded blob to legacy =
smbios_entries */
>> -        /* NOTE: This code runs before smbios_set_defaults(), so we =
don't
>> -         *       yet know which mode (legacy vs. aggregate-table) =
will be
>> -         *       required. We therefore add the binary blob to both =
legacy
>> -         *       (smbios_entries) and aggregate (smbios_tables) =
tables, and
>> -         *       delete the one we don't need from =
smbios_set_defaults(),
>> -         *       once we know which machine version has been =
requested.
>> -         */
>> -        if (!smbios_entries) {
>> -            smbios_entries_len =3D sizeof(uint16_t);
>> -            smbios_entries =3D g_malloc0(smbios_entries_len);
>> +        g_array_append_val(usr_blobs_sizes, size);
>> +        usr_blobs_len +=3D size;
>> +        if (size > usr_table_max) {
>> +            usr_table_max =3D size;
>>         }
>> -        smbios_entries =3D g_realloc(smbios_entries, =
smbios_entries_len +
>> -                                                   size + =
sizeof(*table));
>> -        table =3D (struct smbios_table *)(smbios_entries + =
smbios_entries_len);
>> -        table->header.type =3D SMBIOS_TABLE_ENTRY;
>> -        table->header.length =3D cpu_to_le16(sizeof(*table) + size);
>> -        memcpy(table->data, header, size);
>> -        smbios_entries_len +=3D sizeof(*table) + size;
>> -        (*(uint16_t *)smbios_entries) =3D
>> -                cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) =
+ 1);
>> -        /* end: add a copy of the newly loaded blob to legacy =
smbios_entries */
>> +        usr_table_cnt++;
>>=20
>>         return;
>>     }
>> --
>> 2.39.3



