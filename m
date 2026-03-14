Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1EC10706DC
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 13:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1PHY-00053X-LZ; Sat, 14 Mar 2026 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w1PHU-00053J-7Z; Sat, 14 Mar 2026 09:43:52 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w1PHQ-0002kb-2u; Sat, 14 Mar 2026 09:43:51 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAXbdAMZrVpHXbWAA--.58520S2;
 Sat, 14 Mar 2026 21:43:40 +0800 (CST)
Received: from [192.168.31.181] (unknown [113.246.119.146])
 by mail (Coremail) with SMTP id AQAAf8DwJpQKZrVpIG8BAA--.5684S2;
 Sat, 14 Mar 2026 21:43:39 +0800 (CST)
Message-ID: <f0307563-237c-45b1-8563-4a783e304d9b@phytium.com.cn>
Date: Sat, 14 Mar 2026 21:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] tests/qtest: Add qtest-attrs-test for memory access
 with attrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
 <20260311154934.1575429-3-tangtao1634@phytium.com.cn>
 <CAFEAcA938c9iwZ9oMfd9b_X840PvWFPExmWUxArYssotosDWGg@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA938c9iwZ9oMfd9b_X840PvWFPExmWUxArYssotosDWGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwJpQKZrVpIG8BAA--.5684S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWm0ZHkAQwAEsN
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWDKF4rZF17uF1fJr15twb_yoW7XFykpa
 yrAFn0kr48tF1xJ34fXa1UWF1SyrZ7C3WUGr9aqr1xCFs8CrnrKF12kr1YgrnxXr4vqr18
 u3Wqvr9xWrn5taDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter,

On 3/13/2026 3:23 AM, Peter Maydell wrote:
> On Wed, 11 Mar 2026 at 15:50, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> Add qtest-attrs-test to exercise qtest memory commands with optional attrs
>> on aarch64 (virt, secure=on) and x86 (pc, tcg).
>>
>> The test covers:
>> - ARM (virt machine): exercises all supported ARM security spaces
>>    (non-secure, secure, root, realm).
>> - x86 (pc machine): exercises secure attrs accesses
>>    (SMM address-space path).
>>
>> The test also covers libqtest-single *_attrs shortcut wrappers and
>> verifies that space=non-secure behaves like omitting attrs.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/meson.build        |   4 +-
>>   tests/qtest/qtest-attrs-test.c | 234 +++++++++++++++++++++++++++++++++
>>   2 files changed, 237 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/qtest-attrs-test.c
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index be4fa627b5..c11759e23f 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -115,6 +115,7 @@ qtests_i386 = \
>>      'drive_del-test',
>>      'cpu-plug-test',
>>      'migration-test',
>> +   'qtest-attrs-test',
>>     ]
>>
>>   if dbus_display and config_all_devices.has_key('CONFIG_VGA')
>> @@ -270,7 +271,8 @@ qtests_aarch64 = \
>>     ['arm-cpu-features',
>>      'numa-test',
>>      'boot-serial-test',
>> -   'migration-test']
>> +   'migration-test',
>> +   'qtest-attrs-test']
>>
>>   qtests_s390x = \
>>     qtests_filter + \
>> diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
>> new file mode 100644
>> index 0000000000..ce204c2c95
>> --- /dev/null
>> +++ b/tests/qtest/qtest-attrs-test.c
>> @@ -0,0 +1,234 @@
>> +/*
>> + * QTest for memory access with transaction attributes
>> + *
>> + * Verify optional attrs argument support for qtest memory commands.
>> + *
>> + * Copyright (c) 2026 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "libqtest-single.h"
>> +
>> +/*
>> + * Default RAM size is 128 MiB on both machines used below.
>> + * Keep test addresses in low RAM and away from device MMIO regions.
>> + */
>> +#define TEST_ADDR_OFFSET    0x1000ULL
>> +#define TEST_ARM_BASE       0x40000000ULL
>> +#define TEST_X86_BASE       0x0ULL
>> +
>> +#define TEST_ADDR_ARM       (TEST_ARM_BASE + TEST_ADDR_OFFSET)
>> +#define TEST_ADDR_X86       (TEST_X86_BASE + TEST_ADDR_OFFSET)
>> +
>> +#define ARM_MACHINE_ARGS    "-machine virt,secure=on -cpu cortex-a57"
>> +#define X86_MACHINE_ARGS    "-machine pc -accel tcg"
> You start a virt machine with secure=on, but you are only
> testing the RAM, which is mapped regardless of the security
> space, so this will not notice any bugs where we don't actually
> access with the correct attributes.
>
> It would be more interesting to look at the secure-only
> RAM (which is at 0x0e00_0000), which should only be accessible
> via the secure or root spaces. (I'm not sure what qtest will
> do for attempted access via non-secure and realm, where the
> address will have nothing mapped there. You'll have to check.)



I just tested the secure-only RAM path as you suggested. For accesses 
from the non-secure side, I now see:

   "Invalid read/write at addr 0xE000000, size 1, region '(null)', 
reason: rejected"

which is consistent with the secure-only RAM not being mapped in the 
non-secure address space. So I agree that this is a much better target 
for validating whether the requested attrs are actually being used.


While testing this, I also found another bug in the qtest implementation:
qtest_read/write_sized() currently ignore the MemTxResult returned by 
address_space_read/write, so access failures are effectively handled 
silently. That is not correct. For failed reads/writes, qtest should 
return a non-OK response so the failure can be asserted properly in 
qtest_rsp_args() instead of being treated as success.

I'll fix this in v3 as well.


>
> I don't know if the x86 PC machine has a similar bit of RAM
> or whatever that behaves differently for secure and non-secure
> accesses.


Unlike the Arm virt case, where secure=on gives a very clear secure-only 
RAM target, the x86 side seems less straightforward to me too.

 From the current x86 code, it looks like the normal and SMM address 
spaces are both created ( tcg_cpu_realizefn in 
target/i386/tcg/system/tcg-cpu.c ), with the SMM view built by 
overlaying /machine/smram on top of the normal memory 
view(tcg_cpu_machine_done in target/i386/tcg/system/tcg-cpu.c).

I also looked into the x86 code to see whether there is an obvious 
SMM-specific MemoryRegion that would make a good test target, and I 
found some SMM-related logic in hw/pci-host/q35.c ( such as function 
mch_* ), but that path is complex enough that I am not confident I fully 
understand the intended testing model.

Would it make sense to ask x86 experts what the best way is to test this 
on the PC machine?


>
> thanks
> -- PMM


Thanks for the review,

Tao


