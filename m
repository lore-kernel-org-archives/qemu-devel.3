Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFCAF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQPE-0008OM-B9; Mon, 13 Apr 2026 19:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQPB-0008L5-Vv
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:09:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQPA-0006xz-JO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:09:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso76997315e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121759; x=1776726559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwFZ1UB1Z24/RVCrJPQo8FdEDCjxtQvwKJkKFTsE7bg=;
 b=HdT26UVZLsUVs0iRufgcCbY8YQHIjcmz/JVs+j0EQYNTUzymwEZHFcgcy3XB3I+IP1
 t98MbmClL+SerZnUuQbD85p5j8CMMnWWEEGDApETrPGYeYloyC/Rh34NbIfXQxLSWahv
 1x/2AweZ8ZpOiqakW7Dhba9prO1mHXk57sBaRKF48XO+Xv9zjoPefZFKzz1ZADAfYRAj
 seggs6q0sxlhAJL3uryU5QH9xyk4EZYX/ofZuXBVztamSpGwda+uEDz1oIVvv3TPYGfh
 BN0Lp9Wcc4haXKp9xTP6toMi94Fv6mN2R9XBzjWD8R3L2DPl/8jjfLJ6vg8Lr6fPJasr
 Llkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121759; x=1776726559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwFZ1UB1Z24/RVCrJPQo8FdEDCjxtQvwKJkKFTsE7bg=;
 b=lZJTkySNVtpo/LlNqb8jjHsg35c1+RjO7QgQnfjlpvGdEIsU9ZnWUWkBh/HLCC7Noo
 ib/O8QZSHu2OwgPH3VQcymwAbGIVfJVHKMVRsi/MsGLi6NSfqXqOXfhEq2hxqjHaymL6
 GcHiYcgELTgfHzZQ0Tp4vJGHVYgGOJc9Tf10mrNH2uYb9tXTCw33a+vlIb5y+Qi+udET
 NH7h9qu8/VounNc1IAWv4RMVqlApDzBbJq3+pSRWLXzUE11l6e+BoJS+ik/PIuk4ZRmK
 86H6Prg3CPdMwpZ6bIYnUdnMuPK29wbOz7yEfRvJW1Imx9ZF/nQdj5Z7tHvlwLYyQz22
 5bjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k7tNUtLfq6/tDtFMZQTzaKueHWO90aMfg2uc+Me/Y24Q2gop8CZNUUE+Rr0cbLobNRIxHybN9jZzF@nongnu.org
X-Gm-Message-State: AOJu0YyM3VWKo02g1AEE0chxCfrZkrbIYbENCasA6C/eCJAB2TrboC7d
 TfWSDq0GYISgyLSk8lPMkSYW99QT/Wo0wBm32qR3RApL5KPQzI76xgY1ypY+fPHVhtMj6Wejdt7
 fn5JcjNM=
X-Gm-Gg: AeBDietM2KhP/9QICNFy3TchFGw3YER6lRNy3wURyv2Zi7ej5G6ZOqYfDhkjkjmWEOn
 imZ5iqJtJN5zy0pwT4Eljpikx5OMncWn15P/Jo/2UeYL+6P1vFEgxZaGhdc8dDaz1wz+COLU9R7
 nOfEyQW0LhAydBThunhGZyPsczoi3dmkSbCm7pEU4Hcm+wL3yTQCYp58KxJCfSheT6lyKeacn09
 jFP8ec+k+Is4cy4jT9q2OjuVpSm5izBcKzMIymczQaVCwrxA5+hDSh0FTcY81YT5gf+kogevzzQ
 hj6d9RMbvYpmRYMnA81G7jY3oCbG8cj8Bfk5PuPArqoJpvh5JT8s60Z60QVj0QyZi6Xdkn35o/P
 AMo2bnjDV41cWbwUrpn02Im7kqcG/4ggviCd8dM5QybO97np7EeoV9eXkUzBrXnRB8BLnsm5s7Z
 BFbtjoMZWT6Ye+p6O+jjr+vnUxVlo26FmQ0w4doDUvKPSMVagMZkvmuw0cvtzm9NM3UA==
X-Received: by 2002:a05:600c:1f83:b0:488:a82f:bba9 with SMTP id
 5b1f17b1804b1-488d6864dd2mr205247975e9.22.1776121759078; 
 Mon, 13 Apr 2026 16:09:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019e44sm2888285e9.15.2026.04.13.16.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:09:17 -0700 (PDT)
Message-ID: <2fd0f178-e4a1-4e8d-b159-d1f278bb570d@linaro.org>
Date: Tue, 14 Apr 2026 01:09:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/65] hw/intc/arm_gicv5: Add defines for GICv5
 architected PPIs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/3/26 12:16, Peter Maydell wrote:
> The GICv5 defines architected numbers for the PPI sources like the
> generic timer and the PMU; these are different from the ones
> traditionally used by GICv2 and GICv3.  Add defines for them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   include/hw/intc/arm_gicv5_types.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

