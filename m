Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234EBC79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4CbV-0001hE-9I; Wed, 09 Sep 2026 03:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4CbT-0001gv-PH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:20:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4CbQ-0002Lh-Ew
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:20:19 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6897JwbP013941
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 16:19:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9zm3BeAqumfEnyonaQ7OOMlfpzbFempX9yy0886Xka0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788938398; v=1;
 b=b6rXNNNukM/Utq4E7kOcyl4m87CYanP7Ukfe1zcqZ28j95GxAnV8uJyuJWKasGjO
 u0a+4UMyzs9ZpPTUMvwnIeVgfaZBdaVA2OCFyXvceuTYZfqYa3VfaMy+noG3qDr9
 GyJ0M6xIVL1M/fe0PiiRAzHwJ9ee1a62QJu0nx0EcellMAJmOUtQgWcwnIkamm63
 NC98kPW3pwyq+i4kyIlA+NGpqexPrz1iUz292e7t/3ESsYDe8FJGfZIK0B+K9R2a
 EPN9/htde6XCzZqf9ZJePBH18HuiGwF2OkW0vXw9suGxqQ4tf6I2+pvUmFbCMvWL
 Pmi1RCUuRtOtErHN8vfnHQ==
Message-ID: <341bf6d3-27e4-425e-a0b1-0e3767e2db99@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 16:19:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] igb: Add experimental VF live migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260902192054.3329753-1-clg@redhat.com>
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

On 2026/09/03 4:20, Cédric Le Goater wrote:
> Hello,
> 
> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
> growing requirement, but real hardware with migration support is
> scarce and hard to debug. An emulated device provides a fully
> controlled testbed for developing and validating the entire software
> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
> QEMU, libvirt - and for tuning complex migration policies such as
> downtime convergence. It also serves as an educational reference for
> understanding VFIO migration end-to-end, from device state
> serialization to dirty page tracking.
> 
> This series adds an experimental VF live migration interface to the
> emulated igb (82576) device. It enables a vfio-pci variant driver
> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
> protocol with stop-copy and pre-copy support.
> 
> The target scenario is nested virtualization:
> 
>    L0 QEMU (these patches)
>      igb PF with x-vf-migration=on
>      └── VFs with migration DVSEC
> 
>    L1 kernel
>      igb-vfio-pci variant driver [1]
>      translates VFIO migration v2 ioctls → DVSEC config writes
> 
>    L1 QEMU (stock, unmodified)
>      vfio-pci device model, standard migration fd
> 
>    L2 guest
>      standard igbvf driver, unaware of migration
> 
> The L1 QEMU is completely unmodified -- it sees a standard VFIO
> migratable device and uses the normal migration fd path.
> 
> * Design
> 
> The migration interface is exposed through a DVSEC (Designated
> Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
> 0x160 in VF extended config space. The DVSEC uses a command doorbell
> model - all commands are synchronous via PCI config space writes.
> 
> Device state is serialized as a versioned blob of per-VF register
> (offset, value) pairs covering control, interrupt, RX/TX queue,
> receive address (RA/RA2), etc. plus TX context descriptors and
> VFRE/VFTE enable bits. The buffer address is a guest physical
> address (GPA) written by the driver via virt_to_phys; the device
> accesses guest RAM directly through the system address space.
> 
> Dirty page tracking is implemented with per-range bitmaps maintained
> in IGBCore. All VF DMA paths in igb_core.c (TX data, RX data,
> descriptor writeback) are instrumented to record touched pages. The
> variant driver registers tracked IOVA ranges and queries dirty bitmaps
> through a shared buffer. Buffer structures include len, flags, and
> reserved fields for future extensibility.
> 
> * Caveats
> 
> The x-vf-migration property is experimental (x- prefix, default off).
> 
> The dirty bitmaps are maintained inside the device, which is not
> realistic for discrete NICs without on-chip DRAM.
> 
> * Testing
> 
> The target scenario is nested virtualization: L0 runs QEMU with an
> igb PF (x-vf-migration=on), L1 runs the igb-vfio-pci variant driver
> and an unmodified QEMU, and L2 runs a standard igbvf driver.
> 
> Migration under iperf3 load works correctly: dirty page tracking
> converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
> STOP_COPY), and STOP_COPY stays under 250ms.
> 
> * Todo
> 
>    1. Add migration blocker when x-vf-migration=on (no VMState yet) or
>       add VMState support for L0 migration (dirty bitmaps, tracking
>       engines, DVSEC registers, stats)
>    2. Add PRE_COPY state transfer to validate device INIT data (magic,
>       version, etc.)
>    3. Add qtests for migration state machine transitions, dirty page
>       tracking ?
> 
> * Ideas
> 
>    1. RX bandwidth throttle (x-mig-rx-limit, uint32, default 0)
> 
>       Return false from can_receive when the per-VF packet count in the
>       current tracking interval exceeds the limit. Reduces DMA writes
>       and dirty pages realistically.
> 
>    2. Migration phase timing (GET_STATS extension)
> 
>       Add per-VF timestamps: precopy_start_ns, stopcopy_start_ns,
>       precopy_duration_ns, stopcopy_duration_ns,
>       state_transition_count. Expose via GET_STATS.
> 
>    3. Hot page simulation (x-mig-hot-pages, uint32, default 0)
> 
>       Re-set the first N bitmap bits after each DIRTY_QUERY, simulating
>       workloads with hot pages that prevent convergence.
> 
>    4. Error injection (x-mig-inject-error, uint32, default 0)
> 
>       One-shot error code injection before command dispatch. A separate
>       x-mig-inject-dma-fail (bool) for persistent DMA failure testing.
> 
> * Credits
> 
> Alex Williamson suggested the overall approach of a variant driver
> with the "x-vf-migration" device property to gate the feature. Thanks
> for the ever ongoing support and valuable discussions throughout these
> years.
> 
> * AI disclaimer
> 
> The lack of a migration-capable device has been a recurring pain point
> for VFIO development over the years, and we hope this proposal
> demonstrates the value of having one.
> 
> Claude was used to analyze the IGB PF and VF internal state and
> identify the pain points of a working live migration of such devices.
> The generated code served as a starting point but *significant* time
> was then spent cleaning up, reworking, and shaping it into a clear,
> reviewable IGB model extension.
> 
> As QEMU does not yet accept AI-assisted contributions, this series is
> submitted as an RFC.

This largely repeats the concerns I raised previously [1]. Your 
description of the *significant* time spent cleaning up and reworking 
the generated code suggests that this series is intended for upstream 
inclusion once the implementation direction is agreed. My concerns as a 
maintainer are therefore correctness and maintainability.

The missing migration blocker is a concrete example: it is a basic 
correctness issue that should be straightforward to address, yet it 
remains a TODO. My comments on individual patches also raise the same 
kinds of issues I pointed out in the previous version.

Many of the correctness problems found in v1 and v2 stem from the choice 
to build on igb, which is more complex than virtio-net. That is why I 
suggested using virtio-net as a simpler basis, unless there is a problem 
that rules it out.

I would be willing to support allowing AI use in the project for work 
like this. I would still need to see these correctness and 
maintainability concerns addressed before I could support merging
the series.

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/qemu-devel/20260727053935.1392269-1-clg@redhat.com/

