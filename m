Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E47EE2082
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIoa-00064U-2t; Fri, 06 Feb 2026 05:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1voIoY-00063b-9a
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:11:50 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1voIoV-0004hI-FQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:11:50 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.14])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f6qcw0lrtz5w9n;
 Fri,  6 Feb 2026 10:11:44 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 11:11:43 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S00792e33514-f3f5-4495-af40-08cdb21997a3,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <83d409cf-868c-4a2d-b1c9-5741d3e36adc@kaod.org>
Date: Fri, 6 Feb 2026 11:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, Thomas Huth
 <thuth@redhat.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 72e46bae-b22c-40fe-8812-6f6a3cabb895
X-Ovh-Tracer-Id: 13717682991313816449
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF1mFPgXm+NtGYLZB9gVLv25LR/l74hJ0sDMLHwIvotgoODHY6KO5ew+iTubItFLHl5iYR9Lyv82GKr5ZJ6Rohrhom18Tuvgfe8RJTs/XnOoqA8rgK88HG3kPuOtnLDu1O3dJt1FTd2eFdU6fsfqC+VHW3l0rsFCygzxa/7qNTB0f1nHz8mvaHzOSop9DO9W45B+7XD3VDL8lUBBGMt4qz2Ap4ocZpAJzfmiL2JT3kv36FUy1q1m36QA7CdudaeBM1+1/OzPzcr4O20/jSFrHDXCpxNL6lou2z/BxRaFbTC4XaTAC7Q2OSWi1HB7QpkTgoHnsq3bX3bj39kKb2n0isweGPt9A4gmY2NYI29ECUVU7zOyePnppbXfCnQZE5675OELM9VHVFL5LlvyDY8hC7lMiAGEhVFIXsm9vR36JrZaB2vhv7FjXJP2jn87PY5kjE5jOtM7omFj6zBNStdxl5I3qGl729edUPRBmKBwNHszGjQ8wF7heq6GqGS7ArIY8nD2cRbTFeZo1S38bM4WhSX+Zl/B7nf/i4dDqBu/onj/FPYj8YtZ9hl7YQUnosaIh2fsKgxh+THda8ZUs84/2+Y2RqFqvg4Yr6qkIiHTdHK/sV/VXRYdaEmw2ruRoL7lJAVj7dDmAqywA7csHCKQR9X8A1iqVhFc5G4gUz2a2xM2A
DKIM-Signature: a=rsa-sha256; bh=NHMGinZmgzaFJ0uGvON0ID6jTUHoLYa+nT4I0qY38AI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770372704; v=1;
 b=RxbIx7YGfEvxayvlY/z+9wXZ5ulVQ13ZPXMha9YQh1BuK04/hXWLat0ZYm3459veJm7uVV2G
 N14PnWXx3+woxeEALV3EwxvqCIXgWvbesGYK54Kaef0SKZza8EDyPT/7oVF8x5X11QDyTn//1NV
 5jY1qwT+gT/9WlvS5r1A8Qn0/nRQfEmgup9Cg9W0c4/WCN7zw+xc6bUvQf3lcQH7HcKtLK1aClr
 R994zHeuItuN1mNtPoxsHxzp5if0Xqs/Aj4lc9+H1n8vr+YAYOkASZpEztjnQdqDqlUA/LkeMlk
 elcnQyV+yjfxypIEw51cyG3K8tbIIwSyNq2USzlIKIU7w==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
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

+ Thomas

On 2/6/26 06:33, Jamin Lin wrote:
> Add functional coverage for the AST2700 A2 EVB machine by introducing
> test cases that boot and validate an OpenBMC SDK v11.00 image on
> "ast2700a2-evb".

I wonder if we need to test both machines. The test is already quite long.

On my test system :

   qemu:func-aarch64-aspeed_ast2700             OK              119.68s   3 subtests passed

With both machines :

   qemu:func-aarch64-aspeed_ast2700             OK              219.79s   6 subtests passed

Thanks,

C.


> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   .../functional/aarch64/test_aspeed_ast2700.py | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index 61373ffe5b..68e930ab72 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -86,6 +86,14 @@ def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
>               'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-a1-dcscm-obmc.tar.gz',
>               '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f')
>   
> +    ASSET_SDK_V1100_AST2700A2 = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
> +            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
> +
> +    ASSET_SDK_V1100_AST2700A2_DCSCM = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-dcscm-obmc.tar.gz',
> +            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0')
> +
>       def do_ast2700_i2c_test(self, bus_id):
>           bus_str = str(bus_id)
>           exec_command_and_wait_for_pattern(self,
> @@ -159,6 +167,18 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):
>           self.do_ast2700_i2c_test(1)
>           self.do_ast2700_pcie_test()
>   
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
>       def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
>           self.set_machine('ast2700a1-evb')
>           self.require_netdev('user')
> @@ -170,6 +190,17 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):
>           self.verify_vbootrom_firmware_flow()
>           self.verify_openbmc_boot_start()
>   
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
>       def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):
>           self.set_machine('ast2700a1-evb')
>           self.require_netdev('user')
> @@ -183,5 +214,18 @@ def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):
>           self.do_ast2700_i2c_test(8)
>           self.do_ast2700_i2c_test(16)
>   
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
>   if __name__ == '__main__':
>       QemuSystemTest.main()


