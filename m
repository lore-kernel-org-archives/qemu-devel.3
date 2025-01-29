Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75731C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwL0-0001WL-6p; Tue, 28 Jan 2025 19:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwKz-0001Vh-1S; Tue, 28 Jan 2025 19:53:49 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwKx-0003NA-Fi; Tue, 28 Jan 2025 19:53:48 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afdf096fc5so1520698137.2; 
 Tue, 28 Jan 2025 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112026; x=1738716826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjMUK7PzJcbkHtu60lYMfOtI1KIULJ3JTE/7jDoXzxc=;
 b=fZf+5ih41MVQKeR9t38El1nHnPlt8WtoeUEyqrFpI4eonLAgr7S3mvCYw76lkBdHsk
 HTn1h+tQvnuFKoayh7ABst2yxV0GTWTAsBtlobNglZJBGJ833s2jxqT40MkzWk3J4yPz
 p1OAD7YwrmXZmk4++m17FeS2ch6ZsGarHGSQJ6ZKsh3AnwiI/HG28han5rtYAhhIjeWS
 V066a4gubKmBw7YUZ1m6P8hmlB/WTaLkljTqbxWSUnF5pIxKsZW+hntwpWBGozPJZZcg
 KQ5oo9PrfJrPAoZFD3lY0S8J2RsODaxXgGigWmchuC/Ehs6tgeYhXySVC+mxnSZr4yGF
 IMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112026; x=1738716826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjMUK7PzJcbkHtu60lYMfOtI1KIULJ3JTE/7jDoXzxc=;
 b=nT7Z/ozNn3d6AVQe88BWCnKmd1tISM6KW10wO7vvnkYYGfq5RWNPSXwYa/9Kxiyjp3
 gNkFmb/P33+5bN1kTQOjN8hotXYJ4SQSElPxaL9c/RW8lavkaExNpkmCBNjX5lhyGDfJ
 ngrGLHT9771vHI+wLCnhPHLth0cZow9A3pqLBxKZvBIXduucN+QZNPnhWkcwg9n5Tc0g
 CxRLhFcmUtEcS6lFqVcf8Q5urMD6rg11oz9YdlPzpz59Tw9e2m8TbAgfbEIlSwU5BMw6
 LMprIdfV3VQ01fI93P/JgR3EhTBduChxFvMk3SmFxH3PtOC49cXXYW4ofzjuzbsgqkFD
 5d4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaW7D89ANFCGW60ymYI9BBJGcj/hFEGPOH8UFVFklCzVSKJSpIZaqLrWsa+DnUoL9wd/PZvuA2bRIO@nongnu.org
X-Gm-Message-State: AOJu0YyVTkNIzF8qisljSz7SkH5/PPAvddoIJuCqSnVbSQ0jvELkre6V
 sLtBR6T03YtG3jxfWm0oEKV1H2nRuNIwp6Zr8Qpuuu4+P09jXm4RzZuD5RCSqG86K1Q64xMwNZW
 AvWAKuumDIIeSCyEp/8FRKmCmGIU=
X-Gm-Gg: ASbGncupM9lPLQnP7v56X/K4CsEOVXlLtx/BUpFuXkcj3XaizPxqyBP+BAfx88lDGYg
 tItZEfC6pb105GBJfREULZs+nAaiWFTFapJRlqgZ5IgSCnkhqyzOaMj8r3mqwYYwCU2+ci9q9JC
 hhIrP0dzSgm+pjQAr7Vzhlxnkbiw==
X-Google-Smtp-Source: AGHT+IEGvaQJQMW1ISm4wgEfaS1n/f9EnNQD+kKfKs/SRaduCC3P6wABDXMPeZHY8Nvr5lC941s11D9bKP8BUbd2IK8=
X-Received: by 2002:a05:6102:304f:b0:4b6:1a4e:9ed7 with SMTP id
 ada2fe7eead31-4b9a4ec8bb1mr896794137.5.1738112025852; Tue, 28 Jan 2025
 16:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
 <20250121184847.2109128-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:53:19 +1000
X-Gm-Features: AWEUYZnlOmwo1fIiEcI5lvmQDY4M-5d9zX6FFXmCyQ7z5pOy5qYf3i8Hkv8fNtk
Message-ID: <CAKmqyKO91J5MjmyeUzJRf1ji_YYD2P2Li2TQxTeEZBGvPReJiQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv/csr.c: fix deadcode in rmw_xireg()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Wed, Jan 22, 2025 at 4:52=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity found a DEADCODE issue in rmw_xireg() claiming that we can't
> reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:
>
> done:
>     if (ret) {
>         return (env->virt_enabled && virt) ?
>                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INS=
T;
>     }
>     return RISCV_EXCP_NONE;
>
> This happens because the 'virt' flag, which is only used by 'done', is
> set to 'false' and it will always remain 'false' in any condition where
> we'll jump to 'done':
>
>     switch (csrno) {
>     (...)
>     case CSR_VSIREG:
>         isel =3D env->vsiselect;
>         virt =3D true;
>         break;
>     default:
>         goto done;
>     };
>
> 'virt =3D true' will never reach 'done' because we have a if/else-if/else
> block right before the label that will always return:
>
>     if (xiselect_aia_range(isel)) {
>         return ...
>     } else if (...) {
>         return ...
>     } else {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>
> All this means that we can preserve the current logic by reducing the
> 'done' label to:
>
> done:
>     if (ret) {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>     return RISCV_EXCP_NONE;
>
> The flag 'virt' is now unused. Remove it.
>
> Fix the 'goto done' identation while we're at it.
>
> Resolves: Coverity CID 1590359
> Fixes: dc0280723d ("target/riscv: Decouple AIA processing from xiselect a=
nd xireg")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f07..ab209d0cda 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2658,7 +2658,6 @@ static RISCVException rmw_xireg(CPURISCVState *env,=
 int csrno,
>                                  target_ulong *val, target_ulong new_val,
>                                  target_ulong wr_mask)
>  {
> -    bool virt =3D false;
>      int ret =3D -EINVAL;
>      target_ulong isel;
>
> @@ -2680,10 +2679,9 @@ static RISCVException rmw_xireg(CPURISCVState *env=
, int csrno,
>          break;
>      case CSR_VSIREG:
>          isel =3D env->vsiselect;
> -        virt =3D true;
>          break;
>      default:
> -         goto done;
> +        goto done;
>      };
>
>      /*
> @@ -2705,8 +2703,7 @@ static RISCVException rmw_xireg(CPURISCVState *env,=
 int csrno,
>
>  done:
>      if (ret) {
> -        return (env->virt_enabled && virt) ?
> -               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_IN=
ST;
> +        return RISCV_EXCP_ILLEGAL_INST;
>      }
>      return RISCV_EXCP_NONE;
>  }
> --
> 2.47.1
>
>

