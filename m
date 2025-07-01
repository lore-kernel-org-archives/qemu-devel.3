Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB6C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 18:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWfOC-0005Gd-0u; Tue, 01 Jul 2025 14:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uWfNv-0005Da-Lu; Tue, 01 Jul 2025 14:07:12 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uWfNs-0001CO-4n; Tue, 01 Jul 2025 14:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1751393214;
 bh=oB1HQ5jW4y+GgS9JNmJHGhEh83gN5kSHOE+88EYEWAY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lBW1ociAkhEpE//nks2TsVtHEPVpk8nqknMYIONyfcz7XQUMAtQuNlQKq8JA2fG5v
 KSoN956H3Fx1SpCXB1u1bArtMJZGBd80jMmAIUDOkvHDTriCqSu9Vi06orhhBU0hbw
 YIx9hlbfcycWmCWVVk9J4bBqNnCAeWVbeB3xEEXXhbNJ3XShWxMph9PGZamQZGwn6t
 Lwk1BJ3p+l6DtT8ktc//h3Y/Qt4adnYqI4zxfhsaaoC435RNUC1rZCjjYltWLu4197
 TKeWI1NQ0weaaHBkxgnUUoWIcldlrl4RlIy7+CykNV+HoWhzL75dQ5xZqny657T8Fx
 qZP1Zdrb4O6Lw==
Received: from [192.168.0.215] (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id E9EA24E6;
 Wed,  2 Jul 2025 02:06:49 +0800 (CST)
Message-ID: <374597a7-94e4-45b2-9617-35183db3ea9d@sean.taipei>
Date: Tue, 1 Jul 2025 14:06:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] MAINTAINERS: fix paths for relocated files
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Sean Wei <me@sean.taipei>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.02@sean.taipei>
 <ff8a559e-f1d7-45a8-a292-20c9ab697646@redhat.com>
Content-Language: en-US
From: Sean Wei <me@sean.taipei>
In-Reply-To: <ff8a559e-f1d7-45a8-a292-20c9ab697646@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/7/1 1:24 PM, Thomas Huth wrote:
> On 16/06/2025 17.48, Sean Wei wrote:
>> Several files were renamed in previous commits, causing their entries
>> in MAINTAINERS to reference outdated paths.
>> This prevents scripts/get_maintainer.pl from correctly matching
>> these files to their maintainers.
>>
>> Update the filenames to reflect their current locations so that
>> maintainer lookup works properly.
>>
>> Related commits
>> ---------------
>>
>>    c45460decbd (Oct 2023)
>>      hw/input/stellaris_input: Rename to stellaris_gamepad
>>      Rename  include/hw/input/{gamepad.h => stellaris_gamepad.h}
>>
>>    4faf359accb (Nov 2020)
>>      docs: Move virtio-net-failover.rst into the system manual
>>      Rename  docs/{ => system}/virtio-net-failover.rst
>>
>>    89857312f32 (Apr 2024)
>>      hw/usb: move stubs out of stubs/
>>      Rename  stubs/usb-dev-stub.c => hw/usb/bus-stub.c
>>
>>    f2604d8508a (Apr 2024)
>>      hw/virtio: move stubs out of stubs/
>>      Rename  stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c
>>
>>    2c888febdfa (Apr 2024)
>>      memory-device: move stubs out of stubs/
>>      Rename  stubs/memory_device.c => hw/mem/memory-device-stubs.c
>>
>>    d481cec7565 (Oct 2024)
>>      migration: Move cpu-throttle.c from system to migration
>>      Rename  {system => migration}/cpu-throttle.c
>>
>>    864a3fa4392 (Jan 2023)
>>      monitor: Rename misc.c to hmp-target.c
>>      Rename  monitor/{misc.c => hmp-target.c}
>>
>> Signed-off-by: Sean Wei <me@sean.taipei>
>> ---
>>   MAINTAINERS | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fed8619874..0477e124d1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1002,7 +1002,7 @@ L: qemu-arm@nongnu.org
>>   S: Odd Fixes
>>   F: hw/*/stellaris*
>>   F: hw/display/ssd03*
>> -F: include/hw/input/gamepad.h
>> +F: include/hw/input/stellaris_gamepad.h
>>   F: include/hw/timer/stellaris-gptm.h
>>   F: docs/system/arm/stellaris.rst
>>   F: tests/functional/test_arm_stellaris.py
>> @@ -2163,7 +2163,7 @@ F: hw/net/
>>   F: include/hw/net/
>>   F: tests/qtest/virtio-net-test.c
>>   F: tests/functional/test_info_usernet.py
>> -F: docs/virtio-net-failover.rst
>> +F: docs/system/virtio-net-failover.rst
>>   T: git https://github.com/jasowang/qemu.git net
>>   Parallel NOR Flash devices
>> @@ -2214,7 +2214,7 @@ F: tests/qtest/sdhci-test.c
>>   USB
>>   S: Orphan
>>   F: hw/usb/*
>> -F: stubs/usb-dev-stub.c
>> +F: hw/usb/bus-stub.c
> 
> I think we could simply drop this line now completely since it is 
> already covered by the previous hw/usb/* wildcard line.
> 
>>   F: tests/qtest/usb-*-test.c
>>   F: docs/system/devices/usb.rst
>>   F: include/hw/usb.h
>> @@ -2469,7 +2469,7 @@ F: hw/s390x/virtio-ccw-md.h
>>   F: hw/s390x/virtio-ccw-md-stubs.c
>>   F: hw/virtio/virtio-md-pci.c
>>   F: include/hw/virtio/virtio-md-pci.h
>> -F: stubs/virtio-md-pci.c
>> +F: hw/virtio/virtio-md-stubs.c
> 
> Could be merged with the hw/virtio/virtio-md-pci.c line by turning it into:
> 
> F: hw/virtio/virtio-md-*.c
> 
>>   virtio-mem
>>   M: David Hildenbrand <david@redhat.com>
>> @@ -3187,7 +3187,7 @@ F: hw/mem/pc-dimm.c
>>   F: include/hw/mem/memory-device.h
>>   F: include/hw/mem/nvdimm.h
>>   F: include/hw/mem/pc-dimm.h
>> -F: stubs/memory_device.c
>> +F: hw/mem/memory-device-stubs.c
> 
> This could be merged with the preceeding "hw/mem/memory-device.c" line, 
> too, by turning it into:
> 
> F: hw/mem/memory-device*.c
> 
>   Thomas
> 


Hi Thomas,

Oh yeah, those suggestions makes sense to me, and make this patch much 
better!

Should I send a PATCH v2 to the mailing list, or just attach the fix-up 
like this is enough?
I've also reviewed other files and no other improvement found.

Best wishes,
Sean Wei

---

Several files were renamed in previous commits, causing their entries
in MAINTAINERS to reference outdated paths.
This prevents scripts/get_maintainer.pl from correctly matching
these files to their maintainers.

Update the filenames to reflect their current locations so that
maintainer lookup works properly.

Related commits
---------------

   c45460decbd (Oct 2023)
     hw/input/stellaris_input: Rename to stellaris_gamepad
     Rename  include/hw/input/{gamepad.h => stellaris_gamepad.h}

   4faf359accb (Nov 2020)
     docs: Move virtio-net-failover.rst into the system manual
     Rename  docs/{ => system}/virtio-net-failover.rst

   89857312f32 (Apr 2024)
     hw/usb: move stubs out of stubs/
     Rename  stubs/usb-dev-stub.c => hw/usb/bus-stub.c

   f2604d8508a (Apr 2024)
     hw/virtio: move stubs out of stubs/
     Rename  stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c

   2c888febdfa (Apr 2024)
     memory-device: move stubs out of stubs/
     Rename  stubs/memory_device.c => hw/mem/memory-device-stubs.c

   d481cec7565 (Oct 2024)
     migration: Move cpu-throttle.c from system to migration
     Rename  {system => migration}/cpu-throttle.c

   864a3fa4392 (Jan 2023)
     monitor: Rename misc.c to hmp-target.c
     Rename  monitor/{misc.c => hmp-target.c}

Signed-off-by: Sean Wei <me@sean.taipei>
---
  MAINTAINERS | 15 ++++++---------
  1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7f321597f..d855cb1491 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1005,7 +1005,7 @@ L: qemu-arm@nongnu.org
  S: Odd Fixes
  F: hw/*/stellaris*
  F: hw/display/ssd03*
-F: include/hw/input/gamepad.h
+F: include/hw/input/stellaris_gamepad.h
  F: include/hw/timer/stellaris-gptm.h
  F: docs/system/arm/stellaris.rst
  F: tests/functional/test_arm_stellaris.py
@@ -2171,7 +2171,7 @@ F: hw/net/
  F: include/hw/net/
  F: tests/qtest/virtio-net-test.c
  F: tests/functional/test_info_usernet.py
-F: docs/virtio-net-failover.rst
+F: docs/system/virtio-net-failover.rst
  T: git https://github.com/jasowang/qemu.git net

  Parallel NOR Flash devices
@@ -2222,7 +2222,6 @@ F: tests/qtest/sdhci-test.c
  USB
  S: Orphan
  F: hw/usb/*
-F: stubs/usb-dev-stub.c
  F: tests/qtest/usb-*-test.c
  F: docs/system/devices/usb.rst
  F: include/hw/usb.h
@@ -2475,9 +2474,8 @@ S: Supported
  F: hw/s390x/virtio-ccw-md.c
  F: hw/s390x/virtio-ccw-md.h
  F: hw/s390x/virtio-ccw-md-stubs.c
-F: hw/virtio/virtio-md-pci.c
+F: hw/virtio/virtio-md-*.c
  F: include/hw/virtio/virtio-md-pci.h
-F: stubs/virtio-md-pci.c

  virtio-mem
  M: David Hildenbrand <david@redhat.com>
@@ -3195,13 +3193,12 @@ M: David Hildenbrand <david@redhat.com>
  M: Igor Mammedov <imammedo@redhat.com>
  R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
  S: Supported
-F: hw/mem/memory-device.c
+F: hw/mem/memory-device*.c
  F: hw/mem/nvdimm.c
  F: hw/mem/pc-dimm.c
  F: include/hw/mem/memory-device.h
  F: include/hw/mem/nvdimm.h
  F: include/hw/mem/pc-dimm.h
-F: stubs/memory_device.c
  F: docs/nvdimm.txt

  SPICE
@@ -3242,9 +3239,9 @@ F: util/qemu-timer*.c
  F: system/vl.c
  F: system/main.c
  F: system/cpus.c
-F: system/cpu-throttle.c
  F: system/cpu-timers.c
  F: system/runstate*
+F: migration/cpu-throttle.c
  F: qapi/run-state.json

  Read, Copy, Update (RCU)
@@ -3263,7 +3260,7 @@ Human Monitor (HMP)
  M: Dr. David Alan Gilbert <dave@treblig.org>
  S: Maintained
  F: monitor/monitor-internal.h
-F: monitor/misc.c
+F: monitor/hmp-target.c
  F: monitor/monitor.c
  F: monitor/hmp*
  F: hmp.h
-- 
2.50.0


