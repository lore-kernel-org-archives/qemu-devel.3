Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA4C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnIN-0007sV-0m; Thu, 28 Mar 2024 06:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpnHn-0007jh-EU
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:47:08 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpnHk-0003qj-Tq
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:47:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56bc5a3aeb9so1010865a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711622815; x=1712227615; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtgrdYN8FimGo8IhYUXXXHISMt6fwqAisk0ui8/+sbo=;
 b=Dvu8YM9J3sh9Jmm+T4oLfnLis1tfjZdsJ2wZTjNgGurN+nz/OZD0jh+DrbKIIPII8l
 2tgauzR17U+cZUf1wWO4MtDg31NuPIsfoz9zcpaGKVSUuA9KWHAsTlVz3HxwgvKtCeVW
 SRXRRvXCFOUHUsbZcF3dEZ6hSTjlRrssvptGCFHhy1/vvCNNpla0tmEpol+t29xOmeiU
 41OVgnYTmtUz44TYX6EMTm1x4Oi13BBNS96ek+EwJy9XgfiG8DoDdLBYEC2mBEFhRM7l
 W3G935wNR5WC1hjf+L+s+nnqvGp1JtjI61N2efYUL7uciCMw+y28gBvSpUyEoGIPgGFN
 C3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711622815; x=1712227615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtgrdYN8FimGo8IhYUXXXHISMt6fwqAisk0ui8/+sbo=;
 b=MhIcFl88V7UcWw62Jsx3HQQP4lQov3gNtquF1cmlwyXr08ybMHKbthfJrh4WUuVkxC
 f5A+EEX3nJciupV65djgB+Qd8rn8p6hLuKhLWbb2b0wt2jOT0t8LA/WIGvdbD4EwCkgy
 ODSycOyYfoy3wG21lpHbvzEx16TBoHc0Q26JCJw1W3djnIOZLPBqDSXfOA8DrfeVes7m
 eHlDl7c0eu5b4pZXRQXeRJft+4WRCTQIyRczvM7MqNde5fWeuBcXLB/mds75nmd5Oh5G
 yRM2mRcAMeG+i3LpPJR9uK6XyLctvTcu/RCeXj6+6Qj2j4RdlrsAFvtHcI2DP7nNJmej
 nemg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzVZYm2VFvpRJV4lmOAC6+LR6qf8GRs5qOfA0Cg2reB1hfsRgdYkPYrUqCHpnleHyrt+8dCvKlFoZfYfOrZB2CNOpVTOs=
X-Gm-Message-State: AOJu0YxgnlGCciPM5gD/L3CKX8Ehkv8C+idG9oV/YcXKcUJoqth5+EZg
 LruQkVG2XbqpIZD2Fg19oRcl90dBHypNA+uZWm6vijhiIzSwuwyO90ZKOPKHpaewvtsc3JWdBuK
 3K4ppqlRLKX1KV1fYiz23A4zYDtbcbWKX8OR5tg==
X-Google-Smtp-Source: AGHT+IHiiAhacIByCSjKuDT1yE4lKqAQlbNAYClA6QBXpWupHWmae/yNuBgwp6fV2VFh6/KcBbzfBy7Cd9LjnXxJWDo=
X-Received: by 2002:a50:d743:0:b0:569:e401:42db with SMTP id
 i3-20020a50d743000000b00569e40142dbmr1877814edj.9.1711622815303; Thu, 28 Mar
 2024 03:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-10-ruanjinjie@huawei.com>
 <CAFEAcA8_2U6bydhixx+j84FUBY3tT5rN8Y4c6KHGjbbAX+1v3Q@mail.gmail.com>
 <1a10de26-97aa-260a-7c5b-dfb9a4949790@huawei.com>
In-Reply-To: <1a10de26-97aa-260a-7c5b-dfb9a4949790@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 10:46:44 +0000
Message-ID: <CAFEAcA9R2yBs5Qm4shBp8K+aEFC4uc6=dWKACUMLRRsibqdcbA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/23] target/arm: Handle PSTATE.ALLINT on taking
 an exception
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 28 Mar 2024 at 08:57, Jinjie Ruan via <qemu-arm@nongnu.org> wrote:
>
>
>
> On 2024/3/20 0:47, Peter Maydell wrote:
> > On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >> Set or clear PSTATE.ALLINT on taking an exception to ELx according to the
> >> SCTLR_ELx.SPINTMASK bit.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> v3:
> >> - Add Reviewed-by.
> >> ---
> >>  target/arm/helper.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/target/arm/helper.c b/target/arm/helper.c
> >> index 4bc63bf7ca..81f4a8f194 100644
> >> --- a/target/arm/helper.c
> >> +++ b/target/arm/helper.c
> >> @@ -11705,6 +11705,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
> >>          }
> >>      }
> >>
> >> +    if (cpu_isar_feature(aa64_nmi, cpu) &&
> >> +        (env->cp15.sctlr_el[new_el] & SCTLR_NMI)) {
> >
> > This shouldn't be checking the value of SCTLR_NMI here:
> > the new PSTATE.ALLINT is set to !SPINTMASK even if NMI == 0.
> > (The SPINTMASK bit description is a bit confusing, but
> > the correct behaviour is clear in the AArch64.TakeException()
> > pseudocode.)
>
> It seems unreasonable to remove the SCTLR_NMI check, because if the
> hardware supports FEAT_NMI but the kernel do not enable it, the ALLINT
> bit in pstate will also set or clear when an exception is caught, which
> seems unreasonable.

Whether we personally think it is "unreasonable" or not does not
matter here. The architecture says that we must not check SCTLR_NMI,
and therefore we must not check SCTLR_NMI, or we will be implementing
the wrong behaviour.

thanks
-- PMM

