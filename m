Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B227ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wdk-0003dB-Eu; Wed, 08 Oct 2025 12:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v6Wdi-0003cO-Py
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:03:42 -0400
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v6WdB-0002Ue-2u
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:03:41 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.79])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4chd7w6b27z6VW6;
 Wed,  8 Oct 2025 16:02:52 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 8 Oct
 2025 18:02:52 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003767c6409-4e2a-4507-9ada-ae17834000b7,
 8C34243C2A945F502B3A5846113D703BCD413F3E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2661ec69-dc78-4bfb-bd5e-9d70a5e5329d@kaod.org>
Date: Wed, 8 Oct 2025 18:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] test/functional/aarch64: Split the ast2700a1-evb
 OpenBMC boot test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
References: <20251007141604.761686-1-clg@redhat.com>
 <20251007141604.761686-6-clg@redhat.com>
 <7c84108d-6fe1-496b-92a6-e13469c32397@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <7c84108d-6fe1-496b-92a6-e13469c32397@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 46921f09-b25d-4419-950e-59e178d5a972
X-Ovh-Tracer-Id: 10028390470685592498
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF5lXJRLojDuNhKbfH0F7pnbeNfQORZmv+bXbZnW0leZNobbXQitWGJvz3p+vhTyXeW/2WlJ/NLHKx6wq7ks1Ww35uA1d1ANFCimwL0INyHaTQTJfhLsrU6hl989tfZPvXwwGHSn3zRDDMUprrslkm5zy3nHtSwa41n2E91uXI4KBTgTKwqDKNyFItp7xhZ6tmqzhuXm4pmbFJWWdBZolALGntS1qRzAaJ9Z90WfT3rjfsg9gl8Cu35bdME2Mc8ckz3ODRykLhL2jRZEj0fkuQWU3YBDFZ3sSoZCXOVBC8fmX8nuQb92rPFfA+8Lto4ip36U/mU6sR6234x/3YsDg5lkWp7wXG5bqgYOOqP6B8j/MR4KjPdYiA8C0p7OGnnW1Zdlya8pqHi7raXldULdL+r9R+ZiI/qbQa6swBF7CfFaagNy+UqsZCaTn3IPexuHNqlxtAnuu1C1JHr3r3DJT/Onv0Oz/WOQSTl52pyO/94EvpKaDPzO0QKkavMFWFCn76cs578xzqZApHkEIfMMzcQevlZ36C1EbXVnHEkL4cvUOlia5JbwktjjX6SinWVSGNIbx/Ezhlzu7cuTVyOS6OFvPCIXNPSg2Z33uW3hptR9BgSwGsOCeSAwualCAY2q4vtCE5ZV16GurGXNxujJ9zuV/G7IqSaqQT205CyhVTdLg
DKIM-Signature: a=rsa-sha256; bh=T3xh2F7N4OTTzwRY5U+BCknq37fPDaykgL1u7FtIdEQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759939374; v=1;
 b=ZpPV1Ak9Xgh4qvjzHdcfwcWfKXE3ErShSsvsGIulpJU2pWI12ml/OgcycFjXOwvQEfjvFzCS
 jwcN5b21DS/5mggsdVnQZkhYskASPOAPhP1BEe/fhX/IG4OsMjV8weBxBjlrONY9k0/PVQmwwH2
 IHeNeBieyZ5SqUUnyxYJAHXPVGfmSfi2gsWRPWr2V6U7VI18uLkboUZBEzB6CFsYcIymPTFwGXo
 z1JrLLI528w4okSwzfFFoGBGzcVGuKGdgeBrsW6j+FjUhTY8NpOZtaXg2CSYizW6VhclpFq8Yx+
 AMR4jHMar70e8XUpeoHDrRQ3Ui5uQfelvXXfRbT6Pf4og==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
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

On 10/8/25 08:38, Thomas Huth wrote:
> On 07/10/2025 16.16, Cédric Le Goater wrote:
>> The 'ast2700a1-evb' machine has two functional tests: one loading
>> firmware components into memory and another using a vbootrom
>> image. Both tests perform a full OpenBMC boot and run checks on I2C
>> and PCIe devices, which is redundant and time-consuming.
>>
>> To save CI resources, the vbootrom test is refactored to focus on the
>> firmware boot process only. The OpenBMC boot verification logic is
>> split and a new verify_openbmc_boot_start() helper is introduced to
>> only wait for the kernel to start.
>>
>> The vbootrom test now uses this function and the less essential I2C
>> and PCIe checks have been removed from this test case.
>>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/aarch64/test_aspeed_ast2700.py | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
>> index a60dc1259f69..32c971e13528 100755
>> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
>> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
>> @@ -37,11 +37,14 @@ def verify_vbootrom_firmware_flow(self):
>>           wait_for_console_pattern(self, 'done')
>>           wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
>> -    def verify_openbmc_boot_and_login(self, name):
>> +    def verify_openbmc_boot_start(self):
>>           wait_for_console_pattern(self, 'U-Boot 2023.10')
>>           wait_for_console_pattern(self, '## Loading kernel from FIT Image')
>>           wait_for_console_pattern(self, 'Starting kernel ...')
> 
> The patch is a good idea ... but I'd maybe wait 'til the kernel really has been started, i.e. by waiting for it's initial output like "Linux version 6.6.93" ?

Sure.

I changed the wait pattern from 'Starting kernel ...' to 'Linux version '
without specifying the Linux kernel version since a change would be
needed whenever the SDK images are updated.

> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>


Thanks,

C.


> 
> 
>> +    def verify_openbmc_boot_and_login(self, name):
>> +        self.verify_openbmc_boot_start()
>> +
>>           wait_for_console_pattern(self, f'{name} login:')
>>           exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>>           exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
>> @@ -141,9 +144,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
>>           self.vm.add_args('-netdev', 'user,id=net1')
>>           self.start_ast2700_test_vbootrom('ast2700-default')
>>           self.verify_vbootrom_firmware_flow()
>> -        self.verify_openbmc_boot_and_login('ast2700-default')
>> -        self.do_ast2700_i2c_test()
>> -        self.do_ast2700_pcie_test()
>> +        self.verify_openbmc_boot_start()
>>   if __name__ == '__main__':
>>       QemuSystemTest.main()
> 


