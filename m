Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F2C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7u4R-0004w4-K1; Thu, 24 Apr 2025 06:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u4Q-0004vX-AI; Thu, 24 Apr 2025 06:44:42 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u4O-0000AR-KC; Thu, 24 Apr 2025 06:44:41 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso392294241.2; 
 Thu, 24 Apr 2025 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491478; x=1746096278; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fX1BfI94cjCaZBv7sFcVFt7XdzeRYsyQ8R83ia2uJMo=;
 b=isN74niBoDvq4kLQR1UzCXPah08YvBRnJHE9YjLW9CeKMY5u+MnhjBDSSl8hT/3U7v
 u6tBirgm0sXcolapq9AP8PkDtHaNTyb78gJ191WFLBKohVArkQwUi2y3rXrAbPh2JO9o
 mvdbavXLAN2md4hB4G3omuYlcLZ0pAlENfT9bpiGE3nNDgNRSKQjRDsZm2TYP5MhuJcZ
 EqXTi0y4kJ0Jyn5dZd6t8AtO0lfJSYaVhjJAaaqjhsCB6IUTey6/hUhjKrzpLxnRFcDF
 V7bMIbjfrEDc9SBIbgtU6pY+/UkuVTlLyqVbmyfKxt5HsRPkY9kmuIsgA+57Pde73Zec
 Fp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491478; x=1746096278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fX1BfI94cjCaZBv7sFcVFt7XdzeRYsyQ8R83ia2uJMo=;
 b=DPkQnsH/TftZTclBpnW4a5JGxipaaZpQHCMNUZXrbdUMGhmWd3oZsdk8M1yruR1Hlt
 AaSnMgnmYAbmhIMF825T+RqB/QbKtnD7tOuhYvCtfs3RL8harDDIyRlUa7kte5luJdkq
 a76XkOSccXCn2svQfyJYyDjMnj/ts2US3497Y0dg0lf0xFopL22T6dUhwQQbRieiw0Ih
 8UvAX9sTfl6ZFYu+68r9SObFR0xVIuPUKMmDGAn0KIST/7jhQLpLV17q3in4tSGTpeYc
 X9xqWDNl7N5r26B0RQyIS57SmNcWkpPC0ztEDOqbi3C6sT5QLhFHK0BRKPlydIEy4MWu
 JXrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1YxakDXKQ9Udc8z6d67aXtHBwlIGyVcJ9dwNq61jssOEnoMSZqFdOfCxSxAdh0BlfF6fAZm/j0OcP@nongnu.org
X-Gm-Message-State: AOJu0Yztvro22Cn4r6C3I1CRwTiKjvbcqkN3bquAmi2fSJNkjmD6Iuu4
 NvXXAxi5D7OQTrLsVTiEvLSOmyNdIy4wFFYAAhq3Su54a3S23eiSLzBSmJNw8OApS3TweMbv42g
 v415F6ml3bmaX1CldbiW5FNZhCIw=
X-Gm-Gg: ASbGncvN7yyRdKodZGjrpoP4B+fctoztDrv57X/0nRz9ibTIYo9crEmxxXukE2VevZy
 7Z1GfSyWIMwXFy4/g+z/lhhFG943I/DAF33U/FtWL9QJqYwFGKWxDTU5xdzqj0VvrpoQBg/yE5H
 Oc9vRi/0dtEWx6DZ6XJbImPqFtlexqzitAjBYScj+oyro956i8pC6j++ThxvMe5Kw=
X-Google-Smtp-Source: AGHT+IGWx17h1F3L4hZfkU/BktOHTPQTVUVjhO67D+CAZuEmgo2X1PNadxqrKsy7tbbdyBJmCwui8r5ASYa3jmmBvPU=
X-Received: by 2002:a05:6102:3050:b0:4c5:1bea:1c29 with SMTP id
 ada2fe7eead31-4d38eef134bmr1522062137.19.1745491478471; Thu, 24 Apr 2025
 03:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250414213006.3509058-1-antonb@tenstorrent.com>
In-Reply-To: <20250414213006.3509058-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:44:12 +1000
X-Gm-Features: ATxdqUF9qy3wyS8xiRVUyWa-kWK5WOOzBouAdEpJcBj87V2eSF2TegNjYIipccs
Message-ID: <CAKmqyKO6CQm3DO3kSX0MCC=gv5B9nqwyY1d0iO91kmhRbsCEYA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix vslidedown with rvv_ta_all_1s
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Tue, Apr 15, 2025 at 7:31=E2=80=AFAM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> vslidedown always zeroes elements past vl, where it should use the
> tail policy.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 67b3bafebb..1012d38c8a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5113,9 +5113,11 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong=
 s1, void *vs2,         \
>      }                                                                   =
  \
>                                                                          =
  \
>      for (i =3D i_max; i < vl; ++i) {                                    =
    \
> -        if (vm || vext_elem_mask(v0, i)) {                              =
  \
> -            *((ETYPE *)vd + H(i)) =3D 0;                                =
    \
> +        if (!vm && !vext_elem_mask(v0, i)) {                            =
  \
> +            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);         =
  \
> +            continue;                                                   =
  \
>          }                                                               =
  \
> +        *((ETYPE *)vd + H(i)) =3D 0;                                    =
    \
>      }                                                                   =
  \
>                                                                          =
  \
>      env->vstart =3D 0;                                                  =
    \
> --
> 2.34.1
>
>

