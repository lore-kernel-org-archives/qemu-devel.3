Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1B7C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLDk-0004OI-0v; Tue, 06 Aug 2024 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbLDf-0004MK-E5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbLDc-0006kq-Kg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722954679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvF8Xylsgtl9CdwpW85ezra0SLl7EikGkhlaTaeGrqo=;
 b=VPdJSqJh/Cz9V2KGLroAddG6QCIL46W4pEfYKJyz3rfaLt/w9+nB7tMmMrRsZ4W/NZrPmy
 awoohSU+9QSUKf/GskBf/02T2vp0HHxGRvGaevncM6DamW1vcNgjlXOF1FBUUaGALTEWL4
 +uG3vBYAC5ST6M1aWBbUXKSkqeH8RHQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-LwyEnGVKMKiZD2egNWD8-Q-1; Tue, 06 Aug 2024 10:31:16 -0400
X-MC-Unique: LwyEnGVKMKiZD2egNWD8-Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280c0b3017so5189255e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722954675; x=1723559475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvF8Xylsgtl9CdwpW85ezra0SLl7EikGkhlaTaeGrqo=;
 b=JGc4ur+Bd9+aaytSHXMTlKUsMVqovWblXgIjBVAPEjkQMw6tAMbP8bLY91ompfRYdI
 AMvSYA1nx+XE5KvKyGhXF1iSPkM9PPyIU/Dtx5rvovWBzoJzVJ6KUQ7OPGcZ8Ii/2JuH
 p7uqRdcKmiKYwkirEP+QNlZ1aKkUSelsCWJobwOGRlEJFmxLjZ0hbEM2WaWJSnaTovY4
 8nbInJr59AJtVikYAlQb9LNKENwPNfDcFxQ2jz3kbqwfI1w0+v9/Ia6lBcD9sKNYKZ+w
 AqEVAtK/6xL5flDm0C9NhTqvrROZ+Z1QLJMtHkpp9pSDm945uynZ2Qon+mF/TzWpNP3t
 2+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9kkr29miRUzNaB/m1cKvoQ+2uvIA/kUNSy1DwYxM3sqD+uhCiUyT2IakaJ7OM7AAZRi37F6vt8MVRfYq/0HgQE+seN0=
X-Gm-Message-State: AOJu0Yw97T43wybmGdMSNRH661e7SUrfkFJNmRnfEOi8TvoRDCY/ZPs9
 k8pYpWsxfYyQUhlym/ntwLGR6Wz325eqB1z6I4H2MJb3YT/q06w8FEK0AZD5zvtQr5bUYPUOsiV
 n5bUbdjoslL6IJ0GS0dr/j6QTJ6CDDqmFroKFjz5onU/KIs2UNr4w
X-Received: by 2002:a05:600c:580a:b0:428:f1b4:3473 with SMTP id
 5b1f17b1804b1-428f1b4398bmr71197215e9.26.1722954674992; 
 Tue, 06 Aug 2024 07:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6CXrSXKowS/TTkQO0vuI6Ltcbfrl8sA8YRQn6TA2/2Si4QscTPGDCiUgWPfAr3SBEngAprA==
X-Received: by 2002:a05:600c:580a:b0:428:f1b4:3473 with SMTP id
 5b1f17b1804b1-428f1b4398bmr71196805e9.26.1722954674364; 
 Tue, 06 Aug 2024 07:31:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm161469075e9.17.2024.08.06.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:31:13 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:31:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri,  2 Aug 2024 23:44:01 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Provide a generic interface for error injection via GHESv2.
> 
> This patch is co-authored:
>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
>  hw/acpi/ghes_cper.c    |   2 +-
>  include/hw/acpi/ghes.h |   3 +
>  3 files changed, 152 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a745dcc7be5e..e125c9475773 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static uint64_t ghes_get_state_start_address(void)

ghes_get_hardware_errors_address() might better reflect what address it will return

> +{
> +    AcpiGedState *acpi_ged_state =
> +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> +
> +    return le64_to_cpu(ags->ghes_addr_le);
> +}
> +
>  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> +    uint64_t start_addr = ghes_get_state_start_address();
>      bool ret = -1;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags;
> -
>      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    g_assert(acpi_ged_state);
> -    ags = &acpi_ged_state->ghes_state;
> -
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> -
>      if (physical_address) {
>          start_addr += source_id * sizeof(uint64_t);

above should be a separate patch

>  
> @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      return ret;
>  }
>  
> +/*
> + * Error register block data layout
> + *
> + * | +---------------------+ ges.ghes_addr_le
> + * | |error_block_address0 |
> + * | +---------------------+
> + * | |error_block_address1 |
> + * | +---------------------+ --+--
> + * | |    .............    | GHES_ADDRESS_SIZE
> + * | +---------------------+ --+--
> + * | |error_block_addressN |
> + * | +---------------------+
> + * | | read_ack0           |
> + * | +---------------------+ --+--
> + * | | read_ack1           | GHES_ADDRESS_SIZE
> + * | +---------------------+ --+--
> + * | |   .............     |
> + * | +---------------------+
> + * | | read_ackN           |
> + * | +---------------------+ --+--
> + * | |      CPER           |   |
> + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> + * | |      CPER           |   |
> + * | +---------------------+ --+--
> + * | |    ..........       |
> + * | +---------------------+
> + * | |      CPER           |
> + * | |      ....           |
> + * | |      CPER           |
> + * | +---------------------+
> + */

no need to duplicate docs/specs/acpi_hest_ghes.rst,
I'd just reffer to it and maybe add short comment as to why it's mentioned.

> +/* Map from uint32_t notify to entry offset in GHES */
> +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> +                                                 0xff, 0xff, 0xff, 1, 0};
> +
> +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> +                          uint64_t *read_ack_addr)
> +{
> +    uint64_t base;
> +
> +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> +        return false;
> +    }
> +
> +    /* Find and check the source id for this new CPER */
> +    if (error_source_to_index[notify] == 0xff) {
> +        return false;
> +    }
> +
> +    base = ghes_get_state_start_address();
> +
> +    *read_ack_addr = base +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        error_source_to_index[notify] * sizeof(uint64_t);
> +
> +    /* Could also be read back from the error_block_address register */
> +    *error_block_addr = base +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> +
> +    return true;
> +}

I don't like all this pointer math, which is basically a reverse engineered
QEMU actions on startup + guest provided etc/hardware_errors address.

For once, it assumes error_source_to_index[] matches order in which HEST
error sources were described, which is fragile.

2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
in RAM migrated from older version might not match above assumptions
of target QEMU. 

I see 2 ways to rectify it:
  1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
       in guest RAM, like we do with etc/hardware_errors, see
            build_ghes_error_table()
               ...
               tell firmware to write hardware_errors GPA into
       and then fetch from HEST table in RAM, the guest patched error/ack addresses
       for given source_id

       code-wise: relatively simple once one wraps their own head over
                 how this whole APEI thing works in QEMU
                 workflow  is described in docs/specs/acpi_hest_ghes.rst
                 look to me as sufficient to grasp it.
                 (but my view is very biased given my prior knowledge,
                  aka: docs/comments/examples wrt acpi patching are good enough)
                 (if it's not clear how to do it, ask me for pointers)

  2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
        patching instructions
               bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
                   address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
                   ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^
        during build_ghes_v2() also store on a side mapping
             source_id -> error address offset : read ack address

        so when you are injecting error, you'd at least use offsets
        used at start time, to get rid of risk where injection code
        diverge from HEST:etc/hardware_errors layout at start time.

        However to make migration safe, one would need to add a fat
        comment not to change order ghest error sources in HEST _and_
        a dedicated unit test to make sure we catch it when that happens.
        bios_tables_test should be able to catch the change, but it won't
        say what's wrong, hence a test case that explicitly checks order
        and loudly & clear complains when we will break order assumptions.

        downside:
           * we are are limiting ways HEST could be composed/reshuffled in future
           * consumption of extra CI resources
           * and well, it relies on above duct tape holding all pieces together

>  NotifierList generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> +void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
> +                             uint32_t notify)
> +{
> +    int read_ack = 0;
       ^^^
[...]
> +    cpu_physical_memory_read(read_ack_addr,
> +                             &read_ack, sizeof(uint64_t));
                                                  ^^^^
it looks like possible stack corruption, isn't it?

> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack) {
> +        error_setg(errp,
> +                   "Last CPER record was not acknowledged yet");
> +        read_ack = 1;
> +        cpu_physical_memory_write(read_ack_addr,
> +                                  &read_ack, sizeof(uint64_t));
                                                        ^^^^^
and then who knows what we are writing back here

> +        return;
> +    }
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_addr,
> +                              &read_ack, sizeof(uint64_t));
> +
> +    /* Build CPER record */
> +
> +    /*
> +     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
> +
> +    /*
> +        * It should not run out of the preallocated memory if
> +        * adding a new generic error data entry
> +        */
> +    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> +            ACPI_GHES_MAX_RAW_DATA_LENGTH);
it's better to error out gracefully here instead of crash
in case script generated too long record,
not the end of the world, but it's annoying to restart guest
on external mistake.

PS:
looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
and it is the total size of a error block for a error source.

However acpi_hest_ghes.rst (3) says it should be 4K,
am I mistaken? 


> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +                                    0, 0, data_length,
> +                                    ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, cper->guid,
> +                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +                                cper->data_len, fru_id, 0);
> +

not that I mind, but I'd ax above calls with their hardcoded
assumptions and make script generate whole error block,
it's more flexible wrt ACPI_CPER_SEV_RECOVERABLE/ACPI_GEBS_UNCORRECTABLE
and then one can ditch from QAPI interface cper->guid.

basically inject whatever user provided via QAPI without any other assumptions.

> +    /* Add CPER data */
> +    for (i = 0; i < cper->data_len; i++) {
> +        build_append_int_noprefix(block, cper->data[i], 1);
> +    }
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, block->data, block->len);
> +
> +    g_array_free(block, true);
> +
> +    notifier_list_notify(&generic_error_notifiers, NULL);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> index 7aa7e71e90dc..d7ff7debee74 100644
> --- a/hw/acpi/ghes_cper.c
> +++ b/hw/acpi/ghes_cper.c
> @@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
>          return;
>      }
>  
> -    /* TODO: call a function at ghes */
> +    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
>  
>      g_free(cper.data);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 06a5b8820cd5..ee6f6cd96911 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -85,6 +85,9 @@ typedef struct AcpiGhesCper {
>      size_t data_len;
>  } AcpiGhesCper;
>  
> +void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
> +                             uint32_t notify);

maybe rename it to acpi_ghes_inject_error_block()

> +
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *


