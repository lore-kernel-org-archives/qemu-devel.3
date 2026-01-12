Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9BCF45C1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMy0-0004oO-QL; Mon, 12 Jan 2026 13:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vfMxK-0004lq-Bg; Mon, 12 Jan 2026 13:48:01 -0500
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vfMxH-00062y-D3; Mon, 12 Jan 2026 13:47:58 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.170])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dqhFw1w64z5vqF;
 Mon, 12 Jan 2026 18:47:48 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 12 Jan
 2026 19:47:47 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003648a8dad-ba66-4aa1-a790-9ffbd59cf054,
 1B0C08D700A15D24616A380A8005CBD17F9BC8B9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bd3fb4b8-61b2-4605-8b5a-17b6485f165b@kaod.org>
Date: Mon, 12 Jan 2026 19:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/arm/aspeed: Update buildroot images to
 2025.11
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260105160358.771511-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260105160358.771511-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: cd4f44bf-e0ad-47c8-984d-5a58ef13c53e
X-Ovh-Tracer-Id: 4743416308606864306
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTForqcdwhpvwSUSDUptpGIDrJAZP4pPNir77BtFP8H7vghogPffuIz89sJwx7mlXzAaqIFsKg+ZjxuPlHyd2+UTZSZO7nf/PDizuQD3ZzZxjMNvaXtFb0T+2KL7JJ1pEqebdrwFXqRfCmLK4tKetIdslIsHqbveLGn0LQfKznUBDXpYiPOyTNMwIE3UwHzG77zTNT+YGSdwkaJJN+0BDXGkPOAQs0786i45RKuok8jcQ+3ZXA85YmWbpDlnqdyqbmYkVhN33Uc1CnIwLJGFZCMaVKSbC446g1l4rY8y7mgFo7Fg+e6xyIpBgty05UUFOwMbWm0/3QwOdj0YrsVCiZBWA9fk3uXEiJMsML6myxkysGBHpYnKuj4DwJ9PlJf3KZBYgRlQjPkGCOHYUuAUMDlw1UZsMPUxrus8tjd+Yh/jfCMvQP2JBy1RKVDmGRosVwLGzseKe2Hm2YqWgdsDxptN8z1ivtmGSMsexIOcdBPO5K3NhkPnlEsa693GhcerpyEp5bVCuwyc8h9BCdyOTU1MkF8dVF1bBNWghZB6cJdOsSzFHxoUQKSS1sP7oSdbLWR7SbWcbtd6kHdqHqRwOt6oeIU6cLiEFQSDGc0GFCNRzW55NREY3LFSJEEuVHzI1GcRKMGSOQxDSTzDapQSjmGjh2GxAmHvp32NmX3gCzWjwA
DKIM-Signature: a=rsa-sha256; bh=iWSrlbkLYGQy++Yqk1jqqA8eu9xBGltZv2NsC2iAki8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768243670; v=1;
 b=ZM2pMKRgsXesiWg4b543nY/7ZLRFjx/zNQmPCnyXMkYIxB+jh3gJUBOE/gozPOHqqlds9CXJ
 XVSJLTarjjMIY2kEahHTdod8k8NuJdoRC6BUIJhblDChr3JrwCGshlqmpPHNCVuXrG7mXdxrxCG
 Vo/K9V3trMgx9wTqH96rGJJg28vxsZi4uqfoJVxgaacEvF1jCIUEVHxKxD5BzGu05cyANrMDY74
 c6pGlLvd4ExyP/GqoBTGZiynE1v+h4V6J6j+xMTlZbZDDfoKjoms4SnRzrK3Kp7FSEbto6/xhRG
 kjY9MCK3VFZ8EW7enbggaW3krqq3o7KaTXd1VF3Jsx1Pg==
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jamin, Kane,

On 1/5/26 17:03, Cédric Le Goater wrote:
> The main changes compared to upstream 2025.11 buildroot are
> 
>    - Linux v6.18
>    - latest OpenBMC U-Boot
>    - extra packages (ssh, etc.)
> 
> See
> 
>    https://github.com/legoater/buildroot/commits/aspeed-2025.11
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/test_aspeed_ast2500.py           | 8 ++++----
>   tests/functional/arm/test_aspeed_ast2600_buildroot.py | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)

Could you please send an Ack ?

Thanks,

C.


> diff --git a/tests/functional/arm/test_aspeed_ast2500.py b/tests/functional/arm/test_aspeed_ast2500.py
> index 5efd104c2b95..ac33c62a9f85 100755
> --- a/tests/functional/arm/test_aspeed_ast2500.py
> +++ b/tests/functional/arm/test_aspeed_ast2500.py
> @@ -10,15 +10,15 @@
>   
>   class AST2500Machine(AspeedTest):
>   
> -    ASSET_BR2_202411_AST2500_FLASH = Asset(
> +    ASSET_BR2_202511_AST2500_FLASH = Asset(
>           ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> -         'images/ast2500-evb/buildroot-2024.11/flash.img'),
> -        '641e6906c18c0f19a2aeb48099d66d4771929c361001d554d0d45c667413e13a')
> +         'images/ast2500-evb/buildroot-2025.11/flash.img'),
> +        '31e5a8e280b982fb0e7c07eb71c94851002f99ac604dfe620e71a5d47cc87e78')
>   
>       def test_arm_ast2500_evb_buildroot(self):
>           self.set_machine('ast2500-evb')
>   
> -        image_path = self.ASSET_BR2_202411_AST2500_FLASH.fetch()
> +        image_path = self.ASSET_BR2_202511_AST2500_FLASH.fetch()
>   
>           self.vm.add_args('-device',
>                            'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
> diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> index 575a5f64143f..3d130b9fd189 100755
> --- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> @@ -16,15 +16,15 @@
>   
>   class AST2600Machine(AspeedTest):
>   
> -    ASSET_BR2_202411_AST2600_FLASH = Asset(
> +    ASSET_BR2_202511_AST2600_FLASH = Asset(
>           ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
> -         'images/ast2600-evb/buildroot-2024.11/flash.img'),
> -        '4bb2f3dfdea31199b51d66b42f686dc5374c144a7346fdc650194a5578b73609')
> +         'images/ast2600-evb/buildroot-2025.11/flash.img'),
> +        'c64a0755501393d570ca318e326e1e9f8372edc5a6452cdccc3649bc9fd2c138')
>   
>       def test_arm_ast2600_evb_buildroot(self):
>           self.set_machine('ast2600-evb')
>   
> -        image_path = self.ASSET_BR2_202411_AST2600_FLASH.fetch()
> +        image_path = self.ASSET_BR2_202511_AST2600_FLASH.fetch()
>   
>           self.vm.add_args('-device',
>                            'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')


