Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054B5C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWPJ-00059o-6l; Thu, 01 May 2025 12:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWOI-0003m2-Sv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:04:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWOG-00052Y-Ai
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:04:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22435603572so13070825ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115437; x=1746720237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAQQqAYOWjU0mOUAHbQXE9k9QzK0nWc9RUyxH1u5zr4=;
 b=exPbzoO0NZpsmD0/RGXPNmLQqt7ZLPfy+sY7gXFMxuQq/xx/9STp6AioFxq/4oS32j
 7gSTTxcUlZ1zYpIq8a163ITmMsfentShry5eOMwj02y33J3AfP4Ku+xAylKGF/5KsSNn
 Znx5sPYy60838gIuwIQnbzMFEteFyLJVrCisf87qTwQW7ldY33zFGdVVnKAxDNEEV+iN
 rwtNSyRsOHSOrw9b1wUnc4clMgeaZxcKOJbhtxQIC5B7nrs5y9/IQmdG2EjjeTIwBCrR
 /qKe3s+/X/EKbPgC+txYKq0zdWHTIe1fDB7asCN3ndhMQuv5wUJSwSP7ZKh+YkyWGBQD
 AkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115437; x=1746720237;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAQQqAYOWjU0mOUAHbQXE9k9QzK0nWc9RUyxH1u5zr4=;
 b=GSFEO2FJdtzSaloZGSq1RxCdEZGL/4UKeF3aG2O1wUSwJ3zGkb0Rr3SdQSRRFb92E3
 Iwpb6gtm1LYzI2+aWfESbQI3vunaC7zgjWcXv6yUsufIevR+9uQlBFElI7e++r9vW78k
 M1TP53X79MH57cqTY5A+skb3i/0yO/vQkFsr7aBTRYqIM9s+cFBZn4wZQsmeuN0wCumN
 E9SNtXZGnPn/7xMdCQp0gUsvk6dcIHD23fvgpU37DDXGtV/4PcdNLpkOZx8C2depVqqE
 npHi9z0LcrdJURVcwAjFSuB0mkgTraSQJMMULHuAtUWOk9dByAYRxIqMMTNHpQdaQ0hR
 rLDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFTuiTZMOJHuF9xhp5fyrDO2OaMJcRoe93zuLCPfdKzYwXCSjVaSEQcruI8HShfi4Fgzbx/E2uASzK@nongnu.org
X-Gm-Message-State: AOJu0YybBmklV83b1e/FykqH9fmB0kgMavQedno0Ue+X8guZ9v4I76Ly
 l4m4wKUxc2v10ttKkWqbm054IA9kKOsBt0vkkp0N60pigt7gAxV0k6pHq+qrLHA=
X-Gm-Gg: ASbGncsEcvauzKAc0zFq9shM1zxU7FB1FVzLMKLzXgt8JYX8lqHZhDIuQatKYYMslji
 yJc73dxbOo3HAepWwEDxfCt8IEcATKZzegfVcf79u98vQRfofG5fopauRXk7aQcxxIzdD5OyAKO
 83zrgjR8fHO2dDUE1bOoNlKwZAYG1MjNpS7FP03nwdD5npd5eeZ5zscblNyEu//BsqQvFeixPek
 tA9iURJPlttumMbsF23Pgk0E7NeONz3aT5xLv7DnbPhkruVejRAjWMSIt0svSg0IV9MEsT2zGSA
 VDRNUiXQ27BxSC8GQ9grsbQBKSCoPk2vNgLESOIs6gj3puIeexGCaw==
X-Google-Smtp-Source: AGHT+IE9AI+hs25MpK3qtVqNEEZZ+B3ylaG8sAwyHGVYzevgRuuMsrhIWzk2/DtsdJDl+mdy6VToWA==
X-Received: by 2002:a17:902:f649:b0:220:e9f5:4b7c with SMTP id
 d9443c01a7336-22e08424f3emr49535195ad.17.1746115437376; 
 Thu, 01 May 2025 09:03:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc6d4d7sm8366285ad.129.2025.05.01.09.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:03:56 -0700 (PDT)
Message-ID: <33995845-a60a-4693-9234-dcc03d97217a@linaro.org>
Date: Thu, 1 May 2025 09:03:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] accel/tcg: Move TARGET_TAGGED_ADDRESSES to
 TCGCPUOps.untagged_addr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  7 +++++++
>   include/user/guest-host.h   |  8 +++++---
>   target/arm/cpu-param.h      |  7 +------
>   target/arm/cpu.h            | 32 +-------------------------------
>   target/arm/cpu.c            | 27 ++++++++++++++++++++++++++-
>   5 files changed, 40 insertions(+), 41 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


