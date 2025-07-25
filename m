Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F347C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufM7J-0005mM-OF; Fri, 25 Jul 2025 13:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufM5B-0002nO-0w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:19:45 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufM59-0006oS-3P
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:19:44 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso2190846276.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753463981; x=1754068781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+AOLPPXVd4dLYqDyvaOFlS8EsXEms8ZuY+ijCYuOb4Y=;
 b=LZxsraRxBMlamMGOl8mXYTpzMuf4aDahtBM/tzCvRG7/KySSjDEGHELcIwqomJ5tzK
 ge3PXfeLL4Va/WfkTHeakK6Fnhf8Rc25O0CxZBVBrl9H1zqWSDYkbDcF47VpYYmUH4xn
 hjPhtddZXPT+e5xSbyHE9Ny3lzPpX426GDaYsCsl3LtQwRj5jNDKdKuAwRy1+ox91wPJ
 Uk+kgQzhCaTNQwr58Z3KnEJ3OtRRk97id11AH4gApa6/uyefOyTHLvWObPdMKhtg9CZ4
 gRmy6BKWSugyJ7tFVLhX7pNkTXaucsAnNlS11NBDOZqmIMpnOrv/8fWDoNDb8pO0F+TD
 TgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753463981; x=1754068781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+AOLPPXVd4dLYqDyvaOFlS8EsXEms8ZuY+ijCYuOb4Y=;
 b=IETZwgFtfD9vHwmcBoGP85lW/VhCjoqVm5mKgeY9Y1q9SL2v9UbJYlUkMjBODAmCcz
 dHqvBjIl2QjAUDp/N5DyOclu/hJ70tifRRHo4VMEYoYbrcUmQWquwn/KFbcIsk49gzkn
 QLrIyERABUoPyS9cH5P9tV4uFlZkb9obTn07YsOOpPj72oSYPfBE9LR70/+9hqneEMuA
 eph1e+JI7ioNuBy4n4jeB+rB7gjWloKe+Kc000zdkMlK9tHin9uzKtMbqqHqUz4B+/HD
 5gHNVwBo5XG3vIc1hesqhCK1ae4WaFaZ9QW4dWTcL529P48hEFBQ9E6gtS/dWUoLMz0r
 5eKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2WniF49KPzORpbL5HqdNuNE4gpAiQ3E1oNgQ9FGWk0BrLvWx602QvEcoUA52CxcM6QPk7+ZTh5Fot@nongnu.org
X-Gm-Message-State: AOJu0YxEvt9yihy38YgS8NBt1OKCdZZL2ZED71Ub11clKrSU/DyCa0ZQ
 0m9NMAMB1T59BWLeXzNiH6EQs76/tnLzB5S3hUEYr9kiYGaLM9P3KJXUXI2clrOK+0qDSPl+SPH
 6tfxmmDMH3X12cXJyByxnThqHlKzj6itNl2GKNLC8Vg==
X-Gm-Gg: ASbGnct2PrtNK1zfU6IW3reAMNxABMZ2HzYvKc1zkGC2CbaLalkJquWf6iqAlqVnow2
 r0yilclX2ttvFxye4aog0syuBFrb25di1/nH2rM4e4NK/P/ukAdIJTTYViSrxmNawb44IbAN7bb
 YIP7a1kNibpy6tJoetuCbd5WczgSCKoStVTkynPgAyfF4kakuJzUzhWapVckwmc8IGejLqRQXqc
 QsS52xO
X-Google-Smtp-Source: AGHT+IGy6sG9fpW3pNh1viVVOXDpIU8CFgNZJDEMW8s8lIj71W9SG2GPe10Rop+ZzT3DhI96mha3lQbv6Wdk+Jy6nRg=
X-Received: by 2002:a05:6902:4810:b0:e8d:cf0d:2d2c with SMTP id
 3f1490d57ef6-e8df0fbc67dmr3160531276.0.1753463981462; Fri, 25 Jul 2025
 10:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
 <20250725142240.3760452-3-peter.maydell@linaro.org>
 <f747d280-6d43-4672-9ebe-14151c852cdb@linaro.org>
In-Reply-To: <f747d280-6d43-4672-9ebe-14151c852cdb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jul 2025 18:19:29 +0100
X-Gm-Features: Ac12FXyGu9JueBu34DDmehDlbAaDhzXyK3OvKXUIeLrlG6_hfrnaVkNqX_kTwcw
Message-ID: <CAFEAcA_h6p12cZ3xKYVUC7JASRRd4j1H8mMVbmqMk8ApeYdCuA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC
 signal frame record
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 25 Jul 2025 at 17:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/25/25 04:22, Peter Maydell wrote:
> > FEAT_SME adds the TPIDR2 userspace-accessible system register, which
> > is used as part of the procedure calling standard's lazy saving
> > scheme for the ZA registers:
> >   https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme
> >
> > The Linux kernel has a signal frame record for saving
> > and restoring this value when calling signal handlers, but
> > we forgot to implement this. The result is that code which
> > tries to unwind an exception out of a signal handler will
> > not work correctly.
> >
> > Add support for the missing record.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   linux-user/aarch64/signal.c | 46 +++++++++++++++++++++++++++++++++++--
> >   1 file changed, 44 insertions(+), 2 deletions(-)
>
> Oh my.  I spent yesterday working on this and other signal handling fixes.  Though from a
> FEAT_GCS starting point, so I still hadn't seen the clear tpidr2 on signal delivery change.
>
>
> > +static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
> > +                                       CPUARMState *env, int size)
> > +{
> > +    __put_user(TARGET_TPIDR2_MAGIC, &tpidr2->head.magic);
> > +    __put_user(sizeof(struct target_tpidr2_context), &tpidr2->head.size);
> > +    __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
> > +}
>
> Drop the unused size argument.
>
> > +static bool target_restore_tpidr2_record(CPUARMState *env,
> > +                                         struct target_tpidr2_context *tpidr2)
> > +{
> > +    if (!cpu_isar_feature(aa64_sme, env_archcpu(env))) {
> > +        return false;
> > +    }
> > +    __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
> > +    return true;
> > +}
>
> The sme check is better placed in target_restore_sigframe ...
>
> > +        case TARGET_TPIDR2_MAGIC:
> > +            if (tpidr2 || size != sizeof(struct target_tpidr2_context)) {
> > +                goto err;
> > +            }
>
> ... here.  Then target_restore_tpidr2_record has no failure modes and can return void ...
>
> > @@ -497,6 +530,9 @@ static int target_restore_sigframe(CPUARMState *env,
> >       if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
> >           goto err;
> >       }
> > +    if (tpidr2 && !target_restore_tpidr2_record(env, tpidr2)) {
> > +        goto err;
> > +    }
>
> ... which simplifies this.

Mmm. I wasn't sure to what extent we were trying to follow the
kernel signal.c (which defers essentially all error checks including
sizes to its restore_*_context functions, so that the "switch on
type of record" function is pretty much the same code for each
block, whether it's a complicated variable size one or a simple
fixed record.

-- PMM

