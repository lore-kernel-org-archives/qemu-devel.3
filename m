Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHg24-0008Lo-2S; Thu, 13 Jun 2024 04:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHg22-0008LR-Px
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:42:06 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHg20-0005wW-MI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:42:06 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso8142031fa.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718268122; x=1718872922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBBYI4Z1ffe5PmxZgsGFv6Z2Up/NWIII1ukQdHVgO34=;
 b=mq+BBeOw/SabKH+mrVHAr0xq9u8bUL9Vb3m7Xma9eHPSfDjzuvv4oGM+yYS8J2O0Lp
 X3HAGSmV9CTrY5zJ9wnXKfW6QEV5gmu5m4RLNFQ/NxrezlBttDnDi7ezdlZW5xR2cN/o
 Po/IqJVVQJEVZ/mnx2Gtw8gJoeYG8Ks6XK3dWZFrhbLhZszPW8ic6l6dbTNJvP54qjEo
 tSmtKAx6k+bxkeZNjZgVu7mta4tyHNxGh0ZUXG4VQqGMufYhekrPmx36EJT2JMd3jJL6
 jFOAKRvD3rueo/3MpYDw7HW8dQw/+8+6csG19Q5LPFGgUF8jjiNJmmlWiwMpvW44SCGu
 EOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718268122; x=1718872922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBBYI4Z1ffe5PmxZgsGFv6Z2Up/NWIII1ukQdHVgO34=;
 b=XGt/02nmyRYCBfq4EjyeJ2VFeF4bRqy0do/hxvb9DP6hEVfAdyHbYjrcPTBs22PkN8
 q6B5kW3mpTKEb2ev/QP97oSi5vV+iHa6mrFtn1fdvpms5FE3pCArBOoXTrKbeLSDXyUj
 uMR6J91wPOLENRQGgnso3OVsd7qbQw2lfHRlCikeMwVlnsNwhpr4xbDLsQ9fyGiJslMZ
 2a07xvZq1bCPcD9CO9lSB56THcWga9F0ehDJT338XcEG4N+Q/X+FsNv+X5E5PyL9Oefl
 dJfAyYth1R7mlkDzW0dMXu+S5UX/0eTynkjvxHJIR9qQmmyY/DYKIX/R7iZVDRubnH5A
 RgBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQR2YtmquugcIuGPxuW+hszh8+SXI6g7S9tq0a7qQI+MsQvk7/UQ2LookzYhkSO5OSaY3XjCaocnPTuf9q1Xmn1VNRrc=
X-Gm-Message-State: AOJu0YyeWVgGFJoe7s1SjeZW2CWQywsMwq6vUXTr/k8cnFiMAxGElK9l
 xM04CzTmiMNxZTZ4y2FBfRMr9mzs79CK2Z6agjnpMD/YAmoQfNcVu0JtC9rRENQ=
X-Google-Smtp-Source: AGHT+IHL0IhAGPUkUa1rEqF2KWWEnR9FHKJONGG42wvuQMf/nhtSJ93YnZzr3gCrWl9400gYJXPXww==
X-Received: by 2002:a2e:954f:0:b0:2eb:ea9e:648c with SMTP id
 38308e7fff4ca-2ebfc948831mr23804071fa.31.1718268122222; 
 Thu, 13 Jun 2024 01:42:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9263sm52479675e9.15.2024.06.13.01.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:42:01 -0700 (PDT)
Message-ID: <57d7f1ae-e499-4859-a74e-53ba29ba0be3@linaro.org>
Date: Thu, 13 Jun 2024 10:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/32] hw/sd: Add mmc switch function support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-22-clg@kaod.org>
 <d9a20624-1813-4a29-b819-1de3961cc3cf@linaro.org>
 <4d1777d6-0195-4ecb-a85f-09964268533d@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d1777d6-0195-4ecb-a85f-09964268533d@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 13/6/24 09:44, Cédric Le Goater wrote:
> On 6/13/24 12:49 AM, Philippe Mathieu-Daudé wrote:
>> On 3/7/23 15:24, Cédric Le Goater wrote:
>>> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>>
>>> switch operation in mmc cards, updated the ext_csd register to
>>> request changes in card operations. Here we implement similar
>>> sequence but requests are mostly dummy and make no change.
>>>
>>> Implement SWITCH_ERROR if the write operation offset goes beyond length
>>> of ext_csd.
>>>
>>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> [ clg: - ported on SDProto framework ]
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/sd/sd.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>
>>
>>> +static void mmc_function_switch(SDState *sd, uint32_t arg)
>>> +{
>>> +    uint32_t access = extract32(arg, 24, 2);
>>> +    uint32_t index = extract32(arg, 16, 8);
>>> +    uint32_t value = extract32(arg, 8, 8);
>>> +    uint8_t b = sd->ext_csd[index];
>>
>> This field is added in the next patch :)
>>
>> ../../hw/sd/sd.c:927:21: error: no member named 'ext_csd' in 'struct 
>> SDState'
>>      uint8_t b = sd->ext_csd[index];
>>                  ~~  ^
>> ../../hw/sd/sd.c:949:9: error: no member named 'ext_csd' in 'struct 
>> SDState'
>>      sd->ext_csd[index] = b;
>>      ~~  ^
>>
>> No need to respin, as I'm integrating your work.
> 
> 
> Ah good !
> 
> There are 3 main parts :
> 
>    * Base eMMC support:
>      hw/sd: Basis for eMMC support
>      hw/sd: Add emmc_cmd_SEND_OP_CMD() handler
>      hw/sd: Add emmc_cmd_ALL_SEND_CID() handler
>      hw/sd: Add emmc_cmd_SET_RELATIVE_ADDR() handler
>      hw/sd: Add emmc_cmd_APP_CMD() handler
>      hw/sd: add emmc_cmd_SEND_TUNING_BLOCK() handler
>      hw/sd: Add CMD21 tuning sequence
>      hw/sd: Add mmc switch function support
>      hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
> 
 >      hw/sd: Fix SET_BLOCK_COUNT command argument
 >      hw/sd: Update CMD1 definition for MMC

I am focusing on these for now and should include them
in the next SD pull request, but I'll repost them with
more patches to be reviewed first.

>    * Boot area support
>      hw/sd: Support boot area in emmc image
>      hw/sd: Subtract bootarea size from blk
>      hw/sd: Add boot config support

I haven't studied them yet and plan to look at them
after mentioned repost. I'll try to also include them
in the PR.

>    * Aspeed eMMC support :
>      hw/arm/aspeed: Add eMMC device
>      hw/arm/aspeed: Load eMMC first boot area as a boot rom
>      hw/arm/aspeed: Set boot device to emmc
>      aspeed: Set bootconfig
>      aspeed: Introduce a 'boot-emmc' property for AST2600 based machines

Once my PR posted I'll review them and let you merge them.
Then I'll invite you a beer at the next KVM forum :)

> and I can rework the aspeed part if needed.
> 
> Here is an image you can try boot on :
> 
>    https://www.kaod.org/qemu/aspeed/rainier/mmc-p10bmc.qcow2
> 
> Run with :
> 
>    qemu-system-arm -M rainier-bmc -net nic,netdev=net0 -netdev 
> user,id=net0 -drive 
> file=./mmc-p10bmc.qcow2,format=qcow2,if=sd,id=sd2,index=2 -nographic 
> -serial mon:stdio
> 
> Thanks,
> 
> C.


