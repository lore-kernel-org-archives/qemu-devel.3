Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B59D2E03F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRRPc-0007yF-5S; Fri, 05 Dec 2025 03:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vRRPU-0007x5-A0
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:43:29 -0500
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vRRPQ-0006Cb-Cd
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:43:27 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.159])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dN4dx4Lh6z6MvR;
 Fri,  5 Dec 2025 08:43:17 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 5 Dec
 2025 09:43:16 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00267252dc8-e635-4303-8268-60b44dbdf2dd,
 59763B53E82CD9889501A3149EEF2B77A02AA328) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f0cb1f8e-bccd-4360-911a-f74560a350a8@kaod.org>
Date: Fri, 5 Dec 2025 09:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Deprecate the fby35 machine
To: Peter Delevoryas <peter@pjd.dev>
CC: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Maydell Peter
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <8f8fb825-891a-4c06-9676-4aa232cd4642@kaod.org>
 <2B4B594F-DFB1-4BD1-8FF3-8F74EB2EC52A@pjd.dev>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <2B4B594F-DFB1-4BD1-8FF3-8F74EB2EC52A@pjd.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: f6717cb3-3132-4f8a-8b9d-a29d74e50b95
X-Ovh-Tracer-Id: 11179341651219745781
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGPzYgO7juiaW7NkCuAZtFT0WypUs4+le0HDBPWCT3kqHx6eW/sgKMnKMdrG4DDAaB2qQRAEdoPgb5nVSfWwmrrU5/hSMiW3DwjXhlFAc7Pa6aFbYamkWRTkiNfgoTTEEtJ5DsoR4HmEpvMWD2CWDI5EscuYs8+yi1H7oeI3+J14vL3+yIwesQbGstWtqvssHvVSrXRxkeL5uN3//BipoQ/gIy196ZCLhYDPP30Kzoo331FmiaLud78MV+he5778giphnx+G3nY22vxbveI7a8GIyvvedrSxYkucB6sREKSC5I3LxdsukXu4WLkplQSRGjeYwjMw1cTfpZERcAZi5q8OFwYx4+2kddMkuAMuXloR9xDrhzVs1PUXI03m6mrrFw4sAfRbFo3oXObkndKCk50wMQ4uXhH6klKuiLt3nrDXrMTWV6QENkpxpqBf9v8nZIRYaZymyY//RL49b350eY8kWE6jUZeUgSwTC4vjwHu08fYq5MPOSQjD3zOdv9Zwq/H83rdzIgFVY5pnwRa/Z6EefrTYvMViBsWB6X1wbC39Lc5uAB4GAvV2IGb2yWQfgdJs/3pBqEhsg1hW/eT36U/T+KGZvLEFn5noRDrVck3/8t9lZpe14U1m0c8iVu+IodMMQPP5KxAa+KWTAIgHu0uDC8uq0ubuO/BFOCPhdBjZA
DKIM-Signature: a=rsa-sha256; bh=Azoqj59CU+Vb9APeV/ksGEqbdeV01VrZYrE9HnsB9Xg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1764924200; v=1;
 b=lC8SuRYEfyhR5YUA2NEcvmk2FaKJ5UuphS6gcReEY7yd1IupI0NE6v61K10HqK4GYe237V3R
 q2221RuuiJfMOwZCczs+gt/FdqtV9pe07s0YMViHh+UsjDcmIUaqqQ3fVq1/oq0Z3GcMNPQ4Fgb
 XJ52FH0UMJdGPOxonTSYmC28YYIsG2MUywXxi9XCFCVHn64FPGxUlMlO7RTKtLyf6dr24g8TLvR
 BaHPh4WQcCPj0rqSpF5347DAnN6+6Q/e+CJVeQyfRoqkAB5BMNzwT6562xhLwSuXLUNL5IcidnW
 QqQF8huqKz+fxszLIUrLnEdy4LEl1/gvaJgAor5GNuW3Q==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/4/25 20:45, Peter Delevoryas wrote:
> 
> 
>> On Dec 2, 2025, at 11:42 PM, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> ﻿Hello,
>>
>>> On 11/26/25 11:24, Cédric Le Goater wrote:
>>> There are no functional tests for the 'fby35' machine which makes
>>> harder to determine when something becomes deprecated or unused.
>>> The 'fby35' machine was originally added as an example of a multi-SoC
>>> system, with the expectation the models would evolve over time in an
>>> heterogeneous system. This hasn't happened and no public firmware is
>>> available to boot it. It can be replaced by the 'ast2700fc', another
>>> multi-SoC machine based on the newer AST2700 SoCs which are excepted
>>> to receive better support in the future.
>>> Cc: Peter Delevoryas <peter@pjd.dev>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>
>>
>> No objections ? If not, I will queue the deprecation for QEMU 10.2.
>> Since deprecation is tolerated in the -rc phase.
> 
> Oh hey, sorry I missed the original email, yeah no objections! Totally fair. :) We’re not using this internally either, we’ve mostly ended up pursuing multi-process solutions. 

Could we have your Acked-by then ?

> Even though I think single-process stuff is interesting, getting multi master i2c to work between socs in the same process can be tricky.

Yeah. This is still WIP. Making good progres though.

Thanks,

C.



