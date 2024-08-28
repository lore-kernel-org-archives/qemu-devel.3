Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E7C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjLCl-0000bv-U0; Wed, 28 Aug 2024 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjLCh-0000ai-Rq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:07:27 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjLCb-0002Bq-Uq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:07:27 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f51e5f0656so18072731fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724861239; x=1725466039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+hAxkQhq3tMvqUEA7PJelfbPz6TyQqaMP1c4Jjr/oU=;
 b=jVfcNqpUXul1ruVVWXYqEqQ8dRbtiF4zwiBQhOsTzfCvIlalXXSr5W5ygIvTH7jUI/
 ggm2CIMENzNKXiqw7tIspUJ1Xb/AgoXb0uf27KELoPaGYPUslgWel14U/tXoQkYTrAEX
 S9v/G/ShGzLA/Z7a0DpdJdb5NgYSFecdXXUn6KgnKlQYSzN1Q2YJRrgQyieYL2wfAAmB
 Dm23WtSEb+ocZBzT1JphhXSyXDg9YOxRh2rFnAwqkf5KV3D43fctZgIU/0gGEw6fL2x0
 NEUKsPQauISvp6BU9ktHYRZ7neMaXtfApHNSu0z0prUsMO/inZZu+C7uz6ej8mXPttve
 fDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724861239; x=1725466039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+hAxkQhq3tMvqUEA7PJelfbPz6TyQqaMP1c4Jjr/oU=;
 b=mrUVe29lIjB0ryvmilkLxC3sL/0d1M3GzoksCv5ieCzFSHtuAwN+rpbb7H+WA9QIxz
 MYzg230CDEGtcYFMEzPPoOMO+FEPlDub+qHaY9l8Ln6tT2Fl/AeBI2NRTcX0+XwivLdY
 Tb+pXF6g/8boTcXFbmBuXrGpCHeBEs2DtZMuD5dD9NbzZQXAU3fhCWTQtkC/daZRq584
 FKEmQhAIhw4dhjaOwJZw5K4V+Ry4h/409Z6CrJhsj8SLQqNhdHHZ5pTUlvgeNW0KQhHl
 +F1RCj6rce2ADEYE0yfw3mQsi8rO2Byg8LHsZX6dL/64vKraOQgNPkdi4w7ZG6wOIPLo
 Koqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzrdq1j4pa++17kuwisuNRnfr1c3O3odkiM3z2gl8zceBeuRBlSSK/oLhq7B92EAkS4UZMTtPZLdPf@nongnu.org
X-Gm-Message-State: AOJu0YyOsz8cFqL9vxnVOKuBskBDbFZZnqq87qy6BYwInNu+SBiPvnHi
 yVnWiJhXmlxWX68Y5JUchbcaraTg1mbJh+lmHUoe4LhFWQRhbkN2ivLBFVDaZpTyYlc4Rkw6sCf
 wO7gz9FY8lFEcfqaAP1s/eNdLT1EDvHPQd/1scg==
X-Google-Smtp-Source: AGHT+IH4SFH/RJ2/xpGnpmgXhuGwnKn8+dZbR5Jzg0Q5rRlx67pM8e+sPp+g7e1YRAH5i64m+0U4PI/lhoZf5Twt+I4=
X-Received: by 2002:a05:651c:b26:b0:2ef:1d8d:21fd with SMTP id
 38308e7fff4ca-2f610390981mr2320041fa.2.1724861238805; Wed, 28 Aug 2024
 09:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240826204628.3541850-1-fanjason@google.com>
 <20240826204628.3541850-2-fanjason@google.com>
 <CAFEAcA_ErHypGHM_Gbh3dt35WSuAn5CworUiE5OcY9M2dDOGmA@mail.gmail.com>
 <CALktSQ=+K=RJGoZ2niEgUiwCnKtsSmB7u8EzN170iGV7aFpSfA@mail.gmail.com>
In-Reply-To: <CALktSQ=+K=RJGoZ2niEgUiwCnKtsSmB7u8EzN170iGV7aFpSfA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 17:07:07 +0100
Message-ID: <CAFEAcA9H=w29-8CQStYYNwEU=OEB=NzxpioaqGEgSpc4KnPOHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu/bitops.h: Add deposit8 for uint8_t bit
 operation
To: Jason Fan <fanjason@google.com>
Cc: philmd@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Wed, 28 Aug 2024 at 16:59, Jason Fan <fanjason@google.com> wrote:
>
> Re-send this to include the original mail-list.
>
> Hi Peter,
> I am working on a i3c target model which requires bitops on the uint8_t registers.
> deposit8 can help to check incorrect length or start input for 8 bit value.
> You are right that desposit32 should also work if we always pass the correct arguments, but since the implementation seems trivial enough, I just go ahead and create the patch.

Thanks. However I think by this argument we would want
also deposit16, deposit24, deposit4 for 4-bit registers,
and so on indefinitely. And your start and length arguments
should be #defined constants, preferably done with the
FIELD macros, not raw numbers, so I don't think that
kind of bug is very likely. (Besides, even with a
deposit8() it could protect against, say, a wrong
start value that was 8 or greater, but not a wrong
start value that happened to still be in range for a
uint8_t.)

-- PMM

