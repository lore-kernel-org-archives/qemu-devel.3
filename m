Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285B7C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXC6-0005fR-1u; Thu, 29 May 2025 02:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uKXC3-0005es-Jp
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:56:47 -0400
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uKXC1-0002FW-Dw
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:56:47 -0400
Received: from [192.168.7.202] ([71.202.166.45]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54T6uX1P1799595
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 28 May 2025 23:56:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54T6uX1P1799595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2025052101; t=1748501793;
 bh=/5Ur5Pa3Td8+vAmSxQurSCEo0K1pI21mKg5/70LTAHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IkJXNUtO6N9XEVzYzctCtpJNnFuzosllmR6r8p2CSvdVRD6RJc9VbJmuHJhIlT2Zh
 RcgzhN1sI7X3dk2lgBkyTQXzfeTwfy29jzp2H00O7iwnRiauvUVHeJJDLw+XzwJNl6
 Us4e6gcUO4VQ5SiTdXl8xkRzBLIZSES3AizD6DwHFfIXVaidvwXD6gi4+4K4AM6pTo
 Sfv8/xwEm9mukZ9sjoTUKNoHDTMitcfv1meEIFEym3QI+Jmj73VIvu4EqVzovMGKZR
 pRzZ1E1WeJgsdm/IijHam2su5MuztQ1nnhzBhIGfZ8lvreLb6HCLaUDaYQ7bZVxvEP
 B6uM/oTWmKgbg==
Message-ID: <8d0dd957-c5dd-4220-9ba2-aa4b273dbae2@zytor.com>
Date: Wed, 28 May 2025 23:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add a new CPU feature word for
 CPUID.7.1.ECX
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
References: <20250103084827.1820007-1-xin@zytor.com>
 <20250103084827.1820007-3-xin@zytor.com>
 <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::136; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/25/2025 8:47 PM, Xiaoyao Li wrote:
> On 1/3/2025 4:48 PM, Xin Li (Intel) wrote:
>> @@ -1133,6 +1134,25 @@ FeatureWordInfo 
>> feature_word_info[FEATURE_WORDS] = {
>>           },
>>           .tcg_features = TCG_7_1_EAX_FEATURES,
>>       },
>> +    [FEAT_7_1_ECX] = {
>> +        .type = CPUID_FEATURE_WORD,
>> +        .feat_names = {
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
> 
> This looks silly, and the size of feat_names[] was changed from 32 to 
> 64. Just explicitly assign the first 32 entries with NULL doesn't make 
> any sense after the size change.
> 
> We can just merge the next patch into this one and make it,
> 
>      .feat_names = {
>          [5] = "msr-imm",
>      },

I appreciate this format that clearly indicates which bit corresponds to
which feature, and I'm inclined to proceed with the change.

On the flip side, I hope the new format won't be perceived as disrupting
the consistency of the existing codebase.  If this form could get called 
out by maintainers, there needs a cleanup patch to change all the
instances.

>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index dbd8f1ffc7..d23fa96549 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -667,6 +667,7 @@ typedef enum FeatureWord {
>>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
>>       FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
>> +    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
> 
> I would prefer the newly added leaf being ordered at least in the same 
> leaf. i.e.,
> 
> @@ -661,6 +661,7 @@ typedef enum FeatureWord {
>       FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX 
> ATTRIBUTES[31:0]) */
>       FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
>       FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
> +    FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
>       FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
>       FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
>       FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
> 
> They are QEMU internally data, injecting a new one instead of putting it 
> at the end is OK to me.

Makes sense to me.  Will move FEAT_7_1_ECX, FEAT_7_1_EDX and 
FEAT_7_2_EDX immediate after FEAT_7_1_EAX.

Thanks!
     Xin

