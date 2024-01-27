Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FECC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 05:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTasU-0006RZ-UH; Sat, 27 Jan 2024 00:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTasS-0006QU-JX
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:05:12 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTasN-0003aW-Tn
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:05:09 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d835c7956bso693416a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 21:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331906; x=1706936706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=socohSUVvLUt9LUw39oZmL14omv8AfTWGiDRd7J94bk=;
 b=lozZ0xgXkoN1P773xjPSbiyY1HMosUdIdlvFKubs0AXZhlgO9+gvoq7QZsV9tTWNoN
 7HaQYDWSdBDqF3avvAcGK47BktzaBl2D7PKsYozXNMNGfcejgw5vAu/aa8aZK97qHr7v
 84Q/2rPfRL8hmK5QBbZPyn/j8WdCHoxos2Hg4MgzerpiqQWva+Hq/FbDpYELCK8ZlGjA
 PhSCQBt3oeabQMnBoKCzWUuTfgoCzIw8JV2CEROskkvgoxPVRxUDFrR7ORn2+/FSNnrZ
 gZayVJlUMkwjGmkFJo667qIRaevBFrA48PQQm3GCX3QKnkHxN+57NMGISGqKOXvrhfNc
 QENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331906; x=1706936706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=socohSUVvLUt9LUw39oZmL14omv8AfTWGiDRd7J94bk=;
 b=ptdtrW0XPdpGJ5QozbXAljD5yNwlvQ6rcQTCOnIIM5QDwbpB0b7FfKyQ+0m9w14YrU
 a8zjndyYqsdKCRdWlrUmkWN9KiRZyh8j/2RN8q51q77O779NMOm/CMuYJoRfCoavUJha
 mftSKzykT+X+11IqJSmRuEMrpLUgi8dfdkbNNhkwv9B6+4IvvkAd282hJEdbt7j38TZR
 paRTZVA5o+M7pfWBXAwxgIbTfRUja2n9cnItoxdrunlEfVcDivpoitJ/aNoZhL3HDOVq
 jja+dsPAa+cXv3WTT7mxZijmXPrSih5GPRXbrEo5WKOU1r5PEsQJyOAj9TjFT8nNZN35
 gIoA==
X-Gm-Message-State: AOJu0YwVX4Iz21v7gNVAgHhAMsIJSrCTreTjEBwAN2Ml0vl4UUd5AzCk
 MoupcEmu3MAXqsQWjofSkbOeNbh7dUUbj0DcW95aL1nCNLmvbN6Ctj+lvSij48Y=
X-Google-Smtp-Source: AGHT+IG//jn0QZyv/Eu6SL+erJTsdqUBcndb0/tnZU1D3mIuzhPHPx8KxPh5RO6cU0SNN0C83VBQsw==
X-Received: by 2002:aa7:8457:0:b0:6d9:aaf1:d268 with SMTP id
 r23-20020aa78457000000b006d9aaf1d268mr517873pfn.69.1706331906261; 
 Fri, 26 Jan 2024 21:05:06 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa78683000000b006ddc14c416dsm1974542pfo.95.2024.01.26.21.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 21:05:05 -0800 (PST)
Message-ID: <ef75fa7f-47df-45f7-8310-ae329770092d@linaro.org>
Date: Sat, 27 Jan 2024 15:05:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] disas/riscv: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125163408.1595135-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/26/24 02:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git disas/riscv disas/riscv*[ch]
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   disas/riscv.h          | 1 -
>   disas/riscv-xthead.c   | 1 +
>   disas/riscv-xventana.c | 1 +
>   3 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

