Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4496C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMgh-0001Xb-QB; Tue, 06 Aug 2024 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sbMgT-0001Qy-JI
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:05:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sbMgP-0002Vu-51
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:05:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so606197b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722960305; x=1723565105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItKM+Tlj7Co5dlhPJPwCdTNOBkVWDZ51q+EawMUpriE=;
 b=caogNpL8+VwAhCHntlv7vK04SY7Td4TZ5YC04zRJqgC5ylAMrZRn5Kovoh7twUJcNc
 krjLZgD+DEgv5el/XVO64ZUtmNerF13WU99R7iBAusMw10PDM0gIGEoQIMHh3dCtJPT0
 NpLivN3eC3rR3nQFnIHTZpNtUe9DzjcvGSORhRNPBuFdfrqOA1qJ9F0p5NDyjeuzwDrL
 jghbp8rVfgzd+8h37Jz2xTl4DjzOX8k8O6Jd8nro9pqli5BeKBGR6K28P61CFTWSTC0i
 WxFh1XrdXqIpEgc1zW+2bNdXRjO8Gnta1lEDfgaAnPZad8isSy9Nftbbfjd/aPDWGnKs
 GrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722960305; x=1723565105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItKM+Tlj7Co5dlhPJPwCdTNOBkVWDZ51q+EawMUpriE=;
 b=erKLoKoT2O3HOr8YRqAdlv1oWPpWtzarN0IyjltUvSvPSGT2ooxAilq2RoX3zlEPiR
 388cm3N2ZxPfN7ryXMfRnNgKm3lmJa7ZNaoMsbjtUG/XYC6bpQyY1bkX7QKHr5zaHo9Y
 QATK6DekaQBpYwksNSwVuO9QB+VW3Y3er2W8yeiRt9RuCZCdLe8M6wIyBVT1mX3tXRRR
 AwY22X4s1EuZ9knDhe22hyw5bm2UjZvTadwrgO85aD5olQ2JJrpCukX3ZU5Wd1E7pq4t
 SlP5EMu7x0fFB1mQDs7vA42D+1naHr6OfkCOWal/DMGSGH+Xb6L/H4XX8bCJbGI9bFVl
 Wk7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfR42yX/k5+A8jMkCQj5FNJaWjsdpWDJM8+XTAXXuV3oEnoXhk+yeeLFZVAR9BMkpST7NznSLOXtW8MPDRf/xQV7k6wQ4=
X-Gm-Message-State: AOJu0YxJLCpTjVMOjn1dV3z5chHH+frXao00MDkqLT/P6kMBvjfkZBjF
 o2d6aFktV/pcxggGII5Lp4MGGTbZzmDaijo1ZvBd+yQ1kamWqLnTcoklPnskUPw=
X-Google-Smtp-Source: AGHT+IFGlzhgm55q8lFqMsnxYdqv3odlA6Ll957+FUMSiQkGBni+OlISgJFiQqzcpKo5u9wIAJU3bg==
X-Received: by 2002:a05:6a00:918d:b0:70e:a4ef:e5c2 with SMTP id
 d2e1a72fcca58-7106cfce31fmr13929232b3a.13.1722960305019; 
 Tue, 06 Aug 2024 09:05:05 -0700 (PDT)
Received: from [192.168.68.110] ([177.18.66.246])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed15367sm7358000b3a.175.2024.08.06.09.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 09:05:04 -0700 (PDT)
Message-ID: <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
Date: Tue, 6 Aug 2024 13:05:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240806-9fdad33468ec103d83a85e77@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/6/24 5:46 AM, Andrew Jones wrote:
> On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
>> Counter delegation/configuration extension requires the following
>> extensions to be enabled.
>>
>> 1. Smcdeleg - To enable counter delegation from M to S
>> 2. S[m|s]csrind - To enable indirect access CSRs
>> 3. Smstateen - Indirect CSR extensions depend on it.
>> 4. Sscofpmf - To enable counter overflow feature
>> 5. S[m|s]aia - To enable counter overflow feature in virtualization
>> 6. Smcntrpmf - To enable privilege mode filtering for cycle/instret
>>
>> While first 3 are mandatory to enable the counter delegation,
>> next 3 set of extension are preferred to enable all the PMU related
>> features.
> 
> Just my 2 cents, but I think for the first three we can apply the concept
> of extension bundles, which we need for other extensions as well. In those
> cases we just auto enable all the dependencies. For the three preferred
> extensions I think we can just leave them off for 'base', but we should
> enable them by default for 'max' along with Ssccfg.

I like this idea. I would throw in all these 6 extensions in a 'pmu_advanced_ops'
(or any other better fitting name for the bundle) flag and then 'pmu_advanced_ops=true'
would enable all of those. 'pmu_advanced_ops=true,smcntrpmf=false' enables all but
'smcntrpmf' and so on.

As long as we document what the flag is enabling I don't see any problems with it.
This is how profiles are implemented after all.

With this bundle we can also use implied rule only if an extension really needs
(i.e. it breaks without) a dependency being enabled, instead of overloading it
with extensions that 'would be nice to have together' like it seems to be the
case for the last 3 extensions in that list.

I believe users would benefit more from a single flag to enable everything and
be done with it.


Thanks,

Daniel



> 
> Thanks,
> drew
> 
>> That's why, enable all of these if Ssccfg extension is
>> enabled from the commandline.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   target/riscv/cpu.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 22ba43c7ff2a..abebfcc46dea 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2665,8 +2665,20 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>>       NULL
>>   };
>>   
>> +static RISCVCPUPreferredExtsRule SSCCFG_PREFERRED = {
>> +    .ext = CPU_CFG_OFFSET(ext_ssccfg),
>> +    .preferred_multi_exts = {
>> +        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
>> +        CPU_CFG_OFFSET(ext_ssaia), CPU_CFG_OFFSET(ext_smaia),
>> +        CPU_CFG_OFFSET(ext_smstateen), CPU_CFG_OFFSET(ext_sscofpmf),
>> +        CPU_CFG_OFFSET(ext_smcntrpmf), CPU_CFG_OFFSET(ext_smcdeleg),
>> +
>> +        RISCV_PREFRRED_EXTS_RULE_END
>> +    },
>> +};
>> +
>>   RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] = {
>> -    NULL
>> +    &SSCCFG_PREFERRED, NULL
>>   };
>>   
>>   static Property riscv_cpu_properties[] = {
>>
>> -- 
>> 2.34.1
>>
>>

