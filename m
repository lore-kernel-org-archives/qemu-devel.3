Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2E8D41D53
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 05:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAjSq-0004s2-JL; Tue, 12 Nov 2024 00:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tAjSn-0004lN-Fp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:29:17 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1tAjSl-0004KV-J7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:29:17 -0500
Received: from [192.168.0.19] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id 4FDE0518E77E;
 Tue, 12 Nov 2024 05:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4FDE0518E77E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1731389350;
 bh=o0oE40ctW0bLml6lKjuc08ScniaQRIQjsvsoJpDA8ak=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LQT72GwkYZB1/dHQwVYtBqGlEpJoifR0G6gW7mn7dPC4GCTC/8J27O33pUkhjU6Kq
 Gjj/f8n3KVt8QN7NNJDHRYzV8IXM6Fd0GOMV9B3mJtHOEfj5OZsek3I8JTIMq7O2jO
 fkUs0cbfbeKQp+dG2fBK64CitJUvs1/jj6q3tpQI=
Message-ID: <409b59c3-7c41-49f2-b9eb-af59df21d574@ispras.ru>
Date: Tue, 12 Nov 2024 08:29:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/mips: Convert Octeon LX instructions to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241111222936.59869-1-philmd@linaro.org>
 <20241111222936.59869-4-philmd@linaro.org>
Content-Language: en-US
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20241111222936.59869-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 12.11.2024 01:29, Philippe Mathieu-Daudé wrote:
> Use Octeon decodetree to call gen_lx() for the LX instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  8 ++++++++
>   target/mips/tcg/octeon_translate.c | 12 ++++++++++++
>   target/mips/tcg/translate.c        |  4 +---
>   3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 0c787cb498..102a05860d 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -1,6 +1,7 @@
>   # Octeon Architecture Module instruction set
>   #
>   # Copyright (C) 2022 Pavel Dovgalyuk
> +# Copyright (C) 2024 Philippe Mathieu-Daudé
>   #
>   # SPDX-License-Identifier: LGPL-2.1-or-later
>   #
> @@ -39,3 +40,10 @@ CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
>   POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
>   SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
>   SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
> +
> +&lx          base index rd
> +@lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> +LWX          011111 ..... ..... ..... 00000 001010 @lx
> +LHX          011111 ..... ..... ..... 00100 001010 @lx
> +LBUX         011111 ..... ..... ..... 00110 001010 @lx
> +LDX          011111 ..... ..... ..... 01000 001010 @lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index e25c4cbaa0..0e0b00303a 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -174,3 +174,15 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
>       }
>       return true;
>   }
> +
> +static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
> +{
> +    gen_lx(ctx, a->rd, a->base, a->index, mop);
> +
> +    return true;
> +}
> +
> +TRANS(LBUX, trans_lx, MO_UB);
> +TRANS(LHX,  trans_lx, MO_SW);
> +TRANS(LWX,  trans_lx, MO_SL);
> +TRANS(LDX,  trans_lx, MO_UQ);
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index acadd3d891..6fd5462a24 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -13583,9 +13583,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
>           }
>           break;
>       case OPC_LX_DSP:
> -        if (!(ctx->insn_flags & INSN_OCTEON)) {
> -            check_dsp(ctx);
> -        }
> +        check_dsp(ctx);
>           op2 = MASK_LX(ctx->opcode);
>           switch (op2) {
>   #if defined(TARGET_MIPS64)


