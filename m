Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A55C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9px-0005jl-6a; Wed, 14 Feb 2024 02:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ra9pv-0005jS-8o
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:37:43 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ra9pt-0006RH-Hy
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:37:43 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso6676543a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707896259; x=1708501059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNNk1WpHEZtIFiIVRsIe+/+qoaz0uoLcc5dRK+maGMY=;
 b=YjIBWPLvRrN19JQAcaApqNGdF4Z3C3RM5E8pd8dGpVktvJ6XLU9cWA8VQ9tf/5GsZS
 Z6RSKrcLxvR3px5LImM2xf+GsciKhM6FpkOQn335xwO1fE2rAVxVA51pwLnOswS/sMIq
 +n4yj7UF2C2Xektz+YRjJJ1E8Xqdm5eE8jiFImZ0kiUatMVZhxqjv3UY5+tCI83rx42H
 ieMSICCxziPgP0SDOhI+yXG7i0/hQFcQy7y0xhOHeQmQ+Uj85jqVRxt/jTqrzE2IxQBG
 H8ImznmZiYSYBYs3+ay0ZWYDGv+rLHEomoPlZThAtO0pvNMKjJd+qSCz66l2hkT18GWq
 diKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707896259; x=1708501059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNNk1WpHEZtIFiIVRsIe+/+qoaz0uoLcc5dRK+maGMY=;
 b=CqJCdWvATjQChVOgXwW1wA/+BWOxU//FDtqr1YauardXOP3EmZv6EdylAF82nE3JIZ
 hAwxix0BaZuR1GDkqnVfPOq9w2ktOPB7h3x7az7khj1LzcsMq4pdil6Ls5/dcaxVhnNl
 6Eqw4zcEsRNOp5bj4/M+JGs1Ojt/bRAj8kJnw0qpwD1FEfbeIBFsSidtaKtjaxai4Px5
 6mm7p85WdXNRDFtSMq7qwOoLqSmu2JSfU2t9rSpU0nuVzdsp/fniTki7oqXoc93LNzBZ
 Bd0mjP56tDXsrrhQT6EE4iBgVGZsOfC0vZT/K2vI/9jg7yUl27AI4VAwqO6brkBwx/n2
 m3IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPCU+4P/y1mSieaay0YJZnTq8e42onvK+RoXGfZVqbULOMujSX9ctpLKl+8M5bWEgaajE/w/DnlFCj94/l+h+xv+r0krI=
X-Gm-Message-State: AOJu0YxsGnmB8ZvgO6+5o0Dd2KeKh2SuqfRqCDwgULhwj2DahSSgXPew
 9W/+YaUL8rWfnhVZA7pxzeYT2HpF4H8BL+OMPXout6kWiIsaqbrhNogkrtStjKg=
X-Google-Smtp-Source: AGHT+IFfs9eAISD5ieg/FtrmXnFWSQ1UBt94JjmimDMgoiKeLV6J75Fy+rHRo3mUFiRXcjOpt8/3Ng==
X-Received: by 2002:a05:6402:88c:b0:560:d9d5:7b0f with SMTP id
 e12-20020a056402088c00b00560d9d57b0fmr1323485edy.22.1707896259633; 
 Tue, 13 Feb 2024 23:37:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXlM5GhXFJOcu4Vk/Hd8Bn35JYR7un3bpLjZSnskAX43a97OfKrtF92xmDfcG+O1YmaDIaxQgCTMMNLIdgzN9g96M+HfdwvKx1ilWflAcnoR2+K+t7oSeEmWpzC6pcO/MBLLpMCyrJQfpCSGDeS0/vZ41GTJ4se8PI=
Received: from [192.168.69.100] (mau49-h01-176-184-41-88.dsl.sta.abo.bbox.fr.
 [176.184.41.88]) by smtp.gmail.com with ESMTPSA id
 en14-20020a056402528e00b0055fef53460bsm4438414edb.0.2024.02.13.23.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 23:37:39 -0800 (PST)
Message-ID: <1003f634-f13d-4a9e-af7a-34edc26e22a4@linaro.org>
Date: Wed, 14 Feb 2024 08:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Guenter Roeck <linux@roeck-us.net>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 12/2/24 13:32, Peter Maydell wrote:

> So I would like to explore whether we can deprecate-and-drop
> some or all of them. This would let us delete the code entirely
> rather than spending a long time trying to bring it up to scratch
> for a probably very small to nonexistent userbase. The aim of this
> email is to see if anybody is still using any of these and would be
> upset if they went away. Reports of "I tried to use this machine
> type and it's just broken" are also interesting as they would
> strongly suggest that the machine has no real users and can be
> removed.
> 
> The machines I have in mind are:
> 
> PXA2xx machines:

> connex               Gumstix Connex (PXA255)
> verdex               Gumstix Verdex Pro XL6P COMs (PXA270)

I can still run U-boot on these, but Gumstix webs are
slowly disappearing with the prebuilt images there were
sharing. Their wiki is also dead. I'm happy to use a stable
release for my pflash experiments.

> OMAP2 machines:
> 
> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)

For me these are broken since 2020 (commit 7998beb9c2 "arm/nseries:
use memdev for RAM"), this was discussed in
https://lore.kernel.org/qemu-devel/f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org/
but there was no clear consensus so I gave up testing them.

