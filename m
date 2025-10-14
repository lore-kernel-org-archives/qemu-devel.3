Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00795CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XHP-00069W-Rw; Tue, 14 Oct 2025 01:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XHN-00068D-VD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:08:57 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XHM-00044f-DD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:08:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-62fca01f0d9so10063658a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418534; x=1761023334; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49RVUEuQ3MOn2P3kgnFFLYszw+6SQS1Z81i9ebGPYxc=;
 b=DmaqHRSKNm/oRZDX8ppIFMGc6AVo56e8Id2FH7ky7Cge1OnBSVGe/aKyKhxySspOQI
 gpQL89mYZhZtHEZEYx7qAv+xHp7wkVKrl94PiRs7MaCEBGJLuNMMhfAh3sR99vgWh8WV
 JvQ6p6VpU+5M+meOD4wmrulxT1xRN7uw+MYYrsmg89xbYVX83j6Q2B+jsoSZc8JRbPUJ
 Y0S+HgFuHXAn/afz0odKWzcBYipLdojRFFHkzPy9xVVIQQnH8pMhkT5qWkrFxmzmYQsW
 7trPYf+pxZM8PcZwnS4/AScjvAv/iTDmSQnWFLVbnDOYzwntDoSFeVqEBqYwS2s9G1OY
 yPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418534; x=1761023334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49RVUEuQ3MOn2P3kgnFFLYszw+6SQS1Z81i9ebGPYxc=;
 b=Onw+CyD7g7KUCJEcSQxrQjIEghmZSs6jcpi9iX3siaZeAZCpRqZrt5BRsSUAPUO5k4
 CHsv5dC+2WJLoCBpZALtWTFAZWqU9SmsnDdpBDwigx5C9X/T6ccpkr4vpgcVz7IBTiWu
 DvbJ+s3r13wcVOtW4kdc6KW0X3raHxRf94k5/Ib19/XgBxelySsh8pZuOLm2l+2MAtJQ
 cbz8Si8xAMyhFRTW7/Ao/hm+nXD+zWcRGAp7MAq7dKoeE8+ZZuu3Hxf3DBfXmLVniGlY
 mqkTJebut5Qan6dhqm/gyixi414I2WcXjS0u5PELobthDc2JH33ZdaT0Z3zfD+0kHuAl
 QiEw==
X-Gm-Message-State: AOJu0YxpKKIULGRH/cWEaGs4CevtJ8C+unBF/d1lAVPBKIOlQ/aShlni
 iHwmFiW7WGmI0qeH26SNDi7yMW/T5jd9ZlcaKCAEKsCLfUcXeIE2cpWibJzPqf6/ulqLXNUWf87
 9fqirnFbUIPRYXOROu4iMoKj0jIYVohM=
X-Gm-Gg: ASbGncvkW0hNxTXEzLQzaM7HkRDe1eiSiK1qHMOIhE0o59UUVV8bKOGNiO5miod1SQN
 Y9Vf6si7HC/C5xhll0T8FmcGdYua37NcYh/X14WdxblzjGGBPn9Up705ACgLI8W5V/mtV3yom1w
 UOfFCOvV7tTCMVDJvdLg5123ztSEbNTtUwHgtZ5ebEBk/bDjsdGWDr/caFiMnxc7UNATTPbrFfq
 a67TRyLD+g/62nSfVTw9L5kQQQ4//JaRVGzYJxy6i0/EWiTaQuxOSHq
X-Google-Smtp-Source: AGHT+IHa0DQiFWXZtcliIhXBpEOA4dfXIxyjzg60eRB4sRjAeyuZeh+pZpYRYJfpksRIjuFcf+u0UMQ0zK+F2w9P7ag=
X-Received: by 2002:a05:6402:2809:b0:639:c9c2:3956 with SMTP id
 4fb4d7f45d1cf-639d5c5a382mr23368989a12.28.1760418534216; Mon, 13 Oct 2025
 22:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-11-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-11-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:08:28 +1000
X-Gm-Features: AS18NWD8Ce8ZYAk0qMbkfjJOcMan9EarmZEH3Vl6E7eMjuCeiLQtrWpqFndZjTY
Message-ID: <CAKmqyKO7QzhX3DjYv4GkLkD6E3xiAF+eZcVsFz4NUF6yKJ8gAg@mail.gmail.com>
Subject: Re: [PATCH 10/13] target/riscv: Conceal MO_TE|MO_ALIGN within
 gen_lr() / gen_sc()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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

On Sat, Oct 11, 2025 at 1:58=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All callers of gen_lr() / gen_sc() set the MO_TE and MO_ALIGN flags.
> Set them once in the callees.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rva.c.inc | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index e0fbfafdde4..8737e8d60d1 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -34,6 +34,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>  {
>      TCGv src1;
>
> +    mop |=3D MO_ALIGN;
> +    mop |=3D MO_TE;
> +
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      if (a->rl) {
> @@ -61,6 +64,9 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, Me=
mOp mop)
>      TCGLabel *l1 =3D gen_new_label();
>      TCGLabel *l2 =3D gen_new_label();
>
> +    mop |=3D MO_ALIGN;
> +    mop |=3D MO_TE;
> +
>      decode_save_opc(ctx, 0);
>      src1 =3D get_address(ctx, a->rs1, 0);
>      tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
> @@ -99,13 +105,13 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a,=
 MemOp mop)
>  static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_lr(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
> +    return gen_lr(ctx, a, MO_SL);
>  }
>
>  static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
> +    return gen_sc(ctx, a, MO_SL);
>  }
>
>  static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> @@ -166,14 +172,14 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d =
*a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_lr(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
> +    return gen_lr(ctx, a, MO_UQ);
>  }
>
>  static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
> +    return gen_sc(ctx, a, MO_UQ);
>  }
>
>  static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
> --
> 2.51.0
>
>

