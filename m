Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D0CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rKY-0006OU-LI; Wed, 01 Oct 2025 03:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3rKU-0006NH-Bk
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:51 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3rKK-0003xH-CT
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.165])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cc68834m5z6V80;
 Wed,  1 Oct 2025 07:32:24 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 1 Oct
 2025 09:32:23 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0010ed1f93f-d162-4d58-8294-20d146db9700,
 D9D4E9C7278927B1F3584C3B5B4DCE3027F8E762) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3e2c8210-9e99-438b-aa9b-13479d59f6c9@kaod.org>
Date: Wed, 1 Oct 2025 09:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251001064625.1058680-1-jamin_lin@aspeedtech.com>
 <20251001064625.1058680-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251001064625.1058680-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 491be42e-ca6c-4e18-bef9-e7bcf6e91bd1
X-Ovh-Tracer-Id: 15638749707240901423
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFHsoyT19AXg5MrYVxkXFyuf1d5s4g2ab0YH72gaNP8mxVoaO13u2nZRhv9V/aGXOpVFmmNP7PzcW2HAvho0FXUcji+gOL66fjXHmoBhRIN0g79Wuv34XOZ8YiHzTLsubq3sR5J5z58vHImZRGnBsL0DM29LfNxa/fOHtuif4GS0jK7lc+jq4psCOYmbg9057ri3qs65aHwez6uPx1gkK4D5mifA3YBwiqtYveFJ35pfRy7DnxMDpxA5IovhiWnBSe8DQ+kbnYl6pc7eNTZAGiyUdGOwJEy6OWqsJoCzHsBp6u+9oX7kPNdwvw+4f7tG2LylOdWsf5kxPlijYa6c25rIRjHnt2+GC2ulS3+xij1dObR38WW4NjiPpBFMFHN1/79bNZ7UgtHr8wcfmxNJoNY4AZtoseiKQe5qHKGhDDQ3g8129zXJnJCQTpFEFCTZCeEJXjqTZ+AVAE9+HsWg6RIO/+d49Qln0fWStLGfOaE1MLjCZ4CVfS3vEtDhr51xOevm4q4jGniMunrrocHzUPbZod09oQ8UyoIdGdOk1w4U7621PwWLJFbjFWilmC76jp2ECfS0m2Te+j8rkhTe7s9N5QkHFJd2GMt+PLTSmAAVi6w5qemADJUBLKcY6/bR+QF7aEE2cbHZB1hQHOBeq4SU1NzZb/4ndnvL/yke2VvQ
DKIM-Signature: a=rsa-sha256; bh=difMR18pWO4rh8BX/wSxiBSjQuqUkia5f6GmVbOeTKY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759303945; v=1;
 b=sVTWtY+cP9Xe2szB92lGQvvTYljsOj5vOeISECMjh3zjbLr1Q3pCycXWIiho1IK/9wvg/LDx
 6RnaHqzpnTqLDGqrnVjBW10yEje40p3zLsVN4edENYqyxJ7eupHku28GRrPBBB4oBnXm5pHHpuh
 ARfhU7KD7hQlpgZRwKVZhetik0gG8dBQ1j+tT6PvSwuqQw4iBzC+mxfiQe/SGt1xZoPMK5/xOw2
 jJuw21S40MLEDZWOEawiWtOErY4wLZx7eZ/BJUurlVdD+Ap09mrNa8ACkSZZjOXWeoliXWXXjPo
 TGGMU4J0mkdiieIhT049nwW1uNkAN990cPqucXYQg+x7A==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

On 10/1/25 08:46, Jamin Lin wrote:
> Introduce load_ast2700fc_coprocessor() to load the SSP/TSP ELF images
> via -device loader. Use this helper in start_ast2700fc_test() to remove
> duplicated code.

Ideally, this should be an extra patch. Minor.

> 
> Add start_ast2700fc_test_vbootrom() which boots the ast2700fc machine
> with -bios ast27x0_bootrom.bin and reuses the coprocessor loader.
> 
> Add test_aarch64_ast2700fc_sdk_vbootrom_v09_06() to test the vbootrom
> with ast2700fc machine.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../aarch64/test_aspeed_ast2700fc.py          | 37 ++++++++++++++-----
>   1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index 28b66614d9..c0458e47b2 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -83,6 +83,17 @@ def do_ast2700fc_tsp_test(self):
>           exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
>                                             '[72c02000] 06010103')
>   
> +    def load_ast2700fc_coprocessor(self, name):
> +        load_elf_list = {
> +            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
> +            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
> +        }
> +
> +        for cpu_num, key in enumerate(load_elf_list, start=4):
> +            file = load_elf_list[key]
> +            self.vm.add_args('-device',
> +                             f'loader,file={file},cpu-num={cpu_num}')
> +
>       def start_ast2700fc_test(self, name):
>           ca35_core = 4
>           uboot_size = os.path.getsize(self.scratch_file(name,
> @@ -120,16 +131,13 @@ def start_ast2700fc_test(self, name):
>               self.vm.add_args('-device',
>                                f'loader,addr=0x430000000,cpu-num={i}')
>   
> -        load_elf_list = {
> -            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
> -            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
> -        }
> -
> -        for cpu_num, key in enumerate(load_elf_list, start=4):
> -            file = load_elf_list[key]
> -            self.vm.add_args('-device',
> -                             f'loader,file={file},cpu-num={cpu_num}')
> +        self.load_ast2700fc_coprocessor(name)
> +        self.do_test_aarch64_aspeed_sdk_start(
> +                self.scratch_file(name, 'image-bmc'))
>   
> +    def start_ast2700fc_test_vbootrom(self, name):
> +        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
> +        self.load_ast2700fc_coprocessor(name)
>           self.do_test_aarch64_aspeed_sdk_start(
>                   self.scratch_file(name, 'image-bmc'))
>   
> @@ -144,5 +152,16 @@ def test_aarch64_ast2700fc_sdk_v09_06(self):
>           self.do_ast2700fc_ssp_test()
>           self.do_ast2700fc_tsp_test()
>   
> +    def test_aarch64_ast2700fc_sdk_vbootrom_v09_06(self):
> +        self.set_machine('ast2700fc')
> +
> +        self.archive_extract(self.ASSET_SDK_V906_AST2700)

Could we update all tests to use the latest SDK v09.08 [1] which
was released ?

Thanks,

C.

[1]  https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.08ed

> +        self.start_ast2700fc_test_vbootrom('ast2700-default')
> +        self.verify_openbmc_boot_and_login('ast2700-default')
> +        self.do_ast2700_i2c_test()
> +        self.do_ast2700_pcie_test()
> +        self.do_ast2700fc_ssp_test()
> +        self.do_ast2700fc_tsp_test()
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()


