Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C574AC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpcE-0001kM-9e; Tue, 02 Jul 2024 22:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpc1-0001jb-Tb; Tue, 02 Jul 2024 22:20:50 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpc0-0004rs-CO; Tue, 02 Jul 2024 22:20:49 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-48f44f892d5so1706255137.1; 
 Tue, 02 Jul 2024 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719973246; x=1720578046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mstgbm77qaQGwwyMAYrZ51352SMCBEKquMHKhllRUVY=;
 b=FgHULRXSNTz9eqymnfd4QENAI7MjKnlAqYcSvzZBODDN+LitNaun80rFulSV4QPIHI
 7dKs6GvDMqwGReOtbXpYPiEJyn4BnGVoMR0nl6eR8hRnFELcaWzNC12XTy/914inEznt
 bnc9VruOWcldG+ppPymoIoRDfzS7ZdZGdxic/4C6s9RfFWVHj/FjjscPnGaY6B0ig/+L
 JRNLoj6p2Vtlpd0p8H+vegRMMTfFOb2ldnmO8pS8V1aFo3RNp5jzp5MnbTSM1moMnAFP
 6MqWHWK3qMC+4HL5kBI0bZmeqH9Ctvx1F4vJdsUBNcDm3StOWi0B/1y60QkgJRf7BEdY
 GjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719973246; x=1720578046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mstgbm77qaQGwwyMAYrZ51352SMCBEKquMHKhllRUVY=;
 b=NtN3VcRSV2Jm9ajSSB+BlR8Ce9CZ+mJ423waDZM6hpk1O8YWChEj1skDJ8Cof04b3h
 k3K+tbhnm84aFzNXRlm1ZH5QGRnJkPp8gj+v4Cj+wYE8JCLBWKiQ89w3XDKmy2yzfC3z
 OB2+OhaPca8ygjTj/uIIXfT0+hOqZivwjaX3asE4YcrkrfDL984aV2SxtqNaMs5qZJ0p
 F9cJ9Vi5pTjSvByZJmlUqGrrqtT11aH8TxZnYqhcVDQOr6+Bnjls9juFoWRoNngpvPiG
 k0N/G0q398tBwz9qBG//UhgOK/77FmQUWDEj2U9nJT81R8gNGxmSbuJrkpKQtE/C/Uyb
 JReA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURBOuJ0XL/ai8XTdIwqer+j5brkfnB5Ayu57iyYOMLcp5aji/EoGLCE57VxqLDkIk5TCfsbRA03pp4cEKuR0jHUw1u0XQ=
X-Gm-Message-State: AOJu0YweF6cB7CxE1GSSlH2CjqaYLjh7Pk4F/TLyNHacQGeCf0Ipt+Qj
 zhsHXDAgkWjsGSnr4HKv9/ci9o4HgNq3Y7NtQtz6+MrACaWUKbo/9fIsffjQp0g4MhDLUICqZxs
 TqS5D+2bEkV3cNDSCdPzHVJJD+Rp1zPi0o8g=
X-Google-Smtp-Source: AGHT+IGDhAa+xbgYahb/Y1yg4Y04085U2ObKCTTfmdai3UhzgaVYKOUK7BDMFvGgH/PZWU8Exm2utxHdygyPbwyhdSM=
X-Received: by 2002:a67:ed4a:0:b0:48f:dcc7:9f6 with SMTP id
 ada2fe7eead31-48fdcc70b00mr874052137.20.1719973246222; Tue, 02 Jul 2024
 19:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240626094153.27208-1-rbradford@rivosinc.com>
In-Reply-To: <20240626094153.27208-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:20:20 +1000
Message-ID: <CAKmqyKMraFEP=3v8nwEP2hBa5_aPVnUJn+FLaOcg62Navnag+Q@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Add decode for Zawrs extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Balaji Ravikumar <bravikumar@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

Thanks for the patch. Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
re-sending

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

