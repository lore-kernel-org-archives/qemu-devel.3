Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F16C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigMz-0004I5-Bs; Wed, 21 Jan 2026 17:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigMx-000492-FQ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:08:07 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigMv-0006Zg-Ro
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:08:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso2520995e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769033284; x=1769638084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SIv4bp2wpMQDtsKgbBBkxlY2hyeheUNAlo9AdrfHiv8=;
 b=KeanbtG5PTAmOJ6N03EKHNkVgm3/76xYMra4MX+3vLcQsu125gcqqjTjRp4NXPeqjW
 H6LVyBJJJFfcbi0rsNL8aq6zkjYYNpVKYCE/m4AWj59OF4PRzjRwf3xkxQY0C3RmdugL
 tuGbM8ouopxkJsLmA1jTZInDJc0D13lNI859n7B1OwDJaVz2pkbmvm0gtPXZxO64ykeP
 ZikGhx24iaeR4TvCHvWWOjjKbzzAAdSz9ZIXzHK/UYa5MM6GxNlnNEaMsDM0mhZQARmy
 B1ayqH8sk0SWXrkLZMlpOPUxqRVrFFOPQ4iV7hn5wozsDYxZ1dTHDZuAg/P+S3s9Kgdn
 nUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769033284; x=1769638084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SIv4bp2wpMQDtsKgbBBkxlY2hyeheUNAlo9AdrfHiv8=;
 b=NEazcAiMvip31hyIMl8jruIOs2/dTdhzea4p4HoEJZ1L7XicveD6Wus4kV4mNTvwKc
 3I9v2yE+tUmT/pMnzpbqdaJwdp82UhswdN/4BWXKJDWINP1tGxrIoDhgYPh+Ekc4WFOa
 k7aBot7S5fiys8hjriFQf+PKR7OkjUvQ5kyhp1z8h/xFkxBWPZxPyPG0PoIlzea+EN9h
 HvliQRmdYYesb1rVxb5vqR6mJg/IO1kPprbh5zS4sBU2Xf3c7IpVOgbNs0y/3DlVDNsj
 juC6hNNWbHkqscANDt7m6NHcTbTDStvGJfhSUBIk4QbpQ5L27tsYOlJZwM9q3eWe4ydy
 Jc7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeK78s3Af+v3ASFYiivVr9LkSwePpp94DBvQ+oG35cB5CILfaJOQVKxuIfutyHfe8/Y/gLNJTvznMZ@nongnu.org
X-Gm-Message-State: AOJu0YztXsgE0Tg+2rHUyEPqESWWhGWbAy7Qr77vrAOqWi9E/826Z4Mu
 VqI7xUS48s14TO4utVqWhlc9ntyA+DS65kCJctngtmeGcuNbQL+B6vLx8EPMuHDCGws=
X-Gm-Gg: AZuq6aIAPHOvDXidJ+yTzUWDM0+SPeJYRxx2okIWfkZ7fLgXTtorvN726SUwJnUYn6a
 YjpYVccW+Ih85zdZ8CbYDCXEya828TyzdlBRoRqvutuyYkmrz4fBc/k/3Z2FwmBW+B4BCpkMZpg
 bgeIm0jQaNY4xUFVKMJ0FbK+bih/1c43UjxGqN72gfXdOYs6PamZouZ1nc7mSE2lW1pdLBw4+cy
 zVpW5b0IAs4j86w2JZulSxOAbsJPkgkmuaENcnV1i2zcZnI1Q6eWoLLBQGZ+IWvQ2SpqNBtQ+x+
 PuY1iRHfvHoyeYUd2RnZeMCycrz9hLV1+8RdNzGQIZjxv/OCWH9V7IzsAbZxGWStlLL2mDuP1t0
 d1rQtK1/BP7VuCkooQSbYuS8FJ1RdZDEW/urkMxeyEaWIv+PJq+owRaD2RrXSjO5IvEqGMZYyew
 jcAQWIp1QQPfSxQrGcB5Lik6jyCseZlYxHpT3AoboRnEiicHbP8mKVNq0+v8JPTwTJ
X-Received: by 2002:a05:600c:4e93:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-4801e30a606mr270732135e9.1.1769033284372; 
 Wed, 21 Jan 2026 14:08:04 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1011esm32775695e9.6.2026.01.21.14.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 14:08:03 -0800 (PST)
Message-ID: <d00bd9f4-efb6-4fe4-a562-11baae6cfbc0@linaro.org>
Date: Wed, 21 Jan 2026 23:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/intc: declare GICv3 regions as little endian
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260121105932.135676-1-alex.bennee@linaro.org>
 <20260121105932.135676-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260121105932.135676-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/1/26 11:59, Alex Bennée wrote:
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This should have no functional effect as the GIC
> cannot be instantiated on a BE system but will help the single binary
> efforts.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/intc/arm_gicv3.c            | 4 ++--
>   hw/intc/arm_gicv3_its.c        | 4 ++--
>   hw/intc/arm_gicv3_its_common.c | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

