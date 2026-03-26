Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F0610A1E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5iuE-0006ye-9H; Thu, 26 Mar 2026 07:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5iu0-0006xa-AZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:29:29 -0400
Received: from p-west2-cluster3-host9-snip4-10.eps.apple.com ([57.103.69.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5ity-0003Ul-40
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:29:28 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 4862D18002B9; Thu, 26 Mar 2026 11:29:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774524564; x=1777116564;
 bh=cEkf88vrjYJ2D4dHZMjvUkr12OVbGNtZNCFcAWB+Uk4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Ii9Sm7mLyw55kI878ospD77uggXnJOq39onnZexOYY53WyijdVnYQ9i7IWuoB8wWzXFWExwTEb1eFWVRszflqT1lVFkQwusTJ6OTenLUfQXiJ1ikZUGCDjvSbSMj05sGrzy1eXxmcQjV/RR3EZ+zWCbgbaf/gjwZ+kK3GhGWpNYWhR8Xv2okbv8PbO7Ls48aIacHGART4jWAVuJr/Sp/g+I1JaGHlCmzTVTFBN1qh/kj1LVhyRDlJwezxFfIhELHl3ckm43gfULUvwFYgrAMXnJ8XPdZWn1abENQEhNJ699eWvVxgtBwsEBEjA1YtDqeXOU0AIpnA3L+Fq4Esh2TIw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 C1C9B1801C58; Thu, 26 Mar 2026 11:29:20 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
Date: Thu, 26 Mar 2026 12:29:08 +0100
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAD6E043-B77B-478E-91D6-863B0E185CFC@unpredictable.fr>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
 <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
 <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
To: Mohammadfaiz Bawa <mbawa@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: -U_7kk1a54YL9w4kChjJvkibyEXvkwHL
X-Authority-Info-Out: v=2.4 cv=acpsXBot c=1 sm=1 tr=0 ts=69c51893
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=J4KwwQuTGy50yuDMXiEA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-ORIG-GUID: -U_7kk1a54YL9w4kChjJvkibyEXvkwHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4MCBTYWx0ZWRfX18TPm0S8utCR
 9wqPAkLhTWnpVtahkdOsr2iZLGn9vVzI0/1E4nCS+wUMcNMmIJYjNC42nsTu5h0Akap0wEFRLeR
 p5B84wBYJzVqywvdUcGrNAkyu2NgjDPhCPjYElKFZygJkUdjso+JhhSftCBNSu2qw7PkdXV5eSD
 uQIZJ5fdrMqkRkguWnpRV0k2aB4HhuCusM7BRc1R2BYU3Ios+SQoyzBScWQc3UE+375PYVXFpEq
 AE3W1IcKggqOBGKALlcHzhbSfqhasG5vH+RSKOloOx3fRV/NZJ9EVZSKsyntq0dES4eEHwULmeD
 AJ5VoLJVlTp1sY5QEHtGA1mMfxp7gpJzlfcTW2VUMSqEHcypm8XzQ7eD8X17sY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1030 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260080
Received-SPF: pass client-ip=57.103.69.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> On 26. Mar 2026, at 08:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>=20
> On Thu, Mar 26, 2026 at 2:01=E2=80=AFAM Stefan Berger =
<stefanb@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>> On 3/25/26 4:22 PM, Mohamed Mediouni wrote:
>>>=20
>>>> On 25. Mar 2026, at 20:31, Stefan Berger <stefanb@linux.ibm.com> =
wrote:
>>>>=20
>>>>=20
>>>> I remember having played around with TPM for QEMU on ARM64 =
(Raspberry 5(?)) a while ago and had the impression that there was =
something related to caching that prevented the MMIO interface from =
working correctly and Peter may have confirmed this back then on IRC .. =
I am not sure what exactly it was that didn't work correctly when run =
natively on ARM hardware. It worked well when run in CPU emulation on =
x86_64 for example. So I am wondering whether there is a minimum =
requirement for an ARM CPU or ARM CPU features related to caching that =
someone needs to know about to be able to use TPM TIS successfully? If =
so, it would probably be good to mention it here as well. If you know.
>>>>=20
>>>> Otherwise this looks good to me.
>>>=20
>>> Hi,
>>>=20
>>> There are two things here:
>>>=20
>>> - For Windows guests it=E2=80=99s a bit complicated
>>>=20
>>> Windows guests LDP accesses on the TPM register range which =
doesn=E2=80=99t match ISV=3D1
>>=20
>> oh, yes, right ldp instruction.
>>=20
>>> syndrome requirements and needs a workaround in current QEMU.
>>>=20
>>> I _think_ the QEMU-side workaround described below went in, which =
is:
>>>=20
>>> If we map the TPM register range as read directly, trap on write to =
workaround
>>> usage of LDP then we hit...
>>>=20
>>> - FEAT_S2FWB
>>>=20
>>> This is part of Armv8.4 onwards officially* and allows KVM to force =
a device
>>> memory type read to be promoted to write-back.
>>>> That allows the (easiest) workaround for (1) to work.
>>>=20
>>> However that=E2=80=99s not the _only_ workaround, you can remove it =
and include
>>> =
https://patchew.org/QEMU/20260317174740.31674-1-lucaaamaral@gmail.com/ =
instead.
>>>=20
>>> That works fine and removes reliance on FEAT_S2FWB.
>>>=20
>>> * some older Arm chips implement equivalent semantics without =
signalling it, but
>>> that might depend on SoC-level integration.
>>=20
>>=20
>> It would be good to mention in the docs what the user needs to know
>> about CPU requirements, if anything, so that it can actually work. If
>> these recent modifications/patches make the TIS work on any =
processor,
>> then there's nothing to mention...
>>=20
>>>=20
>>> Thanks,
>>> -Mohamed
>>>=20
>=20
> Thanks Stefan, Mohamed
>=20
> I wasn't aware of the LDP / S2FWB angle, appreciate the context.
>=20
Hello,

> Looking into it, the FEAT_S2FWB requirement is for TPM TIS MMIO access
> in general on ARM64 and predates this series.

Yes, it was added as a workaround for baseline Windows support.

> The PPI region we're
> adding is RAM-backed (memory_region_init_ram_device_ptr), so it
> shouldn't be affected by that issue.

FEAT_S2FWB is for the case where the guest tries to access as MMIO
while the memory region is RAM-backed.

=46rom a quick look at the Linux kernel driver it does a
devm_ioremap_resource which assumes MMIO in drivers/char/tpm/tpm_tis.c

Hence relying (further) on FEAT_S2FWB.

> and for our testing we used an Ampere Altra Max M128-30 (Neoverse N1
> r3p1, MIDR 0x413fd0c1).

Neoverse N1 systems with the Arm CMN fabric aren=E2=80=99t exactly the =
right
system to test this. They don=E2=80=99t advertise FEAT_S2FWB but =
technically
have equivalent semantics.

Once the ISV =3D 0 syndrome support patches get in, there=E2=80=99ll be =
a nicer
way than relying on undocumented support for those semantics or relying
on FEAT_S2FWB without querying it, by switching those away from =
RAM-backed
to an MMIO trap.

Thanks,
-Mohamed



