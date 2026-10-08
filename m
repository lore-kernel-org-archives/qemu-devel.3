Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34686CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEhMP-0005w9-Va; Thu, 08 Oct 2026 02:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEhMF-0005uN-BA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:12:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEhM9-0000ci-NB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:11:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6986BQQk004552
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Oct 2026 15:11:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wliyHGn1aTtXStq0qGx4Qn8uzWMp+c3RPDFwy+8gy0Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791439887; v=1;
 b=BzbJCRx0jRTAFAmOXuwUVMofoZ0hS+vZlmQ3ku164MGQzkzZaTKUSh7SR7zTVAD8
 pypKI3CDSXKDg4rlWTyjlgRgQppGDL9JrfcxMkPogrf38yCoXh4MoJMFnhDH8zNw
 XQKHrv0rAUG1Q4uAKvjr7HnuhiF+ykBydhuLt1+fF5Yb9QeZhUhqvMX+D1CGGpEs
 dndtFpyFhUwjDGHyKTVzJi1EhAuTZDPhuguKyAClEyJKUPk8AQm2cEsBTfsEbEKf
 jJy5kUJAJWZrJ/XIPrBELvlMDecfQJ+BxXF6nEuF6IqVBAzGIGb4KX8DmOBVU2FZ
 rRdDE9mHNak8mHyptT0BlA==
Message-ID: <f503ffbe-0900-4b8e-ae7b-dbfcc74eb5cc@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 8 Oct 2026 15:11:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] contrib/plugins/bbv.c: Allow selecting ROI
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <4eec19e6-db40-4658-b5b3-bc342473cffd@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4eec19e6-db40-4658-b5b3-bc342473cffd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/10/08 10:08, Pierrick Bouvier wrote:
> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>> A region of interest (ROI) often excludes the program startup and exit.
>> For example, a benchmark may parse a large input and then run a
>> computation kernel and the former may take longer than the latter;
>> basic block vectors generated for the whole execution will not properly
>> represent the latter.
>>
>> Add options to specify the beginning and the end of the ROI to bound
>> basic block vector generation to the ROI.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   docs/about/emulation.rst |  8 +++++
>>   contrib/plugins/bbv.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 86 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>> index c58149086cdd..0566171b517b 100644
>> --- a/docs/about/emulation.rst
>> +++ b/docs/about/emulation.rst
>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic block vectors for use with the
>>   
>>     * - Option
>>       - Description
>> +  * - begin=A
>> +    - The virtual address of the instruction that starts basic block vector
>> +      generation. Generation starts from the beginning of the execution if
>> +      not specified.
>> +  * - end=A
>> +    - The virtual address of the instruction that ends basic block vector
>> +      generation. Generation continues until the endo of the execution if
> 
> small typo here: s/endo/end

Thanks for catching the typo.

> 
>> +      not specified.
>>     * - interval=N
>>       - The interval to generate a basic block vector specified by the number of
>>         instructions (Default: N = 100000000)
>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>> index e5caf5d9543b..a2a779f7639e 100644
>> --- a/contrib/plugins/bbv.c
>> +++ b/contrib/plugins/bbv.c
>> @@ -5,6 +5,8 @@
>>    * SPDX-License-Identifier: GPL-2.0-or-later
>>    */
>>   
>> +#include <stdbool.h>
>> +#include <stdint.h>
>>   #include <stdio.h>
>>   #include <glib.h>
>>   
>> @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>   static GRWLock bbs_lock;
>>   static char *filename;
>>   static struct qemu_plugin_scoreboard *vcpus;
>> +static bool begin_present;
>> +static uint64_t begin;
>> +static bool end_present;
>> +static uint64_t end;
>>   static int64_t interval = 100000000;
>>   
>>   static void plugin_exit(void *p)
>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void *userdata)
>>       Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>   
>>       vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
> 
> Not sure which semantic we are trying to achieve with -interval here.
> 
> The original logic was to increment this count, until reaching interval,
> after what we would reset it by using vcpu_count -= interval, to keep
> the extra insn that went in after the threshold.

The counter now starts at -interval and counts up to zero. Subtracting 
interval after emitting a vector still preserves the extra instructions. 
For example, with interval=100:

     initial count:       -100
     after 130 insns:       30  -> emit a vector
     subtract interval:    -70  -> 70 insns until the next vector

> 
>>       vcpu->file = fopen(vcpu_filename, "w");
>>   }
>>   
>> @@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>>       fputc('\n', vcpu->file);
>>   }
>>   
>> +static void vcpu_begin_insn_exec(unsigned int vcpu_index, void *userdata)
>> +{
>> +    GHashTableIter iter;
>> +    void *value;
>> +
>> +    g_rw_lock_reader_lock(&bbs_lock);
>> +    g_hash_table_iter_init(&iter, bbs);
>> +
>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
>> +    }
>> +
>> +    g_rw_lock_reader_unlock(&bbs_lock);
>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>> +}
>> +
>>   static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>>   {
>>       uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>>       }
>>       g_rw_lock_writer_unlock(&bbs_lock);
>>   
>> +    for (size_t idx = 0; idx < n_insns; idx++) {
>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>> +
>> +        if (begin_present && insn_vaddr == begin) {
>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>> +                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS, NULL);
>> +        } else if (end_present && insn_vaddr == end) {
>> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(), INT64_MIN);
>> +        }
>> +    }
>> +
>>       qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>           tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
>>   
>> @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>>   
>>       qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>           tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>> +}
> 
> is INT64_MIN used as an arbitrary large value when interpreted as
> unsigned immediate? If yes, that's confusing to the reader.

The unsigned comparison count < (uint64_t)INT64_MIN is equivalent with 
the signed comparison (int64_t)count >= 0. That is why this particular 
value is used.

Setting count to INT64_MIN suppresses output for the next 2^63 counted 
instructions, which is effectively disabled for this use. The begin 
callback clears the BB counters and sets count to -interval; end sets it 
back to INT64_MIN. The requested interval stays unchanged.

> It would be better to choose something like:
> UINT64_MAX - 1024, and assert than no tb has more than 1024 insn.
> 
>  From that and code above, it seems like we're trying to introduce a "run
> forever" logic as an arbitrary big interval when using begin/end features.

Using UINT64_MAX - 1024 as the disabled counter value would wrap after 
1025 instructions in total. Bounding the size of each TB would not 
prevent that.

> 
> Maybe it would be more obvious to use:
> - leave count initialization to 0
> - if using begin/end, set an arbitrary large interval (which will never
> be "fullfilled" by normal execution), like UINT64_MAX - 1024.
> 
> Normal path is unmodified, and you can insert the begin/end logic
> accordingly.
Using a large interval instead needs another consideration: the 
comparison threshold is embedded as an immediate in translated code. 
Changing the interval variable at begin/end would not update existing 
comparisons, and that variable is shared across vCPUs. Adjusting the 
per-vCPU counter lets the comparison stay fixed.

> 
> Maybe I missed the clever way it's supposed to work, but at this time of
> the day, my brain can't see it :). Feel free to explain if I missed
> anything obvious.
I agree this encoding deserves a comment; it is not obvious from the 
code alone.

Regards,
Akihiko Odaki

