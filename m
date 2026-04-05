Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B784AE9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Wm9-00028n-Tf; Sun, 05 Apr 2026 19:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9Wm1-000277-VE
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:20:58 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9Wlz-0002jT-EU
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:20:57 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso3600930eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775431254; x=1776036054; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyNFCc3lmN4ZV810CoDdVOEIXuWzwi7k9pvCxQa9iMc=;
 b=bKk5PfrZjNbFWmXAqOces0g3uCNSu9mZnLATZPYwNugKwqir0FSBpIffUUJCuvgEYa
 8FWGGr+yy2nRP/gKEIbXiJNTXb6lr2cNabeC9YGI+qCSqL0POidw46jHW5LF7aoLNth8
 UnVZwvKGuptopXDoRrVuTCartrfR/r6ZpUuQiAt+Qojr0ee/sraZZXwFgzqh23AFmQaK
 Y7lfGEqyY53F2Zb6itGkq8Nowzzk/2FnXuFbdfPE8M0J7LbTFE78Cj0oLvO4Mal8N6K0
 JuFP7gTfzpsllbdGuDNEtI8/hsc66tiQyzn9ToxTM/FRCo8PYOiVQOurTWh/fjcX+Qmr
 YjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431254; x=1776036054;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyNFCc3lmN4ZV810CoDdVOEIXuWzwi7k9pvCxQa9iMc=;
 b=KekHDpzH6rLWcX8mZrDHFbnlTc8ucuynCNf+G9bBPI67EyrzdEjAXSTL1TmInkcFP5
 xDxGKvJHbtb3rZXB5lJcKgIuy0nHuEIwbfOq+7ma9q9S+70LGA9HYjiK48BSh6AM7fe0
 BI8GT1NVdyFLqFhTJP/fBTrIWeNRacKARC9Tz/AznpNd3tyNnP8UfjI/4Pgg8/ekI18I
 8UXmExMSa31KEPHKStRdLvJzN2sY/utSujvPSq7HhvkFFbXGsDzBdANXtZ1hSFrIIGBg
 mX4xqD8/zV7WMkbnHQOSFSXRnH4SjP0cYb4UzC8UpcnncB13JXNPEK6QPwWIbYp+T/v9
 3MRw==
X-Gm-Message-State: AOJu0YzI5/ErXiWQAR3CeqnXNVVw6olfx9wjBksCMd7V1wM3EZ2RrOeS
 Hp6atatCwt0o6bZwLot2BWCYGCiVMuovoOWSoMggQSl2YucJ2HrjX9nj
X-Gm-Gg: AeBDiev+ZrrafZtlPWsaX8sZagpR8g6MOwecqlqftHxk3bwWADaFaFJfe/b+nZfxzO0
 wTOgF1Pr3bo5e4gIifwfcJNJiSFrjIm9MIleTF03IMeb7mDOl4ii1VRHAL0vYOt5FpFJf2mCGyK
 FaWCosuWjmC8E4ZZQx/fHTl7oh8oYB+1ewqUHGbrjHC2MqatIwcRbgh67Hc8VFcxx83U/ABQD9V
 ttGv0MWF5CWlb/UYzRflimo6UcTJD4zlsL/tCQlBdzUrAydhPgxxVURzofvNUYiqUVgitQkSOVZ
 FT5j5bvW1eZ8gVcEr+BiDQ/muq9PCtT8tYpGlUfvuEVSQK8N6tYtKjmUSD44EF1payzEUI8tyHm
 0hEER+ihQpDRRFI6fj/XCGZJk7pU6trK6GxqCGHlLffgTY2vFHY976MzRjmGYHC+SCN39jMR7b6
 gIkPP+6lbYiWRoV545vCxdEjcQWWy+je4PmzVEH2Iu4IiHE6cAeBs+e16st5T1E51USXl7fPSx/
 bd5YWHtBDI=
X-Received: by 2002:a05:7300:dc92:b0:2c0:f84b:2455 with SMTP id
 5a478bee46e88-2cbfb4a7fd6mr5612136eec.19.1775431253398; 
 Sun, 05 Apr 2026 16:20:53 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:fc81:54a4:64f6:40f2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c3010e9sm15366187eec.14.2026.04.05.16.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:20:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 16:20:51 -0700
Message-Id: <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
Cc: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <pbonzini@redhat.com>, <rbolshakov@ddn.com>, <phil@philjordan.eu>,
 <mst@redhat.com>, <john.levon@nutanix.com>, <thanos.makatos@nutanix.com>,
 <qemu-s390x@nongnu.org>
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, "Scott J. Goldman"
 <scottjgo@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
In-Reply-To: <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>
>
>> On 5. Apr 2026, at 10:01, Mohamed Mediouni <mohamed@unpredictable.fr> wr=
ote:
>>=20
>>>=20
>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>>=20
>>> This series adds VFIO PCI device passthrough support for Apple Silicon
>>> Macs running macOS, using a DriverKit extension (dext) as the host
>>> backend instead of the Linux VFIO kernel driver.
>>>=20
>>> I'm sending this as an RFC because I'd like feedback before investing
>>> further in upstreaming.  The code is functional.  I've tested it with
>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>>> gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
>>> [1]), likely due to the BAR access penalty described below.  AI
>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>> generates around 140 tok/sec on the same setup [2].
>>>=20
>>> How it works:
>>>=20
>>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>>> for device access and DMA mapping.  On macOS, there is no equivalent
>>> kernel interface.  Instead, a userspace DriverKit extension
>>> (VFIOUserPCIDriver) mediates access to the physical PCI device through
>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>=20
>>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>>> passthrough infrastructure.  A few ioctl callsites are refactored into
>>> io_ops callbacks, the build system is extended for Darwin, and the
>>> Apple-specific backend plugs in behind those abstractions.
>>>=20
>>> The guest sees two PCI devices: the passthrough device itself
>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>> library wraps the IOUserClient calls to the dext for config space,
>>> BAR MMIO, interrupts, reset, and DMA.
>>>=20
>>> DMA limitations:
>>>=20
>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>> mapping operation where the caller specifies the IOVA, the
>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>> system-assigned IOVA.  There is no way to request a specific address.
>>> This means the guest's requested DMA addresses cannot be used
>>> directly.  The guest kernel module must intercept DMA mapping calls
>>> and forward them through the companion device to get the actual
>>> hardware IOVA.
>>=20
>> Hello,
>>=20
>> Ugh this one is not great. By the way, Apple has a private PCIe passthro=
ugh
>> API used by Virtualization.framework but that=E2=80=99s a different desi=
gn.

This is really interesting and I had not heard about this. Are you
able to elaborate on this one at all? Maybe this is something where an
internal API to manipulate the DART is available inside
Virtualization.framework?

>> Would bounce buffering using something akin the confidential compute pat=
h and=20
>> a pre-defined chunk of host memory accessible from the device, and then =
managing
>> the guest address map work? (see swiotlb).

I tested this approach early on, but ran into a couple issues:

1. Not only does PrepareForDMA() limit the total size of the pool, but
   it also limits the size of individual allocations. IIRC it not very
   large at around 16MB. Thankfully, I found that the allocator seemed
   to just keep allocating continguously across multiple allocations, so
   maybe that's fine?
2. Linux swiotlb default configuration is too small for GPU drivers. The
   max single mapping is 256KB and the total pool size is 64MB. The
   overall pool size is configurable but the max single mapping is
   derived from IO_TLB_SEGSIZE and IO_TLB_SIZE which are compile-time
   constants. During games, I have seen roughly ~900MB of active DMA
   mappings and mappings much larger than 256kb.

I abandoned this approach because it seemed like the CPU penalty of
bouncing all the DMA buffers would be pretty severe and the swiotlb
allocator just didn't seem designed for this much memory pressure. I
also was hoping to avoid the requirement of recompiling the entire guest
kernel as a prerequisite for guests to use this passthrough feature. On
top of that, I wasn't sure if upstream would even be willing to take
changes to support this use case, since it's so far outside what the
existing swiotlb allocator would normally be doing.

That said, you were saying that CoCo is fine with this restriction? Do
other devices just not have drivers that are doing so much allocation? I
didn't actually try changing the constants and recompiling the guest
kernel in swiotlb to make the pool big enough for it to really work at
all with the nvidia guest driver, I will have to see what happens.

>
> see restricted-dma-pool
>
> I think in this specific case that ACPI support isn=E2=80=99t worth it an=
d that FDT
> will be good enough.

Yes, this seems fine to me as well if we went the swiotlb route. It
could be a different `-machine` type or perhaps a machine-specific param
if we went this route, maybe.

>
> The limitation that I can see there if if you can=E2=80=99t match IOVA an=
d GPA for that
> restricted DMA pool, then you=E2=80=99ll need a small (and hopefully easy=
 to merge) kernel
> change.
>> If the last part isn=E2=80=99t possible, something minimal to export an =
swiotlb window
>> through device tree with giving the IOVA there would be good too.
>>=20
>> And that will get rid of a need for a apple-dma-pci device.

I am not 100% sure since I didn't try this exactly, but it seems like
you could have the DriverKit side allocate a big DMA buffer before the
guest starts, and then identity map the region somewhere inside the
guest with the `restricted-dma-pool` attribute attached to it. The
caveat being that you might have to pray that the region is contiguous
or introduce a much more complicated swiotlb subsystem allocator.

WRT a kernel patch to make it easier, can you elaborate on what you werelt =
thinking there?

>>> There are also hard platform limits: approximately 1.5 GB total
>>> mapped memory and roughly 64k concurrent mappings.  Not all
>>> workloads will fit within these limits, though GPU gaming and LLM
>>> inference have worked in practice.
>>=20
>> That=E2=80=99s not too dissimilar from the confidential compute limitati=
ons.
>>=20
>>>=20
>>> BAR access has performance issues as well.  HVF does not expose
>>> controls to map device memory as cacheable in the guest, creating a
>>> significant performance penalty on BAR MMIO.  Uncached mappings work
>>> correctly but slowly compared to what the hardware could do.
>>=20
>> That=E2=80=99s not a macOS limitation and not an Apple hardware limitati=
on, but
>> it=E2=80=99s more fundamental to how PCIe works.
>>=20
>> Unlike CXL, PCIe doesn=E2=80=99t have a coherency protocol story, and th=
e alternative
>> of uncached and doing manual software-managed flushes isn=E2=80=99t real=
ly tenable.

Apologies, I misspoke. It's not cacheability that's the issue. I think
it's write-combining. Specifically the question is how the HVF sets the=20
attributes in the stage-2 page tables. The behavior is observable by
looking at the performance of sweeping writes across the BARs.

As part of the work to implement and test this change I wrote such a
benchmark as a client of the dext in the host, and a Linux kernel module
that runs in the guest. It takes BAR1 (VRAM aperture) and does a write
sweep of 8MB with 4 passes and measures the results.

Host (mapped with kIOWriteCombineCache): 386mb/sec
Host (mapped with kIInhibitCache): 46mb/sec

Guest (mapped with ioremap_wc) 31mb/s
Guest (mapped with ioremap): 31mb/s

In the case of BAR1, it is marked prefetchable so I believe you would
usually want to map it with write-combining. I'm not sure why the case
without write-combining is worse in the guest, but it's the same order
of magnitude. I think the real interesting thing there is that the
write-combining map in the guest performs identically to the one=20
without. To me, that indicates that perhaps the stage-2 bits are not set
properly. Even though the host has mapped the memory with
kIOWriteCombineCache, this wasn't propogated when HVF maps this into the
guest, which probably falls back to the lesser of the stage-1 vs stage-2
mappings (i.e. disabling write-combining).=20


>>=20
>>>=20
>>> What works:
>>> - PCI config space passthrough
>>> - BAR MMIO via direct-mapped device memory
>>> - MSI/MSI-X interrupts via async notification from the dext
>>> - Device reset (FLR with hot-reset fallback)
>>> - DMA mapping for guest device drivers
>>>=20
>> This is very interesting to see :)

Thanks! It's always nice to catch some interest/advice for a strange
project like this.

>>=20
>>> What doesn't work:
>>> - Expansion ROM / VBIOS passthrough
>>> - PCI BAR quirks
>>> - VGA region passthrough
>>> - Migration and dirty page tracking
>>> - Hot-unplug
>>>=20
>>
>>=20
>>=20
>>> Questions for reviewers:
>>>=20
>>> 1. Is this something the VFIO maintainers would consider carrying
>>>  upstream?  The refactoring patches (3-6) are benign, but the Apple
>>>  backend is a new platform with real limitations.  That said, if Apple
>>>  lifts some of the DART/HVF restrictions in a future macOS release, the
>>>  code changes to take advantage would likely be minor.  I'd like to
>>>  understand whether this is in scope before doing the work to
>>>  address review feedback on the full series.
>>>=20
>>> 2. The apple-dma-pci companion device: should this be a virtio device
>>>  instead?  I went with a simple custom PCI device because the virtio
>>>  infrastructure didn't buy much for what is essentially a {map, unmap}
>>>  register interface, but if virtio is preferred, what is the process
>>>  for allocating a device ID?  If a custom PCI device is the right
>>>  approach, I've tentatively allocated 1b36:0015.  Is there a process
>>>  for reserving a device ID under the Red Hat PCI vendor, or is
>>>  claiming it in pci-ids.rst sufficient?  The guest-side kernel module
>>>  hooks all DMA mapping functions for passed-through devices, which is
>>>  unusual enough that I'm not sure it's upstreamable in the Linux
>>>  kernel.  I can maintain it out of tree if needed.
>>=20
>> I=E2=80=99d recommend using bounce buffers like the CoCo case if possibl=
e. I don=E2=80=99t
>> think that the apple-dma-pci definitely-not-an-IOMMU is a good idea.

To be clear, it definitely is weird and bad, but it was seemingly the
least bad option that I was able to get working with minimal guest
changes (just one guest kmod).

>>=20
>>>=20
>>> 3. Should the macOS host-side DriverKit extension live in the QEMU
>>>  tree?  It's not included in this series and requires Apple code
>>>  signing.  I'm happy to keep it out of tree if that's preferred,
>>>  or include the source if reviewers want it co-located.
>>=20
>> Both are fine I think. Could you share compatibility with the tinygrad
>> one at https://github.com/tinygrad/tinygrad/tree/7e54992bf600789dbe5d37b=
99fe12a19c32e36a1/extra/usbgpu/tbgpu/installer and prebuilt at https://raw.=
githubusercontent.com/tinygrad/tinygpu_releases/refs/heads/main/TinyGPU.zip=
?

This is a good question and not something I had considered. My module
probably works a little different than their module. It's possible I'm
wrong but my understanding was:

1. They got apple entitlements for AMD/NVIDIA driver vendor ids only.
   That said, if it became compatible with QEMU, I suppose it would be
   an easy case to make that it could be expanded to wildcard (another
   developer indicated to me that Apple was willing to grant the
   wildcard entitlement if the use case was justifiable)
2. The architecture of their driver is a little different. I believe
   they are allocating DMA-able memory in the driver and mapping it down
   to userland, so it's kind of the reverse of what I'm doing now. I
   guess, conceivably they could change how they are doing this to unify
   our efforts.

Thanks,
-sjg

