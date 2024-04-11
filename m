Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9FAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv0nl-0004c9-Mr; Thu, 11 Apr 2024 16:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0nW-0004ap-Hq
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:13:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0nU-0007hd-Ak
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:13:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e504f58230so2093495ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712866403; x=1713471203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFX/sl7xJ0Uk86tSI51fKGf1ykvVdP9omN56kE7qKv0=;
 b=Z9pQeDSxxkHTnwmr9s3ZLU2JtkY7Ellf9x4d1THuZaNHnTUZfrclhekXzX+wsFidX4
 8Ku3MxbJo/rhGIDhTXG7qauwh/xdRMVv3AWppeADkjPFu6LkWp0NiLNQ5841DqArRWYJ
 LCmwN0+Mb8ZfAvI4+kGQSPgAHLej3ehdSPkZvFZ6KF4vZ4+SY/zwnSrvpmuDZOzfVwdS
 rUvk1RNGpUh6EsqTGtnIva/z4dXjlh8ErP1B5Pd/xFaIPO7ulJWNZOw9UdEVHEOpQ8Zr
 9XzmFAm1iKw7J1HmqWUv8e9TxHazKkvXQ0sqH/xWEzI1FWb6bkjHwv/57WSEfmml8fcH
 lUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712866403; x=1713471203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFX/sl7xJ0Uk86tSI51fKGf1ykvVdP9omN56kE7qKv0=;
 b=snj7nMUgUKMDQIw57xsfWdDSNaC9oUTdhs5VtzHVhaZbwolM4v8jBMwv8//Rk/N7Km
 bnCZAChboTOLzLCtQvleImDZZpXOagcIfwPh0rPT3BhR50ORJID7rPtUsFrqJMmc/F4o
 +0dRevHKq3fHG6ErqdfPdE71L20herkZd8mz9Mq/X9uLynmRBilLthDWJUIzBUSlBUN2
 UTnINxnVGb2UFN9Rqc3QpgnIxqHvC+47oMWIh5iHWAOVDraZ3jthLRlxJ0ZjGek5xsm6
 buKp/vn2wrOIdLoPPcxuH3FOCW0CjAI+UvdmqgcH8Q46xL0+aOSm+x7r6Mw1uEhRaM0j
 t8+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl/6Gh6BANXaPc9oSzjXatFMq5WPHXSrDCX8UHRfm8SPmXdFRzozUEDb6lOoW51k0eSJdFnzYRExHUed4ajcq6ci+r2Io=
X-Gm-Message-State: AOJu0YzNECiP8Y7zy7ujxbIRYh+x5OXPVs69aBXRaRf3vD+730mawo9D
 2gq9/XXD0iViq6hzU3OpEZmryQyKOwH1NY7wmwZXQDZ5LV/TnnIzlM8iHSTZ368=
X-Google-Smtp-Source: AGHT+IGPnb6rLQ8m4Qg93NAPegoLnISObIX80ZO8jg3RxQLzDDmbjft1zuhdnlaau+PFVUEsKsfEhw==
X-Received: by 2002:a17:902:ccce:b0:1e4:62e2:fc86 with SMTP id
 z14-20020a170902ccce00b001e462e2fc86mr699234ple.7.1712866402829; 
 Thu, 11 Apr 2024 13:13:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a170902f7d300b001e290af5ec9sm1566304plw.115.2024.04.11.13.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:13:22 -0700 (PDT)
Message-ID: <8fd3391c-7515-47a3-89f2-49cf90b61ae1@linaro.org>
Date: Thu, 11 Apr 2024 13:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] system/qtest: Replace sprintf() by
 g_string_append_printf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
> 
> Replace sprintf() by GString API uses in order to avoid:
> 
>    [120/169] Compiling C object libcommon.fa.p/system_qtest.c.o
>    system/qtest.c:623:13: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>              sprintf(&enc[i * 2], "%02x", data[i]);
>              ^
>    1 warning generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   system/qtest.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

