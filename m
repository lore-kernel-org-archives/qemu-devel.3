Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1BAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1S2x-0005To-Bn; Mon, 29 Apr 2024 10:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1S2s-0005TS-6Z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:31:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1S2q-0003PT-8T
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:31:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed112c64beso4249465b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401110; x=1715005910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vVVlciNyyHz05moZPqH/sIOHSJLJFS8Ha3JikjxVKbU=;
 b=iO28lHtPoRNLgyMR4Pvqz7Rafdq3s59emN7UKmcLz7aRwcCKBxU3GBQ/CBKw3PQSGX
 cyfxmEK6G+K4umVeMxlQRaIdFGrPizk9lyriq+Ms+BFqrUXXNueSQXwMF6yHQsErRGrN
 m9md8n4gSCGP/pW8i7IsWdmaOoR/wIDBTgXhAsqMSv0E0cdonXG7wCnvrPQiqV+Bhvjt
 5oGAelRQRuyDhmWIY94Uuj/Bs8wqy38/O7QDWQofyAtU76zqyO9w+1Y8LbpAXfvd1sMc
 aeVTNVKjH8stVCASE581u87RjGOyoGSnL56FwUtnWnrLqbSuF2sqw+C/lmHA+Fb1sZCr
 hBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401110; x=1715005910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVVlciNyyHz05moZPqH/sIOHSJLJFS8Ha3JikjxVKbU=;
 b=HyW5cobbmOnvw5Z4mu93XCXBK17gQvGy5IIrWBDd7pPKFUdp1pqnypS9dmGYfSz3Pk
 cmrgqvNiVhv+LOQ95bmOQTLmt0J+tFGIbkG/dh0U+VCduHILeEm7KpXxDIebieUAw/fO
 fvgQ313Rwh8PZpCfU1eM/sGEe4kAFiGkZWQkyOri4GtdOizrujjWMnghRiUS1AotkT0h
 lpOiJXr68rgSeqxGjt2tBST1djttideRuLx6AMXM7dmKfMyfNOcgjZdROAEkmgiV/P7g
 AonnzbGYlDj+25zDeSuEXmDc3bifEbCB8ziB/e7MARlMffV6Y7PNFYoi3wcqTM2Dg9zD
 PFAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBQf4TJ3M4dPwVgURXKRKOuwMD/1sdu3BnzyD8o5sNX0YSj6/eDd9gbR0uJ5Hxejtdl0DR+9jIN8PH/vhDajDWyODTZWo=
X-Gm-Message-State: AOJu0YxSEjc19oWHSBueS4UJrDq8hwpTUJHpC1wdR0jfUQs5YjHzHiwf
 ySuYxvZ7Bx5guLYLvRENRVGd5+Q5EPXvzn3kFyjhOsutYYEbCkNn0NWGO3bMOA0riOuKbDIAGlA
 k
X-Google-Smtp-Source: AGHT+IG31B2cDQhdEwhbCnFzJDbXqZQpEufK25a3r36b6d/r5Tf+KNpk6mA8ltpc+SHJq3xQEkQgOA==
X-Received: by 2002:a05:6a00:181c:b0:6f3:eaa2:539f with SMTP id
 y28-20020a056a00181c00b006f3eaa2539fmr7914290pfa.16.1714401110119; 
 Mon, 29 Apr 2024 07:31:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h17-20020aa79f51000000b006e71aec34a8sm19301398pfr.167.2024.04.29.07.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:31:49 -0700 (PDT)
Message-ID: <a2ecda7a-20c3-443c-8dc5-d6a040e6157d@linaro.org>
Date: Mon, 29 Apr 2024 07:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] accel/tcg: Move TaskState from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> TaskState is specific to TCG user emulation, move it
> to AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h | 6 ++++--
>   include/hw/core/cpu.h  | 2 --
>   bsd-user/main.c        | 2 +-
>   linux-user/main.c      | 2 +-
>   linux-user/syscall.c   | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

