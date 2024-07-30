Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F173C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiPN-00052C-Q4; Tue, 30 Jul 2024 04:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYiPL-0004vq-At
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYiPJ-0006lz-Fc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722328832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bx38A0XpDP06oxe3bl+pZoWbefbgYUyRCc/BaKj6xL4=;
 b=C1jtYfAAT7gODQYCtYkI26USn7qdDm2YNHprZoES7vdZYcbRF6e11jwqq/Iynj/UZETrSJ
 1qD0Li2LECbVpz5ksRuKrL1li7tC6FJy8mb0SWox11Tmy019ZH4Ot1XsxRdXvds24kjUIT
 h52z4zYxSwbOMlXEZSzqp+7I/RVRi+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-AC9GrHzsNyeHP56kSTirYQ-1; Tue, 30 Jul 2024 04:40:30 -0400
X-MC-Unique: AC9GrHzsNyeHP56kSTirYQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42817b91d91so29171115e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 01:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722328830; x=1722933630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx38A0XpDP06oxe3bl+pZoWbefbgYUyRCc/BaKj6xL4=;
 b=tPPy1IwKl3JamQ2Ez98txHxJ7xm+Ad4K9GR5u1x2MKO2kEz6pZqjjrGIahzFYA47ks
 1TR6LhTdJyGJyBKmeH6pkq3UCepU71A59pQDXFchdGpQSO07YQ8PGQpXMtKFuIBgOWJa
 DKHRKPUjWfZOX1dDVsIj/TSwfhdnq0cJbl2WusY6TWUxmNcMJxaqh1HejYc97X6PW2Li
 InJeOqM7cmoDbynS0gqqeRMDgtEu/rb9PKdDrRStDKPKhHviH7hVukzo44wZiy5SQqqj
 eqtkKXPVwkCP7z964bglmYAETpqA0NUxJ/xiSHpHpDL3yrBkWU+E/2tp4DLoK0TcS/MU
 cSXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9VWEWdtTCku/wwGpfVj8ttNSqY9v8aiv+1IK45E9zY0Po7AkuEglgH3fwmhqEqLFU5vOigHP3MKHxDtjViRFJOOo1lU8=
X-Gm-Message-State: AOJu0YzpAaVguVNqcX9dUEB2pdazDKZ11e1oZbMxFj1hJc576gsD2SC9
 Xh2gl7mBfYS8O32TS2JlXcFPdECUaNw8XVQMKsdvlj1OQJGMLOzll5WZPlo8mXRHkXZK9o/VWX7
 Oga7xumi1oryf7yoWUzAAS/U04IWG7zPrdp/Ip4Edyao8Jw2ujfGu
X-Received: by 2002:a05:600c:310e:b0:428:15b0:c8dd with SMTP id
 5b1f17b1804b1-42815b0cb56mr77206125e9.20.1722328829627; 
 Tue, 30 Jul 2024 01:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7F8Wl0Pk7pPlBS7mRllgrGC08PD3OtHUYft3GlhhdnBwSt1qfBBkpUl1DTL1TfpmO5NU+Q==
X-Received: by 2002:a05:600c:310e:b0:428:15b0:c8dd with SMTP id
 5b1f17b1804b1-42815b0cb56mr77205935e9.20.1722328829115; 
 Tue, 30 Jul 2024 01:40:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280fa9a30csm136438785e9.30.2024.07.30.01.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 01:40:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:40:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
In-Reply-To: <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 22 Jul 2024 08:45:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add error notification to GHES v2 using the GPIO source.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 8 ++++++--
>  include/hw/acpi/ghes.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..5b8bc6eeb437 100644
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
> @@ -327,6 +327,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_SRC_ID_GPIO:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +373,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..4f1ab1a73a06 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
>  
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> +    ACPI_HEST_SRC_ID_GPIO = 1,
is it defined by some spec, or just a made up number?

>      /* future ids go here */
>      ACPI_HEST_SRC_ID_RESERVED,
>  };


