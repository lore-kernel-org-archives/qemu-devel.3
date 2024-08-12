Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E39EC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTEM-00014i-Uw; Mon, 12 Aug 2024 07:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTEJ-0000uO-I0
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTEH-00051r-AJ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723462128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzMz3TZb/4STKd1zC5JgrVRXvARW6dC5kvx3z4x0yLA=;
 b=ClsX1e90Dx0cKNRhkVyTy3/8DaAYkbgE3Kw5uVJgAUwzvRnuvATehBInYG+1svfusH7Zkg
 XQZl9QHq1IZ+MZQfn/xVVLxLdS2vF8ADGAD8Y4yH6h0eaOeiy/H0PKj6iWw9q+vx/Q7J+u
 OjjGcuuqp8lHHmYxInmYgUH1gg24XZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-qOi1xuVmMYiAkpB5WjH9Kg-1; Mon, 12 Aug 2024 07:28:47 -0400
X-MC-Unique: qOi1xuVmMYiAkpB5WjH9Kg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36d2c29e4ceso1654525f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723462126; x=1724066926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzMz3TZb/4STKd1zC5JgrVRXvARW6dC5kvx3z4x0yLA=;
 b=ukLuBI/MoG8LyuPo9xhcjWMXGPjol6/foYKRpZ/obUhTcC4dXog49tmtM2L/nIPorn
 fNpI7J8PU7MNiOOshWdr2f3AIP2hNWBSFtm+B89VXpHT8igVSUCix2bK0lz1kZSIfx3f
 ENqdR343fHz/iqF6CwDfAsOqntC+9FOi8gagmjYnzRgHBjITghoP1q+QakxFwsn6+Y8i
 bs/i5PBMB4IiDiJrorLg/5i86qcZui9mj69+HtSr/vl3aG7vgm1GGFJiD0Q3GDWM/6p0
 lxMeCP2HbUOdwKTeOp29sLcfqBJb/cSxV/VJMSPAJWpQ5C19f07OWc5SMmPcTxq2vXLt
 3b4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPfVf7tv9prFddxOXKP6Jf5VyZ2gDmMVdGf3htoGcn6CTBKGMAR9c7iudbDhTIr0egu+yRYHS6jDKd0n+XoWprhrQGrjU=
X-Gm-Message-State: AOJu0YwnK1NIJEv7UMRyVRaiKLYZDXtzoEMBbukORJMrAJ8ZVMoNDZEb
 FfDdoWx8rTAzzDiZxeE8HULd2Ho/5N0Qyi1li7B3K9u3M4rOIMeMk4ye7B2djtUV83I9aftiTNm
 kymc/AuILdFsZqClQ427mTGniDCz9d58v75HECa25oLok8D9XKbmv
X-Received: by 2002:a05:6000:d2:b0:368:669c:3bd3 with SMTP id
 ffacd0b85a97d-36d60ef85b9mr4936736f8f.48.1723462125894; 
 Mon, 12 Aug 2024 04:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9JYbDBo4AKSZo1vV2wWmLWk1n2QGqfs8ws+B+ZbyAv3Twi0sB3J3zuY5yY+R8tzUT5/nuw==
X-Received: by 2002:a05:6000:d2:b0:368:669c:3bd3 with SMTP id
 ffacd0b85a97d-36d60ef85b9mr4936720f8f.48.1723462125308; 
 Mon, 12 Aug 2024 04:28:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4ebd33ffsm7203275f8f.99.2024.08.12.04.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 04:28:44 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:28:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 03/10] acpi/ghes: Add support for GED error device
Message-ID: <20240812132844.1328937b@imammedo.users.ipa.redhat.com>
In-Reply-To: <909c4b6c1b90be284f1e5b653e075db7156b00cd.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <909c4b6c1b90be284f1e5b653e075db7156b00cd.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu,  8 Aug 2024 14:26:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As a GED error device is now defined, add another type
> of notification.
> 
> Add error notification to GHES v2 using a GED error device GED
> triggered via interrupt.
> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
>  rename HEST event to better identify GED interrupt OSPM]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 12 +++++++++---
>  include/hw/acpi/ghes.h |  3 ++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 13b105c5d02d..d6cbeed6e3d5 100644
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
> +    case ACPI_HEST_NOTIFY_EXTERNAL:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_NOTIFY_EXTERNAL, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -406,7 +413,6 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
>      if (physical_address) {
> -
>          if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
>              start_addr += source_id * sizeof(uint64_t);
>          }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index fb80897e7eac..ce6f82a1155a 100644
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
> +    ACPI_HEST_NOTIFY_EXTERNAL,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


