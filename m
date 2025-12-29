Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED9E92FDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKXN-0000d6-Qr; Mon, 29 Dec 2025 16:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaKXH-0000cL-73
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:12:15 -0500
Received: from p-east2-cluster4-host11-snip4-10.eps.apple.com ([57.103.78.181]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaKXF-0007kx-96
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:12:14 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPS id
 671251800416; Mon, 29 Dec 2025 21:12:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=OtUXijhvSEKfguDH3+XnhVo02DQlxvuoylgbDMGrhIc=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=cG3MT24wNqOgvKBCZEV9rHnewSGyiR1ccA0EqrQfLyGTO4QD7pa3Cuaw4Y5p5B12Aw0NGVBNnjr9WnhHL/Hwq2MR5Wqi3WP9Bard1j/0gfZt1wYikxD1Z6dsqnhoSyEXZRBlonaw35KMGTMo8HtdxsVUMYx0OYCNgLWxSE/ZwJJYm7nA07N8LtvJq9QA+36XuStHQ3jL/WrDXRSalC6HgOdjZ33XfmsSCElChsBfDg8KW2DMoq720ivAx+pRtBnz/z2JjxSJ/WpJ+yctoks55wc2c+vTdhcPpySS/hXry7drOu6kooRkDUqvs/UaOQTUjpAOk7JoIExT6qzb+GWgew==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-4 (Postfix) with ESMTPSA id
 CB53D1800425; Mon, 29 Dec 2025 21:11:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <2F12B75F-5AE5-494A-96E8-5B0766804685@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_587FF383-DC53-4EC5-AD1C-2D6D0F41ECB3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v12 11/28] whpx: reshuffle common code
Date: Mon, 29 Dec 2025 22:11:44 +0100
In-Reply-To: <c8bba373-0ff1-4acc-ac3e-7157b3627247@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-12-mohamed@unpredictable.fr>
 <c8bba373-0ff1-4acc-ac3e-7157b3627247@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: pHejKiP2ef8xMR29enHKsQiLbNY7WR12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE5NCBTYWx0ZWRfX0nOFEwnzwoIJ
 XXGZoTAjM5pNkTQvF6d4SoQ3gznVmKQ7tpnjdjRKV56mSzFcM7E6MXGfgKTyelzUJNrhbEL7PWq
 TA1ISeYvYJQDHJQmCQYLA49lcHjYjIW4tf4LFZQ+aWzTPHwPPOuYY6dH9tcyoyGVUNPqk5ot+n8
 eVrEPYNOSMBmSTV+4ZInUZ/DgEcid7w34SR88MCKt5atwflIil/+eohgeWYP9orNLmQnFKab2eF
 LQFAX1wfMIPujxCjTDZSLUmHKyvgQkH6YWU0ZMtjpRhQo6uhrS0mWRIhPmEXx5UENJYQkRQkBDe
 zR6F2OC0Bu8MRwI7xeV
X-Authority-Info: v=2.4 cv=X/9f6WTe c=1 sm=1 tr=0 ts=6952eea6 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=3agsX6oeCuEBZHekYfsA:9 a=QEXdDO2ut3YA:10 a=CfRu4lmQCga3v1vYNv0A:9
 a=jW965Cys1SRW_oyn:21 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pHejKiP2ef8xMR29enHKsQiLbNY7WR12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290194
X-JNJ: AAAAAAAByWglAGTDgbITy9AEqAUcDhAmGHZr9hRs2ZzTGGG1wSBc8m+8GlVZah4huuY4D6RWRI8k+JK4bQDLwEmozbHZQw6VKGCdTeE2QcbN8dUhRXOYztj2Tc6VkBTOPQO7zy7rVD0s3/OaBT5P6TYXTPkGmGQyXghv2/QbK4GBSYKzZqHjzBF587Ofp+2do74LuAjBX+7VHTUz15/Yem5GT0/KCtp8HoSzONEpM8nP8DGCmkEHEGnreEqZa6gTqGeJvFM+NQutT1PZWuaP5/R3QTUiDTDMFUteQcbGKCF4a58sBr7cNAx3iQwAPIA/CMP/61IoS1nWPST0749KNzI6BzWTICrA273SZa34abk9EV0nqXajZBWqhsFvGw/Uzr6J/WmDp790fzV2+WYDfDm1Fn1TA4bhIZts8TmtIP7a9iOwVm89CjdfL7UtCH7ZbFFMjmiLUDC6S3uzhoej8maZ68Zy0iUSg8pCpnC2lT9Qvy7b5Pn6w6U4FmNnFH/Cxzz58C1+BekRLD8C+79Z4K2CcG5ABaJXIWsVwmtLV4GtZUmuN6TZ0ib2njYOlsOSuNQRsmdWhuKSSeq22wtJBqxOJ2Fglet1juQAnIz0nVPHe4sZoufIZxQqDeCyT5ox/DB7Ud9ZKMmxvoaN3KgImtWjasJZJUDpkhJsjo39MV4k5t7+f4w64tk42Qa9Ua6p+ErZv0JfPW4Hwlvv5H4o+HgQ7Ar/o4pT339Uh/kYpebDigdMpM540WtwWro7lypweUDs/HQT6QTzBzbobqGufnlfz3hL78WYLMtkycEoEBXixXsUuIQLrqvAEFqIfH4BOfWQfn+YQ2BonmOry2CvURLzyGSghdylaSL/pIypOJakGSm29+yJea7LRCb7QH3VOmm+11ZlZ67qdHKy8YTlPCS9f0EkR5lZbMgIasfGFjUK+VduQkQ7GU5lxqYdRQvE/Xynyq2K81BuaOskFQs=
Received-SPF: pass client-ip=57.103.78.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_587FF383-DC53-4EC5-AD1C-2D6D0F41ECB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 29. Dec 2025, at 19:46, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> ERROR: New file 'accel/whpx/whpx-common.c' must not have license =
boilerplate header text, only the SPDX-License-Identifier, unless this =
file was copied from existing code already having such text.

Hello,

Deliberately didn=E2=80=99t do it because it=E2=80=99s copying chunks of =
the existing x86_64 WHPX backend.

Should I still do it despite that?

Thank you,
-Mohamed=

--Apple-Mail=_587FF383-DC53-4EC5-AD1C-2D6D0F41ECB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 29. Dec 2025, at 19:46, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">ERROR: New file 'accel/whpx/whpx-common.c' =
must not have license boilerplate header text, only the =
SPDX-License-Identifier, unless this file was copied from existing code =
already having such text.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote></div><br><div>Hello,</div><div><br></div><div>=
Deliberately didn=E2=80=99t do it because it=E2=80=99s copying chunks of =
the existing x86_64 WHPX backend.</div><div><br></div><div>Should I =
still do it despite that?</div><div><br></div><div>Thank =
you,</div><div>-Mohamed</div></body></html>=

--Apple-Mail=_587FF383-DC53-4EC5-AD1C-2D6D0F41ECB3--

