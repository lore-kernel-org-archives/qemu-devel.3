Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B68C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8qR-0002V5-IC; Wed, 29 Jan 2025 09:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8qQ-0002Uf-F6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8qL-0005F0-J9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738160099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZm0yViyPaB4mjqdNpOSz1nhQ39D3mT/cQfmITx4EJw=;
 b=Y3zJGTrcIQFTHKpDRnB4UvsxTc1l0IvaZz/+kz3v2441CDedhL1tRi7m6ZLsYu6OyWhnEC
 wN+zK1pgFJdO4oMm+Bj7W0Uf35I8CbbQ8qq10DFS+d2ll5POS02S1abdQhS/WhWNePJCIP
 i68oqdkUqjxj//msDI7JPPupDHowVTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-AKKcGfyWOcSxRcwSHyMGfw-1; Wed, 29 Jan 2025 09:14:58 -0500
X-MC-Unique: AKKcGfyWOcSxRcwSHyMGfw-1
X-Mimecast-MFC-AGG-ID: AKKcGfyWOcSxRcwSHyMGfw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so4153705e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738160097; x=1738764897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZm0yViyPaB4mjqdNpOSz1nhQ39D3mT/cQfmITx4EJw=;
 b=JYK0+2iOkWc93Y2y2iuLRqRfT7AXw/pWLe7SC/UESHpwGAN8skh9xbtFlG07XFDY5A
 3CaDnbyh8LlNdpNTkIGIFp32RfyLdSJcfUexMl3zAbEHZU4IpO54tLZ9NK1lsbHitONv
 SUWkMgdXUr+RupO/NaXzCJkNov9nBmtcQnOvjzL+MdfOvdxiwMN11fHBHX3HRfHQdanw
 2YNKVM2SdNlCcj+EYbzvQVV1+N+Y/Acb7RSGwLUYLkI2nhUynsXmCEMam6bqpJrje7b4
 SPY8zvwxXBvu4Jjy3Xz+1ZoGrlWsuIsba9Iq3pliL3fwsABWZhf8zWHjHzZml7d2Wxu+
 LYtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/AqO0oRAPotphh/q4QtnJbJko4qtz8hmE23JhROg/sGlJMbbNvy1IpOqs1woq9kjWGaVEdeIdjjvL@nongnu.org
X-Gm-Message-State: AOJu0YxZTZHm3AvBubyDwT9BnENQddnG1gffIvJazzAjd9G8GW0r4O7a
 tmTO//hY9zZ3+J9Grw1xry/hxzShjvPqnQWapOAjr3Hdm7t1VSZ10s9jZBhvRgNMEI0Wqy+ryDs
 z2yDO+FYqFVJhEJ11vl69L4UdWcesFp4qTEtzByARy0DKiAzlcY0D
X-Gm-Gg: ASbGncvd1fiSitDa2gCuVJQix9DBQwOYNZg6uz7vEnycCVaW0qMh0dKixVdZ5xGuTKk
 zo/x+erNjn28UM38nYK/xbIqJr5wrj7hSum+OPxNNMTDskf4ANgWkIDGiNgNHvgViWRlgL+TFOD
 IyI9OxMV7pUD9XzTAsgRF+de5SUOkI7cWgn+jewuOB2SBgVVGhVP/RSOYzudxFu1VAxf4fFgWzM
 +YSdQDvh3cgbBLYUgtyIUgIANIx39K6vH/HD5MzYDRwNIT5f1wMpGd4NZij5JszvddCtpKq3hMv
 D9KCU0x+R5z4Wt8gnp9zCHyHW16mYKYdj7SFW6w+DXWUZHAHX0uy
X-Received: by 2002:a05:600c:244:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-438d5967dbfmr63834695e9.8.1738160096798; 
 Wed, 29 Jan 2025 06:14:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5Uof5bbDsPPXxfwWs/5v63vt5u80saJcQuH2FFqd3JggcngXhLRHxGGWXlO6imykOTXH3fA==
X-Received: by 2002:a05:600c:244:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-438d5967dbfmr63834465e9.8.1738160096402; 
 Wed, 29 Jan 2025 06:14:56 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2c4ddsm24216605e9.17.2025.01.29.06.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:14:55 -0800 (PST)
Date: Wed, 29 Jan 2025 15:14:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250129151454.0f5293d7@imammedo.users.ipa.redhat.com>
In-Reply-To: <de81bd00f4b0b656bc0d191232610b86e157fcb8.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <de81bd00f4b0b656bc0d191232610b86e157fcb8.1738137123.git.mchehab+huawei@kernel.org>
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

On Wed, 29 Jan 2025 09:04:10 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack.
> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 111 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 101 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index db6bed010eb0..adf80945c6db 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,25 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/*
> + * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_READ_ACK_ADDR_OFF          64
> +
> +/*
> + * ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_STATUS_ADDR_OFF  20
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -212,14 +231,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>  {
>      int i, error_status_block_offset;
>  
> -    /*
> -     * TODO: Current version supports only one source.
> -     * A further patch will drop this check, after adding a proper migration
> -     * code, as, for the code to work, we need to store a bios pointer to the
> -     * HEST table.
> -     */
> -    assert(num_sources == 1);
> -
>      /* Build error_block_address */
>      for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> @@ -420,6 +431,81 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_ghes_source_offsets(uint16_t source_id,
> +                                    uint64_t hest_entry_addr,

now, confusion introduced in 3/13
(hest_addr_le not actually being start of the table but named as such)
continues here 

> +                                    uint64_t *cper_addr,
> +                                    uint64_t *read_ack_start_addr,
> +                                    Error **errp)
> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> +    uint64_t err_source_entry, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    if (!hest_entry_addr) {
> +        return;
> +    }
> +
> +    cpu_physical_memory_read(hest_entry_addr, &num_sources,
> +                             sizeof(num_sources));

hest_entry_addr implies to me error source entry, while what
you are reading here is a part of HEST but not a part of error source

suggest s/hest_entry_addr/hest_addr/ and then read from
  hest_addr + 'Error Source Count'_offset 

> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_entry = hest_entry_addr + sizeof(num_sources);

and amend this line to point to 1st error source entry 

> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +
> +    for (i = 0; i < num_sources; i++) {
> +        uint64_t addr = err_source_entry;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
> +        type = le16_to_cpu(type);
> +
> +        /* For now, we only know the size of GHESv2 table */
> +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> +            error_setg(errp, "HEST: type %d not supported.", type);
> +            return;
> +        }
> +
> +        /* Compare CPER source address at the GHESv2 structure */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));

> +

I'd drop this new line

> +        if (le16_to_cpu(src_id) == source_id) {
> +            break;
> +        }
> +
> +        err_source_entry += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate though table address pointers */
> +    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
> +                          GAS_ADDR_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    error_block_addr = le64_to_cpu(error_block_addr);
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
> +                         GAS_ADDR_OFFSET;
> +
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +
> +    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -440,8 +526,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> -                         &cper_addr, &read_ack_register_addr);
> +    if (!ags->hest_addr_le) {
> +        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> +                             &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
> +    }
>  
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");


