Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78687E87824
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGMj-0007bt-E0; Tue, 03 Feb 2026 08:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGMi-0007aq-DQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:48 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGMg-0003Qr-E5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:48 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.222])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f540g3L0Lz5vxp;
 Tue,  3 Feb 2026 13:22:43 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 14:22:42 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006479616af-041b-42dc-8a63-443843a60ab9,
 43D9FD9E6FAA5025B81087D7BA78A3446A80EEF4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4a21eb77-afa2-4ce1-83e4-134d460b0436@kaod.org>
Date: Tue, 3 Feb 2026 14:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] tests/functional/aarch64/test_aspeed_ast2700:
 Enable PCIe2 DTS status for AST2700 tests
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <TYPPR06MB8206E427D92025CB3A2D47A2FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206E427D92025CB3A2D47A2FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: fc584a0d-d0cf-4e79-9683-3a00ff50240c
X-Ovh-Tracer-Id: 17772048557629148149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGe5KBRj3a536g5e6Vd5hd+i5APplG7GXC1AycTgdL8jLMEu4R/UOnC3WlwntOgeUGicJpBwYbKdEXBmkH1uywPpSRebgWKfp/NdFLxuCqZa+tLVnQJPBInm9+zB9Q1J4FZD1KA24TRRnXHyBjM26BxWF/mrpbH7PBOKwMqldOY3TfnRTZLmb8VzeT25pRnBrnoXPR0X4GtUAqXaiu/Q3LDy4sgljeVELz8EwQzPOvn+MQ74WJ3d9sPS5zUqWaJ+xxBBtmXm8oqZZxt1P2+qc/9XVzMAQssyqCGbxLwnpDihZaP1vtcUVm3T/x2dMDtXUPCKX4Zz1ISDwTY0OiZFmBLeEBPdx56lEITt4UbzXgS5Um5UcnsWKsD0C2IE2BBgGAYwwlL3RzALYkpxWxs2W9BJ0C3J1QPgigy6G9aPCCKqUrVcJ5M2RMfGVJaTVMYO8up9whi4Y+XjOWp3X4Z+I01kf2Hr4jbW/2b1DmR1EwGSqRWeror/4iBQj8XqFFsAlgRpV3WL2EtClVm0CGnfVZAyAtyhz7PYAUVQlivWIK9nH7Fo1i1q3YOJi+kmniyyarQbsyFUS09JenReLDK32Ynys/yhLEpYw3GphHLXVurx16pxk2/f4w2de8GnyPP3n0AIGQWnkmiJrPoNZCKT+dvlDXkv64OJUqLeVBkAjgQ/Q
DKIM-Signature: a=rsa-sha256; bh=WX2bOPBIe6MdjSsWdjCyQZ/O0ZqeJDxxHwy5r3JIdTY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770124963; v=1;
 b=Xm9qtQNv8jsrOY5wEGdawpC6YniMT/ScDf7rE0V8RuQ1IHJZ06dKLjdLyKuF1w5hecC1OGCc
 sGoHfMirdLdCF1kdY4LTi9WYrR2nrVy/DMROGrPIEUKFUkqYKO3ZOMsrEDSlsprEfaYaLOhdS+S
 wmxJR4kCGoQIAgvs6t+zPxat1k6QkmZH7zP5Qfu9ieVOBJGgpBB2tEWdea7V6XhGuXup3B5u28u
 vKO2+60NpMh8iXRuIdJqIzs/mIyt6VRxuy9knMQumDErb35y1QMKbZP1466nnQCYjaUkpq6mz6Z
 3t7D0pU/J074SPV+B1pEFoNDhh9BYr2AYnbXcNQA04FNg==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
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
> PCIe2 is disabled by default starting from SDK v10.00.
> 
> Add a helper function to stop U-Boot autoboot and update the device
> tree at runtime, setting the PCIe2 node status to "okay" before
> booting Linux. This allows the AST2700 functional test to verify
> the PCIe2 root complex behavior correctly.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../functional/aarch64/test_aspeed_ast2700.py  | 18 ++++++++++++++++--
>   .../aarch64/test_aspeed_ast2700fc.py           | 18 ++++++++++++++++--
>   2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index 0ced1a2502..1f1b5749f4 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -9,7 +9,7 @@
>   import os
>   
>   from qemu_test import QemuSystemTest, Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import wait_for_console_pattern, exec_command
>   from qemu_test import exec_command_and_wait_for_pattern
>   
>   
> @@ -37,9 +37,23 @@ def verify_vbootrom_firmware_flow(self):
>           wait_for_console_pattern(self, 'done')
>           wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
>   
> +    def enable_ast2700_pcie2(self):
> +        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
> +        exec_command_and_wait_for_pattern(self, '\012', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'cp 100420000 403000000 900000', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'bootm start 403000000', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
> +        exec_command(self, 'bootm go')
> +
>       def verify_openbmc_boot_start(self):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
> -        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
> +        self.enable_ast2700_pcie2()
>           wait_for_console_pattern(self, 'Linux version ')
>   
>       def verify_openbmc_boot_and_login(self, name):
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index 8dbc8f234f..a1d8046f58 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -9,7 +9,7 @@
>   import os
>   
>   from qemu_test import QemuSystemTest, Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import wait_for_console_pattern, exec_command
>   from qemu_test import exec_command_and_wait_for_pattern
>   
>   
> @@ -27,9 +27,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>   
>           self.vm.launch()
>   
> +    def enable_ast2700_pcie2(self):
> +        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
> +        exec_command_and_wait_for_pattern(self, '\012', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'cp 100420000 403000000 900000', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'bootm start 403000000', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
> +        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
> +        exec_command_and_wait_for_pattern(self,
> +            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
> +        exec_command(self, 'bootm go')
> +
>       def verify_openbmc_boot_and_login(self, name):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
> -        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
> +        self.enable_ast2700_pcie2()
>           wait_for_console_pattern(self, 'Starting kernel ...')
>   
>           wait_for_console_pattern(self, f'{name} login:')

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

