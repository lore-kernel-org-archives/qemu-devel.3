Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A401410F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKD-0002cP-Kb; Wed, 08 Apr 2026 15:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAYI7-0006k8-Db
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:10:19 -0400
Received: from qs-2003i-snip4-8.eps.apple.com ([57.103.86.91]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAYI5-0006vT-5b
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:10:19 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 4F75530000D7; Wed, 08 Apr 2026 19:10:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775675409; x=1778267409;
 bh=882I656oweRL1P/nTC0ieYi0uexNEGQETQYAb9hoDpg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fjRMqXbWpeLFlqEaRan0GwCkHjP3CvI1fWiAJ78SRQLNngpbFI51m3kxfcUPJFBRKCB+zY2xv4IphhSS9zgfuJDXGLH19VPu1VK+a75c8efMibnpgiIkV68ubSXjyx7gE2Sa36WzYzwmBMZhEdMu9cvwNvSTbEBkm1bkpgzuLcXf+jOcZwJaBz0JRHjeEKgIAsb1foiTDqu9rBZ/NU3EOPfvnj1HroQU/yjcdLsVV8A8byD4mi5Fz6mYCkVAPo00sm0JMBeweXYWrHJksws6O8o1iuOnGd31YPf9mKQOUrl+Awa4I0PvtIGvKOL0xZsjJGOb7asKycV7K+MpWIW11A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 E16853000104; Wed, 08 Apr 2026 19:10:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
Date: Wed, 8 Apr 2026 21:09:50 +0200
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu,
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <97D215C3-5794-4250-BA33-F07C6A753477@unpredictable.fr>
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
 <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
 <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE3OSBTYWx0ZWRfX/Nsc/VPYlYL+
 KXUHK4UouSD0byKmEgge9zESi5Q+WzWBRNKRklB83FLdGVmc3dayIoAbdq7GrWKZAxFPg8l4mYF
 czdCF0ijGCmA6YUWgK4qjSntCqCBKkYv/9r/f9/MIdmH3ElJk9aeFMIcDpdIdKQMODwbNjpqCPB
 GmZui1wqfqqLcUqhjfcSVgzuIn1cq23tV6hnplwcfbfDrxFdFkl2nfSuV92KEzoKDcTqmLmu1xN
 hznz4L57Aj/SefVUQGVMN0kL6b3/L2asy78ojAngW8EKkJULEg/GrKhTynRhNRI0qoYJESGLVqu
 VmS0uXUW4xU0ecsKFC7D/iCwbMAcM0D77dY1BIS6SRp8N2ps9bv0O3qvG/dUYI=
X-Authority-Info-Out: v=2.4 cv=CZ8FJbrl c=1 sm=1 tr=0 ts=69d6a80e
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=R6tJIW19AAAA:20 a=pGLkceISAAAA:8
 a=Tkn4bSnAX37LcA8Kl5AA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: OcIrSYYZ1d36w04Qk0R-YdslOgciV4Hm
X-Proofpoint-GUID: OcIrSYYZ1d36w04Qk0R-YdslOgciV4Hm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1030
 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604080179
Received-SPF: pass client-ip=57.103.86.91;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 8. Apr 2026, at 09:02, Scott J. Goldman <scottjgo@gmail.com> wrote:
>=20
> On Sun Apr 5, 2026 at 5:16 PM PDT, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 6. Apr 2026, at 01:20, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>>>=20
>>> On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>>>>=20
>>>>=20
>>>>> On 5. Apr 2026, at 10:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>>=20
>>>>>>=20
>>>>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>>>>>>=20
>>>>>> This series adds VFIO PCI device passthrough support for Apple =
Silicon
>>>>>> Macs running macOS, using a DriverKit extension (dext) as the =
host
>>>>>> backend instead of the Linux VFIO kernel driver.
>>>>>>=20
>>>>>> I'm sending this as an RFC because I'd like feedback before =
investing
>>>>>> further in upstreaming.  The code is functional.  I've tested it =
with
>>>>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  =
GPU
>>>>>> gaming works but is slow (~30 fps on high settings in Cyberpunk =
2077
>>>>>> [1]), likely due to the BAR access penalty described below.  AI
>>>>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>>>>> generates around 140 tok/sec on the same setup [2].
>>>>>>=20
>>>>>> How it works:
>>>>>>=20
>>>>>> On Linux, VFIO relies on kernel-managed IOMMU groups and =
/dev/vfio
>>>>>> for device access and DMA mapping.  On macOS, there is no =
equivalent
>>>>>> kernel interface.  Instead, a userspace DriverKit extension
>>>>>> (VFIOUserPCIDriver) mediates access to the physical PCI device =
through
>>>>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>>>>=20
>>>>>> The series keeps the existing VFIOPCIDevice model and reuses =
QEMU's
>>>>>> passthrough infrastructure.  A few ioctl callsites are refactored =
into
>>>>>> io_ops callbacks, the build system is extended for Darwin, and =
the
>>>>>> Apple-specific backend plugs in behind those abstractions.
>>>>>>=20
>>>>>> The guest sees two PCI devices: the passthrough device itself
>>>>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>>>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>>>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>>>>> library wraps the IOUserClient calls to the dext for config =
space,
>>>>>> BAR MMIO, interrupts, reset, and DMA.
>>>>>>=20
>>>>>> DMA limitations:
>>>>>>=20
>>>>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>>>>> mapping operation where the caller specifies the IOVA, the
>>>>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>>>>> system-assigned IOVA.  There is no way to request a specific =
address.
>>>>>> This means the guest's requested DMA addresses cannot be used
>>>>>> directly.  The guest kernel module must intercept DMA mapping =
calls
>>>>>> and forward them through the companion device to get the actual
>>>>>> hardware IOVA.
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> Ugh this one is not great. By the way, Apple has a private PCIe =
passthrough
>>>>> API used by Virtualization.framework but that's a different =
design.
>>>=20
>>> This is really interesting and I had not heard about this. Are you
>>> able to elaborate on this one at all? Maybe this is something where =
an
>>> internal API to manipulate the DART is available inside
>>> Virtualization.framework?
>>=20
>> Hello,
>>=20
>> All of it needs using private entitlements currently.
>>=20
>> It's _VZPCIPassthroughDeviceConfiguration, a private class needing =
com.apple.private.virtualization to use.
>>=20
>> The VMM process itself then uses the =
com.apple.private.PCIPassthrough.access entitlement. I'm not
>> sure whether OS versions even have all the code currently though.
>>=20
>=20
> Appreciate the pointers here. It looks like, as you said, the =
framework
> taps into a bunch of code that isn't shipped to us mere mortals. I can
> see from some of the code in Virtualization.framework the general =
shape
> of what they're doing, though.
>=20
> It looks like they implement a virtio-iommu device that ultimately =
calls
> into the host kernel with some internal APIs to do the DART mappings.=20=

>=20

Hello,

Some more details:

The VMM side when using Virtualization.framework is at =
/System/Library/Frameworks/Virtualization.framework/XPCServices/com.apple.=
Virtualization.VirtualMachine.xpc/Contents/MacOS/com.apple.Virtualization.=
VirtualMachine
as Virtualization.framework

And that directly communicates with IOPCIDevice...

And the source code side of PCIDriverKit is at =
https://github.com/apple-oss-distributions/IOPCIFamily/tree/main/PCIDriver=
Kit=20

And for PrepareForDMA at =
https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d375=
211650a4c1ff8ca1ea/iokit/Kernel/IOUserServer.cpp#L1001

IOMemoryDescriptor has this option: =
https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d375=
211650a4c1ff8ca1ea/iokit/DriverKit/IOMemoryDescriptor.iig#L56 - =
kIOMemoryMapFixedAddress

But not sure whether that=E2=80=99s allowed for user-mode drivers

Hopefully that helps.

Thank you,
-Mohamed







