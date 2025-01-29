Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5453C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 12:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td70w-0002Xg-Ag; Wed, 29 Jan 2025 07:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td70u-0002XG-Ma
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:17:48 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1td70s-0003u8-SR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:17:48 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e573136107bso11325673276.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738153065; x=1738757865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ptZga5H1gf4FFJ72Pk0ns03O/gjUlQr7tb0icgzWqxs=;
 b=ls3fcz6c4AR3rZNOD0/G+nLjEETmvgol0fNpSSc89Lq1ILUMtOOPdxpFFRnjSIDt2z
 ZpzV4bht3c/oFUjdKPyhSaNPMPHCd8G2/go1hhUwG/F8nWJsc5yaDHjReZDVWgTgpWZG
 6X7+pq0q6WOJWEZ2Z7eIfpcx98+wrMqdS9XKxAlREIlX3278DJ9orfjWuakl4xnGDynU
 ZsYeTrDkmyYg1/viZMMeGcyQMTkG3u41DYDl88sUswPR/0pw7MkOBKmPzbI+8Oe7NFAV
 7r7h8CkOpNGM/oajtAdWWYRlchOrGMZ4CnIxmCbrASQXXR/dw/rD10CpNwx6ZPV6jejW
 N7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738153065; x=1738757865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptZga5H1gf4FFJ72Pk0ns03O/gjUlQr7tb0icgzWqxs=;
 b=FaX5dneweqboqn173ItUIDykBCGpVG/90o0ajWAShUhAC1tgDvkAssgtcSM+wfCQ4Q
 gjHvOYR1pVgCVfHuB7Icy1mExHQczC2Phc5TFdsykBqISWqbhLq4mU9VxuYdmuU+5wuA
 pSpg5tJGpqGGCfpk4rFy4NMysBX5TgOjVy2JRQ1p30LgfRL8FwPyUlxP7HW26fM1OGQw
 XEJX8BOg7XjNynEC0a7GIea78Pl41oaihRpAae3VRUNrLhcaP6DUpasOpXEu2lFamK+g
 v0jj472rY+b13AsX5jvKNfvWoYJuK5YrXWzdJvVoT1lvj62TNncpMFkQMnoK1fyXhTPN
 DxJg==
X-Gm-Message-State: AOJu0YxPCRzzlg+z3zJgbcLAC1xEcxPhLzeXGjpk9uugY5Radgw35JNJ
 YF9CGzUdT3fqSDp/0Mk+qsfylSkplx9Jb0+PUTbU1+iSSqkMFRd1eArEzS+eqJbVg65ivudeZTn
 VdXMgFa7l0RZT44ENEpYEj82I0FyBi/ALt3MLeg==
X-Gm-Gg: ASbGnctZeqFUqbkbjdA/P6tQEIdnWnOBZBgWwzW8NuarqyB7EMQsgjUgdzHnGDJAW6b
 O4sSV7jXXie9stQQagT/UCCvWA5+6NpHJfTaOg8ckgja18J+pzpJZP1hfFIiTtf7VqGlnfhN3y7
 urisxDxrFj
X-Google-Smtp-Source: AGHT+IGN8hQ7QS0dJQnMXqC7llFxhUeViwW7Tn2oObzJQqQpdA7sL0CPNKnEyGV5X8zcToiE6Bky/8jeaqNdG6jObbk=
X-Received: by 2002:a05:6902:118d:b0:e30:ebdf:9643 with SMTP id
 3f1490d57ef6-e58a4a9a3ecmr1921228276.8.1738153064772; Wed, 29 Jan 2025
 04:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-6-shentey@gmail.com>
 <CAFEAcA_NBPqbOrVJw=bDC6=dTGKBKe42XoXMm82jj7+pHEvW3Q@mail.gmail.com>
 <4EC5E99E-804A-4154-8D61-22D1358C0F6B@gmail.com>
In-Reply-To: <4EC5E99E-804A-4154-8D61-22D1358C0F6B@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jan 2025 12:17:33 +0000
X-Gm-Features: AWEUYZmPJdkyfLwL73Fx_J6ci3Z3l64ovGh6AHYuylD5FXPAiehSzDL19rKViLI
Message-ID: <CAFEAcA8E4Ao_bJTxKzJ_kQ1n+Teqw6brmJKFN9cFpraM6jTYag@mail.gmail.com>
Subject: Re: [PATCH 05/21] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 28 Jan 2025 at 22:16, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 28. Januar 2025 14:29:53 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 846b81e3ec..cace8cf25b 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -819,6 +819,15 @@ F: hw/pci-host/designware.c
> >>  F: include/hw/pci-host/designware.h
> >>  F: docs/system/arm/mcimx7d-sabre.rst
> >>
> >> +MCIMX8MP-EVK / i.MX8MP
> >> +M: Bernhard Beschow <shentey@gmail.com>
> >> +L: qemu-arm@nongnu.org
> >> +S: Odd Fixes
> >
> >I'd rather we didn't take on a new board model that
> >starts out in the "odd fixes" state. If you don't
> >have enough time to look after it, it seems unlikely
> >that anybody else is going to want to take it over.
>
> I'd look after it, but I'd also not raise expectations
> regarding commercial grade support. What state would you
> suggest?

That's
      Maintained:  Someone actually looks after it.
(There's another step above that which is
      Supported:   Someone is actually paid to look after this.)

thanks
-- PMM

