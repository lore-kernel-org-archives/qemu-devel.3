Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D584E9D827
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xdk-00017K-1X; Sun, 05 Apr 2026 20:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9Xdg-00016H-Jr
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:16:25 -0400
Received: from p-east2-cluster1-host7-snip4-10.eps.apple.com ([57.103.76.73]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9Xdd-0000pZ-0o
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:16:24 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPS id
 DA81F1800106; Mon, 06 Apr 2026 00:16:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775434579; x=1778026579;
 bh=/u7J4xmo1R0HaxN2MEL80yg2F4x3MP/Q7Wm2G1fypo0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GX4p2Iv2itnImsFesR52d1dN4MeOSmnNkZ3qkLSzwpnTeek4E3wcgM1fPH756zUE6wFUl1lJSqTSiIvFei/IyYYEFup6WO5nHyylWeW49wAjSPXLW5ggd/x0q646AtZMD42uJM1gquVhvaeTCpfWKK4Zh5yZyBDuygj1Ad/GsoDDK6akZ7qk9A+jkMSkvn+hoUQbC4T+UmJOx7IFMUFTZrTeSqllwOy1GWhaR8ePpbi5AGcbHpHwWNhete9ZLLzOhHLBm3Ce4WaXtxU/JwvZJgfkdzGh0PAaV7jXB7or3NTI141DbvdvS8JRzFr94sGagtBSqAzfQ2ZXjOBtV1GtXg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPSA id
 AED521800109; Mon, 06 Apr 2026 00:16:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
Date: Mon, 6 Apr 2026 02:16:03 +0200
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu,
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=WvIm8Nfv c=1 sm=1 tr=0 ts=69d2fb52
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=R6tJIW19AAAA:20 a=NEAV23lmAAAA:8
 a=aA-33HkQAAAA:20 a=pGLkceISAAAA:8 a=7dIyqzr6FvfTmK1K0HoA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22 a=sJAZaMKuHmt1Z9jkTlw8:22
X-Proofpoint-ORIG-GUID: _epYgB0ZCOiD3JZLBf4VVnDLTQlhmNLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwMSBTYWx0ZWRfX51KE6PW7KSvj
 MyJB+W3SVuvWuL2t1ufGrH/Ge/2Hy42POx5hUcIJ0FSxwbRqJRfdeKe81RC3FsZSP2muUNrgIwT
 /4voLpajZTpi53Xlxdnn06V53BB8dcLYHx7oKbGIrE7pS+XuLd6AwjhS4NqW6RLUbqBLg+QvwaV
 O62PFV9VZxY0yff19BIFdkIj7cYDtEwhm1kZAilGE6nNoN+bec9Dt8R40oMlVqKWNcgnU0dOBA+
 V0xBdqz4mhYSCKqzKUZKpzaPUacKuc3mli7TsUKEI74+Nfp98w7YSpr0zzqNtB8Gw9ZUcYAkGJw
 +ZZ7XkQzNo4eCPCDPCeVHYZmu0J+JZ3y61M1BMQjCxunJYjvnenn/0l3tgih6Y=
X-Proofpoint-GUID: _epYgB0ZCOiD3JZLBf4VVnDLTQlhmNLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060001
Received-SPF: pass client-ip=57.103.76.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 6. Apr 2026, at 01:20, Scott J. Goldman <scottjgo@gmail.com> wrote:
>=20
> On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 5. Apr 2026, at 10:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>>>=20
>>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>>>>=20
>>>> This series adds VFIO PCI device passthrough support for Apple =
Silicon
>>>> Macs running macOS, using a DriverKit extension (dext) as the host
>>>> backend instead of the Linux VFIO kernel driver.
>>>>=20
>>>> I'm sending this as an RFC because I'd like feedback before =
investing
>>>> further in upstreaming.  The code is functional.  I've tested it =
with
>>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>>>> gaming works but is slow (~30 fps on high settings in Cyberpunk =
2077
>>>> [1]), likely due to the BAR access penalty described below.  AI
>>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>>> generates around 140 tok/sec on the same setup [2].
>>>>=20
>>>> How it works:
>>>>=20
>>>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>>>> for device access and DMA mapping.  On macOS, there is no =
equivalent
>>>> kernel interface.  Instead, a userspace DriverKit extension
>>>> (VFIOUserPCIDriver) mediates access to the physical PCI device =
through
>>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>>=20
>>>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>>>> passthrough infrastructure.  A few ioctl callsites are refactored =
into
>>>> io_ops callbacks, the build system is extended for Darwin, and the
>>>> Apple-specific backend plugs in behind those abstractions.
>>>>=20
>>>> The guest sees two PCI devices: the passthrough device itself
>>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>>> library wraps the IOUserClient calls to the dext for config space,
>>>> BAR MMIO, interrupts, reset, and DMA.
>>>>=20
>>>> DMA limitations:
>>>>=20
>>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>>> mapping operation where the caller specifies the IOVA, the
>>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>>> system-assigned IOVA.  There is no way to request a specific =
address.
>>>> This means the guest's requested DMA addresses cannot be used
>>>> directly.  The guest kernel module must intercept DMA mapping calls
>>>> and forward them through the companion device to get the actual
>>>> hardware IOVA.
>>>=20
>>> Hello,
>>>=20
>>> Ugh this one is not great. By the way, Apple has a private PCIe =
passthrough
>>> API used by Virtualization.framework but that=E2=80=99s a different =
design.
>=20
> This is really interesting and I had not heard about this. Are you
> able to elaborate on this one at all? Maybe this is something where an
> internal API to manipulate the DART is available inside
> Virtualization.framework?

Hello,

All of it needs using private entitlements currently.

It=E2=80=99s _VZPCIPassthroughDeviceConfiguration, a private class =
needing com.apple.private.virtualization to use.

The VMM process itself then uses the =
com.apple.private.PCIPassthrough.access entitlement. I=E2=80=99m not
sure whether OS versions even have all the code currently though.

>>> Would bounce buffering using something akin the confidential compute =
path and=20
>>> a pre-defined chunk of host memory accessible from the device, and =
then managing
>>> the guest address map work? (see swiotlb).
>=20
> I tested this approach early on, but ran into a couple issues:
>=20
> 1. Not only does PrepareForDMA() limit the total size of the pool, but
>   it also limits the size of individual allocations. IIRC it not very
>   large at around 16MB.
Sigh.

> Thankfully, I found that the allocator seemed
>   to just keep allocating continguously across multiple allocations, =
so
>   maybe that's fine?
That=E2=80=99s good=E2=80=A6 but it sounds brittle=E2=80=A6

> 2. Linux swiotlb default configuration is too small for GPU drivers. =
The
>   max single mapping is 256KB and the total pool size is 64MB. The
>   overall pool size is configurable but the max single mapping is
>   derived from IO_TLB_SEGSIZE and IO_TLB_SIZE which are compile-time
>   constants. During games, I have seen roughly ~900MB of active DMA
>   mappings and mappings much larger than 256kb.

Pre-defined mappings with restricted-dma-pool sound like a good idea =
there.
>=20
> I abandoned this approach because it seemed like the CPU penalty of
> bouncing all the DMA buffers would be pretty severe and the swiotlb
> allocator just didn't seem designed for this much memory pressure. I
> also was hoping to avoid the requirement of recompiling the entire =
guest
> kernel as a prerequisite for guests to use this passthrough feature. =
On
> top of that, I wasn't sure if upstream would even be willing to take
> changes to support this use case, since it's so far outside what the
> existing swiotlb allocator would normally be doing.
>=20
> That said, you were saying that CoCo is fine with this restriction? Do
> other devices just not have drivers that are doing so much allocation? =
I
> didn't actually try changing the constants and recompiling the guest
> kernel in swiotlb to make the pool big enough for it to really work at
> all with the nvidia guest driver, I will have to see what happens.

CoCo with bounce buffering works with NVIDIA GPUs. It had to be done =
because
no trusted I/O path (and implementing that is a quagmire).

A recent Intel post about it claiming production-readiness:

=
https://community.intel.com/t5/Blogs/Tech-Innovation/Artificial-Intelligen=
ce-AI/Confidential-AI-with-GPU-Acceleration-Bounce-Buffers-Offer-a/post/17=
40417

>=20
>>=20
>> see restricted-dma-pool
>>=20
>> I think in this specific case that ACPI support isn=E2=80=99t worth =
it and that FDT
>> will be good enough.
>=20
> Yes, this seems fine to me as well if we went the swiotlb route. It
> could be a different `-machine` type or perhaps a machine-specific =
param
> if we went this route, maybe.
>=20
>>=20
>> The limitation that I can see there if if you can=E2=80=99t match =
IOVA and GPA for that
>> restricted DMA pool, then you=E2=80=99ll need a small (and hopefully =
easy to merge) kernel
>> change.
>>> If the last part isn=E2=80=99t possible, something minimal to export =
an swiotlb window
>>> through device tree with giving the IOVA there would be good too.
>>>=20
>>> And that will get rid of a need for a apple-dma-pci device.
>=20
> I am not 100% sure since I didn't try this exactly, but it seems like
> you could have the DriverKit side allocate a big DMA buffer before the
> guest starts, and then identity map the region somewhere inside the
> guest with the `restricted-dma-pool` attribute attached to it. The
> caveat being that you might have to pray that the region is contiguous
> or introduce a much more complicated swiotlb subsystem allocator.
>=20
> WRT a kernel patch to make it easier, can you elaborate on what you =
werelt thinking there?

Using restricted-dma-pool - with changes to be able specify to IOVA base =
if necessary.
>=20
>>>> There are also hard platform limits: approximately 1.5 GB total
>>>> mapped memory and roughly 64k concurrent mappings.  Not all
>>>> workloads will fit within these limits, though GPU gaming and LLM
>>>> inference have worked in practice.
>>>=20
>>> That=E2=80=99s not too dissimilar from the confidential compute =
limitations.
>>>=20
>>>>=20
>>>> BAR access has performance issues as well.  HVF does not expose
>>>> controls to map device memory as cacheable in the guest, creating a
>>>> significant performance penalty on BAR MMIO.  Uncached mappings =
work
>>>> correctly but slowly compared to what the hardware could do.
>>>=20
>>> That=E2=80=99s not a macOS limitation and not an Apple hardware =
limitation, but
>>> it=E2=80=99s more fundamental to how PCIe works.
>>>=20
>>> Unlike CXL, PCIe doesn=E2=80=99t have a coherency protocol story, =
and the alternative
>>> of uncached and doing manual software-managed flushes isn=E2=80=99t =
really tenable.
>=20
> Apologies, I misspoke. It's not cacheability that's the issue. I think
> it's write-combining. Specifically the question is how the HVF sets =
the=20
> attributes in the stage-2 page tables. The behavior is observable by
> looking at the performance of sweeping writes across the BARs.
>=20

Hello,

Oh that makes a lot more sense.

There are also other oddities going on there. For device memory, macOS =
does this thing:
=
https://github.com/apple-oss-distributions/xnu/blob/main/osfmk/arm64/sleh.=
c#L1756C1-L1756C33

This function is empty in open-source XNU, but it=E2=80=99s very much =
*not* empty in closed-source XNU (sigh).

> As part of the work to implement and test this change I wrote such a
> benchmark as a client of the dext in the host, and a Linux kernel =
module
> that runs in the guest. It takes BAR1 (VRAM aperture) and does a write
> sweep of 8MB with 4 passes and measures the results.
>=20
> Host (mapped with kIOWriteCombineCache): 386mb/sec
> Host (mapped with kIInhibitCache): 46mb/sec
>=20
> Guest (mapped with ioremap_wc) 31mb/s
> Guest (mapped with ioremap): 31mb/s
>=20
> In the case of BAR1, it is marked prefetchable so I believe you would
> usually want to map it with write-combining. I'm not sure why the case
> without write-combining is worse in the guest, but it's the same order
> of magnitude. I think the real interesting thing there is that the
> write-combining map in the guest performs identically to the one=20
> without. To me, that indicates that perhaps the stage-2 bits are not =
set
> properly.

That indeed looks like that...
> Even though the host has mapped the memory with
> kIOWriteCombineCache, this wasn't propogated when HVF maps this into =
the
> guest, which probably falls back to the lesser of the stage-1 vs =
stage-2
> mappings (i.e. disabling write-combining).=20
>=20
>=20
>>>=20
>>>>=20
>>>> What works:
>>>> - PCI config space passthrough
>>>> - BAR MMIO via direct-mapped device memory
>>>> - MSI/MSI-X interrupts via async notification from the dext
>>>> - Device reset (FLR with hot-reset fallback)
>>>> - DMA mapping for guest device drivers
>>>>=20
>>> This is very interesting to see :)
>=20
> Thanks! It's always nice to catch some interest/advice for a strange
> project like this.
>=20
>>>=20
>>>> What doesn't work:
>>>> - Expansion ROM / VBIOS passthrough
>>>> - PCI BAR quirks
>>>> - VGA region passthrough
>>>> - Migration and dirty page tracking
>>>> - Hot-unplug
>>>>=20
>>>=20
>>>=20
>>>=20
>>>> Questions for reviewers:
>>>>=20
>>>> 1. Is this something the VFIO maintainers would consider carrying
>>>> upstream?  The refactoring patches (3-6) are benign, but the Apple
>>>> backend is a new platform with real limitations.  That said, if =
Apple
>>>> lifts some of the DART/HVF restrictions in a future macOS release, =
the
>>>> code changes to take advantage would likely be minor.  I'd like to
>>>> understand whether this is in scope before doing the work to
>>>> address review feedback on the full series.
>>>>=20
>>>> 2. The apple-dma-pci companion device: should this be a virtio =
device
>>>> instead?  I went with a simple custom PCI device because the virtio
>>>> infrastructure didn't buy much for what is essentially a {map, =
unmap}
>>>> register interface, but if virtio is preferred, what is the process
>>>> for allocating a device ID?  If a custom PCI device is the right
>>>> approach, I've tentatively allocated 1b36:0015.  Is there a process
>>>> for reserving a device ID under the Red Hat PCI vendor, or is
>>>> claiming it in pci-ids.rst sufficient?  The guest-side kernel =
module
>>>> hooks all DMA mapping functions for passed-through devices, which =
is
>>>> unusual enough that I'm not sure it's upstreamable in the Linux
>>>> kernel.  I can maintain it out of tree if needed.
>>>=20
>>> I=E2=80=99d recommend using bounce buffers like the CoCo case if =
possible. I don=E2=80=99t
>>> think that the apple-dma-pci definitely-not-an-IOMMU is a good idea.
>=20
> To be clear, it definitely is weird and bad, but it was seemingly the
> least bad option that I was able to get working with minimal guest
> changes (just one guest kmod).
>=20
>>>=20
>>>>=20
>>>> 3. Should the macOS host-side DriverKit extension live in the QEMU
>>>> tree?  It's not included in this series and requires Apple code
>>>> signing.  I'm happy to keep it out of tree if that's preferred,
>>>> or include the source if reviewers want it co-located.
>>>=20
>>> Both are fine I think. Could you share compatibility with the =
tinygrad
>>> one at =
https://github.com/tinygrad/tinygrad/tree/7e54992bf600789dbe5d37b99fe12a19=
c32e36a1/extra/usbgpu/tbgpu/installer and prebuilt at =
https://raw.githubusercontent.com/tinygrad/tinygpu_releases/refs/heads/mai=
n/TinyGPU.zip?
>=20
> This is a good question and not something I had considered. My module
> probably works a little different than their module. It's possible I'm
> wrong but my understanding was:
>=20
> 1. They got apple entitlements for AMD/NVIDIA driver vendor ids only.
>   That said, if it became compatible with QEMU, I suppose it would be
>   an easy case to make that it could be expanded to wildcard (another
>   developer indicated to me that Apple was willing to grant the
>   wildcard entitlement if the use case was justifiable)
> 2. The architecture of their driver is a little different. I believe
>   they are allocating DMA-able memory in the driver and mapping it =
down
>   to userland, so it's kind of the reverse of what I'm doing now. I
>   guess, conceivably they could change how they are doing this to =
unify
>   our efforts.
>=20
> Thanks,
> -sjg
>=20


