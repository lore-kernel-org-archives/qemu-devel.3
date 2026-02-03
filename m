Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A4E8782B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGMq-0007dT-27; Tue, 03 Feb 2026 08:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGMo-0007d5-8f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:54 -0500
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnGMm-0003S9-94
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:53 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.193])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f540p1qWTz5w1h;
 Tue,  3 Feb 2026 13:22:50 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 14:22:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0026f7c59c4-be6b-4671-b53b-8580052682ca,
 43D9FD9E6FAA5025B81087D7BA78A3446A80EEF4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <552d8254-9a01-4547-8c58-6b55a17b5f7f@kaod.org>
Date: Tue, 3 Feb 2026 14:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] tests/functional/aarch64/test_aspeed_ast2700:
 Update test ASPEED SDK v11.00 for A1
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <TYPPR06MB82062FF44138D2F1EA26F4A8FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB82062FF44138D2F1EA26F4A8FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: d6fa10a7-9960-4ebf-90e0-b0d53a43990d
X-Ovh-Tracer-Id: 17774018879772527605
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEOlf6sXOhr32sTGWOTnTYTRpTXgLjUXWJdPF8X8vlE1Q8DlwlMoN6KrvfGSQAbvt0ksE0RzRf1QleYtxNsnbaI7jbaT0PSg8WK/ZjgFVqzEkH26w5l8AlCm67sAp9iJqMx6l+2qHm7EomWOV+erRm0MkLOfD+jYH04IGb1BhJ42XWvoHbNhz6+6mPmOXULKgwDPGyDvqSRabOfyLPPY487XVEs/TFARfBy/RGzGzzIJ0INI2CZziolFyC7RZ78yOhhNvLXdk3ltQaoPP/QmDNlHG5fjWo30t0HlaGZyYPM+9j+QSo9lK+h6QcxI1UDMsX1pIsH36XLbihC64lMVMvzSSTTnJcQXR4cCzpeE1bWPx/gz31cfzUhBP/dR+1FOpeR0QuPfJsay+88qMn56GV9Rw5P8lsWvql17BAYZJNOXa24uAmXrsQHmBaW3GV6yuqKdqifGSk2LukP0s0efzPUbr0qyTaPoBl6WrVStX5P+x8cjMZrD3TgUlhJP8YxeH0OO+4b5JN+2Wmu2Cdi8OwV45sS3D3O4HSi/K+bwoct5w+ctFlDhYwHb673hqCBvK45vyWncpNMDOTKvKmM1vYx1ZafwRVAhHPam/uNKp+bKO5q5iTux9EREUYbjJVQjkQyPwvSimFvZF8oZk1MCWMGRG0oGIO7H9IdHnHbFJPkIQ
DKIM-Signature: a=rsa-sha256; bh=B8QLOEl2PmefLnxXT6JybdkpTna9al9gHqSmQQLQZhE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770124970; v=1;
 b=Y+g3x5fC74GwIE3AytpmXBmnoG7xcsmoOlVS/dSIG1valvop1c17X3wQ064ayIRl0bx18XWz
 L7xVM78daMUwJzfgtE78RtvzULo01Iu7DuApoZaCXaZu2I5ZryKugeupeMv0TsOi5HLyVWqgMMK
 3ck+nV3oqP97CmlBrQHVAjOV2ntctoEAbYpPRV/n5A+6QiQXuN1PGU7piknF28VZvM7HmF+hkTE
 ex/+qgMeImjYcRlTCv2bD6PVOZbQmXof2tj3QUyTeVAINr2qx/f86m0NIfcESjEjYPU5CRocmPl
 lSeBBPjpnpTP9v7TMbzJknd2F30bEIGGwMUy9hmV2/gqQ==
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
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
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../functional/aarch64/test_aspeed_ast2700.py | 60 +++++++++----------
>   1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index 1f1b5749f4..828ea1ca53 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -26,15 +26,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>           self.vm.launch()
>   
>       def verify_vbootrom_firmware_flow(self):
> -        wait_for_console_pattern(self, 'Found valid FIT image')
> -        wait_for_console_pattern(self, '[uboot] loading')
> -        wait_for_console_pattern(self, 'done')
> -        wait_for_console_pattern(self, '[fdt] loading')
> -        wait_for_console_pattern(self, 'done')
> -        wait_for_console_pattern(self, '[tee] loading')
> -        wait_for_console_pattern(self, 'done')
> -        wait_for_console_pattern(self, '[atf] loading')
> -        wait_for_console_pattern(self, 'done')
> +        wait_for_console_pattern(self, 'Found valid caliptra flash image')
> +        wait_for_console_pattern(self, 'Check flash image checksum')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Read abb header')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Read soc manifest')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Load atf image')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Load optee image')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Load uboot image')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Load ssp image')
> +        wait_for_console_pattern(self, 'pass')
> +        wait_for_console_pattern(self, 'Load tsp image')
> +        wait_for_console_pattern(self, 'pass')
>           wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
>   
>       def enable_ast2700_pcie2(self):
> @@ -63,9 +71,9 @@ def verify_openbmc_boot_and_login(self, name):
>           exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>           exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
>   
> -    ASSET_SDK_V908_AST2700A1 = Asset(
> -            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz',
> -            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e2cd')
> +    ASSET_SDK_V1100_AST2700A1 = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
> +            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
>   
>       def do_ast2700_i2c_test(self):
>           exec_command_and_wait_for_pattern(self,
> @@ -93,19 +101,10 @@ def do_ast2700_pcie_test(self):
>   
>       def start_ast2700_test(self, name):
>           num_cpu = 4
> -        uboot_size = os.path.getsize(self.scratch_file(name,
> -                                                       'u-boot-nodtb.bin'))
> -        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
> -
>           load_images_list = [
>               {
>                   'addr': '0x400000000',
> -                'file': self.scratch_file(name,
> -                                          'u-boot-nodtb.bin')
> -            },
> -            {
> -                'addr': str(uboot_dtb_load_addr),
> -                'file': self.scratch_file(name, 'u-boot.dtb')
> +                'file': self.scratch_file(name, 'u-boot.bin')
>               },
>               {
>                   'addr': '0x430000000',
> @@ -113,8 +112,7 @@ def start_ast2700_test(self, name):
>               },
>               {
>                   'addr': '0x430080000',
> -                'file': self.scratch_file(name, 'optee',
> -                                          'tee-raw.bin')
> +                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')
>               }
>           ]
>   
> @@ -137,26 +135,26 @@ def start_ast2700_test_vbootrom(self, name):
>           self.do_test_aarch64_aspeed_sdk_start(
>                   self.scratch_file(name, 'image-bmc'))
>   
> -    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):
> +    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
>           self.set_machine('ast2700a1-evb')
>           self.require_netdev('user')
>   
> -        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
> +        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> -        self.start_ast2700_test('ast2700-default')
> -        self.verify_openbmc_boot_and_login('ast2700-default')
> +        self.start_ast2700_test('ast2700-a1')
> +        self.verify_openbmc_boot_and_login('ast2700-a1')
>           self.do_ast2700_i2c_test()
>           self.do_ast2700_pcie_test()
>   
> -    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
> +    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
>           self.set_machine('ast2700a1-evb')
>           self.require_netdev('user')
>   
> -        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)
> +        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> -        self.start_ast2700_test_vbootrom('ast2700-default')
> +        self.start_ast2700_test_vbootrom('ast2700-a1')
>           self.verify_vbootrom_firmware_flow()
>           self.verify_openbmc_boot_start()
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

