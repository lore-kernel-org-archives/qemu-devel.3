Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB74FC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td7vM-0000gk-Qi; Wed, 29 Jan 2025 08:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td7vK-0000g1-84
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td7vI-0002y5-5k
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738156563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXI2+Zoyfv46KfKjj+36x3banSuEK0iJ46ZIMkLItVc=;
 b=Z9aHDqYEeuespOO9r+kMmukVlH1khOtlMlFk71ykxuGSdUxwrhew68IbEStOvoD4bp/UsT
 bvyfaOgIqC+LO6U/LEG+fKNbviYeaISGWmWUkGubAMKLxY1EimCJDhH5trWzqi/QEIZpND
 lQfGqhNC3MVJCTuovAs8ZKtNfvhOinw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-GoYZYskfMB2jnZah5PqSyg-1; Wed, 29 Jan 2025 08:16:01 -0500
X-MC-Unique: GoYZYskfMB2jnZah5PqSyg-1
X-Mimecast-MFC-AGG-ID: GoYZYskfMB2jnZah5PqSyg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so2927871f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 05:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738156560; x=1738761360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXI2+Zoyfv46KfKjj+36x3banSuEK0iJ46ZIMkLItVc=;
 b=ORA/B/8GJ5PUn6up5ll5lXwhs8GBi62K6k06GAGwyfgoHjRmfxWhV6v0Uf138MGq+j
 tf2sqWeSmKzaCofeBzR8ZTU67pD1XJhlqrzjsLU7X7KHxppV+Po9xsvkD5dezr+e4WnP
 em7jWDnlhnmfuFdZ8OApWJOvlohnKcucr6jw8JsaLL8v4n7jvtiN4EVwur1QvlUfJv8U
 d9bASBD1D+Jt+G+LFGKl0ixHF6cwpNtwAkt/Tg/Z9cFe8cNeXaa7Hu0hUEXfQAbMMpbN
 o4DJ22/vPmGYKqEvFuTqitIwByTM5eVYpTbvTCR9I+88sILw21lGERZ/EwuqDeu8OSqL
 5i9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXlZ9gsTjbVN26sOyREBcfebJHxf1vM4eMyD8FYz8j+eEdE9bXFpDDVPomAQqGt4oae+5BkKRAp18h@nongnu.org
X-Gm-Message-State: AOJu0Yx6zI3yRKEQNl+U1Pr4zFfB2BKGZCBzw/LoM58Hq1nPX0CeZ1fY
 YooyKfT5p8Ip5dwNf6hwAeArFLDjbuebqNOLTdkpyKuMx4Ix0tmcwn+KASPdyFFgR68r+5SboRf
 IOR9o8Ow8tq4ISu1GqoIGiZLG3ydi5J4ix+k4sDHLbS1BKeDh33Yd
X-Gm-Gg: ASbGncv6lXHpvPWI+b5dwil3vQs5yGcNbL8/kYQN/wT5pKg7NmGzVpgkEzUSHjR1Kwv
 LXKUtIHWdG8A+5mTcrq8VbgMhnAwzQKHJKnPQ4OGh1ecHiTfL5kJ8zC1xedAo8nFSGRCamOLR6r
 0gtPK17O2EmNqHSSj5r7M9rq+ECVS8bO3klxbM3GSmI/k71OjSB022FQMC1NFaIXGfJWgdCUmw0
 O2984MHBS9Xr/7PgL6loZjfASBZ4dqk5B2kOQ2SNLknIsMYt4mQ/AI85xSiUyPG/8ugjZJd8AQL
 e1BJJFSmmI3XhILBbjJWqXRByJ5V+UDWeyG9DWfv1pvcnGstFzHb
X-Received: by 2002:a05:6000:1acc:b0:38a:418e:bee with SMTP id
 ffacd0b85a97d-38c51e919b6mr2593620f8f.42.1738156560421; 
 Wed, 29 Jan 2025 05:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjep8C702wv5zeS8ssz861WrD9Pnf2LfuzIGhETLZ8wb4GvlBzfnh56Iw5IyCmRtRiD3DJ4A==
X-Received: by 2002:a05:6000:1acc:b0:38a:418e:bee with SMTP id
 ffacd0b85a97d-38c51e919b6mr2593580f8f.42.1738156559938; 
 Wed, 29 Jan 2025 05:15:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188a61sm17261298f8f.52.2025.01.29.05.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 05:15:59 -0800 (PST)
Date: Wed, 29 Jan 2025 14:15:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] acpi/ghes: Prepare to support multiple sources
 on ghes
Message-ID: <20250129141558.1e3c8e0c@imammedo.users.ipa.redhat.com>
In-Reply-To: <b1ae283c63e66c128387ffcad37fc91744f56981.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <b1ae283c63e66c128387ffcad37fc91744f56981.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Jan 2025 09:04:07 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current code is actually dependent on having just one error
> structure with a single source.
> 
> As the number of sources should be arch-dependent, as it will depend on
> what kind of notifications will exist, change the logic to dynamically
> build the table.
> 
> Yet, for a proper support, we need to get the number of sources by
> reading the number from the HEST table. However, bios currently doesn't
> store a pointer to it.
> 
> For now just change the logic at table build time, while enforcing that
> it will behave like before with a single source ID.
> 
> A future patch will add a HEST table bios pointer and change the logic
> at acpi_ghes_record_errors() to dynamically use the new size.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c           | 47 +++++++++++++++++++++++++---------------
>  hw/arm/virt-acpi-build.c |  5 +++++
>  include/hw/acpi/ghes.h   | 21 ++++++++++++------
>  3 files changed, 49 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b709c177cdea..4cabb177ad47 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -206,17 +206,26 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
> +                                   int num_sources)
>  {
>      int i, error_status_block_offset;
>  
> +    /*
> +     * TODO: Current version supports only one source.
> +     * A further patch will drop this check, after adding a proper migration
> +     * code, as, for the code to work, we need to store a bios pointer to the
> +     * HEST table.
> +     */
> +    assert(num_sources == 1);
> +
>      /* Build error_block_address */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
>      }
>  
>      /* Build read_ack_register */
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Initialize the value of read_ack_register to 1, so GHES can be
>           * writable after (re)boot.
> @@ -231,13 +240,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  
>      /* Reserve space for Error Status Data Block */
>      acpi_data_push(hardware_errors,
> -        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
> +        ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
>      bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
> -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> +    for (i = 0; i < num_sources; i++) {
>          /*
>           * Tell firmware to patch error_block_address entries to point to
>           * corresponding "Generic Error Status Block"
> @@ -261,12 +270,14 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data,
> -                          BIOSLinker *linker,
> -                          enum AcpiGhesNotifyType notify,
> -                          uint16_t source_id)
> +static void build_ghes_v2_entry(GArray *table_data,
> +                                BIOSLinker *linker,
> +                                const AcpiNotificationSourceId *notif_src,
> +                                uint16_t index, int num_sources)
>  {
>      uint64_t address_offset;
> +    const uint16_t notify = notif_src->notify;
> +    const uint16_t source_id = notif_src->source_id;
>  
>      /*
>       * Type:
> @@ -297,7 +308,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   source_id * sizeof(uint64_t));
> +                                   index * sizeof(uint64_t));
>  
>      /* Notification Structure */
>      build_ghes_hw_error_notification(table_data, notify);
> @@ -317,8 +328,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
> -                                   * sizeof(uint64_t));
> +                                   (num_sources + index) * sizeof(uint64_t));
>  
>      /*
>       * Read Ack Preserve field
> @@ -333,19 +343,23 @@ static void build_ghes_v2(GArray *table_data,
>  /* Build Hardware Error Source Table */
>  void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId *notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    int i;
>  
> -    build_ghes_error_table(hardware_errors, linker);
> +    build_ghes_error_table(hardware_errors, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
>  
>      /* Error Source Count */
> -    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, linker,
> -                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
> +    build_append_int_noprefix(table_data, num_sources, 4);
> +    for (i = 0; i < num_sources; i++) {
> +        build_ghes_v2_entry(table_data, linker, &notif_source[i], i, num_sources);
> +    }
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -410,7 +424,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
>      get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                           &cper_addr, &read_ack_register_addr);
>  
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e17861..3d411787fc37 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static void acpi_align_size(GArray *blob, unsigned align)
>      g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
>  }
>  
> +static const AcpiNotificationSourceId hest_ghes_notify[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -948,6 +952,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      if (vms->ras) {
>          acpi_add_table(table_offsets, tables_blob);
>          acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> +                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
>                          vms->oem_id, vms->oem_table_id);
>      }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 39619a2457cb..9f0120d0d596 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -57,20 +57,27 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> -enum {
> -    ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> -
> -    ACPI_GHES_ERROR_SOURCE_COUNT
> -};
> -
>  typedef struct AcpiGhesState {
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;
>  
> +/*
> + * ID numbers used to fill HEST source ID field
> + */
> +enum AcpiGhesSourceID {
> +    ACPI_HEST_SRC_ID_SYNC,
> +};
> +
> +typedef struct AcpiNotificationSourceId {
> +    enum AcpiGhesSourceID source_id;
> +    enum AcpiGhesNotifyType notify;
> +} AcpiNotificationSourceId;
> +
>  void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId * const notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);


