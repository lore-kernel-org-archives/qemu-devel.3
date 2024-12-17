Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C20E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXjH-0005xG-Bw; Tue, 17 Dec 2024 08:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNXj6-0005qw-SF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:35:04 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNXj4-0004Jd-Vg
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:35:04 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef60e500d7so37443417b3.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734442501; x=1735047301; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoOj9OMhVreh957qfVVVxCYR32RQIhKvGlDk3hpkOtc=;
 b=jVjiIk3J196IlKEXi85rFRiltTxmymcx0pKkIkMtmzStDz+PoPjrk9OESORbKL/2ZB
 r9xnoMX00Na34aI+prCQUSpKdnItiEdFZuQg1lFLqFRKEsgjivivAo8rEGSFzvZ4856U
 oyKf7Lgjwwe9dECfJNBSC1qbGYH7S0OAmqti25L1o8OR8NPOA78T/6uU1H5+zHYonV8n
 7YcM7zpQIpJrTARNfQrc5QlrHm62B5H2Q4bupg8yS1uVX0ADdW/vWTBUQ70hR+/42cIZ
 NQS6+odaQPPTnd+06mP3pBUQphSsifYBLshDsbV2jGNPWmCoSELKtKeXcNDdcNJrRdtN
 56HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734442501; x=1735047301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoOj9OMhVreh957qfVVVxCYR32RQIhKvGlDk3hpkOtc=;
 b=AeV150WBKQ3bICySaK6rGXnxtYOeDR0HBlrtVCyed0L9LjYoCUQi73NhlOW3FQYqSb
 EYpX+vjcdBdHiMCKJPdIwKyuyWX75aO5X9Ss+DdfQEzE+JJ26mIiOrD04N3MgtFvboLr
 HpM7+qMPCx68yrQvPbYjnNP8ZX66UhQP83B134TtONQjKq4Xm6tvJF1i+5ZHmGPg199w
 Shi5klIe1joaASwocEx9zeUmx60mCPa1312h93Z8NueD0N0vHtsDMJFvyndxwV0O5cj0
 kMGl8tVZbviohNXLe8rRuCf4AZN8bx7IdowT8KPuMpp64Vw9EC1LWp0YYvqsy7Yd7Q3t
 xhzA==
X-Gm-Message-State: AOJu0Yw4RNtw5pCZb595QJempqHCGZs1aJ5l1nZnD+Bzx+MrxRzdBQk2
 HrpH/rDlUdWvYik/oFgVprBIUKt7V5P01OLnQFpCPyeXYIpeOOaDf4RcOloKvPE90Pzlmanbr7A
 6ftvRscRtlf4Aj6Bb7yoMhwjruEXfmkOYwM5fcQ==
X-Gm-Gg: ASbGncvBFrl7hGovCorQMR/2HAc3gj1B5K8II8XYTob5BLYMtUz40riZ1RV7eYVApog
 Fd5iCfsUTG2zPEyUSmr+cFll9V2Jrj6prHJL6vaM=
X-Google-Smtp-Source: AGHT+IHF/uU2nxHNccfbJ0gCojA/PuCP89exwJRGMM4RC+XG8cLu91ow9w50SI5xIveSRU0wkQ1srxA9lVrqbBn8vzs=
X-Received: by 2002:a05:690c:6ac2:b0:6ef:63cb:61d0 with SMTP id
 00721157ae682-6f279af6ca2mr135353347b3.10.1734442501308; Tue, 17 Dec 2024
 05:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-4-alex.bennee@linaro.org>
In-Reply-To: <20241206160239.3229094-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 13:34:49 +0000
Message-ID: <CAFEAcA_AgkVcVm5nfCNb=PjB5qnYahTUuQxi-U=um92BFokccw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

> diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
> index 8eaab603c0..b4ecca1b1c 100644
> --- a/include/hw/arm/bsa.h
> +++ b/include/hw/arm/bsa.h
> @@ -22,6 +22,8 @@
>  #define QEMU_ARM_BSA_H
>
>  /* These are architectural INTID values */
> +#define ARCH_TIMER_S_VIRT_EL2_IRQ  19

Can we call this ARM_TIMER_S_EL2_VIRT_IRQ please?
We currently have ARCH_TIMER_NS_EL2_VIRT_IRQ
so we should be consistent about where in
the name we put the "VIRT" bit.

> +#define ARCH_TIMER_S_EL2_IRQ       20
>  #define VIRTUAL_PMU_IRQ            23
>  #define ARCH_GIC_MAINT_IRQ         25
>  #define ARCH_TIMER_NS_EL2_IRQ      26

-- PMM

