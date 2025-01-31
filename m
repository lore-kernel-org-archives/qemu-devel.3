Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B1BC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvZG-00061f-Mk; Fri, 31 Jan 2025 13:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdvZB-0005wM-Dz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:16:35 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdvZ8-00022Y-Ll
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:16:33 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdvYr-00000006atp-0g8r; Fri, 31 Jan 2025 19:16:13 +0100
Message-ID: <0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name>
Date: Fri, 31 Jan 2025 19:16:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v4_00/33=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <87tt9gkqb6.fsf@suse.de>
 <adc80094-f7ea-4a30-8d59-f4a9864392f6@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <adc80094-f7ea-4a30-8d59-f4a9864392f6@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.03, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30.01.2025 21:27, Maciej S. Szmigiero wrote:
> On 30.01.2025 21:19, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This is an updated v4 patch series of the v3 series located here:
>>> https://lore.kernel.org/qemu-devel/cover.1731773021.git.maciej.szmigiero@oracle.com/
>>>
>>> Changes from v3:
>>> * MigrationLoadThread now returns bool and an Error complex error type
>>> instead of just an int.
>>>
>>> * qemu_loadvm_load_thread_pool now reports error via migrate_set_error()
>>> instead of dedicated load_threads_ret variable.
>>>
>>> * Since the change above uncovered an issue with respect to multifd send
>>> channels not terminating TLS session properly QIOChannelTLS now allows
>>> gracefully handling this situation.
>>>
>>> * qemu_loadvm_load_thread_pool state is now part of MigrationIncomingState
>>> instead of being stored in global variables.
>>> This state now also has its own init/cleanup helpers.
>>>
>>> * qemu_loadvm_load_thread_pool code is now moved into a separate section
>>> of the savevm.c file, marked by an appropriate comment.
>>>
>>> * thread_pool_free() is now documented to have wait-before-free semantic,
>>> which allowed removal of explicit waits from thread pool cleanup paths.
>>>
>>> * thread_pool_submit_immediate() method was added since this functionality
>>> is used by both generic thread pool users in this patch set.
>>>
>>> * postcopy_ram_listen_thread() now takes BQL around function calls that
>>> ultimately call migration methods requiring BQL.
>>> This fixes one of QEMU tests failing when explicitly BQL-sensitive code
>>> is added later to these methods.
>>>
>>> * qemu_loadvm_load_state_buffer() now returns a bool value instead of int.
>>>
>>> * "Send final SYNC only after device state is complete" patch was
>>> dropped since Peter implemented equivalent functionality upstream.
>>>
>>> * "Document the BQL behavior of load SaveVMHandlers" patch was dropped
>>> since that's something better done later, separately from this patch set.
>>>
>>> * Header size is now added to mig_stats.multifd_bytes where it is actually
>>> sent in the zero copy case - in multifd_nocomp_send_prepare().
>>>
>>> * Spurious wakeups from qemu_cond_wait() are now handled properly as
>>> pointed out by Avihai.
>>>
>>> * VFIO migration FD now allows partial write() completion as pointed out
>>> by Avihai.
>>>
>>> * Patch "vfio/migration: Don't run load cleanup if load setup didn't run"
>>> was dropped, instead all objects related to multifd load are now located in
>>> their own VFIOMultifd struct which is allocated only if multifd device state
>>> transfer is actually in use.
>>>
>>> * Intermediate VFIOStateBuffers API as suggested by Avihai is now introduced
>>> to simplify vfio_load_state_buffer() and vfio_load_bufs_thread().
>>>
>>> * Optional VFIO device config state loading interlocking with loading
>>> other iterables is now possible due to ARM64 platform VFIO dependency on
>>> interrupt controller being loaded first as pointed out by Avihai.
>>>
>>> * Patch "Multifd device state transfer support - receive side" was split
>>> into a few smaller patches as suggested by Cédric.
>>>
>>> * x-migration-multifd-transfer VFIO property compat changes were moved
>>> into a separate patch as suggested by Cédric.
>>>
>>> * Other small changes, like renamed functions and variables/members, added
>>> review tags, code formatting, moved QEMU_LOCK_GUARD() instances closer to
>>> actual protected blocks, etc.
>>>
>>> ========================================================================
>>>
>>> This patch set is targeting QEMU 10.0.
>>>
>>> What's not yet present is documentation update under docs/devel/migration
>>> but I didn't want to delay posting the code any longer.
>>> Such doc can still be merged later when the design is 100% finalized.
>>>
>>> ========================================================================
>>>
>>> Maciej S. Szmigiero (32):
>>>    migration: Clarify that {load,save}_cleanup handlers can run without
>>>      setup
>>>    thread-pool: Remove thread_pool_submit() function
>>>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>>>      *Aio
>>>    thread-pool: Implement generic (non-AIO) pool support
>>>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>>>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>>>    io: tls: Allow terminating the TLS session gracefully with EOF
>>>    migration/multifd: Allow premature EOF on TLS incoming channels
>>>    migration: postcopy_ram_listen_thread() needs to take BQL for some
>>>      calls
>>>    error: define g_autoptr() cleanup function for the Error type
>>>    migration: Add thread pool of optional load threads
>>>    migration/multifd: Split packet into header and RAM data
>>>    migration/multifd: Device state transfer support - receive side
>>>    migration/multifd: Make multifd_send() thread safe
>>>    migration/multifd: Add an explicit MultiFDSendData destructor
>>>    migration/multifd: Device state transfer support - send side
>>>    migration/multifd: Add multifd_device_state_supported()
>>>    migration: Add save_live_complete_precopy_thread handler
>>>    vfio/migration: Add x-migration-load-config-after-iter VFIO property
>>>    vfio/migration: Add load_device_config_state_start trace event
>>>    vfio/migration: Convert bytes_transferred counter to atomic
>>>    vfio/migration: Multifd device state transfer support - basic types
>>>    vfio/migration: Multifd device state transfer support -
>>>      VFIOStateBuffer(s)
>>>    vfio/migration: Multifd device state transfer - add support checking
>>>      function
>>>    vfio/migration: Multifd device state transfer support - receive
>>>      init/cleanup
>>>    vfio/migration: Multifd device state transfer support - received
>>>      buffers queuing
>>>    vfio/migration: Multifd device state transfer support - load thread
>>>    vfio/migration: Multifd device state transfer support - config loading
>>>      support
>>>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>>>    vfio/migration: Multifd device state transfer support - send side
>>>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>>>    hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
>>>      property
>>>
>>> Peter Xu (1):
>>>    migration/multifd: Make MultiFDSendData a struct
>>>
>>>   hw/core/machine.c                  |   2 +
>>>   hw/vfio/migration.c                | 754 ++++++++++++++++++++++++++++-
>>>   hw/vfio/pci.c                      |  14 +
>>>   hw/vfio/trace-events               |  11 +-
>>>   include/block/aio.h                |   8 +-
>>>   include/block/thread-pool.h        |  62 ++-
>>>   include/hw/vfio/vfio-common.h      |   7 +
>>>   include/io/channel-tls.h           |  11 +
>>>   include/migration/client-options.h |   4 +
>>>   include/migration/misc.h           |  16 +
>>>   include/migration/register.h       |  54 ++-
>>>   include/qapi/error.h               |   2 +
>>>   include/qemu/typedefs.h            |   6 +
>>>   io/channel-tls.c                   |   6 +
>>>   migration/colo.c                   |   3 +
>>>   migration/meson.build              |   1 +
>>>   migration/migration-hmp-cmds.c     |   2 +
>>>   migration/migration.c              |   6 +-
>>>   migration/migration.h              |   7 +
>>>   migration/multifd-device-state.c   | 192 ++++++++
>>>   migration/multifd-nocomp.c         |  30 +-
>>>   migration/multifd.c                | 248 ++++++++--
>>>   migration/multifd.h                |  74 ++-
>>>   migration/options.c                |   9 +
>>>   migration/qemu-file.h              |   2 +
>>>   migration/savevm.c                 | 195 +++++++-
>>>   migration/savevm.h                 |   6 +-
>>>   migration/trace-events             |   1 +
>>>   scripts/analyze-migration.py       |  11 +
>>>   tests/unit/test-thread-pool.c      |   6 +-
>>>   util/async.c                       |   6 +-
>>>   util/thread-pool.c                 | 184 +++++--
>>>   util/trace-events                  |   6 +-
>>>   33 files changed, 1814 insertions(+), 132 deletions(-)
>>>   create mode 100644 migration/multifd-device-state.c
>>
>> Hi!
>>
>> We have build issues:
>>
>> https://gitlab.com/farosas/qemu/-/pipelines/1649146958
>>
> 
> Looks like that's an issue that qatomics on 64-bit
> VFIO bytes transferred counters aren't available on
> 32-bit host platforms.
> 
> The easiest way would be probably to change these to
> 32-bit counters on 32-bit platforms since they can't
> realistically address more memory anyway.

Updated the patch to use "unsigned long" counter instead:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/e42b16d2009067bff5a11936aece8a7af2436dc4

>> And the postcopy/recovery test is failing. It seems the migration
>> finishes before the test can issue migrate-pause:
>>
>> QTEST_QEMU_BINARY=./qemu-system-x86_64  ./tests/qtest/migration-test -p
>> /x86_64/migration/postcopy/recovery/plain
>> ...
>> {"execute": "migrate-start-postcopy"}
>> {"return": {}}
>> {"secs": 1738267018, "usecs": 860991}, "event": "MIGRATION", "data": {"status": "postcopy-active"}
>> {"secs": 1738267018, "usecs": 861284}, "event": "STOP"
>> {"secs": 1738267017, "usecs": 960322}, "event": "MIGRATION", "data": {"status": "active"}
>> {"secs": 1738267018, "usecs": 865589}, "event": "MIGRATION", "data": {"status": "postcopy-active"}
>> {"secs": 1738267099, "usecs": 120971}, "event": "MIGRATION", "data": {"status": "completed"}
>> {"secs": 1738267099, "usecs": 121154}, "event": "RESUME"
>> {"execute": "query-migrate"}
>>
>> ERROR:../tests/qtest/migration/migration-qmp.c:172:check_migration_status:
>> assertion failed (current_status != "completed"): ("completed" !=
>> "completed")
>>
> 
> Hmm, it looks like this failure wasn't showing
> in my tests because the test was skipped due to
> missing userfaultfd support:
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/postcopy/recovery/plain
> TAP version 14
> # random seed: R02Sc99a7d93274064bb87f3e0789fbf8326
> # Skipping test: userfaultfd not available
> # Start of x86_64 tests
> # Start of migration tests
> # End of migration tests
> # End of x86_64 tests
> 1..0
> 
> Will try to make this test run and investigate the reason for
> failure.

It looks like the issue here is that holding BQL around
qemu_loadvm_state_main() in postcopy_ram_listen_thread() causes
blocking QEMUFile operations in qemu_loadvm_state_main()
(and its children) to effectively block the whole QEMU while they
are waiting for I/O.

This causes the test to fail because when that qemu_loadvm_state_main()
call finishes and the postcopy thread relinquishes BQL the migration
state immediately reaches "completed" without giving the test chance
to abort the migration attempt.

I still think that that qemu_loadvm_state_main() call needs BQL
since every other its caller seems to hold it and
qemu_loadvm_state_main() ultimately calls "load_state" SaveVMHandlers
which otherwise would have inconsistent BQL semantics.

Since only the second BQL lock in postcopy_ram_listen_thread()
(the one around migration_incoming_state_destroy()) is technically
necessary for other parts of this patch set I have "downgraded"
that other BQL around qemu_loadvm_state_main() to a TODO remark
for now so postcopy tests now pass:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/005a79953aaa75cad160b95252ba421122d5a6a4

Thanks,
Maciej


