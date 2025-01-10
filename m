Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72EDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEa7-0002xH-Ji; Fri, 10 Jan 2025 07:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEa4-0002oi-EL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:57:40 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEa2-0001Sc-8O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:57:40 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so5280236276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736513857; x=1737118657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWpgClhMu8y0WMFqZn0FgquieZBpCTzT/UOP0udnz8w=;
 b=mpBr56o6jVf3IEjY1fMsJAr+cxojhBrxVNMPheF/eVSRsVoKgEncOVTj6HencdiBzI
 rEkbCyASutr3h/fvbgOBRraUOsBTeEVEdB2FpXB2KbjhBRFXg93vsV/6joXZqLn27aL0
 JLHSGEoUimarfrL3nt+vP+A8DPWHpPdsllyW5VCijVZc17IPFksVIjP7PmjcDQdjqaF8
 9llagCKDJib/FPkCeTJVHoL53sf2lB+c+LCbuJxUDgPod+smKUmHBiZifA1PnmxT7nln
 OtftZ50+8tfA+DBDll8tORNXdeVrB0e0/Pvettfp6EdETGCpnimvXFGCIUkwhiEf6E6D
 zXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513857; x=1737118657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWpgClhMu8y0WMFqZn0FgquieZBpCTzT/UOP0udnz8w=;
 b=UNs0eMDHCJOiLgrdolvEfbhpva5gawt/yWF1X6PeupmGlUko1/JVEHBL3YbuvmGA3E
 ndGlVxEk6tR46PePW7msQUNE5Y+D1qoDHDPKRFnbbyP4JHDrV6MNLk43n88RJZOME6mD
 ZEfdIDuWBHdF7hs16vsGdcYQ06/AunIZ4tLZnfp/HzpZlkYc5AodLkUIdcw2TMbRnjZI
 c8HFRFe7Ke47SMx3HANJOaAVRxibxUMtV/ZIwXxuZ/WtlBMKXCxcPXeLsrzfNyFkcl4a
 FQdVoorEA9R3Ag6UvdcHxJTe6q2NHcPdBZfFa4HBwIrtTlYpy6UqmXXdMXDOwdH7UCEj
 me5Q==
X-Gm-Message-State: AOJu0Yzn7CZ9XUNRZZ/iPge10TzUuMl7yvb8Li4Bsvgp05UUUYVVykjk
 VvC+pVgl3OIiuyxqPi+VChOdAGbJmKgOCtF+CI4XbCTSvRFAnkqBG+sBTE3B7aVz3752C/ufyLQ
 EHaiVZt2whfrr12Jnrx81/cCBXVoY8IQ0RP0C9Q==
X-Gm-Gg: ASbGncuDtJoaylAPbgwEA5G+h0cqItEGnqCelGZiZ/cjHQyyhyVeNinXcFmCaLm1IZ+
 oSEeB87SmtsM8QOrStIXIOi19HVPkxIn383lRllU=
X-Google-Smtp-Source: AGHT+IHcE065TBe/uA2Y7mFRis8OKe5LTm7adGkxAIeoPcxcnaO3bt70DOFe+BMWMUwwXeuuVg1gBKW7H85VXBKRdiw=
X-Received: by 2002:a05:690c:4a0e:b0:6f0:5fc:7d with SMTP id
 00721157ae682-6f543e9b1e6mr51579967b3.11.1736513856798; Fri, 10 Jan 2025
 04:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-4-alex.bennee@linaro.org>
In-Reply-To: <20241218181511.3575613-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:57:25 +0000
X-Gm-Features: AbW1kvaOOj0yN8OXi4jL1b-c8NvPOfIJXFRhrNoYialIjYiHtbpwXnh9vGjlY1M
Message-ID: <CAFEAcA8r9OS9SO_26GmagYD1E-0e1OSmU8GiGXtogpOJ5c7vYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/arm: implement SEL2 physical and virtual
 timers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 qemu-stable@nongnu.org, Andrei Homescu <ahomescu@google.com>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>, 
 =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Wed, 18 Dec 2024 at 18:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
> shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
> actual implementation utilises the same logic as the rest of the
> timers so all we need to do is:
>
>   - define the timers and their access functions
>   - conditionally add the correct system registers
>   - create a new accessfn as the rules are subtly different to the
>     existing secure timer
>
> Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> Cc: Andrei Homescu <ahomescu@google.com>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
> Cc: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
>
> ---
> v1
>   - add better comments to GTIMER descriptions
>   - also define new timers for sbsa-ref
>   - don't conditionally gate qemu_timer creation on the feature
>   - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/g_tval_[read|w=
rite]
> v2
>   - rename IRQ to ARCH_TIMER_S_EL2_VIRT_IRQ
>   - split machine enablement into separate patches
>   - return CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases
> ---

> +static CPAccessResult gt_sel2timer_access(CPUARMState *env,
> +                                          const ARMCPRegInfo *ri,
> +                                          bool isread)
> +{
> +    /*
> +     * The AArch64 register view of the secure EL2 timers are mostly
> +     * accessible from EL3 and EL2 although can also be trapped to EL2
> +     * from EL1 depending on nested virt config.
> +     */
> +    switch (arm_current_el(env)) {
> +    case 0:
> +        return CP_ACCESS_TRAP;
> +    case 1:
> +        if (!arm_is_secure(env)) {
> +            return CP_ACCESS_TRAP_UNCATEGORIZED;
> +        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        return CP_ACCESS_TRAP;
> +    case 2:
> +        if (!arm_is_secure(env)) {
> +            return CP_ACCESS_TRAP_UNCATEGORIZED;
> +        }
> +        return CP_ACCESS_OK;
> +    case 3:
> +        if (env->cp15.scr_el3 & SCR_EEL2) {
> +            return CP_ACCESS_OK;
> +        } else {
> +            return CP_ACCESS_TRAP_UNCATEGORIZED;
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

This code is still using CP_ACCESS_TRAP in some codepaths, which
isn't correct. Either:
 * you want an UNDEF: that's CP_ACCESS_TRAP_UNCATEGORIZED
 * you want to trap to some specific EL: that's CP_ACCESS_TRAP_EL2
   or CP_ACCESS_TRAP_EL3 depending on where you need to trap to.

thanks
-- PMM

