Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8235EF48CB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqkCq-0004V9-DO; Thu, 12 Feb 2026 22:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqkCo-0004Uc-Tr
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:50:58 -0500
Received: from p-east2-cluster2-host3-snip4-10.eps.apple.com ([57.103.78.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqkCn-0006ND-5v
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:50:58 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 2170E1800FA6; Fri, 13 Feb 2026 03:50:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954656; x=1773546656;
 bh=gkIHwLiicPJir/SN3RshaA+EdhlolV51yys+U0JCK6Q=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=Dr79Dk+OgPP6nsT6AWgiF5dBrjNE4/66uHFP//r+nLxoQjkoh7Yis8K5z7/uGJer5BPJeEAFilKuaxHMyaKP1ocPfHTpwne1DN5sAEV9HadOd5408vTY4pLVkotHTYignduapz8tAsRttIlAV2bAlKPh7KIXyH6oUGpQive4rcyn110v5hL5sULoGkza7k9V18es8gOjYZFxPFQtkJmkJbEOhXvl89B9MF2rBiBTwL9rdtijr5V/sQeBzU7Uz1aVsmZJMJWQW6UzdApcHAsUfajnq+Qc66+Y/eCtC1vsU31it6Iu+I+s1TPhJsD4mUcyG39UPWmefMzkSythEorMJg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 846041800F9F; Fri, 13 Feb 2026 03:50:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <1CECBF2E-B19C-41CB-9F6A-44AC45D969D2@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_755AE607-6B94-4988-AB9B-5209C4E3B2AA"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/7] whpx: x86 updates (2026-02)
Date: Fri, 13 Feb 2026 04:50:38 +0100
In-Reply-To: <90285696-0769-4934-9861-886179CC74D6@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
 <90285696-0769-4934-9861-886179CC74D6@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: byszzThlqkprvpSMsYygrVkVigSktedX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNiBTYWx0ZWRfX9ld7cYcdYtWr
 xA1XBeAtGHBhU15lkRnLya21g0+Oky+cezXpYT6APwiwYktj6gJZpLhNgCRgzV7EzPFYOfgvVZD
 0Fu25/Rg60nEaZZTNOBevUHTS0k8ZW0DwHyoG/UId709z6a3GjX5Lrg4NI/kNaoQpzl7yZhRWXi
 IZx+9IApOusWJCzio2tW44aCUBg9cbyesYfO7y1hFolMWMGIipdHDVrfqJJo9IYZqBp7b67iZmZ
 LkcqgJcvdkkl+CHhgUdNts5mcbnDJP4e+q+Ym+yk4upZsoKf2nfuuKkTxcnxjuQnLAxqC6oSNhJ
 vCKlEqXI2qdW6TrR7csv8e/qqyk79oWOTgJ59OiMTaQntqu3J9Hj/gXbET1diM=
X-Proofpoint-ORIG-GUID: byszzThlqkprvpSMsYygrVkVigSktedX
X-Authority-Info-Out: v=2.4 cv=d/T4CBjE c=1 sm=1 tr=0 ts=698e9f9e
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=7KrFPpZLaHbfpcboZ30A:9 a=CjuIK1q_8ugA:10 a=4K97RNY9uchIZwsLnTIA:9
 a=PIhe3K4j1ORAfCcv:21 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1030 mlxlogscore=924
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130026
X-JNJ: AAAAAAABzISFhyNp0CGvEXBjcXNAcjHAC+o9VUJGE7iX+0kojXOk6w0EEsz9pf8s8Hap3THaR/ULrNRgnkawh3o0IUINQShHQNogTHUtUxyWw/IbRsXSa0lxVASApmnlDMt4zuY5+oJyavdj50pk7JA+03U3KsaugWKxPMJhNz8h9KPyP5oLT6+ae1pjY3qcp3FRbS4NxMqh3cVsk11Rx2c0pArp5+U/gmeHSE3TahHaw8wowwfnL9qf2RsHZSmhxjB8VLJ1H0iijhTnmJtF4mjbb44wXnfiyNPNzzKleJ9zcVEazOTGxakasQlV7a4KvltdAoKZCj010iaKY2YzUf/4QVdRukh4HVyfcuYKqqWBySuo7nCJuOPpLSAnrTKH0QLkwNHiVGlMznRlZnGPruqvKaY6m1cMDGhPY5Jw9uuoxzFsNTrYiUtiryI9pczM4MM8b547aJ1LuhkbEEHYLTCrRnKoNC7jrIMISpoUVmE56V54Tw0vG/xAVwyrzaUnXRXdZ0fYWUWxAw0SQRU6p/dieVkw3QlCtrLrXBS0jFKcXMXc1805rfvLfxUZlPv+LuOafPApe85lxTbqIomGxLpi4CRhP2gmqUFTAt+kbS3RtXKXCtspJNQumqetjVbXHB5KpYVZVnsnbO9drIdql7lYj4kA+Vh9U6+xDebUnN9occr7L7FE33qXldwAjAQ+mE3qPRkqRLMczW4jwaVCOOoUVEzkEjZtpC7lt/MGNw+ipljNRsIUNXOYicwBDVVzHwvw4Fj80QLz2TdI75Z9PVAau4yZJqp12ifcYMosr13sqrQD7mI9QHg4AZaqN59gDog9fZcJbvvi3A==
Received-SPF: pass client-ip=57.103.78.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Apple-Mail=_755AE607-6B94-4988-AB9B-5209C4E3B2AA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 12. Feb 2026, at 23:52, Bernhard Beschow <shentey@gmail.com> wrote:
>=20
> I really like this series because it replaces proprietary code with =
already existing open-source one. So I gave it a spin. Unfortunately I =
have to report that I noticed some problematic performance regressions =
when booting x86_64 Linux with Grub: Before this series it takes ~20 =
seconds until the first Linux output is visible, and with this series =
applied it takes a bit more than 2 minutes, i.e. about 6 times as slow. =
Also, when using a GUI, mouse button presses easily take a second until =
reaction which is rather unusable. So I think this series needs more =
work and I'm happy to help with testing.

Hello,

Should be a bit faster now :-) (just sent over the v2)

Turns out that MMU lookups through the Hyper-V API were slower than I =
anticipated,
so moved the HVF x86 MMU translation bits over to common code and =
switched to using
those.

Thank you,
-Mohamed=

--Apple-Mail=_755AE607-6B94-4988-AB9B-5209C4E3B2AA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 12. Feb 2026, at 23:52, Bernhard Beschow =
&lt;shentey@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I really like this series because it =
replaces proprietary code with already existing open-source one. So I =
gave it a spin. Unfortunately I have to report that I noticed some =
problematic performance regressions when booting x86_64 Linux with Grub: =
Before this series it takes ~20 seconds until the first Linux output is =
visible, and with this series applied it takes a bit more than 2 =
minutes, i.e. about 6 times as slow. Also, when using a GUI, mouse =
button presses easily take a second until reaction which is rather =
unusable. So I think this series needs more work and I'm happy to help =
with testing.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: =
solid;"></div></blockquote></div><br><div>Hello,</div><div><br></div><div>=
Should be a bit faster now :-) (just sent over the =
v2)</div><div><br></div><div>Turns out that MMU lookups through the =
Hyper-V API were slower than I anticipated,</div><div>so moved the HVF =
x86 MMU translation bits over to common code and switched to =
using</div><div>those.</div><div><br></div><div>Thank =
you,</div><div>-Mohamed</div></body></html>=

--Apple-Mail=_755AE607-6B94-4988-AB9B-5209C4E3B2AA--

