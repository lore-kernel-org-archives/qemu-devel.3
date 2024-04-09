Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA83CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru4z5-0002IT-8o; Tue, 09 Apr 2024 02:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1ru4z3-0002HY-34
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:29:29 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1ru4z1-0005h3-CM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:29:28 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d29aad15a5so48267541fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1712644165; x=1713248965; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iokoXKahvkzbJmLECwygG7tc6cKoCx20CtQYOHWFhpA=;
 b=I89SdATKZSolBTwTGUPJ4xL5mt3xippaflm315wJiV9iUvXfgJUgj/WnolD2p6SiLJ
 I8o8zCRNMTGh8ew3ADhQYCyuiSA/O//9T1bsw/UDbaskSh2Ma4BAHDBNo8GY9H/u0qGg
 c+ARr4CRpEALAPHD+bqYGj8uBwPDIYHiaWM1pMOfkVlFC68fJk1zlZJYNVbvM66+ciDO
 UfqIkLTw0el/wUpuTpzUr1ieimY41pzucGnvifn4KulAxq7BBsCrrlNKTYYw+ItfQJT+
 zK77DMt7wFbK8QPV8E62kg8fFpWmZV7vsKxkBZxr5JaDf6npL5AFrrUBPwA66O8Ly60g
 mpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712644165; x=1713248965;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iokoXKahvkzbJmLECwygG7tc6cKoCx20CtQYOHWFhpA=;
 b=sc1CKBuEAXGh9LC5C1Hyi7zIFQFKE3bVzDawL+lNBD3hG/sj+Dw+22Cr/yNGgI4LEc
 jHH/gM12G/F53Vz4U7/JvOAoHFFnXjy6oez0wQteV1G7pfXCe9Gm572ji869v/zzPCuW
 T0Odq+pR99qHXJmlLQH0m0hcm+lSyxATf2Ts/j26FiMPH7k8ywIvLAY6uXhmbaDQ1iuZ
 wqljzJuuqvlLwumLtaALqKqOaCcSaZgI5qS5bPHLdS8DbTG8mMbPoTK+aEXP7IkgRxoV
 Uj6nVv8hMbxZVN9fw9751VosT60JqxiGdFT3RDEuKx5UcnDhbegHIAr0HenOBkPM8OI+
 JAuA==
X-Gm-Message-State: AOJu0YxMWJQaZDax6fx0iH9LUHV23weilyQFyk/N9mXBatfa867AQZSK
 wl4r38fxz+7iio9GbaLVgOGsM7Vsr484PdVkHvHhY086MgpEkNk7pdQ8NC4Fax/QYD4uka36d/v
 UN61evOfh54RcuVDfji5ohyEssis2/JpeAkKN8aI2czNUVG/z
X-Google-Smtp-Source: AGHT+IEzVTya2znQiR2A3H+Hoxh9QFW59JQrKuVEbJv0nsQBq1m8KyKAkLHpZqeVVes/cKSzfydl5mA4hNgy2yATYvA=
X-Received: by 2002:a2e:a4d7:0:b0:2d8:23b4:9067 with SMTP id
 p23-20020a2ea4d7000000b002d823b49067mr6935733ljm.39.1712644164796; Mon, 08
 Apr 2024 23:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240328022343.6871-1-jason.chien@sifive.com>
In-Reply-To: <20240328022343.6871-1-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Tue, 9 Apr 2024 14:29:12 +0800
Message-ID: <CADr__8p1Gzg1u3Rk4EuT8k1nJyjDdXuMCfN7GZLLgWDJN3piSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: Support Zve32x and Zve64x extensions
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000011ea480615a40b8f"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000011ea480615a40b8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=BC=
=9A

> This patch series adds the support for Zve32x and Zvx64x and makes vector
> registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.
>
> v2:
>     Rebase onto riscv-to-apply.next (commit 385e575).
> v3:
>     Spuash patch 2 into patch 1.
>     Spuash patch 4 into patch 3.
>
> Jason Chien (3):
>   target/riscv: Add support for Zve32x extension
>   target/riscv: Add support for Zve64x extension
>   target/riscv: Relax vector register check in RISCV gdbstub
>
>  target/riscv/cpu.c                      |  4 +++
>  target/riscv/cpu_cfg.h                  |  2 ++
>  target/riscv/cpu_helper.c               |  2 +-
>  target/riscv/csr.c                      |  2 +-
>  target/riscv/gdbstub.c                  |  2 +-
>  target/riscv/insn_trans/trans_rvv.c.inc |  4 +--
>  target/riscv/tcg/tcg-cpu.c              | 33 ++++++++++++++-----------
>  7 files changed, 30 insertions(+), 19 deletions(-)
>
> --
> 2.43.2
>
>

--00000000000011ea480615a40b8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt; =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:23=E5=AF=AB=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">This patch series adds the support for Zve32x and Zvx64x and makes vecto=
r<br>
registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.<b=
r>
<br>
v2:<br>
=C2=A0 =C2=A0 Rebase onto riscv-to-apply.next (commit 385e575).<br>
v3:<br>
=C2=A0 =C2=A0 Spuash patch 2 into patch 1.<br>
=C2=A0 =C2=A0 Spuash patch 4 into patch 3.<br>
<br>
Jason Chien (3):<br>
=C2=A0 target/riscv: Add support for Zve32x extension<br>
=C2=A0 target/riscv: Add support for Zve64x extension<br>
=C2=A0 target/riscv: Relax vector register check in RISCV gdbstub<br>
<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++<br>
=C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/riscv/insn_trans/trans_rvv.c.inc |=C2=A0 4 +--<br>
=C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 33 ++++++++++++++-----------<br>
=C2=A07 files changed, 30 insertions(+), 19 deletions(-)<br>
<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div></div>

--00000000000011ea480615a40b8f--

