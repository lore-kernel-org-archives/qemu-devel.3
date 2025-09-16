Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F027CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 22:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyeTz-00033D-Rj; Tue, 16 Sep 2025 18:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uyeTw-000310-Sg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:49:05 -0400
Received: from p-east3-cluster7-host12-snip4-5.eps.apple.com ([57.103.84.246]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uyeTv-0004rN-2T
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:49:04 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 717CD1800129; Tue, 16 Sep 2025 22:48:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=mDbLg3wYfQ7NV1O3oBi8gVjmH0TooxeneM6zmpMd7cA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=O7b8NGoAiw2mH581MqejkRkl0GtghjFEkgkr9hOnQpLDt89rolPd31azK5SJ38uNaB7CHpiCKP/sU6CDkl2a69e0OLvaBGvFkc898jnw+rVDzpNaTT0Rl7qHvcQl1d20lQeL5TaWP1FLbObFy0OtcsKYIWgqjZ7aaQKO/IKUdTf3q8hnJZtjXdfGZdAgw220itUutUhPrF38bEkFdlyKVhniGz8fHdyJtIUWcFnVIwyDesC1kzWBeVVJDxJ3n83Z/VYAbnWaR8Ol7TKn+GUP6mTyv1cBLf8BPY+PfUHZEvuIjLWQAJ/8JIcdVhbwTjwI+NtvH3b69miVQ8UNdUfLtA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 4D65E1800115; Tue, 16 Sep 2025 22:48:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <DF061F5C-9807-4948-BD62-EC42425C5B9E@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1D16EF85-9730-4AE1-B498-9C04480066BD"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v4 03/27] target/i386/mshv: Add x86 decoder/emu
 implementation
Date: Wed, 17 Sep 2025 00:48:41 +0200
In-Reply-To: <aMmg_K8N1fKGUV4o@gallifrey>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
 <aMmg_K8N1fKGUV4o@gallifrey>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-ORIG-GUID: A2bviv6Fn1cclaOWZkpAkuiIMsmiT9iU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIxNCBTYWx0ZWRfX//UdMfRCd51f
 WYu8gSk+0W9dv7hQtAAkDSdjfOTj9XSLZ+ZfwziLNAX7nP+URr/IzCDTVTnysTZSLmZRsr9iLRb
 c5zLAE4IbfolElc3iE5U2wH9LgeCBhi9hHRxWLV3Hs2VF0bqwp2GgUY2wj1vjVCDhmpJv+SUdSy
 YmYxnpmPEB6J4+uje835Lkf9FRtJ9o31ZF5GjmyRSJ77vsjlBC6SZ+fde4sSnFhXp+wbEK2u5in
 hAHOupbXBAQvyPXlKpUSMTxA/ubgGlqPFLR4frzqhVULqwJam4ajIVUOOX4TACffdips0gBA8=
X-Proofpoint-GUID: A2bviv6Fn1cclaOWZkpAkuiIMsmiT9iU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0
 clxscore=1030 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509160214
X-JNJ: AAAAAAABNhi7O3dzlkCfLC60iuN/Pxt0Uvh/ff+qSrnALJRA/tr6Pr7icjmBSxLrGUY4wBIdyj8pdKgatNmK2+BodqBZznI1b2AYk3IR6HrGsaQb4K5K97m9FNP4GovV/9Lkh0cjhyQakQqWgqt8C1ywb6V/Vf8vc+lTGJcLQqGHzRa4lcuaM5+3O+51m/tB/UQnnZo8QOUU2wckoDsG2fOGXd+HSrmm6eQghjit/yWDFMXHuJ+o4HEDl5wg6Fmf4+jSB9SRH8W3DxSsFVo4E6O5ZPVK/VgRZtDaupe1AXhIjVVwYjubnamcu4CNlgKfy7U9eda0f+pq4/4cQlps4brOvdInkGmYp1RkuJbNip1pomeoZOFO0S3yJyKHV5Xy4vPEAW9/ipumU4AQJZwmBYF7L5ZmicHP9e0ZKJ3rtlACVlRSimGgz4t7VUSgMRkU+8THKECMD7CQCB5K6Nk3re9Ji7KfSqeFFxq07R5wcQ5ZiZWWT4nZ2KR5V3JRuC713ZcfCelX61ctv+7a1CR1EcSEEPRTxOajxEwgPhqkNDfPLhrffT7k4twA+OXmGOsmVhCunb+ft5G9mrC6PN7n76vuftKqQ4aRiIctMMe8a3HUXWTtYvevV6UEUi0GF/c6V5CpRo8dFzr9vh1WtOPv6+L4MVi+MzqbtTqhdMuTW1BdFspPekEIeetlO+voPe5swVr1u8MpPwl/1E5RH8ljcyILRg+pIWJroRF2yWrJ7TVNP8lYpagR6sUTQ+J1ahSr0SSIYoZ/4I0333cxsqjYR7nRdgDqWHtojnq80+2B2H4HHbcSOvgl49N6WhiOwefH3sQgql36LfrwbT5jxbzNFEVHCARexYTn0onf7rNiUycw0+tUPbE0yRDMmudqg1xYrubI
Received-SPF: pass client-ip=57.103.84.246;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_1D16EF85-9730-4AE1-B498-9C04480066BD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 16. Sep 2025, at 19:40, Dr. David Alan Gilbert <dave@treblig.org> =
wrote:
>=20
> For example 'x86_is_real' is declared in target/i386/emulate/x86.h
> and defined in target/i386/hvf/x86.c  (hmm that's a bit weird).
> So it's probably best to check if what you want already exists,
> move it into target/i386 somewhere I guess, and everyone shares it.
Currently there isn=E2=80=99t a backend-agnostic interface for this.=20
It was part of the import of HVF support to qemu from downstream.

Notably means that the emulate infrastructure isn=E2=80=99t usable by =
multiple
backends in the same build. It might be possible to get away without =
that
however as HVF is macOS specific, MSHV is Linux-specific and WHPX
(which is currently using winhvemulator instead of this) is =
Windows-specific...
=20


--Apple-Mail=_1D16EF85-9730-4AE1-B498-9C04480066BD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 16. Sep 2025, at 19:40, Dr. David Alan Gilbert =
&lt;dave@treblig.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">For example 'x86_is_real' is declared in =
target/i386/emulate/x86.h</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">and =
defined in target/i386/hvf/x86.c &nbsp;(hmm that's a bit =
weird).</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">So it's probably best to =
check if what you want already exists,</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">move it =
into target/i386 somewhere I guess, and everyone shares it.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote></div>Currently there isn=E2=80=99t a =
backend-agnostic interface for this.&nbsp;<div>It was part of the import =
of HVF support to qemu from downstream.<div><br></div><div>Notably means =
that the emulate infrastructure isn=E2=80=99t usable by =
multiple</div></div><div>backends in the same build. It might be =
possible to get away without that</div><div>however as HVF is macOS =
specific, MSHV is Linux-specific and WHPX</div><div>(which is currently =
using winhvemulator instead of this) is =
Windows-specific...</div><div>&nbsp;</div><div><br></div></body></html>=

--Apple-Mail=_1D16EF85-9730-4AE1-B498-9C04480066BD--

