Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B075C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HzX-0004mp-TX; Sun, 28 Apr 2024 23:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HzS-0004mK-IQ; Sun, 28 Apr 2024 23:47:42 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HzQ-0007ZF-4m; Sun, 28 Apr 2024 23:47:42 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7ef2a623958so1376174241.1; 
 Sun, 28 Apr 2024 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362457; x=1714967257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCDroIUNU8CJI25Ill0ZrfqTx8dBu0KCDlaPw3C/2tQ=;
 b=cl8vlsUvZPL2yMLbyWVQoP/sf/pLV3TYuETJTchYYrSCTVcXxM/t0Odjm9Qs27TpiA
 dJQIC5UkercLhDj+4zQIFQUmKB1J1dVIAp/76P2V6BBrBc4wSEx7keDWlnmG7g1MG6Fn
 YwJe4SRXwmlt+2f6n2LcgZdmVPypMuD+wsZW6S3pXvoW/dWZK4Uq7+iyfF2ggPNguLP3
 6V67+DgdcQa+gC2h1tYu+arbfD+as1oKL849gIvJNA+7jsaF8pdjZKWOAkn3e+5VbEb4
 swZ6Ed2ZevYu7LCiUrcVKJjviwbLNi+Vna8R8rsy1RPinXj/JqXfCqAZ/o+pyb0pKYBA
 6Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362457; x=1714967257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCDroIUNU8CJI25Ill0ZrfqTx8dBu0KCDlaPw3C/2tQ=;
 b=OmpMOw98f08ry7lbM7W+owptPB/DH57ayvU9Twnr0YZK86hiM+twGe1GarSHzJSKFE
 wYUgDaOhjjW9OArFuizJI9jxBpkEjAWE4C0xdhQQXaJOmt0PtTAIWV36PBfYpdViZkq5
 rI2D0zbFoOUnFZgyDP5muQj9/mJC5ssjT08SPI4RqEstnsk5UpXwWBNLN0T4qlj26Qas
 AWBjGPBzK0bAWhCehiAwybBUAULsvHih2+vXawh7r2GLYWHNyaWXYg7G/zFbrwqfJAuL
 QQdR2PbumiGft5vm/1orIcoQV/12tZLOZz/XSRcBqmlu1cjXoqiF18S0yFQZM4IuT7uh
 y4SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY3cHqzJ0SIQU2bpIoxj6PHN0tJ1/LqsI/2YcHVsrft3su9ikX++OPcu98kNtNVbkZEVueDT0qlZSGOAByk3ECarspuRbwKqVP4zsBfvph/wy+b/JbjuuSd0g=
X-Gm-Message-State: AOJu0YxyWzPbBuvr1iFFKWNZnMsg48POqzvbZNJ/h9BrtaYm7akc1PhP
 ctF/Zbb5pNAJMMaBMU0sYErY6nFcy0gLkjtZbFAImLixh7XJabcKXRg57QGRMaRpy100m7fWKUU
 PesxeZDs1ghJAd5VmDRs0mhcprrY=
X-Google-Smtp-Source: AGHT+IFHLdTnqfNsDtyI0G1dDcMb994Oz2p79agdcbtJGvbqjChDL4SZ6/J1HgUt2yC4DDSjNlTWpplV6p1q9bwZl9Q=
X-Received: by 2002:a67:ff15:0:b0:47c:37e2:b868 with SMTP id
 v21-20020a67ff15000000b0047c37e2b868mr4077495vsp.35.1714362455555; Sun, 28
 Apr 2024 20:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-4-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-4-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:47:09 +1000
Message-ID: <CAKmqyKNR6hqO7heHgMSmwSE_038CCbKgKVPmjgtjF1=q6OdwGg@mail.gmail.com>
Subject: Re: [PATCH 06/12] tests/qtest/bios-tables-test.c: Add support for
 arch in path
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Fri, Mar 15, 2024 at 11:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> Since virt machine is common for multiple architectures, add "arch" in
> the path to search expected AML files. Since the AML files are still
> under old path, support both by searching with and without arch in the
> path.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index ea3ba1992b..c492438ced 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -78,6 +78,7 @@
>  typedef struct {
>      bool tcg_only;
>      const char *machine;
> +    const char *arch;
>      const char *machine_param;
>      const char *variant;
>      const char *uefi_fl1;
> @@ -262,8 +263,20 @@ static void dump_aml_files(test_data *data, bool reb=
uild)
>          g_assert(exp_sdt->aml);
>
>          if (rebuild) {
> -            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data-=
>machine,
> +            aml_file =3D g_strdup_printf("%s/%s/%s/%.4s%s", data_dir,
> +                                       data->machine, data->arch,
>                                         sdt->aml, ext);
> +
> +            /*
> +             * To keep test cases not failing when the DATA files are mo=
ved to
> +             * ARCH under virt folder, add this check which can be remov=
ed once
> +             * the DATA files are moved.
> +             */
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +                aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, d=
ata->machine,
> +                                           sdt->aml, ext);
> +            }
> +
>              if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>                  sdt->aml_len =3D=3D exp_sdt->aml_len &&
>                  !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> @@ -398,8 +411,13 @@ static GArray *load_expected_aml(test_data *data)
>          memset(&exp_sdt, 0, sizeof(exp_sdt));
>
>  try_again:
> -        aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->mac=
hine,
> -                                   sdt->aml, ext);
> +        aml_file =3D g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->=
machine,
> +                                   data->arch, sdt->aml, ext);
> +        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data-=
>machine,
> +                                       sdt->aml, ext);
> +        }
> +            exp_sdt.aml_file =3D aml_file;
>          if (verbosity_level >=3D 2) {
>              fprintf(stderr, "Looking for expected file '%s'\n", aml_file=
);
>          }
> @@ -1561,6 +1579,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -1654,6 +1673,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void=
)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -1676,6 +1696,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -1749,6 +1770,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(vo=
id)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -1905,6 +1927,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -1924,6 +1947,7 @@ static void test_acpi_aarch64_virt_tcg_topology(voi=
d)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .variant =3D ".topology",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> @@ -2007,6 +2031,7 @@ static void test_acpi_aarch64_virt_viot(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> @@ -2139,6 +2164,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> +        .arch =3D "aarch64",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> --
> 2.40.1
>

