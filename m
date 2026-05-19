Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A8FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLyb-0005vg-L9; Tue, 19 May 2026 11:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPLyY-0005vA-Qc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:03:19 -0400
Received: from smtpout1.mo534.mail-out.ovh.net ([51.210.94.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPLyV-00036A-L1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:03:18 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gKdG658RZz6M0b;
 Tue, 19 May 2026 15:03:10 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 19 May 2026 15:03:10 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.1])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gKdG64SCJz1yFP;
 Tue, 19 May 2026 15:03:10 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3AEF8203B44; 
 Tue, 19 May 2026 15:03:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0034d50ad4d-8ed6-487d-aced-8c1b65432dea,
 A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8246d187-27d9-449f-817d-1365743925ce@kaod.org>
Date: Tue, 19 May 2026 17:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tests/functional/aspeed: introduce
 FacebookAspeedTest
To: William de Abreu Pinho <williamdapinho@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260519-add-anacapa-machine-v2-0-47027867d76a@gmail.com>
 <20260519-add-anacapa-machine-v2-1-47027867d76a@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260519-add-anacapa-machine-v2-1-47027867d76a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8912060714696158219
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGE7Dc/xxCeLRgHvjiHJ7Ul1qM+FnqkaYMyFUlRguCinYycKaMt8KzWO9bb/ubEWCjHgM+GLiKf40gNMX4Jnv0ru6298x8dxxrhDq7BBvaC8OHBSMb2wbFFnoDDTL2zKJBY9Twluo+cuyOxpZxo4iqZN2/wmxEKp0Ht71GckOkNhieAUNGUwvMNJWFL+3LSmuVQ+GlV4JV9AzjTgnoliIAxu79oREnWK6HXiwkfo0NetobZY3ZZcJTLlzULFe+xl9D2kasAQnPDoA0Pe7OnDHmWfwi0ZPr+QFEVIuuoW31k5kKJxk5hxzSO/on7zc0Z/X5X8DCsJVROq2tYAWLPiuP3nSfpgM5sTmUSAgU7C18nW7Q9UbcDvzI+vYnXtyMTvoYGi94gbkprSvUFWPUVlNYbshqJloujKZVPXjB2LIJDYjEQAY8tGfCk4JbxeU6EbvSM5idrJEjeVxHy4kq6tDdHMrvnNPd0+Yvr6ubuJrm9l/A8FSDuU7ce4aBIqJBvlMyB+BdIR0lZgPHJvF8G1tea7Xp2sQngUJ7MEVmoIhTK+JCyRNSbMHA1LhDLsmm5ai7qxHcPoQ1Om2Rvq0SLSR9/nElHsBX22ybhdn0gyoIfU3HjdIi+f4aZ9lHJklKKULWfNiq7EgmogO3EEfHsZUlgMtMvvtSQlLChbKv5ANUQiQ
DKIM-Signature: a=rsa-sha256; bh=DVYu9wco5DHDwj6oo2inPT50IFL3QghavNJauFEANvs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779202991; v=1;
 b=SaGIPCKNz66TSLRHkNyfjhBDf4wimVBqz02OXCH2K+cuuW4ImeZpuzpwKBX35TAGVshSOZM4
 GcUfW5LP2L3dWpdjGa7M517dzv4r30uFMTjptBI8p6ZFAAYwZsM9cIezoEhpEPrfBib7YXzUFL1
 eh3Aenjgdu2ZY5CNN2iAj7x6fP+kD+iuuBPcj3UDDVjIveGvJAJrjqcMyCHUzlylgZ7EtBktrd3
 BHodCkZ2rRszU3iDvYUOYOyohrWFrHwbeaw1bY10P+vUHuaKiGNVNzO1eHn/St0MvmAUIH0MwvL
 HejX68YjzfOtYCIAob5MSHvScEGvpA6x+KE5eU11+J8nA==
Received-SPF: pass client-ip=51.210.94.140; envelope-from=clg@kaod.org;
 helo=smtpout1.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/19/26 12:36, William de Abreu Pinho wrote:
> Facebook OpenBMC Images include an early script [1] that lowers the
> console log level to warning.  This suppresses the "Hostname set to"
> message from the serial console.  Introduce FacebookAspeedTest (a
> subclass of AspeedTest), that waits for login prompt instead.  Update
> bletchley-bmc and catalina-bmc to use the new class.
> 
> This is also used by the anacapa-bmc machine introduced in the following
> patch.
> 
> [1]: https://github.com/openbmc/openbmc/blob/6a56a45931fb7015a3fc18553415909105b484d6/meta-facebook/recipes-phosphor/initrdscripts/phosphor-static-norootfs-init/999-reduce-printk
> 
> Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
> ---
>   tests/functional/arm/test_aspeed_bletchley.py | 6 +++---
>   tests/functional/arm/test_aspeed_catalina.py  | 6 +++---
>   tests/functional/aspeed.py                    | 8 ++++++++
>   3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
> index 5a60b24b3d..3000d0c302 100755
> --- a/tests/functional/arm/test_aspeed_bletchley.py
> +++ b/tests/functional/arm/test_aspeed_bletchley.py
> @@ -5,10 +5,10 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   from qemu_test import Asset
> -from aspeed import AspeedTest
> +from aspeed import FacebookAspeedTest
>   
>   
> -class BletchleyMachine(AspeedTest):
> +class BletchleyMachine(FacebookAspeedTest):
>   
>       ASSET_BLETCHLEY_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
> @@ -22,4 +22,4 @@ def test_arm_ast2600_bletchley_openbmc(self):
>                                           soc='AST2600 rev A3')
>   
>   if __name__ == '__main__':
> -    AspeedTest.main()
> +    FacebookAspeedTest.main()
> diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
> index dc2f24e7b4..2694e4b005 100755
> --- a/tests/functional/arm/test_aspeed_catalina.py
> +++ b/tests/functional/arm/test_aspeed_catalina.py
> @@ -5,10 +5,10 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   from qemu_test import Asset
> -from aspeed import AspeedTest
> +from aspeed import FacebookAspeedTest
>   
>   
> -class CatalinaMachine(AspeedTest):
> +class CatalinaMachine(FacebookAspeedTest):
>   
>       ASSET_CATALINA_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
> @@ -22,4 +22,4 @@ def test_arm_ast2600_catalina_openbmc(self):
>                                           soc='AST2600 rev A3')
>   
>   if __name__ == '__main__':
> -    AspeedTest.main()
> +    FacebookAspeedTest.main()
> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> index 47e84e035b..88b6590934 100644
> --- a/tests/functional/aspeed.py
> +++ b/tests/functional/aspeed.py
> @@ -28,6 +28,9 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>           self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
>           self.wait_for_console_pattern(f'ASPEED {soc}')
>           self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_boot_complete(hostname)
> +
> +    def wait_for_boot_complete(self, hostname):
>           self.wait_for_console_pattern(f'systemd[1]: Hostname set to <{hostname}>.')


This will slow down a bit the tests. Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>       def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
> @@ -69,3 +72,8 @@ def generate_otpmem_image(self):
>               f.write(pattern)
>           return path
>   
> +
> +class FacebookAspeedTest(AspeedTest):
> +
> +    def wait_for_boot_complete(self, hostname):
> +        self.wait_for_console_pattern(f'{hostname} login:')
> 


