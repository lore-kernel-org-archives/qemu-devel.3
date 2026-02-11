Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF45EB596D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4GE-0003jR-0x; Wed, 11 Feb 2026 02:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq4GC-0003iR-Ls
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:03:40 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq4GA-00013X-5B
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:03:40 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.73])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f9qCV37vnz5yp5;
 Wed, 11 Feb 2026 07:03:34 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 08:03:33 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005e419e175-c6b6-4d53-a698-ca5676fa7d0b,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8bfb18b5-9ca1-4fd4-8423-b92c9ae7d85e@kaod.org>
Date: Wed, 11 Feb 2026 08:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] tests/functional/aarch64/test_aspeed_ast2700a2:
 Add AST2700 A2 EVB functional tests
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
 <20260211021527.119674-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260211021527.119674-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG15EX1.mxp5.local (172.16.2.151) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 18c5296e-63bc-4eb0-9599-93eba0b31612
X-Ovh-Tracer-Id: 3010093401688345406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGRA0VSH0AofLFA1IjDcQlPsIgjE9u0c0pUCS25RwdiIQu3waZHq8qPCRsLK1henungM5Aahz6Gv9OE/KyqKNNQMzD1soFxkQWLsbG2nOAjosLq0Jo9jtzfPFGlaKVCtH6kY4InMVGxJ1oaNcflx8m/XK3xboENy8l7LUHuggINVB2TKc8yTKYM0GcOcVntN9S0UuoJwBRG85GFkZ/WjG5piQhjqvRqL6NRIu9epOeTUOr08ON7XJRwxBsgkUuj6nNTf7DqvAIrTOabwDnxCMfCcLiq1+Gcg0wQ2hAcEOx86msR6gT9/hPNbv95GaqJByOXSYQsJJir/2v7gwBLITPtWxCYs37v7QMDZytxr6VWXoSBk+7sbj3nym5sB5ps6gh/EPqE8zdSP0sbR4lMf7rkvm6ZKL2veCG6oissv1UbpPVx4qBElUb9ckZX07g90/R30UxVzObzS8LvLWZFPVGOp0cXqc5SfF4UOMcLbIyfD141MtYsbZjBjgzToeLQE8oBRNP0qEBsvuVT00xeVPOS+W+JSI71JxP3Mg+HUzF5kFPDdCT2gl9NKkiPndiP55MK/6wITe0ZdU6qtJTo02B+G+szyTvEztY3xX0wx56XIQ+CPSWQmpg8sKTWHzpLLUKOtElf7STNx0yiqTRVbO7xcobgaanu5NXt3A2oe6uE7A
DKIM-Signature: a=rsa-sha256; bh=5UABuZ9EdcRnHpXG12u+5C/zMns/LdZVaN+7E09xS5Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770793415; v=1;
 b=XcnUqPpMvp8QfOduWIHb2BQzl6TkA9YlPwghVXzOL4q1BSQfLpckgKFkGKniW6wO4WzReQuf
 Ny9lkQ5DDPXjdsrIhCiDHA/OOwgEJrWej69ameAVnYPR74W4Q6AWVUA/dXsObkpxHWOMRpZ6wPf
 0JByrDj+aWU3Qwkq588woRTdwlB7j6XS5Yh01L9iiUdP8DdhuCzNDZpJ44xm/sqB+434K7PJiI/
 MBY4JjvlimSDJ6MlOuKNmp1lodpLmellNAOOxJJFT1CHGiCyU6DUzVKQUjVa2P42zBCha5El4QL
 KDiIp/CXqTmlJlu/KIQFhmOvxYNBf5qF2pF9Qh2hcXC6w==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
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
> Add functional coverage for the AST2700 A2 EVB machine by introducing
> test cases that boot and validate an OpenBMC SDK v11.00 image on
> "ast2700a2-evb".
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/meson.build          |   2 +
>   .../aarch64/test_aspeed_ast2700a2.py          | 190 ++++++++++++++++++
>   2 files changed, 192 insertions(+)
>   create mode 100644 tests/functional/aarch64/test_aspeed_ast2700a2.py
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index b5dd674bac..49eca12058 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -2,6 +2,7 @@
>   
>   test_aarch64_timeouts = {
>     'aspeed_ast2700a1' : 600,
> +  'aspeed_ast2700a2' : 600,
>     'aspeed_ast2700fc' : 600,
>     'device_passthrough' : 720,
>     'imx8mp_evk' : 240,
> @@ -24,6 +25,7 @@ tests_aarch64_system_quick = [
>   
>   tests_aarch64_system_thorough = [
>     'aspeed_ast2700a1',
> +  'aspeed_ast2700a2',
>     'aspeed_ast2700fc',
>     'device_passthrough',
>     'hotplug_pci',
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> new file mode 100644
> index 0000000000..e527518a55
> --- /dev/null
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> @@ -0,0 +1,190 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2022 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern, exec_command
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +
> +class AST2x00MachineSDK(QemuSystemTest):
> +
> +    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):
> +        bus_str = str(bus_id)
> +        self.require_netdev('user')
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            '-device',
> +            f'tmp105,'
> +            f'bus=aspeed.i2c.bus.{bus_str},'
> +            f'address=0x4d,'
> +            f'id=tmp-test-{bus_str}'
> +        )
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-net', 'user', '-snapshot')
> +
> +        self.vm.launch()
> +
> +    def verify_vbootrom_firmware_flow(self):
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
> +        wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
> +
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
> +    def verify_openbmc_boot_start(self, enable_pcie=True):
> +        wait_for_console_pattern(self, 'U-Boot 2023.10')
> +        if enable_pcie:
> +            self.enable_ast2700_pcie2()
> +        wait_for_console_pattern(self, 'Linux version ')
> +
> +    def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
> +        self.verify_openbmc_boot_start(enable_pcie)
> +
> +        wait_for_console_pattern(self, f'{name} login:')
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
> +
> +    ASSET_SDK_V1100_AST2700A2 = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
> +            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
> +
> +    ASSET_SDK_V1100_AST2700A2_DCSCM = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-dcscm-obmc.tar.gz',
> +            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0')
> +
> +    def do_ast2700_i2c_test(self, bus_id):
> +        bus_str = str(bus_id)
> +        exec_command_and_wait_for_pattern(self,
> +            'echo lm75 0x4d > '
> +            f'/sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',
> +            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0x4d')
> +        exec_command_and_wait_for_pattern(self,
> +            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input',
> +            '0')
> +        self.vm.cmd('qom-set', path=f'/machine/peripheral/tmp-test-{bus_str}',
> +                    property='temperature', value=18000)
> +        exec_command_and_wait_for_pattern(self,
> +            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input',
> +            '18000')
> +
> +    def do_ast2700_pcie_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:00:00.0',
> +            '0002:00:00.0 PCI bridge: '
> +            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
> +        exec_command_and_wait_for_pattern(self,
> +            'lspci -s 0002:01:00.0',
> +            '0002:01:00.0 Ethernet controller: '
> +            'Intel Corporation 82574L Gigabit Network Connection')
> +        exec_command_and_wait_for_pattern(self,
> +            'ip addr show dev eth2',
> +            'inet 10.0.2.15/24')
> +
> +    def start_ast2700_test(self, name, bus_id):
> +        num_cpu = 4
> +        load_images_list = [
> +            {
> +                'addr': '0x400000000',
> +                'file': self.scratch_file(name, 'u-boot.bin')
> +            },
> +            {
> +                'addr': '0x430000000',
> +                'file': self.scratch_file(name, 'bl31.bin')
> +            },
> +            {
> +                'addr': '0x430080000',
> +                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')
> +            }
> +        ]
> +
> +        for load_image in load_images_list:
> +            addr = load_image['addr']
> +            file = load_image['file']
> +            self.vm.add_args('-device',
> +                             f'loader,force-raw=on,addr={addr},file={file}')
> +
> +        for i in range(num_cpu):
> +            self.vm.add_args('-device',
> +                             f'loader,addr=0x430000000,cpu-num={i}')
> +
> +        self.vm.add_args('-smp', str(num_cpu))
> +        self.do_test_aarch64_aspeed_sdk_start(
> +            self.scratch_file(name, 'image-bmc'), bus_id)
> +
> +    def start_ast2700_test_vbootrom(self, name, bus_id):
> +        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
> +        self.do_test_aarch64_aspeed_sdk_start(
> +                self.scratch_file(name, 'image-bmc'), bus_id)
> +
> +    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):
> +        self.set_machine('ast2700a2-evb')
> +        self.require_netdev('user')
> +
> +        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
> +        self.vm.add_args('-netdev', 'user,id=net1')
> +        self.start_ast2700_test('ast2700-default', 1)
> +        self.verify_openbmc_boot_and_login('ast2700-default')
> +        self.do_ast2700_i2c_test(1)
> +        self.do_ast2700_pcie_test()
> +
> +    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):
> +        self.set_machine('ast2700a2-evb')
> +        self.require_netdev('user')
> +
> +        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)
> +        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
> +        self.vm.add_args('-netdev', 'user,id=net1')
> +        self.start_ast2700_test_vbootrom('ast2700-default', 1)
> +        self.verify_vbootrom_firmware_flow()
> +        self.verify_openbmc_boot_start()
> +
> +    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):
> +        self.set_machine('ast2700a2-evb')
> +        self.require_netdev('user')
> +
> +        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)
> +        self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
> +        self.vm.add_args('-device',
> +                         'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
> +        self.start_ast2700_test('ast2700-dcscm', 8)
> +        self.verify_openbmc_boot_and_login('ast2700-dcscm', False)
> +        self.do_ast2700_i2c_test(8)
> +        self.do_ast2700_i2c_test(16)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


