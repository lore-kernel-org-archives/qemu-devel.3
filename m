Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E192E6401E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 12:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Msb-0007Hp-8m; Sun, 05 Apr 2026 08:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9Icl-0000Ke-Oo
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 04:14:27 -0400
Received: from p-east2-cluster2-host5-snip4-6.eps.apple.com ([57.103.78.29]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9Ici-0003ox-Dm
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 04:14:27 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPS id
 D449618000B3; Sun, 05 Apr 2026 08:14:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775376862; x=1777968862;
 bh=t5etCBDR7EazSSH0eWPCNxNxGBcZZBPfuPCbddhssJc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WgXVkbTMbVVxCuMjL/LVF98VkmrbOI4fQSKN+RoMG5Fp+RntmA2AZtJxbye72SXlFCGRHB5ktBkgBrNPQJyeGgHb/rqf7F9+cmr4W8o4Dbyta+nkRlW9yQYENUrkhkVnAWXWmV4XDOOznVMcigvGT4ZgqH/x2PiSV/kvltNeBtsO/UHQGwRROAz3IdmxLsdkb+kAi4kryE8SR89jPz0CFEQatRrjjY1kqF2lMfWC/O4mPAQrDkO0FQKYk4IEZVpY5DXbkP51jBclD/GiQic1s5H8Lq69LnBTGjiblxmnLKGSuNNBlsrkSN+lWB7kOUnwwnxJE+SwTTjY/fwEdABlmQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPSA id
 6CCDD1800132; Sun, 05 Apr 2026 08:14:16 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
Date: Sun, 5 Apr 2026 10:14:04 +0200
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu,
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDA4MSBTYWx0ZWRfXzrrOHq/EHvep
 SlGkUtR7nV5WL9Ss7nr90JAKDdNhKbKAf+0mohzzkiAjbxnLJdlgU2xIIYIuMrSB8AkUN2RVHSB
 aueq048BXa5FC//ykR6iuiRsiaMCsf6ZO2/A1dqgNr8pE4E9/MIl4tfKN/bu1jBkBHsccTbUkS7
 VULHWciBRWs9yfKSZNkVG0WAO0wMIIg45P2wlaGE75QYgqJ/YT7ZMqr8shRkiw/BQ8ZBpsX69dZ
 UlQXo/QE7VH5BZoH3PxLnHvPHCf7QROk0+L/1nXMkJFoBaSAnUZa2gNcdU1whgQrzK9e6kbjQ+u
 CyzevJajDaxYNYxmEhrlDH6pv/iO9YG+vtfZQUNbTHnaT4Tnx/ArL13blPhHS8=
X-Proofpoint-ORIG-GUID: Od60q3nDY_hGaJy05yU4o1RDVo3AjYgt
X-Proofpoint-GUID: Od60q3nDY_hGaJy05yU4o1RDVo3AjYgt
X-Authority-Info-Out: v=2.4 cv=BefVE7t2 c=1 sm=1 tr=0 ts=69d219dc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=aA-33HkQAAAA:20
 a=TkNuIPFPAAAA:20 a=WVbz653JAAAA:20 a=pGLkceISAAAA:8 a=mZfonHcMw-UIrJ9WzQwA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22 a=gGywIldwKSjjSr1hpRws:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1030
 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050081
Received-SPF: pass client-ip=57.103.78.29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 5. Apr 2026, at 10:01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>>=20
>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>>=20
>> This series adds VFIO PCI device passthrough support for Apple =
Silicon
>> Macs running macOS, using a DriverKit extension (dext) as the host
>> backend instead of the Linux VFIO kernel driver.
>>=20
>> I'm sending this as an RFC because I'd like feedback before investing
>> further in upstreaming.  The code is functional.  I've tested it with
>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>> gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
>> [1]), likely due to the BAR access penalty described below.  AI
>> inference workloads appear less affected.  Ollama with Qwen 3.5
>> generates around 140 tok/sec on the same setup [2].
>>=20
>> How it works:
>>=20
>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>> for device access and DMA mapping.  On macOS, there is no equivalent
>> kernel interface.  Instead, a userspace DriverKit extension
>> (VFIOUserPCIDriver) mediates access to the physical PCI device =
through
>> IOKit's IOUserClient and PCIDriverKit APIs.
>>=20
>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>> passthrough infrastructure.  A few ioctl callsites are refactored =
into
>> io_ops callbacks, the build system is extended for Darwin, and the
>> Apple-specific backend plugs in behind those abstractions.
>>=20
>> The guest sees two PCI devices: the passthrough device itself
>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>> AppleVFIOContainer implements the IOMMU backend, and a C client
>> library wraps the IOUserClient calls to the dext for config space,
>> BAR MMIO, interrupts, reset, and DMA.
>>=20
>> DMA limitations:
>>=20
>> This is the biggest platform constraint.  Unlike a typical IOMMU
>> mapping operation where the caller specifies the IOVA, the
>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>> system-assigned IOVA.  There is no way to request a specific address.
>> This means the guest's requested DMA addresses cannot be used
>> directly.  The guest kernel module must intercept DMA mapping calls
>> and forward them through the companion device to get the actual
>> hardware IOVA.
>=20
> Hello,
>=20
> Ugh this one is not great. By the way, Apple has a private PCIe =
passthrough
> API used by Virtualization.framework but that=E2=80=99s a different =
design.
>=20
> Would bounce buffering using something akin the confidential compute =
path and=20
> a pre-defined chunk of host memory accessible from the device, and =
then managing
> the guest address map work? (see swiotlb).

see restricted-dma-pool

I think in this specific case that ACPI support isn=E2=80=99t worth it =
and that FDT
will be good enough.

The limitation that I can see there if if you can=E2=80=99t match IOVA =
and GPA for that
restricted DMA pool, then you=E2=80=99ll need a small (and hopefully =
easy to merge) kernel
change.

>=20
> If the last part isn=E2=80=99t possible, something minimal to export =
an swiotlb window
> through device tree with giving the IOVA there would be good too.
>=20
> And that will get rid of a need for a apple-dma-pci device.


>=20
>> There are also hard platform limits: approximately 1.5 GB total
>> mapped memory and roughly 64k concurrent mappings.  Not all
>> workloads will fit within these limits, though GPU gaming and LLM
>> inference have worked in practice.
>=20
> That=E2=80=99s not too dissimilar from the confidential compute =
limitations.
>=20
>>=20
>> BAR access has performance issues as well.  HVF does not expose
>> controls to map device memory as cacheable in the guest, creating a
>> significant performance penalty on BAR MMIO.  Uncached mappings work
>> correctly but slowly compared to what the hardware could do.
>=20
> That=E2=80=99s not a macOS limitation and not an Apple hardware =
limitation, but
> it=E2=80=99s more fundamental to how PCIe works.
>=20
> Unlike CXL, PCIe doesn=E2=80=99t have a coherency protocol story, and =
the alternative
> of uncached and doing manual software-managed flushes isn=E2=80=99t =
really tenable.
>=20
>>=20
>> What works:
>> - PCI config space passthrough
>> - BAR MMIO via direct-mapped device memory
>> - MSI/MSI-X interrupts via async notification from the dext
>> - Device reset (FLR with hot-reset fallback)
>> - DMA mapping for guest device drivers
>>=20
> This is very interesting to see :)
>=20
>> What doesn't work:
>> - Expansion ROM / VBIOS passthrough
>> - PCI BAR quirks
>> - VGA region passthrough
>> - Migration and dirty page tracking
>> - Hot-unplug
>>=20
>=20
>=20
>=20
>> Questions for reviewers:
>>=20
>> 1. Is this something the VFIO maintainers would consider carrying
>>  upstream?  The refactoring patches (3-6) are benign, but the Apple
>>  backend is a new platform with real limitations.  That said, if =
Apple
>>  lifts some of the DART/HVF restrictions in a future macOS release, =
the
>>  code changes to take advantage would likely be minor.  I'd like to
>>  understand whether this is in scope before doing the work to
>>  address review feedback on the full series.
>>=20
>> 2. The apple-dma-pci companion device: should this be a virtio device
>>  instead?  I went with a simple custom PCI device because the virtio
>>  infrastructure didn't buy much for what is essentially a {map, =
unmap}
>>  register interface, but if virtio is preferred, what is the process
>>  for allocating a device ID?  If a custom PCI device is the right
>>  approach, I've tentatively allocated 1b36:0015.  Is there a process
>>  for reserving a device ID under the Red Hat PCI vendor, or is
>>  claiming it in pci-ids.rst sufficient?  The guest-side kernel module
>>  hooks all DMA mapping functions for passed-through devices, which is
>>  unusual enough that I'm not sure it's upstreamable in the Linux
>>  kernel.  I can maintain it out of tree if needed.
>=20
> I=E2=80=99d recommend using bounce buffers like the CoCo case if =
possible. I don=E2=80=99t
> think that the apple-dma-pci definitely-not-an-IOMMU is a good idea.
>=20
>>=20
>> 3. Should the macOS host-side DriverKit extension live in the QEMU
>>  tree?  It's not included in this series and requires Apple code
>>  signing.  I'm happy to keep it out of tree if that's preferred,
>>  or include the source if reviewers want it co-located.
>=20
> Both are fine I think. Could you share compatibility with the tinygrad
> one at =
https://github.com/tinygrad/tinygrad/tree/7e54992bf600789dbe5d37b99fe12a19=
c32e36a1/extra/usbgpu/tbgpu/installer and prebuilt at =
https://raw.githubusercontent.com/tinygrad/tinygpu_releases/refs/heads/mai=
n/TinyGPU.zip?
>=20
>>=20
>> 4. The existing VFIO code includes <linux/vfio.h> from the
>>  linux-headers/ tree, which is intended to track upstream Linux
>>  UAPI headers.  To make this compile on macOS, I added minimal
>>  stub headers (include/compat/linux/types.h and linux/ioctl.h)
>>  so the existing vfio.h parses on macOS without modification.  An
>>  alternative would be to move an approximation of vfio.h into
>>  standard-headers/, but that felt against the spirit of tracking
>>  the latest upstream headers, and the standard-headers import
>>  process strips ioctls which the VFIO code relies on.  I felt
>>  the stub approach was the least invasive, but I'm open to
>>  changing it if there's a preferred way to handle this.
>>=20
>> [1] https://imgur.com/a/xoRS9kT
>> [2] https://imgur.com/a/ui4pYF0
>>=20
>> Scott J. Goldman (10):
>> vfio/pci: Use the write side of EventNotifier for IRQ signaling
>> accel/hvf: avoid executable mappings for RAM-device memory
>> vfio: Allow building on Darwin hosts
>> vfio: Prepare existing code for Apple VFIO backend
>> vfio: Add region_map and region_unmap callbacks to VFIODeviceIOOps
>> vfio: Add device_reset callback to VFIODeviceIOOps
>> vfio/apple: Add DriverKit dext client library
>> vfio/apple: Add IOMMU container and PCI device
>> vfio/apple: Add apple-dma-pci companion device
>> docs: Add vfio-apple documentation and MAINTAINERS entry
>>=20
>> Kconfig.host                       |   3 +
>> MAINTAINERS                        |  11 +
>> accel/hvf/hvf-all.c                |  10 +-
>> backends/Kconfig                   |   2 +-
>> docs/specs/pci-ids.rst             |   3 +
>> docs/system/device-emulation.rst   |   1 +
>> docs/system/devices/vfio-apple.rst | 160 +++++
>> hw/vfio-user/device.c              |  16 +-
>> hw/vfio/Kconfig                    |   4 +-
>> hw/vfio/ap.c                       |   4 +-
>> hw/vfio/apple-device.c             | 945 =
+++++++++++++++++++++++++++++
>> hw/vfio/apple-dext-client.c        | 681 +++++++++++++++++++++
>> hw/vfio/apple-dext-client.h        | 253 ++++++++
>> hw/vfio/apple-dma.c                | 540 +++++++++++++++++
>> hw/vfio/apple.h                    |  74 +++
>> hw/vfio/ccw.c                      |   2 +-
>> hw/vfio/container-apple.c          | 241 ++++++++
>> hw/vfio/device.c                   |  42 ++
>> hw/vfio/meson.build                |  12 +-
>> hw/vfio/migration.c                |   5 +-
>> hw/vfio/pci.c                      |  50 +-
>> hw/vfio/pci.h                      |   1 +
>> hw/vfio/region.c                   | 108 ++--
>> hw/vfio/types.h                    |   2 +
>> hw/vfio/vfio-helpers.h             |   2 +-
>> hw/vfio/vfio-migration-internal.h  |   4 +-
>> hw/vfio/vfio-region.h              |   4 +
>> include/compat/linux/ioctl.h       |   2 +
>> include/compat/linux/types.h       |  26 +
>> include/hw/pci/pci.h               |   1 +
>> include/hw/vfio/vfio-container.h   |   1 +
>> include/hw/vfio/vfio-device.h      |  40 +-
>> meson.build                        |  10 +-
>> util/event_notifier-posix.c        |   5 +-
>> 34 files changed, 3197 insertions(+), 68 deletions(-)
>> create mode 100644 docs/system/devices/vfio-apple.rst
>> create mode 100644 hw/vfio/apple-device.c
>> create mode 100644 hw/vfio/apple-dext-client.c
>> create mode 100644 hw/vfio/apple-dext-client.h
>> create mode 100644 hw/vfio/apple-dma.c
>> create mode 100644 hw/vfio/apple.h
>> create mode 100644 hw/vfio/container-apple.c
>> create mode 100644 include/compat/linux/ioctl.h
>> create mode 100644 include/compat/linux/types.h
>>=20
>> --=20
>> 2.50.1 (Apple Git-155)



