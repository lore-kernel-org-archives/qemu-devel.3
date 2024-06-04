Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5F2C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKg6-0001Mb-BN; Mon, 03 Jun 2024 23:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKg4-0001MJ-KV; Mon, 03 Jun 2024 23:17:36 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKg3-0008Gb-3I; Mon, 03 Jun 2024 23:17:36 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4eb053d4ce6so206538e0c.1; 
 Mon, 03 Jun 2024 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471053; x=1718075853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0x7nOL0GovRk1tyMv2jsnowpeZA9KSZF/3l2I81By0=;
 b=lCbnUath+6K6fiTQ/8Rw0obHnjUxNGH6W2YP4+r1TIKADPYi4Rb0WX2qHDLV2h813s
 1fQcRbyz28Obv55b9mWexWTNFFMmvWOL0jH/Jyi2IC6o4o9QXPHnag8bljmtlky0OoOj
 JBdClbQOmA9EbGxlJF7ua2zhQnxfnA0+oke0Td/I06NrwQ8tNPTgAxMPZv7v00gJgrF5
 c0bzLsK0x0aQvkx9bIjIBr36EnXd6usoHpGDmmnIK9q/LpY5mtB9GH5QTFEB9BkDTQtt
 rSNQxi03cERo7P54O6RwRCXybYiq8RTqGRATDPxLDaal31lUJvQd1ujahon0jMzegRjZ
 WL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471053; x=1718075853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0x7nOL0GovRk1tyMv2jsnowpeZA9KSZF/3l2I81By0=;
 b=IeZK32UirIjPJu51O4y5K6tpCDMP8lMX9aXcO2C8ZHgSWdt5vShK7dvz/ZHaTc4exi
 xcPgH/xn3yJKt4plO5b060EjH8Ro7p18HMQ0sr/vUGfQfTtBJSdQ1kH5J6qteCUErW0e
 d7Rgi+Rk63OuDXQi+4aSNGA1PQFWpeLjXmFVS4g7ip5FBNQhPmnHv3ZcTPhJWabJb3+A
 kHB2zgJjo6RNX0FH1LsSVb7YPRcE7gWiElTPaC6wuG6LPTT+iBTPAEG41epcf07qM87f
 Ay0t/IdDo+/GZMGsUh2k3mdfeMooIC6jHFalqRDMnevFLy+gRhS0Nw2yyHqHF6ntFQLe
 HTSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+KO4nYB1eKV3PdcVqtARBnmW8aQDP5vSLHYbyP/OOh04uWZwKrZSqr7bPmA20B2yXZhvWptq3RfOC2xzPgVN6jCT2D0=
X-Gm-Message-State: AOJu0YwbOO/bNRDJX7HR9yTE9ii2GruUbohQwR3Pila1C4U04EzMDe4P
 qzq0YR2/a9xgaZtdfN8MkQ4B4m0p6S/pEG1mPWOLql3Y+O6exxj8n4Jc+4qi4b2d2spBY8PZwb1
 1TEQHs7yq76SZICuzhKONQqtFuJTDKM9j
X-Google-Smtp-Source: AGHT+IFF0L0qJGeZPeBwebQMokGD//P8XaiEZ9/RiGhNVHaQaO45IypPnAyEmy3KJLZJLgZ2TRk+4dZ/tRH1yyNWZiU=
X-Received: by 2002:a1f:f2c4:0:b0:4da:aff6:5eee with SMTP id
 71dfb90a1353d-4eb02eb8814mr7949754e0c.15.1717471053553; Mon, 03 Jun 2024
 20:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <20240523124045.1964-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240523124045.1964-5-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:17:07 +1000
Message-ID: <CAKmqyKMk_c=oWJyEt4oK607pz44K0sZvJo3UTPc==DVDZnBdBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/riscv: Add amocas.[b|h] for Zabha
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Thu, May 23, 2024 at 10:44=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn32.decode                  |  2 ++
>  target/riscv/insn_trans/trans_rvzabha.c.inc | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 8a4801d442..eee48f92d3 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1041,3 +1041,5 @@ amomin_h   10000 . . ..... ..... 001 ..... 0101111 =
@atom_st
>  amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
>  amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
>  amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
> +amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/i=
nsn_trans/trans_rvzabha.c.inc
> index 9093a1cfc1..ce8edcba62 100644
> --- a/target/riscv/insn_trans/trans_rvzabha.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
> @@ -129,3 +129,17 @@ static bool trans_amomaxu_h(DisasContext *ctx, arg_a=
momaxu_h *a)
>      REQUIRE_ZABHA(ctx);
>      return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
>  }
> +
> +static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
> +{
> +    REQUIRE_ZACAS(ctx);
> +    REQUIRE_ZABHA(ctx);
> +    return gen_cmpxchg(ctx, a, MO_SB);
> +}
> +
> +static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
> +{
> +    REQUIRE_ZACAS(ctx);
> +    REQUIRE_ZABHA(ctx);
> +    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESW);
> +}
> --
> 2.25.1
>
>

