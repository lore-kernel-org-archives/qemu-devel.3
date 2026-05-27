Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182B7CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEvI-0004LJ-GM; Wed, 27 May 2026 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSEvG-0004L5-JV
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:07:51 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSEvD-0000V7-7v
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:07:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 754FC81E48;
 Wed, 27 May 2026 17:07:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:69::1:d] (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id e7aMX30aGCg0-YzzdJriH; Wed, 27 May 2026 17:07:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779890861;
 bh=TajQye104GeAKGwehH4zb1vcvH6xbWkupvnYLvYWwdI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SS17XuwVzZnZ4bkQxzLnn6IQk+8191gLM8If+LHUqHLa0xG7Ur7AbEkDWvDAzab/v
 gWrWZP7WRMGn8I93v5GVpSfpdnijRPIPwaM9PyC9z/paGzIqSEX58bvPEY7AGuQchE
 v2YXY0J7s3T4eQcd5+x5eiqLcSh1MQk6yiOz+4GY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fc50bbbb-3622-4bc9-8e40-5b61d22fd5c1@yandex-team.ru>
Date: Wed, 27 May 2026 17:07:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/8] virtio-net: live-TAP local migration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, jasowang@redhat.com,
 mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <a9bd3a80-400d-4984-aef3-5e49107f3379@nutanix.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <a9bd3a80-400d-4984-aef3-5e49107f3379@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 27.05.26 13:46, Mark Cave-Ayland wrote:
> On 22/05/2026 13:05, Vladimir Sementsov-Ogievskiy wrote:
> 
>> Hi all!
>>
>> Here is a new migration parameter "local", which allows to
>> enable local migration of TAP virtio-net backend (and maybe other
>> devices and backends in future), including its properties and open
>> fds.
>>
>> With this new option, management software doesn't need to initialize
>> new TAP and do a switch to it. Nothing should be done around
>> virtio-net in local migration: it just migrates and continues to use
>> same TAP device. So we avoid extra logic in management software, extra
>> allocations in kernel (for new TAP), and corresponding extra delay in
>> migration downtime.
>>
>> v16: rebase on master (on top of "[PATCH v4 00/13] net: refactoring and fixes"),
>> 01-08: add r-b by Ben
>> 06: add a-b by Markus
>> 07: small fix, exclude vnet_hdr= and ifname= arguments when
>>      incoming-fds is set (they are not allowed actually, and
>>      netdev_add fails), keep r-b by Ben.
>>
>> Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
>>      "[PATCH v4 00/13] net: refactoring and fixes"
>>
>> Vladimir Sementsov-Ogievskiy (8):
>>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>>    net/tap: move vhost initialization to tap_setup_vhost()
>>    qapi: add local migration parameter
>>    net: introduce vmstate_net_peer_backend
>>    virtio-net: support local migration of backend
>>    net/tap: support local migration with virtio-net
>>    tests/functional: add skipWithoutSudo() decorator
>>    tests/functional: add test_tap_migration
>>
>>   hw/core/machine.c                             |   1 +
>>   hw/i386/pc_q35.c                              |   1 +
>>   hw/net/virtio-net.c                           | 137 +++++-
>>   include/hw/virtio/virtio-net.h                |   2 +
>>   include/migration/misc.h                      |   2 +
>>   include/net/net.h                             |   6 +
>>   migration/options.c                           |  18 +-
>>   net/net.c                                     |  47 ++
>>   net/tap.c                                     | 246 ++++++++--
>>   qapi/migration.json                           |  12 +-
>>   qapi/net.json                                 |  10 +-
>>   tests/functional/qemu_test/decorators.py      |  16 +
>>   tests/functional/x86_64/meson.build           |   1 +
>>   tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
>>   14 files changed, 906 insertions(+), 51 deletions(-)
>>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
> 
> I've been looking at this series to try and understand how CPR migration works with network devices, so I'd be interested to have a look at this.
> 
> Do you have a working example command line and monitor sequence as a reference? I've tried a few examples but I appear to be missing some context, and there's nothing in the cover letter to help out :)
> 
> Also do you have a git branch somewhere with your latest changes?
> 
> 

First, the interface is still under discussion (under 5/8 patch of this series).

Still, of course, you may experiment with current version, I've pushed it now to

    https://gitlab.com/vsementsov/qemu.git , tag: up-tap-fd-migration-with-bk-opt-v16

There is a test, you may run it, like this:

    sudo PYTHONPATH=python:tests/functional QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 QEMU_TEST_KEEP_SCRATCH=1 MESON_BUILD_ROOT=$PWD/build ./build/pyvenv/bin/python3 tests/functional/x86_64/ test_tap_migration.py

sudo is needed, as test configures TAP devices.

In short, the interface is as follows:

1. Set migration parameter local=True, both on source and target
2. Set virtio-net field local-migration=True, both on source and target
3. Set tap parameter incoming-fds=True on target
4. Start migration

Also, migration channel must be a UNIX socket.

[You see, nothing related to CPR, but it should be possible to use this
tap-fd-migration together with CPR, but I didn't test it]


And longer instruction, to partly reproduce test_tap_fd_migration() by hand:

1. Prerequisites
----------------

     QEMU=/path/to/your/build/qemu-system-x86_64

# download same image as in test

     wget -O /tmp/alpine.iso "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"


# prepare tap device (be careful to not break your own networks)

     sudo ip tuntap add dev tap0 mode tap multi_queue
     sudo ip addr add 192.168.100.1/24 dev tap0
     sudo ip link set tap0 up


2. Start source VM
------------------

Open terminal A, and run:

     $QEMU \
         -name source \
         -machine q35 \
         -accel kvm \
         -m 1G \
         -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
         -machine memory-backend=ram0 \
         -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
         -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
         -netdev tap,id=netdev.1,ifname=tap0,queues=4,vnet_hdr=on,script=no,downscript=no,local-migration=on \
         -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
         -serial stdio \
         -nographic \
         -qmp unix:/tmp/qmp-source.sock,server=on,wait=off

Wait for Alpine to boot.  When you see the login prompt, log in as root
(no password):

     localhost login: root

Configure the guest network:

     ip addr add 192.168.100.2/24 dev eth0
     ip link set eth0 up

Verify connectivity from the guest:

     ping -c 3 192.168.100.1

And from the host (in another terminal):

     ping -c 3 192.168.100.2


3. Start target VM
------------------

Open terminal B.  The target VM uses the same shared memory file and
the same ISO.  The NIC is configured with incoming-fds=on — it will
not open tap0 itself; instead it will receive the TAP file descriptors
from the source over the migration channel.

     $QEMU \
         -name target \
         -machine q35 \
         -accel kvm \
         -m 1G \
         -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
         -machine memory-backend=ram0 \
         -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
         -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
         -netdev tap,id=netdev.1,queues=4,script=no,downscript=no,local-migration=on,incoming-fds=on \
         -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
         -serial stdio \
         -nographic \
         -qmp unix:/tmp/qmp-target.sock,server=on,wait=off \
         -incoming defer


4. Start migration
------------------

Open terminal C and connect to the source QMP socket:

     socat - UNIX-CONNECT:/tmp/qmp-source.sock

Negotiate capabilities and configure migration:

     {"execute": "qmp_capabilities"}

     {"execute": "migrate-set-capabilities", "arguments": {
         "capabilities": [
             {"capability": "events",          "state": true},
             {"capability": "x-ignore-shared", "state": true}
         ]
     }}

     {"execute": "migrate-set-parameters", "arguments": {"local": true}}

Open terminal D and connect to the target QMP socket:

     socat - UNIX-CONNECT:/tmp/qmp-target.sock

Negotiate capabilities and configure migration:

     {"execute": "qmp_capabilities"}

     {"execute": "migrate-set-capabilities", "arguments": {
         "capabilities": [
             {"capability": "events",          "state": true},
             {"capability": "x-ignore-shared", "state": true}
         ]
     }}

     {"execute": "migrate-set-parameters", "arguments": {"local": true}}

Tell the target to listen for the incoming migration (terminal D):

     {"execute": "migrate-incoming",
      "arguments": {"uri": "unix:/tmp/migration.sock"}}

Trigger the migration from the source (terminal C):

     {"execute": "migrate",
      "arguments": {"uri": "unix:/tmp/migration.sock"}}

Poll migration status until it completes (terminal C):

     {"execute": "query-migrate"}
     # repeat until "status" == "completed"

Or just wait for the MIGRATION event that QEMU emits automatically:

     # {"event": "MIGRATION", "data": {"status": "completed"}, ...}

Once the source reports "completed", resume the target VM (terminal D):

     {"execute": "cont"}

The target VM is now running with the migrated state and the TAP file
descriptors that were passed from the source.

Verify that the guest is still reachable from the host:

     ping -c 3 192.168.100.2

And from inside the guest (terminal B, target serial console):

     ping -c 3 192.168.100.1


5. Cleanup
----------

Shut down the target VM (terminal D):

     {"execute": "quit"}

Shut down the source VM (terminal C):

     {"execute": "quit"}

Remove the TAP device:

     sudo ip tuntap del tap0 mode tap multi_queue

Remove the shared memory file:

     rm /dev/shm/qemu_migration_test

Remove leftover sockets if they still exist:

     rm -f /tmp/migration.sock /tmp/qmp-source.sock /tmp/qmp-target.sock

-- 
Best regards,
Vladimir

