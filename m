Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34ADCA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvMh-0004bW-F2; Thu, 08 Oct 2026 17:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xEvMf-0004bG-W6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:09:22 -0400
Received: from smtpout5.mo539.mail-out.ovh.net ([51.210.91.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xEvMc-0001TA-NV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:09:21 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4j12fw0XWpz3wj5;
 Thu,  8 Oct 2026 21:09:11 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  8 Oct 2026 21:09:11 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.156])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j12fv2yYWz1xp2;
 Thu,  8 Oct 2026 21:09:11 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 049C6202C6A; 
 Thu,  8 Oct 2026 21:09:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0042f7b6f03-d72d-4120-aee3-86112cd603f4,
 962E323CEA33604AEB532638C894AA56AB6ED06D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8bed7f4e-8453-40d2-a278-d6379ed07d34@kaod.org>
Date: Thu, 8 Oct 2026 23:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO expander
 test
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
 <809fa0e8-889c-43a6-95bd-6a536b6bae93@kaod.org>
 <SEZPR06MB73628EA88DE1E9610A0AB88FFC932@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SEZPR06MB73628EA88DE1E9610A0AB88FFC932@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 465841086491765771
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF9/KC65ndaxTvL9adhXpeA3FX9Ax+riti7Hh0ksN01gpmZB+1o14Nsnp2cD5LrLCo8xsGlR0drvliswNH+xyLJD3jpvRgvNG0V3Q+MRkw2iZqvnLu76806sQXkM26kk+A1EPfU0L6LHnGYrtgXW9gnS2nhmGPm1ECpPm40TN8txiX+hCji13/vU5IfVshNQWznXNyLPtruM+dznF+TpSpzOn+BZVuJN0V16qriURBiaajh/+KPwAu0wvEDcjmECnQ8/vmDgrvnCDf69arp36+3xyR4Qd5swFT3KpxR+f1A0M+kuTfDNVgfBLHRmX1+EXp+vg9JEvkuKG2z61R9671KMl7y4GyTkeJqEht9wF7z4p8va1dy0ceIjxA76Sydh4IiI5nUGllp2w3MW6imBczUWqX21UOpeAKykSRq8t8HXr+vUnwjhiIbPaaP8h7tQ05kdgB+0WqnxB/8eA3M2LaT6VgfUPd1fYnpPoHJs12+8Kz0kFF5jSBW/+Jz4SqsXFLSTCbPhLQXbx89bhWuA7xOtrR58Ly2E9nNx+lEtBP2Hl/roC7OB4L9JsK4RsGThVTX66k/lz1913ORo7gvSOkbd47kXlSxvcpD16IKvY6GUyIsh8GtzZzwvyX747+QKtyPOPl89TqzOPvnXKgcgfyWg4UWLRk4sy7CI5RI5qMzNQ
DKIM-Signature: a=rsa-sha256; bh=P6oiuA2bqf1T45FBInf065Z+MPMNSAfbwm9LhajWHeE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791493753; v=1;
 b=PugD+SD7sNZMCe8c1OlYUE38nH0fLq0NL9Gp6EPK5Ej7eo0gdPgI5fmV9U/t3YGwsl8vpz4T
 2lpiS3uPuHwAYn4tZ6AetGmEcRnIuyGrTig6messrG49qJy9Ei7uEA5kQHJmvvp+42nn/UnCa+F
 /9d/xIuiubNMn+1/573O8ar13JG45ds0Lepmvomu8no50Xcy4VNjeGkrnivj4XCs6qlmOlq9J1w
 fbkONc0/GrE6+Ju/hSorFqztCb2SXYRMkCSgsqhtqxhZ1EFoEQyDXGk9KL/+pHAFtLujbWdfXvB
 DshbStTzCrkYqx+bmjEcN6whddxY2Tr9S3CE6bw0pWwCA==
Received-SPF: pass client-ip=51.210.91.44; envelope-from=clg@kaod.org;
 helo=smtpout5.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/8/26 02:52, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v2 0/2] hw/arm/aspeed: Sort device IDs and add IO
>> expander test
>>
>> On 10/5/26 04:04, Jamin Lin wrote:
>>> This series is split out from "[PATCH v1 0/11] hw/arm/aspeed: Use
>>> unimp array and table for unimplemented devices" to make the changes
>>> easier to review.
>>>
>>> v1
>>>    1. sorts the ASPEED device IDs alphabetically.
>>
>> This is already applied to aspeed-next along with :
>> https://lore.kernel.org/qemu-devel/20260930072501.2612119-1-jamin_lin@as
>> peedtech.com/
>>
> Please apply the v2 patch instead.
  
done.

C.


> 
> The v1 version breaks the AST2700 IO Expander 1 functionality. This is also why I added a functional test in v2 to catch this issue.
> As a result, the functional test currently fails on aspeed-next with the v1 patch applied.
> 
> The v1 change is:
> 
> ASPEED_DEV_IOEXP0_I2C,
> ASPEED_DEV_IOEXP0_I3C,
> ASPEED_DEV_IOEXP0_INTCIO,
> ASPEED_DEV_IOEXP1_I2C,
> ASPEED_DEV_IOEXP1_I3C,
> ASPEED_DEV_IOEXP1_INTCIO,
> 
> The correct ordering in v2 is:
> https://patchwork.kernel.org/project/qemu-devel/patch/20261005020428.3496039-2-jamin_lin@aspeedtech.com/
> 
> +    ASPEED_DEV_IOEXP0_I2C,
> +    ASPEED_DEV_IOEXP1_I2C,
> +    ASPEED_DEV_IOEXP0_I3C,
> +    ASPEED_DEV_IOEXP1_I3C,
> +    ASPEED_DEV_IOEXP0_INTCIO,
> +    ASPEED_DEV_IOEXP1_INTCIO,
> 
> Thanks for your help and support.
> 
> Jamin
> 
>>> v2
>>>    1. Split the device ID sorting change out into a separate series.
>>>    2. Fix the IO expander device IDs in the correct order.
>>>    3. Add a functional test for IO Expander 1 I2C.
>>
>>
>>
>> Applied patch 2 to :
>>
>>       https://github.com/legoater/qemu aspeed-next
>>
>> Thanks,
>>
>> C.
>>
>>
>>> Jamin Lin (2):
>>>     hw/arm/aspeed: Sort device IDs alphabetically
>>>     tests/functional/aarch64/test_aspeed_ast2700a2: Add I2C test for IO
>>>       expander 1
>>>
>>>    include/hw/arm/aspeed_soc.h                   | 176
>> +++++++++---------
>>>    .../aarch64/test_aspeed_ast2700a2.py          |   3 +
>>>    2 files changed, 91 insertions(+), 88 deletions(-)
>>>
> 


