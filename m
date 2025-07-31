Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81B6C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 16:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhVjt-0003kK-7S; Thu, 31 Jul 2025 12:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhUZp-0005av-QL
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:48:14 -0400
Received: from p-east3-cluster6-host6-snip4-3.eps.apple.com ([57.103.85.184]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhUZn-0003qm-To
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:48:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 1F995180012D; Thu, 31 Jul 2025 14:48:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=AfGgLIIFWDJ0UirZxanoClukRITpwri5c7ZKkpMCgXQ=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=V7q9lIFJAigvAj8Ifj1H3NxeMmP9KapIBSblAsnYI9Rp2MakZD6RG9lPdjgTSVDmicfcTj33M5UYIa9L8aoAdS7AzsQoBs5tFy1NHFAV/1hwzGH+L/SdfYq6qeCb1WoDCtAgewH2gkJSQ2hMJzqwZ6+ari1nfnpWl4PVsyUowZe2c9UQeYSyj3EQc9MQ9VKYMo/wa6yxeLLuCFlBZrfodIqE6JCJY0F38SefkESkOO6A9+fH8hWuLC7bLJwEEcFE7HIRrSkSZ/ob+lh4QB4zSRpxFVOzAF+uvLTs1PihT6j3RFdWuOb5SAQ0F8L+B2az1E48oTka/CqvCJhFFFLp/A==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 D57521800126; Thu, 31 Jul 2025 14:48:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <A16A7232-61D2-4A19-B76A-28D660EF0C2F@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_71DCC0DF-7ADC-4590-B251-4121D246DFA1"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [RFC 5/9] hw/virt: make Qemu aware that WHPX has a vGICv3
Date: Thu, 31 Jul 2025 16:47:53 +0200
In-Reply-To: <2945e4b1-09c6-43ab-8640-6b7b9cab4a17@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-6-mohamed@unpredictable.fr>
 <2945e4b1-09c6-43ab-8640-6b7b9cab4a17@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: UCKlvAIwKG3WCTzXJBKX8MD5MhvXptes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMSBTYWx0ZWRfX0O65MJ45HrVx
 VmplZUzXG1+S3tKp1a+63JgVz20eAEFN8zxgrXphvLGG9O7XSOTh7zm9PE2WsTLxZETg/5nB64c
 z9IDMk1Ub1INFwBSU2iaWJyhvvyYRM7zoPUNb6/RxQP2Tao010npB4OeBDS4IN7qQKDyVANmXq/
 wYbu4V+itLoCHqehBTZWi/FIHRKHsykkMS3ERkla9WSPzZEV7qiAmXmUeeKtWgUuGIjt2uD1WOB
 Wi8QxFZZUV64Ol+xE4E+Bwa+72vKTHlDrcTNKnIfm+uPY29iWhQ1aqgi5QxkYwb21z471EhJ4=
X-Proofpoint-ORIG-GUID: UCKlvAIwKG3WCTzXJBKX8MD5MhvXptes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 clxscore=1030
 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507310101
Received-SPF: pass client-ip=57.103.85.184;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--Apple-Mail=_71DCC0DF-7ADC-4590-B251-4121D246DFA1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 31. Jul 2025, at 10:35, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 31/7/25 07:27, Mohamed Mediouni wrote:
>> WHPX is a vGICv3-only target without vGICv2 or user-mode irqchip
>> support.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ef6be3660f..4996c2075e 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -49,6 +49,7 @@
>>  #include "system/tcg.h"
>>  #include "system/kvm.h"
>>  #include "system/hvf.h"
>> +#include "system/whpx.h"
>>  #include "system/qtest.h"
>>  #include "hw/loader.h"
>>  #include "qapi/error.h"
>> @@ -2058,6 +2059,8 @@ static void =
finalize_gic_version(VirtMachineState *vms)
>>          /* KVM w/o kernel irqchip can only deal with GICv2 */
>>          gics_supported |=3D VIRT_GIC_VERSION_2_MASK;
>>          accel_name =3D "KVM with kernel-irqchip=3Doff";
>> +    } else if (whpx_enabled()) {
>> +        gics_supported |=3D VIRT_GIC_VERSION_3_MASK;
>>      } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
>>          gics_supported |=3D VIRT_GIC_VERSION_2_MASK;
>>          if (module_object_class_by_name("arm-gicv3")) {
>=20
> Should this patch be the last of the series to avoid breaking
> git bisectability?

Not needed for buildability I think, as system/whpx.h was already =
present before because of x86 whpx



--Apple-Mail=_71DCC0DF-7ADC-4590-B251-4121D246DFA1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 31. Jul 2025, at 10:35, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 31/7/25 07:27, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">WHPX is a vGICv3-only target without vGICv2 or =
user-mode irqchip<br>support.<br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;hw/arm/virt.c | 3 =
+++<br>&nbsp;1 file changed, 3 insertions(+)<br>diff --git =
a/hw/arm/virt.c b/hw/arm/virt.c<br>index ef6be3660f..4996c2075e =
100644<br>--- a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -49,6 +49,7 =
@@<br>&nbsp;#include "system/tcg.h"<br>&nbsp;#include =
"system/kvm.h"<br>&nbsp;#include "system/hvf.h"<br>+#include =
"system/whpx.h"<br>&nbsp;#include "system/qtest.h"<br>&nbsp;#include =
"hw/loader.h"<br>&nbsp;#include "qapi/error.h"<br>@@ -2058,6 +2059,8 @@ =
static void finalize_gic_version(VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* KVM =
w/o kernel irqchip can only deal with GICv2 =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supported=
 |=3D =
VIRT_GIC_VERSION_2_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;accel_name =3D "KVM with kernel-irqchip=3Doff";<br>+ =
&nbsp;&nbsp;&nbsp;} else if (whpx_enabled()) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supported |=3D =
VIRT_GIC_VERSION_3_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else if =
(tcg_enabled() || hvf_enabled() || qtest_enabled()) =
&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supp=
orted |=3D =
VIRT_GIC_VERSION_2_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;if (module_object_class_by_name("arm-gicv3")) =
{<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Should this patch be the =
last of the series to avoid breaking</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">git =
bisectability?</span></div></blockquote></div><br><div>Not needed for =
buildability I think, as system/whpx.h was already present before =
because of x86 whpx</div><div><br></div><div><br></div></body></html>=

--Apple-Mail=_71DCC0DF-7ADC-4590-B251-4121D246DFA1--

