Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EABC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woai2-0005Ne-Ja; Tue, 28 Jul 2026 01:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woahw-0005NL-4J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:50:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woahr-0002DQ-QT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:50:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S5oAhE097573
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 14:50:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gh3FrXKT3CkUrEOSTp9fwDrN0cOgJCnitWvZSuSYlYQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785217811; v=1;
 b=M/rfVd6IgyLwSM5j2n8bY3wASX2G6yFOu9/Kttw//zvnrInI8UMj/+MzSoMk1F4H
 V4xGrqIrnKsb5zfJcriiyv0CcW8iUVPF2N1diqlQgXUawQjv+l2i/PExvK1LA0BN
 6CpySlAiPQDjDRsjaCMFFa5MSqvqtO4pSE4kyMndm6HiBwm6UThtSm7VHFErUecM
 PYXfCbc2vbzz4JgPRA0xk1ScqQyiZduse3luJb981pQ8zYslenrk02J0Aycz+LcU
 K+GWPb/sDl6gE6ci/zaBOjOqONHj6bQS7EwihPlKMxHkB8iXAaU4sNWFxmg4Rzlm
 co3pKq7EEUKlilcYgcycLg==
Message-ID: <e876234f-312a-495c-837b-5cf64195a622@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 14:50:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] igb: Add experimental VF live migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <ad1d1648-9bfa-4539-9bbc-86577ccff2c3@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ad1d1648-9bfa-4539-9bbc-86577ccff2c3@redhat.com>
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

On 2026/07/28 2:35, Cédric Le Goater wrote:
> Akihiko,
> 
> On 7/27/26 07:39, Cédric Le Goater wrote:
>> Hello,
>>
>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
>> growing requirement, but real hardware with migration support is
>> scarce and hard to debug. An emulated device provides a fully
>> controlled testbed for developing and validating the entire software
>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>> QEMU, libvirt - and for tuning complex migration policies such as
>> downtime convergence. It also serves as an educational reference for
>> understanding VFIO migration end-to-end, from device state
>> serialization to dirty page tracking.

This is another good example of using QEMU as a SR-IOV testbed.

>>
>> This series adds an experimental VF live migration interface to the
>> emulated igb (82576) device. It enables a vfio-pci variant driver
>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>> protocol with stop-copy and pre-copy support.
I suggest looking into virtio-net as an alternative to igb. It would 
allow avoiding lots of complexities of igb.

>>
>> The target scenario is nested virtualization:
>>
>>    L0 QEMU (these patches)
>>      igb PF with x-vf-migration=on
>>      └── VFs with migration BAR + vendor cap
>>
>>    L1 kernel
>>      igb-vfio-pci variant driver [1]
>>      translates VFIO migration v2 ioctls → BAR2 MMIO
>>
>>    L1 QEMU (stock, unmodified)
>>      vfio-pci device model, standard migration fd
>>
>>    L2 guest
>>      standard igbvf driver, unaware of migration
>>
>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>> migratable device and uses the normal migration fd path.
>>
>> * Design
>>
>> The migration interface is exposed through a hidden 64KB PCI BAR
>> (BAR2) on each VF, discovered via a vendor-specific PCI capability
>> ("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
>> machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
>> RESUMING, PRE_COPY).
>>
>> Device state is serialized as a versioned blob of per-VF register
>> (offset, value) pairs covering control, interrupt, RX/TX queue,
>> receive address (RA/RA2), etc. plus TX context descriptors and
>> VFRE/VFTE enable bits. The blob is transferred via DMA through the PF
>> device, since VFIO owns the VF's IOMMU domain and the variant driver
>> maps its DMA buffers through the PF.
>>
>> Dirty page tracking is implemented with per-range bitmaps maintained
>> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
>> descriptor writeback) are instrumented to record touched pages. The
>> variant driver registers tracked IOVA ranges and queries dirty bitmaps
>> through a DMA shared buffer, using a single MMIO doorbell
>> (DIRTY_CTRL=QUERY) per iteration.
>>
>> * Caveats
>>
>> Patch 1 introduces PCI_BASE_ADDRESS_MEM_ALWAYS_ON, a QEMU-internal
>> BAR flag that keeps the migration BAR mapped even after VFIO's
>> Function Level Reset clears PCI_COMMAND_MEMORY.
>>
>> The x-vf-migration property is experimental (x- prefix, default off)
>> and the migration BAR register interface may change.
>>
>> The dirty bitmaps are maintained inside the device, which is not
>> realistic for discrete NICs without on-chip DRAM.
>>
>> * Testing
>>
>> The target scenario is nested virtualization: L0 runs QEMU with an
>> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
>> and an unmodified QEMU, and L2 runs a standard igbvf driver.
>>
>> Migration under iperf3 load works correctly: dirty page tracking
>> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>> STOP_COPY), and STOP_COPY stays under 250ms.
>>
>> * Todo/Ideas
>>
>>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>>       add VMState support for L0 migration (dirty bitmaps, tracking
>>       engines, migration BAR registers, stats)

If you have AI assistance, why don't you just add migration blocker? It 
should be just one prompt away and not more troublesome than leaving 
this "Todo". ;)

>>    2. Add PRE_COPY match data validation (magic, version, caps)
>>    3. Support driver-provided DMA bitmaps per dirty range
>>       (DIRTY_RANGE_ADDR_LO/HI)
>>    4. Add QMP/HMP knobs for error injection and capability tuning:
>>      . Dirty rate throttling: artificial delay or rate limit on DMA
>>        dirty tracking to simulate different convergence scenarios
>>      . State blob size inflation: pad the migration blob to stress
>>        large-state transfers and test DATA_SIZE limits
>>      . Migration phase timing: expose per-VF counters for time spent
>>        in each state (PRE_COPY duration, STOP_COPY latency)
>>      . Hot page simulation: mark specific page ranges as always-dirty
>>        to test worst-case convergence
>>      . Error injection: force STATUS error codes, fail DMA transfers,
>>        corrupt state blobs, mask CAPS bits, etc.
>>    5. Add qtests for migration state machine transitions, dirty page
>>       tracking ?
>>
>> * Credits
>>
>> Alex Williamson suggested the overall approach: a hidden migration BAR
>> discovered via a vendor-specific PCI capability, the "vf-migration"
>> device property to gate the feature. Thanks for the ever ongoing
>> support and valuable discussions throughout these years.
>>
>> * AI disclaimer
>>
>> The lack of a migration-capable device has been a recurring pain point
>> for VFIO development over the years, and we hope this proposal
>> demonstrates the value of having one.
>>
>> Claude was used to analyze the IGB PF and VF internal state and
>> identify the pain points of a working live migration of such devices.
>> The generated code served as a starting point but *significant* time
>> was then spent cleaning up, reworking, and shaping it into a clear,
>> reviewable proposal. As QEMU does not yet accept AI-assisted
>> contributions, this series is submitted as an RFC.
>>
>> Thanks,
>>
>> C.
>>
>> [1] https://github.com/legoater/vfio-pci-extras
>>
>> Cédric Le Goater (11):
>>    pci: Add PCI_BASE_ADDRESS_MEM_ALWAYS_ON BAR flag
>>    igb: Add x-vf-migration property and vendor-specific capability for
>>      IGBVF
>>    igb: Add migration BAR with state machine
>>    igb: Add VF state serialization for live migration
>>    igb: Add VF post-load fixups for live migration
>>    igb: Add dirty page tracking for IGBVF migration
>>    igb: Quiesce VFs on STOP and include PF enable state in migration blob
>>    igb: Fix post-migration RX ring deadlock
>>    igb: Send RARP after VF migration to update bridge FDB
>>    docs: Add igb VF migration testing setup guide
>>    igb: Add migration statistics registers to VF migration BAR
>>
>>   MAINTAINERS                           |    6 +
>>   docs/system/device-emulation.rst      |    1 +
>>   docs/system/devices/igb-migration.rst |  313 +++++++
>>   docs/system/devices/igb.rst           |    6 +
>>   hw/net/igb_common.h                   |   11 +
>>   hw/net/igb_core.h                     |    8 +
>>   hw/net/igb_migration.h                |  201 +++++
>>   include/hw/pci/pci.h                  |    6 +
>>   hw/net/igb.c                          |   18 +
>>   hw/net/igb_core.c                     |  144 ++-
>>   hw/net/igb_migration.c                | 1194 +++++++++++++++++++++++++
>>   hw/net/igbvf.c                        |   29 +-
>>   hw/pci/pci.c                          |    6 +-
>>   hw/net/meson.build                    |    2 +-
>>   hw/net/trace-events                   |   20 +
>>   15 files changed, 1939 insertions(+), 26 deletions(-)
>>   create mode 100644 docs/system/devices/igb-migration.rst
>>   create mode 100644 hw/net/igb_migration.h
>>   create mode 100644 hw/net/igb_migration.c
>>
> 
> First thanks for the quick review ! I will recap here :
> 
> * bisectability, will improve the first patches.
> * state serialization, the blob management is awful. I was expecting
>    flames. Yes. it needs a rework. I lack a qbuf-style put/get API. The
>    contents of the blob need a review. Seems feasible.
> * relocation between VFs, on my TODO. The code already checks the vfn but
>    needs tightening and better support.
> * interrupts bits: will look into it. hopefully, the model "only" needs
>    to be more precise. This was a difficult aspect of the igb to understand
>    and I am still learning.
> * dirty tracking, I worked on 2 different interfaces and some of the code
>    fell through the cracks. DMA failures, bitmap clearing, size validation,
>    all need improvements. Mostly addressed already, remaining items are 
> code
>    reorg. should be fine.
> * quiesce: looks like a bug in the model. Will check.
> * RARP : I got inspiration from the tests. you are right saying it belongs
>    to the management layer. Keeping it for now as it simplifies testing, 
> but
>    will move it out.
> * Stats: the addition is from yesterday. Needs fixes indeed.

Thanks for the summary. Well, the "AI disclaimer" states that you spent 
significant time on cleanup, but your recap highlights several critical 
issues.

Ideally, AI assistance should minimize manual labor while keeping 
quality high. Right now, the workflow seems inverted: the AI created the 
basic scaffolding, you spent significant time reworking it, yet critical 
flaws not mentioned in the "Caveats" and "Todo/Ideas" sections still 
remain. I believe we can do better with AI assistance.

In fact, I am part of the Codex for Open Source program and use GPT-5.6 
Sol Ultra extensively for reviews. It is quite effective at raising 
quality while cutting down manual effort. Most of the comments I 
provided came directly from Codex using a simple prompt: "review each 
commit." The model somehow possesses a latent understanding of QEMU 
requirements, allowing it to flag issues like bisectability breaks and 
lack of L0/L1/L2 boundary enforcement.

I expect that iterating with prompts like "review each commit" and "fix 
these issues" would automatically resolve most of these problems, 
reducing error-prone human intervention. I am not sure if Claude has the 
same depth of virtualization-specific knowledge, but even if it doesn't, 
you can feed your recap back into the model to let it handle the heavy 
lifting.

Moving forward, I see two potential directions for this work:

- Focus on high-level design: Explore alternative architectures like 
hacking virtio-net SR-IOV or keeping RARP out of QEMU. You could send 
the results as a fresh RFC while openly noting the rough edges. This 
allows us to discuss the design architecture without spending massive 
effort polishing the implementation details.

- Focus on code quality and advocacy: Burn more tokens to improve the 
code quality. Use this series as a concrete case study to demonstrate 
that AI assistance can successfully implement complex virtualization 
features. This could help shift project policy regarding AI usage and 
pave the way for upstreaming this and future AI-assisted patches.

Whichever direction you choose, reframing the narrative in the cover 
letter will better align the series with the project's goals.

Regards,
Akihiko Odaki

