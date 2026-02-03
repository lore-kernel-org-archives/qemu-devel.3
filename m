Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA5E87823
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFv3-0003f3-Ni; Tue, 03 Feb 2026 07:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnFv1-0003eQ-F9
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:54:11 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnFuy-0003XD-9U
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:54:11 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.252])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f53MS3cD6z5wPW;
 Tue,  3 Feb 2026 12:53:56 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 13:53:55 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005244cf335-4796-4710-9672-8332f3096abb,
 43D9FD9E6FAA5025B81087D7BA78A3446A80EEF4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e9056749-0200-495f-a5f0-b91f4dd2a100@kaod.org>
Date: Tue, 3 Feb 2026 13:53:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <TYPPR06MB820655E28A3A9BC11193688FFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB820655E28A3A9BC11193688FFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: bced37d9-cb60-4002-b234-475fd770f10e
X-Ovh-Tracer-Id: 17285941273314495477
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGnl8V17HOsoMu8kIRUj0mbePqFePCp77STM2rFnTLJykWP/PgTX+A5CNR1iMEqSH8l9uk9NiQxD39/8SjyYqCowfEKcHsvn/CUIN08AP3eQKjX2CNWcbhyI8SVkHjFzl5H8af2TqMDvAlrFtd20ZDXRrQYYAije1Ke4dWNP8NM2luxv20K8QaOzRf3ux3C/yQNKuGZ82PJAro2oCSap1QUo5hnIpQRnVbSkz6IdbbBwqxSSK6LH3SH+9xaU6T3biolNenFfqazkfhEFBiSAx045CkOtcrGEwukSUchp9PBti9eXc9SpddIJRj6nMSF99mh2LNKrT5jjHzAD93yeYS5gSoFsaySs4qDhNRBi4rBNnn6RsaDu/4L9WWp7VWp66h9fopvLIOwVzf8L+bFAZaEEtc+b1/fCWEc/UwZafeF9lVxMdqfyHQrhDmQUaO3+XPpgWoixzKXBus989uXIxJR3j+YqO8lVs7/gx7uBcqtbJiWqfpVzkqou6gjPdbIEXkTbjQwVfKnsyiOHKRSvYLyRGNG3ANnj6hqaWiBYEJOeiEWCf67GdgCJbngUMHukehYASqBqkGY0UXff62QDpaVgAwXEZ9+Vvo95tp9oSF0agJUv/xf+bCGs6sJmMIDIwjjiCJ4GrHmZy/s4LJU0cGd42i6NSCmJujOHvUbXVqHpQ
DKIM-Signature: a=rsa-sha256; bh=PwMC+xoGxSEYb0UvErO5SP4qTJquRsiKO7xlCHRCfaM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770123237; v=1;
 b=pHB1wUioGzOTexz1C+r6tR0BEUJkfJPNgHKmOvtZNDyiI+PKPzAvOV35lvxjE24R9FLiEZde
 Tpr55QuOrUTmqHym/tRaxmDtVCdxQoDnAX9PTgdhImd4QH36UbcEX31DcoLjNXVH/QmggJI3KuA
 mDKGTjVHtKL+XhUL9XnEDMa6ksOOOtUev951AssfFADBZQTu4oayHhe3jsmzeKpUSsy01ITsBrx
 ftxw9F+ObidWR+xiR2h+GGrSu3kTxFL8WSLneevbjIBUYixHxLf6N0aJ27uRC5ZljvvmgdKbpoD
 8mTppeLioYYP/LEkYzn88XJz3sCJqwWnM2KWM/Udh1fhg==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/3/26 02:55, Jamin Lin wrote:
> v1
>   1. Update test ASPEED SDK v11.00 for AST2700 A1
>   2. Fix DMA moving data into incorrect address for I2C
>   3. Fix EHCI3/4 IRQ routing to GIC
> 
> v2
>   1. Fix some extra 'From' info in the mail body
> 
> Jamin Lin (8):
>    hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
>    hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables by address
>    hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
>    hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
>    tests/functional/aarch64/test_aspeed_ast2700: Enable PCIe2 DTS status
>      for AST2700 tests
>    tests/functional/aarch64/test_aspeed_ast2700: Update test ASPEED SDK
>      v11.00 for A1
>    tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED SDK
>      v11.00 for A1
>    docs/system/arm/aspeed: Load raw U-Boot image in AST2700 boot example
> 
>   docs/system/arm/aspeed.rst                    |  8 +-
>   hw/arm/aspeed_ast27x0-ssp.c                   | 14 +--
>   hw/arm/aspeed_ast27x0-tsp.c                   | 14 +--
>   hw/arm/aspeed_ast27x0.c                       |  2 +
>   hw/i2c/aspeed_i2c.c                           | 87 +++++++++++++------
>   .../functional/aarch64/test_aspeed_ast2700.py | 78 ++++++++++-------
>   .../aarch64/test_aspeed_ast2700fc.py          | 54 ++++++------
>   7 files changed, 153 insertions(+), 104 deletions(-)
> 

There are still threading issues but at least b4 works now.

Thanks,

C.

