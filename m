Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E31C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdX8f-0002YG-ST; Fri, 23 Feb 2024 10:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdWwe-0000Ve-Bo
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:54:36 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdWwc-0005xC-Qa
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:54:36 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5648d92919dso1031968a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708700070; x=1709304870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPQfjQWIvQBLRJ6qvfBoFUVUFt5Qf/N+PgIdEHrJilU=;
 b=wKs4m66SpUeojcxrG0baQVYJj64GQvgMkpRo6ugRKhjrHaR2sKsu+1GN5fxzIiHi3N
 XTxE5EJPGEqLn8CTDMbV2tt/QbdlF0lTOg5HC5yf3iKMHp0FtvH+eKTErjGUoQBUoMPT
 56LaSMQxSKnN18uUEuWRq7h54oRpRq6LDncbSzkMpi23X/6oA0FXOfMyW7pBknaYY2bR
 HzEqru2t/ThCYEs6JGFXk20jzRKaxZVtzCSrLpuQ2tAS6kf+U97xK5/3THAhDQChX/pb
 cdySDi+ik3XJ7+lKg2L8cPB4ZO0Bi3D9PdWWpYADL6SSs9QXdfT6uBbP9uGkwajjWvIQ
 aLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708700070; x=1709304870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPQfjQWIvQBLRJ6qvfBoFUVUFt5Qf/N+PgIdEHrJilU=;
 b=YQ2B2gBvn6KdeOx9hDVcdquZ3Dg8NCHjNq8b6Q9+GkOWtTHhH8JS3Xfs4POHdMqgok
 EYQ3TWptCOHNZtr/d/9iPrrGxf2QBgqXZ62OvfkP5yLat844CpreU8WUWX1jn5VfAXG5
 4F8RmnRPH0n2yqcmGS9NSd6dqwzj7pnEw2zHuxaFMebB2PC0VDbAMKMKKd+nVIti0ifR
 Mj2egWRZWnqoD1YoVBB40yIWBmU+WSZyHgY2Hbj0ZiQ+A4gABcTk1Ux/y6drjI03VFxx
 olaFsNldmVlXo/FUkQuJyg8UpCB96V3xFERj8SHTb3b7p1UNPXryfsV6O3oGHv6RERrf
 00pg==
X-Gm-Message-State: AOJu0YxxdcpwbGgZ8hpjMCf1lj+f+72jhUke2rSp4N8s1S70xaLbJ0j0
 0KZA3T66AeRwsJ/uXdNQROGrTJnnwz+8qiYYfbaV+MEXV7zmg8Rr5f0D5lyES5BvOjsynf8u4B6
 GJa5262O6c0r8Vgy9Dx0Bs0PHyTzG8RMgTytG1g==
X-Google-Smtp-Source: AGHT+IFDKCPKLInO3LzhjwkJhTSK4tXr8wSHM3qhHeK9oim2424hXcp/9Iq5VmIhlW4J4fcnVmhj+kcn//s8XaOO5Ws=
X-Received: by 2002:a05:6402:895:b0:563:d16b:a04f with SMTP id
 e21-20020a056402089500b00563d16ba04fmr46877edy.42.1708700070578; Fri, 23 Feb
 2024 06:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-9-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240219200908.49551-9-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 14:54:19 +0000
Message-ID: <CAFEAcA-GPocNOoe=dp_3dwXvTbVuDOJJRQvhSkCqiwsLybavWw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] Add tests for the STM32L4x5_RCC
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 20:18, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Tests:
> - the ability to change the sysclk of the device
> - the ability to enable/disable/configure the PLLs
> - if the clock multiplexers work
> - the register flags and the generation of irqs
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Acked-by: Thomas Huth <thuth@redhat.com>


> +static bool qts_wait_for_flag(QTestState *qts, uint32_t event_addr,
> +                              uint32_t flag, uint32_t value)
> +{
> +    /* Wait at most 5 seconds */
> +    for (int i =3D 0; i < 5000; i++) {
> +        if ((qtest_readl(qts, event_addr) & flag) =3D=3D value) {
> +            return true;
> +        }
> +        g_usleep(1000);
> +    }
> +
> +    return false;
> +}

Tests using the qtest accelerator shouldn't wait for real
wall time to pass. The system under the test does not actually
run, it only moves forward the system clock when the test
asks it to do so by calling clock_step(). (We have only a few
tests under tests/qtest which need to really run guest code
and so can't use the qtest accelerator. Those may have a reason
for wallclock timeouts, but need to take care because the timeout
that works fine on a fast developer workstation may be insufficient
on a slow heavily loaded server running a CI job...)

Either the device being tested here will immediately
set the flag we're waiting for here, in which case we don't
need to do this loop at all, or else it will only set the
flag after some amount of simulation time has passed, in which
case the loop will always time out because simulation time won't
pass until you call clock_step().

Most device tests don't need to call clock_step(), because we tend
to write our device models so that things that take time on real
hardware (e.g. waiting for a PLL to settle) happen instantaneously.
Timer device tests are the ones that usually do want to see what
happens after simulation time has passed: you can look at
tests/qtest/cmsdk-apb-timer-test.c for a simple example of that.

thanks
-- PMM

