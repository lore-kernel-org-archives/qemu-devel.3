Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B027C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 05:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrHc-0001VR-Nw; Thu, 25 Jul 2024 01:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWrHa-0001Qt-N9; Thu, 25 Jul 2024 01:44:54 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWrHZ-0002UX-1R; Thu, 25 Jul 2024 01:44:54 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-824ae03efbfso112953241.3; 
 Wed, 24 Jul 2024 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721886291; x=1722491091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSgHSXqHWOY5LCFI9i3cLpY9SQ75BCmkY93ynPWmb5k=;
 b=AyZmm1KfwhqfVcnY886Z8iKDu68zkZiT8uHW15WHl30zDsSwWSG8FVciwyo0fNoVjB
 m6xx2wQOA4PQBV+veOKzp5ZDiPojWrbydIS5sMv1LRk/Jmapkye02PnujFeDJ3V9RNZu
 nQspocYsTq6WARhOOZKuFiGxt2BkGxqcS1RzO2LxeiQ1BAb9maMRR6sho3K50+9P8cCG
 oAZg+iJxiJFTwBIGASOQs18AlmLzA88r0lj8rWBdPo4uHi7u9Elsdtnodn6nPSXJ0APq
 bRwrBL5WiR1Gr8VqvNLBbPOKLmTuFXUN55DBghngZTqLiYdjfAYnRhltgfzGVl+7B5DM
 jehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721886291; x=1722491091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSgHSXqHWOY5LCFI9i3cLpY9SQ75BCmkY93ynPWmb5k=;
 b=Kb+6pNQMutmytp7t39hiC/6U7ZSeYiO7Pvkn6nklucuPzduE557wMp3O9zjCI4T6fK
 WEsAXKxqceg/WMxJ8+er0S56CB09Kmw/nXxOBu5DwLK0UmY+JsoXUWeb5s3WUyiJ5smJ
 INJsoyuwMDwwAu7787D24RSEHpdGb/4PFoKnZkDROoesjNEEB58XSPNmLdq2og5MkrAX
 dou362hiq1fzNc+G/99/g8flMHlodrxYuW1QdPKtAY4qNU1DH9oJNhq7YWIPi6JsYmCz
 NE6KDTZRkFSS6j/2TQaBE9O0UXoaEfWHA244njaDELL9PGu6mU2xZsuLlqJTTHxVM2Oh
 Uf2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJR6Azk+oP8iJGKIyugkaRqlH5pBUYZpFZwVwCf2Wk+VzdTLSbqiKG7b8i1/kgZP9k2SIHfxEBFf8bDYgzTONFIpJpoiaCDN5vyvbRlw9J+x57H8ImPezbcbY=
X-Gm-Message-State: AOJu0YxtU54zb2CSPehRnt4ZbKPxfY1d0RMU/i8vS2NTz1+DBjNNa0Fp
 oDeUkrYl9qt0v9IeHQ65u36FvtYLxeZkzp4LenZTTDbk7kKbR3Jtg5IzcX2NDuGPrV8MTFPgOQU
 QApK1enJvIITE9m0f0bDvSZULMQjSE3Ln6fQ=
X-Google-Smtp-Source: AGHT+IGJc0nVutNOErhgDlU/C0IxCJrQlisHmOKYSsRLSCPQyQZU6s+sza8N1z7q5Yi6X6R7bI55UCYg7vZgafwL4sI=
X-Received: by 2002:a05:6102:1494:b0:492:9c32:5344 with SMTP id
 ada2fe7eead31-493d9b05940mr1351735137.18.1721886291490; Wed, 24 Jul 2024
 22:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-16-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-16-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jul 2024 15:44:25 +1000
Message-ID: <CAKmqyKPpfMdJfFwT1a38a8s_sNPJ7dBu9u_JQMR6khFRf_RJ9A@mail.gmail.com>
Subject: Re: [PATCH v2 15/23] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Thu, Jul 25, 2024 at 3:56=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> The avocado test defined test functions for both, riscv32 and riscv64.
> Since we can run the whole file with multiple targets in the new
> framework, we can now consolidate the functions so we have to only
> define one function per machine now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/avocado/riscv_opensbi.py         | 63 --------------------------
>  tests/functional/meson.build           |  8 ++++
>  tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
>  3 files changed, 44 insertions(+), 63 deletions(-)
>  delete mode 100644 tests/avocado/riscv_opensbi.py
>  create mode 100755 tests/functional/test_riscv_opensbi.py
>
> diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi=
.py
> deleted file mode 100644
> index bfff9cc3c3..0000000000
> --- a/tests/avocado/riscv_opensbi.py
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -# OpenSBI boot test for RISC-V machines
> -#
> -# Copyright (c) 2022, Ventana Micro
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2 or
> -# later.  See the COPYING file in the top-level directory.
> -
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> -
> -class RiscvOpenSBI(QemuSystemTest):
> -    """
> -    :avocado: tags=3Daccel:tcg
> -    """
> -    timeout =3D 5
> -
> -    def boot_opensbi(self):
> -        self.vm.set_console()
> -        self.vm.launch()
> -        wait_for_console_pattern(self, 'Platform Name')
> -        wait_for_console_pattern(self, 'Boot HART MEDELEG')
> -
> -    def test_riscv32_spike(self):
> -        """
> -        :avocado: tags=3Darch:riscv32
> -        :avocado: tags=3Dmachine:spike
> -        """
> -        self.boot_opensbi()
> -
> -    def test_riscv64_spike(self):
> -        """
> -        :avocado: tags=3Darch:riscv64
> -        :avocado: tags=3Dmachine:spike
> -        """
> -        self.boot_opensbi()
> -
> -    def test_riscv32_sifive_u(self):
> -        """
> -        :avocado: tags=3Darch:riscv32
> -        :avocado: tags=3Dmachine:sifive_u
> -        """
> -        self.boot_opensbi()
> -
> -    def test_riscv64_sifive_u(self):
> -        """
> -        :avocado: tags=3Darch:riscv64
> -        :avocado: tags=3Dmachine:sifive_u
> -        """
> -        self.boot_opensbi()
> -
> -    def test_riscv32_virt(self):
> -        """
> -        :avocado: tags=3Darch:riscv32
> -        :avocado: tags=3Dmachine:virt
> -        """
> -        self.boot_opensbi()
> -
> -    def test_riscv64_virt(self):
> -        """
> -        :avocado: tags=3Darch:riscv64
> -        :avocado: tags=3Dmachine:virt
> -        """
> -        self.boot_opensbi()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index a2c0398b03..ebc6e2d1c6 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -55,6 +55,14 @@ tests_ppc_thorough =3D [
>    'ppc_bamboo',
>  ]
>
> +tests_riscv32_quick =3D [
> +  'riscv_opensbi',
> +]
> +
> +tests_riscv64_quick =3D [
> +  'riscv_opensbi',
> +]
> +
>  tests_s390x_thorough =3D [
>    's390x_ccw_virtio',
>    's390x_topology',
> diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/te=
st_riscv_opensbi.py
> new file mode 100755
> index 0000000000..d077e40f42
> --- /dev/null
> +++ b/tests/functional/test_riscv_opensbi.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +#
> +# OpenSBI boot test for RISC-V machines
> +#
> +# Copyright (c) 2022, Ventana Micro
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import wait_for_console_pattern
> +
> +class RiscvOpenSBI(QemuSystemTest):
> +
> +    timeout =3D 5
> +
> +    def boot_opensbi(self):
> +        self.vm.set_console()
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Platform Name')
> +        wait_for_console_pattern(self, 'Boot HART MEDELEG')
> +
> +    def test_riscv_spike(self):
> +        self.set_machine('spike')
> +        self.boot_opensbi()
> +
> +    def test_riscv_sifive_u(self):
> +        self.set_machine('sifive_u')
> +        self.boot_opensbi()
> +
> +    def test_riscv_virt(self):
> +        self.set_machine('virt')
> +        self.boot_opensbi()
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()
> --
> 2.45.2
>
>

