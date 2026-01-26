Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE55CF65C7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJAw-0003RB-S2; Mon, 26 Jan 2026 04:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkJAj-0003PQ-Q9
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:46:16 -0500
Received: from p-east3-cluster5-host5-snip4-5.eps.apple.com ([57.103.86.176]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkJAf-0001lp-RP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:46:12 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 31D5E1800134; Mon, 26 Jan 2026 09:46:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769420765; x=1772012765;
 bh=Q7WGvePqidhXGlRwWRnNT7cu6t1Px8nBBTCJSpGEoEw=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=CCc/81WC4IzO+JmUn+m5vedMsGKZuzpUNuEyE60wJFDh6fC2A/hASx4nkXuc2BozOdN5sQIZPVXY2q/JoxmIMx5N22aOHpqfgglU5O6RfmLx+PMqawdzK5tbNh3EFEVtMoWgWqIy+svxaGfPXBd3zNpD7aJ3o0sAC00MFylQVHm3jyYSWEXW6OBS/2O4RmqymbfPBoqfLcMRduNk9A3uR3X6mutlIvkkyU0pOT3FInA/GOXTI0bVE+qjGJUvHQt6JPzfze9srf6vk30RbLbtAAes3Mgg7yLCaKuZJo8yCejD/M1fnY3pBXD1JrQSfaHA6/vb2lzZtHZlpLr08nSlcg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 B7D571800105; Mon, 26 Jan 2026 09:46:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <A4C5EAC8-5527-48B7-9344-816469344AC3@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C83BD6A3-7D02-4461-8350-AE51F34EDF75"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
Date: Mon, 26 Jan 2026 10:45:50 +0100
In-Reply-To: <CAAjaMXZLG2aBtStRhyvmdENj1Z+Mx05BmDgyYUoYrc_ZnHwyVQ@mail.gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
 <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
 <CAFEAcA9oZ=rhUbw8WK5nUPAvs0TEPCJB8t8ReeViv=0b=_x-sQ@mail.gmail.com>
 <CAAjaMXZLG2aBtStRhyvmdENj1Z+Mx05BmDgyYUoYrc_ZnHwyVQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: LF-dlok7qrzx-GcU_zBEILq505wS12Kl
X-Authority-Info-Out: v=2.4 cv=dvfWylg4 c=1 sm=1 tr=0 ts=697737dc
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=CCpqsmhAAAAA:8 a=KKAkSRfTAAAA:8 a=8D93sAZUnP8VoIqYYvkA:9
 a=QEXdDO2ut3YA:10 a=uZpOMUMpUyOTZhun9u8A:9 a=xN7k2SGs4CtfF72F:21
 a=_W_S_7VecoQA:10 a=ul9cdbp4aOFLsgKbc677:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LF-dlok7qrzx-GcU_zBEILq505wS12Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA4MyBTYWx0ZWRfX7sNpjmIADZG+
 h4PGICSwqWUlm5eLzFFRQPpr+75mEa4zbN/Z3dO9ap8UgGJrMic7RTrI01i/7+AHzKB3hu4GUra
 ZIeoTJOyjFz92MRx39VOjucEZSJ6E+jBGLBYtUb/QP1tnjRpoLof9Yv90QylGRoEl/4OdXDTZYJ
 LS1Otus2/j9Nk8y/dWn4Rkqj06clW+cg7Sjvt8k7eDCa0oUx3S2MXU+Tp0lqvb0zyMTiieThHDD
 Mgw8OW9h+8RD3NcqrbdZWne1ZSvSD8uQsEi1gWuZ8ytdKArGCAlSLUeWMA741UBQzxvsH5b8xln
 T6TvAMyMLtXC71GmaIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1030 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601260083
X-JNJ: AAAAAAABTYIBN+dtSMX5KVu/y5+rvcrocVpup7tnyJ2Acm9e3OjHY3egMgRTrEWX9MKsejeqkBMMWQ2aKjh4DWKV2LjiSL2zWAUc7vS0eCtr6bGkHB85FUsUXZBoW1ZLwov7jfiesvuJV5hE8PgDk6IhkczI30zFygSu2DmenxkON6Brm7Pj5ak6izRxon/PlpbCRIA1qkFmfwp9jJj9bsojVn0p1GgBDKbxsldC/ZLrEwbo38wKw1EkUJjTvJolKvaRa/oarz5P9OZzoxqPmgE+cIN77Tkm0r9Xe7aPiytgaySwy9hf/oMOKRjFv+iHfPuHhhk4laWzDVA1/FqCNGGTxUy7Oa8NMIJcLsHeVrD+zkxH1DLHcLvDI8fKM0rJhwKtA+T7777ItCGC+VMFvlz2X8hNUToRZ/y9QY6OdYfXPbjBIV5RNu2gHDYCyxer4ULMF6ziwLkS36yP/Yg7mLCkGcYjpZajpxPzoIlzAMEohTEa/i0Hgcv10rLUdGIP/ohuLib3NtJRpd5UEkQxzOzv8+BUN8UgLEnucET/yU46O0yMsgD56Q13A+2loxL31CjHxdQH4zr4DDNmABbdu/bkzTRM9AIMH4pHWzwxpEUB1+aPo8yiK/etoJfvZXdGcw6kO9hDBPGgoGRswRdoiO6m64i4ByC1J69vDaUZXixVN15imhCc3lXGA1z0K9TpsQTcCv9PDlK9azPiwb21Ndmm
Received-SPF: pass client-ip=57.103.86.176;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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


--Apple-Mail=_C83BD6A3-7D02-4461-8350-AE51F34EDF75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 26. Jan 2026, at 09:34, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> On Thu, Jan 22, 2026 at 6:52=E2=80=AFPM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Tue, 20 Jan 2026 at 10:02, Manos Pitsidianakis
>> <manos.pitsidianakis@linaro.org> wrote:
>>>=20
>>> On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
>>> <philmd@linaro.org> wrote:
>>>>=20
>>>> On 15/1/26 12:20, Manos Pitsidianakis wrote:
>>>>> Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise =
FEAT_SME2.
>>>>>=20
>>>>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>>> Signed-off-by: Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org>
>>>>> ---
>>>>>  target/arm/cpu.c     |  4 +++-
>>>>>  target/arm/cpu64.c   | 13 ++++++++++++-
>>>>>  target/arm/hvf/hvf.c | 25 +++++++++++++------------
>>>>>  3 files changed, 28 insertions(+), 14 deletions(-)
>>>>>=20
>>>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>>>> index =
caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db6075495119c1b642b=
c2abf295 100644
>>>>> --- a/target/arm/cpu.c
>>>>> +++ b/target/arm/cpu.c
>>>>> @@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, =
Error **errp)
>>>>>           * assumes it, so if the user asked for sve=3Doff then =
turn off SME also.
>>>>>           * (KVM doesn't currently support SME at all.)
>>>>>           */
>>>>> -        if (cpu_isar_feature(aa64_sme, cpu) && =
!cpu_isar_feature(aa64_sve, cpu)) {
>>>>> +        if (!hvf_enabled()
>>>>=20
>>>> In my experience "if(!accel)" is bug prone, maybe change to =
explicit "if
>>>> (tcg_enabled() || kvm_enabled()"?
>>>=20
>>> Shouldn't we list all accelerators instead of just tcg/kvm then?
>>=20
>> This "turn off SME if no SVE" check is principally trying to
>> avoid users hitting a bug / missing feature in TCG where
>> it will assert on startup when the guest tries to write to
>> SMCR_EL1 (see the backtrace in f7767ca3017's commit message),
>> because we accidentally coded in assumptions that any guest
>> with SME also has SVE. We turned it off for all accelerators
>> because (a) at the time there weren't any others which had
>> SME support and (b) we didn't do the investigation to figure
>> out if any of those bogus assumptions were in code that's
>> not TCG-specific. (In our defence, it was just prior to
>> a QEMU release :-))
>>=20
>> To the extent that those accidental assumptions are in code
>> that you can hit with HVF, we need to fix them before we
>> can enable SME-no-SVE in HVF. To the extent that they're TCG
>> specific, the only accelerator we really need to turn
>> this off for is TCG. As the comment notes, right now
>> KVM doesn't support SME so it's impossible to get here
>> with SME in the feature registers.
>>=20
>> If the core code is OK for hvf to enable SME-no-SVE,
>> then it should also be OK for any other accelerator
>> except TCG.
>>=20
>> I don't think hvf can get to the smcr_write() function
>> which is the specific failure we saw with TCG, but
>> I think that it ought to be possible to end up calling
>> sve_vqm1_for_el() if you use the gdbstub with hvf
>> accel, get the guest into streaming SME mode (PSTATE.SM
>> set), and then read the "svg" register that gdb uses to
>> expose the vector granule.
>>=20
>> If giving the SME registers a good workout with the
>> gdbstub interface all seems to work fine, then I think
>> we can adjust this condition to be "if tcg_enabled && ...".
>=20
> gdb had a disastrous workout, because it turns out it also assumes SME
> must have SVE:
>=20
>=20
>  (gdb) target remote localhost:1234
>  Remote debugging using localhost:1234
>  ../../gdb/aarch64-tdep.c:3068: internal-error:
> aarch64_pseudo_register_type: bad register number 160
>  A problem internal to GDB has been detected,
>  further debugging may prove unreliable.
>  Fatal signal: Abort trap: 6
>=20
Hello,

Meanwhile the LLVM side looks un-merged: =
https://github.com/llvm/llvm-project/pull/165413
Maybe having a way to mask SME via =E2=80=9C-cpu host,sme=3Doff=E2=80=9D =
and documenting it would be enough?
> "register number 160" corresponds to pseudoregister regnum
> AARCH64_SVE_V0_REGNUM. Looking at gdb/aarch64-tdep.c, it seems they
> are only supported by checking against `tdep->has_sve ()` [0]
>=20
> Peter: So what do we do on the QEMU side? Merge it and wait till
> upstream gdb fixes it to check for bugs?
>=20
> [0]: =
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/aarch64-=
tdep.c;h=3Df1bdce453db27dffeb42f10fcd44a408f706afb2;hb=3DHEAD#l3116
>=20
>=20
>=20
> --=20
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>=20


--Apple-Mail=_C83BD6A3-7D02-4461-8350-AE51F34EDF75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 26. Jan 2026, at 09:34, Manos Pitsidianakis =
&lt;manos.pitsidianakis@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Thu, Jan 22, 2026 at =
6:52=E2=80=AFPM Peter Maydell &lt;peter.maydell@linaro.org&gt; =
wrote:<br><blockquote type=3D"cite"><br>On Tue, 20 Jan 2026 at 10:02, =
Manos Pitsidianakis<br>&lt;manos.pitsidianakis@linaro.org&gt; =
wrote:<br><blockquote type=3D"cite"><br>On Tue, Jan 20, 2026 at =
11:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9<br>&lt;philmd@linaro.org&gt; =
wrote:<br><blockquote type=3D"cite"><br>On 15/1/26 12:20, Manos =
Pitsidianakis wrote:<br><blockquote type=3D"cite">Starting from M4 cores =
and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.<br><br>Reviewed-by: =
Mohamed Mediouni &lt;mohamed@unpredictable.fr&gt;<br>Signed-off-by: =
Manos Pitsidianakis &lt;manos.pitsidianakis@linaro.org&gt;<br>---<br> =
&nbsp;target/arm/cpu.c &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;4 +++-<br> =
&nbsp;target/arm/cpu64.c &nbsp;&nbsp;| 13 ++++++++++++-<br> =
&nbsp;target/arm/hvf/hvf.c | 25 +++++++++++++------------<br> &nbsp;3 =
files changed, 28 insertions(+), 14 deletions(-)<br><br>diff --git =
a/target/arm/cpu.c b/target/arm/cpu.c<br>index =
caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db6075495119c1b642b=
c2abf295 100644<br>--- a/target/arm/cpu.c<br>+++ =
b/target/arm/cpu.c<br>@@ -1577,7 +1577,9 @@ void =
arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* assumes =
it, so if the user asked for sve=3Doff then turn off SME also.<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* (KVM =
doesn't currently support SME at all.)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (cpu_isar_feature(aa64_sme, =
cpu) &amp;&amp; !cpu_isar_feature(aa64_sve, cpu)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!hvf_enabled()<br></blockquote><br>In my experience "if(!accel)" is bug =
prone, maybe change to explicit "if<br>(tcg_enabled() || =
kvm_enabled()"?<br></blockquote><br>Shouldn't we list all accelerators =
instead of just tcg/kvm then?<br></blockquote><br>This "turn off SME if =
no SVE" check is principally trying to<br>avoid users hitting a bug / =
missing feature in TCG where<br>it will assert on startup when the guest =
tries to write to<br>SMCR_EL1 (see the backtrace in f7767ca3017's commit =
message),<br>because we accidentally coded in assumptions that any =
guest<br>with SME also has SVE. We turned it off for all =
accelerators<br>because (a) at the time there weren't any others which =
had<br>SME support and (b) we didn't do the investigation to =
figure<br>out if any of those bogus assumptions were in code =
that's<br>not TCG-specific. (In our defence, it was just prior to<br>a =
QEMU release :-))<br><br>To the extent that those accidental assumptions =
are in code<br>that you can hit with HVF, we need to fix them before =
we<br>can enable SME-no-SVE in HVF. To the extent that they're =
TCG<br>specific, the only accelerator we really need to turn<br>this off =
for is TCG. As the comment notes, right now<br>KVM doesn't support SME =
so it's impossible to get here<br>with SME in the feature =
registers.<br><br>If the core code is OK for hvf to enable =
SME-no-SVE,<br>then it should also be OK for any other =
accelerator<br>except TCG.<br><br>I don't think hvf can get to the =
smcr_write() function<br>which is the specific failure we saw with TCG, =
but<br>I think that it ought to be possible to end up =
calling<br>sve_vqm1_for_el() if you use the gdbstub with hvf<br>accel, =
get the guest into streaming SME mode (PSTATE.SM<br>set), and then read =
the "svg" register that gdb uses to<br>expose the vector =
granule.<br><br>If giving the SME registers a good workout with =
the<br>gdbstub interface all seems to work fine, then I think<br>we can =
adjust this condition to be "if tcg_enabled &amp;&amp; =
...".<br></blockquote><br>gdb had a disastrous workout, because it turns =
out it also assumes SME<br>must have SVE:<br><br><br> &nbsp;(gdb) target =
remote localhost:1234<br> &nbsp;Remote debugging using =
localhost:1234<br> &nbsp;../../gdb/aarch64-tdep.c:3068: =
internal-error:<br>aarch64_pseudo_register_type: bad register number =
160<br> &nbsp;A problem internal to GDB has been detected,<br> =
&nbsp;further debugging may prove unreliable.<br> &nbsp;Fatal signal: =
Abort trap: =
6<br><br></div></div></blockquote>Hello,</div><div><br></div><div>Meanwhil=
e the LLVM side looks un-merged:&nbsp;<a =
href=3D"https://github.com/llvm/llvm-project/pull/165413">https://github.c=
om/llvm/llvm-project/pull/165413</a></div><div>Maybe having a way to =
mask SME via =E2=80=9C-cpu host,sme=3Doff=E2=80=9D and documenting it =
would be enough?</div><div><blockquote type=3D"cite"><div><div>"register =
number 160" corresponds to pseudoregister =
regnum<br>AARCH64_SVE_V0_REGNUM. Looking at gdb/aarch64-tdep.c, it seems =
they<br>are only supported by checking against `tdep-&gt;has_sve ()` =
[0]<br><br>Peter: So what do we do on the QEMU side? Merge it and wait =
till<br>upstream gdb fixes it to check for bugs?<br><br>[0]: =
https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/aarch64-=
tdep.c;h=3Df1bdce453db27dffeb42f10fcd44a408f706afb2;hb=3DHEAD#l3116<br><br=
><br><br>-- <br>Manos Pitsidianakis<br>Emulation and Virtualization =
Engineer at Linaro =
Ltd<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_C83BD6A3-7D02-4461-8350-AE51F34EDF75--

