Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE6606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcExxi5K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOng3-0002qk-W6; Wed, 04 Nov 2026 21:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xOng2-0002qD-1v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 21:58:10 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xOnfz-0008OD-Pu
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 21:58:09 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0d126f631so15399477b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 18:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793847486; x=1794452286; darn=nongnu.org;
 h=content-type:autocrypt:in-reply-to:content-language:references:cc
 :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LARMm2VxR8Z99i9OuglCbBJUmT/nOy63dZ48j8aSALU=;
 b=xcExxi5KLbSbZopT7oUvai1IuPm16Rwp8ue1WPS6Lnm0xdJqZq1w/Yi0JX/4YQklf9
 upcTyR8LnAomhVgq9rVBC7AtCIOiR3pTUrBWyMRG9vuvMTfHimdhsHlkip5M3tB6cviW
 iuNFkG3lIuhLuvCZcJJZsF5/sss+P/b2SqLB46peUtAsKMKl93UOeqdopjb53r8GHQTE
 eFFQKb1opCIz5U3RirfILnkF7U0NJ70juIhlZbXjk90b70LdszYS9k2n5BdM+91+p0qc
 sd6cfwCpbIkMs6gs3JPd6KPezzsPH0gQFwe5npcJO/3Jv+elnuycHaRXHskPj3Wli6+5
 yCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793847486; x=1794452286;
 h=content-type:autocrypt:in-reply-to:content-language:references:cc
 :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LARMm2VxR8Z99i9OuglCbBJUmT/nOy63dZ48j8aSALU=;
 b=OWwHcqY53zkzyQX8+lmwJ+/lKZv50I1Rq+Iqf4HvPHTaPKr9J3fmTa4pgYUJc4L8Iu
 VANc8p3K7DLE1pYT2zTiZH9Omm9F3tiJc9TUqduv+zYNVIoPae/h71zXEjKw72ljFeS8
 dUpufr7swYAna98RDdQ/++fac5rDgOFRd0nFd31KEWQ90ZI51B4aFdQBi4lnPXQjkjww
 SUKYhi03ZbDi+azZE0EYomnsLq/35GRYHhKSc/35DIgmCDtg7Dhu7Pv8SpL9luJtIkT9
 POIkG5LnbetNbxK4lV6r0HySNoAiUrsqpLLFXS9gmVce1+6CN6MarK6QrvPfLyRPK8lj
 hzsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOsjPy8TA1FzNJa1tGSLC/zDxsciu5tFs/Sa1oRP6o/ikGT0Dugurk+GSeAO/bvtNLbV3QVhm+rBCL@nongnu.org
X-Gm-Message-State: APuU4Z9c+ilPb6Sf9uLTF9zypM9D6kthp6EEkhRbuCSAVqcqCtCl7ns1
 RZoM6OBUK+hBPFvkHBbKAOAUu+clBPqGkPGmfZSeBMxnYDsv0b0lwalh
X-Gm-Gg: AYBFou2UCUJ4ZGA1f+UakB5DHGFvMSo/wLC2B5xSFiu48zO3DsA/Nvb1AT5Kchon8UC
 nyeyExmYqMUdZl1D3LFZStwwV1abpzhiV3P+fDBalupCMcTPhMgbRCPVLZ4LGAJSHxXjFWEVisx
 JK8ZJT55J1cGSdRdbxWube737a7v2NZE1tc3LqsXaMMBzc+gCu0sv9VHicFCg3ubMM0cNdOHTTh
 mtPcYkMPGA6e34BGUwN27Zxe4iWxRdMf0ot1bcpqhzfXaNk7aPi/q5cDnr4rYHc5gyeUom3fq2J
 VpKGQxJ498HBKKOhdYtrYvJKybxZ83ggVXx00CrkNWYV8peK8SiGD/mdLA69P/kcLKDQu/Wc+Dn
 WXKTEHjr9AUg46edm8SXF92Qj/OyUyQmNyYhxwXeZsLmGl6S+2qF8AwGQNw/xyZhwk/qTCsgjf/
 Og/ZKERSL8DOTppDM6ViU0aY868fcA1HKaFkLYEtK607qyalpasMoBxJunpgnLFheG5ZaRJoL1R
 ZURCpbfcs7dCDAXvXO0xBxCEpifkC06Q2Y/Zmm47i+FH2F65D+j220cfVGK+5qBQUg6RbZ4QJVm
 kj/UTAFhCDIbaaY6Lj2p//aHdT4Ya4RI
X-Received: by 2002:a05:690c:6e83:b0:8b3:2a74:e0c9 with SMTP id
 00721157ae682-8b32a74e8efmr7007857b3.63.1793847485931; 
 Wed, 04 Nov 2026 18:58:05 -0800 (PST)
Received: from [10.138.10.6] ([149.102.242.31])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b309710cb8sm31590737b3.5.2026.11.04.18.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:58:04 -0800 (PST)
Message-ID: <3bf659db-a058-4bf2-b0e5-86ca443575ad@gmail.com>
Date: Wed, 4 Nov 2026 21:57:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
 <87wlrc1mie.fsf@draig.linaro.org>
 <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
 <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
 <B12BD0AD-64D4-4C64-AE68-D3FBE6EE4662@unpredictable.fr>
Content-Language: en-US
In-Reply-To: <B12BD0AD-64D4-4C64-AE68-D3FBE6EE4662@unpredictable.fr>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wL35HqvRr3VWrxJHbEuQzfA4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=demiobenour@gmail.com; helo=mail-yw1-x112f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wL35HqvRr3VWrxJHbEuQzfA4
Content-Type: multipart/mixed; boundary="------------N3LkNPYuFp2kBF903USP1UmG";
 protected-headers="v1"; hp="clear"
Message-ID: <3bf659db-a058-4bf2-b0e5-86ca443575ad@gmail.com>
Date: Wed, 4 Nov 2026 21:57:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
 <87wlrc1mie.fsf@draig.linaro.org>
 <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
 <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
 <B12BD0AD-64D4-4C64-AE68-D3FBE6EE4662@unpredictable.fr>
Content-Language: en-US
In-Reply-To: <B12BD0AD-64D4-4C64-AE68-D3FBE6EE4662@unpredictable.fr>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT

--------------N3LkNPYuFp2kBF903USP1UmG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/20/26 17:09, Mohamed Mediouni wrote:
>=20
>=20
>> On 20. Oct 2026, at 22:35, Demi Marie Obenour <demiobenour@gmail.com> =
wrote:
>>
>> On 10/20/26 11:06, Mohamed Mediouni wrote:
>>>
>>>> On 20. Oct 2026, at 16:20, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>>>
>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>
>>>>> On 10/7/26 12:29, Alex Benn=C3=A9e wrote:
>>>>
>>>> (CC trimmed, IOMMU relevant maintainers added)
>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> The KVM/QEMU community call is at:
>>>>>>
>>>> <snip>
>>>>>
>>>>> Is this also for topics related to KVM but not necessarily QEMU?
>>>>> If so, and if there will be people who are familiar with device
>>>>> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
>>>>> faults are recoverable.  There is a virtio device I am working on
>>>>> which requires this to avoid either crashing the guest or allowing
>>>>> the guest to hog host memory.
>>>>
>>>> We didn't get to this at the last community call. Is this something =
that
>>>> can be discussed on list first?
>>>
>>> It should be I think.
>>>
>>> Hi,
>>>
>>> For such a virtio device (and granularly exposing it to user contexts=
 too), is ATS + PRI
>>> a good choice? Perhaps even using the host page tables directly, with=
 a per-process
>>> abstraction as the security boundary.> > On physical hardware as inte=
nded, outside of the ATS + PRI case, IOMMU faults
>>> are expected to be something requiring a device/driver reset. On Arm =
however,
>>> there=E2=80=99s an exception for the stall model, which pre-dates ATS=
 + PRI.
>>>
>>> A PRI PPR reply of not present isn=E2=80=99t equivalent to an IOMMU f=
ault and isn=E2=80=99t expected to
>>> result in a crash resulting in a device reset.
>>
>> I have two concerns with ATS + PRI:
>>
>> 1. ATS allows a device to bypass the IOMMU, and my project relies on
>>   the IOMMU to isolate a compromised device.
>=20
> Hi,
>=20
> For the hw side:
>=20
> There are hardware mitigations for these in the sense of only allowing
> pages to be addressed if they were supposed to be accessible (Arm DPT, =
tied
> as part of the RME story)
>=20
> Or what is also out there and often preferred is relying on PCIe IDE + =
attestation instead=E2=80=A6

I need to support consumer hardware as well.

>> 2. I need to support both consumer and enterprise hardware.  I suspect=

>>   that ATS support is very limited in the consumer space.
>=20
> PCIe ATS (at least in-SoC) is how AMD NPUs are deployed today, and the =
Intel
> in-SoC accelerators rely on it too (via SVA): https://www.kernel.org/do=
c/html/next/x86/sva.html

Sadly, those are very much a special case.  AMD NPUs don't support
passthrough at all, and Intel in-SoC accelerators aren't available
on the platforms I'm targeting.  The main devices this is intended
for are NICs, storage devices, USB controllers, and Wi-Fi controllers.

> But for a synthetic device implemented in the hypervisor stack for the =
guest that=E2=80=99s not going
> to be an issue.
>=20
>>
>> For more context, I'm working on a device that allows a backend VM
>> to provide virtio devices to other (frontend) VMs.  The backend VM
>> will often have an assigned PCIe device,
>=20
> Hm, and you want that backend VM to not be able to access to all guest =
memory?

The data flow is:

  PCIe device
     |
     | PCIe passthrough
     |
  Backend VM
     |
     | Virtio PCI transport
     |
  Virtio Vhost-Guest Device/Vhost-User Server (in backend VMM)
     |
     | AF_UNIX socket
     |
  Vhost-User Client
     |
     | Virtio PCI transport
     |
  Frontend VM

Threat model:

- The host is fully trusted, and does not trust the PCIe device, backend
  VM, frontend VM, or device emulators.

- All device emulators consider all VMs (including, but not limited
  to, their own) to be untrusted.

- The backend VM trusts the PCI device, the host, and its device
  emulator.  It does not trust the frontend VM or the frontend VM's
  device emulator.

- The frontend VM trusts the host and the frontend VM's device emulator.
  For the purpose of this discussion, one can assume that it also
  trusts the backend VM.

>> and there are applications>> where zero-copy I/O would be very helpful=
 for performance.
>>
>> However, when the frontend VM exits or unmaps memory, the memory
>> also needs to be unmapped from the backend.  If this is cooperative,
>> the backend may simply refuse to cooperate, causing a host-side
>> memory leak.
>=20
> So =E2=80=9Cstealing=E2=80=9D memory from the frontend VM to be a share=
d region with the backend? With=20
> an aim that all other guest memory remains inaccessible?

Stealing some or all of the frontend memory, yes.

>> If it is preemptive, the backend will take faults when
>> it tries to access the memory that has been unmapped from it.
>>
>> One can avoid both problems by only letting the backend access a small=

>> buffer, but this requires a copy in either the frontend or the device.=

>=20
> In practice, bounce buffering here can end up meaning both=E2=80=A6

I think the copy could happen in two possible places:

- The backend VM could be given memory that doesn't support P2PDMA,
  forcing it to fall back to memcpy().  I don't know how well the
  guest would handle that situation.

- The frontend VM could use Device Memory Buffer, meaning that only
  a small amount of memory needs to be accessed by the backend (and
  so possibly leaked).

> Given your use case, I=E2=80=99m not sure if emulating ATS + PRI is the=
 right thing to do,> but it=E2=80=99s the only on-demand memory mapping s=
upport in the PCIe specification today.
>=20
> In your case it might mean having the IOMMU implementation as part of y=
our TCB so that
> the device emulator is only able to map guest pages through the IOMMU i=
mplementation
> in your VMM...

Given my threat model, I can't use ATS + PRI.  There's also no way
to emulate it that I am aware of.  While I could emulate it to the
VMs, I can't make the PCIe device use it.

>> This might make the system uncompetitive with host-side vhost-user
>> devices in high-performance applications.
>>
>> Is there a way around this tradeoff, or is zero copy incompatible
>> with protecting both the backend and the host?
>=20
> I don=E2=80=99t have much visibility on something else that=E2=80=99d b=
e portable across
> platforms unfortunately. In the CoCo cases what I=E2=80=99ve seen being=
 deployed
> ends up being either bounce buffering for passed through devices or PCI=
e
> IDE with attestation and the NIC being trusted...

That makes sense.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)


--------------N3LkNPYuFp2kBF903USP1UmG--

--------------wL35HqvRr3VWrxJHbEuQzfA4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrr8LgACgkQszaHOrMp
8lMgcA//YCxOGFfN9fiVfmwqx7TM1bGrCjzVHWx58vyaQOGhpbG/jpf78BxBtmbl
wrs1KutoCuW03Up5HxnYRW4fA7/anoEgqCCGvzEmPttehiEkMrXRW1sIE/BUiMXk
xp3ys+azObq21wGhmrZF4pJ9Mdd1kO9pJYcqeGobbpu05WXOSEhOqWoK9gCDtpSe
v6XARp/YDnzyHNzwla3gcKDDL0p9u7gXp4MTbz7rGWhFZLa30PhKgxO0sQw5S45R
dNGu0f2E0ILI5zBsC5RGw6McEAkKfgSndN7xqAdxGOjH+1XFurX0t7PMEfCiCrCo
CXAjPgRtNz4LCtGP6fgCPe3shSj4VDxq1Yfl1CG29BtVbjTOivlQj3w/yt/PiMiU
tkHELD7iS9de22+0MSQCSe5495IE3NAIniv4qScdwa9MJjXHODbNO+UB9xdU4m/k
sf8dL0YBYEteGqhVMZ1XN20kOR6LeQhd3ArsPaJYaYqMJVeNtjSLGswLeDmT2bCn
kw67KPwtWhkQebQPyW2sWN6WGI1STVSznWmlXKfQ1zqDGPX1q8CXGBTAC+nzs0vD
ZjQ/gQPT23CrQqaTeH4IAIW3HBXNKr2Ra/eEcNaJklI0BTFQbJB0DHlqMv4Gfrij
N2H6+N1GlF/Mw5IZce0YvIQjVzuK/JZHD2taUbs4KB1EDD7QC+I=
=CuZb
-----END PGP SIGNATURE-----

--------------wL35HqvRr3VWrxJHbEuQzfA4--

