Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A10C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 12:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnHQb-000469-0z; Thu, 21 Mar 2024 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnHQY-0003tj-KR
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:21:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnHQW-0000dg-Po
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:21:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-414700cffd6so6971605e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711023703; x=1711628503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2KEG4iM1wy5ywBKDstOhLY/YSmX6x6uyrXSWofvWJo=;
 b=uCiN8Ed1LzLGzGxOt9EN9iM4u0jur6rDwF14RK3xjUtWdG46jRsMSTGaErbjn7RkDw
 N0PgAKg5jvOceZJVV6jmb/JVS7L0/fX6zZ/2G98BzFkTywNsJ9mV/UR6VeLbjsw+VM3Z
 4acIgDBWygUMl4yS4KUexe6wwYSoBLEH4aV7YmPB36r2KiZt7R0FZhPKeQc0RpJPRiCI
 Y9wS7flCLHgnB/xFm8ztPQthZpl6jvOVAn24v38r9XljYvdI+Dv+C18kZvhHtvRfkKsL
 mW5UWIVvCYLZ6WkgbpMzNLif9LgFdU00hdr+z3EAuabI9ZUsysPt8Zh7erdpyJTpOjd8
 Vatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023703; x=1711628503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2KEG4iM1wy5ywBKDstOhLY/YSmX6x6uyrXSWofvWJo=;
 b=tCaeJ3VHYCL3LuBdcS5fznwIydjA+ZXGpg63EhtbaSTgD+eHS++OTeUhY0sdKgq83N
 jX9PuBCZ+/qJ6yB9tPjaCPhoUBf7aK2vnw8tCRicy2gUw1IM/dfCzoNl2jvnHmqAzwcj
 lBLp1NADqKNKXt5TwDAPtwwKzuZ8+3yNGk9kitIdfmyFdOmTSNad2BBHIfKGd5uerudA
 hdC+Kh2a8HAsErAm+LeBo68jbWbpPA7AtgWOXnmCkdjKqN/ZwchUGI9Cb32XihYiFhHi
 jEbBON/SeAD54PncrwYiCJq9RwDvveY2Xl67mVTczkn0KV2Z1wBSwEWb+rxDhgFrsu1O
 ZDsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzxQVf4afQJhd5CfMqbsUTS9HhaCR06P76jHzzPmy37i4yDqgNTlvhcTcO/+tjMooE/gRIsCEn9fc2omPis7vkWVhthOQ=
X-Gm-Message-State: AOJu0YzyBRCfshdBtU8rwfpJ89htDlYFDW6ExlBdQAO51gWPp4L3xfpa
 dcB0evMph8a9ZiSpPruOiy+NmqSlolAt2NQ2qxtoysGiHIozmFWLVV38i6zvu9E=
X-Google-Smtp-Source: AGHT+IFB/ELJOb2BGsDt5RmEqk5zLlsbFe4rqHiZefJhIo0K8LejE0eYjs67kO30sfKmtyYe9WvXuA==
X-Received: by 2002:a05:600c:3b98:b0:413:e63b:b244 with SMTP id
 n24-20020a05600c3b9800b00413e63bb244mr4014597wms.7.1711023703083; 
 Thu, 21 Mar 2024 05:21:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a05600c3b0200b0041463c2c6ccsm5502168wms.4.2024.03.21.05.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 05:21:42 -0700 (PDT)
Message-ID: <fe843b04-e562-4147-bb0d-89df7ad4ba05@linaro.org>
Date: Thu, 21 Mar 2024 13:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: Fix qemu-system-loongarch64 assert
 failed with the option '-d int'
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20240321063106.1700330-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240321063106.1700330-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/3/24 07:31, Song Gao wrote:
> qemu-system-loongarch64 assert failed with the option '-d int',
> the helper_idle() raise an exception EXCP_HLT, but the exception name is undefined.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 76 +++++++++++++++++++++++-------------------
>   1 file changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index f6ffb3aadb..c56e606d28 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -45,33 +45,47 @@ const char * const fregnames[32] = {
>       "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
>   };
>   
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
>   
>   const char *loongarch_exception_name(int32_t exception)
>   {
> -    assert(excp_names[exception]);
> -    return excp_names[exception];
> +    int i;
> +    const char *name = NULL;
> +
> +    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
> +        if (excp_names[i].exccode == exception) {

               return excp_names[i].name;

> +            name = excp_names[i].name;
> +            break;
> +        }
> +    }

        return "Unknown";

> +    return name;
>   }


