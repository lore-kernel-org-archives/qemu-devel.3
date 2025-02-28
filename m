Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3D2C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzwz-00041H-VC; Fri, 28 Feb 2025 07:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzwn-0003fc-9P
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnzwj-0006EQ-WF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740747508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOdElMhER4o/+uZuYvse6PdLduLz2Bd1s6NaMonnZvg=;
 b=W+WTadtusNVhXeH8ZoaKn3EfFy3On4n1CJAl5OwMIird3g7QieQPIf1/F0oUTeHB1PyxCZ
 kgCNieuZzBwPlao73iAlGj7bmEQUz0Z3DGjaU7w2qshuV8YVzy/LfxuJQxPCk8XTYc/Xm6
 ysV1/nmeRfZD7tDFJ/tgrD5AIpj7rzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-7wLENa9TOfaWnBwqynUBAw-1; Fri, 28 Feb 2025 07:58:27 -0500
X-MC-Unique: 7wLENa9TOfaWnBwqynUBAw-1
X-Mimecast-MFC-AGG-ID: 7wLENa9TOfaWnBwqynUBAw_1740747506
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so10357675e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 04:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740747506; x=1741352306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOdElMhER4o/+uZuYvse6PdLduLz2Bd1s6NaMonnZvg=;
 b=xJyaWRlDcoynG0LWG7xcGTujB4kb/9Q33Yc9qXdgDNyERf/20OwtuZuwV6ZE2/A+Xp
 v58DNBEHAqUlJ9Q2GORu8mLihnH7C98UobrG5Ml2eTvRKh7zq2ZkVPI9iHatPCFxotlQ
 +n0hLB/vnHRbiVz/2zk35LfBbF6SbW6t9VFuAY9oEAixTxk2X1Wcz/z38nQzzR3lm3Io
 ouCgCbz5Xf80P1yplDHV09MuwMqTHJUXJYO1wQivgD5t/sZTv/3m/FyyOoNVKw7EImLG
 xlYWbCMTblADMHZ39nHKN0j2T8I9ajdPMF53TxhibZSdYZQKmuktdTjE4MdFhjKjRX7T
 pCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCkpliulh6weRG1SX5RoVe9ZVzs4vT9OWKdWvPK2NhUc6r+KPAddz9O+br3i7I46WtGzx2K4crrvN0@nongnu.org
X-Gm-Message-State: AOJu0YwbWKXD4QqUsI8D1hf0IPrIbrANSCmbDKJ2PRrpRE4Ymo8mrsZn
 Gr5/qDrqCQPEcIUe+gSxo4sbPNQuqPSxZwGFhezKSlW+Vk+++eWWT4jKwRIEeWv5zkcMOO7jOyK
 Tckpat2zSdVGoXPNhmk3/eUtdiV0ZeBQG9bBrXCAx+p2qKHKm89Dq
X-Gm-Gg: ASbGncvYfLMxM2jrFDYxS3i2q20GD158yc5y8Uq3RMOCxknaxfpQeCzqxJiyW1+2WAE
 TxuTc6h120dbCpZcjRyShniFCpB3QaHQLwj5svXaBIBvbkIv+sv4kvSL7GQosnS3Yzadzs9+wLK
 mgeJyqlz3NrqlPQVIErgTwU54h6RnvZRjNGzcjTXY8YKbuYBA9dHDrv4WVZ482jsI7BXGLEmSLB
 eLXt5Rnap80pIkg8R3c6Y4LiHtHvJO8c8US80KTFWESmhUGZ5X4lQWl6MO9CadvxmOxM26eFVuT
 0gF/0m09Md98enT6SPVM8ZQXKb4TyAH7hPLw5qT/Yj0rMnbMGs0OLG6dukWzB5Y=
X-Received: by 2002:a05:6000:1fac:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-390ec7760efmr2961132f8f.0.1740747505790; 
 Fri, 28 Feb 2025 04:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd3CKonl5hDfbOT/izjKTluVl0Zz26NrDrbURNF+GzsPp4DmwMrCrizD5xEMyGPCPAnDe6Gg==
X-Received: by 2002:a05:6000:1fac:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-390ec7760efmr2961109f8f.0.1740747505438; 
 Fri, 28 Feb 2025 04:58:25 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47965ddsm5288898f8f.18.2025.02.28.04.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:58:24 -0800 (PST)
Date: Fri, 28 Feb 2025 13:58:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/19] acpi/ghes: add a notifier to notify when error
 data is ready
Message-ID: <20250228135824.04713a97@imammedo.users.ipa.redhat.com>
In-Reply-To: <a6a2b8b68a12df8ef9018a9756b3ea95b1c84eb9.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
 <a6a2b8b68a12df8ef9018a9756b3ea95b1c84eb9.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Thu, 27 Feb 2025 17:00:47 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Some error injection notify methods are async, like GPIO
> notify. Add a notifier to be used when the error record is
> ready to be sent to the guest OS.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 5 ++++-
>  include/hw/acpi/ghes.h | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f49d0d628fc4..0135ac844bcf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -510,6 +510,9 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
>  }
>  
> +NotifierList acpi_generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> +
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -550,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
> -    return;
> +    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 8c4b08433760..390943e46d99 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -24,6 +24,9 @@
>  
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "qapi/error.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList acpi_generic_error_notifiers;
>  
>  /*
>   * Values for Hardware Error Notification Type field


