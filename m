Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C1BC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJqY-0005Kk-JI; Mon, 03 Jun 2024 22:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJqW-0005Jr-To; Mon, 03 Jun 2024 22:24:20 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJqV-0004R3-Cc; Mon, 03 Jun 2024 22:24:20 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-48bdacabb43so146996137.3; 
 Mon, 03 Jun 2024 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467858; x=1718072658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW5CbtxuaoZows9bWqiQvmFoorN0d9bgv4iT+dlfljk=;
 b=Ya6cmN2vPhZi9hE4ZRM0FDLYkaTvx2Zi+IcSKX0AAJoMlt1A5frxyi3yo7NdxOH5p+
 fQtvU0NXVpqaNlAb++nzr+FaFsdeqE1XLsMknTfEdLVTYLlC9AGAAc26Mf89xP9EJD/8
 m+KHqKrjH+qK3OobT6hkpaJCUvgM8kN/6ln6HCEsg7XsSk7dS3YuVtYm+P0CxzjsA1IH
 QO10pcmHC6j6zZbeVzNoJ5epr9hhJ5bl5BeahS4OOnqlTqWUefcO/Hdq2qxAA3WksH16
 hjO6uL6YULN5rCLWJxQdqrBnW/33OhALZrN/kyC7aM27u0k+nfNZYwEggD5gEQpBu9Fs
 anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467858; x=1718072658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AW5CbtxuaoZows9bWqiQvmFoorN0d9bgv4iT+dlfljk=;
 b=DXxBMAnTw3OKVnyMIR3xifuXgDUdxaIEby2BRbEOuhGHr1keaovRjqEp4A9b8/R3Vv
 auA11y9QEXFPy6MVRHVJKeb/OYFDK7hVcXQuC7p7Pcp6dIqGtATeBILBho+rElV8wdqe
 QehIfMJgbWIrx6eFr/qNIuIvZLVIbIVtTDV8Fcb0ND3xSXyTjKXA0H/Hz+RwMydl9sj5
 rovmbWKxPE/LgVbLonuHCxxes3h1NP5ppThRP6lnj2kKd7DZ4njcq8yFXATk/e7vVsiU
 80ZVLg7VZ/F59L127rdH2s/qXNskNSMSvoDtSFDBG8NLbGDfSEnGOLGWt2pQyQrjjk2g
 n3xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqddY9ymRuxCLYx/k2e4gvve8JEMOnIg9cjacGi4eXp1ilknZIpjx6dRwRRJrh3NGppOHFZ8C1xW+GjBt+5lLWmav2Uuk=
X-Gm-Message-State: AOJu0YzD8Vs8owyj8SuXgcDRNfj6hEqrN7Uc+wfMh0dDX3RlipkcsNdL
 JlZuD+rd/WmdWaVmgtkq4kLVF1wgFLdqLWm1s0xwL9eGhkX9qtiBko9Kp16qtcUUIo4JBsEdl9/
 6De7l2iX30YAam9h2y8VUtBFyJ2clPw==
X-Google-Smtp-Source: AGHT+IG4MAVGD9p8mxF50/GL+OqqaVwBpSIIcu67qAhSTn/Ulq8f7ZVD9dSIAixc0fky6TSvuJfOtXu6EzjfUW2rAwQ=
X-Received: by 2002:a05:6102:5f61:b0:47e:f540:f461 with SMTP id
 ada2fe7eead31-48bc214d47fmr8493231137.11.1717467857813; Mon, 03 Jun 2024
 19:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240522062905.1799-5-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:23:51 +1000
Message-ID: <CAKmqyKOYTz4muba1mrGUSRDk+2-H+pkq9PyFeTJa7X1_aiNVig@mail.gmail.com>
Subject: Re: [PATCH 4/4] disas/riscv: Support zcmop disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 iwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Wed, May 22, 2024 at 4:33=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Although in QEMU disassemble, we usually lift compressed instruction
> to an normal format when display the instruction name. For C.MOP.n,
> it is more reasonable to directly display its compressed name, because
> its behavior can be redefined by later extension.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 4cd769f165..41050246f3 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -946,6 +946,14 @@ typedef enum {
>      rv_mop_rr_5    =3D 915,
>      rv_mop_rr_6    =3D 916,
>      rv_mop_rr_7    =3D 917,
> +    rv_c_mop_1     =3D 918,
> +    rv_c_mop_3     =3D 919,
> +    rv_c_mop_5     =3D 920,
> +    rv_c_mop_7     =3D 921,
> +    rv_c_mop_9     =3D 922,
> +    rv_c_mop_11    =3D 923,
> +    rv_c_mop_13    =3D 924,
> +    rv_c_mop_15    =3D 925,
>  } rv_op;
>
>  /* register names */
> @@ -2176,6 +2184,14 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>      { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "c.mop.1",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.3",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.5",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.7",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.9",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2469,6 +2485,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>              break;
>          case 2: op =3D rv_op_c_li; break;
>          case 3:
> +            if (dec->cfg->ext_zcmop) {
> +                if ((((inst >> 2) & 0b111111) =3D=3D 0b100000) &&
> +                    (((inst >> 11) & 0b11) =3D=3D 0b0)) {
> +                    op =3D rv_c_mop_1 + ((inst >> 8) & 0b111);
> +                    break;
> +                }
> +            }
>              switch ((inst >> 7) & 0b11111) {
>              case 2: op =3D rv_op_c_addi16sp; break;
>              default: op =3D rv_op_c_lui; break;
> --
> 2.25.1
>
>

