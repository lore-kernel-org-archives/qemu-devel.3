Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4D2C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdyL-0000rK-TP; Sun, 07 Jul 2024 22:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdyK-0000k4-2I; Sun, 07 Jul 2024 22:19:20 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdyI-0001lS-C1; Sun, 07 Jul 2024 22:19:19 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-48fde3a2b17so1149862137.0; 
 Sun, 07 Jul 2024 19:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720405157; x=1721009957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acoq333b3C8guK9U0dvpe211RuNQEBkb3Ev0BsnkM3A=;
 b=F8og1GyQA6M6qCPsXeNKaBDTaBJb+I0CwSlPIfx+buP1HzRHUV0pl1ZUK/yoNs+sDD
 tqbljQTMjV1PQEvyoxipHGfs8eVWa9AIJIfQTrFCteFRbHiXenpfydJ6i/P2VW9dR57S
 5960RdlF9iGwy28Nx4+Xc3GORm7D/py1xrvoSMxaCPYmFLcZF9SXKKyzjcfyQH/fKUK6
 hyYhOJIJtwmnyqD2xd/kVYuoQ5iqejC2N7Wn99LwA48rL+i42Ez19bNhzvd7TeD0stZB
 p5Uo+DxnaaL4nyV6TEuaNt6BqAcJXla5KX4fdEehl/deGHY4KgTP4riGckEql/bsyxD1
 yzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720405157; x=1721009957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acoq333b3C8guK9U0dvpe211RuNQEBkb3Ev0BsnkM3A=;
 b=f0IzLTQ59blCEPE70zwq8YATMWsXgrn6qiUZ03nph8Sqn6Yr5URt0obk1VeLRXzyMU
 Y7lnOgx6QfVqzi4iKU/RzmD88JagPj9I960PuScForvfmipnIPagCn0M2qldwWz5j7p+
 4XGKL9iaSJxALK1TIbhsBwmk/XX5rYtzYs73GOBYIHvurqP0PV22N/UpVrEj13NextoI
 kpf+B2YmCg/lFm9ezIJzvGErTnTYIuMGqWZg1L0H/KAKuix4eGcM0smllvGRPTMLiEPK
 zm5SiRZfvscEDDLHnjD7D55734M702UIy007+EShKMh57OMqG4/cCcTW6nGEgUqa9CcU
 2SFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU37iJTnaaDiHQbKefTiJ8LPL235FBYr8RBVWdxop9lI4EuhInZYeXl8c131Yiyk92Om5ubYhHEc91ww6K46So5Pd/+KI=
X-Gm-Message-State: AOJu0YyuxqeNOkRaiNd6tfYDxAZlE2kC4Hg5/9S6RFUyCRSFJJO57q4r
 svpIBd6AWuL66UAJ1J/MkmekEpJbULSOrcURVEfY6BeN8CsfTxMfkvQewtlNUMEBtQc7621IPd6
 oLj3fD4e4K/n4b6diGboPRqBapg30PQ==
X-Google-Smtp-Source: AGHT+IGejtAaBV0WE7CvH411YCOEFx5WzluYvNfIz/Pu/hMKc0RoVWzODQCRjXLtBrKM6E9avurp0ZYJMmukHKQQKCA=
X-Received: by 2002:a05:6102:17c1:b0:48f:8ead:7a3 with SMTP id
 ada2fe7eead31-48fee65f2c4mr11037263137.9.1720405156835; Sun, 07 Jul 2024
 19:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240705165316.127494-1-rbradford@rivosinc.com>
In-Reply-To: <20240705165316.127494-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:18:50 +1000
Message-ID: <CAKmqyKO2cmGeSS_Fn3ney0W8OXg8ip0BSqQ1vdd-8=hNXNt9qA@mail.gmail.com>
Subject: Re: [PATCH v2] disas/riscv: Add decode for Zawrs extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Balaji Ravikumar <bravikumar@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Sat, Jul 6, 2024 at 2:54=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
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
> index 05b663ebfe..ff0323f0dd 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -974,6 +974,8 @@ typedef enum {
>      rv_op_amomaxu_h =3D 943,
>      rv_op_amocas_b  =3D 944,
>      rv_op_amocas_h  =3D 945,
> +    rv_op_wrs_sto =3D 946,
> +    rv_op_wrs_nto =3D 947,
>  } rv_op;
>
>  /* register names */
> @@ -2232,6 +2234,8 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
>      { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -4000,6 +4004,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_i=
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

