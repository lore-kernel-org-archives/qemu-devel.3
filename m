Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA551606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XfBpWPsh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEFN-00043P-Av; Fri, 23 Oct 2026 08:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEEv-00040Z-5u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:19:17 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEEs-0002t1-SE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:19:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso6963467b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792757953; cv=none;
 d=google.com; s=arc-20260327;
 b=AMzAYYNxN3qsZdm7ssDgu5pKaF5lTQZLhZWeTsS8v9aeU1lIzFaJjjQF8dUoEkhtjU
 l7S/mz3jz0m8XVjGHVXTlrHU8jYjX/WB/ohAEiTxWfV/xoHgqEHwpTlC5D7AQ7o7nC49
 tSQgdmvW29KlBKGgTXV0Qiwo73sy4AxVkHc9kmpGfmcYHSDbxs7DoGandelewNxMSd2L
 UW/H19jDHngr8t7mmsTo3CTOQzCkUFVgMnmzJ6EJ6W020St14/eUL1uBA/+fa/GaF3bJ
 pM68uarb54ug+WZkl/5yX84is7sxevEtdXIuy20AyC51IXqnyFrcuRMLfyTeGDDeq41g
 RyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BoKFBlo2C4S0Vf7Yirj3DM5jMCxYqVeRO33J8URGw8k=;
 fh=2QBD8KTC2sfq0kvQjdRg/mj69KXY9RIcG2foctS71to=;
 b=XZyHRj6mCOHZhEZXZwAlrl2Rh3URGdLBg7MccVVb07bozrL33PCndDN3LjUbFikvDo
 yeJ82UecdVB8SB0HcXJcVKmXqnUOGGh2ieimEHhhS4sQZn2wnTdnrDrYendqyQ72tWBM
 XO4bVLShn8lEgjchketFeL+sCLbnuyC2NUskwg9FM8ZWnxJZ23fcBWwMHXPcUfxMRil6
 QofYyFAVWicCkjc9p33PQgjCVEzHTDtW+bDkjcGUgbLTvMZBBr6rtC0oZz/ZeZGKmBGi
 rYAr6uBRuGMaDP6uSvnL77HlNW9zwVfQvaKVX/LPjEh3voZvCyVirY3tGqh9hCE4RM6o
 gkMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792757953; x=1793362753; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BoKFBlo2C4S0Vf7Yirj3DM5jMCxYqVeRO33J8URGw8k=;
 b=XfBpWPshTxvVlZcX0WrPh/PMBh6jUItj3Tu/ciFEQ+9gqGVcc7hi5c4SZRsMRy7pyA
 1TV+FYOjNOHHZxoUP+9XH2kR0bs0l8Z4cELavkqaiB89DiwpviS1LUVwuVHNrBM4nzWV
 yWnSOyG4mCJBkBnGzplNdYcdbk495kdDyFeuIRb4TqROf8ncw3d4xynjiwwrVWpkpC7l
 Nz53cWAErjx6QqNqczJQL8caiAgw8gpFJ2o1DLNBPwZjRH6UnQZGDLAR5Opt0d9oce3V
 fcWrn7DljlfbexYYxf8tExeod5FiCrpTiJCSRIINojMCqFlNaq+7RpmcUZgJLkzC3QYl
 iVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792757953; x=1793362753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BoKFBlo2C4S0Vf7Yirj3DM5jMCxYqVeRO33J8URGw8k=;
 b=y8ctG0UyGFgNbR0UByoyfkeQ52IZvuypr881hyyyb9sAtZ/3QVzQIwrYfYEJwM8Vii
 DwOOF/lCDjKyo1K0NshxHE8RGDec0dIAOH28z8SFVw+pS3gaKv806mmQUpWcHuHmmcOk
 eSHbG0U/UltymveU0w0C0IZOaGhp9fXDCGv5gEm2miFKgiMGPz8NkAk6jRUfPvDnZVev
 JFpZusFD87N2YHfHKKwbcAeQgUcjyeHktCa+wuRy3Dg0mVQ0jisj/JWU5x1izFBHF1X+
 4bOmdP5VTIdQTuyCHIulA7ISDiu/pTSWK3WDhTNRzWqIFZWfXUVvftXz70TfClRG+dAt
 5+2g==
X-Gm-Message-State: AFq9FYKzLIlZFNbjV47V4t5SK/z9HE2ZxUjq/wAK5Y4ZVkwBpHvhvQQm
 ybfFFk81KQ4cxVxfZtfuoTSK8SRgyXMbCTfI/OTctK2WkHqmMdv07VoKoKlQ2UHSfdit6IUegqO
 X35dv0TI7gqMRwp8ZxVEoIBrJ2N/43xheA0O1glaOXA==
X-Gm-Gg: AYBFou0X5VX2qX7eAYnEjpwHF3ffK5gYvDc51/0KZrH70E4YmlID4KSThOFQZig/yQp
 Hc2y49aP9TZUxR0hGsZjhYmyiXFOmzcJoDtHGCdHGqyA57fHcUimO+XBZd9q6ibUNWpwH86wXLL
 Dc9+1t1GtzJfIskdU84dPccK9JXCU6KSDEay8nxAHDNuEIV6bEDLpAJOZ85ifHWeHvduyi/Hs2m
 qT1dFHDfgcKplXmfP9qPVhuO5s/CFxpHcd/XTTZIKXTLZGawHuSE5Z/9lAxoIV94W2YVutSviC6
 2RmULXwuork3yJy0+q53yceHewY9+RKoX1g8mKp9VevHZVm7N0sbNl6oVa0du/kxcQMs9lnNywu
 nj1Bgg51TSukjFUG8jnml7O9u711DMspsN6qPjo8RScPJfJc8I8s/yq1dnBuyNqhjTLdso8yYpX
 YVq00jpRW9ntxjKOZpQ6P9
X-Received: by 2002:a05:690c:c355:b0:8a8:8456:a970 with SMTP id
 00721157ae682-8b157e1b5e9mr12603817b3.68.1792757953091; Fri, 23 Oct 2026
 05:19:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-3-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-3-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:19:01 +0100
X-Gm-Features: AclHuK8_nx5Lx7TCgjDtTcbwWFcW7Z5f_rLbaTJwa4mNQ6Wdh9GP_xQfG_kj49g
Message-ID: <CAFEAcA8GicYKBQDACcGzR+baM8Zi49uN+dfhu-GDH9Pgiq8J3g@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: sync vCPU state after PSCI CPU_ON reset
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> From: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
>
> arm_set_cpu_on_async_work() resets the target CPU and sets its entry
> point and context ID in CPUARMState, but never tells the accelerator
> that the register state changed. TCG reads CPUARMState directly, and
> KVM re-pushes state on reset, but HVF only writes CPUARMState back to
> the hardware vCPU when cpu->vcpu_dirty is set.

My first reaction to "this works on KVM but HVF does something
differently and it doesn't work" is "so why are we doing things
differently?".

> A vCPU that reached PSCI_OFF is left clean: its last hv_vcpu_run() exit
> was a WFI or a cancel, and flush_cpu_state() cleared the flag. A later
> CPU_ON then resets and re-points only the QEMU-side copy. The vCPU
> resumes in its old context, with the old MMU state and vector table, and
> never runs the requested entry point.
>
> This shows up when a guest that already onlined and offlined its
> secondary CPUs boots another kernel, for example kexec on Apple Silicon:
> the new kernel logs "CPUn: failed to come online" for every secondary.
> Fresh vCPUs are created dirty and single-CPU guests never issue CPU_ON,
> so the ordinary boot path is unaffected.
>
> Call cpu_synchronize_post_reset() after resetting the target, in both
> arm_set_cpu_on_async_work() and arm_set_cpu_on_and_reset_async_work().
> It is a no-op for TCG.
>
> Signed-off-by: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
> ---
>  target/arm/arm-powerctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index ef14a1f8a9..e197a0ebda 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -16,6 +16,7 @@
>  #include "qemu/log.h"
>  #include "qemu/main-loop.h"
>  #include "system/tcg.h"
> +#include "system/hw_accel.h"
>  #include "target/arm/multiprocessing.h"
>  #include "trace.h"
>
> @@ -80,6 +81,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>
>      /* Start the new CPU at the requested address */
>      cpu_set_pc(target_cpu_state, info->entry);
> +    cpu_synchronize_post_reset(target_cpu_state);

This isn't a CPU reset, so do we really need
cpu_synchronize_post_reset ?

>      g_free(info);
>
> @@ -189,6 +191,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
>
>      /* Initialize the cpu we are turning on */
>      cpu_reset(target_cpu_state);
> +    cpu_synchronize_post_reset(target_cpu_state);

I'm not sure whether cpu_synchronize_post_reset() is supposed to be
"after we just did a full system reset" (the way i386 uses it) or
also "after we did a single cpu reset" (the way s390 uses it).

>      target_cpu_state->halted = 0;
>
>      /* Finally set the power status */

-- PMM

