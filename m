Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE159C71150
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSgX-0002K5-4Y; Wed, 28 Aug 2024 20:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSgT-00027u-Jn; Wed, 28 Aug 2024 20:06:42 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSgO-0004Q8-OL; Wed, 28 Aug 2024 20:06:38 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-498d9a865c9so41222137.3; 
 Wed, 28 Aug 2024 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724889995; x=1725494795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H0SUUDnDwNtpiKPBF/yGIfTQn6dCuy4Wjf/3IAvDgQ=;
 b=a9zfLOYPXXRo+Hp98QLXVgvWKV2DjGElB5X/I+Co2034OQ0tytkLOYZDjUNS3M815g
 K3r6JCdqhqh3VEbAEV7zzLaO1PIRESiq7Q4e0TGZozIpHrpX05FAG1xJ9QgI61YAAYkz
 X35auIcILFycoqESJPGF0AOZRBdcMoNlDv10hjWVeTcnb6EXg3hf+JMCIgLBW2F9SB7g
 2ZYeQhQP3FQqHJ+l7SGvhRN1q7yPfrKN6JKD+cbZZQNfhSZf8U0vcO7K5k3nv+11N9Tq
 3+iasQuIOjJPlQGwIKbpM0vHNscuRSZgMWxq3az9wT8lBk1kUT545TCh+DliboVS4y8Q
 yEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724889995; x=1725494795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H0SUUDnDwNtpiKPBF/yGIfTQn6dCuy4Wjf/3IAvDgQ=;
 b=q2H32x0s0idBpwcR8u6WEdEiL4rix2TG3aWJ+w1jBI6gaVqC7DVRQilrR8mKWCiPZy
 ZzNZSt3z77N8bXTsLxjb6dp8iZPcZSjDavbnFvJGvNB0OWd0nj9B1pRxmij6jPTlMJpW
 MiHQhl7nNPhamng8o7Tg80HH92/TNp7zkm3e5moXu5Zyz2/SeHwhQ1I1cX+gqruJqdzr
 GdXeyDwgd5EbpWJm1PIZIN+cZJ/Q2arxWvVn9bWHnBFmPlMouR7yLwjsBbul+upwSzMm
 kjks0vLI+Jzje2ONURiZUCUd0UdiXE4DHk+pF+awOp3kigzr5lUXJbaLufvsTtQYxBN/
 tZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzAsjoAJx7//RCaGUw8BU1WP1+KykE4LiORzTNwr9GDOvYOUeXLzesm1/PVeriBG1EsrstXaj7UJxD@nongnu.org
X-Gm-Message-State: AOJu0YxnKYOwHuN88E9izaJDLuPjrGiSkb/25jiZ99Yy6j7pLZr4gxfU
 V6ChdNJ7xOm781dpJ6Dz4vE+BxbiXe3GgoaKnHLrMsv6aEFey1zfn8Qu0pVjTqyAasbSNh3Wyxn
 GDLy1CRNFGZrLI2yz0MxqwJsUKHo=
X-Google-Smtp-Source: AGHT+IGBKfkN8Kb8BH1SeEBXbyVWC3zZJH96OkfLQcCpEqITzIreIg+o7/pmNjTs38U2eChHSm6rlAP1WGwXD69A30s=
X-Received: by 2002:a05:6102:3914:b0:492:af0d:cf93 with SMTP id
 ada2fe7eead31-49a5b19f6b8mr1314859137.10.1724889995030; Wed, 28 Aug 2024
 17:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-20-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-20-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:06:09 +1000
Message-ID: <CAKmqyKOecAQ2MTPnsw1_tPTRF++QbCBGOEDKKUMM9R3HUvqdRw@mail.gmail.com>
Subject: Re: [PATCH v11 19/20] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Thu, Aug 29, 2024 at 3:53=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> sspush and sspopchk have equivalent compressed encoding taken from zcmop.
> cmop.1 is sspush x1 while cmop.5 is sspopchk x5. Due to unusual encoding
> for both rs1 and rs2 from space bitfield, this required a new codec.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 19 ++++++++++++++++++-
>  disas/riscv.h |  1 +
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 5eafb7f7f3..6e9ba42edd 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -980,6 +980,8 @@ typedef enum {
>      rv_op_ssrdp =3D 949,
>      rv_op_ssamoswap_w =3D 950,
>      rv_op_ssamoswap_d =3D 951,
> +    rv_op_c_sspush =3D 952,
> +    rv_op_c_sspopchk =3D 953,
>  } rv_op;
>
>  /* register names */
> @@ -2244,6 +2246,10 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
>      { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0=
 },
>      { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0=
 },
> +    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
> +      rv_op_sspush, 0 },
> +    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
> +      rv_op_sspopchk, 0 },
>  };
>
>  /* CSR names */
> @@ -2604,7 +2610,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>              if (dec->cfg->ext_zcmop) {
>                  if ((((inst >> 2) & 0b111111) =3D=3D 0b100000) &&
>                      (((inst >> 11) & 0b11) =3D=3D 0b0)) {
> -                    op =3D rv_c_mop_1 + ((inst >> 8) & 0b111);
> +                    unsigned int cmop_code =3D 0;
> +                    cmop_code =3D ((inst >> 8) & 0b111);
> +                    op =3D rv_c_mop_1 + cmop_code;
> +                    if (dec->cfg->ext_zicfiss) {
> +                        op =3D (cmop_code =3D=3D 0) ? rv_op_c_sspush : o=
p;
> +                        op =3D (cmop_code =3D=3D 2) ? rv_op_c_sspopchk :=
 op;
> +                    }
>                      break;
>                  }
>              }
> @@ -4923,6 +4935,11 @@ static void decode_inst_operands(rv_decode *dec, r=
v_isa isa)
>      case rv_codec_lp:
>          dec->imm =3D operand_lpl(inst);
>          break;
> +    case rv_codec_cmop_ss:
> +        dec->rd =3D rv_ireg_zero;
> +        dec->rs1 =3D dec->rs2 =3D operand_crs1(inst);
> +        dec->imm =3D 0;
> +        break;
>      };
>  }
>
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 4895c5a301..6a3b371cd3 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -167,6 +167,7 @@ typedef enum {
>      rv_codec_r2_imm2_imm5,
>      rv_codec_fli,
>      rv_codec_lp,
> +    rv_codec_cmop_ss,
>  } rv_codec;
>
>  /* structures */
> --
> 2.44.0
>
>

