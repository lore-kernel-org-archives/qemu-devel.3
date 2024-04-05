Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41307C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssIm-0006Zf-H1; Fri, 05 Apr 2024 18:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssIl-0006Z4-Em
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:44:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssIj-0003GA-TF
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:44:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so2865806a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712357088; x=1712961888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N+cLcjZk5Z0LSrhbvokt17tdjVYsNa5J2dWKb579bww=;
 b=p7sR8k64mlrzd6MwU7zktdopSQey+VCm1GIBVdJ2Q28QXef/ZCjwxUQpPABldvHxge
 42xYhDH7fBoRunbc3yamAf8rgKZJ0ipVaQJDtK8uK1BRaKxAf+WnYkgInYVjbOVrCx8J
 KYuCwpbEVvCKb7RcsUFIbKk/BNKahKPvHfUyZe/HTuVkje1dFr643q+vcAmyCnyHflZB
 EMOEquvCtruBFHY/q2W+fE3M4u9urkItBm5CJU+z09uE8qHObeK+AhDoLx0dOJYHBU3D
 kYqpXafv9ChOjMzLpg3U9RRoBm2ezfYsYp2yba6ulmAyndombnN973T/wb433GmhpqjP
 ahQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712357088; x=1712961888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N+cLcjZk5Z0LSrhbvokt17tdjVYsNa5J2dWKb579bww=;
 b=Eeqb0eKcWUwQ9uEicoz1HhQ4a8wneIwP1BplHr4NAbtl+zh0XSMmy1BaKQOTsTxv2w
 AAtxBRuOdgwBJWWZ+p9sIQ5voBi3wbVKiDdUhdabTKng/DVgOujErPmUZBBVDbOssjnT
 wFWcSvYdeKKsvMOzGaghBkIogT+0TK79NsK5TaO5O8UHTapXVtu7UqWf3PqximRO6uMq
 OxhvEerMFwMF+jZcYSNzA3PeqK7oxES2IYjiNlpG5C0wIYPAEkeJh4e6iKYTxIW+nFpK
 O0h4IaHjC89zDeeoKv463DwZy26q2zjT+O2BFGzA8rtdhpai0plvMdNS4KcMHQkEf3Er
 uIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0pRIpIspx0+r9e1/Fv9/YROxo+WlSRNHJI/R4zAVgDBgjSHPnGcnqg0NZeflZU4DbWUZedrX1SWO3uJPsNHNpa9gIfxg=
X-Gm-Message-State: AOJu0YxYCmvmO8/EQ57f4emK8MKQGYrT/+31frXvlAWmHNg93iNP7tP9
 JiSd8fuW6daI359KXqJYSom2frfuxpk8YlZEpZrQhHBSx0eIK5P8cooWsY9yo5g=
X-Google-Smtp-Source: AGHT+IHXzgJb6eGMQXRRsi8EWVFsr32MY5U+rg4Bu5j+Zo6ULxp0+ASK1E89aT52aSTUbC1dzwONHw==
X-Received: by 2002:a17:90a:17ab:b0:2a2:f4f4:2c4a with SMTP id
 q40-20020a17090a17ab00b002a2f4f42c4amr5019722pja.21.1712357088451; 
 Fri, 05 Apr 2024 15:44:48 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a17090aac0800b002a2f055e52csm2877989pjq.34.2024.04.05.15.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 15:44:48 -0700 (PDT)
Message-ID: <f96cb1da-09ea-4708-9616-bc2560d63d5f@linaro.org>
Date: Fri, 5 Apr 2024 12:44:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 6/7] hw/core: Move reset.c to hwcore_ss[] source
 set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240404194757.9343-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/4/24 09:47, Philippe Mathieu-Daudé wrote:
> reset.c contains core code used by any CPU, required
> by user emulation. Move it to hwcore_ss[] where it
> belongs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index e26f2e088c..1389f1b339 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -3,7 +3,6 @@ hwcore_ss.add(files(
>     'bus.c',
>     'qdev-properties.c',
>     'qdev.c',
> -  'reset.c',
>     'resetcontainer.c',
>     'resettable.c',
>     'vmstate-if.c',
> @@ -16,6 +15,7 @@ if have_system
>     hwcore_ss.add(files(
>       'hotplug.c',
>       'qdev-hotplug.c',
> +    'reset.c',

This patch would seem to obviate the previous?

r~


