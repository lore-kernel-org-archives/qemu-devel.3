Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D22CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGoAe-0003yM-Pf; Tue, 13 Oct 2026 21:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGoAa-0003xI-FU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:52:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGoAW-0000tu-76
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:52:40 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69E1qKF3027188
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 14 Oct 2026 10:52:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iTvbq0sN1cwzMJIoHwmdzt/RMsk2t3E4bq/W4Yh0bD4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791942740; v=1;
 b=Ho3MybZ50gHH+TKJMsKre7jX2sHmJH7+ltPq5EPErvdVcA0rNC6BtPT/ZEmBdilK
 UBWlpGw55Xfff6+PrQtWID/C7BK2Hp4t2+xfuTE6Q/AR0rORMl4xjwxKQTi9y2bp
 kfGhyMV9SnvRQMS9Fp3i8ZqBmCgdf2lN05zBnfiCzg+csmXpqwBsNqP50Og2MUDN
 dpTs5OUoDn7dmjcS1hNfgt8jMIG1GxXMzi+LBTGE7lrDSRgH7NltpyEfn3kzT5sr
 SbVotDiewQlFvSCfYgWORFeNaXOeGDHROt/SbJcq9xl4xZtm5s7KBOMTLZytCchm
 grkP9JrrKaBdlIvBdjAVCQ==
Message-ID: <a231b25f-7cdc-4667-b9d8-2b2ef023cb56@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 14 Oct 2026 10:52:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] contrib/plugins/bbv.c: Allow selecting ROI
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <4eec19e6-db40-4658-b5b3-bc342473cffd@oss.qualcomm.com>
 <f503ffbe-0900-4b8e-ae7b-dbfcc74eb5cc@rsg.ci.i.u-tokyo.ac.jp>
 <2d7c2cdb-b5b9-41ed-9786-dd9b4876bdd8@oss.qualcomm.com>
 <9cda6271-aed9-4a2b-b88f-bca8371d753e@rsg.ci.i.u-tokyo.ac.jp>
 <0b392aaf-7ce1-46bb-b39b-47744ea1e6f9@oss.qualcomm.com>
 <65391825-ef44-4771-99b4-ad3a47279762@rsg.ci.i.u-tokyo.ac.jp>
 <6b00ed2c-e78a-4ac7-9e5b-34d4aebefbbf@oss.qualcomm.com>
 <ea052c05-88bb-4640-801e-8b9937bc5955@rsg.ci.i.u-tokyo.ac.jp>
 <d4552417-493f-4577-ac64-b3b63b15cdd5@oss.qualcomm.com>
 <9ce93dc1-b374-4732-97f8-e7a236759346@rsg.ci.i.u-tokyo.ac.jp>
 <5ad30a8d-b52f-4a9a-b299-a0caa98f2a67@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5ad30a8d-b52f-4a9a-b299-a0caa98f2a67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/14 10:13, Pierrick Bouvier wrote:
> On 10/13/2026 6:02 PM, Akihiko Odaki wrote:
>> On 2026/10/13 11:12, Pierrick Bouvier wrote:
>>> On 10/12/26 7:00 AM, Akihiko Odaki wrote:
>>>> On 2026/10/09 15:37, Pierrick Bouvier wrote:
>>>>> On 10/8/26 8:33 PM, Akihiko Odaki wrote:
>>>>>> On 2026/10/09 11:30, Pierrick Bouvier wrote:
>>>>>>> On 10/8/2026 5:57 PM, Akihiko Odaki wrote:
>>>>>>>> On 2026/10/09 1:40, Pierrick Bouvier wrote:
>>>>>>>>> On 10/7/2026 11:11 PM, Akihiko Odaki wrote:
>>>>>>>>>> On 2026/10/08 10:08, Pierrick Bouvier wrote:
>>>>>>>>>>> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>>>>>>>>>>>> A region of interest (ROI) often excludes the program startup
>>>>>>>>>>>> and
>>>>>>>>>>>> exit.
>>>>>>>>>>>> For example, a benchmark may parse a large input and then run a
>>>>>>>>>>>> computation kernel and the former may take longer than the
>>>>>>>>>>>> latter;
>>>>>>>>>>>> basic block vectors generated for the whole execution will not
>>>>>>>>>>>> properly
>>>>>>>>>>>> represent the latter.
>>>>>>>>>>>>
>>>>>>>>>>>> Add options to specify the beginning and the end of the ROI to
>>>>>>>>>>>> bound
>>>>>>>>>>>> basic block vector generation to the ROI.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        docs/about/emulation.rst |  8 +++++
>>>>>>>>>>>>        contrib/plugins/bbv.c    | 80 +++++++++++++++++++++++++
>>>>>>>>>>>> ++++
>>>>>>>>>>>> ++++++++
>>>>>>>>>>>> +++++++++--
>>>>>>>>>>>>        2 files changed, 86 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>>>>>>>>>>> index c58149086cdd..0566171b517b 100644
>>>>>>>>>>>> --- a/docs/about/emulation.rst
>>>>>>>>>>>> +++ b/docs/about/emulation.rst
>>>>>>>>>>>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic
>>>>>>>>>>>> block vectors for use with the
>>>>>>>>>>>>            * - Option
>>>>>>>>>>>>            - Description
>>>>>>>>>>>> +  * - begin=A
>>>>>>>>>>>> +    - The virtual address of the instruction that starts basic
>>>>>>>>>>>> block
>>>>>>>>>>>> vector
>>>>>>>>>>>> +      generation. Generation starts from the beginning of the
>>>>>>>>>>>> execution if
>>>>>>>>>>>> +      not specified.
>>>>>>>>>>>> +  * - end=A
>>>>>>>>>>>> +    - The virtual address of the instruction that ends basic
>>>>>>>>>>>> block
>>>>>>>>>>>> vector
>>>>>>>>>>>> +      generation. Generation continues until the endo of the
>>>>>>>>>>>> execution if
>>>>>>>>>>>
>>>>>>>>>>> small typo here: s/endo/end
>>>>>>>>>>
>>>>>>>>>> Thanks for catching the typo.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> +      not specified.
>>>>>>>>>>>>          * - interval=N
>>>>>>>>>>>>            - The interval to generate a basic block vector
>>>>>>>>>>>> specified by
>>>>>>>>>>>> the number of
>>>>>>>>>>>>              instructions (Default: N = 100000000)
>>>>>>>>>>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>>>>>>>>>>> index e5caf5d9543b..a2a779f7639e 100644
>>>>>>>>>>>> --- a/contrib/plugins/bbv.c
>>>>>>>>>>>> +++ b/contrib/plugins/bbv.c
>>>>>>>>>>>> @@ -5,6 +5,8 @@
>>>>>>>>>>>>         * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>>>>>>>>         */
>>>>>>>>>>>>        +#include <stdbool.h>
>>>>>>>>>>>> +#include <stdint.h>
>>>>>>>>>>>>        #include <stdio.h>
>>>>>>>>>>>>        #include <glib.h>
>>>>>>>>>>>>        @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>>>>>>>>>>>        static GRWLock bbs_lock;
>>>>>>>>>>>>        static char *filename;
>>>>>>>>>>>>        static struct qemu_plugin_scoreboard *vcpus;
>>>>>>>>>>>> +static bool begin_present;
>>>>>>>>>>>> +static uint64_t begin;
>>>>>>>>>>>> +static bool end_present;
>>>>>>>>>>>> +static uint64_t end;
>>>>>>>>>>>>        static int64_t interval = 100000000;
>>>>>>>>>>>>          static void plugin_exit(void *p)
>>>>>>>>>>>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index,
>>>>>>>>>>>> void
>>>>>>>>>>>> *userdata)
>>>>>>>>>>>>            Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus,
>>>>>>>>>>>> vcpu_index);
>>>>>>>>>>>>              vcpu_filename = g_strdup_printf("%s.%u.bb",
>>>>>>>>>>>> filename,
>>>>>>>>>>>> vcpu_index);
>>>>>>>>>>>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
>>>>>>>>>>>
>>>>>>>>>>> Not sure which semantic we are trying to achieve with -interval
>>>>>>>>>>> here.
>>>>>>>>>>>
>>>>>>>>>>> The original logic was to increment this count, until reaching
>>>>>>>>>>> interval,
>>>>>>>>>>> after what we would reset it by using vcpu_count -= interval, to
>>>>>>>>>>> keep
>>>>>>>>>>> the extra insn that went in after the threshold.
>>>>>>>>>>
>>>>>>>>>> The counter now starts at -interval and counts up to zero.
>>>>>>>>>> Subtracting
>>>>>>>>>> interval after emitting a vector still preserves the extra
>>>>>>>>>> instructions.
>>>>>>>>>> For example, with interval=100:
>>>>>>>>>>
>>>>>>>>>>          initial count:       -100
>>>>>>>>>>          after 130 insns:       30  -> emit a vector
>>>>>>>>>>          subtract interval:    -70  -> 70 insns until the next
>>>>>>>>>> vector
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>            vcpu->file = fopen(vcpu_filename, "w");
>>>>>>>>>>>>        }
>>>>>>>>>>>>        @@ -102,6 +109,22 @@ static void
>>>>>>>>>>>> vcpu_interval_exec(unsigned int
>>>>>>>>>>>> vcpu_index, void *udata)
>>>>>>>>>>>>            fputc('\n', vcpu->file);
>>>>>>>>>>>>        }
>>>>>>>>>>>>        +static void vcpu_begin_insn_exec(unsigned int vcpu_index,
>>>>>>>>>>>> void
>>>>>>>>>>>> *userdata)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    GHashTableIter iter;
>>>>>>>>>>>> +    void *value;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>>>>>>>>>>> +    g_hash_table_iter_init(&iter, bbs);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>>>>>>>>>>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index,
>>>>>>>>>>>> 0);
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>>>>>>>>>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>        static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void
>>>>>>>>>>>> *userdata)
>>>>>>>>>>>>        {
>>>>>>>>>>>>            uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>>>>>>>>>>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct
>>>>>>>>>>>> qemu_plugin_tb
>>>>>>>>>>>> *tb, void *userdata)
>>>>>>>>>>>>            }
>>>>>>>>>>>>            g_rw_lock_writer_unlock(&bbs_lock);
>>>>>>>>>>>>        +    for (size_t idx = 0; idx < n_insns; idx++) {
>>>>>>>>>>>> +        struct qemu_plugin_insn *insn =
>>>>>>>>>>>> qemu_plugin_tb_get_insn(tb,
>>>>>>>>>>>> idx);
>>>>>>>>>>>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>>>>>>>>>>>> +
>>>>>>>>>>>> +        if (begin_present && insn_vaddr == begin) {
>>>>>>>>>>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>>>>>>>>>>> +                insn, vcpu_begin_insn_exec,
>>>>>>>>>>>> QEMU_PLUGIN_CB_NO_REGS,
>>>>>>>>>>>> NULL);
>>>>>>>>>>>> +        } else if (end_present && insn_vaddr == end) {
>>>>>>>>>>>> +
>>>>>>>>>>>> qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>>>>>>>>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64,
>>>>>>>>>>>> count_u64(),
>>>>>>>>>>>> INT64_MIN);
>>>>>>>>>>>> +        }
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>>            qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>>>>>>>>>>                tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(),
>>>>>>>>>>>> n_insns);
>>>>>>>>>>>>        @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct
>>>>>>>>>>>> qemu_plugin_tb *tb, void *userdata)
>>>>>>>>>>>>              qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>>>>>>>>>>                tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>>>>>>>>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>>>>>>>>>>>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>>>>>>>>> +}
>>>>>>>>>>>
>>>>>>>>>>> is INT64_MIN used as an arbitrary large value when interpreted as
>>>>>>>>>>> unsigned immediate? If yes, that's confusing to the reader.
>>>>>>>>>>
>>>>>>>>>> The unsigned comparison count < (uint64_t)INT64_MIN is equivalent
>>>>>>>>>> with
>>>>>>>>>> the signed comparison (int64_t)count >= 0. That is why this
>>>>>>>>>> particular
>>>>>>>>>> value is used.
>>>>>>>>>>
>>>>>>>>>> Setting count to INT64_MIN suppresses output for the next 2^63
>>>>>>>>>> counted
>>>>>>>>>> instructions, which is effectively disabled for this use. The
>>>>>>>>>> beginEmulation
>>>>>>>>>> callback clears the BB counters and sets count to -interval; end
>>>>>>>>>> sets it
>>>>>>>>>> back to INT64_MIN. The requested interval stays unchanged.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ok I see better.
>>>>>>>>> Even though it works, it's pretty confusing to be honest. Inline
>>>>>>>>> operatons works with unsigned values, so with conversion and wrap
>>>>>>>>> around, it's safe, but really not intuitive.
>>>>>>>>>
>>>>>>>>> I would prefer if you could refactor this to keep a zero
>>>>>>>>> initialized
>>>>>>>>> count value, and add a specific instrumentation path for begin, end
>>>>>>>>> logic (COND_LT, UINT64_MAX - N) to keep the same behavior of
>>>>>>>>> "infinite
>>>>>>>>> interval".
>>>>>>>>
>>>>>>>> We cannot choose a separate instrumentation path based on whether
>>>>>>>> execution is inside the ROI. Instrumentation is installed when a
>>>>>>>> TB is
>>>>>>>> translated, but the same TB may execute both inside and outside the
>>>>>>>> ROI.
>>>>>>>>
>>>>>>>> I will preserve this logic and add code comments for clarification.
>>>>>>>>
>>>>>>>
>>>>>>> I took some time to read again how bbv works. Indeed, my idea to
>>>>>>> modify
>>>>>>> interval was a non sense, and not what is expected.
>>>>>>>
>>>>>>> The current instrumentation per tb is always done unconditionally,
>>>>>>> and
>>>>>>> the only need thing to do is to snapshot bbs hashtable to keep
>>>>>>> track of
>>>>>>> the correct data only when being inside the ROI. The rest of existing
>>>>>>> logic stays the same.
>>>>>>>
>>>>>>> - On enter, set vcpu->count to 0 (fresh start) and restore bb
>>>>>>> table from
>>>>>>> previous exit (empty table if there was no exit yet).
>>>>>>> - On exit, duplicate the bb table to allow to restore it next time we
>>>>>>> enter in ROI.
>>>>>>> Key idea is that we keep on adding things in bb table, but save/
>>>>>>> restore
>>>>>>> when leaving/entering ROI.
>>>>>>>
>>>>>>> I think for robustness you should also add detection of those
>>>>>>> expected
>>>>>>> transitions: Out of ROI -> Enter ROI -> Exit ROI -> Enter ROI -> ...
>>>>>>>
>>>>>>> Nothing is currently done to detect if if we meet enter/exit address
>>>>>>> multiple times, without having the correct sequence. I don't know
>>>>>>> if we
>>>>>>> want to report an error or handle reentrance correctly in this case.
>>>>>>>
>>>>>>> Also, should count be reset on each entrance, or do we want to keep
>>>>>>> track of it also, and save/restore that on exit/enter? I tend to
>>>>>>> think
>>>>>>> the idea is create a "virtual" interval than only is alive when being
>>>>>>> inside the ROI. In this case, we should keep track of this value
>>>>>>> also.
>>>>>>
>>>>>> The current design that resets the bb table is intentional. A
>>>>>> "virtual"
>>>>>> interval spanning multiple ROIs would be misleading because it mixes
>>>>>> different sections of execution.
>>>>>>
>>>>>
>>>>> Ok.
>>>>>
>>>>>> I don't think we need to add a special handling to enforce a
>>>>>> particular
>>>>>> order of transitions. This patch performs the same action for the
>>>>>> begin
>>>>>> and end addresses and that makes the behavior predictable.
>>>>>>
>>>>>> Perhaps we can extend the documentation to clarify the "begin"
>>>>>> marker to
>>>>>> tell that it resets the bb table, making the behavior clear regardless
>>>>>> of transition order.
>>>>>>
>>>>>
>>>>> I'm fine to keep a simple model, but I'll ask you to remove the logic
>>>>> involving negative numbers, it's just too confusing. Please remove:
>>>>> vcpu->count = begin_present ? INT64_MIN : -interval;
>>>>> and
>>>>> QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>>
>>>>> Instead, let's add a new boolean "tracking_region" in struct Vcpu, that
>>>>> is set to true when entering ROI (or true by default if no begin
>>>>> parameter was given).
>>>>
>>>> The flag may look simpler in isolation, but streamlining the
>>>> interactions with the counter requires more careful thought. Please see
>>>> below.
>>>>
>>>>>
>>>>> Then, modify instrumentation to replace:
>>>>> ```
>>>>> else if (end_present && insn_vaddr == end) {
>>>>>                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>>                    insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(),
>>>>> INT64_MIN);
>>>>> ```
>>>>> with:
>>>>> ```
>>>>> else if (end_present && insn_vaddr == end) {
>>>>>       qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_exit_region,
>>>>> QEMU_PLUGIN_CB_NO_REGS, NULL);
>>>>> }
>>>>>
>>>>> static void vcpu_exit_region(unsigned int vcpu_index, void *userdata)
>>>>> {
>>>>>       Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>>       vcpu_interval_exec(vcpu_index, NULL);
>>>>>       vcpu->tracking_region = false;
>>>>> }
>>>>> ```
>>>>
>>>> vcpu_exit_region should only disable tracking. Calling
>>>> vcpu_interval_exec directly bypasses its count >= interval precondition:
>>>> it subtracts interval even when count is smaller, wrapping the unsigned
>>>> counter, and emits a partial vector or potentially an empty one.
>>>>
>>>
>>> I'm fine with it. I was unsure if you wanted to dump the partial data,
>>> aggregate it when reentering the section, or simply discard it.
>>> With a discard, it's even simpler, just need to set tracking_region to
>>> false.
>>>
>>>>>
>>>>> In addition, let's rename s/vcpu_begin_insn_exec/vcpu_enter_region, to
>>>>> be consistent and explicit on what it's doing.
>>>>>
>>>>> And finally, the last piece:
>>>>> static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>>>>> {
>>>>>        Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>>        if (!vcpu->tracking) {
>>>>>          return;
>>>>>        }
>>>>>        ...
>>>>
>>>> The early return must come after vcpu->count -= interval. Otherwise,
>>>> once count reaches interval outside the ROI, it remains above the
>>>> threshold and invokes the callback on every subsequent TB, rather than
>>>> once per interval.
>>>>
>>>
>>> Right, thanks for catching it.
>>>
>>>>>
>>>>> The impact performance of calling vcpu_interval_exec + one if every N
>>>>> instructions is invisible, and at least, it's a piece of code we can
>>>>> read in 6 months, and understand in less than 2 min without any
>>>>> additional doc.
>>>>
>>>> I agree the performance impact is negligible, but at least you need to
>>>> consider about that to be sure. Adding another flag requires those
>>>> additional considerations.
>>>>
>>>> More broadly, I don't think it's ideal to introduce application-specific
>>>> logic for this. Looking at the bigger picture, a counting timer with
>>>> variable expiration is a common pattern that should ideally be supported
>>>> generally.
>>>>
>>>> An alternative option is to have signed integer variants of
>>>> qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() and similar
>>>> functions to support for that. However, I don't think those are
>>>> necessary either. Taking at an even broader perspective, C allows
>>>> avoiding such specialization by letting unsigned variables hold signed
>>>> values in a well-defined manner; even the underlying implementation of
>>>> the inline op uses signed and unsigned types interchangeably.
>>>>
>>>
>>> If the argument is "C allows that with a defined behaviour", I don't
>>> think it makes a point for me. There is a lot of well defined and
>>> confusing code you can write.
>>>
>>> Something like:
>>>    qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>           QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>> with limit and counter being unsigned is not readable for me.
>>>
>>>> Although it might not be immediately obvious that an unsigned variable
>>>> is storing a signed value, adding a brief clarifying comment is still
>>>> simpler than introducing another variable overall.
>>>>
>>>
>>>   From there I'll let you decide between introducing the flag, or
>>> reimplement that with positive values (sticking to init count=0) only
>>> if you really prefer this approach.
>>
>> I agree that "C allows this with defined behaviour" is insufficient on
>> its own. Ideally, we could express the signed interpretation directly
>> with int64_t without adding complexity. That would improve clarity,
>> even though the existing arithmetic is already well-defined.
>>
>> However, we need to consider the whole design. Both approaches require
>> readers to understand more than the individual expressions.
>>
>> The counter-only approach requires knowing that:
>>
>> - count is actually treated as signed.
>> - Any non-negative is smaller than (uint64_t)INT64_MIN when compared as
>>    unsigned.
>>
>> The flag approach requires considering:
>> - How the count and flag together determine when a vector is emitted.
>> - The required ordering of count and flag accesses.
>> - Whether the number of callback invocations will significantly
>>    increase.
>>
>> The count-only approach requires fewer considerations, and the ones it
>> does require needs no deduction. The first point is a common practice,
>> as seen in the underlying implementation. The second point is simply a
>> matter of the int64_t definition. In both cases, knowing the definition
>> is sufficient, and both can be documented clearly in the comments.
>>
>> In contrast, the flag approach requires real reasoning. Comments won't
>> help here; explaining the ordering and interactions via comments would
>> be as complicated as the code itself, thereby imposing a greater
>> cognitive burden.
>>
>> Furthermore, supporting a variable interval (as done in the count-only
>> approach) is a pattern we should embrace, rather than working around it
>> by introducing a separate flag.
>>
>> We have also already discussed why retaining count=0 is not a drop-in
>> alternative under the same counter-only instrumentation. The initial
>> state must distinguish execution that starts inside the ROI from
>> execution waiting for the begin marker.
>>
>> Putting all together, I still believe utilizing the existing signed
>> representation is cleaner than inventing an alternative approach ourselves.
>>
> 
> I respect your opinion, but I would prefer to not introduce such usage
> of the existing API in contrib/, since it might (wrongly) inspire other
> people reading this plugin code.

I agree that contrib plugins should set a good example. What pattern
would you like them to demonstrate for a counting timer whose expiration
can change at runtime, including effectively disabling the timer?

The counter-only design expresses this by updating the counter while
keeping the instrumentation unchanged. I think that is a useful pattern
to demonstrate, with its interpretation and assumptions documented.

I would like to understand which general pattern you would prefer to
encourage, so we can compare the approaches on that basis.

Regards,
Akihiko Odaki

