Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E3C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVe3-0008UI-V2; Fri, 08 Mar 2024 03:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVe1-0008U6-UX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:31:58 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVdz-0002j7-7i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:31:56 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51336ab1fb7so812664e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709886712; x=1710491512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6hM0Yf2lccp4Tc2J9h9jFZKi9GqFKiU/wACGxg8+TA=;
 b=hsjGDtMdfwkeeuXXMpdWDk8j1mDbWRCD7UAUFSHGC6aEPMrxWKRP32d+lg0nW05tSS
 KjOyb32tDgK6GwdnI0D9GUcbxWlLn9ncfYZTrr7N8ZmQJR3IyAwLMM0Y+orAeUUUJCCG
 PGRViKD9b7KcDfWG9K40o0rce8cM/c+eXi2BxWJEG0eBBi/8VZEk2rE5CH9GoJ1RzmHq
 mqy6t2/UaL6GiPfVAal+Xrt158vz7RpqyN72eLAYE/yOJZnN9c3zANOHTN91GJs/Wira
 jaq8Vgh8xJk+6l6sA9CyG0uJnvVZRqtKlPWNtnxc4Tm9AuCnSZXy1pHroFqMhw2kiChU
 7RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886712; x=1710491512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6hM0Yf2lccp4Tc2J9h9jFZKi9GqFKiU/wACGxg8+TA=;
 b=Vn7A8vwkA4/16MA/8xAbzCNnGzuWnENGZGs7oduV4bl5w3wGTN7gW4wN8NF6TfLIWZ
 gep5Yq5c6oUMxthM3hn+HzIjcy6ZC6Jd8gCy0hzDWntdnjYFOKZzJu6QzYf2T0Yplu3G
 XKJgbzM/+5NdpQ/NjCX3O0eTdRoqVUjOpZHoM97ETH40Pty9Z3gZviuLBwLzsoPe/poB
 BM3sb9cf69DGmq/7z9XzLCbFHPi8a2++33A/ZAH0cScAawEAzQBujs/0RyUCerCyjmQu
 vGEVlBkLu81SMxr3h9abPxjg1hFJnPCso3CI9WbnlB9+xXr7SM9levuDewcYsUGCBnbo
 gv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtbQWZ/qksPU85C6YSuwz1cKxBITI0jxeqBXOVvlSbLNUycasLbAZyL3dtW7e1tmCCakhAbSf3XoBLEWYthWkMxCqsjD4=
X-Gm-Message-State: AOJu0Yyrz6eKCLzNLFfbG6lRZnYcN+agPlXiLcb15qWkiyVxyLjnPtbf
 VULayVMUT3cIlvB8HoUxCdEYb2ZmH9s5d1MTxghR9hlWcsLl7akJTHS1o3ybcEY=
X-Google-Smtp-Source: AGHT+IFdNCMHajturIq62OFUmCM9kzzUNquBNqndSbzJFhy8WPloMhfIFBbCe5Apyk9tkugltzh0uQ==
X-Received: by 2002:ac2:4d87:0:b0:512:d061:a1b with SMTP id
 g7-20020ac24d87000000b00512d0610a1bmr2664774lfe.0.1709886712341; 
 Fri, 08 Mar 2024 00:31:52 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c315100b004122b7a680dsm5252509wmo.21.2024.03.08.00.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:31:51 -0800 (PST)
Message-ID: <931b4105-9002-47d0-94ca-0826e85c3764@linaro.org>
Date: Fri, 8 Mar 2024 09:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/17] hw/loongarch: Move boot fucntions to boot.c
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maobibo@loongson.cn
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-2-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307164835.300412-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/24 17:48, Song Gao wrote:
> Move some boot functions to boot.c and struct
> loongarch_boot_info into struct LoongArchMachineState.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-2-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 128 ++++++++++++++++++++++++++++++++++++
>   hw/loongarch/meson.build    |   1 +
>   hw/loongarch/virt.c         | 121 +++-------------------------------
>   include/hw/loongarch/boot.h |  21 ++++++
>   include/hw/loongarch/virt.h |   2 +
>   5 files changed, 160 insertions(+), 113 deletions(-)
>   create mode 100644 hw/loongarch/boot.c
>   create mode 100644 include/hw/loongarch/boot.h

Consider enabling scripts/git.orderfile.

Typo "functions" in patch subject.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


