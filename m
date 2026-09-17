Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A35C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7I6u-0000Pg-Sr; Thu, 17 Sep 2026 15:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7I6o-0000PT-0W
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:49:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7I6k-0005TU-23
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:49:25 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68HJn7Ef068508
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 04:49:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=czVniBCtYL8qvhPrDgCaqJy/H8WVQojLM1zUvY9ocCc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789674548; v=1;
 b=DTeiQjMpCHyHSLEtKtRoIeVt4w1HKSc1tR+kC/9isbGzbhdLjc2qcpu7zu6OucW5
 vH2pORlR+Kg+Bg35RwL2iUC9gb4w+NuH8xA9vbIYVmR5JSMP3/dMkY8FA+6BnjXO
 ENV2WKHHmbl4Yvv43iPha5bGcjvcTd1x3FiKRBo2jaDPKixSn0KefM/kHeOXhlrd
 LdNXhGwZWx0ikR2MPMUAoUen8hUWdkKBB+1HNUzVlyoXmKjrdHOWreRZPvI708Hg
 CZhDktLfp+dgMv+7OcSH9D/KbDDfP8FATsDD6jxB0pHu6SAO6jnHbLp3zLJepRtx
 1K3p5367+QJgSVUYMlq8cA==
Message-ID: <fd08029a-4822-4ccc-8033-a981b8ddbbe3@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 04:49:07 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <73fe443f-0acd-41b0-a9ca-259f88f0ff88@redhat.com>
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

On 2026/09/15 17:20, Cédric Le Goater wrote:
> On 9/9/26 09:19, Akihiko Odaki wrote:
>> On 2026/09/03 4:20, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
>>> growing requirement, but real hardware with migration support is
>>> scarce and hard to debug. An emulated device provides a fully
>>> controlled testbed for developing and validating the entire software
>>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>>> QEMU, libvirt - and for tuning complex migration policies such as
>>> downtime convergence. It also serves as an educational reference for
>>> understanding VFIO migration end-to-end, from device state
>>> serialization to dirty page tracking.
>>>
>>> This series adds an experimental VF live migration interface to the
>>> emulated igb (82576) device. It enables a vfio-pci variant driver
>>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>>> protocol with stop-copy and pre-copy support.
>>>
>>> The target scenario is nested virtualization:
>>>
>>>    L0 QEMU (these patches)
>>>      igb PF with x-vf-migration=on
>>>      └── VFs with migration DVSEC
>>>
>>>    L1 kernel
>>>      igb-vfio-pci variant driver [1]
>>>      translates VFIO migration v2 ioctls → DVSEC config writes
>>>
>>>    L1 QEMU (stock, unmodified)
>>>      vfio-pci device model, standard migration fd
>>>
>>>    L2 guest
>>>      standard igbvf driver, unaware of migration
>>>
>>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>>> migratable device and uses the normal migration fd path.
>>>
>>> * Design
>>>
>>> The migration interface is exposed through a DVSEC (Designated
>>> Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
>>> 0x160 in VF extended config space. The DVSEC uses a command doorbell
>>> model - all commands are synchronous via PCI config space writes.
>>>
>>> Device state is serialized as a versioned blob of per-VF register
>>> (offset, value) pairs covering control, interrupt, RX/TX queue,
>>> receive address (RA/RA2), etc. plus TX context descriptors and
>>> VFRE/VFTE enable bits. The buffer address is a guest physical
>>> address (GPA) written by the driver via virt_to_phys; the device
>>> accesses guest RAM directly through the system address space.
>>>
>>> Dirty page tracking is implemented with per-range bitmaps maintained
>>> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
>>> descriptor writeback) are instrumented to record touched pages. The
>>> variant driver registers tracked IOVA ranges and queries dirty bitmaps
>>> through a shared buffer. Buffer structures include len, flags, and
>>> reserved fields for future extensibility.
>>>
>>> * Caveats
>>>
>>> The x-vf-migration property is experimental (x- prefix, default off).
>>>
>>> The dirty bitmaps are maintained inside the device, which is not
>>> realistic for discrete NICs without on-chip DRAM.
>>>
>>> * Testing
>>>
>>> The target scenario is nested virtualization: L0 runs QEMU with an
>>> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
>>> and an unmodified QEMU, and L2 runs a standard igbvf driver.
>>>
>>> Migration under iperf3 load works correctly: dirty page tracking
>>> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>>> STOP_COPY), and STOP_COPY stays under 250ms.
>>>
>>> * Todo
>>>
>>>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>>>       add VMState support for L0 migration (dirty bitmaps, tracking
>>>       engines, DVSEC registers, stats)
>>>    2. Add PRE_COPY state transfer to validate device INIT data (magic,
>>>       version, etc.)
>>>    3. Add qtests for migration state machine transitions, dirty page
>>>       tracking ?
>>>
>>> * Ideas
>>>
>>>    1. RX bandwidth throttle (x-mig-rx-limit, uint32, default 0)
>>>
>>>       Return false from can_receive when the per-VF packet count in the
>>>       current tracking interval exceeds the limit. Reduces DMA writes
>>>       and dirty pages realistically.
>>>
>>>    2. Migration phase timing (GET_STATS extension)
>>>
>>>       Add per-VF timestamps: precopy_start_ns, stopcopy_start_ns,
>>>       precopy_duration_ns, stopcopy_duration_ns,
>>>       state_transition_count. Expose via GET_STATS.
>>>
>>>    3. Hot page simulation (x-mig-hot-pages, uint32, default 0)
>>>
>>>       Re-set the first N bitmap bits after each DIRTY_QUERY, simulating
>>>       workloads with hot pages that prevent convergence.
>>>
>>>    4. Error injection (x-mig-inject-error, uint32, default 0)
>>>
>>>       One-shot error code injection before command dispatch. A separate
>>>       x-mig-inject-dma-fail (bool) for persistent DMA failure testing.
>>>
>>> * Credits
>>>
>>> Alex Williamson suggested the overall approach of a variant driver
>>> with the "x-vf-migration" device property to gate the feature. Thanks
>>> for the ever ongoing support and valuable discussions throughout these
>>> years.
>>>
>>> * AI disclaimer
>>>
>>> The lack of a migration-capable device has been a recurring pain point
>>> for VFIO development over the years, and we hope this proposal
>>> demonstrates the value of having one.
>>>
>>> Claude was used to analyze the IGB PF and VF internal state and
>>> identify the pain points of a working live migration of such devices.
>>> The generated code served as a starting point but *significant* time
>>> was then spent cleaning up, reworking, and shaping it into a clear,
>>> reviewable IGB model extension.
>>>
>>> As QEMU does not yet accept AI-assisted contributions, this series is
>>> submitted as an RFC.
>>
>> This largely repeats the concerns I raised previously [1]. Your 
>> description of the *significant* time spent cleaning up and reworking 
>> the generated code suggests that this series is intended for upstream 
>> inclusion once the implementation direction is agreed. 
> 
> Yes. The IGB kernel vfip-pci variant driver is "ready", and so is the
> internal test framework for VFIO migration. The emulated IGB device
> is also becoming increasingly important as a reference device for
> the kernel VFIO self-tests. See:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
> commit?id=1583ef1175ba533e326dfeff6d8b9f3aaf761225
> 
>> My concerns as a maintainer are therefore correctness and 
>> maintainability.
> 
> I am trying to avoid too much intrusion in the core igb model :
> 
>   hw/net/igb_common.h                   |   16 +
>   hw/net/igb_core.h                     |   11 +
>   hw/net/igb.c                          |    7 +
>   hw/net/igb_core.c                     |  124 ++-
>   hw/net/igbvf.c                        |   52 +-
> 
> These are mostly code movement or additions. The runtime is hardly
> impacted apart from the DMA tracking, which adds one indirection.
> 
> I have added myself as Maintainer for the migration part :
> 
>    +igb VF migration
>    +M: Cédric Le Goater <clg@redhat.com>
>    +S: Maintained
>    +F: hw/net/igb_migration.*
> 
> I can add you in the next respin. That would be a natural choice
> from my perspective, but I don't want to impose it on you.

My concern about maintainability is not primarily the line count in 
igb_core.c, but the correctness of the architecture as a whole.

The migration layer inherently depends on deep assumptions about the 
core device model. For example, my feedback on this version highlighted 
dependencies on RA handling, VLAN filtering, and the interrupt state 
machine. Moving migration logic into a separate file isolates the file 
footprint, but it does not remove these underlying functional dependencies.

>> The missing migration blocker is a concrete example: it is a basic 
>> correctness issue that should be straightforward to address, yet it 
>> remains a TODO. 
> 
> yes. It's identified and easy to address. It can come at the end once
> all other issues have been discussed. What worries me the most is the
> control plane : interface with the Linux driver. That is the most
> important part on which these changes depend on getting it right :
> 
>    https://github.com/legoater/linux/commits/vfio/

That makes sense. If the immediate goal is to review the control plane 
interface while save/load state remains incomplete, it would help to 
explicitly state that scope in the cover letter, along with the current 
limitations in implementation and testing.

> 
>> My comments on individual patches also raise the same kinds of issues 
>> I pointed out in the previous version.
> 
> You're being tough on me ! I did all this fixing below ! :)
> 
> * Changes since rfc-v1
> 
>    - Migration BAR replaced with DVSEC at offset 0x160 (no BAR needed)
>    - Wire-format structs (IgbMigBlob, IgbMigRegPair, IgbMigTxCtx)
>      replace raw pointer arithmetic and memcpy
>    - RA entries separated from fixed regs, scanned by pool bit
>    - VFN relocation support (offset remapping + RA pool bit swap)
>    - GPA buffer (address_space_read/write) replaces PCI DMA through PF
>    - State blob validation on load (magic, version, error codes)
>    - NEED_WORDS macro and igb_vf_offset_valid removed
>    - Error codes renumbered: removed BAD_VFN, added UNK_CMD (1-11)
> 
>    Reported by Akihiko Odaki:
> 
>    - propagate_irqs: clear VF bits before OR (EIMS/EIAC/EIAM)
>    - propagate_ivar: clear IVAR entry when source VTIVAR is invalid
>    - rearm_irqs: restore actual PVTEICR causes, not all three
>    - Dirty bitmap allocation uses BITS_TO_LONGS (heap corruption fix)
>    - Dirty query validates range before g_malloc0 (memory exhaustion)
>    - Dirty bits cleared only after successful bitmap DMA write
>    - Dirty query buffer uses struct offsets (layout mismatch fix)
>    - Load path: register offsets validated against VF whitelist
>    - VMBMEM (mailbox payload) documented as transient, not serialized
>    - dma_writes counter: consistently uint64_t
>    - Dirty range_size: consistently uint64_t (was truncated to 32 bits)
>    - ERROR->STOP: quiesce VF (clear VFRE/VFTE) on transition
>    - rearm_irqs: runs on re || te, not just re (TX-only VF fix)
>    - Stats DMA-written atomically via GET_STATS (no split MMIO tear)
>    - Bisectability: DVSEC + state machine introduced together
>    - Removed NAPI reference and "===" comment decoration

I appreciate the progress, and I certainly don't mean to minimize the 
effort put into fixing these issues.

However, many of these bugs stem from the same root cause: high-level 
systemic requirements, such as boundary checks, VF renumbering, 
interrupt state preservation, and OS-independence, are being addressed 
piecemeal as individual bugs arise. I would like to see these 
requirements enforced systematically across the entire implementation 
rather than patched reactively. Replacing raw pointers with explicit 
wire-format structures across the protocol is a great example of the 
kind of systematic fix I mean.
>>
>> Many of the correctness problems found in v1 and v2 stem from the 
>> choice to build on igb, which is more complex than virtio-net. That is 
>> why I suggested using virtio-net as a simpler basis, unless there is a 
>> problem that rules it out.
> 
> virtio-net is a software abstraction designed for virtualization.
> 
> Here’s my pitch for igb:
> 
> Using an emulated igb device addresses a different problem: validating
> migration of hardware-like devices. igb exposes a real PCI device
> model, hardware-driver interface, DMA engines, queues, interrupts and
> SR-IOV VFs. It allows migration to be implemented at the same
> abstraction boundary at which VFIO migrates physical devices, rather
> than being reduced to serialization of a paravirtualized protocol
> state. Also,
> 
> The igb VF uses the inbox igbvf kernel driver, which matches the
> hardware VFIO promise: transparent migration with unmodified guest
> drivers.
> The DVSEC extended capability is a discoverable and standard control
> plane with the device. This is a mechanism a hardware vendor could
> use.
> One cool aspect of an emulated device is that it allows the state to
> be inspected, the behavior is deterministic and faults can be injected
> at any boundary. That's the QEMU bonus.

I understand the motivation to test hardware-like device migration. 
However, modern virtio-net devices are also implemented in physical 
SmartNICs/DPUs and expose standard PCI interfaces, BARs, DMA engines, 
queues, interrupts, and SR-IOV VFs.

Using virtio-net as a VFIO test device would not require guest driver 
changes or bypass hardware-like semantics. Given its cleaner separation 
of state, it remains a strong fit for these testing requirements without 
carrying igb's extra complexity.

> 
>> I would be willing to support allowing AI use in the project for work 
>> like this. I would still need to see these correctness and 
>> maintainability concerns addressed before I could support merging the 
>> series.
> 
> I agree. The save/load is still in progress and we might need some
> more intrusive changes in igb to support migration of all state.
> To start with, we could detect and warn.

Starting with a restricted set of supported configurations is a 
reasonable way forward. However, for features whose state cannot yet be 
restored accurately, we should reject migration rather than merely issue 
a warning. Otherwise, a completed migration risks silently corrupting 
guest-visible device behavior.

This is another advantage of virtio-net: feature negotiation offers a 
clean, standard mechanism to disable unsupported features and define a 
tightly constrained initial scope that is fully migratable.

Regards,
Akihiko Odaki

