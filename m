Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F35C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 05:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlLZp-0006jc-Rw; Fri, 21 Feb 2025 00:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tlLZm-0006j7-GV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 00:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tlLZk-0004do-CP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 00:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740115665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DF168dVKgRm6Uv7cc0o/jSNvdzVRIdhtMrj2lWKmhlQ=;
 b=PQWtJJ4Ds9tCn+7V1790IQhxXr5gInsfa+q/dF6w3/l3cIE6dyfxAhPz13Rtl/OQIv46SC
 lQCw0jTxeaE2QlS2hRNM9jtQECWTY+S9ZRN2kttmvA5uYrgnQBId/+9+NzwpRy5hk1TyYA
 qwBObVYFrp+fRaqbkAvut5ikejmcLDQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-m623NaR7OSm2_6Q7XuU7tg-1; Fri, 21 Feb 2025 00:27:43 -0500
X-MC-Unique: m623NaR7OSm2_6Q7XuU7tg-1
X-Mimecast-MFC-AGG-ID: m623NaR7OSm2_6Q7XuU7tg_1740115663
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-221063a808dso34803235ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 21:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740115663; x=1740720463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DF168dVKgRm6Uv7cc0o/jSNvdzVRIdhtMrj2lWKmhlQ=;
 b=pXjQOAYj1QaZW9thaFFsOpYURIo9qhVLo7Pb3g90OoFMasYYjKhe+wzrxvurY1dzeI
 qNG9FkWHwJyKM/XwBbFaVNO6LnJTpoL+gBzSNp7piy195MRb2ydRIr6+qJE3VozSJfcR
 5NhNbbouGkND7NYyEVweyzvQZt68FGOR44dm40oijAQMSI49e+/7q8FQFvFB5fH3hg8R
 lhUZgmkhApt3+cHvgV+671E5B+hE599kSZB4Xz8pKlnzfpW113DDkACWwjMyW39ASohm
 od2OOqOOgotg04AXszK/3KgUG4Z0V1s7NHUam3+HuNq9Mc7/OVnEHYR2P+7Lih2d9vHi
 Newg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhL/IOFmPW+VIt/HiJasRBpZo3PwxLW8WMWZuSfpSKpozjBXWsf8VJ0dT2v6EfcQX/7Ji57Kmfx/6@nongnu.org
X-Gm-Message-State: AOJu0YwcuXAOfqqG9GOBo4jZHStvBDZvUkqTpYkpB5UtGWQnde1jDSfw
 cRRhB/YV1PUGHLcywX2n/NOvbPhL/LWK1eNZ5H5P9w+pnDdkuEWOjugofI3iRUULWrMvAthdO06
 YgikiJ3JQhKE5bU8S1sfzIcOqsoqNV7lGwUdbf6jXaZ1ehLoK52Eo
X-Gm-Gg: ASbGncuq5ddyOZ0xZCBo3RofL4VeAojmxKsUQ29s8Bh2vhBZR/NcWsTfMoZAi7rBZ2C
 W8ciIc/ryyQT3UAQRyYAj7YWJb4wk6GlpMRbIOG8xWnV3Szlmtx1DuzZWEuBXFrytovZ0aEuXUz
 BrIbkwj3g3cCEukHHizO8pRPLH9YTdw61mGk511uiJjjzxYpqktAyFWCgXBBGlhImH3CY5PI+86
 6ZzkNONtSL7Wc7qRoYFLKIS8JyXINl/khUZeYnZOHOn7XrFdXYMMJPPK6okNrHx90A9JNgIRtis
 RWjk4BO9eELe1BBy
X-Received: by 2002:a05:6a20:8409:b0:1ee:da6e:a82b with SMTP id
 adf61e73a8af0-1eef3c8a8eamr3146436637.18.1740115662836; 
 Thu, 20 Feb 2025 21:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCbUoHzSyySDB/bo2S8TQi191Gi5Hpz0yBIEiZuoP/zbuEe+2Ap1233cInvLTxCzkvCoWXSw==
X-Received: by 2002:a05:6a20:8409:b0:1ee:da6e:a82b with SMTP id
 adf61e73a8af0-1eef3c8a8eamr3146403637.18.1740115662403; 
 Thu, 20 Feb 2025 21:27:42 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325f5d1eb9sm12146578b3a.17.2025.02.20.21.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 21:27:41 -0800 (PST)
Message-ID: <7caa54df-abe1-4833-bb59-cb83f8241962@redhat.com>
Date: Fri, 21 Feb 2025 15:27:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/arm: Retry pushing CPER error if necessary
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-5-gshan@redhat.com>
 <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/20/25 3:55 AM, Igor Mammedov wrote:
> On Fri, 14 Feb 2025 14:16:35 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> The error -1 is returned if the previously reported CPER error
>> hasn't been claimed. The virtual machine is terminated due to
>> abort(). It's conflicting to the ideal behaviour that the affected
>> vCPU retries pushing the CPER error in this case since the vCPU
>> can't proceed its execution.
>>
>> Move the chunk of code to push CPER error to a separate helper
>> report_memory_errors() and retry the request when the return
>> value from acpi_ghes_memory_errors() is greater than zero.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   target/arm/kvm.c | 31 +++++++++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 5c0bf99aec..9f063f6053 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2362,6 +2362,30 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>       return ret;
>>   }
>>   
>> +static void report_memory_error(CPUState *c, hwaddr paddr)
>> +{
>> +    int ret;
>> +
>> +    while (true) {
>> +        /* Retry if the previously report error hasn't been claimed */
>> +        ret = acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr, true);
>> +        if (ret <= 0) {
>> +            break;
>> +        }
>> +
>> +        bql_unlock();
>> +        g_usleep(1000);

Igor, thanks for the detailed comments. Sorry for a bit delay of the reply, I
was checking the code to understand it better :)

> even with bql released it's not safe to loop in here.
> consider,
>    a guest with 2 vcpus
>      * vcpu 1 gets SIGBUS due to error
>      * vcpu 2 trips over the same error and gets into this loop
>      * on guest side vcpu 1 continues to run to handle SEA but
>        might need to acquire a lock that vcpu 2 holds
> 

Agreed.

> GHESv2 error source we support, can report several errors,
> currently QEMU supports only 1 'error status block' which
> can hold several error records (CPER) (though storage size is limited)
> 
> 1:
> We can potentially add support for more GHESv2 error sources
> with their own Read ACK registers (let's say =max_cpus)
> (that is under assumption that no other error will be
> triggered while guest VCPUs handle their own SEA (upto clearing Read ACK))
> 
> 2:
> Another way could be for QEMU to allocate more error status _blocks_
> for the only one error source it has now and try to find
> empty status block to inject new error(s).
>   * it can be saturated with high rate of errors (so what do we do in case it happens?)
>   * subject to race between clearing/setting Read ACK
>      (maybe it can dealt with that on side by keeping internal read_ack counter)
> 
> 3:
> And alternatively, queue incoming errors until read ack is cleared
> and then inject pending errors in one go.
> (problem with that is that at the moment QEMU doesn't monitor
> read ack register memory so it won't notice guest clearing that)
> 
> 
> Given spec has provision for multiple error status blocks/error data entries
> it seems that #2 is an expected way to deal with the problem.
> 

I would say #1 is the ideal model because the read_ack_register is the bottleneck
and it should be scaled up to max_cpus. In that way, the bottleneck can be avoided
from the bottom. Another benefit with #1 is the error can be delivered immediately
to the vCPU where the error was raised. This matches with the syntax of SEA to me.

#2 still has the risk to saturate the multiple error status blocks if there are
high rate of errors as you said. Besides, the vCPU where read_ack_register is acknoledged
can be different from the vCPU where the error is raised, violating the syntax of
SEA.

#3's drawback is to violate the syntax of SEA, similar to #2.

However, #2/#3 wouldn't be that complicated to #1. I didn't expect big surgery to
GHES module, but it seems there isn't perfect solution without a big surgery.
I would vote for #1 to resolve the issue from the ground. What do you think, Igor?
I'm also hoping Jonathan and Mauro can provide their preference.

> PS:
> I'd prefer Mauro's series being merged 1st (once it's resplit),
> for it refactors a bunch of original code and hopefully makes
> code easier to follow/extend.
> 

Sure. I won't start the coding until the solution is confirmed. All the followup
work will base on Mauro's series.

>> +        bql_lock();
>> +    }
>> +
>> +    if (ret == 0) {
>> +        kvm_inject_arm_sea(c);
>> +    } else {
>> +        error_report("Error %d to report memory error", ret);
>> +        abort();
>> +    }
>> +}
>> +
>>   void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>   {
>>       ram_addr_t ram_addr;
>> @@ -2387,12 +2411,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                */
>>               if (code == BUS_MCEERR_AR) {
>>                   kvm_cpu_synchronize_state(c);
>> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr, false)) {
>> -                    kvm_inject_arm_sea(c);
>> -                } else {
>> -                    error_report("failed to record the error");
>> -                    abort();
>> -                }
>> +                report_memory_error(c, paddr);
>>               }
>>               return;
>>           }
> 

Thanks,
Gavin


