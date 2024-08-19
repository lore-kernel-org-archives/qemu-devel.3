Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE88C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1xC-0002pZ-PI; Mon, 19 Aug 2024 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg1x8-0002oU-HM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg1x6-0005Gg-Jp
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724072259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQq04umgaGGIU/uyNF6ouiRkFMTZ4eoaEDjVqBV4xoQ=;
 b=L+HdzufIZx3ptFtlVd/+jsYjfLa9AFMLC4kRpF/Cw+6XOIJA4yRhpBXG4Yf2s5tAX+tnkj
 B0tc2bM9SudAsJzl6ULSxl0wglPsccVke0Et7bM3S/+ce0tGj5+WIUlimB/wx0cdp5g3Gl
 /s9hw9Jpr1ZCRGoG8Qv6Jx5bPpoL+2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-yRSjae6dPsKAYhFKBVwRxg-1; Mon, 19 Aug 2024 08:57:37 -0400
X-MC-Unique: yRSjae6dPsKAYhFKBVwRxg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3717cc80ce1so2647017f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 05:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724072256; x=1724677056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQq04umgaGGIU/uyNF6ouiRkFMTZ4eoaEDjVqBV4xoQ=;
 b=jr0YRbhqvkDEm1WcU/J+9lMEquBNkfTy8JIdYK5w75KE8zpUI3h7NkNpXvQmmqVjZ1
 z0GnVpPMZnZnsBVefc1ZfQcFbM3lCpsd41I5Q8/hD58lyEd8vObRFMlY4HvA0UWuAazc
 Hc2u5nQVXGNDJILnnZyaDKQHBh7M+yEEyIrbNNbvqrU0Tq/280pm7u/u6YRiDHbsXBxL
 +tVHgeuvYye+GH6VnhW44p8ge4pEwmmjWAoFFAhT5r/SMqJLIaA/vsR1lTTpLmTSVmBc
 oBMGcxmSmhqeCszxXywmIF2DoCoxSCchO6YrU1fgL8d3dctMFVI162zYdtsuh62G8NuG
 PPwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXPdnr7bLwE1BMF6iCF3/DRIqB4/WGYPthrxI0OdMn+YIsqAtE1MSoWj00wgBegjYrBmRERxvCh0ohYrZvc1cJ7bnaW3U=
X-Gm-Message-State: AOJu0YzKkMoF14rwXQ/+wfvMR/1aQd9aTi8ApIzwhrK+D1omcZ7KwuJm
 ASEFGfjcY7hrO1Fowp1Q+WQEpcCCDalks2vwMa27510hGRga1SBqtnbZChBWK1RU9fVHviXlcgC
 dWW7XV6m0rMhW28wES5UZohD+NRNXVAm/htKklijmVczFpnYLTLQK
X-Received: by 2002:a05:6000:e4e:b0:367:8f29:f7b6 with SMTP id
 ffacd0b85a97d-371946ae685mr7234182f8f.51.1724072256297; 
 Mon, 19 Aug 2024 05:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdM5bWz0CAQc4dGvn0HR9XlG67JZvOfW1ujlsk+hoA8XtZ2Fphyll8c8dG8XzG5MUJlwt/cg==
X-Received: by 2002:a05:6000:e4e:b0:367:8f29:f7b6 with SMTP id
 ffacd0b85a97d-371946ae685mr7234159f8f.51.1724072255728; 
 Mon, 19 Aug 2024 05:57:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718984c0d0sm10471874f8f.38.2024.08.19.05.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 05:57:35 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:57:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 12/13] acpi/ghes: cleanup generic error data logic
Message-ID: <20240819145734.03977654@imammedo.users.ipa.redhat.com>
In-Reply-To: <d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Aug 2024 09:37:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Remove comments that are obvious.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
these comments help if you don't have spec side by side with code
to compare. I'd even say such comments are preferable than no comments
when composing an ACPI table.

pls, drop the patch

> ---
>  hw/acpi/ghes.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4f7b6c5ad2b6..a822a5eafaa0 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -130,34 +130,28 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
>   * ACPI 6.1: 18.3.2.7.1 Generic Error Data
>   */
>  static void acpi_ghes_generic_error_data(GArray *table,
> -                const uint8_t *section_type, uint32_t error_severity,
> -                uint8_t validation_bits, uint8_t flags,
> -                uint32_t error_data_length, QemuUUID fru_id,
> -                uint64_t time_stamp)
> +                                         const uint8_t *section_type,
> +                                         uint32_t error_severity,
> +                                         uint8_t validation_bits,
> +                                         uint8_t flags,
> +                                         uint32_t error_data_length,
> +                                         QemuUUID fru_id,
> +                                         uint64_t time_stamp)
>  {
>      const uint8_t fru_text[20] = {0};
>  
> -    /* Section Type */
>      g_array_append_vals(table, section_type, 16);
> -
> -    /* Error Severity */
>      build_append_int_noprefix(table, error_severity, 4);
> +
>      /* Revision */
>      build_append_int_noprefix(table, 0x300, 2);
> -    /* Validation Bits */
> +
>      build_append_int_noprefix(table, validation_bits, 1);
> -    /* Flags */
>      build_append_int_noprefix(table, flags, 1);
> -    /* Error Data Length */
>      build_append_int_noprefix(table, error_data_length, 4);
>  
> -    /* FRU Id */
>      g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
> -
> -    /* FRU Text */
>      g_array_append_vals(table, fru_text, sizeof(fru_text));
> -
> -    /* Timestamp */
>      build_append_int_noprefix(table, time_stamp, 8);
>  }
>  
> @@ -165,19 +159,17 @@ static void acpi_ghes_generic_error_data(GArray *table,
>   * Generic Error Status Block
>   * ACPI 6.1: 18.3.2.7.1 Generic Error Data
>   */
> -static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
> -                uint32_t raw_data_offset, uint32_t raw_data_length,
> -                uint32_t data_length, uint32_t error_severity)
> +static void acpi_ghes_generic_error_status(GArray *table,
> +                                           uint32_t block_status,
> +                                           uint32_t raw_data_offset,
> +                                           uint32_t raw_data_length,
> +                                           uint32_t data_length,
> +                                           uint32_t error_severity)
>  {
> -    /* Block Status */
>      build_append_int_noprefix(table, block_status, 4);
> -    /* Raw Data Offset */
>      build_append_int_noprefix(table, raw_data_offset, 4);
> -    /* Raw Data Length */
>      build_append_int_noprefix(table, raw_data_length, 4);
> -    /* Data Length */
>      build_append_int_noprefix(table, data_length, 4);
> -    /* Error Severity */
>      build_append_int_noprefix(table, error_severity, 4);
>  }
>  


