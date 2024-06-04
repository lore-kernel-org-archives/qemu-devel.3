Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E252CC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIcT-0003bd-Tb; Mon, 03 Jun 2024 21:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIcR-0003b6-TM; Mon, 03 Jun 2024 21:05:43 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIcO-0002Tk-8n; Mon, 03 Jun 2024 21:05:43 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48bdcecf6efso496035137.3; 
 Mon, 03 Jun 2024 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717463136; x=1718067936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFuDBMea4o7/OJ3TpKxQ/uBafb3l2Vfljrcr5P1yuO4=;
 b=EZ/IauVosEYNZvh1LyyrLItLC+20XjKbZ13DhjbLpnK2k3oAw7citYXlcA1inNDBUC
 MDRZPpMMg+P1V4R5n1Lir2YlePUZsAY5ubl3REazvQO5sx2r1vs4Jh0RdCyN9BxPlpew
 wNzYlSWYVM2d070AxH1tuT9YxPZQAhYQTgA5xkBfDysxdu89Z6ip5RqRovHM2eAWIkdc
 EFATmznubQ46Vp2NAyU/+ufri/h537LVSIzJp6ffIhUMq3N/Xq0vkX674eVLL34vXtLm
 7JIDkg3saNKTo6xhbF1+Ren+WxyhXy9W+g4wAAZ/37x2HmdDKMYxBbNrs6ACJ/r/+SVC
 7nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717463136; x=1718067936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFuDBMea4o7/OJ3TpKxQ/uBafb3l2Vfljrcr5P1yuO4=;
 b=jKI9ZBDDr1V7Wm2br5apPXh/m1VS2WUJuYTa27VeaD8xZHUAPg4ErrRTif66hqY3VN
 1zTMyfdKksKmolB8aFSYYmCtaInbJG9PKfGw+p7gw0O0AMMa++Y/qtSTWEnzf2DKkVse
 YWAdfrTCHtG+KkyY1RjTFQx2VJv4RUsca616uVgvz4kL7NjFuQ9ICuXh08C7oelMTbgU
 GNIH7rK2YcRdtvnvxH4eNseklzJq7wDdCgs4O6KV8kLW5JvDfSdXbyly1uCQLYdEq6ag
 wvHhWtsNiDdVpi/eKrRS3jbHbty6LoIaCboFou3yKklk2DAuKJ66NpIQJ/kaV35raYBO
 RYOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJpkzhlJ2n8ytHGvGOjiAy6lCTajC7nbhmVY7kuTLL/uXj4M9QelrKSHyQfjd1T5+mPLmUxAvD4iPLds57Jdtz9GQXyE7fqJDlPipDBFYSiXBAnfkPDrNCuwGeSMoh
X-Gm-Message-State: AOJu0Yy/8aFB2NGPifP6Ak3TgLwCJipCUjb0rXCmbRrbz/redFKRujoE
 YRegLXP7FpmtyaciANksBo4J3eAwBlzP27L13nPC96zFTCLlgm27y++lJzNA/2774QI3PnYCbbJ
 4W2x/UQDOwUq427JB1u4RHSD2I6mJZkds
X-Google-Smtp-Source: AGHT+IEsgoeFs8lkovkHx95KhrQNennftzKU4WggLUZaV8LHR5ES/j6eAlS/1x6exxlAwp+w6knSmTnPT7Uh1RFdb+I=
X-Received: by 2002:a67:ce81:0:b0:48a:31d7:656e with SMTP id
 ada2fe7eead31-48bc2367ae1mr10165703137.30.1717463135966; Mon, 03 Jun 2024
 18:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <LO4P265MB66669BD6FF7CAB642AE30316933E2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
 <LO4P265MB6666B4EBBD3BE5DC8822C85E933D2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO4P265MB6666B4EBBD3BE5DC8822C85E933D2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 11:05:09 +1000
Message-ID: <CAKmqyKMyTckJn3MkGvKEQ4neC_h-UPVHt2XRFxnA5qwr5_VR+A@mail.gmail.com>
Subject: Re: [PATCH] Fix incorrect disassembly format for certain RISC-V
 instructions
To: Simeon Krastnikov <Simeon.Krastnikov@imgtec.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Shiva Chen <Shiva.Chen@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Wed, Apr 3, 2024 at 7:16=E2=80=AFPM Simeon Krastnikov
<Simeon.Krastnikov@imgtec.com> wrote:
>
> * The immediate argument to lui/auipc should be an integer in the interva=
l
>  [0x0, 0xfffff]; e.g., 'auipc 0xfffff' and not 'auipc -1'
> * The floating-point rounding mode is the last operand to the function,
>   not the first; e.g., 'fcvt.w.s a0, fa0, rtz' and not 'fcvt.w.s rtz,
> a0, fa0'. Note that fcvt.d.w[u] and fcvt.w[u].d are unaffected by the
> rounding mode and hence it is omitted from their disassembly.
> * When aq and rl are both present, they are not separated by a '.';
>   e.g., 'lr.d.aqrl' and not 'lr.d.aq.rl'.
>
> Based on the following assembly reference:
> https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.m=
d

I don't really follow these changes. I don't see most of the changes
mentioned in https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/=
riscv-asm.md

It might be worth for each dot point to point directly to the
reference on why we should change it. Also I don't think it is trivial
in the sense that it should go via the qemu-trivial tree.

Alistair

>
> Signed-off-by: Simeon Krastnikov <simeon.krastnikov@imgtec.com>
> ---
>  disas/riscv.c | 144 ++++++++++++++++++++++++++------------------------
>  disas/riscv.h |  10 ++--
>  2 files changed, 79 insertions(+), 75 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e236c8b5b7..71a3ab878f 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1311,98 +1311,98 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm, NULL, 0, 0, 0 },
>      { "flw", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
>      { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
> -    { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> +    { "fmadd.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fmsub.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fnmsub.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fnmadd.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fadd.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fsub.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fmul.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fdiv.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
>      { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_s, 0, 0, 0=
 },
>      { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_s, 0, 0,=
 0 },
>      { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_s, 0, 0,=
 0 },
>      { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
>      { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> +    { "fsqrt.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
>      { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.w.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.s.w", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.s.wu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
>      { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
>      { "fclass.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
>      { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.l.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.s.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.s.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
>      { "fld", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
>      { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
> -    { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> +    { "fmadd.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fmsub.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fnmsub.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fnmadd.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fadd.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fsub.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fmul.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fdiv.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
>      { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_d, 0, 0, 0=
 },
>      { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_d, 0, 0,=
 0 },
>      { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_d, 0, 0,=
 0 },
>      { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
>      { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.s.d", rv_codec_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.d.s", rv_codec_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },
> +    { "fsqrt.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
>      { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.w.d", rv_codec_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.d.w", rv_codec_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.d.wu", rv_codec_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
>      { "fclass.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.l.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
>      { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.d.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.d.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
>      { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
>      { "flq", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
>      { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
> -    { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0=
, 0 },
> -    { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, =
0, 0 },
> -    { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
> +    { "fmadd.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fmsub.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0=
, 0 },
> +    { "fnmsub.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fnmadd.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, =
0, 0 },
> +    { "fadd.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fsub.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fmul.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
> +    { "fdiv.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
>      { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_q, 0, 0, 0=
 },
>      { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_q, 0, 0,=
 0 },
>      { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_q, 0, 0,=
 0 },
>      { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
>      { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.s.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.d.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fsqrt.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
>      { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
>      { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.w.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.w", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.wu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
>      { "fclass.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> -    { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> +    { "fcvt.l.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.q.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
>      { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
>      { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
>      { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_ad=
di,
> @@ -2009,8 +2009,8 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
>      { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> -    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> +    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
>      { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 =
},
>      { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 =
},
>      { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, =
0 },
> @@ -2031,15 +2031,15 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
>      { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
>      { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
> -    { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
> -    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
> +    { "fround.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "froundnx.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fround.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "froundnx.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fround.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "froundnx.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fround.h", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "froundnx.h", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
> +    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
>      { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
>      { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0, 0, 0 },
>      { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> @@ -4854,7 +4854,8 @@ static void format_inst(char *buf, size_t buflen, s=
ize_t tab, rv_decode *dec)
>              break;
>          case 'U':
>              fmt++;
> -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> +            uint32_t uimm =3D dec->imm >=3D 0 ? dec->imm : ((1 << 20) + =
dec->imm);
> +            snprintf(tmp, sizeof(tmp), "0x%" PRIx32, uimm >> 12);
>              append(buf, tmp, buflen);
>              if (*fmt =3D=3D 'o') {
>                  while (strlen(buf) < tab * 2) {
> @@ -4939,7 +4940,10 @@ static void format_inst(char *buf, size_t buflen, =
size_t tab, rv_decode *dec)
>              }
>              break;
>          case 'R':
> -            if (dec->rl) {
> +            if (dec->aq && dec->rl) {
> +                append(buf, "rl", buflen);
> +            }
> +            else if (dec->rl) {
>                  append(buf, ".rl", buflen);
>              }
>              break;
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 16a08e4895..a7a2a49971 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -237,11 +237,11 @@ enum {
>  #define rv_fmt_rd_frs1                "O\t0,4"
>  #define rv_fmt_rd_frs1_frs2           "O\t0,4,5"
>  #define rv_fmt_frd_frs1_frs2          "O\t3,4,5"
> -#define rv_fmt_rm_frd_frs1            "O\tr,3,4"
> -#define rv_fmt_rm_frd_rs1             "O\tr,3,1"
> -#define rv_fmt_rm_rd_frs1             "O\tr,0,4"
> -#define rv_fmt_rm_frd_frs1_frs2       "O\tr,3,4,5"
> -#define rv_fmt_rm_frd_frs1_frs2_frs3  "O\tr,3,4,5,6"
> +#define rv_fmt_frd_frs1_rm            "O\t3,4,r"
> +#define rv_fmt_frd_rs1_rm             "O\t3,1,r"
> +#define rv_fmt_rd_frs1_rm             "O\t0,4,r"
> +#define rv_fmt_frd_frs1_frs2_rm       "O\t3,4,5,r"
> +#define rv_fmt_frd_frs1_frs2_frs3_rm  "O\t3,4,5,6,r"
>  #define rv_fmt_rd_rs1_imm             "O\t0,1,i"
>  #define rv_fmt_rd_rs1_offset          "O\t0,1,i"
>  #define rv_fmt_rd_offset_rs1          "O\t0,i(1)"
> --
> 2.25.1
>

