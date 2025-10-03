Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45426CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 01:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Umo-0000FZ-RK; Thu, 02 Oct 2025 21:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4Uml-0000FE-Jp
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:40:39 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4UmZ-0003Yk-LX
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:40:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6228de280a4so3386837a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759455616; x=1760060416; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQLsGW03J6qGYR3m6WmNEfCYFNehMAesc3EQALbX4VQ=;
 b=h964Q/8ChHGugCRkLSkKj/BlIeFDXRpuYEBlCVD5/SO6AcruV4zSbO5JJHkzTBMHfK
 wOySvHk0FFid7K8+0Pc2ntARichmiJCTO74lKL5t1kNHh4kEAJCDhPzXjE4P9jfStpmm
 SPrhUnQ2jw7nwtc/yMWEA9w+KDTBFO7a/LYJCxeVY60VEgfYaaLiLqL+pf+HX2xdNInv
 e1w28hEUAOgwGzf3g2YO1EmGLqV8AJW4uA6V/wKFBf/n+XDBmlaRtFyF7XaXDfro7TFo
 n75NZT5BF1Dm1VlfxJU3HDNOegKD1bs5b8xvKBXksWXloEzDNKM8SMWhGzLYVKIQz9sn
 zH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759455616; x=1760060416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQLsGW03J6qGYR3m6WmNEfCYFNehMAesc3EQALbX4VQ=;
 b=S3UwWBtmrmMxEnehYJeQzAtntWwUx8uKcpa0f9Sz/K+KpEYr1WE35W2HUeDchnncfk
 HUIHeXQf7nY0FhDAnxsVegDmImyv4R7tvFJRwqU/d52HQzz+8nMZlHpx7UUZpos2IhLD
 0tyPBURf8/MKEfJlt6Z/w3CMu5UFs2pLV4S8EaiRxYTFhFE89ukbovl1jiDwslnTEV8q
 d7vsLn0N57JZk+4UM3jMWjPxDU/zRf1oqcgQwC213HxTo4TnWdawvz1ZVtM/iQOO9LLU
 E/znQievGRvE80rOvUi/JW7Iut2w/GWDidIvryIAGdxzZXvKgfRZmS0VGQjjgSBstVX4
 6Xbw==
X-Gm-Message-State: AOJu0YwfBAsU0oTqe3wvqX4oJEwaz4upEYHBGmgxnbcNwO9BB3Gcmsho
 Fbt8EaSzpPOqkNiH9hOa0FFLCeCETqvkxusyHx1WfxLrTzpq4TU5QLmrs6Wi5MI06aiT9TbLho2
 5MoOYqwAOdblInJV0zr9m6qAIHszOOWg=
X-Gm-Gg: ASbGncuHOQjyOvd86TnNh//Eu5L11NcvRIqkqUkh0nJvr+dDp3/m947dLcwWulxAYmp
 lkxbas7qrRk5+D8aETfO8NM66DBd4e70yziqoAd+MQYBHEq5YOapJ81frV7xofXWeVpzYFvqCQd
 L6B66BgRWZJlK4wcufcWChX0tglk9uIZUyTx+WevH/17HOrGwiX1xvlJy1OVfZn1+aKThy2wcuv
 ccPC+9QA/HNXHRhsIqbGUNZDzKusWYQaI9GRMj1gBgjKZ3G+RMC9EXuJADnqQ==
X-Google-Smtp-Source: AGHT+IG8bQn79UfIqcXPIRO9LkK1+e/em1ErwNENcJKKp0r+NIzzrGQ8ieaCDET84wujn5SuQ+NBuNzNzibsqbWbJ3k=
X-Received: by 2002:a17:907:94c5:b0:b3f:c562:faf7 with SMTP id
 a640c23a62f3a-b49c449b9b2mr176688366b.55.1759455615673; Thu, 02 Oct 2025
 18:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-22-alistair.francis@wdc.com>
 <d42e9b86-80d6-4357-8d8a-158a60db0eb9@linaro.org>
In-Reply-To: <d42e9b86-80d6-4357-8d8a-158a60db0eb9@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:39:49 +1000
X-Gm-Features: AS18NWB0_jM2P7FAkGBDMAWBkY6QIfyAIOLkNPbrgbdwB55raySzcaJb2oICYr0
Message-ID: <CAKmqyKMZwG6NDkZJqetFo+4ycEaRC6FmkH=KG5Vqyz-9aChy_g@mail.gmail.com>
Subject: Re: [PULL 21/30] target/riscv: Implement privilege mode filtering for
 cycle/instret
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Atish Patra <atishp@rivosinc.com>, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Aug 21, 2025 at 7:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> (old patch merged as b2d7a7c7e4e30fb5341d38deac968de675f9419c)
>
> On 18/7/24 04:10, Alistair Francis wrote:
> > From: Atish Patra <atishp@rivosinc.com>
> >
> > Privilege mode filtering can also be emulated for cycle/instret by
> > tracking host_ticks/icount during each privilege mode switch. This
> > patch implements that for both cycle/instret and mhpmcounters. The
> > first one requires Smcntrpmf while the other one requires Sscofpmf
> > to be enabled.
> >
> > The cycle/instret are still computed using host ticks when icount
> > is not enabled. Otherwise, they are computed using raw icount which
> > is more accurate in icount mode.
> >
> > Co-Developed-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Message-ID: <20240711-smcntrpmf_v7-v8-7-b7c38ae7b263@rivosinc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/cpu.h        |  11 ++++
> >   target/riscv/pmu.h        |   2 +
> >   target/riscv/cpu_helper.c |   9 ++-
> >   target/riscv/csr.c        | 117 ++++++++++++++++++++++++++-----------=
-
> >   target/riscv/pmu.c        |  92 ++++++++++++++++++++++++++++++
> >   5 files changed, 194 insertions(+), 37 deletions(-)
>
>
> > +#if defined(CONFIG_USER_ONLY)
> >   /* User Timers and Counters */
> > -static target_ulong get_ticks(bool shift, bool instructions)
> > +static target_ulong get_ticks(bool shift)
> >   {
> > -    int64_t val;
> > -    target_ulong result;
> > -
> > -#if !defined(CONFIG_USER_ONLY)
> > -    if (icount_enabled()) {
> > -        if (instructions) {
> > -            val =3D icount_get_raw();
> > -        } else {
> > -            val =3D icount_get();
> > -        }
> > -    } else {
> > -        val =3D cpu_get_host_ticks();
> > -    }
>
> I see this comes from old commit c7b95171881 ("RISC-V: Implement
> modular CSR helper interface"), ...
>
> > -#else
> > -    val =3D cpu_get_host_ticks();
> > -#endif
> > -
> > -    if (shift) {
> > -        result =3D val >> 32;
> > -    } else {
> > -        result =3D val;
> > -    }
> > +    int64_t val =3D cpu_get_host_ticks();
> > +    target_ulong result =3D shift ? val >> 32 : val;
> >
> >       return result;
> >   }
>
>
> > +{
> > +    uint64_t *snapshot_prev, *snapshot_new;
> > +    uint64_t current_ticks;
> > +    uint64_t *counter_arr;
> > +    uint64_t delta;
> > +
> > +    if (icount_enabled()) {
> > +        current_ticks =3D icount_get();
> > +    } else {
> > +        current_ticks =3D cpu_get_host_ticks();
> > +    }
>
> ... but still I wonder, why not use cpus_get_elapsed_ticks()?

I don't think there is a specific reason, I didn't realised
cpus_get_elapsed_ticks() is the way to go. Should this be changed to
use cpus_get_elapsed_ticks()?

Alistair

>
> Regards,
>
> Phil.
>

