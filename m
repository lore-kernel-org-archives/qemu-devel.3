Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3D6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzqk-0008Kj-CL; Tue, 25 Feb 2025 13:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmzqh-0008JC-Ev
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:40:07 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmzqf-0007mU-7o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:40:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so4964230f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740508803; x=1741113603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SK+pZ6MprBxs9+fbAymxbUvDpeR0HW77rc1PIpkryUo=;
 b=wFJIZkw1Xi1rOQHxWZeVnb/RGAWJUPyW3AhvyBECXZuuZ+mdc3C7gN7IiEWm+Bdts4
 tY1426mcYMCyw8orFhovFVk6u0oiT5nPGoZBprD7eaq46FUySWD8QHVkfhsplUZ054nz
 4BPLjhgmPHkf4rTHnlQGI2yw0d8INJHvf3EPTbjiCJyFaufx4XWFqKpCC9nsjz99aeg8
 69Kyegp+sMlNpMkl9195lRXSUEqN3Slsm3TPXwgB8i6k3AZ3zwsvGkxyxvPqMOOJnCi6
 iGgUN0UjO3zD0L26+DoLFZhmU2AwYQ0RDCZuxjlfG8BO+tp/4j3kh/EWJ1KtZd10FiH/
 Spuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740508803; x=1741113603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SK+pZ6MprBxs9+fbAymxbUvDpeR0HW77rc1PIpkryUo=;
 b=ihnXRimd/7JDlKd/iWEHzzt48QAb6N//LsKev1EbfSWcxuzbRx7ufJp9FTd/PYEgq5
 IPzBjg7yfeJJ1R51nGkOueuTQfTks5bxdLJePEQkW9lklh+4dRY3lWFVRHG0Vdruo/3P
 2lwWakNONUle0reOJSbIWeM/EdbnUoJ26wgbRZFXx4KzqvMqZjRxtxpQwCUK36d8SdJQ
 WrZb7LrcvesBIK08bTkpKwmY77oezalgDyTrEUI+zFxNATuV4NbliGigc0BNYwZ75qjk
 +RGR7gHpJDPEmrqU+MQdInvHVSxFgQp/NnqAcJSFRzYaaT9lSz8/g062aAX47/e+0C1B
 q7ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmEbeMWpN45UGwyB1lemjuMWBL9zB4nb4habkuaX/EFydoK11ODz3Wy9myq+dRW5M/si3VPako85O@nongnu.org
X-Gm-Message-State: AOJu0Yz/Ggt3w3yz5KJxTEhAVzSOaLYTOYHJdl36V1y7z0ZAcWw2a5To
 c0SeGn/Z4y18IxpNPPCIF0LC8Ca/MCG5PlxDwtvHmuAej2EAlMelkIrTX5cn/pM=
X-Gm-Gg: ASbGncti4POzbQfMt7LxZI26M1ZWd/W5A/Nqb6Pehj29dhvtPwKqQ9u8shO+dGWuYXN
 pMobnGCaeVE97FChp9Ha9Kc3h05FQBQWVtPjYaMPMdbQ+7xygfSDRwWM8vM5RAe7o795nFgB25e
 UYiIyZ/gXCpcFCJi2kVq59yfiF2RgEPOOsxibpyHpVKpQE33xpUWGymIvcKy3vCPPZ2FXSQvpTw
 HzvAH7BeHtNw8P/jIcnVFe8mSlil9XD7rFonesq9ZrHL2lTMaFOvO0KPi1+Kq5YccV1z0ANihUx
 Hw9jY2ROJOsXQAfD5PfY2RYfPz+KBg9FGhHs+FzaXVDfWBGQXcb/pq3rA+oXDFD6Ofmiig==
X-Google-Smtp-Source: AGHT+IFWivxc2poYdICPxSKl3qXJBSjJKvRiW75Gr9CEqGXB9ftx/Ubg0onAvgkc4cq7SEIZu920qw==
X-Received: by 2002:adf:ffd1:0:b0:38f:394f:d8c with SMTP id
 ffacd0b85a97d-390d4f4d319mr260261f8f.33.1740508802938; 
 Tue, 25 Feb 2025 10:40:02 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab14caa5esm38358195e9.0.2025.02.25.10.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:40:01 -0800 (PST)
Message-ID: <e344bd3a-fd3a-4314-9fe7-97ac0b252a89@linaro.org>
Date: Tue, 25 Feb 2025 19:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 006/162] tcg: Convert and to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  4 +++
>   tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++--------
>   tcg/arm/tcg-target.c.inc         | 41 +++++++++++++++++-------
>   tcg/i386/tcg-target.c.inc        | 27 ++++++++++++----
>   tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++-------
>   tcg/mips/tcg-target.c.inc        | 55 +++++++++++++++++++-------------
>   tcg/ppc/tcg-target.c.inc         | 40 ++++++++++++-----------
>   tcg/riscv/tcg-target.c.inc       | 29 ++++++++++-------
>   tcg/s390x/tcg-target.c.inc       | 48 +++++++++++++++-------------
>   tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++---
>   tcg/tci/tcg-target.c.inc         | 14 ++++++--
>   11 files changed, 216 insertions(+), 125 deletions(-)


> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 1115d1e38d..01010dfdc0 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc


> +static void tgen_andi(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_AND + rexw, a0, a2, 0);

We could s/0/false/ in preparation of tgen_arithi() taking a boolean
for the CF bit.

> +}
> +
> +static const TCGOutOpBinary outop_and = {
> +    .base.static_constraint = C_O1_I2(r, 0, reZ),
> +    .out_rrr = tgen_and,
> +    .out_rri = tgen_andi,
> +};


> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index f5441d2033..d60bdaba25 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2196,6 +2196,31 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_and(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
> +    } else if (a0 == a1) {
> +        tcg_out_insn(s, RR, NR, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
> +    }
> +}
> +
> +static void tgen_andi_3(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_mov(s, type, a0, a1);
> +    tgen_andi(s, type, a0, a2);
> +}
> +
> +static const TCGOutOpBinary outop_and = {
> +    .base.static_constraint = C_O1_I2(r, r, rNKR),

So INDEX_op_and_i32 gets more constraints (ri -> rNKR):

CONST('K', TCG_CT_CONST_P32)
CONST('N', TCG_CT_CONST_INV)
CONST('R', TCG_CT_CONST_INVRISBG)

IIUC this doesn't affect anything, as these constraints are only
useful for 64-bit ops, right?

> +    .out_rrr = tgen_and,
> +    .out_rri = tgen_andi_3,
> +};


> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index f43d95b025..b3fbe127c0 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc


> +static const TCGOutOpBinary outop_and = {
> +    .base.static_constraint = C_O1_I2(r, r, rJ),

Again, missing 'z', so C_O1_I2(r, rz, rJ)?

> +    .out_rrr = tgen_and,
> +    .out_rri = tgen_andi,
> +};

