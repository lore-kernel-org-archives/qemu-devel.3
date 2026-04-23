Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C9FC0359
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw6l-0002ea-D6; Thu, 23 Apr 2026 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFw6X-0002dU-1F
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:36:39 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFw6T-0000gC-Og
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776958586; x=1777563386; i=deller@gmx.de;
 bh=ovRjcfEclcOo6JzpkPA/9gQ07TevjWrICsG8ojv1+R8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LVa/FJTL4vXxgiO1dROlQuzyqGcHNiB9Q23oN9e6xpzMEg+vsGvj/iqCwuS5sWC7
 OtKuqxmkQ1Xu1ym+Z0SDBjHVMSHJyaXucqOMWwuEkpCyyMGg8z/Ca1i/qyfWbsz3P
 UjhitqWeOrKcp+lt+XcEdkhR0lj0dimMFatokfVQGF3kNwWLIWsrGzCUcJMbpO9Zj
 hrlS/OxiQ8t0n4PDQs11b/7EtYr3AtaUu4KyyNEWrKhKtQIgqat1nTso7lGRcH6dg
 hGw1PD56KEZyptdw+QQh1yjKFKJHIvtztr5Cfm78s/Yec/mqfp1Tv/jyq2z15phZ4
 4THaLNkGzVeIYb4+Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1wHJ9D1Fv3-00HGr1; Thu, 23
 Apr 2026 17:36:26 +0200
Message-ID: <23e33b6a-acca-4e01-aa3e-d702aa45ea4c@gmx.de>
Date: Thu, 23 Apr 2026 17:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 pierrick.bouvier@posteo.net,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gaosong <gaosong@loongson.cn>
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
 <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
 <ff06a5b1-f36f-ccc9-3d8d-90f3fed1320c@loongson.cn>
 <CAFsMJvDO8CPt1xAYMBc9JWEE6FPsvNZjwAtWEAsQjVoMneTUNw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFsMJvDO8CPt1xAYMBc9JWEE6FPsvNZjwAtWEAsQjVoMneTUNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qIVZPsgEVMohSmP0oM7qSMynv2niWm9d2lUKoJ2FEV89CtUMgf
 ixvEKAldUWu2tGIQKOrxGuLBBH7SiH6jXwtFozEAPeHbbiL7uoZ6EKorDfTrKkt6fyq3Kem
 XEPMpWBvhxami/S7P5sPbgZevH1pAYI8u9yMg8nnsE656Vh8ovExyK2Nafwe/vDQPxPppg2
 on17+8P4WFLC/INTEM3ZA==
UI-OutboundReport: notjunk:1;M01:P0:Dg3NVOorGEg=;XzMoJMYpRqJFyv18Bb9rgeX5ZRM
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/16/26 21:14, Gyorgy Tamasi wrote:
> Hi Peter,
>=20
> Your analysis cleared some things related to this older changeset:
> https://github.com/qemu/qemu/commit/c52e405968341b1d10c618f23bdbb841e39f=
9255
>=20
> Before this syscall-NR 79 & 80 (newfstatat & fstat) was not enumerated
> in the old/deleted (non-generated)
> linux-user/loongarch64/syscall_nr.h=E2=80=8E...but these appeared again =
in the
> newly created linux-user/loongarch64/syscall.tbl=E2=80=8E.
>=20
> I can recall that I was getting "Unknown syscall" messages for 79 &
> 80, when I tried to run qemu-user 8.x.x even with the simplest ABI 1.0
> executable, because even the shared-lib loading phase failed on these
> missing syscalls 79 & 80 (used by the old glibc env of that ABI 1.0
> exe). So in the case of that older qemu-user 8.x.x it was obvious that
> it is not compatible with ABI 1.0.

I've applied this patch to the linux-user for-next git tree at:
https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dheads

I've added the comments from Peter to the commit message.
Peter suggested to adjust the commit message.
Gyorgy: If you want to resend the patch with a rephrased commit message, I=
'm happy to take it.

Furthermore: Do we want to backport this patch to earlier qemu releases?

Helge

>=20
> Thanks,
> -tgy
>=20
> On Thu, Apr 16, 2026 at 2:28=E2=80=AFPM gaosong <gaosong@loongson.cn> wr=
ote:
>>
>> =E5=9C=A8 2026/4/16 =E4=B8=8A=E5=8D=8812:06, Gyorgy Tamasi =E5=86=99=E9=
=81=93:
>>> Hi,
>>>
>>> This is a very simple change within a broader and more complex logical
>>> context. It has an important property: it targets a single specific
>>> QEMU configuration (LOONGARCH64) and has no possible side effects for
>>> other configurations. Additionally, it can only have a positive effect
>>> in any context (in any QEMU fork) when the modified code is
>>> executed=E2=80=94even in non-standard or unexpected scenarios, such as
>>> attempting to run an ABI 1.0 binary using a qemu-user-loongarch64
>>> build intended for ABI 2.0. In such cases, if the limited (non-ABI
>>> 2.0=E2=80=93specific) feature set of the ABI 1.0 application happens t=
o allow
>>> execution, this change still behaves safely. In this sense, it follows
>>> a fundamental principle of software bug fixing (and medicine): primum
>>> non nocere (=E2=80=9Cfirst, do no harm=E2=80=9D). =F0=9F=99=82
>>>
>>> I understand that we are currently in the middle of an important
>>> transition period, during which even traditionally =E2=80=9COld World=
=E2=80=9D (ABI
>>> 1.0=E2=80=93dependent) LoongArch64 Linux distributions are releasing t=
heir
>>> =E2=80=9CNew World=E2=80=9D (ABI 2.0=E2=80=93specific) versions.
>>>
>>> I do not feel qualified to estimate the duration of the next phase of
>>> this transition, namely the replacement of ABI 1.0 OS installations
>>> with ABI 2.0 versions in the end-user base. If a company plans to
>>> release something for LoongArch64 now, and its goal is to make it
>>> available to as many users as possible, building for ABI 2.0=E2=80=94a=
nd
>>> optionally also for ABI 1.0=E2=80=94may still be a reasonable choice (=
provided
>>> a sufficiently large number of users are still on ABI 1.0 systems
>>> before they upgrade).
>>>
>>> My (admittedly very specific) personal perspective: I do not yet have
>>> access to real LoongArch64 hardware, so I have been testing both ABI
>>> 2.0 and ABI 1.0 LA64 binaries using different qemu-user versions (even
>>> if this is not a typical use case). Since I have already applied this
>>> modification in my own qemu-user builds, the issue no longer affects
>>> me. Therefore, I can accept that this fix may not be integrated into
>>> the official QEMU branches (given that it concerns the now phasing-out
>>> ABI 1.0). The decision is beyond my scope.
>> Hi,
>>
>> Thank you for your explanation. QEMU 11.0 is currently in the RC4 stage=
,
>> so I believe we can merge this patch in the next cycle.
>> Thank you again for your contribution to QEMU.
>>
>>
>> Thanks.
>> Song Gao
>>> Best regards,
>>> -tgy
>>>
>>>
>>> On Mon, Apr 13, 2026 at 5:04=E2=80=AFAM gaosong <gaosong@loongson.cn> =
wrote:
>>>> =E5=9C=A8 2026/4/11 =E4=B8=8B=E5=8D=886:39, Gyorgy Tamasi =E5=86=99=
=E9=81=93:
>>>>>>> This changeset was the last mod of syscall_defs.h - but it still
>>>>>>> incorrectly modifies the condition of struct target_stat64 usage:
>>>>>>> (~ "Add Loongarch64 old ABI support")
>>>>>>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547b=
be45c2e864be99
>>>>>>> (line 2006)
>>>>>>> -----
>>>>>>> -#if !defined(TARGET_RISCV64)
>>>>>>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>>> I think this patch has nothing to do with ABI 1.0/2.0, it really fi=
xed
>>>>>> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
>>>>>> Huacai
>>>>> But here the added "|| defined(TARGET_LOONGARCH64)" part doesn't fix
>>>>> that affected bug similar to RISCV[32] vs. RISCV64...you need "&&
>>>>> !defined(TARGET_LOONGARCH64)" here to create an effect for
>>>>> TARGET_LOONGARCH64 similar to the proper solution for TARGET_RISCV64
>>>>> (~ disable the use of this struct target_stat64 with 32bit sec/nsec
>>>>> fields for a glibc environment where 64bit sec/nsecs are used - the
>>>>> default struct target_stat is perfect for these 64bit envs, do not l=
et
>>>>> TARGET_HAS_STRUCT_STAT64 to be defined). [This 2nd embedded "||
>>>>> defined(TARGET_LOONGARCH64)" within an other encapsulating "||
>>>>> defined(TARGET_LOONGARCH64)" #elif-section is effectively a no-op he=
re
>>>>> (the 2nd is always true, if the encapsulating 1st was true)...it doe=
s
>>>>> not effectively change the behaviour of its conditional
>>>>> code-fragment-body in the actual context...comparing to the original
>>>>> "#if !defined(TARGET_RISCV64)" full-line.]
>>>>>
>>>>> How the contexts of LoongArch64 ABI1.0 vs. ABI2.0 are linked to this
>>>>> issue (related to an optional code-path in qemu/linux-user/syscall.c=
)?
>>>>> The answer:
>>>>> The existence of this bug does not directly depend on or linked to a=
ny
>>>>> difference of core features of LA64's ABI1.0 vs. ABI2.0.
>>>>> The difference in behaviour of ABI1.0 and ABI2.0 environments relate=
d
>>>>> to this qemu-code-part here strictly depends on the behaviour of
>>>>> specific glibc versions used by those LA64 ABI1.0 and ABI2.0
>>>>> environments.
>>>>>
>>>>> In the ABI1.0 env of glibc-2.28-7cdc44d5a1 used by Loongson's gcc 8.=
3
>>>>> rc1.6 a stat-like call (filling up a struct stat instance) IS NOT
>>>>> always routed via the statx syscall, newfstatat can be used
>>>>> instead!...and the processing of this newfstatat triggers the usage =
of
>>>>> the problematic code-path in qemu/linux-user/syscall.c having this
>>>>> bug, related to the host_to_target_stat64() function, where this cod=
e
>>>>> fragment prefers to use struct target_stat64 (instead of struct
>>>>> target_stat), if its use is enabled by
>>>>> defined(TARGET_HAS_STRUCT_STAT64):
>>>>> (~ around line 7975 in the 10.2.2 source)
>>>>> #if defined(TARGET_HAS_STRUCT_STAT64)
>>>>>            struct target_stat64 *target_st;
>>>>> #else
>>>>>            struct target_stat *target_st;
>>>>> #endif
>>>>>
>>>>> While in the ABI2.0 env of glibc of this gcc
>>>>> https://github.com/loongson/build-tools/releases/download/2025.08.08=
/x86_64-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz
>>>>> from https://github.com/loongson/build-tools (glibc:
>>>>> https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz) ALL stat-like calls
>>>>> ARE ROUTED via the statx syscall, so the problematic code path of
>>>>> host_to_target_stat64() IS NOT used/triggered at all (and processing
>>>>> path of the statx syscall in linux-user/syscall.c is correct). This
>>>>> behaviour of glibc-2.42 can be determined by these definitions in
>>>>> glibc-2.42/sysdeps/unix/sysv/linux/loongarch/fixup-asm-unistd.h:
>>>>> -----
>>>>> /* To avoid the messy usage of the fstat, newfstatat, and statx syst=
em calls, we
>>>>> only use statx.  */
>>>>> #undef __NR_fstat
>>>>> #undef __NR_newfstatat
>>>>> -----
>>>>>
>>>>> -tgy
>>>> Hi,
>>>>
>>>> Thank you for your explanation.
>>>>
>>>> I confirm that the same issue exists in the 9.2-tcg-old branch, and y=
ou have clearly identified the root cause of the problem.
>>>> There is no doubt that the patch itself is fine, but what confuses me=
 is that you attempted to run (ABI 1.0.0) using QEMU (ABI 2.0),
>>>> which led to the misconception that QEMU (2.0) is compatible with 1.0=
, when in fact QEMU has never been compatible with 1.0.
>>>> As far as I understand, the differences between the ABI 2.0 and ABI 1=
.0 environments should be quite significant.
>>>>
>>>> Therefore, I am unsure whether we should accept this patch.
>>>> Should we submit this patch to the 9.2-tcg-0ld branch?
>>>> Or should you consider discontinuing support for ABI 1.0? To my knowl=
edge, ABI 2.0 has now become the mainstream standard.
>>>>
>>>> Thanks.
>>>> Song Gao
>>>>
>>>>> On Sat, Apr 11, 2026 at 10:24=E2=80=AFAM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
>>>>>> On Sat, Apr 11, 2026 at 10:09=E2=80=AFAM Gyorgy Tamasi <gyorgy.tama=
si@gmail.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thanks for the link of this separate Loongson-maintained 9.2-tcg-o=
ld
>>>>>>> branch - intended for use specifically with ABI 1.0 code.
>>>>>>>
>>>>>>> This separate branch still contains the same bug (in the context o=
f
>>>>>>> the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - wher=
e
>>>>>>> fstatat syscall can be used by glibc, and it can trigger the usage=
 of
>>>>>>> the related erroneous data-conversion workflow based on  struct
>>>>>>> target_stat64 with 4byte sec/nsec fields):
>>>>>>>
>>>>>>> This changeset was the last mod of syscall_defs.h - but it still
>>>>>>> incorrectly modifies the condition of struct target_stat64 usage:
>>>>>>> (~ "Add Loongarch64 old ABI support")
>>>>>>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547b=
be45c2e864be99
>>>>>>> (line 2006)
>>>>>>> -----
>>>>>>> -#if !defined(TARGET_RISCV64)
>>>>>>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>>> I think this patch has nothing to do with ABI 1.0/2.0, it really fi=
xed
>>>>>> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
>>>>>>
>>>>>> Huacai
>>>>>>
>>>>>>> -----
>>>>>>>
>>>>>>> This is the broader context in this 9.2-tcg-old original version:
>>>>>>> Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
>>>>>>> no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64=
)"
>>>>>>> is true/false.
>>>>>>> -----
>>>>>>> #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
>>>>>>>            || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || =
\
>>>>>>>            defined(TARGET_LOONGARCH64)
>>>>>>> /* These are the asm-generic versions of the stat and stat64 struc=
tures */
>>>>>>>
>>>>>>> #define TARGET_STAT_HAVE_NSEC
>>>>>>> struct target_stat {
>>>>>>> ...
>>>>>>> };
>>>>>>>
>>>>>>> #if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>>>> #define TARGET_HAS_STRUCT_STAT64
>>>>>>> struct target_stat64 {
>>>>>>> ...
>>>>>>> };
>>>>>>> #endif
>>>>>>>
>>>>>>> #elif defined(TARGET_HPPA)
>>>>>>> -----
>>>>>>>
>>>>>>> The correct fix is the same here (~ disable the use of this struct
>>>>>>> target_stat64 - instead of explicitly enabling it for
>>>>>>> TARGET_LOONGARCH64 with the "|| defined(...)" part):
>>>>>>> -----
>>>>>>> ~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori sys=
call_defs.h
>>>>>>> --- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
>>>>>>> +++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
>>>>>>> @@ -2003,7 +2003,7 @@
>>>>>>>         abi_uint __unused5;
>>>>>>>     };
>>>>>>>
>>>>>>> -#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>>>> +#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
>>>>>>>     #define TARGET_HAS_STRUCT_STAT64
>>>>>>>     struct target_stat64 {
>>>>>>>         abi_ullong st_dev;
>>>>>>> -----
>>>>>>>
>>>>>>> The same test-scenario of
>>>>>>> https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
>>>>>>> [with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-ol=
d
>>>>>>> toolset] to show exactly the same bad & good test results - withou=
t &
>>>>>>> with this mod.
>>>>>>>
>>>>>>> Just a personal experience based side-note on ABI1.0 compatibility
>>>>>>> with mainline qemu (~10.2.2):
>>>>>>> I'm working on porting a quite large code-base (a commercial OCR &
>>>>>>> document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...=
and
>>>>>>> I'm trying to check correctness of my actual builds using the
>>>>>>> regression-test package of this codebase. It runs quite complex
>>>>>>> workflows of general CLI code. I accept that this is not a
>>>>>>> comprehensive test with all of the edge cases or touching every
>>>>>>> special areas (like signal handling) of compatibility of ABI1.0 an=
d
>>>>>>> mainline qemu, but...the ABI1.0 version of this test-code seems to=
 be
>>>>>>> able to run with mainline qemu-user 10.2.2.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> -tgy
>>>>>>>
>>>>>>> On Fri, Apr 10, 2026 at 11:37=E2=80=AFAM gaosong <gaosong@loongson=
.cn> wrote:
>>>>>>>> =E5=9C=A8 2026/4/9 =E4=B8=8B=E5=8D=888:14, Gyorgy Tamasi =E5=86=
=99=E9=81=93:
>>>>>>>>> Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>>>>>>>>>
>>>>>>>>> Additional independent testing (bug + fix cases) is documented h=
ere -
>>>>>>>>> see comments by sourav/@kishu279:
>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/work_items/3371
>>>>>>>> Hi.
>>>>>>>> Please note that QEMU is not compatible with ABI 1.0.
>>>>>>>>
>>>>>>>> If you absolutely must use ABI 1.0, the branch below is the versi=
on we use.
>>>>>>>> https://github.com/loongson/qemu/commits/9.2-tcg-old/
>>>>>>>>
>>>>>>>> However, this branch is quite far from the mainline.
>>>>>>>> The QEMU mainline follows the kernel mainline, and
>>>>>>>> I believe this is the case for other architectures as well.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>> Song Gao
>>>>>>>>> On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
>>>>>>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>>>>>> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
>>>>>>>>>>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
>>>>>>>>>>> TARGET_LOONGARCH64 are defined!) we can not use the struct
>>>>>>>>>>> target_stat64 for data-transfer, since this struct target_stat=
64 is
>>>>>>>>>>> defined for 32bit environments with its int-sized (4byte) st_*=
time
>>>>>>>>>>> sec/nsec components.
>>>>>>>>>>> The user side compiler headers of the LoongArch64 env uses lon=
g-sized
>>>>>>>>>>> (8byte) st_*time sec/nsec components.
>>>>>>>>>>>
>>>>>>>>>>> (This is similar to the case of 32bit vs. 64bit RISCV: the ori=
ginal
>>>>>>>>>>> code does not use struct target_stat64 in 64bit RISCV env, whe=
n both
>>>>>>>>>>> TARGET_RISCV and TARGET_RISCV64 are defined.)
>>>>>>>>>>>
>>>>>>>>>>> This fix is important for LoongArch64 ABI1.0, where stat() is =
using an
>>>>>>>>>>> fstatat syscall with this struct target_stat64, if its usage i=
s
>>>>>>>>>>> enabled.
>>>>>>>>>>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, wher=
e this
>>>>>>>>>>> problematic struct target_stat64 is not used, struct statx is =
correct
>>>>>>>>>>> in the LoongArch64 env.)
>>>>>>>>>>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/33=
71
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       linux-user/syscall_defs.h | 2 +-
>>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>=20


