Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E4ED6910B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeb0-0002pc-R8; Thu, 28 Nov 2024 08:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGeax-0002oq-Og
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:11 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGeav-00051X-LG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:11 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ff550d37a6so9558831fa.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800608; x=1733405408; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HdxVcGZn2g90vtNJBwAGz4nBOwK1aqnh7yPSz2Erf7g=;
 b=zV5IaynCpltkhOifp9j/QXLNO4LJ4NimHLj30mGMcaHdcD7/X24qQuzuJw6xVXPE+1
 2tR07S9q+wKLjw07BB2ACzr1wHhefxZ6S8+DjEe4CnTNRJsJicQIEg18E2LDNNPxxYUE
 dV3L6hhtBOIAYQJF9WV4eRu4ScbW1o9PhIB2UEgUBlhwidPMP/mSjylvk3vp6WH/rYmU
 h7QkyxsXM/bS93/WcjP4gkxzxYIM47kZioHgIE8LF0VxT9lWXDr8Gicd0myU8bSecOuF
 D6CO5bzopdhudTUhP4jLqWOGfwudseLyI0tMJ8jtsw72Hd6ujcCXOKGH+6z40xGWVpl6
 Qytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800608; x=1733405408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdxVcGZn2g90vtNJBwAGz4nBOwK1aqnh7yPSz2Erf7g=;
 b=iVX9iu6PwnlSna9ZqzLmBIeuFLOVLiC10k7tSl/Qc4qmiiZKJLeqav6088lPVe9zkA
 Fsm2XrgDjuWR/idm7aD87FXU+J7LIuoUakrDGPNWpSkypF33uHHxe79LBZYefqjiBt1u
 s58MQ1Ft+B5Ovbqk3DU5XXb/iNwsFf0NMFMOMEbO4OXb2G7yvwSST1at3XWjS25M3EHC
 a5T0xWQDuW9cyIe9DAgsVPPaIIXSelIWiSUBTKisdHrFygoIwGQaL3JbGnGBOP5kenT1
 zEali+O/FGINmjvYtNr+wjlqGpjBS1Q9VDBP4k2dR0W6UoZCmG95Ol6Q2TS+vihRABVq
 x3/w==
X-Gm-Message-State: AOJu0Ywh4rTDT+wvGcPzh113869vDP0ZiwFSTswB82P1pst7V1foW8qF
 wd8RUS2VjKQ5Qfvb4LwY7AEat36pgD2TS1KgsPYmC0+C0MRJQ1FjfPpzINk3hM2RRSQyAYDX5tu
 HrC6YWJMZPzr2tG/Jl85U9T5hMbt6yCfeGjP0VfXvGw5w1U7y
X-Gm-Gg: ASbGncuij1mWiCtCmFiGrHL9f5mbZl7mWqDGhDuCGsypbyweaxaEuk1jrXcxJiVAp0Y
 uKVwMkI1I5539A0+FZU1KJIUANFzmw3o+
X-Google-Smtp-Source: AGHT+IG4cRr1zZfKcD8PfjiCBXMu6wsSrIfn7dc/n6cSuQo1w2hm2/RHMRkeQueixv7ufpDrk5RTeNAhIQwYmevk4O0=
X-Received: by 2002:a2e:9a0b:0:b0:2fb:2ebf:3251 with SMTP id
 38308e7fff4ca-2ffd60dc5aemr42977221fa.23.1732800607741; Thu, 28 Nov 2024
 05:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20210502144419.1659844-1-richard.henderson@linaro.org>
 <20210502144419.1659844-16-richard.henderson@linaro.org>
In-Reply-To: <20210502144419.1659844-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 13:29:56 +0000
Message-ID: <CAFEAcA_zePe98nx31F_KmeG=S2Kj7__chb51LK_GTcWkY5u4JA@mail.gmail.com>
Subject: Re: [PULL v2 15/31] Hexagon (target/hexagon) use softfloat default
 NaN and tininess
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Sun, 2 May 2021 at 15:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Taylor Simpson <tsimpson@quicinc.com>
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <1617930474-31979-11-git-send-email-tsimpson@quicinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index c2f87addb2..9ea318f3e2 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -145,6 +145,9 @@ static FloatParts parts_default_nan(float_status *status)
>  #elif defined(TARGET_HPPA)
>      /* snan_bit_is_one, set msb-1.  */
>      frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
> +#elif defined(TARGET_HEXAGON)
> +    sign = 1;
> +    frac = ~0ULL;
>  #else
>      /* This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
>       * S390, SH4, TriCore, and Xtensa.  I cannot find documentation

This change has the effect that Hexagon is unique in that its
default_nan value doesn't correspond with its setting for
snan_bit_is_one(): the default NaN is supposed to be
a QNaN but this value is what snan_bit_is_one() thinks is an SNaN.

Is that intentional? Should we adjust snan_bit_is_one() too ?

(I noticed this because I need to make the default-nan value
be runtime-selectable, and was wondering if I could avoid
having to make targets specify snan_bit_is_one separately
from specifying their default-NaN value. But this handling
of Hexagon would prevent that.)

thanks
-- PMM

