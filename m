Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6071D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=j5Z/ZR3H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJH5g-0007tU-VT; Tue, 20 Oct 2026 17:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xJH5a-0007tK-8B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:09:42 -0400
Received: from pv-2001j-snip6-2.eps.apple.com ([2a01:b747:3003:200::66]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xJH5X-0001rp-SX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 17:09:42 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPS id
 78FDF180080C; Tue, 20 Oct 2026 21:09:33 +0000 (UTC)
X-ICL-RepId: 01a15b25-e7df-7938-a5be-74fa058ee113
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISRMFUgddTVYNRw9YHlwUFwhFQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0x7SQEvc1tzNBROBykDRgYzD0weLHJdCl19S3Uvcl13NQ1OBV93HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792530576; x=1824066576;
 bh=lftDRfMOyhjXYARdRkCKzzKnkNbtke1R1tM6bKa5wI4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=j5Z/ZR3HV3qk7miMrYeoBuVrjx2UcHkF6WKHJA972wKL+AxXeioPDfb7w9nYishT0AIaESElvxUmgC4F/UvAdWnnnSjW8VF1CgX4STkobzmkgEHoTd0SwarvvX1fK4y50jfdYj1b3POhTcyqc8aZg7qfQD89QHQ5qloP0DMm2twY8dvPBIMSH3XutabJFnF+wi+tbVpJqOBdMrmUHCpPWo8WK7LlLbQUTa+0u7fBKcWAHKDFdjA88P1jlWL48OH5Mhm2gakOz2bhofiPvV+stMWDrtU4/UrP1MgYnCu8/bpz+kE4deTotRlnB9UCqhlTzzWqefED3LjeysfDorF0vg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPSA id
 E17971800E4D; Tue, 20 Oct 2026 21:09:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
Date: Tue, 20 Oct 2026 23:09:18 +0200
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B12BD0AD-64D4-4C64-AE68-D3FBE6EE4662@unpredictable.fr>
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
 <87wlrc1mie.fsf@draig.linaro.org>
 <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
 <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Proofpoint-GUID: I2OKU68DmAUzfbGZQPBRPDeoXWSkqP1i
X-Proofpoint-ORIG-GUID: I2OKU68DmAUzfbGZQPBRPDeoXWSkqP1i
X-Authority-Info-Out: v=2.4 cv=Z9/h3XRA c=1 sm=1 tr=0 ts=6ad7d88e
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=iyAqGMKVjAwXEVTXmp4A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX1BXJRKm/1q2V
 nGvPRw0RLTNeq6fzCxTTqLWhhoNFV6usJ6G4k8VYyLa43RjAoLr4vVOuD5c1r6Qskd3gN5NID8T
 dyLa2I5xZAE/u202SyC0mlg591BXBYgNTGV04wRhVH6VllC3bZIlhyS7IaI0oEIqcQIqsBF6hpm
 B50jcKYH2qjktVYmG5cSwjnbzq/8siByUkrz6ETv1AKF6UG690HSHB523RbsfBQ9uckKqzTLCLn
 Po9ZltntB5HcIXz1DFfeY20RyzsnXQtfqdBwLR37FCPtjWrptOU2ESM8eh9RfOl414Wp/6PyHpI
 DnRRvAyue6SiZcMtoForxZUWlfU24DPEA28BgOEMd0uSvMgjdSMqtRGVkAO5Z4=
X-JNJ: AAAAAAABwWirstkEfX6rR1IrO9e+CfqZ4LpMGGbmVnbGhk4+s32cn94T9VTpq1RalmOvAxX0I1zSY8sEVPU9xp8CWadoN27Y90J0koP6gdgk3mzVNVJlo0KecVCpC5opRiA8O8QVbIDfgs6ee9gABC+5jCARhCEEmow165ex+F9rJQNQ+AB7GKFiFw3PaI/DT7/Yk6qruXrFJQ+6PMK7imuNl1lii4AgigeUfvzWsjmJ2tGkhggTyJQE4y1xjknXoWcmEO6wFaDyQkXPRFyzS7krUfgq8/nI5GWIgo/2bVJUu/1f9uqhPKZjtRH+u6Byn5VoFe0zOrILr5+iUKzmDRxIFqb8N7Przi1fl/oST9sDx9CXLWSYXrhvjhRAl90Q0DhCNHwtfBAlkk/wlpxirn5Jca9B7DnxEGXyr8PGM3xTDj3aiK25/VwuSpg4ETBar955XL49AZUhgWrM8aS6XXtX/WKkpHjSen5PGQCKNtow6QQuDbBtuB2i4uxQLTtGciSAsHG3aYu/hsYr7BZOT2/omLyOz0o1ZqyMelpMHGcRcFJqW6pbssdVz3UZJhDVYGk7aI7vsTHaj+3JRYThSBT2L3VnJ0QLEOoVzjeXfZz4xd+QEqQ+O+reCBjC7ReFLItKtux/FMVnUqve7UupYyTM+OwpijwD/CMmvsnx3XIeO4Gxn+I2xo6DeDnI3B5X+q+9wwAqUnrC6pqRyMZBju+iT56+2ST9Ri8+IsY13PtEdwDhUsXve+Iyj9ZFHZEmm0mF5xv9M0kvk8T4wjQCSugYgSvVbd/BuIGz0qKCjLyHtj9H4aTfDVCEEzWOmU/z/eJzmBvvXEd8X1Tl6oLJrUVQtdq+dwcTefgWGsIu/wlWdvcYsrE6sLc4karpPkSqtaF/L/xkRA0nh9cUHTu33NzCoHWHDGFfXY5WlmlE+jVZCO4Rw6o3HIIN3nq7xl9zaRZFL9So7R53bCLHUc1j4dQJjfV2FkP
 IuIfx8cgynRSiPDfFr7Ww+ch58ZGzZeF66HmMnFVXu0YaeTLN/FXs3FJ+KyFyIj0bytce7sFaeSMNsGCF+/zptH6sQNIB3FMFS2wMioZLSb9sctVp3VDWyJpu+GMsXkQQblbHMXI3odVlgZov33wfMYBwAiMb5jumOlH60DMoulVSIHsxFROaKtiTeLPmjgnCfTWvUuyl/9RRRCVdkjuYPWLfZaAamcV9FHbSXVRA4IAGgJx+m1Cjkp3yuR1yj64TnoVBNIHUE6bxv3ljCdwKgKFLdbmZmDLc6ek/s+1Cjefa+cUIGn5wUwtL0tgkLhFfxrD1vxyLF1YhNXnADe9br4Uq2CU9UcdWFq98Q19gOuzOcqwHLqyayJCg2dyoePYQlfeuSzCecToyGVpwg1oVarf9+hMb3oW/Y1eqMSEXE8WH/etffc1H5dq/t0+OHCZkpXI26uBbmOvpIEXhurnURXsHfdqweE4GV+McpEkZMvZqj7kQQt7ExiFH8dxtcmID8stPYfjBc/QYSFJ7phBsvOrEsZaXmDDlFnICNPjB1h5bZZxqFRLnw7dnz/VMiJxDC4URt3cv3nC8hP3mrmghq0bZLCjrlrDiXan5/3kDz7VQSj6fXeiGFrH5XCITnKlzmkMr3TH2
Received-SPF: pass client-ip=2a01:b747:3003:200::66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 20. Oct 2026, at 22:35, Demi Marie Obenour <demiobenour@gmail.com> =
wrote:
>=20
> On 10/20/26 11:06, Mohamed Mediouni wrote:
>>=20
>>> On 20. Oct 2026, at 16:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>=20
>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>=20
>>>> On 10/7/26 12:29, Alex Benn=C3=A9e wrote:
>>>=20
>>> (CC trimmed, IOMMU relevant maintainers added)
>>>=20
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> The KVM/QEMU community call is at:
>>>>>=20
>>> <snip>
>>>>=20
>>>> Is this also for topics related to KVM but not necessarily QEMU?
>>>> If so, and if there will be people who are familiar with device
>>>> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
>>>> faults are recoverable.  There is a virtio device I am working on
>>>> which requires this to avoid either crashing the guest or allowing
>>>> the guest to hog host memory.
>>>=20
>>> We didn't get to this at the last community call. Is this something =
that
>>> can be discussed on list first?
>>=20
>> It should be I think.
>>=20
>> Hi,
>>=20
>> For such a virtio device (and granularly exposing it to user contexts =
too), is ATS + PRI
>> a good choice? Perhaps even using the host page tables directly, with =
a per-process
>> abstraction as the security boundary.> > On physical hardware as =
intended, outside of the ATS + PRI case, IOMMU faults
>> are expected to be something requiring a device/driver reset. On Arm =
however,
>> there=E2=80=99s an exception for the stall model, which pre-dates ATS =
+ PRI.
>>=20
>> A PRI PPR reply of not present isn=E2=80=99t equivalent to an IOMMU =
fault and isn=E2=80=99t expected to
>> result in a crash resulting in a device reset.
>=20
> I have two concerns with ATS + PRI:
>=20
> 1. ATS allows a device to bypass the IOMMU, and my project relies on
>   the IOMMU to isolate a compromised device.

Hi,

For the hw side:

There are hardware mitigations for these in the sense of only allowing
pages to be addressed if they were supposed to be accessible (Arm DPT, =
tied
as part of the RME story)

Or what is also out there and often preferred is relying on PCIe IDE + =
attestation instead=E2=80=A6

>=20
> 2. I need to support both consumer and enterprise hardware.  I suspect
>   that ATS support is very limited in the consumer space.

PCIe ATS (at least in-SoC) is how AMD NPUs are deployed today, and the =
Intel
in-SoC accelerators rely on it too (via SVA): =
https://www.kernel.org/doc/html/next/x86/sva.html

But for a synthetic device implemented in the hypervisor stack for the =
guest that=E2=80=99s not going
to be an issue.

>=20
> For more context, I'm working on a device that allows a backend VM
> to provide virtio devices to other (frontend) VMs.  The backend VM
> will often have an assigned PCIe device,

Hm, and you want that backend VM to not be able to access to all guest =
memory?

> and there are applications
> where zero-copy I/O would be very helpful for performance.
>=20
> However, when the frontend VM exits or unmaps memory, the memory
> also needs to be unmapped from the backend.  If this is cooperative,
> the backend may simply refuse to cooperate, causing a host-side
> memory leak.

So =E2=80=9Cstealing=E2=80=9D memory from the frontend VM to be a shared =
region with the backend? With=20
an aim that all other guest memory remains inaccessible?

>  If it is preemptive, the backend will take faults when
> it tries to access the memory that has been unmapped from it.
>=20
> One can avoid both problems by only letting the backend access a small
> buffer, but this requires a copy in either the frontend or the device.

In practice, bounce buffering here can end up meaning both=E2=80=A6

Given your use case, I=E2=80=99m not sure if emulating ATS + PRI is the =
right thing to do,
but it=E2=80=99s the only on-demand memory mapping support in the PCIe =
specification today.

In your case it might mean having the IOMMU implementation as part of =
your TCB so that
the device emulator is only able to map guest pages through the IOMMU =
implementation
in your VMM...

> This might make the system uncompetitive with host-side vhost-user
> devices in high-performance applications.
>=20
> Is there a way around this tradeoff, or is zero copy incompatible
> with protecting both the backend and the host?

I don=E2=80=99t have much visibility on something else that=E2=80=99d be =
portable across
platforms unfortunately. In the CoCo cases what I=E2=80=99ve seen being =
deployed
ends up being either bounce buffering for passed through devices or PCIe
IDE with attestation and the NIC being trusted...

> --=20
> Sincerely,
> Demi Marie Obenour (she/her/hers)


