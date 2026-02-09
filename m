Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9610ECA5FEB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMXd-0000AM-9K; Mon, 09 Feb 2026 03:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vpMXa-00007L-Ml
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:22:42 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vpMXX-0003m2-DY
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:22:42 -0500
X-ASG-Debug-ID: 1770625343-086e234e4c012f0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id x54UVS1Ji4iuAOlo (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 09 Feb 2026 16:22:23 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 9 Feb
 2026 16:22:23 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 9 Feb 2026 16:22:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 9 Feb
 2026 16:15:33 +0800
Received: from [10.28.44.3] (EwanHaiuntuMini.zhaoxin.com [10.28.44.3])
 by ewan-server.zhaoxin.com (Postfix) with ESMTP id EA1B52D00050;
 Mon,  9 Feb 2026 03:15:32 -0500 (EST)
Message-ID: <65edadda-9e8e-4673-947a-13fc4b1a25ef@zhaoxin.com>
Date: Mon, 9 Feb 2026 16:15:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
To: Paolo Bonzini <pbonzini@redhat.com>, <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX
 comment in Yongfeng model
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
 <b3632083-f8ff-4127-a488-05a2c7acf1ad@redhat.com>
Content-Language: en-US
In-Reply-To: <b3632083-f8ff-4127-a488-05a2c7acf1ad@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 2/9/2026 4:22:15 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1770625343
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3216
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.154262
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/7/26 9:44 PM, Paolo Bonzini wrote:
>=20
>=20
> On 1/9/26 03:10, Ewan Hai wrote:
>> Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
>> accurately list the missing features instead of the generic TODO message=
.
>>
>> As background, current Zhaoxin CPUs implement several CPUID.(EAX=3D0xC00=
00001,
>> ECX=3D0):EDX feature bits that are not yet defined in the Linux kernel, =
for
>> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
>> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
>>
>> We previously tried to upstream all these extra feature bits in one patc=
h
>> (https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.=
com/),
>> but the maintainer rejected it because there was no in-tree code using t=
hese
>> features yet. So our current plan is to add the CPUID bits together with=
 real
>> kernel users step by step, Once full or partial in-tree implementations =
of
>> these features are merged, we will update these definitions accordingly =
and
>> potentially introduce corresponding support in QEMU.
>=20
> KVM now has a mechanism for introducing feature bits separately from the
> kernel.=C2=A0 Feel free to resumit using that mechanism, then we can incl=
ude
> them from the beginning in Shinjidadao.
>=20
> Thanks,
>=20
> Paolo

Hi Paolo,

Thanks for pointing out that KVM has a mechanism for introducing feature bi=
ts
independently from the kernel.

Before I start working on the patches, I'd like to clarify a few things:

1. Which specific mechanism are you referring to?
   a) The kvm_only_cpuid_leafs enum + kvm_cpu_cap_init_kvm_defined()?
   b) Or some other approach, given that CPUID_C000_0001_EDX is already
      a kernel-defined leaf (word 5)?

2. Should this independent introduction be limited to CPUID_C000_0001_EDX o=
nly
For other feature words, I assume they still need to be handled on a
case-by-case basis depending on their semantics and QEMU support status, co=
rrect?

For context: I want to add SM2/SM3/SM4/RNG2/PHE2/RSA etc. bits to
0xC0000001.EDX, but these features don't have in-tree kernel users yet.

Thanks,
Ewan

>> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
>> ---
>> =C2=A0 target/i386/cpu.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 34e3e66344..10603eeb31 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6958,8 +6958,8 @@ static const X86CPUDefinition builtin_x86_defs[] =
=3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_80=
00_0007_EDX] =3D CPUID_APM_INVTSC,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: When the Linux=
 kernel introduces other existing definitions
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for this leaf, remem=
ber to update the definitions here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * missing: SM2/SM2_EN,=
 CCS/CCS_EN, PARALLAX/PARALLAX_EN,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TM3/TM3_EN, RNG2/RNG=
2_EN, PHE2/PHE2_EN, RSA/RSA_EN
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_C0=
00_0001_EDX] =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
>=20


