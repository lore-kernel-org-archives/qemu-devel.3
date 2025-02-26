Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C359EC18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJeg-0007s6-Qa; Wed, 26 Feb 2025 10:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJee-0007rV-D3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJec-0003bd-E6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740584936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiNEq2r2jsaEr8moOLNR8H3qcNO6mJXfZrazVGEeCMY=;
 b=IqJf4RUB4AUnBz12+YkBnopQ8jGo/bAIi+X2rDSEXnUAwGsgFPaUwcWB0B2GB5oJee02Zv
 TooUEFBdu0Wvh4FnJos/XL+RMzJEMyKDYH0Sgt3BqaFxmtGAgAw8CEqU9vGCT1s+GZymkj
 Vt24AxUg2+vJ9h2LfTFci9al3FeKtn4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-b_5qeMtTMvqyVKkOQkT2Ow-1; Wed, 26 Feb 2025 10:48:55 -0500
X-MC-Unique: b_5qeMtTMvqyVKkOQkT2Ow-1
X-Mimecast-MFC-AGG-ID: b_5qeMtTMvqyVKkOQkT2Ow_1740584934
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4e47d0b2so3150829f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584934; x=1741189734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TiNEq2r2jsaEr8moOLNR8H3qcNO6mJXfZrazVGEeCMY=;
 b=pbnbSZyvC21fH0qODgCHAIv/AEqMXYxyZgRQa+nsVCwgGbP+oAkf+Ub129sTEhNXkG
 uyLef0dK5AMxHVFNdTMajwPFpbRTwolSZKIM4fINfq3RHb1mSYKO+r7XKlmbCKwVCT69
 0QJ0GhjMK2OmFOMz3tvKRww/9BfsI08LTgvmqXFO9JQTIo7dMtUq+63eOS6D6b4KbGi+
 H0guD6eTRM6pGszIkN3kNWg1iODAo0MwFxtQQxFBmSoNld75k9lyb68tYVHcB8om5i41
 h/8cHrikB7bHMXQifB2T5/1bTr8RSaPxUpMrviFiiXg9aY1s3EUdGupFVGJUD/f6jsod
 KK+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpZ/QKqQEHGhmtE6scEmpfzq1RcWD2ZkYvp0dvIFlU0qlzH4MNijYdRPl+7rtjad6g/18/hZsnCVWC@nongnu.org
X-Gm-Message-State: AOJu0YzrIafRSb+LJrUvqv9fbfkjmBsfjdM+2pFs6jEQdexRi53nWggg
 BDpB/M41rfmABUOn/l2LCSp0wTlgF2cpRZYnonOEFTdaVChmTCeRTZk85JPQnVAWcMkAm7UYUir
 UGuIey566WT6Q6g/3NIERV27G/cFHW95dCPFHqSKoohybPr90Jm/7
X-Gm-Gg: ASbGncv9cw8jwaErmeASyRfjsgcjBVbhejji9xetH4fVnSSCQojrN4RmUA4oyH9jrLF
 LMq2IlaTjPRh3le9VgtVS9SfTuavqnRoPcoJjOtPLFSRpa2WKshx4VWahxeHbqJk5Gv3Yen/Vm1
 7ShMIh2kAzjQTjbEOuXK2uAPvgXbMZLdlWtvTONjU+TsfIEK8voWkj2vPPkqIPM/OOX4qXEMqaC
 KsI4JNfV4dCT8D0KjeGy3eBxOZ9iIPeE97YQT1+/tVKpB7NxwdwEjcZ8GnWnck7pd8DGzGeLPqq
 wZeUPgQJjU1c4I0GIH3FWt/wNbhAgCH4xDrNM01Y9bD0gdjV/pfXL+z5ZoNMdDU=
X-Received: by 2002:a05:6000:184e:b0:38f:3735:68e with SMTP id
 ffacd0b85a97d-390d4f9bce6mr3304466f8f.46.1740584933965; 
 Wed, 26 Feb 2025 07:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp18JhmWYwbrKX7q30/PycgnHThNyfXu8nXVhQu2qMes1vLvDUMqkQamIhfAumFKn8SRJ2fw==
X-Received: by 2002:a05:6000:184e:b0:38f:3735:68e with SMTP id
 ffacd0b85a97d-390d4f9bce6mr3304434f8f.46.1740584933542; 
 Wed, 26 Feb 2025 07:48:53 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86ca9csm6009486f8f.22.2025.02.26.07.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:48:52 -0800 (PST)
Date: Wed, 26 Feb 2025 16:48:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/14] acpi/ghes: don't hard-code the number of
 sources for HEST table
Message-ID: <20250226164851.316aa095@imammedo.users.ipa.redhat.com>
In-Reply-To: <13755cc3680bfee1435fee2e366b621d2a940a1a.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <13755cc3680bfee1435fee2e366b621d2a940a1a.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 15:35:13 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current code is actually dependent on having just one error
> structure with a single source, as any change there would cause
> migration issues.
> 
> As the number of sources should be arch-dependent, as it will depend on
> what kind of notifications will exist, and how many errors can be
> reported at the same time, change the logic to be more flexible,
> allowing the number of sources to be defined when building the
> HEST table by the caller.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c           | 38 +++++++++++++++++++++-----------------
>  hw/arm/virt-acpi-build.c |  8 +++++++-
>  include/hw/acpi/ghes.h   | 17 ++++++++++++-----
>  3 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 7efea519f766..4a4ea8f4be90 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -238,17 +238,17 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
>  static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
> -                                   BIOSLinker *linker)
> +                                   BIOSLinker *linker, int num_sources)
>  {
>      int i, error_status_block_offset;
>  
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
> @@ -263,13 +263,13 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
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
> @@ -295,12 +295,14 @@ static void build_ghes_error_table(AcpiGhesState *ags, GArray *hardware_errors,
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
> @@ -331,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   source_id * sizeof(uint64_t));
> +                                   index * sizeof(uint64_t));
>  
>      /* Notification Structure */
>      build_ghes_hw_error_notification(table_data, notify);
> @@ -351,8 +353,7 @@ static void build_ghes_v2(GArray *table_data,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
>                                     ACPI_HW_ERROR_FW_CFG_FILE,
> -                                   (ACPI_GHES_ERROR_SOURCE_COUNT + source_id)
> -                                   * sizeof(uint64_t));
> +                                   (num_sources + index) * sizeof(uint64_t));
>  
>      /*
>       * Read Ack Preserve field
> @@ -368,22 +369,26 @@ static void build_ghes_v2(GArray *table_data,
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId *notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>      uint32_t hest_offset;
> +    int i;
>  
>      hest_offset = table_data->len;
>  
> -    build_ghes_error_table(ags, hardware_errors, linker);
> +    build_ghes_error_table(ags, hardware_errors, linker, num_sources);
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
>  
> @@ -529,7 +534,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
I'd also remove one blank line here


>  
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 8ab8d11b6536..4439252e1a75 100644
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
> @@ -956,7 +960,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>              acpi_add_table(table_offsets, tables_blob);
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, vms->oem_id, vms->oem_table_id);
> +                            tables->linker, hest_ghes_notify,
> +                            ARRAY_SIZE(hest_ghes_notify),
> +                            vms->oem_id, vms->oem_table_id);
>          }
>      }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 2f06e433ce04..51c6b6b33327 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -57,13 +57,18 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> -enum {
> -    ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> -
> -    ACPI_GHES_ERROR_SOURCE_COUNT
> +/*
> + * ID numbers used to fill HEST source ID field
> + */
> +enum AcpiGhesSourceID {
> +    ACPI_HEST_SRC_ID_SYNC,
>  };
>  
> +typedef struct AcpiNotificationSourceId {
> +    enum AcpiGhesSourceID source_id;
> +    enum AcpiGhesNotifyType notify;
> +} AcpiNotificationSourceId;
> +
>  /*
>   * AcpiGhesState stores an offset that will be used to fill HEST entries.
>   *
> @@ -86,6 +91,8 @@ typedef struct AcpiGhesState {
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       GArray *hardware_errors,
>                       BIOSLinker *linker,
> +                     const AcpiNotificationSourceId * const notif_source,
> +                     int num_sources,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);


