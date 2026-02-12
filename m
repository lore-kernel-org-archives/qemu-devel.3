Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B20EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRYS-0007AB-Ai; Thu, 12 Feb 2026 02:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vqRYP-00079u-Eg
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:56:02 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vqRYL-0006Wv-HP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:56:01 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.78])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4fBSKN2X50z5vs8;
 Thu, 12 Feb 2026 07:55:52 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 12 Feb
 2026 08:55:51 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004e6ee8168-4771-4b4d-af75-59e9eff3fe00,
 5ECDD1DB171B3EC4A5C9F109ECF6661A1890414A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <44801358-496e-4cef-a33e-ca91745a15c8@kaod.org>
Date: Thu, 12 Feb 2026 08:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
To: Kane Chen <kane_chen@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
 <SI6PR06MB7631B5BECA948F629031A0E1F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631B5BECA948F629031A0E1F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG17EX2.mxp5.local (172.16.2.172) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: b83bce78-e20f-409c-baf3-db30882ebdd7
X-Ovh-Tracer-Id: 9766055796169542645
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGKxU/mKVE6/S0woPNkD0skKRhp+/vP4mBxVzJm5zqvrCS8rLOFlu1YIHASvpepxYUvWTmAjtodxQM+GeYNYUIl30AO8ayZ8oB1lBhMSMmOP3T8G3uaZ+2xNbtSDeNEcGCry3nn4Xuu0bHXc67RIYSGXJ+cu52+jXDPZLElzwpmy3/i5PItUM2LroCalEifX3uCNzsm0Dv/5vstcFIPX5lFIoDK4MJgMmNb6iNEA+jToFhcq3nYXkr4+j3/6VTbbhG5Y+eCrvWxZHIJtkp8MkX0Jxq9yrt3Ix1BHYW+pOxMUBkEiUCetKIAG5rzbjBvSov5JJDyl6qeDTaVjwGaJR+dleJHfpc8RzerK42ohAZU4Rr7nPuGg6T+ZuGw6kZ500gD7UCu7Vgj4h6xFrYCIBFeJRep0lzGdZRFG0V6hT3NDNp2vZkp4AsNH1glfOjuS7ImckH5EkpK4x+zmR5gsNxjdYAxC9f0xd4yAUDOGtF5CXl55vXTCHqfkHNV4P9ulQ00L4xOLtViwD2mIiFzQQwQuKo9Fef4miJthWOeNA/Y9EqGChtr3q5Yi10OR5W2J0QRmsGATU2dFQabhorVNcxAKRZLjgGB5nO7fQWczoZJrGFMW7x+3flZpLhHHeKgwwWZwo7bbpNWobpu05swYel0mA2owplrj9MmAnFn9VxNhQ
DKIM-Signature: a=rsa-sha256; bh=r3BwugiSD2Bgrwuji/yDjrGOHl3qi/Q89nfI0awMHCc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770882953; v=1;
 b=T+XB5d17RtlRLQCkx7zcSq3dXGJpIDDs1nHIIp7hscGacwAXHyBop7tN9yewglj9ckq+aJ8b
 HOuMGhGlEvPKO4sQS5Ow+cp7Ri8jJ2oGCYdYyYQqDKw0w/VuC/jLZeXKET8zj42FwnndzrjolNv
 tL6sntJbXqPURZsKY9cjb1GTVisVeL3BlDW87KweZuuE00bxxjWdjklPatEqq3ISZ8NChpeS5LM
 T1C9BWfAoGLKWWzHzKRclbSJmhHjJMGWPVDh4nN3HX1F1DB3Reo2bSi+yEw7ysNyGL6iAb3sNZ6
 QAwxUJ4J1eZQORhVRV+giGp807623VtBUuV/Bujf+VOiw==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
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

Hello Kane,

On 2/12/26 04:39, Kane Chen wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Wednesday, February 11, 2026 4:33 PM
>> To: Cédric Le Goater <clg@redhat.com>; qemu-devel@nongnu.org;
>> qemu-arm@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Thomas
>> Huth <thuth@redhat.com>; Kane Chen <kane_chen@aspeedtech.com>
>> Subject: Re: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
>>
>> Jamin, Kane,
>>
>> Could you please review this series ?
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>> On 2/9/26 07:50, Cédric Le Goater wrote:
>>> Hi,
>>>
>>> This allows the functional test suite to run tests in parallel more
>>> effectively and adds a new set of tests using the older Linux 5.15
>>> kernel.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>> Cédric Le Goater (2):
>>>     tests/functional: Split Aspeed ARM tests into separate files
>>>     tests/functional: Add SDK tests with Linux 5.15
>>>
>>>    tests/functional/arm/meson.build              | 18 ++++--
>>>    tests/functional/arm/test_aspeed_ast1060.py   |  0
>>>    ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
>>>    .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
>>>    .../arm/test_aspeed_ast2500_sdk_515.py        | 29 +++++++++
>>>    .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
>>>    .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60
>> +++++++++++++++++++
>>>    .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
>>>    .../arm/test_aspeed_ast2600_sdk_515.py        | 29 +++++++++
>>>    .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
>>>    10 files changed, 196 insertions(+), 73 deletions(-)
>>>    mode change 100644 => 100755
>> tests/functional/arm/test_aspeed_ast1060.py
>>>    rename tests/functional/arm/{test_aspeed_ast2500.py =>
>> test_aspeed_ast2500_buildroot.py} (74%)
>>>    create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
>>>    create mode 100755
>> tests/functional/arm/test_aspeed_ast2500_sdk_515.py
>>>    create mode 100755
>> tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
>>>    create mode 100755
>> tests/functional/arm/test_aspeed_ast2600_sdk_515.py
>>>    create mode 100755
>>> tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
>>>
> 
> Hi Cédric,
> 
> Thank you for the effort in improving the test suite. The separation
> into firmware-specific files makes it much clearer.
> 
> This series is reviewed.
Could you please send a Reviewed-by: tag ?

Thanks,

C.

