Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E396C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGYR-0002t0-Ki; Tue, 06 Aug 2024 05:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGYO-0002rj-PD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGYN-00032L-3i
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722936746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNPu6LDpYhbJ2jHL6PKAzJIFj3TmTcV+iCxzYNSBT/0=;
 b=SdtM8pNsdFbdOm45J2uBtzIHTzfiefEyYNP8UhU3ghRgOgr0/5R95gDN3uPbeSOU6269fS
 lUcZl6wGCaS3dDARL9jPaEyY66KZ/oQTHbpZ3WIumQMXeZ6VR8y0iqgCCXtMHU4tgdM/P8
 7LH19jhZlesm/Xp1glPfwx3wIm/0z4Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-7E88Jzr7O2u07NHyUJLClQ-1; Tue, 06 Aug 2024 05:32:23 -0400
X-MC-Unique: 7E88Jzr7O2u07NHyUJLClQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef23ec8dceso4258531fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722936742; x=1723541542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNPu6LDpYhbJ2jHL6PKAzJIFj3TmTcV+iCxzYNSBT/0=;
 b=u1hETdMOEi/vbjvL5f4D/IcuI8YRhDmz++7ByXt69BgK0HsvJzqDdf1H3PsJJLu57l
 JoU79cNH14Te7qB2twZcUNhmhxMXU4GEug+YmGzweYpKVlnpvtL7cTpXWu5C34/9DvKo
 /a1LRtiVmJHOECo5a/YdPS5to/+OxQKr08lY+5A88jzvimgTPcR+4LN884bzWukQvXis
 GGHitAsITHH4kv+fOaOCtI4WqHGzh5+K3TIZQJIn6TAnDeCx7YGSZJFpfAqkcizDwk1l
 eNsKkkUgDPpAvQS4CNHmQKJvnQHMDP2viYNwd3tt8F7+cXmTZeFGxbiN5cnEMgYkIYCq
 /cXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX76dZDPEaCmKANJLpKjgdGpqRY7yzO4UTin56yh6B998HcxaS9XXftM3a2fpMujD3R4Iy6Il+0VTShakbOXM89fl/788Q=
X-Gm-Message-State: AOJu0Yyc7vhynYKoaVCbeal+2ZOqwoRaae8GdHzIAeMOhzEOiWYafbse
 ZJG+WRnHYh8IdXR2pr0MWkOPLzom48voH1PqZjyLHCUdBbUtFhcTLI99nevaJJUPCheDnkDs2w2
 neJitVqqA1UeZ2cZ00TCEO2SQeGYqhCYpSWrb7X3t8vw15vsaI5z6
X-Received: by 2002:a2e:968b:0:b0:2ec:56b9:259b with SMTP id
 38308e7fff4ca-2f15ab5db15mr94720591fa.49.1722936742176; 
 Tue, 06 Aug 2024 02:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEow/WATG8BQ3G1Izu1sXI36xWSPlf4kPcR6y+06fEg5iiFT1qOQ5VcUBxZEzK3GuW8lZA1nQ==
X-Received: by 2002:a2e:968b:0:b0:2ec:56b9:259b with SMTP id
 38308e7fff4ca-2f15ab5db15mr94720281fa.49.1722936741527; 
 Tue, 06 Aug 2024 02:32:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm233403665e9.1.2024.08.06.02.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 02:32:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:32:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
In-Reply-To: <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  2 Aug 2024 23:43:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add error notification to GHES v2 using the GPIO source.
> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 16 ++++++++++------
>  include/hw/acpi/ghes.h |  3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8d0262e6c1aa..a745dcc7be5e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -34,8 +34,8 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> +/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> +#define ACPI_GHES_ERROR_SOURCE_COUNT        2
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> @@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  {
>      uint64_t address_offset;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_SRC_ID_GPIO:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);

perhaps ACPI_GHES_NOTIFY_EXTERNAL fits better here?

> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -406,10 +413,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
>      if (physical_address) {
> -
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +        start_addr += source_id * sizeof(uint64_t);

why check is being removed?

>  
>          cpu_physical_memory_read(start_addr, &error_block_addr,
>                                   sizeof(error_block_addr));
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 6891eafff5ab..33be1eb5acf4 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> +/* Those are used as table indexes when building GHES tables */
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> +    ACPI_HEST_SRC_ID_GPIO,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


