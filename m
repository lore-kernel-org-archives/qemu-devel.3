Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57B5103A9AC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5MIo-0006EU-OP; Wed, 25 Mar 2026 07:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5MIg-00067H-SE
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:21:28 -0400
Received: from p-east2-cluster1-host7-snip4-2.eps.apple.com ([57.103.76.65]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5MIa-0008Dr-37
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:21:22 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id
 DB3611800BFB; Wed, 25 Mar 2026 11:21:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774437678; x=1777029678;
 bh=bJA+iuHctjTO9s1GECU57d6RXVIn/v7fG5rhnfeDQ6c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=BkUOZPYaR6wRUDuWAxey4+2NNFcebSgEdjjBzZJmeW1z7EcfldHtWWFooZCL0nRfN7juzxdMXoRGR55sMduxxj2OTMA6oi2H64GzWpWdeAngM/rbrnVit2GBC0agdmyHIoQxwDdEqBqwJDyoAGqNHv5rjYa5JAPLZRUOIqIMh9VL2ueDUNlef7tUkS/NJ1MZlco56z+Zr3JIF+36YDzsWwFORpDqA1xMyRO8b6VKjBeGFQv+yaKdaUpT0BE/23+BvI4WakPW8ZCIGOMJj3mKMdNKZ1MOdJy13qTG7sWb/fElbuaxZOHlG2MB1FWYoxu1FC2Z/ffNcUj5UtlwALvWyg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id
 F2DBC1800E8C; Wed, 25 Mar 2026 11:21:13 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH v7 7/7] hvf: do not merge: enable private ISA
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <9cf3d5c9-32eb-4944-8fbf-4775e1cccecb@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Mar 2026 12:21:01 +0100
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78785F86-CA85-4187-93A6-1D9852263964@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
 <20260324204855.29759-8-mohamed@unpredictable.fr>
 <9cf3d5c9-32eb-4944-8fbf-4775e1cccecb@rsg.ci.i.u-tokyo.ac.jp>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=II8PywvG c=1 sm=1 tr=0 ts=69c3c52c
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ADnFLmdGAAAA:20 a=bWGPkEa5fn51Ohx-lacA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4MCBTYWx0ZWRfX+iqnFjnXmpeM
 6nCtyxReJ02bxm/CF6vpVAr8JTaL4/kHxneAJnrTI2UCiWA7hKzFJgQ65h47JCqX+5r0GdyCw9A
 LugWT3BHyPTtqlWbMiYM1WyRZCN3sTgi+Bu8ODV2fbWVl2tTreEz6aiWgCi3UEP5KbvnemZvnte
 QSWExMBwsaU4TvaGSL7Ooyf4AlNcSJxcMIWG9m4YV24xyV6cxWrCXMrnm3Q5fmhnEpTR2N0QmGi
 BXED7m1Cm4FtEiXps8SDEwt1SFAPEqkCIwjQyPMfzdr/o3ow6Jxy0wwgtoG3uSVuv0vCA/E14Dt
 12ueoTqtzfJJDFaXBGZ8Kq2kkiBs4VXme7ZcIzotYEN0GnoSLF90eZCvH68dqA=
X-Proofpoint-GUID: 3IxXWuu204Ri1zXLTvM1fnOTaWdetOUW
X-Proofpoint-ORIG-GUID: 3IxXWuu204Ri1zXLTvM1fnOTaWdetOUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=719
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0
 clxscore=1030 suspectscore=0 adultscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603250080
Received-SPF: pass client-ip=57.103.76.65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 25. Mar 2026, at 12:07, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> On 2026/03/25 5:48, Mohamed Mediouni wrote:
>> Booting macOS Tahoe.
>> There in the series to show that's all it takes, but not
>> mergable as is. Testing this requires SIP to be disabled
>> and AMFI to be bypassed to be able to launch the executable.
>=20
>=20
> This is interesting. Do you have any idea what is the private ISA?
>=20
> Regards,
> Akihiko Odaki

Hello,

For the macOS vmapple target:

Apple PAC is paravirtualised and not trappable by the VMM without
patching the =E2=80=9Chvc #0=E2=80=9D to something else.

That=E2=80=99s the only private ISA bit being used there needed for =
boot.

The documentation for those HVCs:
https://github.com/matteyeux/darwin-xnu/blob/master/doc/vmapple_pac.md

Apple briefly pushed that there, and open-source XNU has that code =
present.

When private ISA is disabled, instead of the VMM being able to process =
those
HVCs, they return an error code and the guest dutifully goes into a =
infinite
loop.

For the vresearch1 target used for PCC VRE and iOS:

Bunch of private ISA used there, including GXF. Private ISA level 3 =
isn=E2=80=99t
enough to boot those, it wants private ISA level 4.

Thanks,


