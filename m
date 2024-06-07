Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB46C27C5E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 01:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFOB5-0006wm-6l; Thu, 06 Jun 2024 21:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sFOB3-0006wY-Sz; Thu, 06 Jun 2024 21:13:57 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sFOB2-0008Rv-8B; Thu, 06 Jun 2024 21:13:57 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4eb236e27adso490727e0c.2; 
 Thu, 06 Jun 2024 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717722834; x=1718327634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VVamNqwn3NCn58TIfBAlHEWasFi1+faLZkARLd1OqY=;
 b=YyrQIFVViW9dSKcFYS4T3uUZSbDP3bRoIfl00ejmuHnp0Oy+L6Ibj/GBIGhwqKzBmL
 eRTQsLunhrtqtf3UU1F3oEWcpn3ue34zdvh8GJ7F9NwM67BuAWNsStv6yx0NWXpFStIR
 mvec/80LnqEVb3LRiosuGqEh03ot4EyUvG7VYesEmZL8AKrsRDoPKLD00r6gLKSuIWTR
 qI4LexhPrl5ZW6DBAU7uezIeHsYQ/mo2DKaYp8iUb+nGNle+q649NSgusp9QRAx+Q8c4
 LFLcSawfs8V0ApKiOd28sW3b11CYfMYRQHgX/kj/8Sg5bhZo8AYOPDbS68JKr0fUdcI/
 FoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717722834; x=1718327634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VVamNqwn3NCn58TIfBAlHEWasFi1+faLZkARLd1OqY=;
 b=RIn1/1ylHzFXKOtpAPBEOTrLEMHx67avK9QRWG5EH2QQDAUetDMGSgBuLoTpmkfHPK
 wc7pUJZSKI6YulDPNeRrG0aAzse4GoFHxfFLR7Sbm1DfvFFQR2oR8HEIZArzmeASOIta
 5m6TmLe1w2Llpvb9AyCpQ9r91sR2QMOuiW+/Tzi7srfZdRhRRmYDLV874MjyJ138by6/
 XwROJf9GraiLvHlUeKVGitx182uO6vWEX5MhLI/pqJmr2P4ak7hCqTiMBtIooqnrm/tF
 KqeeoW2/TbgnlUnBbWDoME4OyMPODWr4scRYWDuzHlqaaCTG7YdZaE89vCeEJsNj1/tL
 SJWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXALgk38ul8xW4Z54luZH5JW54+usDCVrm4dnF+AlZGiLSAAGeqdp/0RHEvdsnXWtofbheva+DSNKcOKb6uWkjfzxTNxk0=
X-Gm-Message-State: AOJu0YwkwbPJhfeHNM5ylf4w60NMrxlrv5k3xSVQ0tt+vf5/RCFWVjPg
 AXXwo9k1iPf87j2cQNDQH4qE5BKiLZFSmiaLEFJAgTfv3u4JhT2loQszXDfeNKfpETarMpyvZwX
 8/OHb2lttvdSzjnGN2d0NrqEwIOI=
X-Google-Smtp-Source: AGHT+IFazOw7XbNYxsiokdd0Y0syoJlKT7kvZatbx47I96buS6oj4QYH6wQBWthjcupYBlBw4OGuJ1c4YudTcbiPOzY=
X-Received: by 2002:a05:6122:4592:b0:4d8:7b33:c624 with SMTP id
 71dfb90a1353d-4eb5615a33emr1678867e0c.0.1717722833799; Thu, 06 Jun 2024
 18:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240606135454.119186-1-fea.wang@sifive.com>
 <20240606135454.119186-7-fea.wang@sifive.com>
In-Reply-To: <20240606135454.119186-7-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Jun 2024 11:13:26 +1000
Message-ID: <CAKmqyKOwVE56P1--w0faiYb=96KJeBAeZ+qhC95s6YfYO8oFaw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/riscv: Support the version for ss1p13
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Thu, Jun 6, 2024 at 11:51=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Add RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Weiwei Li <liwei1518@gmail.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 6 +++++-
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fd0f09c468..4760cb2cc1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1779,7 +1779,9 @@ static int priv_spec_from_str(const char *priv_spec=
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
> @@ -1799,6 +1801,8 @@ const char *priv_spec_to_str(int priv_version)
>          return PRIV_VER_1_11_0_STR;
>      case PRIV_VERSION_1_12_0:
>          return PRIV_VER_1_12_0_STR;
> +    case PRIV_VERSION_1_13_0:
> +        return PRIV_VER_1_13_0_STR;
>      default:
>          return NULL;
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4c6141f947..eb6f7b9d12 100644
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

