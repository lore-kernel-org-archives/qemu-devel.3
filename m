Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68609C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1rY-0003IJ-21; Mon, 19 Aug 2024 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg1rQ-00032Y-Kz
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg1rN-0004Oy-LM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724071903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=by+QCFBT6MiEPhb9gf96i+Wtei4ibVP3WzqXMkTBrlg=;
 b=IGNH7I3Xd02CmDXZHfbucpuItazKWX83L7WnmXuPUfQ4FN511TnjCDVlJOYXA2ypxpIS1R
 C/5zy5HycAMEt30tyAi3x8VI0jTHA+lY3UVOSP9ejN3/XqyEt5NskXc2+z3j43T15THBCi
 tQNDHnvaXLXHc7E5k+uKDNrIVpgJqoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-mwpKFF-AO4G_J5ucudh1qg-1; Mon, 19 Aug 2024 08:51:40 -0400
X-MC-Unique: mwpKFF-AO4G_J5ucudh1qg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37193ed09b2so1700328f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 05:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724071899; x=1724676699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=by+QCFBT6MiEPhb9gf96i+Wtei4ibVP3WzqXMkTBrlg=;
 b=PdSLlKmn8ilJzRgLvknm/DWJIqKwcuDP9wafGhK67A1hzwj2wU+Jp9IiJfOvvIEM/a
 BrlDFXhwNPXsteQjCEJFi2seumNL0KlO1IEdKYx3a6ND9GrckL3gqI7OyOqDXOp4FuSi
 VW8BbKKtcesfOAZmRmTnDHpCz7K/QQwo7mw4YlwbrFBJuH6XPF6MkB0A/kBDVRKgD9kQ
 lT7/Ltye9D00tSmyRAAGxTktxFvNzp1VyUAwvtr2sLGwijmdAbAt7smzkKXgzAivxzJb
 JFP/hLtJ2G9Ue+RLx1PQq30bOqiMWT0jKeJHgp7ldvghwCrQtKRMAn7MWYFCSZ36oTph
 BmSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjVYuIBhITsvnA1sKgGygzijAcJEv7U8YfUh3x7oM8yZ440JwIcdPBDI7uz0PhWahSRYZntPdMgqqjTlO98bsa3+NltSY=
X-Gm-Message-State: AOJu0YyRLgDDIyrJu7RT+7nMId1U1agVhzMkFJWu15AKTNiPga1eN+cw
 7zkMjxtBMGt+Xr0wSRnCNHFk2TkYo4l5RloAcXbSdBgSl8HF/H0zFT+MXcJ8opVpzAdkanw1YRz
 CukATBcujHqMCkIjo99ELVQn8DJ8v6b22eNuCEOKD/e88NvHowbLZ
X-Received: by 2002:a05:600c:a4f:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-429ed9f844fmr70111965e9.9.1724071898913; 
 Mon, 19 Aug 2024 05:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu5dMeM3vuzUh+X/YtAM1Q3TDvVYo3c4xih2tjIAfoIXlYmZsj5lFA5CHrpBFR2sximZ4f7w==
X-Received: by 2002:a05:600c:a4f:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-429ed9f844fmr70111795e9.9.1724071898403; 
 Mon, 19 Aug 2024 05:51:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed65072asm108393795e9.13.2024.08.19.05.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 05:51:37 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:51:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
In-Reply-To: <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Aug 2024 09:37:38 +0200
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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper.c |  2 +-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 7870f51e2a9e..a3ae710dcf81 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -500,6 +500,63 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> +void ghes_record_cper_errors(uint8_t *cper, size_t len,
> +                             enum AcpiGhesNotifyType notify, Error **errp)
> +{
> +    uint64_t cper_addr, read_ack_start_addr;
> +    enum AcpiHestSourceId source;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags;
> +    uint64_t read_ack;
> +
> +    if (ghes_notify_to_source_id(notify, &source)) {
> +        error_setg(errp,
> +                   "GHES: Invalid error block/ack address(es) for notify %d",
> +                   notify);
> +        return;
> +    }
> +
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    g_assert(acpi_ged_state);
> +    ags = &acpi_ged_state->ghes_state;
> +
> +    cper_addr = le64_to_cpu(ags->ghes_addr_le);
       ^^^ suggest to rename to error_block_address
       that way reader can easily match it with spec.

> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
and it would be better to merge this with previous line to be more clear
 + to avoid shifting meaning of variable between lines.

> +    read_ack_start_addr = cper_addr + source * sizeof(uint64_t);

> +    cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> +    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
I'd avoid changing meaning of variable, it adds up to confusion.
Anyway, what the point of of above math?  

> +
> +    cpu_physical_memory_read(read_ack_start_addr,
> +                             &read_ack, sizeof(uint64_t));
s/sizeof(uint64_t)/sizeof(read_ack)/
ditto elsewhere

> +
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack) {
> +        error_setg(errp,
> +                   "Last CPER record was not acknowledged yet");

> +        read_ack = 1;
> +        cpu_physical_memory_write(read_ack_start_addr,
> +                                  &read_ack, (uint64_t));
we don't do this for SEV so, why are you setting it to 1 here?


> +        return;
> +    }
> +
> +    read_ack = cpu_to_le64(0);
> +    cpu_physical_memory_write(read_ack_start_addr,
> +                              &read_ack, sizeof(uint64_t));
> +
> +    /* Build CPER record */
> +
> +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> +    }
move check at start of function?

> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(cper_addr, cper, len);
> +
> +    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
> +}
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> index 92ca84d738de..2328dbff7012 100644
> --- a/hw/acpi/ghes_cper.c
> +++ b/hw/acpi/ghes_cper.c
> @@ -29,5 +29,5 @@ void qmp_ghes_cper(const char *qmp_cper,
>          return;
>      }
>  
> -    /* TODO: call a function at ghes */
> +    ghes_record_cper_errors(cper, len, ACPI_GHES_NOTIFY_GPIO, errp);
>  }


