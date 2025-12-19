Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCA3D7497F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdba-0001Qt-L5; Fri, 19 Dec 2025 11:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWdbQ-0001L6-Ao; Fri, 19 Dec 2025 11:45:17 -0500
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWdbN-00023f-W0; Fri, 19 Dec 2025 11:45:16 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.171])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dXtgP5B92z5w1c;
 Fri, 19 Dec 2025 16:45:05 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 17:45:04 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0074fb417e3-955a-4214-a165-351b0e6e5bd7,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <68041580-c434-45ec-bdd3-b20f7c4fed43@kaod.org>
Date: Fri, 19 Dec 2025 17:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 00/12] hw/arm/aspeed: Add AST1060 SoC and EVB
 support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251112030553.291734-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: ecdb76dd-8a19-4b23-95b4-1dff68397a78
X-Ovh-Tracer-Id: 9299933231506295614
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFObtiDUkSl+Op618lcoGwzIaJkiIExq90CcZ+FvNr2XymBYIhsqCPflsizVwTVbOGwf5ObuRc4j+r3t+E8Xyr5tHiNkOnBaRIsxLtlx5GSOB6BHGRex9je2DppBxOYppaCjUvpv8EWhCaCsMkCL9Ralh2GndiP+quHScwyfinFXfkYHJQmfmc1g6tR3tGstP0IvQCWjfMTZ0tZwpGbLsBkp4UZZaT8zb28h8Oz8hu3IRLLeCRJ5CoZW4mpsAKKukQNUTIuTlHZDkEzlrNyICIGfWww9ZyXoZa0PgQeV5oEbUlmruTmnLL4KkXvVHD7ltOSxHgd1Mf1ZIlpU2hN506ik4/LexWXXWxvIIeddm5C4AA4v0N9QkQslcQP+NwyGmsxqScTeIEr0Gvgu4PzTzX76hBRRsO+THEme3lY6uvt0IxE8NbfALN5ooT4pMo9fYdEQIlonIZjGFJEJSzfk0JJ4xRW+Lk5wJ2aV7O4KKY8ASqFRZQRfMA9GRvkUqzqA4DIx9x7ax8WfkugrzGefUi+1kXsiRIgUs0iVaKrg0i4y4pBy1kOYx8Os3Ajfj6wdVSgfFyKlqmh+dGIWS10PI7GX8uHtQnOOEvrbzWUUM6MfChrl0BmABjeEnwnL3A6aoV/MyZfyX8ouSqAmZ8KYey/wZ+kGID1lYXCSkpIQE/D2w
DKIM-Signature: a=rsa-sha256; bh=BQEaoPeic6Zn3kVCdEkLXGiT1snUl+zVVzwMZ99eNyY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766162707; v=1;
 b=AA2Hrue/ORRGvpjXkgcFoyVzK3Wxc6Dj8vkdye/z7xR4Jkx9HNvV2PAL2bZzar28liuY8xCb
 NCe/n8/pC+BhIMgbszZX9k3qPgHifcAg9/yXroeG/PZrnNLvf+mXNJnbyogZwECD8XZgSdZu6iA
 nT+UoaaJ2uqTtdjGwlFd207DYpNTOc7GD+IvqMUXcmSsymIFRcpziA0zOgvTkYqBpFXhHejVcFJ
 jm5jlnEHgrdrHOY0L+DjaiQqtSI0siBUZ/2E9EQlbZyHd+7PHlkW6Rbz+DLXXurYhmwPRsRm+LO
 EapZjQrm85Gh1wrx4tC8ZNMBmvoeCxWq/IB8Dun0dFvPg==
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

On 11/12/25 04:05, Jamin Lin wrote:
> v1:
>    1. Add SFDP table for Winbond W25Q02JVM flash
>    2. Add AST1060 SoC and EVB support
>    3. Fix missing SPI IRQ connection causing DMA interrupt failure
>    4. Fix the revision ID cannot be set in the SOC layer for AST2600 and AST1030
> 
> v2:
>    1. Fix review issue.
>    2. Use "Platform Root of Trust" instead of "PFR"
> 
> Jamin Lin (12):
>    hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt
>      failure
>    hw/block/m25p80: Add SFDP table for Winbond W25Q02JVM flash
>    hw/misc/aspeed_scu: Fix the revision ID cannot be set in the SOC layer
>      for AST2600 and AST1030
>    hhw/misc/aspeed_scu: Add AST1060 A2 silicon revision definition
>    hw/arm/aspeed_ast10x0: Add common init function for AST10x0 SoCs
>    hw/arm/aspeed_ast10x0: Add common realize function for AST10x0 SoCs
>    hw/arm/aspeed_ast10x0: Pass SoC name to common init for AST10x0 family
>      reuse
>    hw/arm/aspeed_ast10x0: Add AST1060 SoC support
>    hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB machine support
>    tests/functional/arm/test_aspeed_ast1060: Add functional tests for
>      Aspeed AST1060 SoC
>    docs/system/arm/aspeed: Update Aspeed and 2700 family boards list
>    docs/system/arm/aspeed: Update Aspeed MiniBMC section to include
>      AST1060 processor
> 
>   docs/system/arm/aspeed.rst                  |  27 +--
>   hw/block/m25p80_sfdp.h                      |   1 +
>   include/hw/misc/aspeed_scu.h                |   1 +
>   hw/arm/aspeed_ast10x0.c                     | 209 +++++++++++++-------
>   hw/arm/aspeed_ast10x0_evb.c                 |  23 +++
>   hw/arm/aspeed_ast2600.c                     |   2 +
>   hw/arm/aspeed_ast27x0.c                     |   2 +
>   hw/block/m25p80.c                           |   2 +
>   hw/block/m25p80_sfdp.c                      |  36 ++++
>   hw/misc/aspeed_scu.c                        |   5 +-
>   tests/functional/arm/meson.build            |   1 +
>   tests/functional/arm/test_aspeed_ast1060.py |  52 +++++
>   12 files changed, 278 insertions(+), 83 deletions(-)
>   create mode 100644 tests/functional/arm/test_aspeed_ast1060.py
> 

Applied to aspeed-next.

Thanks,

C.

