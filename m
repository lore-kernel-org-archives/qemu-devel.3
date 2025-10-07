Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006FCCCA471
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 02:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5xWG-0004jb-HR; Mon, 06 Oct 2025 22:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5xWE-0004jI-RD
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 22:33:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5xWC-0001KE-Mi
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 22:33:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2640620f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759804415; x=1760409215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jh1aLwphx6jivSdeIL6mI+co6kO5RcW7/REbFfuc41I=;
 b=LUwga6my547EaSBjoHEqQBtWih4WztwTCnV6VNoHXMS7hCj5/ruMErCYK104VfhflM
 AIFd/mCQGXWuWh/YyTjIxi8AmZk7GE9Ta5wf8xDSow4uLVavO9EGgVDbVeVf7aL7I03D
 OJlRGlXs9WhcQ3yRd11xripV86GMax2+70B6xbKA+JMN9VbMr4XiarG/tukKrWycRlSs
 V340gDFktIdZnmzQcSPnOvRlt+NH9+YSaVBflRvi2TBQHL4QW46hyZGs1usNM6QKvHG3
 i0kieBlIqt5twSUV/JZKPaWG6aqRYCLUGg/ImADNO9ih6sJjZeCR4gwmnj8c7F7DX279
 L0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759804415; x=1760409215;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jh1aLwphx6jivSdeIL6mI+co6kO5RcW7/REbFfuc41I=;
 b=fZ6za/oMI5vYLQdDFwwgFApJc8Y3nf3n37I7VKDvMBPJpbGu7mPySklICOHhGoC4mH
 YT6uA6rXdamBu63XO3nhx2bkeoLwm2gEUVWiiVycgUOPno6EIE4hCavhntQMcXzqu+VR
 sCZGnhWWjWo/X4LY5uz9AcIlLPcf4vEZN8mx5jFG5dpNfp2/lrQAjlLXXVugeoW/GUbE
 3omaOs9uaFwGzoVketY/amnFeOnLGw3/4/DO/ugdR0JlIyNCJyk/YUgRoHR552MFy0KQ
 weMs2zT/OMCoPpVtWuP3BhBaaI0DmN+RrO+Po5t6xg8yINj0oc/MICpcvk3X5D3i5zU6
 7pxg==
X-Gm-Message-State: AOJu0Yz3XIqgSJ0lypfY04mB1b+c7sVjTHjr6ZOvFL0/WtPkzpGRqWQ+
 IPSUG6k5r72PQiDkDSOp93Hjk7n47pbolf11naR3WuHNiMK2MWUQib2mWXVhj1A+BLs=
X-Gm-Gg: ASbGncu/6m4YhWyYkYtMrH+uXKi46b3ZAPX+kljDjoZf9mN3rtRsyDuV38uB00OFqGq
 xVB6unRwBbt+IwT1HedPKe7mOyTrT1Img4LdckzbpXaFsk64LcbaC0hKZLIPgdCrHbUyuGGlvge
 wrKww3zN/FMATYVy7+nZfv3zaXS0+8CPCoUmVK6tTnmcmih7u7xN79zDgwv3SpHZ12Y+L9/wSpk
 6wkoMb1URcCpfLDSpE7ffngZFXmS8klSYLCRK47fh+P4nw69vJgCcpUO2mTMXfSR1xaI3CuD5FI
 ak7ZWy1735SBUOc1QV7AjhDkeVeZPGZPVDOEodCqX3dl7h34bhHVwEFeqBaMd71M7At1VPBAWUp
 lLZgvXWNoxnRWcAR2xGAMBpjvziK7GvgleCybBnV/uJEBlwk2rcuDFVnOq1uLBF1eYQt/DYnTL3
 mPRleZGRxYqA7FnE6VuQ==
X-Google-Smtp-Source: AGHT+IEmIN4iB81/njLnHYXR38P2vTlcg8ZacIAU+9gIqFP9AEo7YkigYfetOrHKpl31px+Om9ETFQ==
X-Received: by 2002:a05:6000:2401:b0:3e5:394d:10bb with SMTP id
 ffacd0b85a97d-4256719eb33mr8102832f8f.41.1759804414705; 
 Mon, 06 Oct 2025 19:33:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm23303259f8f.6.2025.10.06.19.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 19:33:33 -0700 (PDT)
Message-ID: <662fc857-9453-4caf-ad4e-1ac3d68d8e5b@linaro.org>
Date: Tue, 7 Oct 2025 04:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/36] MAX78000: Add MAX78000FTHR Machine
To: Jackson Donaldson <jcksn@duck.com>,
 Jackson Donaldson <jackson88044@gmail.com>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
 <20250711133429.1423030-2-peter.maydell@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711133429.1423030-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

Hi,

On 11/7/25 15:33, Peter Maydell wrote:
> From: Jackson Donaldson <jackson88044@gmail.com>
> 
> This patch adds support for the MAX78000FTHR machine.
> 
> The MAX78000FTHR contains a MAX78000 and a RISC-V core. This patch
> implements only the MAX78000, which is Cortex-M4 based.
> Details can be found at:
> https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf
> 
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>

The author email doesn't match the S-o-b line, so I'm Cc'ing both
addresses.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20250704223239.248781-2-jcksn@duck.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/max78000_soc.h |  35 +++++++
>   hw/arm/max78000_soc.c         | 172 ++++++++++++++++++++++++++++++++++
>   hw/arm/max78000fthr.c         |  50 ++++++++++
>   hw/arm/Kconfig                |  10 ++
>   hw/arm/meson.build            |   2 +
>   5 files changed, 269 insertions(+)
>   create mode 100644 include/hw/arm/max78000_soc.h
>   create mode 100644 hw/arm/max78000_soc.c
>   create mode 100644 hw/arm/max78000fthr.c
Could we have an entry in the MAINTAINERS file covering this board please?
Thanks,

Phil.

