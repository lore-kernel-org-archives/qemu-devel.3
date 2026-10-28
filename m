Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B6606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=q6DeWMwT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzYm-0000Wj-WF; Wed, 28 Oct 2026 05:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzYk-0000Vc-Il
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:03:02 -0400
Received: from smtpout4.mo538.mail-out.ovh.net ([51.210.91.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzYi-0003av-GA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:03:02 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jF1bj2WgDz6DYN;
 Wed, 28 Oct 2026 09:02:57 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Wed, 28 Oct 2026 09:02:57 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.53])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jF1bj18gxz1xqK; Wed, 28 Oct 2026 09:02:57 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 3E9B019231F4; Wed, 28 Oct 2026 09:02:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S00311948785-e9b5-4531-8901-b70805559acb,
 E08929C5676352A1F51837021B168DD299C323AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <1db3970e-5e8c-40d1-9a6c-87aca288c6d8@kaod.org>
Date: Wed, 28 Oct 2026 10:02:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] hw/arm/aspeed: Add AST1040 FMC/SPI controllers
 and unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13421008368489573421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF/cy3wNeUwtFnfXAjGNTzp/VwYaMb9X5uTwQ3AUMnoafam+VI4u9sLUndSLCWEf7UDSABYuJLMXxWAaybgfjDMbgteyLR10TRQEdnR4s4HMGOWOnX+6MRR7s3aW2suM2JjBDSGojnfWazZXqaUI33FnrwsZC2lbmBotzMwo63HsQ4Fy8Z+sKEGblreC+ejB3zmZu8rYOILUMC4PoHgp6LUWdSACf75L2IJ2/YXIq6njsBdtR+y1KsbP1v6jQU4SSZZkJ9FZBfj/KbsQ081XCLjTGunKJ+TuJLjXqM+pJo5gdsepXteqwcrqNtZa00HDfAi4Fk1VfMYIOdjYptB5m2OspXn+SK0Sgndj6iy8yFQfF6seM88YtBPlKKXURyfHktHpBUWXgBO8mtuUQsJobe+V7erGKMnBQ7hkLG8OQno3E+AM65FPIImh33jXKOkmM49YXII3MtBQjofczn5Vf83JzrNdB/tySF0Uy5QJAYsDSKIx5NGrH7HILPAyE8FmHSljc2aJWtzkBbMgEjUAs98WPOMuprqgTyACoO9SlOVQKcDpDPWceKTXcfqFoFEL7cDaxM1r7bB7Gf1rZJbyYYjZVdQOe0BMj9bVdRXaeqif6bhITJKy0sKEIkZvS9UpyR7jo3X1R/nrMih0Q8TubE31cPa1Hkp6h6K3ysnGP78nQ
DKIM-Signature: a=rsa-sha256; bh=DVzxAO9HLlHPapkyUcxqJFhHiYiFnzprl3r9Jqc3pOA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793178178; v=1;
 b=q6DeWMwTyZBRHAVv85AJJzgViiiw2k2mkH3+vKWqRnJkC1GouyayAq149XRjOb4/j+fVoC2y
 GKIhmOi9+Q2kGGFm3/MZp+k/k/JjlEsZwkkVrwtkk3y3/cCGh00VuLJJTIdV/RfubY2rWIbEUEZ
 QhvcpjeSkKiy910DONa1vM7MG5szFv9xkI/X5CcI6/7rQRkniTsW8RQSmTSF+58SXfe7Nm7xAm1
 mFTaM9MNR9uziWozXRajIs5V3ZiyTyd7Z/oyJgmYKgJDEWg241+VF6S6yw9o8wHgOH8R7qNTEPf
 tKcPLQBvsilD6BKYyd20GTkCpuqc1wHCMCfAr2y04O2zA==
Received-SPF: pass client-ip=51.210.91.33; envelope-from=clg@kaod.org;
 helo=smtpout4.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 03:31, Jamin Lin wrote:
> v1:
>   1. Fix AST2700 segment end address decoding
>   2. Fix AST2700 DMA flash address mask
>   3. Rename w25q32dw to w25q33pw and add the SFDP table for the W25Q33PW,
>   4. Correct the AST1040 A0 silicon revision ID
>   5. Add FMC and SPI controllers
>   6. Add the FMC/SPI filters, OTP, ATC, I3C and Caliptra register
>      regions as unimplemented device
>   7. Update the AST1040 functional test to use the official pre-built
>      image from aspeed-mcu-fw-hub v01.00.
> 
> v2:
>    1. Add w25q33pw as a separate flash model instead of renaming w25q32dw.
>    2. Add the AST1040 SMC reset value table.
> 
> Jamin Lin (13):
>    hw/ssi/aspeed_smc: Fix AST2700 segment end address decoding
>    hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
>    hw/block/m25p80: Add Winbond W25Q33PW flash
>    hw/misc/aspeed_scu: Correct AST1040 A0 revision ID
>    hw/ssi/aspeed_smc: Add AST1040 FMC and SPI controllers
>    hw/arm/aspeed_ast1040: Add FMC and SPI controllers
>    hw/arm/aspeed_ast1040: Add FMC and SPI filters as unimplemented
>      devices
>    hw/arm/aspeed_ast1040: Add OTP as an unimplemented device
>    hw/arm/aspeed_ast1040: Add Anti-Tamper Controller (ATC) as an
>      unimplemented device
>    hw/arm/aspeed_ast1040: Add I3C as an unimplemented device
>    hw/arm/aspeed_ast1040: Add Caliptra as an unimplemented device
>    tests/qtest/aspeed_smc: Add AST1040 SMC tests
>    tests/functional/arm/test_aspeed_ast1040: Update AST1040 image to
>      aspeed-mcu-fw-hub v01.00
> 
>   hw/block/m25p80_sfdp.h                      |   1 +
>   include/hw/misc/aspeed_scu.h                |   2 +-
>   hw/arm/aspeed_ast1040.c                     |  45 +++++++
>   hw/block/m25p80.c                           |   2 +
>   hw/block/m25p80_sfdp.c                      |  36 ++++++
>   hw/ssi/aspeed_smc.c                         | 131 +++++++++++++++++++-
>   tests/qtest/aspeed_smc-test.c               |  61 +++++++++
>   tests/functional/arm/test_aspeed_ast1040.py |  12 +-
>   8 files changed, 278 insertions(+), 12 deletions(-)
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


