Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10086C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0BY-0002kG-8q; Thu, 08 Aug 2024 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc0BJ-0002fJ-BJ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:15:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc0BE-00033x-P6
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:15:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1246062a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723112129; x=1723716929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4g8dcmoChDv2it2vHAMsk11DokszwvL88J2ivi3iQ5Q=;
 b=S38R128iOFCehoGMSIxOHKNf+PV1WvLHs1q9jz/tR2fSzXJe6Y+qVMFAT+VXml5S89
 rS1RwveQjU0gDuNGKzUSjuAOOF3lPJdCPM0BAhQ+QA0FApJxidLDE3JnWI4htfhFdWkv
 OZjkm/D7/PmcYZfYwGAMPNoC3ra4Qo/rYiRYYUKqCvBTumkHGHI6Cazyw04163rKtMnd
 ocjT5t2q2RJtWis02oNcKcjJtar4kEcMqHL2RLeNJqrWmstoIu++PeqGH+co2b64Sc4M
 GnLI79L87K5Z+v9/lwffgcMVJnuJmKSPUoSvSMKuP6W80VjC1j0Vjai6vthLzVFN7t/i
 HqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112129; x=1723716929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g8dcmoChDv2it2vHAMsk11DokszwvL88J2ivi3iQ5Q=;
 b=JSmezEk+xYkPRNR82QSalH77N3FEka9cVfcncUPJgyIXOwlR/arcI+aDsdDo1tBR7+
 KL5+Nbx1ROG2u35Jb2SZCTsk48rzV9S5JdATMt6ZyYtPbpQPcZKipbZ/dzLhVY2A/P56
 Tiesb2vAfkuPdZ8u49T3RyIk+ulCNGcLBugYp8dnBaWYCOcG7USXyABfOJJ4ACcio2cP
 fSS9JMxL+6XMeDFkVRMlzQW1/of82jfOR7Vs6ap6V4CS/Xp0hTcMFjYBtM/sh0BEXpLf
 0vW1L1Ao7SHmwp3vRinVQBxHtTbXrtoW4UV2ZfVxKPMmtU9rwsq6bs1sRL705LoDYTBz
 wHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDqk+9BZN+aYhuMkAxrRC6gmMTJcZhlJz/K+Jm8PBvxppOt3ylimDzWCdMLsf+mbC9KoQG6WMi0lvPfOVa8NN1I9D0Cu8=
X-Gm-Message-State: AOJu0Ywn9eLU+/gPgUfzyrZmR2etHLT3fJMOZp70CzCf5KFSaN9FPoOQ
 Lox/BEtJ7+Boas6fI9NHpHetjcMnejbGuci4vB0znQSHdQhffGtjt7eVYvfjYH5rOmD9b7DdBKF
 YabgF8GJ+xY7gGp3oqlY9wjyGSqrkTh0Io9G27Q==
X-Google-Smtp-Source: AGHT+IE8PBNFPG6APEvqNhDMSsbFoox0V8+ps1OwXsN8WZQzNFAtL/x4px2bNYF1Pw3juyJYlpT6iXM7pSshJUJ0sVs=
X-Received: by 2002:a05:6402:280c:b0:59f:9f59:b034 with SMTP id
 4fb4d7f45d1cf-5bbb3c8f81emr1258112a12.13.1723112128774; Thu, 08 Aug 2024
 03:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 <87ed6z1j77.fsf@pond.sub.org>
In-Reply-To: <87ed6z1j77.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 11:15:17 +0100
Message-ID: <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 8 Aug 2024 at 10:02, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 8 Aug 2024 at 05:32, Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >> [...]
> >>
> >> > The QAPI command which this code is implementing is
> >> > also (a) target-specific and (b) unfortunately
> >> > designed so that it doesn't get passed a particular
> >> > CPU or particular device to query, it's just assumed
> >> > to be a part of the whole simulation.
> >>
> >> We can fix (b) if we care: add a suitable optional argument, default to
> >> the sole GIC in the system, fail if there's more than one.  I assume we
> >> have no machines with more than one now.
> >
> > The exynos4210 SoC (board types 'nuri', 'smdkc210') has
> > two GICs. (It's a rather odd design -- there's the
> > interrupt controller that's part of the main CPU
> > cluster, and then they used a second "external" GIC
> > that feeds into that one.)
>
> Then "fail if there's more than one" would be an incompatible change for
> this machine.
>
> If the two GICs have identical capabilities, it doesn't matter to which
> of the two query-gic-capabilities technically applies.
>
> Else, it matters, and we have an interface issue.  Do we?

It's not possible to use KVM with that machine type, so the
question is a bit moot. (This also indicates that the
interface is not very helpful -- it purports to tell the
management layer whether it can use an accelerated in-kernel
GIC, but because it doesn't specifiy the board type there's
no way to provide an accurate answer. It would be useful
to know exactly what libvirt/etc actually use this for...)

thanks
-- PMM

