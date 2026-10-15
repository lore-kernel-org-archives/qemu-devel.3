Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C79CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHENU-0000W6-NP; Thu, 15 Oct 2026 01:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xHENS-0000QV-7j
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:51:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xHENO-0002fn-DK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:51:42 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69F5pHC5002842
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2026 14:51:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rtrXwU6CJYaSc96wgRxAmLBXW6WCu3r7ZsGT+3em1c0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1792043477; v=1;
 b=J9gZLnMqJIvxBaX7w2ZmeEhkAD9FT4wHFbI6y3A9DqK/I2cOIyjnxlSg7G1boWll
 2pDU/yDgTAu0CB6sswoq9HvyOEp0tzu8omS8X43tQihyC+SQBJbWuRGOlXfZyY2G
 nwx9YfVjJOa54enOTVeOKIKKlc3YkFwJlQT+mqIcKFnALepNAwDlnH9VHT4VLUw7
 zR3xYKsaaDJbwbzi1Rvefg+VDTjvACf0/qBwPPy7QJ1G38S/SFj5Tb+fqYkZ7gG6
 haYW8p6z4QPoG92QF0vMuuzjUMgbYsfxeJMBKBu4XAmdlKw8Whm3b6qj28oQXZz0
 G5Zw8kZIyHXQBCqziTnczQ==
Message-ID: <d41be206-4325-4c15-9b31-633a75bd93a2@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Oct 2026 14:51:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] igb: Add experimental VF live migration
 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
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
> Hello,
> 
> Live migration of VFIO-passthrough devices, SR-IOV VFs, vGPUs, is a
> growing requirement, but real hardware with migration support is
> scarce and hard to debug. An emulated device provides a fully
> controlled testbed for developing and validating the entire software
> stack, vfio-pci variant drivers, VFIO core migration v2 framework,
> QEMU, libvirt, and for tuning complex migration policies such as
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
> The L1 QEMU is completely unmodified. It sees a standard VFIO
> migratable device and uses the normal migration fd path.
> 
> * Design
> 
> The migration interface is exposed through a DVSEC (Designated
> Vendor-Specific Extended Capability, PCIe cap id 0x23) at offset
> 0x160 in VF extended config space. The DVSEC uses a command doorbell
> model; all commands are synchronous via PCI config space writes.
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
> The current implementation maintains dirty bitmaps inside the device,
> which is not realistic for discrete NICs without on-chip DRAM.
> 
> On load, MTA/UTA fixup merges missing source entries into the
> destination but is not durable: the L1 PF driver zeroes and reprograms
> these tables on any multicast update, and has no record of the
> migrated VF's hashes. A proper fix requires QEMU to track per-VF
> multicast hashes and restore them on load, either through a new DVSEC
> command consumed by the variant driver or by injecting a VF mailbox
> message to the L1 PF driver.
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
>    1. Add VMState support for L0 migration (dirty bitmaps, tracking
>       engines, DVSEC registers, stats)
>    2. Add PRE_COPY state transfer to validate device INIT data (magic,
>       version, etc.)
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

Below is the raw output from running `b4 shazam` and asking GPT-6 Astra 
Ultra to "review each commit," shared here for demonstration. Normally, 
I review each comment, filter out false positives, and manually assemble 
the relevant context, but I wanted to provide the unfiltered results 
this time.

Since you use Claude while I use Codex, I can understand if Codex 
catches a few things Claude misses, but I didn't expect this volume. 
Moreover, many of these issues are recurring, following a pattern that 
hasn't changed over the last two reviews.

I don't believe Claude's core capabilities are too limited to catch 
these issues. Instead, my hypotheses are:

- Claude is not priotizing working "better, not faster" [1]. While
   working faster is nice, quality should take precedence, and the
   current balance may be miscalibrated.
- The model and reasoning effort configuration may be underpowered.

Suggestions for improvement:

- Explicitly ask: "review each commit".
- Pass past review comments as context when asking Claude to perform the
   review.
- Use the best model and highest reasoning effort configuration for
   final local reviews before submission.

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/qemu-devel/20260930085433.830743-2-pbonzini@redhat.com/

---

Reviewed all 17 commits in `615ece3c406b..c5d547be30d8`. The series 
still has migration correctness issues and a qtest regression.

1. **`5404e7f4e9ae` — Property and DVSEC capability**
    No actionable finding.

2. **`fc515c08615c` — Migration blocker**
    No actionable finding.

3. **`dae704cc51b8` — Migration state machine**
    No independent finding. The recovery problem introduced by quiescing 
is covered under commit 12.

4. **`995983deaea3` — Serialization infrastructure**
    No independent finding.

5. **`207eb305d397` — VF register serialization**
    **[P1] Preserve pending mailbox transactions.** The [register 
list](hw/net/igb_migration.c:102) saves mailbox control registers but 
omits `VMBMEM`, claiming quiescing drains it. No drain occurs. A pending 
PF reply therefore restores `PFSTS` with stale destination payload. A 
focused probe restored `PFSTS=1` but read payload `0` instead of 
`0x12345678`. Preserve the transaction or coordinate its completion 
before saving.

6. **`a0e79d2465df` — Post-load fixups**
    No additional finding.

7. **`3509f2eb4600` — TX context serialization**
    No additional finding.

8. **`c0c5fe9620dd` — Receive-address serialization**
    **[P1] Reconcile restored addresses with PF allocation state.** The 
[free-slot allocation](hw/net/igb_migration.c:284) moves addresses 
without updating the PF driver’s `mac_table`. A round trip moved VF0’s 
MAC from reserved RAR23 to RAR1. The PF still considers RAR1 free, so a 
subsequent secondary-address allocation can overwrite the migrated VF’s 
address. Restoring hardware entries alone does not preserve ownership.

9. **`bd807329dbca` — VLAN filter serialization**
    **[P1] Restore PF VLAN bookkeeping alongside VFTA.** The [VFTA 
update](hw/net/igb_migration.c:380) leaves the destination PF driver’s 
`shadow_vfta` unchanged. For example, restoring VLAN 100 and then adding 
VLAN 101 through the PF rewrites the same VFTA word from that stale 
shadow, clearing VLAN 100. The migrated VF then loses tagged traffic 
despite retaining its VLVF entry.

10. **`7694a1bc9d43` — MTA/UTA restoration**
     **[P1] The multicast restoration is still temporary.** [OR-ing the 
saved MTA](hw/net/igb_migration.c:662) does not restore the PF driver’s 
per-VF multicast hashes and counts. A later multicast request from 
another VF rebuilds MTA and the receive-mode bits from those caches, 
discarding the migrated VF’s configuration. This remains the PF 
bookkeeping problem discussed in the thread.

11. **`efe8749e6477` — Dirty tracking**

     **[P1] This intermediate commit does not compile.** The [trace 
declarations](hw/net/trace-events:302) change the save/load events to 
five/four arguments, while their call sites still pass two. Commit 12 
fixes the calls; move the declaration changes there.

     **[P1] Reject overflowing query ranges.** The [range 
check](hw/net/igb_migration.c:1064) adds `range_iova + range_size` 
without checking overflow. With tracking enabled for `[0, 64 KiB)`, a 
query starting at `UINT64_MAX - 4095` with size 8192 incorrectly 
succeeds. Larger wrapped sizes can also truncate the bitmap allocation 
while leaving `bitmap_count_one()` scanning the full requested size.

     **[P2] Honor the query buffer length.** The [query 
handler](hw/net/igb_migration.c:1095) never reads `len`. A probe 
advertising only 24 bytes succeeded and overwrote the next 16 bytes with 
response fields. Validate the header and available bitmap space before 
writing or clearing dirty bits.

     **[P2] Free dirty bitmaps during teardown.** The 
[allocations](hw/net/igb_migration.c:961) are released only by explicit 
disable/state transitions. Neither VF nor PF unrealize cleans them up. 
Removing a PF with active tracking leaks its bitmaps; repeated hotplug 
accumulates the allocations.

12. **`61cd2a726e1e` — Quiescing and enable-state preservation**

     **[P1] STOP does not quiesce interrupt DMA.** 
[Quiescing](hw/net/igb_migration.c:1289) clears `VFRE`/`VFTE` but leaves 
active EITR timers able to notify MSI-X. A probe observed another MSI 
memory write after STOP reported `QUIESCED`. Pending timer notifications 
need to be stopped and preserved for resume.

     **[P2] Error recovery overwrites the saved enable state.** [ERROR → 
STOP](hw/net/igb_migration.c:1348) quiesces again even when the VF was 
already stopped. After `RUNNING → STOP → STOP_COPY`, a failed SAVE 
followed by `ERROR → STOP → RUNNING` replaces the saved RX/TX enables 
with zero. The probe returned to RUNNING with both directions disabled.

     **[P2] Validate the blob before clearing VFLRE.** The [pre-load 
operation](hw/net/igb_migration.c:831) consumes the PF’s pending 
VF-reset indication before validating the blob. A rejected LOAD 
therefore still changes device state. Move this mutation after 
successful validation.

13. **`4a9d2fed1f04` — Effective interrupt masks**
     **[P1] Preserve effective pending causes as well as masks.** 
[Restoring masks](hw/net/igb_migration.c:1268) clears the VF’s `EICR` 
slice without saving it. A masked pending cause disappeared across a 
simple `STOP → RUNNING` cycle, without any migration. Serialize and 
restore the actual pending causes.

14. **`dcffcb07ed87` — Interrupt re-injection**
     **[P1] PVTEICR is not the pending-cause state.** The [new 
helper](hw/net/igb_core.c:4613) reads a shadow containing the last 
write-one-to-clear value. It can therefore recreate an already 
acknowledged interrupt while missing a genuinely pending one. A probe 
changed effective `EICR` from zero to `0x400000` after STOP/RUNNING 
solely because that cause had previously been acknowledged.

15. **`01bcf6d4e9d1` — Dirty-tracking statistics**
     No additional finding.

16. **`4eda0478f80d` — Testing documentation**
     No independent finding. The documentation builds successfully.

17. **`c5d547be30d8` — Migration qtests**
     **[P1] Restrict registration to supported machines and devices.** 
The [registration function](tests/qtest/igb-migration-test.c:867) 
unconditionally adds tests to the shared `qos-test` binary, while 
startup hardcodes `q35`. Running the new DVSEC test against 
`qemu-system-aarch64` aborts with “unsupported machine type.” Gate 
registration or use the graph’s machine/device discovery.

The x86_64 and AArch64 binaries, `qos-test`, and HTML documentation 
build successfully at the tip. All 31 supplied migration tests pass on 
x86_64; focused probes reproduce the mailbox, address relocation, 
range/length validation, interrupt, and recovery failures above. The PF 
bookkeeping consequences were traced through the Linux driver; full 
nested guest migration was not run. The worktree remains unchanged.

