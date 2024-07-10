Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E6CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 00:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRLcC-0006k5-Ub; Tue, 09 Jul 2024 20:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRLcB-0006j4-QJ; Tue, 09 Jul 2024 20:55:23 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRLcA-00041Z-80; Tue, 09 Jul 2024 20:55:23 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48ff70394fbso1689527137.3; 
 Tue, 09 Jul 2024 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720572918; x=1721177718; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viKJMXEkM22cJ1W0Ufy93kvLIqXEPSQExDKRUS6qGlM=;
 b=GKbypbikKHvX3HP3bxchYWhaV1yMeVc8ZBkLXHF2ihhA/AVtTaJJ7MGIRZ/I/EONxe
 CTEfqCEEzgbsjxO8r3Y6IQkvWSOv0eK7GjsaY7ZUKUf+AQ/L+NnBokeuRs9Oh4ANHqK+
 lkTlm/m43A5HKGUUmaMYY9620Hx2bae8EzkkfKqynaUoxAOZd4jZpNXS71GyzxjMZeyI
 ywBEjLYYY7fbgx4Rc+6ZGNrsFuE24J5ojQFvYRLyhrfTWYylUpiczqv73mAuSxYy/1jT
 QukgXpxcQ11OYfznmv5KXXe0rpaYi163vrWeSCOpBrl7aEoVBD4T1xywMmjGqgvLMV0z
 7suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720572918; x=1721177718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viKJMXEkM22cJ1W0Ufy93kvLIqXEPSQExDKRUS6qGlM=;
 b=DxlbVqqe6HEhyLk5rUCFCMJlicSR3axrnm8tS18Rbl/dmqG7JRL0i1r3DwIyijDlBb
 DPCP0u52OAi6978/KfMZUXM0WSvDBJp34QHYBvdFKzV2iDzjWukHAYCU6lp2y2R1CPc+
 Axxlt7+bjvW5Ud2ZQiZcyykjWv52XWa0iI4iUqTUXR2i5H6R+pBB1paJrkM94aPp74FR
 2IoU4sqIdqT2Z7m7p8y19qMTfNuiuLJMiHwHTMYWqkTqbLUYWKIOm1l5wLXE+78zbfX6
 jAuQIUlOBAchJSqrnZui9uCiQ+05gF7BbiTAhtKuAO+HPcfjJnsSxv7R20WUh+m18Zkq
 BdcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXax1pXejhmi0CT0KuPeUocAQqut0fMWajEw+CuprQO9QKl57RyQXsN+UEE4xnUesAhh2R10z+RsI+oXSaHeyjm9r57bo=
X-Gm-Message-State: AOJu0YyMHAd73UlCC28c4RZbIJ7HWp7ED+Qj+zO/pqd4XRDGmS4aXMnm
 KHeJjiIkeX4v233wOvRUeAHPgrVunIQo6kOze8d48IIr3Oa0gxpyft5RXO2S5CM0gvnWCtGu4Me
 No4vC5PRA9xsJRSSd6A/g4wwiW8M=
X-Google-Smtp-Source: AGHT+IHUE1/Lv/210tA9gG2gOWjb6MHHiSirxwjob4a8emn1lYbWaypTgc/39I8+lT66h+wgS6keW0h49w04d029PxI=
X-Received: by 2002:a05:6102:38c8:b0:48f:eaf7:74e with SMTP id
 ada2fe7eead31-4903213a490mr4779352137.20.1720572918165; Tue, 09 Jul 2024
 17:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-7-sunilvl@ventanamicro.com>
In-Reply-To: <20240708114741.3499585-7-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 10:54:52 +1000
Message-ID: <CAKmqyKPZZydEoDg37OLTNkqeBAHhsoo1-PeWaHjoXQRGvawsCw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] tests/qtest/bios-tables-test.c: Remove the fall
 back path
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Mon, Jul 8, 2024 at 9:50=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> The expected ACPI AML files are moved now under ${arch}/{machine} path.
> Hence, there is no need to search in old path which didn't have ${arch}.
> Remove the code which searches for the expected AML files under old path
> as well.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index f4c4704bab..498e0e35d9 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -267,15 +267,6 @@ static void dump_aml_files(test_data *data, bool reb=
uild)
>                                         data->arch, data->machine,
>                                         sdt->aml, ext);
>
> -            /*
> -             * To keep test cases not failing before the DATA files are =
moved to
> -             * ${arch}/${machine} folder, add this check as well.
> -             */
> -            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> -                aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir,
> -                                           data->machine, sdt->aml, ext)=
;
> -            }
> -
>              if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>                  sdt->aml_len =3D=3D exp_sdt->aml_len &&
>                  !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> @@ -412,11 +403,6 @@ static GArray *load_expected_aml(test_data *data)
>  try_again:
>          aml_file =3D g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->=
arch,
>                                     data->machine, sdt->aml, ext);
> -        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> -            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data-=
>machine,
> -                                       sdt->aml, ext);
> -        }
> -
>          if (verbosity_level >=3D 2) {
>              fprintf(stderr, "Looking for expected file '%s'\n", aml_file=
);
>          }
> --
> 2.43.0
>
>

