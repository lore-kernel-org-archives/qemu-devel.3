Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73414C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5TxY-0003Kw-BK; Fri, 10 May 2024 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5TxW-0003Kh-SP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:23:03 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5TxV-00035m-A3
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:23:02 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so562842066b.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715361777; x=1715966577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VhsuRuM2IBesjYzbXTwOI/lKInv55ZB/iw9X3zYbGQ=;
 b=XK95FgjgTJUHqXsbdMA08wgXNecs84WTNj6d28XekBFb6eayYuqpYJ8gIRTp87mcdQ
 tpV5WuAgMpFC8nU1gTjgRP/LMpbOZ0h8Ki/oJKGs13YPPfBipn/qZsbpwTZX25+6avcd
 uFVk8gnCntm00rTNkNEe1utKvTYzzTBvq4s9nZTn4Yj82Sl+LDq45kop4PfrN0cWpZoi
 vZdnml2ntvbK/WqPHqGW/3qAVg4YrUsQzv+iHlP/ADc6V50R0kKF+dmuvm/CACDQX+j7
 JrHAi7qVY7uvi0J2FfyrP5SpjGOJf1W2owCC2SaIO3Iuj3L7Ek5YTzA1mPCZtk0Mp3ei
 q6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715361777; x=1715966577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VhsuRuM2IBesjYzbXTwOI/lKInv55ZB/iw9X3zYbGQ=;
 b=PD9HPbiWDgE5FAO4b+kj7LZL3BEGtYfI0yAnIPtT5VmQNw22o5lKZX+G+mwFI27o52
 AeujZfpFLBzYePY4ZXM2firN4yjJbA7ggb8ooAjGag2nOc6rUOkMKDpI02ZmkI2mOH54
 33aLt0to/DBqHQAxmgF9A56MQEi9+jr6l0XaN93gjzeOgSZalvwweXMZhFxhgKnZGLeJ
 enddfwdI19GLlKqGd2ueZccb3J++/cceDwOhBwuaflQY+Ai35bC6mTzVv2cHVl4f8n+P
 VAPNT3Vh//NKRXQVHvzvLNL9vaQnswaHI6hM+ALzd5TiOZESSXyvWcd4g/T0nNOm1840
 GECw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzV/61VoMiGbl7zCZMoFDMAd0XearSDULofhDiPK8wZH7C80v3ArjAtofGpbIstc90oTb5SqdMGX74wNeK2lt9mr/aZlo=
X-Gm-Message-State: AOJu0YxhfO6d9Yihoi+VTGhoq61gk5ToTS4oJXB/JH5Flo7itjzRKv82
 PH3mWsq5FK/Z1QXK+D82umVe6+0aRKr+iSVBnZT0CIzziUpo+5sTp4cH4Kespp8=
X-Google-Smtp-Source: AGHT+IHLEjEXtQHaUefv1hoIknDUh812QSoKmEuxwpIX/fKA8gxgu7NuQrCkmPyucLjupGCnrPHemg==
X-Received: by 2002:a17:906:d202:b0:a5a:1b47:dab3 with SMTP id
 a640c23a62f3a-a5a2d57a8f7mr218294966b.25.1715361777647; 
 Fri, 10 May 2024 10:22:57 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781ce5dsm203647466b.42.2024.05.10.10.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:22:57 -0700 (PDT)
Message-ID: <47264475-31f2-4fa5-8454-61395d9a2828@linaro.org>
Date: Fri, 10 May 2024 19:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/41] target/sparc: Implement LZCNT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-27-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 18 ++++++++++++++++++
>   target/sparc/insns.decode |  1 +
>   2 files changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


