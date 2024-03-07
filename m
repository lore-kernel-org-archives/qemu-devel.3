Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B0AC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri2Gu-0004y5-Tf; Wed, 06 Mar 2024 20:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri2Gt-0004xp-Kk; Wed, 06 Mar 2024 20:10:07 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri2Gs-0002jx-5x; Wed, 06 Mar 2024 20:10:07 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7db9694a3ceso42827241.1; 
 Wed, 06 Mar 2024 17:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709773804; x=1710378604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCt9dBpTJs9tq31pbefVghVMmdPiFbBdGLdyiMtRrdA=;
 b=l0EufUB8AHNVByi134yQRRPdNY4N+4wnfUjDFa0AfqL7m01Rbg+iOpSANFSnNQlUj3
 BbuITtgojjIaCfuOZ8oix3z4maoxcUspCXriReV4BWpgBYU/9uEtTBOSGKuKFBHKBwKl
 +dK+6ZtKQBYK/12p0Od5MgN47Un37ZvcGRH4uqdVbtWa4Plm2i57M+IjcwLSj0SyigtQ
 zannd0ZorEYlyI7ZwclbqKD7OvH2m0vXZYD2r2zqRods/WT0XtCT1PrS0iVIY1eu0dzV
 1kZfOZzkMs1V7QGPRZSIY1PulcCCUy+BjU8LswIONvAPsiOnoT6cefYRsS/w5vZKinQG
 dIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709773804; x=1710378604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCt9dBpTJs9tq31pbefVghVMmdPiFbBdGLdyiMtRrdA=;
 b=rKEAEVTnUL+CuZxqU7fTRNT702zWHO/qd6GjvdFTDQONg4QqWD9Alxe95vFCikJHey
 QgPHJAFZ9gltQkxEXUbWNKnU86kDwR7FOiwsX1gwSj93r8nh/qcSEdUUM0jMdudspizt
 osYMSE/O+yPwydjSW12VeEO1j5ho/QpL9c8iBzewh25p1Rp/7KTtLRPils5AyCWni2Ov
 MbeFte2BsheVM8wuiYRuT+RL4ARgDIzhnLx+WCa3PG4xhBordFVjh2X0QVrQX071GXnc
 JrfrNrLLVLaBFWxsW/A9y5/MFWZCx3Fy92Tq7HgnelUJtOkcAzyQYGaKNJdHwMeahuhU
 wuwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULuceRx7FLYINYrg18LxzeoP3+jbHQi9qZMJaLSurr2N4wwngqbs9pGu63RlMr3lEdjHpI+iU+YrW4VpLwQ27uh4VTopA=
X-Gm-Message-State: AOJu0Yye4/b9myDNwL2KBMZTonHOnFpnvlCQtzwc0JXAPc5dLsgK9njq
 p+BXB4k2vK4EmRb29uNtV26pPRoAiYek+FOtL6zAUWOx7TZF1v7CiIzHSS4ZgAHz902fKOmZV6U
 wY3ijHxHei4XfXrUfmzaqiBRwykg=
X-Google-Smtp-Source: AGHT+IE2J5Lc7+HffyxVSedMRb/boDP5GYLGIHGNBYpLwGUP+7s4hC9OjITVTP74HPedIDCez31+Cyz7hxfX1J3bX8s=
X-Received: by 2002:a05:6102:390b:b0:472:771e:79bd with SMTP id
 e11-20020a056102390b00b00472771e79bdmr7313847vsu.28.1709773804663; Wed, 06
 Mar 2024 17:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20240225174114.5298-1-demin.han@starfivetech.com>
In-Reply-To: <20240225174114.5298-1-demin.han@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 11:09:38 +1000
Message-ID: <CAKmqyKMG8mE5U46e-NmQW07H7YURJT5_Z+_=ShqC9cSv-rNTBw@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Fix shift count overflow
To: "demin.han" <demin.han@starfivetech.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, 
 alistair.francis@wdc.com, philmd@linaro.org
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

On Mon, Feb 26, 2024 at 3:42=E2=80=AFAM demin.han <demin.han@starfivetech.c=
om> wrote:
>
> The result of (8 - 3 - vlmul) is negative when vlmul >=3D 6,
> and results in wrong vill.
>
> Signed-off-by: demin.han <demin.han@starfivetech.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
> - Add vlen var
>
> Changes in v3:
> - Fix commit msg typo
>
>  target/riscv/vector_helper.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 84cec73eb2..fe56c007d5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_=
ulong s1,
>      target_ulong reserved =3D s2 &
>                              MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                              xlen - 1 - R_VTYPE_RESERVED_=
SHIFT);
> +    uint16_t vlen =3D cpu->cfg.vlenb << 3;
>      int8_t lmul;
>
>      if (vlmul & 4) {
> @@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target=
_ulong s1,
>           * VLEN * LMUL >=3D SEW
>           * VLEN >> (8 - lmul) >=3D sew
>           * (vlenb << 3) >> (8 - lmul) >=3D sew
> -         * vlenb >> (8 - 3 - lmul) >=3D sew
>           */
> -        if (vlmul =3D=3D 4 ||
> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
> +        if (vlmul =3D=3D 4 || (vlen >> (8 - vlmul)) < sew) {
>              vill =3D true;
>          }
>      }
> --
> 2.43.2
>
>

