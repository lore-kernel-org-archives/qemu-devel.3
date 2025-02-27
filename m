Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829BEC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tni0h-0004wC-El; Thu, 27 Feb 2025 12:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tni0d-0004pa-4n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:49:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tni0b-0002ot-0h
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:49:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220d132f16dso18557935ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740678555; x=1741283355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gpVXUC9D62GEd9Dp8sCbHKDAhh148PxPU2XID+oMK00=;
 b=OHx+vuJpejtibCFI2IngrH2H0mUKvaRTKLahl2ayOX4fAqbt7JoGCxqzDPxmX+FhR/
 DscIOjulOOx775k/A+UIqbkxnA2L2OCGNOc4TCraQ+ae296w/HuFgYQDDLTHYsaotA6v
 L+6ftR3TLG4w4D+f0XUg5wIq7qEsUhLmKjZ6XSJhm93Z54oCjmFhUaY6aFmD8QCW7PYW
 nTPVO3BU97WSkUv20m0EtZkl+s+qevlsCz/6AaffGXjq3WRyvXS4g0ybwzy4axqxb2Rk
 XrO9d5VdhVDEB1mtWJgDCejahoztCqxllJyjTgtQZ0yiorC21QKGdFKKql/u88ZXaFH/
 XDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740678555; x=1741283355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gpVXUC9D62GEd9Dp8sCbHKDAhh148PxPU2XID+oMK00=;
 b=FHtWmXijI2ivjaT57j+nCndgkqfoO6YJmZdqmH0S9Dt1UXEs1tdndskHksfAr3y0cN
 axFJemYOkORoOjMabiNtlDzGKt6kv3+3iRy+v2hx9YpDfcVFD7eBlnzpipXsPL1MPJzs
 hhJ+P/UMUELY3rubFBLBFFdhPdBuyK/yYiNBZ6+ByyFl5VC9TKSNkzjNiV6Ngj6s2Rdg
 3Jz5lptIjIkruZCaB/dU8TfCKH/K7xhNk2W6MsEccz2yerEJI0MAEwOgUCvsZ/AMwrD0
 zpftMUGsqPxxDIzsFbA7/iFTdeHOA91wctNS5npp31E8LMBcwxHqry9qnewGEsJLAUWW
 MdYA==
X-Gm-Message-State: AOJu0YxqpCCOFTyZFb8OrCNp09r5FLo5iWHuobOQlzc2C4dDlEozr6eU
 ZTD1118RtvmMCRTu52NGfKTvHSWNsK1zwoqofmfFHHgalIBCQ2pUVWH4a6VK1VYbL9FJkSrzxSq
 C
X-Gm-Gg: ASbGnctmHtQWUuIhWfv3r8T/LVmlYXVbAtD5bswSRTfrsXMwNfJEudjw0tyi2uQ8Z11
 0wXgrbLN5lBUrcRwYLvBV/d1/pRrY0fkOmqL+TPixy8N4iDAjtk6nSI0WFUvkF1A1BJ7Dx1lSq3
 FPtN3VrxHoeKe4c06NGI1uI54JdXF2PeOdWLGrZnWeCVM1st1zBWu5x0ldzLctvYqMqNhCwBvwb
 A7Mpsss4IDvq5uJOMNCckpcFecjVZ8gavic1dGCewG5LIJcXA54AZP3xJ9IAULtsh8XIyprN3q9
 M2WFHEDN/4S9q/rrshuYxvEBg8FQV7ZfxCXv8Fov3niiwWU28WF/BG9cliQxgFZM4aLjsGUKvp0
 6pLYtZWI=
X-Google-Smtp-Source: AGHT+IGWuugfQSB2ujo8A3zvr8AYxzl+wMvzgbmzil88QrSWJ0/oO8R7KZE1MxVDfLnrrVuNjz5xeA==
X-Received: by 2002:a17:903:1b27:b0:220:da88:2009 with SMTP id
 d9443c01a7336-2236925d082mr356205ad.45.1740678555079; 
 Thu, 27 Feb 2025 09:49:15 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c5bc6sm17604905ad.126.2025.02.27.09.49.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:49:14 -0800 (PST)
Message-ID: <23ce78fc-c4e0-4279-94ec-199a4ef90d81@linaro.org>
Date: Thu, 27 Feb 2025 09:49:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/arm: Remove printf() calls
To: qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250227170117.1726895-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/27/25 09:01, Peter Maydell wrote:
> Peter Maydell (5):
>    hw/arm/omap1: Convert raw printfs to qemu_log_mask()
>    hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
>    hw/arm/omap1: Convert information printfs to tracepoints
>    hw/arm/omap_sx1.c: Remove ifdeffed out debug printf
>    hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

