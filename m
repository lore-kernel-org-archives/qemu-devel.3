Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1182DF4BB99
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCQV-0001sw-Co; Wed, 25 Feb 2026 05:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvCQP-0001r7-MK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:47:25 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvCQM-0000F7-HQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:47:25 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.134])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4fLWW82d1Tz5wwq;
 Wed, 25 Feb 2026 10:47:15 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 11:47:14 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0030806bb13-3f1a-433f-a07a-0adbc76e5069,
 C59C41ABD0014BFD9FF8970E1C3D3014408A4F94) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <e79610da-334b-40b8-bc67-dfb763c36312@kaod.org>
Date: Wed, 25 Feb 2026 11:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/22] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-22-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260225021158.1586584-22-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG12EX1.mxp5.local (172.16.2.121) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 57749d08-8643-4fcc-bae0-25f4a9ba6ac4
X-Ovh-Tracer-Id: 15218507569250012036
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEfTT7NCtKI3I+OP8VzUjzldjUFiHbxqIWo/nzf1KGDG5Lx7rKyrf9K1Dro6FcydyTP2WYj3oqrDOjdWoIoOGwrOFN+QU+LXQzMDPn5Chx21yRV6QNbRKvN5g2G/WxaNpPvhxkNWI4Jkxe4L5hjFy3/ad81XNJ59MZBFsg54gBKjEiT2uJM9DOYAFs7k1W97Wsp8oi+60o/NJulxX2u+EfaUgD/HhhbozGpyE/KFQfrd9DDaDLamrAYDgIPmPqc9KrX94znqq+n4jiBBcBBk+CfCqqDU8k77s7gF57j3z62jw2DuPb/+BGNfBlJw1Q1lLfJi/LyZGGsuvFJkDgpY2Rqa3zOsT1fDbYbmyyKUdEKiU+B1LSzC1RltofPIqCGU0yj2r4Qi7wO67uz1wkWDjZ5he+uhrZbJNq627pLjCUajOji0YLFERV/fZx3XfvOpjIz/MxUUx1jw5NspVRU4R/FLiWtMpUBRcRbVOLu0EtYleRS+MmgHMOT0u/dCpUw158ndjRCTl98ofSKlYaLzjF5H5Dbox1EiYjAiHisvVnSF04LONdb5trEsRwc7JX2rEVyhhbCsUHDYMzrUcMHX3kwP/xWRmTqH7rw9LpJaFIYlJbthKIKX9HpcyEnLKM7LnAPpzE0fE0xse6LSyMn+q1lvQ9cnvfUa5I0liF26EHIww
DKIM-Signature: a=rsa-sha256; bh=8GozfWXNi34NcWfS45YtvAy3sbP89wZrlv5I0Gs4s3k=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772016437; v=1;
 b=NF990/sri4EyfB0Sq3x474oF3UcM7GfR0bEErJgdQsiJkAGFNMRDpJctd9EushV+AVyyhWHP
 mE/skLMW06NXgEr1XkrxMYK1LCf1AvNUAVOiBrvYPjc/9R12CyfsGWSfpUOVTl8h+u9v5JouRXb
 lH4DaXPnjX91PNrhBprEH3ji2DQKiLRuNXVd5b+iZhOuu9Lwx11CXAJf54/EMLCEHIzDIMiPkJ/
 YzfrfY4DDFTOBGUhZsNEvmLm8IFXGzrzH06nVrHf2R8kRUUAON9N6XtyuOaDv/MnZ8LJqXmuzmJ
 cJxBloO/UAQwPhNdagzJfB/shMW6Rl7EbPM/ioYLrUxVw==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/25/26 03:12, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
> index 971fa3390d..46b9f7058c 100755
> --- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
> @@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):
>               'ip addr show dev eth4',
>               'inet 10.0.2.15/24')
>   
> +    def do_ast2600_i3c_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'
> +            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',
> +            'Success on message 0')
> +        exec_command_and_wait_for_pattern(self,
> +            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | xargs',
> +            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')
> +
>       def test_arm_ast2600_evb_sdk(self):
>           self.set_machine('ast2600-evb')
>           self.require_netdev('user')
> @@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):
>               'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
>           self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
>           self.vm.add_args('-netdev', 'user,id=net1')
> +        self.vm.add_args('-device',
> +            'mock-i3c-target,bus=dw.i3c.5,pid=0xab9078563412')
>           self.do_test_arm_aspeed_sdk_start(
>               self.scratch_file("ast2600-default", "image-bmc"))
>   
> @@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):
>           exec_command_and_wait_for_pattern(self,
>                '/sbin/hwclock -f /dev/rtc1', year)
>           self.do_ast2600_pcie_test()
> +        self.do_ast2600_i3c_test()
>   
>   
>   if __name__ == '__main__':



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



