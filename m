Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F32C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SqH-0002SU-9Z; Mon, 29 Apr 2024 11:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SqF-0002SC-Oq
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:22:55 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SqE-00063n-5C
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:22:55 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-60c49bdbcd3so1584070a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714404172; x=1715008972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWUcFOUQLwGApQaiCRI6B5NgGGxRbSHkPA/3dTGtuaI=;
 b=d2fDB0rlpKgGdQH3ONLZpbPwiznXDic81FZCukmuojDSxkbfG6FvrqFTxaCwYdy4Cp
 XeEwskdfvghPUdNNpd3t1JQhe/N2OBbfUR7IdevTD38pVvrJi9438PX0oACUNfu9VsPh
 2zgW7ZbgIyHUE85OewBLNtGfj2EiLU+7BTgtwv7+S/KL/362BP8ZD3gJ2a7I8p2FigTU
 g/eWCvlTNoe7ly+Qc+fAko0HOdCxRXsPbYGAece+3UmpE5nDsTGSs2PCB5xQDot6K6Hm
 Z7XTO6Gw5mBZsbJW4Y6Jdb0R8qFH4HlKH4f842tuF5p6qPF0hMScKTpgjUs6S4Tqo1Ct
 wCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714404172; x=1715008972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWUcFOUQLwGApQaiCRI6B5NgGGxRbSHkPA/3dTGtuaI=;
 b=kHSBNBMcKEfUv65iomd+2uJqLF45VyEEcIwCUyvlaW3izOjovPKFHv9scyOZYiHwIx
 5O6cAZGqtDInpMIjVzwlWVaIBfXZx3OOmC/H83H6kZ0s0xpmygyPsviElRJPTS+p8lzQ
 Qtlnzkp06m5h7RH3x5tqKdViIr32nf0jOemeivnzhc+vM/+/JshiVKR3OJpZpNwv8VLd
 7ztHb00LexnkA0welAi6kPUL4NJKz3XY/y6o5rkhjKXlA7viawxvmco8Whn7q9Awca8F
 jESTCavsQ1NXZKYDyu9su10QgKKcLvMqKXfIV6kZ9RPRDzJqs/Ugfmj2xSoZBNaFpHf7
 RUpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmTxCFpJ9OyMgRHdr+CVn795MKzNepEyUxs6anGlYw5BD1w3re4BqFauEFPTEo0pkU6/bdpVScQmC2M5aXkbXVluJ01yo=
X-Gm-Message-State: AOJu0YwA54xZhyOAbZKHENrLYZQH4hs0tIgGbpRPmch8jyMeUdjmxpbd
 ORKoxPLfaSueyuDFueajhVIg+9zUe67S7pZMCqmOBeGms5MaEtETFKMV7rcFWNQ=
X-Google-Smtp-Source: AGHT+IEmHgYSidTMDMYrZgJ/0VvxKuUrAMKZIDSvRQwOegrUi8nj/MsDsG2Hd83rAt9G6Vtd+piGXg==
X-Received: by 2002:a17:90b:3b45:b0:2a7:7a8e:bdc2 with SMTP id
 ot5-20020a17090b3b4500b002a77a8ebdc2mr7113879pjb.9.1714404172616; 
 Mon, 29 Apr 2024 08:22:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a17090ac88e00b002abb4500e97sm19335903pjt.41.2024.04.29.08.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 08:22:52 -0700 (PDT)
Message-ID: <af0fcbf5-1c68-471d-b1af-477eb53e4ed2@linaro.org>
Date: Mon, 29 Apr 2024 08:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] accel/tcg: Move @cflags_next_tb from CPUState to
 TCG AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> @cflags_next_tb is specific to TCG accelerator, move it to
> its AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h    |  2 ++
>   include/hw/core/cpu.h     |  1 -
>   accel/tcg/cpu-exec.c      | 12 ++++++------
>   accel/tcg/tb-maint.c      |  4 ++--
>   accel/tcg/tcg-accel-ops.c |  1 +
>   accel/tcg/translate-all.c |  2 +-
>   accel/tcg/watchpoint.c    |  5 +++--
>   hw/core/cpu-common.c      |  1 -
>   8 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

