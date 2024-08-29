Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AB0C7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSeu-0003bE-58; Wed, 28 Aug 2024 20:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSeZ-0002LC-US; Wed, 28 Aug 2024 20:04:43 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSeY-00047E-39; Wed, 28 Aug 2024 20:04:43 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so50822eaf.2; 
 Wed, 28 Aug 2024 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724889880; x=1725494680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtLYdyUJh8ojTBRHftT2Qjtv3UJm2n8g3X6/RdzwZzw=;
 b=k9h2LLDmOmFBNhcyGjJz5L44kgqVorsuwtUC9q7uncFwu2/W01CHAAM2G2CgjDrn6B
 aBpC5n8zk7zxz62QRnm402QsNq7HK1WpLnip3DIpeV/LNiEkwEsp+EakGyTzzyPEzDnY
 lnXTjeyYQfL0c/rn58WoC16fNxDnELSKP3lVHMX+kVKzZT11xLjFq8g5M/jIGqMphVGQ
 6gTxjN0nvlphiIV3aARs9XX6fdhexPJ586mAlY+WuCntozcyteWWu8PNtSstE6t66aNe
 YZp5Pa3DxpGa6jPJR0Z9BHs5QM9JWG8DBOJIB3u+fs42jYBFpaEB33AxOLeoQgKpne1L
 KFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889880; x=1725494680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtLYdyUJh8ojTBRHftT2Qjtv3UJm2n8g3X6/RdzwZzw=;
 b=VdfdYZ98MBEh6iBicJBqQ2Ea2w/FrxJifuHR4J41Dt1uMItGIcJ41AEbOT6jrtFzkr
 9fGpL8p4/nZQ1lcdxNPEY4KbX5N05Z9BnSIveBU+k7UW4B08pX7KvbJkOC6Vn4KJ0m+D
 f3BL6YtjY7yfNsOYQzvdgeCbruW6zEHh4D/CMWsfzwdW6Zbr45CsSnyNldVzatVlqvjQ
 ol8ydzLS+VdyC042gEBhgGHgcqcjsLtTRYaMlmq7rAHDi7HuomcNxt7cfSfgytyPvVEm
 m67CPwQf+Cb5wrMzpmk7OcIh0mGCnf2dhKfIp7yPNcd37D9buwoO5t0jgkK1dNt1wmgO
 z2zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqal/pmuJ5vxSimfWpbtaptHnTB1UYRVAxnZN9owUlDS2o52RTrTBZYkaImvTq3maR1WtnONyAKOM9@nongnu.org
X-Gm-Message-State: AOJu0Yw1WoplBlNGUyHGS89AdBQPeC4SN3EnGeEqRPHKEzX7YpXB93wj
 yUpz75iss25H8yr/NSBnbUF6yA4/erOgGVSdn/mSjJ+KMcQQbsUqHwHIucuzaIvsjkxViUsczdD
 vCQsenbi15y0CxvNmg4G/2QMja5o=
X-Google-Smtp-Source: AGHT+IG6u8wlGEqVHyp8FpAK32BTXraEsMUyJDXl6KU/4unk3kqbkFEGeb4pjiis0llzcLHgnRC+jdoPe5QyZyjCBQA=
X-Received: by 2002:a05:6808:30a1:b0:3db:5260:a994 with SMTP id
 5614622812f47-3df05ee4121mr1213325b6e.42.1724889880285; Wed, 28 Aug 2024
 17:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-19-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-19-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:04:14 +1000
Message-ID: <CAKmqyKO55AX_oKzs23+5wNZ5TC+dZ0kyO7vQXXbKLn_7hZjLJg@mail.gmail.com>
Subject: Re: [PATCH v11 18/20] disas/riscv: enable disassembly for zicfiss
 instructions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2f.google.com
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

On Thu, Aug 29, 2024 at 3:52=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Enable disassembly for sspush, sspopchk, ssrdp & ssamoswap.
> Disasembly is only enabled if zimop and zicfiss ext is set to true.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  disas/riscv.h |  1 +
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index c7c92acef7..5eafb7f7f3 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -975,6 +975,11 @@ typedef enum {
>      rv_op_amocas_b  =3D 944,
>      rv_op_amocas_h  =3D 945,
>      rv_op_lpad =3D 946,
> +    rv_op_sspush =3D 947,
> +    rv_op_sspopchk =3D 948,
> +    rv_op_ssrdp =3D 949,
> +    rv_op_ssamoswap_w =3D 950,
> +    rv_op_ssamoswap_d =3D 951,
>  } rv_op;
>
>  /* register names */
> @@ -2234,6 +2239,11 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
> +    { "sspush", rv_codec_r, rv_fmt_rs2, NULL, 0, 0, 0 },
> +    { "sspopchk", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +    { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
> +    { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0=
 },
> +    { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0=
 },
>  };
>
>  /* CSR names */
> @@ -2251,6 +2261,7 @@ static const char *csr_name(int csrno)
>      case 0x0009: return "vxsat";
>      case 0x000a: return "vxrm";
>      case 0x000f: return "vcsr";
> +    case 0x0011: return "ssp";
>      case 0x0015: return "seed";
>      case 0x0017: return "jvt";
>      case 0x0040: return "uscratch";
> @@ -3077,6 +3088,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_i=
sa isa)
>              case 66: op =3D rv_op_amoor_w; break;
>              case 67: op =3D rv_op_amoor_d; break;
>              case 68: op =3D rv_op_amoor_q; break;
> +            case 74: op =3D rv_op_ssamoswap_w; break;
> +            case 75: op =3D rv_op_ssamoswap_d; break;
>              case 96: op =3D rv_op_amoand_b; break;
>              case 97: op =3D rv_op_amoand_h; break;
>              case 98: op =3D rv_op_amoand_w; break;
> @@ -4028,7 +4041,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_i=
sa isa)
>              case 3: op =3D rv_op_csrrc; break;
>              case 4:
>                  if (dec->cfg->ext_zimop) {
> -                    int imm_mop5, imm_mop3;
> +                    int imm_mop5, imm_mop3, reg_num;
>                      if ((extract32(inst, 22, 10) & 0b1011001111)
>                          =3D=3D 0b1000000111) {
>                          imm_mop5 =3D deposit32(deposit32(extract32(inst,=
 20, 2),
> @@ -4036,11 +4049,36 @@ static void decode_inst_opcode(rv_decode *dec, rv=
_isa isa)
>                                                         extract32(inst, 2=
6, 2)),
>                                               4, 1, extract32(inst, 30, 1=
));
>                          op =3D rv_mop_r_0 + imm_mop5;
> +                        /* if zicfiss enabled and mop5 is shadow stack *=
/
> +                        if (dec->cfg->ext_zicfiss &&
> +                            ((imm_mop5 & 0b11100) =3D=3D 0b11100)) {
> +                                /* rs1=3D0 means ssrdp */
> +                                if ((inst & (0b011111 << 15)) =3D=3D 0) =
{
> +                                    op =3D rv_op_ssrdp;
> +                                }
> +                                /* rd=3D0 means sspopchk */
> +                                reg_num =3D (inst >> 15) & 0b011111;
> +                                if (((inst & (0b011111 << 7)) =3D=3D 0) =
&&
> +                                    ((reg_num =3D=3D 1) || (reg_num =3D=
=3D 5))) {
> +                                    op =3D rv_op_sspopchk;
> +                                }
> +                        }
>                      } else if ((extract32(inst, 25, 7) & 0b1011001)
>                                 =3D=3D 0b1000001) {
>                          imm_mop3 =3D deposit32(extract32(inst, 26, 2),
>                                               2, 1, extract32(inst, 30, 1=
));
>                          op =3D rv_mop_rr_0 + imm_mop3;
> +                        /* if zicfiss enabled and mop3 is shadow stack *=
/
> +                        if (dec->cfg->ext_zicfiss &&
> +                            ((imm_mop3 & 0b111) =3D=3D 0b111)) {
> +                                /* rs1=3D0 and rd=3D0 means sspush */
> +                                reg_num =3D (inst >> 20) & 0b011111;
> +                                if (((inst & (0b011111 << 15)) =3D=3D 0)=
 &&
> +                                    ((inst & (0b011111 << 7)) =3D=3D 0) =
&&
> +                                    ((reg_num =3D=3D 1) || (reg_num =3D=
=3D 5))) {
> +                                    op =3D rv_op_sspush;
> +                                }
> +                        }
>                      }
>                  }
>                  break;
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 1182457aff..4895c5a301 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -224,6 +224,7 @@ enum {
>
>  #define rv_fmt_none                   "O\t"
>  #define rv_fmt_rs1                    "O\t1"
> +#define rv_fmt_rs2                    "O\t2"
>  #define rv_fmt_offset                 "O\to"
>  #define rv_fmt_pred_succ              "O\tp,s"
>  #define rv_fmt_rs1_rs2                "O\t1,2"
> --
> 2.44.0
>
>

