Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B4AC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDwf-0003JG-0W; Mon, 31 Mar 2025 08:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDwY-0003Hw-OY
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:08:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDwV-0003S0-VX
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:08:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so24616275e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743422918; x=1744027718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7K/4GPWGIZEu2YallF2JHPPsSY3vBicgLVyIy98Zowg=;
 b=wq5iJZBxdqRAT0o6reP2UtXgZd6KWZWfr4aQwyG1oHpTsSXyjNmS1ZZ+7sT43zF9a6
 OEp1kqX6tkapnDb+MvuHCoFr/AZ7hfuxqdb08A++t/OKt0psT0y26kiuIJUyKDnm8FPd
 sSEHfy2bxNEILT2Q8W834+hUzoi9Lw4L9uGTSyMiqLYtPEFUlySFOs1/YzKlO/g5trMD
 EwLsshQ92f2Lfd6j4mmJNGWm2z64QU426k/3yDPYxAfoNfJt51Ez96jJnfKLWVQaJ2tE
 G2YexYZTpNWheJIHJWtUarvTX9om/TiQD4mahe/labMt6nRWiJv+Wifo1mVSUCYB+8EB
 s6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422918; x=1744027718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K/4GPWGIZEu2YallF2JHPPsSY3vBicgLVyIy98Zowg=;
 b=fZMQYaOYazRwh9om1mCb0fTtPY6HJgpXH9qmPmybUE4MNbdp60MX4qmTJToJZiRPvm
 9qwmKi9kTtKBI0oTwoItVpI1gzB/IoGUPju2f6+SlVXLotI5QjqSf9SWcgGL8G8I4mGJ
 +dN+dsipRTrkLgBSMHId8/v00D89Kd5IbiOHLybxmtNGaUeTMpzmtSulyTvzpPAuHPBc
 d0nVKEoL6q4s6zPHrjFLjSs9GfCYg5g/xGYqob+bFGY5oumzJkIelCqM9B6x4FtIObLl
 3qGeV3YP6EEpGBd/mjNeBJAHBPlv/XqmuDIUhWDKKlXJmFxn2/ew3PtucUtOfpD3n5B/
 DSgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWiUHPxiW6sXWrOXKRCeDgMYj/13b+lrqd9DRYeBfWnGyWOsHJTqY0RQky0W9Y7LM0qIT6nlpXPXvc@nongnu.org
X-Gm-Message-State: AOJu0Yy9Ayk0l53K0Rx6r0zEXU+DC/6sU/aR9G3GDZoot6a81O1GIIe5
 eqcF40/zXYEMK7UiKtZ8FGzJH52cTuwi0hpI5GmpJ6PYciXri11Jc9lkiWnnGgY=
X-Gm-Gg: ASbGncuaJt3ADHt7Pe2/CJy+R6oc3rrOSZhBNR7n5mlw/y3+ol/t056PssES0DyunRB
 pNk5aszSwmbPuXwkk5a3121Si89R8O9AiDgMasZcc6l3kFjoBdXuPBQUn5db9eb7C3Ip8TMjOoY
 rB7IGmwZmNpNgSrYXiBU0gjHV4GAZTLhqEv4UQSK12TsMA4cWqInbNzd3ZLGpMJXbH6YjZTFOEj
 2xMV0bUgb46cKz4Qk9RlrdVE078gs52Xq4xZr6Vj0k8cJbUTPB85RhyutAekKpcREjQeYY3V0dq
 hUQCkfaToI+mNfchYpTg4MZlb0Lbaj6Zer/3mwtzMvsYN3ydaCfRBGo5Y+lVr01GPju6btPai4Y
 Y78INbMyFzK8a
X-Google-Smtp-Source: AGHT+IERudE0c3MqkTsupD9wPvwN97BbjuKs07vZOHd7x9shbaN87Z2dQ1h0wlK/AWVuZTLQe0E9VQ==
X-Received: by 2002:a05:600c:83cc:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-43db62bc26fmr66069065e9.20.1743422917793; 
 Mon, 31 Mar 2025 05:08:37 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e393sm11262945f8f.72.2025.03.31.05.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:08:37 -0700 (PDT)
Message-ID: <c8657538-9ab6-4b6b-9198-2339a37fdb56@linaro.org>
Date: Mon, 31 Mar 2025 14:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/ppc: Fix SPRC/SPRD SPRs for P9/10
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20250331120357.584561-1-npiggin@gmail.com>
 <20250331120357.584561-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250331120357.584561-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 31/3/25 14:03, Nicholas Piggin wrote:
> Commit 60d30cff847 ("target/ppc: Move SPR indirect registers into
> PnvCore") was mismerged and moved the SPRs to power8-only, instead
> of power9/10-only.
> 
> Fixes: 60d30cff847 ("target/ppc: Move SPR indirect registers into PnvCore")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu_init.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


