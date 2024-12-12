Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC194E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 21:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLqkF-0002I1-EC; Thu, 12 Dec 2024 16:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLqk8-0002Hg-Id
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLqk5-0004bm-Lv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734038943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uY+TrTBxI5R2O+5foBGFgKbI4zhzk7qXDuFF6ceEyjg=;
 b=IfyBm+9LMo813poFLr4UcttuyEi01AkE3SFyAjrBZbmY24E5U+HG6fgt+9i+TQuseBg/AP
 cy+tiklZtHeKD66z51l/XdTHKQpoktuHrFz697cWBRmTMt1pt5YsRAMiILxfU9NY7q7vGq
 Bw5KHPf2CofpCz/OyGLte4qMsEwHX7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-O-IItg3XOMeDEqPaAdRRdQ-1; Thu, 12 Dec 2024 16:29:01 -0500
X-MC-Unique: O-IItg3XOMeDEqPaAdRRdQ-1
X-Mimecast-MFC-AGG-ID: O-IItg3XOMeDEqPaAdRRdQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862b364578so1151849f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 13:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734038940; x=1734643740;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uY+TrTBxI5R2O+5foBGFgKbI4zhzk7qXDuFF6ceEyjg=;
 b=Y8ahiLBlD8ru9WE36rVrmgC11nMRL+igM4YRaqdysKi6B6leYsDjtz8dtRq053b9hX
 l01nSXPlBxfHaLTW2pZdlhgnc3/RhwIzINGn5l0snM4ms9S5anZK67UF6LRfvGyz7jvz
 06+vwGIa4sMKWfP9uDXXUxaOKjfBsiK7Mhku3EQnlP+3nnsvqs+qbJ6nih/NO6jK9VZV
 hagSW4n7P9cRy1rJYnn0gvZKSurZzFyCdlSzSBZ/tdU9bD39f+EaHEXRr555VNSxxUhr
 455WV3h38PMP3HtrvAz693t7UnMuvRgVl3hguDYTpz0gsebnxwl7UvFIZ0hMZoU8NXo5
 FgoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM2sPvZVeWEh8RjeZkYr6oabtIiJ0p+fWZtFDGXnPeKXNOHJQaGDzdYTo58CPLmNp85U2J5w1w1+AI@nongnu.org
X-Gm-Message-State: AOJu0YybYyUKqjfd+gt+Kr0qoWX0r+yf5TsYKO11blm4A40UlomuOUTt
 h5PxA2Sz4aK2lVP3jNzlCrfIGMXjPWthF8b13lX/pnGDPpQm8Jyc5lKUrBEYqyqWHXQaXCKKdP3
 BeAFXCF2MwA6tVdTDN0Ms+oDJb+zmtm1anCh8xNA938HJ6Z8Wf8pc
X-Gm-Gg: ASbGncstJz7OIuLDrG0TwkQF6BpZP0NvX3XIV79RQdNL0ksNqs/6euaQyfpqTJiPUbG
 xBPJwRe84Bj9Nd2ZKFosybDXPZeWJyFnhWF3qRvffD+PTG84wSj5tIyU6daOv3UehOYL72kOC00
 i+uVDvmYpuT0lXTwhYMqRM+OE8lBihmJoo7m5zhRBte/ZJNbDDKkGob3z104bXVlqOu2ZQKcDI6
 jXWVPzJiwL7I6tOSUP539Top4sATZ3zcMDhR7xMUZx/zF8O/IN5qzl7mcos
X-Received: by 2002:a05:6000:71d:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-388c366d199mr8352f8f.14.1734038939831; 
 Thu, 12 Dec 2024 13:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd1nbupUsOV4a1spQsi5HBxdNRlDLcHYLjUJTEpA7Y8Y5j2J2J+EAttX9xTsv44Id9sWl/ZA==
X-Received: by 2002:a05:6000:71d:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-388c366d199mr8335f8f.14.1734038939449; 
 Thu, 12 Dec 2024 13:28:59 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-387824bf19dsm4989230f8f.53.2024.12.12.13.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 13:28:58 -0800 (PST)
Message-ID: <5b8f7d63-ef0a-487f-bf9d-44421691fa85@redhat.com>
Date: Thu, 12 Dec 2024 22:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
To: Sean Christopherson <seanjc@google.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, farrah.chen@intel.com,
 kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <Z1qZygKqvjIfpOXD@intel.com>
 <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
 <Z1s1yeWKnvmh718N@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z1s1yeWKnvmh718N@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/12/24 20:13, Sean Christopherson wrote:
> On Thu, Dec 12, 2024, Paolo Bonzini wrote:
>> On 12/12/24 09:07, Zhao Liu wrote:
>>> On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
>>>> Date: Thu, 12 Dec 2024 11:26:28 +0800
>>>> From: Binbin Wu <binbin.wu@linux.intel.com>
>>>> Subject: [PATCH] i386/kvm: Set return value after handling
>>>>    KVM_EXIT_HYPERCALL
>>>> X-Mailer: git-send-email 2.46.0
>>>>
>>>> Userspace should set the ret field of hypercall after handling
>>>> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>>>>
>>>> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
>>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>>>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>>>> ---
>>>> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
>>>> otherwise, TDX guest boot could fail.
>>>> A matching QEMU tree including this patch is here:
>>>> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
>>>>
>>>> Previously, the issue was not triggered because no one would modify the ret
>>>> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
>>>> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
>>>> value could be modified.
>>>
>>> Could you explain the specific reasons here in detail? It would be
>>> helpful with debugging or reproducing the issue.
>>>
>>>> ---
>>>>    target/i386/kvm/kvm.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>>> index 8e17942c3b..4bcccb48d1 100644
>>>> --- a/target/i386/kvm/kvm.c
>>>> +++ b/target/i386/kvm/kvm.c
>>>> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>>>>    static int kvm_handle_hypercall(struct kvm_run *run)
>>>>    {
>>>> +    int ret = -EINVAL;
>>>> +
>>>>        if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
>>>> -        return kvm_handle_hc_map_gpa_range(run);
>>>> +        ret = kvm_handle_hc_map_gpa_range(run);
>>>> +
>>>> +    run->hypercall.ret = ret;
>>>
>>> ret may be negative but hypercall.ret is u64. Do we need to set it to
>>> -ret?
>>
>> If ret is less than zero, will stop the VM anyway as
>> RUN_STATE_INTERNAL_ERROR.
>>
>> If this has to be fixed in QEMU, I think there's no need to set anything
>> if ret != 0; also because kvm_convert_memory() returns -1 on error and
>> that's not how the error would be passed to the guest.
>>
>> However, I think the right fix should simply be this in KVM:
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 83fe0a78146f..e2118ba93ef6 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10066,6 +10066,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
>>   		}
>>   		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
>> +		vcpu->run->ret                = 0;
> 
> 		vcpu->run->hypercall.ret
> 
>>   		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
>>   		vcpu->run->hypercall.args[0]  = gpa;
>>   		vcpu->run->hypercall.args[1]  = npages;
>>
>> While there is arguably a change in behavior of the kernel both with
>> the patches in kvm-coco-queue and with the above one, _in practice_
>> the above change is one that userspace will not notice.
> 
> I agree that KVM should initialize "ret", but I don't think '0' is the right
> value.  KVM shouldn't assume userspace will successfully handle the hypercall.
> What happens if KVM sets vcpu->run->hypercall.ret to a non-zero value, e.g. -KVM_ENOSYS?

Unfortunately QEMU is never writing vcpu->run->hypercall.ret, so the 
guest sees -KVM_ENOSYS; this is basically the same bug that Binbin is 
fixing, just with a different value passed to the guest.

In other words, the above one-liner is pulling the "don't break 
userspace" card.

Paolo


