Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A1C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhg5P-0001xH-KF; Tue, 05 Mar 2024 20:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg5K-0001uM-DK; Tue, 05 Mar 2024 20:28:42 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg5J-000379-0q; Tue, 05 Mar 2024 20:28:42 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7db68ed7bb1so358607241.2; 
 Tue, 05 Mar 2024 17:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688519; x=1710293319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OsRDjDlmh9JeG7jLI3lJAq0rHM1iX7+F+7H1ForrQ8=;
 b=IpgWesGb0UvGyTVxkGMeHsd2K2BEeyZ8sY3kXZbu7RK4W7il/LWXEBkUUneP/GC01f
 LIW5gZ/TCHj6tWiBzfthRU+m8b9KNEaSwGrFhbDZTdM3us+s43vHfQGXdGN5rojHriz/
 uOhIxc4vpgMb+M0hgzUCi/tz7HzIQ2674LnInIuf337YZdSYLKQvtANqnIc5UzwetyUX
 /6W/bH55cHkV74wofisr+g7bqTwUSHEgyqQNNN6EYqTkkrMG5uTXOdVFKSAq3t+1V2fT
 E3jT6W07nwXkru09ko9YictxS31HHLu1Q/4fBr1HhuxmwPNcQ+7Iu/4MeYyJdlJT9X3m
 C8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688519; x=1710293319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OsRDjDlmh9JeG7jLI3lJAq0rHM1iX7+F+7H1ForrQ8=;
 b=hOI9ktamvDnH+9lMQ7cchk3f6HKN4MBCfmnDE4Xl0rR7A/HF6rqjeHwZGucM6gRuQN
 xo+i9XBt3RUvvZKlmDunmaA3Hxk0LhQ3+rCC8L2oYK58yV6ZX84yVeZld32FYxghbSkV
 Hc6XWWWPsuRUF4DLy3945P33ONiW264eAEhqTMLld17FTz4ytEEDSh6mOQXnlrfIfq3f
 rmCD3G93oZaNas0WwVd5jAJ6Vdrvequ9ADkbvRNveaqrkmqG+7RksffUD4Qnreqlgvpb
 rLvb+PdvGn3acW32loJOCFUuTpyan8za9uJBYmsRwC2eXXyQUWK7ax+cRpcpjFw+ztAL
 Ubhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH/EVvCyxvAHHjwSowwWMNQ5P39bYcxPglhctSFBCuYrbhbTiw9Dahpb7jIs9aBsZ9nrR3caQDqUkx1Fbs3Leid2BPuBI=
X-Gm-Message-State: AOJu0YxMveHwyd2qWX+kJgHJRGWZeZ8H7dY459WyzSv0sRWAfeJ4oFPg
 7TrJlEVTvC3ORH8GXUk5CY2PvyUna7rP/GaDIKEaxK+oDvynOLDg5MA4Y+GZYWzjBx56b8DwLBV
 5NOK7YtXQGRnWhrjO4x6Q6E6lGi9rwHgc
X-Google-Smtp-Source: AGHT+IFQZcxw/SgupNnODAbuxk3xGDZCmaCYkxLfnE93FsnAEIfTZQvZ/HH6tCrkjSNeU7pYydK1Zr+oJIi0hKmYBqg=
X-Received: by 2002:a05:6122:270a:b0:4c9:9ff3:7562 with SMTP id
 ej10-20020a056122270a00b004c99ff37562mr3642378vkb.16.1709688519656; Tue, 05
 Mar 2024 17:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:28:13 +1000
Message-ID: <CAKmqyKMAN5w_EdO5LzBPOMLfi7FH=6d-qHNQyR9joEUSpOwyYg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] target/riscv/translate.c: remove 'cpu_vstart'
 global
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Thu, Feb 22, 2024 at 7:33=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The global is unused after recent changes.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 177418b2b9..f2f0593830 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -38,7 +38,7 @@
>  #undef  HELPER_H
>
>  /* global register indices */
> -static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
> +static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
>  static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>  static TCGv load_res;
>  static TCGv load_val;
> @@ -1321,8 +1321,6 @@ void riscv_translate_init(void)
>
>      cpu_pc =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), =
"pc");
>      cpu_vl =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), =
"vl");
> -    cpu_vstart =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, v=
start),
> -                            "vstart");
>      load_res =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_res),
>                               "load_res");
>      load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_val),
> --
> 2.43.2
>
>

