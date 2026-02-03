Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72EAE87822
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxM-0004a3-9v; Tue, 03 Feb 2026 07:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnFxI-0004XZ-2H
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:32 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnFxD-0003w9-4d
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:28 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.87])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f53QH1SD9z5vwc;
 Tue,  3 Feb 2026 12:56:23 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 13:56:22 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001859ba12c-2476-4f9f-b524-ac2b990b8985,
 43D9FD9E6FAA5025B81087D7BA78A3446A80EEF4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b459b2ff-a21a-4fca-add5-4eb0447b5fa3@kaod.org>
Date: Tue, 3 Feb 2026 13:56:21 +0100
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
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 40a574d1-6be9-45b4-b5fc-9aa10542dcfd
X-Ovh-Tracer-Id: 17327318091653352437
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8b7vUdgCd5eiBbOtN2FP0k0ZTqypJNY1io2KKvVo9wezmpSjJOsa5st3weVfXXCtlHjR7SLhq+q3i+wV4omO7LOexSYUjLgELFk5tA4wTHwUv/K2siXiQhyfMGNfhm1P0s7zzUmH/Ph7rai2H13ZFgBOAkrXBWewRiA6dWu+ppqBmECPt7ztIFHZLdVnaxLOMCXL4KsV/yWgybGhBdRQMgQpah25OhxEi/F/TFvxyXp7yvCLzx730GC5qjDhA2yD3ZQigemynpnEfnN5js9ARM7otfYd4euVV6u+AMPVMQ61o0RD80L4qbGHEFApxFkrgMb3P20au2jPIblRW1DRVQ9U5ED51vSwmjqjcoWKULK0LfpJwq4DOHSuFrN+GPNibcGIcAZsY/dI0EAOg2rx4CI6Qf0AAlqNwqYnMbNsbA7Ap7fkAwWvfsQhhFwjaHwvZgNxn7vSWmeup1OuZKy94BO7iWLzaWKuXGZgd4aNCzI7zqJnMypk6dP78EV/TfAyFUzsi1DElFrYfJc2YJ2ecxT0HOvDw6d9QYc0RyPCcgdHyi0tVYfTX4u6cE8rd/O8gWTkvAqaWGV3K7H1E4RNkp4q8E0eoiWgkVPFgAZ92ybUV5muH2SEg2Yzk8Itaseru63UzZEBKw0O6Zy6y4/qI6fEFsec+mE4shvW7Xzq4Xw
DKIM-Signature: a=rsa-sha256; bh=42F2GFYIMhRS2PQCAqg/3GgVTwZeMi+RGhd8IXHgk0c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770123384; v=1;
 b=DQAkauXm1eBpnP2xORANLS4AKGKrVeO2D21kcmX34zesI1pABQE0JahpVQFkYLNUcOzts6+u
 zZ9M0nsfLWIgGQRWRutwN3GUWfXQu73IV/dfw6ASNcf5u0NWek7wADyfWmiO3nY0JXJGQ6woz0Q
 wV7nDYj+u7IexX8Ssud3hsEnnk/qGiEDcD39wqbbo9WET9gB/TQGVYbhkqM4a/ZUNYgrFyFfaRO
 TvSTJSzfgw8OcxQaPyGAxJC50+lGVtm+QfU2OvMNktvRl0m9917cAmn72BxwjRqzp3E60gFrvS3
 CS/ZeyF8zuQlbgpCqMMya7R5b1kHNJXkNofCP4X0zEJ8Q==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
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

For the series,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

