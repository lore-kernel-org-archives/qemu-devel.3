Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE724E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdJg-00012A-QR; Fri, 06 Dec 2024 13:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJdJe-00011l-W1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:44:39 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJdJc-0004OY-Bj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:44:38 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tJdJW-00000003MgG-1qJq; Fri, 06 Dec 2024 19:44:30 +0100
Message-ID: <ab2e0bfa-16ff-4201-aba8-d2fefadd7db6@maciej.szmigiero.name>
Date: Fri, 6 Dec 2024 19:44:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00/24=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5.12.2024 22:27, Cédric Le Goater wrote:
> On 11/17/24 20:19, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This is an updated v3 patch series of the v2 series located here:
>> https://lore.kernel.org/qemu-devel/cover.1724701542.git.maciej.szmigiero@oracle.com/
>>
>> Changes from v2:
>> * Reworked the non-AIO (generic) thread pool to use Glib's GThreadPool
>> instead of making the current QEMU AIO thread pool generic.
>>
>> * Added QEMU_VM_COMMAND MIG_CMD_SWITCHOVER_START sub-command to the
>> migration bit stream protocol via migration compatibility flag.
>> Used this new bit stream sub-command to achieve barrier between main
>> migration channel device state data and multifd device state data instead
>> of introducing save_live_complete_precopy_{begin,end} handlers for that as
>> the previous patch set version did,
>>
>> * Added a new migration core thread pool of optional load threads and used
>> it to implement VFIO load thread instead of introducing load_finish handler
>> as the previous patch set version did.
>>
>> * Made VFIO device config state load operation happen from that device load
>> thread instead of from (now gone) load_finish handler that did such load on
>> the main migration thread.
>> In the future this may allow pushing BQL deeper into the device config
>> state load operation internals and so doing more of it in parallel.
>>
>> * Switched multifd_send() to using a serializing mutex for thread safety
>> instead of atomics as suggested by Peter since this seems to not cause
>> any performance regression while being simpler.
>>
>> * Added two patches improving SaveVMHandlers documentation: one documenting
>> the BQL behavior of load SaveVMHandlers, another one explaining
>> {load,save}_cleanup handlers semantics.
>>
>> * Added Peter's proposed patch making MultiFDSendData a struct from
>> https://lore.kernel.org/qemu-devel/ZuCickYhs3nf2ERC@x1n/
>> Other two patches from that message bring no performance benefits so they
>> were skipped (as discussed in that e-mail thread).
>>
>> * Switched x-migration-multifd-transfer VFIO property to tri-state (On,
>> Off, Auto), with Auto being now the default value.
>> This means hat VFIO device state transfer via multifd channels is
>> automatically attempted in configurations that otherwise support it.
>> Note that in this patch set version (in contrast with the previous version)
>> x-migration-multifd-transfer setting is meaningful both on source AND
>> destination QEMU.
>>
>> * Fixed a race condition with respect to the final multifd channel SYNC
>> packet sent by the RAM transfer code.
>>
>> * Made VFIO's bytes_transferred counter atomic since it is accessed from
>> multiple threads (thanks Avihai for spotting it).
>>
>> * Fixed an issue where VFIO device config sender QEMUFile wouldn't be
>> closed in some error conditions, switched to QEMUFile g_autoptr() automatic
>> memory management there to avoid such bugs in the future (also thanks
>> to Avihai for spotting the issue).
>>
>> * Many, MANY small changes, like renamed functions, added review tags,
>> locks annotations, code formatting, split out changes into separate
>> commits, etc.
>>
>> * Redid benchmarks.
>>
>> ========================================================================
>>
>> Benchmark results:
>> These are 25th percentile of downtime results from 70-100 back-and-forth
>> live migrations with the same VM config (guest wasn't restarted during
>> these migrations).
>>
>> Previous benchmarks reported the lowest downtime results ("0th percentile")
>> instead but these were subject to variation due to often being one of
>> outliers.
>>
>> The used setup for bechmarking was the same as the RFC version of patch set
>> used.
>>
>>
>> Results with 6 multifd channels:
>>              4 VFs   2 VFs    1 VF
>> Disabled: 1900 ms  859 ms  487 ms
>> Enabled:  1095 ms  556 ms  366 ms
>>
>> Results with 4 VFs but varied multifd channel count:
>>               6 ch     8 ch    15 ch
>> Enabled:  1095 ms  1104 ms  1125 ms
>>
>>
>> Important note:
>> 4 VF benchmarks were done with commit 5504a8126115
>> ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
>> reverted since this seems to improve performance in this VM config if the
>> multifd transfer is enabled: the downtime performance with this commit
>> present is 1141 ms enabled / 1730 ms disabled.
>>
>> Smaller VF counts actually do seem to benefit from this commit, so it's
>> likely that in the future adding some kind of a memslot pre-allocation
>> bit stream message might make sense to avoid this downtime regression for
>> 4 VF configs (and likely higher VF count too).
>>
>> ========================================================================
>>
>> This series is obviously targeting post QEMU 9.2 release by now
>> (AFAIK called 10.0).
>>
>> Will need to be changed to use hw_compat_10_0 once these become available.
>>
>> ========================================================================
>>
>> Maciej S. Szmigiero (23):
>>    migration: Clarify that {load,save}_cleanup handlers can run without
>>      setup
>>    thread-pool: Remove thread_pool_submit() function
>>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>>      *Aio
>>    thread-pool: Implement generic (non-AIO) pool support
>>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>>    migration: Document the BQL behavior of load SaveVMHandlers
>>    migration: Add thread pool of optional load threads
>>    migration/multifd: Split packet into header and RAM data
>>    migration/multifd: Device state transfer support - receive side
>>    migration/multifd: Make multifd_send() thread safe
>>    migration/multifd: Add an explicit MultiFDSendData destructor
>>    migration/multifd: Device state transfer support - send side
>>    migration/multifd: Add migration_has_device_state_support()
>>    migration/multifd: Send final SYNC only after device state is complete
>>    migration: Add save_live_complete_precopy_thread handler
>>    vfio/migration: Don't run load cleanup if load setup didn't run
>>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>>    vfio/migration: Add load_device_config_state_start trace event
>>    vfio/migration: Convert bytes_transferred counter to atomic
>>    vfio/migration: Multifd device state transfer support - receive side
>>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>>    vfio/migration: Multifd device state transfer support - send side
>>
>> Peter Xu (1):
>>    migration/multifd: Make MultiFDSendData a struct
>>
>>   hw/core/machine.c                  |   2 +
>>   hw/vfio/migration.c                | 588 ++++++++++++++++++++++++++++-
>>   hw/vfio/pci.c                      |  11 +
>>   hw/vfio/trace-events               |  11 +-
>>   include/block/aio.h                |   8 +-
>>   include/block/thread-pool.h        |  20 +-
>>   include/hw/vfio/vfio-common.h      |  21 ++
>>   include/migration/client-options.h |   4 +
>>   include/migration/misc.h           |  16 +
>>   include/migration/register.h       |  67 +++-
>>   include/qemu/typedefs.h            |   5 +
>>   migration/colo.c                   |   3 +
>>   migration/meson.build              |   1 +
>>   migration/migration-hmp-cmds.c     |   2 +
>>   migration/migration.c              |   3 +
>>   migration/migration.h              |   2 +
>>   migration/multifd-device-state.c   | 193 ++++++++++
>>   migration/multifd-nocomp.c         |  45 ++-
>>   migration/multifd.c                | 228 +++++++++--
>>   migration/multifd.h                |  73 +++-
>>   migration/options.c                |   9 +
>>   migration/qemu-file.h              |   2 +
>>   migration/ram.c                    |  10 +-
>>   migration/savevm.c                 | 183 ++++++++-
>>   migration/savevm.h                 |   4 +
>>   migration/trace-events             |   1 +
>>   scripts/analyze-migration.py       |  11 +
>>   tests/unit/test-thread-pool.c      |   2 +-
>>   util/async.c                       |   6 +-
>>   util/thread-pool.c                 | 174 +++++++--
>>   util/trace-events                  |   6 +-
>>   31 files changed, 1586 insertions(+), 125 deletions(-)
>>   create mode 100644 migration/multifd-device-state.c
> 
> 
> I did a quick run of a VM with a mlx5 VF and a vGPU and I didn't see
> any issue when migrating. I used 4 channels for multifd. The trace
> events looked ok and useful. We will tune these with time. I wished
> we had some way to dump the thread and channel usage on each side.
> 
> A build was provided to RHEL QE. This to get more results when under
> stress and with larger device states. Don't expect feedback before
> next year though !

Thanks Cédric, more testing of a complex code change is always
appreciated.

Especially that your test environment is probably significantly
different from mine.

> Having a small cookbook to run the migration from QEMU and from
> libvirt would be a plus.
> 
> Thanks,
> 
> C.

Thanks,
Maciej


