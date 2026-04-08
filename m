Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD210F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXhu-0002iv-B6; Wed, 08 Apr 2026 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAXhs-0002cq-0t
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:52 -0400
Received: from ci-2003c-snip4-2.eps.apple.com ([57.103.91.153]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAOLn-0000xZ-C1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:33:29 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id
 3E46518001AB; Wed, 08 Apr 2026 08:33:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775637203; x=1778229203;
 bh=Ey2BXgJ2jMhavmvlJ1DxFW7VHxQdZ6dEzTrI8zI5AIY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NK8IIC2iWpNvDFRxKTxkdDFppYifSDi0jSkeRQyjgmj/MN+/7sTq1z1fVx5PKEKotNfNxwABubt7y2e64txoHCClsiAloh1oFN6nRwUOPUvUyeivgdu0tiaAONZn+lYg0Zg7TNz8YVp2GeLD9p6FXVskLwhDrS2kJdWmixuIMOt3wu0/xv9LgX/M0WNwQuUPJHMjJrVHv1uZ9QBUttW0MN41WIK4KpaOlEBB45fZ+ldspylfIHawNEIGjuzkgqoLnzm77h72pWauWf+kq3GPUsVAyax+5+xf8GCUt9Oai+IeESq4UjcCQ+8htZwR/7euu/+cylw4d9HYEBwbyGENtQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id
 AD40418001AE; Wed, 08 Apr 2026 08:33:18 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
Date: Wed, 8 Apr 2026 10:33:06 +0200
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu,
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DF8BCE0-8685-47EC-AD6A-DAD9A6CAE6D5@unpredictable.fr>
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
 <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
 <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=IbCKmGqa c=1 sm=1 tr=0 ts=69d612d2
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=DBfv99YmAAAA:8
 a=hCTvFA7NAAAA:20 a=m3wG6IFcAAAA:20 a=9AdMxfjQAAAA:20 a=pGLkceISAAAA:8
 a=2Noezc2ShHwjsch0QPoA:9 a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22
 a=bA3UWDv6hWIuX7UZL3qL:22 a=sJAZaMKuHmt1Z9jkTlw8:22
X-Proofpoint-GUID: DrUJdl-g5ei-4mYSk9MkmT1RSBWPgppP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA3NyBTYWx0ZWRfX+h9SgFHvoGe1
 DQTEr9VVVGfi3NA7ZdvxF7vBdTHVt4sp2t4m1cyO5kLNiNgEOsp5pXYewK9+vQAvrx1IF3d5x++
 O6rRaYidd1xMnZ3OZjal+OL8D63Ao4syJbSAa4VXRjwDtAPhhjwWvX1ivQ/HowXRh9qION34n5h
 3H3/BudJGAU6osEsHZ3qKz4SKZDWWuWh+SNCijLvtddJzPTTx19t2cz4pXtRH+fYGTYyJ+LtQBr
 MDPWTyWNcJlVdZxFm3TpvFI7uRy2E3+gNIrYJFOcCRMn7u6ZJca+59MkRjKDjMDeo4PDtfIFE6P
 fnQj8X3mo+wNLzHssGvLF7yJ2LYhYUUcTK2VzQffQPZ9epHjK40pc4StS6uH4I=
X-Proofpoint-ORIG-GUID: DrUJdl-g5ei-4mYSk9MkmT1RSBWPgppP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604080077
Received-SPF: pass client-ip=57.103.91.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On 8. Apr 2026, at 09:02, Scott J. Goldman <scottjgo@gmail.com> wrote:
>=20
>=20
> I dug in here and implemented the restricted-dma-pool solution. Still
> needs some cleanups but it's working enough to test. To start with the
> bad news:
>=20
> 1. As I mentioned previously, the mainline kernel has a max 256k limit
> for any single swiotlb mapping. This has been debated a few times on
> LKML, but the consensus has been generally that it should not be =
changed
> or made configurable. You can see the threads:
>  - https://lkml.org/lkml/2015/3/3/84
>  - =
https://patchwork.kernel.org/project/linux-mips/patch/20210914151016.31749=
24-1-Roman_Skakun@epam.com/
>=20
> 2. NVIDIA drivers immediately make a contiguous 528384 byte =
allocation,
> at least on my hardware (NVIDIA RTX 5090), which is required as part =
of
> initializing the firmware on the card. This obviously fails =
immediately.
> It happens on both the NVIDIA-provided "open" drivers[1] and the =
in-tree
> `nouveau` [2], so it's more a hardware-specific issue than just a =
driver
> problem. If you hack around that (allocate 3 smaller buffers and hope
> they are contiguous), you'll see that both drivers assume coherent DMA
> memory (moreso in the nvidia driver than nouveau, but it's a problem =
in
> both). They map DMA buffers and then write data into the buffers
> afterward. So you end up sending empty swiotlb buffers to the card and
> it'll ultimately fail to initialize.

Hello,

Interesting, on x86 the bounce buffer situation is a bit different =
instead of=20
just conventional swiotlb.

It looks like some of the NVIDIA bounce buffering support code is behind =
checks
to support x86_64 only:

=
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/db0c4e65c8e34c678d7=
45ddb1317f53f90d1072b/src/nvidia/src/kernel/gpu/ce/arch/blackwell/kernel_c=
e_gb100.c#L1833

>=20
> It's possible the press release was referring to using the closed =
NVIDIA
> drivers, but those are now deprecated and don't support my newer GPU.
>=20

They=E2=80=99re using the open ones on x86, Hopper doesn=E2=80=99t =
support the closed ones.

> But, there is good news:
>=20
> 1. The IOVA range that seems to always come from PCIDriverKit is =
pretty
> far outside the default qemu mapping from `-machine virt`, so the =
range
> can be cleanly identity mapped in the VM without overlap. One of the
> restrictions I noted earlier (16MB max contiguous mapping) was =
actually
> just a bug in my code. A large contiguous mapping seems to work fine,
> though the ~1.5GB limit is still real.

There=E2=80=99s a catch there for early platforms with small IPA space =
(ie early non-Pro/Max)
which only had a 64GB IPA space.

But documenting those as not supported is probably fine.

>=20
> 2. restricted-dma-pool DT attribute can be assigned per-device. So it
> doesn't affect other drivers on the system, and potentially that means
> you can have different pools for multiple devices (have not actually
> tried this yet, but seems like it would work).

Yes.

>=20
> 3. More normal devices can work. I purchased a thunderbolt nvme
> enclosure and it works with the swiotlb bounce buffering with no =
kernel
> modifications.
>=20
> 4. With a sufficient amount of hacks in the driver, the NVIDIA "open"
> driver can be made to work, albeit with already slow gaming =
performance
> reduced to about 30% (~10fps) vs paravirt dma mapping (~30fps). I =
wasn't
> able to get CUDA working, but presumably that just needs more elbow
> grease.

UVM for CUDA uses its own separate memory allocator so changes for CUDA
are expected - except if you force disable UVM which you can do by not
loading nvidia-uvm and this:

=
https://gist.githubusercontent.com/shkhln/40ef290463e78fb2b0000c60f4ad797e=
/raw/0e1fd8e8ea52b7445c3d33f5e5975efd20388dcb/uvm_ioctl_override.c

>=20
> After sleeping on this a bit, I think my proposal would be:
>=20
> - The `restricted-dma-pool` method can be the default. For most =
devices
>  this will work seamlessly, though users may have to specify a size =
for
>  the pool, since the optimal size will vary for each device.
>=20
> - The apple-dma-pci thing can be downgraded from an actual device to =
an
>  out-of-tree workaround. I have not yet tested it, but presumably it
>  can use ivshmem or a virtual serial port to communicate the mappings.
>  It's mostly a guest-side hack so it doesn't really need qemu
>  involvement necessarily.

If it=E2=80=99s going to ship, I think keeping it an actual device is a =
good idea.

>=20
> - I doubt Apple will actually approve this for distribution, but I can
>  write a kext that uses the kernel API to manipulate the DART =
directly.

Unfortunately the kext situation is pretty much a hard no for signing on
the Apple side. :/

>  I didn't realize this was an option before. This can act as kind of a
>  companion for my dext and as follow-on to this patchset, I can teach
>  the vIOMMU device to use it. Eventually if Apple exposes this as
>  something you can use in a dext, then the functionality can be moved
>  into the dext and all of these concerns become moot. Until then, it
>  can be an optimization if you're willing to run without SIP.

Yeah, proper virtio-mmu can be available as an option when SIP is off
with a custom kext, and I think having support for that in-tree would be
a good idea.

>=20
> If you think this is OK, I can prepare a new version of the patchset.

This all looks cool :)

>=20
> Thanks,
> -sjg
>=20
> [1] =
https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/nvidia/src=
/kernel/gpu/gsp/kernel_gsp.c#L5404
> [2] =
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm=
/subdev/gsp/rm/r535/gsp.c#L1827
>=20


