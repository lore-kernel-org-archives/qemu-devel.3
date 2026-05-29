Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756BECD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 16:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT00D-00030Y-HE; Fri, 29 May 2026 12:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT00A-00030D-Rj
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:24:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT009-0001PE-6V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:24:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso95764555e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780071839; x=1780676639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XkTA+tyNA//kTw8ZV2L55UB9CF3UBX/3Rah1pnrUAIg=;
 b=s8yR9S97toiuFTvyKF6SYNKJvDB4CU/NI5go09XgzIh0fczEANa5Dl7agNp16g1l1+
 BWEaf0pC5iwLV+U9fmkAjlqrFfGVbn8gpis5OTQwsBvq3vXVvbNGfqfEiMtBbP9m9wBt
 DtnqLOpUp05Qo44lDnKStdkHt9gzSI4sOypfamVKPX7MsELfhFY2VNI95JOY8Mijc1t4
 hs6EE9I9X6CT/Oe5PGln5RCDdcWf1QDeC5uRTLCkG9hfdJY+0bQgnc4i+lKyfqcdgldd
 XhEC5YTV74wat0ILWV6/Z1ugb7F0x+0dQis6A/mIJWyizkp7WfjgfRxWFZn8s+DoWaDY
 XbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780071839; x=1780676639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XkTA+tyNA//kTw8ZV2L55UB9CF3UBX/3Rah1pnrUAIg=;
 b=WcbK3Dc6YZrE+0fNv20iiQiaeMUAgA0HHLSI0t3OsYgo+ofyWxOmp77PiEGyRjxkFy
 H/wxurPet1LrUSVFvHG+/GV0RzC9q8b3Uu428IaN4NOQfnSYwLy8GG2zANQ97+slNvgm
 OMTa06cUdksTHTh2HhZ/jp00g+RK50YwuiUJTAWr7RGRnnpViAoEKAmW4H04OlMxDOKM
 KdYJVkND6h+27U+zlkFtEQOTDf5dSA1CId+TU2YP0pNTBLMtKWahoNhqEY6rT6dPhBaR
 b15Y5kCRIM2ox1Z0TetyjiAVFT0u8IUPzxSQqNANWelj6y2Dvr8YKXtdb9lu4WKCjAWy
 Qsog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oAN1NTHDUyULUhfb3NVIJnqA3YqV+hC6kj1kVZJKOSH9ogH9zFzBx5hvFoFBpYM8j/tZXqGPsaOM/@nongnu.org
X-Gm-Message-State: AOJu0YwyM21wiXfsyLX/+b7SlLT6xva2UbDKhobN+50HiW/8PyXS96rJ
 2XrTLgT+UX2ZCxNX/EzQwh7VgcVUBp7CeWpsnNHCiOAjFEj7T3CS3e77O2q4CzUEy6w=
X-Gm-Gg: Acq92OHIjOIRXD020sH9577VkjHwEfPK24UdQEOW47UxslWqDUWVGE+ZzFaaMGE49tp
 Div4BsQ10aJqEWOnW2maN+8IZEK4Z3f76g9EgIKu5G3iHN4si5DRxEllyhPILFxGtcd65GvvEkl
 6GYIR8oORu++qxYMGeyMvfMHgHa3egz+O6WFUkMt9YxLv/Hfo0nRRsWRxWsILgqbNv+pHbECSjb
 z0AIXDmXeUMMqu2vtvF5DzkV2x/BDXM4Ut1U9HoaNWPocXGiis7eNS4nmIGApVbNziam+YN/6z+
 Qj16yxMuUvL8FcdPB6n0NhOGqJXzrIkO+bPp3Fvc+QsDpEuUkp/SzmVp57F3TJrXNF7uQ/EtKp/
 90QEVxkzCXyZDxT1oOqb/nH9kDLklHRxn05lYejCjnM8HzUwIPPuY++k379KgelZRJp5Vjf46Uh
 gJRp4p5hG1ahvxGYdGB35frrllwURKH0m9kM9Mp42X8BuSOA==
X-Received: by 2002:a05:600c:8b12:b0:490:2238:4021 with SMTP id
 5b1f17b1804b1-490a29079a0mr6842805e9.8.1780071838612; 
 Fri, 29 May 2026 09:23:58 -0700 (PDT)
Received: from [192.168.69.207] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c50f6sm5255630f8f.16.2026.05.29.09.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 09:23:57 -0700 (PDT)
Message-ID: <c8a7a19c-7018-40d0-add0-b4749196fa35@linaro.org>
Date: Fri, 29 May 2026 18:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/intc/exynos4210_combiner: Avoid hw_error for guest
 errors
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260529143624.158935-1-peter.maydell@linaro.org>
 <20260529143624.158935-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529143624.158935-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/5/26 16:36, Peter Maydell wrote:
> In the exynos4210_combiner device, several cases of bad register
> offsets passed by the guest are handled by calling hw_error().  This
> causes QEMU to abort with a guest register dump.  These days we
> prefer to handle "guest does something wrong" by logging it and
> continuing.
> 
> Update the hw_error() calls to qemu_log_mask(LOG_GUEST_ERROR).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3396
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/exynos4210_combiner.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

