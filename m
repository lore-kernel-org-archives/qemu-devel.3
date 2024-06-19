Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A2C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrj4-0000js-Mr; Wed, 19 Jun 2024 05:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrj2-0000hg-Sw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrj1-0006xL-FE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718789730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGEzzY08bh5HSHPmQO9sp7fYf7xs1EETsPabs8WT5cU=;
 b=hJDBY/FDGIUWYAm6Ey1jt7kIhB7BVB7DFafB1mnKDvuKrs0XyjE0lGbnJ2nV5KItq7vVlA
 a2i2HImOhIlsv50r+ryVDvOHE06hjPV2WLCumeBDVe96P7iEV/qBv5TII9EMwRkwr9PiDa
 WePHDqPG73sA0pUlvJS6BJ/hPwNJ8eA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-STMMPeNVNCagGXYE6DBlFA-1; Wed, 19 Jun 2024 05:35:27 -0400
X-MC-Unique: STMMPeNVNCagGXYE6DBlFA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421759c3556so3531695e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718789726; x=1719394526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGEzzY08bh5HSHPmQO9sp7fYf7xs1EETsPabs8WT5cU=;
 b=Nv6ttXAkMdZnL/pxY/X+j139WIzUYOrMjFg98vP1bbQNifyq0oZAHjlAZtTfWug2Pw
 uvvPSkOrVXoGb1sEWGJkAKyITqW2wiLBPtZbkPpbaOwd3mtY778eG+198Ofe39lHhWqV
 DRq3AELR/HW5bky2WpgmI0d0WjeNGjs6QXaFcY3krTD0A308f+DJ2tWUnAfosQxkqIgl
 dcFqzgr0zc7cfSPervq2ODRVw6iLuDmlroxFXg0mENGl7HlSo6yDqE3nHNm5vb3RQOL5
 82xVpv7brFibfRjMW1D04LsQ29PTrWtMq1/HRhUKD9ZFIKXrbQuRGCG7nhV+6totj2XT
 bSag==
X-Gm-Message-State: AOJu0YxTrmhRa82PfdWJ90XjvXm+C8zWn3SfBlKU1tVFpC9HtNiCVWrq
 mieJCI4f/lS+Iw4EfPzW2/usIfpIxtYd3ZUINNS7RuoJjK7wpjeTjytgWoSNzB2KKdBXpkk9Ecp
 mjWLRygtKFcyqh+vlhwnALtdzu6TP6eZsyIQ4MRIXvRBwRWNBk6qV
X-Received: by 2002:a05:600c:2e56:b0:421:811b:b865 with SMTP id
 5b1f17b1804b1-42474d4087emr20950615e9.18.1718789726560; 
 Wed, 19 Jun 2024 02:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+IOZZFjySlq9hPVyUo2hSZ+ha2aCerpTjyNRDvaaSNN2tjbfyqJfO9CRAfgzFv+lPaIWLEQ==
X-Received: by 2002:a05:600c:2e56:b0:421:811b:b865 with SMTP id
 5b1f17b1804b1-42474d4087emr20950355e9.18.1718789726193; 
 Wed, 19 Jun 2024 02:35:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm221167315e9.19.2024.06.19.02.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:35:25 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:35:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis
 <alistair23@gmail.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1
 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>, Andrew
 Jones <ajones@ventanamicro.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 08/12] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Message-ID: <20240619113524.23982e70@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524061411.341599-9-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-9-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Fri, 24 May 2024 11:44:07 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Update list of images supported in unpack_edk2_blobs to enable RISC-V
> ACPI table testing.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  pc-bios/meson.build     | 2 ++
>  tests/qtest/meson.build | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 0760612bea..8602b45b9b 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -4,6 +4,8 @@ if unpack_edk2_blobs
>      'edk2-aarch64-code.fd',
>      'edk2-arm-code.fd',
>      'edk2-arm-vars.fd',
> +    'edk2-riscv-code.fd',
> +    'edk2-riscv-vars.fd',
>      'edk2-i386-code.fd',
>      'edk2-i386-secure-code.fd',
>      'edk2-i386-vars.fd',
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 86293051dc..2f60f6aed8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -259,6 +259,9 @@ qtests_s390x = \
>  qtests_riscv32 = \
>    (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>  
> +qtests_riscv64 = \
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> +
>  qos_test_ss = ss.source_set()
>  qos_test_ss.add(
>    'ac97-test.c',


