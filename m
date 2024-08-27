Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FA5C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sincN-0004MB-DK; Tue, 27 Aug 2024 00:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sincK-00048N-Vd; Tue, 27 Aug 2024 00:15:41 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sincI-0007qU-Bq; Tue, 27 Aug 2024 00:15:40 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-498debdf653so1735984137.1; 
 Mon, 26 Aug 2024 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724732136; x=1725336936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjvSzCBL+Kn+8YKPSPu9q9Hzr6T578Nltsb5vjwLkLw=;
 b=G6aI7MRO2CII0WWvoLM4/ZQ8Q6fpCw2XHRiDNBrOF6OXDfg07fkPLQt+iBmE3BK8RF
 S4wB2HoO9/MvG3iTKZYxaanTl9on4TBFdFmxKmSj45wr1x7JTvzksVd2JVEKPzoX9q68
 i8e/V5oV2FHz94h+FZvb1OWT5jHRAoUOK0FlU0C4QwTK9lC6XvwL4SNGZDlpB3LtKz9u
 AhVEWlHyN8mS6x74yggTk/LaCla3GQuEb5zSwbFLZ2RfF39KF+TwFNmARBgLmbS5IhSv
 4RUmQg6xijFtfDkdw6H+/FF/PvEBDraGzY7GKhwWQPBLUeonxkHaNt9eT2cnRF27yhzz
 yx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724732136; x=1725336936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjvSzCBL+Kn+8YKPSPu9q9Hzr6T578Nltsb5vjwLkLw=;
 b=eP/QoKtr/1iuP6aBG3Y0FYjYD5wV+tzINuNhLAwTSOo5kjyr7JU3BluAUPvy8lQm/m
 Wttcre8OS0r2fNnKZU1uk7Ymem7s8MGMQKSO+gsTLz4IWq/j1417sw9xAXSucnWlMk6r
 lfXNAprze4xAsIAB6Fq2trxX+GZ1ivwtiZcT0zmWxMi7UNAx/78a8LDj7PmxxeHXvpSV
 f6bc5SocoPm25iZeJZOPwn+z0jUs0TMQXO7p9Mg6RnITjABN/zC0KGjmlGd0b8bW8hwc
 R17cmZ1FaKCCAf+EnJF1LRxGsObb6I3Ct6XYVDJRYWPq2hqykbIhCqPlrs5uXKmnZjxT
 n0qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOsiJrLOMAXk355USG65L72o3wdfdW1Kf9gntM4cazrNzwykKbZgXuqP0TKi7PlARD7JcbTFnfJyJe@nongnu.org
X-Gm-Message-State: AOJu0Yx3fXgMTTMx2N0nIRzmvXE0zCxmfEs4et7LA4YUjodwH10N8rl0
 vcgxWh8nD+akrKHD7kJIgnC2xDQKHmqhVHuqA5M7oGFbjm8qxttK4tnBnqQIeus/T6LpZwhVUKH
 BLzLzKJFeXuOVlxAO9V2ekyqL8HN6rQy70gU=
X-Google-Smtp-Source: AGHT+IFzuSEMcRr6qMFOadVdQABSQswD5esy/OtiE0xwg3XbdHGiGFXVtcZLM7GRNqsDn7rAobc8ZGpSZ34B6LxBceE=
X-Received: by 2002:a05:6102:3583:b0:48f:3df9:ff9 with SMTP id
 ada2fe7eead31-498f454d6e6mr15758622137.8.1724732136490; Mon, 26 Aug 2024
 21:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-8-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-8-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 14:15:10 +1000
Message-ID: <CAKmqyKN=JVVEDHbN+4Dw-O1KK--mMA4x46QDOK2jXS1P8eM+bw@mail.gmail.com>
Subject: Re: [PATCH v9 07/17] disas/riscv: enable `lpad` disassembly
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Tue, Aug 27, 2024 at 1:32=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 18 +++++++++++++++++-
>  disas/riscv.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index c8364c2b07..c7c92acef7 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -974,6 +974,7 @@ typedef enum {
>      rv_op_amomaxu_h =3D 943,
>      rv_op_amocas_b  =3D 944,
>      rv_op_amocas_h  =3D 945,
> +    rv_op_lpad =3D 946,
>  } rv_op;
>
>  /* register names */
> @@ -2232,6 +2233,7 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 }=
,
>      { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2925,7 +2927,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>              case 7: op =3D rv_op_andi; break;
>              }
>              break;
> -        case 5: op =3D rv_op_auipc; break;
> +        case 5:
> +            op =3D rv_op_auipc;
> +            if (dec->cfg->ext_zicfilp &&
> +                (((inst >> 7) & 0b11111) =3D=3D 0b00000)) {
> +                op =3D rv_op_lpad;
> +            }
> +            break;
>          case 6:
>              switch ((inst >> 12) & 0b111) {
>              case 0: op =3D rv_op_addiw; break;
> @@ -4482,6 +4490,11 @@ static uint32_t operand_tbl_index(rv_inst inst)
>      return ((inst << 54) >> 56);
>  }
>
> +static uint32_t operand_lpl(rv_inst inst)
> +{
> +    return inst >> 12;
> +}
> +
>  /* decode operands */
>
>  static void decode_inst_operands(rv_decode *dec, rv_isa isa)
> @@ -4869,6 +4882,9 @@ static void decode_inst_operands(rv_decode *dec, rv=
_isa isa)
>          dec->imm =3D sextract32(operand_rs2(inst), 0, 5);
>          dec->imm1 =3D operand_imm2(inst);
>          break;
> +    case rv_codec_lp:
> +        dec->imm =3D operand_lpl(inst);
> +        break;
>      };
>  }
>
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 16a08e4895..1182457aff 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -166,6 +166,7 @@ typedef enum {
>      rv_codec_r2_immhl,
>      rv_codec_r2_imm2_imm5,
>      rv_codec_fli,
> +    rv_codec_lp,
>  } rv_codec;
>
>  /* structures */
> @@ -228,6 +229,7 @@ enum {
>  #define rv_fmt_rs1_rs2                "O\t1,2"
>  #define rv_fmt_rd_imm                 "O\t0,i"
>  #define rv_fmt_rd_uimm                "O\t0,Ui"
> +#define rv_fmt_imm                    "O\ti"
>  #define rv_fmt_rd_offset              "O\t0,o"
>  #define rv_fmt_rd_uoffset             "O\t0,Uo"
>  #define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
> --
> 2.44.0
>
>

