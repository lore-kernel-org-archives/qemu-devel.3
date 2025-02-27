Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86654C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndvD-0000ok-5U; Thu, 27 Feb 2025 08:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndv9-0000ir-TD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndv7-00024T-MF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740662840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Az0axnx9GoNHmG1bRahpz+gTtatrJjB9FkHXDcLXTEU=;
 b=SfYAHXeJDWt2//MhBw2kNKYdGLMEZ9+LFHSZYTdcWohTvhA8lHMlTA2mg4Lp2PIiAdfCbz
 9XTz0xGHzbhkaaZ+N7TvWNiXTnGCQUUbK3kmYGrdGflzAYlzwS4QZMJGH0ezzYceTeMftH
 EELNzxK3N79vZz89AdK9fgfrICV4kbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-su9D7xnpPbmvK7qZTHsisA-1; Thu, 27 Feb 2025 08:27:18 -0500
X-MC-Unique: su9D7xnpPbmvK7qZTHsisA-1
X-Mimecast-MFC-AGG-ID: su9D7xnpPbmvK7qZTHsisA_1740662838
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so8939075e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740662837; x=1741267637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Az0axnx9GoNHmG1bRahpz+gTtatrJjB9FkHXDcLXTEU=;
 b=hCzrZbheunngPMk/WivqPGWoWpBw+ShoUbvhZDYuPnWyoLRIO+RLf5elxyOrpGhQrZ
 O0QJfKap9JGdvzl8Z1JF1m79n53gZeJ1UmvIk3OUzgVk5Ym1nPmjKsRLQc5AKDL5mHco
 Usb8tPEQ5gGZ7u5OYUulmEE1+q5wB2WPQ7S6Y82uVR0UL71wqBnLOrM9vCRinilmySgf
 w9UoKKNnEp6UR2Zp/Wdf4eG9cOOD699aa2Lcme+kNlEdrY4abswI5NkuutYxatxrB77u
 f8fd1zVv3L0Mrcri8gDu1LSAGOUA7qpECP4+czs01hwAtn8X0rk138k5AC/2s7g1bzrz
 gyzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Gu2t2cR6exfBg6nRhPKAv8OIaSYReUiUD15agHNDdiHpEnS+uTHdF4snqYhw6U8wZRyQznX/xsll@nongnu.org
X-Gm-Message-State: AOJu0YxfqrSxALY9+rqZYQxHjm6GwxwBCyX73GtOhfF3n9qHGQyLj/Qq
 Lz6dzGlpXaWmwIpkaUV60w4tIVtKwfV560dLCbZ+bNFoV2tFPugmA/f69OeEyeNlSWugB1gJF6N
 CDrI7gfK3htS2ub0bI7vgz0SmupmdxCaBTyYxmj2GAux0KLIwOGPv
X-Gm-Gg: ASbGncv9AUdmA6vBq4JKM73lD1JgmShjg9mEB1ecnlf2E6MLwTITvNfcxLSWHE0hZOB
 yZlQoCKPWqN5xJfdx4e80vcKBY3bDef3RsgeTXfdYXv6AyziTdhec37G5O7lf45Fnpc3iJ8XLLO
 B5NhsWP1qDK8JlCH0n9ACwsaDuxEs3pSOMdtC6D/CwgQzmdWT7XMYuRKeBeArRfNE0dKWYdEAYK
 EwL/V4mVBC4eEpTtaWUFPZyC8i6tkWvlj7O2oNy0vSwyfrWK0bN12qiG1GDFMeJ0aqR6qLwwrJN
 J0bpNJaMyk3ZRbf/46a+82ZOZMvCIaYX5P4QWDz0abXs4xd51re8r7q6xe0UDFU=
X-Received: by 2002:a5d:5f93:0:b0:38b:f4e6:21aa with SMTP id
 ffacd0b85a97d-390e1648bd8mr2548334f8f.5.1740662837589; 
 Thu, 27 Feb 2025 05:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpfkKx1S7TW7K4FNOYoEi418gJH6dJcGjcmN/GLUDm9AZ+9mdiaFjVmR4OGFaJbqvSqzQKDA==
X-Received: by 2002:a5d:5f93:0:b0:38b:f4e6:21aa with SMTP id
 ffacd0b85a97d-390e1648bd8mr2548313f8f.5.1740662837146; 
 Thu, 27 Feb 2025 05:27:17 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795962sm2139257f8f.13.2025.02.27.05.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:27:16 -0800 (PST)
Date: Thu, 27 Feb 2025 14:27:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/21] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250227142715.79984512@imammedo.users.ipa.redhat.com>
In-Reply-To: <bd544e003047996eaaebe10c11e13f1d30c2751d.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <bd544e003047996eaaebe10c11e13f1d30c2751d.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 27 Feb 2025 12:03:37 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the read ack.
> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes
> from older QEMU versions.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ghes.h |   2 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8ec423726b3f..5158418f93cb 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -41,6 +41,12 @@
>  /* Address offset in Generic Address Structure(GAS) */
>  #define GAS_ADDR_OFFSET 4
>  
> +/*
> + * ACPI spec 1.0b
> + * 5.2.3 System Description Table Header
> + */
> +#define ACPI_DESC_HEADER_OFFSET     36
> +
>  /*
>   * The total size of Generic Error Data Entry
>   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> @@ -61,6 +67,30 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * See the memory layout map at docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/*
> + * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_ENTRY_SIZE  92
> +
> +/*
> + * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + * Read Ack Register
> + */
> +#define GHES_READ_ACK_ADDR_OFF          64
> +
> +/*
> + * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-341 Generic Hardware Error Source Structure
> + * Error Status Address
> + */
> +#define GHES_ERR_STATUS_ADDR_OFF  20
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -408,6 +438,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_ghes_source_offsets(uint16_t source_id,
> +                                    uint64_t hest_addr,
> +                                    uint64_t *cper_addr,
> +                                    uint64_t *read_ack_start_addr,
> +                                    Error **errp)
> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> +    uint64_t err_source_entry, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    hest_addr += ACPI_DESC_HEADER_OFFSET;
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources,
> +                             sizeof(num_sources));
> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_entry = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
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
> +        /* Compare CPER source ID at the GHESv2 structure */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +        if (le16_to_cpu(src_id) == source_id) {
> +            break;
> +        }
> +
> +        err_source_entry += HEST_GHES_V2_ENTRY_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate through table address pointers */
> +    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
> +                          GAS_ADDR_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +    error_block_addr = le64_to_cpu(error_block_addr);
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
> +                         GAS_ADDR_OFFSET;
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
> +}
> +
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -423,6 +520,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 38abe6e3db52..dcc7288ffba5 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -79,7 +79,7 @@ enum {
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool use_hest_addr;         /* Currently, always false */
> +    bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,


