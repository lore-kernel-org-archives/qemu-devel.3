Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF2FC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 15:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKfKB-00028u-4R; Thu, 29 May 2025 11:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKfKA-00028e-5d
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:37:42 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKfK8-0007KO-FO
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:37:41 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70b4e497d96so11036217b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748533059; x=1749137859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CE6kGDjxFKKcDmM4b6gj6+heUchY/sQzHh7mQXpY2lI=;
 b=FDpE5w7BAqy2HsU8SObPewqRMooY8IO3zhJJwifaAT4qQpiv22nDOKOLw6RexteByH
 vr44bKm033/mhGtiRp534RC4qd2R+zlW/xuNvhR7756VORXsvFn7wG956pkH0iLhg5rv
 Ahn7uAP2Oi2aJNRaFk8imms2SlLicK1i84rgBHTRTsK1C2CWlI+VzX56RnnaZwXOZMh9
 1GvNTe8CjUm1EqdjuF6kPz5OQzgKPPUEnC/gr7Mm6/EEffldYnh1Kt183tMstnbl1SFt
 yX6MFIPyXpGFM36NCHo41R+mp47EQEQv8XhhJOckzjC0Rp0VSrkKCc78KXu6JG12O8Qy
 d/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533059; x=1749137859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CE6kGDjxFKKcDmM4b6gj6+heUchY/sQzHh7mQXpY2lI=;
 b=hCM5QvzcADf4jzH/8Bqa579h5EYT/6auVZjvs9YYD82cYfsV/Sd8gyv0e+sysVE+Mh
 NNnqU+ERjibzeojUn6ur/oW1otSGg/7xvkeOMbCg0+fJMB2+a6jvZhstIhInjMTmmSv+
 Oy8Zx3clPOdmq/r8nzlwZkYhbJlwwlSao8mbl+IJ1Ns/MNWdCYNdIfoKE+o4nhtMHCGh
 m0t/b1b3vf5VZaTGEQSgnPH6z+ICqRmck9tEzbUU0iTuVg/wkaQHHR0EzYHP/oV0B1oK
 1ENFlFPIfOGvsiiV84MPFFpJFxN0pyD14GAmbNoslzuZ7HrLRDEeiQHv1MSfF5LAkZUo
 SNbg==
X-Gm-Message-State: AOJu0YyHk3C0Odh6JdvSPrshNoSWitIuOTxv8JghUyzS7kGSdAMOL9DZ
 q67C01HtVnzlz5twlnwOMOXv/+xyD8OFwivc5Mb23OacQ0JrlwHw4FyITqye8MFOvBMFvJtdD7P
 ip9tuqfJdvku7RykRidsBk3pq39ZX52597x3tHtkYTw==
X-Gm-Gg: ASbGncuPNBkTIYyiGDyQOab76sPAf3rC7bX1nT6Cl8lSAxNn8MB0+eSaV5KQzFIs/iX
 ELbKXj/eBX06AIChb4MfzE8a4ofzZau2vsmLH1sZN2PAhKm7zVRbPy8opgwg7E9rDjKdrEkpjUZ
 H+/kyXdKOXY4vPDaBtNf42yhozrVZA8KjqTQ==
X-Google-Smtp-Source: AGHT+IFy23899he6EU+chMal7vR6/dZzVtCt941tKQ8ngUnljcaPnC8RB+X1bOD9U57M2Nyh1sCRjzeBguEW4FUEZXM=
X-Received: by 2002:a05:690c:5c08:b0:70e:2a57:83cc with SMTP id
 00721157ae682-70e2d99f0c8mr243048637b3.12.1748533059073; Thu, 29 May 2025
 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250513173928.77376-1-philmd@linaro.org>
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 May 2025 16:37:26 +0100
X-Gm-Features: AX0GCFvvE2syBP7vEGPKMecrfOn87W-_yMOuKLhfHhBrskq9tsOgpHEQGXcX52E
Message-ID: <CAFEAcA9jfLT2NY_1K7z-zHyzzpbw1NcyKRxrPvLx3CoH2QxSRg@mail.gmail.com>
Subject: Re: [PATCH 00/19] target/arm: More header rework around arm_feature()
 & multiprocessing.h
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 13 May 2025 at 18:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Before I respin my "single-binary: Make hw/arm/ common" [1] I'm
> extracting these random cleanup patches. Some aren't necessary
> anymore because now units in arm_common_ss[] can access "cpu.h",
> but the patches are reviewed and simplify a bit IMO.
>
> Based-on: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
>           "single-binary: compile target/arm twice"
>
> [1] https://lore.kernel.org/qemu-devel/20250403235821.9909-1-philmd@linar=
o.org/
>
> Philippe Mathieu-Daud=C3=A9 (19):
>   target/arm/tcg-stubs: compile file once (system)
>   target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF definition
>   target/arm: Only link with zlib when TCG is enabled
>   target/arm/cpregs: Include missing 'target/arm/cpu.h' header
>   hw/arm/boot: Include missing 'system/memory.h' header
>   target/arm/cpu-features: Include missing 'cpu.h' header
>   target/arm/qmp: Include missing 'cpu.h' header
>   target/arm/kvm: Include missing 'cpu-qom.h' header
>   target/arm/hvf: Include missing 'cpu-qom.h' header

Hi; I've applied these patches to target-arm.next.

>   hw/arm: Remove unnecessary 'cpu.h' header

After this patch things fail to compile:

../../hw/arm/exynos4210.c:511:20: error: use of undeclared identifier
'ARM_AFF1_SHIFT'
  511 |     return (0x9 << ARM_AFF1_SHIFT) | cpu;

../../hw/arm/mps3r.c:295:14: error: use of undeclared identifier
'GTIMER_PHYS'; did you mean 'ITIMER_PROF'?
  295 |             [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,

etc. Probably this patch needs to go later in the series.

>   target/arm: Restrict inclusion of 'multiprocessing.h'

Starting somewhere around here the patches don't apply any
more (trivial rebase conflicts, I think, but given the compile
error above I didn't spend time on trying to sort them out).

>   target/arm: Move some definitions from 'cpu.h' to 'multiprocessing.h'

>   hw/arm: Include missing 'target/arm/gtimer.h' header
>   target/arm: Extract PSCI definitions to 'psci.h'
>   target/arm: Extract feature definitions to 'cpu_has_feature.h' header
>   target/arm: Add arm_cpu_has_feature() helper
>   hw/arm/realview: Replace arm_feature() -> arm_cpu_has_feature()
>   hw/arm/virt-acpi: Replace arm_feature() -> arm_cpu_has_feature()
>   target/arm: Always include full path to 'cpu.h'

I'm not sure about the arm_cpu_has_feature() patches at
the tail end of the series, and there seemed to be some
review comments to the effect that maybe we don't need
them any more?

thanks
-- PMM

