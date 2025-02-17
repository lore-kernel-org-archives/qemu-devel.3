Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC9DC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5f3-0007ZW-Gp; Mon, 17 Feb 2025 13:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5ex-0007Yy-Qk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:16:00 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5es-0006qT-LD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:15:56 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2bcceee7b40so665261fac.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739816151; x=1740420951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5Un0T/zEiFdIeFsrjeVvWkExkzImpvTYSRLVRI62W0=;
 b=OXRBdpCJcBTz9DslEHV1nq5dTghg0DYyG+0Jg0Poi4hV5RpmtRJOzFws/x5Tgt7JdC
 UFQWrReFnFp+yri+1DzhyzMSpEHJzctPuVhHMke5o1tx4h2oQtnitJQYPDEJLYXrrd5u
 FgXUzPEFrK1qqXjOG0mtjAswkMG6UBTPg2Kq1S/kXcaAO5sc2SN2UkZGzUcuHWCIZYS1
 3AKIWfyTrp/817pMt65ROmmEGjB78P50pLJi8PttoSKJAjlusE6b+oFf3nhaFZNTY/jU
 FhRRFpqlyzMYBReCODufvGuLwfU0lmSpw2O3qOU3oyi1LBZSFw+kmCnbKmb5WQc9F35A
 UqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739816151; x=1740420951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5Un0T/zEiFdIeFsrjeVvWkExkzImpvTYSRLVRI62W0=;
 b=BSbeEGKj1VDvM8Guf16U2+zNYD6+kpNjnQuQ4Jvn/7CgiixFEJ/S76IU9dj5ELaimK
 fPiUcPw+QBrcrpCCcmKtRZsKOdf98Fubwp8vqfa2CRaA7uT4mTfyjjlHY239LhqgwvRm
 zi1FR6HXT9jaoW/4LAahFzya3hNciFAEM6P5HGFuxj7gbsLHSlXTvpMxxCs+RMefcbn8
 YaC33rSxZrsstMyZwGdFfNb6H6qw7aS63HYhdvgZ30MmosPIFkezTd1X/+0thwzMUkXV
 yBAKO0FqhnkhEnv+pUaTZWGykUROXlnxb4mntCLNKxwLFRytKViohk5vqo1HAkkgD9np
 ieXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUncJVOsJpl3Z36lSZ05pshjVuwArgjotLafmE+gEPD7BHuWjtSOEaYG5KgbbK25mOI7tVML+qZWi9d@nongnu.org
X-Gm-Message-State: AOJu0YwE3rjixbZqCMny9ZLEhpIkurhskWA+eaG6AfS0T8TG2i9D9F4D
 8PcBdWMokyP3RMu+f0UKdN6uOgE5C+HK/FQIgYWTlQaymGVKmk8DORcwXvuCAlvm9Lp+HRQe2Uj
 Y
X-Gm-Gg: ASbGncsYAiFr8xT1/EceqshMjPgDkgj23VdHaQxiidUIhgx//6SJb3Dxr1TA/fBNiuo
 AYHRPgOJ2GW4b77GGXm7qaWiuBow1sN2VcvgtglEtfr+pk3vMsMZeoEZLMz7aqnXNW2Y+ZvSnW8
 Z2/TolX+Cwm5G5bJGk7/cE0y0ob3So03fG3g3HjafdBxmt6DaIJaQ2dusMUSBk047WT0uBkCCK3
 pgEo1Ma50IAzEa2gE8WNma8iDXr8wSXV9Ts4z75JGsH1rSyT0tXIhgAiXU2AKPX7s5hd/wQXApG
 cVVy6fdHVx5mJspfje8oDA68BX/kY0K/vIA5duTDNP4iZmWGefUyuQg=
X-Google-Smtp-Source: AGHT+IHTDMIDVqvM4meGRGqfOGj0KAsa4akeAVOBYrl4fOELwz7P1MNbIi2xdM20w2ubLMl6U8dg3w==
X-Received: by 2002:a17:90b:39cc:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2fc410429aamr16083307a91.28.1739815812859; 
 Mon, 17 Feb 2025 10:10:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d537d0f2sm74762485ad.105.2025.02.17.10.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:10:12 -0800 (PST)
Message-ID: <a1b54d6d-7aaa-4306-94d5-ad45e6a66258@linaro.org>
Date: Mon, 17 Feb 2025 10:10:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/m68k: Avoid using floatx80_infinity global
 const
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> The global const floatx80_infinity is (unlike all the other
> float*_infinity values) target-specific, because whether the explicit
> Integer bit is set or not varies between m68k and i386.  We want to
> be able to compile softfloat once for multiple targets, so we can't
> continue to use a single global whose value needs to be different
> between targets.
> 
> Replace the direct uses of floatx80_infinity in target/m68k with
> calls to the new floatx80_default_inf() function.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/m68k/softfloat.c | 47 ++++++++++++++---------------------------
>   1 file changed, 16 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

