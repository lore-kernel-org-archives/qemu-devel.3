Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D40EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPAD-0004cb-Qt; Mon, 12 May 2025 05:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEPAB-0004Z5-6q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEPA8-0004qi-PP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747040968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HqKyjEVR/Q8YEGRAuysSt3y67/T8DQuMaByAK8Y4qWk=;
 b=E/0cnD9cR+5atzhn/XfBBAymXpRte/9LBDqXmLvvjIjZiNMUr3UUfB8bDZ9jK3rETrHABq
 +uir8idt0iy17D9eIj9oIhvlk6xUXr6VgtyqkZdXihriQlCrQ6ajkp19npTBzBeVw8WMgP
 Wm8okYHntgKjt8rLUsWHUSiJWwDiAb0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-ueU-ULDiPDeEcn_4e6ex9Q-1; Mon, 12 May 2025 05:09:26 -0400
X-MC-Unique: ueU-ULDiPDeEcn_4e6ex9Q-1
X-Mimecast-MFC-AGG-ID: ueU-ULDiPDeEcn_4e6ex9Q_1747040965
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442cd12d151so26806585e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747040965; x=1747645765;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HqKyjEVR/Q8YEGRAuysSt3y67/T8DQuMaByAK8Y4qWk=;
 b=IkknRdFC8u8um2MFPEHcphoZ93qIaj8mbQIDEjbO9f+CsKeSIzt6xzxiKeMZhmg+GC
 n5dcnVr5pdhBy4HsqhfGR0PD3pYc1Ln0TAmbEtkpJoKrlTGUWactE5QxEqkFO3h2XBTG
 8z1pPmtNtS9yQqKzoeMb7pARDyriXfco/ZWS6qoE9KsN2YMYO9EXfFgA1UsokZ90b/dM
 dw/CdQq/FCHe1hFobFvejrHj3NOsRMjQz9EuIc7O0sCbuhl7D0QhaTH+mawSc1b9Y6O0
 R2bHgdHuMsjCEaz/xOxeuT8rcRWngt2lkWu2ouufXNxObje0m2lmH7FRAjIj+2JE1p1O
 1pNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJgpuMYhJT929dtmvAZl/fM6yiDWWu3XY9jIfQqGPIC0YZUEK8mGWGtani6H3Z60YEDnqAWwbf6P8G@nongnu.org
X-Gm-Message-State: AOJu0YxHusnUIDkU1Q6z/ZKY12aaOXlKoO8toPYGv4ssta/qL1OBoqJT
 g09ti5qvGtFHJbW7uIZ/Dp9StBCUludl7N8/GvMe16COf5ng0U5kvzrcnJmbBOzkOeffgBam8iy
 CFbw2+zLXEk4NC5b4St/c6Om2Cad2DYfKJVKZYy2j1g0wuv8YROP1
X-Gm-Gg: ASbGncvQZYRveTX8bgK16q1kcuR1VAwjhX9kL5fzQdR65btuNOnrpzjrrnqfyZPEroo
 jxhJAulJbwW01d91u8VsKVRiP70gK8mZm9wbrBvrFun2HgGLJFyGiUhQ177FCMX7pxpZHeC4Oyj
 xwjGordzH+BLZJS2R63Jl1ad1379f7uK54SnLVbgXjcL4vnAED/7wq17HBeih1CQK4Dc4EstBQb
 Vz7I+CYCeyGkizR9XdJgMed1TXXo24Lw251MNhaTR70KDncFlFMrrr+eBYnmmU6GPX4Q5M83MFA
 IFlZQ5UfukXfYvVVGo2BW/aOemEreiATp3LhUnyEZOx+oiryPSFZgHYPW5TlifMhFds8EDoRWMc
 0TDo5Q78HRADnvWt7ueYqBFILhdZ4iBk0NREO4Y4=
X-Received: by 2002:a05:600c:64c9:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-442d6de535amr89664395e9.32.1747040964946; 
 Mon, 12 May 2025 02:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwff7v5a8byMrXSlLv/6Cgq7r3VB9uwPo4d/4vL7gdju+j1Ez9qRQKJEkQMp7PDzHky+oNsw==
X-Received: by 2002:a05:600c:64c9:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-442d6de535amr89664075e9.32.1747040964541; 
 Mon, 12 May 2025 02:09:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0?
 (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de.
 [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeccdsm159135585e9.32.2025.05.12.02.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 02:09:23 -0700 (PDT)
Message-ID: <ba792558-6b92-4fcc-9e48-d48797b0207b@redhat.com>
Date: Mon, 12 May 2025 11:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/23] target/s390x: call plugin trap callbacks
To: Julian Ganz <ganz@fzi.de>, qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <cover.1746968215.git.neither@nut.email>
 <e7b270caf050f837fb9222a88cd4f156c608d197.1746968215.git.neither@nut.email>
 <f9602133-c616-4b41-b856-785767644257@redhat.com>
 <20250512084352.2424-1-ganz@fzi.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250512084352.2424-1-ganz@fzi.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 12.05.25 10:43, Julian Ganz wrote:
> From: Julian Ganz <neither@nut.email>
> 
> Hi David,
> 
> It appears you only replied to the qemu-devel list? I just saw this when
> informing a co-worker about this series.

Yeah, sorry for that. My tired mind clicked the wrong button (reply to 
sender only ...)

> 
>> On 11.05.25 15:14, Julian Ganz wrote:
>>> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
>>> index e4c75d0ce0..b7e7a4deff 100644
>>> --- a/target/s390x/tcg/excp_helper.c
>>> +++ b/target/s390x/tcg/excp_helper.c
>>> @@ -34,6 +34,7 @@
>>>    #include "hw/s390x/s390_flic.h"
>>>    #include "hw/boards.h"
>>>    #endif
>>> +#include "qemu/plugin.h"
>>>    
>>>    G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
>>>                                               uint32_t code, uintptr_t ra)
>>> @@ -499,6 +500,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
>>>        S390CPU *cpu = S390_CPU(cs);
>>>        CPUS390XState *env = &cpu->env;
>>>        bool stopped = false;
>>> +    uint64_t last_pc = cpu->env.psw.addr;
>>>    
>>>        qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
>>>                      __func__, cs->exception_index, env->psw.mask, env->psw.addr);
>>> @@ -528,21 +530,27 @@ try_deliver:
>>>        switch (cs->exception_index) {
>>>        case EXCP_PGM:
>>>            do_program_interrupt(env);
>>> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>            break;
>>>        case EXCP_SVC:
>>>            do_svc_interrupt(env);
>>> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>            break;
>>>        case EXCP_EXT:
>>>            do_ext_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>            break;
>>>        case EXCP_IO:
>>>            do_io_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>            break;
>>>        case EXCP_MCHK:
>>>            do_mchk_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>            break;
>>>        case EXCP_RESTART:
>>>            do_restart_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>
>> Might be easier to check for "if (cs->exception_index != EXCP_STOP)"
>> after that switch-case.
> 
> I still need to differentiate between exceptions and interrupts, which
> would result in another switch-case.

Ah, again ... need more coffee :)

> 
>> But I'm curious about the semantics: are we supposed to call
>> qemu_plugin_vcpu_interrupt_cb() just after an interrupt got delivered?
> 
> `qemu_plugin_vcpu_interrupt_cb` or `qemu_plugin_vcpu_exception_cb` need
> to be called after the CPU was set up (that is, after PC and any other
> relevant register was set) and before the next instruction is executed.
> So, yes, more or less.


Okay, thanks for the clarification!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


