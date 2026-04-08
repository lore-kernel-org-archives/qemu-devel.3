Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D53B10FC45F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcOi-0004vu-7Y; Wed, 08 Apr 2026 19:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAcOh-0004vP-7x
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:33:23 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAcOd-0000vQ-N9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:33:21 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12c15414820so96061c88.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775691198; x=1776295998; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sp1l2TLSy59KuOnmhMceKZg7VGUfjBL3v4kCUvYEWOg=;
 b=T9dfMCBPMCgxGmDSK0NQLe3hgUpFqbffsXmMtvN3rkSCHp+chhSd05kVp64jKZ7rZf
 kDg96NfXQ+f9Je47C4NXXb30jvZ0czZZVTvVJCHsa05SZQwZLJOZDET8NXLsJmn2mB2l
 coMelWqko+tJDC2Tvynbkg+uCTv5NSOLCS6maHANBxwu7VltrxwbNxNK1OcNNdRIM7tk
 6n4UgJbNcizdyFdsBHhaHDARMdIH6rk0nc+fFmhUsx4kIJJ9t7bGoV4pyJpNXyYNS92/
 6TBSnBVElZzBaRdCTJAM0kS1YFsqHC3cLI1XGCxeC+xLy3wu96kqxgtHv6X1CttYcQJE
 lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775691198; x=1776295998;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sp1l2TLSy59KuOnmhMceKZg7VGUfjBL3v4kCUvYEWOg=;
 b=R6hP9eghik8s6XgDgeLBxJ6kwAYSJw4OixRQMVp5FGjpgT7Xd3i3d+ibCvlwNxNMbz
 5hkUAVwHMip5klbwzacI8NBjWCyBEGZCYlqrfpmbXzlpKxk8a3/kmE36iDgl8GsAAtsm
 qR6VeLUjIOIOA0SC3w1Hgy+rV9DLFzpTmyBL7g1NXKLbQicYv+PKNShyL9RylIrDhHWd
 gg8cUlnFuQ6GOWRuaX2keJEpO0/HGal4TEZ47q+91GwIKkk2NE2KX5RrAV0IW6949a5n
 /WJY5Me0C91GDOL8+X8m6I+Xf0Q6903BmuX6lzyf7DjLlBlz7O2lw1obUFpm5864bdud
 4iDA==
X-Gm-Message-State: AOJu0YyQ7Rkc+zLXXh8LmtAUwPk0YVEuoo9BEj8HpVUlF7qtuGcedjIQ
 Vr2KD28XsvRpirNFo+UKk8Ns0yluhRJR/6uFsOoMnPpXOsKtRHPYW/5d
X-Gm-Gg: AeBDievepCvW5TtYkapFLXoYZXtltnuB3KTvgbDfCH9lbNZIVdWQT7cxHo5aUQgmsM5
 gjBsak8tcv5hGIffuu09LDIzIPhYbUWLCEGxSbxQUoRiwQ3ZYpJAMbEDuCcMjEJ9SjIbtoXUWFI
 Zu3qcQ9sveWyqdJTRSCt4XG6ZgQeGpJRfyORVecVgKA/067EDcq3rXpbxHrHQ2QmV20g2060SnA
 zcxda7UjypQb6GiTTr7LyzbC+8MAt4CptNrlfiCfzj2oFkw440n5NEaLSec6012r4mPRScA3HBa
 TA9J3fm1VUaTFuu4VbUQPhTzeiMQNDVlcTAKdu6Tz49dydYR4UuL7sFPj6AHssyO7It+KFTQ06N
 G/zuqzZx/cdQ6TnydMNYZNkLAMbggttLteVy0QLLoXEIo6jaFPLcCZWLXiicBQvkoItIAWu/dub
 ZVqHQi4GyD4oY4/QccR/85/oQTH3hJW+zUQBBwlg17djW7oS8pmOve03ZWxwP/UItRbc76OXza0
 s+jGzh9EKk=
X-Received: by 2002:a05:7022:4182:b0:119:e569:f84d with SMTP id
 a92af1059eb24-12c28bf351bmr604986c88.4.1775691197782; 
 Wed, 08 Apr 2026 16:33:17 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:a1bd:9754:418f:9b37])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c07a8703esm17623995c88.8.2026.04.08.16.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 16:33:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 16:33:15 -0700
Message-Id: <DHO5ZTWY64G0.1AIDXSKEL01UU@gmail.com>
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
 <DHO2FDRRIEGO.FEORPWSGCJE9@gmail.com>
 <7929BC15-D10B-4CF7-875C-0A168811CA72@unpredictable.fr>
In-Reply-To: <7929BC15-D10B-4CF7-875C-0A168811CA72@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=scottjgo@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Apr 8, 2026 at 3:12 PM PDT, Mohamed Mediouni wrote:
>
>
>> On 8. Apr 2026, at 22:45, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> On Wed Apr 8, 2026 at 12:09 PM PDT, Mohamed Mediouni wrote:
>>>=20
>>>=20
>>>> On 8. Apr 2026, at 09:02, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>>>=20
>>>> On Sun Apr 5, 2026 at 5:16 PM PDT, Mohamed Mediouni wrote:
>>>>>=20
>>>>>=20
>>>>>> On 6. Apr 2026, at 01:20, Scott J. Goldman <scottjgo@gmail.com> wrot=
e:
>>>>>>=20
>>>>>> On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On 5. Apr 2026, at 10:01, Mohamed Mediouni <mohamed@unpredictable.=
fr> wrote:
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> w=
rote:
>>>>>>>>>=20
>>>>>>>>> This series adds VFIO PCI device passthrough support for Apple Si=
licon
>>>>>>>>> Macs running macOS, using a DriverKit extension (dext) as the hos=
t
>>>>>>>>> backend instead of the Linux VFIO kernel driver.
>>>>>>>>>=20
>>>>>>>>> I'm sending this as an RFC because I'd like feedback before inves=
ting
>>>>>>>>> further in upstreaming.  The code is functional.  I've tested it =
with
>>>>>>>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  G=
PU
>>>>>>>>> gaming works but is slow (~30 fps on high settings in Cyberpunk 2=
077
>>>>>>>>> [1]), likely due to the BAR access penalty described below.  AI
>>>>>>>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>>>>>>>> generates around 140 tok/sec on the same setup [2].
>>>>>>>>>=20
>>>>>>>>> How it works:
>>>>>>>>>=20
>>>>>>>>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfi=
o
>>>>>>>>> for device access and DMA mapping.  On macOS, there is no equival=
ent
>>>>>>>>> kernel interface.  Instead, a userspace DriverKit extension
>>>>>>>>> (VFIOUserPCIDriver) mediates access to the physical PCI device th=
rough
>>>>>>>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>>>>>>>=20
>>>>>>>>> The series keeps the existing VFIOPCIDevice model and reuses QEMU=
's
>>>>>>>>> passthrough infrastructure.  A few ioctl callsites are refactored=
 into
>>>>>>>>> io_ops callbacks, the build system is extended for Darwin, and th=
e
>>>>>>>>> Apple-specific backend plugs in behind those abstractions.
>>>>>>>>>=20
>>>>>>>>> The guest sees two PCI devices: the passthrough device itself
>>>>>>>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>>>>>>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>>>>>>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>>>>>>>> library wraps the IOUserClient calls to the dext for config space=
,
>>>>>>>>> BAR MMIO, interrupts, reset, and DMA.
>>>>>>>>>=20
>>>>>>>>> DMA limitations:
>>>>>>>>>=20
>>>>>>>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>>>>>>>> mapping operation where the caller specifies the IOVA, the
>>>>>>>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>>>>>>>> system-assigned IOVA.  There is no way to request a specific addr=
ess.
>>>>>>>>> This means the guest's requested DMA addresses cannot be used
>>>>>>>>> directly.  The guest kernel module must intercept DMA mapping cal=
ls
>>>>>>>>> and forward them through the companion device to get the actual
>>>>>>>>> hardware IOVA.
>>>>>>>>=20
>>>>>>>> Hello,
>>>>>>>>=20
>>>>>>>> Ugh this one is not great. By the way, Apple has a private PCIe pa=
ssthrough
>>>>>>>> API used by Virtualization.framework but that's a different design=
.
>>>>>>=20
>>>>>> This is really interesting and I had not heard about this. Are you
>>>>>> able to elaborate on this one at all? Maybe this is something where =
an
>>>>>> internal API to manipulate the DART is available inside
>>>>>> Virtualization.framework?
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> All of it needs using private entitlements currently.
>>>>>=20
>>>>> It's _VZPCIPassthroughDeviceConfiguration, a private class needing co=
m.apple.private.virtualization to use.
>>>>>=20
>>>>> The VMM process itself then uses the com.apple.private.PCIPassthrough=
.access entitlement. I'm not
>>>>> sure whether OS versions even have all the code currently though.
>>>>>=20
>>>>=20
>>>> Appreciate the pointers here. It looks like, as you said, the framewor=
k
>>>> taps into a bunch of code that isn't shipped to us mere mortals. I can
>>>> see from some of the code in Virtualization.framework the general shap=
e
>>>> of what they're doing, though.
>>>>=20
>>>> It looks like they implement a virtio-iommu device that ultimately cal=
ls
>>>> into the host kernel with some internal APIs to do the DART mappings.=
=20
>>>>=20
>>>=20
>>> Hello,
>>>=20
>>> Some more details:
>>>=20
>>> The VMM side when using Virtualization.framework is at /System/Library/=
Frameworks/Virtualization.framework/XPCServices/com.apple.Virtualization.Vi=
rtualMachine.xpc/Contents/MacOS/com.apple.Virtualization.VirtualMachine
>>> as Virtualization.framework
>>>=20
>>> And that directly communicates with IOPCIDevice...
>>>=20
>>> And the source code side of PCIDriverKit is at https://github.com/apple=
-oss-distributions/IOPCIFamily/tree/main/PCIDriverKit=20
>>>=20
>>> And for PrepareForDMA at https://github.com/apple-oss-distributions/xnu=
/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/Kernel/IOUserServer.cp=
p#L1001
>>>=20
>>> IOMemoryDescriptor has this option: https://github.com/apple-oss-distri=
butions/xnu/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/DriverKit/I=
OMemoryDescriptor.iig#L56 - kIOMemoryMapFixedAddress
>>>=20
>>> But not sure whether that=E2=80=99s allowed for user-mode drivers
>>>=20
>>> Hopefully that helps.
>>>=20
>>=20
>> Appreciate the pointers. It seems like the flag does work on DriverKit
>> user-level drivers. Unfortunately it controls the virtual address
>> placement in the process, not the IOVA for DMA. If you follow the path
>> through:
>>=20
> That=E2=80=99s indeed the case=E2=80=A6=20
>> PrepareForDMA_Impl(options, memDesc, offset, length, ...)
>> -> IODMACommand::prepare(offset, length)
>>   -> md->dmaCommandOperation(kIOMDDMAMap, &mapArgs)
>>     -> IOGeneralMemoryDescriptor::dmaMap(mapper, ..., &mapArgs.fAlloc)
>>=20
>> You can see that the code doesn't pass these flags through to the
>> ultimate call to iovmMapMemory. The base class path is at:
>>=20
>> https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3=
75211650a4c1ff8ca1ea/iokit/Kernel/IOMemoryDescriptor.cpp#L4581-L4587C54
>>=20
>> and the IOGeneralMemoryDescriptor override (which is the path taken for =
client memory) has the same gap:
>>=20
>> https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3=
75211650a4c1ff8ca1ea/iokit/Kernel/IOMemoryDescriptor.cpp#L4671-L4742
>>=20
>> where the mapOptions are also set in IODMACommand::prepare():
>>=20
>> https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d3=
75211650a4c1ff8ca1ea/iokit/Kernel/IODMACommand.cpp#L985C1-L996C1
>>=20
>> I think the flag that would have to be in the path would be
>> kIODMAMapFixedAddress.
>
> Intriguingly, mapOptions is defined at https://github.com/apple-oss-distr=
ibutions/xnu/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/Kernel/IOD=
MACommand.cpp#L943C39-L943C49 and set there in https://github.com/apple-oss=
-distributions/xnu/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/iokit/Kern=
el/IODMACommand.cpp#L985C1-L996C1 but then not used afterwards=E2=80=A6
>
> And the flags passed are:
> https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d37=
5211650a4c1ff8ca1ea/iokit/Kernel/IOUserServer.cpp#L979
> so it=E2=80=99s not in IODMACommandSpecification either.
>
> Makes me wonder even more what Apple does for their own VM thing, or mayb=
e
> the simplest answer is that they=E2=80=99re not using something public - =
especially
> as they=E2=80=99re doing this from user-mode using the IOPCIDevice interf=
ace=E2=80=A6
> Or=E2=80=A6 the Apple code in Virtualization.framework is unfinished and =
I=E2=80=99m just thinking too hard about this

My possibly incorrect read of the strings and some disassembly of
Virtulization.framework is that they look for
IOServiceMatching("PCIPassthrough") which is simply not exported by
anything I can find on my Mac. For internal builds maybe they ship
another kext for this?

