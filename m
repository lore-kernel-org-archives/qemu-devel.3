Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8822CD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slrBu-0002IF-0y; Wed, 04 Sep 2024 10:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slrBs-0002D8-Oa
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slrBr-0007MN-3k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725460858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c7P1uzDN/52FPeGB3kibgn6TFI+vrxiSWk93tGyE0ZQ=;
 b=DiZooLsMWUfx/LbZjGiCNIHIMR7OkX5/QYUvXXcFZVAByy5Doc81MNRJ2eppR9rLUKdPFo
 cu2eD3seKGcsdmt7VWgJA5yQk+iC/CUVMFSlOxdKlQ8vY+3a+6fSZtX5cbfS0cXdX8eXBK
 6oqGLEJQaDVnVTZAlk0/vBS1fqXg43M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-LXQrdWsmOMmoUagHufmVfg-1; Wed, 04 Sep 2024 10:40:56 -0400
X-MC-Unique: LXQrdWsmOMmoUagHufmVfg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8685464a7dso488862466b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460855; x=1726065655;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7P1uzDN/52FPeGB3kibgn6TFI+vrxiSWk93tGyE0ZQ=;
 b=t8Y1HnhEbHEplXMPFshdHFkjczUPNVEt+klV1+gRVJwgtQBB1RnlhzxDw7hPRIYrfz
 VXDa2nkE8rz+a67rAU4QzcdooV4boyBLD8MToghEz+ac2Csb1qy+xapjWQ42NFOrMrT4
 TnLAQRk8ZV9xB/qWFhTkc8HmV2MocxOUmh9i09VnU5BT55h7lOakOBwrffgjd1PQej+J
 jmPYiNqKBx5R2eQ9jT0xOXuRIrAAc+NqOG3jvABT5Y3yjH8KpaI/PlFMNlx5qYhWyV22
 GxfazxlJWzuuN+aPsLhINT3ivYcBtaA7OD/KZqdlxTWuKeUztYwX7MKMCvPifuOmYuW3
 mU/g==
X-Gm-Message-State: AOJu0YzA8MOqWdZN1WuJQAcwR84+Q6WZCWz6DUMwkdyzUjOybTC3ek9n
 /IXt7J1FoEVOY36swGPGX90yEX61z2nNv4vC9rrmdSpcmHxvQBa63N1jOfqENs5tVojmKI7CnEw
 eLC3niRg+1sLnMXKUFdHYqFSjaJfF2Cf0EUJua4RswMdxDdjXUCW02SSL+DNs/5E=
X-Received: by 2002:a17:907:980c:b0:a86:8f57:7de0 with SMTP id
 a640c23a62f3a-a89a37aa9famr1263777066b.49.1725460854200; 
 Wed, 04 Sep 2024 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaEYOuQxOteVzM57N7XhVK7OXzgSmNZoT/RmeoY23r/b0B5LA9GAOUC+Ys6m2igKLexS4wmQ==
X-Received: by 2002:a17:907:980c:b0:a86:8f57:7de0 with SMTP id
 a640c23a62f3a-a89a37aa9famr1263774266b.49.1725460853594; 
 Wed, 04 Sep 2024 07:40:53 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a8a61fbaef4sm1187166b.27.2024.09.04.07.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 07:40:53 -0700 (PDT)
Message-ID: <29c4518e-4442-4638-a35f-8ad21f07b37d@redhat.com>
Date: Wed, 4 Sep 2024 16:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] target/i386: Misc cleanup on KVM PV defs, outdated
 comments and error handling
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <ZthkvhgLMfEfXCZ8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZthkvhgLMfEfXCZ8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 15:46, Zhao Liu wrote:
> Hi Paolo,
> 
> Just a kindly ping.

It's on my list now that 9.1 has been released.

Paolo

> 
> Thanks,
> Zhao
> 
> On Wed, Jul 17, 2024 at 12:10:06AM +0800, Zhao Liu wrote:
>> Date: Wed, 17 Jul 2024 00:10:06 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: [PATCH v4 0/9] target/i386: Misc cleanup on KVM PV defs, outdated
>>   comments and error handling
>> X-Mailer: git-send-email 2.34.1
>>
>> Hi,
>>
>> This is my v4 cleanup series. Compared with v3 [1],
>>   * Returned kvm_vm_ioctl() directly in kvm_install_msr_filters().
>>   * Added a patch (patch 9) to clean up ARRAY_SIZE(msr_handlers).
>>
>>
>> Background and Introduction
>> ===========================
>>
>> This series picks cleanup from my previous kvmclock [2] (as other
>> renaming attempts were temporarily put on hold).
>>
>> In addition, this series also include the cleanup on a historically
>> workaround, recent comment of coco interface [3] and error handling
>> corner cases in kvm_arch_init().
>>
>> Avoiding the fragmentation of these misc cleanups, I consolidated them
>> all in one series and was able to tackle them in one go!
>>
>> [1]: https://lore.kernel.org/qemu-devel/20240715044955.3954304-1-zhao1.liu@intel.com/T/
>> [2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
>> [3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/
>>
>> Thanks and Best Regards,
>> Zhao
>> ---
>> Zhao Liu (9):
>>    target/i386/kvm: Add feature bit definitions for KVM CPUID
>>    target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
>>      MSR_KVM_SYSTEM_TIME definitions
>>    target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
>>    target/i386/kvm: Save/load MSRs of kvmclock2
>>      (KVM_FEATURE_CLOCKSOURCE2)
>>    target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
>>    target/i386/confidential-guest: Fix comment of
>>      x86_confidential_guest_kvm_type()
>>    target/i386/kvm: Clean up return values of MSR filter related
>>      functions
>>    target/i386/kvm: Clean up error handling in kvm_arch_init()
>>    target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
>>      KVM_MSR_FILTER_MAX_RANGES
>>
>>   hw/i386/kvm/clock.c              |   5 +-
>>   target/i386/confidential-guest.h |   2 +-
>>   target/i386/cpu.h                |  25 +++++++
>>   target/i386/kvm/kvm.c            | 113 +++++++++++++++++--------------
>>   target/i386/kvm/kvm_i386.h       |   4 +-
>>   5 files changed, 92 insertions(+), 57 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 
> 


