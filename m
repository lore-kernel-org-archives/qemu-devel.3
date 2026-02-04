Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BACE83EF9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYig-0003YF-BN; Wed, 04 Feb 2026 03:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYif-0003Xd-8w
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:58:41 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnYic-0005t7-P1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:58:41 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.72])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f5Z5R3sv5z5vS5;
 Wed,  4 Feb 2026 08:58:35 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 4 Feb
 2026 09:58:34 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0050b4dcc8d-a1d3-4526-854a-6f7f765e852c,
 E481ED796CD1A7AD002472F698DA8951F44CEEA4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <76c6098c-a924-4c19-848e-3910fe65e7a4@kaod.org>
Date: Wed, 4 Feb 2026 09:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/22] tests/functional/aarch64: Parameterize I2C bus
 ID in AST2700 test
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
 <20260204082113.3955407-21-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260204082113.3955407-21-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 94c7712e-291a-42cf-86cb-158cf1dcf0f3
X-Ovh-Tracer-Id: 737182967922396149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFwE5jkYFznWbfEnUZg34IsSxerq7GWH35BoKpbwEvK8jxnFr0v6jm2dKrwXAzWfLpW4F92owa0Yhq0VuoXvZs99OJ07lUczs3ezJQHTiPjhAQMpqlH76FhqrYn89eQL6byLzDvdaV4RbZXfCtSOr9j10eu2BF+7kTK+y1t3FFdsz7Tc5tqU0CEZgcci809HL0I5knvURocXdhM97UMfWae74lVrXzN7v+26JHXKEcCq2hwdxHQLGI75Stc+hkA/emYBc6OBLsAg49seodzjdc5zM38cjVl3+CtLAM0X6nU9e9J+lnzy5aug7h45GXLr8sPtre30+x6y90lqyz5nQvsM/PQYxRKAdrnYPf436ESInN80QWrVw3EGiP4NlVsJFFLSFBiXbr4yeTh4xYqu+qAauOP6GU09ETJVn68pbBR1nREn/9DW8/kvYDWnMcUzI+zLYVwA81Dse3iWEwlBiEJI5s5CxUVlPCDu0K6uVtQztx+2CxOKQb58+JKIrsZ1rNAIXp57ZFeB75nHG+NULwTHKBim2f0ntZ6w7hmnm5gsJOKVd4LlLLhnTISFuJJQrN8/pCxN0ExoOTbIB3pV7cnxhCPr/cKgo9gmGp29+mu4jWPeejSZW8AQEq/yf0JL90rvWgeYr5N1ac1R5R4oXA2AtDJsXeJKTCnoF9cTAtpZw
DKIM-Signature: a=rsa-sha256; bh=mxXacsUwv/dAoellGLT35D3wtWIQuzYHO0KcQFy2/cY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770195515; v=1;
 b=K1qlNjdxXrG3SusuHMnOsO2slOd222EjfE+U7ve9UOARQzZSWLHDviO/IRA1luit+r0f9ZMm
 Fs19pyXSxeL/Zt7Tx838GGihLEBr8+UyBLJmNr9NnblTKJEZuGmBCXU+kKno9GqXAIRv7WmtSW2
 Dj38BhkHmkn4iPcFn0voOyt8AH+DXGYRK4HgdUkAgCwkaPbay/p25xasm9me8cXKZbHN/JVDzUw
 ijDB92CEXk6iwpyW1UtAyfFIohAMSTaqkDBlxr9cm9025jbrOrC5BnfkcO8UUwTnkHmjkgDK3YL
 ns5T0eNOkdwkjFHwmEvo/kqv6bOOg5Wkd5WfM/0i72uHg==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
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

On 2/4/26 09:21, Kane Chen wrote:
> The current Aspeed AST2700 functional test case strictly uses I2C bus
> 1 for its sensor tests. This hard-coded approach prevents the test
> logic from being reused for other machine types or configurations
> where I2C bus 1 might be disabled or where a different bus needs to
> be verified (e.g., I2C expanders).
> 
> This refactoring allows the same I2C verification logic to be shared
> across different test scenarios by simply passing the target bus
> number.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   .../functional/aarch64/test_aspeed_ast2700.py | 39 +++++++++++--------
>   1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index 828ea1ca53..d7eeab9c23 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -15,11 +15,17 @@
>   
>   class AST2x00MachineSDK(QemuSystemTest):
>   
> -    def do_test_aarch64_aspeed_sdk_start(self, image):
> +    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):
> +        bus_str = str(bus_id)
>           self.require_netdev('user')
>           self.vm.set_console()
> -        self.vm.add_args('-device',
> -                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
> +        self.vm.add_args(
> +            '-device',
> +            f'tmp105,'
> +            f'bus=aspeed.i2c.bus.{bus_str},'
> +            f'address=0x4d,'
> +            f'id=tmp-test-{bus_str}'
> +        )
>           self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>                            '-net', 'nic', '-net', 'user', '-snapshot')
>   
> @@ -75,16 +81,17 @@ def verify_openbmc_boot_and_login(self, name):
>               'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-obmc.tar.gz',
>               'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525')
>   
> -    def do_ast2700_i2c_test(self):
> +    def do_ast2700_i2c_test(self, bus_id):
> +        bus_str = str(bus_id)
>           exec_command_and_wait_for_pattern(self,
> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
> -            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
> +            f'echo lm75 0x4d > /sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',
> +            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0x4d')
>           exec_command_and_wait_for_pattern(self,
> -            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> +            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '0')
> +        self.vm.cmd('qom-set', path=f'/machine/peripheral/tmp-test-{bus_str}',
>                       property='temperature', value=18000)
>           exec_command_and_wait_for_pattern(self,
> -            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
> +            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input', '18000')
>   
>       def do_ast2700_pcie_test(self):
>           exec_command_and_wait_for_pattern(self,
> @@ -99,7 +106,7 @@ def do_ast2700_pcie_test(self):
>               'ip addr show dev eth2',
>               'inet 10.0.2.15/24')
>   
> -    def start_ast2700_test(self, name):
> +    def start_ast2700_test(self, name, bus_id):
>           num_cpu = 4
>           load_images_list = [
>               {
> @@ -128,12 +135,12 @@ def start_ast2700_test(self, name):
>   
>           self.vm.add_args('-smp', str(num_cpu))
>           self.do_test_aarch64_aspeed_sdk_start(
> -            self.scratch_file(name, 'image-bmc'))
> +            self.scratch_file(name, 'image-bmc'), bus_id)
>   
> -    def start_ast2700_test_vbootrom(self, name):
> +    def start_ast2700_test_vbootrom(self, name, bus_id):
>           self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
>           self.do_test_aarch64_aspeed_sdk_start(
> -                self.scratch_file(name, 'image-bmc'))
> +                self.scratch_file(name, 'image-bmc'), bus_id)
>   
>       def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
>           self.set_machine('ast2700a1-evb')
> @@ -142,9 +149,9 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
>           self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> -        self.start_ast2700_test('ast2700-a1')
> +        self.start_ast2700_test('ast2700-a1', 1)
>           self.verify_openbmc_boot_and_login('ast2700-a1')
> -        self.do_ast2700_i2c_test()
> +        self.do_ast2700_i2c_test(1)
>           self.do_ast2700_pcie_test()
>   
>       def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
> @@ -154,7 +161,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
>           self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
>           self.vm.add_args('-netdev', 'user,id=net1')
> -        self.start_ast2700_test_vbootrom('ast2700-a1')
> +        self.start_ast2700_test_vbootrom('ast2700-a1', 1)
>           self.verify_vbootrom_firmware_flow()
>           self.verify_openbmc_boot_start()
>   


