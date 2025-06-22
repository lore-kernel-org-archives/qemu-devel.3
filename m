Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B34C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8Tk-0000lH-4R; Sat, 21 Jun 2025 20:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Ti-0000l1-CY
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:22:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Tg-0003ZG-QI
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:22:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2350b1b9129so21944495ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551751; x=1751156551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sc5YN3OnlFRHHU7WNUdwucHTYCRl0stn3spHf8N9xxo=;
 b=BfELJQRPAmI2t6K6tzmoRnk7dmP98YP9TaMDX/U0wFm3KhWGuuf4DfsdnZuYvcybiW
 zmpY4419Jz6TbsiuXXfEXKvc+15pnEnu+095q6ExyiIE+fSq7guorrrwspUkz6vR4dyM
 Fc7s/M+ZyyJEIV0zwZgflUMSMw83njsh9vkscPlRW8aXlLkIAg0/0yCOh9qzk2ehqepv
 ecUimPCpBTkiwpH8tlr9HUtV/xDL75ohHQXGgUtWvLzukT4UaY2cq1jGZvU8BGzxW8nH
 StKjKJv7ereXP89ZyILRvDGzK97g+DM8k9xy3P2LknT6yO4rRecoXjkx5yckbmwaOO+k
 Smbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551751; x=1751156551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sc5YN3OnlFRHHU7WNUdwucHTYCRl0stn3spHf8N9xxo=;
 b=Kf2SLQerCR2t11LHAj7ADeBqTH2v8+mq5oXBBLemYD/fERKoHFlB43O9ZfRyFCpm9p
 PqfKFyZcc24q+o97LyTiDpYT3lGz8Y7lho1V9UOkBAZ3wAEALVWIyKRzXdsWVlYGKTEG
 Y8Cx0xYurbLrOsJq3fehUTs9ASKyqYJZmog7WDgmvi07oa13RRGfL3w1NzYs8AydJPrv
 Rt77XS3+wglFPqCJV8N1qEc/u/Z7GLr1nzI+z4OvAPrz9IxKrOsBL7wrsSpwUAg2MLyP
 ap7TK11tHleZY/G/pcE4MQ4kEfT6hLiZ2dX66OGVghl0olOrdjiKa+ojHHxydc/9q3su
 ckrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn7zJRCbm1fLrE2fMLCMjiqk/0aWUEZD2P5hnVdgRNtWzml8d1Gyxl7QagNcvO6uF9fqC3QRfg1FQy@nongnu.org
X-Gm-Message-State: AOJu0YwFbXGs8b2zPR/oCebX2f0U/iUdxm3aOXJCfQDmYGUopjVEiRD3
 dDSOHkD+BTdTPMRRpHl0shtLbcTNV8RqJYdTHhrRA7YD4uBgoXOxO+pmP6k84xpW29c=
X-Gm-Gg: ASbGncs30e7K8xp6C3KPyfOiEgiYpmZ0UI+eYxluBmrzP2fthWP9PC/kdyYLAM1sZk/
 M0zcaHA5fNcSRndSAOsRc6sHzXxPhMjEv/znahuVyF0zv9HYj3By3ymzg+iOAjLXN4D1L2NbuZn
 doWSpew3vsHnVyVRedzVb4fbYUGwTdB3VWhbZ3a+X5PqZZ3cO3oFCaoLaB9Pq6Cps3Uzey475BD
 5O6b8y/jQOGBGr1yUZKdmFR58MWA9z1EelmanU3aRCpN8Cv9W0t6lzgtaTGJ9cgMGuR26e7BxXp
 IjUty6sKarJ86o7J9mlsY2Wra7K1+Qom5cmXD2QXmrJm24eMmbRJRcfUKhTpFoBqIxWdPo727HC
 TCgxq7qealDoFoHzLlWPrJWBkbmj0
X-Google-Smtp-Source: AGHT+IFf2837OfruM88uFvxuNFJXL0QLJ/9ND+2Q9iOV07siszr7HJjc+WzDH4MjoBmOvgKepOyeiw==
X-Received: by 2002:a17:902:c94e:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-237d97cfb5cmr109338735ad.13.1750551751092; 
 Sat, 21 Jun 2025 17:22:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83f0ec3sm48839325ad.78.2025.06.21.17.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:22:30 -0700 (PDT)
Message-ID: <5e88cd4c-037d-4737-ba67-8bb6f8e15da7@linaro.org>
Date: Sat, 21 Jun 2025 17:22:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/26] target/arm: Create GTimers *after* features
 finalized / accel realized
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Call generic (including accelerator) cpu_realize() handlers
> *before* setting @gt_cntfrq_hz default
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

