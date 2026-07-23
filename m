Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241EDC531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmu9m-00057B-RN; Thu, 23 Jul 2026 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmu9l-00054k-D4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:12:13 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmu9i-0005J9-NH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:12:13 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id E4132EC00A2;
 Thu, 23 Jul 2026 10:12:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 10:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784815927;
 x=1784902327; bh=knQ56I/Y9LvZf3+b56xGBAaklgvYK0rFJL1NE08BG2c=; b=
 DTAN5M7izu9hWe0VRAeXB6jV2zZrcBV6mJlyS6cT6nUmfECclQoke+pkWQYS12Df
 /4O6c+9dUjuUdNdIABVUo4NO6x8PqXvm50FUNwe4Uw5WSRWZiobb2INIJNx0abAP
 pfvJHmO1CV+CCjZayN9Pbe8loZWaO6vVq1uvQOZbJmgk4AWUyEZKtUbY96MRnQtv
 aSbQGvWsgXFgQR2mkXloSuiX4Qgn2F7KrGlBa9gwa961PS1yF/9mtLtVX/HT0V8L
 rxaaBlHbT0jNijUgmidGwv44fIcLXpm76emHVwKrhLYuQpVLtNfPspo69wIooH2x
 lVcwrojSpR2BrACc8/vwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784815927; x=
 1784902327; bh=knQ56I/Y9LvZf3+b56xGBAaklgvYK0rFJL1NE08BG2c=; b=X
 IT+r8XLutH7hwq6vAfRgy81rpsNNWXrav1w5dDcnHDHtWbUWeSKKkyHx09MIk3xM
 +qpdFornYQdMLccXZMhKxvd88pY1lp1oJk3lYGPpp7AGtB2Y/Y7cTJqOMFXrgaKf
 NnLtrKyvKjtLl6mvhwJByM+vYosn8Hbrr+riPwJniqocGgQKUkoDz91J1wlANyrq
 Q3IKEd+uHjsAnwkx0sxrRrMN/UL4MvWYdek+RVLs6xFe6LcXdmyMQJeIvJYDc8wF
 fMHN1C0WZ64pE+jfrbsKZbVPuBy/RipIWnfJLkEoEhccRw+J3lRo8aFlM6RZ2W9b
 I6fTCxKbMhoE1GQHRxfRA==
X-ME-Sender: <xms:NyFiagLILkGDB8EbUDugvbMIJzuV4kCmACag-mOgJfo0IJo7DhGKtg>
 <xme:NyFiam5FOGmQ1NvfRv9CsxF1a6AyH-aNMh0l9A0IMP-J0FF4jsZox5krswg1VFFQj
 myefGJUWWDyh271-4ZQjG6tOAvCcs9PjMWrB5hjtlK57skwrgty>
X-ME-Received: <xmr:NyFiaidEcvN0L2ZNkGLVgnAA9h5Pg2n5XqMkl_2xrFwBRhsNM6mE1dXHqSenLg>
X-ME-Proxy-Cause: dmFkZTEdd31j8CaJx7HSszv0TsiKNul7IefA7JwTFc0j/mfaY0cPo4/2PTkf875Ms4Qfp/
 xLJMt+XtX0eWcrKvR+s0VP4wI+AAaorWmwY+f7HgWTU1OKhJG2scyg8NKykcZwr3aBby0Q
 ya5kUwPAUjFKNdOUP4KuWyCcg4aP1gC2f5yNQa+obpW4ZYNJd7hcz9Ozcv7IIaOezTesgj
 b3BNIp2lRa+lvyjJYj7WCrDTmahqf+qLRK7Ks87mxzNc8oozi7ZWPe+X16HvzEMlqH55Fv
 LfftvOEwXvE9+dGqjm7JV8pFgdfioq0QGzWNzPhWYIsg1anFRIxQ5sAwP8uaeO8/gtWaj0
 paMqTWzX+7VyD/tCDSbrT0l6G3yLnMi0mgghoObqwHViWlMid9cchv6ecBAxonvp7bRoJS
 1PudOnilfuAu3T9YdZI5ou5nB0mqJf5Iy8wE1xL3WhQU8L1Sov7bL1digigMLA878e0S/R
 Ctf3jZ1APKyl3IGY93bgjHVSQrkXZULt0FWDqub1BOeprCT0VpSkIMYAvg5w2W4DQ62Gqw
 zrELIi8gB1zCC7KqLC+iLu3qMqm2It32rc63WleJpA5clJdz7zNNurB4kC06uI+6fQ9aCH
 OeXWBrUV8WRRjdPy/XP0nW/lJFSqRbUgsQ3KErmRLsPOzYQJ6vAj5a1Digog
X-ME-Proxy: <xmx:NyFiapHj831Mz4JpWUACuOJuysVJOwkJj5-cwSvkZiqgGBQZKrBDsA>
 <xmx:NyFiajTghFTAdlBZFkr8Pp9w1ezWIwcryX9NUWfR1llaMwRWqGXGSQ>
 <xmx:NyFiavZdcqdni_36sMcEEOLnASPUR7i-Ef5dDvx5ZcFFJquAo5civA>
 <xmx:NyFiau27hhDd3iUqr3LOmGzHtgJUz0Jv0uUPLmN8h9ALBGTRCWjgHw>
 <xmx:NyFiagJdi3gcWaHu0B4Jl6SlmJ1Z8KAnlFXbSUffLVTPij27AJUYNvVb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 10:12:05 -0400 (EDT)
Date: Thu, 23 Jul 2026 08:12:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Yangwencheng
 <yangwencheng@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode
 DMA (re)map for passthrough BARs
Message-ID: <20260723081201.37e8f70b@shazbot.org>
In-Reply-To: <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
 <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
 <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
 <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.148; envelope-from=alex@shazbot.org;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 23 Jul 2026 21:44:47 +0800
Wencheng Yang <east.moutain.yang@gmail.com> wrote:

> On 2026/7/23 15:37, C=C3=A9dric Le Goater wrote:
>=20
> Hello,
>=20
> On 7/23/26 05:50, Wencheng Yang wrote:
>=20
> __
>=20
>=20
> On 2026/7/22 13:00, Alex Williamson wrote:
>=20
> On Tue, 21 Jul 2026 11:03:39 -0400
> "Michael S. Tsirkin"<mst@redhat.com> <mst@redhat.com>
> <mailto:mst@redhat.com> <mst@redhat.com> wrote:
>=20
> On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:
>=20
> On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:
>=20
> From: YangWencheng<east.moutain.yang@gmail.com>
> <east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com>
> <east.moutain.yang@gmail.com>
>=20
> A passthrough device's own MMIO/BAR range is registered with the IOMMU
> (VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
> address space, to support peer-to-peer DMA into that BAR from other
> devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
> and back on -- something PCI enumeration/attribute code does routinely,
> sometimes several times for the same device (e.g. disable before
> reprogramming a BAR then re-enable, or generic driver probing during
> guest OS boot) -- currently tears down and rebuilds this mapping every
> single time via vfio_listener_region_del()/region_add(), unconditionally.
>=20
> For devices with very large BARs this is expensive: mapping a 64GB BAR
> into IOMMU page tables measured at ~8.5s per call on this hardware, and
> was observed being repeated 3-5 times for the same BAR during a single
> guest boot, because nothing changed about the underlying mapping between
> the disable and the following re-enable.
>=20
> Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
> passthrough device BARs used for P2P DMA -- explicitly not regular guest
> RAM or RamDiscardManager-backed regions, so migration/ballooning/
> virtio-mem are unaffected) instead of issuing it immediately in
> region_del(). If a matching region_add() for the exact same region
> (same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
> the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
> host-side mapping was never actually removed, so there is nothing to
> redo. A region_add() for anything that doesn't match maps normally, as
> before.
>=20
> Nothing is leaked: any mapping still on the pending list is flushed with
> a real unmap in two places -- vfio_container_instance_finalize(), before
> the container's fd is closed (VM shutdown / last device in a group
> removed),
> and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
> device's own BARs, so a device hot-unplugged while the container stays
> alive for other devices can't leave a dangling deferred entry either.
>=20
> This does not weaken the PCI_COMMAND memory-decode security boundary:
> every guest write to PCI_COMMAND is still forwarded synchronously and
> unconditionally to the real device's config space in
> vfio_pci_write_config() (an entirely separate code path, untouched by
> this change), which is what actually gates whether the physical device
> claims/responds to transactions targeting its BAR, independent of
> whatever the IOMMU's routing table still contains. This change only
> avoids redundant bookkeeping of that routing table when nothing about
> the mapping has changed.
>=20
> Seems like you should focus on huge pfnmap support on your platform
> rather than hack the VMM to not behave like bare metal.  Thanks,
>=20
> But bare metal does not tweak an iommu during pci enumeration?
>=20
> Bare metal is not using the IOMMU to map the device into a guest
> physical address space, so no, an equivalent operation does not occur
> there.  The proposal here is intentionally leaving stale gpa mappings
> to avoid the unmap/remap overhead, where we've essentially eliminated
> that overhead on other platforms with huge pfnmap support.  The
> specific platform that's being optimized here is also omitted, which
> makes it impossible to determine the ongoing need for this code.
>=20
> The scheme here effectively assumes that a region_del() will either be
> followed by a region_add() that cancels the deferred unmap, or the
> deferral will be executed on finalize.  It does not actually account
> for cases where the guest might remap the BAR to a different address,
> ex. pci=3Drealloc, leaving a stale mapping in place.  The finalize also
> appears to be using a different MR from the one deferred, such that the
> IOMMU is actually only unmapped due to close().
>=20
> More importantly though, this entire scheme is relying on a gap in the
> vfio type1 IOMMU backend, where clearing the memory enable bit of the
> command register zaps the CPU mappings and errors faults while cleared,
> but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
> generating a move-notify/invalidate on the dma-buf, which results in an
> IOMMU unmap.  IOW, the premise of this workaround is broken in the
> direction that VFIO is headed.
>=20
> Therefore, I'd once again suggest that effort is better redirected to
> implement huge pfnmap support for whatever platform this might be in
> order to follow a proven solution to this problem for type1.  Huge
> pfnmap is used both in the CPU fault path as well as the DMA mapping
> path, by virtue of generating user faults in the pfnmap.  Alternatively,
> iommufd may provide better p2p DMA mapping performance than type1
> without huge pfnmap, but CPU faults would lag without such support
> anyway.  Thanks,
>=20
> Alex
>=20
>=20
> I noticed you provided a kernel patch "PCI: Batch BAR sizing operations",
>=20
> the patch eliminates the overhead of IOMMU map/unmap operations from
>=20
> guest kernel. I found OVMF has the same issue, I tried to fix it in edk2
> source
>=20
> code, but the PCI commands are scattered, it's hard to handle it like
> kernel.
>=20
> I think it's reasonable to handle it qemu, as the overhead is introduced =
by
>=20
> qemu to support PCIe device passthrough.
>=20
>=20
> "we've essentially eliminated that overhead on other platforms with huge
>   pfnmap support."
>=20
> Can you provide some key references about this approach?
>=20
> Check these related commits.
>=20
> Linux :
>=20
>   commit f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
>=20
> QEMU:
>=20
>   commit 00b519c0bca0 ("vfio/helpers: Align mmaps")
>=20
> Thanks,
>=20
> C.
>=20
> Thanks a lot.
>=20
> The two patches above establish huge-page mappings for the CPU,
> saving memory allocated for page tables, and using huge pages also
> reduces TLB entry consumption. However, the issue I'm running into
> is that OVMF's frequent PCI_COMMAND operations cause QEMU
> to repeatedly invoke VFIO_IOMMU_MAP_DMA. While huge pages
> can certainly reduce the time spent resolving the PFN corresponding
> to an IOVA, they do not eliminate these repeated calls themselves.

Reducing the number of map/unmap cycles turns out to be only an
incremental improvement while implementing huge pfnmap, depending on
the available huge page sizes, can reduce operations by a factor of
256k (ex. 4K -> 1G).
=20
> For a GPU with a relatively large VRAM =E2=80=94 say, 64GB =E2=80=94 the =
cumulative
> overhead from these frequent invocations is substantial. In my testing,
> passing through a 64GB VRAM GPU to a VM shows that a single
> ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) call takes roughly
> 8 seconds.

See:

https://lore.kernel.org/all/20250218222209.1382449-1-alex.williamson@redhat=
.com/

for the IOMMU backend integration.
=20
> Applying the two patches above might help reduce this time. I'm currently
> running QEMU 8.2 with kernel 5.10, and directly cherry-picking these two
> patches results in conflicts. I'll spend some time backporting them and
> see how the results look.

It's generally recommended to test with recent kernel and QEMU,
backporting as necessary to match upstream performance and driving
improvements from an upstream perspective.  Optimizing QEMU for an
older kernel where those changes are redundant upstream, or
dis-recommended, is a downstream problem.  Thanks,

Alex

