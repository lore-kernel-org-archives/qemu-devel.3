Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5249AC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGYU-0007nM-CJ; Fri, 24 Jul 2026 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wnGYS-0007ms-T7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:07:13 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wnGYQ-0004eE-A1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:07:12 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-5276d598b96so3392811cf.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902029; cv=none;
 d=google.com; s=arc-20260327;
 b=IJ7eSc10dOR82NOO91EnwJKdwpns2Qqw0UOMHS+aQq55XWVS/aOTsEdN1gDv7vjSZt
 YXQ26sEyjANljb1EctmmSnD5xkx0NCDOBzo1WnR32ucHMOOgdVyVrDI6Ec06QWLtplb1
 xqRwn4EdORaTlmZ6h9MIh//npfmUtYQGO+7UMJy+9PPjhYTWG+TU/yGYNQQaTE2dQ/sU
 676Nk+V1JKMji4wUoU+ICy3B9ufbqPyLky3InIWXrTI2xa9YSeY7mcCJqSoyP2ddJQmH
 3m0cCRxAio2yIUAUWi4IaZg6l0LiXJW/wmrAquMrubNGDdnN4RpWRmqX7AWfYulmWURO
 QvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d4nnTSs7cP5y+TXVuHuHvzatoX5QCB3VvyJwAoOqyxE=;
 fh=yjXAfW90bFVi1Y/+7+tQzctjot22u0BagFzYyY/wRko=;
 b=WTLV0KNbDY5oVRx2P5ZjR08/1/kqcU4VFk+DnAB4IxInrxxvwqhKdq3YbOwTPXMMX0
 7Z6v2aVpmWi2tsy0lRJsu0zSr0fCKxT1ijLQ+CBiD0YjEozG19IdD4jmO2/IeLBNfdiO
 uhaFOeqSO1lGzM5bygl0Z6A3V0FkVXOXgbOwz7T7K+CGHV/MAXMfh9sO99mT5h4CIdtz
 Nu8cKtR+gZF0OBILmHYJWeuE5ZoFCmGlwhJS3LhyaszDlhr4ZAE0fZCFRWKI0C66tLT1
 nAl7/VpOrh7x2bRSNrcWwhblW18G+KLyrtpU7YMUQC/Mf5nEepKIqGNnFYPuFy3zUWEZ
 4VSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784902029; x=1785506829; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d4nnTSs7cP5y+TXVuHuHvzatoX5QCB3VvyJwAoOqyxE=;
 b=Naec2wkLmLbs/mgBqiPJwT7+EziTlgxh/BmNAP0MraNTwogZklai7HHHwqu+ppy0mP
 RzZKD+p6SI+x5258/0/Vq6P0Kn9qewh1YXZRfoTKKmD8g5S6Au7jG1TMHP3eeFaRoZyE
 GDmP4xi7+9cKOGUkNWRFN5RLnP0bJrGqbLr1sy/x4qDG11Ou9pfii8sxP18qX/yA8Uau
 FhZjJnU8fq02d1IoM3J5WJlZ/qmlKwb5e3WzB23VJs8amhaFy5TC9exG8IeLlxQptlwh
 vATBJpcGb5wK4y37RyHMhiLPdssKBw0yPrA4gDNyl8HJKTeQ9Sa1p/Y1DSMaotgtsg0J
 xHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784902029; x=1785506829;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d4nnTSs7cP5y+TXVuHuHvzatoX5QCB3VvyJwAoOqyxE=;
 b=TLIfg/Y0ccqsgbSS5ETcy6a1/BllBfpR1w3Dgr5KjY05VZuRdTolDRfC9rkshELVO8
 qYY1hxy8qeGW/1EU7f1+mg6S6IExXJRRvUrx5aWIgeYFzYCe4wVPW4vLlXjKRG9ttszt
 2MobbwEqLXvsMZy0S9hTEWSP34XUyaAitloh/gbhWzs/MFVtwFaDOq/32k0P3oKlZwTg
 XqOkwDqTjtDUshestez75qfPEag8k0q1QM3nrKFu/j2BIuo92SlH4XdYPdZndxBEp9cC
 99QNeGFH+h+oMDMG+JRM4mV0tvw9OtUH3mHhEDGqAt9NfyJDkFoAppfaL7m2Lkq8XQPo
 jmuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSzdhbFUtSgR+yxNESgTDpNBhQ4aDR2HTsJ9MntLmUIQJy9RqtrpEeztBxhF25VnFTzdkpH7tJae+o@nongnu.org
X-Gm-Message-State: AOJu0YxChKkCrJt+vlCpoybKZ2jAxILXvEZgTrgtv/4dLMhuu4EJcvtV
 H7LZEaYB7h3I6vf8ID8zBLFjgfSnoqtAyKp1THCwgdTOlnujeo7+UsT1QTaNQ2e99uNVRVffk9D
 KjrP6NGzqRp3LW7PYQEJByQGBe68RutQ=
X-Gm-Gg: AR+sD13fwIO3RRHTyOtUyYuuatFnQvfw8feo7oMIesF+MIFrjyfdX/ySMonV6rBmXeQ
 seBdmqokrGHFuW+CJLEjGE03udPdzP50uIxYHy4gYGKvANX4rvDGvnvAR3SMH8gtXUrb3XPbt9I
 eBT6s8G5RdLU19vJjIy4hSBS7iSwD08uec/WJWMmnZDnALt0vrwAK3oePmKyfH8ij4OWsTRvA9B
 kC9j4AHM/Lt67LrhRluyZhd8OCkvRAx2EFGhPZT4kIB/X/KgjbvWIMGRTQ9R+I=
X-Received: by 2002:a05:622a:28c:b0:51c:25da:903e with SMTP id
 d75a77b69052e-5283df1c625mr73766391cf.58.1784902028636; Fri, 24 Jul 2026
 07:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
 <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
 <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
 <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
 <20260723081201.37e8f70b@shazbot.org>
In-Reply-To: <20260723081201.37e8f70b@shazbot.org>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Fri, 24 Jul 2026 22:06:56 +0800
X-Gm-Features: AUfX_mzVUf3-WbgDYJMz55JuU3qN2YLvVTS8B6MLe7KDoKzFXOcSlGVuOL-2PaU
Message-ID: <CALrP2iVCjJKNTHoLFgSwht684o+ta4-BY98kaS0O6gzMaCYgLA@mail.gmail.com>
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
To: Alex Williamson <alex@shazbot.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Yangwencheng <yangwencheng@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000060353d06575be3ec"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000060353d06575be3ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2026/7/23 22:12, Alex Williamson wrote:

On Thu, 23 Jul 2026 21:44:47 +0800
Wencheng Yang <east.moutain.yang@gmail.com> <east.moutain.yang@gmail.com> w=
rote:


On 2026/7/23 15:37, C=C3=A9dric Le Goater wrote:

Hello,

On 7/23/26 05:50, Wencheng Yang wrote:

__


On 2026/7/22 13:00, Alex Williamson wrote:

On Tue, 21 Jul 2026 11:03:39 -0400
"Michael S. Tsirkin"<mst@redhat.com> <mst@redhat.com> <mst@redhat.com>
<mst@redhat.com><mailto:mst@redhat.com> <mst@redhat.com>
<mst@redhat.com> <mst@redhat.com> wrote:

On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:

On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:

From: YangWencheng<east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com><east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com><east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com>

A passthrough device's own MMIO/BAR range is registered with the IOMMU
(VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
address space, to support peer-to-peer DMA into that BAR from other
devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
and back on -- something PCI enumeration/attribute code does routinely,
sometimes several times for the same device (e.g. disable before
reprogramming a BAR then re-enable, or generic driver probing during
guest OS boot) -- currently tears down and rebuilds this mapping every
single time via vfio_listener_region_del()/region_add(), unconditionally.

For devices with very large BARs this is expensive: mapping a 64GB BAR
into IOMMU page tables measured at ~8.5s per call on this hardware, and
was observed being repeated 3-5 times for the same BAR during a single
guest boot, because nothing changed about the underlying mapping between
the disable and the following re-enable.

Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
passthrough device BARs used for P2P DMA -- explicitly not regular guest
RAM or RamDiscardManager-backed regions, so migration/ballooning/
virtio-mem are unaffected) instead of issuing it immediately in
region_del(). If a matching region_add() for the exact same region
(same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
host-side mapping was never actually removed, so there is nothing to
redo. A region_add() for anything that doesn't match maps normally, as
before.

Nothing is leaked: any mapping still on the pending list is flushed with
a real unmap in two places -- vfio_container_instance_finalize(), before
the container's fd is closed (VM shutdown / last device in a group
removed),
and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
device's own BARs, so a device hot-unplugged while the container stays
alive for other devices can't leave a dangling deferred entry either.

This does not weaken the PCI_COMMAND memory-decode security boundary:
every guest write to PCI_COMMAND is still forwarded synchronously and
unconditionally to the real device's config space in
vfio_pci_write_config() (an entirely separate code path, untouched by
this change), which is what actually gates whether the physical device
claims/responds to transactions targeting its BAR, independent of
whatever the IOMMU's routing table still contains. This change only
avoids redundant bookkeeping of that routing table when nothing about
the mapping has changed.

Seems like you should focus on huge pfnmap support on your platform
rather than hack the VMM to not behave like bare metal.  Thanks,

But bare metal does not tweak an iommu during pci enumeration?

Bare metal is not using the IOMMU to map the device into a guest
physical address space, so no, an equivalent operation does not occur
there.  The proposal here is intentionally leaving stale gpa mappings
to avoid the unmap/remap overhead, where we've essentially eliminated
that overhead on other platforms with huge pfnmap support.  The
specific platform that's being optimized here is also omitted, which
makes it impossible to determine the ongoing need for this code.

The scheme here effectively assumes that a region_del() will either be
followed by a region_add() that cancels the deferred unmap, or the
deferral will be executed on finalize.  It does not actually account
for cases where the guest might remap the BAR to a different address,
ex. pci=3Drealloc, leaving a stale mapping in place.  The finalize also
appears to be using a different MR from the one deferred, such that the
IOMMU is actually only unmapped due to close().

More importantly though, this entire scheme is relying on a gap in the
vfio type1 IOMMU backend, where clearing the memory enable bit of the
command register zaps the CPU mappings and errors faults while cleared,
but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
generating a move-notify/invalidate on the dma-buf, which results in an
IOMMU unmap.  IOW, the premise of this workaround is broken in the
direction that VFIO is headed.

Therefore, I'd once again suggest that effort is better redirected to
implement huge pfnmap support for whatever platform this might be in
order to follow a proven solution to this problem for type1.  Huge
pfnmap is used both in the CPU fault path as well as the DMA mapping
path, by virtue of generating user faults in the pfnmap.  Alternatively,
iommufd may provide better p2p DMA mapping performance than type1
without huge pfnmap, but CPU faults would lag without such support
anyway.  Thanks,

Alex


I noticed you provided a kernel patch "PCI: Batch BAR sizing operations",

the patch eliminates the overhead of IOMMU map/unmap operations from

guest kernel. I found OVMF has the same issue, I tried to fix it in edk2
source

code, but the PCI commands are scattered, it's hard to handle it like
kernel.

I think it's reasonable to handle it qemu, as the overhead is introduced by

qemu to support PCIe device passthrough.


"we've essentially eliminated that overhead on other platforms with huge
  pfnmap support."

Can you provide some key references about this approach?

Check these related commits.

Linux :

  commit f9e54c3a2f5b ("vfio/pci: implement huge_fault support")

QEMU:

  commit 00b519c0bca0 ("vfio/helpers: Align mmaps")

Thanks,

C.

Thanks a lot.

The two patches above establish huge-page mappings for the CPU,
saving memory allocated for page tables, and using huge pages also
reduces TLB entry consumption. However, the issue I'm running into
is that OVMF's frequent PCI_COMMAND operations cause QEMU
to repeatedly invoke VFIO_IOMMU_MAP_DMA. While huge pages
can certainly reduce the time spent resolving the PFN corresponding
to an IOVA, they do not eliminate these repeated calls themselves.

Reducing the number of map/unmap cycles turns out to be only an
incremental improvement while implementing huge pfnmap, depending on
the available huge page sizes, can reduce operations by a factor of
256k (ex. 4K -> 1G).


For a GPU with a relatively large VRAM =E2=80=94 say, 64GB =E2=80=94 the cu=
mulative
overhead from these frequent invocations is substantial. In my testing,
passing through a 64GB VRAM GPU to a VM shows that a single
ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) call takes roughly
8 seconds.

See:
https://lore.kernel.org/all/20250218222209.1382449-1-alex.williamson@redhat=
.com/

for the IOMMU backend integration.


Applying the two patches above might help reduce this time. I'm currently
running QEMU 8.2 with kernel 5.10, and directly cherry-picking these two
patches results in conflicts. I'll spend some time backporting them and
see how the results look.

It's generally recommended to test with recent kernel and QEMU,
backporting as necessary to match upstream performance and driving
improvements from an upstream perspective.  Optimizing QEMU for an
older kernel where those changes are redundant upstream, or
dis-recommended, is a downstream problem.  Thanks,

Alex

Yes, with the full patch set of huge pfn for CPU page table and IOMMU page
table,
I think my patch is redundant. I dived into those related patches,
backporting to
 kernel 6.6 requires numerous patches, let alone kernel 5.10.

best regards,
YangWencheng

--00000000000060353d06575be3ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20
   =20
 =20
  <div>
    <br>
    <br>
    <div>On 2026/7/23 22:12, Alex Williamson
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On Thu, 23 Jul 2026 21:44:47 +0800
Wencheng Yang <a href=3D"mailto:east.moutain.yang@gmail.com" target=3D"_bla=
nk">&lt;east.moutain.yang@gmail.com&gt;</a> wrote:

</pre>
      <blockquote type=3D"cite">
        <pre>On 2026/7/23 15:37, C=C3=A9dric Le Goater wrote:

Hello,

On 7/23/26 05:50, Wencheng Yang wrote:

__


On 2026/7/22 13:00, Alex Williamson wrote:

On Tue, 21 Jul 2026 11:03:39 -0400
&quot;Michael S. Tsirkin&quot;<a href=3D"mailto:mst@redhat.com" target=3D"_=
blank">&lt;mst@redhat.com&gt;</a> <a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">&lt;mst@redhat.com&gt;</a>
<a href=3D"mailto:mst@redhat.com" target=3D"_blank">&lt;mailto:mst@redhat.c=
om&gt;</a> <a href=3D"mailto:mst@redhat.com" target=3D"_blank">&lt;mst@redh=
at.com&gt;</a> wrote:

On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:

On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:

From: YangWencheng<a href=3D"mailto:east.moutain.yang@gmail.com" target=3D"=
_blank">&lt;east.moutain.yang@gmail.com&gt;</a>
<a href=3D"mailto:east.moutain.yang@gmail.com" target=3D"_blank">&lt;east.m=
outain.yang@gmail.com&gt;</a> <a href=3D"mailto:east.moutain.yang@gmail.com=
" target=3D"_blank">&lt;mailto:east.moutain.yang@gmail.com&gt;</a>
<a href=3D"mailto:east.moutain.yang@gmail.com" target=3D"_blank">&lt;east.m=
outain.yang@gmail.com&gt;</a>

A passthrough device&#39;s own MMIO/BAR range is registered with the IOMMU
(VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
address space, to support peer-to-peer DMA into that BAR from other
devices. Toggling the guest&#39;s PCI_COMMAND memory-decode-enable bit off
and back on -- something PCI enumeration/attribute code does routinely,
sometimes several times for the same device (e.g. disable before
reprogramming a BAR then re-enable, or generic driver probing during
guest OS boot) -- currently tears down and rebuilds this mapping every
single time via vfio_listener_region_del()/region_add(), unconditionally.

For devices with very large BARs this is expensive: mapping a 64GB BAR
into IOMMU page tables measured at ~8.5s per call on this hardware, and
was observed being repeated 3-5 times for the same BAR during a single
guest boot, because nothing changed about the underlying mapping between
the disable and the following re-enable.

Defer the actual VFIO_IOMMU_UNMAP_DMA for &quot;ram device&quot; regions (i=
.e.
passthrough device BARs used for P2P DMA -- explicitly not regular guest
RAM or RamDiscardManager-backed regions, so migration/ballooning/
virtio-mem are unaffected) instead of issuing it immediately in
region_del(). If a matching region_add() for the exact same region
(same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
host-side mapping was never actually removed, so there is nothing to
redo. A region_add() for anything that doesn&#39;t match maps normally, as
before.

Nothing is leaked: any mapping still on the pending list is flushed with
a real unmap in two places -- vfio_container_instance_finalize(), before
the container&#39;s fd is closed (VM shutdown / last device in a group
removed),
and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
device&#39;s own BARs, so a device hot-unplugged while the container stays
alive for other devices can&#39;t leave a dangling deferred entry either.

This does not weaken the PCI_COMMAND memory-decode security boundary:
every guest write to PCI_COMMAND is still forwarded synchronously and
unconditionally to the real device&#39;s config space in
vfio_pci_write_config() (an entirely separate code path, untouched by
this change), which is what actually gates whether the physical device
claims/responds to transactions targeting its BAR, independent of
whatever the IOMMU&#39;s routing table still contains. This change only
avoids redundant bookkeeping of that routing table when nothing about
the mapping has changed.

Seems like you should focus on huge pfnmap support on your platform
rather than hack the VMM to not behave like bare metal.  Thanks,

But bare metal does not tweak an iommu during pci enumeration?

Bare metal is not using the IOMMU to map the device into a guest
physical address space, so no, an equivalent operation does not occur
there.  The proposal here is intentionally leaving stale gpa mappings
to avoid the unmap/remap overhead, where we&#39;ve essentially eliminated
that overhead on other platforms with huge pfnmap support.  The
specific platform that&#39;s being optimized here is also omitted, which
makes it impossible to determine the ongoing need for this code.

The scheme here effectively assumes that a region_del() will either be
followed by a region_add() that cancels the deferred unmap, or the
deferral will be executed on finalize.  It does not actually account
for cases where the guest might remap the BAR to a different address,
ex. pci=3Drealloc, leaving a stale mapping in place.  The finalize also
appears to be using a different MR from the one deferred, such that the
IOMMU is actually only unmapped due to close().

More importantly though, this entire scheme is relying on a gap in the
vfio type1 IOMMU backend, where clearing the memory enable bit of the
command register zaps the CPU mappings and errors faults while cleared,
but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
generating a move-notify/invalidate on the dma-buf, which results in an
IOMMU unmap.  IOW, the premise of this workaround is broken in the
direction that VFIO is headed.

Therefore, I&#39;d once again suggest that effort is better redirected to
implement huge pfnmap support for whatever platform this might be in
order to follow a proven solution to this problem for type1.  Huge
pfnmap is used both in the CPU fault path as well as the DMA mapping
path, by virtue of generating user faults in the pfnmap.  Alternatively,
iommufd may provide better p2p DMA mapping performance than type1
without huge pfnmap, but CPU faults would lag without such support
anyway.  Thanks,

Alex


I noticed you provided a kernel patch &quot;PCI: Batch BAR sizing operation=
s&quot;,

the patch eliminates the overhead of IOMMU map/unmap operations from

guest kernel. I found OVMF has the same issue, I tried to fix it in edk2
source

code, but the PCI commands are scattered, it&#39;s hard to handle it like
kernel.

I think it&#39;s reasonable to handle it qemu, as the overhead is introduce=
d by

qemu to support PCIe device passthrough.


&quot;we&#39;ve essentially eliminated that overhead on other platforms wit=
h huge
  pfnmap support.&quot;

Can you provide some key references about this approach?

Check these related commits.

Linux :

  commit f9e54c3a2f5b (&quot;vfio/pci: implement huge_fault support&quot;)

QEMU:

  commit 00b519c0bca0 (&quot;vfio/helpers: Align mmaps&quot;)

Thanks,

C.

Thanks a lot.

The two patches above establish huge-page mappings for the CPU,
saving memory allocated for page tables, and using huge pages also
reduces TLB entry consumption. However, the issue I&#39;m running into
is that OVMF&#39;s frequent PCI_COMMAND operations cause QEMU
to repeatedly invoke VFIO_IOMMU_MAP_DMA. While huge pages
can certainly reduce the time spent resolving the PFN corresponding
to an IOVA, they do not eliminate these repeated calls themselves.
</pre>
      </blockquote>
      <pre>Reducing the number of map/unmap cycles turns out to be only an
incremental improvement while implementing huge pfnmap, depending on
the available huge page sizes, can reduce operations by a factor of
256k (ex. 4K -&gt; 1G).
=20
</pre>
      <blockquote type=3D"cite">
        <pre>For a GPU with a relatively large VRAM =E2=80=94 say, 64GB =E2=
=80=94 the cumulative
overhead from these frequent invocations is substantial. In my testing,
passing through a 64GB VRAM GPU to a VM shows that a single
ioctl(container-&gt;fd, VFIO_IOMMU_MAP_DMA, &amp;map) call takes roughly
8 seconds.
</pre>
      </blockquote>
      <pre>See:

<a href=3D"https://lore.kernel.org/all/20250218222209.1382449-1-alex.willia=
mson@redhat.com/" target=3D"_blank">https://lore.kernel.org/all/20250218222=
209.1382449-1-alex.williamson@redhat.com/</a>

for the IOMMU backend integration.
=20
</pre>
      <blockquote type=3D"cite">
        <pre>Applying the two patches above might help reduce this time. I&=
#39;m currently
running QEMU 8.2 with kernel 5.10, and directly cherry-picking these two
patches results in conflicts. I&#39;ll spend some time backporting them and
see how the results look.
</pre>
      </blockquote>
      <pre>It&#39;s generally recommended to test with recent kernel and QE=
MU,
backporting as necessary to match upstream performance and driving
improvements from an upstream perspective.  Optimizing QEMU for an
older kernel where those changes are redundant upstream, or
dis-recommended, is a downstream problem.  Thanks,

Alex
</pre>
    </blockquote>
    Yes, with the full patch set of huge pfn for CPU page table and
    IOMMU page table,<br>
    I think my patch is redundant. I dived into those related patches,
    backporting to<br>
    =C2=A0kernel 6.6 requires numerous patches, let alone kernel 5.10.</div=
><div><br>
best regards,<br>
YangWencheng</div>

</div>

--00000000000060353d06575be3ec--

