Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC63CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpgB-0007sJ-Rq; Thu, 27 Jun 2024 10:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMpg9-0007rX-Hi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMpg8-0000mT-0Y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719496846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tHklZwhNsPO3QlY7GWCK2VHwde+DSfz0Rc62+68QOn8=;
 b=Cx67d1IiFjxhW0CD89NBbtg7CuIwQd2gqF8dGUPXtnB5xOVP6fO6Mtv5MjB1ZTE+RFJGiX
 vVdqyfTTDzEMbLBDSEYqDRjm4ZLfc2mQvqNfqJlzSjNuCxNkqYv89SLyCY0W8MogNV6RuM
 FbSzH8boKZzO8QBjbIMd5F6p5d8Fe9Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-eqo1L_uCPOW9IEqzeu08VQ-1; Thu, 27 Jun 2024 10:00:45 -0400
X-MC-Unique: eqo1L_uCPOW9IEqzeu08VQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a706f279c56so257766966b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496844; x=1720101644;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHklZwhNsPO3QlY7GWCK2VHwde+DSfz0Rc62+68QOn8=;
 b=ReDhU14OiKSNliitfFpM6BEqHzgBnyCs5Q33RwojTpEwqEotao9uhMIU84sqPaB2N3
 8BxzV4C5g0dXbpgovmvQ4eWYQgkKLq0wRH4sYEeBVhfb427u7iPdfLh12JjfqzP2/GHP
 2uaWhf4VgfZnZtKYD3DsPjRx5Cd5M2Pz/Kf5NC4l/CfYBDZVeHysYnCy6pKlnhimmODm
 rHH8ak/02v7Xpib358mJmPEU/C4XWxjyjdI8+hwj0mv72JRk2NULmWVHWBeonkc2OzBk
 KEQ5ajxOzm7EDiObFS4g9nkMmuyBm5HNAUBrSchX6HqtildyHPSKKF7URSyelxnkeeS7
 9kvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUzm0QlL0jo+DyOXf1e18ef7ZP/bmCNnntsuvex55zqXQ1NUIXNNm+Y1oiUxRXeB1A8CdtwHyv+32xxP4zbi0jT1Sc+QA=
X-Gm-Message-State: AOJu0YzGf4NBRFJa/GtFPtWQ3ADjaOieVHVw8ITHJ1HXQYrD9sGBoVVw
 O1dCSuBtJ1sh3bWESUOtuF7RNGRSJNyKy6ui+HGWj8IUOZpDYmJNY6/uztwDDIW1nGNJLuvp+ND
 lxGIDd4NDFiTRcgDxlSPsAyCOVPVQ7r3Fcm1n3AT/OmJewJQt+/HN
X-Received: by 2002:a17:907:d508:b0:a72:6ff6:b932 with SMTP id
 a640c23a62f3a-a727f895cecmr483691066b.51.1719496844045; 
 Thu, 27 Jun 2024 07:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqk5Dw66miZayQI722JNfKrL6vmmyCm3C3fcoGZ2awTSIZhsbGzJ3Kpjk3OBEi2zuWrTXbOA==
X-Received: by 2002:a17:907:d508:b0:a72:6ff6:b932 with SMTP id
 a640c23a62f3a-a727f895cecmr483688966b.51.1719496843594; 
 Thu, 27 Jun 2024 07:00:43 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.235.205])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a729d7794e8sm62636966b.128.2024.06.27.07.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 07:00:43 -0700 (PDT)
Message-ID: <0794eb13-63a6-4a6e-a0a8-5953c3c09f9f@redhat.com>
Date: Thu, 27 Jun 2024 16:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 39/42] i386: Add support for SUCCOR feature
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>, William Roche
 <william.roche@oracle.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-40-pbonzini@redhat.com>
 <c54d5f72-ecfd-46e0-baf9-324fdedd2ed3@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c54d5f72-ecfd-46e0-baf9-324fdedd2ed3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/13/24 11:50, Xiaoyao Li wrote:
> On 6/8/2024 4:34 PM, Paolo Bonzini wrote:
>> From: John Allen <john.allen@amd.com>
>>
>> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is 
>> required to
>> be exposed to guests to allow them to handle machine check exceptions 
>> on AMD
>> hosts.
>>
>> ----
>> v2:
>>    - Add "succor" feature word.
>>    - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
>>
>> Reported-by: William Roche <william.roche@oracle.com>
>> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: John Allen <john.allen@amd.com>
>> Message-ID: <20240603193622.47156-3-john.allen@amd.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> [snip]
> ...
> 
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 55a9e8a70cf..56d8e2a89ec 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -532,6 +532,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, 
>> uint32_t function,
>>            */
>>           cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
>>           ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
>> +    } else if (function == 0x80000007 && reg == R_EBX) {
>> +        ret |= CPUID_8000_0007_EBX_SUCCOR;
> 
> IMO, this is incorrect.
> 
> Why make it supported unconditionally? Shouldn't there be a KVM patch to 
> report it in KVM_GET_SUPPORTED_CPUID?

Yes, but since the bit doesn't need any hypervisor support it is common 
to also add it in QEMU.

> If make it supported unconditionally, all VMs boot with "-cpu host/max" 
> will see the CPUID bits, even if it is Intel VMs.

It should be harmless, but you're right, it's not tidy and we don't know 
for sure that it doesn't trigger weird paths in guest OSes.  I've send a 
series to fix this.

Paolo


