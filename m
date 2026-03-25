Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43884FEA801
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ebb-0008JJ-VX; Tue, 24 Mar 2026 23:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5EbU-0008HQ-JM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:08:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5EbS-0006T5-GT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:08:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so2874067a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408097; cv=none;
 d=google.com; s=arc-20240605;
 b=XiDPOWe362+TEcP+tv5QCI7PvM58/VLmH+W7OPWKJHtftEUjqwoGMPzNTdKZCxc1In
 3zjtDjY4+FZJ24HP7JaEvCQS08nJnWu2O9Wlr68njHsJxrsy3Du7THRJL4MbqBeKZNuf
 o82f1GjmFMaoWs1GUlXKNUkK7eeHnQSuIGrkpSOutRgQhRhKAv9s+SGVLjd81a1IO+Pz
 ifR/r9lBVnDIt9gpKJSB1q6Y7UVyhd8xTsG8+RjCGpZea+TT1p1+Wrq/Nlle+nZHMiF+
 YSyx0/ZCMoy/rxZC51jGMB3sJOJ43pIr31avwUaQ3q0EKO6K/KREee3vas9VzetXxyA7
 qN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O13OSwGI8HM5d1dMYjjI+VWWuu28+zY3HI6x7fAYwZM=;
 fh=m5oKrkuo9UOwL6I6rd3EY1SpWeob6v9TKXwmvMvymTg=;
 b=e0SOJM6jcjnZNOXuK6K9DYN2NSv8Syk81IdEL9UqabywT60BsBYnAfDGwMvXuGH1DV
 fvPf3AMxwyPOkX7P9+RqH9N4I4sdp2RCr1nzVkxTaHy/GDdqtwzKyNpKDQxP75FOZtnv
 z7sGuq0JB1rdmsQHy12e+Qg9J4KKBWZQ/9HgE2AYgNxN4j9FUC8estP7e+EiiOMfqKjT
 6zfwrfR14ZH71z32ZpANR6FXFlc9Hvmrb+ZJ2OezHRFs6z0I1lEMyPlOM+XSkpWt/L7/
 prsCZq7Uudfwy2o6hZz/iSdbSTY2jVyWHVeRnB68e822wtHBaLAoKGdORZTqmBnWz/I0
 no7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774408097; x=1775012897; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O13OSwGI8HM5d1dMYjjI+VWWuu28+zY3HI6x7fAYwZM=;
 b=EC90ZIUTCIlPw6fn8FfeeYvvTfMrt6MflDINKxD/ilmSsfvolpStgCajotvdRUnI3z
 M+ZJiPVSWRhx3BmFDS3gv8Dy6jFH2towtrtxR5piXv7yWT0lara57HPVV9o1brr7+jJq
 iuMdviPHTeeBDE3ic++uNI9LXJs2Vgk+MNtl4KwTcd2uB14ph3mJhRlulmhqOvMiZjqZ
 ZMQ0dIyyi5KqsDr11L1WygqNXtgldAW7Efq05bwl6iXs1ISW++8ouur6DNoaoe1J4lOh
 gosLk0VW5imeH6YYzy9Q1Uk+jpVulNh8s5+D/LFWR7tgpIxtxYdrna1a+WWo1VHFUFab
 LTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774408097; x=1775012897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O13OSwGI8HM5d1dMYjjI+VWWuu28+zY3HI6x7fAYwZM=;
 b=JVvu/cCJTpll7yDZ7i96waT5WqDvwyeJMRl3x9L7/php8uLFZJVhnVLskNJQgHHNN2
 YiUZz5BSDuP0l48O0cviWfKJd0MF5L5fCLa4I6uF5XtW4HnCxzMgO28oEuXgqQNF9ERJ
 rNsr0X0eAQoynK4Pq+87TCgrzhSBBDL+2Mwi5+Bp+j/PQkJe974SebnIRe4qpJzzlNQl
 ZMqPYqA+2/oynVIZ8U+hZrwWKFtpxaHCy6b1XmZJ87Yt2hDXaWNS7RME1NyGFYgYEubu
 tubJhMXDihARrfq1nWRHuQoTtqe+MsEP2tsSut1DLwiNwlTDYP1e3oGfyuqzHObCZQoW
 00jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZsCuuOeJFsCr08f9LFXFqk3mPwwc64fSky8IelCWdiFBPfc5jqWNNGziqifS7zHbPJKdiOT4/3oq@nongnu.org
X-Gm-Message-State: AOJu0YzYw2fgsvI6kKb5Cx/owYAGw2qe4XnTRf7fV2WvPGH6nf6/HqN7
 Pm6E7e11UJ+KSstaMRoSu/+6ItXSOrC0oz7LRSr2JRkXgxK7g/3E1RfLYggXWf9TAZM2yGdzflq
 95GgY49/KveGfC+9AV7buClTmHPHgBl8=
X-Gm-Gg: ATEYQzyovFdRo8x3fLySF4XobT1jZSth2UFFipScASlx8Rcot7z+pGjAH+giaza8r2t
 DX3RLDFuvIBjfyjbNomGLm7YRDkVZ9HpybPbQJSkDfB3SbVC+/wxUljNSWdxNGnaFXC1ts+72jw
 tWPFhwt/dBkN5zerWO5uKWMY+vb2qE1EkdG3drTwXGqSYU+TlJ/QSoNN+JH36yd/o/AqM8AttkA
 WpuGamfv0ehLTAtNpSBXf2vV9/BBiKN4jL0KpsEWV1K4Es6gC3sUhB8474hfWu1s482XFhRGSPk
 057Jn1hP1R5OmDBMB8jIx95adhpt/bPH/YKoTcivpgMQgpUX
X-Received: by 2002:a17:907:3ea5:b0:b98:36cd:7e11 with SMTP id
 a640c23a62f3a-b9a54283404mr108058366b.45.1774408096560; Tue, 24 Mar 2026
 20:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <20260321141345.599105-3-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-3-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:07:50 +1000
X-Gm-Features: AQROBzCibXsoTN5LKSm5vdAqH4qxVs256sC_tBtkkP8ZcByW54VnzMHCaEvBZPA
Message-ID: <CAKmqyKPzEpAT_4gOJBfamV_7m4uVCR5681Lb9GiQYur+hqQLZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] linux-user/riscv: Allow restore_sigcontext to
 return error
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 22, 2026 at 12:16=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> Linux can return error from restore_sigcontext in some conditions, which
> forces a SIGSEGV. Plumb through this error handling which will be used
> by the next change.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/signal.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 22b1b8149f..ece276f85f 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -145,7 +145,7 @@ badframe:
>      force_sig(TARGET_SIGSEGV);
>  }
>
> -static void restore_sigcontext(CPURISCVState *env, struct target_sigcont=
ext *sc)
> +static bool restore_sigcontext(CPURISCVState *env, struct target_sigcont=
ext *sc)
>  {
>      int i;
>
> @@ -161,9 +161,11 @@ static void restore_sigcontext(CPURISCVState *env, s=
truct target_sigcontext *sc)
>      uint32_t fcsr;
>      __get_user(fcsr, &sc->fcsr);
>      riscv_csr_write(env, CSR_FCSR, fcsr);
> +
> +    return true;
>  }
>
> -static void restore_ucontext(CPURISCVState *env, struct target_ucontext =
*uc)
> +static bool restore_ucontext(CPURISCVState *env, struct target_ucontext =
*uc)
>  {
>      sigset_t blocked;
>      target_sigset_t target_set;
> @@ -177,7 +179,7 @@ static void restore_ucontext(CPURISCVState *env, stru=
ct target_ucontext *uc)
>      target_to_host_sigset_internal(&blocked, &target_set);
>      set_sigmask(&blocked);
>
> -    restore_sigcontext(env, &uc->uc_mcontext);
> +    return restore_sigcontext(env, &uc->uc_mcontext);
>  }
>
>  long do_rt_sigreturn(CPURISCVState *env)
> @@ -191,7 +193,10 @@ long do_rt_sigreturn(CPURISCVState *env)
>          goto badframe;
>      }
>
> -    restore_ucontext(env, &frame->uc);
> +    if (!restore_ucontext(env, &frame->uc)) {
> +        goto badframe;
> +    }
> +
>      target_restore_altstack(&frame->uc.uc_stack, env);
>
>      unlock_user_struct(frame, frame_addr, 0);
> --
> 2.51.0
>
>

