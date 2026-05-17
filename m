Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB48BCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOezY-0004N0-MH; Sun, 17 May 2026 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOezO-0004KR-MZ
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:09:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOezL-0005gd-EB
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:09:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so1210922b3a.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037754; x=1779642554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=he1Dyz8R7Mm7MJs4xXs6q+UXQpQ1IJghuaaV0vDa/zA=;
 b=Y5er7xqz9f/jiSCHWx364HUj8ElONjQKU8XkhHdfg2gY+fsgW2wTKpfbR3nLXdxmzM
 N9yl97kba+ygruICWqyKvHT2IsxK8d37Ki7yR2rwnr0sdwrca3NeZNQrzm21A9Lu4uKF
 vNTA+zyq8Q3SdZOecgaripoYNxg6G4uKvscXrw6lIt4kTZF2bIGlIlwb424/Cdq/tJSP
 OQo6P9FKBtzPQUjOpTVIXZ3yVhXovYwIe8H7lwwGzFu2QmwOJEiGJRV1FRPl2BGGeek1
 sOsNuuZRhdagZRYyZH/A4wMlDiqHQabitBHXQWF6Ntw9GXh5aCnnSwL/kb7UNF8nAJ4E
 6X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037754; x=1779642554;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=he1Dyz8R7Mm7MJs4xXs6q+UXQpQ1IJghuaaV0vDa/zA=;
 b=KVvbXzmfjrOoIXIdumBxeOUROIxFgbc0Lnj0cmGLrs6KNFPX5DtLjvBF1gBCw2kAGd
 8rwp+p9/pDg9waSP9XPvRkNclbClS401Xk3dkK4TLeGOh5qXrt7Iu2rZ5gYQxfM/u2P/
 XPUUTCaC7CJzMHU50w6CvBUjHub2Y30JNtBxpw20aAh4E7qWCjeH1q6cyA0rw8K8ROA3
 DFQjfcdRn4xnQ0X12e17XeJYYA8ZmbKxZJGt/hx2pgGzNwyWQaTRwkBReGym8Ncyo6iP
 J5ml5Ei+Tru9Lp+ngvFVZa/NkxYJ7WtY7uwbezS7lnbHlOvw3OXQqSW9QDrK6Wo5aqf0
 LXMg==
X-Gm-Message-State: AOJu0YyMOH3YFwDaHdGyHHaVzOzGpjDS7BTvIEO/4t1aDkrxmn6Sp+tz
 rkIZFabWE4A2uLLDp1hn5X+OHhu00v71XwjgbJOAh4nHrfF6DRz0CBdysY9t/3t/1mPPBtQq4cf
 i+Qbd
X-Gm-Gg: Acq92OHxcg8P94U2766eikKtuaFj5Z1wktHcCnSecVXN3Xz9QZbZEJy4O7+kcrOmD1w
 Ps2BkZVtS4kTUIMfuYslbiTkkb5Y5JqdQEyVKF4mF82diYSzYKEEvFosOo5PYYZvwzqghl66GK0
 qVIQrAAxsswxdKyqVdmx89fHb9R8faFI9bzttFDrqPnhgyURwsXFhKgb/Xlir4i9LcualFXW/2e
 6T2dL1iV4jKaY+fzh5277vSq29Zp85zpFu5a0To554oXHMNEiSJIYcBQv/46Vy2LW9aAmRq5SJS
 S4f0M9WWwMIgkEAQzj6MmE9dvws3ti76eDnqsGY54AAqsSRXj+sbSoztJBVB7SuBf5AraO6VKhH
 vOwZ68AZz9MIMmJvySJdpGaVtpd4JVxu6GqYKQz1jx640eDMrnnURvpp38KIw/WnSpIrnSn0yl9
 IUvu/X+Wos0SH3DV7wQQ3p1ttYBOdoZA6PzxW9
X-Received: by 2002:a05:6a00:ad87:b0:82f:9e98:1356 with SMTP id
 d2e1a72fcca58-83f33ce6a1fmr13091752b3a.20.1779037753884; 
 Sun, 17 May 2026 10:09:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c77162sm13002134b3a.40.2026.05.17.10.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:09:12 -0700 (PDT)
Message-ID: <a6dd5d58-a81f-4f85-ae5d-566922b30569@linaro.org>
Date: Sun, 17 May 2026 10:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] hw/arm/omap: Delete unused #defines
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> Delete some #defines which we no longer use because they are
> for OMAP SoCs which we dropped support for.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h | 185 ------------------------------------------
>   1 file changed, 185 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

