Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927CCE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6ul-0001a8-Mc; Sun, 12 Jan 2025 17:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6uj-0001Yx-U3
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:58:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6ui-0001ji-Cy
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:58:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so42865725e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736722714; x=1737327514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jh8TTghxPbyTQJFgWVhN0JvpcsBQ7bEf6F9d2W0xjv4=;
 b=rzUTAvF2bAx3C54xbq0KujXIVz/0pEZflc4sRCmyRC5QPkC2fCsEMuT1LNUmnEtvV2
 /E5ebR9FR96ODz8wqF3EEp1rRwUl8YhQDf9Y3iUVtG3JLxUCqewmbwu3UxC04ICbh/TQ
 fefgN4i/BJutEquUXIjfyWKpDsDSQvUsI8qsMec4g+f9LYE92TdKAamlOnGum2W19Rk1
 BVsXrV+YWy02ZWtNlU+4AkDhiFAnH3yAmZAiNTz6Xsu7vqhz8hJ9W9zVnntOzBk0K7A3
 Qlpx1ek88d2MvdMliLRkMiuAaRyejmlMKwHd6MrSmOHfNDDkw4rcBTDzmAkLAduC9pJc
 xKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736722714; x=1737327514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jh8TTghxPbyTQJFgWVhN0JvpcsBQ7bEf6F9d2W0xjv4=;
 b=drTP197QIl4tNQO/Ub+KWyfi5Q1jv1zbdD6DLTNr9/q15PIMZTrHNfJ092F/kXovOk
 UYrAlVL68ZCgCaWBgZgPO6cDdi7u+YZrWUGp0WPbQs9bUzKuawFVMxQMxhgVmtqItxmG
 1BeTwhhZ/PvZkgxgpwhZvRlmKuIG8XtHR+prd+3AXjnhjG0UKgiF6q6dOl8WOHI1TM4G
 Pllgz0j1P3jiWukU1Wyg2DP1AONkeWPSm5kV6Z2Bw2+5Fko3ZbshNTn54z97g538wZgP
 /Lo2qCHV1pmD0dtuEeB7nMpwc/gJ3yV+9TH/AxXTcVeCoD6uIF0wyqK8pJUnZPkZ6UCL
 3ktQ==
X-Gm-Message-State: AOJu0Yz2fm7j6xH0zs8fthweKna97STUCeut1Btm49QweF6fpWfgOy/E
 sAp+bIQhL+8nGq1QUqYHl1jMLgIcxqcrP1tYVXWptX0iJe/pDh1cDu77fVaCnVzomTbdEUSaQER
 EgeA=
X-Gm-Gg: ASbGncsrIb0HgvDgcmaI8jH3Ypoqm00YUrVSG1mi3j4uJmxRke/kUXjcatwzaPss51e
 w02zmlj3Ksj33SW02dmfshMLWxq9hcMvEoNYC2RGkhC+yKbVP3njybvKC+hBaJe/SXtNUv02ww4
 zvZ/sqyAVJj7g+ttvJr8eoOZm6PTc6bB4LDhao1kZcydVyCFAiXzh3jdE7ISyKIUgI34l+pMaWX
 fhOYx7pbxSj31+o86NpRPm5prBlMTs3F5o+0a53n2s3fw5Ty6FgZmUx3uRTuT9NmR5NFDa5eXvG
 +/Mg8es1doeyfw2ugae6oQy3
X-Google-Smtp-Source: AGHT+IGIg/pWgnD8oJeSNpdt7EuddkZjau+/K79fvRM8EuEn/lnvS24Tyjtu+iYQdcB6JCrTccSiRg==
X-Received: by 2002:a05:600c:3ca4:b0:436:6460:e680 with SMTP id
 5b1f17b1804b1-436e26c3331mr136479525e9.16.1736722714298; 
 Sun, 12 Jan 2025 14:58:34 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92794sm157177235e9.37.2025.01.12.14.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 14:58:33 -0800 (PST)
Message-ID: <8a2e8401-a1b7-4401-a720-851a75e4c3de@linaro.org>
Date: Sun, 12 Jan 2025 23:58:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/arm/stellaris: Add 'armv7m' local variable
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250112225614.33723-1-philmd@linaro.org>
 <20250112225614.33723-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250112225614.33723-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/1/25 23:56, Philippe Mathieu-Daudé wrote:
> While the TYPE_ARMV7M object forward its NVIC interrupt lines,
> it is somehow misleading to name it 'nvic'. Add the 'armv7m'
> local variable for clarity, but also keep the 'nvic' variable
> behaving like before when used for wiring IRQ lines.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/stellaris.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Note this patch diverges with my other Stellaris series:
https://lore.kernel.org/qemu-devel/20250110160204.74997-1-philmd@linaro.org/

I'm OK to rebase whichever isn't merged first (this one
being less work).

