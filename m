Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FCE606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YAPqqQs4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJGZ9-0007ba-Px; Tue, 20 Oct 2026 16:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xJGZ8-0007b2-0L
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:36:10 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xJGZ5-0005eZ-Rs
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:36:09 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b05bf699easo506647b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792528564; x=1793133364; darn=nongnu.org;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LVXZO/A+jxkg8NaKs2bQTAklpCTfNo0fpHC/tQkUgg8=;
 b=YAPqqQs44MO2Sh3hQmGnsTrLQ3FvSUuir0Du4Lr4hlhAbJIY4MasJcezwkfK7lAFRk
 MWCbheiFMvHm0gJ7iKh2ynfm5JgpKx6MSo1wY+PA+f0sLVqQcK6FItzed81+W+MgM3C3
 cDnmMBuT6kxH/cdry2nkHci/AcMn7CA+UYQ1O4gNTOSAsjRexXQLFurPvad1xWM/aS5r
 G6O1rFogOwDjBMiOQtOcrWU+/g1whJ0CRbwgmoKHmKsQdbnZCsCGaI6KkO+RSWsgijAQ
 A5lznr9iEw3dhG510Hj7evZwUlfJ5PGbqwaZ6s+JYtKWfmfEPdGVBYLFniRj2uqz4wiF
 mKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792528564; x=1793133364;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVXZO/A+jxkg8NaKs2bQTAklpCTfNo0fpHC/tQkUgg8=;
 b=yIGJ7r56DNYa9ojpzmfEwjR+bYADOCpO1M8Cumk1CJ3D6rIxLKOXDOZRg2ZcIixst5
 sYYAzMdUbc0qGy6ongcaa3r+wBR8a3z4gkMB8fSshHEhMRaJCZJfidgq2U1IAicx9p1Y
 7ovTrCGjCLbnDCuAX2X2S6TznbhG6L5TwlqDPeG1RtNAQLeEBTd16oMHqckOUDcclNWo
 irgrNlfkp3ZdBGYJfSFHuACikVwIof0zFLNhtTB7dijY0v3Qe2z6KyxLaF7++zpzvafc
 hg9flqlQU7wkvQv/3imyzx4NifMtm2cUIOk11tt9za03nB22HalOJfrzZxj4g68SQQOQ
 B5EA==
X-Gm-Message-State: AFq9FYJfgJEMlFWirJk/7FtRFmi1d7sjw0AzT3lujuAs7o6flxdMbpwb
 9wUV26gV6MktucPCKcoD4DU2BEpIZ15CEPBaJf1ma6pXVh6lcN6Jx+0W
X-Gm-Gg: AYBFou2CNo+xGwDaVHTYAGFIq3TbnleHorTWepg2E6VMs+XrfEyPwfp0hGhSQO9ugZD
 doflOXNs5sZsTbaU4l/6dsxtEvV9onBkI3XuM+NGmkR56KbYfZLvmq0DMzPfwaQnIUbvjjvO93l
 Dm+bVlXsDZNJ0e31QvnLpu1ELBm0n1geILjnV2eq4ow3A50nZsKKu1cnDoibKVvxcs7gy+L3yAC
 ZIXkrKPAcx3SGHax9a6XgviLPeqwxdnEhb586oOdXVSytAcEy6y7fSuwvkFAEbR1WuT2jer9Rs9
 +n9/nBu+O4eo+UAALl2XJn61rIUuIZ891NoR6o1mmt8id8lJGPX1As7Rfa9G9JWJInnXyKOcmmI
 vTAlGUr6ubH1T7L9G5fjlqZxmCSYTNDrvg4/4eDxp8iwOjDpXRYA6sLqfIfnbEyEuCVc7+Qqcpp
 +7bALbPYOJYN/XsSWaE6FhDBfke6JdFkTsE+3hOUXJQ7nYgHm1WXWmvbF9dH6gPgtRPLg4swlkA
 UkZ
X-Received: by 2002:a05:690c:dd4:b0:8ab:4b1b:fb06 with SMTP id
 00721157ae682-8b13417af11mr280357b3.27.1792528564297; 
 Tue, 20 Oct 2026 13:36:04 -0700 (PDT)
Received: from [10.138.10.6] ([149.102.242.31])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b13012f91bsm2778267b3.34.2026.10.20.13.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 13:36:03 -0700 (PDT)
Message-ID: <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
Date: Tue, 20 Oct 2026 16:35:57 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
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
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sK03UOIG0EDQkwf2QJWXaQ3T"
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
--------------sK03UOIG0EDQkwf2QJWXaQ3T
Content-Type: multipart/mixed; boundary="------------TD0b06sig68BTEnu8cAFXkDk";
 protected-headers="v1"; hp="clear"
Message-ID: <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
Date: Tue, 20 Oct 2026 16:35:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
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
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>

--------------TD0b06sig68BTEnu8cAFXkDk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/20/26 11:06, Mohamed Mediouni wrote:
>=20
>> On 20. Oct 2026, at 16:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>
>>> On 10/7/26 12:29, Alex Benn=C3=A9e wrote:
>>
>> (CC trimmed, IOMMU relevant maintainers added)
>>
>>>>
>>>> Hi,
>>>>
>>>> The KVM/QEMU community call is at:
>>>>
>> <snip>
>>>
>>> Is this also for topics related to KVM but not necessarily QEMU?
>>> If so, and if there will be people who are familiar with device
>>> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
>>> faults are recoverable.  There is a virtio device I am working on
>>> which requires this to avoid either crashing the guest or allowing
>>> the guest to hog host memory.
>>
>> We didn't get to this at the last community call. Is this something th=
at
>> can be discussed on list first?
>=20
> It should be I think.
>=20
> Hi,
>=20
> For such a virtio device (and granularly exposing it to user contexts t=
oo), is ATS + PRI
> a good choice? Perhaps even using the host page tables directly, with a=
 per-process
> abstraction as the security boundary.> > On physical hardware as intend=
ed, outside of the ATS + PRI case, IOMMU faults
> are expected to be something requiring a device/driver reset. On Arm ho=
wever,
> there=E2=80=99s an exception for the stall model, which pre-dates ATS +=
 PRI.
>=20
> A PRI PPR reply of not present isn=E2=80=99t equivalent to an IOMMU fau=
lt and isn=E2=80=99t expected to
> result in a crash resulting in a device reset.

I have two concerns with ATS + PRI:

1. ATS allows a device to bypass the IOMMU, and my project relies on
   the IOMMU to isolate a compromised device.
  =20
2. I need to support both consumer and enterprise hardware.  I suspect
   that ATS support is very limited in the consumer space.

For more context, I'm working on a device that allows a backend VM
to provide virtio devices to other (frontend) VMs.  The backend VM
will often have an assigned PCIe device, and there are applications
where zero-copy I/O would be very helpful for performance.

However, when the frontend VM exits or unmaps memory, the memory
also needs to be unmapped from the backend.  If this is cooperative,
the backend may simply refuse to cooperate, causing a host-side
memory leak.  If it is preemptive, the backend will take faults when
it tries to access the memory that has been unmapped from it.

One can avoid both problems by only letting the backend access a small
buffer, but this requires a copy in either the frontend or the device.
This might make the system uncompetitive with host-side vhost-user
devices in high-performance applications.

Is there a way around this tradeoff, or is zero copy incompatible
with protecting both the backend and the host?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------TD0b06sig68BTEnu8cAFXkDk--

--------------sK03UOIG0EDQkwf2QJWXaQ3T
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrX0K4ACgkQszaHOrMp
8lNnqw//fu34G1ZtoYaUZagzAysNd4DTWd4rlf3kU18JsF1S15ah7FJwYUixp/E8
vWy+HXbNLJEmW+OevjVlTdln8aVcpnNROPgJ1F4IDa0ZBNXai3QRnIIq0X1JSNqr
XQ0l7bru20reJUQplFam87B4SVKIGvLVRMMxjQctfq40KiwwgbLIw/fyDAK8FayG
g1J/NUgjFkTKRFnLDspeiZBcUix/JfpSqw9fuKWizZuTapeFcohpu5lONQsXzP96
whjIAXq6/739wwhRlNALo5z0A6OeeAKPCmZSeUf2PzSxJfi4PLWeeeUydO2d7Yum
usYsHxWsl0WUxSh7TA4q0+eQODrHmeU48IJZp4RcFptbTSm15/ws3WXyd8CWCrpk
YsHTi0C9n7WPTNszhLzjgWLwGZyXy1ix/zsWKDe60ZJzIp0/yhO02rSCEMjfxT1F
3cOnQCIJIa+CSte6BLaNjxE0VI5Qr5eC6K88Ge5VXPPDjL6qdSMiO9wZvVbUrdnt
J5wkaUwqEM7R319NzP/xlZbDvYdBuLKrSjXDDGCwKoxelRduE5rxD5zpEUGxAWQE
AusJ/teOmxtfIsZFaf5aD8zhaEKPDacVDGKibN9zNQhEH8/EGXaDwdr9UVB7Qze0
otqez2j02l0civkLm3RTdzA0x2IcX5SpiO1CFR3p/Am3f44aMZI=
=mncX
-----END PGP SIGNATURE-----

--------------sK03UOIG0EDQkwf2QJWXaQ3T--

