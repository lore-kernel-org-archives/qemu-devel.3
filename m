Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B547CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLN9-0001oX-Cg; Fri, 08 May 2026 09:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLLN1-0001nS-Kp
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:35:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLLN0-0006Ym-04
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:35:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso1531762f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778247355; x=1778852155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uaPAJWNOba7k7wzsMIlyJdSxA3zB9u+1R8heCdLP2p4=;
 b=RYvTpjCOhIAIj/imR/7hSq3467I8TXhnk0AOxT4NunH23wy21lE2xrHpZn1Rd4tmIM
 OZju0b6Fly+Ad1zaya71uRFWd5rq0NovxkH6WHwXrXrfzleuOZ3DodnG2JSxAdN8/J1q
 XNbQ8pRP3ZDNvfsKQS87F9g6ZEybQ0z0NW7ydjVcb0sx5VeTbYKdihkS92gy3JmNoaXl
 PkiEl6We/J3fahW3x57z0ZCyA3p1VH4WpOHuOPp7jfeNSBWbLdr1ymss088tgiGKk/wJ
 nlR4i9Ued2JwUpiD/FUn5sTKWJxRpmeE+uRRuDNWqwgXJ2bDDPiM8pffYVGVCwYOlM8k
 HNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778247355; x=1778852155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uaPAJWNOba7k7wzsMIlyJdSxA3zB9u+1R8heCdLP2p4=;
 b=OOM0+qTFaXnVDTWebXcv0VMz1WbYpTi22v+oyS6hyPZJCH4ZCLniaA3bW0wqhhImnT
 fET8g8dGcKuBxSO3fZmtua6hSawPZfmwJs1xENZNc0aHI+tvWwRO4ds7UHxJa0H1vfx4
 CyxAfyAx/mLxGuoncK5XWhM7WeG3h6IVbNOmG+G2REKmHRzAttdf0RoywmTQM5wRrG9N
 rLUNIdaydbETL/egbX0iuHhdZ4VimitCmcauszM2psR1nOSoDmJtQTiy3gFWapqVvVI0
 DWOYvUp5m9VKvEyV9Ee9oVMdAkD/V4ovS5Sz/H2Cz1SGuHQN76YFsAChvxKeGzRCMP/X
 vihQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sVV4R58+jFCi+ai5pmqsZO3zW3fn7UxLIKlMCPQ5scL4a3hKsy7H9BeKDHWehNOYUq22KpBZXhN0R@nongnu.org
X-Gm-Message-State: AOJu0YwH2ngyM9XPw4sXS62JBdKqLkLHr1Xje5yteSEEMup42KY6ZPHJ
 2ZKROI2EQI3JWZ/HEN+2kyKrxje8yvVtMhMOtSLpqoCtods32Lx0r2TiJeQIWA9MCyE=
X-Gm-Gg: Acq92OFJseF04Tml44PeZ5/CPbC7mqRe88b8+kEAzkH65azCyuMCn2ttZzpv0HbQfgC
 HKAp2zKgCiciULg5aFz0dO/SKMxZdDMuwQdG979JQM3waMYwNSGgpRypWeHrn4uazPYdE9F4TXL
 e+HIJgvG4Cd4L09zJaGkGh8xjj4CfFTNJOGNsVMxKe7erM6YPOiOPBkaz6yg/7Yx6B6IFbV/XVP
 wlfIVTAlbTqcj11+ea8a3vjEeHtg/gJy8yxfP06YQR6+Tpm5D46w+sYt1YKJaMiC4JZAbYzZk08
 UKBPOgVFnNRbapNbqLyLdGknzjSR3DJOvbUSV1RuVgkPLR2HrT5ZABe9aNwQfAsdccjHIQOpBw2
 smzZXkO++ThQLejYCeCqXMQnaWM6SLFcF7I/eTVGFJ+b2p9zybX7mWpINQPaayjOtTaw3dDKnxP
 y98maQ7xhlvHieQAfmFTkh8mMsulrGUqUm0/RT+M8hmi9+79NqbD7F2iLRZWEQH8F9fQ==
X-Received: by 2002:a05:6000:1789:b0:43c:f66e:f24 with SMTP id
 ffacd0b85a97d-4515da95ffbmr20566082f8f.35.1778247355454; 
 Fri, 08 May 2026 06:35:55 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm3950042f8f.1.2026.05.08.06.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 06:35:54 -0700 (PDT)
Message-ID: <17295abb-58c4-44de-bac3-d67b995ff793@linaro.org>
Date: Fri, 8 May 2026 15:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] hw/usb/ehci: Improve migration helper and property
 naming
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/5/26 05:26, Jamin Lin wrote:
> This patch series is based on the following patch series:
> 
> https://patchwork.kernel.org/project/qemu-devel/list/?series=1089061
> 
> hw/usb/ehci: Add 64-bit descriptor addressing support
> 
> The above patch series has already been applied to the aspeed-next
> branch of:
> https://github.com/legoater/qemu
> 
> This series only contains naming and comment improvements based on
> reviewer suggestions.
> 
> This patch series depends on the aspeed-next branch of:
> https://github.com/legoater/qemu

Since this isnt' it /master, it makes me wonder why not squash directly.

> 
> v1:
>   1. Rename migration compatibility fetch address fields
>   2. Rename CTRLDSSEGMENT default property
> 
> Jamin Lin (2):
>    hw/usb/hcd-ehci: Rename migration compatibility fetch address fields
>    hw/usb/hcd-ehci: Rename CTRLDSSEGMENT default property
> 
>   hw/usb/hcd-ehci.h       | 23 +++++++++++++++++------
>   hw/arm/aspeed_ast27x0.c |  2 +-
>   hw/usb/hcd-ehci.c       | 14 +++++++-------
>   3 files changed, 25 insertions(+), 14 deletions(-)
> 


