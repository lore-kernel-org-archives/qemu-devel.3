Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmQugFE7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXEe-0001No-P7; Thu, 29 Oct 2026 17:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMXEc-0001NA-1G; Thu, 29 Oct 2026 17:00:30 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMXEZ-0000m1-Vd; Thu, 29 Oct 2026 17:00:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3614E601EE;
 Thu, 29 Oct 2026 21:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A171F01816;
 Thu, 29 Oct 2026 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793307618;
 bh=eksexs5QV6m0Tl17tTXKOxOQP7ooOY8fNQ0JiEVRh3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mmQugFE7sPd6+7dU3pzvRCO8WfOgYxosgpF9r7VT1HM04IeANCQUMPeOdAWQsMyRn
 UG0GDMnGbvxPmDmVjDBXZ0QhZ2YEGzqgKoAkzTfHnsS8PsAHOpfnAllRjkekFL93Z5
 lCewXmHvmfddmcb+kAbLF48oJ6xAY3+gypgGkRx8YJFQin+vmW/INe0FMnLGPoDmcI
 WkMXwKBzvEhfXqTgvW3Xv4vX83sYIqIZ3pjBtEbTKc2gRvKS7R/HLFBRya2t+cBzbx
 eidC+gX8JKb7rtLKN3ZcOhQJuzlJUud/2/i4wvJvtfIJ8pm80Rn2vqDEmVYtkDXsFy
 KIHNHS2NO389g==
Date: Thu, 29 Oct 2026 14:00:17 -0700
From: Drew Fustini <fustini@kernel.org>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mindal@semihalf.com" <mindal@semihalf.com>,
 "sunilvl@oss.qualcomm.com" <sunilvl@oss.qualcomm.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>,
 "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "cp0613@linux.alibaba.com" <cp0613@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "radim.krcmar@oss.qualcomm.com" <radim.krcmar@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
 "npitre@baylibre.com" <npitre@baylibre.com>,
 "cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
 "atish.patra@linux.dev" <atish.patra@linux.dev>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PATCH v6 4/6] hw/riscv: implement CBQRI bandwidth controller
Message-ID: <auOz4d4Tq4gXCOyi@thelio>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-4-1a367a35cd0e@kernel.org>
 <e0b034b0a1d9c0e5dccc912f7ce73580c4ababc2.camel@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b034b0a1d9c0e5dccc912f7ce73580c4ababc2.camel@wdc.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:18:02AM +0000, Alistair Francis wrote:
> On Mon, 2026-10-26 at 10:47 -0700, Drew Fustini wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Implement a bandwidth controller according to the Capacity and
> > Bandwidth
> > QoS Register Interface (CBQRI) which supports these capabilities:
> > 
> >   - Number of access types: 2 (code and data)
> >   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> >   - Event IDs supported: None, Total read/write byte count, Total
> >                          read byte count, Total write byte count
> >   - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> > 
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: rpfx and p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> 
> My review bot doesn't like the assert:
> 
> - [CRITICAL] In hw/riscv/cbqri_bandwidth.c (get_bw_alloc), the array
> index mixes the architectural AT encoding (data=0, code=1) with a
> compacted count of supported ATs. at_data and at_code are independent
> bool properties, so at_data=false/at_code=true is a legal
> configuration; a guest BC_ALLOC_CTL write with AT=code then passes
> is_valid_at in riscv_cbqri_bc_write_alloc_ctl and funnels into
> get_bw_alloc(rcid, 1), which evaluates g_assert(1 < 1) and aborts the
> QEMU process on a guest MMIO write (QEMU maps assert to g_assert, so
> release builds abort too). Even with the assert compiled out, realize
> sizes the table to nb_rcids+1 entries while the code-only index for
> the last RCID is nb_rcids+2, a guest-triggered one-past-the-end
> access. Reject the asymmetric property combination in realize, or
> index by AT encoding instead of the supported-count.

This is a good point. I should not have allowed at_data=false as the
CBQRI spec states that unsupported AT values behave as AT 0. I'll remove
the at_data property and index by the AT encoding in both controllers.

> - [MEDIUM] In riscv_cbqri_bc_class_init (hw/riscv/cbqri_bandwidth.c)
> the device registers neither dc->vmsd nor .unmigratable, yet it is
> user_creatable and (per series patch 6/6) pluggable on the
> migration-capable virt machine. None of its guest-visible state -- the
> cached bc_mon_ctl/bc_mon_ctr_val/bc_alloc_ctl registers and the
> mon_counters[] and bw_allocations[] tables -- is migrated; the
> destination comes up in power-on state and the guest's QoS programming
> silently vanishes mid-workload. Add a VMStateDescription covering the
> caches and both arrays, or set unmigratable with justification (the
> sibling riscv-iommu-pci device already takes the latter route).

I'll mark both controllers unmigratable.

> - [MEDIUM] riscv_cbqri_bc_realize (hw/riscv/cbqri_bandwidth.c)
> allocates mon_counters and bw_allocations with g_new0 and initializes
> the MMIO MemoryRegion, but the class registers no dc->unrealize and no
> instance_finalize. With user_creatable = true, QMP/HMP device_del
> cycles orphan both arrays and the region backing store on every
> hot-unplug. Add an unrealize that unparents the region and frees both
> arrays (NULL-guarded, since realize can bail early on the mmio_base
> check)

This should not be a problem since device_del is rejected for sysbus
devices.

> Related: the bc_bw_alloc struct field is dead state --
> BC_BW_ALLOC traffic goes through bw_allocations[0] and nothing reads
> or writes the field -- so use it or drop it.

I will remove bc_bw_alloc.

> - [MEDIUM] Commit message: the body is a bullet list of supported
> access types, monitoring ops, event IDs and allocation ops -- a
> restatement of the register encodings the patch adds -- with no
> sentence explaining why QEMU should carry a CBQRI bandwidth
> controller. That omission matters here because the model deliberately
> performs no bandwidth enforcement and marks every counter INVALID;
> without the motivation (e.g. the Linux RISC-V resctrl/CBQRI consumer)
> a reviewer cannot judge whether the stub level is intended. The spec
> Link and DCO trailers are fine; add one or two motivation sentences.

I'll add more details to the commit message.

> - [LOW] In riscv_cbqri_bc_realize (hw/riscv/cbqri_bandwidth.c), the
> allocation size is computed as get_bw_alloc(bc, nb_rcids, 0) -
> bc->bw_allocations while the pointer is still NULL: forming NULL + n
> and subtracting pointers that do not point into the same array object
> is undefined behavior, latent today but trapped by UBSan at realize
> time. The capacity controller's sibling code avoids this pattern with
> the pure-integer get_blockmask_offset helper. Compute the count
> arithmetically (1 + nb_rcids * MAX(nb_ats, 1)) before g_new0 instead
> of through the pointer-returning accessor.

I'll add a helper that returns the index as an integer like
get_blockmask_offset().

> - [LOW] The target qdev property (hw/riscv/cbqri_bandwidth.c) is
> stored into the target struct field by the property setter and by
> riscv_cbqri_bc_create, but nothing in the device model ever reads it:
> users passing target=<str> get a silently ignored option, and the
> device never associates itself with the controlled resource. Either
> wire it up to a real association, or drop the property, the field, and
> the exported factory if series patch 6/6 confirms no in-tree board
> code calls riscv_cbqri_bc_create.

I'll remove the target property.

> - [LOW] riscv_cbqri_bc_realize (hw/riscv/cbqri_bandwidth.c) hard-
> requires mmio_base and self-maps its MMIO region via sysbus_mmio_map,
> which clashes with the series-end
> machine_class_allow_dynamic_sysbus_dev registration on virt, where the
> platform bus normally assigns addresses for -device-created sysbus
> devices. Stated conditionally on patch 6/6's dynamic-sysbus wiring: if
> that registration stands, either make mmio_base optional and let the
> platform bus map the device, or do not register it for dynamic sysbus
> hot-plug.

platform_bus_map_mmio() skips a region that is already mapped. mmio_base
is required so the address is known for DT nodes and the RQSC table.

> - [LOW] hw/riscv/cbqri_bandwidth.c re-declares MonitorCounter and the
> 64/32-bit align-down/RMW MMIO read-write wrapper pair verbatim from
> hw/riscv/cbqri_capacity.c and re-implements the same property-table
> plumbing; declare the type once in cbqri.h and share the wrapper
> helpers. The duplication is already diverging (capacity uses the
> pure-integer get_blockmask_offset while bandwidth computes the table
> size through a NULL pointer, per the lifecycle finding above).

I'll move the MonitorCounter definition to cbqri.h.

> From quickly reading it, it seems like the assert in get_bw_alloc() can
> be triggered from guest code, so it shouldn't assert
> 
> Alistair

That should be resolved by no longer allowing at_data=false.

Thanks,
Drew

