Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E01094482
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3y7B-0006Ft-MM; Sat, 21 Mar 2026 11:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3y79-0006FW-RS
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:19:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3y77-0005zW-V3
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:19:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so21883015e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774106384; x=1774711184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+SXICu0xF9tzyKjYlGReh8cg+6UZnkvInGRoddpc0Ck=;
 b=FqrpE5yFkTzrHtBIjGtsJ8Lv1AwZmFBEssQKTgHLyfV6sjVX6JX/IpQoX69M9TmF5/
 Bk7yOJb36vhTK5oV+FXj2mw0TIHchsooXsuo6gaZC731lBwzz75xzMiI2PuXiUwphiRg
 PxHJBwtEGXthFAC1pASAMiUsqVYPb7AVXsQ+i7gSRAuCpvSg3FXVkkdIpNoCuCG9gdGw
 ZcuyYX4qRqXo2SckWMWB7FOyzhsJUP+idKIK7d0/RSQjWt1uIdiPZvgzgT6ns+nICmNR
 8CAemE25+SVS7CXMrNW2DdVHgnADGDIFzxlq2vjKELLYzMvJLO0qqaSoU1SaZK79YvHI
 rbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774106384; x=1774711184;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SXICu0xF9tzyKjYlGReh8cg+6UZnkvInGRoddpc0Ck=;
 b=FJymt4DdldW61voZaiS7ESuKpS5FbvY5kKtZv82j/xd/ayiADhtCeGbHgOfAEDoeX/
 MhaHU3wt3JWxozGwjTrJkFJ88X1+7foWduk/9RcETdkKcnvVxl4hInI9vQGJngB+osoM
 L6/L7mR6kPoJ5HGRDqhjRXb1xh2F8Vj4N8muueyWQxSJmvXyhdhoKxoXvM+Xyy1v9AY2
 V0yX+96LW2a+Xm8ouAig6c3ZqdviFk39dLfvaXX6JFLC51BKR8ECH2AkgQRzHm0Px7aQ
 gcCGHoys010pHIa1svsJCgE4iDzYQQPKWQ2Nun0uzzVIGyUnui4gKmHuJ5uYSW45rwNb
 blkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN7kLsRDeYz7FfH4PZh+4ZQlVV2eiQPpB+irEEntHFt+1NmmXoDb0C9czlBOJhPtdB9h+sjZzzQOHL@nongnu.org
X-Gm-Message-State: AOJu0YyyqifBE2ganyImSy7gbHpGudWIwqNORrY4RqUZF2LXU5En2yFE
 gA8YzxK3Z2FzgHgxIzYtT5p9qLXeENjbAyjMv6S01+rtVvqBJmNrBn9uj4qnwL7NDuc=
X-Gm-Gg: ATEYQzzI5kp9aXd8bcs5VECu2d3qmtjy2VPdeERE2H2K9jAypxf9WNaqTXwq+xX3TtI
 xCw5ptcqoa3BDEvEeWVIyu/SfpgUYpV/uKgvvZ2o8ZZi1+eiA8acsLFYOZke53cqlEpMZ7pSG1S
 eyJ+ujWrq10zxpIt/IbwWxHvbfdcITXljDDHz/kRFoq5k45qWAzQbspPwuLXg/IOJvHghN5JzM+
 Jxh3CjSNxIclQ4XiYf79QD+h7C3GMJDLpDLriASqzFqMPUdG5lhAc1FwOQb2rqs28RcI1gkP6rd
 US0MVf69k7LeqNBHopkMx6prBE5U6Wheo+uDg3V3HqMkBsfHfayWkfGXqr8j1UWGkPfU+3yAONf
 4aHEYmaNgiYxN+gPqRFaUEe6USejD7zK2DyGH9OOBfpLepQ/jwabcpHHuQGAHICutEnEUkkK6Hc
 7Mx8TCJq+AL0PlQv90wCxHOrtxJYPGHvFRMFPuKMEVNvtUe72Q4hgl4Zv0nyihNthS9A==
X-Received: by 2002:a05:600c:3514:b0:483:a27e:6706 with SMTP id
 5b1f17b1804b1-486fedb54cdmr93139835e9.9.1774106383787; 
 Sat, 21 Mar 2026 08:19:43 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b1fe65sm203379935e9.5.2026.03.21.08.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 08:19:42 -0700 (PDT)
Message-ID: <9ed408a5-6b25-4d4e-aefc-59b413058ca6@linaro.org>
Date: Sat, 21 Mar 2026 16:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 03/10] cpus: Introduce
 CPUClass::legacy_monitor_defs hook
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <7c54cfcf-fef6-41db-a1a8-382857371d3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/3/26 23:01, Pierrick Bouvier wrote:
> On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
>> Allow targets to register their legacy target_monitor_defs()
>> in CPUClass; check it first in get_monitor_def() otherwise
>> fall back to previous per-target helper.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h | 3 +++
>>   monitor/hmp.c         | 3 ++-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 04e1f970caf..072f58bead5 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -148,6 +148,8 @@ struct SysemuCPUOps;
>>    * @max_as: Maximum valid index used to refer to the address spaces 
>> supported by
>>    *          the architecture, i.e., to refer to CPUAddressSpaces in
>>    *          CPUState::cpu_ases.
>> + * @legacy_monitor_defs: Array of MonitorDef entries. This field is 
>> legacy,
>> + *                       use @gdb_core_xml_file to dump registers 
>> instead.
>>    *
>>    * Represents a CPU family or model.
>>    */
>> @@ -174,6 +176,7 @@ struct CPUClass {
>>       const char *gdb_core_xml_file;
>>       const char * (*gdb_arch_name)(CPUState *cpu);
>>       const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>> +    const MonitorDef *legacy_monitor_defs;
>>       void (*disas_set_info)(const CPUState *cpu, disassemble_info 
>> *info);
>> diff --git a/monitor/hmp.c b/monitor/hmp.c
>> index c63da13e310..a2b6269d0ff 100644
>> --- a/monitor/hmp.c
>> +++ b/monitor/hmp.c
>> @@ -24,6 +24,7 @@
>>   #include "qemu/osdep.h"
>>   #include <dirent.h>
>> +#include "hw/core/cpu.h"
>>   #include "hw/core/qdev.h"
>>   #include "monitor-internal.h"
>>   #include "monitor/hmp.h"
>> @@ -1603,8 +1604,8 @@ void monitor_register_hmp_info_hrt(const char 
>> *name,
>>    */
>>   int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>   {
>> -    const MonitorDef *md = target_monitor_defs();
>>       CPUState *cs = mon_get_cpu(mon);
>> +    const MonitorDef *md = cs->cc->legacy_monitor_defs ?: 
>> target_monitor_defs();
>>       void *ptr;
>>       uint64_t tmp = 0;
>>       int ret;
> 
> I'm not very fond of the "keep legacy callback for the N targets that 
> might require it". Either set it for every target, using a default 
> implementation if needed, or...
> 
> As an alternative, we could use a dispatch function like:
> 
> const MonitorDef *target_monitor_defs()
> {
>    switch (target_arch()) {
>    case
>      SYS_EMU_TARGET_X:
>        return X_target_monitor_defs();
>      SYS_EMU_TARGET_Y:
>        return Y_target_monitor_defs();
>    default:
>      return default_target_monitor_defs();
>    }
> }
> 
> Personally, I prefer the dispatch approach, as it's very clear to see 
> what happens per target. This solves the symbol duplication by manually 
> name them differently.
> 
> It's just a suggestion though, and I'm ok to have a per target field, as 
> long as we enforce it to be set for all targets, and not using a 
> 'legacy' callback for a few of them only.
> 
> Pick the one you prefer :)

My preference would be to remove this legacy code altogether, as
I'm pretty sure it isn't used anymore (see for the example the
issues RISC-V folks had with it before giving up).

