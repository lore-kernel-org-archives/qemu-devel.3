Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7C2C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh98i-000312-PE; Mon, 04 Mar 2024 09:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rh98X-00030I-UK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rh98V-0000fG-CJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709561866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnWM5avK/+I5CgQLU/E1yEhYlRe0g/wy2f0BVVXsg04=;
 b=NFGwjzNymZCTkJBkJVZ8FXPzaO6tZur1E83vjJVWKl4cVzOoyPfuQgc8tmOk2/2oovztza
 dTRO3LMaYNvn9pJO+QQ+Nj/jiASn9ZVmdznXzIpNb42s7YGnqv/Kdkj+PNuqeV/klyGEKL
 OYo27Bg+qBKpUDCp0xamhlnLIn8a06Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-5IkLdKtvNDmnOamFxwjp7Q-1; Mon, 04 Mar 2024 09:17:45 -0500
X-MC-Unique: 5IkLdKtvNDmnOamFxwjp7Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d8b4175dbso1874950f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709561864; x=1710166664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnWM5avK/+I5CgQLU/E1yEhYlRe0g/wy2f0BVVXsg04=;
 b=nyPnxGeU/iBOToOp8DvLRv98M37mWz4WyP+2tXmMb1IbCInlgjju8Vzg1bb9dMiD8f
 U65z2a3A42ixa9Vsh6eYcOKRKPNdFTp7QYNdACUoEIF979FiSgb8b2jGqjIlB+fEYbyj
 BOfJZQ24/9Z+eTITg1wR2G6kWmGa4rZAhwmZY0JjIQb/fggM4eMK4+CpgHdZQw0PG/Nl
 wQVr62mLoiQYaJl9FrT1A3fsFpmEc3rdxgSKBcjqJA69xIsr9oDdMteiGLUXXJtb6uaa
 4k5weOg7zM0/z8dINrw+m6gfrkBVZDSx4BFByGrsnDu2ykqLPrLh6bncYkxQ2wIeqHFu
 pjbQ==
X-Gm-Message-State: AOJu0YyaXt6B49Sd7vE0ehX7PrJcs6I4e+Hxv8cBwnqsO8neg52c9APm
 XNMK1NtYt7Ryl9tMDIKv22UhfmP+9srS76/2MDdck4rD+K0nPRIz21I6qVdi3rnJYkN+YwTXcNf
 8PC3ZfJe5qZ3ggGhl0AjTCtTkp6J1XAKvajci2JkwHRokTwjn95r1
X-Received: by 2002:a5d:4c8c:0:b0:33d:96c7:ae3d with SMTP id
 z12-20020a5d4c8c000000b0033d96c7ae3dmr7369551wrs.16.1709561863886; 
 Mon, 04 Mar 2024 06:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGavF+Iilpr8AhfEEF3b8QxJr92vWRfqGseTILau1rokIKVu2MUNZ/lgUt3orOZdCTLfSKE0Q==
X-Received: by 2002:a5d:4c8c:0:b0:33d:96c7:ae3d with SMTP id
 z12-20020a5d4c8c000000b0033d96c7ae3dmr7369514wrs.16.1709561863451; 
 Mon, 04 Mar 2024 06:17:43 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 bs3-20020a056000070300b0033d4c3b0beesm12603850wrb.19.2024.03.04.06.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:17:43 -0800 (PST)
Date: Mon, 4 Mar 2024 15:17:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com,
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 07/19] smbios: avoid mangling user provided tables
Message-ID: <20240304151741.68f95249@imammedo.users.ipa.redhat.com>
In-Reply-To: <bb38e2e8-d9dd-d552-469e-8d47196393c1@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-8-imammedo@redhat.com>
 <bb38e2e8-d9dd-d552-469e-8d47196393c1@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, 4 Mar 2024 15:25:11 +0530 (IST)
Ani Sinha <anisinha@redhat.com> wrote:

> On Tue, 27 Feb 2024, Igor Mammedov wrote:
> 
> > currently smbios_entry_add() preserves internally '-smbios type='
> > options but tables provided with '-smbios file=' are stored directly
> > into blob that eventually will be exposed to VM. And then later
> > QEMU adds default/'-smbios type' entries on top into the same blob.
> >
> > It makes impossible to generate tables more than once, hence
> > 'immutable' guard was used.
> > Make it possible to regenerate final blob by storing user provided
> > blobs into a dedicated area (usr_blobs) and then copy it when
> > composing final blob. Which also makes handling of -smbios
> > options consistent.
> >
> > As side effect of this and previous commits there is no need to
> > generate legacy smbios_entries at the time options are parsed.
> > Instead compose smbios_entries on demand from  usr_blobs like
> > it is done for non-legacy SMBIOS tables.
> >  
> 
> This patch is very dense and even after taking several iterations through
> it, I am not confident that I have not missed anything.

it's shortest variant, I've came up with and still keeping it
as an atomic change.
Potentially I can split off removal of smbios_immutable to reduce
context changes (shift to left  due to removal of 'if') but then
it wont's be a single step anymore and won't really help much.

> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/smbios/smbios.c | 179 +++++++++++++++++++++++----------------------
> >  1 file changed, 92 insertions(+), 87 deletions(-)
> >
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index c46fc93357..aa2cc5bdbd 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -57,6 +57,14 @@ static size_t smbios_entries_len;
> >  static bool smbios_uuid_encoded = true;
> >  /* end: legacy structures & constants for <= 2.0 machines */
> >
> > +/*
> > + * SMBIOS tables provided by user with '-smbios file=<foo>' option
> > + */
> > +uint8_t *usr_blobs;
> > +size_t usr_blobs_len;
> > +static GArray *usr_blobs_sizes;
> > +static unsigned usr_table_max;
> > +static unsigned usr_table_cnt;
> >
> >  uint8_t *smbios_tables;
> >  size_t smbios_tables_len;
> > @@ -67,7 +75,6 @@ static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
> >  static SmbiosEntryPoint ep;
> >
> >  static int smbios_type4_count = 0;
> > -static bool smbios_immutable;
> >  static bool smbios_have_defaults;
> >  static uint32_t smbios_cpuid_version, smbios_cpuid_features;
> >
> > @@ -569,9 +576,8 @@ static void smbios_build_type_1_fields(void)
> >
> >  uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
> >  {
> > -    /* drop unwanted version of command-line file blob(s) */
> > -    g_free(smbios_tables);
> > -    smbios_tables = NULL;
> > +    int i;
> > +    size_t usr_offset;
> >
> >      /* also complain if fields were given for types > 1 */
> >      if (find_next_bit(have_fields_bitmap,
> > @@ -581,12 +587,33 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
> >          exit(1);
> >      }
> >
> > -    if (!smbios_immutable) {
> > -        smbios_build_type_0_fields();
> > -        smbios_build_type_1_fields();
> > -        smbios_validate_table(expected_t4_count);
> > -        smbios_immutable = true;
> > +    g_free(smbios_entries);
> > +    smbios_entries_len = sizeof(uint16_t);
> > +    smbios_entries = g_malloc0(smbios_entries_len);
> > +
> > +    for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
> > +         i++)
> > +    {
> > +        struct smbios_table *table;
> > +        struct smbios_structure_header *header;
> > +        size_t size = g_array_index(usr_blobs_sizes, size_t, i);
> > +
> > +        header = (struct smbios_structure_header *)(usr_blobs + usr_offset);
> > +        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
> > +                                                   size + sizeof(*table));
> > +        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
> > +        table->header.type = SMBIOS_TABLE_ENTRY;
> > +        table->header.length = cpu_to_le16(sizeof(*table) + size);
> > +        memcpy(table->data, header, size);
> > +        smbios_entries_len += sizeof(*table) + size;
> > +        (*(uint16_t *)smbios_entries) =
> > +            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
> > +        usr_offset += size;

[...]
> 
> Why can't we do a memdup even for the legacy case instead of memcpy?
because legacy entries have different structure,
see above or corresponding code that removes original handling at comment
 " add a copy of the newly loaded blob to legacy smbios_entries"


> Secondly, here and other places we should check for NULL returns.
> https://docs.gtk.org/glib/func.memdup2.html
> return from memdup2 can be null.

all SMBIOS code is pestered with unchecked allocations,
so I followed the same style for consistency.

A patch on top can address that in consistent manner
cleaning up all places. Doing cleanup is out of scope
of this series (it's already too big as it is).

In this case I can add assert() on respin if you insist.

> 
> 
> > +    smbios_tables_len = usr_blobs_len;
> > +    smbios_table_max = usr_table_max;
> > +    smbios_table_cnt = usr_table_cnt;
> >
> > -    if (!smbios_immutable) {
> > -        smbios_build_type_0_table();
> > -        smbios_build_type_1_table();
> > -        smbios_build_type_2_table();
> > -        smbios_build_type_3_table();
> > +    smbios_build_type_0_table();
> > +    smbios_build_type_1_table();
> > +    smbios_build_type_2_table();
> > +    smbios_build_type_3_table();
> >
> > -        assert(ms->smp.sockets >= 1);
> > +    assert(ms->smp.sockets >= 1);
> >
> > -        for (i = 0; i < ms->smp.sockets; i++) {
> > -            smbios_build_type_4_table(ms, i);
> > -        }
> > +    for (i = 0; i < ms->smp.sockets; i++) {
> > +        smbios_build_type_4_table(ms, i);
> > +    }
> >
> > -        smbios_build_type_8_table();
> > -        smbios_build_type_11_table();
> > +    smbios_build_type_8_table();
> > +    smbios_build_type_11_table();
> >
> >  #define MAX_DIMM_SZ (16 * GiB)
> >  #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
> >                                          : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
> >
> > -        dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
> > +    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
> > +               MAX_DIMM_SZ;
> >
> > -        /*
> > -         * The offset determines if we need to keep additional space between
> > -         * table 17 and table 19 header handle numbers so that they do
> > -         * not overlap. For example, for a VM with larger than 8 TB guest
> > -         * memory and DIMM like chunks of 16 GiB, the default space between
> > -         * the two tables (T19_BASE - T17_BASE = 512) is not enough.
> > -         */
> > -        offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
> > -                 dimm_cnt - (T19_BASE - T17_BASE) : 0;
> > +    /*
> > +     * The offset determines if we need to keep additional space between
> > +     * table 17 and table 19 header handle numbers so that they do
> > +     * not overlap. For example, for a VM with larger than 8 TB guest
> > +     * memory and DIMM like chunks of 16 GiB, the default space between
> > +     * the two tables (T19_BASE - T17_BASE = 512) is not enough.
> > +     */
> > +    offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
> > +             dimm_cnt - (T19_BASE - T17_BASE) : 0;
> >
> > -        smbios_build_type_16_table(dimm_cnt);
> > +    smbios_build_type_16_table(dimm_cnt);
> >
> > -        for (i = 0; i < dimm_cnt; i++) {
> > -            smbios_build_type_17_table(i, GET_DIMM_SZ);
> > -        }
> > +    for (i = 0; i < dimm_cnt; i++) {
> > +        smbios_build_type_17_table(i, GET_DIMM_SZ);
> > +    }
> >
> > -        for (i = 0; i < mem_array_size; i++) {
> > -            smbios_build_type_19_table(i, offset, mem_array[i].address,
> > -                                       mem_array[i].length);
> > -        }
> > +    for (i = 0; i < mem_array_size; i++) {
> > +        smbios_build_type_19_table(i, offset, mem_array[i].address,
> > +                                   mem_array[i].length);
> > +    }
> >
> > -        /*
> > -         * make sure 16 bit handle numbers in the headers of tables 19
> > -         * and 32 do not overlap.
> > -         */
> > -        assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
> > +    /*
> > +     * make sure 16 bit handle numbers in the headers of tables 19
> > +     * and 32 do not overlap.
> > +     */
> > +    assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
> >
> > -        smbios_build_type_32_table();
> > -        smbios_build_type_38_table();
> > -        smbios_build_type_41_table(errp);
> > -        smbios_build_type_127_table();
> > +    smbios_build_type_32_table();
> > +    smbios_build_type_38_table();
> > +    smbios_build_type_41_table(errp);
> > +    smbios_build_type_127_table();
> >
> > -        smbios_validate_table(ms->smp.sockets);
> > -        smbios_entry_point_setup();
> > -        smbios_immutable = true;
> > -    }
> > +    smbios_validate_table(ms->smp.sockets);
> > +    smbios_entry_point_setup();
> >
> >      /* return tables blob and entry point (anchor), and their sizes */
> >      *tables = smbios_tables;
> > @@ -1254,13 +1281,10 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
> >  {
> >      const char *val;
> >
> > -    assert(!smbios_immutable);
> > -
> >      val = qemu_opt_get(opts, "file");
> >      if (val) {
> >          struct smbios_structure_header *header;
> > -        int size;
> > -        struct smbios_table *table; /* legacy mode only */
> > +        size_t size;
> >
> >          if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
> >              return;
> > @@ -1277,9 +1301,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
> >           * (except in legacy mode, where the second '\0' is implicit and
> >           *  will be inserted by the BIOS).
> >           */
> > -        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
> > -        header = (struct smbios_structure_header *)(smbios_tables +
> > -                                                    smbios_tables_len);
> > +        usr_blobs = g_realloc(usr_blobs, usr_blobs_len + size);
> > +        header = (struct smbios_structure_header *)(usr_blobs +
> > +                                                    usr_blobs_len);
> >
> >          if (load_image_size(val, (uint8_t *)header, size) != size) {
> >              error_setg(errp, "Failed to load SMBIOS file %s", val);
> > @@ -1300,34 +1324,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
> >              smbios_type4_count++;
> >          }
> >
> > -        smbios_tables_len += size;
> > -        if (size > smbios_table_max) {
> > -            smbios_table_max = size;
> > +        if (!usr_blobs_sizes) {
> > +            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
> >          }
> > -        smbios_table_cnt++;
> > -
> > -        /* add a copy of the newly loaded blob to legacy smbios_entries */
> > -        /* NOTE: This code runs before smbios_set_defaults(), so we don't
> > -         *       yet know which mode (legacy vs. aggregate-table) will be
> > -         *       required. We therefore add the binary blob to both legacy
> > -         *       (smbios_entries) and aggregate (smbios_tables) tables, and
> > -         *       delete the one we don't need from smbios_set_defaults(),
> > -         *       once we know which machine version has been requested.
> > -         */
> > -        if (!smbios_entries) {
> > -            smbios_entries_len = sizeof(uint16_t);
> > -            smbios_entries = g_malloc0(smbios_entries_len);
> > +        g_array_append_val(usr_blobs_sizes, size);
> > +        usr_blobs_len += size;
> > +        if (size > usr_table_max) {
> > +            usr_table_max = size;
> >          }
> > -        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
> > -                                                   size + sizeof(*table));
> > -        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
> > -        table->header.type = SMBIOS_TABLE_ENTRY;
> > -        table->header.length = cpu_to_le16(sizeof(*table) + size);
> > -        memcpy(table->data, header, size);
> > -        smbios_entries_len += sizeof(*table) + size;
> > -        (*(uint16_t *)smbios_entries) =
> > -                cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
> > -        /* end: add a copy of the newly loaded blob to legacy smbios_entries */
> > +        usr_table_cnt++;
> >
> >          return;
> >      }
> > --
> > 2.39.3
> >
> >  
> 


