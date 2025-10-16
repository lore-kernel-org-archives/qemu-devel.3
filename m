Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06567CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MUY-0001D9-7g; Thu, 16 Oct 2025 07:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v9MUU-00014B-O1; Thu, 16 Oct 2025 07:49:54 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v9MUH-0004Y0-Cc; Thu, 16 Oct 2025 07:49:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.197])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cnR7r6JJyz6VNy;
 Thu, 16 Oct 2025 11:49:28 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 16 Oct
 2025 13:49:27 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00607e934b2-4de4-47bd-b856-36a16f1c38b5,
 690D5AE12EE8992330AA3CE60F7E42257DE08779) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
Date: Thu, 16 Oct 2025 13:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: aspeed: Split the machine definition into individual source files
To: Jamin Lin <jamin_lin@aspeedtech.com>, "'qemu-arm@nongnu.org'"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: 'Andrew Jeffery' <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Patrick
 Williams <patrick@stwcx.xyz>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
 <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: c9a32436-85c9-4f02-b229-511518cb7e72
X-Ovh-Tracer-Id: 15836908092875508527
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFhDw+225tgu0beJwmE1aBm0MmsKUSt8RiBDyL7OlOnbc+1ZknnRh7dpLRqmWWmi0C/yAf0+fHGDqo7uFUAV/V+5E2q6PbvG8AsWZ02F37ae91yocAPSroQQePckzCjy8O9ktgle+H/dVuYh9e1/KgGsyybkQQvAHAKvlTAfJUv/2cwYy6hwSx3XRiIvoMc96BRaqjBUUv1eD6OzENvk0sCRadChgX+xCwQsCOOY95jBineNehlYzG/vweE+brboPZZI0uWCDDnSh2UcJvH1SNP2Zr93k2F6Bdi1g+DDJoCEKGzfn2fDChwbOZQavSC9KJNjHHR5VIyH632EitbEKVwG3+SscX7+XkFxIBIe3lWBqfUILLh/9X5G9oGsnGu5Ay70f8BXiXNCKJ+pvXsrSm3Jk5QQzmDNdIpHWW/MlWaYGSn4AmDQAusSuWfbVermyq4byFdg8u/GbUQYd//idT0VonX7OQpTlwsU5mwrATjdcls15aE1vdZ+VdvW++k7XSjDLw1CHJuN06ky+/6XVZS32eBbzwhFU+RQsch5zsw0O83qM3iXPbd3i5r4krzHMiETsNzjMX+aD8bBZCPw9AL/jI24KiCs9a2xM8SdGnb+oHmESkXQuJH8RDiaB5P6+tT9iQnbL6+Cr7SAxsu1J8RAt60iAi3gikXLu/ORI1rmQ
DKIM-Signature: a=rsa-sha256; bh=876Xla4T8vBVZ6eOgpHWJjnQkxJzs6D33B0DgFOW9W8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760615370; v=1;
 b=Ehmf03ttpilutuqJ1gKw21EtE12BfMdLh6nqWcARRRow60b/esGnHDpwVQ2MKrWyXwNE7xvu
 IGX/LvsE/2qVW27dIwhuwY9arK7JHtsTU/fQB+WSXbdLXfETCDPJMkJ3BieXCMcjNLa8fYpdjd9
 IoOE3TGrq80TUqW7LdMAApLxA1TnFcyRphX225EgQkwIi+kQuKfwVPn+cZaNpNAGIel0bxpEvHP
 p4LYMVxORImWf3XaK6wrN/h4qVXCrrdbnSSZZybsbqTRBBjZqKF0RjXIZ59ms8QbVn72Y5xAmJB
 9FOaMOMQPuB7gaUwA4cJ2tW4lhlpt60qMzbQDE505TmWQ==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/16/25 04:30, Jamin Lin wrote:
> Hi all
> 
>> Subject: aspeed: Split the machine definition into individual source files
>>
>> Hi,
>>
>> This is a follow up of a private discussion with Patrick.
>>
>> Aspeed modeling started nearly 10y ago with the palmetto-bmc machine.
>> We now have 5 SoCs and 25 machines which are mostly defined in in a single
>> aspeed.c file. Multi SoC machines, fby35 and ast2700fc, are defined in fby35.c
>> and aspeed_ast27x0-fc.c respectively.
>>
>> Since we started separating the SoCs :
>>
>>     hw/arm/aspeed_ast10x0.c
>>     hw/arm/aspeed_ast2400.c
>>     hw/arm/aspeed_ast2600.c
>>     hw/arm/aspeed_ast27x0.c
>>     hw/arm/aspeed_ast27x0-ssp.c
>>     hw/arm/aspeed_ast27x0-tsp.c
>>
>> We could do the same for the machines keeping an 'aspeed_ast<rev>'
>> prefix (and maybe avoid the 'bmc' suffix). I think this would ease introduction
>> of new machines. We would be able to get rid of aspeed_eeprom.[ch] and
>> move machine custom data in the machine source file. Which seems cleaner.
>>
>> Timing is about right for code reshuffling, still 3w before soft freeze, no
>> important changes inflight, but if we start doing this conversion, we should do
>> it for all. See the list below for the brave.
>>
>> Comments ?
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>> * AST2400
>>
>>     palmetto-bmc
>>     quanta-q71l-bmc
>>     supermicrox11-bmc
>>
>> * AST2500
>>
>>     ast2500-evb
>>     romulus-bmc
>>     sonorapass-bmc
>>     witherspoon-bmc
>>     yosemitev2-bmc
>>     supermicro-x11spi-bmc
>>     fp5280g2-bmc
>>     g220a-bmc
>>     tiogapass-bmc
>>
>> * AST2600
>>
>>     ast2600-evb
>>     qcom-dc-scm-v1-bmc
>>     qcom-firework-bmc
>>     rainier-bmc
>>     fuji-bmc
>>     bletchley-bmc
>>     fby35-bmc           (fby35.c should rename to
>> aspeed_ast2600-fby35.c)
>>
>> * AST2700
>>
>>     ast2700a0-evb
>>     ast2700a1-evb
>>     ast2700fc           (aspeed_ast27x0-fc.c)
>>
>> * AST1030
>>
>>     ast1030-evb
> 
> 
> I’ve started working on this refactoring and have sent the first patch for the AST1030:
> https://patchwork.kernel.org/project/qemu-devel/patch/20251015081219.2766143-2-jamin_lin@aspeedtech.com/
> I’m doing this because I plan to add a new machine for the AST1060, and it seems like a good opportunity to perform this cleanup first.
> I just want to make sure I’m moving in the right direction — could you please help review it?
> 
> If you agree with the following plan, I’ll create a new patch series to move all existing machines into separate aspeed_ast<rev>_boards.c files:
> > Planned structure
> Create aspeed_ast10x0_boards.c
>   ast1030-evb
> 
> Create aspeed_ast2400_boards.c
>    palmetto-bmc
>    quanta-q71l-bmc
>    supermicrox11-bmc
> 
> Create aspeed_ast2500_boards.c
> (Or should these be grouped with aspeed_ast2400_boards.c? — I’d appreciate your thoughts.)

no. I'd prefer keeping a consistent 'aspeed_ast<rev>' prefix.

>   ast2500-evb
>   romulus-bmc
>   sonorapass-bmc
>   witherspoon-bmc
>   yosemitev2-bmc
>   supermicro-x11spi-bmc
>   fp5280g2-bmc
>   g220a-bmc
>   tiogapass-bmc
> 
> Create aspeed_ast2600_boards.c
>   ast2600-evb
>   qcom-dc-scm-v1-bmc
>   qcom-firework-bmc
>   rainier-bmc
>   fuji-bmc
>   bletchley-bmc
> 
> Rename
> fby35.c -> aspeed_ast2600-fby35.c
>   fby35-bmc
> 
> Create aspeed_ast27x0_board.c
>      ast2700a0-evb
>      ast2700a1-evb
> 
> Keep
> aspeed_ast27x0-fc.c
>    ast2700fc
> 
> 
> One last question
> Do you think it’s better to:
> Create one commit per SoC generation (e.g. one for all AST2500-based machines),
> or
> Create one commit per board (e.g. one for ast2500-evb, one for romulus-bmc, etc.)?

One per machine/board please.

Initially, I thought we would introduce one 'aspeed_ast<rev>_<board>.c'
file per machine/board but that might be too intrusive. At the same
time, it would provide a clear view of how many boards QEMU models
for each SoC revision. What do you think ?


Eventually, file 'aspeed_eeprom.c' would be removed, so would file
'aspeed.c'. 'aspeed_coprocessor_common.c' should probably be renamed.
File 'aspeed_soc_common.c' should become 'aspeed_common.c' probably.


Thanks,

C.



