Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=bXNlmp6c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU0J-0001BD-9b; Thu, 29 Oct 2026 13:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xMU0E-00017S-HQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:33:28 -0400
Received: from mr-2001d-snip6-2.eps.apple.com ([2a01:b747:3000:200::2a]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xMU08-0002JE-UV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:33:24 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPS id
 EFC36180017E; Thu, 29 Oct 2026 17:33:07 +0000 (UTC)
X-ICL-RepId: 01a188b8-ffbb-7df6-97fb-722898bef239
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkQAOwddcV10XXw9A1QaXwBDDlULXnVTH0F6PQJVBVIANHxLcC1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793295189; x=1824831189;
 bh=e3LWz86LDjxYCEhClxncJ/HYfKEkzZGYYGx7eHCW9bQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=bXNlmp6csD+bwepd15ZeXP9LcY+F6ze0flcIAUQRlOWcbyN27TSiBlkm1GdSYOpVPtywChFngefqMYgb3/V8LM6kr1UT5shBVAmF7TWwUOlHvq+DS5tamC4RTlr/5GOOA12/nVg1/kYElrdC8zkNHq7+EmLyChPvRYZH7sAdZmGLxv9Dtvv3JRvYWYFQqB2TrVu/L7BhiJcnxLuJNud8ZPSLeby8djDeJTRkvzjrFazqrkHikIoSQ3TlxX+YmFwdATsrvTCnoednb0F/Th8TQhPvlyrlAqRc/R0ydsV8oK8Nwv0bYvBK2KhoTFOeQU6xihNu447uwAZ0GTR0/kkK/g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPSA id
 7952C18010BB; Thu, 29 Oct 2026 17:33:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA8Ywq6MZxO5jt4AKay8wjWGLQYxnJ1rMkFjzoF1ppUJ3w@mail.gmail.com>
Date: Thu, 29 Oct 2026 18:32:54 +0100
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <49C40F6F-EE09-4237-83B8-1CE18292DE3C@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
 <1016C70E-8B1C-4F3F-A19E-59D7A0E66A33@unpredictable.fr>
 <CAFEAcA8Ywq6MZxO5jt4AKay8wjWGLQYxnJ1rMkFjzoF1ppUJ3w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXyya5to/N1NPT
 Q7CLLYEiI/owYdID2MyCTkIf+GSXQO41N6oyRyeTp3xbblJqxUWYty8f8i1ZZRxalwGppmNtHmP
 XzEGLird+TNTbNxDh5N72yEUDU5WxlIqQKwNoutCFwJ6/veqq+7mFtBzvxydHRd0ysv2546Xlv3
 sTnMeKPhFYWPbM9HgbyeQn5NAvQtXTZZqM46uCX75GlVVhnkRm5eIh5a/PbSciCsV48tI4Q/9dm
 AFbQYCmF6mRNm9PI1zuKQQE8BZaaufNVxTNFWU/7XZvldxw9htmlABnuUXUDT3nWHWhKmviKIn3
 q6ezJGUChumwTAL1GghKSPlbWdwgzmRZ3+9ezpY9pl1IQCVHPoaMfjDFC/64TQ=
X-Authority-Info-Out: v=2.4 cv=YJGSCBGx c=1 sm=1 tr=0 ts=6ae38354
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=jGu7mHzcN-bRX1q2kKUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Mi3_Tmux8CyVg5k_rcm3EH_HNGJVWIYY
X-Proofpoint-ORIG-GUID: Mi3_Tmux8CyVg5k_rcm3EH_HNGJVWIYY
X-JNJ: AAAAAAABA9ZON/u779LCuYjTJdxBfw/MP0dtSdUWfR9Kar8SfY/TpvGr8NG5sT70DMmp8s
 r6Pqz42fvQ+sCrQ4bZLYbkFgSyHXUoh8oWiJsUP86x4SPUt7/jr0ZapmP7Usz2s0Hecs2L
 IQ2Cbq++wNRF7z9jINue9MHSMirO72v0Lq9oukng+cZt7LYlcOrAH87VrA75vxYciqXukr
 65c9o1ZAYfzgLb7VrQDx/oCtaqOz++Ny/oWjstyEKG2SibLQrn2asyy+YjsINt2ifU8Ujl
 oJe6iEfqsIt2KA6/nfYUbh87jnVHCN8OY7fHCs/yXp2BNnX+tFI6NvvGgxAu5KhN+OPbeX
 q5tQcVoBjr+k22Mn5d4qFdx8JU1KlzkR4ogl4GOsUgpPalVAyREpGEn5t1K9VBeXgvZaDD
 slXFO1yHME0f+6HPaG7ghi6xS7kuUTfUGN3c71obcCNAOsprV1ZaTBjp/GGzkuOMJovWZD
 T0X+jgIcKmmnm+jYItf/2i6PothxzBBZIkz/vHh6EXhqh6XIQu2rqdHWJXv30SBDL+CtZT
 dGdzFU2jnHSV763OGAtrVwksilV7GtjmbEnLnxlGvfUkwQt7eWWXrelFbrECLqmA4J6+w9
 LydxZq0sSSpbq6x5A9dnngEMigEKnPV5bEFR7WpYYX74A7IhuWdUQdmGHqXjUPnfT8qWro
 8gO6XjRopdXKqbuc42myAvWG6RF6ynjKnPJ7jhJzzbK96Lh4dGHD/ZinhVPN6iVl3Ab3E7
 yZOv8wzRcBQDP32bbMhqwjVjOAVP5UJ1GHE1NjPjUAMpOnIRkLHfn4qhmQ7lXPYUV+oPD3
 P13VVEHJlm868qkPp09vmNPV/Gsk1GCS3tE/Y42Yt6dTgISzpznv8rJzNMi8QSsTToRGa+
 a1vaiYR/nMcjHaKXHONKyE7Dq8xkvgJdvNOu6iR3eYgjruKvmsh3V3Uw6fPZaBXqHkT9Yj
 4mbqxq3YsrxbgjfmziHH2rcz+jGDxjepD069ebLjHb4aPzjp1s50X+4dpN3nFSzo+JxpZo
 0FDpODwq8X0SRIcv/jJnla122Z8omalSVIkvb9OUA1G/0g19yrmrEndi3m2XBhqH2rTFRh
 10uIw2ozayomkWh4TlYlTmWmcz1pP3BWmOWLl9Wl2f5PWGtOy9AXDaHFLU3M3OImEgY0bh
 yguVw2MdhFJMsak5exqfLyTMM4+/9jOEj8wAUlUNZt5V0gXKSbJTe6kjYM38VHtx2abMaw
 I8JsK7+no88CIsy7YRNcWncqaCKg5BvTpatd7mxgoYRTVnZUJOznWBoVcVWzpTh2EAl1Ml
 0Qe33STfj37s6xliBedIUyQVRlAZDtY7amFGDHYAmBL8i89Ag46/txrgBfNAE5upCpMSWJ
 abYNRQ8DwLaVW8AkkJJmaKGO9+5wcg57+Yr5QOTrV/Qej3xnl0iZrog=
Received-SPF: pass client-ip=2a01:b747:3000:200::2a;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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



> On 29. Oct 2026, at 18:13, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Thu, 29 Oct 2026 at 17:02, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>=20
>>> On 29. Oct 2026, at 15:27, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> On Tue, 27 Oct 2026 at 12:03, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>=20
>>>> v2:
>>>> - remove GIC_ISPENDR workaround: currently under further =
investigation
>>>> - simplify SME save/restore patch
>>>> - rework the CPU reset strategy, with also taking care of the GIC =
CPU interface registers.
>>>>=20
>>>> v1:
>>>>=20
>>>> - workaround for presumed Hypervisor.framework issue
>>>> - save/restore SME state only when SME is on for the CPU
>>>> - add ID_AA64PFR0_EL1.GIC sync to advertise the system register =
interface
>>>=20
>>> I've applied patches 1-4 to target-arm.next; 5 and 6 I left comments =
on.
>>>=20
>>> What's the status with the apple-gfx compile failures on macos 27?
>>> (issue #4486)
>>=20
>> Hi,
>>=20
>> I think we should just disable building apple-gfx by default for now.
>>=20
>> It=E2=80=99s private API as of macOS 27, and as long as a decision on =
whether
>> to keep that reverse-engineered device model isn=E2=80=99t made =
yet...
>=20
> That makes sense to me; we've had the vmapple machine disabled by =
default
> for a long time, and that I'm guessing that was the biggest reason to =
use
> apple-gfx.
>=20
> Do you think we should deprecate the "vmapple" machine type, or do
> you hope to resurrect it still?

Hi,

I do hope to get it resurrected as an optional feature still, but
the issue is that it=E2=80=99ll stay (by design) a reverse-engineered =
model.

I need to spin a new revision of the patches for that though.

It will break from time to time and cannot come with an expectation
of short-term (as in, anything past 6 months) stability/build-ability.
>=20
> thanks
> -- PMM


