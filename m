Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKmN-0003kU-Rs; Fri, 12 Apr 2024 13:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKmM-0003kL-Oh
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:33:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKmL-0004Ev-2B
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:33:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4180c6a60baso3747135e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943211; x=1713548011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IHObx4vJm1LE6X2KrAOYhzWxOZlYzfq5HvIkVYziS8k=;
 b=qwoxejTdOdN/nszqFPy8Up1thk8tN0C5JiCo7eE56MyYPs1DFmBqn7ip1s7QZJu8/Y
 QdX41uYD97QYO3mC+3feRTvdn6DiRyZnzd/hahtDVf3P9rOEchPbOGbIp8YyhnRh9etJ
 1Sa23deu12n27a1KvQCEoA68+gbGOLDQy+eyxOeaxTA8WWEjzOvN/JWKfTpiFZhApjSj
 k3jkxwkDaNYkDM2tek8IX7/cy/O+KYuPvtHW2O5tZUYP3IQfXHIGnjZJLP0gYGV0ps0h
 ypSK6+2oO+06jkfgpvI7cVgJvGPTYbSY78qFmbBli3Jv3Xe5aKRa1/M8CxISw3fynSQ7
 ExQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943211; x=1713548011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IHObx4vJm1LE6X2KrAOYhzWxOZlYzfq5HvIkVYziS8k=;
 b=DXJPH8+XL5Ktt9Dty2pnkMdDX59i/WG0Y0YUg3/TOsDbDp5drV7UQOWFPThf0C0hUJ
 XkHb8V1pJdqPIUyaSi2cntDXC3Qfa0fKHGpIl0CAbbRy3er+o3nMl7HL+WtzjLl76Y4N
 B6iE+fnSB4tkIEW60lh0xmZOvTN7v3jS5OQJEAd/4QHyXd2wQL058n7V9KuZCl0tPaUA
 qVXlT70si58Vh0JgwVpw/8YIvb8ZxcEvsoR4gOiLXP7MQpFITsO4M+9HjuHT8iKUd3c8
 H7Gj8Ec/d+fPpk7PMem/edZCGFgAaa5nfSgpUUCR3vp2iGwoqvM19sg8bMO/3Glp0Wtn
 lQGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgAypGD9I12wYlohltH2HUYDfjwuuslvZDz635oNZoM/NBD1KdTG9cEJgpiaVaJKchYHrABp2NKUww5Le+1VCiQuAtq34=
X-Gm-Message-State: AOJu0Yy5gB3T1s1bd4GM00+K1feXqm4sFeCSjqr4xR4a2yMOykBhu38k
 G0QEwb4uBrtScOJPY2FwIlMi+yd4qFadT8eDkz1AGUy8SKtfGtU552JKR6BlSzlxv0BpJAWREli
 I
X-Google-Smtp-Source: AGHT+IGrX6UCGXKy0ih2IRk+GB8XKOeQVqIlDcYNElnjNQYY8UW9k5ELgCX7aX0F/o5AfJW3n03pAQ==
X-Received: by 2002:a05:600c:350b:b0:415:45ba:bf55 with SMTP id
 h11-20020a05600c350b00b0041545babf55mr2490636wmq.34.1712943211500; 
 Fri, 12 Apr 2024 10:33:31 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 fc18-20020a05600c525200b0041563096e15sm9595932wmb.5.2024.04.12.10.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:33:31 -0700 (PDT)
Message-ID: <cb3b51d1-e6ab-4643-9f35-1a6e20683ce5@linaro.org>
Date: Fri, 12 Apr 2024 19:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To: Bin Meng <bmeng.cn@gmail.com>, qemu-devel@nongnu.org
References: <20240412123729.1340062-1-bmeng.cn@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412123729.1340062-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Bin,

On 12/4/24 14:37, Bin Meng wrote:
> The Wind River email address might change in the future. Use my
> personal email address instead.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
>   MAINTAINERS | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1f6922025..50729a0985 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -332,7 +332,7 @@ F: tests/tcg/ppc*/*
>   RISC-V TCG CPUs
>   M: Palmer Dabbelt <palmer@dabbelt.com>
>   M: Alistair Francis <alistair.francis@wdc.com>
> -M: Bin Meng <bin.meng@windriver.com>
> +M: Bin Meng <bmeng.cn@gmail.com>

Do you mind confirming that from your windriver.com
email while you still have it?

Thanks,

Phil.

