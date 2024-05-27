Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B9C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZfB-00086Z-EP; Mon, 27 May 2024 08:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBZf8-00085I-UN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:41:14 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBZf7-0006Bk-1t
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:41:14 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-578517c8b49so3699065a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716813670; x=1717418470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BjtQJnIP1iJ6XLf3ypFXW2pbWBDirOARD8AgZpfN/fA=;
 b=CCKa61AzSnIvhYqTqFmNywwXKxliQbb5+vc0xiC85gf34R6MDOPxZPEt6sC8Op3yvy
 hFwwaE4vdlU6/bGj9n9G1EfZe/PO7PJ4kLfZ7vGwHwQR+pfOyVVSBma9pt8QRooJzSBJ
 jpAqLYkxogdDgZ+2utRCylg+w7CVUdvojx4OWR3et5rCXnrvg+GhHSeJPeSSzpxsNdOd
 pcOL1cN6lSUFWKBo/gCwL/DEJC0pJx90HYXo0Xuo/k+FWOBSP5O2by0TsYovG7HtYKOg
 tOiD4ycOz7wG1ufUwmIYsLNaqveiq10Hgh0HAF+1SBvgTKAAg4zFDBI4uUi+sgKDDbY6
 JlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716813670; x=1717418470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BjtQJnIP1iJ6XLf3ypFXW2pbWBDirOARD8AgZpfN/fA=;
 b=QTCsMzJ/zBpkTJrqk4QpRSOtbq+mYgdim48GkK0w0wFuugHgyH3mlLANtVF1y3Dpr1
 Tv5oCIXdm4DcZSt/f4PW6Pb20XWbWSTUPsW7yAl2um6qLe2HVlRFSwESMIWmb3MlPiCF
 LPpsf4yu6DdKpDNjh5TgEZ7mDI4is0a8EMhxE2E/AZDFlqJ73tDp+6AR2eGuY8b/dVk5
 x7cDmrX5n6Z6RE6JOuyt0TehQvkBBxfAGz3yBaJP9Uml4nvxOkCuMM3BKH8GfDj/xy0I
 k4TGW/jO4PxG4HIz0n2bPZLLoaM79tUOI01psT9BOLyy/nFoU2LjNQnOORufIfgp4zBZ
 6jVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1yrriN99QEfESBShu7OTxNP82a6HHN+JJJ1oyo4fLV9MOdsomAcXdxMwTY0VpiKq9tmG5tG0DhbblPcC9szmvb1VuQL0=
X-Gm-Message-State: AOJu0Yx1cXG3X+gs5U8hqFUDxI1NindXpQB/jfJlwafds9+oWhKCJMWG
 CTnk0v38ucczFyI27jhCPfaJj9wASfWg8UU5lIMKZeCrTaIF8P/JvF/9/NL5R/M=
X-Google-Smtp-Source: AGHT+IGkQa66fedL7TLixH6dTZZBRndmW4Gnqi9CGxEUGwgpGExgAX9oFnSc4H3P1hn+etL8LaOk8Q==
X-Received: by 2002:a17:906:2512:b0:a59:a431:f955 with SMTP id
 a640c23a62f3a-a62651187b0mr640069366b.73.1716813670383; 
 Mon, 27 May 2024 05:41:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93b678sm486450966b.82.2024.05.27.05.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:41:09 -0700 (PDT)
Message-ID: <933822dc-de0e-4180-90f9-d951aed30aec@linaro.org>
Date: Mon, 27 May 2024 14:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
 <9476cfcc-5a7c-4b76-a684-1361463bd161@linaro.org>
 <b01604af-5fa7-469f-98e9-c23b3a668a2e@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b01604af-5fa7-469f-98e9-c23b3a668a2e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/5/24 13:18, Cédric Le Goater wrote:
> On 5/27/24 12:24, Philippe Mathieu-Daudé wrote:
>> Hi Jamin,
>>
>> On 27/5/24 10:02, Jamin Lin wrote:
>>> The SDRAM memory controller(DRAMC) controls the access to external
>>> DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.
>>>
>>> The DRAM memory controller of AST2700 is not backward compatible
>>> to previous chips such AST2600, AST2500 and AST2400.
>>>
>>> Max memory is now 8GiB on the AST2700. Introduce new
>>> aspeed_2700_sdmc and class with read/write operation and
>>> reset handlers.
>>>
>>> Define DRAMC necessary protected registers and
>>> unprotected registers for AST2700 and increase
>>> the register set to 0x1000.
>>>
>>> Add unlocked property to change controller protected status.
>>>
>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   hw/misc/aspeed_sdmc.c         | 190 +++++++++++++++++++++++++++++++++-
>>>   include/hw/misc/aspeed_sdmc.h |   5 +-
>>>   2 files changed, 193 insertions(+), 2 deletions(-)
>>
>>
>>> diff --git a/include/hw/misc/aspeed_sdmc.h 
>>> b/include/hw/misc/aspeed_sdmc.h
>>> index ec2d59a14f..61c979583a 100644
>>> --- a/include/hw/misc/aspeed_sdmc.h
>>> +++ b/include/hw/misc/aspeed_sdmc.h
>>> @@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, 
>>> AspeedSDMCClass, ASPEED_SDMC)
>>>   #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
>>>   #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
>>>   #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
>>> +#define TYPE_ASPEED_2700_SDMC TYPE_ASPEED_SDMC "-ast2700"
>>>   /*
>>>    * SDMC has 174 documented registers. In addition the u-boot device 
>>> tree
>>> @@ -29,7 +30,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, 
>>> AspeedSDMCClass, ASPEED_SDMC)
>>>    * time, and the other is in the DDR-PHY IP which is used during 
>>> DDR-PHY
>>>    * training.
>>>    */
>>> -#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
>>> +#define ASPEED_SDMC_NR_REGS (0x1000 >> 2)
>>
>> This change breaks the migration stream.
> 
> Do you mean migration compat ? We never cared much about that
> for the Aspeed machines.

So let's just remove the VMSTATE to reduce code burden?

Otherwise incrementing the vmstate.version is enough.

Regards,

Phil.

