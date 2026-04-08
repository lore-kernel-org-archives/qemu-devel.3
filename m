Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1AD10FC441
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAZmN-0005P0-Fy; Wed, 08 Apr 2026 16:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAZmK-0005OA-1x
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:45:36 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAZmH-0007eW-QP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:45:35 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2ce102afb0aso13779eec.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775681132; x=1776285932; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XjWYk28MaeCJW42BsIeqyY/lWCGT4Q7ga1TuSXvwjQ=;
 b=Ueg6obl6oQbC02M++GA6yIOXxhDS5447C61zu1pshZ1T42wdA71hV3GiI767gfHDPw
 UvX1m4H4tYlgXDF78bnJQvzMWwbZPk6w2wI5ze6v9cmMhu3N0/wL5GdCEiyI9gOlN2nc
 PDFj5kROj9WgyYktcHqB7u8xJ4Ar6d3rAA1RtchpyGSA6qzDjqpe9QmYqr/b6Wer1z5i
 yJBBRQUO3Luh/mvqK8BRVtDXJWDGmt9a8jUIAdA5Ez8t+wrySIoEJqGrZOe8Q1eQaVyM
 TIGShcIA9QOiiC3DQEwLob6qtPviEu57lNH0DTW9DL2+IpTqo29XrXnZ54i7uBd3jTVu
 G0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775681132; x=1776285932;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XjWYk28MaeCJW42BsIeqyY/lWCGT4Q7ga1TuSXvwjQ=;
 b=WW2Gk3KV6SAfy/+QIEvqRD4XmU7kbZXyyZkP9P6K45pnvbAV2GMp0FhXrZwfhtyqPn
 pnlVIa4pewZ6LXBS4bBhyA1863A3JJ2dRHlHuDGGKbokHMIH6Rop4n5kiSWjb096JYzQ
 Rj1Q3wuxQVJEa+oFsp6Ri9Vpq9lRRbynlrw0g2eKUBucvvs6vI7vOpGYHGD2dZOG9pk7
 8UfXfSqLes3nCnGpcCEbszv8XyK6H/HTXxXIG+GZcGInbJmo3BY/Qe0NviAXbq3NI8IH
 2KZ/hUZ8Hr/DqHoMmEtszCSxBx5cdLJ/o5RW1XMI0AQ+NtkxKs5TDGUJzaR+rGHEzTCK
 UFWw==
X-Gm-Message-State: AOJu0Yw+YB2rm4F8Q4zOlShSHeBgWmMh4xNaa9y6kM+Amew3oy6R80Xp
 8SQMXgyXFoabKfixNS3uuAz1DEq8gOGPbuqOvHEqfPEmW2zoJ5SKV/c+
X-Gm-Gg: AeBDieupFqd0+Ehx56tx+n/U435mAeh4ROUL2OM8mZ39C6IbI+VUEN6vVFl9FiGfgOr
 lGT0oqKmHucbTPg0ZqzMtHlEl4AFPTIywXaLbggd96sM10BMUbCiAhhlFjNNtpBp5947/8ft5If
 /ROmT4vPBQ5D3Yy7g/2EFEcFTChph/I9cx1sNBj9MmWxKfqjo8a3F/O/H5aSBVh9yPqxDoa03Gk
 WDVydyKnH89+E5IymgupjVfS9Hs21NJx8OBK+iJMd6d7mfigdaDR65TLmEi0feDalW14hZWZtZH
 IUmXcFSwhtc7duYrQDOlRvn1LLCXWU9JQiE9bfGkytMRl3UEA1aCgtyWIGtrjvHknE4dJZPizQS
 Gs9SEJR49u5EfwGAA7/MxEkayukZ02OczVIejghRTtHD6MbmwUkat4eGtnJD5BJ6qdWADJKFkUP
 +eP6xm4wetCFdT5xdZRAG8J1p5I28CPrbnMvD+lYT5WBO7/kucfnlDAr5BZJrBZ3WXck5pYARaV
 e393PAODS8=
X-Received: by 2002:a05:7301:6743:b0:2c5:50fe:c792 with SMTP id
 5a478bee46e88-2cbfa1d6fa5mr11650920eec.12.1775681131861; 
 Wed, 08 Apr 2026 13:45:31 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:a1bd:9754:418f:9b37])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d2d5409fd1sm4991608eec.13.2026.04.08.13.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 13:45:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 13:45:30 -0700
Message-Id: <DHO2FDRRIEGO.FEORPWSGCJE9@gmail.com>
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
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
 <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
 <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
 <97D215C3-5794-4250-BA33-F07C6A753477@unpredictable.fr>
In-Reply-To: <97D215C3-5794-4250-BA33-F07C6A753477@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1334.google.com
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

On Wed Apr 8, 2026 at 12:09 PM PDT, Mohamed Mediouni wrote:
>
>
>> On 8. Apr 2026, at 09:02, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> On Sun Apr 5, 2026 at 5:16 PM PDT, Mohamed Mediouni wrote:
>>>=20
>>>=20
>>>> On 6. Apr 2026, at 01:20, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>>>=20
>>>> On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>>>>>=20
>>>>>=20
>>>>>> On 5. Apr 2026, at 10:01, Mohamed Mediouni <mohamed@unpredictable.fr=
> wrote:
>>>>>>=20
>>>>>>>=20
>>>>>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> wro=
te:
>>>>>>>=20
>>>>>>> This series adds VFIO PCI device passthrough support for Apple Sili=
con
>>>>>>> Macs running macOS, using a DriverKit extension (dext) as the host
>>>>>>> backend instead of the Linux VFIO kernel driver.
>>>>>>>=20
>>>>>>> I'm sending this as an RFC because I'd like feedback before investi=
ng
>>>>>>> further in upstreaming.  The code is functional.  I've tested it wi=
th
>>>>>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>>>>>>> gaming works but is slow (~30 fps on high settings in Cyberpunk 207=
7
>>>>>>> [1]), likely due to the BAR access penalty described below.  AI
>>>>>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>>>>>> generates around 140 tok/sec on the same setup [2].
>>>>>>>=20
>>>>>>> How it works:
>>>>>>>=20
>>>>>>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>>>>>>> for device access and DMA mapping.  On macOS, there is no equivalen=
t
>>>>>>> kernel interface.  Instead, a userspace DriverKit extension
>>>>>>> (VFIOUserPCIDriver) mediates access to the physical PCI device thro=
ugh
>>>>>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>>>>>=20
>>>>>>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>>>>>>> passthrough infrastructure.  A few ioctl callsites are refactored i=
nto
>>>>>>> io_ops callbacks, the build system is extended for Darwin, and the
>>>>>>> Apple-specific backend plugs in behind those abstractions.
>>>>>>>=20
>>>>>>> The guest sees two PCI devices: the passthrough device itself
>>>>>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>>>>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>>>>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>>>>>> library wraps the IOUserClient calls to the dext for config space,
>>>>>>> BAR MMIO, interrupts, reset, and DMA.
>>>>>>>=20
>>>>>>> DMA limitations:
>>>>>>>=20
>>>>>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>>>>>> mapping operation where the caller specifies the IOVA, the
>>>>>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>>>>>> system-assigned IOVA.  There is no way to request a specific addres=
s.
>>>>>>> This means the guest's requested DMA addresses cannot be used
>>>>>>> directly.  The guest kernel module must intercept DMA mapping calls
>>>>>>> and forward them through the companion device to get the actual
>>>>>>> hardware IOVA.
>>>>>>=20
>>>>>> Hello,
>>>>>>=20
>>>>>> Ugh this one is not great. By the way, Apple has a private PCIe pass=
through
>>>>>> API used by Virtualization.framework but that's a different design.
>>>>=20
>>>> This is really interesting and I had not heard about this. Are you
>>>> able to elaborate on this one at all? Maybe this is something where an
>>>> internal API to manipulate the DART is available inside
>>>> Virtualization.framework?
>>>=20
>>> Hello,
>>>=20
>>> All of it needs using private entitlements currently.
>>>=20
>>> It's _VZPCIPassthroughDeviceConfiguration, a private class needing com.=
apple.private.virtualization to use.
>>>=20
>>> The VMM process itself then uses the com.apple.private.PCIPassthrough.a=
ccess entitlement. I'm not
>>> sure whether OS versions even have all the code currently though.
>>>=20
>>=20
>> Appreciate the pointers here. It looks like, as you said, the framework
>> taps into a bunch of code that isn't shipped to us mere mortals. I can
>> see from some of the code in Virtualization.framework the general shape
>> of what they're doing, though.
>>=20
>> It looks like they implement a virtio-iommu device that ultimately calls
>> into the host kernel with some internal APIs to do the DART mappings.=20
>>=20
>
> Hello,
>
> Some more details:
>
> The VMM side when using Virtualization.framework is at /System/Library/Fr=
ameworks/Virtualization.framework/XPCServices/com.apple.Virtualization.Virt=
ualMachine.xpc/Contents/MacOS/com.apple.Virtualization.VirtualMachine
> as Virtualization.framework
>
> And that directly communicates with IOPCIDevice...
>
> And the source code side of PCIDriverKit is at https://github.com/apple-o=
ss-distributions/IOPCIFamily/tree/main/PCIDriverKit=20
>
> And for PrepareForDMA at https://github.com/apple-oss-distributions/xnu/b=
lob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/Kernel/IOUserServer.cpp#=
L1001
>
> IOMemoryDescriptor has this option: https://github.com/apple-oss-distribu=
tions/xnu/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/DriverKit/IOM=
emoryDescriptor.iig#L56 - kIOMemoryMapFixedAddress
>
> But not sure whether that=E2=80=99s allowed for user-mode drivers
>
> Hopefully that helps.
>

Appreciate the pointers. It seems like the flag does work on DriverKit
user-level drivers. Unfortunately it controls the virtual address
placement in the process, not the IOVA for DMA. If you follow the path
through:

PrepareForDMA_Impl(options, memDesc, offset, length, ...)
 -> IODMACommand::prepare(offset, length)
   -> md->dmaCommandOperation(kIOMDDMAMap, &mapArgs)
     -> IOGeneralMemoryDescriptor::dmaMap(mapper, ..., &mapArgs.fAlloc)

You can see that the code doesn't pass these flags through to the
ultimate call to iovmMapMemory. The base class path is at:

https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3752=
11650a4c1ff8ca1ea/iokit/Kernel/IOMemoryDescriptor.cpp#L4581-L4587C54

and the IOGeneralMemoryDescriptor override (which is the path taken for cli=
ent memory) has the same gap:

https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3752=
11650a4c1ff8ca1ea/iokit/Kernel/IOMemoryDescriptor.cpp#L4671-L4742

where the mapOptions are also set in IODMACommand::prepare():

https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3752=
11650a4c1ff8ca1ea/iokit/Kernel/IODMACommand.cpp#L985C1-L996C1

I think the flag that would have to be in the path would be
kIODMAMapFixedAddress.

Thanks,
-sjg

