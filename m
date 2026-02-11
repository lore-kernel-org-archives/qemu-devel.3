Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F16E9E308
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqAS7-00049r-0k; Wed, 11 Feb 2026 08:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vqAS5-00049Q-8R
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:40:21 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vqARz-0000cU-Ve
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:40:20 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.134])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4fB0174RLfz5ynv;
 Wed, 11 Feb 2026 13:40:11 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 14:40:10 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007b554fb87-63bf-4a2d-b794-acd0cdb9ee66,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <93629d7d-8e27-4121-a9ba-cc6361020830@kaod.org>
Date: Wed, 11 Feb 2026 14:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] tests/functional/arm/test_aspeed_ast2600_sdk:
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
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <20260210091018.1553489-22-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260210091018.1553489-22-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG15EX1.mxp5.local (172.16.2.151) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f8c306dd-4f8f-4162-87ff-f1eb35fd3d91
X-Ovh-Tracer-Id: 9708353422013467521
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEiMAhRmgMqBxjbBhtXP85BmkBWrf2Z4upWkkpfOKcEDmkx6jYQOSPTq7WQYXmwRjT6fpy6DGGHqnhIBTr2zfLwhNmOyIhcaCW1fjYW9VXtnYrumyfAD4LyBWgDgzzBR32eX06kIu6Zh6E+Q/Sh92bHseknKOjV4rMWaH3ASdFuZVGnc553F+1OQoVkhZy6Pf8OXIzW+MLqXm+eCbEmKvLpGBjDbXi5xBevUDgnAqOZgzw+btr2ef7BSrWnVE6HT1oLkhb8EhdptEcecc+shPySY+yy8hc9K5y6dth83yFldeWjbjJNPf9F54Oup+5nBTVXtd/j8Pxz4lHQ1pzmbp4PN650WUTZfqTmAxwCNrK3w3Wbb0BYZB4s5HOVdyGLYzw5Wpxik0Hoe1YA44Kb/tpIK70K8ciD8tGVDukL8XwPwmBxAIGPCUvvbQu/v6/3ZBSF6C5j4nxKeT1xGxYuEsr53EuevZiegRjYefGYXscJIFLL5CnYLnJwmO6+g+GCDL0HHwogn39UGsW0KC2sNNC/N+WbIRJ5TnD+oUumycBOG/dGppdvxElTboO13tQJ/48eJKRmRlkI9hdsGHO5iUjdJwDDAzTbUsawwnmjz1qnMVqV+B8Sth7o5p4dM6M9j366esKkdyPdMVBTfHwm08KKBIlgSt4UIXre7g0+kMFvww
DKIM-Signature: a=rsa-sha256; bh=RR4siVaqlJXEHXdf3ATJamn4gePCw4XHPAbeHA4p+zg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770817212; v=1;
 b=Qc8pTIuhF54UwHn1lQXRlaBEcrcuI6XI8jTrego+txxvkK2an0Y6FgzddUwtQgBCkDFJQ15J
 epLeWVPmUzzJ4TlwYU9T2s8jkt6B85wN2xuTenJ/OfjdlIPqqxrjNZmVi6I/nIxOGDKQeHIri92
 qqr89Pc8YI1KTzuAbDP8r1ni0IQn9EqrjHIPxmt4uabVRU8tm8yJATcrouKFGW9AUTxWEHqIT7Z
 EJTML9ARA+/uL8IUZWzlfi/FwK6dc3gZomAs7uHk/WeeJz+5Oq7Bge46koyUvPlDi768GWVolmj
 bnFLuMcpCfa91tgsYxUe8qx17dvpY3eoLfGRgiieWEAgQ==
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

On 2/10/26 10:10, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
> index 6236aeb11c..3485feaf2c 100755
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
>       def test_arm_ast2600_otp_blockdev_device(self):
>           self.vm.set_machine("ast2600-evb")

I am seeing these errors from Linux :

2026-02-10 16:50:20,812: [    5.080168] i3c i3c-0: xfer error: 4
2026-02-10 16:50:20,818: [    5.083648] i3c i3c-0: xfer error: 4
2026-02-10 16:50:20,818: [    5.085817] i3c i3c-0: xfer error: 4
2026-02-10 16:50:20,818: [    5.086369] i3c i3c-0: xfer error: 4
2026-02-10 16:50:20,870: [    5.127257] i3c i3c-1: xfer error: 4
2026-02-10 16:50:20,873: [    5.130879] i3c i3c-1: xfer error: 4
2026-02-10 16:50:20,874: [    5.131253] i3c i3c-1: xfer error: 4
2026-02-10 16:50:20,874: [    5.131527] i3c i3c-1: xfer error: 4
2026-02-10 16:50:20,909: [    5.162790] i3c i3c-2: xfer error: 4
2026-02-10 16:50:20,913: [    5.163488] i3c i3c-2: xfer error: 4
2026-02-10 16:50:20,949: [    5.195396] i3c i3c-3: xfer error: 4
2026-02-10 16:50:20,952: [    5.196101] i3c i3c-3: xfer error: 4
2026-02-10 16:50:21,018: [    5.253398] i3c i3c-5: xfer error: 4
2026-02-10 16:50:21,042: [    5.269565] i3c i3c-0: xfer error: 9
2026-02-10 16:50:21,043: [    5.273845] i3c-mux-imx3102 0-4cc31020000: No ownership
2026-02-10 16:50:21,049: [    5.276017] i3c i3c-1: xfer error: 9
2026-02-10 16:50:21,049: [    5.278757] i3c-mux-imx3102 1-4cc31020000: No ownership

Is that expected ?

Thanks,

C.



