Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DC6C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thHXP-0004TV-59; Sun, 09 Feb 2025 19:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHXM-0004T2-RF; Sun, 09 Feb 2025 19:20:32 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHXL-00081g-EQ; Sun, 09 Feb 2025 19:20:32 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-85c4c9349b3so996161241.3; 
 Sun, 09 Feb 2025 16:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739146829; x=1739751629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lmgmsn191/xkR2MqNkyc879vAy+UpV8jLP2EKCsWi8=;
 b=D+b8ECbfUFi/JgM0VEDij3p/Y2U6b/ldJ7p9LBbDS9tKm2/fFhKLkl5Q7uo2o7kD/a
 sfY3V5WJfrFjHGh9F+EJddoc7gYqovRFMoem0xkkfubXZDs3UjJEvu2NTO5URT9BSWQV
 6MT3dzJ2Yz8Ul+RnKjN/Q0Spv/puuJ1/jsDG+4VIlvZWiOf+wvFN1FxEJS6x2R038tsQ
 4awEfNYyZrLyTWNQWxfSuwCmt0oauWbO/sxOWvsUCRMZLSJDPhaGEdXMddskxS9Ycw+V
 P0OAYcJfExDufNaFIZ1CNjH0MJFMphTmbn/2+dtKCVe0DLq13K4hs6V5pbqV0fRV9tyO
 sPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739146829; x=1739751629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lmgmsn191/xkR2MqNkyc879vAy+UpV8jLP2EKCsWi8=;
 b=nqTaCiEtKVH1QNHQsqVvqHHmcNila3BBk95xRtguMnbjt24VmRNFSynB3euMbuCaVX
 NiD2rvA5w/0QCD+Zc7KQsD6OQuHCnhEKZmuoWVD1poNWeMoCUu3AFGBmTo3+1bj4cugc
 XrJIKlIDHOfgVt83WXo/NlPd3uy6QszqBFzOUOAVWKcdPiqXgSEWwKwR3DJWv0l5Es0+
 xYuhJ/BfGiD6MWECmQg21dC07TyYvtocCducGFiQkRhZoM4RSKbl/u7OAWscUtkDaA/i
 eoa89w1q2WaaKNI9Isf9jLxJszYELKjrQBQ/mA9aamHe4XzTZCzbSz7vf60vqWelsq+P
 bRRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvZEvU4EXlFlIVnOAuVjhfJD1SYJh1TdHTTzFIE57GiQxa531R8t08yNYhyvGa/NTOgMcuDyM7dh3Q@nongnu.org
X-Gm-Message-State: AOJu0YxqekqzilT5gzKW1+9D6To3FiCHseDKDp54gaJzhJNhfgLbcQWI
 L5Vwp8diazHa0OPtcv1UPK5xHvDICDXoShTjyTaoblfP3sIrATJmiuvlQoYN9oyZ4c4NZJD0PzN
 +bGzQRV3tLNzPEmoTDeDbYzqEBCM=
X-Gm-Gg: ASbGnctXeDZ9j7CJgt+Io8c0IjFucxruEWWpvayamZHbFwVsKtV3neiQCZ6r8dCwF42
 V+cdLZQMBq1XL5u/yigkBYGsHA5ofQHh1C7nxGwh0KsQO8IdxwoeB+8SFKtLyfIT1yc0rATM7h5
 MouYx3KEQ2cdiQp/Mbj+Q5GA+5AA==
X-Google-Smtp-Source: AGHT+IHLhS9GyVaPuPOM9t3hmsMHIJfanijgb3zpUbYl90YU5TByrMsNL7HmIkOnxJUkIsMfOTtdIuNH3kGDNClW064=
X-Received: by 2002:a05:6122:1d55:b0:520:4539:4b4c with SMTP id
 71dfb90a1353d-520453960cfmr1099802e0c.9.1739146829221; Sun, 09 Feb 2025
 16:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20250207152823.265068-1-rbradford@rivosinc.com>
In-Reply-To: <20250207152823.265068-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:20:03 +1000
X-Gm-Features: AWEUYZkteMMhLcoxk-xsqi2QjcxrRYdSmrhBqY7TaiHEgduUNzjcPgZm_Au6HyI
Message-ID: <CAKmqyKNVcR2ErHZxawHVwZCbU-xL54tAdhntYkgfz4+mzB6qvw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix minor whitespace issue in
 riscv_cpu_properties
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Sat, Feb 8, 2025 at 1:29=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> The mvendorid/mimpid/marchid properties have the wrong amount of
> whitespace ahead of them.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2..cca24b9f1f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2844,9 +2844,9 @@ static const Property riscv_cpu_properties[] =3D {
>      {.name =3D "cbop_blocksize", .info =3D &prop_cbop_blksize},
>      {.name =3D "cboz_blocksize", .info =3D &prop_cboz_blksize},
>
> -     {.name =3D "mvendorid", .info =3D &prop_mvendorid},
> -     {.name =3D "mimpid", .info =3D &prop_mimpid},
> -     {.name =3D "marchid", .info =3D &prop_marchid},
> +    {.name =3D "mvendorid", .info =3D &prop_mvendorid},
> +    {.name =3D "mimpid", .info =3D &prop_mimpid},
> +    {.name =3D "marchid", .info =3D &prop_marchid},
>
>  #ifndef CONFIG_USER_ONLY
>      DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVE=
C),
> --
> 2.48.1
>
>

