Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9162FC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redVD-00069T-19; Mon, 26 Feb 2024 11:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redV5-00066J-Dq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:06:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redUw-0005vI-Cf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:06:43 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so4969761a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708963588; x=1709568388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6RZ19sTM05Z+88w1NUGEHn3Dcz3i6pGJL7ASY0ZUGo=;
 b=LBySo5UauXOVFIl5na25v6YeCpj+sIzwjjU6/qKMf501xHzlFVbqdHyqSrRLaptbqR
 Lwt0Wc++M58rNfLQnSYhmmaqH2ht4L8o5RLrr8yLzqeOlTtDx/uMugJt2ybm0ksLiA1E
 +qZ/XQdYTOcLNekBFXx9uIYHJ0Nh8XgJysXjNKJJs5H1JnDyzNM4eVVdyVudaBxh8cPE
 on1+ybDdXbSZ63nLnNRHKhrm4uWsQlj9CbD6HPPAN/JDZ/fcTlPxiEdeL0LXIVIpbVv5
 iSJUNGL4qT8SjCdkLzG9sPZ3rQ3SZEDRhRe94lbgqf3SC4p3ylBfaOC8j+6r+jUBVtuL
 mrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708963588; x=1709568388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6RZ19sTM05Z+88w1NUGEHn3Dcz3i6pGJL7ASY0ZUGo=;
 b=oJH/HfwGMBuV+Q6jAKQ4hzV+xlwCBV2OjjE7dVYHK0eqSRIBt9XvDkLjsxcWczCmxN
 ADXCIOys4NSLG7z/KdQuiSKfDQ7GTSd91AwIZ60BA9sd+fgxve+C+2Ao3Kl2hgdPr8Yc
 cE4RJwMT5CuOSQ/sK5pX64xwAmRB5WR8GCsrBIR8gfJOcz4pE68dxGfOj5SK9DO1NmhL
 IXCs427YxUWiuBOTeTDjOoNSIStZdwr3hi9bomvE6PvkAUdvUnw3u6f2BPV8AthZBaNW
 IFcJQ3pR0Doof4q0wEmHKTebCYf6TtsT36WEE0vZg0odvbb59RFR+GKwOMCQ/yxz0tnw
 7mVw==
X-Gm-Message-State: AOJu0Yx5EQ5YNT1yQX/JzCUVzye8k0LsxMQBNtz+pmLUgqeYQYL1HhwI
 +KUOziKKyXHr0+MS+YVJtU4sBmbNpT3iiGX4i2+MyZ8qSPhIcZH23LCmUDNUHZ/utMz0SZrlw3x
 n
X-Google-Smtp-Source: AGHT+IF4GY17zDFKxS6DLsP20xiuof/9GpazsY3lLUYwNxj7OdWKG7ZKj/tuH2f9Ih293XwQ+X1hKQ==
X-Received: by 2002:aa7:d799:0:b0:565:f782:10ef with SMTP id
 s25-20020aa7d799000000b00565f78210efmr1844352edq.10.1708963588092; 
 Mon, 26 Feb 2024 08:06:28 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0564021a4900b0056626973bc1sm104394edb.38.2024.02.26.08.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 08:06:26 -0800 (PST)
Message-ID: <730fed32-0c79-4aa0-8ec5-141135dce2cd@linaro.org>
Date: Mon, 26 Feb 2024 17:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/41] Add clock_isp stub
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-19-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-19-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 26/2/24 01:02, Sergey Kambalin wrote:
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>   hw/arm/bcm2838_peripherals.c         | 6 ++++++
>   include/hw/arm/bcm2838_peripherals.h | 1 +
>   2 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


