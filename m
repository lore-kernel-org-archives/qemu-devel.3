Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC55C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hxf-0003Ft-KQ; Sun, 28 Apr 2024 23:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hxc-00039j-32; Sun, 28 Apr 2024 23:45:49 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hxa-0007T0-7m; Sun, 28 Apr 2024 23:45:47 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4daa8e14afbso1252627e0c.3; 
 Sun, 28 Apr 2024 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362337; x=1714967137; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e173JHTzTbq34c+/yRRVsXqp0hA+sPoH6ZmdTnPxTh8=;
 b=PXCGheZRyYyk3eNNOzjdHrJrA3AgSSrB5dZZYC54So3ghomTVlgF8/cjKZ4yLn7sco
 JzL3+qoJVpGAiPpd8cWHxqbEwCLqsmss/3Hi5F+XFWQo32jin/CN9fOp5qKpVnfJ3qej
 22yC4VbemFwx6LV6YOoucK6Yo79BNF1pvAIHC5VRYM2eiCSCYXzIXHEXoJU9pFIdP9fo
 8iK2HEUA/j6atQMgAnIUMtfD+QTdND2/sB4dYE07rILjiNL6bn6RJjO0zdwZVGV+NyMZ
 PfSmdqKOyejHSeifucdfUnC+tckTheHefXa6PQUIfvNoocRTrBRLmosjLFEdBHPxX5H5
 eRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362337; x=1714967137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e173JHTzTbq34c+/yRRVsXqp0hA+sPoH6ZmdTnPxTh8=;
 b=Uh8nvMMRdoxYF27rIwMC+wzFFJtePGzibjyAmKFtUjWwRpzrtLYLmrcLUXfQc8ExDZ
 c+LhSNrUXU/wvwDE6iioKRo2ZfpRQXNwgWkFpff2f+571kWWHaTVHuaPzeb4glQdWfst
 a1jkpD5QBRDxjeytJYRO290Hys4gqg28Kg856CElRdzOvqjM5JGZupzR9R7YScHeBHYV
 TV7DyxV/GaxSGmjJyOeMT0dsYUVp/VKg5hwbgOgRHxkwmA/eKaXZMkpSPtQzl+tFV4it
 pZh0yVUblVcKZhVV3qSqH/q9LRRXcZ8uX81R6jwGz4FCxSGOTzv+mmuHhqRpuS2A+IJi
 /R4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzDdNTDW3SVPnxIeNrfpvOsz1lARd1IPiy2Qb1hjnQJgvZCgcIoZ77uJXMzE/NpDjgEr3znqMoAfOi7WWDoV4jykIRdPwnPI/QRQSY1hzeDLwNhxH0Pc1NF5M=
X-Gm-Message-State: AOJu0Yx1RyEg2N4vuq3JOy2tBQTX4Y9kOUZKqAhwYZ1aK9y/3uQnGuoR
 efb7Rd4FM16ryLMq1d7/oMGx6y7f5rQGxJGzfya2r2CZ4qX+MYisX0CDeD8ZBd6w8vgZ0/Qklu6
 GKH2ThM7FtoDWPmTsDALSo12wORY=
X-Google-Smtp-Source: AGHT+IFZcTrcu1HQIGfm84wOQCEBQ/i1E3aSzRNvneAJOYMBks9IfQ2bIhPnh1Xf96zdbQi7JnETpTliBqULBwp7gPo=
X-Received: by 2002:a05:6122:2522:b0:4d8:7359:4c25 with SMTP id
 cl34-20020a056122252200b004d873594c25mr9992725vkb.12.1714362336984; Sun, 28
 Apr 2024 20:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-3-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-3-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:45:10 +1000
Message-ID: <CAKmqyKMLpve8jA4gbwiabEJLB_o3szS6t+ZsxqdA+LN8U0e16w@mail.gmail.com>
Subject: Re: [PATCH 05/12] qtest: bios-tables-test: Rename aarch64 tests with
 aarch64 in them
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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
> Existing AARCH64 virt test functions do not have AARCH64 in their name.
> To add RISC-V virt related test cases, better to rename existing
> functions to indicate they are ARM only.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 35 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index 21811a1ab5..ea3ba1992b 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1557,7 +1557,7 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>
> -static void test_acpi_virt_tcg_memhp(void)
> +static void test_acpi_aarch64_virt_tcg_memhp(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -1650,7 +1650,7 @@ static void test_acpi_microvm_ioapic2_tcg(void)
>      free_test_data(&data);
>  }
>
> -static void test_acpi_virt_tcg_numamem(void)
> +static void test_acpi_aarch64_virt_tcg_numamem(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -1672,7 +1672,7 @@ static void test_acpi_virt_tcg_numamem(void)
>
>  }
>
> -static void test_acpi_virt_tcg_pxb(void)
> +static void test_acpi_aarch64_virt_tcg_pxb(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -1745,7 +1745,7 @@ static void test_acpi_piix4_tcg_acpi_hmat(void)
>      test_acpi_tcg_acpi_hmat(MACHINE_PC);
>  }
>
> -static void test_acpi_virt_tcg_acpi_hmat(void)
> +static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -1901,7 +1901,7 @@ static void test_acpi_microvm_acpi_erst(void)
>  }
>  #endif /* CONFIG_POSIX */
>
> -static void test_acpi_virt_tcg(void)
> +static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -1920,7 +1920,7 @@ static void test_acpi_virt_tcg(void)
>      free_test_data(&data);
>  }
>
> -static void test_acpi_virt_tcg_topology(void)
> +static void test_acpi_aarch64_virt_tcg_topology(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -2003,7 +2003,7 @@ static void test_acpi_q35_cxl(void)
>  }
>  #endif /* CONFIG_POSIX */
>
> -static void test_acpi_virt_viot(void)
> +static void test_acpi_aarch64_virt_viot(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -2135,7 +2135,7 @@ static void test_acpi_microvm_oem_fields(void)
>      g_free(args);
>  }
>
> -static void test_acpi_virt_oem_fields(void)
> +static void test_acpi_aarch64_virt_oem_fields(void)
>  {
>      test_data data =3D {
>          .machine =3D "virt",
> @@ -2301,16 +2301,19 @@ int main(int argc, char *argv[])
>          }
>      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> -            qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> +            qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
>              qtest_add_func("acpi/virt/acpihmatvirt",
> -                            test_acpi_virt_tcg_acpi_hmat);
> -            qtest_add_func("acpi/virt/topology", test_acpi_virt_tcg_topo=
logy);
> -            qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numam=
em);
> -            qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
> -            qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
> -            qtest_add_func("acpi/virt/oem-fields", test_acpi_virt_oem_fi=
elds);
> +                           test_acpi_aarch64_virt_tcg_acpi_hmat);
> +            qtest_add_func("acpi/virt/topology",
> +                           test_acpi_aarch64_virt_tcg_topology);
> +            qtest_add_func("acpi/virt/numamem",
> +                           test_acpi_aarch64_virt_tcg_numamem);
> +            qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg=
_memhp);
> +            qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_p=
xb);
> +            qtest_add_func("acpi/virt/oem-fields",
> +                           test_acpi_aarch64_virt_oem_fields);
>              if (qtest_has_device("virtio-iommu-pci")) {
> -                qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
> +                qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_=
viot);
>              }
>          }
>      }
> --
> 2.40.1
>

