Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2050EF584C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 19:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrLh2-0000it-Ib; Sat, 14 Feb 2026 14:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrLgz-0000ic-01
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:52:37 -0500
Received: from p-west1-cluster5-host2-snip4-7.eps.apple.com ([57.103.66.188]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrLgw-00080o-Nc
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:52:36 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-15 (Postfix) with ESMTPS id
 669AE18005B3; Sat, 14 Feb 2026 19:52:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771098750; x=1773690750;
 bh=D3+KlGKLpcPU5HRgJ5kAGMN63WXwzAkiQ2RDeDkhwLU=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=CjdXU1PH20X0btesiHucrZPOOY9Kb0CgowfgiNwU0A6lrrTQUjq7FIZPiJLnm0hEvAPMKAChntIOO4K8nJvFJYIp1RAOBHqDqjOt8JfxFW9wW1k8fR2d514NGeY61D8SgA6ZBl9fpDibqyZfs718d4t7HVYQWva5SvI1QHDkKhGGmpJohoPDJlcWi2pNubSiJadPGa8LcWrmHZEkWbPY2GTnp7DU28qV754yyfjTzFtzbcolgIKHq1NVIdhPv37s1/+bzZQqbi6nBkoztDJVZ1TGmlXyunHqV253iM0TiJEPX+9Hpmq5EdI/qYtqS6silGSQ9/hX3iUA4ZS1sWwE3A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-15 (Postfix) with ESMTPSA id
 AF35418005A0; Sat, 14 Feb 2026 19:52:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <4F19682B-800C-4442-A5BA-C63E81D3E792@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_BE1BE1EE-6147-44DB-8F60-7E30C3016EEC"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/3] i386 emulate fixes
Date: Sat, 14 Feb 2026 20:52:11 +0100
In-Reply-To: <20260214131659.31378-1-shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
To: Bernhard Beschow <shentey@gmail.com>
References: <20260214131659.31378-1-shentey@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=SsSdKfO0 c=1 sm=1 tr=0 ts=6990d27b
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=OQdDbjkjo2-Olhh4lEAA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
 a=2XsdyA_o0lUjXkYChjcA:9 a=jt1rJ_WpdYvtSKXg:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: xxBJnMMmaXx81D22X85UpOxvSgRBbXLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDE2NiBTYWx0ZWRfX3uU4VemAYS14
 BS1BA+qAKOJUs7M7cXaAcA0cWttofHcJGhlBvfbPU5h/cf8Ybs6Lm3TRg2Qw0oAzHw2Hyca4l2x
 cic0gOxcn2NYJ+VNdEdmuUm00/Ejg1kIeMdUoKAfPhZrm7NSUBIYERHerH0Ed9E99GBjdXMB64j
 YHQkoBjhtfHyMw/TUcEdEtv3tg21vTHmKJkbIqD1xzrY18tL6L7+Q+5rY/ftkQ6Rsa0aJ3riuYL
 ZJXwIeujWiqeHTMC3PMM5+qvbEQoR572APMkY1rCJ9oeB9CEwjIDxzgrm3R2ofBtp0P/SvkF+b3
 Ls+aIqjQ1yYSjd7Y6qTMatxtXmzhzhXdecVtp/wzKB9TUIBX6mrBP6+jmMRawI=
X-Proofpoint-ORIG-GUID: xxBJnMMmaXx81D22X85UpOxvSgRBbXLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-14_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=771 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602140166
X-JNJ: AAAAAAABZLjuU49qt3SeBQJRqanDOZsbvv1Pg67+SH3HlBLIqDZ8uRg/88pb1E6chJ4bhjeKOIjKdMgAyy1FG0iNckIyYhjJh8kl6Pjz7u698IDGsklKJVyLkMPgBCitj/Y0k2HqQ1F+jks6JVnoJ/zy9NKLgn95+QvtfdpxGO1Yqlj/8PDCxpa5m7jIfvS52ZIz/jeDz53BUAcWA+XvZmTviSKSR7eI6IaXVE3mi2gZiEirlsyqKgf4WiWdAtpvEbZBKiuJiwWZnuDO73PEOio+AGz39DhSblPiVopWuEw7+y20japth53wTc097tTjkC3rNQ25sU2f+5DX3HGfcPPPA7gvxYOn+Z0CI55X/50/HXbmW7KlAIHsVcAeS1w0QuaB8GfApipSiJpKiCc0dHw2ept5dG7KgePtKHqNVtuQXEiz3qabfiErWTlr7aWt2dlrA+x3tiYwcE0HsGTrFhuDXxbI2rmLmm8X0dSPoIn3EZY8cfr65xBzPWR0AWX03eQ2G3nDYGxOwmLkiBlsEgcUDFZN++8F4hE2q6IAj0zZ37Zh3XeZDQFTMMh5+W417ovsB2DirAWO51q3brLGJFC0ujz0+SiiuSraRP5eTUxWNG2IwyZ7dknNrkF/Mum6u3f6BHke33ZyZApjbPys9LGajy9Si76gMmfsX2QcwgaqfIWjWOjvtGGNAQN9dQMaj6v5zZc06L+m
Received-SPF: pass client-ip=57.103.66.188;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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


--Apple-Mail=_BE1BE1EE-6147-44DB-8F60-7E30C3016EEC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 14. Feb 2026, at 14:16, Bernhard Beschow <shentey@gmail.com> wrote:
>=20
> When testing Mohamed's recent x86_64 WHPX updates [1] I encountered =
two
> compilation issues under MSYS2/GCC which are fixed in this series. The =
last
> commit fixes a missed optimization opportunity in MSHV code.
>=20
> The MSHV code will be reused in WHPX [1] which allowed me to test it. =
I
> didn't notice any performance benefits, though in theory there should =
be some
> due to less guest memory accesses.
>=20
> Testing done:
> * Use a Linux VM for a couple of hours
>=20
> [1] =
https://lore.kernel.org/qemu-devel/20260213034556.13471-1-mohamed@unpredic=
table.fr/
>=20
> Bernhard Beschow (3):
>  target/i386/emulate/x86_decode: Fix compiler warning
>  target/i386/hvf/x86_mmu: Fix compiler warning
>  target/i386/emulate/x86_decode: Actually use stream in
>    decode_instruction_stream()
>=20
For the series:

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr =
<mailto:mohamed@unpredictable.fr>>

> target/i386/emulate/x86_decode.c | 6 +++---
> target/i386/hvf/x86_mmu.c        | 6 ++++--
> 2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.53.0
>=20


--Apple-Mail=_BE1BE1EE-6147-44DB-8F60-7E30C3016EEC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 14. Feb 2026, at 14:16, Bernhard Beschow =
&lt;shentey@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>When testing Mohamed's =
recent x86_64 WHPX updates [1] I encountered two<br>compilation issues =
under MSYS2/GCC which are fixed in this series. The last<br>commit fixes =
a missed optimization opportunity in MSHV code.<br><br>The MSHV code =
will be reused in WHPX [1] which allowed me to test it. I<br>didn't =
notice any performance benefits, though in theory there should be =
some<br>due to less guest memory accesses.<br><br>Testing done:<br>* Use =
a Linux VM for a couple of hours<br><br>[1] =
https://lore.kernel.org/qemu-devel/20260213034556.13471-1-mohamed@unpredic=
table.fr/<br><br>Bernhard Beschow (3):<br> =
&nbsp;target/i386/emulate/x86_decode: Fix compiler warning<br> =
&nbsp;target/i386/hvf/x86_mmu: Fix compiler warning<br> =
&nbsp;target/i386/emulate/x86_decode: Actually use stream in<br> =
&nbsp;&nbsp;&nbsp;decode_instruction_stream()<br><br></div></div></blockqu=
ote>For the series:</div><div><br></div><div>Reviewed-by: Mohamed =
Mediouni &lt;<a =
href=3D"mailto:mohamed@unpredictable.fr">mohamed@unpredictable.fr</a>&gt;<=
/div><div><br></div><div><blockquote =
type=3D"cite"><div><div>target/i386/emulate/x86_decode.c | 6 +++---<br> =
target/i386/hvf/x86_mmu.c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 6 =
++++--<br> 2 files changed, 7 insertions(+), 5 deletions(-)<br><br>-- =
<br>2.53.0<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_BE1BE1EE-6147-44DB-8F60-7E30C3016EEC--

