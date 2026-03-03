Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8114EDEBF4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWXd-0004hV-Jo; Tue, 03 Mar 2026 15:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWXb-0004hH-W7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:40:28 -0500
Received: from p-west3-cluster4-host1-snip4-9.eps.apple.com ([57.103.74.180]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWXZ-0005Cj-82
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:40:27 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 2D88A180019C; Tue,  3 Mar 2026 20:40:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772570422; x=1775162422;
 bh=OFwb2uOCDlQeV+pmH0avS3ee6+zN38nIQ8f3BKYP8nk=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=DIHQWhUfhFJ9Sjlzyxe/QNXJsOXIt4GG7OXom+ERMicWlkdQeWVpApM+qb9JEIP9AMAZCpqWiYhXpwTa2J44gR1GZF49u5phODAfv4oxN/pKKDC3uepLL8RzUmwNOG1XwdZ+XSSd7Dfxpmig0NQjwtroCbQ8cHhNvEKg/hdE8oGgZA4VuSbxW5Nx/1XCHo/1gv8PTBikSLiMQIr0PLWP+Smsddx+EaKHakJYjAt413GeBsjtrf2PEzB2vTZTmwn30ITkXvM80t93hYPB9S3RQRtkCXavcrNrGGvzXAoLkiUl1Dc1mbTl0l0ESiInb4Nb108YcGlnKOClHT2WCYBP+w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 CDAE018001A7; Tue,  3 Mar 2026 20:40:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <BE45EC79-CC3B-40BE-A211-EF0ECDA4F82C@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_52AA0F16-1A7E-4FEA-839D-C2C0B549DA6A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 20/28] hvf: i386: save/restore CR0/2/3
Date: Tue, 3 Mar 2026 21:40:04 +0100
In-Reply-To: <fce1ca77-fdd3-424f-9dff-eef789526fa8@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
 <20260223233950.96076-21-mohamed@unpredictable.fr>
 <fce1ca77-fdd3-424f-9dff-eef789526fa8@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=R9oO2NRX c=1 sm=1 tr=0 ts=69a74735
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=ha_ofOWIjzeisTP-1KIA:9 a=QEXdDO2ut3YA:10 a=mE678OqdOOWXuf51JREA:9
 a=LLfhMUBVRP0H3FWg:21 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ytpmr1EsEmIKbGXeiybuvh872JGITeQK
X-Proofpoint-ORIG-GUID: Ytpmr1EsEmIKbGXeiybuvh872JGITeQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2OSBTYWx0ZWRfX5axC0Ghp/s6G
 /b5PuGpx8S7+wBpCb/G58Ae1AW+TprsrSo2F6ByC2/E0d58TAncewHdsfMy94+Gb69d80uG0YYx
 V+yJ7vOBEwx7AzUtcjDQEE2zFvJVBUU4pziNG3b/0kMOq/dHmdpEe+PchIY7b5B058AZTPHftHj
 qC4DzFr7WUHWUfIXN42Suyv4Pe9NGAvmTno0/oDMeRRc6TBCaemBHKAbQkHA45O1UJ1kiRTiYwX
 pA79J6q/T64F8K+CoG2I6+HmLjsYbMbc39dgMUmDeftloHfz5ibRBq1/LEXFFbV5wTFmiIBzNJp
 htHydIUnJSfk+AMQdV2TqI6/rkJga9XCX8erumLFpwgj0Ib9O8KTET7vCArl8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030169
X-JNJ: AAAAAAABYCBu1V0K96w+bK5uKL8cXqTLGNZOxUHL2u/DD6XmM9qiF0pv6keDeMNhs07EYcyWVsw3TFUgfVUqlYBiQlYno1sj+Ik8j0TD08MdTnhmNl80++uwBso3hzO3fTmUzIqqteShjLzMX4P4uSmvxqPZVci99LxIVtUKA28TP1rWIe/8VA5w91uWLWNSzZbh/Q/0p4h4ydma6DpATX3F1f4cJTzWnZ2rLZW10qEsUOJKYMnjElm3fDfio1WRZ2pPhkvTN93kRql9kZ86xstsee6DgWTxFps4P9Zd2mrlmgsOEa0JB9TL+bVP9muFKVrsfW21VmuCyukPuxty5nbTHWYYt9d4sec9x4hpTU0MjEjPBKZGneMYOhsRpMCT6BfwE58CiJTH7Mew46HRDiyAqDsvPAaPtByV9yg3vAbtr6tCd1yui1KG4uJPPW4wlOEJow24Nu9+rm5ImdK+zgY9E8mogklSE6b0TrHtxUOnyj4R80aaYtYsqbDmP0YVfPJ1GxypeCIAGu3fR5n26NtAz15rRVafsOKKO0yjaRLM3IAu5ShgcjZnek9LXeyE9hYE9qfkBXv5M2zvCqUqQeFcjbwjDGw7cSJdo8ZX8Grk6s/vwiDPua/2rcmHrS6vdJd2Vd6+ldY62Uyn+yunWnefchrIXyQXRatpxXOwekol6fqgdFpgvLzuDK916GpGlQnmj2t3urU5OF1BIvi+/PApXdP+d4WxZ1Un3+FMj9Iw4ucejYx/1UL9iQR0k8LfvnPpa3ww1iVixIOsY0IzmIjqkKJHlzePquA/d27vp3cxmHVAX+EmRkbgLRLf1/PuDJyEL7p97RYj78nDLMpcPzBXkYqYCGUP
Received-SPF: pass client-ip=57.103.74.180;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


--Apple-Mail=_52AA0F16-1A7E-4FEA-839D-C2C0B549DA6A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 3. Mar 2026, at 20:03, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 2/23/26 3:39 PM, Mohamed Mediouni wrote:
>> For symmetry, save/restore the same set of registers even when not =
needed.
>> CR2 save/restore needed as page faults injected to the guest imply =
modifying CR2.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/i386/hvf/hvf.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>> index fb039ff7bd..a70f8461b0 100644
>> --- a/target/i386/hvf/hvf.c
>> +++ b/target/i386/hvf/hvf.c
>> @@ -477,7 +477,19 @@ static void hvf_load_crs(CPUState *cs)
>>        env->cr[0] =3D rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
>>      env->cr[3] =3D rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
>> +    env->cr[2] =3D rreg(cpu->accel->fd, HV_X86_CR2);
>>  }
>> +
>> +static void hvf_save_crs(CPUState *cs)
>> +{
>> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
>> +    CPUX86State *env =3D &x86_cpu->env;
>> +
>> +    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
>> +    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
>> +    wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
>> +}
>> +
>>  void hvf_load_regs(CPUState *cs)
>>  {
>>      X86CPU *cpu =3D X86_CPU(cs);
>> @@ -794,6 +806,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>>              decode_instruction(env, &decode);
>>              exec_instruction(env, &decode);
>>              hvf_store_regs(cpu);
>> +            hvf_save_crs(cpu);
>>              break;
>>          }
>>          break;
>> @@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>>          assert(ins_len =3D=3D decode.len);
>>          exec_instruction(env, &decode);
>>          hvf_store_regs(cpu);
>> +        hvf_save_crs(cpu);
>>            break;
>>      }
>> @@ -942,6 +956,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>>          decode_instruction(env, &decode);
>>          exec_instruction(env, &decode);
>>          hvf_store_regs(cpu);
>> +        hvf_save_crs(cpu);
>>          break;
>>      }
>>      case EXIT_REASON_TPR: {
>=20
> This patch doesn't compile.
> See a fixing patch I'll let you upstream.
> I'm a bit puzzled about how this has been tested though.
>=20
> If you don't have access to a Mac intel based, you can use a =
github-runner for free [1].
>=20
Hello,

My bad, I had this tested locally but I I screwed up on a rebase=E2=80=A6

Thank you,
-Mohamed
> [1] https://github.com/second-reality/github-runners
>=20
> Regards,
> Pierrick<0001-target-i386-hvf-hvf.c-fix-compilation.patch>


--Apple-Mail=_52AA0F16-1A7E-4FEA-839D-C2C0B549DA6A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 3. Mar 2026, at 20:03, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 2/23/26 3:39 PM, Mohamed Mediouni =
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
text-decoration-thickness: auto; text-decoration-style: solid;">For =
symmetry, save/restore the same set of registers even when not =
needed.<br>CR2 save/restore needed as page faults injected to the guest =
imply modifying CR2.<br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;target/i386/hvf/hvf.c | =
15 +++++++++++++++<br>&nbsp;1 file changed, 15 insertions(+)<br>diff =
--git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c<br>index =
fb039ff7bd..a70f8461b0 100644<br>--- a/target/i386/hvf/hvf.c<br>+++ =
b/target/i386/hvf/hvf.c<br>@@ -477,7 +477,19 @@ static void =
hvf_load_crs(CPUState =
*cs)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;env-&gt;cr[0] =3D =
rvmcs(cpu-&gt;accel-&gt;fd, =
VMCS_GUEST_CR0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;env-&gt;cr[3] =3D =
rvmcs(cpu-&gt;accel-&gt;fd, VMCS_GUEST_CR3);<br>+ =
&nbsp;&nbsp;&nbsp;env-&gt;cr[2] =3D rreg(cpu-&gt;accel-&gt;fd, =
HV_X86_CR2);<br>&nbsp;}<br>+<br>+static void hvf_save_crs(CPUState =
*cs)<br>+{<br>+ &nbsp;&nbsp;&nbsp;X86CPU *x86_cpu =3D X86_CPU(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;CPUX86State *env =3D &amp;x86_cpu-&gt;env;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;wvmcs(cpu-&gt;accel-&gt;fd, VMCS_GUEST_CR0, =
env-&gt;cr[0]);<br>+ &nbsp;&nbsp;&nbsp;wvmcs(cpu-&gt;accel-&gt;fd, =
VMCS_GUEST_CR3, env-&gt;cr[3]);<br>+ =
&nbsp;&nbsp;&nbsp;wreg(cs-&gt;accel-&gt;fd, HV_X86_CR2, =
env-&gt;cr[2]);<br>+}<br>+<br>&nbsp;void hvf_load_regs(CPUState =
*cs)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;X86CPU *cpu =3D =
X86_CPU(cs);<br>@@ -794,6 +806,7 @@ static int =
hvf_handle_vmexit(CPUState =
*cpu)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;decode_instruction(env, =
&amp;decode);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;exec_instruction(env, =
&amp;decode);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;hvf_store_regs(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf_save=
_crs(cpu);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<=
br>@@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState =
*cpu)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert(ins_=
len =3D=3D =
decode.len);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exec=
_instruction(env, =
&amp;decode);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf=
_store_regs(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf_save_crs(cpu);<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;}<br>@@ -942,6 +956,7 @@ static int =
hvf_handle_vmexit(CPUState =
*cpu)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;decode_inst=
ruction(env, =
&amp;decode);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exe=
c_instruction(env, =
&amp;decode);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf=
_store_regs(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf_save_crs(cpu);<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case EXIT_REASON_TPR: =
{<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
display: inline !important;">This patch doesn't compile.</span><br =
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
display: inline !important;">See a fixing patch I'll let you =
upstream.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
display: inline !important;">I'm a bit puzzled about how this has been =
tested though.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
display: inline !important;">If you don't have access to a Mac intel =
based, you can use a github-runner for free [1].</span><br =
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
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote>Hello,</div><div><br></div><div>My bad, I had =
this tested locally but I I screwed up on a =
rebase=E2=80=A6</div><div><br></div><div>Thank =
you,</div><div>-Mohamed<br><blockquote type=3D"cite"><div><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">[1]<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://github.com/second-reality/github-runners" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://github.com/second-reality/github-runners</a><br =
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
display: inline !important;">Regards,</span><br style=3D"caret-color: =
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
display: inline !important;">Pierrick</span><span =
id=3D"cid:8FF2D541-3872-423C-BA7C-98CD2422EAD2">&lt;0001-target-i386-hvf-h=
vf.c-fix-compilation.patch&gt;</span></div></blockquote></div><br></body><=
/html>=

--Apple-Mail=_52AA0F16-1A7E-4FEA-839D-C2C0B549DA6A--

