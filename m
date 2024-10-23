Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0564DD2E008
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3RDT-00052x-Mo; Tue, 22 Oct 2024 22:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RDE-00050v-CS; Tue, 22 Oct 2024 22:35:04 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RDC-0001qE-4e; Tue, 22 Oct 2024 22:35:04 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d431b0ae2so237389e0c.1; 
 Tue, 22 Oct 2024 19:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729650899; x=1730255699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJLZu3wfzWsMU2KyeCkcJ12E76myWXaAn0vOgGxkH10=;
 b=gJgimGyZ3xTOVwa3b+XGsitIxHF7wVK9ZBNcy6WcMWsY69hDRscnRtc8CuGyFo2G48
 2lV8wnvE1fTZOi+M+/lxI7VOFiS7Yc1ypPUKRe9GN73SEn/5yFauONiUaCN3ovG4QJ2V
 kiK0pVmE6k8Nevlsr/ReAesOCqGyKxzqGOTOtY2IQ8SQid/YRV1i+Ei3p3RQzwM+g4ls
 ydCdHN432pvFQArzMHzzFPZmxIlxDSwZ0OVKOqYFenIXXBRJJpBFitRHBOcvO7XdJ0lT
 tI1kmn/Av9UkwOPaJ+GVX75Zfdi3sLna0vskR42joWbiT+lVUSkBq+dQ84N9nasNkorA
 1cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729650899; x=1730255699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJLZu3wfzWsMU2KyeCkcJ12E76myWXaAn0vOgGxkH10=;
 b=S0nxiYNsqViinlY5ZDQJYVhrxwuu8p7UblrzXtP9kmaLrfICkRFbvEOGlk01z3BiWa
 v13AYH0H76MQueVISKZ/y0ZmTDlFP4/yzLDaEEnH6LSL6r5LATCkKFeYInFoHRT6ISXc
 5UELWHYtgX9tkdDKuNN2JslDI6y72Xig3fpQlI08UhRs/OasAMA1MdKThQx5R0b+We1f
 r0/ITx+dZh7QfQMmkiVhINxLjXLSbnb4K5eT5Pd3lzMGsyj5end72xciUFC06gSQ1AxL
 okHE5ewOnWOWJO80SSSs0TKPQNCDk9MbVU7eogWYoiX3D07xokTbg+pNG8l1jqdk64VK
 ToUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq4/mCi/pus/orrxPTj5US0fssWJXy23kSi76xVurJ12eeXEDYk21nEe25EmED3aIc/+0DV0xzVskL@nongnu.org
X-Gm-Message-State: AOJu0YxWJRimVSI6KUIrlEgmiQ3AAnaovUKpUJ64jU8/ctIZLo05s3iv
 LnbWaxgWlJbNIqq8Fx/NVshXRn91tQh93+p67zGxfe/+K5Yf50aqSiiiIjrXOG0BnPhrlCUOvAG
 ulyu/4OPo5vG47j4gIP9LNHmmuZs=
X-Google-Smtp-Source: AGHT+IHf2vyEuQdzcJnt8LRAiH7NqF7MfE9waoSMNDg1s5spV7NK+SQ5ILEgXmMKNtyVsJ3F9kYZ3YVlDTILBfK/hvA=
X-Received: by 2002:a05:6122:3221:b0:50d:45e1:f32c with SMTP id
 71dfb90a1353d-50fb2ef568amr5152540e0c.2.1729650899259; Tue, 22 Oct 2024
 19:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241022001134.828724-1-richard.henderson@linaro.org>
 <20241022001134.828724-10-richard.henderson@linaro.org>
In-Reply-To: <20241022001134.828724-10-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 Oct 2024 12:34:33 +1000
Message-ID: <CAKmqyKOMZQsy333uGYquoBA9SHep8yHaCFmxHH_3n42OrxHDtg@mail.gmail.com>
Subject: Re: [PATCH v7 09/14] tcg/riscv: Accept constant first argument to
 sub_vec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use vrsub.vi to subtract from a constant.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target-con-set.h | 1 +
>  tcg/riscv/tcg-target.c.inc     | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-se=
t.h
> index 97e6ecdb0f..d8ce5414f5 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -25,6 +25,7 @@ C_O0_I2(v, r)
>  C_O1_I1(v, r)
>  C_O1_I1(v, v)
>  C_O1_I2(v, v, v)
> +C_O1_I2(v, vK, v)
>  C_O1_I2(v, v, vK)
>  C_O1_I2(v, v, vL)
>  C_O1_I4(v, v, vL, vK, vK)
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index ce8d6d0293..1ce2f291d3 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2350,7 +2350,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcod=
e opc,
>          break;
>      case INDEX_op_sub_vec:
>          set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
> +        if (const_args[1]) {
> +            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
> +        } else {
> +            tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
> +        }
>          break;
>      case INDEX_op_and_vec:
>          set_vtype_len(s, type);
> @@ -2565,7 +2569,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGO=
pcode op)
>      case INDEX_op_xor_vec:
>          return C_O1_I2(v, v, vK);
>      case INDEX_op_sub_vec:
> -        return C_O1_I2(v, v, v);
> +        return C_O1_I2(v, vK, v);
>      case INDEX_op_cmp_vec:
>          return C_O1_I2(v, v, vL);
>      case INDEX_op_cmpsel_vec:
> --
> 2.43.0
>

