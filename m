Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF8CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfsh-0004Ru-2a; Tue, 01 Oct 2024 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+3a746e6341840b9b25e3+7709+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1svfse-0004Q8-Dz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:37:45 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+3a746e6341840b9b25e3+7709+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1svfsa-0005t6-Jh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CYqsn0SaE8mlKt7sK/HFp+JICnaZ7nQGJz+/fnzzSZg=; b=iQmHwDYXuyHQ/CsjoN7Dd+N4LX
 GR1GQAvE5g+G3HYUZWBCMcsLpITc4UCqcRPgp4ypaos+TJw6UP5UP2q4WYHqS7zkajVxorEFREnuB
 cjLKUr27ecBD3utEyUE4G0pPXSi+XsLWiXkzWw8hqnfXeNZYcKsnRvX7Ru7MToHTYnbAKRwmrF1rI
 wWDSmS+peZjZP6gJwsipWf63gra1jrrOXwNf4atpEF09fGLMAe4WStgheu4dTQFDnlfThjpWWIHnY
 K798ll21AjOIYIqUr/FFamo0RdTKN/epr/5a3tlg5vh7zeQJqAQCWW8J4USV+JLNd59yZYKi6crWD
 XPaRtAJg==;
Received: from [2001:8b0:10b:5:bced:fb63:3d59:27e3]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1svfsS-00000002w0a-3iRB; Tue, 01 Oct 2024 16:37:33 +0000
Message-ID: <25db532f21b8395bec58712294ba45fe6f9f393f.camel@infradead.org>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
From: David Woodhouse <dwmw2@infradead.org>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Sandesh Patel <sandesh.patel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Rob Scheepens <rob.scheepens@nutanix.com>, Prerna
 Saxena <confluence@nutanix.com>, Alexander Graf <agraf@csgraf.de>
Date: Tue, 01 Oct 2024 17:37:33 +0100
In-Reply-To: <Zvv6JOiyyQZp39pI@redhat.com>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <a80c99b0e10e71a5a301c884d699eeaff3893349.camel@infradead.org>
 <Zvv6JOiyyQZp39pI@redhat.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-CbBcVJpc3E6q+2eTxklV"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+3a746e6341840b9b25e3+7709+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


--=-CbBcVJpc3E6q+2eTxklV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-10-01 at 14:33 +0100, Daniel P. Berrang=C3=A9 wrote:
>=20
> > It looks like when interrupt remapping is enabled with an AMD CPU,
> > Windows *assumes* it can generate AMD-style MSI messages even if the
> > IOMMU is an Intel one. If we put a little hack into the IOMMU interrupt
> > remapping to make it interpret an AMD-style message, Windows seems to
> > boot at least a little bit further than it did before...
>=20
> Rather than filling the intel IOMMU impl with hacks to make Windows
> boot on AMD virtualized CPUs, shouldn't we steer people to use the
> amd-iommu that QEMU already ships [1] ?

No, because there's no way to disable *DMA* translation on that.

We absolutely don't want to offer guests another level of DMA
translation under their control, because of the performance and
security implications.

The way we implement 'dma-translation=3Dpff' for Intel IOMMU is a bit of
a hack, disabling all three of the SAGAW bits which advertise support
for 3-level, 4-level or 5-level page tables and thus leaving the guest
without *any* workable DMA page table setup. (I have asked Intel to
officially bless this trick, FWIW).

Linux *used* to panic when it saw this, but I fixed it when I added the
'dma-translation=3Doff' support to QEMU. Windows always just quietly
refrained from using such an IOMMU for DMA translation, while still
using it for Interrupt Remapping. Which was the point.

> Even if we hack the intel iommu, so current Windows boots, can we
> have confidence that future Windows releases will correctly boot
> on an intel iommu with AMD CPUs virtualized ?

I'm not really proposing that we hack the Intel IOMMU like this; it's a
proof of concept trying to understand the Windows bugs.

And it *only* works for interrupts generated by the I/O APIC anyway.
For real PCI MSI, Windows still generates an AMD-style remappable MSI
message but *doesn't* actually program it into the IOMMU's table!
Probably because in AMD mode, the IRTE indices are per-device rather
than global.

For PCI MSI(-X) we're actually better off without an IOMMU because then
we see a *different* Windows bug =E2=80=94 it just puts the high bits of th=
e
APIC ID into the high bits of the MSI address, instead. Obviously such
an MSI *ought* to miss the APIC at 0x00000000FEExxxxx completely, and
just scribble over guest memory, but we can cope with that as I showed
in a later email.

At this point I'm just hacking around and trying to understand how
Windows behaves; until I do that I don't have any concrete suggestions
for if/how we should attempt to support it.

There is a Design Change Request open with Microsoft already, to fix
some of this and use the KVM/Xen/Hyper-V 15-bit MSI extension sensible.
Hopefully they can fix it, and we don't have to worry too much about
what future Windows versions will do because they'll be a bit saner.

In the meantime we're trying to work out if it's even possible to make
today's versions of Windows work, without having to give them DMA
translation support.

With `-cpu host,+hv-avic` and a hack in pci_msi_trigger() to handle the
erroneous high bits in the MSI address, I do have Windows Server 2022
booting. I'm not sure what would happen if it ever tried to target an
I/O APIC interrupt at a CPU above 255 though.

FWIW I *already* wanted to rewrite QEMU's MSI handling before we gained
TCG X2APIC support, and now I want to rewrite it even more, even
without this Windows nonsense. We should have a *single* translation
function which covers KVM and TCG, which includes IOMMUs, Xen's PIRQ
hack, the 15-bit MSI extension, this Windows bug (if we want to support
it), and which will allow the IOMMU to know whether to deliver an IRQ
fault event or not. And which handles the cookies needed for IOMMU
invalidation, which needs to kick eventfd assignments out of the KVM
irq routing table.

When a guest programs a PCI device's MSIX table, this function should
be called with deliver_now=3D=3Dfalse. If the translation succeeds, yay! It
should be put into the KVM routing table and the VFIO eventfd should be
attached (which will allow posted interrupts to work). If the
translation fails, QEMU should just listen on the VFIO eventfd for
itself.

When an MSI happens in real time, either because a VFIO eventfd fires
or because an emulated PCI device calls pci_msi_trigger(), it calls the
same function with 'deliver_now=3D=3Dtrue'. If an IOMMU lookup *still*
fails, that's when the IOMMU will actually raise a fault.

That function allows us to collect all the various MSI format nonsense
in *once* place and handle it cleanly, converting to the KVM X2APIC MSI
format which both KVM *and* the TCG X2APIC implementation accept.

It would have a comment which looks something like this...

(Signed-off-by: David Woodhouse <dwmw@amazon.co.uk> in case anyone gets
around to such a rewrite before I do, and/or just wants to nab this and
put it somewhere useful)

/*
 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 * MSI MESSAGE FORMATS
 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 *
 * Message Signaled Interrupts are simply DMA transactions from the device.
 * It really is just "write <these> 32 bits <here> when you want attention.=
"
 * The MSI (or MSI-X) message configured in the device is just the 64 bits
 * of the address to write to, and the 32 bits to write there.
 *
 * You can use this to do polled I/O by telling the device to write into a
 * data structure of your own choosing, then checking to see when it does
 * so.
 *
 * Or you can tell the device to poke at MMIO on *another* device, for
 * example when it's finished receiving a packet and it's time for the next
 * device to process that packet.
 *
 * Or =E2=80=94 and this one is *actually* how it's expected to be used by =
sane
 * operating systems =E2=80=94 you can point it at a special region of "phy=
sical
 * memory" which isn't actually memory; it's really an MMIO device which
 * can be used to trigger interrupts.
 *
 * That MMIO device is called the APIC, and on x86 machines it lives at
 * 0x00000000FEExxxxx in the physical memory space (the real one in host
 * physical space, and a virtual one in guest physical space).
 *
 * When the APIC receives a write transaction, it looks at the low 24 bits =
of
 * the address, and the 32 bits of data, and that conveys all the informati=
on
 * about which interrupt vector to raise on which CPU, and a few more detai=
ls
 * besides. Some of those details include special cases like cluster delive=
ry
 * modes and ways to delivery NMI/INIT/etc. which we won't go into here.
 *
 * Ih the beginning, there was only one way of doing this. This is what Int=
el
 * documentation now calls "Compatibility Format" (=C2=A75.1.2.1 of the VT-=
d spec).
 * It has 8 bits for the Destination APIC ID which are in bits 12-19 of the
 * MSI address (i.e. the XX in 0xfeeXX...). The *vector* to be raised on th=
at
 * CPU is in the low 8 bits of the data written to that address.
 *
 *
 * Compatibility Format
 * --------------------
 *
 * Address: 1111.1110.1110.dddd.dddd.0000.0000.rmxx
 *               0xFEE    . Dest ID .  Rsvd   .=E2=86=91=E2=86=91=E2=86=91
 *                                             ||Don't Care
 *                                             |Destination Mode
 *                                             Redirection Hint
 *
 * Data:    0000.0000.0000.0000.TL00.0DDD.vvvv.vvvv
 *               Reserved      .=E2=86=91=E2=86=91     =E2=86=91 .  Vector
 *                              ||     Delivery Mode
 *                              Trigger Mode, Trigger Mode Level
 *
 * Crucially, this format has only 8 bits for the Destination ID. Since 0xF=
F
 * is the broadcast address, this allows only up to 255 CPUs to be supporte=
d.
 *
 * For many years the Reserved bits in bit 4-11 of the address were labelle=
d
 * in some Intel documentation as "Extended Destination ID", but never used=
.
 *
 *
 * I/O APIC Redirection Table Entries
 * ----------------------------------
 *
 * The I/O APIC is just a device for turning line-level interrupts into MSI
 * messages. Each pin on the I/O APIC has a Redirection Table Entry (RTE)
 * which configures the MSI message to be sent. The 64 bits of the RTE
 * include all the fields of the Compatibility Format MSI, including the
 * Extended Destination ID, but basically shuffled into a strange order for
 * historical reasons. Creating a Compatibility Format MSI from an I/O APIC
 * RTE is basically just a series of masks and shifts to move the bits into
 * the right place. Linux will compose an MSI message as appropriate for th=
e
 * actual APIC or IOMMU in use (we'll get to those), then just shuffle the
 * bits around to program the I/O APIC RTE.
 *
 *
 * Intel "Remappable Format"
 * -------------------------
 *
 * When Intel started supporting more than 255 CPUs, the 8-bit limit in wha=
t
 * was not yet called "Compatibility Format" became a problem. To support
 * the full 32 bits of logical X2APIC IDs they had to come up with another
 * solution. Since MSIs are basically just a DMA write, the logical place f=
or
 * this was the IOMMU, which already intercepts DMA writes from devices. So
 * they invented "Interrupt Remapping". The "Remappable Format" MSI does no=
t
 * directly encode which vector to send to which CPU; instead it just
 * identifies an index into an IOMMU table (the Interrupt Remapping Table).
 *
 * The Interrupt Remapping Table Entry (IRTE) contains all the information
 * which was once present in the MSI address+data, but allows for a full 32
 * bits of destination ID. (It can also be used for posted interrupts,
 * delivering the interrupt *direcftly* to a vCPU in guest mode).
 *
 * To signal a Remappable Format MSI, Intel used bit 4 of the MSI address,
 * which is the lowest of the bits which were previously labelled "Extended
 * *Destination ID". With an Intel IOMMU doing Interrupt Remapping, you can
 * either submit Remappable Format MSIs, *or* Compatibilly Format, and the
 * IOMMU will only actually remap the former. (It can be told to block the
 * latter, for security reasons.)
 *
 * Intel calls the IRTE index the "handle". There are some legacy multi-MSI
 * devices which can't be explicitly configured with a different address/da=
ta
 * for each interrupt, but just add one to the data for each consecutive MS=
I
 * vector they generate. This *used* to correspond to consecutive IRQ vecto=
rs
 * on the same CPU. To cope with this, Intel added a "Subhandle" in the low
 * bits of the data, which *optionally* adds those bits to the handle
 * extracted from the MSI address:

 * Address: 1111.1110.1110.hhhh.hhhh.hhhh.hhh1.shxx
 *               0xFEE    .   Handle[14:0]    .=E2=86=91=E2=86=91=E2=86=91
 *                                             ||Don't Care
 *                                             |Handle[15]
 *                                             Subhandle Valid (SHV)
 *
 * Data:    0000.0000.0000.0000.ssss.ssss.ssss.ssss
 *               Reserved      .  Subhandle (if SHV=3D=3D1 in address)
 *
 * These is a slight complexity here for the I/O APIC, which doesn't *just*
 * shuffle the bits around to generate an MSI, but also handles EOI of line
 * level interrupts (and has to re-raise the IRQ if the line is actually
 * still asserted). For that, the I/O APIC interprets the RTE bits with the=
ir
 * original "compatibility" meaning. All those bits actually end up in the
 * low bits of the MSI data, so the OS has to program those bits accordingl=
y
 * even though it sets SHV=3D0 so they're actually *ignored* when generatin=
g
 * the interrupt.
 *
 *
 * AMD Remappable MSI
 * ------------------
 *
 * AMD's IOMMU is completely different to Intel's, and they didn't make
 * things anywhere near as complicated. When the IOMMU is enabled, a
 * device cannot send "Compatibility Format" MSIs any more, so there is
 * no need to tell one format from the other. AMD just used the low 11
 * bits of the data as the IRTE index, and nothing else matters.
 *
 * Address: 1111.1110.1110.xxxx.xxxx.xxxx.xxxx.xxxx
 *               0xFEE    .       Don't Care
 *
 * Data:    xxxx.xxxx.xxxx.xxxx.xxxx.xiii.iiii.iiii
 *               Don't Care            IRTE Index
 *
 * The reason for using only 11 bits of IRTE index is because, as described
 * above, the I/O APIC actually *does* care about bit 11 of the MSI data,
 * (or, more accurately, it cares about the RTE bit which gets shuffled int=
o
 * bit 11 of the MSI data). That's the original "Trigger Mode" bit, which t=
he
 * I/O APIC needs in order to re-raise level-triggered interrupts which are
 * EOI'd while they're still asserted.
 *
 * Although the Intel IOMMU has a single Interrupt Remapping Table and a
 * single number space for IRTE indices across the whole system, the AMD
 * IOMMU has a table per device. This, sadly becomes important later.
 *
 * The 15-bit MSI extension
 * ------------------------
 *
 * The problem with IOMMUs is that they were designed to support DMA
 * translation, and there is no architectural way to disable that and offer
 * guests an IOMMU which *only* supports Interrupt Remapping. We really don=
't
 * want guests doing DMA translation, as it has severe performance and
 * security implications.
 *
 * So KVM, Hyper-V and Xen all define a virt extension which uses 7 of the
 * original "Extended Destination ID" bits to give support for up to 32768
 * virtual CPUs. (This extension avoids the low bit which Intel used to
 * indicate Remappable Format). This format is exactly like the Compatibili=
ty
 * Format, except that bits 5-11 of the MSI address are used as bits 8-15
 * of the destination APIC ID:
 *
 * Address: 1111.1110.1110.dddd.dddd.DDDD.DDD0.rmxx
 *               0xFEE    . Dest ID .ExtDest  .=E2=86=91=E2=86=91=E2=86=91
 *                                             ||Don't Care
 *                                             |Destination Mode
 *                                             Redirection Hint
 *
 * Data:    0000.0000.0000.0000.TL00.0DDD.vvvv.vvvv
 *               Reserved      .=E2=86=91=E2=86=91     =E2=86=91 .  Vector
 *                              ||     Delivery Mode
 *                              Trigger Mode, Trigger Mode Level
 *
 *
 * Xen MSI =E2=86=92 PIRQ mapping
 * ----------------------
 *
 * All of the above are implementable in real hardware. Actual external PCI
 * devices can perform memory transactions to addresses in the physical
 * address range 0x00000000FEExxxxx, which reach the APIC and cause
 * interrupts to be injected into the relevant CPU.
 *
 * But Xen guests know that they are running in a virtual machine. So they
 * know that the PCI config space is a complete fiction. For example, if th=
ey
 * set up a BAR of a given device with a certain address, that is a *guest*
 * physical address. The hypervisor probably doesn't even change anything o=
n
 * the device itself; it just adjusts the EPT page tables to make the
 * corresponding BAR *appear* in the guest physical address space at the
 * desired location.
 *
 * MSI messages are similarly fictional. The guest configures a PCI device
 * with its own vCPU APIC ID and vector, and the real hardware wouldn't kno=
w
 * what to do with that. (Well, we could design an IOMMU which *could* cope
 * with that, let guests write directly to the PCI devices' MSI tables, and
 * use the resulting MSIs for posted interrupts as a first-class citizen, b=
ut
 * nobody's done that.)
 *
 * In practice, what happens is that the hypervisor registers its *own*
 * handler for the interrupt in question (routing it to a given vector on a
 * given *host* CPU). When that host interrupt handler is triggered, the
 * hypervisor injects an interrupt to the guest vCPU accordingly. Most
 * hypervisors, including Xen and KVM, do *not* have a mechanism to simply
 * write to guest memory *instead* of injecting an interrupt. So if the gue=
st
 * configured the MSI to target an address outside the 0x00000000FEExxxxx
 * range, it just gets dropped. (Boo, no DPDK polled-mode implementations
 * abusing MSIs for memory writes, in virt guests!)
 *
 * This means that we can abuse the high 32 bits of the address even in a
 * guest-visible way, right? Nothing would ever go wrong...
 *
 * Xen was the first to do this. It needed a way to map MSI from PCI device=
s
 * to a 'PIRQ', which is a form of Xen paravirtualised interrupt which bind=
s
 * to Xen Event Channels. By using vector#0, Xen guests indicate a special
 * MSI message which is to be routed to a PIRQ. The actual PIRQ# is then in
 * the original Destination ID field... and the high bits of the address.
 *
 * (We'll gloss over the way that Xen snoops on these even while masked, an=
d
 * actually unmasks the MSI when the guests binds to the corresponding PIRQ=
,
 * because there's only so much pain I can inflict on the reader in one
 * sitting.)
 *
 * AddrHi:  DDDD.DDDD.DDDD.DDDD.DDDD.DDDD.0000.0000
 *                    PIRQ#[31-8]        .  Rsvd
 *
 * AddrLo:  1111.1110.1110.dddd.dddd.0000.0000.xxxx
 *               0xFEE    .PIRQ[7-0].  Rsvd   .Don't Care
 *
 * Data:    xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.0000.0000
 *                  Don't Care           . Vector =3D=3D 0
 *
 *
 * KVM X2APIC MSI API
 * ------------------
 *
 * KVM has an ioctl() for injecting MSI interrupts, and routing table entri=
es
 * which cause MSIs to be injected to the guest when triggered. For
 * convenience, KVM originally just used the Compatibility Format MSI messa=
ge
 * as its userspace ABI for configuring these. This got less convenient whe=
n
 * X2APIC came along and we needed an extra 24 bits for the Destination ID.
 *
 * KVM's solution was to abuse the high 32 bits of the address, If this was=
 a
 * true memory transaction, such a write would miss the APIC completely and
 * scribble over guest memory at an address like 0x00000100FEExxxxx. But in
 * this case it's just an ABI between KVM and userspace, using bits which
 * would otherwise be completely redundant. KVM uses the high 24 bits of th=
e
 * MSI address (bits 40-63) as the high 24 bits of the destination ID.
 *
 * AddrHi:  DDDD.DDDD.DDDD.DDDD.DDDD.DDDD.0000.0000
 *            Destination ID bits 8-31   .  Rsvd
 *
 * AddrLo:  1111.1110.1110.dddd.dddd.0000.0000.rmxx
 *               0xFEE    . Dest ID .  Rsvd   .=E2=86=91=E2=86=91=E2=86=91
 *                                             ||Don't Care
 *                                             |Destination Mode
 *                                             Redirection Hint
 *
 * Data:    0000.0000.0000.0000.TL00.0DDD.vvvv.vvvv
 *               Reserved      .=E2=86=91=E2=86=91     =E2=86=91 .  Vector
 *                              ||     Delivery Mode
 *                              Trigger Mode, Trigger Mode Level
 *
 * This hack is not visible to a KVM guest. What a KVM guest programs into
 * the MSI descriptors of passthrough or emulated PCI devices is completely
 * different, and (at this point in our tale of woe, at least) never sets
 * the high 32 bits of the target address to anything but zero.
 *
 *
 * IOMMU interrupts
 * ----------------
 *
 * Since an IOMMU is responsible for remapping interrupts so they can reach
 * CPUs with higher APIC IDs, how do we actually configure the events from
 * the IOMMU itself?
 *
 * Intel uses the same format as the KVM X2APIC API (which may actually hav=
e
 * been why KVM did it that way). Since it's never going to be an actual
 * memory transaction, it's safe to abuse the high bits of the address. Int=
el
 * offers { Data, Address, Upper Address } registers for each type of event
 * that the IOMMU can generate for itself, with the high 24 bits of the
 * destination ID in the higher 24 bits of the address as shown above.
 *
 * AMD's IOMMU uses a completely different 64-bit register format (e.g XT
 * IOMMU General Interrupt Control Register) which doesn't pretend very har=
d
 * to look like an MSI at all. But just happens to have the DestMode at bit
 * 2, like in the MSI address. And just happens to have the vector and
 * Delivery Mode (from the low 9 bits of the MSI data) in the low 9 bits of
 * its high word (bits 32-40 of the register). And then just throws the
 * actual destination ID in around them in some other bits:
 *
 * Low32:   dddd.dddd.dddd.dddd.dddd.dddd.xxxx.xmxx
 *             Destination ID [23-0]     . DC . =E2=86=91=E2=86=91
 *                                              |Don't Care
 *                                              Destination Mode
 *
 * High32:  DDDD.DDDD.xxxx.xxxx.xxxx.xxxD.vvvv.vvvv
 *        DestId[31-24]                 =E2=86=91.  Vector
 *                                      Delivery Mode
 *
 *
 * Windows, part 1: Intel IOMMU with no DMA translation
 * ----------------------------------------------------
 *
 * As noted above, the 15-bit extension was invented to avoid the need for
 * an IOMMU, because it is undesirable to offer a virtual IOMMU to guests
 * with support for them to do their own additional level of DMA translatio=
n.
 *
 * However, although Hyper-V exposes the 15-bit MSI feature, Windows as a
 * guest OS does not use it. In order to support Windows guests with more
 * than 255 vCPUs, a hack was found for the Intel IOMMU. Although there is =
no
 * official way to advertise that the IOMMU does not support DMA translatio=
n,
 * there *are* "Supported Adjusted Guest Address Width" bits which advertis=
e
 * the ability to use 3-level, 4-level, and/or 5-level page tables. If
 * Windows encounters an IOMMU which sets *none* of these bits, Windows wil=
l
 * quietly refrain from attempting to use that IOMMU for DMA translation, b=
ut
 * will still use it for Interrupt Remapping.
 *
 * However, this only works correctly if Windows is running on an Intel CPU=
.
 * When Windows runs on an AMD CPU, it will happily configure and use the
 * Intel IOMMU, but misconfigures the MSI messages that it programs into th=
e
 * devices. For I/O APIC interrupts, Windows programs the IRTE in the Intel
 * IOMMU correctly... but then configures the I/O APIC using the AMD format
 * (with the IRTE index where the vector would have been). A hack to the
 * virtual Intel IOMMU emulation can make it cope with this bug... but sadl=
y
 * it *only* works for I/O APIC interrupts. For actual PCI MSI, Windows sti=
ll
 * configures the device with an AMD-style remappable MSI but *doesn't*
 * actually configure the IRTE in the IOMMU at all. This is probably becaus=
e
 * Intel's IRT is system-wide, while AMD has one per device; Windows does
 * seem to think it's using a separate IRTE space, so the first MSI vector
 * gets IRTE index 0 which conflicts with I/O APIC pin 0.
 *
 * So for PCI, the hypervisor has no idea where Windows intended a given MS=
I
 * to be routed, and cannot work around the Windows bugs to support >255 AM=
D
 * vCPUs this way.
 *
 *
 * Windows, part 2: No IOMMU
 * -------------------------
 *
 * If we do *not* offer an IOMMU to a Windows guest which has CPUs with hig=
h
 * APIC IDs, we encounter a *different* Windows bug, which is easier to wor=
k
 * around. Windows doesn't use the 15-bit extension described above, but it
 * *does* just throw the high bits of the destination ID into bits 32-55 of
 * the MSI address.
 *
 * Done without negotiation or discovery of any hypervisor feature, this
 * arguably ought to cause the device to write to an address in guest
 * *memory* and miss the APIC at 0x00000000FEExxxxx altogether, but we
 * already admitted almost no hypervisors actually *do* that. (QEMU is the
 * exception here, because for *emulated* PCI devices, pci_msi_trigger() do=
es
 * actually generate true write cycles in the corresponding DMA address
 * space.)
 *
 * We can cope with this Windows bug and even use it to our advantage, by
 * spotting the high bits in the MSI address and using them. It does requir=
e
 * that we have an API which is specifically for *MSI*, not to be conflated
 * with actual DMA writes. So QEMU's pci_msi_trigger() would have to do
 * things differently. But let's pretend, for the same of argument, that I'=
m
 * typing this C-comment essay into a VMM other than QEMU, which already
 * does think that way and has a cleaner separation of emulated-PCI vs. the
 * VFIO or true emulation which can back it, and *does* always handle MSIs
 * explicity.
 *
 * In that case, all the translation function has to do, in addition to
 * invoking all the IOMMU and Xen and 15-bit translators as QEMU's
 * kvm_arch_fixup_msi_route() function already does, is add one more trivia=
l
 * special case. This format is the same as the KVM X2APIC API format, with
 * the top 32 bits of the address shifted by 8 bits:
 *
 * AddrHi:  0000.0000.DDDD.DDDD.DDDD.DDDD.DDDD.DDDD.0000.0000
 *            Rsvd   .         Destination ID bits 8-31
 *
 * AddrLo:  1111.1110.1110.dddd.dddd.0000.0000.rmxx
 *               0xFEE    . Dest ID .  Rsvd   .=E2=86=91=E2=86=91=E2=86=91
 *                                             ||Don't Care
 *                                             |Destination Mode
 *                                             Redirection Hint
 *
 * Data:    0000.0000.0000.0000.TL00.0DDD.vvvv.vvvv
 *               Reserved      .=E2=86=91=E2=86=91     =E2=86=91 .  Vector
 *                              ||     Delivery Mode
 *                              Trigger Mode, Trigger Mode Level
 */

bool arch_translate_msi_message(struct kvm_irq_routing_entry *re,
				const struct kvm_msi *in,
				uint64_t *cookie,
				bool deliver_now)
{

--=-CbBcVJpc3E6q+2eTxklV
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMDAxMTYzNzMzWjAvBgkqhkiG9w0BCQQxIgQgA9PaWHNW
PwspQgZPYzGBXcrrihhLpLjpTZADxAzLVsQwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCCQIxTKwvcEqJxuYAbG9rgIjsIgPj2L2jP
ptF7oJdHDJHGqbabvQgKzJuLBNwcRRcyfCLMATYiED9UQ9W9hk1nCxVWN4P4T+N2+SzbJL2SM6g+
pKUZPXc3/G8jXe6W9Q3lF85gXSM72c3GDFRrcDH9Qz1d9C2gB2MgO5Cr9XPnOxR10TaaZy0wgOfw
GPb8RJ0suJaOFuhSW71tmV4P+ccOc+Cko12/9GXIA5+YqXWpAoyF+rQbXP3LP7QRqXQWcc4x+h5C
/4SrdsLHbNC5msH8yM/oTJYShaKE0zwj1nd2U9xAw9+lJbZFBOAZSfhF8ups8UsTGNItPh4+DU+0
JqVzmha3+JY+tnSQInWYLir00wZZpWQ+K2NSDOpWgtV7lNBVbHOncY4iDodmaY7HE7HoNsNgK2DI
k19RQ8grB6r+tSeqCnnWffG/np5kRd4HIhPPriGOhsGcYVc9JNy88xF3wYNeG2QPbS49+3huwmto
qbMEbrsIBy4LUgoNr8F96IjgBk6jQ2W8v7QGwhPhOPWX/vYSHOkpvqV8NROOZy/8EoHCgbKOxH9n
H0UqJlqKU01DKnIsRpjiBy+tp+a1kp+vzKPTXnUPS/yBD6Yts9VYCqpMTyuHp2F3SY6/i+PsV6QT
Vhm6UemONnhm3p5ZO07IWWroH8dAS0ZvLdepUcN2ZQAAAAAAAA==


--=-CbBcVJpc3E6q+2eTxklV--

