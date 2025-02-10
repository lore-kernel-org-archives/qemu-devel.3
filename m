Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2794AC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thSBy-0006PE-MA; Mon, 10 Feb 2025 06:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thSBu-0006OM-3h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:43:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thSBs-0007D8-5x
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:43:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso6198925e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739187782; x=1739792582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EfAEcBZVfgER+PyjUrcBoEN2a5jycU5m9Zrs1Vj4dU=;
 b=btU546x3o3G73Idc7HYNR0PYZDnk5C+Uuz9Y54/q4NdV/svSkITW3WuzcAziVnYw0N
 9ov5gJ/JkUQDfa8JSLiSgToYPTTQDm3QZkJlnJ8135FEGJOPNtRVmhvhRUOWjMWsmRqD
 adqCqtgaDGCMQaciYupoyTS0HHLRw5/cQRLjTVNsmioiGbQV0Qgkb4aIw4yIJog/CSHA
 qdFw2TqZ5NmubjF+rJXiIDvier1F+/XQIebCncfWr6ZgY0XgmVM4xz4rk8rksxHgphET
 lM8qLt5OTfp+mkNzJRayMPHahLkGqgaUvcduHbLpchTkWjJ9qkAO1hL7L4EXZhjXPEXB
 6XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739187782; x=1739792582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8EfAEcBZVfgER+PyjUrcBoEN2a5jycU5m9Zrs1Vj4dU=;
 b=dnVyy8BSVxnnM0WeCnxScC15/QOER4S1w9NHuzhytKAr46O6a8lwofTY7MkcdNBkLX
 Xn+sHwZE4lT5+tsdo8rumQospJ1ckmeWE8931QOo3q24WIS24iZu/Y74AHw7rC0lRcWy
 5/qHN263/XlT/ozx8Xt98mtwZ9McTqUMbSl8zRpLaVQNujVnthMaiCj2Tvuk+oWeoty4
 5wqkjWroKWH5/Ye6Kl8BdRtZUF5q/wzOBNr5TGwQ2FJFENtNJslT23J1Bqz8LE4Jpmam
 RWMMyvubjOG8Xmif+4uQlSsZvN6kmw3MZSRZN3xbYs8hr/+eUDhfO1TwSTlxGy62nLEh
 rzYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVchtb+7uT2VWm7ZPfM2hA3uQrCcxlfFlXaegJHcrySmJMMK8hEo4a4U0rJnUi0vIUKascHWOcd/bAu@nongnu.org
X-Gm-Message-State: AOJu0Yy73KdZDDTfehqQK+o4Sbisx+1PzrqQSbejeA9E79x2WqmDLU3I
 JgIIybm8z6h/qw3FE+fJh+qtK2iF1ZQlVew3GLJBqz2vSlB/Xem436Sif04ptAU=
X-Gm-Gg: ASbGncsRoF6ZJLvgF1U4OTwwhJuIQLJG1tv7/n8ucZXEVIj1dAXSNqtAw+VgEOGbLSY
 yPDo8k9pGyUhY9mMeFZUeFuKMAaot3d/R20UC9R1EBdfCUcxClO03J8UgI/4korO9kORKOa5Id3
 SEWd/ODWDeYBKxgU7MBR2mxTzddcZRd1+BBq2ezrhczhbunaUP6Nwmckke5+ahB2+39KPG2zh9w
 OW0wDmw7wg1P9uJSYFwGFhgNcd38u++NOH9Ywvbw/GT/ZSgm7xdJcnMnOJX/78kLiyqbB6oUT6c
 Cb9plM/JVyCn9ODxa20ucY0L09RJl256HIfGj83WRRI3tUx21ssjlvu6nslgg6pu
X-Google-Smtp-Source: AGHT+IE0ilfTc2otY9pOIaVgjNtY99ocpapQf2nyyIp5DWjOIIU/fgmGtPCGmxKW8ozZvvkwRds2Tg==
X-Received: by 2002:a05:600c:204c:b0:439:3050:1abc with SMTP id
 5b1f17b1804b1-43930501c28mr65743385e9.15.1739187782022; 
 Mon, 10 Feb 2025 03:43:02 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d753sm177623775e9.11.2025.02.10.03.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 03:43:01 -0800 (PST)
Message-ID: <69457f04-47bb-4cee-9f10-64dfb1dc9447@linaro.org>
Date: Mon, 10 Feb 2025 12:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250207151157.3151776-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207151157.3151776-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/2/25 16:11, Peter Maydell wrote:
> The SMC91C111 includes an MMU Command register which permits
> the guest to remove entries from the RX FIFO. The datasheet
> does not specify what happens if the guest tries to do this
> when the FIFO is already empty; there are no status registers
> containing error bits which might be applicable.
> 
> Currently we don't guard at all against pop of an empty
> RX FIFO, with the result that we allow the guest to drive
> the rx_fifo_len index to negative values, which will cause
> smc91c111_receive() to write to the rx_fifo[] array out of
> bounds when we receive the next packet.
> 
> Instead ignore attempts to pop an empty RX FIFO.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 80337b66a8e7 ("NIC emulation for qemu arm-softmmu")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2780
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


