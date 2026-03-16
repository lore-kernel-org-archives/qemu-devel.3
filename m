Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE3BF46444
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24qH-0007np-Cl; Mon, 16 Mar 2026 06:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w24po-0007gW-C1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:06:06 -0400
Received: from p-west1-cluster5-host1-snip4-4.eps.apple.com ([57.103.66.175]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w24pb-0002Yu-87
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:05:56 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPS id
 546E41800568; Mon, 16 Mar 2026 10:05:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773655546; x=1776247546;
 bh=ydwHkAY1auBlY1evp4miw1u/lUtR8WVY2cfK5ls72nA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=NKhQ4eYLNdSfbLjiNPTZjI4wfGvdSIFWAkSS1qzWSMm1OIXKItmsalqVdehTP7bvqI+xZK4uy5fVZ8fmmSu1C6b7G/RamhZh7g2GZqJsQ9pnbW9OdQzBXayv7KJiryVvX7ER4FQBKNmOacS55g6fzKAXC8PCQzGc+rSOCnAuonZ88+aRUoEm8HKea8UTXiq9ATCxqt97rY3IzLpp3yVD0Yh/sjxuJMtYKi0rDkVW2AgT/2j/YZniZuAhuGGOZvB8U24CzJ3POxc6fNnAWv7W/9YcSAR++eeV5ddHcALK+gdXLah4NQVRYwLrRiWzNfKSZYbRkTBjOBYx9lJtlPBkTg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPSA id
 1FA6D1800F0F; Mon, 16 Mar 2026 10:05:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <560F3847-D525-42CB-B889-B8C501D0B2CA@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_A60EC716-E254-4648-817F-7934B819C01C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
Date: Mon, 16 Mar 2026 11:05:32 +0100
In-Reply-To: <87ikawnmcq.fsf@draig.linaro.org>
Cc: Zenghui Yu <zenghui.yu@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
 <87ikawnmcq.fsf@draig.linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=Dfwaa/tW c=1 sm=1 tr=0 ts=69b7d5f8
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=Q2Tcm2EymWg8q0U7rsUA:9 a=QEXdDO2ut3YA:10
 a=3i-3ziGlWDvPACRBTR4A:9 a=7fWluDsYvjumcxeh:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NyBTYWx0ZWRfX2Ay9qiKc+JPU
 MrrD8inWly9VTr49pdfmqYi+82v7jJY7Kip60126Tgc5M963iFFgrEZKei39s3nmDdL6EkdbBZO
 ppWRT/7mLHHmI9RFABujZnt6YIVhRDOIgg95v04IDMQmJncintROgb593CQu15fX8OS9+3iX95l
 KrV/iJDrh2dzewLh57XwC25TglzXn7fYGwJzH+swyGZje3igwIR4MI/xeRTromu2r3UKEteXJxJ
 N2/6b/n01dvXKguNOX39gYqu3k4Wn/SS2QTg5mhibafsWoplp3Dd9Z+2XWw23fM47HrK2y7GYY2
 K9MWwc5/YS5jD6xsw+r976KT6AtKhjGITqgUOkMV6gdAnv5MiJuz0zdkMmQK+g=
X-Proofpoint-GUID: Ne2Ue96xHbjPafmtbXmFpReYVTSEywGN
X-Proofpoint-ORIG-GUID: Ne2Ue96xHbjPafmtbXmFpReYVTSEywGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160077
Received-SPF: pass client-ip=57.103.66.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


--Apple-Mail=_A60EC716-E254-4648-817F-7934B819C01C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 16. Mar 2026, at 10:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Zenghui Yu <zenghui.yu@linux.dev> writes:
>=20
>> It seems that hvf doesn't deal with the abort generated when guest =
tries to
>> execute instructions outside of the valid physical memory range, for
>> unknown reason. The abort is forwarded to userspace and QEMU doesn't =
handle
>> it either, which ends up with faulting on the same instruction =
infinitely.
>>=20
Hello,

This one is a bit complicated.

We don=E2=80=99t fully implement the whole vmapple device model for =
example
- and I have hacks locally around that to run new macOS releases...

I think at this point that a lot of the exception story would be better =
off
in a common library between backends, like the upcoming =
target/arm/emulate for isv=3D0=E2=80=A6.

Interestingly, behaviour on x86 also has expectations around accessing =
an unmapped memory region, and _that_
is actually leveraged by the Linux kernel with =
https://github.com/torvalds/linux/commit/ab8131028710d009ab93d6bffd2a2749a=
de909b0
only checking CPUID=E2=80=A6=20

>> This was noticed by the kvm-unit-tests/selftest-vectors-kernel =
failure:
>>=20
>>  timeout -k 1s --foreground 90s /opt/homebrew/bin/qemu-system-aarch64 =
\
>>    -nodefaults -machine virt -accel hvf -cpu host \
>>    -device virtio-serial-device -device virtconsole,chardev=3Dctd \
>>    -chardev testdev,id=3Dctd -device pci-testdev -display none \
>>    -serial stdio -kernel arm/selftest.flat -smp 1 -append
>>  vectors-kernel
>=20
> Have you got patches for teaching kvm-unit-tests about hvf or are you
> running these all manually? I tried building on the Mac we have but it
> failed the build and the docs only mention x86.

It builds fine from aarch64-elf cross toolchain and runs as usual with =
accel=3Dhvf.

>=20
>>=20
>>  PASS: selftest: vectors-kernel: und
>>  PASS: selftest: vectors-kernel: svc
>>  qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20
>>  qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20
>>  qemu-system-aarch64: 0xffffc000: unhandled exception ec=3D0x20
>=20
> I think this is running:
>=20
>  static bool check_pabt(void)
>  {
>          enum vector v =3D check_vector_prep();
>=20
>          install_exception_handler(v, ESR_EL1_EC_IABT_EL1, =
pabt_handler);
>=20
>          test_exception("adrp	x9, check_pabt_invalid_paddr\n"
>                         "add	x9, x9, =
:lo12:check_pabt_invalid_paddr\n"
>                         "ldr	x9, [x9]\n",
>                         "blr	x9\n",
>                         "", "x9", "x30");
>=20
>          install_exception_handler(v, ESR_EL1_EC_IABT_EL1, NULL);
>=20
>          return pabt_works;
>  }
>=20
> which is expecting 0x21 - instruction abort at the same exception =
level.
> I wonder why there is the difference.
>=20
>=20
>>  [...]
>>=20
>> It's apparent that the guest is braindead and it's unsure what =
prevents hvf
>> from injecting an abort directly in that case. Try to deal with the =
insane
>> guest in QEMU by injecting an SEA back into it in the EC_INSNABORT
>> emulation path.
>>=20
>> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
>> ---
>> target/arm/hvf/hvf.c | 23 +++++++++++++++++++++++
>> 1 file changed, 23 insertions(+)
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index aabc7d32c1..54d6ea469c 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -2332,9 +2332,32 @@ static int hvf_handle_exception(CPUState *cpu, =
hv_vcpu_exit_exception_t *excp)
>>         bool ea =3D (syndrome >> 9) & 1;
>>         bool s1ptw =3D (syndrome >> 7) & 1;
>>         uint32_t ifsc =3D (syndrome >> 0) & 0x3f;
>> +        uint64_t ipa =3D excp->physical_address;
>> +        AddressSpace *as =3D cpu_get_address_space(cpu, =
ARMASIdx_NS);
>> +        hwaddr xlat;
>> +        MemoryRegion *mr;
>> +
>> +        cpu_synchronize_state(cpu);
>>=20
>>         trace_hvf_insn_abort(env->pc, set, fnv, ea, s1ptw, ifsc);
>>=20
>> +        /*
>> +         * TODO: If s1ptw, this is an error in the guest os page =
tables.
>> +         * Inject the exception into the guest.
>> +         */
>> +        assert(!s1ptw);
>> +
>> +        mr =3D address_space_translate(as, ipa, &xlat, NULL, false,
>> +                                     MEMTXATTRS_UNSPECIFIED);
>> +        if (unlikely(!memory_region_is_ram(mr))) {
>> +            uint32_t syn;
>> +
>> +            /* inject an SEA back into the guest */
>> +            syn =3D syn_insn_abort(arm_current_el(env) =3D=3D 1, ea, =
false, 0x10);
>> +            hvf_raise_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);
>> +            break;
>> +        }
>> +
>>         /* fall through */
>>     }
>>     default:
>=20
> I need the check the exception paths for KVM and TCG. I guess for the
> KVM case it is all in the kernel?

KVM does a whole lot in the kernel that other backends don=E2=80=99t.
Perhaps it=E2=80=99d be a good idea to introduce a reduced capability =
KVM cap that shrinks
the number of things KVM does.

> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>=20


--Apple-Mail=_A60EC716-E254-4648-817F-7934B819C01C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 16. Mar 2026, at 10:40, Alex Benn=C3=A9e =
&lt;alex.bennee@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Zenghui Yu =
&lt;zenghui.yu@linux.dev&gt; writes:<br><br><blockquote type=3D"cite">It =
seems that hvf doesn't deal with the abort generated when guest tries =
to<br>execute instructions outside of the valid physical memory range, =
for<br>unknown reason. The abort is forwarded to userspace and QEMU =
doesn't handle<br>it either, which ends up with faulting on the same =
instruction =
infinitely.<br><br></blockquote></div></div></blockquote>Hello,</div><div>=
<br></div><div>This one is a bit =
complicated.</div><div><br></div><div>We don=E2=80=99t fully implement =
the whole vmapple device model for example</div><div>- and I have hacks =
locally around that to run new macOS =
releases...</div><div><br></div><div>I think at this point that a lot of =
the exception story would be better off</div><div>in a common library =
between backends, like the upcoming target/arm/emulate for =
isv=3D0=E2=80=A6.</div><div><br></div><div>Interestingly, behaviour on =
x86 also has expectations around accessing an unmapped memory region, =
and _that_</div><div>is actually leveraged by the Linux kernel =
with&nbsp;<a =
href=3D"https://github.com/torvalds/linux/commit/ab8131028710d009ab93d6bff=
d2a2749ade909b0">https://github.com/torvalds/linux/commit/ab8131028710d009=
ab93d6bffd2a2749ade909b0</a></div><div>only checking =
CPUID=E2=80=A6&nbsp;</div><div><br><blockquote =
type=3D"cite"><div><div><blockquote type=3D"cite">This was noticed by =
the kvm-unit-tests/selftest-vectors-kernel failure:<br><br> =
&nbsp;timeout -k 1s --foreground 90s =
/opt/homebrew/bin/qemu-system-aarch64 \<br> =
&nbsp;&nbsp;&nbsp;-nodefaults -machine virt -accel hvf -cpu host \<br> =
&nbsp;&nbsp;&nbsp;-device virtio-serial-device -device =
virtconsole,chardev=3Dctd \<br> &nbsp;&nbsp;&nbsp;-chardev =
testdev,id=3Dctd -device pci-testdev -display none \<br> =
&nbsp;&nbsp;&nbsp;-serial stdio -kernel arm/selftest.flat -smp 1 =
-append<br> &nbsp;vectors-kernel<br></blockquote><br>Have you got =
patches for teaching kvm-unit-tests about hvf or are you<br>running =
these all manually? I tried building on the Mac we have but it<br>failed =
the build and the docs only mention =
x86.<br></div></div></blockquote><div><br></div>It builds fine from =
aarch64-elf cross toolchain and runs as usual with =
accel=3Dhvf.</div><div><br><blockquote =
type=3D"cite"><div><div><br><blockquote type=3D"cite"><br> &nbsp;PASS: =
selftest: vectors-kernel: und<br> &nbsp;PASS: selftest: vectors-kernel: =
svc<br> &nbsp;qemu-system-aarch64: 0xffffc000: unhandled exception =
ec=3D0x20<br> &nbsp;qemu-system-aarch64: 0xffffc000: unhandled exception =
ec=3D0x20<br> &nbsp;qemu-system-aarch64: 0xffffc000: unhandled exception =
ec=3D0x20<br></blockquote><br>I think this is running:<br><br> =
&nbsp;static bool check_pabt(void)<br> &nbsp;{<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;enum vector v =3D =
check_vector_prep();<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;install_exception_ha=
ndler(v, ESR_EL1_EC_IABT_EL1, pabt_handler);<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;test_exception("adrp=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>x9, check_pabt_invalid_paddr\n"<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"add=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>x9, x9, :lo12:check_pabt_invalid_paddr\n"<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"ldr=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>x9, [x9]\n",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"blr=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>x9\n",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"", =
"x9", "x30");<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;install_exception_ha=
ndler(v, ESR_EL1_EC_IABT_EL1, NULL);<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
pabt_works;<br> &nbsp;}<br><br>which is expecting 0x21 - instruction =
abort at the same exception level.<br>I wonder why there is the =
difference.<br><br><br><blockquote type=3D"cite"> =
&nbsp;[...]<br><br>It's apparent that the guest is braindead and it's =
unsure what prevents hvf<br>from injecting an abort directly in that =
case. Try to deal with the insane<br>guest in QEMU by injecting an SEA =
back into it in the EC_INSNABORT<br>emulation =
path.<br><br>Signed-off-by: Zenghui Yu =
&lt;zenghui.yu@linux.dev&gt;<br>---<br> target/arm/hvf/hvf.c | 23 =
+++++++++++++++++++++++<br> 1 file changed, 23 insertions(+)<br><br>diff =
--git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c<br>index =
aabc7d32c1..54d6ea469c 100644<br>--- a/target/arm/hvf/hvf.c<br>+++ =
b/target/arm/hvf/hvf.c<br>@@ -2332,9 +2332,32 @@ static int =
hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool ea =3D (syndrome =
&gt;&gt; 9) &amp; 1;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool s1ptw =3D (syndrome =
&gt;&gt; 7) &amp; 1;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t ifsc =3D =
(syndrome &gt;&gt; 0) &amp; 0x3f;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t ipa =3D =
excp-&gt;physical_address;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AddressSpace *as =3D =
cpu_get_address_space(cpu, ARMASIdx_NS);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hwaddr xlat;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion *mr;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_synchronize_state(cpu);<br><=
br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;trace_hvf_insn_abort(env-&=
gt;pc, set, fnv, ea, s1ptw, ifsc);<br><br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* TODO: If s1ptw, this =
is an error in the guest os page tables.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Inject the exception =
into the guest.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert(!s1ptw);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mr =3D =
address_space_translate(as, ipa, &amp;xlat, NULL, false,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MEMTXA=
TTRS_UNSPECIFIED);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(unlikely(!memory_region_is_ram(mr))) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t=
 syn;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* =
inject an SEA back into the guest */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;syn =3D =
syn_insn_abort(arm_current_el(env) =3D=3D 1, ea, false, 0x10);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hvf_rais=
e_exception(cpu, EXCP_PREFETCH_ABORT, syn, 1);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* fall through */<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br> =
&nbsp;&nbsp;&nbsp;&nbsp;default:<br></blockquote><br>I need the check =
the exception paths for KVM and TCG. I guess for the<br>KVM case it is =
all in the kernel?<br></div></div></blockquote><br>KVM does a whole lot =
in the kernel that other backends don=E2=80=99t.</div><div>Perhaps =
it=E2=80=99d be a good idea to introduce a reduced capability KVM cap =
that shrinks</div><div>the number of things KVM =
does.</div><div><br><blockquote type=3D"cite"><div><div>-- <br>Alex =
Benn=C3=A9e<br>Virtualisation Tech Lead @ =
Linaro<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_A60EC716-E254-4648-817F-7934B819C01C--

