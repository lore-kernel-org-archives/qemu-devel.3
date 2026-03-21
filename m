Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2652E109448F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 19:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w42Lp-0005MB-GU; Sat, 21 Mar 2026 15:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w42Ln-0005JV-Vb
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 15:51:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w42Lm-0004AI-Az
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 15:51:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1619428b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774122668; x=1774727468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JMeyUJKcBvqehviZRhCK0rGYVpyb7wlZpOrOkiaJG5I=;
 b=m1n8auFsr/YqnjRf6BnNJNq9ppgcmHzx86YswosEH0HqFu95pjIVDQNnbaPxK9HbB6
 rn3v/zjHVmii9DjKuEMbIxxikG5s1dQySLeAw7DrL2a9P7fMNLZcAZw+Do6LV/jrOtZ6
 s7uvBrrjhKnMKQNkk4+sgUFx0FQBHBtl/nScQ+fmDUUL2LtftrWWLmkN9bvjpuoqtgsM
 SWXzlDP6JaYNIZtEOHiKy7KxGC4Mnret/2EtPVHSw+eRDh184RFzrSKn3A22UewX3OmG
 ycBxCkSSMA6GrYmojDhTEtviJna1BdJqZTYmWYsMSRq/OzO4X1yFsaWvB95IsG+t1mTO
 5d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774122668; x=1774727468;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMeyUJKcBvqehviZRhCK0rGYVpyb7wlZpOrOkiaJG5I=;
 b=rsUZ1iuGCzZ5UpeM0PCJqLhGyQ1iGCn8fjyACzY3zZBqIO2nHTYhNqsrA2bXMSU15g
 U+Km1su202uETXxktNc75Jw7hp9Ohha8zRjIumRRUqhM+8qEBKU8m6MzyXkXC7jVAw5j
 sTI8pCVEte4XHXqqyQGm75kW2fXrU8gu7jabHjr02kdMQR/7O/TjCkI1eztQr5S1MAL/
 cp9kkR4SZzUs5uFmeK0Fn0LaiqodJuFeeYGTdU3G28eus3xa4hTFyp2smu1kBwzP6Eq+
 Y/bwu9JBpDDi2EPs6wGZ06FbCyDkKvnUS8i0XrXJ4+jNkcVIrXzZ4acK9P9eAPIHDqZh
 UKCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4l5r3MznN9Y8U+QrY0D8kFDWzXhZpXFtlptG5GrmQJRPqMvDkq5SrU46wvhJ7oyeoAhbInweqR9t@nongnu.org
X-Gm-Message-State: AOJu0YxaTvP4wKVGFydKYo7Xnxc+vTYT4kBis3eIyHN5VMKgROLyGAkx
 /yOdJKV/5WqXZNLK6qgNSl/HDIs+nPmzEm6ddQ5M1LBDdeK3R5zO7aGuIeJSN70aXz8=
X-Gm-Gg: ATEYQzyCmF7x4bPnSNodGMsBM2saJhMzDAJgxLET4SN04bkELOgNzpwQsOMaRhUbG05
 Sj0oPDq8JXvUYsnsLM+QRHqPa7Ch3lhLaSMMkb2MOWRXSIytyKfR3yPNCek1ZMKKbxTh3NLZz2v
 DvuJEZqehmGPbJ7/4boCw3asBlgbIXlkhE3ZPK0HmAFIWzLdKDp2rmgHs2PTCtc9XTEmLTT5SCW
 LWztOw5Dbg3MyoQBv8MGtYVKN5nJeCqnqrlKL28e52xu26bFpNiR8UWAsxpOKivGJGQLuMEcSSM
 cxwkPTiSRspqsWrvaNCAxkd37A+q2Ue3ly7D/64byTwU5kvPAs3Zp/GrNKwRT7BdB0hRTrYCN1J
 hdf67+1xn11M35s29ag09d8qIuafHUqHzkcUT4CHZtEDHbAHD/P4uKsPMhp4PenJ/MtAhQoYoaq
 PJHQJtjW3jojzQBeoDoxpCj4/q1dM5P0ZNRzqpEpLifUXyzspCAWQYWGAAnEGNCkQArDod
X-Received: by 2002:a05:6a00:b41:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-82a8c24817emr5948139b3a.6.1774122668186; 
 Sat, 21 Mar 2026 12:51:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bc6881sm5985500b3a.22.2026.03.21.12.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 12:51:07 -0700 (PDT)
Message-ID: <ada320b4-4204-43eb-a2da-5730641535de@linaro.org>
Date: Sat, 21 Mar 2026 12:51:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 03/10] cpus: Introduce
 CPUClass::legacy_monitor_defs hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20260320160811.28611-1-philmd@linaro.org>
 <20260320160811.28611-4-philmd@linaro.org>
 <7c54cfcf-fef6-41db-a1a8-382857371d3a@linaro.org>
 <9ed408a5-6b25-4d4e-aefc-59b413058ca6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <9ed408a5-6b25-4d4e-aefc-59b413058ca6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/21/26 8:19 AM, Philippe Mathieu-Daudé wrote:
> On 20/3/26 23:01, Pierrick Bouvier wrote:
>> On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
>>> Allow targets to register their legacy target_monitor_defs()
>>> in CPUClass; check it first in get_monitor_def() otherwise
>>> fall back to previous per-target helper.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    include/hw/core/cpu.h | 3 +++
>>>    monitor/hmp.c         | 3 ++-
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index 04e1f970caf..072f58bead5 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -148,6 +148,8 @@ struct SysemuCPUOps;
>>>     * @max_as: Maximum valid index used to refer to the address spaces
>>> supported by
>>>     *          the architecture, i.e., to refer to CPUAddressSpaces in
>>>     *          CPUState::cpu_ases.
>>> + * @legacy_monitor_defs: Array of MonitorDef entries. This field is
>>> legacy,
>>> + *                       use @gdb_core_xml_file to dump registers
>>> instead.
>>>     *
>>>     * Represents a CPU family or model.
>>>     */
>>> @@ -174,6 +176,7 @@ struct CPUClass {
>>>        const char *gdb_core_xml_file;
>>>        const char * (*gdb_arch_name)(CPUState *cpu);
>>>        const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>>> +    const MonitorDef *legacy_monitor_defs;
>>>        void (*disas_set_info)(const CPUState *cpu, disassemble_info
>>> *info);
>>> diff --git a/monitor/hmp.c b/monitor/hmp.c
>>> index c63da13e310..a2b6269d0ff 100644
>>> --- a/monitor/hmp.c
>>> +++ b/monitor/hmp.c
>>> @@ -24,6 +24,7 @@
>>>    #include "qemu/osdep.h"
>>>    #include <dirent.h>
>>> +#include "hw/core/cpu.h"
>>>    #include "hw/core/qdev.h"
>>>    #include "monitor-internal.h"
>>>    #include "monitor/hmp.h"
>>> @@ -1603,8 +1604,8 @@ void monitor_register_hmp_info_hrt(const char
>>> *name,
>>>     */
>>>    int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>>    {
>>> -    const MonitorDef *md = target_monitor_defs();
>>>        CPUState *cs = mon_get_cpu(mon);
>>> +    const MonitorDef *md = cs->cc->legacy_monitor_defs ?:
>>> target_monitor_defs();
>>>        void *ptr;
>>>        uint64_t tmp = 0;
>>>        int ret;
>>
>> I'm not very fond of the "keep legacy callback for the N targets that
>> might require it". Either set it for every target, using a default
>> implementation if needed, or...
>>
>> As an alternative, we could use a dispatch function like:
>>
>> const MonitorDef *target_monitor_defs()
>> {
>>     switch (target_arch()) {
>>     case
>>       SYS_EMU_TARGET_X:
>>         return X_target_monitor_defs();
>>       SYS_EMU_TARGET_Y:
>>         return Y_target_monitor_defs();
>>     default:
>>       return default_target_monitor_defs();
>>     }
>> }
>>
>> Personally, I prefer the dispatch approach, as it's very clear to see
>> what happens per target. This solves the symbol duplication by manually
>> name them differently.
>>
>> It's just a suggestion though, and I'm ok to have a per target field, as
>> long as we enforce it to be set for all targets, and not using a
>> 'legacy' callback for a few of them only.
>>
>> Pick the one you prefer :)
> 
> My preference would be to remove this legacy code altogether, as
> I'm pretty sure it isn't used anymore (see for the example the
> issues RISC-V folks had with it before giving up).

I'm not sure what you mean.

If it's not used, then we simply remove it.
If it's used, then let's keep it, but just make it consistent with all 
targets without having a special case named "legacy". If it's here to 
stay, it's not legacy.

Do you have something else in mind?

