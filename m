Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823EAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3jH-0004k5-Jb; Tue, 25 Jun 2024 06:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3jF-0004gr-Tj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3jE-000611-BA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719312527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDJ1rFuPBohvm8zo550ZMj/KcvQ/XnmLnyAbPdrOw8g=;
 b=HGzSvWjeXwDLFovAug6uXPjn8Omc4RjRvMGHdo4lB8lUnWq8X0VlrfJIoL9rA/S74AUFct
 ffkfENcl/B6mPX4IUpTXM0u1GnvKvU0ebywh5meYphwZBHEMonR4eMXtNBZrI5AT7ZYKp2
 EG+LgwamTzFRRq+27WM6cA9nYuUr0j4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-KTF-jZwKP0Ke7sRVvO6v2Q-1; Tue, 25 Jun 2024 06:48:45 -0400
X-MC-Unique: KTF-jZwKP0Ke7sRVvO6v2Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ce04ea31cso1952483e87.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 03:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719312524; x=1719917324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDJ1rFuPBohvm8zo550ZMj/KcvQ/XnmLnyAbPdrOw8g=;
 b=dy3+ih6EoByW1OxL3uNyUoXz3cC4MFxwgusPiKsqE+9hZRBIGfuxZvmKllBLfjdNbC
 OTu6XJSN/TKb1oSg6i/gQT0rQM6ruVyTCZLgu0iO/tPba2RTDShWBGidlTDQtMtEupgG
 z/f9OFbcwVDyArClaFBtRDPBaSe+wPS/bzMKhpkjrGDs6kOkSVfFbsQPdAe/jqoEHx+J
 FGylKuoMmEfXZLSPkywy07wZZBOU6WXtMCbG8ZUFqUs5RTzoIKyLrLijRTlsCV6lT2bG
 s/S79DZqxkX7r6Sc0tEj7UMv22upHhOj7gjNfXNth0SqEEbQ2QfwWRII9AvwV2uIQwyN
 GQwg==
X-Gm-Message-State: AOJu0YzYGMNYQSc+cLsvjEz9VIy3/6R2acThT1xMJEMRRK2nX4c8GXqd
 7+K7pY1TNDzST2kvdNfH8HaRGUnza39PqmKk4fkDNSJpw3ETWw9j5SBvvQMAJDQbdIj3hmKZ5kl
 EWEC6tyinmJ4PFMz6vwo19fDkV64cTklRk8P3Irch4QBcNOxqK2xf
X-Received: by 2002:ac2:4c91:0:b0:52c:ce28:82b0 with SMTP id
 2adb3069b0e04-52cdf7e6706mr4284766e87.14.1719312524458; 
 Tue, 25 Jun 2024 03:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGowgV9MxyKqh168ejgm4GaFM9C12R2ioSkD3J9W7UCTCDYWlZLYE1dC/Q5ggFAY79IhZwLHw==
X-Received: by 2002:ac2:4c91:0:b0:52c:ce28:82b0 with SMTP id
 2adb3069b0e04-52cdf7e6706mr4284754e87.14.1719312524093; 
 Tue, 25 Jun 2024 03:48:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481922774sm172814475e9.47.2024.06.25.03.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 03:48:43 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:48:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 06/15] tests/qtest/bios-tables-test.c: Set "arch" for
 aarch64 tests
Message-ID: <20240625124842.709ecc97@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240621115906.1049832-7-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-7-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Fri, 21 Jun 2024 17:28:57 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> To search for expected AML files under ${arch}/${machine} path, set this
> field for AARCH64 related test cases.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 29c52952f4..007c281c9a 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1591,6 +1591,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -1684,6 +1685,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -1706,6 +1708,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -1779,6 +1782,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -1935,6 +1939,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -1954,6 +1959,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .variant = ".topology",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> @@ -2037,6 +2043,7 @@ static void test_acpi_aarch64_virt_viot(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> @@ -2213,6 +2220,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
>  {
>      test_data data = {
>          .machine = "virt",
> +        .arch = "aarch64",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",


