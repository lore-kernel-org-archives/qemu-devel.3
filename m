Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FBFE77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcO2-0000we-En; Sun, 05 Jan 2025 20:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcNv-0000v6-Mf; Sun, 05 Jan 2025 20:58:29 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcNq-0000P8-Ms; Sun, 05 Jan 2025 20:58:24 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85c4557fce0so2708668241.3; 
 Sun, 05 Jan 2025 17:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736128701; x=1736733501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xepoDEePQvWw+8jkzD2kNGWweQnW9kY2KXHrWtfbXO0=;
 b=QiwbW1XliS4Q83TrxqYleAHWIaBUEfKufroMLWQXRdwmUG0BTeDBTahnFSP/uXLYll
 7gkEhVaHlENnopPiBBH456ntXkJiZoYLbwU8OW7rtVebEx7FiOtrG/U34hvEBqmoYOj6
 H36a6MALw7nRngVripRtFm+bmQtZjnve0cH09l0p9gpnGQuTQ+M9wlNN2QhfVnB3OiYd
 +UeAfAw95fC+gPRPDpKSRofwXWoVYhui6H0MH+EQVDTsUPAWAiYvz3LsSxBSaUKeXG4V
 coQIgwxWJ+uq+6SxYomaOFfnhV7um9egwDkgj72nP0YnBLyIzjBtZ8EK4B/huRqVDzP1
 JQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736128701; x=1736733501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xepoDEePQvWw+8jkzD2kNGWweQnW9kY2KXHrWtfbXO0=;
 b=dCEAfvDznLNvb8T23jeoLsYsPXGgc/HdmUqemYRrUw5MoRnvzTj7tkYridDlmCIsTU
 kuURUXlvcfoBh6arOJ39h97F5ve0LsL926RV3NOig8Yho/t8JhQxh9TKm+pY+5H2Gznq
 z544sdskdZ/Na75A1nrYhkc5vZwR9TfKgE+JJHgRdLJxhd8ernw/0FD4CxFlaYjacjH8
 OBrwuvliBUqjo7DhYV7d0uFGHUBR04qJZZj5NZQPAWdCQNtQcsRGjUfQfON/QFtS+/Wl
 LhkrETSifTj4EaUkZ8XLW5nKjcQ4Z/iq5UySC9412JIzARAr4eE6iWnsDrsiNzOAlDol
 1h8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCLSi23IAuVkREI/ZAMzlfmajTaRSrKnrHEgOffMNKZuUgrjba4wbkzt3wcKebAW0Wv6nXHHpCaD79@nongnu.org
X-Gm-Message-State: AOJu0YzUgIIszGYqCfuhC4+SSGFlOiaLnbRUaIF3CRrDKZKRtrj1Mw5H
 BdElZeKJ7V6KOTLfs0qHGktuKZ+Al4frUoTWaK9UTtYKkbIULqa64Tp3+aVXmiILHtRMZi2DFlz
 N/wK2akHyZd2yYTfzz9E99WS/2ic=
X-Gm-Gg: ASbGnctHeslBs3+8bj41vmfkjrzuHeYHVCadJiZQGOBxOCULQYaScRRSM3490U3vXKj
 GKn3T5KeNTBYEb9FJEIF5blE8yfYx/rCP61TC3RCMFc0xnPD4s4J7qdHzIO1/4jbHzn8=
X-Google-Smtp-Source: AGHT+IE1J53AprUrowbvFAGAO3ev6fzUjI+BTwJlfkAGC0nPLv4kjG1YImoChUSTgZBptyozyLvz5ZoqFc3EvnC6DZE=
X-Received: by 2002:a05:6102:5689:b0:4b1:1232:def with SMTP id
 ada2fe7eead31-4b2cc31a411mr41772639137.4.1736128701057; Sun, 05 Jan 2025
 17:58:21 -0800 (PST)
MIME-Version: 1.0
References: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
In-Reply-To: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:57:54 +1000
Message-ID: <CAKmqyKNMPypBqdGk_0kOerbzpNXnsFtvGYCbmCs-+MLi=h-YcA@mail.gmail.com>
Subject: Re: [PATCH v4] riscv/gdbstub: add V bit to priv reg
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 alex.bennee@linaro.org, mario.fleischmann@lauterbach.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

