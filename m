Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B9C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpV3-000641-Iw; Tue, 02 Jul 2024 22:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpV2-00063S-EU; Tue, 02 Jul 2024 22:13:36 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpUx-0001qO-W9; Tue, 02 Jul 2024 22:13:36 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4ef6f5e2e6cso1552962e0c.1; 
 Tue, 02 Jul 2024 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719972809; x=1720577609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9K0okOqOzIEJ+i663e7Bql4OEDVS662Pbrl8g3LbGc=;
 b=d7aKZ38v5jy11N82z1QB7cU7g0CbRspr4zhs7+yb7bEO7WsFDr+nWEao3GuqYfgb9g
 BrWfdsaOmIi4bwVbUGui73sQ07mNqKZt/MIxld/sc5f7Dpq+nzVK+g2w6WLPlKVyoL1i
 uDqtueGLWpBJpMieofL9nc6HsX1enBnPp0BFdgAhSZnB1odpwIPGhObK6F3S+6n0Qn72
 H0o4gARVjkt/zQvu3WF2AbN+46mu/W/fxF6Xd9MXeQat4oI+cYUknzPPwa1P/Cm9acxg
 Qv2H+p6WFJumOqYhTwS/gsT/TRYh+sgTFR2pcIz41lniYjBMtRmBJ4Rlo4PZF80VNEq2
 ubqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719972809; x=1720577609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9K0okOqOzIEJ+i663e7Bql4OEDVS662Pbrl8g3LbGc=;
 b=mY5Ue2a43IOfIyuKwZr/uuGHhSUS4F4g3O73j95BG3F7KfhuozH61URrdWAoEh3xiq
 1AyAnMN9JVSBiZ844v+kbNHB9YNEevfZcJ0etAYFmQM6dWJS9DJplL8d13nh/hJXx3rX
 FG0OVx3UITD32bOp3/Ljil+sHE6OWv+bc9Qnqha0bgS0YkQWlunUzasc+fhdPfJ5Wv09
 H/+oBHadFPcAbkibncPyGc9ozp9sQsFICAN/hj1GF7Tb/etLp7BQBaNCK4vNu4KwkrWY
 EO8LB/KuHxUyNWJuZvvwsj0QOGirNDfYTbvweoEaogOa+B8Ze4u0pA8l56xjTTDvit6b
 6FWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUFF1br18Qkur3xsvlGoN6txqebqs2Dsh8AbnP2CP2KNHe8vW7oPBRVssr5KBhR+Inipx4ImXxiEFL6wN+Hh6uanN580=
X-Gm-Message-State: AOJu0YyyuDPrjYM+FVcQIflEBCZ3BVUd7NTeSY/PUv5lS3fQn1XHA0d/
 I+df0bur5LXFbeinB3z15t43OZQlky4WQECX0OuAy4Oc6S6q9jmk/IKJCnpc33CN3qgDs9G1v0U
 McJ7DXupr/SLyVFkrksOgTnJUOX0=
X-Google-Smtp-Source: AGHT+IGQ9rRtn6cek6kXXR5MxrcO7f5z+9yRLQ2xxa8HvlHX3dTp+hQeC/lT5CHXkTxLDD2WXX3FQO6mLZu8L8KizA4=
X-Received: by 2002:a05:6122:4982:b0:4f2:e1c9:fc3b with SMTP id
 71dfb90a1353d-4f2e1ca0481mr139524e0c.6.1719972809622; Tue, 02 Jul 2024
 19:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240626094153.27208-1-rbradford@rivosinc.com>
In-Reply-To: <20240626094153.27208-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:13:03 +1000
Message-ID: <CAKmqyKO0Lo7qCL-5uVNixaKe8H4=N2KXZUMUrUSB-mw76p81CQ@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Add decode for Zawrs extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Balaji Ravikumar <bravikumar@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Wed, Jun 26, 2024 at 7:43=E2=80=AFPM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> From: Balaji Ravikumar <bravikumar@rivosinc.com>
>
> Add disassembly support for these instructions from Zawrs:
>
> * wrs.sto
> * wrs.nto
>
> Signed-off-by: Balaji Ravikumar <bravikumar@rivosinc.com>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 90d6b26de9..e79788ea0a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -906,6 +906,8 @@ typedef enum {
>      rv_op_amocas_w =3D 875,
>      rv_op_amocas_d =3D 876,
>      rv_op_amocas_q =3D 877,
> +    rv_op_wrs_sto =3D 878,
> +    rv_op_wrs_nto =3D 879,
>  } rv_op;
>
>  /* register names */
> @@ -2096,6 +2098,8 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -3817,6 +3821,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_i=
sa isa)
>                      case 0: op =3D rv_op_ecall; break;
>                      case 32: op =3D rv_op_ebreak; break;
>                      case 64: op =3D rv_op_uret; break;
> +                    case 416: op =3D rv_op_wrs_nto; break;
> +                    case 928: op =3D rv_op_wrs_sto; break;
>                      }
>                      break;
>                  case 256:
> --
> 2.45.2
>
>

