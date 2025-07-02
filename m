Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FDDC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxpg-0000Ey-Ks; Wed, 02 Jul 2025 09:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org>)
 id 1uWxpX-0000AF-Ax
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:48:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org>)
 id 1uWxpP-0000e5-4f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:48:54 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bXLnz08fnz4x43;
 Wed,  2 Jul 2025 23:48:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bXLnw2SHJz4wxJ;
 Wed,  2 Jul 2025 23:48:20 +1000 (AEST)
Message-ID: <403d594e-cd95-4578-868c-02df19daf7bd@kaod.org>
Date: Wed, 2 Jul 2025 15:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 berrange@redhat.com, thuth@redhat.com, jean-philippe@linaro.org,
 eric.auger@redhat.com, smostafa@google.com
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <ed4fb068-dcba-4ce0-83d7-3534d3e37509@kaod.org>
 <87ecuyemwl.fsf@draig.linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <87ecuyemwl.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/25 15:35, Alex Bennée wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> Hello,
>>
>> On 6/27/25 22:02, Pierrick Bouvier wrote:
>>> This test allows to document and exercise device passthrough, using a
>>> nested virtual machine setup. Two disks are generated and passed to the
>>> VM, and their content is compared to original images.
>>> Guest and nested guests commands are executed through two scripts,
>>> and
>>> init used in both system is configured to trigger a kernel panic in case
>>> any command fails. This is more reliable and readable than executing all
>>> commands through prompt injection and trying to guess what failed.
>>> Initially, this test was supposed to test smmuv3 nested emulation
>>> (combining both stages of translation), but I could not find any setup
>>> (kernel + vmm) able to do the passthrough correctly, despite several
>>> tries.
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    tests/functional/meson.build                  |   2 +
>>>    .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
>>>    2 files changed, 144 insertions(+)
>>>    create mode 100755 tests/functional/test_aarch64_device_passthrough.py
>>> diff --git a/tests/functional/meson.build
>>> b/tests/functional/meson.build
>>> index 3021928a9d4..6cc78abb123 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -13,6 +13,7 @@ endif
>>>    test_timeouts = {
>>>      'aarch64_aspeed_ast2700' : 600,
>>>      'aarch64_aspeed_ast2700fc' : 600,
>>> +  'aarch64_device_passthrough' : 720,
>>>      'aarch64_imx8mp_evk' : 240,
>>>      'aarch64_raspi4' : 480,
>>>      'aarch64_reverse_debug' : 180,
>>> @@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
>>>    tests_aarch64_system_thorough = [
>>>      'aarch64_aspeed_ast2700',
>>>      'aarch64_aspeed_ast2700fc',
>>> +  'aarch64_device_passthrough',
>>>      'aarch64_imx8mp_evk',
>>>      'aarch64_raspi3',
>>>      'aarch64_raspi4',
>>> diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
>>> new file mode 100755
>>> index 00000000000..1f3f158a9ff
>>> --- /dev/null
>>> +++ b/tests/functional/test_aarch64_device_passthrough.py
>>> @@ -0,0 +1,142 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Boots a nested guest and compare content of a device (passthrough) to a
>>> +# reference image. Both vfio group and iommufd passthrough methods are tested.
>>> +#
>>> +# Copyright (c) 2025 Linaro Ltd.
>>> +#
>>> +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import os
>>> +
>>> +from qemu_test import QemuSystemTest, Asset
>>> +from qemu_test import exec_command, wait_for_console_pattern
>>> +from qemu_test import exec_command_and_wait_for_pattern
>>> +from random import randbytes
>>> +
>>> +guest_script = '''
>>> +#!/usr/bin/env bash
>>> +
>>> +set -euo pipefail
>>> +set -x
>>> +
>>> +# find disks from nvme serial
>>> +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
>>> +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
>>> +pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
>>> +pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
>>> +
>>> +# bind disks to vfio
>>> +for p in "$pci_vfio" "$pci_iommufd"; do
>>> +    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
>>> +        continue
>>> +    fi
>>> +    echo $p > /sys/bus/pci/drivers/nvme/unbind
>>> +    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
>>> +    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
>>> +done
>>> +
>>> +# boot nested guest and execute /host/nested_guest.sh
>>> +# one disk is passed through vfio group, the other, through iommufd
>>> +qemu-system-aarch64 \
>>
>> Is this binary on the host.ext4 image ?
>>
>> If so, the test is testing a chosen QEMU version compiled in the
>> L1 guest image but not the current QEMU version, which is the one
>> running in the L0.
>>
>> Anyhow this is a very nice test and an excellent base to build on.
>> As a next step, I’d suggest including tests with NICs using igb
>> devices and igb virtual functions (VFs).
>>
>> It would also be great to run the L1 environment using the current
>> version of QEMU. I haven't found a clean way to achieve that yet :/
> 
> I sometimes boot up with a virtiofsd mapped to $HOME but it gets a
> little unstable over time and I haven't had a chance to figure out where
> things where going wrong.
> 
> We have the containers to reliably build a cross image of QEMU but we
> would have to ensure the guest image matches so we don't run into
> library skew issues. 

and could we generate a disk image from a container build, keep the
artifact and use it in the functional test to boot the L1 guest  ?


Thanks,

C.


