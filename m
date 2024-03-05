Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD577C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWrd-00047N-7H; Tue, 05 Mar 2024 10:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhWrb-00046y-J8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:37:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhWrS-0004b9-Ij
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:37:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so27963335ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653064; x=1710257864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ld3gl94UlupCDSFVzXjsYxI6WQPx/u7ZfDL4K61RZ8=;
 b=qOuTd2EJ2cZrarHeubSj3NEMM+mb2uXmYY/6hgwgMLhgUTETN0A3T7IKXU8650ImvY
 3VQf489ED99W4C446Rsioai27D1LhlbLte0c8qZnkKGbhhXH+ZQ4XDLGCcHGqxfu2uUY
 Pj6Kh0hVmRZ7+OygEsBdLrKJlU0CgxDhHq5nAS9RX21YhjrNUrVH2J3EGBvNDrGXx2qd
 7Qn+W5FdQQFEwmxzoatueTlP/sy3ogf2aFRjYf4aGxkJd4setJmZ9hPCod42crM2Ft3c
 rg2WgHF/DTZ4nCa4QVv3CBCN27eNqMoQqFzuyGIJ465ghwg/xBw6rRZIqJfCKVT1E9lj
 rF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653064; x=1710257864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ld3gl94UlupCDSFVzXjsYxI6WQPx/u7ZfDL4K61RZ8=;
 b=Mb54qJ+ERh3mFEh849L/z75/PgUlFnSC0GfotL3F55Pjx7c+OPqcBqq0Sz3/25qsJt
 4JD11NvaFV8nTRownRd6bC2evsolcoSWQMpURCAqRTyjgYu4ckBgsSHfIZdgYap0XqXW
 yJT4AJ7poKZv85Ft/4Q80cXQwf42pyWCXxtJ1M8sYAQqF0Fm1rlKERHGikHnzrX6auEF
 SAA0S0qXRJf79s3XO+K7SM7fMDhEPbLjSsGscVfug+ArkTG6iHt+TEdIFLMBeRwYEGp+
 riUzLQ/TDyHdK8dk3zctBNbrop/a6zWW47JYfo9S7gfJv0Yzua/rY+jProb+JmIzPU5a
 SKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcmRchAz5zxtTOIQ2tURRZ7+UQFAH2uOZN+BI1eUj1MfTif5tk48LF3HWTPZj0ZLodpcUg5t8aCsxp5tmekQQDyHkLzeU=
X-Gm-Message-State: AOJu0YyPPUX/NIf1VpmdyHjbj7KAqpbuOEVFFoarIXUBED90Bn3yfEAy
 +24IAk0RQCixnUAZj34gouJ4DVBHae0hAjsSx927k0mkGtH4ywy/xa7CO96no4k=
X-Google-Smtp-Source: AGHT+IGWV8d4nINgFkteuk3SsJ0Eha3JGDVmSahjCia/VH76asCjkn1xpX5ROHhmMJ/8Nc4VDABYng==
X-Received: by 2002:a17:902:edc2:b0:1dc:1ff5:3dfe with SMTP id
 q2-20020a170902edc200b001dc1ff53dfemr1706223plk.27.1709653064376; 
 Tue, 05 Mar 2024 07:37:44 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 h15-20020a170902680f00b001dd090a7c00sm5231084plk.292.2024.03.05.07.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:37:43 -0800 (PST)
Message-ID: <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
Date: Tue, 5 Mar 2024 05:37:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
 <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/4/24 20:21, lixianglai wrote:
> Hi Richard:
>> On 3/4/24 17:51, Xianglai Li wrote:
>>> When we use qemu tcg simulation, the page size of bios is 4KB.
>>> When using the level 2 super large page (page size is 1G) to create the page table,
>>> it is found that the content of the corresponding address space is abnormal,
>>> resulting in the bios can not start the operating system and graphical interface normally.
>>>
>>> The lddir and ldpte instruction emulation has
>>> a problem with the use of super large page processing above level 2.
>>> The page size is not correctly calculated,
>>> resulting in the wrong page size of the table entry found by tlb.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> Cc: maobibo@loongson.cn
>>> Cc: Song Gao <gaosong@loongson.cn>
>>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>>> Cc: zhaotianrui@loongson.cn
>>> ---
>>>   target/loongarch/cpu.h            |  1 +
>>>   target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
>>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>>> index ec37579fd6..eab3e41c71 100644
>>> --- a/target/loongarch/cpu.h
>>> +++ b/target/loongarch/cpu.h
>>> @@ -292,6 +292,7 @@ typedef struct CPUArchState {
>>>       uint32_t fcsr0_mask;
>>>         uint32_t cpucfg[21];
>>> +    uint32_t lddir_ps;
>>
>> This magical cpu state does not appear in the manual.
> 
> The hardware instruction manual is hosted on github at
> 
> https://github.com/loongson/LoongArch-Documentation
> 
>> Are you sure that large pages above level 2 are really supported by LDDIR?
> 
> 
> Yes,We have done tests on the physical cpu of loongarch64 and
> 
> it works fine with a level 2 large page on the physical cpu.
> 
> 
>>
>> Some explanation from the hardware engineering side is required.
> 
> The description of lddir hardware manual is as follows:
> 
> 
> Instruction formats:
> 
> |lddir rd, rj, level|
> 
> The|LDDIR|instruction is used for accessing directory entries during software page table 
> walking.
> 
> If bit|[6]|of the general register|rj|is|0|, it means that the content of|rj|is the 
> physical address of the
> 
> base address of the level page table at this time. In this case, the|LDDIR|instruction 
> will access the level
> 
> page table according to the current TLB refill address, retrieve the base address of the 
> corresponding
> 
> |level+1|page table, and write it to the general register|rd|.
> 
> 
> reference:
> 
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html
> 
> 
>           4.2.5.1.|LDDIR|

Yes, I have this manual.  Please highlight the portion of this description that 
corresponds to the LDDIR_PS variable that you add.


r~

