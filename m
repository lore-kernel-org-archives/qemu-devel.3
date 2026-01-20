Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F27D2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 07:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi5t6-0001TX-BM; Tue, 20 Jan 2026 02:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vi5t2-0001QC-Tv
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:10:48 -0500
Received: from p-west1-cluster1-host7-snip4-10.eps.apple.com ([57.103.64.33]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vi5t0-0006Ce-TU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 02:10:48 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPS id
 1377C1800309; Tue, 20 Jan 2026 07:10:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768893041; x=1771485041;
 bh=LXv2hb0/QwRZ12iWS+IA7XlhZpbUiDdhYqHbaFhntts=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=DHYSWBNavPB+X3OjPM077BVU/va16v4ZinlZqnYQYE6DJG2ua1zjoiF2vzKUFmLFF9OnV8imjcnWw/kcQKDVuhTg1lTsHm43M0aRRFcl6mqbkTe3gkuFGW5j9NZu9/cnZD7S0whe04VuphaqdBoKDV8Y3oQkYkZAh5laZ6CJYg+/TKxrRAll44KFDigQQd4x1OCnJ/i5wCHqc5WF/0hSFC/brIFQskcNZ7F2Wx3/1ACYs2xYiWYDbJyAo0x1qsbVlVNWD2zHcSDDcOIyNJzTsxsmKuUao3OvxddAwl2GADft+7XJSRtcB+NzD+JinK5evLeWjWOgddLQW/ulj0BAgQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPSA id
 2797C180017B; Tue, 20 Jan 2026 07:10:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <3BAD1C4B-D8D2-4F80-8A58-576DED9205C7@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6B7B01D3-55F2-409C-8223-ABE27820747C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 50/59] target/arm/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
Date: Tue, 20 Jan 2026 08:10:23 +0100
In-Reply-To: <f7a2dc18-ecad-4487-9b7d-f85618fc2ba5@linaro.org>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-51-philmd@linaro.org>
 <f7a2dc18-ecad-4487-9b7d-f85618fc2ba5@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA1OSBTYWx0ZWRfXzDEFcN6stpYC
 vVMCb/eGgS7Z0zh5rDvIbFZwI9wsLtX+OZixFMOGY7l/UuWcyIecF6APjx7aO9bHniv0+WW3gvU
 LOxWukpIREw/PzDNSfu/SdZizYxyfYj/GAUHF7TmUTfVZQbvDCt3zz5k7W+VYT+6P6nlBmx9fNo
 IOZkbRKOCl43ADvoL/UeHrs/K65McnBWySvBDPZUEUoADWHr+ZhDnmdY4WASqo5MZ+JqO5lEMSp
 XqbuXFFoXyAJ8EoZRywd/8CHBYqZ3fAoYgY47uO2s7O7AeULPlLmKlJtadVQmgpt1E6Oh9murwe
 QfUU7qbDIeFcKoBsar4
X-Authority-Info: v=2.4 cv=NK3YOk6g c=1 sm=1 tr=0 ts=696f2a70
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=QqRhPzoe9nByCySpuJwA:9 a=CjuIK1q_8ugA:10
 a=HGuZ2jdinyDo1KHoTtIA:9 a=X2QVYIltt2j8uuVa:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pb66v-rJ2Pb69BHpACCoD0DPcYjKmGPB
X-Proofpoint-ORIG-GUID: pb66v-rJ2Pb69BHpACCoD0DPcYjKmGPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 mlxlogscore=710 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601200059
X-JNJ: AAAAAAABGVwhqd05yQqhgfkhutxmIBMtmxseoN/hxFmayyrgGhTf1W44kNekacGp/YAHtfZx52mpnd4u37eHe3cL/CPQMtbJ6TX11KY/FJzk5E/cbXHWmVK8o8zkKyrHr9aRLHi6TPPrJWBJArwKJjy2XIdE5WgpLSKPxc54GVINM5NUxVg3FJ16Oa0xf4smkpf0inXn0YDaz1Li015XBrZfpR+uYCGAiLQBP1rPhGRLY1MbghMGJ6tzHPiCnbrU2nq8r0mwg6kqtmzbSWUO1DBVM2fbYX5df1b9/rN+e5a1OtGLSBOaq6K+EuyU2txg0c2xd0QAMtu+B/Z92RPkt6wFwUaJeCYICDbyYNO0mN/EHBsOsysOLRlT/bSaLv9vCOS3hK2hUyDXbsTerhV97VBNiodBoHnCvgfQivKtrKVEtKJDuu4HLxBm0TMmLpZmOqDLk5q8RdNZkehFOALrla8Z+vaZ3+YqbttPGRdaguejUgvGxfvKIrjnTUgUnRUXfp9/mmJiR7TrByef97FDEWs+DRjmMeG14f1/7StYMhcbOMtn7mr3xQSlKFNtJoeJ8KEYXTw1b4CexyFmt2ZF2AOSKDBE9Zpas4OVK6BboBkp4nPW5YYbLAiJOSvonegnG8yCFgNyWR7stAHFNUffmudn+SqKta6sSj3ICzszO03qBnUeB5tckln0Behy1PixZbRl1ZLP7O5ZyMHph6BtKq0Frugsawtk35pmDgNKUxoIhB64pdn1zNGVtQiD5L5xdoQr0YyxL50rbJxVZBUdH7tM392flEVtcg==
Received-SPF: pass client-ip=57.103.64.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


--Apple-Mail=_6B7B01D3-55F2-409C-8223-ABE27820747C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 28. Oct 2025, at 13:06, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> because surely we can always probe the supported IPA size.


APIs for that were added on macOS 13.

Prior to that release, the only safe thing to do was to assume 36-bit.

But since then, there has been macOS 14, 15 and 26, so the support =
policy might still allow dropping this...=

--Apple-Mail=_6B7B01D3-55F2-409C-8223-ABE27820747C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 28. Oct 2025, at 13:06, Richard Henderson =
&lt;richard.henderson@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">because surely we can always probe the =
supported IPA =
size.</span></div></blockquote></div><div><br></div><div>APIs for that =
were added on macOS 13.</div><div><br></div><div>Prior to that release, =
the only safe thing to do was to assume =
36-bit.</div><div><br></div><div>But since then, there has been macOS =
14, 15 and 26, so the support policy might still allow dropping =
this...</div></body></html>=

--Apple-Mail=_6B7B01D3-55F2-409C-8223-ABE27820747C--

