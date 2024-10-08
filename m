Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FE8CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 00:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyQj-0007Lb-W8; Mon, 07 Oct 2024 20:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyQe-0007Hg-Fb; Mon, 07 Oct 2024 20:50:21 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyQc-0005eF-Vy; Mon, 07 Oct 2024 20:50:20 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-50ac0c8cd48so1479047e0c.1; 
 Mon, 07 Oct 2024 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728348617; x=1728953417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aOAazVGZzuUQuCoiM6TIgT8pILzareCk0Lqih6zbHM=;
 b=QdovmfLdMxYP8Bm5ey6gL6WmobNBnNVQwfOvgJhWmyQnexm0q/4eeUfO6xAGkRsATa
 KlY/EFTla0AEUqUk7LRbiOLaSqchAkS7kiZueauU2okkJmnBiRCaed5SHFgOYHONEOgI
 uCkiu+kl8esLToctWiOnrWi7DFLOVFswUg1m+uITr27Dur6unjsOBzCIejaH90PjAmg9
 VJjSftULKrfhhUhMlOeaO+9j0PGT8YM+4A4pKHDvEhWIrf/pG4K9LaspkFuZrOwdz6pn
 XxHrtxNUV0BZI/OzXVcAg4iHX1Mjzn7gfLS4SYkWkRmA8WmIm1mjhAi7+P6f3gVmNg61
 Nhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728348617; x=1728953417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aOAazVGZzuUQuCoiM6TIgT8pILzareCk0Lqih6zbHM=;
 b=iKvQ5vX05SuC5dJ2W+Fwao3rrly9OlpDnoyZnPn8wZK8bM2Fdynb+wzpUSsVlhVhlR
 KT59kP7Fparo9xqwnx8PGlb/lPr48TXR9l1EZvR/9Y1gdtopBeAdYaUvduYONX1Qlz/J
 eUzjRmX5rMs7+qvE+b71ZymdPEcrBVxVJ95kx6NymGWglBQFqANGZQ42u6uK1IKYtc0s
 tJBdK+5a89KpZ9JZ1A9W36oZsAsG1VY8x+sXkf9kOc6P09X0mHe5vDif02+xpxx0aLak
 LEXO71WkJKDW7+QhkRA3U+IJxI7Lh9LaeaaHwEeM7DtKhfK3GDeDVmGGg85W0+bdkCGd
 1l/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQoSoItYnWCdLKTBd43J9JrkNJIO/lqR6Ork2YVaprvh8Rhx5surjfuzpgzNZ86Cy3ZJPxa/jUxodL@nongnu.org
X-Gm-Message-State: AOJu0Yxz8ba7vWTyIzeiTPa9WECSdnnavsfk24bbQY69xURIzjb5aHF5
 LjLddJcxIQtSXyoorf0D3aatNvAU6S2/NzV9nR1jbnLmCxargtZXVyRYZX6PzxpgVDHvzLMdsEF
 ilhXbEMuwAm4wOVXO+kSc0/XjLgA=
X-Google-Smtp-Source: AGHT+IHOxoa3jgDuMwUPp1P4elaIQ5pUNLDGLnSjafEnUbztGs1p3RoIl8Fh7orWx3o/z1Ex0YTXSp7ZsQUrGU1Ugvc=
X-Received: by 2002:a05:6102:f0b:b0:49b:f255:179a with SMTP id
 ada2fe7eead31-4a405749686mr12091143137.5.1728348617559; Mon, 07 Oct 2024
 17:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
 <20240919055048.562-9-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240919055048.562-9-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 10:49:51 +1000
Message-ID: <CAKmqyKNhS6zLPNLN4=-v_t01aOL4e9qK3BiYX7cMLAvhooGNjA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Thu, Sep 19, 2024 at 3:57=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> make check-avocado AVOCADO_TESTS=3Dtests/avocado/tuxrun_baselines.py: \
> TuxRunBaselineTest:test_riscv64_rv32
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/avocado/tuxrun_baselines.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_bas=
elines.py
> index 736e4aa289..589c7f254b 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -533,6 +533,22 @@ def test_riscv64_maxcpu(self):
>
>          self.common_tuxrun(csums=3Dsums)
>
> +    def test_riscv64_rv32(self):
> +        """
> +        :avocado: tags=3Darch:riscv64
> +        :avocado: tags=3Dmachine:virt
> +        :avocado: tags=3Dtuxboot:riscv32
> +        :avocado: tags=3Dcpu:rv32
> +        """
> +        sums =3D { "Image" :
> +                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a=
3d6deccbd5",
> +                 "fw_jump.elf" :
> +                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b1=
8936676985",
> +                 "rootfs.ext4.zst" :
> +                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31=
bb13108cba" }
> +
> +        self.common_tuxrun(csums=3Dsums)
> +
>      def test_s390(self):
>          """
>          :avocado: tags=3Darch:s390x
> --
> 2.43.0
>
>

