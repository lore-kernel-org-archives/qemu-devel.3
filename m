Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8821BC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkyL-0003XW-5b; Wed, 06 Mar 2024 01:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhky9-0003WE-Bt
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhky6-0000SM-OT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709707293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5x3iQ+o9MdNG+rw2Auq87crWL0YefwVSeYPIgkDiOu4=;
 b=JgHEYykb1VUBd5IcvdENguoW5IrSbykMYnqDW7uiul4l1wHsPd3e+hdUGQkFCmu02lDm+z
 7oveW1PWBEVF1D0cAlfZ3AWbQT2zJ/ooZly91KIMREI+AOs/h0Sr6pnTHg3gS4jUY7KENb
 S4ksTclc32PG6oKq4TNMWJgPA6qWiAw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8_us6ZDrNdmx9YbqulfpZg-1; Wed, 06 Mar 2024 01:41:29 -0500
X-MC-Unique: 8_us6ZDrNdmx9YbqulfpZg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29a5bae5b3fso5309021a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709707288; x=1710312088;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5x3iQ+o9MdNG+rw2Auq87crWL0YefwVSeYPIgkDiOu4=;
 b=o71ZeTd72eyjv3mXGZ04+8dcAVO7f8QMQNm9WnmprDa13ZCWXxejJflTbISUf9ymBJ
 rEb5c+PqtzCCAkCdeLEE6fiLBZry47nxMH6VoSAAWU/3I1V62zdC+yfXHgWk7KGbiPUl
 t4lWcMn5iThPAJtFrHlIs8ZPuacgAxunlbNtAtxegi6VReIZ0GMa1qXtbg4/cwWtBiVU
 N+4gfdGUjes8dnh6jqq+Y2lxupTuYCH8wvg2qLheSJL5qqNqABznRGkSw1G11GmiLsqP
 V9CzQKPKLyPzkPHqYH9mKkAFoJQ0bg2mx5LRY05kooCQnIyNSPC4JqDOiKNWxU3HGl3W
 tb7A==
X-Gm-Message-State: AOJu0YzlNeTKTZUD1/7ctS7ALoiCHQjv5fcm0D2SQlxF5ZO0gptcc3lP
 FKoC/ZWTR8rKHFgACH7DhvSu7sWWd0Xtp4lz3eKPfv4I4HfkU1mUfgbZogkWOH9jZiW6ifJx/3h
 Pru+U2dlp8Rtw1h2LTmxZvBIfpyWbvc9pVCzvBo4s59/s9+65I4Pw
X-Received: by 2002:a17:90b:20c:b0:29a:9f04:fbcd with SMTP id
 fy12-20020a17090b020c00b0029a9f04fbcdmr13293913pjb.20.1709707288558; 
 Tue, 05 Mar 2024 22:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiLyX/73IoA4TDKQ2eGwJHutThPRBKFcOBnZwXHvi/yeiGwUKRq/8Ek9DMv5S5tdhJcXDO3A==
X-Received: by 2002:a17:90b:20c:b0:29a:9f04:fbcd with SMTP id
 fy12-20020a17090b020c00b0029a9f04fbcdmr13293900pjb.20.1709707288127; 
 Tue, 05 Mar 2024 22:41:28 -0800 (PST)
Received: from fc37-ani ([115.96.30.47]) by smtp.googlemail.com with ESMTPSA id
 d8-20020a170903230800b001db5bdd5e33sm11709816plh.48.2024.03.05.22.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 22:41:27 -0800 (PST)
Date: Wed, 6 Mar 2024 12:11:18 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org, 
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH v2 07/20] smbios: avoid mangling user provided tables
In-Reply-To: <20240305155724.2047069-8-imammedo@redhat.com>
Message-ID: <0eeed9a2-cd7b-bdde-6346-3357dc430835@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-8-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On Tue, 5 Mar 2024, Igor Mammedov wrote:

> currently smbios_entry_add() preserves internally '-smbios type='
> options but tables provided with '-smbios file=' are stored directly
> into blob that eventually will be exposed to VM. And then later
> QEMU adds default/'-smbios type' entries on top into the same blob.
>
> It makes impossible to generate tables more than once, hence
> 'immutable' guard was used.
> Make it possible to regenerate final blob by storing user provided
> blobs into a dedicated area (usr_blobs) and then copy it when
> composing final blob. Which also makes handling of -smbios
> options consistent.
>
> As side effect of this and previous commits there is no need to
> generate legacy smbios_entries at the time options are parsed.
> Instead compose smbios_entries on demand from  usr_blobs like
> it is done for non-legacy SMBIOS tables.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/smbios/smbios.c | 179 +++++++++++++++++++++++----------------------
>  1 file changed, 92 insertions(+), 87 deletions(-)
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index c46fc93357..aa2cc5bdbd 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -57,6 +57,14 @@ static size_t smbios_entries_len;
>  static bool smbios_uuid_encoded = true;
>  /* end: legacy structures & constants for <= 2.0 machines */
>
> +/*
> + * SMBIOS tables provided by user with '-smbios file=<foo>' option
> + */
> +uint8_t *usr_blobs;
> +size_t usr_blobs_len;
> +static GArray *usr_blobs_sizes;
> +static unsigned usr_table_max;
> +static unsigned usr_table_cnt;
>
>  uint8_t *smbios_tables;
>  size_t smbios_tables_len;
> @@ -67,7 +75,6 @@ static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>  static SmbiosEntryPoint ep;
>
>  static int smbios_type4_count = 0;
> -static bool smbios_immutable;
>  static bool smbios_have_defaults;
>  static uint32_t smbios_cpuid_version, smbios_cpuid_features;
>
> @@ -569,9 +576,8 @@ static void smbios_build_type_1_fields(void)
>
>  uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
>  {
> -    /* drop unwanted version of command-line file blob(s) */
> -    g_free(smbios_tables);
> -    smbios_tables = NULL;
> +    int i;
> +    size_t usr_offset;
>
>      /* also complain if fields were given for types > 1 */
>      if (find_next_bit(have_fields_bitmap,
> @@ -581,12 +587,33 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
>          exit(1);
>      }
>
> -    if (!smbios_immutable) {
> -        smbios_build_type_0_fields();
> -        smbios_build_type_1_fields();
> -        smbios_validate_table(expected_t4_count);
> -        smbios_immutable = true;
> +    g_free(smbios_entries);
> +    smbios_entries_len = sizeof(uint16_t);
> +    smbios_entries = g_malloc0(smbios_entries_len);
> +
> +    for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
> +         i++)
> +    {
> +        struct smbios_table *table;
> +        struct smbios_structure_header *header;
> +        size_t size = g_array_index(usr_blobs_sizes, size_t, i);
> +
> +        header = (struct smbios_structure_header *)(usr_blobs + usr_offset);
> +        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
> +                                                   size + sizeof(*table));
> +        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
> +        table->header.type = SMBIOS_TABLE_ENTRY;
> +        table->header.length = cpu_to_le16(sizeof(*table) + size);
> +        memcpy(table->data, header, size);
> +        smbios_entries_len += sizeof(*table) + size;
> +        (*(uint16_t *)smbios_entries) =
> +            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);

I know this comes from existing code but can you please explain why we add
1 to it? This is confusing and a comment here would be nice.

> +        usr_offset += size;

It would be better if we could add a comment here describing a bit what
this is all about.

user blobs are an array of smbios_structure_header entries whereas legacy
tables are an array of smbios_table structures where
smbios_table->data represents the a single user provided table blob in
smbios_structure_header.

>      }
> +
> +    smbios_build_type_0_fields();
> +    smbios_build_type_1_fields();
> +    smbios_validate_table(expected_t4_count);
>      *length = smbios_entries_len;
>      return smbios_entries;
>  }
> @@ -1094,67 +1121,67 @@ void smbios_get_tables(MachineState *ms,
>  {
>      unsigned i, dimm_cnt, offset;
>
> -    /* drop unwanted (legacy) version of command-line file blob(s) */
> -    g_free(smbios_entries);
> -    smbios_entries = NULL;
> +    g_free(smbios_tables);
> +    smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);

Again a comment describing here would be nice as to why memdup is ok.

> +    smbios_tables_len = usr_blobs_len;
> +    smbios_table_max = usr_table_max;
> +    smbios_table_cnt = usr_table_cnt;
>
> -    if (!smbios_immutable) {
> -        smbios_build_type_0_table();
> -        smbios_build_type_1_table();
> -        smbios_build_type_2_table();
> -        smbios_build_type_3_table();
> +    smbios_build_type_0_table();
> +    smbios_build_type_1_table();
> +    smbios_build_type_2_table();
> +    smbios_build_type_3_table();
>
> -        assert(ms->smp.sockets >= 1);
> +    assert(ms->smp.sockets >= 1);
>
> -        for (i = 0; i < ms->smp.sockets; i++) {
> -            smbios_build_type_4_table(ms, i);
> -        }
> +    for (i = 0; i < ms->smp.sockets; i++) {
> +        smbios_build_type_4_table(ms, i);
> +    }
>
> -        smbios_build_type_8_table();
> -        smbios_build_type_11_table();
> +    smbios_build_type_8_table();
> +    smbios_build_type_11_table();
>
>  #define MAX_DIMM_SZ (16 * GiB)
>  #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
>                                          : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
>
> -        dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
> +    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
> +               MAX_DIMM_SZ;
>
> -        /*
> -         * The offset determines if we need to keep additional space between
> -         * table 17 and table 19 header handle numbers so that they do
> -         * not overlap. For example, for a VM with larger than 8 TB guest
> -         * memory and DIMM like chunks of 16 GiB, the default space between
> -         * the two tables (T19_BASE - T17_BASE = 512) is not enough.
> -         */
> -        offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
> -                 dimm_cnt - (T19_BASE - T17_BASE) : 0;
> +    /*
> +     * The offset determines if we need to keep additional space between
> +     * table 17 and table 19 header handle numbers so that they do
> +     * not overlap. For example, for a VM with larger than 8 TB guest
> +     * memory and DIMM like chunks of 16 GiB, the default space between
> +     * the two tables (T19_BASE - T17_BASE = 512) is not enough.
> +     */
> +    offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
> +             dimm_cnt - (T19_BASE - T17_BASE) : 0;
>
> -        smbios_build_type_16_table(dimm_cnt);
> +    smbios_build_type_16_table(dimm_cnt);
>
> -        for (i = 0; i < dimm_cnt; i++) {
> -            smbios_build_type_17_table(i, GET_DIMM_SZ);
> -        }
> +    for (i = 0; i < dimm_cnt; i++) {
> +        smbios_build_type_17_table(i, GET_DIMM_SZ);
> +    }
>
> -        for (i = 0; i < mem_array_size; i++) {
> -            smbios_build_type_19_table(i, offset, mem_array[i].address,
> -                                       mem_array[i].length);
> -        }
> +    for (i = 0; i < mem_array_size; i++) {
> +        smbios_build_type_19_table(i, offset, mem_array[i].address,
> +                                   mem_array[i].length);
> +    }
>
> -        /*
> -         * make sure 16 bit handle numbers in the headers of tables 19
> -         * and 32 do not overlap.
> -         */
> -        assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
> +    /*
> +     * make sure 16 bit handle numbers in the headers of tables 19
> +     * and 32 do not overlap.
> +     */
> +    assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
>
> -        smbios_build_type_32_table();
> -        smbios_build_type_38_table();
> -        smbios_build_type_41_table(errp);
> -        smbios_build_type_127_table();
> +    smbios_build_type_32_table();
> +    smbios_build_type_38_table();
> +    smbios_build_type_41_table(errp);
> +    smbios_build_type_127_table();
>
> -        smbios_validate_table(ms->smp.sockets);
> -        smbios_entry_point_setup();
> -        smbios_immutable = true;
> -    }
> +    smbios_validate_table(ms->smp.sockets);
> +    smbios_entry_point_setup();
>
>      /* return tables blob and entry point (anchor), and their sizes */
>      *tables = smbios_tables;
> @@ -1254,13 +1281,10 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>  {
>      const char *val;
>
> -    assert(!smbios_immutable);
> -
>      val = qemu_opt_get(opts, "file");
>      if (val) {
>          struct smbios_structure_header *header;
> -        int size;
> -        struct smbios_table *table; /* legacy mode only */
> +        size_t size;
>
>          if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
>              return;
> @@ -1277,9 +1301,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>           * (except in legacy mode, where the second '\0' is implicit and
>           *  will be inserted by the BIOS).
>           */
> -        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
> -        header = (struct smbios_structure_header *)(smbios_tables +
> -                                                    smbios_tables_len);
> +        usr_blobs = g_realloc(usr_blobs, usr_blobs_len + size);
> +        header = (struct smbios_structure_header *)(usr_blobs +
> +                                                    usr_blobs_len);
>
>          if (load_image_size(val, (uint8_t *)header, size) != size) {
>              error_setg(errp, "Failed to load SMBIOS file %s", val);
> @@ -1300,34 +1324,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              smbios_type4_count++;
>          }
>
> -        smbios_tables_len += size;
> -        if (size > smbios_table_max) {
> -            smbios_table_max = size;
> +        if (!usr_blobs_sizes) {
> +            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
>          }
> -        smbios_table_cnt++;
> -
> -        /* add a copy of the newly loaded blob to legacy smbios_entries */
> -        /* NOTE: This code runs before smbios_set_defaults(), so we don't
> -         *       yet know which mode (legacy vs. aggregate-table) will be
> -         *       required. We therefore add the binary blob to both legacy
> -         *       (smbios_entries) and aggregate (smbios_tables) tables, and
> -         *       delete the one we don't need from smbios_set_defaults(),
> -         *       once we know which machine version has been requested.
> -         */
> -        if (!smbios_entries) {
> -            smbios_entries_len = sizeof(uint16_t);
> -            smbios_entries = g_malloc0(smbios_entries_len);
> +        g_array_append_val(usr_blobs_sizes, size);
> +        usr_blobs_len += size;
> +        if (size > usr_table_max) {
> +            usr_table_max = size;
>          }
> -        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
> -                                                   size + sizeof(*table));
> -        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
> -        table->header.type = SMBIOS_TABLE_ENTRY;
> -        table->header.length = cpu_to_le16(sizeof(*table) + size);
> -        memcpy(table->data, header, size);
> -        smbios_entries_len += sizeof(*table) + size;
> -        (*(uint16_t *)smbios_entries) =
> -                cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
> -        /* end: add a copy of the newly loaded blob to legacy smbios_entries */
> +        usr_table_cnt++;
>
>          return;
>      }
> --
> 2.39.3
>
>


