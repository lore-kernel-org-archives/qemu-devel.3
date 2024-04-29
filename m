Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24559C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 04:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1IGR-0005lT-Ox; Mon, 29 Apr 2024 00:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IGJ-0005l1-Fi; Mon, 29 Apr 2024 00:05:07 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1IGE-0001Sw-At; Mon, 29 Apr 2024 00:05:07 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-47c10a4083fso1170830137.3; 
 Sun, 28 Apr 2024 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714363501; x=1714968301; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XCwxHUBqjpSBxkPLMrqSboNWe7+VBl/jWn5j9AclrI=;
 b=dvnq2Iw5SqOMtNtZvi1aMmYxYN6DNtGZvSX9dB5FBwlc4g4O8o9kf+BdpaewOwMK/r
 1eNBt250Vm6oj2VlPZThHLntFgdb801eKhUiLDhk8+KfJTWVFgFRY/YPSVcY1B1ZsEVW
 Le/Jhic/582Et1y7L8tY1XlHCDCyblF4aJTHpg5f2H3FDh/e/XR7F7QFxNId8hvTWBMk
 MY1KCVTuTip/eRIhowxEhmQmGV48CiMKic/W2An/9ho1Xyop1bNxhUF/pbtXTovKoLHe
 Rp4JxgsThru3U24LGAHwE7n8DXjs8cadX8LCJnXD1ylwxhbr86YZ07QcXZDCjAuoOOhc
 d4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714363501; x=1714968301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XCwxHUBqjpSBxkPLMrqSboNWe7+VBl/jWn5j9AclrI=;
 b=mMrtqR1kwvlSVQURl+2M14oR1aIAZMugx3pENCJMs6V5g05CvwuXXBke1s4LLutV10
 0D+Lw9JMoZJ8G/cEtu8Ol/eFw5QuSpCTnuJerIuni4g7F9fZe/M8vOfCeWeiN/f+op8h
 sWfcsVCIOJ/BAGd4AsLXaAbfMywN7p3FZvxGHENrptvXUh7As5+QNky9bDsq2wNeF+w0
 4icrHY3O+HGG81hnuy5lGEqT60hYA+S4hTpgHUXu8/T8UX/fbrivSPKUhuktgUOpif5q
 T3YZV8nqPDD8RQsA6iMRLy5cW3EJzLhC0l5P9R5gqqHYy0pKh5PItUvZOrdbkOixTWx7
 QGNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcO7bG2I/a2VeHJaHk0ulIAdLiOGJ7v+TjNweU12zVB5KNYqTkN6z0ciirmXF7+ZV8UX0pnZZzzjdUrN5Ch0MrU0pM8Ag=
X-Gm-Message-State: AOJu0Yw5gJgeStEoZFBNOh0ZxUZ19sTPckCBgZTR9RZQLM/DVvPoUJB5
 jxLxMwuTOyVgs68GMLBmAsUJW9FYkwwaQDaGLtRYn28glf8Mf2GNjCMa2TtPrmhUVKtup26v7Bn
 JMcA18Ln5xVTtAAbaZ3q7G/5B1x0=
X-Google-Smtp-Source: AGHT+IEI/0cEcHDf3UcIxmd2T9j5ecmxvBz4yWXRHMCB9B/xONvf93/O7E7r7TeuEikAYaVtvbTeSq5lr1T3+cCikk0=
X-Received: by 2002:a05:6122:36a9:b0:4dc:a1f6:4406 with SMTP id
 ec41-20020a05612236a900b004dca1f64406mr10816369vkb.3.1714363500884; Sun, 28
 Apr 2024 21:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-2-hchauhan@ventanamicro.com>
In-Reply-To: <20240314185957.36940-2-hchauhan@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 14:04:34 +1000
Message-ID: <CAKmqyKNoU8eFqxEHWo5qjcxpdAwt=BOzgK+7YF2vv5G3kyKZdA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] target/riscv: Check for valid itimer pointer
 before free
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 5:01=E2=80=AFAM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> Check if each element of array of pointers for itimer contains a non-null
> pointer before freeing.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..5f14b39b06 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -938,7 +938,10 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>          env->tdata3[i] =3D 0;
>          env->cpu_breakpoint[i] =3D NULL;
>          env->cpu_watchpoint[i] =3D NULL;
> -        timer_del(env->itrigger_timer[i]);
> +        if (env->itrigger_timer[i]) {
> +            timer_del(env->itrigger_timer[i]);
> +            env->itrigger_timer[i] =3D NULL;
> +        }
>      }
>
>      env->mcontext =3D 0;
> --
> 2.34.1
>
>

