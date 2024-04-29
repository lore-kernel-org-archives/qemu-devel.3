Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I1f-00074i-5U; Sun, 28 Apr 2024 23:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I1a-00073a-Od; Sun, 28 Apr 2024 23:49:55 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I1Z-0007m2-66; Sun, 28 Apr 2024 23:49:54 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f0470a1f28so563117241.1; 
 Sun, 28 Apr 2024 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362590; x=1714967390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmyr5DLNiclxmZAPsPe/K+sYnytsBiLMgBIEcvdIp9c=;
 b=NuIHdD1uyJayDNyjapopt3dA+TKZB7e9jM7k0UjOsXEIqBhhdM988Wah5IZYwKOjGm
 aUYCII3/vwnzDf+GWe3EFiOUc3yamIN12kNMdPwMg6lu3VHe+Q60nlkRuCLtdSWbY+PI
 /jO4OucemHLAY0Nm1dmbYBQbAomOhBmiWbxynaN0kxIYFrCq2L9BFsVHpevPzQecXVi1
 dULtpo21y4qcjixPLR6pU/l+udGiGGBPCs3m/t3nCWo+bZqgXhk4io9lEKCH++p2E4Ju
 5ZHUud3YdHw+K15YHTSZLH3Oxr4IG1Cj4YaBPCaKsaCP8FfviFQwjXLm+kj5xlqVysOD
 uxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362590; x=1714967390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmyr5DLNiclxmZAPsPe/K+sYnytsBiLMgBIEcvdIp9c=;
 b=Ku+2W/aoOOmqPS6SxcH9bHHcP0kIv+ygUs/8+PYBXnCN4bKa9CY5aGqA9MkGGUL+NU
 zLjQO7+Rzcu0I9yJlhbWxcGs34tCDu0O3GUNXphO6WfNExnHUZUbLDxW2FkJzfM40Sau
 oitDGc4JiIOl3JkZej2fkMpgdCxviSH+ceyRmSjYBS1v44H/blN1Nqz4WfQRR7RsA6Ph
 J1qZshih9JkbOrMC41vIG1lqmCiGhw2PKtP4xUxzSDcr5nYw7ryyb1ZZ+VoRKKaHVRMg
 UA4p3M41nrNB4kUxmZevqb0Bk9whoT/mhMANRHOZw8b6MbB9uqI4O+/UpGTabxGYSoow
 5aRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw1+oScdG+9l1lPr7rvtHH0HoQRSFl4IftFOKi1Tv09Pu3xvBJ16cYdcOjHK6oVOFSTxP/bhlcqBKILnIBP7PaWmW2k9afkHipb+bLk1QwrABgnQcStjxBd00=
X-Gm-Message-State: AOJu0YxEJznBZsQvKpKBHod3IddFFM5q8M5LEu/tOCmH6YhizzHmuiO+
 FAFO9VG3r2jmNYOUu2fcJWtuI5t2HnPSRqQOoFBW+POyQ2m+RL3o78vTRVoqFyG2Gucb6d0WbDJ
 iFW5e6TBCqFV0tmp+wgwohBkzmE8=
X-Google-Smtp-Source: AGHT+IG0JwcSzX8Y87nNZbopdDr74AAghTBQBoHeSIxlG8HsD0XQ0IvUmLLTTPvKRnLdC+liJyFyn9s51TiwBYiBtI4=
X-Received: by 2002:a05:6102:3a72:b0:47a:42e6:ba69 with SMTP id
 bf18-20020a0561023a7200b0047a42e6ba69mr10860086vsb.27.1714362590325; Sun, 28
 Apr 2024 20:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-7-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-7-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:49:24 +1000
Message-ID: <CAKmqyKNAZxN3AfXP1BycBbt6dvE_QVDExFXWhUwF+HpAYs7q_g@mail.gmail.com>
Subject: Re: [PATCH 09/12] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 11:10=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> Update list of images supported in unpack_edk2_blobs to enable RISC-V
> ACPI table testing.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> index 36c5c13a7b..dd19711d9f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -252,6 +252,9 @@ qtests_s390x =3D \
>  qtests_riscv32 =3D \
>    (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-wa=
tchdog-test'] : [])
>
> +qtests_riscv64 =3D \
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> +
>  qos_test_ss =3D ss.source_set()
>  qos_test_ss.add(
>    'ac97-test.c',
> --
> 2.40.1
>

