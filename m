Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E20DC38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQeFw-0007GZ-9E; Sun, 07 Jul 2024 22:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeFs-0007FF-FH; Sun, 07 Jul 2024 22:37:28 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeFq-0005Zk-UP; Sun, 07 Jul 2024 22:37:28 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4f319616b79so212597e0c.3; 
 Sun, 07 Jul 2024 19:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720406245; x=1721011045; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngmQV77UOLNY8eARstKUe5+C55Lpfop8kUyqi4dIJEk=;
 b=EyM4DzN7PFLoPll9S4Z/eRJyVbAspIjbBi6zelGfsjTAVJw+ivqCIEaM/diNWcyqP/
 lHKc9866+369WfWgbeHfo4KsZjWdKw9/PoTa+04QsKw+Njf7hY5pw4aQ06mGg7CTzmUS
 9BjEmL7ojkARCvv1k+vgPan9JtHAzKdFJ6OJRVprpUylqdzlM9XMuBdWFxKegkcFk2ZC
 LikFhQi7bI0HcZ0cfCbrt5Pyhq7ZEB7z712wIxAvPLehaD0jBjbjsEZQxMBqmUEsl25S
 JjLZXF7gFBxwJf0Xpu0hwSj1BfHbugk/0jOn2StMTANDAz+BTlZ1oQqwiIrYHLCmiJ2X
 FPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720406245; x=1721011045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngmQV77UOLNY8eARstKUe5+C55Lpfop8kUyqi4dIJEk=;
 b=KBCueoIzTZgvwiBkMSChptfQUba7CbWMtgU4ZTOOzNCXZ2UjLDPnaGhtOsdMnYrKB0
 yI82gCgWv+U/9mUUmcvEAix3D3QrV0tC1DYUixf8ejKqoxMoEN3FJL8D1DmCcbLwoIy6
 F+8+aX7/LSTT1tgGJcaZ2hWaw1FFgcAGCgfijMEZrpTIX9HANdO3PQvjCp/Uf4iwHTmH
 VPY1RA8QakbhA1gYyPB6MRVlmErpfe4PfVoOWQ2CLeoVWRVzxlEje+9GpWt1WOvRpJ/W
 kWb1Lsqd+sHqM5Clm/ayVjqPTJXzT7tQfRY8VjU4EovR0R0UPLLNEhQQRmJgwrBlN3gB
 XfxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV2BXeryR2MzWixACA27YqKrWwACA3kyDfnh5kPki+up7nEseHHTv+jds1L7NNQ8EwYGSYWExn2P1Px82p+oprz+FZqjk=
X-Gm-Message-State: AOJu0Yw7aqDcMZb84YD/axjMHvBt4T2vAh1ZTbRkdcE29F9C7B5tuFuO
 YzfLvEM8v2+KdyDdpBoqRhqvi3Y2sEIy7vaYNvOyjuy0yuqMFW8FNsGSfZClk+N6QC7hus3kcG7
 tlLhH24ULL9xIKfuvhaBnrS4AIjU=
X-Google-Smtp-Source: AGHT+IEFw9T6v/pR8DRZa8q3m8SmVHwoXOpTBNrN7IJisDhM616Twe3AG2fGyZCePPaCC+QxLPPqfTGxXR6iVwrr8Vk=
X-Received: by 2002:a05:6122:3887:b0:4ef:64a8:c61b with SMTP id
 71dfb90a1353d-4f2f3ea4eabmr7088330e0c.7.1720406245256; Sun, 07 Jul 2024
 19:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240705165316.127494-1-rbradford@rivosinc.com>
In-Reply-To: <20240705165316.127494-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:36:59 +1000
Message-ID: <CAKmqyKP1ZcoW-XcWXQ_=cLqnv9Vu1kMe=K36RMSrBcTP6E-12A@mail.gmail.com>
Subject: Re: [PATCH v2] disas/riscv: Add decode for Zawrs extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Balaji Ravikumar <bravikumar@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

