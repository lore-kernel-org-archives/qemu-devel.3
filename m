Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D90CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEyj-0005W9-A3; Wed, 27 May 2026 10:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSEyh-0005Vf-Iy
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:11:23 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSEye-0003OE-2o
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:11:23 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:271d:0:640:65b1:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D06C18075C;
 Wed, 27 May 2026 17:11:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:69::1:d] (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp)
 with ESMTPSA id EBaew30YEa60-BnSg9x4f; 
 Wed, 27 May 2026 17:11:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779891075;
 bh=umZNnt8Ncoz8v+xHNtg7At9lKN3aP3lG7YspMuIs4zI=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=zu+Enu0xufD74zbz1DzXmJXDRShms1w+ecTamjJT+RVBDVdjuBPempS+YTeOskR/M
 KwthAKJnM6vZ3yhy1UnZ0nverNvh9VrzyaWkVpDMaV9+nHltobvVJSzwJRy/nDpFyR
 uj8PhURA94O7GK6hoTJxOcmJ55loopHST4nEvm/s=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5d813fe-4072-47bc-b701-9def8caa928d@yandex-team.ru>
Date: Wed, 27 May 2026 17:11:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/8] virtio-net: live-TAP local migration
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, jasowang@redhat.com,
 mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <a9bd3a80-400d-4984-aef3-5e49107f3379@nutanix.com>
 <fc50bbbb-3622-4bc9-8e40-5b61d22fd5c1@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <fc50bbbb-3622-4bc9-8e40-5b61d22fd5c1@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27.05.26 17:07, Vladimir Sementsov-Ogievskiy wrote:
> On 27.05.26 13:46, Mark Cave-Ayland wrote:
>> On 22/05/2026 13:05, Vladimir Sementsov-Ogievskiy wrote:
>>
>>> Hi all!
>>>
>>> Here is a new migration parameter "local", which allows to
>>> enable local migration of TAP virtio-net backend (and maybe other
>>> devices and backends in future), including its properties and open
>>> fds.
>>>
>>> With this new option, management software doesn't need to initialize
>>> new TAP and do a switch to it. Nothing should be done around
>>> virtio-net in local migration: it just migrates and continues to use
>>> same TAP device. So we avoid extra logic in management software, extra
>>> allocations in kernel (for new TAP), and corresponding extra delay in
>>> migration downtime.
>>>
>>> v16: rebase on master (on top of "[PATCH v4 00/13] net: refactoring and fixes"),
>>> 01-08: add r-b by Ben
>>> 06: add a-b by Markus
>>> 07: small fix, exclude vnet_hdr= and ifname= arguments when
>>>      incoming-fds is set (they are not allowed actually, and
>>>      netdev_add fails), keep r-b by Ben.
>>>
>>> Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
>>>      "[PATCH v4 00/13] net: refactoring and fixes"
>>>
>>> Vladimir Sementsov-Ogievskiy (8):
>>>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>>>    net/tap: move vhost initialization to tap_setup_vhost()
>>>    qapi: add local migration parameter
>>>    net: introduce vmstate_net_peer_backend
>>>    virtio-net: support local migration of backend
>>>    net/tap: support local migration with virtio-net
>>>    tests/functional: add skipWithoutSudo() decorator
>>>    tests/functional: add test_tap_migration
>>>
>>>   hw/core/machine.c                             |   1 +
>>>   hw/i386/pc_q35.c                              |   1 +
>>>   hw/net/virtio-net.c                           | 137 +++++-
>>>   include/hw/virtio/virtio-net.h                |   2 +
>>>   include/migration/misc.h                      |   2 +
>>>   include/net/net.h                             |   6 +
>>>   migration/options.c                           |  18 +-
>>>   net/net.c                                     |  47 ++
>>>   net/tap.c                                     | 246 ++++++++--
>>>   qapi/migration.json                           |  12 +-
>>>   qapi/net.json                                 |  10 +-
>>>   tests/functional/qemu_test/decorators.py      |  16 +
>>>   tests/functional/x86_64/meson.build           |   1 +
>>>   tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
>>>   14 files changed, 906 insertions(+), 51 deletions(-)
>>>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
>>
>> I've been looking at this series to try and understand how CPR migration works with network devices, so I'd be interested to have a look at this.
>>
>> Do you have a working example command line and monitor sequence as a reference? I've tried a few examples but I appear to be missing some context, and there's nothing in the cover letter to help out :)
>>
>> Also do you have a git branch somewhere with your latest changes?
>>
>>
> 
> First, the interface is still under discussion (under 5/8 patch of this series).
> 
> Still, of course, you may experiment with current version, I've pushed it now to
> 
>     https://gitlab.com/vsementsov/qemu.git , tag: up-tap-fd-migration-with-bk-opt-v16
> 
> There is a test, you may run it, like this:
> 
>     sudo PYTHONPATH=python:tests/functional QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 QEMU_TEST_KEEP_SCRATCH=1 MESON_BUILD_ROOT=$PWD/build ./build/pyvenv/bin/python3 tests/functional/x86_64/ test_tap_migration.py
> 
> sudo is needed, as test configures TAP devices.
> 
> In short, the interface is as follows:
> 
> 1. Set migration parameter local=True, both on source and target
> 2. Set virtio-net field local-migration=True, both on source and target
> 3. Set tap parameter incoming-fds=True on target
> 4. Start migration
> 
> Also, migration channel must be a UNIX socket.
> 
> [You see, nothing related to CPR, but it should be possible to use this
> tap-fd-migration together with CPR, but I didn't test it]
> 
> 
> And longer instruction, to partly reproduce test_tap_fd_migration() by hand:

[..]

> 2. Start source VM
> ------------------
> 
> Open terminal A, and run:
> 
>      $QEMU \
>          -name source \
>          -machine q35 \
>          -accel kvm \
>          -m 1G \
>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>          -machine memory-backend=ram0 \
>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>          -netdev tap,id=netdev.1,ifname=tap0,queues=4,vnet_hdr=on,script=no,downscript=no,local-migration=on \

Oops. For v16, local-migration=on should be in virtio-net-pci, not in tap, and save for target process.

>          -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
>          -serial stdio \
>          -nographic \
>          -qmp unix:/tmp/qmp-source.sock,server=on,wait=off
> 



-- 
Best regards,
Vladimir

