Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5728BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OVk-0005A2-Fb; Mon, 29 Apr 2024 06:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OVf-00058j-F3
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:45:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OVc-00044S-RV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:45:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-418e4cd2196so34748205e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714387518; x=1714992318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0rberOqdKiMqtwQWqQiYoGWM6yI7HisXIlPF+srG68s=;
 b=cUHcCDLrzhj6en06Jldednv2GATK2VE2G0KG7LD4BknLJLfl2uGKjazhG+3jeWlpfB
 zILhf+19TCGjkNTxEJRajeFiXZ6HAAS1Hntx/G7BS5Hm8pY3vv3kvfR9fWwC7EQMk8xV
 V/ayQAg34wffYinJVijABnHU3cIwXqFNpqRZ/MJgDpYpCUokg3V3breyceeeCMuPAr13
 ev8L5KF3/BLAdSMitMTXcZpVmqCayOBxFVIZCHyvoAXGBtE8PS8T42SOX4TM1b3Rd3gM
 41x83YkZKfk+B3eTd2H5QcBU/egD0RS7E2VAuC48cJYZ6aTpTk2iHp8S1+5Rr/0e1H5g
 iGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387518; x=1714992318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0rberOqdKiMqtwQWqQiYoGWM6yI7HisXIlPF+srG68s=;
 b=Gz5iFmO7NRtw7EZ0ECeUrYfNVIgde/GS/c1JtuD1M/FD4+L6o0wGldvqn4dJxPvnDC
 ZhWqTrPJvAbB+8Dp2VzaYedYhHvSb3OSwhbXzToVDO6YrABSrr/W1x/A/MYPvsIMSExO
 1O9EkPz5V3GNgGVj19px/BY7ZZW0m5RzJO9sRnt8epf6RASnWKfUlRQkztcRERNMGShe
 uRGjFXjAvQtqdCuQF5AU7oXtQJM8WNAI3PhXj4x3kPgGzWRMGA4zJAZO5X8wJjUMIORf
 MHVIqFw/CG76HpFScCTxoHS1a074ZjQkj/TKf+ixLrozx3yW9bfBrQh9ccFNYrapZYj3
 xxmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT/uw/TQUFI+mADK7m+UKBPvG/xoyu9t0b7tFSb+I0U9I4b7Vgj0/ZKlMuuC04rM0nKr1qLs3A4kdhisnlP5zx0lYWMPs=
X-Gm-Message-State: AOJu0YwYdUSz7wQ06HndRQaSvJfGdAo+uCGuB38c9V2Rz5Sz/YMFlrSE
 zUXsYJ2asegq2dOX56TY13tw6PIj5SrKrEO84QZ44udlay5iVGlLLtaKQtukIXg=
X-Google-Smtp-Source: AGHT+IFLYVA0IWNacCWBLDgdJYqYzq/Y24Dt0MryYQzRkCWbR2PmE2TYqHsv+op+b0x6wtiUAyMQaA==
X-Received: by 2002:a05:600c:1c10:b0:41c:7be:851 with SMTP id
 j16-20020a05600c1c1000b0041c07be0851mr3523208wms.9.1714387518110; 
 Mon, 29 Apr 2024 03:45:18 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a05600c4f1000b0041a1fee2854sm30157818wmq.17.2024.04.29.03.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:45:17 -0700 (PDT)
Message-ID: <41a49fcc-66f6-4839-93b4-0a10f7bb1c46@linaro.org>
Date: Mon, 29 Apr 2024 12:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/33] plugins: Read mem_only directly from TB cflags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Do not pass around a boolean between multiple structures,
> just read it from the TranslationBlock in the TCGContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/plugin-gen.h |  7 +++----
>   include/qemu/plugin.h     |  3 ---
>   accel/tcg/plugin-gen.c    |  4 +---
>   accel/tcg/translator.c    |  2 +-
>   plugins/api.c             | 14 +++++++++-----
>   5 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


