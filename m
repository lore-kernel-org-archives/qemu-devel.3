Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8207CD40D0D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TL7-00076o-NC; Tue, 05 Nov 2024 18:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TL4-00071S-3w; Tue, 05 Nov 2024 18:51:58 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TL0-00016U-CN; Tue, 05 Nov 2024 18:51:56 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-50d4a6ef70aso2041003e0c.3; 
 Tue, 05 Nov 2024 15:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850712; x=1731455512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d/elUn899oblJwq17awcMzOt8ehUfEugDOwFZC0xT0=;
 b=nW0my2s5ACdPWBU7z2s2lvBopSuOZAdd7I1ANZ1QifzlLi6dFQAlKeJAIpQSF+Ayy6
 Sh6/bnCR9e1wRXCD2paSOdJ9r9taidSMPzCSJn+Z8/6j4amwIA3PFb4tDtAxVoUQqiVh
 g7KYRHiI+Edti3KkHHpvKAebwC3HnXYgKPrcB5i6MuZsaYZ+Z8nKZnusV2F2rwHQsNCx
 Fk8dBHGAzjJNtoYS7ubdPr6HTcSEueKtBL/XQ4IHbrwR8b+2Ui9mv2Lewv8cdIjZRm++
 HHb+HtKLfdIpkjuoUHctvAQXQDcTkbpG+KzfWIjbgrrp+Dj6mMAR7a7XNaQLVee3/AQ5
 gPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850712; x=1731455512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3d/elUn899oblJwq17awcMzOt8ehUfEugDOwFZC0xT0=;
 b=s8PAmtd6WKdCCAGPml9bczruf9CcRisoLPYW/mrnoj48OfmhFdd8Stmp3E+5ciq2UA
 iWNongzbt9ibzrAZlvKMf7A3r6NbBKoNLEJzWdBmxwc2nQjsyGyw33HqD1VxQF+Tp3Em
 JbBzsT8waiiT+a0NFjIbjq8zpl5e2na8x5AWUZLhcER42NegSsBZpRTKF/xkF8vHqEjp
 IjGyOzMy3I9ylZ8iB1cUEssX6v/MfapkBtp+RFyjfKNig2Ehjos4IdoXYFJgFtb+4J/3
 Wp5TZKv1/1VZdSqBhOHm5il2sbTR7zha+WacjrNL2Zpan7APudPrYNAbDxgaqiaM+XGL
 4f9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNoIP27mUxwyOaY5BKRqvLooRKr1aVP+g1vk31xjVoqIl5Q95ur85mpAVYs/ob0P361Uce3AwhZcpH@nongnu.org
X-Gm-Message-State: AOJu0YzJKmk2cF9cuqkTqiJGMluUzrxGcCCfubkbQJo5h5HnXsDsgAAR
 URgtWq6Ds9RZ/Upb9Ez52g4QIzcV6SBhHsxpgYkKFXCDs/yI3K3+QA1xOSAmXGxB8qwZZODHZOG
 CwMFV+t+Ce3YuzzoYlQzo266P8Ys=
X-Google-Smtp-Source: AGHT+IGkeBZEFqP+jTKwuWIAKwaxt1IvtUpXco+RHhdXq3XZmHFuVyIbwRluz2RAYUfIIutf3sMQiBhm/JLZv4i3PuM=
X-Received: by 2002:a05:6122:91f:b0:50d:918d:4da1 with SMTP id
 71dfb90a1353d-512270b59e0mr17055578e0c.3.1730850712055; Tue, 05 Nov 2024
 15:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20241105103519.341304-1-thuth@redhat.com>
In-Reply-To: <20241105103519.341304-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 09:51:26 +1000
Message-ID: <CAKmqyKPke9NQ4fcBZSWfBih+Gwnx73o7aMZP3=bCT-kCJpULtg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Convert the RV32-on-RV64 riscv test
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>
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

On Tue, Nov 5, 2024 at 8:36=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> A straggler that has been added to the Avocado framework while the
> conversion to the functional framework was already in progress...
> Move it over now, too!
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Sorry about that!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/avocado/tuxrun_baselines.py       | 16 ----------------
>  tests/functional/test_riscv64_tuxrun.py | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_bas=
elines.py
> index 366c262e32..38064840da 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -222,19 +222,3 @@ def test_arm64be(self):
>                   "rootfs.ext4.zst" :
>                   "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b0145=
1b47fb4bd7"}
>          self.common_tuxrun(csums=3Dsums)
> -
> -    def test_riscv64_rv32(self):
> -        """
> -        :avocado: tags=3Darch:riscv64
> -        :avocado: tags=3Dmachine:virt
> -        :avocado: tags=3Dtuxboot:riscv32
> -        :avocado: tags=3Dcpu:rv32
> -        """
> -        sums =3D { "Image" :
> -                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a=
3d6deccbd5",
> -                 "fw_jump.elf" :
> -                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b1=
8936676985",
> -                 "rootfs.ext4.zst" :
> -                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31=
bb13108cba" }
> -
> -        self.common_tuxrun(csums=3Dsums)
> diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/t=
est_riscv64_tuxrun.py
> index 13501628f9..4e2449539c 100755
> --- a/tests/functional/test_riscv64_tuxrun.py
> +++ b/tests/functional/test_riscv64_tuxrun.py
> @@ -23,6 +23,13 @@ class TuxRunRiscV64Test(TuxRunBaselineTest):
>          'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
>          'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679e=
b')
>
> +    ASSET_RISCV32_KERNEL =3D Asset(
> +        'https://storage.tuxboot.com/20230331/riscv32/Image',
> +        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd=
5')
> +    ASSET_RISCV32_ROOTFS =3D Asset(
> +        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
> +        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cb=
a')
> +
>      def test_riscv64(self):
>          self.set_machine('virt')
>          self.common_tuxrun(kernel_asset=3Dself.ASSET_RISCV64_KERNEL,
> @@ -34,5 +41,11 @@ def test_riscv64_maxcpu(self):
>          self.common_tuxrun(kernel_asset=3Dself.ASSET_RISCV64_KERNEL,
>                             rootfs_asset=3Dself.ASSET_RISCV64_ROOTFS)
>
> +    def test_riscv64_rv32(self):
> +        self.set_machine('virt')
> +        self.cpu=3D'rv32'
> +        self.common_tuxrun(kernel_asset=3Dself.ASSET_RISCV32_KERNEL,
> +                           rootfs_asset=3Dself.ASSET_RISCV32_ROOTFS)
> +
>  if __name__ =3D=3D '__main__':
>      TuxRunBaselineTest.main()
> --
> 2.47.0
>
>

