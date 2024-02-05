Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04ACC48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpBe-0007SF-BL; Sun, 04 Feb 2024 21:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpBc-0007PX-Sk; Sun, 04 Feb 2024 21:58:20 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpBa-0006kZ-F1; Sun, 04 Feb 2024 21:58:19 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7d6275d7d4dso1610531241.2; 
 Sun, 04 Feb 2024 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707101897; x=1707706697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNKhOPqd0X7Ap2stK/qaMss0bTy4pcMPNUwi6m6bIso=;
 b=k6VSs8BOeCnmIlMCNn9kbMcqV57tPebvWpqG/mYymvxkqZimOhWSe/iAcKvycCKzqv
 1XucR+9icuSadpazppZ9easYvvyvjJNI6wVnkoM5g5B8LVMlGD1iWzYt0tK0K7Qb+vvb
 iTOSdTrtzNcTKPrFJbSAewyJD+9IEC6HotbQSGh7DV1N+QM7X7C78s5BZFziylTUgyEn
 xA8dVHaXkfSNTJUG8JCsUFWmFv7uNWpjWXFeYLusK6KPZPXRZ+oguayg4C2RlWbTy1td
 fxVmfYZ3f5YMxb9rSQCr3rnMLD5Y5k+Lxjh5Ejhi5g4brLxmI7feTuBVzrlZsF2Y3M28
 62PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707101897; x=1707706697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNKhOPqd0X7Ap2stK/qaMss0bTy4pcMPNUwi6m6bIso=;
 b=CLb7h3GsLOVZAsljyU0MwTzvAJkt5XepqBvkOHcvXFnG0YqVh370y9bdudk2WLHKI0
 wvLuA12kJKNBSFNBauPbAmBX3uxBcdyphyqCcsfwreIrng7xsYi3bPdgQjBK4dfVuGfN
 nBxa7OfkL3ajNb71BDhaeD+Avyd42AEQx+LmL5Somh7fcsSSh0dO6Y6zW/FbsHX4djvY
 3RcA9lMtTX5foWqkGCw1fcL+wZ/W0fxPiPF4OTgQ7/toLMotdLI/FWbfW0yLWMacb5Vy
 kVFS+Ox+OH2J/+0Y6bYZKdVS4/yM8FeiuJ2kvF66VEcAYX/6mkacHt9IYOLcZSTvLB85
 tujw==
X-Gm-Message-State: AOJu0YytZNcYCXhw8fr9/O3CR6zCF12y7qsfGXve6VUoFTUAa9EFjGz+
 GV/5+fg/CRWszkxl2ghaXlbaXncJZqAJf+PlKza6ub7HONRqVpF6mNCzi3DEqSgZF/WSyazDwau
 zq176I+NqrvJI03maLzyidlUftL8=
X-Google-Smtp-Source: AGHT+IGPC8NpLHtitXgNl6TIHHMuIOZ6+xvcP++sHc5BuxfnhhDcBMKyA7F/6sUu+Gxc7hZmTSnzwkTgz7PY6Codd0Q=
X-Received: by 2002:a67:e283:0:b0:46d:20cd:fa2e with SMTP id
 g3-20020a67e283000000b0046d20cdfa2emr1632063vsf.13.1707101896986; Sun, 04 Feb
 2024 18:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 12:57:51 +1000
Message-ID: <CAKmqyKM7efPb7An4W4Z+pW4p7aNUsfGCU804A9O8gmbdxLLHAA@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/riscv/numa.c: use g_autofree in
 socket_fdt_write_distance_matrix()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Tue, Jan 23, 2024 at 8:17=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Use g_autofree in 'dist_matrix' to avoid the manual g_free().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
> index d319aefb45..cf686f4ff1 100644
> --- a/hw/riscv/numa.c
> +++ b/hw/riscv/numa.c
> @@ -167,7 +167,8 @@ void riscv_socket_fdt_write_id(const MachineState *ms=
, const char *node_name,
>  void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
>  {
>      int i, j, idx;
> -    uint32_t *dist_matrix, dist_matrix_size;
> +    g_autofree uint32_t *dist_matrix =3D NULL;
> +    uint32_t dist_matrix_size;
>
>      if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
>          dist_matrix_size =3D riscv_socket_count(ms) * riscv_socket_count=
(ms);
> @@ -189,7 +190,6 @@ void riscv_socket_fdt_write_distance_matrix(const Mac=
hineState *ms)
>                                  "numa-distance-map-v1");
>          qemu_fdt_setprop(ms->fdt, "/distance-map", "distance-matrix",
>                           dist_matrix, dist_matrix_size);
> -        g_free(dist_matrix);
>      }
>  }
>
> --
> 2.43.0
>
>

