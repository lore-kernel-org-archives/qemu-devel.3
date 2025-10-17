Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD77CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dM0-0003Ea-KO; Fri, 17 Oct 2025 01:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9dLs-00038C-S9
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:50:09 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9dLn-0004dI-Q3
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:50:08 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.167])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cnv6Z1RFyz5x6S;
 Fri, 17 Oct 2025 05:49:58 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:49:57 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0029bdceaed-dd06-410d-a4db-a64fad21235b,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8483b727-f8c4-4626-8b04-8e2867a0a480@kaod.org>
Date: Fri, 17 Oct 2025 07:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add Aspeed GPIO test and Support Nuvoton Serial
 GPIO Expansion (SGPIO) device
To: Coco Li <lixiaoyan@google.com>, <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <flwu@google.com>,
 <andrew@codeconstruct.com.au>, <philmd@linaro.org>
References: <20251015011830.1688468-1-lixiaoyan@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251015011830.1688468-1-lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 30608c05-2de3-4bb5-81bc-c07dca71739a
X-Ovh-Tracer-Id: 15638186757671848809
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTExn6INrKLxWkQJYtU6LCQH/m65B5PntwiUm5oflpSqZUZDA330n33UyPp3Ovn61gFKIBTp/8AJbmOJBQrmQNFdP96RlZnoOqs1ONQVM2jiZRo9/KS0sdN+tXcbR2L8QQqXAq45zrlYFDGDQXaxoTFTgo561gSfMnJTCAucculylRcr4jJ1NhU3UzJpsLPqSlhsG6l5Q/PR1dgGxLbSNx6X1MpRIgYoIOxgz07pdSXRASwQSlID1qvxUmv5mOrIWvxxfYOaIKxvGWSCMknfVKMAZjagVcBPJ7YHl0Za/eC539OuZHjUpxER598bMam9+BtgTDOnibC+3rff5fRwCOnKDCi0Vtjt78F1LLAc8dhaeAWAdePjpjB0jAmH/tQu4vrtTyAwGRekf/oah7100L9pawLQAz+PuOZV+Bg7kVVgTqmDmhSVQMYAJh6DWDCfbaWud+LKBMWBqluZOmHueQmZbnpiMemev8AFcVbZUiw22ezL26HiI6PruyXqoVopt7DJmwmjF8T0o3Jata8Nystaa7uHNmpLI/O55zVdCmjG0TIAbuMt8Vu9ySl/1x1xTmS5gIY0pv3hnbrhygxXg8KzN17qS6m2UUtg4cokisBwEwPOUOKd835w4dc3FvVMlPIcNurhjO3e3uwDT7bc9WjvSYI4XCUnbJ/OPinYwgo/Tg
DKIM-Signature: a=rsa-sha256; bh=EID7rj2yXLIJcWWalARjptsn44rq8y5wd1Ghlajd7no=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760680198; v=1;
 b=HfdLEXY/51e40wNBi3k+FzAeNW5FcWLq67Hmg4/KoddbnFsnGgh4u6n/9EXwfAF4tsVD7YoE
 VfwqhLAqfx7V3rs5AQewxcePWpq1+vw4pQ36TouFBQoVcAl69Tqa4WXAtSNTkRHbi28OTQ81Jhg
 zFuHxQTzuoVlf2cinxS1SDr19lkxp40D+VHOD4cLGjgRt7nKtV/D4xPUaismOuNqHa8d4w2bEHj
 19N6bFHtbk3j6Ey6kkZCE1TwCoBYNgji6D1EzDrpDvNXwBG1YE3OEmuFw9IbG/9rOWWGyEGGfDY
 Vn+Nh5ph6l1yMb060KV9oALVkZKj5vRSL9dggqv43oYGQ==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/15/25 03:18, Coco Li wrote:
> GPIO series:
> Added 32 bits property for ASPEED GPIO with updated qtests.
> 
> SGPIO series:
> Implemented SGPIO device according for npcm8xx.
> Two notable implementations left undone in these patches are:
> 
> 1. Reading the data from the host controlled SIOX via register IOXDATR
> 2. On-demand with polling reading node
> 
> The reason for this ommitance is that both features are currently unused/umimplemented by the nuvoton driver.
> 
> The changes to qobject is used in both sets of patches. The patch series implements indexing gpios with array indices on top of accessing with registers.
> The reasons for this is becasue it creates another easier way to access gpio. In our internal tests, we model complex behaviors with a large number of gpios, such as in fault injection, or in networking behaviors.
> Indexing multiple gpios at once allows qmp/side band client to no longer hardcode and populate register names and manipulate them faster.
> 
> Updates since V0: added more descriptions on qobjects change in cover letter.
> Updates since V1:
>    - added more description to "hw/gpio: Add property for ASPEED GPIO in 32 bits basis" patch
>    - used bitops.h for bit operations in "hw/gpio/npcm8xx: Implement npcm sgpio device input pin"
> 
> Coco Li (3):
>    hw/arm/npcm8xx.c: Add all IRQ ENUMs
>    hw/gpio/npcm8xx: Implement SIOX (SPGIO) device for NPCM without input
>      pin logic
>    hw/gpio/npcm8xx: Implement npcm sgpio device input pin logic
> 
> Felix Wu (2):
>    hw/gpio: Add property for ASPEED GPIO in 32 bits basis
>    tests/qtest: Add qtest for for ASPEED GPIO gpio-set property
> 
>   hw/arm/npcm8xx.c                 |  66 +++-
>   hw/gpio/aspeed_gpio.c            |  57 ++++
>   hw/gpio/meson.build              |   1 +
>   hw/gpio/npcm8xx_sgpio.c          | 518 +++++++++++++++++++++++++++++++
>   hw/gpio/trace-events             |   4 +
>   include/hw/arm/npcm8xx.h         |   2 +
>   include/hw/gpio/npcm8xx_sgpio.h  |  45 +++
>   include/qobject/qdict.h          |   1 +
>   qobject/qdict.c                  |  13 +
>   tests/qtest/aspeed_gpio-test.c   | 105 ++++++-
>   tests/qtest/meson.build          |   3 +-
>   tests/qtest/npcm8xx_sgpio-test.c | 222 +++++++++++++
>   12 files changed, 1024 insertions(+), 13 deletions(-)
>   create mode 100644 hw/gpio/npcm8xx_sgpio.c
>   create mode 100644 include/hw/gpio/npcm8xx_sgpio.h
>   create mode 100644 tests/qtest/npcm8xx_sgpio-test.c
> 


Applied patches 1,2 to aspeed-next.

Thanks,

C.



