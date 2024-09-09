Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3121EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniQz-0005wN-PA; Mon, 09 Sep 2024 13:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniQx-0005mE-Gz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:44:15 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniQv-0007Wl-Th
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:44:15 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so247052666b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903851; x=1726508651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKnXHUv6SmKw+WE9nhTwKSMjER1Cln1ig5Dty4aaU8I=;
 b=O2n6YR4jumDi2VmqyPjQWbJoyEUfOn7qXj246hmXU4noqOQEtqigZRzgbrE4Zn6USd
 LnZrufuRch0WI5fUxrPGTZJQPpHl+mG7nOIXyQ9Lei7CvcL3Urrs2ixEo1bUZeA2xn7T
 XWs04yTTPUay/0w7pVD8H7Di1kjjDAkyZZSCxtBJ7sgO4LOOvMIv0j+gVAvPIkAR0XvS
 68HxiNVglkNjMmmo+6M4nP5zfBJPuTfxPVZ30QoYbsyhhdS3hHA173hIZhmm2NOp2mp+
 rMhiDF79r/KbFUodYAveJQar2NdjrNAUz76UmkalYdRxyODhgzddcPyIC24JDUltGWYF
 dPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903851; x=1726508651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKnXHUv6SmKw+WE9nhTwKSMjER1Cln1ig5Dty4aaU8I=;
 b=QAjfNHBV8Hake1yZ5OCchrP/ZgCNgEPdOfBUzlMUvAEzYckv+SSFqgfJXC16Aq8J5W
 FeXrXm6CAKemrVX6948RQzC3QdefmrkQNi+cDRCC/HeZlScrHChZx7EeyM7ze/w75xXO
 mrl2EAvlBRqy0sWqLCk+N06q9BANMOksHAHKtLthTf+pabnstmld/B44wOQd+vGSn2nr
 qvgtANOJzkwko4Ud28c5mD/xVOLgaNddAOne/OSGTP+E73vnbwt6Fl5rYJDJvamh7vJa
 Q840Zf/DlCOWdDOkHVgBn1RRL4RIRsscr3hCCKUgwurQjKkBNZXjM3D9DurvP4Hi8Nck
 /nmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7yTJormivxgfKCI1WNUeL8Z7Up5sekc/mokK7bp3R6k/dW0mnxbCkClI855fX+kv47qg5FUnkfun4@nongnu.org
X-Gm-Message-State: AOJu0YzXyU1231ZDhAdKQvkfkI23vKIwFjQ4fHA8H5Km5BQ7ufXX7KlC
 l62mNUz3Lvwl4kbdksrRRv0lRsFv4Hlh+kY+M9ESLpHXwBQIU2YhNeRI5dXeXXM=
X-Google-Smtp-Source: AGHT+IExw11VCLjE/wCFrJKUpXTiSQUrV9xrGTrdceaBTqw4pVT02teuRzzb4CMugagTTs7//vrpQg==
X-Received: by 2002:a17:906:eec7:b0:a88:b90b:bd5e with SMTP id
 a640c23a62f3a-a8a885be339mr904307266b.3.1725903850957; 
 Mon, 09 Sep 2024 10:44:10 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5dc8csm368569766b.206.2024.09.09.10.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:44:10 -0700 (PDT)
Message-ID: <0f704f5b-461b-4c9f-8d03-7baae8845cb2@linaro.org>
Date: Mon, 9 Sep 2024 19:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 13/53] hw/arm: Remove STRONGARM->PXA2XX dependency
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-14-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Currently the STRONGARM KConfig symbol pulls in PXA2XX. Since we've now
> removed all the true uses of PXA2XX, we'd like to remove the PXA2XX
> symbol too. To permit that, make STRONGARM directly select the things
> it truly depends on:
>   * pxa25x-timer
>   * SSI
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig       | 4 +++-
>   hw/timer/Kconfig     | 3 +++
>   hw/timer/meson.build | 2 +-
>   3 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


