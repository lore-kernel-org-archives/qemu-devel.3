Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A8CCE7AA8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPBp-0002fE-4K; Thu, 05 Sep 2024 22:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPBm-0002ci-PR; Thu, 05 Sep 2024 22:59:11 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPBk-00039a-Uc; Thu, 05 Sep 2024 22:59:10 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5019d48b1aaso136981e0c.1; 
 Thu, 05 Sep 2024 19:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725591547; x=1726196347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scxXtJAi4fhmV/EpIEXsQuThYjMsY3hoM7pWPhmwXqA=;
 b=dBxSHt1gJyfJy5hGsMpGw6w+AvId976xvczJBueIt/fYZMjCE/szulbLxLaXymBBIc
 Sn6x7P+m+w0wkEF33hhJpZGzLZyYU3vwkl3iJ9trUKY08zaDCyaiIoBYxCeOra9wVr8J
 Jh/iGShgJsSywSZe8yyyDKtfmMIlboZR4p0k+0c4LDRIXy5QDvIeKZibh1sNuwnOw2ZV
 M0It+FJW+Jgpe6UFzyvpqxxW0sVX1gkEq8BgCaeMIzuWaV5+90ij7RQJzPpEIU8RQlNL
 vqtcCRTNlsbSvfKPE/x2ugMc63cZYqKQAEbawJOcAPRRFHloClMFh+8D8+dV6aP82XBI
 93mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725591547; x=1726196347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scxXtJAi4fhmV/EpIEXsQuThYjMsY3hoM7pWPhmwXqA=;
 b=PXaMBVYeIwyr3PZl0jbUkvTUt/141+Jcfm9lEoswBE1vNeRXV0PDErmPmqIRKdINmw
 z5ItnYonjrdkHehhbNVoiKngTCqXxSgEMSv4Q9nBRQx3BUI9BV0oaKEkUuqO9lg4vdEE
 HYZjeejE11YkjQo06G0BLlz/vKEo88RQtawELHn7/mfsHrsZus6HpDRnRn2dlW4Sh/+6
 K8NFcjrS20l4XvKRfKp0mTTYHi0vU55NhRRM4fmHhSsZAhC25dnbX2aJqJPxWgYjs9I+
 0bBgLLfogvR1U6tFft8wxzn3/uiXpSCsK5XeHnLT4TrZesq3TN2b+Khqiupf50OhdW3X
 rUYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFDlFU3A7sPn+qMzkbxSEDmTQXmeZivDO/nfCUFDbGUA1vieK01Y+nirZIF+TdFaOJ2ALN4G+RAdQn@nongnu.org
X-Gm-Message-State: AOJu0Yy5GrNDDROnlTZadbogODpLjulSYsmWhlo8IS86QxVg8ZmBk1X2
 AWKfCeQcO5E/Zy1x6t43QgU+ynW4BfLg2AaXJETM0KIXKc3qDd1ku6OIIsZ44w38yrAOgazQ793
 LcPeeJe32Tz1se4MuidqJvxpeTaE=
X-Google-Smtp-Source: AGHT+IFGvjY2Gz8HaL3vaidatyg86xgqS7S69vsiSAD1t6dFQXZzIojsNc7IM/A3c1nWLtFH4v+7mNm4TTcA32HPEOU=
X-Received: by 2002:a05:6122:1828:b0:4ef:6865:8ffd with SMTP id
 71dfb90a1353d-4fff16970aemr26341352e0c.10.1725591547253; Thu, 05 Sep 2024
 19:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-8-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-8-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 12:58:41 +1000
Message-ID: <CAKmqyKN+emnjxdCdX9_kBEqZoo4OtdJeSearxEB3o-Ak374tQw@mail.gmail.com>
Subject: Re: [PATCH 04/11 v2] target/riscv: Update CSR xie in CLIC mode
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Tue, Aug 20, 2024 at 2:15=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> From: Ian Brockbank <ian.brockbank@cirrus.com>
>
> The xie CSR appears hardwired to zero in CLIC mode, replaced by separate
> memory-mapped interrupt enables (clicintie[i]). Writes to xie will be
> ignored and will not trap (i.e., no access faults).
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> ---
>  target/riscv/csr.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 9c824c0d8f..a5978e0929 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -30,6 +30,10 @@
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
>
> +#if !defined(CONFIG_USER_ONLY)
> +#include "hw/intc/riscv_clic.h"
> +#endif

This doesn't seem like the way to go

> +
>  /* CSR function table public API */
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
>  {
> @@ -1805,16 +1809,19 @@ static RISCVException rmw_mie64(CPURISCVState *en=
v, int csrno,
>                                  uint64_t *ret_val,
>                                  uint64_t new_val, uint64_t wr_mask)
>  {
> -    uint64_t mask =3D wr_mask & all_ints;
> +    /* Access to xie will be ignored in CLIC mode and will not trap. */
> +    if (!riscv_clic_is_clic_mode(env)) {

We can just implement this check, it's only two lines

> +        uint64_t mask =3D wr_mask & all_ints;
>
> -    if (ret_val) {
> -        *ret_val =3D env->mie;
> -    }
> +        if (ret_val) {
> +            *ret_val =3D env->mie;
> +        }
>
> -    env->mie =3D (env->mie & ~mask) | (new_val & mask);
> +        env->mie =3D (env->mie & ~mask) | (new_val & mask);
>
> -    if (!riscv_has_ext(env, RVH)) {
> -        env->mie &=3D ~((uint64_t)HS_MODE_INTERRUPTS);
> +        if (!riscv_has_ext(env, RVH)) {
> +            env->mie &=3D ~((uint64_t)HS_MODE_INTERRUPTS);
> +        }
>      }
>
>      return RISCV_EXCP_NONE;
> @@ -2906,13 +2913,13 @@ static int read_mintstatus(CPURISCVState *env, in=
t csrno, target_ulong *val)
>  static int read_mintthresh(CPURISCVState *env, int csrno, target_ulong *=
val)
>  {
>      *val =3D env->mintthresh;
> -    return 0;
> +    return RISCV_EXCP_NONE;

This change should be made when these functions are added

Alistair

>  }
>
>  static int write_mintthresh(CPURISCVState *env, int csrno, target_ulong =
val)
>  {
>      env->mintthresh =3D val;
> -    return 0;
> +    return RISCV_EXCP_NONE;
>  }
>
>  /* Supervisor Trap Setup */
> @@ -3059,7 +3066,10 @@ static RISCVException rmw_sie64(CPURISCVState *env=
, int csrno,
>              *ret_val |=3D env->sie & nalias_mask;
>          }
>
> -        env->sie =3D (env->sie & ~sie_mask) | (new_val & sie_mask);
> +        /* Writes to xie will be ignored in CLIC mode and will not trap.=
 */
> +        if (!riscv_clic_is_clic_mode(env)) {
> +            env->sie =3D (env->sie & ~sie_mask) | (new_val & sie_mask);
> +        }
>      }
>
>      return ret;
> @@ -3337,13 +3347,13 @@ static int read_sintstatus(CPURISCVState *env, in=
t csrno, target_ulong *val)
>  static int read_sintthresh(CPURISCVState *env, int csrno, target_ulong *=
val)
>  {
>      *val =3D env->sintthresh;
> -    return 0;
> +    return RISCV_EXCP_NONE;
>  }
>
>  static int write_sintthresh(CPURISCVState *env, int csrno, target_ulong =
val)
>  {
>      env->sintthresh =3D val;
> -    return 0;
> +    return RISCV_EXCP_NONE;
>  }
>
>  /* Supervisor Protection and Translation */
> --
> 2.46.0.windows.1
> This message and any attachments may contain privileged and confidential =
information that is intended solely for the person(s) to whom it is address=
ed. If you are not an intended recipient you must not: read; copy; distribu=
te; discuss; take any action in or make any reliance upon the contents of t=
his message; nor open or read any attachment. If you have received this mes=
sage in error, please notify us as soon as possible on the following teleph=
one number and destroy this message including any attachments. Thank you. C=
irrus Logic International (UK) Ltd and Cirrus Logic International Semicondu=
ctor Ltd are companies registered in Scotland, with registered numbers SC08=
9839 and SC495735 respectively. Our registered office is at 7B Nightingale =
Way, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cir=
rus.com
>

