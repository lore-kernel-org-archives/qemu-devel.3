Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBF0C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 14:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnJ8x-00055g-Ay; Thu, 21 Mar 2024 10:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnJ8u-00055Q-Bh
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 10:11:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnJ8s-0008Mf-0z
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 10:11:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4146562a839so7296655e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711030294; x=1711635094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N4UY9dzI13Ko2/xHkiCsRocTYu4UJTQzC5X35sf18eA=;
 b=YpcDdLzTtPHTVegRp/G6rWRSYyc+F13TVzcha+t2+5tBXqzY/Pjt6An8tH/CkDT/pn
 ezQuG6AJO6PR2TdnMhWPPctCDzJZOSjCoOnCzO+0bNbQJxcMkZ3i+8t2re+15EcZLthX
 HBTN5TQP66+stKJgMgGf2D348vU3G4p3RQ4J+v2hcM988UlXqgBnvxxmuugMbBFm3SWV
 Lq9sXhLwmImha6YTZn4CuVrAzSom2OSvrR31XiqjMPWepHgdZh2vAUJF8Z3J5qB341LP
 snwWw/uo/G7EQ6uY1s8fFSadG+DMLfRhs7YbewvuWIcXCQevD8Q3Wh6F6Hiaxa9VbGvX
 JbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711030294; x=1711635094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4UY9dzI13Ko2/xHkiCsRocTYu4UJTQzC5X35sf18eA=;
 b=rn9P6qaRwo7vkJ+PjWmurrZ+Bb2LaCtwiEculLjlZDuMuTk4iT9E1eauSJIa5dIJB8
 9r6F9bbUEwFiV9IMsa7PzcOCAH550R3SvgJXd+aabvG89vRxdM6a0P/jbfh2+7mMtz1k
 /APumJJ4r4HdrnR4rE31/6MZidblsRV5ZsZ8qbD4yPJR4C0uz6dhplvGXTI8sPGXx9wT
 O/a3g0DUxjyeSxeoO0hb4x/P58xl7uUZNlQR+Z1476wH/5hlNNSEu8DxREDMrnfYxF0H
 eTpcKPm1pOmAborHI8i12BgH53OugilNtUl7NUZuUCC0C8/fkPnAgro6tjiPu+OO7xuu
 KsdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9ezVI/5b5WPjKvJVVTO4H+INKskON7aMhjmRQIn7q+ti+6bYW1BPMnBYytKkuiSqVaAsbQ9PHuRYOoN8Lq5qH8QOvPUE=
X-Gm-Message-State: AOJu0YyMTbsS138Vx4IAhABasCqkyJ0qYEa0QS5DtyPAjJiu3Am0DK5p
 FzsOMvOVwqyaJAUBDuOd8Jull8bYriH/MBSld5Z8I5M2qhMgJ/jb3mk6jhF5kfy3yNLGyMGVRr8
 zvrE=
X-Google-Smtp-Source: AGHT+IG/W/7pwCYE0DG5ImEWQXSSvAU59PexjuE6ZILaHqFScFJBmJQHBQyTcfDuTLn2zcmA44csnQ==
X-Received: by 2002:adf:ab04:0:b0:33e:5fb4:49d1 with SMTP id
 q4-20020adfab04000000b0033e5fb449d1mr6436726wrc.44.1711030294135; 
 Thu, 21 Mar 2024 07:11:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adfe94e000000b0033cf60e268fsm17220557wrn.116.2024.03.21.07.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 07:11:33 -0700 (PDT)
Message-ID: <39ed1c9d-c303-4713-9dbf-6053f423d57b@linaro.org>
Date: Thu, 21 Mar 2024 15:11:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/loongarch: Fix qemu-system-loongarch64 assert
 failed with the option '-d int'
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20240321123606.1704900-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240321123606.1704900-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 21/3/24 13:36, Song Gao wrote:
> qemu-system-loongarch64 assert failed with the option '-d int',
> the helper_idle() raise an exception EXCP_HLT, but the exception name is undefined.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 74 +++++++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 34 deletions(-)


> -static const char * const excp_names[] = {
> -    [EXCCODE_INT] = "Interrupt",
> -    [EXCCODE_PIL] = "Page invalid exception for load",
> -    [EXCCODE_PIS] = "Page invalid exception for store",
> -    [EXCCODE_PIF] = "Page invalid exception for fetch",
> -    [EXCCODE_PME] = "Page modified exception",
> -    [EXCCODE_PNR] = "Page Not Readable exception",
> -    [EXCCODE_PNX] = "Page Not Executable exception",
> -    [EXCCODE_PPI] = "Page Privilege error",
> -    [EXCCODE_ADEF] = "Address error for instruction fetch",
> -    [EXCCODE_ADEM] = "Address error for Memory access",
> -    [EXCCODE_SYS] = "Syscall",
> -    [EXCCODE_BRK] = "Break",
> -    [EXCCODE_INE] = "Instruction Non-Existent",
> -    [EXCCODE_IPE] = "Instruction privilege error",
> -    [EXCCODE_FPD] = "Floating Point Disabled",
> -    [EXCCODE_FPE] = "Floating Point Exception",
> -    [EXCCODE_DBP] = "Debug breakpoint",
> -    [EXCCODE_BCE] = "Bound Check Exception",
> -    [EXCCODE_SXD] = "128 bit vector instructions Disable exception",
> -    [EXCCODE_ASXD] = "256 bit vector instructions Disable exception",
> +struct TypeExcp {
> +    int32_t exccode;
> +    const char *name;

       const char * const name;

(Sorry I missed in review, no need to respin)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


> +};
> +
> +static const struct TypeExcp excp_names[] = {
> +    {EXCCODE_INT, "Interrupt"},
> +    {EXCCODE_PIL, "Page invalid exception for load"},
> +    {EXCCODE_PIS, "Page invalid exception for store"},
> +    {EXCCODE_PIF, "Page invalid exception for fetch"},
> +    {EXCCODE_PME, "Page modified exception"},
> +    {EXCCODE_PNR, "Page Not Readable exception"},
> +    {EXCCODE_PNX, "Page Not Executable exception"},
> +    {EXCCODE_PPI, "Page Privilege error"},
> +    {EXCCODE_ADEF, "Address error for instruction fetch"},
> +    {EXCCODE_ADEM, "Address error for Memory access"},
> +    {EXCCODE_SYS, "Syscall"},
> +    {EXCCODE_BRK, "Break"},
> +    {EXCCODE_INE, "Instruction Non-Existent"},
> +    {EXCCODE_IPE, "Instruction privilege error"},
> +    {EXCCODE_FPD, "Floating Point Disabled"},
> +    {EXCCODE_FPE, "Floating Point Exception"},
> +    {EXCCODE_DBP, "Debug breakpoint"},
> +    {EXCCODE_BCE, "Bound Check Exception"},
> +    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
> +    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> +    {EXCP_HLT, "EXCP_HLT"},
>   };


