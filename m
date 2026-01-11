Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B09D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veizy-0001TZ-N3; Sat, 10 Jan 2026 19:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veizw-0001TH-Cu
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:08:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veizu-0006u9-VA
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:08:00 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so35498915ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090077; x=1768694877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyCEUpNN2PM+mXbju6RYeemInXV/YXO0CfLN1eL4emI=;
 b=iF37xvewu7ZQpO28Gek8Jd58gYpXIqyrPRuThQqs3kqiu7r9KxDduVgg/Kk2ukHjyE
 rWGyD850em+eVLcZ35W5wbqOgrEt7OjFYaudC+ZCpLMxWC8po4X7tc3U9XYpbtK2w4xa
 KQQ+khnfZsEoz0t+HiKPZErMcy1rIB2T10WtiAf/Vu8yWRGwGAI5/pJuVNPCEH0tHJRg
 EKbCihehmSgPndkCKzKyXcjSJz+pzEGJOdrC2eWka9U0E3JC29zQxxpEGjvhN4oniykX
 kZUxK7JNgiJJTkAhbzM6M56fMxd+Q+iUckl6N9NyItgdckg7lfURi5qfJVXtrHwVqHwl
 Pf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090077; x=1768694877;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyCEUpNN2PM+mXbju6RYeemInXV/YXO0CfLN1eL4emI=;
 b=QguzbRG5FHg28TCguygGkCxbLEjlB27OQvqENRqC38qxCXGX9PDotZRjTwiHrC6+Yy
 UAX8AtRWpKzQ8uP+hp6zvAkOk6/+AVBqLQHQFXJApqUNVmx2t8Vtom+7GwxeBXPTx0GB
 RI66gbfEY/GMH9EY2qDR9lmG2shKSTQ6ByERcBA4FUnFt6YNibRCkHY5RZh6UZl5Rr9s
 WiSj9qTExeW/t59/4ffVaFBDTpIlr6dRhjsE9OCO/ukhgReT9pYTXo656edVmX5cOxG5
 ppsj8WD9VOLVwghaxZZ5BF04gJ7fjDAk+rkkG22SaXEXoROLQfe2A9pOMGa62bBaeFsg
 /xew==
X-Gm-Message-State: AOJu0Yxzi0TeqYU8kA7cb1OP2ogfE0g08KJH+nHAT1hK4obDOmu6WTEc
 3gb7IDJEdTEsinf8zW+JkjFzwYU+7alQyqthQx1Hee+r6M6xW8EEbbnVYdAmiXQBEE5wFBavy6E
 dGTSzwEA=
X-Gm-Gg: AY/fxX4txin5HeO1vNi6qfycqOOLlvNB46fVsGUk8XmdCjKWBuF2bsPATKt5xeYdjET
 Z2vEyDM2N1aBqmqymOE6fU5SK+FhkmH958ZrygaC+MR3YeMjSR3gF+S3xEOjfb1AAyp2uXqX91B
 uGbPGNk7Pl47iyUSnwPiaUkcuX4kt1aRBUC0VCBrm5VLPpR1U9sAiKIKuKMJAqizxuwZ8+VAYkX
 50+3HtICr0Dh70A0jdfs0mz2mgdqQkzvdID2QFHC6mOZ+zcwBBBOfhexXKOfwa1JM3k8C806tUQ
 J2917daJ1F8rYWbODm7N320MJtAkvXHPwZk0YkFTrnhqntHpQG5NaU7IAO+h7tXcPIaop5fUDei
 YFhl2/QQiUlHluPHO2EZ2+Nt1DNHTRss5/m49NrYvbTf52oahOYZXKPJFerGqj2hg6xiKlFhO+b
 MX1LvAcEdx11532EdWClJxuZnwcg==
X-Google-Smtp-Source: AGHT+IH4H2dP4p43YCWAONJZ0vCAYnV9lrUlu1VynjRdwxvjOEzJbx9ZwPAoI+ZEXy6D1ygh7HX8vA==
X-Received: by 2002:a17:903:234c:b0:29d:6b8e:d565 with SMTP id
 d9443c01a7336-2a3ee4c0e80mr116781315ad.38.1768090077360; 
 Sat, 10 Jan 2026 16:07:57 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88fcsm135969305ad.83.2026.01.10.16.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:07:56 -0800 (PST)
Message-ID: <f904ee62-3cc2-4657-bb09-71e933df9092@linaro.org>
Date: Sun, 11 Jan 2026 11:07:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
To: qemu-devel@nongnu.org
References: <20251229231546.50604-1-philmd@linaro.org>
 <20251229231546.50604-2-philmd@linaro.org> <87v7hcd0i8.fsf@pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87v7hcd0i8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/8/26 18:30, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> cpu_get_phys_page_debug() takes a vaddr type since commit
>> 00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
>> hook").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>> ---
>>   monitor/hmp-cmds-target.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
>> index e9820611466..2976f986d35 100644
>> --- a/monitor/hmp-cmds-target.c
>> +++ b/monitor/hmp-cmds-target.c
>> @@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>>   
>>   void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>>   {
>> -    target_ulong addr = qdict_get_int(qdict, "addr");
>> +    vaddr addr = qdict_get_int(qdict, "addr");
>>       CPUState *cs = mon_get_cpu(mon);
>>       hwaddr gpa;
> 
>         if (!cs) {
>             monitor_printf(mon, "No cpu\n");
>             return;
>         }
> 
>         gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
>         if (gpa == -1) {
>             monitor_printf(mon, "Unmapped\n");
>         } else {
>             monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
>                            gpa + (addr & ~TARGET_PAGE_MASK));
> 
> Pardon my ignorant question: is HWADDR_PRIx appropriate for vaddr?

The print argument is gpa + offset, and hpa is hwaddr.


r~

