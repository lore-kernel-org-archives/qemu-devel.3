Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E47BC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg40Q-0006KB-I8; Thu, 06 Feb 2025 10:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg40O-0006Jj-RI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:41:29 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg40M-0002gB-H5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:41:28 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5b1c4d14f2so926182276.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738856484; x=1739461284; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MUmIUl+7CiZDD1nVfbNvHDoplWKLvo/NAi2M7/ioT+8=;
 b=s6e0nHDnAesWEOZMfaAO/WETLNT/fJzFnauXMiH1qKYHd3s/BB+usNhcsIK+CZUYNB
 6Va34xp5EojKsinKx3cGGSnHP02XQ4MC2lBp5wpcKD7fQIBWc8gvybue67iB6yDm0h5L
 n5Anji1rwJLe06HEpVMHwDMBZxIQFtF/BQYlampXIQ4S9AftWrm0aN14gfp1M6PukQxK
 LxXUBVIAKY6qxT75WdWBJdb6iYruWXl7FIekbrpHB06uKSXPbz+ZvKZLWZ9duq5cZvca
 XTdHUmPdYYIBsi9k5jnT2BpxcGLWykoX0J3vTj4agvg6VOxEa7lk3jtM6sj/hX92n8RI
 h7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738856484; x=1739461284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUmIUl+7CiZDD1nVfbNvHDoplWKLvo/NAi2M7/ioT+8=;
 b=vvRAtZV6TjKeHLPBlryzrLF9WXRAuZALDPWAud2HF3zc0JtjQ+mV0YXZAI77oTVwcf
 JSkWxlfNZpXcOhYuAdpY8p/hvsMCc1ZGzACSHWdNlIMmLI0tJeoKjFV7JuHPKSlUZwan
 i+oj2sdmfXhK2cjzqjSdgKsHfMbd5JTjqxj/mkFs6KQgnQoAO+lKWtOMm64DxWnD0VYw
 xcPw/97m/tGlr/0uVAM/IrqmBQu68kyHJIHIpjotKiVkHkdPP2AjEzthnlu7/n9t3CJ9
 umxpuRjkjQDlLAKubcP4UQqMnV/n+7RpGOO2Q3EUEqJZjb8n6vMITY/CK9sE/ecZ5+77
 ZdOg==
X-Gm-Message-State: AOJu0YxjsFJQI6WJSPzOWktN+0cPRhHgSScTVabL0sbdPfEVpqCcsitz
 Oku2xV3ZgGJj//GMJU3W/cOfKO27fMk2ZO3H9oRy9jB3FRasU9KmLdKAmI4Swv85LyZi9wjmoPU
 oAMaI9LWwd79zaTuRgQB/jcMcWdLeL5bMCs+tEw==
X-Gm-Gg: ASbGncsPayZVPC3bpNeHIrCY0cj8UjQ+CUnzYMclxQM2rcgfQA1zxtuya4l3Qn7lRV4
 tbjCsx7WXFvbpkDk6Ln2PPO2BAe+sGD5Yrn2l063viyyzHeRSk8NK17aDs8b89eKWV082fDSS1Q
 ==
X-Google-Smtp-Source: AGHT+IEQYoK7m6ukCkfWVtPyPECRjxZZMSwxIDjatSWlNpaDxigHgRH/AMt8wmr96H2m5vZvnYXyNlAL/Wc5S6BUKpc=
X-Received: by 2002:a05:6902:cc9:b0:e5b:257e:c3b1 with SMTP id
 3f1490d57ef6-e5b259d1967mr5605889276.8.1738856484213; Thu, 06 Feb 2025
 07:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
 <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
 <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
In-Reply-To: <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 15:41:12 +0000
X-Gm-Features: AWEUYZmahiK2qpuPa0z3RYfenGXJ3dinOUgdtOsO67P154Uz5jEB1MLc-NVKMig
Message-ID: <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Tue, 20 Aug 2024 at 12:30, Florian Lugou <florian.lugou@provenrun.com> wrote:
>
> > > $ aarch64-none-elf-gcc -ffreestanding -nostdlib -T qemu/tests/tcg/aarch64/system/kernel.ld -o test test.S
> > >
> > > $ qemu-system-aarch64 \
> > >         -machine virt,secure=on,gic-version=3 \
> > >         -cpu cortex-a57 \
> > >         -kernel test \
> > >         -display none \
> > >         -semihosting
> > >
> > > $ # Exits after ~1s
> > >
> > > $ qemu-system-aarch64 \
> > >         -machine virt,secure=on,gic-version=3 \
> > >         -cpu cortex-a57 \
> > >         -kernel test \
> > >         -display none \
> > >         -semihosting \
> > >         -icount shift=0,sleep=off
> > >
> > > ... (hangs until QEMU is killed)
> >
> > For me, with QEMU commit 9eb51530c12ae645b, this test case
> > exits (doesn't hang) with both these command lines. Do you
> > still see this bug? I guess it's possible we fixed it in
> > the last month or so, though I can't see anything obviously
> > relevant in the git logs.
>
> Thank you for taking the time to test it.
>
> On my machine (Ubuntu 22.04), with QEMU configuration options
> "--target-list=aarch64-softmmu --enable-debug", running the provided test case
> with "-icount shift=0,sleep=off" still makes QEMU hang forever on commit
> 9eb51530c12ae645b.
>
> The issue was initially reported by a colleague of mine so I was hoping it would
> be somehow reliably reproducible. But apparently it is not.

Somebody else reported a similar issue to this to me this week,
which reminded me of a different bug that we'd found and fixed
in the interim, which was enough of a hint that I figured out
why this wasn't reproducible for me.

This bug only reproduces if your QEMU binary isn't compiled
with slirp support (which will happen if your host system
doesn't have libslirp-dev or libslirp-devel installed).
If slirp is present then the usermode networking backend
will be present and it always has an active timer. Without
slirp, the problem manifests when there are no active timers.

You can also repro it on a with-slirp compile by adding
"-net none" to the command line.

I'll have a look at what the underlying bug is... thanks again
for the handy test case.

thanks
-- PMM

