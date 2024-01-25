Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC7CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 04:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrhO-00051T-Ch; Wed, 24 Jan 2024 23:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrhM-000519-Ne
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:50:44 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrhL-00087f-0r
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 23:50:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40eb033c192so1707115e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 20:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706158241; x=1706763041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zf1Q5ChE7zffupadRXMHMHAGPvHuegrMX3stPwK3Tcc=;
 b=dBeXT1zkgTLrlHEGn6gYeCzYWzEaevM9uptIs8ZmNDogNV7zB5b58h0fyFJltD4z+T
 aEa7JF0DPVTDt6fZNTrZVcxG6Q1xfqKeij4kjBHlxFB8OG/FfJ9NkwJ3raLh/hFE39BQ
 k1Ycdz+P1nM6DQuf6WJ/D2lr1KHsZZg1J5imfOhAU1GAf5mu/+uC/kjHzuyg6yQiKk/u
 6HsTQjdL9kePcKtvbunkgCft/+tF8WbKerGySjxtARa/fifsjLpwwn/qUlNP8T2qrrU9
 s2mNS3Jz+Sfv8PS6Z0qmNzwPE66lc3p66Gw5CI1IG326qJGOsGTLDYpXiq7rfPcaQPB5
 T69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706158241; x=1706763041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zf1Q5ChE7zffupadRXMHMHAGPvHuegrMX3stPwK3Tcc=;
 b=bkGkLO7C3giXUEo0uaUFKuNZfe5zEFk7CvlcG7XlLYEBVSh0x0Y8GC7yX9SLkkDGku
 q9hOURSLvfzFvlihD1+Agt+B2t/KiXbNA7Zs77vMf1ZQPjJHTF1v/8Z1cgUTxsDksd0e
 MqDl8b9meb/g+m2Iuu6RcaBps6f4LPqDMU8sZUL7IkHwAb3svR0Is+T4zOlQi6cpky6H
 ZVCEUUTzMykzIgD0LPdP/HdwNfz9cu/RuSRKOmFQGBAQXAB4I8qE42uKzLDAlBf8zR5M
 lBbbXTFAZgxoTKEPpiTmsLz7871O9d/tUrjrHTOhL/5hFzBd7cx543s4PlWYdZxy6E5H
 j2AA==
X-Gm-Message-State: AOJu0YwYIm3a4tKWAhMrzI7YT6VXbkVtKInory1GaWK1S8Hd5/fMz11w
 NjbnJWtSkhdaS67ogXsgwTGlrJZ1VeJRATurssq80gR9wZ+8ycakYDuwX0fCAnA=
X-Google-Smtp-Source: AGHT+IFJrFRVmGWVbGRAtlxFgmL7R9pBO8w17tHEW5wq4ka8QfjB256NGPWth6FXvPCkisickqybkA==
X-Received: by 2002:a05:600c:1716:b0:40e:7940:b04a with SMTP id
 c22-20020a05600c171600b0040e7940b04amr139642wmn.125.1706158241146; 
 Wed, 24 Jan 2024 20:50:41 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c4f4500b0040ec8330c8asm1076496wmq.39.2024.01.24.20.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 20:50:40 -0800 (PST)
Message-ID: <dbb0a39c-7495-4c38-9915-bb69fe86728f@linaro.org>
Date: Thu, 25 Jan 2024 05:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/arm/aspeed: Init CPU defaults in a common helper
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-4-philmd@linaro.org>
 <3aeb1471-dc88-4971-9e77-e1896e40d446@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3aeb1471-dc88-4971-9e77-e1896e40d446@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 25/1/24 03:26, Gavin Shan wrote:
> Hi Phil,
> 
> On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
>> Rework aspeed_soc_num_cpus() as a new init_cpus_defaults()
>> helper to reduce code duplication.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/aspeed.c | 71 +++++++++++++++++++------------------------------
>>   1 file changed, 28 insertions(+), 43 deletions(-)
>>
> 
> One nit needs to be addressed:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>


> Failure from './scripts/checkpatch.pl --strict'
> 
> ERROR: do not use C99 // comments
> #216: FILE: hw/arm/aspeed.c:1505:
> +    aspeed_machine_class_init_cpus_defaults(mc); //

Oops, forgot to clean that =) Thanks!

