Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF6EC54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhg9V-0003TC-Df; Tue, 05 Mar 2024 20:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg9P-0003Sz-Ty; Tue, 05 Mar 2024 20:32:56 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhg9N-0004Af-Cr; Tue, 05 Mar 2024 20:32:54 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-472e7dc2b6eso101887137.2; 
 Tue, 05 Mar 2024 17:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688772; x=1710293572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7XhNwWqmh7Hb4VDmGCvrwyQ9xPGFQOjs7Zij6i9PLU=;
 b=gkHRcLxw41T8YBcNP1dtwrnyu5UnWxNC9YWrodCJcRqMAbYNjubliCKCBQJ2E9nZB0
 o1q86K/7jcImCDoApfuxUAbMQVOnNWTpGnjnIFcQaagd1LZxYGEUA626kHOthig07bT3
 2GJkoMfEHzPKjRmo7V56w82iBrOP2mOTIEbc3ZksWs5GaDYVPt9bGW6Y3LSjzEI8MIFr
 Ksq3hx3I7FdrZH0uCgOWlR88Wy2RmLzpI6C57Ffo53LmvG150Q3mgp+Rbfg0NEgPO4ME
 fNChO3bQEVLXgm8igzPEkZDNPv8k3mqtimzXNu3fh6zTwGnWHLXwRGm1lx62XceS4xso
 FNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688772; x=1710293572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7XhNwWqmh7Hb4VDmGCvrwyQ9xPGFQOjs7Zij6i9PLU=;
 b=QyNdXP1VtgMdcDVpHD9/mF4bvQdL30KnBfbMXoelcQdriOPpYlgte3Y6b7yWa7iOmg
 ueZvIEuWcA96+h6T+bM2TRhe/pTNfSAeDY30BJkrytGBmP+4eGYJ//2G8Qh8hFo9QF/r
 UzRJ0p3huT53+9qaiLwwLzklfO89RUYJgwKuUDNujTvq16xS9ADiMKW8HRKPqmK637FB
 KB+PziwUwO/u+k8mMBcof0LwkowpL2kikf8Y3E1724Tjkfa9PEPqpkQHx2UGnReQqPXU
 LKeYP21Ib9iMuZI2eebCkQTjrSjJAwX7YoJXRgIleMjHbObKGC4jMhasvEa4zawj51kN
 VZQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXv7ZTNfWy9/K/HN74Dhn/oQBjyts9bKSADC43SDznlAtiO9lE72w3eqQceZu0rWMs/qMxJArMZool+AOhJX2g52LUB0=
X-Gm-Message-State: AOJu0YyxBMegqtY3TmAtqcQE8GlUN2oiXS9744P2ukh6uIwhBiV7Kk7P
 wXXSvfeek+6aZZbkOaqcD8r7EweAF3NzbDqfPwELNjYsGmtzHAJpE6sIFikdmB4XQdRa9PHqZWK
 rmsIJV+2QQaLKSllZCEJdHeIC/do=
X-Google-Smtp-Source: AGHT+IEa9FkV+XTGpJKBvX8mNezWE0xPvv7OFIgleFDcJd8Tf4I7Ci4mnVG9lQLSnv9o0/+RqBNwBzpdznVRK6BTdpg=
X-Received: by 2002:a05:6102:34ed:b0:472:ebae:771e with SMTP id
 bi13-20020a05610234ed00b00472ebae771emr728528vsb.2.1709688771938; Tue, 05 Mar
 2024 17:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:32:26 +1000
Message-ID: <CAKmqyKNOoxZ1gUr4Jd9nhV_x7T8ONDFTdB58F1iyRu3_CGbnEw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] target/riscv: remove 'cpu_vl' global
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Thu, Feb 22, 2024 at 7:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> At this moment the global is used only in do_vsetvl(). Do a direct env
> load in do_vsetvl() to read 'vl' and remove the global.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
>  target/riscv/translate.c                | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 58299d9bb8..69f32d081e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -157,7 +157,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs=
1, TCGv s2)
>
>      if (rd =3D=3D 0 && rs1 =3D=3D 0) {
>          s1 =3D tcg_temp_new();
> -        tcg_gen_mov_tl(s1, cpu_vl);
> +        tcg_gen_ld_tl(s1, tcg_env, offsetof(CPURISCVState, vl));
>      } else if (rs1 =3D=3D 0) {
>          /* As the mask is at least one bit, RV_VLEN_MAX is >=3D VLMAX */
>          s1 =3D tcg_constant_tl(RV_VLEN_MAX);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f2f0593830..3040f5e0e4 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -38,7 +38,7 @@
>  #undef  HELPER_H
>
>  /* global register indices */
> -static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
> +static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
>  static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
>  static TCGv load_res;
>  static TCGv load_val;
> @@ -1320,7 +1320,6 @@ void riscv_translate_init(void)
>      }
>
>      cpu_pc =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), =
"pc");
> -    cpu_vl =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), =
"vl");
>      load_res =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_res),
>                               "load_res");
>      load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_val),
> --
> 2.43.2
>
>

