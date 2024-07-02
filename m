Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD2C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEG-0006AM-GV; Tue, 02 Jul 2024 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeDW-000581-Tu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeDG-0000K0-1l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so30483725e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929425; x=1720534225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nSiBZuSUNSDOcvWr7Kr5QIPs5+gqfC0Gg6WBdDWZxi4=;
 b=XceyYX+KC1xdt36nyH5I/PphzkGOKi7tyvFek1vH9z/ePpzlq9M49arYfwcS0/+SQL
 16n5I/jWPvcyG7JCFY4fwySi/iaAM524UY5XwCwfzk8CmtkOqiJMq1ZSFIoKVhdzn3Rg
 gqZ19A1+vsCq+LumhsBKtoQ6WCbyzhpuu6VfAP7v/WD5KOomq24MVAztyfL6bRKrZCeQ
 +Jn2fC/rZd0C9yiplKPgTSI68HRuOBA6xBWTQA/4W2aK9U2k09KD1+rrIg1u4fVbUWkB
 FBR4cu+eZtWBapkQV52am0GdDLDa9adaKkygtlSwMBJ6XyEdxjPmEp6izHsyINNzUbhN
 MIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929425; x=1720534225;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nSiBZuSUNSDOcvWr7Kr5QIPs5+gqfC0Gg6WBdDWZxi4=;
 b=qieQCTtI0tP9jmOBwMOqRmEojIPRLOhjLdIPoEnc1lPwrB1wsERJ8vSSuQzE9iusO9
 bsxhha+ZZm9zYImwtccf8uu1deJVmkcmsxKSi2IPVFZmI+95TYToFBTpo6bo85FQ9gsf
 RdNqdj5k/emHqMDsEF2k3Ff2D6uvPzcogBAIV3bfWep+N8U5qSuMiAXrigDY26FJrEf5
 lscSV3/OJSc4GQnu2BDrLH4NSX299kbd7t30ieVOTOMSY9OKNx0VO1ncyh7aazZO0J4v
 1m57bCaFqHfarnMD7lx3xyYGdcmUN7d3JiQ5vR4GF0NvznJ7nBPAshNq75TM9VGhxexm
 f/0w==
X-Gm-Message-State: AOJu0YxxGv628XqbmUy7Bi2hjU+sQLj1jO1mWFyoXbT4mrwX9zDG0Vfw
 LGgVURBgbfezlYQIr87oWE+yHx+xOXWJLKN8O909sY5GyHItBrCunBP6leXCvMJ823iO5S26gUN
 O
X-Google-Smtp-Source: AGHT+IHnx6aQxALg6pae5xeXOSv1Jr0Oj6WagLUAGOOoErKRQ1B27vI/2S3YUAC+15gVP6zV+Fyatg==
X-Received: by 2002:a05:600c:35c2:b0:424:a823:51d7 with SMTP id
 5b1f17b1804b1-4257a02b8famr55016525e9.5.1719929425121; 
 Tue, 02 Jul 2024 07:10:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a073sm199177875e9.32.2024.07.02.07.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:10:24 -0700 (PDT)
Message-ID: <e1e461c9-08e2-46d2-b9e1-e6b98ef18475@linaro.org>
Date: Tue, 2 Jul 2024 16:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/23] hw/sd/sdcard: Generate random RCA value
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shengtan Mao <stmao@google.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-10-philmd@linaro.org>
 <37f83be9-deb5-42a1-b704-14984351d803@linaro.org>
 <c64e9127-8932-4ad1-abee-90d349300181@linaro.org>
Content-Language: en-US
In-Reply-To: <c64e9127-8932-4ad1-abee-90d349300181@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/24 15:13, Philippe Mathieu-Daudé wrote:
> On 21/6/24 11:44, Philippe Mathieu-Daudé wrote:
>> On 21/6/24 10:05, Philippe Mathieu-Daudé wrote:
>>> Rather than using the obscure 0x4567 magic value,
>>> use a real random one.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/sd/sd.c | 8 ++------
>>>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> 
>> Hmm the NPCM7xx test is failing:
>>
>> ▶  58/450 ERROR:../tests/qtest/npcm7xx_sdhci-test.c:101:sdwrite_read: 
>> assertion failed: (!memcmp(rmsg, msg, len)) ERROR
>>
>> But booting various Linux / FreeBSD guests on SD cards works,
>> so I suppose the test (or TYPE_NPCM7XX_SDHCI model) need some
>> rework.
>>
>> $ git grep 0x4567
>> tests/qtest/npcm7xx_sdhci-test.c:47:    sdhci_cmd_regs(qts, 
>> NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
>> tests/qtest/npcm7xx_sdhci-test.c-48- SDHC_SELECT_DESELECT_CARD);
>>
>> In tests/qtest/libqos/sdhci-cmd.h:
>>
>> /* CMD Reg */
>> #define SDHC_SEND_RELATIVE_ADDR (3 << 8)
>> #define SDHC_SELECT_DESELECT_CARD (7 << 8)
>>
>> IIUC setup_sd_card():
>>
>> card address is queried ...:
>>
>>      sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0,
>>                     SDHC_SEND_RELATIVE_ADDR);
>>
>> ... but then ignored and magic 0x4567 is used instead:
>>
>>      sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
>>                     SDHC_SELECT_DESELECT_CARD);
>>
>> OK, so this test need rework. I see the sdhci_read_cmd()
>> method but it reads the SDHC_BDATA FIFO register, not sure
>> this is what should be used to read the RCA from R6 command
>> response.

Fix: 
https://lore.kernel.org/qemu-devel/20240702140842.54242-4-philmd@linaro.org/


