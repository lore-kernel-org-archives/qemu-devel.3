Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F178E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUn0-0005mx-K5; Tue, 17 Dec 2024 05:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUmd-0005mB-BJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:26:32 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUmY-0006lO-Aa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:26:31 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6eff5f6fe07so37477247b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734431182; x=1735035982; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/rQgZ/oeQahjrYm2PRJmTFP2DkZlk2xmXF2IH2WwbU=;
 b=sdq6wpOAXXPF9a1E7708/8MhdFn3WMuQVKeiHG9UNM84gs/jPYxce6dCyTkf7SMXMd
 gwMIYynrP+h6HVgxMO1RCvCk+BnUV1dSRGHtZCmeJ0AP9DTm1QIgvE6PNU+bLb61rXop
 4eo+j7uoL9TBvvky6iFiceEW4NhglosIUFQEMsbsBGog7Zt7ZFgEbLBS3pkUF41C+wEF
 UBdljatFkh+CKKYZda0RMmovqPoaIJsLSRVkgq+vA6c+n+pSjyIb+p7xH5IIWet5W2k3
 cZWRBuHHBCL+/kHAP1o3kVErusZp//Y/de0TSux1juVpO0jnlfMQxBiah9T8fLkaZfr/
 w4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734431182; x=1735035982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/rQgZ/oeQahjrYm2PRJmTFP2DkZlk2xmXF2IH2WwbU=;
 b=epk0FM/RjBU4oteFpR9+PIGSxb/0tS0L4E1JO5F2Q1IY1qznIneUeIx0tboqz/5wfL
 /4lp1jfKLQ5MbEatCAmqyHtH519AdCEzSoZhl1mt/RNBZoOY0rhD/V3A06tEJju6YKo9
 SFnAIBAIbFriHovg6jnS9akD9SdnjpAS/LMDirt161xKI1Z5UOd/y8B+lRRp3IL0YSeO
 wqtw0SfsKpHBdgHlojjykwKygWzJQtGUTM6Ot0EJRfETr5hOkipJl3/nNcCzPasbxLpn
 PX0onKCkYfObGa+MpgwUGFrEdiKSuOveLa2UTX3O98Cd5S63xuY8HB0LJwkDvwFgQGN0
 3xqw==
X-Gm-Message-State: AOJu0Yxl27CxVVX5FseEoGX4KqlkDpFfO8wlbvwA3SrqQ6lemAdzKRo8
 1skUdPfMvefWFhwUrEPqvkHv9CJUxt5N4V7yFUElizb0a9JR/FxGMz+ggSnkJRPswAckyopL+z7
 sb+m/wCcoCgcSEScrbowG54W+9sK/sJg9iIAmsA==
X-Gm-Gg: ASbGncueUpPFnYvobVAD+qgtlnKiaWqBvRj3qql7OKJrh2cRXcJ/bxYvqtzCWDbMZU2
 uOScGVYsfJ4+jxgp+6gjBgjruz+wcNOBfR/Inc4Q=
X-Google-Smtp-Source: AGHT+IGIbn1mQdQVBYitHaeW5bX2cZ8tsbcLxdQXiPMvQeK2MLNBPiDSNM+HZLFaf8LXogMFU68HTmEvK7XCKmDVw8A=
X-Received: by 2002:a05:690c:600e:b0:6f0:5fc:7d with SMTP id
 00721157ae682-6f2bbae5e20mr20582257b3.11.1734431182168; Tue, 17 Dec 2024
 02:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-4-alex.bennee@linaro.org>
 <CAFEAcA8mi=gTBvh9FqyMFeyqAHqirkah84sW4m8axKPqwMZDkQ@mail.gmail.com>
 <877c7z1l0h.fsf@draig.linaro.org>
In-Reply-To: <877c7z1l0h.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 10:26:10 +0000
Message-ID: <CAFEAcA_F4mXvCjY9r=-=zRYzsThA4_Yz=qN-Uc+1b272f-J20w@mail.gmail.com>
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

On Mon, 16 Dec 2024 at 19:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 6 Dec 2024 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
> >> shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
> >> actual implementation utilises the same logic as the rest of the
> >> timers so all we need to do is:
> >>
> >>   - define the timers and their access functions
> >>   - conditionally add the correct system registers
> >>   - create a new accessfn as the rules are subtly different to the
> >>     existing secure timer
> >>
> >> Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Cc: qemu-stable@nongnu.org
> >> Cc: Andrei Homescu <ahomescu@google.com>
> >> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
> >> Cc: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >>
> >> ---
> >> v1
> >>   - add better comments to GTIMER descriptions
> >>   - also define new timers for sbsa-ref
> >>   - don't conditionally gate qemu_timer creation on the feature
> >>   - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/g_tval_[rea=
d|write]
> >> ---
> >>  include/hw/arm/bsa.h |   2 +
> >>  target/arm/cpu.h     |   2 +
> >>  target/arm/gtimer.h  |   4 +-
> >>  hw/arm/sbsa-ref.c    |   2 +
> >>  hw/arm/virt.c        |   2 +
> >
> > I would put the board changes in their own patch(es).
>
> Won't that break bisection?

Any guest code attempting to use this timer currently is
not going to work because the registers don't even exist.
So there's no previous working state that would be broken.

thanks
-- PMM

