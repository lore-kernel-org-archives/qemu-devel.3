Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1852606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=q7fNREVe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzuH-0007Fb-Pl; Mon, 16 Nov 2026 11:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xSzuG-0007EA-0W
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:12 -0500
Received: from qs-2001i-snip6-11.eps.apple.com ([2a01:b747:3006:201::5d]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xSzuD-0006T1-TL
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:11 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 789401C1F80A; Mon, 16 Nov 2026 16:50:07 +0000 (UTC)
X-ICL-RepId: 01a1e544-176f-72f6-9cb2-2df72d18edd8
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794847808; x=1826383808;
 bh=v3aEawUcvV9HqLB73mMVw52RR0ETsCAqw7JLAWZ4yDQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=q7fNREVekY+A8p52fYAdQHQXsAiXLW+XtSUH6Cr5k0hrkdTd84grbnZkJFBljqe+4pUEDGNhFsWoHRHEAcjSP3U/3CbBGiXtWE8rylei0xXRWiRa5uvkKhvuM3tzZlvSQPLdWde0gFiuk92EQT1oo4KjfBHBd6p2preerjF5S6IOyMHbFWvwXkp7FTxm2MTv6+63SM61B+iiELGPKPELOTOIpjewatnvNruqL4D1est7vxBcG8p2iDUy5r92frUAz0AetTfj8Ux8zRut2/Hjoj9plx69ovUhGmE9cwja8B2FP1VOXqEIXsaN00S/mWqkDxOf8w1q0KtR7+A/lF22Ig==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 69DD81C1F86F; Mon, 16 Nov 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] pvg: disable by default
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <6784d934-1efa-4108-8582-e9c237fccbb3@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:49:54 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <828E220B-6D3E-4EF5-A800-98069538A545@unpredictable.fr>
References: <20261116144951.71940-1-mohamed@unpredictable.fr>
 <6784d934-1efa-4108-8582-e9c237fccbb3@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: nPmLjDCHWDWRxqxZNXtgkZ0xSN2FcbDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfX2m831kee+CKU
 zEiQ19VQETwNQILf9xWxQVT04lQ58vhFri/a9sNT9KMFn7P3snZBEvjUX+K5l5qwnrhUsNEZvGJ
 cK2tQ8ToVMV1AVhP8EklyjoG/j1im7yfX7chRDG0ufpzxckKEFiN0UMPl1grwFUeVnvF7D/02a6
 UsQ8V+9HB+dNFg2XxYdP2L+gSqRE2sTZZ4ZrbRYvP4H/PqPJEQpb9afmj5DmoFOM4vmCms0Xfx+
 EobSkOudjW2Kwo+WVe8D0wxwx7BQuDPZnDZcVWsayT7AaBTKfYND24iVqKOoYTsrHTNYON4ZAxy
 rLXF4sUCzI8q3cFwnoVgNsSeF8nFZ9hnWsF9pRlHmjHVW7F9Qwz08TWDTPN+dk=
X-Authority-Info-Out: v=2.4 cv=W6k1lBWk c=1 sm=1 tr=0 ts=6afb343f
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=xrXt8KjulaXKxkSOdtkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nPmLjDCHWDWRxqxZNXtgkZ0xSN2FcbDB
X-JNJ: AAAAAAAB02AooHDpfQ88T6Ox0T8ioYY1HXM/m77ozN9ye2IkLSYspx13DNdb9uevIkXLkT
 T/inDp37wTTCY8ud7h38iAAgfynz5Cg3px4z0ICRz8Ag4Kt+pbF6pf/k1EpT13IIsINHWo
 yLsuKbRbgUwqa64IMu9+k1UX2coqQAyMfxDQ+Xd5afN1S2iRSpK3PNv7CV+skbvvhKMec0
 8MUTzIivNKgNgY8uax7mfsyB6C1pu5LgigFD4PkSyGEWmdI+V5/HOEAKwD5mJ3YNh7bqJH
 7yLVJqwiijGEafbanzlJ59pIxpe1mJSSItKIFMpynpYS6nAzOwnTCU8Ckj/09oFZ2eJSFl
 C1JE+wyl2lKzfF3dzkiKB/Q8aAkPXcCu27eNpn2vm1cGppCadGQALr18QQicyCcB05zJXn
 hIQ9q/V2tZ6whh+9q3aXmjfGkkKHXzVViugZ+ZRzwb+EPtuRmXC9U0t0mYSZMQlNutQdrr
 0HBknj8K5Ca+aiB9dckS2KYBOdh+TfMPMvH7mN+zc7SE00ehufvttZ+DC04DuQG7JYOyjW
 D1+plzrsyVNpyhWLLBA7VXZbidROdHYjxJ39TYAZu5yNmjQTyu4C/n20jcTwY44sJd3Ink
 Z5pd4uN7lA2bhBnzFnzeLlwhyMbxhnCtWZ0oH4zmmhhZRM2ppl5ib/xop/xPAkYCKvUIyv
 p2prRl9ahAXiFYhFshF8WmuC3F96MEWk0hjaLryYgHkOZQxYbLV84Nu1aXPHzxk+DP8rqK
 ct+NO6LMztcbskROzVOlTjznuwDNMeW1b0zCaunjiBLKTpEoDBCNgus8ZzZ6wedfLnyjR2
 Um/mL6NyBPk9sKc80HXgTls4r3tIuvOnVi9UQ8ZcAg5gYGei1XvtpDKZ3siOuY5f87ak3i
 ZmfkssEZGYfTFu1c+40qRB2+pqTTGyFRPqTaOduFhCOS6K5whLERDZVM3pbe+vI0aRznev
 WP/vlUeaglbENBsaHVBJlmrXT2ctjXKH7f3eTp3tZSGjJno+j7KML/wME2PcWZx/lNOi2L
 gZDt/DOyN333FDiTrFNAB5VECf+xVuGneOwuKZFMR54fWsk2Iv0iG/+kQzMYx86uBYn7lE
 yEy8yK0lDDhthNsZhLc+ObeOWZD5WgWgxizE4jvlxCdAYoPdVeno4e4JwkRfVIGiKnRS1p
 6lhi2avyKsxmBwNimmCH4Y4Un8Ks/6L2+ftqTyFHElDbJpbZeU3bKNXUosgWcuGXzJXL45
 zArh5dxYgoeJGh7W0R3K9mZocTXWAuLPEFrYxuOPVtp8t3kICFViobitOU9PWz8Norszgr
 lBE477A9MUiwIZ3ZZskzpyhSN+8Ox3TXERVfXg4+DWxHRbWXjwfeWW9mvhlzN0X+uwgT4W
 6h0Q+NfP3mhxbkE4oL3w6MkybLeJFFu9vD05Jmn1CA+myBpJ6h2Jk0SY
Received-SPF: pass client-ip=2a01:b747:3006:201::5d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 16. Nov 2026, at 17:45, Pierrick Bouvier =
<pierrick.bouvier@oss.qualcomm.com> wrote:
>=20
> On 11/16/2026 6:49 AM, Mohamed Mediouni wrote:
>> macOS 27 removes support for x86 processors. As such, support
>> for ParavirtualizedGraphics as a public API has been removed.
>>=20
>> Current QEMU does not compile with ParavirtualizedGraphics enabled
>> and the arm64 side of PVG is not documented or supported by Apple
>> for third-party use.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> meson_options.txt | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 0d4907a0d3..eb049479f0 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -208,7 +208,7 @@ option('lzfse', type : 'feature', value : 'auto',
>>        description: 'lzfse support for DMG images')
>> option('lzo', type : 'feature', value : 'auto',
>>        description: 'lzo compression support')
>> -option('pvg', type: 'feature', value: 'auto',
>> +option('pvg', type: 'feature', value: 'disabled',
>>        description: 'macOS paravirtualized graphics support')
>> option('rbd', type : 'feature', value : 'auto',
>>        description: 'Ceph block device driver')
>=20
> Sounds like the only thing we can do for now.
> Maybe it could be a proper check in meson.build based on macos =
version?

Hi,

It=E2=80=99s possible to use a newer SDK even on an older macOS, and the =
new SDK
can be used to back deploy all the way back to macOS 11.

So detecting the host OS version isn=E2=80=99t good enough, but perhaps =
detecting
an older SDK would=E2=80=A6 but not sure that=E2=80=99d be worth the =
hassle.

> Not sure how useful is it to enable this by default.
>=20
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>=20
> Regards,
> Pierrick


