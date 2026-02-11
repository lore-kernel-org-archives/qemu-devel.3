Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C9E9E2FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq93Y-00085Q-6e; Wed, 11 Feb 2026 07:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vq93S-00084P-K4; Wed, 11 Feb 2026 07:10:50 -0500
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vq93Q-0004zF-LR; Wed, 11 Feb 2026 07:10:50 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.52])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f9y1w0ksFz5vRx;
 Wed, 11 Feb 2026 12:10:43 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 13:10:36 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001f46e54fc-1314-4bb6-8ec7-c8bc1a171f58,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <02375eec-2e5a-479e-b560-9c5c425f6cc7@kaod.org>
Date: Wed, 11 Feb 2026 13:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Support ASPEED AST2700 A2
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG17EX2.mxp5.local (172.16.2.172) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 1af37ce2-cced-4f11-ba5d-61331aa02989
X-Ovh-Tracer-Id: 8195706898719607614
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8F+qvljyKFdBDkuuwUjpm6BhuwLR4m4CZL2yAxYAiWZQaheV7UFmIcepTYEWd5LkacadcRQ8HiVAQpZJpmDfOjCuI1Ogj+C38WoqROpVpM0kXdG1pwbOJntYmJkyMJVonPp8fhp/oKMFJuQ6ymobc/jPys3j24RV5l0VDCTKv5sidThxuSxlsqLqdrWibD+yaXhcC4HlmhpbWvA6l0fOqLuaeeINgYBFoirFCh9ryyvIFimbHLNjkSr8TRpT276hYotJcb3g3jxux7Op8eSmiQpkn39v3kwL5G78h2FjV0elWQZSxmyc0AAkZG0gwiO8rLl8NrcjrFqX1VylhSj/BebjBsN23AQPlO3hmfsG9H5QWCTu2wJ/rg3z+i+u3nA1asZqj6gX0bSJlbcrgzqAUUmng+Puw0M9phu2iuRaZYYfntdJuI3084heDLsWh7oMo1wDtIVmkZ8dSzKmLE024C3Csmf1Mm55XnOMi9BaPIsK4mAbNuLa9eOaFSuBxPYjPR1IK5ioIEzk6D5aNydnSQjPUmf6vPNZm32IzPvj50QESNPu+NO63TtpbjByllTuG0NdOIsiIBXD3oDuzI7Xeovsh7lQNKae2KordP+muXYJbMiP3ULKWhVaVn9z19S79tXp0UbuN1acz6QU5tupHRAZYyCPTzPSLl6RxMSVQow
DKIM-Signature: a=rsa-sha256; bh=pE/Mls6yO791yybTrP7CTnC030lwjwZT8XT6zNH5R28=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770811845; v=1;
 b=E2hXAOKI78MOVZoj3Ggl6OlM/vBEH4NJZ7VC0Mm0fcN7N+iyY8XbzRUiwIojU3eoEZIhULHb
 dCiJMQ8PR6+gduPwxrTGPwJmNCi+T+52D7tc2+EhE8wXyaeS8+orO0EA5yRfucksM2gmrdDl+Rc
 zZIemzwg0nLr2T62cSXcJ17GJP5zoPt0cLUs5CBpMTYE/8vqtJ4pRCNa3Qdsi00sNnJwZEbt6B9
 3TFNcL0YFjqWkw8K5kQOfX+YbpoiJJmftLszkG6Q37LpgykMBiB7PSiSFkqnsmNSoCVn6bl2n8l
 AEhA5XceYDsFbXQMgRJOox0WucfxHt2ecCZcNjW5/BObA==
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

On 2/11/26 03:15, Jamin Lin wrote:
> v1
>    1. Add AST2700 A2 SoC support
>    2. Add AST2700 A2 EVB machine
>    3. Alias ast2700-evb to ast2700a2-evb
>    4. Switch AST2700 FC machine to use the A2 SoC
>    5. Update functional tests for both AST2700 A1 and A2
>    6. Fix I2C Fix Out-of-Bounds access issue
> 
> v2
>    1. AST2700 A2 is functionally identical to AST2700 A1.
>       There are no changes to the IRQ layout, memory map, or peripheral
>       configuration; the only difference is the silicon revision.
>    2. The ast2700a2-evb machine is largely identical to ast2700a1-evb.
>       The only difference is the default DRAM size, which is increased to 2 GB.
>    3. The I2C out-of-bounds fix has been separated into a new patch series.
>    4. The increase of the I2C device register size to 0xA0 has been separated
>       into a new patch series.
> 
> v3:
>    1. Rename to test_aspeed_ast2700a2.py for AST2700 A2 testing
> 
> Jamin Lin (11):
>    hw/misc/aspeed_scu: Remove unused SoC silicon revision definitions
>    hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions
>    hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
>    hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine
>    hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to AST2700 A2 EVB
>    tests/qtest/ast2700-hace-test: Use ast2700-evb alias for AST2700 HACE
>      tests
>    tests/functional/aarch64/test_aspeed_ast2700: Rename AST2700 A1 test
>      to reduce test runtime
>    tests/functional/aarch64/test_aspeed_ast2700a2: Add AST2700 A2 EVB
>      functional tests
>    hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine to A2 SoC
>    hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM size to 2GB for AST2700 A2
>    tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK
>      image for FC tests
> 
>   include/hw/misc/aspeed_scu.h                  |  11 +-
>   hw/arm/aspeed_ast27x0-fc.c                    |  15 +-
>   hw/arm/aspeed_ast27x0.c                       |  36 ++++
>   hw/arm/aspeed_ast27x0_evb.c                   |  29 ++-
>   hw/misc/aspeed_scu.c                          |  11 +-
>   tests/qtest/ast2700-hace-test.c               |  22 +-
>   tests/functional/aarch64/meson.build          |   6 +-
>   ...ed_ast2700.py => test_aspeed_ast2700a1.py} |   0
>   .../aarch64/test_aspeed_ast2700a2.py          | 190 ++++++++++++++++++
>   .../aarch64/test_aspeed_ast2700fc.py          |  16 +-
>   10 files changed, 286 insertions(+), 50 deletions(-)
>   rename tests/functional/aarch64/{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py} (100%)
>   create mode 100644 tests/functional/aarch64/test_aspeed_ast2700a2.py
> 

Applied to aspeed-next.

Thanks,

C.



