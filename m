Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C76FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Wl-00009S-Tg; Wed, 05 Jun 2024 19:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0Wk-00007v-2F; Wed, 05 Jun 2024 19:58:46 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sF0Wi-0001M4-3Y; Wed, 05 Jun 2024 19:58:45 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4eb18095222so135844e0c.2; 
 Wed, 05 Jun 2024 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717631922; x=1718236722; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LDArNmgrPeRJ/t84W8+0kxwBm6A6sNEuUzeOnkZ24A=;
 b=ZFibOhMKyP5nR4Ijhv1dWOadFh+jfgSUbTZ8egAKwHSnZ2wDlRzUHuyUsBQHqrQIcw
 9ulCRqi4fyAzhYPpuuhf7SJJB8ugRNtt9jUuKiNN+vq2z8F68YBYKCDcKT0LRDbfGHt9
 uAX/i2Mag4Nkvfquj7tXSvQ+kx6MlkOq64gJ7RotkaNg7rlURfIfo1woRUCO6ZeLzNbq
 4IjQzYztHx8KQqYTf0gHUGnL4Db6Bi5kXOddp+x6TcVbfzcAbrSDfmlK6Nd38SxMiWC8
 W2qveGDOGWlxwXYxUnXXw4gO8fHAh0lCuaxUsYWVdWVQI/xoOCBdemYYPuKjKpCaz/sW
 J9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717631922; x=1718236722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LDArNmgrPeRJ/t84W8+0kxwBm6A6sNEuUzeOnkZ24A=;
 b=Zqh3BXnt8qGiFhio5aKRAm7dHUkB62szkf5avO3xav8GkfqFgJymIAr3yYwkrUJPKE
 V0rylbjKU/xqPVN+gL7yFfRGNO8Gc7r/GSc9an8RNS0iRw15HrOxShq9YTySiOkLOXKB
 rTl1phqvO/DYZIUJFaGTKgAT0xwNDj2g77L+RHeJUpu08lHF/gUGmraGxtok1R5PjLbk
 shJDvf0kpU4qLgT0Qaj+U/iFftP0s3XfAjNcp3WB5g8mRyDFPRSJX5LVDmtHJO5Hs/C5
 y128qhKzBWPPW8qG+FPO5yrR6uqMUvBZjA9xWakbNR0QNBtL8YD0pjNnysv2tjRdJCHG
 +LGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Qs5bn0KByy2rMd5GAq45qi+lRfQDHHbS1rpiu8ef/9vS0DZDnj586G53DCFW2EzUbKIopqDkttokpRyKMc5STWNqW+E=
X-Gm-Message-State: AOJu0YyW+0SVL/4EIqcGOzQEC4YGL6eR55OcS0v397Y3nK1kkxsF/6oT
 CMZmWouqmLWvE33VHshhx2P/BHwApHWL5/tv2+cA5KW0QKqD/CNPCXQswQdUGfPwK4DN9zLLqHX
 +qHZVWWzUI3sIpuBQOlC0ZjFUzxForg==
X-Google-Smtp-Source: AGHT+IHnRqbB0EZ4Qbhj5cUIE7aYSncBn+9w2fE6BBJ/ZO8Qyuae3LsgC4Z+/TMn6eKUQhxp2avc2WjDoa+XH47q49k=
X-Received: by 2002:a05:6122:45a4:b0:4ea:edfb:8da6 with SMTP id
 71dfb90a1353d-4eb3a4f4c6fmr4997264e0c.10.1717631922115; Wed, 05 Jun 2024
 16:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240604062747.9212-1-fea.wang@sifive.com>
 <20240604062747.9212-4-fea.wang@sifive.com>
In-Reply-To: <20240604062747.9212-4-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2024 09:58:16 +1000
Message-ID: <CAKmqyKM_WQNV2=W=C5xe4wh99sbQUD7AWhYTgOOyqO=0_dW3jA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] target/riscv: Support the version for ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Tue, Jun 4, 2024 at 4:23=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrote=
:
>
> Add RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Weiwei Li <liwei1518@gmail.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

This should be the last patch in the series. The idea is that we add
support and then let users enable it.

Alistair

> ---
>  target/riscv/cpu.c         | 6 +++++-
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e9e69b9863..02c1e12a03 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_spec=
_str)
>  {
>      int priv_version =3D -1;
>
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> +        priv_version =3D PRIV_VERSION_1_13_0;
> +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
>          priv_version =3D PRIV_VERSION_1_12_0;
>      } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
>          priv_version =3D PRIV_VERSION_1_11_0;
> @@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
>          return PRIV_VER_1_11_0_STR;
>      case PRIV_VERSION_1_12_0:
>          return PRIV_VER_1_12_0_STR;
> +    case PRIV_VERSION_1_13_0:
> +        return PRIV_VER_1_13_0_STR;
>      default:
>          return NULL;
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 60fe0fd060..595d3b5b8f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCVCPU=
 *cpu)
>          cpu->cfg.has_priv_1_12 =3D true;
>      }
>
> +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> +        cpu->cfg.has_priv_1_13 =3D true;
> +    }
> +
>      /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> --
> 2.34.1
>
>

