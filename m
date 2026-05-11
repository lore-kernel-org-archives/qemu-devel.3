Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B164CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVX6-0005FC-9Q; Mon, 11 May 2026 14:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMVX4-0005Eg-FP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:39:10 -0400
Received: from p-east2-cluster1-host2-snip4-5.eps.apple.com ([57.103.76.38]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMVX1-0007hs-RN
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:39:10 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 EBAD718069CD; Mon, 11 May 2026 18:39:00 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJA01fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQU8BVUFXHMzDVUDVQJZH0QJTgtAdlpzSBRJAlxyKXY2AE0ELnQrRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778524744; x=1781116744;
 bh=HrDiUX/m1sVNw40ckFgYf4G5OrERdo/IyQoPlmyEv7Q=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Pg/s5XuyFBz4iudxOQ9QVC1AcJ/e0Er6iopDFey7FMZ3SHv28tuQKurcF2ctlILBiVjuoutUm3doqruVzfW20IxMZpT64i/rklDUuvhDD82alnCPVVe+yP3OneHbwdYAPyzegAAC9yz0cDQQIshGRlt3MLxqcX1sd/LjgZ67EyoXqASjKTnDvz/lsGythGmAr9ZNZ58o8x3qA23AZspxZcrGiWEa5MEE3DtjLhHz4E9hal8pX/W84NldQKKeKOeYrzoDh1EOkdnYLJrjpDkyVjg7Ilh+Ch3ii9Rhrt5XQ63SxokIEglKqFy+WRvxgMjUfgZw0ha9nN0ed86SgsgGrQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 5AE20180303A; Mon, 11 May 2026 18:38:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260511122633.GE1116784@nvidia.com>
Date: Mon, 11 May 2026 20:38:44 +0200
Cc: Peter Maydell <peter.maydell@linaro.org>, Tushar Dave <tdave@nvidia.com>,
 qemu-devel@nongnu.org, alwilliamson@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6827AC4-0852-4068-A1A8-111EBDF957CC@unpredictable.fr>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <CAFEAcA9KxUF6c555Q_Kqn_NVE3z1ojr91+KuatYudj_T4GjbxA@mail.gmail.com>
 <20260511122633.GE1116784@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: dPTda6USknI3hMRBRaHVf00R9PeIKVx1
X-Authority-Info-Out: v=2.4 cv=TP1Iilla c=1 sm=1 tr=0 ts=6a022246
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=Vdg3MsYikgLEERl5QvQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5OCBTYWx0ZWRfX6qJ+CM8MwTy4
 A1DG3foCg+eDML4vUiNN1iWdRw2F7t8mkcaksDEy0abArQ79PTJifpgAnccI5YVLQQTK/sJ7d9s
 /CmaqV6xoaLroe5GlywPMeqrnrzExm09ld8EK3gV0qOjLPbDZrURf9Zrt8noNbwM2+VpWM7u/Po
 8w2LY1VkUMbfzXmuCKhNjpAi8bvPO5S1tuvlU7SxCE0EA18k+UIqXjLDn01i7MWM2XdftPUZJyr
 Cqr1rUFMV8Bj9gAJhM275twCc/uze6qIxv1+VrZoTpM0nZ/tjjSCv8MxRK+1NsTdLYQYp0GNXjU
 quX+Cfrjc/MIe0mVE4Gt6soXZcRL8KT6GYGlPMGTI7iHLDPdrwjgvi0xU7nO7U=
X-Proofpoint-ORIG-GUID: dPTda6USknI3hMRBRaHVf00R9PeIKVx1
Received-SPF: pass client-ip=57.103.76.38;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 11. May 2026, at 14:26, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, May 11, 2026 at 08:46:57AM +0100, Peter Maydell wrote:
>> On Fri, 8 May 2026 at 19:37, Tushar Dave <tdave@nvidia.com> wrote:
>>>=20
>>> This RFC introduces a mechanism to specify Guest Physical Addresses
>>> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
>>> addresses to match host physical addresses for assigned devices.
>>>=20
>>> On some platforms, P2P DMA is performed between devices within the =
same
>>> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
>>> without going through the host bridge in order to achieve the =
required
>>> performance.
>>>=20
>>> To support this multi-device IOMMU group P2P scenario in =
virtualization,
>>> the VM may need to use the same MMIO BAR addresses as the host =
physical
>>> address layout.
>>=20
>> This feels like something's wrong in the design. A VM doesn't
>> necessarily have the same memory layout as the host: the
>> VM hardware is all about making that possible.
>=20
> The HW running these systems is unfortunately limited and doesn't have
> ATS support. Without the right HW features the physical PCI topology
> is leaked into the VM and there is no choice but to have the VM guest
> physical and true physical match, otherwise the VM can't work.
>=20
> There is no other way to support these VM shapes on this HW.
>=20
> Newer CPUs in this family have more HW features and won't need to do
> these things.
>=20
> Jason
>=20

Hi,

It has been years already since I last looked at Grace (synthetic-)PCIe =
handling
(and it was with another VMM than QEMU) but...
=20
As you=E2=80=99ve said newer parts will not have this quite peculiar =
requirement, and
that makes me think that this is maybe suited as more of a workaround =
that
is not open ended... by having it open just like that there=E2=80=99s a =
chance that it
would get future users and I don=E2=80=99t think that makes a bunch of =
sense.

And not very relevant to Grace + GPU systems specifically, but any hopes =
of live
migration support are lost outside of very awkward placement trickery =
when using
this to match host addresses.

Is this specific to the NIC attached directly to the GPU (that is
then attached over C2C) configuration?

Using PCIe passthrough with ATS disabled doesn=E2=80=99t sound like such =
a great idea
on the security side of things imo.



