Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0230AC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnPD-0000yS-99; Tue, 02 Jul 2024 19:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnP7-0000xE-2R; Tue, 02 Jul 2024 19:59:21 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnP5-0007gG-Gx; Tue, 02 Jul 2024 19:59:20 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-48fddbb579dso52402137.3; 
 Tue, 02 Jul 2024 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719964758; x=1720569558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc2aEDgOgEzXvSmnVveht//k4/07WbMFwG5D6w4BLPo=;
 b=X2GSdn8neNabLrWSVtaQpfiwRQaQcIe/u//VpDBReYkKE92JTjg9mA4mjv0cG7xzPL
 ffsKpPg1lVBjcJ5gjFiyzrA7CUDVuZTP4l2gHkD+FUCj/1Cuhco/Oq+oHExLItCWEweu
 GHVs1qGsS2p45YWh5xWM5EvjIbLgOST4RGrUWbRxQD0Ov032Qjj0J4DEKpDYosGbxj7E
 /SA4upNtnzMRlfk0sFlfa6dcNpp6Dy7rlUED8rhxHVLD6Hdrc0F9lpISMdIxVwmbLTUb
 jNJV8JOdSBoXybKiuvIuP2GV1h7NbcbU2Nayq1pv9knvEHstN2XzelPXpcMCgx4h1BTl
 ZIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964758; x=1720569558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xc2aEDgOgEzXvSmnVveht//k4/07WbMFwG5D6w4BLPo=;
 b=AlBgwDCpr0CA2dYAae1oczZ5XpquWSfnepPTfJ+xIVTfWff/e4i2gma+mmJ6qQMSa3
 dyIiga3nKcXXMYIebSpI17HEzKYssClXlKTgTjFyKLtn1AgHsPA0c8LQm9IokFtmZwoy
 moaPR7reDwimoBmziSaCCYEviA5iokHJPDukNOST9Wi9s3eCBfbob+GZxaqWDtFnDexa
 yJqS9YiazfhsILhR4xC8VKRqAKYz6xHcleMlzaXxN3Wt+O9FsbpN49hSaOYHE7aZSEup
 XYVjyxplFQHpOcA9Og5aC6SDwwBZJdJjqH2UEvBbGNC2uC82qVOagOaJwWgLYNZ3GlKE
 A6kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEvxXqvqsoBWbPJlRR5kALnUSwHvQePSzOyKKw7PoZQb9X9PWr6EZvQczBb4HETS9xEHxzpl5a3/dDI/rxMV71cNMyClA=
X-Gm-Message-State: AOJu0YzMt7pwibPMS7kPq4E+n2xI6PEYH/aI6OhXaAh515dErHZBrZ0i
 ZVzVC3kvFaQE81yLzo5AfnC3YF+OeDPTNo9FXx/YKcovssGJgmYqxjWxit/2cKDoZyPO5ZIUVzN
 YdS/Qvfesnos8wIyS6gfOZ+TGXkA=
X-Google-Smtp-Source: AGHT+IEmAiPpRRasPJprEYmrM1o132AlePwbOI6dJLPEye4u7rOiiQfrnm+tDCp37nttAo+KsOlk8NpW491tPlA4x5U=
X-Received: by 2002:a05:6102:241c:b0:48d:706f:a884 with SMTP id
 ada2fe7eead31-48faf0aa2c2mr9970406137.20.1719964758086; Tue, 02 Jul 2024
 16:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-4-richard.henderson@linaro.org>
In-Reply-To: <20240627180350.128575-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 09:58:52 +1000
Message-ID: <CAKmqyKM28=qGsXTS-50hOkL-o=X0gGHbh7YKDkzeztPy+Mk=Pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, brad@comstyle.com, Alistair.Francis@wdc.com, 
 palmer@dabbelt.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Fri, Jun 28, 2024 at 4:06=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With recent linux kernels, there is a syscall to probe for various
> ISA extensions.  These bits were phased in over several kernel
> releases, so we still require checks for symbol availability.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  meson.build          |  6 ++++++
>  util/cpuinfo-riscv.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 97e00d6f59..58afd0125d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2837,6 +2837,12 @@ have_cpuid_h =3D cc.links('''
>    }''')
>  config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
>
> +# Don't bother to advertise asm/hwprobe.h for old versions that do
> +# not contain RISCV_HWPROBE_EXT_ZBA.
> +config_host_data.set('CONFIG_ASM_HWPROBE_H',
> +                     cc.has_header_symbol('asm/hwprobe.h',
> +                                          'RISCV_HWPROBE_EXT_ZBA'))
> +
>  config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>    .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot e=
nable AVX2') \
>    .require(cc.links('''
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index abf799794f..cf59ce83a3 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -6,6 +6,11 @@
>  #include "qemu/osdep.h"
>  #include "host/cpuinfo.h"
>
> +#ifdef CONFIG_ASM_HWPROBE_H
> +#include <asm/hwprobe.h>
> +#include <sys/syscall.h>
> +#endif
> +
>  unsigned cpuinfo;
>  static volatile sig_atomic_t got_sigill;
>
> @@ -47,6 +52,27 @@ unsigned __attribute__((constructor)) cpuinfo_init(voi=
d)
>  #endif
>      left &=3D ~info;
>
> +#ifdef CONFIG_ASM_HWPROBE_H
> +    if (left) {
> +        /*
> +         * TODO: glibc 2.40 will introduce <sys/hwprobe.h>, which
> +         * provides __riscv_hwprobe and __riscv_hwprobe_one,
> +         * which is a slightly cleaner interface.
> +         */
> +        struct riscv_hwprobe pair =3D { .key =3D RISCV_HWPROBE_KEY_IMA_E=
XT_0 };
> +        if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) =3D=3D 0
> +            && pair.key >=3D 0) {
> +            info |=3D pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA :=
 0;
> +            info |=3D pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB :=
 0;
> +            left &=3D ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +#ifdef RISCV_HWPROBE_EXT_ZICOND
> +            info |=3D pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZI=
COND : 0;
> +            left &=3D ~CPUINFO_ZICOND;
> +#endif
> +        }
> +    }
> +#endif /* CONFIG_ASM_HWPROBE_H */
> +
>      if (left) {
>          struct sigaction sa_old, sa_new;
>
> --
> 2.34.1
>
>

