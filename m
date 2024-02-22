Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06C1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3my-0004pd-Lp; Thu, 22 Feb 2024 02:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3mo-0004p8-AU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:46:31 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3mm-00049S-55
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:46:29 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-512bce554a5so4925972e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 23:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708587985; x=1709192785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmLBSTMxj1HbXs6MbsBQhqOwNKgLSOcVt5+zcBSMtkM=;
 b=qmlqdtdrnLi8K2lgufQuxk/U6GjkP6G4DumL0fjxfikX3fqZybQj4LdKGlE1a+LXnY
 2VbeyzptVugaTV3GoBcNGenP/ddkbMkd6jkI3kdCebJge7uCP0nE/+JO7c5GRSX7oMzo
 fwH96j6UVP7rkAG1UkQG0PNZ7xLKO/3r/igwJsN2aFxrxzlnrSrDHh0MaltJiFMA7Y3L
 XO3MNMNn5xOIApT9aJrpBp0MjRzOREX+IWeAghgJQcB8RiIXH40OFiGJU1T+pJV7Wckt
 /AL8xbRO6u45fy0HrFJmHW2APpWi+k8i3aipWtRuimXHvsEGKBfbRuD8+1r4ZnhMNU4o
 O+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708587985; x=1709192785;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmLBSTMxj1HbXs6MbsBQhqOwNKgLSOcVt5+zcBSMtkM=;
 b=S/8ETWnTuOxSHDYPIARhcTy9bD2leeOlLFGCX6CmX2TeBcn2qr4fN70w/3kTcLWs8/
 AEcNl/HLvzbExqZ/BQZDzDk89OVwP91oLPnWEXt+1j7X5ce66tv0FvzQ9wMia8J8XdpY
 fhXoRLvXKIaqwOJdzbMH5ErjK/zP8C7JffgMKGoCuw7xdfqJcS92Si27UcY6V5eXrezO
 c1OO8ugu7WSaRMxUchFfn6U955frVY7DVxekU404VIr9N1yx+GRg/hbPiHALgOUY9S7T
 x3HA4ac54ZLwTwPSS5hp8znRUZrExuqsodwFt5NSdW57miozUrz0Kv+jex5gBsEPTHHY
 TNoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWOMy4zhuRBZTNZdsaMLQ/IyJfKP6YbpdHjrXC2VbClqG7EdyaSRtaUbAAuUzPIKX45CIGVTkXk+YlYamLYDGkwOC4N6I=
X-Gm-Message-State: AOJu0YywxwZF+Hk+UOBdKGl0chV4HVA+AYNc+Y7Rob2fn0vuL9BEoR1c
 Z8YAuby+0PhU1JblDJK1wXIdUwy46xiU8b7273Ax3mAI8u06oa+w0tYT2fEqSxw=
X-Google-Smtp-Source: AGHT+IF0YlO3y1wjSRcsPpRpG0glA+HXdep4vpQ5n10C9p+949OzDrPYLo/EBd+WMkzPVxUE+Dxuow==
X-Received: by 2002:a05:6512:1384:b0:512:cb9f:a25b with SMTP id
 fc4-20020a056512138400b00512cb9fa25bmr4797916lfb.28.1708587984867; 
 Wed, 21 Feb 2024 23:46:24 -0800 (PST)
Received: from [192.168.184.175] ([92.88.171.240])
 by smtp.gmail.com with ESMTPSA id
 jd3-20020a05600c68c300b004122fbf9253sm5120999wmb.39.2024.02.21.23.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 23:46:24 -0800 (PST)
Message-ID: <0a37899f-ca73-4749-8f6f-2b61b92cb560@linaro.org>
Date: Thu, 22 Feb 2024 08:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221180751.190489-1-thuth@redhat.com>
 <99813a8e-45ec-460e-a944-c696eb853b75@linaro.org>
 <1ed3ee21-20ff-4503-98ea-de00c490b83a@linaro.org>
In-Reply-To: <1ed3ee21-20ff-4503-98ea-de00c490b83a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 21/2/24 19:49, Philippe Mathieu-Daudé wrote:
> On 21/2/24 19:47, Philippe Mathieu-Daudé wrote:
>> On 21/2/24 19:07, Thomas Huth wrote:
>>> leon3.c currently fails to compile with some compilers when the -Wvla
>>> option has been enabled:
>>>
>>>   ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
>>>   ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length 
>>> array
>>>    ‘offset_must_be_zero’ [-Werror=vla]
>>>     153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, 
>>> info[id], info);
>>>         |     ^~~~~~~~~
>>>   cc1: all warnings being treated as errors
>>>
>>> Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
>>> here: DO_UPCAST is supposed to check that the second parameter is the
>>> first entry of the struct that the first parameter indicates, but since
>>> we use and index into the info[] array, this of course cannot work.
>>>
>>> The intention here was likely rather to use the container_of() macro
>>> instead, so switch the code accordingly.
> 
> Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")
> 
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/sparc/leon3.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>

Patch queued!


