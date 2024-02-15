Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A8EC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raUV8-0000S2-Dt; Thu, 15 Feb 2024 00:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUV1-0000P5-BO; Thu, 15 Feb 2024 00:41:32 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUUz-0002v9-Od; Thu, 15 Feb 2024 00:41:30 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7cedcea89a0so362668241.1; 
 Wed, 14 Feb 2024 21:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707975688; x=1708580488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxT1ML7xRa8Z95kc9kVylYSdEdc53SdXf07+TWN7eA0=;
 b=luvfWlv9Hle0v3jRk3Bm8AW/HskAfItDODXW8pl3bYeyTAqjVUeecvRIl4sew8oF5k
 LqAQUIV89rzjiemJ/22lSTo97LPVvfNbGObawDmktcvktyscJt/NXQt24rCIbRbaSrv0
 FQ0IZZ65nDO2oAAYPvzaI3nq+xnMe6pdzTWzNL6Bvs4X1SbjqgaHeJJwGlywBqN47OmY
 d64Dr1PnA+QG0tG5zd4mE9RPNxONhZLS6mJ58MWNeS9mHO+YqyT4J8mTSlvQL8JbXVrn
 dyNYLft94QEhuv6HbIzktKycjpVqTQU3ZTOeRTWKb9J7K8wmpH9b6vcx9R92qLR42DRH
 a1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707975688; x=1708580488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxT1ML7xRa8Z95kc9kVylYSdEdc53SdXf07+TWN7eA0=;
 b=usyQCYUnKPG3gLOxERDzkTjBo+XTB+8eu1+jxHLQaEXmExKPBCo8/qfjs/A2lcvVDK
 BmZL/9jjlvzYjnu4SyDvPs+oPTQPicBfcoYSeP4/aWaszkAX9mAEQqVkqx8ypZDwjyMP
 J5yvyXpJeYK3v9o/2EsbfmoqVjZ42h0gt3LKzOsIRHF5AamxjYjhfl8qNw0a92ToWsQs
 lYTTk4kzwwC0POG/j21vzujmGSWQwXKkHVyt+yPVZW/HUNJoyiFds6TVtUcwrNuUidvm
 KvMjQJ1+M8O9vdwYvHQ4ZCPvluxV1rx+jJPTfHMDAtnjcEUF1tpBbD6d0f3qbI7PNIT2
 NugQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3rI0Upj/ERLgSnG8rAjR77iI0FpWLvNGf65a/1G/eVxwp9QvpeP4SsrlpkQ0OUmHI2NVJRiA8Dz79bI5zf3wRM23d0o=
X-Gm-Message-State: AOJu0YzLzsYaSmZjIED7m6umDcdyXCPgVweOzVWmruDf0R7z1+uBfmpe
 o6btkfnRIyfaOUhSoYMhmZmRZvklWUsbRzX/ScnYQb5NZ6jvImUMB2/Uknw3fTc/Ta9DkpJze2C
 aVe2me5HjyTyVbjvteMOECongllY=
X-Google-Smtp-Source: AGHT+IGl3p63t387eIcxinUpqFqX1S0Hb5uQf9+L7ySLaoJ8JRMIqoTdRHX0urVbn9ugubuckyJuJe1VnhoDq2ELPjo=
X-Received: by 2002:a1f:62c3:0:b0:4c0:3621:7ab0 with SMTP id
 w186-20020a1f62c3000000b004c036217ab0mr553772vkb.15.1707975688242; Wed, 14
 Feb 2024 21:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240202152154.773253-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:41:02 +1000
Message-ID: <CAKmqyKN+WScEJNiwtQyV5pR0nbjttBPX0sVSmebzw2UeesoROA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] target/riscv: Promote svade to a normal extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Sat, Feb 3, 2024 at 1:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> Named features are extensions which don't make sense for users to
> control and are therefore not exposed on the command line. However,
> svade is an extension which makes sense for users to control, so treat
> it like a "normal" extension. The default is false, even for the max
> cpu type, since QEMU has always implemented hardware A/D PTE bit
> updating, so users must opt into svade (or get it from a CPU type
> which enables it by default).
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 9 ++-------
>  target/riscv/tcg/tcg-cpu.c | 6 ++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 50ac7845a8..f036b153a1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1422,6 +1422,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> +    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
> @@ -1534,7 +1535,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental=
_exts[] =3D {
>   * and priv_ver like regular extensions.
>   */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
> -    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>
>      /*
> @@ -2182,8 +2182,6 @@ static RISCVCPUProfile RVA22U64 =3D {
>   * Other named features that we already implement: Sstvecd, Sstvala,
>   * Sscounterenw
>   *
> - * Named features that we need to enable: svade
> - *
>   * The remaining features/extensions comes from RVA22U64.
>   */
>  static RISCVCPUProfile RVA22S64 =3D {
> @@ -2195,10 +2193,7 @@ static RISCVCPUProfile RVA22S64 =3D {
>      .ext_offsets =3D {
>          /* rva22s64 exts */
>          CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
> -        CPU_CFG_OFFSET(ext_svinval),
> -
> -        /* rva22s64 named features */
> -        CPU_CFG_OFFSET(ext_svade),
> +        CPU_CFG_OFFSET(ext_svinval), CPU_CFG_OFFSET(ext_svade),
>
>          RISCV_PROFILE_EXT_LIST_END
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 43c32b4a15..9fc64979f1 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1314,6 +1314,12 @@ static void riscv_init_max_cpu_extensions(Object *=
obj)
>          isa_ext_update_enabled(cpu, prop->offset, true);
>      }
>
> +    /*
> +     * Some extensions can't be added without backward compatibilty conc=
erns.
> +     * Disable those, the user can still opt in to them on the command l=
ine.
> +     */
> +    cpu->cfg.ext_svade =3D false;
> +
>      /* set vector version */
>      env->vext_ver =3D VEXT_VERSION_1_00_0;
>
> --
> 2.43.0
>
>

