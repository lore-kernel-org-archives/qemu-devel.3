Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81287C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVG2-0000OY-2A; Tue, 20 Feb 2024 13:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVFy-0000Gw-8g
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:54:18 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVFt-0000b6-M4
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:54:16 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512bce554a5so2631625e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708455252; x=1709060052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bz71ocTEp/2HTrXTtW2EYsMen6XywXEB/KHZhSzjqHo=;
 b=NtG97qic3bZv18tRmiMwWmj8dHhPpsl4ZR+Tzx7Yevqskd8K59h6Is2lK4WdobQP1e
 sFlHgcev2f6tyEOnAFR0q6q7cAcpfg4T34tAmq2FF530gpGWycYVxbvZeJP69b8PSYK7
 ChfftUEORDYK8jGS2KxMTSYIfQ6IwgVwRcSqdMgIR2gVXRPVOPOZkS9Wado4++TWfpJN
 /dfeh1T/NUAuuovl0kmHYAE6KUTL9bQda+239JmomovkM9bT+1w3f1BKbyPQeIsOAkhT
 2ZVSdMLu+bIP9NHHj25LxTpXARZqAMPhMry28DTHiXXsJpkgLufbiEhu1wyLMWTD6BAO
 f3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708455252; x=1709060052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bz71ocTEp/2HTrXTtW2EYsMen6XywXEB/KHZhSzjqHo=;
 b=mI+0MiCS56zSUNO7dPAKzaCcYC2PLhY8DA9tt2lniLrRNSQYGTOHihVKocdmXRTX+T
 f6uzUeajwppQXeJgMWlXtmKFZtL4Z/p+MyaQlQl0oeNeCz6JlNzjkgxa/Y7WKv4DnBEY
 VMmJHLlS7plQH7PYpcde++7c/KFQ1zrkJqsdVhdjwWKLySakSs6Lpr7zI7T8llwc4NY4
 JP6bnLbd0POWDU6TRjVmtuqqmhm72qs9in2whlJ0s1U/JiawTUV/fbbvtFTFjWix/R7L
 fOFTrYQUsi6Q88tcpwSf1tvE+cGZnWfpsJq7NOuaCtRnFn9nNVjkY3qUgq8iO4wAgjRa
 +3aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQmR236mNkPsmKYz5xqvADpM15Y5Jmbp7ieVoMQ5am8+a4rt7e77KcQ3ZpSXefspaMSW7Dif2tFzerXmiwt4/Khv3TmIo=
X-Gm-Message-State: AOJu0YwK4UuJOHPzsf0dMmCBb7H40z0SOUBvP7PQ0vEnRReOplJ4tzUE
 MnNQU7p8x35gbROHKlT+MwPrRUZauZ4IwHw+U4BpA6nd6+vkJ36wBz7hrpa3Pc4=
X-Google-Smtp-Source: AGHT+IHBlN7KElNEVVSXFaBVM1KM9ZFZN5bMeAUklgn8yUmQPJmAcBll4tlDT55NBi+7FgG9k19WfA==
X-Received: by 2002:a19:c511:0:b0:512:9e57:375a with SMTP id
 w17-20020a19c511000000b005129e57375amr7109993lfe.53.1708455251738; 
 Tue, 20 Feb 2024 10:54:11 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 q25-20020a05651232b900b00512a949a4d6sm1189163lfe.7.2024.02.20.10.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:54:11 -0800 (PST)
Message-ID: <cd7eafd8-f909-45ba-b319-6ec3a4b3c5e8@linaro.org>
Date: Tue, 20 Feb 2024 19:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: ensure nios2 processes queued work
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240220170803.888143-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220170803.888143-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 18:08, Alex Bennée wrote:
> While async processes are rare for linux-user we do use them from time
> to time. The most obvious one is tb_flush when we run out of
> translation space. We will also need this when we move plugin
> vcpu_init to an async task.
> 
> Fix nios2 to follow its older, wiser and more stable siblings.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   linux-user/nios2/cpu_loop.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
> index da77ede76bd..7fe08c87501 100644
> --- a/linux-user/nios2/cpu_loop.c
> +++ b/linux-user/nios2/cpu_loop.c
> @@ -32,6 +32,7 @@ void cpu_loop(CPUNios2State *env)
>           cpu_exec_start(cs);
>           trapnr = cpu_exec(cs);
>           cpu_exec_end(cs);
> +        process_queued_cpu_work(cs);

We really should abstract that pattern for user emulation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


