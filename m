Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6578ECD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiA0-0004Ae-R1; Mon, 08 Apr 2024 02:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti9y-00049u-JG
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:07:14 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti9x-0005gg-6I
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:07:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a51c8274403so132869066b.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556431; x=1713161231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrNGz3fFUSXNpSclLhBqxoUlkGc8I5y+gs9scffpAY4=;
 b=iZ346rHLeZj85jpOyS8rOhmzUdfOjcQNg4XSL1/DrJcVqjS1AJQKGUhXNM4wC+46Cx
 R/p6c2fahJvMv1bBfvXKx2PzqYBBsY93XjguNlKnnMRM8VT7YUr4YLmWUnSR+2tGJcV3
 j4aDDXzFwq/RqHemGKFS3J6fPBW6HUjkF3RgFg2h6utCitopbQRpVNp4gCfwGwDhDvgp
 0X3B2WG+TfPESYwS3CIO8Ne0O9KIFqpqWpj3P3NsaIVBY62nF3IE67HnKjX0Hgv+40Fc
 ecO9j4Dq/gAnNSQsixyRfzMFQS+cy+4LfC8MnKPUibiutErDlcmuoBBWlF9PdTmJhFdn
 cMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556431; x=1713161231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PrNGz3fFUSXNpSclLhBqxoUlkGc8I5y+gs9scffpAY4=;
 b=TPmE/69KJXT3kwNmBjv1AcbbgS/65yU9+7vVDyz3GMdx04UkjdQKEiNKnmorU1Bb8t
 EePc5ECoOFIR0jwJP1t7JKxyzB2xBxNwgGpxEdBTSJgTUgrxcSTxiM9cJmUUrmxfiSDG
 BFsRiGTn4WUeTTxJyPttaWosN31xpe+nKg1b0iN65VsN08zDWkyS0VKuZC2vsKWFxkyS
 Vgym6vUtpVR0NjmrtWqTZ4EaYii1DyEpavHFEjLLjhuLlKXcaA+gZX8eYx91nrJAb5mr
 HBKqhOMiECgj9fIPIbvVd5VL4sebYNhWfoG62IDS//T2zAuG78PVg1LeUrx4qKDW/70Y
 pznA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULPBbVnGFY9yTKCXyx9907IZqGaR3uHbti4V/UWHCvD14J/HX8OMdBQXyWXGT7aSS+dU53J+OyoDxv1qWWDtCACNYYSg0=
X-Gm-Message-State: AOJu0Yz38hVLc59xx9/M2fubUrvWfOAdHc8cNpLOfmU57dJ16J8JKgir
 O244QofVgA8zcy/l/iBGkGVa6k1alOOzogJmuROTLZ+NJeOmUY8FFwC8u3wNoSs=
X-Google-Smtp-Source: AGHT+IFE5bxuSyaggZOnxU2am6ubk5YisIjlaqtJEL7xfGPqBq3rIvXo0Sc/hja2jjAXmiWILqBb/A==
X-Received: by 2002:a17:906:c10d:b0:a51:b19d:b1d with SMTP id
 do13-20020a170906c10d00b00a51b19d0b1dmr4724672ejc.33.1712556431662; 
 Sun, 07 Apr 2024 23:07:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 xi1-20020a170906dac100b00a51d3785c7bsm1113761ejb.196.2024.04.07.23.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:07:11 -0700 (PDT)
Message-ID: <36a5d37e-495b-4164-9882-7a5586ea740a@linaro.org>
Date: Mon, 8 Apr 2024 08:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/sh4: Merge mach and macl into a union
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zack@buhman.org, peter.maydell@linaro.org, ysato@users.sourceforge.jp
References: <20240406053732.191398-1-richard.henderson@linaro.org>
 <20240406053732.191398-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406053732.191398-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 6/4/24 07:37, Richard Henderson wrote:
> Allow host access to the entire 64-bit accumulator.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/cpu.h | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


