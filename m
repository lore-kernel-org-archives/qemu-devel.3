Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A983C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6rY-0006YQ-Ou; Mon, 03 Mar 2025 09:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6rL-0006JE-ON
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:36 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6rI-00039s-9b
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:31 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e60b04fc3edso3068972276.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012406; x=1741617206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BG94PURy4Kn2Bfua32aXt/Ze4/q0cpT4/Ty3kd+QUZo=;
 b=K2AfOu7vkrVuyl+1cA0LBurjiYFpdIwuNflWz8YX0zDQyrFqcT7fAfwv1CBEJ+tdER
 gF2p9OaRwOeq/SHTy/wCdyflhJ8flpbFZ6A61DTDq3M2O3UjZJKl/TCNJVUVuirkGy/R
 Oo6mYJ8ZrhAJ6RtokwOAMDLDH7hPaLLZ249Pia4WliQZCghegtwXI6EybpzbF/Uh5u+U
 2RveJ/NKF4VhannDWYiWiFs7dWS4H3S6R67LZlxKYmhllkhqV4mcfk+Gjn4dyo9unWy7
 nzXWiP74FHwO57yPjfK3RMr5P+1m3UEQcGP6ZzWTQAfHbo0O0Zo8zfRzed/Ycc/L5k7q
 SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012406; x=1741617206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BG94PURy4Kn2Bfua32aXt/Ze4/q0cpT4/Ty3kd+QUZo=;
 b=FoJhqAwGZfJHo7Et7AsWFZfprvgrt1UQeLaF5b0YW83zTAaq96ymn/pGHxbv+qnNjq
 UELNP3IDltJ3J/BmaAqdpte1cPXAzLA9n3kp8afk/x+lXW2wjm5SbIEYapVrzyRgyKVk
 4VSESXjG/t+kqGXGRp/9ypAFPRcW3eppBwabirT+AUnO18KNmCVn3cJod9pWhjICT3Hk
 3wE3wRpijHWmoeMEf8Q6CYyTHphoL9NUXRPKCT04ilbekkjWrqw8VdoedofWy1VCNIjP
 iWOHv8FAjvmEXJwKgEjVE2ErtDShnfhcrh2VHsfPUv+tOAb+MWgB2uP0Eb9qlzTTiT2q
 Ojiw==
X-Gm-Message-State: AOJu0Yy3cbiBxOG7zzIj/ZPeBGqX8qloD0N8O7bQ6MpyPwCZnxwAH3bQ
 mPJq1qOIiSt7zbg4mts6slXSmZLBY9R7ZBo2z8R7Ml730QhBA2ehpWBx6VmwM7LjHglrMNLBl5g
 Q1SfKNvXozVNM4Z8YzgG/PsJHV7RbuLDJnRmd56Pf1ymy0z9f
X-Gm-Gg: ASbGncuqTLIa1ciHcyE91bNJblP60+ql9Adlj2Srm4hWyBc5HVxHUSmOOJ+nWu8V3ui
 i529kZCQ9/XP8R0pP1niuQxZG7xWgPdAKOA3IXEANrs5iAERTAuSGC+JMDHMSHykmTd0D0AVnbj
 +oiq66OWj8pAx4G022q3ch1cuQKLw=
X-Google-Smtp-Source: AGHT+IEW+Zu2ZKz6CA2+hLTYm6qMBsxguheHbfaRR7O+n1gfzQXn8N/hhHAxJjxJgHlTuL6J6MEqJz9dGmlIdOvlQw8=
X-Received: by 2002:a05:690c:6382:b0:6fb:47d8:79ba with SMTP id
 00721157ae682-6fd49fe0297mr165608147b3.16.1741012406716; Mon, 03 Mar 2025
 06:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20250225074133.6827-1-kuqin12@gmail.com>
In-Reply-To: <20250225074133.6827-1-kuqin12@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 14:33:14 +0000
X-Gm-Features: AQ5f1Joi0jVIjWjz2dEiebZ9_9YaJNZyiE_bRCgMIVi-PIGKdcgenlOHf-vs-k0
Message-ID: <CAFEAcA__w8-nJjP8zPk=3vLEgwOcoXa8K_opqeEo_UYBo=skhg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Adding TPM support for ARM SBSA-Ref machine
To: Kun Qin <kuqin12@gmail.com>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Tue, 25 Feb 2025 at 07:41, Kun Qin <kuqin12@gmail.com> wrote:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
>
> This change intends to support an ARM64 server like platform that has TPM
> support to unlock more power for sbsa_ref.
>
> The idea is to add a TPM create routine during sbsa machine initialization.
> The backend can be the same as the rest of TPM support, by using swtpm.
>
> Sign-off-by: Kun Qin <kuqin12@gmail.com>
>
> Kun Qin (1):
>   hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref machine
>
>  hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

By the way, single patches don't need a separate cover letter
email; only multi-patch series should have the cover letter.
This isn't a big deal, but the cover letter on a single patch
seems to confuse some of our tooling, unfortunately, e.g.
patchew fails to find the patch email:
https://patchew.org/QEMU/20250225074133.6827-1-kuqin12@gmail.com/

-- PMM

