Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1512C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlgus-0004Eo-LY; Mon, 20 Jul 2026 01:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlgud-0004Dn-3F
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:51:39 -0400
Received: from smtpout9.mo540.mail-out.ovh.net ([51.210.91.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wlguW-0001XF-QX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 01:51:34 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h3V4q6zszz3wbq;
 Mon, 20 Jul 2026 05:51:23 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 20 Jul 2026 05:51:23 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.73])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h3V4q00M5z7tqg; Mon, 20 Jul 2026 05:51:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3E67A9419E0; 
 Mon, 20 Jul 2026 05:51:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004a6d23edb-6ef7-43c7-a619-2ac814b586e6,
 4C691EFFF00230C9D76A3F7E6338562E7D7850CB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <df431d72-0cd5-40bb-a3db-42a42415fbe7@kaod.org>
Date: Mon, 20 Jul 2026 07:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] tests/functional/aarch64/test_aspeed_ast2700:
 Drop the AST2700 crypto self-test workaround
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-18-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260715033311.1648424-18-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13212153934811212845
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFsGVp90X2p/Ykiphc99Kt3uNvp7VJZWzEbLLtRKPM2ACjC0cXhIi5V3DPXszlrMSzM0wPaaWR50aINMqrIqcdXEx39Sc4Zz5ymqk4NFBKQ/FfJodXdEhpKyUEGlX6g5fWFUuhuIbWXSglYtwzL6vGUnQxeiIBdkdySrjgnAFt8IVglqayDA++s/pq5+/IvnQtOK30BjuEUFFr5qlI66uaH5g+mw0pwqipUu18Tt8Ext0JVQm597AvSXkZbSOLZjKxC479kXMjW9Rl6RRYBSyvTJu4azt2V102voozcRNA7X7NtS1WxISABOR2mp/f7m73eDCF8S5QKeIcuzCarHWJnTD8oFFYXVwkyFNdbwpNCfMmnc/tstz5r/BNY275d4tTBxZzgrbAdLVdFlKkg1s9CL8gi0OxfCx6aiiRyRH0gBiwMj1obz7meqpxgbGEAL/fXQ4lj9DPtv9oSnPK6fDwWtzM0ubjiFHDkhgU0a8vWVvkjNOG1+z6tD87+NqFzfGzvl2/ZurkpNkn2Opg80XkTzX/i9r4P7NHSv7kio3QbLWCzBNF9C6vCG/7deGQbu7r328AQciGT8W0T2cGzpF5PPWDGXWPbInmhBPwtrY9nyhU4MLEY8UJzI2SBEs7cgvHJ+EKjrvIpIUYwWyFDMIEtU+ZfuHSlYPHoKklxqmVpgg
DKIM-Signature: a=rsa-sha256; bh=ltq7D9B+Ns8UDqTmgeB0vrOQWmLFyANSLXV9UunInMA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784526685; v=1;
 b=jxdwBhBd7D5RMluq3iceZ9CLQXiC8WeNXmNmEFtCBIQU8haSUpdgIosXXEzwtwS+2ccHRucj
 y0TnY47Kl9IZ9ZhaUdB9LJuZMbmCwvT1E893NPcBBhvYxHUSHoE78LADke11nyzYZKNiRexO2+t
 ROlrSEeuQsFtaW9CW4ubObI7S82Kmuy6nwcF4RMmaL1dBm6zZs5blxbNrKYqQ5SPjL9XNDmRIq+
 8SIfCUOaL5UZN9TA1CzECLGgo9RFA+ShZZeXVS56oVQWwXRXbvtLpk4aIGAQlpAtal/rzZc3u5R
 +G4GRdZX/U6C4M6CaxWfjxXDgrhPZy+hDZz2gz8qUzwkA==
Received-SPF: pass client-ip=51.210.91.58; envelope-from=clg@kaod.org;
 helo=smtpout9.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/15/26 05:33, Jamin Lin wrote:
> The AST2700 boot tests appended 'cryptomgr.notests=1' to the kernel
> command line to skip the Linux crypto manager self-tests.
> 
> Now that the HACE crypto engine emulates the crypto command, the
> self-tests pass, so drop the workaround and let them run. This also
> exercises the HACE crypto emulation during the functional boot tests.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/test_aspeed_ast2700a1.py | 5 -----
>   tests/functional/aarch64/test_aspeed_ast2700a2.py | 5 -----
>   tests/functional/aarch64/test_aspeed_ast2700fc.py | 5 -----
>   3 files changed, 15 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
> index b0c08854da..bc535449b5 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
> @@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):
>           wait_for_console_pattern(self, 'pass')
>           wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
>   
> -    def disable_kernel_crypto_selftest(self):
> -         exec_command_and_wait_for_pattern(self,
> -            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
> -
>       def enable_ast2700_pcie2(self):
>           exec_command_and_wait_for_pattern(self,
>               'cp 100420000 403000000 900000', '=>')
> @@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
>           wait_for_console_pattern(self, 'Hit any key to stop autoboot')
>           exec_command_and_wait_for_pattern(self, '\012', '=>')
> -        self.disable_kernel_crypto_selftest()
>           if enable_pcie:
>               self.enable_ast2700_pcie2()
>           else:
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> index ed414999f4..5aea0a9dd0 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
> @@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):
>           wait_for_console_pattern(self, 'pass')
>           wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
>   
> -    def disable_kernel_crypto_selftest(self):
> -         exec_command_and_wait_for_pattern(self,
> -            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
> -
>       def enable_ast2700_pcie2(self):
>           exec_command_and_wait_for_pattern(self,
>               'cp 100420000 403000000 900000', '=>')
> @@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=True):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
>           wait_for_console_pattern(self, 'Hit any key to stop autoboot')
>           exec_command_and_wait_for_pattern(self, '\012', '=>')
> -        self.disable_kernel_crypto_selftest()
>           if enable_pcie:
>               self.enable_ast2700_pcie2()
>           else:
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index df889134ed..1648fa9dba 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -27,10 +27,6 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>   
>           self.vm.launch()
>   
> -    def disable_kernel_crypto_selftest(self):
> -         exec_command_and_wait_for_pattern(self,
> -            'setenv bootargs "${bootargs} cryptomgr.notests=1"', '=>')
> -
>       def enable_ast2700_pcie2(self):
>           exec_command_and_wait_for_pattern(self,
>               'cp 100420000 403000000 900000', '=>')
> @@ -47,7 +43,6 @@ def verify_openbmc_boot_and_login(self, name):
>           wait_for_console_pattern(self, 'U-Boot 2023.10')
>           wait_for_console_pattern(self, 'Hit any key to stop autoboot')
>           exec_command_and_wait_for_pattern(self, '\012', '=>')
> -        self.disable_kernel_crypto_selftest()
>           self.enable_ast2700_pcie2()
>           wait_for_console_pattern(self, 'Starting kernel ...')
>   


There are still crypto tests errors. See below. Is it expected ?

Thanks,

C.


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd040]
[    0.000000] Linux version 6.18.3-v00.08.01-g172b7e27a30d (oe-user@oe-host) (aarch64-openbmc-linux-gcc (GCC) 15.1.0, GNU ld (GNU Binutils) 2.44.0.20250429) #1 SMP PREEMPT Wed Feb 18 09:06:34 CST 2026
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: AST2700 EVB
[    0.000000] Malformed early option 'earlycon'
[    0.000000] Reserved memory: created DMA memory pool at 0x000000047ff00000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node xdma0, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000047ff00000..0x000000047fffffff (1024 KiB) nomap non-reusable xdma0
[    0.000000] Reserved memory: created DMA memory pool at 0x000000047fe00000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node xdma1, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000047fe00000..0x000000047fefffff (1024 KiB) nomap non-reusable xdma1
[    0.000000] Reserved memory: created CMA memory pool at 0x000000047de00000, size 32 MiB
[    0.000000] OF: reserved mem: initialized node video0, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000047de00000..0x000000047fdfffff (32768 KiB) map reusable video0
[    0.000000] Reserved memory: created CMA memory pool at 0x000000047ac00000, size 32 MiB
[    0.000000] OF: reserved mem: initialized node video1, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000047ac00000..0x000000047cbfffff (32768 KiB) map reusable video1
[    0.000000] Reserved memory: created CMA memory pool at 0x000000047ce00000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node mcyc0, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x000000047ce00000..0x000000047ddfffff (16384 KiB) map reusable mcyc0
[    0.000000] OF: reserved mem: 0x0000000430000000..0x000000043007ffff (512 KiB) nomap non-reusable trusted-firmware-a@430000000
[    0.000000] OF: reserved mem: 0x0000000430080000..0x000000043107ffff (16384 KiB) nomap non-reusable optee-core@430080000
[    0.000000] OF: reserved mem: 0x0000000428000000..0x000000042bffffff (65536 KiB) nomap non-reusable eadf0-memory@428000000
[    0.000000] OF: reserved mem: 0x0000000424000000..0x0000000427ffffff (65536 KiB) nomap non-reusable espi0-mmbi-memory@424000000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000423800000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node bmc-dev0-memory@423800000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000423800000..0x00000004238fffff (1024 KiB) nomap non-reusable bmc-dev0-memory@423800000
[    0.000000] OF: reserved mem: 0x0000000423a00000..0x0000000423bfffff (2048 KiB) nomap non-reusable pcie0-mmbi0-memory@423a00000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000423900000, size 1 MiB
[    0.000000] OF: reserved mem: initialized node bmc-dev1-memory@423900000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000423900000..0x00000004239fffff (1024 KiB) nomap non-reusable bmc-dev1-memory@423900000
[    0.000000] OF: reserved mem: 0x0000000423c00000..0x0000000423dfffff (2048 KiB) nomap non-reusable pcie1-mmbi4-memory@423c00000
[    0.000000] OF: reserved mem: 0x0000000423e00000..0x0000000423ffffff (2048 KiB) nomap non-reusable pcie2-mmbi0-memory@423e00000
[    0.000000] OF: reserved mem: 0x000000042c000000..0x000000042dffffff (32768 KiB) nomap non-reusable ssp-memory@42c000000
[    0.000000] OF: reserved mem: 0x000000042e000000..0x000000042fffffff (32768 KiB) nomap non-reusable tsp-memory@42e000000
[    0.000000] OF: reserved mem: 0x0000000431080000..0x000000043187ffff (8192 KiB) nomap non-reusable ipc-ssp-share@431080000
[    0.000000] OF: reserved mem: 0x0000000431880000..0x0000000431b2ffff (2752 KiB) nomap non-reusable ipc-bootmcu-share@431880000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000431b30000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node uhci0-reserved@431b30000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000431b30000..0x0000000431b6ffff (256 KiB) nomap non-reusable uhci0-reserved@431b30000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000431b70000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node uhci1-reserved@431b70000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000431b70000..0x0000000431baffff (256 KiB) nomap non-reusable uhci1-reserved@431b70000
[    0.000000] OF: reserved mem: 0x0000000431bb0000..0x0000000431bbffff (64 KiB) nomap non-reusable vbios-base0@431bb0000
[    0.000000] OF: reserved mem: 0x0000000431bc0000..0x0000000431bcffff (64 KiB) nomap non-reusable vbios-base1@431bc0000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000431bd0000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node mctp0-reserved@431bd0000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000431bd0000..0x0000000431bdffff (64 KiB) nomap non-reusable mctp0-reserved@431bd0000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000431be0000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node mctp1-reserved@431be0000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000431be0000..0x0000000431beffff (64 KiB) nomap non-reusable mctp1-reserved@431be0000
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000431bf0000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node mctp2-reserved@431bf0000, compatible id shared-dma-pool
[    0.000000] OF: reserved mem: 0x0000000431bf0000..0x0000000431bfffff (64 KiB) nomap non-reusable mctp2-reserved@431bf0000
[    0.000000] NUMA: Faking a node at [mem 0x0000000400000000-0x000000047fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x47a892d40-0x47a89533f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000400000000-0x000000047fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000400000000-0x00000004237fffff]
[    0.000000]   node   0: [mem 0x0000000423800000-0x0000000431bfffff]
[    0.000000]   node   0: [mem 0x0000000431c00000-0x000000047fdfffff]
[    0.000000]   node   0: [mem 0x000000047fe00000-0x000000047fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000400000000-0x000000047fffffff]
[    0.000000] cma: Reserved 32 MiB at 0x0000000401800000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.5
[    0.000000] percpu: Embedded 31 pages/cpu s88216 r8192 d30568 u126976
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GICv3 CPU interface
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: console=ttyS12,115200n8 root=/dev/ram rw earlycon
[    0.000000] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 2MB
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x0000000478300000-0x0000000478500000] (2MB)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 524288
[    0.000000] Policy zone: DMA
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICD_CTLR.DS=1, SCR_EL3.FIQ=1
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000012280000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer running at 1600.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1fffffffffffffff max_cycles: 0x171024fa93b, max_idle_ns: 440795253189 ns
[    0.000037] sched_clock: 61 bits at 1600MHz, resolution 0ns, wraps every 4398046511103ns
[    0.006379] Console: colour dummy device 80x25
[    0.008502] Calibrating delay loop (skipped), value calculated using timer frequency.. 3200.00 BogoMIPS (lpj=6400000)
[    0.008572] pid_max: default: 32768 minimum: 301
[    0.010747] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.010795] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.037047] rcu: Hierarchical SRCU implementation.
[    0.037077] rcu: 	Max phase no-delay instances is 1000.
[    0.038351] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.041363] ASPEED AST2700 rev A2 (06020103)
[    0.042677] smp: Bringing up secondary CPUs ...
[    0.045789] Detected VIPT I-cache on CPU1
[    0.046337] GICv3: CPU1: found redistributor 1 region 0:0x00000000122a0000
[    0.046467] CPU1: Booted secondary processor 0x0000000001 [0x411fd040]
[    0.050519] Detected VIPT I-cache on CPU2
[    0.050686] GICv3: CPU2: found redistributor 2 region 0:0x00000000122c0000
[    0.050765] CPU2: Booted secondary processor 0x0000000002 [0x411fd040]
[    0.052102] Detected VIPT I-cache on CPU3
[    0.052264] GICv3: CPU3: found redistributor 3 region 0:0x00000000122e0000
[    0.052345] CPU3: Booted secondary processor 0x0000000003 [0x411fd040]
[    0.052712] smp: Brought up 1 node, 4 CPUs
[    0.052729] SMP: Total of 4 processors activated.
[    0.052743] CPU: All CPU(s) started at EL2
[    0.052780] CPU features: detected: 32-bit EL0 Support
[    0.052821] CPU features: detected: CRC32 instructions
[    0.052910] CPU features: detected: PMUv3
[    0.059753] alternatives: applying system-wide alternatives
[    0.070608] Memory: 1673568K/2097152K available (14592K kernel code, 2014K rwdata, 5568K rodata, 1408K init, 524K bss, 303892K reserved, 114688K cma-reserved)
[    0.088349] devtmpfs: initialized
[    0.110897] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.111263] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.111895] futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.113861] 26688 pages in range for non-PLT usage
[    0.114239] 518208 pages in range for PLT usage
[    0.115151] pinctrl core: initialized pinctrl subsystem
[    0.135658] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.144194] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.144873] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.145400] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.145718] audit: initializing netlink subsys (disabled)
[    0.147488] audit: type=2000 audit(0.140:1): state=initialized audit_enabled=0 res=1
[    0.149211] cpuidle: using governor menu
[    0.149955] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.150560] ASID allocator initialised with 65536 entries
[    0.216875] iommu: Default domain type: Translated
[    0.216907] iommu: DMA domain TLB invalidation policy: strict mode
[    0.220788] SCSI subsystem initialized
[    0.221600] usbcore: registered new interface driver usbfs
[    0.221813] usbcore: registered new interface driver hub
[    0.221908] usbcore: registered new device driver usb
[    0.222221] mc: Linux media interface: v0.10
[    0.222262] videodev: Linux video capture interface: v2.00
[    0.222358] pps_core: LinuxPPS API ver. 1 registered
[    0.222364] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.222392] PTP clock support registered
[    0.222497] EDAC MC: Ver: 3.0.0
[    0.223354] scmi_core: SCMI protocol bus registered
[    0.231561] mctp: management component transport protocol core
[    0.231573] NET: Registered PF_MCTP protocol family
[    0.232784] vgaarb: loaded
[    0.235288] clocksource: Switched to clocksource arch_sys_counter
[    0.237125] VFS: Disk quotas dquot_6.6.0
[    0.237189] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.252368] NET: Registered PF_INET protocol family
[    0.253271] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.256584] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    0.256622] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.256661] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.257174] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.257342] TCP: Hash tables configured (established 16384 bind 16384)
[    0.258127] UDP hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.258261] UDP-Lite hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.258919] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.259388] PCI: CLS 0 bytes, default 64
[    0.262222] Trying to unpack rootfs image as initramfs...
[    0.262737] Initialise system trusted keyrings
[    0.263942] workingset: timestamp_bits=42 max_order=19 bucket_order=0
[    0.266013] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.266194] jffs2: version 2.2. (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    0.296367] NET: Registered PF_ALG protocol family
[    0.296561] Key type asymmetric registered
[    0.296676] Asymmetric key parser 'x509' registered
[    0.297006] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.297097] io scheduler mq-deadline registered
[    0.297134] io scheduler kyber registered
[    0.297360] io scheduler bfq registered
[    0.310863] aspeed_usb_phy3 12010000.usb-phy3: Probed USB PHY3
[    0.311709] aspeed_usb_phy3 12020000.usb-phy3: Probed USB PHY3
[    0.323247] ledtrig-cpu: registered to indicate activity on CPUs
[    0.324971] ipmi-bt-host 12c19140.pcie-ibt: initialised channel 2 at IO address 0xe4
[    0.325436] ipmi-bt-host 12c19940.pcie-ibt: initialised channel 3 at IO address 0xe4
[    0.326029] ipmi-bt-host 14c31140.ibt: initialised channel 0 at IO address 0xe4
[    0.326393] ipmi-bt-host 14c32140.ibt: initialised channel 1 at IO address 0xe4
[    0.327619] aspeed-kcs-bmc 12c19024.pcie-kcs: Initialised IPMI client for channel 8
[    0.327656] aspeed-kcs-bmc 12c19024.pcie-kcs: Initialised channel 8 at IO address 0x3a0
[    0.328103] aspeed-kcs-bmc 12c19028.pcie-kcs: Initialised IPMI client for channel 9
[    0.328112] aspeed-kcs-bmc 12c19028.pcie-kcs: Initialised channel 9 at IO address 0x3a8
[    0.328481] aspeed-kcs-bmc 12c1902c.pcie-kcs: Initialised IPMI client for channel 10
[    0.328490] aspeed-kcs-bmc 12c1902c.pcie-kcs: Initialised channel 10 at IO address 0x3a2
[    0.328832] aspeed-kcs-bmc 12c19114.pcie-kcs: Initialised IPMI client for channel 11
[    0.328841] aspeed-kcs-bmc 12c19114.pcie-kcs: Initialised channel 11 at IO address 0x3a4
[    0.329240] aspeed-kcs-bmc 12c19824.pcie-kcs: Initialised IPMI client for channel 12
[    0.329248] aspeed-kcs-bmc 12c19824.pcie-kcs: Initialised channel 12 at IO address 0x3a0
[    0.329852] aspeed-kcs-bmc 12c19828.pcie-kcs: Initialised IPMI client for channel 13
[    0.329860] aspeed-kcs-bmc 12c19828.pcie-kcs: Initialised channel 13 at IO address 0x3a8
[    0.330154] aspeed-kcs-bmc 12c1982c.pcie-kcs: Initialised IPMI client for channel 14
[    0.330162] aspeed-kcs-bmc 12c1982c.pcie-kcs: Initialised channel 14 at IO address 0x3a2
[    0.330497] aspeed-kcs-bmc 12c19914.pcie-kcs: Initialised IPMI client for channel 15
[    0.330506] aspeed-kcs-bmc 12c19914.pcie-kcs: Initialised channel 15 at IO address 0x3a4
[    0.331245] aspeed-kcs-bmc 14c31024.lpc-kcs: Initialised IPMI client for channel 0
[    0.331256] aspeed-kcs-bmc 14c31024.lpc-kcs: Initialised channel 0 at IO address 0xca0
[    0.331599] aspeed-kcs-bmc 14c31028.lpc-kcs: Initialised IPMI client for channel 1
[    0.331608] aspeed-kcs-bmc 14c31028.lpc-kcs: Initialised channel 1 at IO address 0xca8
[    0.332047] aspeed-kcs-bmc 14c3102c.lpc-kcs: Initialised IPMI client for channel 2
[    0.332058] aspeed-kcs-bmc 14c3102c.lpc-kcs: Initialised channel 2 at IO address 0xca2
[    0.332393] aspeed-kcs-bmc 14c31114.lpc-kcs: Initialised IPMI client for channel 3
[    0.332402] aspeed-kcs-bmc 14c31114.lpc-kcs: Initialised channel 3 at IO address 0xca4
[    0.332793] aspeed-kcs-bmc 14c32024.kcs: Initialised IPMI client for channel 4
[    0.332801] aspeed-kcs-bmc 14c32024.kcs: Initialised channel 4 at IO address 0xca0
[    0.333107] aspeed-kcs-bmc 14c32028.kcs: Initialised IPMI client for channel 5
[    0.333115] aspeed-kcs-bmc 14c32028.kcs: Initialised channel 5 at IO address 0xca8
[    0.333408] aspeed-kcs-bmc 14c3202c.kcs: Initialised IPMI client for channel 6
[    0.333425] aspeed-kcs-bmc 14c3202c.kcs: Initialised channel 6 at IO address 0xca2
[    0.333731] aspeed-kcs-bmc 14c32114.kcs: Initialised IPMI client for channel 7
[    0.333739] aspeed-kcs-bmc 14c32114.kcs: Initialised channel 7 at IO address 0xca4
[    0.335242] aspeed_bmc_dev 12110000.bmc-dev: reserved memory is beyond device's set DMA address range
[    0.335287] aspeed_bmc_dev 12110000.bmc-dev: assigned reserved memory node bmc-dev0-memory@423800000
[    0.336909] aspeed_bmc_dev 12110000.bmc-dev: aspeed bmc device: driver successfully loaded.
[    0.337060] aspeed_bmc_dev 12120000.bmc-dev: reserved memory is beyond device's set DMA address range
[    0.337068] aspeed_bmc_dev 12120000.bmc-dev: assigned reserved memory node bmc-dev1-memory@423900000
[    0.337826] aspeed_bmc_dev 12120000.bmc-dev: aspeed bmc device: driver successfully loaded.
[    0.343471] aspeed-uart-routing 14c31098.uart-routing: module loaded
[    0.343602] aspeed-uart-routing 14c32098.uart-routing: module loaded
[    0.344331] aspeed-xdma 12c04000.xdma: reserved memory is beyond device's set DMA address range
[    0.344341] aspeed-xdma 12c04000.xdma: assigned reserved memory node xdma0
[    0.346934] aspeed-xdma 12c05000.xdma: reserved memory is beyond device's set DMA address range
[    0.346945] aspeed-xdma 12c05000.xdma: assigned reserved memory node xdma1
[    0.389006] aspeed_usb_phy3 12010000.usb-phy3: Wait phy3 init timed out
[    0.389059] phy phy-12010000.usb-phy3.3: phy init failed --> -110
[    0.389134] aspeed_usb_hp soc@10000000:usb3ahp: failed to init usb3 phy
[    0.389309] aspeed_usb_hp soc@10000000:usb3ahp: probe with driver aspeed_usb_hp failed with error -110
[    0.402300] aspeed_usb_phy3 12020000.usb-phy3: Wait phy3 init timed out
[    0.402312] phy phy-12020000.usb-phy3.4: phy init failed --> -110
[    0.402319] aspeed_usb_hp soc@10000000:usb3bhp: failed to init usb3 phy
[    0.402325] aspeed_usb_hp soc@10000000:usb3bhp: probe with driver aspeed_usb_hp failed with error -110
[    0.405370] aspeed_pcie_mmbi 12c21000.e2m-config:pcie0-mmbi@0: ASPEED PCIe MMBI Dev 0: driver successfully loaded.
[    0.406781] aspeed_pcie_mmbi 12c22000.e2m-config:pcie1-mmbi@4: ASPEED PCIe MMBI Dev 1: driver successfully loaded.
[    0.408663] aspeed-mctp 12c06000.mctp0: assigned reserved memory node mctp0-reserved@431bd0000
[    0.412243] aspeed-mctp 12c07000.mctp1: assigned reserved memory node mctp1-reserved@431be0000
[    0.413541] aspeed-mctp 14c1a000.mctp2: assigned reserved memory node mctp2-reserved@431bf0000
[    0.415109] ast2700_otp 14c07000.otp: Aspeed OTP driver successfully registered
[    0.458099] Freeing initrd memory: 1312K
[    0.489832] aspeed-espi 14c05000.espi: assigned reserved memory node mcyc0
[    0.495645] aspeed-espi 14c05000.espi: eDAF mode: 0x2
[    0.496444] aspeed-espi 14c05000.espi: module loaded
[    0.497026] ast2700-rtc-over-espi 14c3d000.rtc-over_espi: RTC not ready, deferring probe
[    0.548836] Serial: 8250/16550 driver, 23 ports, IRQ sharing enabled
[    0.561470] 12c18000.serial: ttyS19 at MMIO 0x12c18000 (irq = 78, base_baud = 25000000) is a ASPEED VUART
[    0.563500] 12c18100.serial: ttyS20 at MMIO 0x12c18100 (irq = 79, base_baud = 25000000) is a ASPEED VUART
[    0.564507] 12c18200.serial: ttyS21 at MMIO 0x12c18200 (irq = 80, base_baud = 25000000) is a ASPEED VUART
[    0.565501] 12c18300.serial: ttyS22 at MMIO 0x12c18300 (irq = 81, base_baud = 25000000) is a ASPEED VUART
[    0.566848] 14c33200.serial: ttyS2 at MMIO 0x14c33200 (irq = 82, base_baud = 115384) is a 16550A
[    0.568986] 14c33800.serial: ttyS9 at MMIO 0x14c33800 (irq = 83, base_baud = 115384) is a 16550A
[    0.570059] 14c33b00.serial: ttyS12 at MMIO 0x14c33b00 (irq = 84, base_baud = 115384) is a 16550A
[    0.571430] printk: legacy console [ttyS12] enabled
[    0.599367] DWC_TRNG_DriverSDK_1.00a
[    0.599866] NIST_TRNG: Hardware rel_num=0x0, ext_ver=0x0, ext_enum=0x0
[    1.081562] wait_on_: failed timeout: 00000000
[    1.081679] NIST_TRNG init failed (-21)
[    1.081882] nist_trng nist_trng: probe with driver nist_trng failed with error -21
[    1.100031] brd: module loaded
[    1.108016] loop: module loaded
[    1.137960] spi-aspeed-smc 14000000.spi: user mode and normal read are used
[    1.141534] spi-nor spi0.0: supply vcc not found, using dummy regulator
[    1.162328] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
[    1.162556] spi-aspeed-smc 14000000.spi: CE0 write buswidth: 4 [0x40340602]
[    1.215999] 5 fixed-partitions partitions found on MTD device bmc
[    1.216161] Creating 5 MTD partitions on "bmc":
[    1.216316] 0x000000000000-0x000000400000 : "u-boot"
[    1.218264] 0x000000400000-0x000000420000 : "u-boot-env"
[    1.219554] 0x000000420000-0x000000d20000 : "kernel"
[    1.220982] 0x000000d20000-0x000006000000 : "rofs"
[    1.222261] 0x000006000000-0x000008000000 : "rwfs"
[    1.227788] spi-nor spi0.1: supply vcc not found, using dummy regulator
[    1.228829] spi-aspeed-smc 14000000.spi: Calibration area too uniform
[    1.229072] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
[    1.229186] spi-aspeed-smc 14000000.spi: CE1 write buswidth: 4 [0x40340602]
[    1.247107] spi-aspeed-smc 14010000.spi: user mode and normal read are used
[    1.248480] spi-nor spi1.0: supply vcc not found, using dummy regulator
[    1.249664] spi-aspeed-smc 14010000.spi: Calibration area too uniform
[    1.249758] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
[    1.249851] spi-aspeed-smc 14010000.spi: CE0 write buswidth: 1 [0x00120602]
[    1.259585] spi-aspeed-smc 14020000.spi: user mode and normal read are used
[    1.260535] spi-nor spi2.0: supply vcc not found, using dummy regulator
[    1.260863] spi-nor spi2.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00
[    1.264807] spi_aspeed_txrx 14030000.spi: cs: 0, ctrl_val: 0x00000407
[    1.279202] CAN device driver interface
[    2.288754] aspeed_can 14c3e000.can (unnamed net_device) (uninitialized): timed out for config mode
[    2.289000] aspeed_can 14c3e000.can: probe with driver aspeed_can failed with error -110
[    2.291357] ftgmac100 14050000.ethernet: Read MAC address 52:54:00:12:34:56 from chip
[    2.292825] RTL8211E Gigabit Ethernet 14040000.mdio-1:00: attached PHY driver (mii_bus:phy_addr=14040000.mdio-1:00, irq=POLL)
[    2.312021] ftgmac100 14050000.ethernet eth0: irq 86, mapped at (____ptrval____)
[    2.312736] ftgmac100 14060000.ethernet: Read MAC address 52:54:00:12:34:57 from chip
[    2.312994] RTL8211E Gigabit Ethernet 14040008.mdio-1:00: attached PHY driver (mii_bus:phy_addr=14040008.mdio-1:00, irq=POLL)
[    2.331522] ftgmac100 14060000.ethernet eth1: irq 87, mapped at (____ptrval____)
[    2.331821] e100: Intel(R) PRO/100 Network Driver
[    2.331879] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.332018] e1000: Intel(R) PRO/1000 Network Driver
[    2.332088] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.332213] e1000e: Intel(R) PRO/1000 Network Driver
[    2.332303] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.332431] igb: Intel(R) Gigabit Ethernet Network Driver
[    2.332511] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.332639] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    2.332726] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    2.333468] MCTP I2C interface driver
[    2.333816] usbcore: registered new interface driver mctp-usb
[    2.333952] usbcore: registered new interface driver cdc_ether
[    2.334071] usbcore: registered new interface driver cdc_eem
[    2.334194] usbcore: registered new interface driver net1080
[    2.334317] usbcore: registered new interface driver cdc_subset
[    2.334434] usbcore: registered new interface driver zaurus
[    2.334550] usbcore: registered new interface driver cdc_ncm
[    2.334670] usbcore: registered new interface driver r8153_ecm
[    2.336620] platform-uhci 14110000.usb: Detected 2 ports from device-tree
[    2.336765] platform-uhci 14110000.usb: Enabled Aspeed implementation workarounds
[    2.337202] platform-uhci 14110000.usb: Generic UHCI Host Controller
[    2.337204] ehci-platform 14123000.usb: EHCI Host Controller
[    2.337639] ehci-platform 14123000.usb: new USB bus registered, assigned bus number 2
[    2.337640] platform-uhci 14110000.usb: new USB bus registered, assigned bus number 1
[    2.338409] platform-uhci 14110000.usb: irq 89, io mem 0x14110000
[    2.338627] platform-uhci 14110000.usb: Device does not have specific DMA pool
[    2.339110] ehci-platform 14123000.usb: irq 88, io mem 0x14123000
[    2.344125] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.18
[    2.344272] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.344375] usb usb1: Product: Generic UHCI Host Controller
[    2.344456] usb usb1: Manufacturer: Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd
[    2.344560] usb usb1: SerialNumber: 14110000.usb
[    2.347100] hub 1-0:1.0: USB hub found
[    2.347598] hub 1-0:1.0: 2 ports detected
[    2.351199] ehci-platform 14123000.usb: USB 2.0 started, EHCI 1.00
[    2.351206] usbcore: registered new interface driver cdc_acm
[    2.351251] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    2.351648] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    2.351794] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.351918] usb usb2: Product: EHCI Host Controller
[    2.351999] usb usb2: Manufacturer: Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd
[    2.352005] usbcore: registered new interface driver uas
[    2.352094] usb usb2: SerialNumber: 14123000.usb
[    2.352418] usbcore: registered new interface driver usb-storage
[    2.352828] usbcore: registered new interface driver pl2303
[    2.352891] hub 2-0:1.0: USB hub found
[    2.353110] usbserial: USB Serial support registered for pl2303
[    2.353190] hub 2-0:1.0: 6 ports detected
[    2.363145] platform-uhci 14110000.usb: Controller not stopped yet!
[    2.366436] aspeed_vhub 12060000.usb-vhub: PCIe EHCI to vhub
[    2.368834] aspeed_vhub 12060000.usb-vhub: Initialized virtual hub in USB2 mode
[    2.379205] aspeed_vhub 12062000.usb-vhub: PCIe EHCI to vhub
[    2.380707] aspeed_vhub 12062000.usb-vhub: Initialized virtual hub in USB2 mode
[    2.392449] aspeed_vhub 14120000.usb-vhub: Initialized virtual hub in USB2 mode
[    2.396382] aspeed-rtc 12c0f000.rtc: registered as rtc0
[    2.396904] aspeed-rtc 12c0f000.rtc: setting system clock to 1970-01-01T01:01:01 UTC (3661)
[    2.397557] i2c_dev: i2c /dev entries driver
[    2.401063] i2c_ast2600 14c0f100.i2c-bus: i2c-bus [0]: adapter [100 KHz] mode [2] version [1]
[    2.401971] i2c_ast2600 14c0f200.i2c-bus: i2c-bus [1]: adapter [100 KHz] mode [2] version [1]
[    2.402763] i2c_ast2600 14c0f300.i2c-bus: i2c-bus [2]: adapter [100 KHz] mode [2] version [1]
[    2.403689] i2c_ast2600 14c0f400.i2c-bus: i2c-bus [3]: adapter [100 KHz] mode [2] version [1]
[    2.404448] i2c_ast2600 14c0f500.i2c-bus: i2c-bus [4]: adapter [100 KHz] mode [2] version [1]
[    2.405292] i2c_ast2600 14c0f600.i2c-bus: i2c-bus [5]: adapter [100 KHz] mode [2] version [1]
[    2.406064] i2c_ast2600 14c0f700.i2c-bus: i2c-bus [6]: adapter [100 KHz] mode [2] version [1]
[    2.406787] i2c_ast2600 14c0f800.i2c-bus: i2c-bus [7]: adapter [100 KHz] mode [2] version [1]
[    2.407562] i2c_ast2600 14c0f900.i2c-bus: i2c-bus [8]: adapter [100 KHz] mode [2] version [1]
[    2.408366] i2c_ast2600 14c0fc00.i2c-bus: i2c-bus [11]: adapter [100 KHz] mode [2] version [1]
[    2.409112] i2c_ast2600 14c0fd00.i2c-bus: i2c-bus [12]: adapter [100 KHz] mode [2] version [1]
[    2.409807] i2c_ast2600 14c0fe00.i2c-bus: i2c-bus [13]: adapter [100 KHz] mode [2] version [1]
[    2.410928]  14c20000.i3c0: MIPI I3C HCI v0.0 r00
[    2.411100]  14c20000.i3c0: unsupported HCI version
[    2.411231] mipi-i3c-hci 14c20000.i3c0: probe with driver mipi-i3c-hci failed with error -93
[    2.411493]  14c21000.i3c1: MIPI I3C HCI v0.0 r00
[    2.411571]  14c21000.i3c1: unsupported HCI version
[    2.411636] mipi-i3c-hci 14c21000.i3c1: probe with driver mipi-i3c-hci failed with error -93
[    2.411863]  14c22000.i3c2: MIPI I3C HCI v0.0 r00
[    2.411934]  14c22000.i3c2: unsupported HCI version
[    2.411999] mipi-i3c-hci 14c22000.i3c2: probe with driver mipi-i3c-hci failed with error -93
[    2.412217]  14c23000.i3c3: MIPI I3C HCI v0.0 r00
[    2.412290]  14c23000.i3c3: unsupported HCI version
[    2.412355] mipi-i3c-hci 14c23000.i3c3: probe with driver mipi-i3c-hci failed with error -93
[    2.412574]  14c24000.i3c4: MIPI I3C HCI v0.0 r00
[    2.412644]  14c24000.i3c4: unsupported HCI version
[    2.412710] mipi-i3c-hci 14c24000.i3c4: probe with driver mipi-i3c-hci failed with error -93
[    2.412927]  14c25000.i3c5: MIPI I3C HCI v0.0 r00
[    2.412997]  14c25000.i3c5: unsupported HCI version
[    2.413062] mipi-i3c-hci 14c25000.i3c5: probe with driver mipi-i3c-hci failed with error -93
[    2.413280]  14c26000.i3c6: MIPI I3C HCI v0.0 r00
[    2.413350]  14c26000.i3c6: unsupported HCI version
[    2.413414] mipi-i3c-hci 14c26000.i3c6: probe with driver mipi-i3c-hci failed with error -93
[    2.413659]  14c27000.i3c7: MIPI I3C HCI v0.0 r00
[    2.413734]  14c27000.i3c7: unsupported HCI version
[    2.413798] mipi-i3c-hci 14c27000.i3c7: probe with driver mipi-i3c-hci failed with error -93
[    2.414017]  14c28000.i3c8: MIPI I3C HCI v0.0 r00
[    2.414087]  14c28000.i3c8: unsupported HCI version
[    2.414153] mipi-i3c-hci 14c28000.i3c8: probe with driver mipi-i3c-hci failed with error -93
[    2.414371]  14c29000.i3c9: MIPI I3C HCI v0.0 r00
[    2.414442]  14c29000.i3c9: unsupported HCI version
[    2.414506] mipi-i3c-hci 14c29000.i3c9: probe with driver mipi-i3c-hci failed with error -93
[    2.414742]  14c2a000.i3c10: MIPI I3C HCI v0.0 r00
[    2.414817]  14c2a000.i3c10: unsupported HCI version
[    2.414884] mipi-i3c-hci 14c2a000.i3c10: probe with driver mipi-i3c-hci failed with error -93
[    2.415160]  14c2b000.i3c11: MIPI I3C HCI v0.0 r00
[    2.415243]  14c2b000.i3c11: unsupported HCI version
[    2.415310] mipi-i3c-hci 14c2b000.i3c11: probe with driver mipi-i3c-hci failed with error -93
[    2.415542]  14c2c000.i3c12: MIPI I3C HCI v0.0 r00
[    2.415613]  14c2c000.i3c12: unsupported HCI version
[    2.415679] mipi-i3c-hci 14c2c000.i3c12: probe with driver mipi-i3c-hci failed with error -93
[    2.415900]  14c2d000.i3c13: MIPI I3C HCI v0.0 r00
[    2.415973]  14c2d000.i3c13: unsupported HCI version
[    2.416041] mipi-i3c-hci 14c2d000.i3c13: probe with driver mipi-i3c-hci failed with error -93
[    2.416267]  14c2e000.i3c14: MIPI I3C HCI v0.0 r00
[    2.416340]  14c2e000.i3c14: unsupported HCI version
[    2.416405] mipi-i3c-hci 14c2e000.i3c14: probe with driver mipi-i3c-hci failed with error -93
[    2.416647]  14c2f000.i3c15: MIPI I3C HCI v0.0 r00
[    2.416725]  14c2f000.i3c15: unsupported HCI version
[    2.416790] mipi-i3c-hci 14c2f000.i3c15: probe with driver mipi-i3c-hci failed with error -93
[    2.418547] aspeed-video 120a0000.video: irq 106
[    2.418735] aspeed-video 120a0000.video: dvi mode-detection irq 107
[    2.418985] aspeed-video 120a0000.video: assigned reserved memory node video0
[    2.432446] aspeed-video 120a0000.video: alloc mem size(18493440) at 0x000000047de00000 for pool
[    2.435819] aspeed-video 120a0000.video: aspeed-video0 registered as /dev/video0
[    2.436890] aspeed-video 120a1000.video: irq 108
[    2.437029] aspeed-video 120a1000.video: assigned reserved memory node video1
[    2.449658] aspeed-video 120a1000.video: alloc mem size(18493440) at 0x000000047ac00000 for pool
[    2.450250] aspeed-video 120a1000.video: aspeed-video1 registered as /dev/video1
[    2.458433] sdhci: Secure Digital Host Controller Interface driver
[    2.458547] sdhci: Copyright(c) Pierre Ossman
[    2.458614] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.461200] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    2.462065] sdhci-aspeed 12090100.sdhci: Configured for slot 0
[    2.463137] aspeed_crypto 12070000.crypto: will run requests pump with realtime priority
[    2.466408] aspeed_crypto 12070000.crypto: will run requests pump with realtime priority
[    2.467319] aspeed-ufshcd 12c08200.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
[    2.467557] aspeed-ufshcd 12c08200.ufshc: ufshcd_populate_vreg: Unable to find vcc-supply regulator, assuming enabled
[    2.467743] aspeed-ufshcd 12c08200.ufshc: ufshcd_populate_vreg: Unable to find vccq-supply regulator, assuming enabled
[    2.468017] aspeed-ufshcd 12c08200.ufshc: ufshcd_populate_vreg: Unable to find vccq2-supply regulator, assuming enabled
[    2.468196] aspeed_crypto 12070000.crypto: cannot find sbc node
[    2.468648] aspeed_crypto 12070000.crypto: Aspeed Crypto Accelerator successfully registered
[    2.469278] aspeed-ufshcd 12c08200.ufshc: Command Descriptor Memory allocation failed
[    2.469443] aspeed-ufshcd 12c08200.ufshc: Memory allocation failed
[    2.469825] aspeed-ufshcd 12c08200.ufshc: ufshcd_pltfrm_init() failed -12
[    2.469962] aspeed-ufshcd 12c08200.ufshc: probe with driver aspeed-ufshcd failed with error -12
[    2.470412] aspeed_rsss 12080000.crypto: will run requests pump with realtime priority
[    2.471110] aspeed_rsss 12080000.crypto: RSA init failed
[    2.471245] aspeed_rsss 12080000.crypto: probe with driver aspeed_rsss failed with error -5
[    2.472595] aspeed_ecdsa 12c1e000.crypto: probe with driver aspeed_ecdsa failed with error -5
[    2.473678] usbcore: registered new interface driver usbhid
[    2.473827] usbhid: USB HID core driver
[    2.485896] hw perfevents: enabled with armv8_cortex_a35 PMU driver, 7 (0,8000003f) counters available
[    2.487770] optee: probing for conduit method.
I/TC: Reserved shared memory is disabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
[    2.488394] optee: revision 4.4 (8f645256efc0dc66)
[    2.489279] watchdog: NMI not fully supported
[    2.489417] watchdog: Hard watchdog permanently disabled
[    2.490296] optee: dynamic shared memory is enabled
[    2.496286] optee: initialized driver
[    2.499251] mmc0: SDHCI controller on 12090100.sdhci [12090100.sdhci] using ADMA 64-bit
[    2.499601] pktgen: Packet Generator for packet performance testing. Version: 2.75
[    2.502051] NET: Registered PF_INET6 protocol family
[    2.508037] Segment Routing with IPv6
[    2.508286] In-situ OAM (IOAM) with IPv6
[    2.508812] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.510670] NET: Registered PF_PACKET protocol family
[    2.511122] can: controller area network core
[    2.511471] NET: Registered PF_CAN protocol family
[    2.511597] can: raw protocol
[    2.511791] can: broadcast manager protocol
[    2.512029] can: netlink gateway - max_hops=1
[    2.512210] 8021q: 802.1Q VLAN Support v1.8
[    2.520069] registered taskstats version 1
[    2.521401] Loading compiled-in X.509 certificates
[    2.531388] Demotion targets for Node 0: null
[    2.532261] Key type .fscrypt registered
[    2.532350] Key type fscrypt-provisioning registered
[    2.564198] mmc0: Failed to initialize a non-removable card
[    2.573543] alg: skcipher: aspeed-ctr-des encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
[    2.573863] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
[    2.573938] ------------[ cut here ]------------
[    2.574155] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
[    2.574401] WARNING: CPU: 3 PID: 116 at /usr/src/kernel/crypto/testmgr.c:5829 alg_test+0x490/0x5bc
[    2.574972] Modules linked in:
[    2.575579] CPU: 3 UID: 0 PID: 116 Comm: cryptomgr_test Not tainted 6.18.3-v00.08.01-g172b7e27a30d #1 PREEMPT
[    2.575776] Hardware name: AST2700 EVB (DT)
[    2.575979] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.576125] pc : alg_test+0x490/0x5bc
[    2.576215] lr : alg_test+0x490/0x5bc
[    2.576286] sp : ffff800081f7bd50
[    2.576358] x29: ffff800081f7bdf0 x28: 0000000000000004 x27: ffff800080eaa568
[    2.576584] x26: 0000000000000000 x25: 00000000ffffffff x24: 0000000000000004
[    2.576809] x23: ffff0000065d1680 x22: 0000000000001085 x21: ffff0000065d1600
[    2.576981] x20: 00000000ffffffea x19: ffff800080eaa568 x18: 000000000000000a
[    2.577104] x17: 32322d3d63722820 x16: 64656c6961662073 x15: 0000000000000000
[    2.577223] x14: 0000000000000000 x13: 00000000ffff0a01 x12: 00000000ffffffea
[    2.577345] x11: ffff800081f7bab8 x10: 00000000ffffefff x9 : ffff8000815ae3c8
[    2.577486] x8 : ffff8000815ae420 x7 : 0000000000017fe8 x6 : c0000000ffffefff
[    2.577609] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000000
[    2.577744] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000006de2400
[    2.578021] Call trace:
[    2.578164]  alg_test+0x490/0x5bc (P)
[    2.578302]  cryptomgr_test+0x24/0x44
[    2.578384]  kthread+0x140/0x220
[    2.578455]  ret_from_fork+0x10/0x20
[    2.578604] ---[ end trace 0000000000000000 ]---
[    2.579215] alg: skcipher: aspeed-ctr-tdes encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
[    2.579437] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
[    2.579445] ------------[ cut here ]------------
[    2.579673] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
[    2.580184] WARNING: CPU: 0 PID: 115 at /usr/src/kernel/crypto/testmgr.c:5829 alg_test+0x490/0x5bc
[    2.580525] Modules linked in:
[    2.580726] CPU: 0 UID: 0 PID: 115 Comm: cryptomgr_test Tainted: G        W           6.18.3-v00.08.01-g172b7e27a30d #1 PREEMPT
[    2.580940] Tainted: [W]=WARN
[    2.580992] Hardware name: AST2700 EVB (DT)
[    2.581058] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.581196] pc : alg_test+0x490/0x5bc
[    2.581261] lr : alg_test+0x490/0x5bc
[    2.581335] sp : ffff800081f73d50
[    2.581392] x29: ffff800081f73df0 x28: 0000000000000004 x27: ffff800080eaa568
[    2.581529] x26: 0000000000000000 x25: 00000000ffffffff x24: 0000000000000004
[    2.581655] x23: ffff0000065d1880 x22: 0000000000001085 x21: ffff0000065d1800
[    2.581781] x20: 00000000ffffffea x19: ffff800080eaa568 x18: 0000000000000000
[    2.581904] x17: 0000000000000000 x16: 00000000e820414d x15: ffff000006de1290
[    2.582027] x14: 00000000000002e0 x13: 0000000000000001 x12: 0000000000000001
[    2.582149] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff800081f73bc0
[    2.582281] x8 : ffff000006de1db0 x7 : 0000000000000001 x6 : 0000000000007a4f
[    2.582408] x5 : ffff0000054541e0 x4 : ffff000006de1200 x3 : ffff000006de5a00
[    2.582538] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000006de1200
[    2.582670] Call trace:
[    2.582715]  alg_test+0x490/0x5bc (P)
[    2.582782]  cryptomgr_test+0x24/0x44
[    2.582856]  kthread+0x140/0x220
[    2.582921]  ret_from_fork+0x10/0x20
[    2.582989] ---[ end trace 0000000000000000 ]---
[    2.620920] alg: skcipher: aspeed-ctr-aes encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
[    2.621176] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
[    2.621185] ------------[ cut here ]------------
[    2.621384] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
[    2.621420] WARNING: CPU: 0 PID: 117 at /usr/src/kernel/crypto/testmgr.c:5829 alg_test+0x490/0x5bc
[    2.621673] Modules linked in:
[    2.621738] CPU: 0 UID: 0 PID: 117 Comm: cryptomgr_test Tainted: G        W           6.18.3-v00.08.01-g172b7e27a30d #1 PREEMPT
[    2.621925] Tainted: [W]=WARN
[    2.621975] Hardware name: AST2700 EVB (DT)
[    2.622044] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.622153] pc : alg_test+0x490/0x5bc
[    2.622218] lr : alg_test+0x490/0x5bc
[    2.622283] sp : ffff800081f83d50
[    2.622337] x29: ffff800081f83df0 x28: 0000000000000004 x27: ffff800080eaa568
[    2.622458] x26: 0000000000000000 x25: 00000000ffffffff x24: 0000000000000004
[    2.622578] x23: ffff0000065d0e80 x22: 0000000000001085 x21: ffff0000065d0e00
[    2.622694] x20: 00000000ffffffea x19: ffff800080eaa568 x18: 000000000000000a
[    2.622811] x17: 32322d3d63722820 x16: 64656c6961662073 x15: 0000000000000000
[    2.622931] x14: 0000000000000000 x13: 00000000ffff0a01 x12: 00000000ffffffea
[    2.623061] x11: ffff800081f83ab8 x10: 00000000ffffefff x9 : ffff8000815ae3c8
[    2.623200] x8 : ffff8000815ae420 x7 : 0000000000017fe8 x6 : c0000000ffffefff
[    2.623325] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000000
[    2.623447] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000006de3600
[    2.623570] Call trace:
[    2.623625]  alg_test+0x490/0x5bc (P)
[    2.623690]  cryptomgr_test+0x24/0x44
[    2.623752]  kthread+0x140/0x220
[    2.623810]  ret_from_fork+0x10/0x20
[    2.623875] ---[ end trace 0000000000000000 ]---
[    2.653308] aspeed_mbox_client 431880000.mbox-bootmcu-1: TX shmem: phys 0x0x0000000431880000 size 1048576
[    2.653484] aspeed_mbox_client 431880000.mbox-bootmcu-1: RX shmem: phys 0x0x0000000431980000 size 1048576
[    2.653616] aspeed_mbox_client 431880000.mbox-bootmcu-1: TX timeout: 10000 ms


