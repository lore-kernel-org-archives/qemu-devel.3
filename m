Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AB9C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJC1-0000Es-9e; Fri, 12 Jul 2024 12:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJBx-0008US-5y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:32:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJBv-0002nX-8n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:32:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42795086628so14666445e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801933; x=1721406733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eE/q1N+8qvVh72cX8o24mKis3t9CAY0ic804Ljq/N6M=;
 b=MM3buJKl4BAtKs3HDLyS0xqXntBPIEyAJfRezYS33g3tQ2Mi4cVepML3hxro8+6xky
 oK37iY9hXhRY0/bhtAkBxTW2CQ0JPfnP6XooRE7EP7SP6WTH3sdSnPwRAnb3K2jUyIi1
 cOuTiBVuje2HBw/pYdg8RTtR1CnxOOfpDJdBDANvbDKHRrIjDBWxLtPUhcUb4xeW8Ytb
 5cTW1iIi3TsUQHKwn1784iNhDK15zesByRCIxA2KwxrRh+MpIt2zsK7y4ArDvgH4LIe6
 wkZ7oqNTGIXx3b32z2rEwCP9P0XUbZKxSbznNUXsNXBaUrAO9V2s/FQJdZWv46nXijyb
 ixDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801933; x=1721406733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eE/q1N+8qvVh72cX8o24mKis3t9CAY0ic804Ljq/N6M=;
 b=lbZhCosyr3OvkRG00yS4Mkeq5PkaYAo4GCNgu8ryZxPS5To8xXSZdc46GBbTtfkMSF
 rMJ7Ma2G7AsZJVBq6RoVK85+jiMKWdb480oVDF8WC78NsPXl3CbgQUeElxctczgN/eSU
 /q5/rplwlsJro6jGvxvQt3Jw2xCobAAZqmFgg9QTrP70REQIq2gzJDyQ2UEWSv888O6b
 SihyFVzueis8SkHmaH0+hyTQctp0T349s4ENb5cM7bM1Q/QY7LVV0NbPhu5lQejDEnHh
 4DYUk17HajnRPEO62E7mnw3ipG031Vthd4++NRo6/sbK7lNe5yHGXc1w9VjmQtigmbPx
 u+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5w8wcRXHAUHR2d3BSwB6UZhei8Z6IPtlGdcYz2zAf6J1icAO0usNP/qzUu1q3BaD/iktgXGV+NkG+LClmplxtzAe7tsw=
X-Gm-Message-State: AOJu0YwvPIbZ0qskbyLIFOUsUNzti2sOVpt/6ItZ3rbalAUa+QMlYdsj
 K2UD1J/Y2MpxDdjfd85aq/xihrs6NF7d15T37CghrZPs8ShXPE9ao59nk1+rihM=
X-Google-Smtp-Source: AGHT+IF3N0JPt1h9OZE1DQioTI3Gq9+pKTwQ1oHd99jhPc6imtGKcb6OADBjVO3Snkuh7/ACST6mHw==
X-Received: by 2002:a05:600c:358f:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-4268ef4a0b6mr67256475e9.20.1720801933427; 
 Fri, 12 Jul 2024 09:32:13 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2c1e07sm27893795e9.45.2024.07.12.09.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 09:32:12 -0700 (PDT)
Message-ID: <939a96a0-c49a-42b8-a050-fec93ee934f4@linaro.org>
Date: Fri, 12 Jul 2024 18:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/qdev-core.h: Correct and clarify gpio doc
 comments
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
References: <20240708153312.3109380-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240708153312.3109380-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 8/7/24 17:33, Peter Maydell wrote:
> The doc comments for the functions for named GPIO inputs and
> outputs had a couple of problems:
>   * some copy-and-paste errors meant the qdev_connect_gpio_out_named()
>     doc comment had references to input GPIOs that should be to
>     output GPIOs
>   * it wasn't very clear that named GPIOs are arrays and so the
>     connect functions specify a single GPIO line by giving both
>     the name of the array and the index within that array
> 
> Fix the copy-and-paste errors and slightly expand the text
> to say that functions are connecting one line in a named GPIO
> array, not a single named GPIO line.
> 
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Does this help? I wrote the text and know what the functions do
> to start with so it's a bit tricky for me to see where the docs
> don't state things as clearly as they ought to do...
> ---
>   include/hw/qdev-core.h | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)


> - * This function connects an anonymous output GPIO line on a device
> - * up to an arbitrary qemu_irq, so that when the device asserts that
> - * output GPIO line, the qemu_irq's callback is invoked.
> + * This function connects a single GPIO output in a named array of output
> + * GPIO lines on a device up to an arbitrary qemu_irq, so that when the
> + * device asserts that output GPIO line, the qemu_irq's callback is invoked.
>    * The @name string must correspond to an output GPIO array which exists on
>    * the device, and the index @n of the GPIO line must be valid (i.e.
> - * be at least 0 and less than the total number of input GPIOs in that
> + * be at least 0 and less than the total number of output GPIOs in that

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks!

