Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8600C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH9I-0002FE-Ie; Mon, 01 Jul 2024 09:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH9C-00028t-Nr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:32:50 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH9B-0006pF-5o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:32:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so391519a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719840762; x=1720445562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8e1CaWsVPtKpH+k7gT0yv3OQ/WjO4R1smXp48iZjANs=;
 b=vvH6HHYNy4Thrx9Yg4+72WIxDhCPt+QuzPj28dj1a2M0fOc7MlzUntMZwp7zL9JnoX
 CokISNasKRLerF63X0NAL7otcS3TXitlA1w1jlK0ghqbZ1EWptNzXztALdgHehjwCyZA
 pV9JA5O6e0j94IIWqTgr+JP4A3ju7EMAaOiw95Cbo1fMNFTxLs3u6W5wAHPUADZItgqR
 DBtDxYIZsIFga9YFkinUFjciU4IIlFYgIj9TX6LososiA+yjt1yu/ko6cgt1sAd53wM0
 FGKFYN0cL1eWfsT0pVnHedCL9GhD2k7hmYAnZsRBAbqnjrxoCDMnjQWVWWScV7qeoy0o
 gLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840762; x=1720445562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8e1CaWsVPtKpH+k7gT0yv3OQ/WjO4R1smXp48iZjANs=;
 b=Qytnk2Zl17rxn2o/bjLfTFzjP8SusAY0k+HhU4AFJFlMKi00Zg7NMRDPccE+fgkKl2
 Jx3osIfJOYM6uIImqMQ92dFqAFHOy6Y6e6RJUVLh9jC6VU7HXKRYIu2bflBPDLaliEYV
 Yq4QI0mxSE/kEfpbZxjrs9hxJJFf/y+JVeeckgrOqcsMQR/kqg+8Uoahw/MWglt6aQ97
 z2PqBZc0Bl5M4Nr7n8X3uWVO8yn2BTBbxIRhShYx1Zd11K0s558uv1ZgDh2i9OrF6Iwk
 zBN07Rjmhj7fOoqvn9LVgfIFaDuY8UDBwqimPUjyGG5ffML7zMxxj0QY/1bUIXnZO8gH
 FMLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOp9h1hO66/VEd0fn8YEiAki7rAHM0qOsj3DE8aAf0ZslJqr6W1AAKGePZrbyTOmI+A01TACjEwN7j/iatw+8N+n8mdk8=
X-Gm-Message-State: AOJu0YyQlU5/dZHTJ4wUPo9xUhYSn4sqw/6dij+lnkAleN59wsrjEV9H
 d0e+Lgyhu5l205r1FxfZ47fr1aFh7vcEIzQK0PYVSxN21tG7lh/wcS0Xa3+syK3qufpFWvcelxT
 GAJrj9I+/l7tQNYrJFBO9UIGjEmxI2+OseideMg==
X-Google-Smtp-Source: AGHT+IGLOISxIcnFtFKNrNuzQvL36O0CLpWLREAAkq/8hTRyBpDgY9kagqC3UDOm0qFMfjD2SDqvGXN95DVc0iOEq0k=
X-Received: by 2002:a05:6402:26d4:b0:57c:6a71:e62e with SMTP id
 4fb4d7f45d1cf-5879f9843cdmr3350165a12.23.1719840762361; Mon, 01 Jul 2024
 06:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
 <20240629-pmu-v1-2-7269123b88a4@daynix.com>
 <CAFEAcA8FQLQF69XZmbooBThA=LeeRPDZq+WYGUCS7cEBiQ+Bsg@mail.gmail.com>
 <1b5608aa-5cd5-48b1-bc7c-e356afdc9865@daynix.com>
In-Reply-To: <1b5608aa-5cd5-48b1-bc7c-e356afdc9865@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 14:32:30 +0100
Message-ID: <CAFEAcA8+BzYOv4aO9QWHNBYFoCy0hnx+NSn+YH0gA4akCYE+Jg@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/arm: Always add pmu property
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 1 Jul 2024 at 13:17, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/07/01 20:54, Peter Maydell wrote:
> > On Sat, 29 Jun 2024 at 13:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>
> >> kvm-steal-time and sve properties are added for KVM even if the
> >> corresponding features are not available. Always add pmu property too.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   target/arm/cpu.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> >> index 35fa281f1b98..0da72c12a5bd 100644
> >> --- a/target/arm/cpu.c
> >> +++ b/target/arm/cpu.c
> >> @@ -1770,9 +1770,10 @@ void arm_cpu_post_init(Object *obj)
> >>
> >>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> >>           cpu->has_pmu = true;
> >> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> >>       }
> >>
> >> +    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> >
> > This will allow the user to set the ARM_FEATURE_PMU feature
> > bit on TCG CPUs where that doesn't make sense. If we want to
> > make the property visible on all CPUs, we need to make it
> > be an error to set it when it's not valid to set it (probably
> > by adding some TCG/hvf equivalent to the "raise an error
> > in arm_set_pmu()" code branch we already have for KVM).
>
> Doesn't TCG support PMU though?

Not for every CPU. If the CPU is, say, an ARM1176, then it's
too old to have the PMUv3 that our TCG code emulates. And
that kind of PMU doesn't exist on the M-profile CPUs either.

thanks
-- PMM

