Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DCC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 15:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9ul-0003jG-23; Wed, 29 Jan 2025 10:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9uj-0003im-AJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:23:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9uh-0006XQ-Sc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738164214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oA3yWs7c8bDIgIX82kAPNrS7GmCTA2Npsse3oH3dhbs=;
 b=BhvKH+KX4sCZaacJq+Ln4OOVqKUWie0Z83PjLzEKYhLhEg6mTmkbzDEyrrIo7EWVR0My24
 eTlK8+6K0i2L2I/xrN7lwuY9bRVX6M3oJxZ/E4VYGdJfP/JaSlbGG8sQ73qfKRdeBQ0Dr1
 qdZsVD1SsE4aseWSnId4qA8Bf1iBHas=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-yXskHRx8N6Gqmg_h7sda4A-1; Wed, 29 Jan 2025 10:23:31 -0500
X-MC-Unique: yXskHRx8N6Gqmg_h7sda4A-1
X-Mimecast-MFC-AGG-ID: yXskHRx8N6Gqmg_h7sda4A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43624b08181so4621705e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 07:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738164210; x=1738769010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oA3yWs7c8bDIgIX82kAPNrS7GmCTA2Npsse3oH3dhbs=;
 b=wTq89IgGJIkbUGyQJJSbDRmqNUy/Iu4bXtSq0a5/bivLro8NLtZ07DO5xO9UuxsNDV
 TwDkJa7+hbsQpOVjILMkTzjJsZ+EyPzCUU4jk3Vx8TQ2TFRJdTnboReEdpqeI3mWTXYN
 ABI0KLitWqY3fHy3I0FBWC/H1eEEvX/q31XDeyv78rjXZmB/T6MIiUyqtg3BM8MBcc7A
 udHblI3zYjWKhFW6H3QX/RHLk90ipN/feaVKUmlVbSsbhNqIjpWKlZTUHR+J5/vZGEiH
 DIyvqTX5vrXIFlkwcNuJX9SOoIURY2KjkCM1tDbB5DCCPW2lFkfFtZEukl8FXVc/PDh7
 1+nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5oGutxOtuv5uaJpFS7YqGn4QVBgWBMGdEnMEDtGiy6+zq3bRBjLIvv54qapxSck+NZwph7veuzRBY@nongnu.org
X-Gm-Message-State: AOJu0YwMAO6W30EBRt8dRLm/P+KC2nNwPzJ84lM6Ex84D0JUsGd0Y8gj
 VYzxyhyc0J6zAhktln0vm4+K7KBsdecbkXuKkE207kCqHwKtPj0LtkxBYmkjifJZNDIU+RI2qfo
 p7juIedF2ND/iFg2PPjSp1mUXM8c9HaAn7W+QEZPl+Wf8595sLPbV
X-Gm-Gg: ASbGncsqhQV4MeGnXsUpfpJuEDjKJbxSfJDUVMH2wtekzFYFPIcP0XUq7ws6HVxs8et
 ueasoid+JFtXw9wk9DWI0Wisz+DjhJe3F/AE0VCu8g23CYiiVAbdaFmawX803UYuY+gu4Sw413r
 VB5l+d2rerXawzFVTefTd3rf0nMHWMQVGfo+TJ7YPPRqnRGk7Ea7Tngexq0GJ1m6ViAM57uhl7t
 mQ286OV6axHcEpYKp7bgARnxcZbDzNjT+D/BxKqGuHjEKg83u9mVFoSr96VKS0ddHT8cfHyjkc3
 PF3H1EUEZrn/iWg3qgjvyxwKI+a9waGgA3xn7nDvVUL7LU8HAuZ2
X-Received: by 2002:a05:600c:6c92:b0:437:c453:ff19 with SMTP id
 5b1f17b1804b1-438d59b566dmr69106745e9.14.1738164210179; 
 Wed, 29 Jan 2025 07:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Wz1MPx7xrX7tYdHB94aHbvZ85zBnapPE8i+vvLO+p4WSftE/TzCmgF3YP19ESgrgTEuNMg==
X-Received: by 2002:a05:600c:6c92:b0:437:c453:ff19 with SMTP id
 5b1f17b1804b1-438d59b566dmr69106535e9.14.1738164209749; 
 Wed, 29 Jan 2025 07:23:29 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2f17dsm26180725e9.23.2025.01.29.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 07:23:29 -0800 (PST)
Date: Wed, 29 Jan 2025 16:23:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250129162328.17680ee7@imammedo.users.ipa.redhat.com>
In-Reply-To: <294577300217e4f7a606f3cb17382fd108c8c021.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <294577300217e4f7a606f3cb17382fd108c8c021.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 29 Jan 2025 09:04:09 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> While here, capitalize first letter on a comment about hardware_error
> address.
> 
> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 18 +++++++++++++++++-
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4cabb177ad47..db6bed010eb0 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -261,7 +262,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>      }
>  
>      /*
> -     * tell firmware to write hardware_errors GPA into
> +     * Tell firmware to write hardware_errors GPA into
>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */

please, drop non relevant hunk, or move it out into a separate path

>      bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> @@ -349,12 +350,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
>      int i;
>  
>      build_ghes_error_table(hardware_errors, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
>  
> +    hest_offset = table_data->len;
move it before acpi_table_begin() so that name would match with what actually happens
and adjust 4/13 to account for that

> +
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, num_sources, 4);
>      for (i = 0; i < num_sources; i++) {
> @@ -362,6 +366,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>      }
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);

it's not safe to add this without compat logic, as it changes size of linker
table and possibly layout.

I'd suggest to  partially combine this with use_hest_addr patch.
One way to do it cleanly would be to move part introducing
use_hest_addr here and set it to false to start with,
and flip default to true one all hest_addr_le code in place.
see related comment 6/13 

>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -375,6 +388,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
see 6/13 comments

> +
>      ags->present = true;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 9f0120d0d596..237721fec0a2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
>  };
>  
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;


