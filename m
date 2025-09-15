Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B34CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 04:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0jU-0006Aq-T3; Mon, 15 Sep 2025 00:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0jR-00069k-Vd
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:22:26 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0jK-00056J-Sq
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:22:24 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b042eb09948so782688666b.3
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 21:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757910133; x=1758514933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jumm2xu+sZ/TP65LQQULuz9ZRHV2Yiy5Lh9gUoMfBTk=;
 b=TakRBarG49tGbkystmUWBtwRFJKNGTam6xrEolssfdFN+K6G9S3lSyXt7UC0sZ+KyH
 +1Xx7jFx1TwkaVQeSTRRcD1u7KGIQNnQSn53bauxaYl45PzfAKD4knDokPrkdKa5XFJz
 4KIwskIb3v1WHFB8AlUhVwwzkZtnHPgxSaC4DfW95iyg1HeKF/OlnUbNzewlb/UcLB1x
 g9IY04h03YgvHANRTkKXeIXOivSxXSzNqq1t+f443G1P5Rk3/aGhMnji3gqItI53wwNf
 jb7Bp3iUvfQvAH882KKTSf3uC3OIDLSfdDSxhtDWGc6Qq09OWtVZG0gDLsepUtAGnu0P
 Uw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757910133; x=1758514933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jumm2xu+sZ/TP65LQQULuz9ZRHV2Yiy5Lh9gUoMfBTk=;
 b=e96xeYEC3LI2il0nhlAVscDOEdtH1oBqSgwvPe6+ItAhTcqQnrzwFGhi9nJYH+8hbj
 mNvR+XsGqlnp5uCYoe+Yy3iFGs/qMqaBxrj6/cJ3SDs0wJbaDeLk9m7yYmfGOXL/fjtp
 lTsVsKmfkVYbMUI79Sc/ZWHhMyfLbjKumMv3h4ZurDUYp2NIRL/j1jsXi4CTC7bgBl/g
 CB8gyfboVNAlea83lNb5Qjxz93U7iDWLZKUtny1Fl0TBqb/pjw+9DuNTWinYTj7voNGF
 BhlHbmtH/EXvro8+Lurbn2DJPTRsl1pUY71fy9bVbYVtiBWur622M2EE+lPbLorXrqJD
 jBJA==
X-Gm-Message-State: AOJu0Yzo55mKla1NT+2lPoL7xNSoTWeA+cr7oDVwhv3lHQX0hWZ4Ezgf
 YpMynci5607R4WlnzJFCMgNq1sRalKopNu9ZmlGzFMkDqFI/JoTiXNkzNfq1OytXSO++1gd2A2Z
 lw7FFDCYRkZ8nucqz0MhV35gMDvsOA6c=
X-Gm-Gg: ASbGnctVui+39seCHj5qLEkyFJsTf3VB7LWeVi0psRX9xiuEATTLVe0+zhXV3fh7Up1
 vtibTThD2rc1VRN89cgSpa3X8bBKQPOgT1EmCZsBCcpKSUavLNvK8+jU3V0uSJd9upI65OhRGKN
 /iLcebINVhuNBaEePcHb6Q4fJLq/lo0OgI+kVgbVcD+ttxHw+j2N4iU93X65v15Gjk6wQUR0SXJ
 Uz7YUL8Soqm426TIiFY6i5ffMHlH1StrfO94R9230B0/fYj
X-Google-Smtp-Source: AGHT+IGJxV+QMjYWeJ1s5c+xhEcvtb5oaXBWDirMyP55GJIDpA9FsgxxY1Xa3lPycnDOgaooHHlTHEH3swk2f/U0E2U=
X-Received: by 2002:a17:907:25c7:b0:af9:eace:8a52 with SMTP id
 a640c23a62f3a-b07c3833af7mr1119115066b.50.1757910132676; Sun, 14 Sep 2025
 21:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
 <20250911-timers-v3-4-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-4-60508f640050@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 14:21:45 +1000
X-Gm-Features: Ac12FXwxVWkBg8Hizdafgdb9lCejHZ9lc71fnso-m1UPCpPDRKdXQuq7QzaMr6o
Message-ID: <CAKmqyKPFJMAy4YJNxsH=qaE9po65w=yeiT-ah6yNu77K3NCYcA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] target/riscv: Save stimer and vstimer in CPU
 vmstate
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Thu, Sep 11, 2025 at 7:59=E2=80=AFPM TANG Tiancheng <lyndra@linux.alibab=
a.com> wrote:
>
> vmstate_riscv_cpu was missing env.stimer and env.vstimer.
> Without migrating these QEMUTimer fields, active S/VS-mode
> timer events are lost after snapshot or migration.
>
> Add VMSTATE_TIMER_PTR() entries to save and restore them.
>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 1600ec44f0b755fdd49fc0df47c2288c9940afe0..51e0567ed30cbab5e791ea904=
165bc1854709192 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -400,6 +400,30 @@ static const VMStateDescription vmstate_ssp =3D {
>      }
>  };
>
> +static bool sstc_timer_needed(void *opaque)
> +{
> +    RISCVCPU *cpu =3D opaque;
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (!cpu->cfg.ext_sstc) {
> +        return false;
> +    }
> +
> +    return env->stimer !=3D NULL || env->vstimer !=3D NULL;
> +}
> +
> +static const VMStateDescription vmstate_sstc =3D {
> +    .name =3D "cpu/timer",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D sstc_timer_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_TIMER_PTR(env.stimer, RISCVCPU),
> +        VMSTATE_TIMER_PTR(env.vstimer, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 10,
> @@ -476,6 +500,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_elp,
>          &vmstate_ssp,
>          &vmstate_ctr,
> +        &vmstate_sstc,
>          NULL
>      }
>  };
>
> --
> 2.43.0
>
>

