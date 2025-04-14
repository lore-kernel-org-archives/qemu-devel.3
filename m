Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E91C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Duu-0001fp-L1; Mon, 14 Apr 2025 03:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4Dur-0001fJ-GP
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:07:37 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4Duo-0006TH-4i
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:07:37 -0400
X-ASG-Debug-ID: 1744614440-086e2365b8bbdb0001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id qUJKHu3mzJBDo1CJ (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 14 Apr 2025 15:07:20 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 14 Apr
 2025 15:07:20 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 14 Apr 2025 15:07:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 14 Apr
 2025 14:56:01 +0800
Message-ID: <a0d83b72-2b19-4209-856d-3a358e1f6b27@zhaoxin.com>
Date: Mon, 14 Apr 2025 14:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
To: Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin
 YongFeng vCPU template
CC: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
 <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
 <a8750eb8-63ad-4ed8-a80d-f4568c4bc778@zhaoxin.com>
 <Z/iK4wVFWTjhEa32@intel.com>
 <d69d169a-9401-4a19-a942-44d540f050d2@zhaoxin.com>
 <c8a0db98-893a-4fb2-836e-becd49375c89@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <c8a0db98-893a-4fb2-836e-becd49375c89@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/14/2025 3:07:18 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1744614440
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4987
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139939
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



On 4/14/25 2:44 PM, Xiaoyao Li wrote:
>=20
> On 4/11/2025 3:42 PM, Ewan Hai wrote:
>>
>>
>> On 4/11/25 11:22 AM, Zhao Liu wrote:
>>>
>>> On Thu, Apr 10, 2025 at 10:07:15PM +0800, Ewan Hai wrote:
>>>> Date: Thu, 10 Apr 2025 22:07:15 +0800
>>>> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
>>>> Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin
>>>> YongFeng
>>>> =C2=A0 vCPU template
>>>>
>>>> On 4/10/25 8:22 PM, Paolo Bonzini wrote:
>>>>>
>>>>> On 4/7/25 04:07, Ewan Hai wrote:
>>>>>> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac=
4.
>>>>>> The correct value is 0x5b. This mistake occurred because the extende=
d
>>>>>> model bits in cpuid[eax=3D0x1].eax were overlooked, and only the bas=
e
>>>>>> model was used.
>>>>>>
>>>>>> This patch corrects the model field.
>>>>>
>>>>> Hi, please follow commit e0013791b9326945ccd09b5b602437beb322cab8 to
>>>>> define a new version of the CPU.
>>>>
>>>> I=E2=80=99ve noticed that in the QEMU repository at commit
>>>> e0013791b9326945ccd09b5b602437beb322cab8 (as HEAD), the following
>>>> patches I
>>>> previously submitted (which the Zhaoxin YongFeng vCPU model depends
>>>> on) are
>>>> not included:
>>>
>>> :-) e0013791b9326945ccd09b5b602437beb322cab8 is an example case to show
>>> how to fix model id.
>>>
>>>> - 5d20aa540b6991c0dbeef933d2055e5372f52e0e: "target/i386: Add support
>>>> for
>>>> Zhaoxin CPU vendor identification"
>>>> - c0799e8b003713e07b546faba600363eccd179ee: "target/i386: Add CPUID le=
af
>>>> 0xC000_0001 EDX definitions"
>>>> - ff04bc1ac478656e5d6a255bf4069edb3f55bc58: "target/i386: Introduce
>>>> Zhaoxin
>>>> Yongfeng CPU model" (this is the main patch that needs to be fixed)
>>>> - a4e749780bd20593c0c386612a51bf4d64a80132: "target/i386: Mask
>>>> CMPLegacy bit
>>>> in CPUID[0x80000001].ECX for Zhaoxin CPUs"
>>>>
>>>> Should I resend the entire patchset, or would it be sufficient to
>>>> just send
>>>> a revised version of the =E2=80=9Ctarget/i386: Introduce Zhaoxin Yongf=
eng CPU
>>>> model=E2=80=9D
>>>> patch?
>>>
>>> IIUC, because this fix is planning to land in v10.1 (next release
>>> cycle), current CPU model (will be released in v10.0) can't be modified
>>> directly. It is only possible to directly modify an unreleased CPU mode=
l
>>> during the same release cycle.
>>>
>>> Thus it's enough to just introduce a v2 and correct your model id like
>>> this:
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 1b64ceaaba46..1ca1c3a729e8 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -5621,6 +5621,17 @@ static const X86CPUDefinition
>>> builtin_x86_defs[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .features[FEAT_V=
MX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .xlevel =3D 0x80=
000008,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model_id =3D "Z=
haoxin YongFeng Processor",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .versions =3D (X86CPUVersio=
nDefinition[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .=
version =3D 1 },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .version =3D 2,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .props =3D (PropValue[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "model", "0x5b" },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of list */ }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /=
* end of list */ }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0 };
>>>
>>
>> Thanks again for your patience and explanation.
>>
>> I'm not entirely sure if this is the best approach. I have one thought,
>> and I'd like your help to confirm whether I'm on the right track or not.
>> From what I can tell, most other vCPU definitions that use the .versions
>> mechanism do so incrementally: for instance, they add new features in
>> v2, v3, etc., but each of those versions (v1, v2, v3) remains valid for
>> practical use.
>>
>> However, in our specific case, the v1 version of the Zhaoxin vCPU
>> definition has an incorrect .model value, which breaks the Linux guest's
>> vPMU functionality. That makes me uncertain whether using new version
>> definitions to fix this issue is really the best solution. After all, v1
>> itself would remain problematic.
>>
>> Do you have any thoughts on whether it might be better to correct the
>> existing definition, or do you think the versioned approach is still the
>> recommended path? I appreciate any input or guidance you can provide.
>>
>=20
> If changing the @model value directly, it will introduce user visible
> change. E.g., live migrating from old QEMU to new QEMU, the guest will
> find the model number changes.
>=20
> That's why versioned CPU model was introduced. It becomes the fact
> already that YongFeng-v1 has model id 11 and broken vpmu. If user create
> vcpu with YongFeng-v1, user has to accept it. If user wants a working
> vpmu, go and use YongFeng-v2
>=20

Got it. Thanks for the explanation.
I'll send a new fix patch as soon as possible.


