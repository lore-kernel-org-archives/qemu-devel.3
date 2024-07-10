Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC72C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRada-0001Rk-GN; Wed, 10 Jul 2024 12:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRadW-0001NC-IH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:57:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRadR-0000FQ-Un
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:57:44 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ee90f56e02so65455581fa.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720630659; x=1721235459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXgDdt4XtA1oLIEFkh0NWVIoScezdBkIZ5hfhDsQgCo=;
 b=ePKjgc0QXypBklJ2fENxfqQITgNdfh3eQSrjIEwZL/G3CfdjRjirQJ4Wdeb/ZjzYhL
 be5aSFcxK5youy2BQKqa67XvRIXhqK3Dh6UrZiZaHQ7CLStxCOF+ld4TckX4RPJ9710p
 EH99BR6d/85NTt16bQ+VOgt66V+plhOyvkGUDjkzgVULMSgMMtzuZILXE8v4Jpf3ro/M
 Kd5i8WKCEJQBonu/vokRM0VD+1KYchFTLGMCjox5zv2WrvbdPpmJGNysb5Y7BavrRX/N
 J0L0sAS0a/jO4doh+QmKI5iWCGJkcNvDc1UQUdkkV8Qw2QlHHpFJB0nspGntpKBfc/Ec
 Nfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720630659; x=1721235459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nXgDdt4XtA1oLIEFkh0NWVIoScezdBkIZ5hfhDsQgCo=;
 b=fnge0IzwAaY1pm0vSdW6cIjypoVgGajS09Tbk0BO3DFgmmrPVo5OnXWj+FYejlH4Xo
 xqHA0QaMp6Re5IljE8DmP9s6FaouVBkrNQ1zmtqDyZVYjhzqoEhzx0scRHN99GJZ8tL5
 dzGV8a8NkQTXIhdigisxaJng6Gqm6daDsbHH2llE4c6VP/FCAJ2A5ON6SsF2+UUX3JLY
 huLH0PK8d//Wbld61eiYJXFizHjno3yRla2K7uo1NfoVwUIJUZtO6VzU2jbilisSp/FB
 llma8o0Lu3XIdWaHy6vkUTROC2kdnv2CCCbHZaPrd1LGOCqC3qiR8PI2z+J+58kEaqSw
 oJVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUniiMVPvxQoVZKg4kpmRzMocHQ8fWmuICtrWVjPMr2xl/t39zbRvkLnPZXmnckkL9vVoxc2l62MV8OGi/TNB7CRs6T7kE=
X-Gm-Message-State: AOJu0YwFeyRaagJSyAK4Qhx5hts7ix6z8FQToZ0PzzfEImKeTz/DAn04
 5YsGly2kjFDq2f6LWRfb+jg8FU6KkS+0tl408MzQrGOEColKxZTff/WtSIpy7qk=
X-Google-Smtp-Source: AGHT+IFwlfRUTPk4K17ztgYW830c0kc7ff94q21eGT0fhAU2Z5bGptOdMKAyn8i6sSNOZj+HPDgpYw==
X-Received: by 2002:a2e:86cc:0:b0:2ed:275d:aa44 with SMTP id
 38308e7fff4ca-2eeb30fcd17mr39340951fa.28.1720630658644; 
 Wed, 10 Jul 2024 09:57:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f22acsm257747505e9.24.2024.07.10.09.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 09:57:38 -0700 (PDT)
Message-ID: <a8af41ee-f4e5-4720-9365-9a7493a5e84f@linaro.org>
Date: Wed, 10 Jul 2024 18:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v48 00/12] hw/sd/sdcard: Add eMMC support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
References: <20240710141408.69275-1-philmd@linaro.org>
 <09a1a960-5a79-4aa9-a57f-1c1efd809901@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <09a1a960-5a79-4aa9-a57f-1c1efd809901@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/7/24 17:35, Cédric Le Goater wrote:
> On 7/10/24 4:13 PM, Philippe Mathieu-Daudé wrote:
>> Tag to test Aspeed tree:
>>    https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v8
>>
>> Since v43:
>> - Reordered and squashed commits (Cédric)


>> Cédric Le Goater (2):
>>    hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler (CMD3)
>>    hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)
>>
>> Joel Stanley (1):
>>    hw/sd/sdcard: Support boot area in emmc image
>>
>> Luc Michel (1):
>>    hw/sd/sdcard: Implement eMMC sleep state (CMD5)
>>
>> Philippe Mathieu-Daudé (6):
>>    hw/sd/sdcard: Basis for eMMC support
>>    hw/sd/sdcard: Register generic command handlers
>>    hw/sd/sdcard: Register unimplemented command handlers
>>    hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
>>    hw/sd/sdcard: Add eMMC 'boot-size' property
>>    hw/sd/sdcard: Implement eMMC 'boot-mode'
>>
>> Sai Pavan Boddu (1):
>>    hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
>>
>> Vincent Palatin (1):
>>    hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)
>>
>>   include/hw/sd/sd.h |   3 +
>>   hw/sd/sd.c         | 418 ++++++++++++++++++++++++++++++++++++++++++++-
>>   hw/sd/trace-events |   3 +
>>   3 files changed, 418 insertions(+), 6 deletions(-)
> 
> 
> Shall we merge now ?

Are you OK with this patchset?


