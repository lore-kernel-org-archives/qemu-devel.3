Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30163C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKh6-00022e-BP; Mon, 03 Jun 2024 23:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKh4-00020x-K5; Mon, 03 Jun 2024 23:18:38 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKh2-0008PD-T0; Mon, 03 Jun 2024 23:18:38 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-80aca0fbcffso179488241.1; 
 Mon, 03 Jun 2024 20:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471115; x=1718075915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVGn+ROEU+OlLzw+7S8VjAW/C8tukqACCtDAR0K9Rog=;
 b=es4JG2FJNvovUp8OHaYzFYi6hxaBCXyxUcdCt6D3K7pxLOZ2Gkp/+9xxWoFCfoKovv
 dK9UzHnjX8PK98mND9dfoe0NERFSAFUX3YEtPY3noSK2vgObxZsaYmwHNDGjKGd+LpBB
 FDZm1gRKyBXP+VjYJuYdPGWinww/7wkLI//o1t/EePBIhGiCGDj9NfIxCvVTr4lcCGqF
 /nYoQ6/sBdcB8Rwbrx8gXYjT+uQ5pLIQyTmASNlbOR/Ix4k3DlHm7v4MtXpF1hCgHkiu
 6KJ95+OpqyoxEVN+r77r5lKuZ1cs6m3iEo3UTRZRez9rF9yFxvx3ADsyx7zKfAvqxEyS
 5e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471115; x=1718075915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVGn+ROEU+OlLzw+7S8VjAW/C8tukqACCtDAR0K9Rog=;
 b=R6ZsOHBjtsLeF1MxpONvexnR6e/JCoJqEr6Nq0BHNa8uZ6M7HvSLIOlaGbfQWC1YxV
 WrEvRDix+FjIgh/+BSCzzBQFjksnWnhCMS5paI2FvzvLDxPmTvRcVwSr+mftdVV1kktE
 jZXNbwIZVKQAmGDr19GdxSeTod1trPKMFnjOSQ5oCn+MbKzMRXxiAd1SGbBxThw04tEP
 wnUOLED3Wsv/YnCZf6/cwKMwHeet3pffT0DCdSMNwZL2mU2GmVY/Z+WhIWT5IcBIVT5z
 SHOMt5clvSDDV04zZIez6kibfKhC/FQFRVpu8tO1d13UEYfeIeeVWdBEdt6fTmop4k/m
 6sfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTLUSKTGCpjP4fOUKd1bo5H+14+hOY6G3OfXh0dvbcGmkvce03tQGHZm5Vf86CzsAIZjaqRVBgxOkB1FDUYvxfLXR2Lw=
X-Gm-Message-State: AOJu0YwcmuyemqUEeBMytrRTHQHPG59+vl4B4QwT8LOnDg8BaAbQElkC
 kOv+dQmoLXl8fJF2pduzJKPh+zidpTQJX+8+0IfH/gKEH3l6JjitRawCEE2Iqs1lvP+Hwxzp2yZ
 cRYLRQZVN00mF5qt6uw0uANuYiGE=
X-Google-Smtp-Source: AGHT+IEuqi4+jRLBWFvYo1pBsDrhVvED7o97v4T0aLB9Cy+RlWNc34i2QEaOuSSmjELKmhv267CtwWENwayqtxOv3/4=
X-Received: by 2002:a05:6102:3be8:b0:48b:a1c4:af56 with SMTP id
 ada2fe7eead31-48bc21c31e2mr9322305137.18.1717471115143; Mon, 03 Jun 2024
 20:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <20240523124045.1964-7-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240523124045.1964-7-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:18:09 +1000
Message-ID: <CAKmqyKM7bx55uipq=by5DeYKi1MAtYJ0RK6LU5TvLLNA_cNSjA@mail.gmail.com>
Subject: Re: [PATCH 6/6] disas/riscv: Support zabha disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Thu, May 23, 2024 at 10:46=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 41050246f3..849af82ddf 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -954,6 +954,26 @@ typedef enum {
>      rv_c_mop_11    =3D 923,
>      rv_c_mop_13    =3D 924,
>      rv_c_mop_15    =3D 925,
> +    rv_op_amoswap_b =3D 926,
> +    rv_op_amoadd_b  =3D 927,
> +    rv_op_amoxor_b  =3D 928,
> +    rv_op_amoor_b   =3D 929,
> +    rv_op_amoand_b  =3D 930,
> +    rv_op_amomin_b  =3D 931,
> +    rv_op_amomax_b  =3D 932,
> +    rv_op_amominu_b =3D 933,
> +    rv_op_amomaxu_b =3D 934,
> +    rv_op_amoswap_h =3D 935,
> +    rv_op_amoadd_h  =3D 936,
> +    rv_op_amoxor_h  =3D 937,
> +    rv_op_amoor_h   =3D 938,
> +    rv_op_amoand_h  =3D 939,
> +    rv_op_amomin_h  =3D 940,
> +    rv_op_amomax_h  =3D 941,
> +    rv_op_amominu_h =3D 942,
> +    rv_op_amomaxu_h =3D 943,
> +    rv_op_amocas_b  =3D 944,
> +    rv_op_amocas_h  =3D 945,
>  } rv_op;
>
>  /* register names */
> @@ -2192,6 +2212,26 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>      { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
>      { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
> +    { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
> +    { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2923,9 +2963,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>          case 11:
>              switch (((inst >> 24) & 0b11111000) |
>                      ((inst >> 12) & 0b00000111)) {
> +            case 0: op =3D rv_op_amoadd_b; break;
> +            case 1: op =3D rv_op_amoadd_h; break;
>              case 2: op =3D rv_op_amoadd_w; break;
>              case 3: op =3D rv_op_amoadd_d; break;
>              case 4: op =3D rv_op_amoadd_q; break;
> +            case 8: op =3D rv_op_amoswap_b; break;
> +            case 9: op =3D rv_op_amoswap_h; break;
>              case 10: op =3D rv_op_amoswap_w; break;
>              case 11: op =3D rv_op_amoswap_d; break;
>              case 12: op =3D rv_op_amoswap_q; break;
> @@ -2947,27 +2991,43 @@ static void decode_inst_opcode(rv_decode *dec, rv=
_isa isa)
>              case 26: op =3D rv_op_sc_w; break;
>              case 27: op =3D rv_op_sc_d; break;
>              case 28: op =3D rv_op_sc_q; break;
> +            case 32: op =3D rv_op_amoxor_b; break;
> +            case 33: op =3D rv_op_amoxor_h; break;
>              case 34: op =3D rv_op_amoxor_w; break;
>              case 35: op =3D rv_op_amoxor_d; break;
>              case 36: op =3D rv_op_amoxor_q; break;
> +            case 40: op =3D rv_op_amocas_b; break;
> +            case 41: op =3D rv_op_amocas_h; break;
>              case 42: op =3D rv_op_amocas_w; break;
>              case 43: op =3D rv_op_amocas_d; break;
>              case 44: op =3D rv_op_amocas_q; break;
> +            case 64: op =3D rv_op_amoor_b; break;
> +            case 65: op =3D rv_op_amoor_h; break;
>              case 66: op =3D rv_op_amoor_w; break;
>              case 67: op =3D rv_op_amoor_d; break;
>              case 68: op =3D rv_op_amoor_q; break;
> +            case 96: op =3D rv_op_amoand_b; break;
> +            case 97: op =3D rv_op_amoand_h; break;
>              case 98: op =3D rv_op_amoand_w; break;
>              case 99: op =3D rv_op_amoand_d; break;
>              case 100: op =3D rv_op_amoand_q; break;
> +            case 128: op =3D rv_op_amomin_b; break;
> +            case 129: op =3D rv_op_amomin_h; break;
>              case 130: op =3D rv_op_amomin_w; break;
>              case 131: op =3D rv_op_amomin_d; break;
>              case 132: op =3D rv_op_amomin_q; break;
> +            case 160: op =3D rv_op_amomax_b; break;
> +            case 161: op =3D rv_op_amomax_h; break;
>              case 162: op =3D rv_op_amomax_w; break;
>              case 163: op =3D rv_op_amomax_d; break;
>              case 164: op =3D rv_op_amomax_q; break;
> +            case 192: op =3D rv_op_amominu_b; break;
> +            case 193: op =3D rv_op_amominu_h; break;
>              case 194: op =3D rv_op_amominu_w; break;
>              case 195: op =3D rv_op_amominu_d; break;
>              case 196: op =3D rv_op_amominu_q; break;
> +            case 224: op =3D rv_op_amomaxu_b; break;
> +            case 225: op =3D rv_op_amomaxu_h; break;
>              case 226: op =3D rv_op_amomaxu_w; break;
>              case 227: op =3D rv_op_amomaxu_d; break;
>              case 228: op =3D rv_op_amomaxu_q; break;
> --
> 2.25.1
>
>

