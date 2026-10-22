Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yh91x6A2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJhT9-0001IP-HX; Wed, 21 Oct 2026 21:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xJhT6-0001I8-A1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 21:19:45 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1xJhT4-0006GP-Mh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 21:19:44 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ad98c3fb15so11859777b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792631980; x=1793236780; darn=nongnu.org;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zllu7BH4v9fEohd6QH5qIqfDwrDSFIIV6xVx/TB6Y8I=;
 b=Yh91x6A2WFFUQWAQVwT/mO5TvlgFXt9q5iHm66eFVv9cCogLrStlzlteLdInrLCYA+
 fTmpRdbKD6QrY1btx1Ju0k//yghQgKwFWwQKYxIys/S8h3txcUXbCU9OX3p9QdDqoGTD
 O7JE0wCTZ0qRwlkzGP/n/gsV0+/WY6YPXIYDkWnn6CL30vSDB5hinzv14rzl+Sa97j3R
 /c0OX5vNzczn5Ay4WvXeE23Ids7NY6bKLOa85KQBjawTHUAH+GwIb/mI7HmcaSH4VjU1
 qk3gQnRwqRsyOII0SNDPRqqkip0P0wLhmRB/60i0jpL27QrmJToY7tKE1DQwb+HQNPLx
 0a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792631980; x=1793236780;
 h=content-type:in-reply-to:autocrypt:from:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zllu7BH4v9fEohd6QH5qIqfDwrDSFIIV6xVx/TB6Y8I=;
 b=jPutsPMnkjMa+U4ZWoDPod5ZdE8o2cFUJUWqf5ySJ1TIiC4boknJIX4Yyxkuq9cPL0
 nzoquG9pEozM7sw4BJL3q6C0ZU0gQQubo2Ns2iTDXh9uNFo4j39I6lrR/RPwMDQVEfWC
 ujw4c/UtO6XLkuWkAsv2ZIxVagfXOsEJJ63GqsycxlRNOUcLu2onHYUYYhP7coN5Sgny
 51Voa1v9ioDpxdhR8+tivlYonGIjC9VWpGJxn8eF/qxzQzNTPtjp3pfCmTybEcbFa2YU
 QNa5D9KqryUZzgKY0Q1+5V+YefQA43UbQuycq07Xd3VfkE7aV1xQ0m4nmvzkE6j+trzJ
 6nhA==
X-Gm-Message-State: AFq9FYL8r86zQyoygHQ6flPdqHzTCQqbeghfh+6dEpiZuh2jDqRSmHfm
 e7Oa3SbXPpGIl75ld8lTy2YSkfT8V/bBTUwhHe4iGP1PFMN1MpueYGbx
X-Gm-Gg: AYBFou2IeB2D+sqzwUT/uwI5OHY/yC1Yv+gRd/7e7VSEXnD6RQtB2AMog3zhKetcWMl
 BW+j/agSnR+bu6phfnfiRzO5yEKXgHws8poCl//GvEFZkWiH2dMJVWttJVk34kicQVUuZZvTPW9
 B9hQYQuR2IyA2s7tfv6xMWBnz7/8SgZEMtvs/BLwVYM5NgF35TbudQhdlKaEda1OUWNfr4wq1gy
 DsyU7zBMBKr9f958DTNIjyuk3QwgG2XL2WGbaySO6IFWc75fM/2f1X92Es1MiHS9qASonsnMSYF
 czG6lVthtw+J/OCAvzlzfKG2PbASBpx+MGsyoqmg9AHLA8cBnf4xK8vD4CzUuRXCblJc5i4tLx3
 AEhkooRVV5ml1lF4eLuUUkIlTp2Cg+lHprPFZeP8R+lueSUIYMTEPT70v7UcsApUHXEu0mtBD00
 rNdh33uM4yUT7+yQ/SM/n8Wrb6nr/GAPYMQYa8+44maMoliNh4I2VK47s7JUlpuLYcCV68lgLWC
 47TBJ/2gpqdywILGbGCUe0ezKzKWom4013vClO92ahm3OCctkmMUnRmyNQ1
X-Received: by 2002:a05:690e:144d:b0:679:c43d:1ffa with SMTP id
 956f58d0204a3-67a0e48571emr2323361d50.40.1792631980452; 
 Wed, 21 Oct 2026 18:19:40 -0700 (PDT)
Received: from [10.138.10.6] ([149.102.242.31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a0e185441sm1945622d50.3.2026.10.21.18.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 18:19:39 -0700 (PDT)
Message-ID: <1a4451c6-b5c6-453f-a9e0-27514bc8b833@gmail.com>
Date: Wed, 21 Oct 2026 21:19:35 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Yi Liu <yi.l.liu@intel.com>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
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
 <5f15a11c-a564-4853-95f2-630405287b62@intel.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <5f15a11c-a564-4853-95f2-630405287b62@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n1ZIbgGX3yyXZ1I8PLsfM0fj"
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
--------------n1ZIbgGX3yyXZ1I8PLsfM0fj
Content-Type: multipart/mixed; boundary="------------z3037Ai638iRMVBeg12hqBSN";
 protected-headers="v1"; hp="clear"
Message-ID: <1a4451c6-b5c6-453f-a9e0-27514bc8b833@gmail.com>
Date: Wed, 21 Oct 2026 21:19:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Yi Liu <yi.l.liu@intel.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
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
 <5f15a11c-a564-4853-95f2-630405287b62@intel.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <5f15a11c-a564-4853-95f2-630405287b62@intel.com>

--------------z3037Ai638iRMVBeg12hqBSN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/21/26 04:18, Yi Liu wrote:
> On 10/21/26 04:35, Demi Marie Obenour wrote:
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
>>     the IOMMU to isolate a compromised device.
>>    =20
>> 2. I need to support both consumer and enterprise hardware.  I suspect=

>>     that ATS support is very limited in the consumer space.
>>
>> For more context, I'm working on a device that allows a backend VM
>> to provide virtio devices to other (frontend) VMs.  The backend VM
>> will often have an assigned PCIe device, and there are applications
>> where zero-copy I/O would be very helpful for performance.
>=20
> curious how you let the frontend memory accessible to backend within
> a VM?

The FDs passed by the frontend are mmap()d, and the regions are mapped
into KVM.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------z3037Ai638iRMVBeg12hqBSN--

--------------n1ZIbgGX3yyXZ1I8PLsfM0fj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrZZKgACgkQszaHOrMp
8lM8VQ/+NVyqWBER/dqTEsZhJrCzm9jDwAqJixU6rfAlispyf47UjOKnSk2sk1dY
o7oCWnB6YnfKqyXuQA3Qgr1pdllxq9jo5jxDFXLD12cJO0m38jxEeZscSPVyEmql
yzKFN3R2MM9a8lL6kUfjDERQOz5dkqAdvrqYlGcI/uHVM0LA74i+K+QpD/V4VRVv
htnVcc5We0gStST1oXZGKmzgWw+GcKyZLTcA2kvZT1Ugi/bHBSCfAN+BPz8uqAtJ
mndLKC6UcpMDS5wKtQF8qvDo0aDRq1aUBdZOtBzqBS0itKo50HrU6WiZOZBg8NEF
ifn/N9nmeXwIgKyQoee5ZHN4DO8y13y83dwU7twny5n5V+JLmbjuRt+MDy/ZEew/
yukqWtCca71yl9cZX/BglkLY+x+T9NLErXmxCZ/h3K0WS8NZXjU5KYf0Gtyu+QSs
IZ18GWoxryTO4iBPb9Qv8diT4NM2kIKyDRx++zXj3rH27Jjd7WdnmWYlfkCEzXIu
pqNcQj9znL/1m5+gNaH98pLVi2dt2wgFzPH0eUDJ1Aj/vtVSzCvw7JIUlyj6tkf8
MKO18b0HcnejUesaKICYcqkqctA29jUUw2qByY11pPRBhvmJyNl/mWUhbZuK7M43
wI2koT3j09nlDarJWoUGw2XDHSkHVkixfqE838N4VufSPnoy6jc=
=OycK
-----END PGP SIGNATURE-----

--------------n1ZIbgGX3yyXZ1I8PLsfM0fj--

