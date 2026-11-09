Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C3606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Tn3asfRp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDSU-0005zu-8I; Sun, 08 Nov 2026 19:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDSR-0005zB-Ho
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:59 -0500
Received: from ci-2004i-snip6-11.eps.apple.com ([2a01:b747:3005:204::5d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDSL-0006QO-Jo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:56 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPS id
 B9E191800135; Mon, 09 Nov 2026 00:41:49 +0000 (UTC)
X-ICL-RepId: 01a1bdc1-134d-7420-ba6a-72d5d266e3ef
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXC0EJPQFadSkfRAtAd0ADL3RGFEB3XwZGczZ/PHdVdS8CNQk6cxhZG0AVXRFQGVYJXhUXHkFTFx9LAFxFUBhEH10dZhxcAFYCXA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184911; x=1825720911;
 bh=JtJX+H/4r4ZGa8WmmEX2cQSecTfEprw7NL+js8/GXkY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Tn3asfRp9a3Zayo4Z5yO1zWXuzwiVenjEoteEgjSQ8imbAAKE9UgwCC3BOV1lhOw4smnusxbCoPmbMhFKUYHJYj3SrrnC0b+L2+IlfPKd/eKULoL2wRypG0KGYD9RG7HwqD2tXCGx0/NUPt7Mby8NdGdqHR5oRuB15CL+6wMugvCa+OufzrDqu4ZF7El8WpeSllSG4+OoY3+LcUEX9/EtQcnfO7vrGdtSce3v0o84PAMLFGYLNbq0XEA16xsdvQmUi0Aq8CJ11FSXCDiucTVjNoGgyZ9r28TevQ25X57USmw+WjzXOReClV3K9LVsGoNR86HWwvpK+igA82NsV0P0g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPSA id
 CCB1A18001EE; Mon, 09 Nov 2026 00:41:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PULL 00/13] Whpx fix 0 patches
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <87ik27i1vx.fsf@draig.linaro.org>
Date: Sun, 8 Nov 2026 17:41:37 -0700
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <910E27BB-428D-4DF6-8D21-AFFDD8BD0E0B@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
 <87ik27i1vx.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: quiGGI8YiaqY_vVmqjROorMIvGF4ZDb5
X-Proofpoint-ORIG-GUID: quiGGI8YiaqY_vVmqjROorMIvGF4ZDb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX/6z0sdmiYUZU
 8WJUky0VD+Ac46hGpVdjfOPTWEbJITYE7HLtpMLqMSerd9avAbFQqNULRDGLGjMcuUojsUtaaDR
 yMRMIf8//tJFB2bBsgMLfTvVbXVDVOOWVxeaPpa6wjg6AHEmxt0ut0NuDlch6+CC8gzax7NO4zw
 oOJgpzTgdGeCdDJHET4kQDpvDc9aTXZNG76xlqE8QoiMbAFmGFfDGCKYYI6zyrrwdTmkTPG0c3z
 NVOm1ZrzNx2Lc2D6ogQpRm0hxppZo4JwrBigEm0hw4VZgLx1Npd3sVGSmaZ4APBoFLAm3lEKTQK
 nYlKHQSHC0Vr5FVEsW+LqZQXt+ULzKnRW8tHM3RrGisI9s9mxkQ4AbSMJwYRUg=
X-Authority-Info-Out: v=2.4 cv=TLdIilla c=1 sm=1 tr=0 ts=6af116ce
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xNf9USuDAAAA:8 a=NEAV23lmAAAA:8 a=ID6ng7r3AAAA:8
 a=KKAkSRfTAAAA:8 a=pm2JN4saWKRQQ0Hh5qUA:9 a=QEXdDO2ut3YA:10
 a=AkheI1RvQwOzcTXhi5f4:22 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABixvhjEF2gXhmnzRi1OdkCHjql3mAtG8tib+1KFhoRfGMTDrRMD3aPp7FV8fhtI
 KnYnke8a4zuolwJ4hyEVEVILshlCwB8P6pzCyorFvU5XxRbdrCkoyBuDMaXD/8jGreDB29
 VpG5syFTBZHP6D5R87Z70XSyUlYq2MMt20rUTYkI1ddD+xb6w/nhTqy6auCYMGa9i7quum
 IiistOVYRVntb4TSMM3DBLh+M/SbKBWCjm64vOrh5u74JpKGYX0LAfL82FcAahP1W1wibc
 GY35w2ady2B76RG6ERoBePIeTY3NnX+3kPzL6fqWMm//yU3oM24dmu/ibyZualge78zwvB
 heP5tq78ELx/IFMcunhXpQurbUqIywKx1CZJRiV2Xxe7JPgDmmWaTGWz9CX5KORoa0kuHb
 I7sQ9QXcKgOBMhdRe4TRpB/0DTL10bo9vRSLGqF6OgaKdrh9r/fRdWYohNl8aNxIxDn/b+
 hqNS/GAPhz3xXbPFmF5pjagl0YJ5k5PjCb1V9XJb7k5VA//2g2qr9iMHw4ehQ3gxkfcjIu
 LKSWx/rE4F/J+g4dZGgyl+B3Ary3CHfNXqlIBfndx3FHKWZJX8qR59Dv9NICR0W2qBfVAu
 iOIzZLuNmyGLGBWDFlvCZd/HFFOOXmSNc3AWWWeed/gtlxTcucbpzJh2sHwY5YOzu5b9qp
 sX4YlUGBdCSvMAZdJOdcPj0+Rfn76faLd6TqgetTDMJUd6Fj0inIAVo5rz/F2D3a1Payzv
 J56MFQ9n1R1pKwwkghT5EaxkEdbc1t5G8Yi8k9OkiLb2hUpGwXv0B0xOEqYZODFoQ9E0S8
 1Gwn5EGuzt8BDQ5TA06MRgUBAPZZQF0ec5xwLmM908h3JWLIa8jUQ1ilY1x/7nrhqHDkhY
 uwR4904h1FSqsCo38jczQTNVqaxmSVMI5SNf5ILXw9NW6T7CCyKttMcuzilimlhqIbAYm2
 j5hYIHDp1TwLInQ3Xc1LC2BDNpXLew85C0G9bgfQOqKs8cRSNm7gglIREz2PKKIXohdt96
 XCU9grwwe2fB3YoTBjS+/BpJRQ+Yc44wTFs3V9S/EgulYTmeCp4ZXPbxjK87cJ5HkKvbel
 jmqNjRv5rm2fM910wmBQ0uV/XZARisGbf3oNGrcjq6ZsOsYOo0reu4bwCAxst/WoaVC/s1
 4+D6ZqoSF5DxIzsO0G7tnEtatQMBThRmyRnuFZkLB+tdi/STxq+HbWYjdgolwOYILRGDE/
 uiCPbUhRRYTi5rmesx47kafvigWfhv6MPtJc0dEIjS0A+zdvZoiPVtLR9CJziFLfhvzu+B
 gYV1RVq8Q67+bC5BMcGsMtShYhEcMBFsR5jOLDcGhRuLiErthAw1f6M9EXVrNcM6VZAQT9
 2097/Jycea3ome/9WVBfjWB1UJ1v6lRFEkq4wjUB+HQ4BtMEZF+DSGXFy7XquIYnYQikmO
 n3
Received-SPF: pass client-ip=2a01:b747:3005:204::5d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 8. Nov 2026, at 12:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Mohamed Mediouni <mohamed@unpredictable.fr> writes:
>=20
>> The following changes since commit =
d73149283205645625bfa9fe029cfb68e4c4a9ae:
>>=20
>>  Merge tag 'samuel-thibault' of =
https://people.debian.org/~sthibault/qemu into staging (2026-10-24 =
16:09:37 +0200)
>>=20
>> are available in the Git repository at:
>>=20
>>  https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request
>>=20
>> for you to fetch changes up to =
2bf35950b54c1db9a6de6eb47b42cf843c6bd282:
>>=20
>>  whpx: i386: also save debug registers (2026-11-08 02:48:18 -0700)
>>=20
>> ----------------------------------------------------------------
>> whpx: QEMU 11.2 pull request
>>=20
>> This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" =
patchset
>> with fixes for QEMU 11.2.
>>=20
>> These include:
>>=20
>> - fixing reset
>> - CPUID fixes (leaf 0xd)
>> - handle systems where nested virt is advertised but not working
>> - xsave fixes
>=20
> You need to apply your s-o-b to patches you submitting in a PR:
>=20
>  =
https://www.qemu.org/docs/master/devel/code-provenance.html#subsystem-main=
tainer-requirements

Hi,

Sent a new version with that being addressed.

Thank you,
-Mohamed
>=20
>=20
>>=20
>> ----------------------------------------------------------------
>>=20
>> Akshey Taneja (2):
>>  whpx: i386: do not require ProcessorFeaturesBanks on legacy Windows
>>  whpx: i386: fall back to xAPIC when the MSR exit bitmap is =
unavailable
>>=20
>> Boden Randin (1):
>>  whpx: i386: avoid updating hflags for vmexits
>>=20
>> Doug Cook (1):
>>  target/i386/whpx: fix VMX capability MSR values
>>=20
>> Doug Cook (WINDOWS) (2):
>>  target/i386/whpx: whpx_get_xsave_state error handling
>>  target/i386/whpx: handle processor reset
>>=20
>> Kostas Chatzikokolakis (1):
>>  whpx: i386: forward the dynamic EBX of CPUID[0xD] sub-leaves 0 and =
1,
>>    not 1 and 2
>>=20
>> Mohamed Mediouni (6):
>>  whpx: i386: get APIC state before VM save
>>  whpx: i386: fix TPR encodings for local APIC
>>  whpx: i386: save/restore xss
>>  whpx: i386: make nested virtualisation init failure non-fatal
>>  target/arm/whpx: handle processor reset
>>  whpx: i386: also save debug registers
>>=20
>> include/system/whpx-internal.h |   5 +-
>> target/arm/whpx/whpx-all.c     |  10 +-
>> target/i386/whpx/whpx-all.c    | 307 =
++++++++++++++++++++++++++-------
>> target/i386/whpx/whpx-apic.c   |  10 +-
>> 4 files changed, 266 insertions(+), 66 deletions(-)
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro



