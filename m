Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9371AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXfm-0005y3-4p; Thu, 18 Apr 2024 15:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXfg-0005x5-VZ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:43:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXff-0001yJ-F0
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:43:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4187c47405aso8839625e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713469426; x=1714074226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=34NdJVNM/f8cFi+3ftlJpve1D+ocrwlonR8qBi3+aEE=;
 b=SvdoK6F/37cxZUijS8O6FIlyamITRVLeCAm6aNq0p3YuBw75mYg8Qyj+ankVbzJHd3
 5nsI/fxGLEOkd+JqepuZBL4WJHnhC/fa1N+Ww4+R1EfPekc9jBDUmEiKe3IvbdfHmiss
 ypHmOU6AoCQqc/i4CmdcUoIOlTfi9lTMzXQfBj9YtpqAiQm0ns9KmrwyiQnJC0PiNe7M
 3NS8pVskCU3Jg948NoNgJ6uFjEmMVy3yHusDDcv0y1O0IMb/P8kZkfGZ/3Kg/5htjO2b
 0AnLcOFxj0GgdDwrefMhglM0cagHURO9dNg6+N1IzEiK9aBf5y1F3blWo72JYKIC6XgV
 hsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713469426; x=1714074226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=34NdJVNM/f8cFi+3ftlJpve1D+ocrwlonR8qBi3+aEE=;
 b=YAIDIexOrd8sxZrY0pN7fZWtD7Aos0UVV7Wr8KknSQAqXQH1CTSazqrlHPApL6wD9g
 puYixIbkieGC+NpBFhpNMeAhrOymkU2OLKSVC91UPaiqPFD/umFstda5YpmtlAucLzNS
 FZuNlhMVL6FgId0QoWj9eSGeeN6ZxRg5NLRJ/3o3MrnqEH3mv2JPBhLSVH1nXOscxrJF
 s1A8Zv/RevG+c0JVRlE9Bpd0m3pA7JX4eiwR8cdwWGnf/WUX4zuVdQHUXNSQypM3/n8R
 lND24P12jNPw/MspKPCCojpSC3Zo2lNBlVp9NL452FjgaHmkMsZPiSph2XlEnhTOb/j8
 xHuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaIPoeJ+z+Gzic1+TEZ8yKknH3IQu2Yi3ZZ1O665KRc+F+6+bBmVwXK1hMBBH6XyXc6ozRIPvJCIVdJRiJTVuZ6mfW3M8=
X-Gm-Message-State: AOJu0YwOaJTyFCK+dOFjkB/zfb6pyCibJgyC+NV1KR2SXAw8Sf4BRJ5k
 vC7wilfKvrmK12PZ5amuMTW01Uq0EWybBYWMKuezebnGoa/1QCb0/O2u6sWv/UvR/h9uwnpz6Wr
 r
X-Google-Smtp-Source: AGHT+IEwO9OKdnWnKyCjelhz1DXdcdvO+0b2VHDYVFeRLnzr0dDD7u7c9chnLdfPVtpifCTFppNN9A==
X-Received: by 2002:a05:600c:c0b:b0:416:c1c6:c7e with SMTP id
 fm11-20020a05600c0c0b00b00416c1c60c7emr2731721wmb.41.1713469425821; 
 Thu, 18 Apr 2024 12:43:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c190d00b00418a386c17bsm7564416wmq.12.2024.04.18.12.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 12:43:44 -0700 (PDT)
Message-ID: <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
Date: Thu, 18 Apr 2024 21:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: Raphael Poggi <raphael.poggi@lynxleap.co.uk>, qemu-devel@nongnu.org
Cc: luc@lmichel.fr, damien.hedde@dahe.fr,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Raphael,

On 18/4/24 21:16, Raphael Poggi wrote:
> When dealing with few clocks depending with each others, sometimes
> we might only want to update the multiplier/diviser on a specific clock
> (cf clockB in drawing below) and call "clock_propagate(clockA)" to
> update the childs period according to the potential new multiplier/diviser values.
> 
> +--------+     +--------+      +--------+
> | clockA | --> | clockB |  --> | clockC |
> +--------+     +--------+      +--------+
> 
> The actual code would not allow that because, since we cannot call
> "clock_propagate" directly on a child, it would exit on the
> first child has the period has not changed for clockB, only clockC is

Typo "as the period has not changed"?

Why can't you call clock_propagate() on a child?

> impacted in our example.
> 
> Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
> ---
>   hw/core/clock.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> index a19c7db7df..85421f8b55 100644
> --- a/hw/core/clock.c
> +++ b/hw/core/clock.c
> @@ -101,8 +101,9 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
>               if (call_callbacks) {
>                   clock_call_callback(child, ClockUpdate);
>               }
> -            clock_propagate_period(child, call_callbacks);
>           }
> +
> +        clock_propagate_period(child, call_callbacks);
>       }
>   }
>   


