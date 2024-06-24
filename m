Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D809C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 06:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcnr-000866-Qm; Mon, 24 Jun 2024 02:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sLcnq-00085n-98; Mon, 24 Jun 2024 02:03:46 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sLcno-00015s-5C; Mon, 24 Jun 2024 02:03:46 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4ef765e6dcaso169514e0c.1; 
 Sun, 23 Jun 2024 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719209022; x=1719813822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRjjzrwoopXOsYzu6jLr+pwyQKTmPnQYozm0u0J2YTM=;
 b=iX0XJY3yCz4WndDZOsOz17Qub6BdUbHOo1Ye7EZXvIb25rUXypsA44I02mbh+uUcKz
 m68tofezDOgNwCJ3pf61Zgc/vodspvqEn41TBKIIO/cgQz8NcMRCIW+noDivUWquHaij
 8wA42ry40JJH4eGy+hkwRoyNskrg7xOEXfLGuqLPMjoZ2o0g0a0hKTP2iiowCBnEAcl6
 OxUaDS7kf5dPYGUNP2Fx8UuiJkMiMSOg5VIaz2DA6GLWfb6I3dRbvJS3oqmo9vCUfVyV
 BE9B28nhC4eSBfhmzvwuo7Eq6Z8+ClggWlvEgTyCaYTInQxtza0LudScRl1BXw6v46Qa
 3yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719209022; x=1719813822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRjjzrwoopXOsYzu6jLr+pwyQKTmPnQYozm0u0J2YTM=;
 b=nI8rlvFO3diSBN+DCq7CsmcGy3TgiJZtxwDCtA3N8B7fMlzA8cWspI+YfW9qpVtwYh
 hW1CK07QtyNVl+GH8/FL0c2zyRb189qVgw+K75eMiemIIYc3SDgxaFj5zxgKHFLOOHvq
 TjSxZ15Ok0V1FyAgHdfa7Sxd+eb3KdMYz+LPJfnW3SnrmZxs5zmAgwaG/UuwV3MLwiU9
 qanVByjDKPN4XGDLUcz9/+pe5PlvLm1oTCy7OtuFphTe9/x7PvTgmyuU/p8eLamnNYQc
 7/6T0RjZU7KKYgL1Z/UmtZxaknnLCTAZ52UYueJt1uEQ831qUiM8a/WXtRSvLsGm5Svi
 xLsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjh9acmVXEx6QDaNYt7Km3YiAfI1sv4Oa2D5DYdxCv/GiE4dkKiaaBWVS7MAk/HVmjThRG2SMD+0BTcIUJPq6I4PD/TUXPQ6sqnsO44DIhar3FaEEV45u+xHw=
X-Gm-Message-State: AOJu0YyENnPUq4+aSI8gesmyachO7pP8k1U4UBfLjj2bxJXbdBqHV6VE
 q99K6Y3aE1BYFYjrrRdDlPebKxPpHxmlBSFCnbAGYz0tV0dhrAvmJ4kY+G5dHb4KAWVr6TbgD8Z
 MV81+9nGKHWwM7LFm30BvO8abKjg=
X-Google-Smtp-Source: AGHT+IEcWsqd89DLCmWK0tK7I6cDExskcfvlt5EnUjJAuJgXABnuiug2pvWsnT04x9/vig2PEScH26loBO2Cem3yF/c=
X-Received: by 2002:a05:6122:1790:b0:4ef:6865:8ffd with SMTP id
 71dfb90a1353d-4ef6a73802bmr1655165e0c.10.1719209022128; Sun, 23 Jun 2024
 23:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-6-sunilvl@ventanamicro.com>
In-Reply-To: <20240621115906.1049832-6-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jun 2024 16:03:15 +1000
Message-ID: <CAKmqyKOXXRtu3U4xPp57_4qoCAx07Q3o50oEVHKPgZ=0EjAoXg@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] tests/qtest/bios-tables-test.c: Add support for
 arch in path
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
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, Jun 21, 2024 at 9:59=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Since machine name can be common for multiple architectures (ex: virt),
> add "arch" in the path to search for expected AML files. Since the AML
> files are still under old path, add support for searching with and
> without arch in the path.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index c4a4d1c7bf..29c52952f4 100644
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
> @@ -262,8 +263,19 @@ static void dump_aml_files(test_data *data, bool reb=
uild)
>          g_assert(exp_sdt->aml);
>
>          if (rebuild) {
> -            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data-=
>machine,
> +            aml_file =3D g_strdup_printf("%s/%s/%s/%.4s%s", data_dir,
> +                                       data->arch, data->machine,
>                                         sdt->aml, ext);
> +
> +            /*
> +             * To keep test cases not failing before the DATA files are =
moved to
> +             * ${arch}/${machine} folder, add this check as well.
> +             */
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +                aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir,
> +                                           data->machine, sdt->aml, ext)=
;
> +            }
> +
>              if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>                  sdt->aml_len =3D=3D exp_sdt->aml_len &&
>                  !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> @@ -398,8 +410,13 @@ static GArray *load_expected_aml(test_data *data)
>          memset(&exp_sdt, 0, sizeof(exp_sdt));
>
>  try_again:
> -        aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data->mac=
hine,
> -                                   sdt->aml, ext);
> +        aml_file =3D g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->=
arch,
> +                                   data->machine, sdt->aml, ext);
> +        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
> +            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, data-=
>machine,
> +                                       sdt->aml, ext);
> +        }
> +
>          if (verbosity_level >=3D 2) {
>              fprintf(stderr, "Looking for expected file '%s'\n", aml_file=
);
>          }
> --
> 2.40.1
>

