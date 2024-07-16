Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1101BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgQQ-0000MX-Dg; Tue, 16 Jul 2024 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgQI-0008Nh-Se
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:32:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgQF-0004ak-Ou
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:32:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab63so8316987a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721129562; x=1721734362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+UbT74xhk+b2SVYVJW8InGMelgItyrvL9jYPz+CIMg=;
 b=ZGCX6w4UNta3DoSqlOJSRjjLxdSOQzRlKtfM3UqjAdEkOUuUyR/PwCCQJwDluEOLsX
 N0OJTh3WHoNaXwHDHZphppdCHSjg6kORwM6c/77Bp1gDWJubcmis/ZY92EMhRHU/qD8c
 d1bNL1NAZUXL6RRJgB01+LaTtCycu4WSge1Y5c1vLf6Kr3EH5Z4E3h90i/aL4krkbuZs
 5Yuu3ELTa5tBq7QPbcP0zmIjNaNUScurIKwXEkQQ+cHcfepebZxGCgxxdfS0hfrwJYpu
 FAF2gNtDAw/VuBpLamZ1yJ1o0lIK2gT/KT+spZ/oX9msnXIVvkDPN/6msKpeCj/EW67y
 IQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721129562; x=1721734362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+UbT74xhk+b2SVYVJW8InGMelgItyrvL9jYPz+CIMg=;
 b=w4aLy464mOErRDf/nbF7jsO5c2M+1/joYbb/5yjjL/dJN5RZPMWG40Nxgs7h62tngE
 WNUNfE++20lA4c3UMIOzNGGMn81ujhU3dXJmwLHth5vl50bTzbCogMLAHfP0iYRgWCtx
 qvaMvVVRZESSO1V1vdO6LImpDA5ql/viDW4BEwcNcBAsw576OQPrUNbRd0d58oRqVQbV
 ullAGoT1RQGIo2mIpp51Eux2aDzsnqi9liVovu4mW6hO9Q4VyKLnz9OHK2K73k438EYt
 aqu+9Mbuf9ZwDUNTzIGt1t8JYlRGhfkDKQ4I4Wrr0BMW9TOp6+2hUHBFQRbvPo6A0O/2
 2PSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQAyWadT4V1bDKTo1+300kn9bpyBLtB9nRcvPFEXCfeiOqAu8LTpngYr0lNWVBpE6LJXWbtnbeqiBjFRCvnsEhdUdt9EU=
X-Gm-Message-State: AOJu0YzjhOskz6vMZXp8QGoA5bUeILuX7CA32bghlXvYNm6P7YuQnSoJ
 aL54p/PEgcLS6KSdhnQ/gFwR0KU8AQmtCTUef5n29KN+TahefpXejLoHDgvy5w6Y1+5J/usCP0o
 32jUuGNZOPcBlfTX8oFZKqhpocO3QIr2Dvd7Ivw==
X-Google-Smtp-Source: AGHT+IE+O8dqUI/OG0kgY2BNmik8WSmu7vBcnDW2s3w9tfiJgcv6WUep5/b41oRdvvBiFsk2mgfhVG4zmvbSX7UPnZI=
X-Received: by 2002:a05:6402:3582:b0:58d:ebf9:4e2d with SMTP id
 4fb4d7f45d1cf-59eee833de0mr1345309a12.2.1721129561829; Tue, 16 Jul 2024
 04:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 12:32:31 +0100
Message-ID: <CAFEAcA9trFnYaZbVehHhxET68QF=+X6GRsEh+zcavL-1DxDB4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/arm: Always add pmu property
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

On Tue, 16 Jul 2024 at 09:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property too.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 9e1d15701468..32508644aee7 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1781,9 +1781,10 @@ void arm_cpu_post_init(Object *obj)
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>          cpu->has_pmu = true;
> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>      }
>
> +    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> +
>      /*
>       * Allow user to turn off VFP and Neon support, but only for TCG --
>       * KVM does not currently allow us to lie to the guest about its

Before we do this we need to do something to forbid setting
the pmu property to true on CPUs which don't have it. That is:

 * for CPUs which do have a PMU, we should default to present, and
   allow the user to turn it on and off with pmu=on/off
 * for CPUs which do not have a PMU, we should not let the user
   turn it on and off (either by not providing the property, or
   else by making the property-set method raise an error, or by
   having realize detect the discrepancy and raise an error)

thanks
-- PMM

