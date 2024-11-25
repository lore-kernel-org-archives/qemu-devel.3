Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D5DD3B7D2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 04:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFQq4-0004lz-OD; Sun, 24 Nov 2024 23:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFQq0-0004lh-Gj; Sun, 24 Nov 2024 23:36:40 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFQpy-0006Wc-Qq; Sun, 24 Nov 2024 23:36:40 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84ff612ca93so1182915241.0; 
 Sun, 24 Nov 2024 20:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732509397; x=1733114197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpFj9GSYfzkEGmASAIG7nCFVTW9dIuN9f7BIh3LVCQE=;
 b=Sg27uKETaTf7ES3LnCbnicNeYQJ4x6qzInsVseZM+O/srlE5/ELDAZMhq+ykOpSAgh
 V3Z/hLQznlr6PWQJ2RGSdf2YEtSKta/JPXy8VXEAO104vhYNLbvfwxNdUxf93O74y8NW
 qZ8310iV+68lOYXsNOjWbfSRho4afvCXvmjuHcMaLxDXb9Kr57VNqLZU38s77gezuoS4
 wMPaP/BHIysGcYW3qHp2lNOoc9vH6JDTwn3uOuamPVuaKkxVQxklcWD5/o0H4E9lCwUv
 eDMb36vd/6f5gV1TSVz9G+ysQPotdRcokcfhp6jAoNuQ8EUrYx75z8hcPQ1oONtdc3Wx
 qATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732509397; x=1733114197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpFj9GSYfzkEGmASAIG7nCFVTW9dIuN9f7BIh3LVCQE=;
 b=EVv/9mpk0LAw5paRo7LM2zxSx7fNUwyYSciE2LY2bUZJk5NJxXLwqHCkYZVzrw4ILj
 JzWLU8viVJzAPLfCnPncsfvoivjO0i5gDWc75Un6idxR6EL/SXxClL0TGLydjGUGRPTt
 LtPWnbtXn/IyrCVLZS/YKSPl+K2ApPdHfWKTQUy9+cED7Bb9BEo3BfDOQBa+9ttzaUh+
 /ZAOn2HTcYfy4+2YO/5jaamPNbdNN9G7iYnt7oXuwhA/O/1DFW5aRmebhi7RaJN3/CsJ
 TJLuebF3md5n/mtv5gwYG8hwjocZ8+5x+wmsOlUJRSALWjR/blZTiA38SMSOFj4gET1H
 yCFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf6Jdd2v/EXbGL+TOEyg0jMPAHu2HhfmEeeryX/TWj8ZemHGEFVhoNIvq0jFfxlH3DpUMfjChq0TR0@nongnu.org
X-Gm-Message-State: AOJu0Yxv46ETs4NC12F5zbW5dX8t63pIaz8mgrUEO1NhX6qH+AsJvKlb
 znqkRhDgeP+ZBCcBU85Uj9kAEaezi1htWGCdnc1UvfXSXAmxaL3hzlvIKfnjICQmklN3I5/ZFsA
 rYC1rRISynGPUqjI82DKyfxCugpI=
X-Gm-Gg: ASbGncs/xf1XVusA8mVGpqHIG1X2RTtEln6TjOzGzGtzOspNiI6UaBBg4ktNbzvPzs2
 usknEEKmrhS9Yc+tIPWStBVl1Yy4o/smNK/jmsnaIiDFQwnnF9+ZTN/Gx2ZZLdw==
X-Google-Smtp-Source: AGHT+IH72I8e1gQQadsJh0E3+R60iA8Dg+ALB4MeYS+x4yhLcW5/e+qAOB9Bp20sT7W/Lk8UVzWma2R3ro8sM7BUUEA=
X-Received: by 2002:a05:6102:32d4:b0:4af:c66:de88 with SMTP id
 ada2fe7eead31-4af0c66f5b7mr3914989137.16.1732509397274; Sun, 24 Nov 2024
 20:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Nov 2024 14:36:11 +1000
Message-ID: <CAKmqyKOgtDnKLHZCW+Y0F64vEgdTGOJDdFJLpZW6Qft8pBKpaQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 1/9] target/riscv/tcg: hide warn for named feats
 when disabling via priv_ver
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Thu, Nov 14, 2024 at 3:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 68c9e54bea handled a situation where a warning was being shown
> when using the 'sifive_e' cpu when disabling the named extension zic64b.
> It makes little sense to show user warnings for named extensions that
> users can't control, and the solution taken was to disable zic64b
> manually in riscv_cpu_update_named_features().
>
> This solution won't scale well when adding more named features, and can
> eventually end up repeating riscv_cpu_disable_priv_spec_isa_exts().
>
> Change riscv_cpu_disable_priv_spec_isa_exts() to not show warnings when
> disabling a named feature. This will accomplish the same thing we're
> doing today while avoiding having two points where we're disabling
> exts via priv_ver mismatch.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c62c221696..cd83968166 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -304,6 +304,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RIS=
CVCPU *cpu)
>              }
>
>              isa_ext_update_enabled(cpu, edata->ext_enable_offset, false)=
;
> +
> +            /*
> +             * Do not show user warnings for named features that users
> +             * can't enable/disable in the command line. See commit
> +             * 68c9e54bea for more info.
> +             */
> +            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) =
{
> +                continue;
> +            }
>  #ifndef CONFIG_USER_ONLY
>              warn_report("disabling %s extension for hart 0x" TARGET_FMT_=
lx
>                          " because privilege spec version does not match"=
,
> @@ -331,11 +340,9 @@ static void riscv_cpu_update_named_features(RISCVCPU=
 *cpu)
>          cpu->cfg.has_priv_1_13 =3D true;
>      }
>
> -    /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> -                          cpu->cfg.cboz_blocksize =3D=3D 64 &&
> -                          cpu->cfg.has_priv_1_12;
> +                          cpu->cfg.cboz_blocksize =3D=3D 64;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> --
> 2.47.0
>
>

