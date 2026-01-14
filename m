Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E795D37E2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0gp-0000jP-KS; Wed, 14 Jan 2026 08:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg0gY-0000aN-N8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:13:24 -0500
Received: from p-west1-cluster3-host7-snip4-10.eps.apple.com ([57.103.66.53]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg0gW-0002ZJ-QQ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:13:18 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-12 (Postfix) with ESMTPS id
 4B2FA18002A2; Wed, 14 Jan 2026 13:13:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XBDnJjLY4j0IHtHcJd9nxSwRKudljfaQ1JcdAc6f5RA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=TwxUrnDDSoqLWCCOPfFYwz4U80uRn7AMa6s+tIcuMzWL/+UGorcduKvQRQyaf5I4mabdN9HdalaMJaltvpyytI6UwGSdhyTHBlRMUDQdFypSk55bGS8cvIfzZpA7BejxO4zDCMfQCjHqAXpm90aAFmmNssfbOzLdGl2EdOdlbGX50QoBjoLRaWSmpyZHpeqq7PrYd2uKXChIWftqe1nOdO/1KTJ6ell0zr8+mYCz2lJEEA1EberJ8F7Q49TbCoA3SkTwiwvV1QxnMld4rf5mFPwL+cfk+jWhRGY7hDwYT4L7syTU7KNkAQ6Puf6bYFcc7iGNK+ImNR47BTXn2Mu/5A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-12 (Postfix) with ESMTPSA id
 C667218002A4; Wed, 14 Jan 2026 13:13:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <3A952EB6-9EC4-40F1-87C6-766379808DD7@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_0B70B3B2-3BA4-4780-9BB0-E58C1536AF6D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 1/2] hvf/arm: handle FEAT_SME2 migration
Date: Wed, 14 Jan 2026 14:12:58 +0100
In-Reply-To: <CAAjaMXZehMtdZC+7obmRZgfE+T2Dn64GTY2MqncPq9grKGcSsw@mail.gmail.com>
Cc: Alexander Graf <agraf@csgraf.de>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
 <20260114-sme2-hvf-v1-1-ce9599596736@linaro.org>
 <6edbbdd7-8992-420e-9aee-7596afbcf00d@csgraf.de>
 <CAAjaMXZehMtdZC+7obmRZgfE+T2Dn64GTY2MqncPq9grKGcSsw@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExMCBTYWx0ZWRfX+LMtQ+T5Cqm1
 ABMRw3ej+69VOmmQKaTZJ5ScQX4wFkOLSJZdqO53+jnQdrb78pW+9uz6KBxemSL2e6y3EDRKh1Q
 QoAtPyifNxTN4/Vje1MXbWLZeyAVHG8w0vNTC01WU8dr+V0qpU5/XRaACLHWKqJcQJ9VGiO3ktC
 C0Alp1G544x71y1GEjv7ioeQm4uP1s1/O/tJWc9aAOrtraLgBhgWcKBfOBbyXr7CZpepLgBFdt4
 xWY0U/VzS5YLeXp4KrbF4puRmvUE2IBCIH0k/5U56lwg6sxfIDduV3egpn1r0Y3ZvXGDF9H+6bl
 XBH88qe1WeARBP/RcZb
X-Proofpoint-GUID: axa2rg2wbDZA3NMWqRIZbqdADUGcPXQY
X-Proofpoint-ORIG-GUID: axa2rg2wbDZA3NMWqRIZbqdADUGcPXQY
X-Authority-Info: v=2.4 cv=N90k1m9B c=1 sm=1 tr=0 ts=69679669
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=7JoiO3d9rUHgviZBdYkA:9 a=CjuIK1q_8ugA:10
 a=tMk-nljNnkZwi1k34TAA:9 a=2hQirLpjCCEEXmJT:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=772 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140110
X-JNJ: AAAAAAABIKlXfxSRsKoJU73MLiIYHNM+KCWQDTrI1DcEFA6bUcpPQp8n77FzsoJkyON8+aTVPb0zWd4XmyMm0hgvtBwWsiSt1BKyJPy9dh/kOnj0EDX2kwDBiomf5SGpWR8KY77EWe+8thocyW1USxXKLAWjIORTMbSMv4LhGASfTJbORK/IsaRJf5uQxYY797GaoXZjFTNZ8zSG+zwKReYv9A6fWJKv9Hg/nfCRyb+/Ed8+T6elehQ/q52TzZf7hUbxsHR0nwRGw6n9eSCh2oLJVyg/MalLrvg6DkLmREzqPwDWGa5khkrcRPIgMVfHj+EDzJkdGuZpvLJ1dv3cmP2geI8rvmTsYnqSnaX1qh4/J/19bxKwpFxxMIompTwBaoR0Mdyx+la+3RfiOyXtWx0mlCG51J2JscMF0uLkq1WLVeZUojd9GIf2Os3pFo1CsLy5Ai6hLWKjZLUJoIb37C86fC+xb07GSp53MRJg2UwMQBBEQwbD2lotn7kvMdF1WJkQs8ZA/5r5xedIOVO5Oxmd79tmysCIv2/nVNZ6AlDdYYeWIHrIiDgXd/dYhhx5nJguBDQgKqPjeaojWV1WOaaO2GbQ3E2GXmnTb3ExR2YAYOCL2hdiCs/IJUQwydTgdkeZGQuXdq+0DJDloxeOMDvfU5Dpv+8tmPkJVZmE6Rh3M2fKIeXPkAE=
Received-SPF: pass client-ip=57.103.66.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_0B70B3B2-3BA4-4780-9BB0-E58C1536AF6D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 14. Jan 2026, at 12:51, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> I agree completely, the problem is two-fold here: the HVF exposes APIs
> with API_AVAILABLE(...) (clang's availability attribute) and also with
> plain ifdefs (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200), and
> specifically the HV_SME_FOO_REG variants, which cannot be protected
> with the availability attribute. )
>=20
> So every time an SME type such as hv_vcpu_sme_state_t is used, it has
> to be guarded :/ __builtin_available(...) check is not sufficient
> because it will not compile due to undefined types.


Hello,

Newer SDKs can still target older OSes so we might get away with
just requiring a new SDK but still running on older OSes I think?




--Apple-Mail=_0B70B3B2-3BA4-4780-9BB0-E58C1536AF6D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 14. Jan 2026, at 12:51, Manos Pitsidianakis =
&lt;manos.pitsidianakis@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I agree completely, the problem is two-fold =
here: the HVF exposes APIs</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">with API_AVAILABLE(...) (clang's =
availability attribute) and also with</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">plain ifdefs =
(__MAC_OS_X_VERSION_MAX_ALLOWED &gt;=3D 150200), and</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">specifically the HV_SME_FOO_REG variants, =
which cannot be protected</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">with the availability attribute. =
)</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">So =
every time an SME type such as hv_vcpu_sme_state_t is used, it =
has</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">to be guarded :/ __builtin_available(...) =
check is not sufficient</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">because it will not compile due to =
undefined types.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote></div><div><br></div>Hello,<div><br><div>Newer =
SDKs can still target older OSes so we might get away =
with</div><div>just requiring a new SDK but still running on older OSes =
I =
think?</div><div><br></div><div><br></div><div><br></div></div></body></ht=
ml>=

--Apple-Mail=_0B70B3B2-3BA4-4780-9BB0-E58C1536AF6D--

