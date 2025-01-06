Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46284E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcP3-0001U8-HL; Sun, 05 Jan 2025 20:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcP1-0001Od-7d; Sun, 05 Jan 2025 20:59:35 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcOz-0000XQ-HV; Sun, 05 Jan 2025 20:59:35 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-85bb264993cso2256546241.1; 
 Sun, 05 Jan 2025 17:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736128772; x=1736733572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XivDPfZEm8827ekIR2Pg4GXa3ja9+uBgidlNUVkDuC0=;
 b=HoaHhfVaHmdbWA6DO0PdC1xA8DgmnXpgkesIUvoVQT9wSB2Wi1qw20S5bVCkIicMTd
 QORN4qHsWalmIe1sMZ/B9iJ6RL9ktXiqcTB/xAenjGM9TEKQ7y7KPTLc9n6kLjgNisaw
 ObrurbfoYrbvPl/2b0Qmn0Plh1T3SjY0oNXTYYbnJEVl8FcfM7Uj2Obl4mfbSCEmvj/a
 3Na1DoGG0YOxp2MhjKzatXi4Hzed/+lgDIpryykpecoqzZYSBkpx/9YoPWOLlUgmGqlQ
 nV9jRpQHT+yHs9bzEKmyySWz0+WOUUEgYi9OQ3l0M9PRGCu1MbNHa98tvsZRlJI4JmqE
 VOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736128772; x=1736733572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XivDPfZEm8827ekIR2Pg4GXa3ja9+uBgidlNUVkDuC0=;
 b=u1mAXNI5OnuEIUloVdwEK6MnW9am2/V+xl9HSKWMfdUSjT5lMCxc3vb0QsqmskYV7c
 F5CFYMPNMd3/eL28OCj38gJH88xzdFCy6OeG+cJp754umczvFHE/h5g18iySGhI6xzli
 oGCm6fBKgUhwFzrXAMTxLFbxRRsBatZZevPWZC9Vqb0utP9ZZcw70l7dwayILSe0SiD4
 OwXWz7KG7L9ls9fUqfpmJqWkZbC86yD1HyUtuF9dWYisa+5FcKzwu+zreOlik+CIv+om
 qZ8mZlnL8ei5ENcDAAGNDzyvVAT7A+esL0x2x3u7M7QDrlzgDr2pqZkF99TOGeE3MvAs
 CWdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxV+kAbSx4VHvrW25xq0ho1ofMJpIKG9lmfzRJwqG96Pk1Gwq5tRvwYiw5K8NTntSzYhljkjeWb0Tk@nongnu.org
X-Gm-Message-State: AOJu0Yzp5A+at/flmxbWrJg2id7CcdWbUy9IP8gRlHC8MLHEKqRmPM1R
 PZt/3qddvQNWd8lmUG1heerxgTB3p+f6mvTNE47Kuk7YTHkPCqK7ik0Hl3GkhxAO6DrYyjwOKee
 eh0eeodsTGAkAH/YUTyADDPCFepCkRQ==
X-Gm-Gg: ASbGnctY8UWqomk97VvZ9vtt1tvvkIAWe/cNEegjIzJx/P9C8+TsraJ41WzvzHpHlKe
 r2yZTj2WowkwZYbVm0jMo3XQQHDM0yRHhbuwa3U01xEie6M3+XqbxHPCF87kVAzB77IE=
X-Google-Smtp-Source: AGHT+IEFG2XDjcyLZ6ONTemGqla5ecN8Pleyk2MAHf2Cuq0BOr5obj55CcYLRDZffH9DNTGXtBn70DCQh8/mkTu/tcQ=
X-Received: by 2002:a05:6102:1493:b0:4af:af20:516a with SMTP id
 ada2fe7eead31-4b2cc31c290mr45507450137.1.1736128771806; Sun, 05 Jan 2025
 17:59:31 -0800 (PST)
MIME-Version: 1.0
References: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
In-Reply-To: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:59:05 +1000
Message-ID: <CAKmqyKOjW=oaSEW76dFa+=hQn6n-DhH3sSncz0bDC+O31Eyj-Q@mail.gmail.com>
Subject: Re: [PATCH v4] riscv/gdbstub: add V bit to priv reg
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 alex.bennee@linaro.org, mario.fleischmann@lauterbach.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Mon, Dec 16, 2024 at 7:38=E2=80=AFAM Yanfeng Liu <yfliu2008@qq.com> wrot=
e:
>
> This adds virtualization mode (V bit) as bit(2) of register `priv`
> per RiscV debug spec v1.0.0-rc4. Checked with gdb-multiarch v12.1.
>
> Note that GDB may display `INVALID` tag for `priv` reg when V bit
> is set, this doesn't affect actual access to the bit though.
>
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/gdbstub.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index c07df972f1..18e88f416a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByte=
Array *buf, int n)
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>
> -        return gdb_get_regl(buf, env->priv);
> +        /* Per RiscV debug spec v1.0.0 rc4 */
> +        target_ulong vbit =3D (env->virt_enabled) ? BIT(2) : 0;
> +
> +        return gdb_get_regl(buf, env->priv | vbit);
>  #endif
>      }
>      return 0;
> @@ -226,10 +229,22 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint=
8_t *mem_buf, int n)
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
>
> -        env->priv =3D ldtul_p(mem_buf) & 0x3;
> -        if (env->priv =3D=3D PRV_RESERVED) {
> -            env->priv =3D PRV_S;
> +        target_ulong new_priv =3D ldtul_p(mem_buf) & 0x3;
> +        bool new_virt =3D 0;
> +
> +        if (new_priv =3D=3D PRV_RESERVED) {
> +            new_priv =3D PRV_S;
> +        }
> +
> +        if (new_priv !=3D PRV_M) {
> +            new_virt =3D (ldtul_p(mem_buf) & BIT(2)) >> 2;
>          }
> +
> +        if (riscv_has_ext(env, RVH) && new_virt !=3D env->virt_enabled) =
{
> +            riscv_cpu_swap_hypervisor_regs(env);
> +        }
> +
> +        riscv_cpu_set_mode(env, new_priv, new_virt);
>  #endif
>          return sizeof(target_ulong);
>      }
> --
> 2.34.1
>
>

