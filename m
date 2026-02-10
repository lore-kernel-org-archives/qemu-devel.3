Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A6EA8124
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpp5r-0004ev-8I; Tue, 10 Feb 2026 09:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpp5o-0004eP-Rw
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:51:57 -0500
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpp5l-00049J-T6
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:51:56 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.73])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f9PfF33xbz5w0M;
 Tue, 10 Feb 2026 14:51:49 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 10 Feb
 2026 15:51:48 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001c312675f-0281-4818-8223-04f89c42ffc9,
 013E132ABECAD38B5622F7607EFF7317793E1520) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <abcb0d99-2008-4144-9cfa-8716e3207a82@kaod.org>
Date: Tue, 10 Feb 2026 15:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>
References: <20260210104428.424420-1-kane_chen@aspeedtech.com>
 <20260210104428.424420-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260210104428.424420-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 8d26544b-807c-42b2-8179-1f981e5b8b35
X-Ovh-Tracer-Id: 5045438957882805237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTESbk6sVEKqkAXduErqpYtA53qMR6Vl8FCctrwJT9tEAcl+/LWTL/G79tLYzs6U1YEdoO0C71ew4bEFRpYhV+oEy1gNpBtVbfCwwH2K84mK2BlSKBwVGXcKW6z8VRuI71MDm9Jj6NbCk8Iu9QBbgJlgcuDofnt+4r5StQoodxl4W5/uHFqDMLufL8IwU7A0hvqW0SG+mAj29viGUpymuUaHJ/T8vPDILt4bbcG/O+eGu7keQ/iA7vH7gnOYAGNj6n8H2clASDy/soDfPZy13H9jAziknmS0JIPw5Ix25uI9TB0h/5G4zYkiVKVbvoF71F27LmSr8MLeIBm2QM6wN02RJQhj45kYu50i5YIVIvEGtQ7BlCiJOGlTq6dRcjCYN1zArUZ1Xr/SRYJAxLPCCyr65nF7YunfmD+2j5/vHOWzfaEY3LCnZqCs37WJ5e8zfsxom0w0hw3580SbV9U0Bt1lljQrel0II5Y6xmAls8MA1Vsq7oVEMa4u6auPMK9EHkrJvN9thG0mh9mhqlJK6pSfclytshbZ7mbxwi8CnuYqWDa2pDNvq8abpVMF1kmljWprQ2SyxFncA6UoP76wQhwurzljF4Nt3+yeZZHXiLUcAP/KIRXTrIPIwSLw0JRGsaLDsRt9f3leAjgoELyllwFyLMaOktFr89WksUDPPPxTAA
DKIM-Signature: a=rsa-sha256; bh=B7GOmHE29X8pgbardChCOYhkny4RgiOjgMocN4u0jFs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770735110; v=1;
 b=c2/7wZX/+NPGzLXiG9jPmysdO7J/dByBBcn8/EhVGYgqHhz8z5G9/CqLDz+U5WsflxWSP591
 5J1EdxJ66w6y1Lcr/ZFnQ7lwf6jnHSwz7imM14HW+8wcZ/2UMLr8ltI9Z2PfsNQplQRpnLa1GDD
 mmbQbXw4uao8u0zBZth5/Iromj2UfYbg9bRHVaDjMiuNvQ+51NNofZiKG4zeN3xX0Btgr6eqO8r
 m8RE4V2w89pSQ15UanZzTxiY6JOGqde42XQ1hJWmTgPhUdIBfjn6BMRa5uJQpPaCr8p4BiUgE6e
 1wrFFYzNoSiQSECSLMSU4sb2AhI39JXF/uh4ChTKP9ZMA==
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
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

On 2/10/26 11:44, Kane Chen wrote:
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
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 35 ++++++++++++++++---
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> index 4066532d5d..90f283ea09 100644
> --- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
> @@ -6,7 +6,8 @@
>   
>   from qemu_test import Asset
>   from aspeed import AspeedTest
> -

Can you keep the line above please ?

> +from qemu_test import wait_for_console_pattern, exec_command
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   class AST2600Machine(AspeedTest):
>   
> @@ -25,9 +26,35 @@ def test_arm_ast2600_otp_blockdev_device(self):
>               "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
>               "-global", "aspeed-otp.drive=otp",
>           )
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.scratch_file("ast2600-default", "image-bmc"))
> -        self.wait_for_console_pattern("ast2600-default login:")
> +        self.require_netdev('user')
> +        self.vm.add_args('-drive', 'file=' +
> +                self.scratch_file("ast2600-default", "image-bmc") +
> +                ',if=mtd,format=raw',
> +                '-net', 'nic', '-net', 'user', '-snapshot')

please add at the top of the function :

       self.require_netdev('user')


Thanks,

C.


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


