Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC93C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 02:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRNIZ-0002vx-Hl; Tue, 09 Jul 2024 22:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sRNIY-0002vT-Ql
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 22:43:14 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sRNIX-000545-5A
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 22:43:14 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e04b03c9a3cso804999276.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 19:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720579392; x=1721184192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTwpxY9pLW0RdwGdoKl03gnm/OAmc3fhfvoNHC+8T80=;
 b=SPGGPaUQgN/VXDGN4HDIawpLyrG7nqc5Bunuk09UKFtXvm2iMcjbl9G2DiOh0GIqZb
 f5mWb7iEkq3EPyxuQHQp3wL0PHbvU9fZPI+nc0Xv6Dw66XHcp89bm/7aPS02VpaeVYRs
 Cj1YJGNwx5znxPkLnD9lMC3J5tzhIjeGumUQBy9txBM7mF4WVzx0HhdNYANKALk8EiqL
 DUo05pXXpb/jZwdxKXAGHwRAoZGKr6aHJhsV3dsHrjoRfGKXS0FCwxYfsA8ySM9rmHPE
 8lKWS+1TkqQ/jj5u83M2MyumrT4g/LaupU7WXHMWPHaof3zinVFEL48m9zIpzA4DmIVc
 ZhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720579392; x=1721184192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTwpxY9pLW0RdwGdoKl03gnm/OAmc3fhfvoNHC+8T80=;
 b=lYCvGhTdALRQ9rdFqebrNUXO1Y7H1BDKGtpnwWtm8loLnj35Q8YZwWzpzYgmr85yrW
 A9OzMAmzaE7CHJkKQgU7XvMIu/X4QqdRlxAcj6RHPk1p0cP7z8OGiuxKXdq9+5o79tUw
 jKd1NNCayFGbCytOKvCkfi07Xz9Fy6WZ9z5+JeKnZGV1r2vKjX1/SV4s4d5zyxYBKqg+
 09/+p/iiBQ8Jr5EiNa0+mWTAyaSqfpqOa99hDE2cPUffeRMCeX0hw2yW+nfd7CLf5e5E
 NV1ULuMyV0jI5Mz9g1doursgA0WaxdWD25zxZWBlvSwNlUx+u6C9/jf9lULXNCfSgas8
 F1Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECgMR8NpjfhSjWiZi9+O7qy3fkKenUER4W4G1caX6XJ+RaeQVU3LIpZAzNyI7XLSt04aDsyqsuVdYb+2mSTqOb7Q91Nk=
X-Gm-Message-State: AOJu0Yzg9WmzU9OKGuwiPJpEvA2Bw6Q8E50IKgXr4mKA+iXY1wC2pw4D
 FDWNThYoeNZzk5VMVvQsMmK6PViaqihfotDgT4vWAQkFQ8j9JZvdm9pg+09oHu5q5PUGGOsO5J5
 UHwvgrTv4hbmmofYdgezo9g91RzQ=
X-Google-Smtp-Source: AGHT+IE4HFTTfp3u20apbf1xN6IOhK8wwUeJZ4kHNC93+LAGLKNtyPgSBeriuMu44QjX9smRMu19jll6Ke2mJ1cd+Go=
X-Received: by 2002:a0d:f942:0:b0:615:8c1:d7ec with SMTP id
 00721157ae682-658f02f4a45mr46080377b3.33.1720579391635; Tue, 09 Jul 2024
 19:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240628033357.50027-1-chris.chenfeiyang@gmail.com>
In-Reply-To: <20240628033357.50027-1-chris.chenfeiyang@gmail.com>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Wed, 10 Jul 2024 12:43:00 +1000
Message-ID: <CACWXhKkxXZF+6-V38BuFiRQPR+Wo+V0B1kh-wMU6YE5ibH0TZA@mail.gmail.com>
Subject: Re: [PATCH v2] target/loongarch: Remove avail_64 in trans_srai_w()
 and simplify it
To: gaosong@loongson.cn, richard.henderson@linaro.org
Cc: c@jia.je, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=chris.chenfeiyang@gmail.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ping

https://lore.kernel.org/qemu-devel/20240628033357.50027-1-chris.chenfeiyang=
@gmail.com/

On Fri, Jun 28, 2024 at 1:34=E2=80=AFPM Feiyang Chen
<chris.chenfeiyang@gmail.com> wrote:
>
> Since srai.w is a valid instruction on la32, remove the avail_64 check
> and simplify trans_srai_w().
>
> Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only i=
nstructions")
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
> ---
>  target/loongarch/tcg/insn_trans/trans_shift.c.inc | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/l=
oongarch/tcg/insn_trans/trans_shift.c.inc
> index 2f4bd6ff28..377307785a 100644
> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> @@ -67,19 +67,9 @@ static void gen_rotr_d(TCGv dest, TCGv src1, TCGv src2=
)
>      tcg_gen_rotr_tl(dest, src1, t0);
>  }
>
> -static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
> +static void gen_sari_w(TCGv dest, TCGv src1, target_long imm)
>  {
> -    TCGv dest =3D gpr_dst(ctx, a->rd, EXT_NONE);
> -    TCGv src1 =3D gpr_src(ctx, a->rj, EXT_ZERO);
> -
> -    if (!avail_64(ctx)) {
> -        return false;
> -    }
> -
> -    tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
> -    gen_set_gpr(a->rd, dest, EXT_NONE);
> -
> -    return true;
> +    tcg_gen_sextract_tl(dest, src1, imm, 32 - imm);
>  }
>
>  TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
> @@ -94,6 +84,7 @@ TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_g=
en_shli_tl)
>  TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
>  TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
>  TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
> +TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
>  TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
>  TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
>  TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
> --
> 2.34.1
>

