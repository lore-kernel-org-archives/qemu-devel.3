Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C3FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiVK-0004xx-Gd; Fri, 04 Jul 2025 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiVG-0004wn-8D
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:39:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiVE-0007OO-PC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:39:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so11804845e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751643543; x=1752248343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHIDvLFsE01jmoXKQows53ZFy1xLZz1kAcDhK5XFIDs=;
 b=R/Sc0JwI/TMEWLri888pDjcfELBg4rHFzydkv/6ht7gpzQi4aHWOUrMSlNC4Rx+qXN
 54aDWaOvhe5GR0BmIj9t4f3Y8vVpoZu/R+5Zbc7Y7m8KIM5xqWlgaENwreGia7ZEr039
 cAbWho+XOaDtOdaS8FhMFvCRV9BrnkVBblBWv7Z+N1QZv5BbXTNMyes+zm8xhi9LLAbR
 3WRC3I5gX0uGcJi5oKz+XBDVeUKQX5VSGkLV5XKE67+nLDwAhpT4eMbbAdbtFLH2GbPC
 DisydWGZaiNQ55xBYH1B5svLu+IKHJOrp2HGh1rYAC/InnHwdEj5WwzRU/YMLgZFlj1Y
 CftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643543; x=1752248343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHIDvLFsE01jmoXKQows53ZFy1xLZz1kAcDhK5XFIDs=;
 b=AcKHYN+ItWrYBTtwOpZxH+UB2xANciOQJlOR52WmWpKxnE+ymtMGY0uJNPnw9ncRey
 CSTkkDnn/m1vUKj9eZQW8IaifCIjwJcGH7ez618CfhAR2NkdM3CKO/mu9Y8697mcP7PA
 XgSBgg+n+6oEUwwQK4qLHyq0AM2sbuO/smeFl6UjCGYxbhpe/kW2+wolKZLtOJI0Ep3p
 TCnUMApW5Za5T+MbU5XsLZS9lS3nAoZbTQiny5wNNAuYCvLv9saWduxDtp/ILHsCi3PB
 2obbo/tRyzF437iuDbWtVLYC8+hbbmX4a0Lch4oP5HjcMl0PhI7mHk5unBXUH4yfJwbU
 kpfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmdxaWkeVG/gWywtrwlKYU51DnjGC183mcYTO3I8+BdfnY8z1kV7oCNHT47juBt/PcwuizgZvqcOtm@nongnu.org
X-Gm-Message-State: AOJu0YzPsSegoxWx0xVCfUk71hEWnAvQQoyCf3NLBJk0nY9II90GZIj7
 ioSJ9IRMzuRP+vhOEe6UGB11qqBghEftKjx4xZ9VPgiBaPLDgRCG4kCDJ/6UmhnqnCQM6DYdFII
 N4DXX
X-Gm-Gg: ASbGncuRmmZmJV5if1OfRqZTvHkURSHlGwpnU8PnWhIIe0cVQQ6J5Y0kAuBl5Id8oeV
 10BwW1lGyR6pNRUvdFvGKuKG51wL4X419bI24kOWv9bk+NpjFXGXuwwiOFvzAKslDqcwsPWYXd6
 5pabcgoW8yfOrddsAGr2xKkjoC3peF88ziSXeXz0gE9mrMFnEz4pWOXmp3HOijGGhqWfQeUYmGm
 Gu1sKrs0mHJiMqZndeGtBDd8ylizujVJr/LYruJeYgnK/4nE8RyFXntC3rl11N21R/PhC/9lgrp
 W/8CcxlUy4c1z/jBVRNVw9A7QVmIrDIgnGw1Pw2xZA2qjyXgVC6IJlw6c25FvNXy6vmkybEKhM+
 RlGzt4Jd2NTGE+XyHvgYkWWgf2PIge6I9zoo=
X-Google-Smtp-Source: AGHT+IFKanwTwTRdh0qryB5TDrAXpMSnhQ5zGB0Awqhw6FLCnxrr6FSi8OTi6uXus6pTG1aWI7EJuA==
X-Received: by 2002:a05:6000:653:b0:3b4:9721:2b2b with SMTP id
 ffacd0b85a97d-3b497212ca8mr2781419f8f.12.1751643542964; 
 Fri, 04 Jul 2025 08:39:02 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba29sm2736541f8f.2.2025.07.04.08.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 08:39:02 -0700 (PDT)
Message-ID: <4b6ab777-9c25-4ad4-95c8-ea31c4c8ddec@linaro.org>
Date: Fri, 4 Jul 2025 17:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm/cpu: fix trailing ',' for SET_IDREG
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-4-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141927.38963-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 4/7/25 16:19, Cornelia Huck wrote:
> While a trailing comma is not broken for SET_IDREG invocations, it
> does look odd; use a semicolon instead.
> 
> Fixes: f1fd81291c91 ("arm/cpu: Store aa64mmfr0-3 into the idregs array")
> Fixes: def3f1c1026a ("arm/cpu: Store aa64dfr0/1 into the idregs array")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/tcg/cpu64.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


