Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFDFEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvygx-0004qC-Ck; Fri, 27 Feb 2026 09:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvygp-0004pJ-VE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:19:37 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvygn-0002Mv-Ro
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:19:35 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3B1FE80808;
 Fri, 27 Feb 2026 17:19:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:42e::1:38] (unknown
 [2a02:6bf:8080:42e::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OJkjnG0AreA0-x9m9xzTX; Fri, 27 Feb 2026 17:19:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772201966;
 bh=JBgZei6YlWdxDaploGZykn8RDHoG+ibZZkJyEgvhlvs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Lja8xpsFhBesfhCrp5B/WW4fnn/TngZIIhXITKmTj7lYM/76LZvzWDAwXd+4SziHf
 50KxTBlx60d1xtI5i38bCdydGh8l52CqZigb/S19GGAm6U9Iz3sZrnfSg7kOsVjgfB
 1PLQCq6ODLqxdyxHRDv/X8VYfEiFSJSjBlabRVYc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0f032d75-061a-423c-bd93-233499d7f515@yandex-team.ru>
Date: Fri, 27 Feb 2026 17:19:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] tests/functional: add test_tap_migration
To: Thomas Huth <thuth@redhat.com>, jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com, 
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, davydov-max@yandex-team.ru,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
 <20260219115530.2019498-9-vsementsov@yandex-team.ru>
 <45f6dfe0-c81b-4d50-af62-f8eb38584a2d@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <45f6dfe0-c81b-4d50-af62-f8eb38584a2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 27.02.26 16:25, Thomas Huth wrote:
> On 19/02/2026 12.55, Vladimir Sementsov-Ogievskiy wrote:
>> Add test for a new local-migration migration of virtio-net/tap, with fd
>> passing through UNIX socket.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   tests/functional/x86_64/meson.build           |   1 +
>>   tests/functional/x86_64/test_tap_migration.py | 401 ++++++++++++++++++
>>   2 files changed, 402 insertions(+)
>>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
>>
>> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
>> index f78eec5e6c..d23b0cc727 100644
>> --- a/tests/functional/x86_64/meson.build
>> +++ b/tests/functional/x86_64/meson.build
>> @@ -36,4 +36,5 @@ tests_x86_64_system_thorough = [
>>     'vfio_user_client',
>>     'virtio_balloon',
>>     'virtio_gpu',
>> +  'tap_migration',
>>   ]
>> diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
>> new file mode 100755
>> index 0000000000..c629b44f66
>> --- /dev/null
>> +++ b/tests/functional/x86_64/test_tap_migration.py
>> @@ -0,0 +1,401 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that tests TAP local migration
>> +# with fd passing
>> +#
>> +# Copyright (c) Yandex Technologies LLC, 2026
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import time
>> +import subprocess
>> +from subprocess import run
>> +import signal
>> +from typing import Tuple
>> +
>> +from qemu_test import (
>> +    LinuxKernelTest,
>> +    Asset,
>> +    exec_command_and_wait_for_pattern,
>> +)
>> +from qemu_test.decorators import skipWithoutSudo
>> +
>> +GUEST_IP = "10.0.1.2"
>> +GUEST_IP_MASK = f"{GUEST_IP}/24"
>> +GUEST_MAC = "d6:0d:75:f8:0f:b7"
>> +HOST_IP = "10.0.1.1"
> 
> Is it ok to use hard-coded IP addresses here? What if there is already another unrelated 10.0.1.x network on the host (e.g. from a libvirt setup or a VPN)?

Agree, that's bad.. What to do? AI suggest use isolated network namespace (netns). I'll try it.

> 
>> +HOST_IP_MASK = f"{HOST_IP}/24"
>> +TAP_ID = "tap0"
>> +TAP_ID2 = "tap1"
>> +TAP_MAC = "e6:1d:44:b5:03:5d"
>> +
>> +
>> +def ip(args, check=True) -> None:
>> +    """Run ip command with sudo"""
>> +    run(["sudo", "ip"] + args, check=check)
> I think you need to check for the "ip" binary somewhere and skip the test if it is not available (e.g. on a unusual Linux distro or a *BSD host).
> 

ok


-- 
Best regards,
Vladimir

