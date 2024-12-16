Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CAFE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFcg-0004Sx-TG; Mon, 16 Dec 2024 13:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNFcd-0004S5-Sq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:15:12 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNFca-0001U6-RQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:15:11 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef7c9e9592so38301357b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372907; x=1734977707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9O1TKsg2TNHr4BpDtt2C4w1mwrPUnbzM/X5S3xllnMI=;
 b=suFqHcj26f+JH+Gryh17GQEBEdvXmuQjLca8702d/f7JLgHGsNQaSCtdcp0eWU7S/h
 YItumTqwyuGJ2m6t/AmLd1XHX7rIBUCTYEudEWzi19O9L1yJeDFWIOh54eYxp3lJVhMR
 wiLKTnm4D78WHj0q/hgTJ2ruHVUMGP8JsRXgtOEqFF2U9aZI+0RGo9yAVhZOyps15fSj
 J7eDxUfwh1FRUhae2JxYyJvHAFE7iuN2WexVpJLijKznfvk37Xl28OPcwga7mSYzwix7
 G1lqAGhdSV+nTccun0NVXsJ++AFm158zxqdZS2s7V9U/Z6vHyRgo+fWZl7eb710DGe+w
 SJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372907; x=1734977707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9O1TKsg2TNHr4BpDtt2C4w1mwrPUnbzM/X5S3xllnMI=;
 b=YZywi5fCDHOQzTKKimI/xobSwCEcOUSvTV7VolCs9eQe1WUzo0+sYbCVjnkL6NLBxX
 nQLUAjdVEzLQkyvm/GX2G8RWIBBUs+iswYSshzXgddDx7rmEhuh86HFnBzzm87JCQNha
 bnGepqfA/5QhE113a/PrLorSirNueGrBRaKop5mV2k0Prci5TXCijFZGq3sPaV/LJy2R
 AbVCZsVdRDudGxPDOIMjBsWh0sgYuNvH1ifqWzGM/LKQs62iSYgjhp/0JE6gFi/8+8Sq
 0/R1WExjz1U+WvpEqZV+9I9bn0mCNkHfOTr2YWmEyveBkLjH2sPt9ZzYTGNse5Z/OzFl
 2Xqw==
X-Gm-Message-State: AOJu0YxQYHYK1bHdvOr2HWjcOVetSelyMmmVPQ5yrI4821Q+X4vy/s+K
 NfP2qnV8OEaBvruxk0IyXOB6R3M2dyC9kkbD+Se3mCkZwrBNxR7qpJEigsxJFHzRau3XXs5/sM5
 9Lyr674j8a2FhUALXJPfq5YnO+04NXHDxiLPrQw==
X-Gm-Gg: ASbGncsU6UBVrJJmCTT8pORq1RyUvSkMIusg4FTUspEKsD2vNYwB+D9DBMWwCIuVQDb
 GWOpscouR1WV9Om/nSycu96RBeZ0u1koE3k251u8=
X-Google-Smtp-Source: AGHT+IHyXK09daxX4pz/42t243P7Dp4eqSZpvj2mEl9smiSAx9tvRckEJrODyV1nya0vZI0rTG02tXdNPs6lSY6O0KA=
X-Received: by 2002:a05:690c:397:b0:6ef:a187:f377 with SMTP id
 00721157ae682-6f279b8da60mr100466677b3.34.1734372907304; Mon, 16 Dec 2024
 10:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-4-alex.bennee@linaro.org>
In-Reply-To: <20241206160239.3229094-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 18:14:55 +0000
Message-ID: <CAFEAcA8mi=gTBvh9FqyMFeyqAHqirkah84sW4m8axKPqwMZDkQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: implement SEL2 physical and virtual timers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-stable@nongnu.org, 
 Andrei Homescu <ahomescu@google.com>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>, 
 =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 6 Dec 2024 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
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
> ---
>  include/hw/arm/bsa.h |   2 +
>  target/arm/cpu.h     |   2 +
>  target/arm/gtimer.h  |   4 +-
>  hw/arm/sbsa-ref.c    |   2 +
>  hw/arm/virt.c        |   2 +

I would put the board changes in their own patch(es).


> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index cd147b717a..f82503304e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2668,6 +2668,41 @@ static CPAccessResult gt_stimer_access(CPUARMState=
 *env,
>      }
>  }
>
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
> +            return CP_ACCESS_TRAP;
> +        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        return CP_ACCESS_TRAP;
> +    case 2:
> +        if (!arm_is_secure(env)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +        return CP_ACCESS_OK;
> +    case 3:
> +        if (env->cp15.scr_el3 & SCR_EEL2) {
> +            return CP_ACCESS_OK;
> +        } else {
> +            return CP_ACCESS_TRAP;
> +        }

These should generally be using CP_ACCESS_TRAP_UNCATEGORIZED,
not CP_ACCESS_TRAP. The pseudocode uses "UNDEF", which means
it wants ESR to be reported as an uncategorized-exception
(classic UNDEF), not as a "trapped system register access".

Almost always a trapped-sysreg-access is directed to a
specific EL; an UNDEF is never directed to a specific EL
but always to the usual destination for exceptions.
I should probably check whether the other uses of
CP_ACCESS_TRAP are correct or just bugs we haven't noticed
yet...

> +    default:
> +        g_assert_not_reached();
> +    }
> +}

thanks
-- PMM

