Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE8F8A160
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLpv-00017e-B0; Thu, 16 Apr 2026 08:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wDLpm-00017N-5O
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:28:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wDLph-00081j-JN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:28:37 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxI_Dn1eBpsCMBAA--.4937S3;
 Thu, 16 Apr 2026 20:28:23 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDx6+Db1eBpwX1uAA--.14624S3;
 Thu, 16 Apr 2026 20:28:19 +0800 (CST)
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 pierrick.bouvier@posteo.net
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
 <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ff06a5b1-f36f-ccc9-3d8d-90f3fed1320c@loongson.cn>
Date: Thu, 16 Apr 2026 20:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDx6+Db1eBpwX1uAA--.14624S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3KryrZw1UCF47CFWDtFWrWFX_yoW8GrWfZo
 W3Jr4xJw4xJr1rZF4qk39rJFy7Ww1UCr15JrW7X348GFnIqw1UGw1xJ3yrXFWayF95Ka98
 Ja45Jan8ZFWxJF93l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
 43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jU
 sqXUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.135,
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

在 2026/4/16 上午12:06, Gyorgy Tamasi 写道:
> Hi,
>
> This is a very simple change within a broader and more complex logical
> context. It has an important property: it targets a single specific
> QEMU configuration (LOONGARCH64) and has no possible side effects for
> other configurations. Additionally, it can only have a positive effect
> in any context (in any QEMU fork) when the modified code is
> executed—even in non-standard or unexpected scenarios, such as
> attempting to run an ABI 1.0 binary using a qemu-user-loongarch64
> build intended for ABI 2.0. In such cases, if the limited (non-ABI
> 2.0–specific) feature set of the ABI 1.0 application happens to allow
> execution, this change still behaves safely. In this sense, it follows
> a fundamental principle of software bug fixing (and medicine): primum
> non nocere (“first, do no harm”). 🙂
>
> I understand that we are currently in the middle of an important
> transition period, during which even traditionally “Old World” (ABI
> 1.0–dependent) LoongArch64 Linux distributions are releasing their
> “New World” (ABI 2.0–specific) versions.
>
> I do not feel qualified to estimate the duration of the next phase of
> this transition, namely the replacement of ABI 1.0 OS installations
> with ABI 2.0 versions in the end-user base. If a company plans to
> release something for LoongArch64 now, and its goal is to make it
> available to as many users as possible, building for ABI 2.0—and
> optionally also for ABI 1.0—may still be a reasonable choice (provided
> a sufficiently large number of users are still on ABI 1.0 systems
> before they upgrade).
>
> My (admittedly very specific) personal perspective: I do not yet have
> access to real LoongArch64 hardware, so I have been testing both ABI
> 2.0 and ABI 1.0 LA64 binaries using different qemu-user versions (even
> if this is not a typical use case). Since I have already applied this
> modification in my own qemu-user builds, the issue no longer affects
> me. Therefore, I can accept that this fix may not be integrated into
> the official QEMU branches (given that it concerns the now phasing-out
> ABI 1.0). The decision is beyond my scope.
Hi,

Thank you for your explanation. QEMU 11.0 is currently in the RC4 stage,
so I believe we can merge this patch in the next cycle.
Thank you again for your contribution to QEMU.


Thanks.
Song Gao
> Best regards,
> -tgy
>
>
> On Mon, Apr 13, 2026 at 5:04 AM gaosong <gaosong@loongson.cn> wrote:
>> 在 2026/4/11 下午6:39, Gyorgy Tamasi 写道:
>>>>> This changeset was the last mod of syscall_defs.h - but it still
>>>>> incorrectly modifies the condition of struct target_stat64 usage:
>>>>> (~ "Add Loongarch64 old ABI support")
>>>>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c2e864be99
>>>>> (line 2006)
>>>>> -----
>>>>> -#if !defined(TARGET_RISCV64)
>>>>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
>>>> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
>>>> Huacai
>>> But here the added "|| defined(TARGET_LOONGARCH64)" part doesn't fix
>>> that affected bug similar to RISCV[32] vs. RISCV64...you need "&&
>>> !defined(TARGET_LOONGARCH64)" here to create an effect for
>>> TARGET_LOONGARCH64 similar to the proper solution for TARGET_RISCV64
>>> (~ disable the use of this struct target_stat64 with 32bit sec/nsec
>>> fields for a glibc environment where 64bit sec/nsecs are used - the
>>> default struct target_stat is perfect for these 64bit envs, do not let
>>> TARGET_HAS_STRUCT_STAT64 to be defined). [This 2nd embedded "||
>>> defined(TARGET_LOONGARCH64)" within an other encapsulating "||
>>> defined(TARGET_LOONGARCH64)" #elif-section is effectively a no-op here
>>> (the 2nd is always true, if the encapsulating 1st was true)...it does
>>> not effectively change the behaviour of its conditional
>>> code-fragment-body in the actual context...comparing to the original
>>> "#if !defined(TARGET_RISCV64)" full-line.]
>>>
>>> How the contexts of LoongArch64 ABI1.0 vs. ABI2.0 are linked to this
>>> issue (related to an optional code-path in qemu/linux-user/syscall.c)?
>>> The answer:
>>> The existence of this bug does not directly depend on or linked to any
>>> difference of core features of LA64's ABI1.0 vs. ABI2.0.
>>> The difference in behaviour of ABI1.0 and ABI2.0 environments related
>>> to this qemu-code-part here strictly depends on the behaviour of
>>> specific glibc versions used by those LA64 ABI1.0 and ABI2.0
>>> environments.
>>>
>>> In the ABI1.0 env of glibc-2.28-7cdc44d5a1 used by Loongson's gcc 8.3
>>> rc1.6 a stat-like call (filling up a struct stat instance) IS NOT
>>> always routed via the statx syscall, newfstatat can be used
>>> instead!...and the processing of this newfstatat triggers the usage of
>>> the problematic code-path in qemu/linux-user/syscall.c having this
>>> bug, related to the host_to_target_stat64() function, where this code
>>> fragment prefers to use struct target_stat64 (instead of struct
>>> target_stat), if its use is enabled by
>>> defined(TARGET_HAS_STRUCT_STAT64):
>>> (~ around line 7975 in the 10.2.2 source)
>>> #if defined(TARGET_HAS_STRUCT_STAT64)
>>>           struct target_stat64 *target_st;
>>> #else
>>>           struct target_stat *target_st;
>>> #endif
>>>
>>> While in the ABI2.0 env of glibc of this gcc
>>> https://github.com/loongson/build-tools/releases/download/2025.08.08/x86_64-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz
>>> from https://github.com/loongson/build-tools (glibc:
>>> https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz) ALL stat-like calls
>>> ARE ROUTED via the statx syscall, so the problematic code path of
>>> host_to_target_stat64() IS NOT used/triggered at all (and processing
>>> path of the statx syscall in linux-user/syscall.c is correct). This
>>> behaviour of glibc-2.42 can be determined by these definitions in
>>> glibc-2.42/sysdeps/unix/sysv/linux/loongarch/fixup-asm-unistd.h:
>>> -----
>>> /* To avoid the messy usage of the fstat, newfstatat, and statx system calls, we
>>> only use statx.  */
>>> #undef __NR_fstat
>>> #undef __NR_newfstatat
>>> -----
>>>
>>> -tgy
>> Hi,
>>
>> Thank you for your explanation.
>>
>> I confirm that the same issue exists in the 9.2-tcg-old branch, and you have clearly identified the root cause of the problem.
>> There is no doubt that the patch itself is fine, but what confuses me is that you attempted to run (ABI 1.0.0) using QEMU (ABI 2.0),
>> which led to the misconception that QEMU (2.0) is compatible with 1.0, when in fact QEMU has never been compatible with 1.0.
>> As far as I understand, the differences between the ABI 2.0 and ABI 1.0 environments should be quite significant.
>>
>> Therefore, I am unsure whether we should accept this patch.
>> Should we submit this patch to the 9.2-tcg-0ld branch?
>> Or should you consider discontinuing support for ABI 1.0? To my knowledge, ABI 2.0 has now become the mainstream standard.
>>
>> Thanks.
>> Song Gao
>>
>>> On Sat, Apr 11, 2026 at 10:24 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>>>> On Sat, Apr 11, 2026 at 10:09 AM Gyorgy Tamasi <gyorgy.tamasi@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> Thanks for the link of this separate Loongson-maintained 9.2-tcg-old
>>>>> branch - intended for use specifically with ABI 1.0 code.
>>>>>
>>>>> This separate branch still contains the same bug (in the context of
>>>>> the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - where
>>>>> fstatat syscall can be used by glibc, and it can trigger the usage of
>>>>> the related erroneous data-conversion workflow based on  struct
>>>>> target_stat64 with 4byte sec/nsec fields):
>>>>>
>>>>> This changeset was the last mod of syscall_defs.h - but it still
>>>>> incorrectly modifies the condition of struct target_stat64 usage:
>>>>> (~ "Add Loongarch64 old ABI support")
>>>>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c2e864be99
>>>>> (line 2006)
>>>>> -----
>>>>> -#if !defined(TARGET_RISCV64)
>>>>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
>>>> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
>>>>
>>>> Huacai
>>>>
>>>>> -----
>>>>>
>>>>> This is the broader context in this 9.2-tcg-old original version:
>>>>> Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
>>>>> no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64)"
>>>>> is true/false.
>>>>> -----
>>>>> #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
>>>>>           || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || \
>>>>>           defined(TARGET_LOONGARCH64)
>>>>> /* These are the asm-generic versions of the stat and stat64 structures */
>>>>>
>>>>> #define TARGET_STAT_HAVE_NSEC
>>>>> struct target_stat {
>>>>> ...
>>>>> };
>>>>>
>>>>> #if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>> #define TARGET_HAS_STRUCT_STAT64
>>>>> struct target_stat64 {
>>>>> ...
>>>>> };
>>>>> #endif
>>>>>
>>>>> #elif defined(TARGET_HPPA)
>>>>> -----
>>>>>
>>>>> The correct fix is the same here (~ disable the use of this struct
>>>>> target_stat64 - instead of explicitly enabling it for
>>>>> TARGET_LOONGARCH64 with the "|| defined(...)" part):
>>>>> -----
>>>>> ~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori syscall_defs.h
>>>>> --- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
>>>>> +++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
>>>>> @@ -2003,7 +2003,7 @@
>>>>>        abi_uint __unused5;
>>>>>    };
>>>>>
>>>>> -#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
>>>>> +#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
>>>>>    #define TARGET_HAS_STRUCT_STAT64
>>>>>    struct target_stat64 {
>>>>>        abi_ullong st_dev;
>>>>> -----
>>>>>
>>>>> The same test-scenario of
>>>>> https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
>>>>> [with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-old
>>>>> toolset] to show exactly the same bad & good test results - without &
>>>>> with this mod.
>>>>>
>>>>> Just a personal experience based side-note on ABI1.0 compatibility
>>>>> with mainline qemu (~10.2.2):
>>>>> I'm working on porting a quite large code-base (a commercial OCR &
>>>>> document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...and
>>>>> I'm trying to check correctness of my actual builds using the
>>>>> regression-test package of this codebase. It runs quite complex
>>>>> workflows of general CLI code. I accept that this is not a
>>>>> comprehensive test with all of the edge cases or touching every
>>>>> special areas (like signal handling) of compatibility of ABI1.0 and
>>>>> mainline qemu, but...the ABI1.0 version of this test-code seems to be
>>>>> able to run with mainline qemu-user 10.2.2.
>>>>>
>>>>> Best regards,
>>>>> -tgy
>>>>>
>>>>> On Fri, Apr 10, 2026 at 11:37 AM gaosong <gaosong@loongson.cn> wrote:
>>>>>> 在 2026/4/9 下午8:14, Gyorgy Tamasi 写道:
>>>>>>> Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>>>>>>>
>>>>>>> Additional independent testing (bug + fix cases) is documented here -
>>>>>>> see comments by sourav/@kishu279:
>>>>>>> https://gitlab.com/qemu-project/qemu/-/work_items/3371
>>>>>> Hi.
>>>>>> Please note that QEMU is not compatible with ABI 1.0.
>>>>>>
>>>>>> If you absolutely must use ABI 1.0, the branch below is the version we use.
>>>>>> https://github.com/loongson/qemu/commits/9.2-tcg-old/
>>>>>>
>>>>>> However, this branch is quite far from the mainline.
>>>>>> The QEMU mainline follows the kernel mainline, and
>>>>>> I believe this is the case for other architectures as well.
>>>>>>
>>>>>> Thanks.
>>>>>> Song Gao
>>>>>>> On Wed, Apr 8, 2026 at 8:21 PM Pierrick Bouvier
>>>>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>>>> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
>>>>>>>>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
>>>>>>>>> TARGET_LOONGARCH64 are defined!) we can not use the struct
>>>>>>>>> target_stat64 for data-transfer, since this struct target_stat64 is
>>>>>>>>> defined for 32bit environments with its int-sized (4byte) st_*time
>>>>>>>>> sec/nsec components.
>>>>>>>>> The user side compiler headers of the LoongArch64 env uses long-sized
>>>>>>>>> (8byte) st_*time sec/nsec components.
>>>>>>>>>
>>>>>>>>> (This is similar to the case of 32bit vs. 64bit RISCV: the original
>>>>>>>>> code does not use struct target_stat64 in 64bit RISCV env, when both
>>>>>>>>> TARGET_RISCV and TARGET_RISCV64 are defined.)
>>>>>>>>>
>>>>>>>>> This fix is important for LoongArch64 ABI1.0, where stat() is using an
>>>>>>>>> fstatat syscall with this struct target_stat64, if its usage is
>>>>>>>>> enabled.
>>>>>>>>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
>>>>>>>>> problematic struct target_stat64 is not used, struct statx is correct
>>>>>>>>> in the LoongArch64 env.)
>>>>>>>>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
>>>>>>>>>
>>>>>>>>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
>>>>>>>>> ---
>>>>>>>>>      linux-user/syscall_defs.h | 2 +-
>>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


