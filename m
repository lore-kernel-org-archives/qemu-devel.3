Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E41AD1A61E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCVb-0002qm-FN; Fri, 09 Jan 2026 08:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1veCVX-0002nz-I0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:26:27 -0500
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1veCVU-0008Vz-58
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:26:27 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.186])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dnjGM5Ljhz5wCj;
 Fri,  9 Jan 2026 13:26:19 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 9 Jan
 2026 14:26:18 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002e7762db7-ea44-4596-85d8-18ffe36546c3,
 E09514031C8F96F06A4508024BC0A168B8B405DC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ba0183c5-d2a4-4dea-9238-d26a45c4daa7@kaod.org>
Date: Fri, 9 Jan 2026 14:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
 <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
 <SI6PR06MB763104221FFD3B2F8511E62FF782A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB763104221FFD3B2F8511E62FF782A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: f79d14d2-c56e-4df4-9b06-41b2984f917e
X-Ovh-Tracer-Id: 142707816364084213
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF0X6aktm847G4ILvaGt5UprgWCyMKydZbDtRhNxwx5KjJ6jNeDpYEtgU1kQjNYSawrvcV0WSY1yx+LSfwQlbVE11fL97+aaf51VJFMQkMT/WVqIy22gT6nY8V6Bygz266d7CE8M2OzFtxlCpYKcGUUzcyuexEM/mSMfGaO+T3idK9XfxIgK9EANNYeG1K3DZFmS2ED+4SqNgpv0iScGhvZ8/UYfNVgXYOGbCJlutwrTwIWivLcojId9ZXP3csTAddZieNJHSzcQjuDljjaYWZTqtnpyfd2yyrfbq2HlWPSIKlKAm76zGZV+skksK4DCtnC46pxMXoAQPny1q64hjfOPEuX5R+EU4q67ZrLWX+Rp41kmawCLIqPFoaTXfVtqQ8xghXrH+wRY1YZo/p3vlpkU1xB5wrHUJLkXa8/fUvAQVs91T35pazNejGi0mFz17DfRStuz0rqYybcHAxmWZRAXBMZhbCZgxDDjULumxpTQ0uT5Q12uKXiuopawkOziIj2HSWHhSbBJi66e6iHXtmy74koaAKy5mqhriB0y6KperBIzEcNgBzim2G4aZYPQPLBqnmurKLp1qmbEwQAn7koVjP3qITowCEDTdYBtbrbhElB2GpfJtfnxEAn5bJNQLkdJbaeZbaC4pJ5NNyBu7TnzN6FdIyh88CLMZSXQY7CSA
DKIM-Signature: a=rsa-sha256; bh=Hff4Pi0s4m/HSXGfPtFiESboc/azxUJm/8MBc6L2ibM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767965181; v=1;
 b=QFyvxXBA2aHYYp9Fhf6M9dvCSo9XIN5UwRMD0dAW7pzbFkwdp7u6YlV3+sNx+SGeEjoTMpOf
 UEUpPP57gOFSVocaPsJhKz5lB4t1fg11XOew8qc6q0ssbFQmM4btOeSuUKJRTTb8kJKh/Ae0SSy
 lbVGhjjDkqfb3VMg2Ro0MRfabaE7jVVW9YNhGazNvNkR/Y7kW3vX/ezaYMZbjUrATiyz/m9AvHo
 +ssTithEo8qTuaVjOK+XljTWcUl3/K33Agw1T+FK5NptVYGmRYugS5h8C0D8hG4spBPzTEYNoER
 Cx04caAdRZhJ+1CbPnCxjfrzqJfjgZ3bktoyGGzhzHHhA==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/9/26 10:59, Kane Chen wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Thursday, January 8, 2026 6:24 PM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
>> here <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; nabihestefan@google.com
>> Subject: Re: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700
>> model
>>
>> Hi Kane,
>>
>>> Thanks for your suggestions. I have refactored the bus naming logic to
>>> align with your comments. The decision making for the bus name has
>>> been moved up to the SoC level, and the redundant "aspeed" prefix has
>> been removed.
>>>
>>> Here is a summary of the changes:
>>> 1. Added a bus-label property to AspeedAST1700SoCState. This allows the
>> top-level
>>>     SoC (e.g., AST2700) to define the label during its initialization or realize
>> phase.
>>> 2. The bus-label is passed from aspeed_ast1700_realize to the I2C controller
>>>     (AspeedI2CState).
>>> 3. In aspeed_i2c_realize, the controller generates unique names using the
>> bus-label.
>>>     These names are passed to the AspeedI2CBus through a new bus-name
>> property
>>>     during the initialization of the buses.
>>>
>>> With these changes, the new object hierarchies and bus names are as
>> follows:
>>> BMC: /i2c/bus[0]/aspeed.i2c.bus.0
>>> IOEXP0 (LTPI0): /ioexp[0]/ioexp-i2c[0]/bus[0]/ioexp0.0
>>> IOEXP1 (LTPI1): /ioexp[1]/ioexp-i2c[0]/bus[0]/ioexp1.0
>>
>> The names in the object hierarchy should not have changed, only the bus
>> names exposed to the user are impacted.
> 
> Sorry, I may not fully understand your point here, so I'd like to double-check.
>  From my understanding, the object hierarchy itself has not been changed, and
> only the user-visible bus names are affected. Below is the current object hierarchy
> without my changes:
> 
> BMC: /i2c/bus[0]/aspeed.i2c.bus.0
> IOEXP0 (LTPI0): /ioexp[0]/ioexp-i2c[0]/bus[0]/aspeed.i2c.bus.0
> IOEXP1 (LTPI1): /ioexp[1]/ioexp-i2c[0]/bus[0]/aspeed.i2c.bus.0

ah yes. The "child<i2c-bus>" objects are really deep in the hierarchy.
I think it is fine.


> 
> I believe this matches your comment that the object hierarchy remains the same,
> while the bus naming logic is adjusted. Please let me know if you were expecting
> a different result here, or if there is still something I should change.
> 
>>
>>> I have also verified that this naming convention does not require
>>> changes to existing test scripts, and all functional tests passed successfully.
>>>
>>> If you have no further concerns regarding this approach, I will submit
>>> the updated patch series.
>>
>> Please separate the bus-label change from the rest. I am expecting a
>> functional test case too, maybe we should update the sdk version to v10.00
>> first ?
> 
> Regarding the functional test case: currently, our BMC releases do not enable AST1700
> by default. I tested the image on other platforms instead. I noticed that the AST2700
> DCSCM image includes a DTB with AST1700 enabled, but I ran into an image size issue.
> 
> On AST2700 EVB, the BMC image size is 128 MB, while on AST2700 DCSCM it is 64 MB.
> This prevents directly loading the DCSCM image on the EVB. As a workaround, I concatenated
> the DCSCM image twice to match the 128 MB size, which allowed the image to boot and
> proceed with further testing. However, this feels like an unexpected and non-ideal
> approach for testing.
Did you try using the "fmc-model" machine option ?

> Do you have any suggestions on how you would prefer this situation to be handled?

We could add a new "ast2700-dc-scm" machine too, if it make sense.

Thanks,

C.


