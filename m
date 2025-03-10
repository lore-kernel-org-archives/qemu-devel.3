Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A0C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 23:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trmCT-0004ML-4F; Mon, 10 Mar 2025 19:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmCP-0004HY-8x; Mon, 10 Mar 2025 19:06:17 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trmCN-0005vh-Ag; Mon, 10 Mar 2025 19:06:16 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-523dc190f95so2090731e0c.1; 
 Mon, 10 Mar 2025 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741647973; x=1742252773; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQTfrPnkvMG9SwLXAFTWjvSu0VEEHfWFdLc6vfIZOGg=;
 b=azt2GD/c3N1aXG3grgnw1P7z4yjAWwY94+X55l+oDBEkrEscMwCh6FxhRKnAVTzTsR
 vpJPqBCL/5eovbpOn1KnlAysfioGAKhLJX3vacqtSuj8ynY9HDHf1pl7GbVPHZQZmTwn
 9HaKcLj8JcR6DXrCMqWzOkalI/a3/dIdJ05jA3QhCvOeMpcklpnnAFKPL3ryyGq7V/nq
 vlyHj9gflnAvAUJx0fVJndpxDbmnHTQmkK6d4xHOx47l9K+fdUArcofx3OUBd1A3WxOK
 R8yNoklhitUlbqi5Vrjhjs/JfFUnOzEo2a6XUfkUdRgVRMC8v7nCYDFlMO76VTvju6Ul
 qHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741647973; x=1742252773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQTfrPnkvMG9SwLXAFTWjvSu0VEEHfWFdLc6vfIZOGg=;
 b=ORLxtI+T+prBEGDnJLNZ5aYSxKN2g3PGt49VjOOvfMidjoFzBE0m5BjeZHbZtLMbBQ
 fM+EsiRYNJve87kdVbOTbtKgd0Uc70sSwLEGhnJrBtQlfEWZzRs5yiuyPW4PgC59OzpQ
 SpDGEJRHw7GP9qaHrVswIb9h2D8isKx1Tp7mFxrZcsz3+Jz5c5pZFxGllL5ozLajPvTX
 2JZf7DzG8UF/qqP/srR9EvViVMTxj9O/nqCXe2pb4lqoesHSbWAn12MJLPqypd0m24Qu
 sh+TiG+es0XlC+/dyyrNNIkpZbIKsc8G3SyOTL+9L6hpAccz0acrk+LzJg0LIiINk3XU
 RuIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOtNe/caFZeB60heDeIzUZhmJ0t1Rqa23tzydiYjUCoUx1NmO2FloXcNTpFn59iAMM7i3LuGB1MEakA==@nongnu.org
X-Gm-Message-State: AOJu0Yy3uQyBO7W+3VWK/S9CchAxZzLTRSN5JVYUs6u+V6BsWNKrz1QK
 2t9yUxTiEY9Y3uA1OaJxL1BTS9pL/9bq7wQxlyC+wNAYG47pfkwD3XCc7xrCqZNK3LmI4vLl1eW
 WfjUZmqQySEjz1OJ4i5B5/X0vc7M=
X-Gm-Gg: ASbGncvx3+K814t/QLixojxzehRi3HWRUobIEYvOk+3wZUjjadDXptgh8AmrElS6RaX
 1o8TOUc6UAVIDN1mgwI1sRQ9NGMRy/w7My0SyoxFt2ROTJ6g6x8VpsrKGfIxWqh5zpZCt+lu0rq
 Ycm/zeknlK1GxHx/wRjsXtccxnsH1nsHOwHkbPI0ub8c9eJKUa7FI4po1k
X-Google-Smtp-Source: AGHT+IFtBmPN0xQx5WHHy7Wk/ZfMn58692fAJb7Qd9n+SqwKu5yRgllNYQ678TeZhFnj7eH7YBpeIQwcajQYOAuhaOg=
X-Received: by 2002:a05:6122:1809:b0:520:60c2:3f1 with SMTP id
 71dfb90a1353d-523e3fd2c81mr9263678e0c.0.1741647973508; Mon, 10 Mar 2025
 16:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-3-richard.henderson@linaro.org>
In-Reply-To: <20250308225902.1208237-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Mar 2025 09:05:47 +1000
X-Gm-Features: AQ5f1JrZ3wnO-74GGkDMelHNHV6zi7Vuxesyr7GBV1J9m8bJxNq52iePxBWrkIA
Message-ID: <CAKmqyKPVJYuNLhdK1iQrTNbHe5xkP=oDJ3E4xH=Zk_wgpm7TmQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Sun, Mar 9, 2025 at 9:00=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The third argument of the syscall contains the size of the
> cpu mask in bytes, not bits.  Nor is the size rounded up to
> a multiple of sizeof(abi_ulong).
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Andreas Schwab <schwab@suse.de>
> Fixes: 9e1c7d982d7 ("linux-user/riscv: Add syscall riscv_hwprobe")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/syscall.c | 55 +++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 02ea4221c9..fcc77c094d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9118,35 +9118,38 @@ static void risc_hwprobe_fill_pairs(CPURISCVState=
 *env,
>      }
>  }
>
> -static int cpu_set_valid(abi_long arg3, abi_long arg4)
> +/*
> + * If the cpumask_t of (target_cpus, cpusetsize) cannot be read: -EFAULT=
.
> + * If the cpumast_t has no bits set: -EINVAL.
> + * Otherwise the cpumask_t contains some bit set: 0.
> + * Unlike the kernel, we do not mask cpumask_t by the set of online cpus=
,
> + * nor bound the search by cpumask_size().
> + */
> +static int nonempty_cpu_set(abi_ulong cpusetsize, abi_ptr target_cpus)
>  {
> -    int ret, i, tmp;
> -    size_t host_mask_size, target_mask_size;
> -    unsigned long *host_mask;
> +    unsigned char *p =3D lock_user(VERIFY_READ, target_cpus, cpusetsize,=
 1);
> +    int ret =3D -TARGET_EFAULT;
>
> -    /*
> -     * cpu_set_t represent CPU masks as bit masks of type unsigned long =
*.
> -     * arg3 contains the cpu count.
> -     */
> -    tmp =3D (8 * sizeof(abi_ulong));
> -    target_mask_size =3D ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
> -    host_mask_size =3D (target_mask_size + (sizeof(*host_mask) - 1)) &
> -                     ~(sizeof(*host_mask) - 1);
> -
> -    host_mask =3D alloca(host_mask_size);
> -
> -    ret =3D target_to_host_cpu_mask(host_mask, host_mask_size,
> -                                  arg4, target_mask_size);
> -    if (ret !=3D 0) {
> -        return ret;
> -    }
> -
> -    for (i =3D 0 ; i < host_mask_size / sizeof(*host_mask); i++) {
> -        if (host_mask[i] !=3D 0) {
> -            return 0;
> +    if (p) {
> +        ret =3D -TARGET_EINVAL;
> +        /*
> +         * Since we only care about the empty/non-empty state of the cpu=
mask_t
> +         * not the individual bits, we do not need to repartition the bi=
ts
> +         * from target abi_ulong to host unsigned long.
> +         *
> +         * Note that the kernel does not round up cpusetsize to a multip=
le of
> +         * sizeof(abi_ulong).  After bounding cpusetsize by cpumask_size=
(),
> +         * it copies exactly cpusetsize bytes into a zeroed buffer.
> +         */
> +        for (abi_ulong i =3D 0; i < cpusetsize; ++i) {
> +            if (p[i]) {
> +                ret =3D 0;
> +                break;
> +            }
>          }
> +        unlock_user(p, target_cpus, 0);
>      }
> -    return -TARGET_EINVAL;
> +    return ret;
>  }
>
>  static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
> @@ -9163,7 +9166,7 @@ static abi_long do_riscv_hwprobe(CPUArchState *cpu_=
env, abi_long arg1,
>
>      /* check cpu_set */
>      if (arg3 !=3D 0) {
> -        ret =3D cpu_set_valid(arg3, arg4);
> +        ret =3D nonempty_cpu_set(arg3, arg4);
>          if (ret !=3D 0) {
>              return ret;
>          }
> --
> 2.43.0
>
>

