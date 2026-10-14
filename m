Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FD9CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGz09-0002zz-JQ; Wed, 14 Oct 2026 09:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGyzx-0002zj-HC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:26:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGyzr-0004dn-VJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:26:23 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69EDQ2Du027072
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 14 Oct 2026 22:26:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lOsEA+8MhnE2pwVWeWoObZXfiUpRmM6VFXYl7r7I8ys=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791984363; v=1;
 b=WiErE7FRklNbSz49XwqFgA7OSD0jol4nQkgMbW7y2UMSf8WDMApp2isSPns5aCDp
 FrBQXwlifp8Ekj5XNBW7jVvWiL7fI7Dyb9uDrvH7d67KntDWcfixfUAEtwZzGzuv
 m1qhq0i3d6gzjzuMiOZRVW9LZOMy/KLsDb/ibVaMxSqKwaP0GCV7BWcVtepKmWbK
 LNzxmF3T8BkSOfGm69Wx4wf8Hy5NaAlXKuAN9ST3quirqHkQmLKRg9xQ2OZ+KrIi
 qe/a8WN0mBPQVBVetQxpPU4fLL/4+S+0A61GR2rztK+kOBprKuHI6N3pth9TPrUG
 blsdaFaZGG6VhVp9Fz5/MQ==
Message-ID: <4d6dffaf-901a-4706-8a14-efe8a3ba3bad@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 14 Oct 2026 22:26:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] igb: Add experimental VF live migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <341bf6d3-27e4-425e-a0b1-0e3767e2db99@rsg.ci.i.u-tokyo.ac.jp>
 <73fe443f-0acd-41b0-a9ca-259f88f0ff88@redhat.com>
 <fd08029a-4822-4ccc-8033-a981b8ddbbe3@rsg.ci.i.u-tokyo.ac.jp>
 <34a84565-bb0e-4e6b-b5dc-480c2990740e@redhat.com>
 <c4cbc75f-6629-44cd-834e-c84ac7a1eb0e@rsg.ci.i.u-tokyo.ac.jp>
 <e72a18ba-7319-442e-afeb-d7c9f279a06b@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e72a18ba-7319-442e-afeb-d7c9f279a06b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/14 17:46, Cédric Le Goater wrote:
> On 10/14/26 03:40, Akihiko Odaki wrote:
>> On 2026/10/13 16:20, Cédric Le Goater wrote:
>>> Hello Akihiko,
>>>
>>> I finally found the time to address the comments from your review.
>>> Some more replies below.
>>>
>>>
>>> On 9/17/26 21:49, Akihiko Odaki wrote:
>>>> On 2026/09/15 17:20, Cédric Le Goater wrote:
>>>>> On 9/9/26 09:19, Akihiko Odaki wrote:
>>>>>> On 2026/09/03 4:20, Cédric Le Goater wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - 
>>>>>>> is a
>>>>>>> growing requirement, but real hardware with migration support is
>>>>>>> scarce and hard to debug. An emulated device provides a fully
>>>>>>> controlled testbed for developing and validating the entire software
>>>>>>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>>>>>>> QEMU, libvirt - and for tuning complex migration policies such as
>>>>>>> downtime convergence. It also serves as an educational reference for
>>>>>>> understanding VFIO migration end-to-end, from device state
>>>>>>> serialization to dirty page tracking.
>>>>>>>
>>>>>>> This series adds an experimental VF live migration interface to the
>>>>>>> emulated igb (82576) device. It enables a vfio-pci variant driver
>>>>>>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>>>>>>> protocol with stop-copy and pre-copy support.
>>>>>>>
>>>>>>> The target scenario is nested virtualization:
>>>>>>>
>>>>>>>    L0 QEMU (these patches)
>>>>>>>      igb PF with x-vf-migration=on
>>>>>>>      └── VFs with migration DVSEC
>>>>>>>
>>>>>>>    L1 kernel
>>>>>>>      igb-vfio-pci variant driver [1]
>>>>>>>      translates VFIO migration v2 ioctls → DVSEC config writes
>>>>>>>
>>>>>>>    L1 QEMU (stock, unmodified)
>>>>>>>      vfio-pci device model, standard migration fd
>>>>>>>
>>>>>>>    L2 guest
>>>>>>>      standard igbvf driver, unaware of migration
>>>>>>>
>>>>>>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>>>>>>> migratable device and uses the normal migration fd path.
>>>>>>>
>>>>>>> * Design
>>>>>>>
>>>>>>> The migration interface is exposed through a DVSEC (Designated
>>>>>>> Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
>>>>>>> 0x160 in VF extended config space. The DVSEC uses a command doorbell
>>>>>>> model - all commands are synchronous via PCI config space writes.
>>>>>>>
>>>>>>> Device state is serialized as a versioned blob of per-VF register
>>>>>>> (offset, value) pairs covering control, interrupt, RX/TX queue,
>>>>>>> receive address (RA/RA2), etc. plus TX context descriptors and
>>>>>>> VFRE/VFTE enable bits. The buffer address is a guest physical
>>>>>>> address (GPA) written by the driver via virt_to_phys; the device
>>>>>>> accesses guest RAM directly through the system address space.
>>>>>>>
>>>>>>> Dirty page tracking is implemented with per-range bitmaps maintained
>>>>>>> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
>>>>>>> descriptor writeback) are instrumented to record touched pages. The
>>>>>>> variant driver registers tracked IOVA ranges and queries dirty 
>>>>>>> bitmaps
>>>>>>> through a shared buffer. Buffer structures include len, flags, and
>>>>>>> reserved fields for future extensibility.
>>>>>>>
>>>>>>> * Caveats
>>>>>>>
>>>>>>> The x-vf-migration property is experimental (x- prefix, default 
>>>>>>> off).
>>>>>>>
>>>>>>> The dirty bitmaps are maintained inside the device, which is not
>>>>>>> realistic for discrete NICs without on-chip DRAM.
>>>>>>>
>>>>>>> * Testing
>>>>>>>
>>>>>>> The target scenario is nested virtualization: L0 runs QEMU with an
>>>>>>> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
>>>>>>> and an unmodified QEMU, and L2 runs a standard igbvf driver.
>>>>>>>
>>>>>>> Migration under iperf3 load works correctly: dirty page tracking
>>>>>>> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>>>>>>> STOP_COPY), and STOP_COPY stays under 250ms.
>>>>>>>
>>>>>>> * Todo
>>>>>>>
>>>>>>>    1. Add migration blocker when x-vf-migration=on (no VMState 
>>>>>>> yet) or
>>>>>>>       add VMState support for L0 migration (dirty bitmaps, tracking
>>>>>>>       engines, DVSEC registers, stats)
>>>>>>>    2. Add PRE_COPY state transfer to validate device INIT data 
>>>>>>> (magic,
>>>>>>>       version, etc.)
>>>>>>>    3. Add qtests for migration state machine transitions, dirty page
>>>>>>>       tracking ?
>>>>>>>
>>>>>>> * Ideas
>>>>>>>
>>>>>>>    1. RX bandwidth throttle (x-mig-rx-limit, uint32, default 0)
>>>>>>>
>>>>>>>       Return false from can_receive when the per-VF packet count 
>>>>>>> in the
>>>>>>>       current tracking interval exceeds the limit. Reduces DMA 
>>>>>>> writes
>>>>>>>       and dirty pages realistically.
>>>>>>>
>>>>>>>    2. Migration phase timing (GET_STATS extension)
>>>>>>>
>>>>>>>       Add per-VF timestamps: precopy_start_ns, stopcopy_start_ns,
>>>>>>>       precopy_duration_ns, stopcopy_duration_ns,
>>>>>>>       state_transition_count. Expose via GET_STATS.
>>>>>>>
>>>>>>>    3. Hot page simulation (x-mig-hot-pages, uint32, default 0)
>>>>>>>
>>>>>>>       Re-set the first N bitmap bits after each DIRTY_QUERY, 
>>>>>>> simulating
>>>>>>>       workloads with hot pages that prevent convergence.
>>>>>>>
>>>>>>>    4. Error injection (x-mig-inject-error, uint32, default 0)
>>>>>>>
>>>>>>>       One-shot error code injection before command dispatch. A 
>>>>>>> separate
>>>>>>>       x-mig-inject-dma-fail (bool) for persistent DMA failure 
>>>>>>> testing.
>>>>>>>
>>>>>>> * Credits
>>>>>>>
>>>>>>> Alex Williamson suggested the overall approach of a variant driver
>>>>>>> with the "x-vf-migration" device property to gate the feature. 
>>>>>>> Thanks
>>>>>>> for the ever ongoing support and valuable discussions throughout 
>>>>>>> these
>>>>>>> years.
>>>>>>>
>>>>>>> * AI disclaimer
>>>>>>>
>>>>>>> The lack of a migration-capable device has been a recurring pain 
>>>>>>> point
>>>>>>> for VFIO development over the years, and we hope this proposal
>>>>>>> demonstrates the value of having one.
>>>>>>>
>>>>>>> Claude was used to analyze the IGB PF and VF internal state and
>>>>>>> identify the pain points of a working live migration of such 
>>>>>>> devices.
>>>>>>> The generated code served as a starting point but *significant* time
>>>>>>> was then spent cleaning up, reworking, and shaping it into a clear,
>>>>>>> reviewable IGB model extension.
>>>>>>>
>>>>>>> As QEMU does not yet accept AI-assisted contributions, this 
>>>>>>> series is
>>>>>>> submitted as an RFC.
>>>>>>
>>>>>> This largely repeats the concerns I raised previously [1]. Your 
>>>>>> description of the *significant* time spent cleaning up and 
>>>>>> reworking the generated code suggests that this series is intended 
>>>>>> for upstream inclusion once the implementation direction is agreed. 
>>>>>
>>>>> Yes. The IGB kernel vfip-pci variant driver is "ready", and so is the
>>>>> internal test framework for VFIO migration. The emulated IGB device
>>>>> is also becoming increasingly important as a reference device for
>>>>> the kernel VFIO self-tests. See:
>>>>>
>>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/ 
>>>>> linux.git/ commit?id=1583ef1175ba533e326dfeff6d8b9f3aaf761225
>>>>>
>>>>>> My concerns as a maintainer are therefore correctness and 
>>>>>> maintainability.
>>>>>
>>>>> I am trying to avoid too much intrusion in the core igb model :
>>>>>
>>>>>   hw/net/igb_common.h                   |   16 +
>>>>>   hw/net/igb_core.h                     |   11 +
>>>>>   hw/net/igb.c                          |    7 +
>>>>>   hw/net/igb_core.c                     |  124 ++-
>>>>>   hw/net/igbvf.c                        |   52 +-
>>>>>
>>>>> These are mostly code movement or additions. The runtime is hardly
>>>>> impacted apart from the DMA tracking, which adds one indirection.
>>>>>
>>>>> I have added myself as Maintainer for the migration part :
>>>>>
>>>>>    +igb VF migration
>>>>>    +M: Cédric Le Goater <clg@redhat.com>
>>>>>    +S: Maintained
>>>>>    +F: hw/net/igb_migration.*
>>>>>
>>>>> I can add you in the next respin. That would be a natural choice
>>>>> from my perspective, but I don't want to impose it on you.
>>>>
>>>> My concern about maintainability is not primarily the line count in 
>>>> igb_core.c, but the correctness of the architecture as a whole.
>>>>
>>>> The migration layer inherently depends on deep assumptions about the 
>>>> core device model. For example, my feedback on this version 
>>>> highlighted dependencies on RA handling, VLAN filtering, and the 
>>>> interrupt state machine. Moving migration logic into a separate file 
>>>> isolates the file footprint, but it does not remove these underlying 
>>>> functional dependencies.
>>>>
>>>>>> The missing migration blocker is a concrete example: it is a basic 
>>>>>> correctness issue that should be straightforward to address, yet 
>>>>>> it remains a TODO. 
>>>>>
>>>>> yes. It's identified and easy to address. It can come at the end once
>>>>> all other issues have been discussed. What worries me the most is the
>>>>> control plane : interface with the Linux driver. That is the most
>>>>> important part on which these changes depend on getting it right :
>>>>>
>>>>>    https://github.com/legoater/linux/commits/vfio/
>>>>
>>>> That makes sense. If the immediate goal is to review the control 
>>>> plane interface while save/load state remains incomplete, it would 
>>>> help to explicitly state that scope in the cover letter, along with 
>>>> the current limitations in implementation and testing.
>>>>
>>>>>
>>>>>> My comments on individual patches also raise the same kinds of 
>>>>>> issues I pointed out in the previous version.
>>>>>
>>>>> You're being tough on me ! I did all this fixing below ! :)
>>>>>
>>>>> * Changes since rfc-v1
>>>>>
>>>>>    - Migration BAR replaced with DVSEC at offset 0x160 (no BAR needed)
>>>>>    - Wire-format structs (IgbMigBlob, IgbMigRegPair, IgbMigTxCtx)
>>>>>      replace raw pointer arithmetic and memcpy
>>>>>    - RA entries separated from fixed regs, scanned by pool bit
>>>>>    - VFN relocation support (offset remapping + RA pool bit swap)
>>>>>    - GPA buffer (address_space_read/write) replaces PCI DMA through PF
>>>>>    - State blob validation on load (magic, version, error codes)
>>>>>    - NEED_WORDS macro and igb_vf_offset_valid removed
>>>>>    - Error codes renumbered: removed BAD_VFN, added UNK_CMD (1-11)
>>>>>
>>>>>    Reported by Akihiko Odaki:
>>>>>
>>>>>    - propagate_irqs: clear VF bits before OR (EIMS/EIAC/EIAM)
>>>>>    - propagate_ivar: clear IVAR entry when source VTIVAR is invalid
>>>>>    - rearm_irqs: restore actual PVTEICR causes, not all three
>>>>>    - Dirty bitmap allocation uses BITS_TO_LONGS (heap corruption fix)
>>>>>    - Dirty query validates range before g_malloc0 (memory exhaustion)
>>>>>    - Dirty bits cleared only after successful bitmap DMA write
>>>>>    - Dirty query buffer uses struct offsets (layout mismatch fix)
>>>>>    - Load path: register offsets validated against VF whitelist
>>>>>    - VMBMEM (mailbox payload) documented as transient, not serialized
>>>>>    - dma_writes counter: consistently uint64_t
>>>>>    - Dirty range_size: consistently uint64_t (was truncated to 32 
>>>>> bits)
>>>>>    - ERROR->STOP: quiesce VF (clear VFRE/VFTE) on transition
>>>>>    - rearm_irqs: runs on re || te, not just re (TX-only VF fix)
>>>>>    - Stats DMA-written atomically via GET_STATS (no split MMIO tear)
>>>>>    - Bisectability: DVSEC + state machine introduced together
>>>>>    - Removed NAPI reference and "===" comment decoration
>>>>
>>>> I appreciate the progress, and I certainly don't mean to minimize 
>>>> the effort put into fixing these issues.
>>>>
>>>> However, many of these bugs stem from the same root cause: high- 
>>>> level systemic requirements, such as boundary checks, VF 
>>>> renumbering, interrupt state preservation, and OS-independence, are 
>>>> being addressed piecemeal as individual bugs arise. I would like to 
>>>> see these requirements enforced systematically across the entire 
>>>> implementation rather than patched reactively. Replacing raw 
>>>> pointers with explicit wire-format structures across the protocol is 
>>>> a great example of the kind of systematic fix I mean.
>>>
>>>
>>>
>>> The v3 series enforces these requirements structurally. The migration
>>> blob uses a typed wire-format struct. Load is two-phase: the blob is
>>> validated before any core state is modified, so a malformed blob does
>>> not leave the device partially updated. VFN mismatch is rejected.
>>> Interrupt mask bits are captured from the PF aggregates before quiesce.
>>
>> The typed format and validation before modifying device state sound
>> like useful improvements. I will assess those changes when v3 is
>> available.
> 
> 
> Will send today.
> 
> 
>>
>>>
>>>
>>>>>>
>>>>>> Many of the correctness problems found in v1 and v2 stem from the 
>>>>>> choice to build on igb, which is more complex than virtio-net. 
>>>>>> That is why I suggested using virtio-net as a simpler basis, 
>>>>>> unless there is a problem that rules it out.
>>>>>
>>>>> virtio-net is a software abstraction designed for virtualization.
>>>>>
>>>>> Here’s my pitch for igb:
>>>>>
>>>>> Using an emulated igb device addresses a different problem: validating
>>>>> migration of hardware-like devices. igb exposes a real PCI device
>>>>> model, hardware-driver interface, DMA engines, queues, interrupts and
>>>>> SR-IOV VFs. It allows migration to be implemented at the same
>>>>> abstraction boundary at which VFIO migrates physical devices, rather
>>>>> than being reduced to serialization of a paravirtualized protocol
>>>>> state. Also,
>>>>>
>>>>> The igb VF uses the inbox igbvf kernel driver, which matches the
>>>>> hardware VFIO promise: transparent migration with unmodified guest
>>>>> drivers.
>>>>> The DVSEC extended capability is a discoverable and standard control
>>>>> plane with the device. This is a mechanism a hardware vendor could
>>>>> use.
>>>>> One cool aspect of an emulated device is that it allows the state to
>>>>> be inspected, the behavior is deterministic and faults can be injected
>>>>> at any boundary. That's the QEMU bonus.
>>>>
>>>> I understand the motivation to test hardware-like device migration. 
>>>> However, modern virtio-net devices are also implemented in physical 
>>>> SmartNICs/DPUs and expose standard PCI interfaces, BARs, DMA 
>>>> engines, queues, interrupts, and SR-IOV VFs.
>>>>
>>>> Using virtio-net as a VFIO test device would not require guest 
>>>> driver changes or bypass hardware-like semantics. Given its cleaner 
>>>> separation of state, it remains a strong fit for these testing 
>>>> requirements without carrying igb's extra complexity.
>>>
>>>
>>> virtio-net already has a clean migration path via its own protocol.
>>> The goal here is different. igb models a real hardware interface that
>>> mirrors what VFIO migration must handle with physical devices.
>>> virtio's cleaner separation is an advantage for production, but it
>>> doesn't exercise the same problems.
>>
>> As I mentioned previously, virtio-net is already implemented in
>> physical NICs. It is a vendor-neutral interface for network devices,
>> whether paravirtualized or physical. igb, by comparison, implements
>> an Intel-specific legacy hardware interface.
>>
>> A physical virtio-net device is arguably a more realistic target for
>> a migration mechanism like the one proposed here than an Intel
>> 82576. Adding a new migration interface to the emulated igb device
>> does not make that interface representative of existing igb hardware.
>>
>> My suggestion was to use virtio-net as the device behind VFIO in the
>> same nested setup. L1 QEMU would still exercise VFIO migration, and
>> L2 would still use its ordinary guest driver.
>>
>>>
>>>
>>>>
>>>>>
>>>>>> I would be willing to support allowing AI use in the project for 
>>>>>> work like this. I would still need to see these correctness and 
>>>>>> maintainability concerns addressed before I could support merging 
>>>>>> the series.
>>>>>
>>>>> I agree. The save/load is still in progress and we might need some
>>>>> more intrusive changes in igb to support migration of all state.
>>>>> To start with, we could detect and warn.
>>>>
>>>> Starting with a restricted set of supported configurations is a 
>>>> reasonable way forward. However, for features whose state cannot yet 
>>>> be restored accurately, we should reject migration rather than 
>>>> merely issue a warning. Otherwise, a completed migration risks 
>>>> silently corrupting guest-visible device behavior.
>>>
>>>
>>> Reject was the approach taken in v3. However, I made the choice to
>>> fixup the MTA/UTA table. Restore widens the receive filter (OR missing
>>> entries), never drops existing ones. The worst case is a few extra
>>> frames that the guest stack would have discarded. Rejecting migration
>>> over transient IGMP/mDNS differences would be disproportionate.
>>
>> My concern is whether that restoration survives subsequent PF driver
>> operations.
>>
>> For example, Linux's igb driver records each VF's multicast hashes in 
>> its own software state. A multicast update from another VF calls 
>> igb_set_rx_mode(), which rebuilds the MTA and restores each VF's 
>> multicast configuration from those records. It also rewrites the VMOLR 
>> multicast enable bits.
>>
>> Consequently, unless v3 also reconciles the destination PF driver's 
>> records, a later update could remove the migrated VF's multicast 
>> reception. OR-ing the device tables at load time would not address 
>> that dependency.
> 
> 
> Agree. The fixup is not durable. the merged entries will be dropped
> on the next MTA rebuild.
> 
> A proper fix requires QEMU to track per-VF multicast hashes, and
> restore them on load either through a new DVSEC command or by
> injecting a VF mailbox message to the L1 PF driver.

Tracking the hashes would provide the state to restore, but the
destination PF driver's bookkeeping also needs to agree with the
restored device state. A new DVSEC command would need a defined path
for updating that bookkeeping. Mailbox injection would require
coordination with ordinary mailbox traffic and completion handling.

I am not prescribing either mechanism. I would like to see the
complete restoration flow, including how subsequent PF operations
preserve the restored configuration. The same ownership question
also needs to be considered for the other PF-managed resources.

> 
> 
>>>> This is another advantage of virtio-net: feature negotiation offers 
>>>> a clean, standard mechanism to disable unsupported features and 
>>>> define a tightly constrained initial scope that is fully migratable.
>>>
>>>
>>> virtio feature negotiation is a software construct. The DVSEC CAPS
>>> register models the mechanism a hardware vendor would actually use to
>>> advertise migration capabilities. Not as rich as virtio, but closer to
>>> real hardware.
>>
>> virtio feature negotiation is part of the device interface and also
>> applies to hardware implementations. It is not specific to software
>> devices.
>>
>> My point concerned limiting the features exposed to the guest so that 
>> every enabled feature is supported by migration. Advertising migration 
>> capabilities serves a different purpose.
> 
> igb doesn't have the feature negotiation mechanism to limit the
> features, and the MTA/UTA is a gap.
> 
> Since multicast hash filtering is always active, rejecting on
> VMOLR.ROMPE would block migration entirely :/ I don't have a
> good answer for that apart from implementing the above fix.

ROMPE is conditional: Linux's igb_restore_vf_multicasts() clears it
when the VF has no multicast subscriptions. However, I understand
that rejecting it would exclude ordinary guest configurations.

If rejecting unsupported state excludes the intended workloads,
then supporting that state is a prerequisite for those workloads.
That does not make silently accepting an incomplete restoration
correct.

> For v4 ?

Addressing this in v4 is reasonable for an RFC. In the meantime,
please document the limitation and reject affected migrations.
I would need this resolved before supporting a merge.

This is also why I continue to suggest virtio-net: its cleaner state
separation reduces the coordination required for correct migration.
The additional complexity here follows from igb's PF/VF interface,
rather than from the VFIO migration framework itself.

Unless I am missing something, virtio-net appears to align better with 
your overall goals than igb. While porting this VF live migration 
mechanism to another device by hand would be daunting, I hope AI makes 
such an experiment more tractable, allowing us to evaluate and choose 
the best path forward based on concrete implementations.

Regards,
Akihiko Odaki

