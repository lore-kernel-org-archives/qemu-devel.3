Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F74C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKqN-0005mk-F7; Mon, 03 Jun 2024 23:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKqL-0005mQ-EC; Mon, 03 Jun 2024 23:28:13 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKqJ-0003PC-T5; Mon, 03 Jun 2024 23:28:13 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48bf6ab0838so71182137.1; 
 Mon, 03 Jun 2024 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471690; x=1718076490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eWhS8DKF3OnrTIVAxEn22B6mjryzGk+OEnITUQjq1w=;
 b=Nw020TJdXD/eifI8EyDmKPEHj+1xpPLWqJ//PJnnn/D4/5MvTxALYSwDrx/x57pIUb
 B+6Yy2/ZiRm98OZjPcXsk+KPE1ksKN4ZNQcdxjvhQ33uNlP5/gV392CyOYZGjL8x9IP0
 f8MXu4UD/BQ1JjMrvnRTLvfhbynsYKqkT3oTwvzuzjo0Y3ecJuYhBDIub209YHFzWAfL
 rgiJ0FqHkLj16G5U+s2SpF/EfbzUVNMPM66ax+E/ClQpOeODjx0TWZrKMC3gSJrDz559
 BUMfTKIKRPq5vfKge38Z63n4EyQJvfYvh/YNRuIOkAusZYD8PyN2yO5Nkc4TCwcNQwNg
 raKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471690; x=1718076490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eWhS8DKF3OnrTIVAxEn22B6mjryzGk+OEnITUQjq1w=;
 b=tbIvw3f9oNmAsZRA+kx7Hj9CUPkcGna39PgNIl+45FkC2a9Bk73qzWdIVs5H0uFJr4
 0X5fNGp7etBI9zZ01d+xUk8SDCFrtC5AG8JSNnHwes9Ek0Sz7G8yBCzL9Z9oYK1r05TV
 fGEfIXjr33tf0LB7NkItwM5eTP26opONuWijg77djAp+MZWgetnN1E1qKAY+2W9/cZzs
 SFz7CwqczLdftYrJW09TUX82Z7H3AA1bkc94gbQWBiifaO9aqFDGXHtnwa3v7pEL173p
 f+VFlpqx7gm0QvoLKL3Uw/aOQmmzDDGxQ5BshInztjZ6QVuKYO8c9luGQZ8j1mnKZJpq
 +PeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwUT9v1QYmLLrS89Sls8CO9qDC44Bw6qk1rV029J7TS1w8RzvxMDLM67duAoJlsXJSXw44s+OPVCe160ajFuZiI9oiB9zdm3BQfdGPTa6cMprkLeIU1MeIo8U=
X-Gm-Message-State: AOJu0YxFDiv7sDgB8VA2sPEV2UFXYmP6nkAuAt5YhO94lyUP/lYm5Iqu
 hi8Y7d1ycjonNJsP47GfQ3VYVFzchG393tYjda3WwNZ7TD0cFeqzIoz+GiVYO+lG+sIEsZJwotq
 HuOgqVcGtpNrDhCJyOUnKwlmRlmo=
X-Google-Smtp-Source: AGHT+IE+gwQ9FFZBCdZvOMYLBEus+texlLhU70HGoWbtbMowFBYUgLJJveYmxQDhh8ivkZJaxNznVHlJ5Ed1TmkQiug=
X-Received: by 2002:a05:6102:12ca:b0:48b:c002:be5e with SMTP id
 ada2fe7eead31-48bc21b9c14mr10763123137.18.1717471690043; Mon, 03 Jun 2024
 20:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-12-sunilvl@ventanamicro.com>
In-Reply-To: <20240524061411.341599-12-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:27:44 +1000
Message-ID: <CAKmqyKPqwpuOhLvL7ZQOCcRpHmfzgumk+LmgAcAM7DSBe4ObAQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 24, 2024 at 4:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Add basic ACPI table test case for RISC-V.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index c73174ad00..880435a5fa 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1935,6 +1935,29 @@ static void test_acpi_microvm_acpi_erst(void)
>  }
>  #endif /* CONFIG_POSIX */
>
> +static void test_acpi_riscv64_virt_tcg(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .arch =3D "riscv64",
> +        .tcg_only =3D true,
> +        .uefi_fl1 =3D "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-riscv-vars.fd",
> +        .ram_start =3D 0x80000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    /*
> +     * RHCT will have ISA string encoded. To reduce the effort
> +     * of updating expected AML file for any new default ISA extension,
> +     * use the profile rva22s64.
> +     */
> +    test_acpi_one("-cpu rva22s64 -device virtio-blk-device,drive=3Dhd0 "
> +                  "-drive file=3Dtests/data/uefi-boot-images/bios-tables=
-test.riscv64.iso.qcow2,id=3Dhd0",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data =3D {
> @@ -2404,6 +2427,10 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_=
viot);
>              }
>          }
> +    } else if (strcmp(arch, "riscv64") =3D=3D 0) {
> +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> +            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> +        }
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
> --
> 2.40.1
>

