Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD815C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X7W-00026C-DG; Mon, 28 Apr 2025 18:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X7T-00021O-2c; Mon, 28 Apr 2025 18:38:35 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X7O-0001vE-1u; Mon, 28 Apr 2025 18:38:34 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so6335286241.1; 
 Mon, 28 Apr 2025 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879902; x=1746484702; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpUqHcnBd43LP2hUATKl39DJgX3NyFvdkJczrM5CSy0=;
 b=AWVaNTaEGD5qc39c/GEe+VNEFRt0b5+60JU2N0h9hUrd9Bu0+0Yg1/XksLWQGvd3Yh
 KgCHCcGriSHAO5si2L4jprI+OdcZlzkgqeQnFp9mnTq5cSzLlTV8QsLzQJ+f4DrAPt6O
 JdrBO4W5i/cnknhAMg9P44khv6ezG/w+w6tFPIAIslUYbhBU46v75lLlrmCL4IaZLvfb
 o7TRrGDPapdwN7c7c6CttjQf1CdLCjLJU3ME0pahI3HwKQszibHVvMrn5EDtoWXDH/WN
 UwALBpLIUTcXFCy4pl3PCx5JC9xLczISKe9EmolszMzYIkjVT9wPE5LTLupH3hWkMRVc
 8reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879902; x=1746484702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpUqHcnBd43LP2hUATKl39DJgX3NyFvdkJczrM5CSy0=;
 b=LJbKlM/fLKKTpUO0lSer286lOthWY7HQfBRisPWopUsd1tNH9qdI13ifScUj4fcabK
 dsJcVPgd8lyiKJqfEs2FdCa1zg3mSTxkNUX9pq4x1a2ftzxMWf6SaXXnJqmMyWbA5BTf
 UDqDfztXQGPucogQW702E31RIVvXqVrUx2a8RydniwlXsOftNow9sLfm98bbypZdQjSp
 JDqEPbuMw8c360LLj9uBCaOy+GrF8eZ/API47r+jHfPHnLkHfkNjkMCh1bM3AxWnJ/cy
 EZc7fnolVaGrK1kurRHsLBwcvvGu6fRrsCREOADptwO8r701fUYvQA82kDhVfEs2IBw7
 +8cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR3htFPikB3YtuXBCdQ/qfE/lVIWxRJMysZ6pZummabtynHkVeQFN5ouuoVD4yZNjIXuhDaCXd77UM@nongnu.org
X-Gm-Message-State: AOJu0YxZv/+tDmsmqk6WfhwVJZYo1bAYVP4kEV0cU8BLWjs0Pl6AO09C
 wf0m2/BhTJH2HBVJIizLLu4GwQ/Rs9PrqJbTXEfHJS9+231Yo0BoNPzGJZmzVxluGcnpymwhkkS
 Qye2gpe3mhX/g35JhP1F9kA8OEUg=
X-Gm-Gg: ASbGncs5s8BHZiqKGZsJYMyuoufOhYotLjCECmf7q6KkThFmQmXDqvyQBVprx7/2xZa
 Xr8WcqrhYg3Md3HxjaytubVRUO5Oi0s+3B1hTEmoVIkwanDe3J2hOsp8Y5hRzIlubiWvz4jiOvX
 3Y82WkMMnTEcWZQbwpnVX69Fr39CpcukCfCs08T4sStoINPo2abH9V
X-Google-Smtp-Source: AGHT+IGitC03r3Gd2YvXhr+OGBQ4yc7WKEYwvUPauUxOh5NtvtgzAbRge1ZUzwLKNwrOetHZhvK7Ecn30Z4oCttsPeY=
X-Received: by 2002:a67:fe4b:0:b0:4bd:39c7:804d with SMTP id
 ada2fe7eead31-4da918e6675mr651237137.0.1745879902039; Mon, 28 Apr 2025
 15:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-7-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-7-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:37:55 +1000
X-Gm-Features: ATxdqUERznKfsqpjSWY73rmK-cDUOf96LSBV_r-UMPehIKsWJGj6fTxSf_PEIic
Message-ID: <CAKmqyKOG0V=+1CCTtyaS32OWrn8WTtL5MY+O8qkyp0EOYoAEpw@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/riscv: Move insn_len to internals.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Sat, Apr 26, 2025 at 1:24=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 5 +++++
>  target/riscv/translate.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 213aff31d8..4570bd50be 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -201,4 +201,9 @@ static inline target_ulong adjust_addr_virt(CPURISCVS=
tate *env,
>      return adjust_addr_body(env, addr, true);
>  }
>
> +static inline int insn_len(uint16_t first_word)
> +{
> +    return (first_word & 3) =3D=3D 3 ? 4 : 2;
> +}
> +
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cef61b5b29..9836ab8c20 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1210,11 +1210,6 @@ static uint32_t opcode_at(DisasContextBase *dcbase=
, target_ulong pc)
>  /* The specification allows for longer insns, but not supported by qemu.=
 */
>  #define MAX_INSN_LEN  4
>
> -static inline int insn_len(uint16_t first_word)
> -{
> -    return (first_word & 3) =3D=3D 3 ? 4 : 2;
> -}
> -
>  const RISCVDecoder decoder_table[] =3D {
>      { always_true_p, decode_insn32 },
>      { has_xthead_p, decode_xthead},
> --
> 2.43.0
>
>

