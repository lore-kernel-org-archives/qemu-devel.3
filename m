Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Xz-00074J-BE; Tue, 07 Jul 2026 09:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wh5Xx-000741-Rx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:09:09 -0400
Received: from smtpout7.mo537.mail-out.ovh.net ([51.210.91.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wh5Xu-0008UP-O1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:09:09 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gvhPq1MYGz403F;
 Tue,  7 Jul 2026 13:09:03 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue,  7 Jul 2026 13:09:03 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.94])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gvhPp73WKz7tNN; Tue,  7 Jul 2026 13:09:02 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C91961923D2E; Tue,  7 Jul 2026 13:09:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0019bd950ee-9dd2-4f06-81cd-279a0974c22e,
 7260B8E4F09D2588E97168B383347FBEBF8FD1E0) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6a129e5a-1953-4655-b631-ee61125a1012@kaod.org>
Date: Tue, 7 Jul 2026 15:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] ast2600: yosemite4 functional test
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org, 
 Titus Rwantare <titusr@google.com>, Emmanuel Blot <eblot@meta.com>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>, philmd@mailo.com
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-3-alexander.hansen@9elements.com>
 <CAEr1sMs-Fwt_LbCU8KUnMRKgUaWuGrSX1EAz7KapXPGmSX4z6w@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAEr1sMs-Fwt_LbCU8KUnMRKgUaWuGrSX1EAz7KapXPGmSX4z6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18045642232318766091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFhYisB267om4oy6+t4RUYA/NaE5jnp95XeLdYvPI0Wkm0BMZ0PhYGNlyki97WcU//Y25wpcg0xTeTLnaiZFLnh+2kqBLZNfBmDij8sCwi225IM5p84agZn+gVsyp+kjIHBoW69VxPbaHA7R0F9WmKvO7UE9uozrbp5F1ej+DllLhOQPxH6ZhwwCo/p4IM2BzHw/O8ZUJPF5f/CrGRYryhZgHZrX7Z6f/oFIJpeqeLVamIrTDFFpZwjVPUNVJ219rHXEaI3a6ic8X7Fuilbr4GklMgOtg0kaBJ99PUIzRohQkpdEpFW4gDNuAcP4sAyJtiz+ESXeCEStPfYxtq54w6fMpSBWf4iTRZd3GTwYiXoGPhR+gX1/PkfbI2MXag3/1O3pu0wgsU6+RbX0diPDxDcZz0KGILjavZkaO9e+o2sj0pT/6pmiIu1z/wHSE9aBMnX8PVXwpbQd6Ra9QrdWeFUaKH/zqkVVT/q5MqnUZaGZymHMnl7THm0DPCYS2WJ7cdIfMBWCMRtq7ShHdQsO9KymtET2HhTgHT12BEM3aNy9RsdBPIpRapWyWGinsH+AJmTEXuM0NnE5nNLGzDFvIeJPSVsCBFmX02qTJMce2yMNVcRtEAuU+dVUqd+n/RFh9q2EK1EbU01QvJVzPrkRVtKopZfEicX8pdpp4N4rGcs7g
DKIM-Signature: a=rsa-sha256; bh=tQ0zIOirlFgCjC1joHE3kPPJ66A8hXB0Nb1v6XAtWMY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783429743; v=1;
 b=FiKfv/jC/qVUx05BzkoPSncFti9XDGUTlvFzV39RIjwg2+0gTPNhAQbeoxPViezt7CK7Iy/g
 Fvv9/3nBX+CD0pwV5LKSb/A7VDnTSclLBJSHxYJPejvS2tgyxgCpCBPguiJDr3GI0lFFfYTM8PX
 ILdC+tOjE1VERDYOdxRMKp7fSU5N/qGBRWymCbH0n/xyDv/Yn22J9kOJeL66B35zv7aiPDQDvn3
 6d4Wn4b+/ni9cqrl9gUUd9yx9IlDCPG8cwJi05+kqKOxZJoq6gusay7Mk7ndYn4hDDBbnM8QT7n
 USH3El85Z64B+QPrtU7o3zqJNc5frUgK5WPwOzGMgEK0w==
Received-SPF: pass client-ip=51.210.91.26; envelope-from=clg@kaod.org;
 helo=smtpout7.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello,

On 7/7/26 14:51, Alexander Hansen wrote:
> Hi Cedric,
> 
> sorry to ping, since the
> - (ast2600: yosemite4 initial support) and
> - (ast2600: yosemite4 functional test)
> 
> also work by themselves, would you consider those two as ready or is
> there something i need to fix there.

These 2 patches are fine AFAIR.

> Alternatively, do all patches of a series need to go in together?
> Would it help if I pushed those 2 again separately.

The Yosemite V4 machine is of limited interest without the sensor models
required by the board. For the current use case, a user might as well
use the ast2600-evb machine instead.

More broadly, we should avoid adding with machine types that offer little
functional differences. Each additional machine increases maintenance
burden, so new machines should provide capabilities that cannot already
be achieved with existing ones. That rationale has its limits, since devices
can also be created from the command line. However, I'm fine with adding
a standalone machine, provided it comes with the required device models and
functional tests.


I sent a few comments on the MAX* sensor models that should be addressed.
Before I take the series through the Aspeed queue, I'd greatly appreciate
an Ack from one of the sensor maintainers or a review from a developer
familiar with those models.

The same applies to the ADC128D818 model. It has already received a review.
The merge is primarily gated by the review of the test cases.

We have now reached the QEMU 11.1 soft freeze, so only bug fixes should be
merged from this point onward.

> 
> Thanks again for taking the time reviewing those patches :)

Let's make it happen in QEMU 11.2.

Thanks,

C.


> 
> Alexander
> 
> Am Fr., 19. Juni 2026 um 13:55 Uhr schrieb <alexander.hansen@9elements.com>:
>>
>> From: Alexander Hansen <alexander.hansen@9elements.com>
>>
>> Add a functional test for the Yosemite V4 (fby4-bmc) machine
>> that validates:
>> - U-Boot initialization and kernel boot sequence
>>
>> The test uses an OpenBMC image built for the yosemite4 board and
>> validates console output through the boot process.
>>
>> Cc: Emmanuel Blot <eblot@meta.com>
>> Cc: Titus Rwantare <titusr@google.com>
>> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
>> Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
>> Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
>> Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
>> Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
>> Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
>> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
>> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
>> ---
>>   tests/functional/arm/meson.build         |  2 ++
>>   tests/functional/arm/test_aspeed_fby4.py | 45 ++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>   create mode 100755 tests/functional/arm/test_aspeed_fby4.py
>>
>> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
>> index 61b00932db..19331b3f16 100644
>> --- a/tests/functional/arm/meson.build
>> +++ b/tests/functional/arm/meson.build
>> @@ -15,6 +15,7 @@ test_arm_timeouts = {
>>     'aspeed_anacapa' : 480,
>>     'aspeed_bletchley' : 480,
>>     'aspeed_catalina' : 480,
>> +  'aspeed_fby4': 480,
>>     'aspeed_gb200nvl_bmc' : 480,
>>     'aspeed_rainier' : 480,
>>     'bpim2u' : 500,
>> @@ -50,6 +51,7 @@ tests_arm_system_thorough = [
>>     'aspeed_anacapa',
>>     'aspeed_bletchley',
>>     'aspeed_catalina',
>> +  'aspeed_fby4',
>>     'aspeed_gb200nvl_bmc',
>>     'aspeed_rainier',
>>     'bpim2u',
>> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
>> new file mode 100755
>> index 0000000000..a521834f79
>> --- /dev/null
>> +++ b/tests/functional/arm/test_aspeed_fby4.py
>> @@ -0,0 +1,45 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots the ASPEED machines
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import Asset
>> +from qemu_test import wait_for_console_pattern
>> +from aspeed import AspeedTest
>> +
>> +
>> +class YosemiteV4Machine(AspeedTest):
>> +
>> +    ASSET_YOSEMITE_V4_FLASH = Asset(
>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
>> +        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')
>> +
>> +    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
>> +                                   cpu_id, soc):
>> +
>> +        self.set_machine(machine)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
>> +                         '-snapshot')
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
>> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
>> +        self.wait_for_console_pattern('Starting kernel ...')
>> +        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
>> +        self.wait_for_console_pattern(f'ASPEED {soc}')
>> +        self.wait_for_console_pattern('/init as init process')
>> +        # yosemite v4 does not emit the hostname log which is
>> +        # different from the other machines.
>> +        self.wait_for_console_pattern('yosemite4 login:')
>> +
>> +    def test_arm_ast2600_yosemitev4_openbmc(self):
>> +        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
>> +
>> +        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=image_path,
>> +                                        uboot='2019.04', cpu_id='0xf00',
>> +                                        soc='AST2600 rev A3')
>> +
>> +if __name__ == '__main__':
>> +    AspeedTest.main()
>> --
>> 2.54.0
>>


