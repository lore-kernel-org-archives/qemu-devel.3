Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5923EB596D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4Fz-0003N8-Jk; Wed, 11 Feb 2026 02:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq4Fx-0003M7-6j
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:03:25 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq4Fu-0000wj-2I
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:03:24 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.79])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f9qC94djzz5w21;
 Wed, 11 Feb 2026 07:03:17 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 08:03:16 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S00786a7a9bc-0e18-49ba-bd0c-0cad4d53d659,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f2f2bf4a-a188-4a9c-8cce-5f339732e506@kaod.org>
Date: Wed, 11 Feb 2026 08:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>
References: <20260211052326.430475-1-kane_chen@aspeedtech.com>
 <20260211052326.430475-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260211052326.430475-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG11EX1.mxp5.local (172.16.2.111) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: e88839ee-f7f2-4738-af1c-2d5d4a1a03fa
X-Ovh-Tracer-Id: 3005308329524825077
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFlizL17AJ1rUSUFSOAu1zc5Wvqo1Xc9nwDZaGtLmMDFQKdl1p2v49dtZsrDCqcXTYEnqqSmJ97FaSBa6hNtfMKCLL70Pzac9eynx2+xykuU91Xgm+9ymuEQ+D7HMz7njTv9Ajhs/7jM3anHlFbylKFURoaaDhJn8bZqI1u7ZUhs/VZBYYHKjXhCezGUEFDlOiyEkDn4mDFwNPh2+eJ7ytfnM56lSQNqZPJpIOBxJq8Yv/dPVz0zKqEGbZXfYGmcVHjmYadWZ6Afr5RPtac9uNF0UD0qHrdKOp27wKxVAdb4KGbFusY4stFLmZchdG0vFmMYgReV7ZQEthuoYy4duSlNqns+rXpkdEoi0Y24fG3BBbFWSqzcTiw98uIKinPogXIVixQludzNwZcZd4gsAqzYhvtZ/EAXVT7xoEYP4jnn3/Exx/o0EcpNeI13fvaShIeQGQwih6MZ9hYJbA9rqFq0rHCIRTM8U9Yvg6HJtkNyh32oVoaiiEPh4vlMQlHYJf5OHZ47AIyZw7RU7OcUBxKuZhUzDHqFH6cPdCcRfrbT5um9bDUzOlOyXoseo9AJrB5+0SCmpgjh5j44NdDbeBbimc7E7Pvg6bnnuOoL6xjgiYaUeD/QLyWja5uDKELN2ppg+Srz/uJYDq/5pMBkaVamjEcePdh5eyT+lzH4QlzPA
DKIM-Signature: a=rsa-sha256; bh=8pz5vB9HpHy/2ZoJ591xkoKhhbxixKiLY6KqRjHh7FA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770793399; v=1;
 b=uAjY8S6y0HknosDwv9Md+FjwCcn+v5Khdm9ZR6wBxxFeobnKnNpnx4SKHDPwJxKnux+udwec
 SeLeJqsk38D58yOA+uFD7VrG6FDV/AL8QVTAYRVhUl3tAy1YuY2AJBEbPdvjcm01YZJVTRZ5SvG
 rBph2amMoWTVIuoA9Rxzb3A7NgkKdEZCHaXlMitESgEwaNpPU6waBOGvXwwqXKFPN5TcP92pL09
 5AtBPM9M8tkJLm3apeGqTRhbLeI66GPmQWTsBKxsYt0L4ASlbXJIy/1A4r9ONiC5WVwxNooXw3R
 OVZRl6RaqFAbB9Rw1jI4rVbs7evfSrrt5fufW7Y2YVOiA==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
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

On 2/11/26 06:23, Kane Chen wrote:
> Improve the OTP test script by adding functional verification of OTP
> strap registers. The test now validates that OTP modifications made
> in U-Boot persist through the Linux boot process and survive a
> subsequent reboot.
> 
> Key changes:
> - Added interactive console commands for U-Boot and Linux.
> - Implemented verification for OTP register 0x30 across reboots.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> index 4066532d5d..31a1c3bed6 100644
> --- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> @@ -7,6 +7,8 @@
>   from qemu_test import Asset
>   from aspeed import AspeedTest
>   
> +from qemu_test import wait_for_console_pattern, exec_command
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   class AST2600Machine(AspeedTest):
>   
> @@ -16,6 +18,7 @@ class AST2600Machine(AspeedTest):
>   
>       def test_arm_ast2600_otp_blockdev_device(self):
>           self.vm.set_machine("ast2600-evb")
> +        self.require_netdev('user')
>   
>           image_path = self.archive_extract(self.ASSET_SDK_V1100_AST2600)
>           otp_img = self.generate_otpmem_image()
> @@ -25,9 +28,34 @@ def test_arm_ast2600_otp_blockdev_device(self):
>               "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
>               "-global", "aspeed-otp.drive=otp",
>           )
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.scratch_file("ast2600-default", "image-bmc"))
> -        self.wait_for_console_pattern("ast2600-default login:")
> +        self.vm.add_args('-drive', 'file=' +
> +                self.scratch_file("ast2600-default", "image-bmc") +
> +                ',if=mtd,format=raw',
> +                '-net', 'nic', '-net', 'user', '-snapshot')
> +        self.vm.launch()
> +
> +        # Set OTP value via uboot command
> +        wait_for_console_pattern(self, 'Hit any key to stop autoboot:')
> +        exec_command_and_wait_for_pattern(self, '\012', 'ast#')
> +        exec_command_and_wait_for_pattern(self,
> +            'otp pb strap  o 0x30 1', 'ast#')
> +        # Validate OTP value in uboot stage
> +        exec_command_and_wait_for_pattern(self,
> +            'otp read strap 0x30', '0x30      1')
> +        exec_command_and_wait_for_pattern(self, 'boot',
> +            "ast2600-default login:")
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, '0penBmc',
> +            'root@ast2600-default:~#')
> +        # Validate OTP value in BMC stage
> +        exec_command_and_wait_for_pattern(self,
> +            'otp read strap 0x30', '0x30      1')
> +        exec_command_and_wait_for_pattern(self,
> +            'reboot', 'Hit any key to stop autoboot')
> +        exec_command_and_wait_for_pattern(self, '\012', 'ast#')
> +        # Validate OTP value in uboot stage
> +        exec_command_and_wait_for_pattern(self,
> +            'otp read strap 0x30', '0x30      1')
>   
>   
>   if __name__ == '__main__':

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



