Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF951C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZ71-0006Ns-9G; Thu, 01 May 2025 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZ6z-0006MV-9m
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:58:21 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZ6w-0003k5-Qg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:58:21 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d948ce7d9dso5094585ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746125897; x=1746730697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VqgPJ5g/juNUd3epRnQFTvcp4gyn80HGDjRO2mGRWfE=;
 b=GFKQEzblvQtKHuBAFydx6b9DycEMEI7MLTu2+EbuPICmIHN16GuZNHBOjKAsAobe2W
 KivQI45y4gi4mpcSYvhayVlyNlh7DuviuCvvVrxdzoWka8f6rqtELy7YFDJZ09m+IyJC
 IhzCrQr96nFPr/Dn0NMfMHYpzY2cNsXub+hzvH5hIybh7JsesM/Ox7abY7mN9eHZ8u0J
 J5wRsXc9sh5lVhbTzpV/qTJKaX3JPRQ6YDWQN4cZd0Y45o84yz4KHaZd8ILDL8JmgNeY
 AypOAfA/+PH7m8b2r8MC/CSHrFeQtGPb59TM6hkm9co/R93KCWslbmZuEVGCDlolnJyd
 /uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746125897; x=1746730697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqgPJ5g/juNUd3epRnQFTvcp4gyn80HGDjRO2mGRWfE=;
 b=Yv6EXojSgV5Jkz4iOstWY13CikvtZzQvHmd2xeq7lnk/wuQjaScVUz7g8v8Q0ji9F+
 wAb3ZacolvReNO0DjbkmUK1Jwrvya8g96s2e9dXKl3ZwgwgJBR34igf7AOxAOYMCz4x1
 dzByiHzbMYUQ5/aEwK63jBeoGEprA7UZzmhmrMt92gCX4Yz2WounV1BQPY3ZuYWXRKmy
 8k1yiT8YLK88Z+CqvOhE5E6ZHCDBHpIMRVPlfEcJkZJQDyAdZYzPbzq2vUrZEsbm7y95
 i+Yl+xGMYtJ/WXxry4BK6EHtYuxafMzKIOpLqK1JX2BTHi4t4qF6bUbTLsUK1AKwiqo0
 Xvjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhmP+9jUnNX0F6ZeeSXJueY/xs4c3eWAI0W1tOX599Isb11PUg33uRA2sG3+WHDRUorMHjjoyk1eZQ@nongnu.org
X-Gm-Message-State: AOJu0YzlyxMVdyPXNZZzn/xeevYXMfMA4PbC9tOyCij0zZr/Stl8gO1U
 2EYtJl5kNE3Ekl6szPOziNw+0N/ZZlRKAIjHHQfbvdGkUhAGoReho3ZpQiNU8h3kBfdaDxxatNx
 a
X-Gm-Gg: ASbGncug3hAx1ZLCLg+WYYFm5p/Y8X54Yma+oFVn1ei8INE7KKA+tVKTgPX7hedZ4sJ
 anurzWd0o+ZIgyp7cNI2juvvO8TcYM/dtjFyBmuykz56md7c19UpiZbpDJUIbrebqq9JRTmcskQ
 +5SaMDV/i0XL/THoMW3U4orA8ZLdLNBzFkAmnZU3pG6WqwBFQn4is0U2Vw/mmmTLSeXFjIW8IEy
 Sw6Ls+sGivQI08ARxD9ACQJfeLNKK6doFXfvA3Cj2QsOGkQIK5LwfBrgi7Q7JS7iN+dl5ZV1PzU
 Nm8R+dMuqLgNXL8y6DunCqTUgNuVzh5QBzRjy1TL14i1JdKR/R5GKwQCkw8j2cBmBHWEXXZX7GD
 NFlcaejfK/UdPAA==
X-Google-Smtp-Source: AGHT+IE235DpQRqgOCmE+kZLrSw4xKKywWYNjtfZfB+oWjHtkpidmbwdpJJavWaDU7tVY8hK9DFepA==
X-Received: by 2002:a05:6e02:174e:b0:3d5:893a:93ea with SMTP id
 e9e14a558f8ab-3d97c1bbd2dmr183625ab.13.1746125896764; 
 Thu, 01 May 2025 11:58:16 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f6dd94sm2652515ab.64.2025.05.01.11.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 11:58:16 -0700 (PDT)
Message-ID: <c1c866fd-4457-421a-ad37-ee0630818246@linaro.org>
Date: Thu, 1 May 2025 20:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/pci-host/designware: Fix viewport configuration
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501183445.2389-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-il1-x135.google.com
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

On 1/5/25 20:34, Bernhard Beschow wrote:
> Commit 6970f91ac781, "hw/pci-host/designware: Use deposit/extract API"
> accidentally introduced a copy-and-paste error, causing Linux 6.14 to hang when
> initializing the PCIe bridge on the imx8mp-evk machine. This fix corrects the
> error.
> 
> Fixes: 6970f91ac781 ("hw/pci-host/designware: Use deposit/extract API")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/designware.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index b4bff14579..f6e49ce9b8 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -348,14 +348,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_BASE:
>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
> -        viewport->base = deposit64(root->msi.base,
> +        viewport->base = deposit64(viewport->base,
>                                      address == DESIGNWARE_PCIE_ATU_LOWER_BASE
>                                      ? 0 : 32, 32, val);
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
>       case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
> -        viewport->target = deposit64(root->msi.base,
> +        viewport->target = deposit64(viewport->target,
>                                        address == DESIGNWARE_PCIE_ATU_LOWER_TARGET
>                                        ? 0 : 32, 32, val);
>           break;

Oops sorry :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


