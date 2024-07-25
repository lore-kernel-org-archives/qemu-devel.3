Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtoN-0004Fr-OK; Thu, 25 Jul 2024 04:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtoK-0004FN-V8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtoJ-0007yc-34
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721896009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmJIVUr1s0ufZvXavXbaV36IURY/gDwnQgrgVArckXI=;
 b=Y2MyGhIrb/vTFWE29+GuAAkIChPYGkixNvZ/RkfrcQzFyGEh1CNR7DWpI0/xL36bIkaQ81
 3SXLVb9BSuin+ugVrlrbzcrBkhMpglGQCSJ6Z7Rjo754EGDJ1uIK/1te0dCQi3bMV906ma
 nWYCKQDfT2b5gVKop/JiHYmJTPVLq6g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ffQahzPpMqCIkXX3TCRnvg-1; Thu, 25 Jul 2024 04:26:47 -0400
X-MC-Unique: ffQahzPpMqCIkXX3TCRnvg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4279b07cd45so4581795e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721896006; x=1722500806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmJIVUr1s0ufZvXavXbaV36IURY/gDwnQgrgVArckXI=;
 b=gq2Jev9nLg/nh8HcjjMvl1t6HO19wvqxgMAtRpS+kws2CE6qryBt4JaW2+KjPV3QNp
 b1uRWHiYFBCMh0APD/SaaumFgCKcj+DpAVNuQW1wuIdUN6/bXzLUNJndvWK2xHjnHKia
 HyOn65G8qKn2SaxXTtbiuTqcVEEOicEmxiwXoL3OWoFs3f5h4d8w7wmg3bxatLn7Dsnz
 08qbg4ZhW/e6ilciEE8kEpTu1aeQxiW4HnOgq1kIvdqEE+5Pw6MgmvblTlHfdGj531Um
 4OAn18fBtzTmwU/cNityip9RWOEX+Ov30WHTxI7iehRnVWAUEjdiZ3prZyA4hvs9F/PJ
 G3zA==
X-Gm-Message-State: AOJu0YwyovNsEKn93zt+2/G8JMPWPvNY314aplkbbaQibZ6urmtkTyJ4
 gt3+WpRh8WPBEeGJyvczsDYyiQZ4PR8QBj1koKjlN47XjeY8mW+IPOs0h0ghcdLKkRe9z3X1mm9
 FWmL/Ox5XZo6O8HgRVbxDEj2n3rPi0lEBOOe1Okzl0X22iz+wV7s8
X-Received: by 2002:a05:600c:1d15:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42805508671mr11444695e9.4.1721896005884; 
 Thu, 25 Jul 2024 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFveB3gVv95n5WzoDG+eeAlZTmn0ASHbFDqaP/OgZXTbrI6xW2Ob+sqZmAk0FxdC72/C9rCw==
X-Received: by 2002:a05:600c:1d15:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42805508671mr11444525e9.4.1721896005476; 
 Thu, 25 Jul 2024 01:26:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730bd0sm23243225e9.10.2024.07.25.01.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:26:45 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:26:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Wire up S3 and S4 sleep
Message-ID: <20240725102643.498a0192@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-2-d2ef0aaa543a@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <20240613-loongarch64-sleep-v1-2-d2ef0aaa543a@flygoat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 13 Jun 2024 18:30:16 +0100
Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> Wire up S3 and S4 sleep by setting relevant slp-typs bits for
> GED and generate _S3 and _S4 methods in acpi table.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/loongarch/acpi-build.c | 18 ++++++++++++++++++
>  hw/loongarch/virt.c       |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index af45ce526d6e..2cb1696b579b 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -416,6 +416,24 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      acpi_dsdt_add_tpm(dsdt, lvms);
>  #endif
>      /* System State Package */
> +    scope = aml_scope("\\");
> +    pkg = aml_package(4);
> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
> +    aml_append(pkg, aml_int(0)); /* ignored */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(scope, aml_name_decl("_S3", pkg));
> +    aml_append(dsdt, scope);
> +
> +    scope = aml_scope("\\");
> +    pkg = aml_package(4);
> +    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S4));
> +    aml_append(pkg, aml_int(0)); /* ignored */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(scope, aml_name_decl("_S4", pkg));
> +    aml_append(dsdt, scope);

if it's the same in both patches, I'd suggest to move it
in helper function in hw/acpi/generic_event_device.c
and call that here.

>      scope = aml_scope("\\");
>      pkg = aml_package(4);
>      aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 66cef201abe0..a4b55f00a32b 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -615,6 +615,9 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
>      }
>      dev = qdev_new(TYPE_ACPI_GED);
>      qdev_prop_set_uint32(dev, "ged-event", event);
> +    qdev_prop_set_uint32(dev, "slp-typs", (1 << ACPI_GED_SLP_TYP_S3) |
> +                         (1 << ACPI_GED_SLP_TYP_S4) |
> +                         (1 << ACPI_GED_SLP_TYP_S5));

drop this, it should be default,
and backward compatibility for versioned machine types,
should be handled by compat machinery
 
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
>      /* ged event */
> 


