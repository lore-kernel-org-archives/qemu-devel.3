Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF72C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEki-0007vO-IA; Thu, 20 Jun 2024 06:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEke-0007uv-Is
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:10:45 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEkc-0008U8-Qk
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:10:44 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so7146251fa.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718878241; x=1719483041; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtW2PjYDm2ZcTRvR96oon/PVVay2h/NrCdIjd+nEyTU=;
 b=yVGDmmf7jo8FSepcMLKMwPO37+A4eDWSZljP2AjAv4H8vy7LRhKBeaW+PzgPQU08Lj
 c+xle/jRI0Z19Jdxh1uuU6r8pTTITx5x0m/n7uz6UgW88M/UjEsELFy1msaJbp4KQV0L
 R/f8hDMYB+ALRPFUxv8MXt2QyP/XCNx3HcxUkjWHU/JQ19hl3bW2HgIU8CSxMEfY5jf4
 wAGpogun4jXK17sPjPozZpb91uYwNAsj3bRc1Jhra+HWkeyFSg1yHKcLEU729wujCPeW
 XPwru7J4IMGBJ3UvUMjFAIl8CMlPyGSdXuAMOYzn/p3e0ZIgjd4gyO4LTW9IswMACrjc
 cQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718878241; x=1719483041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtW2PjYDm2ZcTRvR96oon/PVVay2h/NrCdIjd+nEyTU=;
 b=Z4FJSq/PztTihv3gvV3yKC4kJuGgbrgNXHij/F5Zz0mfe33ICLux3ThYPcCdbGrwkC
 PngIz8tS5cDEfAROJiPx7h15uid06PfssWyNfkMdu/cP9NZm4XCwnTouLa97Tc+QcxRQ
 YW0JyB10AYzvrOsS6fSXdaAA+XD3l7DZkyJ/3aBF6TdavsC+ufCsDo+oIKYK9ld5WPkG
 BWPvyH1Ge72EQNVx8U7awyxRq1rArDCom/VfwT7/aTGHqxXcD1wDivnc14SZ3/AA2Ndg
 3t8d5ZOk23xH/uC//QHxSUZ/CDNmTmy6RLAIs2pyinDMUNd9R6ZmTmdjFQ7Pi+u6N3N1
 DQ1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqzDG9qTgBxpr/bp/1m88vKXc01evEauRVEfTQ2dSdwKm0koOg3PbRA8pmjyCKfKOe+vSh8npeCitJeUql3hhNwm/GlcE=
X-Gm-Message-State: AOJu0YxOZweWm29nyz1hp0GXM9KAaNF2qF3I5vJOVPY4un3FZVYBTpPN
 70ICeVRo6Vmi7N8wXYxJhsXrQaPIWd+At6HCePY27uTAtRoz5/XyQUGKcVHeJYyNvEIS18BbeSD
 wcpx89j6TakJgexsR9xEPpWjMt/XUJYP0pTqBsQ==
X-Google-Smtp-Source: AGHT+IEkpjfVgsIjQRpFjmpo0r2yPS6jeu5X8iKlHAtLVM+IEeHDOwrSVsOvcdBR9+HAolieW5euo13D7K4chFKW/go=
X-Received: by 2002:a2e:9257:0:b0:2ec:27d0:b28b with SMTP id
 38308e7fff4ca-2ec3ce9f6d0mr32151901fa.5.1718878240607; Thu, 20 Jun 2024
 03:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240618144009.3137806-1-zheyuma97@gmail.com>
 <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
In-Reply-To: <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 11:10:29 +0100
Message-ID: <CAFEAcA82T-hS0Armp6PVBkrywfqv+-u+L4z8rtrjBpnwvE8Hxg@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 18 Jun 2024 at 15:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/6/24 16:40, Zheyu Ma wrote:
> > This commit updates the a9_gtimer_get_current_cpu() function to handle
> > cases where QTest is enabled. When QTest is used, it returns 0 instead
> > of dereferencing the current_cpu, which can be NULL. This prevents the
> > program from crashing during QTest runs.
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=3Dqtest, -m 512M -machine npcm750-evb -qtest stdio
> > writel 0xf03fe20c 0x26d7468c
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >   hw/timer/a9gtimer.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
> > index a2ac5bdfb9..64d80cdf6a 100644
> > --- a/hw/timer/a9gtimer.c
> > +++ b/hw/timer/a9gtimer.c
> > @@ -32,6 +32,7 @@
> >   #include "qemu/log.h"
> >   #include "qemu/module.h"
> >   #include "hw/core/cpu.h"
> > +#include "sysemu/qtest.h"
> >
> >   #ifndef A9_GTIMER_ERR_DEBUG
> >   #define A9_GTIMER_ERR_DEBUG 0
> > @@ -48,6 +49,10 @@
> >
> >   static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
> >   {
> > +    if (qtest_enabled()) {
> > +        return 0;
>
> Indeed this is how we fixed hw/intc/arm_gic in commit 09bbdb89bc,
> so:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > +    }
> > +
> >       if (current_cpu->cpu_index >=3D s->num_cpu) {
>
> That said, such accesses of @current_cpu from hw/ are dubious.

True, but I'm not sure we ever settled on the right way to avoid
them, did we?

Anyway, I've applied this patch to target-arm.next.

-- PMM

