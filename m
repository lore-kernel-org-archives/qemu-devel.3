Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CA9E78D6A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNHt-0002pl-3C; Mon, 09 Feb 2026 04:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vpNHp-0002pY-Us
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 04:10:29 -0500
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vpNHn-0006cM-8B
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 04:10:29 -0500
X-ASG-Debug-ID: 1770628218-1eb14e02ad00ec0001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx2.zhaoxin.com with ESMTP id ELt8Yug0DnhU4jBC (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 09 Feb 2026 17:10:18 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 9 Feb
 2026 17:10:17 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 9 Feb 2026 17:10:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 9 Feb
 2026 17:03:50 +0800
Received: from [10.28.44.3] (EwanHaiuntuMini.zhaoxin.com [10.28.44.3])
 by ewan-server.zhaoxin.com (Postfix) with ESMTP id AFBD12D0004E;
 Mon,  9 Feb 2026 04:03:49 -0500 (EST)
Message-ID: <24c9693a-8554-46c7-8619-a440d2bcc022@zhaoxin.com>
Date: Mon, 9 Feb 2026 17:03:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
To: Paolo Bonzini <pbonzini@redhat.com>, <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX
 comment in Yongfeng model
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
 <b3632083-f8ff-4127-a488-05a2c7acf1ad@redhat.com>
 <65edadda-9e8e-4673-947a-13fc4b1a25ef@zhaoxin.com>
 <ac50822f-393f-4057-9d7d-aa4e1595d528@redhat.com>
Content-Language: en-US
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ac50822f-393f-4057-9d7d-aa4e1595d528@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 2/9/2026 5:10:16 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1770628218
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2639
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.154263
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
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

On 2/9/26 4:48 PM, Paolo Bonzini wrote:
>=20
>=20
> On 2/9/26 09:15, Ewan Hai wrote:
>> On 2/7/26 9:44 PM, Paolo Bonzini wrote:
>>>
>>>
>>> On 1/9/26 03:10, Ewan Hai wrote:
>>>> Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
>>>> accurately list the missing features instead of the generic TODO messa=
ge.
>>>>
>>>> As background, current Zhaoxin CPUs implement several CPUID.(EAX=3D0xC=
0000001,
>>>> ECX=3D0):EDX feature bits that are not yet defined in the Linux kernel=
, for
>>>> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_E=
N,
>>>> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
>>>>
>>>> We previously tried to upstream all these extra feature bits in one pa=
tch
>>>> (https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxi=
n.com/),
>>>> but the maintainer rejected it because there was no in-tree code using=
 these
>>>> features yet. So our current plan is to add the CPUID bits together wi=
th real
>>>> kernel users step by step, Once full or partial in-tree implementation=
s of
>>>> these features are merged, we will update these definitions accordingl=
y and
>>>> potentially introduce corresponding support in QEMU.
>>>
>>> KVM now has a mechanism for introducing feature bits separately from th=
e
>>> kernel.=C2=A0 Feel free to resumit using that mechanism, then we can in=
clude
>>> them from the beginning in Shinjidadao.
>>>
>>> Thanks,
>>>
>>> Paolo
>>
>> Hi Paolo,
>>
>> Thanks for pointing out that KVM has a mechanism for introducing feature=
 bits
>> independently from the kernel.
>>
>> Before I start working on the patches, I'd like to clarify a few things:
>>
>> 1. Which specific mechanism are you referring to?
>> =C2=A0=C2=A0=C2=A0 a) The kvm_only_cpuid_leafs enum + kvm_cpu_cap_init_k=
vm_defined()?
>> =C2=A0=C2=A0=C2=A0 b) Or some other approach, given that CPUID_C000_0001=
_EDX is already
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a kernel-defined leaf (word 5)?
>=20
> You can just add X86_FEATURE_* in arch/x86/kvm/reverse_cpuid.h.=C2=A0 For
> example:
>=20
> /* Intel-defined sub-features, CPUID level 0x00000007:1 (EDX) */
> #define X86_FEATURE_AVX_VNNI_INT8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM=
_X86_FEATURE(CPUID_7_1_EDX, 4)
> #define X86_FEATURE_AVX_NE_CONVERT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM_X86_=
FEATURE(CPUID_7_1_EDX, 5)
> #define X86_FEATURE_AMX_COMPLEX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KVM_X86_FEATURE(CPUID_7_1_EDX, 8)
> #define X86_FEATURE_AVX_VNNI_INT16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM_X86_=
FEATURE(CPUID_7_1_EDX, 10)
> #define X86_FEATURE_PREFETCHITI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
> #define X86_FEATURE_AVX10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVM_X86_FEATURE(CPUID_7_1_EDX, 19)
>=20
>=20
> Paolo
>=20

Got it. Thanks!


