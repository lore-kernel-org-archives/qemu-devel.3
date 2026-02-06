Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFBAEE2086
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJEZ-0006Xq-8Y; Fri, 06 Feb 2026 05:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1voJEX-0006Xh-24
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:38:41 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1voJEU-00008D-EP
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770374314; x=1770979114; i=deller@gmx.de;
 bh=93R8zBHUW5vP0zmQk76aFGUHCotsYKxMfATqwYglGYE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LGBSHhIvqGTJ5XIqDor86xjWWAVqHXTwdq2apSMfvAGDsb0UbfuxfoDzi4MTaLuY
 F0EuG63/a/c09l760lO9pAEacioOe0Hmh5/qqorSSF8C/8RGyqZFNV3BBHlSSx7Ax
 C7eW0PKa5s9+JztBZvasrlGC4xEJwkQE9sr1sIVoSq1kdeauINTcnQaFM7QQDn1I1
 RSH03oe06PSJTMv5rMaWeHV+/y2cz77OoQ8E9yO5cJPRhSxW+k+iW216mmrYiXToD
 heezeJKTIYnIOH1G2p1lujsoTMjfN5dIe+heYO3J0cpjFLU3q3Ez35YhuDNvhPv4h
 rRjRqGsaH1hbb6jQqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1vuNm80uDO-00DunA; Fri, 06
 Feb 2026 11:38:34 +0100
Message-ID: <edeb98cb-6511-46fe-a3ca-42a0ee330044@gmx.de>
Date: Fri, 6 Feb 2026 11:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] target/hppa: Define PA[20|1X] physical address
 space size
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn
References: <20260112-phys_addr-v3-0-5f90fdb4015f@rev.ng>
 <20260112-phys_addr-v3-2-5f90fdb4015f@rev.ng>
 <a96d6954-4242-4358-ad85-cc170749e736@linaro.org>
 <vny3gezfqo3wmwbjdcg64wxjt6mfhhp47pqfj5dlrbyr5urbwh@ijszrun7nwwq>
 <aYVB68PA1Qh7jEyZ@hive.localdomain>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aYVB68PA1Qh7jEyZ@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RCJXz4eZ++wNmKju1lJed01JvnB2uZmFhqKd/A9AiIKdRNNgfFi
 x8qUp1GXn1lJuLkUW1vP0Y/ZzBptntJRhBch+a9/sS8WG3z5x7+C9XjI3ZXak22Dcqas5Xl
 RKIPfn4dOcSUs8HqGA+2WYhE51Y0WBYm5slD7MRg26nYGpRXh95FSms+jjikE90AZmwAdht
 otaPJBZCKk+QESho1cnzw==
UI-OutboundReport: notjunk:1;M01:P0:ApfsVMQNsKs=;PEGVzjxOOWGfmpwHWnPIjrG1+vt
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/6/26 02:59, Anton Johansson wrote:
> On 14/01/26, Anton Johansson wrote:
>> On 12/01/26, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 12/1/26 13:22, Anton Johansson wrote:
>>>> When converting virtual to physical addresses,
>>>> TARGET_PHYS_ADDR_SPACE_BITS is used under PA-RISC 2.0, and an explici=
t
>>>> cast to uint32_t is used under PA-RISC 1.X.  Replace the former with =
a
>>>> more specific macro limited to mem_helper.c, and make the latter
>>>> conversion explicit by defining the size of the physical address spac=
e
>>>> for PA-RISC 1.X.
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>>> ---
>>>>    target/hppa/mem_helper.c | 23 ++++++++++++++++++-----
>>>>    1 file changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
>>>> index cce82e6599..8563bb0e2a 100644
>>>> --- a/target/hppa/mem_helper.c
>>>> +++ b/target/hppa/mem_helper.c
>>>> @@ -29,6 +29,19 @@
>>>>    #include "hw/core/cpu.h"
>>>>    #include "trace.h"
>>>> +/*
>>>> + * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-=
bit
>>>> + * machines 7300LC.  This gives 44 and 32 bits of physical address s=
pace
>>>> + * respectively.
>>>> + *
>>>> + *   CPU model        Physical address space bits
>>>> + *   PA-7000--7300LC  32
>>>> + *   PA-8000--8600    40
>>>> + *   PA-8700--8900    44
>>>> + */
>>>> +#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 44
>>>> +#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
>>>> +
>>>>    hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>>>>    {
>>>>        /*
>>>> @@ -42,8 +55,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>>>>         * Since the supported physical address space is below 54 bits=
, the
>>>>         * H-8 algorithm is moot and all that is left is to truncate.
>>>>         */
>>>> -    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
>>>> -    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
>>>> +    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
>>>> +    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
>>>>    }
>>>>    hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>>>> @@ -67,7 +80,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>>>>             * is what can be seen on physical machines too.
>>>>             */
>>>>            addr =3D (uint32_t)addr;
>>>> -        addr |=3D -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>>>> +        addr |=3D -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
>>>>        }
>>>>        return addr;
>>>>    }
>>>> @@ -217,7 +230,7 @@ int hppa_get_physical_address(CPUHPPAState *env, =
vaddr addr, int mmu_idx,
>>>>                if (hppa_is_pa20(env)) {
>>>>                    phys =3D hppa_abs_to_phys_pa2_w0(addr);
>>>>                } else {
>>>> -                phys =3D (uint32_t)addr;
>>>> +                phys =3D extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BIT=
S_PA1X);
>>>>                }
>>>>                break;
>>>>            default:
>>>> @@ -558,7 +571,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_=
ulong r1,
>>>>        /* Align per the page size. */
>>>>        ent->pa &=3D TARGET_PAGE_MASK << mask_shift;
>>>>        /* Ignore the bits beyond physical address space. */
>>>> -    ent->pa =3D sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
>>>> +    ent->pa =3D sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA2=
0);
>>>>        ent->t =3D extract64(r2, 61, 1);
>>>>        ent->d =3D extract64(r2, 60, 1);
>>>>
>>>
>>> Patch LGTM but fails on CI on 2 distinct jobs...
>>>
>>> 166/793 func-quick+func-hppa - qemu:func-hppa-seabios          TIMEOUT
>>> 90.05s   killed by signal 15 SIGTERM
>>>
>>> 209/276 qemu:func-quick+func-hppa / func-hppa-seabios
>>> TIMEOUT         180.04s   (exit status 143 or signal 15 SIGTERM)
>>>
>>> Works with:
>>>
>>> -- >8 --
>>> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
>>> index 40d28435aa8..e7a26398c5a 100644
>>> --- a/target/hppa/mem_helper.c
>>> +++ b/target/hppa/mem_helper.c
>>> @@ -82,3 +82,3 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>>>           addr =3D (uint32_t)addr;
>>> -        addr |=3D -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>>> +        addr |=3D -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 8);
>>>       }
>>> ---
>>>
>>> PA-8000--8600 case with 40 bits?
>>
>> Ouch!
>>
>> AFAICT SeaBIOS runs on a C3700 (PA-8700) which is supposed to have a
>> 44-bit physical address space.  I've tried to look around for any other
>> assumption of 40-bit physical addresses in QEMU and SeaBIOS but not
>> found anything yet..
>=20
> Gave this another go, from what I can tell SeaBIOS uses 40-bit physical
> addresses, see here for the firmware start and end addresses
>=20
>    https://github.com/hdeller/seabios-hppa/blob/master/src/parisc/hppa_h=
ardware.h#L9
>    https://github.com/hdeller/seabios-hppa/blob/master/src/parisc/pafirm=
ware.lds.S#L15
>=20
> taking firmware start as an example, with the 44-bit physical address
> space we map the 32-bit absolute address 0xf0000000 to the physical
> address 0xf00f0000000, instead of 0xf0f0000000 which is the start addres=
s
> in the SeaBIOS image.  Searching for f0f0* more 40-bit PDC address can
> be found.  So I guess the test should run on a PA-8000--8600 machine
> like C3600 instead..
>=20
> I'll revert to using 40 bits for the physical address, and add a
> comment since I'm not sure if there are other discrepencies between
> C3600/3700 lurking.

Anton, thanks for looking into it!
I plan to add support for PA8700-PA8900 CPUs as well.
The new A400 machine support in my SeaBIOS "devel-v22" branch is the begin=
ning
to support 64-bit only (PAT) machines with PA8800/PA8900 CPUs.

I wonder if it's somehow possible to support both 40 and 44 bits in a easy=
 way?
E.g. adjusting SeaBIOS and qemu and always utilize 44 bits for the 64-bit =
CPUs?

Helge

