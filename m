Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15406C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYSM-0000mR-PY; Thu, 27 Aug 2026 07:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzYSK-0000lS-Cc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:39:40 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzYSG-0001a9-Br
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:39:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 5FB3580F91;
 Thu, 27 Aug 2026 14:39:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id SdcpNN3XaCg0-gNs0wHvx; Thu, 27 Aug 2026 14:39:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787830768;
 bh=xxhoC2OvVrXhdj8Awf0dCranVkROrG1Yl6coTY4MYjk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VzfJrG8Tpk4C7c96E5RAx3/gwoOfcAf62HogtKQSmTR4m2mzcZPh7EUE7gzeOEqAB
 LEXMNTC/8Hp3DUjxIr4yCyO1lSsn9hL2ygkMDz2O1oB0CJ6Pm7V0qm7R5Ou6r1VqAZ
 n6Kg0u3eunnnUZhyK1VYqnlLudsahu08SGXSnnZ0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2edb6a75-8493-4f5b-8511-abf4911c1c35@yandex-team.ru>
Date: Thu, 27 Aug 2026 14:39:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 00/16] virtio-net: live-TAP local migration
To: jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

ping)

On 19.08.26 21:01, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a migration for TAP net backend, including its properties and
> open fds.
> 
> With this new feature, management software doesn't need to initialize
> new TAP and do a switch to it. Nothing should be done around
> virtio-net in local migration: it just migrates and continues to use
> same TAP device. So we avoid extra logic in management software, extra
> allocations in kernel (for new TAP), and corresponding extra delay in
> migration downtime.
> 
> v21:
> 09: wording, add r-b and a-b by Markus and Peter
> 10-12: new, reworkd v20/10
> 15: rename x-local-migration-supported to x-permit-local-migration,
>      small docs improvements, keep r-b
> 
> v21 is pushed to
> 
>      https://gitlab.com/vsementsov/qemu.git
>        tag: up-tap-fd-migration-with-bk-opt-v21
> 
> To run the test, use sudo, as test needs to configure TAP device:
> 
>      sudo PYTHONPATH=python:tests/functional \
>      QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
>      MESON_BUILD_ROOT=$PWD/build \
>      ./build/pyvenv/bin/python3 tests/functional/x86_64/test_tap_migration.py
> 
> Or, to test the feature by hand, you may follow the instruction at
> the and of this document (search for "How to run local fd migration by hand"
> caption).
> 
> Why this series, and why do it this way
> =======================================
> 
> This came up in the v19 discussion, so it's summarized here to avoid
> repeating the same questions.
> There was a large discussion at v19, covered many questions. I'm
> summarizing them below.
> 
> v19: https://lore.kernel.org/qemu-devel/20260714154246.1242856-1-vsementsov@yandex-team.ru/
> 
> Why local migration matters
> ---------------------------
> 
> Local migration (migrating to a new QEMU process on the same host) is not
> a rare operation for in the cloud.  When upgrading QEMU, _all_ VMs on
> _all_ hosts are locally migrated.  The freeze time of such update affects
> _all_ customers, and some are sensitive to even small freezes.  Remote
> migrations, by contrast, are done mostly to release a physical server for
> service/redeploy, which is relatively infrequent.
> 
> The aggregate impact is large, and reducing the per-VM downtime is
> significant.
> 
> Why not just create a new TAP and switch to it
> ----------------------------------------------
> 
> It is possible to create a new TAP device on the target and
> migrate the usual way.  But the overhead is in switching to the new TAP
> in our cloud virtual networking component.  Could the switching itself
> be optimized to always be very fast?  Probably yes, but we chose a
> different approach: drop extra components from the process and avoid
> any switching at all.  Both the cloud networking component and the
> storage backend (with the vhost-user-blk live-update series) don't even
> know that QEMU is migrating.  This gives a simpler design (fewer
> components involved) and shows good results -- several times reduction
> in freeze time.
> 
> Also, on hosts with many CPUs, TAP queues allocate a noticeable amount of
> RAM, so having 2x queues during migration is an overhead.
> 
> Why not use a persistent TAP (open the same TAP on both source and target)
> -------------------------------------------------------------------------
> 
> First, same memory overhead like with "new TAP" case.
> 
> Second, MAX_TAP_QUEUES is 256 in the kernel; if the source already has more
>    than 128 queues open, the target cannot open the same device.
> 
> [Note also, that such persistent TAP migration will not "just work",
> it also needs QEMU changes like patch 12/15 to avoid packet lost]
> 
> Why not pass FDs externally (e.g. from libvirt / management tool)
> -----------------------------------------------------------------
> 
> - The management tool would need to store (or retrieve from source QEMU)
>    and pass these FDs, requiring it to know about FDs that QEMU already
>    owns.  Libvirt may restart, and that shouldn't break migration.
> - Adding an API to retrieve FDs from QEMU just to pass them to target QEMU
>    is not a clearer solution.
> - QEMU owns the TAP fd and has full knowledge of its state.  Pushing
>    this responsibility to an external tool means the tool needs to
>    understand QEMU internals -- that's a worse separation of concerns.
> - QEMU already passes FDs through migration for VFIO devices (CPR), we
>    do continue this practice
> 
> Looking at wider picture, where we want to migrate not only TAP, but also
> vfio devices (already implemented as CPR migration, but may be updated to
> use similar approach as in this series, to use one migration channel),
> vhost-user-blk (my another series in flight) and vhost-user-fs (not yet
> published), vhost-vsock migration ("[PATCH v3 0/7] migration/cpr: support
> vhost-vsock devices" in flight-series from Virtuozzo), it seems to be a
> good generic approach: simply pass backends (including open FDs) to the
> target, not involving mgmt. Qemu has full knowledge about these FDs and
> owns the whole state. Migrating them in QEMU looks correct.
> 
> Why not use the cpr-transfer approach (pass FDs before device creation)
> -----------------------------------------------------------------------
> 
> The CPR approach passes FDs _before_ any devices are created on the
> target.  While this avoids touching frontend code (patch 11/15), it
> means the target starts using (calling ioctls on) FDs that are still
> actively used by the running source QEMU.  That works for TAP, but it
> does _not_ work with vhost-user-blk, where sharing the fd between
> source and running target can break things.  My series uses the same
> approach for both net and storage, and it also works with CPR (see
> below).
> 
> That's not saying about "local" approach provides simpler user
> experience than cpr-transfer:
> 
> - no need in secondary migration channel
> - no need to work with unavailable QMP for target process until
>    "migrate" on source
> 
> Does this work with CPR?
> ------------------------
> 
> Yes.  For cpr-transfer, TAP migrates through the main migration channel
> like other (non-CPR) devices.  For cpr-exec, TAP FDs don't have
> FD_CLOEXEC set, so they are inherited by the new process as-is; the
> same core mechanism (load_fd / save_fd in migration/vmstate-types.c) is
> used.  The 'local' migration parameter documentation now also covers
> cpr-exec mode (skip the UNIX-socket requirement in that case).
> New test cases exercising both cpr-transfer and cpr-exec with TAP
> local migration will be sent as separate series.
> 
> 
> How to run local fd migration by hand
> =====================================
> 
> The walkthrough uses four terminals:
> 
>    source-cmd  -- source VM console (serial output, guest login)
>    source-qmp  -- QMP connection to the source QEMU
>    target-cmd  -- target VM console (serial output, guest login after migration)
>    target-qmp  -- QMP connection to the target QEMU
> 
> 1. Prerequisites
> ----------------
> 
>      QEMU=/path/to/your/build/qemu-system-x86_64
> 
> # download same image as in test
> 
>      wget -O /tmp/alpine.iso "https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"
> 
> 
> # prepare tap device (be careful to not break your own networks)
> 
>      sudo ip tuntap add dev tap0 mode tap multi_queue
>      sudo ip addr add 192.168.100.1/24 dev tap0
>      sudo ip link set tap0 up
> 
> 
> 2. Start source VM
> ------------------
> 
> In source-cmd, run:
> 
>      $QEMU \
>          -name source \
>          -machine q35 \
>          -accel kvm \
>          -m 1G \
>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>          -machine memory-backend=ram0 \
>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>          -serial stdio \
>          -nographic \
>          -S \
>          -qmp unix:/tmp/qmp-source.sock,server=on,wait=off
> 
> Note: the netdev and virtio-net device are added via QMP below for symmetry
> with the target.  On the source you could also pass them on the command line
> (with x-permit-local-migration=on).
> 
> In source-qmp, connect and add the TAP netdev and virtio-net device:
> 
>      socat - UNIX-CONNECT:/tmp/qmp-source.sock
> 
>      {"execute": "qmp_capabilities"}
> 
>      {"execute": "netdev_add", "arguments": {
>          "id": "netdev.1",
>          "type": "tap",
>          "ifname": "tap0",
>          "queues": 4,
>          "vnet_hdr": true,
>          "script": "no",
>          "downscript": "no",
>          "x-permit-local-migration": true
>      }}
> 
>      {"execute": "device_add", "arguments": {
>          "driver": "virtio-net-pci",
>          "id": "vnet.1",
>          "netdev": "netdev.1",
>          "bus": "pci.1",
>          "mq": true,
>          "vectors": 18,
>          "romfile": "",
>          "disable-legacy": "off"
>      }}
> 
>      {"execute": "cont"}
> 
> Wait for Alpine to boot in source-cmd.  When you see the login prompt, log
> in as root (no password):
> 
>      localhost login: root
> 
> Configure the guest network:
> 
>      ip addr add 192.168.100.2/24 dev eth0
>      ip link set eth0 up
> 
> Verify connectivity from the guest:
> 
>      ping -c 3 192.168.100.1
> 
> And from the host (in any spare terminal):
> 
>      ping -c 3 192.168.100.2
> 
> 
> 3. Start target VM
> ------------------
> 
> The TAP netdev must be created via QMP after enabling the "local" migration
> parameter -- the target will not open tap0 itself; instead it will receive the
> TAP file descriptors from the source over the migration channel.
> 
> In target-cmd, run:
> 
>      $QEMU \
>          -name target \
>          -machine q35 \
>          -accel kvm \
>          -m 1G \
>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>          -machine memory-backend=ram0 \
>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>          -serial stdio \
>          -nographic \
>          -qmp unix:/tmp/qmp-target.sock,server=on,wait=off \
>          -incoming defer
> 
> In target-qmp, connect, enable local migration, and add the TAP netdev and
> virtio-net device.  The "local" parameter must be set before creating the TAP.
> Do not pass ifname/fd -- the fd will arrive via the migration channel:
> 
>      socat - UNIX-CONNECT:/tmp/qmp-target.sock
> 
>      {"execute": "qmp_capabilities"}
> 
>      {"execute": "migrate-set-capabilities", "arguments": {
>          "capabilities": [
>              {"capability": "events",          "state": true},
>              {"capability": "x-ignore-shared", "state": true}
>          ]
>      }}
> 
>      {"execute": "migrate-set-parameters", "arguments": {"local": true}}
> 
>      {"execute": "netdev_add", "arguments": {
>          "id": "netdev.1",
>          "type": "tap",
>          "queues": 4,
>          "script": "",
>          "downscript": "",
>          "x-permit-local-migration": true
>      }}
> 
>      {"execute": "device_add", "arguments": {
>          "driver": "virtio-net-pci",
>          "id": "vnet.1",
>          "netdev": "netdev.1",
>          "bus": "pci.1",
>          "mq": true,
>          "vectors": 18,
>          "romfile": "",
>          "disable-legacy": "off"
>      }}
> 
> 4. Start migration
> ------------------
> 
> In target-qmp, tell the target to listen for the incoming migration:
> 
>      {"execute": "migrate-incoming",
>       "arguments": {"uri": "unix:/tmp/migration.sock"}}
> 
> In source-qmp, configure migration capabilities and parameters:
> 
>      {"execute": "migrate-set-capabilities", "arguments": {
>          "capabilities": [
>              {"capability": "events",          "state": true},
>              {"capability": "x-ignore-shared", "state": true}
>          ]
>      }}
> 
>      {"execute": "migrate-set-parameters", "arguments": {"local": true}}
> 
> In source-qmp, trigger the migration:
> 
>      {"execute": "migrate",
>       "arguments": {"uri": "unix:/tmp/migration.sock"}}
> 
> Poll migration status until it completes (source-qmp):
> 
>      {"execute": "query-migrate"}
>      # repeat until "status" == "completed"
> 
> Or just wait for the MIGRATION event that QEMU emits automatically:
> 
>      # {"event": "MIGRATION", "data": {"status": "completed"}, ...}
> 
> Once the source reports "completed", resume the target VM (target-qmp):
> 
>      {"execute": "cont"}
> 
> The target VM is now running with the migrated state and the TAP file
> descriptors that were passed from the source. Still, target console
> (in target-cmd) may still be empty, until you at least press Enter in
> it.
> 
> Verify that the guest is still reachable from the host:
> 
>      ping -c 3 192.168.100.2
> 
> And from inside the guest in target-cmd:
> 
>      ping -c 3 192.168.100.1
> 
> 
> 5. Cleanup
> ----------
> 
> Shut down the target VM (target-qmp):
> 
>      {"execute": "quit"}
> 
> Shut down the source VM (source-qmp):
> 
>      {"execute": "quit"}
> 
> Remove the TAP device:
> 
>      sudo ip tuntap del tap0 mode tap multi_queue
> 
> Remove the shared memory file:
> 
>      rm /dev/shm/qemu_migration_test
> 
> Remove leftover sockets if they still exist:
> 
>      rm -f /tmp/migration.sock /tmp/qmp-source.sock /tmp/qmp-target.sock
> 
> Vladimir Sementsov-Ogievskiy (16):
>    net/tap: rework tap_parse_script
>    net/tap: improve script/downscript options documentation
>    net/tap: deprecate "no" as special value for script/downscript
>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>    net/tap: move vhost initialization to tap_setup_vhost()
>    net/tap: use container_of instead of DO_UPCAST
>    net/tap: QOMify tap backend
>    net/tap: add TYPE_VMSTATE_IF interface
>    qapi: add local migration parameter
>    migration/fd: fix fd leak when fd is not valid for migration
>    migration/fd: add errp parameter to migration_fd_valid()
>    migration: check that transfer is UNIX socket when "local" set
>    virtio-net: support local migration of backend
>    net/tap: disable read polling for stopped VM
>    net/tap: support local migration with virtio-net
>    tests/functional: add test_tap_migration
> 
>   docs/about/deprecated.rst                     |  18 +
>   docs/system/i386/microvm.rst                  |   4 +-
>   docs/system/i386/xenpvh.rst                   |   2 +-
>   docs/system/ppc/ppce500.rst                   |   4 +-
>   docs/system/riscv/microchip-icicle-kit.rst    |   2 +-
>   docs/system/riscv/sifive_u.rst                |   2 +-
>   hw/net/virtio-net.c                           |  89 +++-
>   include/hw/virtio/virtio-net.h                |   1 +
>   include/migration/misc.h                      |   2 +
>   include/migration/vmstate.h                   |   2 +
>   include/net/net.h                             |   9 +
>   include/net/tap.h                             |   2 +
>   migration/fd.c                                |  28 +-
>   migration/migration.c                         |  13 +
>   migration/options.c                           |  18 +-
>   net/net.c                                     |  14 +-
>   net/tap.c                                     | 446 ++++++++++++++---
>   qapi/migration.json                           |  21 +-
>   qapi/net.json                                 |  47 +-
>   qemu-options.hx                               |  13 +-
>   tests/functional/x86_64/meson.build           |   1 +
>   tests/functional/x86_64/test_tap_migration.py | 461 ++++++++++++++++++
>   22 files changed, 1081 insertions(+), 118 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_tap_migration.py
> 


-- 
Best regards,
Vladimir

