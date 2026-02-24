Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA990E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqbp-0002gA-ON; Tue, 24 Feb 2026 06:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuqbn-0002fS-MI
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:29:44 -0500
Received: from ci-2003b-snip4-1.eps.apple.com ([57.103.91.142]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuqbk-0005yA-RP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:29:43 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id
 540731801C94; Tue, 24 Feb 2026 11:29:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771932579; x=1774524579;
 bh=f5lEtBIYA2RDP3sph8d8jG2bX9xl/apQ3J9B1QG6f9I=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=FvwI9c+gV4h6PrCBChT7VZ2knJMIC2X9xaK9rQipyoZsatpEhxVxTMoFVdIRpKynv59cfEjBMZ8ERyzqNHrvJ5u2MyUlSU2/oseXyZnSw7zmrfdRZysq5Yx9DiTpT0r5jmsJTdT7F1A9CR6Qd02sN+Cw6nN9JWamN5EwViNhE1IXIT6qX/bQutSgHhDhGDvl+irB8JfssvsjslcIXkasq78/gI2u+EuSGClRGF6AV+yokJyX8cO1t2brS3pjVhr3Er5bG1SpYZdHcEZHBO3mUQX7pF8cfUBOEsoCXsnvjd05wxPX0taH9FZVNodTcKlH0sVULoI+rI4HL3DofPx8EA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id
 AF6271801CBA; Tue, 24 Feb 2026 11:29:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <2502A540-B199-4310-B457-B797CE4DCA42@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1097E229-A16B-4A51-BE40-B2D34E915A48"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 25/28] whpx: i386: inject exceptions
Date: Tue, 24 Feb 2026 12:29:21 +0100
In-Reply-To: <b0297c7a-70d1-458c-8ae4-39a6583f6a41@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
 <20260223233950.96076-26-mohamed@unpredictable.fr>
 <b0297c7a-70d1-458c-8ae4-39a6583f6a41@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: -59bQr48suyw4_ERACvw-wz7KBa18AF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5MiBTYWx0ZWRfX7q9PWxhMescO
 LYHbLEOv+atlteDNmfAkkGMPYXzQLzynmxPKp0XgxHEPPWvhmmtlskh0TPFb5Bv1PMkuv/naBzr
 Ql6IoE+R9s6A7TMxmP4KVp4XtiVL17eSWB+o1axGUqywgyc4QJW04s9HosYNJfyhcwpwGaLaQLb
 ToF8xEJNSMEnmBdWfxfhWTHrKO2U2ddRLapjTeJ/Nz7wFfSwON/klRBzjuJpCf8CK4qJfnESuUS
 dIDdWTC0HTDdO2jAACSqeJ7pdj7K0VONNY8c+UJT9K5ROYL5S3Q+HcKhqVZjnL2f9sgYo7qlGNq
 mLtiRX0tANBQbMSsluJpni39XdtTudIkxicwoKOqLIGr6xa3TzaoFL9gVMgHbw=
X-Authority-Info-Out: v=2.4 cv=WItyn3sR c=1 sm=1 tr=0 ts=699d8ba1
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=mxXg7-MiAAAA:20
 a=20KFwNOVAAAA:8 a=zZ5bwPEQCaYx6c-6SBUA:9 a=QEXdDO2ut3YA:10
 a=mgdu8sh8Y2HbHtj-eeoA:9 a=LU2eZxbh6nR-ia5a:21 a=_W_S_7VecoQA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: -59bQr48suyw4_ERACvw-wz7KBa18AF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240092
X-JNJ: AAAAAAABD+1SOosf/fcPSF5PqAcW2+ps0ZeWXeWRHrwCCnADdRKFAaIJ7ZAnNSgSWjF5SLZJzM0uOVUbygeIstUW6LMjwUMVkGafLaDCcXeewU8s9GXEzpcFpoVxgnTY5WbYOhp5kXOZk976oumIDI3L5qnuS3onryIi7acF654GzSTJXbInHZKM5ID+LtelAmM3lrdYhZsfK65Gw7ghYh4FT5f5gbMZDWSOo8ursVHAEs03bRHTzgefPEMVWPqOGrE48248G3hvIZ6O2zNeJ5cZuom8+6n56kMQj7s6xi0Zj1HDFiGytNJgdnjTmf5cZDc7dx2GLGPN7TUPvJzy5u5MnPAnybKjga7bWl9pxchxW8iTX8rZiRPw4uq4rhd7vaUHCsKXf7QU76H60vzhUZ3wVg6kCJQRLEc7MzsjGyHKkLWGYlh8kJFYpcHSRswv4YuvllnjhBWG97OWyaduKIOQmjiLRuQUwEKH6xxNW0+d++9+rXQsrgTGaMTgO7xo4ljPMDXd845xFS1/cFMnCeEF488TPzBs35Xq3hX0t7xe3vFnrTY0PCjMwN4VRURE97O3IXFTHEvwi+5Jx+x64mNEuSS6Vde25Pb8U44fdNLubxuTPylapmW6PAjIxTyf5x6J7VnFT5xQdUgceD2tBpXEBkKrRd1dUoCu+QHhZznGqapFhnwP/aiYuJLp/KLJc8xrEzOuKCdkvD0ON+SqnmSlqIBw55yYeOxmVngYM43uDlHhgi8YsrAXxdbLyfAhqedAkURuakOudRMHDpMh30hIYUt+2w1qGUpG1776y8H/gnncN4jk63F2w6YMXGy1Dr/YpUGZuGc4Q9CYUbuJlJQb
Received-SPF: pass client-ip=57.103.91.142;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_1097E229-A16B-4A51-BE40-B2D34E915A48
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 24. Feb 2026, at 10:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 2/24/26 00:39, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> diff --git a/target/i386/whpx/whpx-all.c =
b/target/i386/whpx/whpx-all.c
>> index 561a48206c..0259782a82 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -1506,6 +1506,26 @@ static void =
whpx_vcpu_process_async_events(CPUState *cpu)
>>      }
>>  }
>>  +static void whpx_inject_exceptions(CPUState* cpu)
>> +{
>> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
>> +    CPUX86State *env =3D &x86_cpu->env;
>> +
>> +    if (env->exception_injected) {
>> +        env->exception_injected =3D 0;
>> +        WHV_REGISTER_VALUE reg =3D {};
>> +        reg.ExceptionEvent.EventPending =3D 1;
>> +        reg.ExceptionEvent.EventType =3D =
WHvX64PendingEventException;
>> +        reg.ExceptionEvent.DeliverErrorCode =3D 1;
>=20
> I can't find very good documentation of the WHPX API, but does this =
need to be limited to: 1) #DF/#TS/#NP/#SS/#GP/#PF/#AC vectors; 2) =
CR0.PE=3D1?
>=20
> Thanks,
>=20
> Paolo

Hello,

There=E2=80=99s no (maintained) documentation other than the headers for =
WHP unfortunately, but there shouldn't be limitations in particular on =
the injectable exception types.

The headers have a comment that say that the event type has to be =
WHvX64PendingEventException but not much else: =
https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/main/vi=
rtualization/api/hypervisor-platform/headers/WinHvPlatformDefs.h#L1012

=46rom a cursory test, #DB and #UD don=E2=80=99t look to be blocked by =
WHP.

And as of CR0.PE=3D1, that=E2=80=99s handled earlier on before the =
creation of the exception
instead of injection time, as part of the walker helpers at =
target/i386/emulate/x86_mmu.c.

Thanks,
-Mohamed=

--Apple-Mail=_1097E229-A16B-4A51-BE40-B2D34E915A48
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 24. Feb 2026, at 10:49, Paolo Bonzini =
&lt;pbonzini@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 2/24/26 00:39, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;target/i386/whpx/whpx-all=
.c | 22 ++++++++++++++++++++++<br>&nbsp;1 file changed, 22 =
insertions(+)<br>diff --git a/target/i386/whpx/whpx-all.c =
b/target/i386/whpx/whpx-all.c<br>index 561a48206c..0259782a82 =
100644<br>--- a/target/i386/whpx/whpx-all.c<br>+++ =
b/target/i386/whpx/whpx-all.c<br>@@ -1506,6 +1506,26 @@ static void =
whpx_vcpu_process_async_events(CPUState =
*cpu)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;}<br>&nbsp;+static =
void whpx_inject_exceptions(CPUState* cpu)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;X86CPU *x86_cpu =3D X86_CPU(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;CPUX86State *env =3D &amp;x86_cpu-&gt;env;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (env-&gt;exception_injected) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;env-&gt;exception_injected =3D =
0;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE reg =
=3D {};<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg.ExceptionEvent.EventPending =
=3D 1;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg.ExceptionEvent.EventType =3D=
 WHvX64PendingEventException;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg.ExceptionEvent.DeliverErrorC=
ode =3D 1;<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">I can't find very good documentation of the =
WHPX API, but does this need to be limited to: 1) =
#DF/#TS/#NP/#SS/#GP/#PF/#AC vectors; 2) CR0.PE=3D1?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
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
display: inline !important;">Thanks,</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
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
display: inline =
!important;">Paolo</span></div></blockquote></div><div>Hello,</div><div><b=
r></div><div>There=E2=80=99s no (maintained) documentation other than =
the headers for WHP unfortunately, but there shouldn't be limitations in =
particular on the injectable exception =
types.</div><div><br></div><div>The headers have a comment that say that =
the event type has to be WHvX64PendingEventException but not much =
else:&nbsp;<a =
href=3D"https://github.com/MicrosoftDocs/Virtualization-Documentation/blob=
/main/virtualization/api/hypervisor-platform/headers/WinHvPlatformDefs.h#L=
1012">https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/m=
ain/virtualization/api/hypervisor-platform/headers/WinHvPlatformDefs.h#L10=
12</a></div><div><br></div><div>=46rom a cursory test, #DB and #UD =
don=E2=80=99t look to be blocked by WHP.</div><div><br></div><div>And as =
of CR0.PE=3D1, that=E2=80=99s handled earlier on before the creation of =
the exception</div><div>instead of injection time, as part of the walker =
helpers at =
target/i386/emulate/x86_mmu.c.</div><div><br></div><div>Thanks,</div><div>=
-Mohamed</div></body></html>=

--Apple-Mail=_1097E229-A16B-4A51-BE40-B2D34E915A48--

