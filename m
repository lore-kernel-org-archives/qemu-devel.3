Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5F9CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMhw-0001jt-3G; Mon, 01 Apr 2024 14:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrMhv-0001jl-8W
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:48:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrMht-0006lp-MP
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:48:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e267238375so584155ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711997312; x=1712602112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shIDPPaJnogHdZ8Y23mf1STXk2VCXGjne5qhmlXalPs=;
 b=fmEz9cGqFmB7LCHqOu5YzCS1B0/7Zl1SOsO5nQSavjN6i2h/NARIbQglh8goiFHo6H
 ILdzTcS12WVc0gNa4Dv62Al7my2h3T7Y4J2McG6FgbJjaHo+yc/EomFAXHZ4kfHTu45K
 cb+E3TSWxM9iJIYbFelloofrv7wqq1eoVivn+vmaW3bSqIZXHazreKT2xWi2fUjYDL3R
 B1NjzXqfV65iOWdIOjab4yL/yFW7gfRWzHEY9CR2Lwtm0utw4je42IGos7QrNPQ5108u
 itLXl2r9Mg1IB4L5JO3ZxGn6g+5HqN3/k8jWN9MCnKKvwtcxdprXNqMESHYv/lYV0m5W
 5Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711997312; x=1712602112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shIDPPaJnogHdZ8Y23mf1STXk2VCXGjne5qhmlXalPs=;
 b=uKke2Iu38ur7aDzVAKAPWCF1coH3Vq/Uz3Mr54k9BKAduV1Rm1m7gGtacA7Hkv+Mhy
 SA4bkMcuut4WD8RuUTIu6UsVRX6uPaVLygtGrtlWWQsxxChZ/UKs27SQ4rcIlOmV4MjX
 Gk02obc2zPHN1pZfdw9jdG2cxzCa1UBpePp0Jty20VE3Ulq8bgI7sooVgOwIiGPqM9K8
 L4a+54ijhDwUKsD4TnLq/GYELGUx/A+DLJv+XRI6tEXWTwGMzErB6zD6incOnVO006yp
 CUyUQke9eA8KKHnIIsY5QORW4JSBI26vF9wDIHRGekvhiZu9sDyegGR2Us/C4KJi0x6X
 czhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnEUeWYwluvZc5SaFIlHtAQAv79JBBWa3VIsQkYNVgNZrkpIZGs1I9Gmimvz3oXMQPM3592P+MB40HPdenmFhYE5748/I=
X-Gm-Message-State: AOJu0YzYIyw+mCejCV3u28QsPPe+ozN7/qXnh6JWbsDaMCZpYvICDGba
 6TIY274xLejL7ZKaqvcaOMFmJ2AP6zl70tfu6z8ivfm/pogMKeaBWDNVrcLR049XXb2sYJwd17A
 F
X-Google-Smtp-Source: AGHT+IEoliH3byKWtBB7dC4w/zQCBHDuGjxRFTRAR8s0+jyS7B4LBgWgl90GTBsE7Qxha5AsRSWjuw==
X-Received: by 2002:a17:902:cec7:b0:1e2:58f:7ed4 with SMTP id
 d7-20020a170902cec700b001e2058f7ed4mr16938644plg.5.1711997312216; 
 Mon, 01 Apr 2024 11:48:32 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902e80d00b001e211a291d6sm9308663plg.260.2024.04.01.11.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Apr 2024 11:48:31 -0700 (PDT)
Message-ID: <47998747-e990-4c4e-be4e-d0d38b43e9d8@linaro.org>
Date: Mon, 1 Apr 2024 08:48:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
To: Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
 <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/1/24 08:08, Liviu Ionescu wrote:
> same behaviour for 8.2.2; same workaround.
> 
>> On 2 Sep 2023, at 21:11, Liviu Ionescu <ilg@livius.net> wrote:
>>
>> When trying to build 8.1.0 on an Ubuntu 18.04 aarch64, I get the above error.

You were told back in September that Ubuntu 18.04 is no longer supported.
The passage of 6 months has not changed that.


r~

