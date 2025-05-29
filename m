Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874ACC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXSN-0001k7-Vq; Thu, 29 May 2025 03:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKXSM-0001jm-Br
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKXSF-0003qT-GQ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748502804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JKWFmljB5JdXUZ/Bi4aSs++CFHhk/z5O7fgAyW13LFw=;
 b=dNvAW29ZbAn31RYkIdZN31Cz1zjbQET2yydwCoInVnPb9h1DCo936OJXtLtxuBGTC9nurR
 nr/8soQYVv8m/63gQ4ZxtaOT2iNnM9oiqd5TYOv1x28DtHdBK72iK+UHMNN8OQm5/+thjq
 UxH1q/edx008PmH4MD4rx6QaGam90KE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-KI48otrmOjywiguHBSBSDw-1; Thu, 29 May 2025 03:13:23 -0400
X-MC-Unique: KI48otrmOjywiguHBSBSDw-1
X-Mimecast-MFC-AGG-ID: KI48otrmOjywiguHBSBSDw_1748502802
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad5271a051eso54009166b.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748502802; x=1749107602;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JKWFmljB5JdXUZ/Bi4aSs++CFHhk/z5O7fgAyW13LFw=;
 b=VyRHdNog/Y2ASscgpg73zXOWb8MlpVC6F7h+R8aLHm0EsD5ETG6ktZleNipagD1w2r
 WYlQXfuCVZHVET52jUx0Ng5hpS6qu6C0YzWHAj/kLg2NDgitYLJPDCeH1A3o4FFIX6eX
 P4j8mUNq6RzVEZhzJfsohOZmom8ozFTGzs13TUP5eio1ZPvzvWzWBp06q2/MbOmGtj3R
 kejVq1rlT2i2TCDfW2mmf5h1UpAqhLCrQIOCEiOIc1cF0jKfiDGwAHL1E+cXPTf4YNhL
 JQ0cMCU52xTYZWAI+XMYzVLRdlruFe7/qPvrOaKSKurb/szvCrlewbfXb5s1ZiNswd2M
 8cOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRhsGqpJoDFBvJ+ps88LFk0xiv3MdFyOa2mp7NXp7oCsexnqpImMHBOaJNaXwPLu6A2i+e8epF034Q@nongnu.org
X-Gm-Message-State: AOJu0YwiM8MeKjOgU8DkwF1+asSW3/j3o51JF3vIVK0bhJPFlaiuIdeD
 14YREsXmVUSnZU/Tnexn03T7Cv66nJRhu14mJiKRPwSFtHZ8Gr/jPYU96Mtjlq5LVlNvZal4T3L
 VjYwKscMstQL2phA22pNkuyh0e+Em9KNjT33D28S8N5bmFDwSrI4dmXd1
X-Gm-Gg: ASbGncuR3Sp5PkraksV5VfanAZLBIi79OFSKPFi40kAMROTQ1ArygkabQQH6hunnzqf
 7l5JMdiAPH1/okHaQcPLGH1Wwf2ajS+7JWSQm2L7paDsaPgob7psYjRrp8eu1mL2MfUbprPk0JS
 vNvbWwQcPDOuet9mnvKQIxqdicUIJcJXh9MiNNXyLvq7tbWtGjDVaAOdy/xOizO4H3ErrmQVtab
 rXn33M970zITovhst/qyytWGtCPb+dHITmqesIwRP3RBd2sH8yrxel+l0EJzlkiUsu7GVqfK6rn
 mrqqtnnIK63NxOFpf3r5bNl9Iw8QxKvQxGn2rTxUcx6fugnKnw==
X-Received: by 2002:a17:907:2d23:b0:ad8:a935:b906 with SMTP id
 a640c23a62f3a-ad8a935c9a9mr355027566b.0.1748502801787; 
 Thu, 29 May 2025 00:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1T5Fv75IlKnIcD+j6UJ9OB2LG66qtkGfTV0KtM8NpxABM/8LbkbQQXBuSLXxYjfwj9u2X8Q==
X-Received: by 2002:a17:907:2d23:b0:ad8:a935:b906 with SMTP id
 a640c23a62f3a-ad8a935c9a9mr355024766b.0.1748502801346; 
 Thu, 29 May 2025 00:13:21 -0700 (PDT)
Received: from [192.168.154.123] (93-37-190-49.ip66.fastwebnet.it.
 [93.37.190.49]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ada5d7ff25dsm88985866b.23.2025.05.29.00.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 00:13:20 -0700 (PDT)
Message-ID: <e63cbab9-3a9b-4556-aa44-3783573df32c@redhat.com>
Date: Thu, 29 May 2025 09:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] target/i386: Add a new CPU feature word for
 CPUID.7.1.ECX
To: Xiaoyao Li <xiaoyao.li@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
 qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, xin3.li@intel.com
References: <20250103084827.1820007-1-xin@zytor.com>
 <20250103084827.1820007-3-xin@zytor.com>
 <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <859d17d7-2f5f-456c-887e-7a50134a205d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/26/25 05:47, Xiaoyao Li wrote:
> On 1/3/2025 4:48 PM, Xin Li (Intel) wrote:
>> The immediate form of MSR access instructions will use this new CPU
>> feature word.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>   target/i386/cpu.c | 23 ++++++++++++++++++++++-
>>   target/i386/cpu.h |  1 +
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 8a1223acb3..2fb05879c3 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -894,6 +894,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t 
>> vendor1,
>>   #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | 
>> CPUID_7_1_EAX_FSRS | \
>>             CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
>> +#define TCG_7_1_ECX_FEATURES 0
>>   #define TCG_7_1_EDX_FEATURES 0
>>   #define TCG_7_2_EDX_FEATURES 0
>>   #define TCG_APM_FEATURES 0
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

64 is just for MSR features.  This is a bit silly, I agree, but it is 
consistent with existing feature words and ultimately it becomes more 
compact after just 9 features.  So I'm queuing Xin's patches as they are.

Thanks for the review though!  It's always appreciated even if we disagree.

Paolo

> 
> We can just merge the next patch into this one and make it,
> 
>      .feat_names = {
>          [5] = "msr-imm",
>      },
> 
>> +        },
>> +        .cpuid = {
>> +            .eax = 7,
>> +            .needs_ecx = true, .ecx = 1,
>> +            .reg = R_ECX,
>> +        },
>> +        .tcg_features = TCG_7_1_ECX_FEATURES,
>> +    },
>>       [FEAT_7_1_EDX] = {
>>           .type = CPUID_FEATURE_WORD,
>>           .feat_names = {
>> @@ -6659,9 +6679,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>               *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
>>           } else if (count == 1) {
>>               *eax = env->features[FEAT_7_1_EAX];
>> +            *ecx = env->features[FEAT_7_1_ECX];
>>               *edx = env->features[FEAT_7_1_EDX];
>>               *ebx = 0;
>> -            *ecx = 0;
>>           } else if (count == 2) {
>>               *edx = env->features[FEAT_7_2_EDX];
>>               *eax = 0;
>> @@ -7563,6 +7583,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error 
>> **errp)
>>           x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
>> +        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
>>           x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
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
> 
>>       FEATURE_WORDS,
>>   } FeatureWord;
> 
> 
> 


