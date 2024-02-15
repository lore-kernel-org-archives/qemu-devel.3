Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B20C48BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYRa-0001yx-Uj; Thu, 15 Feb 2024 04:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYRZ-0001yO-FA; Thu, 15 Feb 2024 04:54:13 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYRX-0001O2-Ux; Thu, 15 Feb 2024 04:54:13 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d6a772e08dso270462241.2; 
 Thu, 15 Feb 2024 01:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990850; x=1708595650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dg9Dq9LxbLZcuJ61oe45xPZhA69Go+urHMRwkKmROyI=;
 b=DsBx4ghiwTT86YrVJyDBQnGvULcQYHcMHFa2el+MkpzDKTV/SUv4DzL9QcL0Csp5vZ
 gWZ+IJUtxbPgQ5dWPMzPcOR0kJOb19Xz34jHvNNztco6HgDxNKsTrQqMouhKUN+MKPYE
 XfTkq3cMzyZEnYiiwYlW12Eza4XGMdJBOK2uGrv4EJk7gQI9o3zS7ULpPrAx3oblGwmd
 OxmJNFZ3iufTlmhykX1qBJS4WIDPaHcW5S3aMdWAKhB4nWVW/qtV9shv937qKEhepB1c
 j9GR8vpwgcJNmoS68Lp+yrF1bc/5+XBD3p1pYWvkMapXT4ceomkszBX9gYnLsAAV/shY
 Ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990850; x=1708595650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dg9Dq9LxbLZcuJ61oe45xPZhA69Go+urHMRwkKmROyI=;
 b=AWsiU0dPSK+Zs9QldUW1KT8+uvt6n5/DJ0KS67dnaB2KGStMluphksTUm9tjJu8RMW
 kNYt+L0RnQG6ioywY6m3vbsGoS9iwjxAt/zvlfiZa0Fb90Xo7d4o0KBVDbX1UphUVfB1
 LS8IH2Epj2RsiERrhbatWPB7F0z3j6RI6yqasmEBoGg2b1jnuKEjJ99NpJhgYQuIex93
 ouPIL1OCmEbMWx929MkW8XVrgGwkV4AQTPkVTYrEZTQR2Dy7C7xermsGgwE0sEooEaQ1
 DOjFQkOh5DBI5yk/JzHfbw7klezO5sa3ugtEhw2PmFmVW6OXohECxaqGY641xEqP8Xsa
 UQ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJg43sjt4ycfE6kU2ZgB4zRkdyXJO/Y2KJw9o98DzHZTXhdk7mK0rXBOvhEvMBj9qikBmeth+djYII/qu3S+QlLGQbt9g=
X-Gm-Message-State: AOJu0YwXes4qY9piL2BkzGoJkjjuGy89Q0DYHhElyHcsmT/Nyqof3blS
 Ar4nGEYfkbJkQvhdnTPM/fsXhPzadG6Xn07gnNE3x9gZmPe6pBwnlc86lcegqqQQwS47NOCCDES
 T6frjFog7aclmFFoVMHAFbLi00Io=
X-Google-Smtp-Source: AGHT+IGOQw3S1VPEzuIComSGfsNTgkc6otMpctHlb4SdjGBB5BFLZr3nc+tOMyT8/VrpxZoXa3zty0mIKWJ4WKxU2N0=
X-Received: by 2002:a05:6102:1627:b0:46e:e449:b8f0 with SMTP id
 cu39-20020a056102162700b0046ee449b8f0mr1213320vsb.7.1707990850107; Thu, 15
 Feb 2024 01:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20240207081820.28559-1-jason.chien@sifive.com>
In-Reply-To: <20240207081820.28559-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:53:43 +1000
Message-ID: <CAKmqyKPZ9-vWgk3R5vupZw3Zbi1PBvRtxQHUaFnfSwHT2UwYmQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Update $ra with current $pc in
 trans_cm_jalt()
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Wed, Feb 7, 2024 at 6:18=E2=80=AFPM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> The original implementation sets $pc to the address read from the jump
> vector table first and links $ra with the address of the next instruction
> after the updated $pc. After jumping to the updated $pc and executing the
> next ret instruction, the program jumps to $ra, which is in the same
> function currently executing, which results in an infinite loop.
> This commit stores the jump address in a temporary, updates $ra with the
> current $pc, and copies the temporary to $pc.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index 2d992e14c4..cd234ad960 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -293,12 +293,14 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm=
_jalt *a)
>  {
>      REQUIRE_ZCMT(ctx);
>
> +    TCGv addr =3D tcg_temp_new();
> +
>      /*
>       * Update pc to current for the non-unwinding exception
>       * that might come from cpu_ld*_code() in the helper.
>       */
>      gen_update_pc(ctx, 0);
> -    gen_helper_cm_jalt(cpu_pc, tcg_env, tcg_constant_i32(a->index));
> +    gen_helper_cm_jalt(addr, tcg_env, tcg_constant_i32(a->index));
>
>      /* c.jt vs c.jalt depends on the index. */
>      if (a->index >=3D 32) {
> @@ -307,6 +309,8 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_j=
alt *a)
>          gen_set_gpr(ctx, xRA, succ_pc);
>      }
>
> +    tcg_gen_mov_tl(cpu_pc, addr);
> +
>      tcg_gen_lookup_and_goto_ptr();
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>      return true;
> --
> 2.43.0
>
>

