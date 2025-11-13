Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BDDCD6E71
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYS2-0000rJ-Fz; Thu, 13 Nov 2025 09:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vJYQO-0007JW-1S
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:35:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vJYQL-00039a-HJ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763044542;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KlH9s8L709HhmwmfZLNRXcFcHHTi3n4aoQODNuX7DM=;
 b=NpO3sNVXLLdFwcCBhLhKh+iZqQv/5/zuAkfmCzrSMcQI2Jo6j2pyGZHR++Aeed4pRrhpA9
 qjMz1vcNtQxOKrSx/hZREPDZih9H4pUylg0a1F/SDBmoupR4vPurjwiqg0dInrnnu2xoE4
 7sTbjn1bhui5mYyYYiDUKzBt8cJ/fzY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-qN7HHBP1Mem8I_O3PMZHbQ-1; Thu, 13 Nov 2025 09:35:41 -0500
X-MC-Unique: qN7HHBP1Mem8I_O3PMZHbQ-1
X-Mimecast-MFC-AGG-ID: qN7HHBP1Mem8I_O3PMZHbQ_1763044540
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-89090e340bfso199030185a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 06:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763044540; x=1763649340;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KlH9s8L709HhmwmfZLNRXcFcHHTi3n4aoQODNuX7DM=;
 b=LjZXaVajHla/KsGwF7HCJjpU8GiMLfTn5hPWQGGE+sQWZHTDbSOc64u1cnGOad6H5W
 1H79+lqFokYsEVVOD2Q2GOGTEfzzFesx7ItrJugy2ZGA6Ux+miCvrJt5JC1f0LG0XpW0
 m6kaFvkAKu94iHpbZFtoM3wZnWvqy8EiNFW6VwaEj7cKI16AQ/Rq96vf1AqPqpGRz9XR
 sbf4YjjvIOAUCt0CqEJroxmVc7rlfhaqCdl4M+VBFqqGciLgSiTAimnRNdO+y2kss+Bz
 JZyA8LU/vZ6wqsh9HHoMeiy0pMgumGbWBl45cGLYsY9Ef6g42ETWPCMa8aRnSaGBBx5S
 BUpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFAbnfdOABnk3gl9US+EtkDjB6sQGRQKed6iCU38AGdEhTk+BWjMDD7+HkRoiByRL4QEYBaoMGvn7r@nongnu.org
X-Gm-Message-State: AOJu0YycIoP+OshZm2YSBwEIjTFPYYpSma7mjW45ZZ5shr0Y24AFcak5
 U4ziExha2v9PNWB8Hbo0irwNGQj5SbrbTLdfsPjuVCgt0UIqGr4e5niwTW3U2xLqU8955k7ES7U
 0h9n6mA9NF8g7hLnGyMNceRU0H4nG8d6xoJGXpOYKGeoBTnAuw8kYQd9X
X-Gm-Gg: ASbGncsXjTrGMxLWJIhPlCLyM75kw0skiajkW4nmPNcttbs0FKn42wZKhOxT49NEqIK
 Ki/mHaGOz82UJqD6YD6F9fdnwXUk+S0PvVgzdYYWeViTMfJ+efDuYXk1jP0EWx6aZ5lPp4s2QLV
 D/zOgSgRqi6Ow7p9WNaj+A5hFdYdSN4vbB3z9GBXoniDltRf63VzKdEi+DuiCJ2HJBzbn2k3X/D
 fojf1Ku1f1DE1OwiFMUvSyhIoILfyTi825MTNStZpDnSV0ywh70UhxP67zWFq+B/2H3aPVL/Aqo
 /TgWPEG2urlPPNfCcSNxlEP2blu+VUrj2EyMvyf6jd0RNoxMPxu5jKkwQghtdNzgaLU6ZMBku0T
 o0qsB7Pl/HorlbgwReqkeOSaEBu5KwBc62IEETEIbUqA1rw==
X-Received: by 2002:a05:620a:4409:b0:888:f40a:256 with SMTP id
 af79cd13be357-8b29b849758mr928416385a.65.1763044540319; 
 Thu, 13 Nov 2025 06:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbsjW7Lv0uOxhMYE6H+zXUrQykvudd58FoEt36AhaO1fhYEMNHxt18xfXxrK4BP0B6XxinXQ==
X-Received: by 2002:a05:620a:4409:b0:888:f40a:256 with SMTP id
 af79cd13be357-8b29b849758mr928411585a.65.1763044539805; 
 Thu, 13 Nov 2025 06:35:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aee9fb7fsm141021985a.1.2025.11.13.06.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 06:35:39 -0800 (PST)
Message-ID: <791e0383-c4c7-49bf-863c-d45428f3e48d@redhat.com>
Date: Thu, 13 Nov 2025 15:35:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/7] target/arm/machine: Improve traces on register
 mismatch during migration
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-2-eric.auger@redhat.com> <877bwtvaj7.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <877bwtvaj7.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/17/25 4:59 PM, Cornelia Huck wrote:
> On Thu, Oct 16 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
> More information is really valuable here. I have some nits :)
>
>> Currently whenthe number of KVM registers exposed by the source is
> s/whenthe/when the/
>
>> larger than the one exposed on the destination, the migration fails
>> with: "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This gives no information about which registers are causing the trouble.
>>
>> This patches rework the target/arm/machine code so that it becomes
> s/patches rework/patch reworks/
>
>> able to handle an input stream with a larger set of registers than
>> the destination and print useful information about which registers
>> are causing the trouble. The migration outcome is unchanged:
>> - unexpected registers still will fail the migration
>> - missing ones are print but will not fail the migration, as done today.
> s/print/printed/
>
>> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
>> registers compared to what exists on the target.
>>
>> If there are more registers we will still hit the previous
>> "load cpu:cpreg_vmstate_array_len" error.
>>
>> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
>> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are print.
> s/print/printed/
>
> If we really get tons of register discrepancies, I'd expect the reason for
> that to be something more obvious, so limiting should be fine.
>
>> Example:
>>
>> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
>> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
>> qemu-system-aarch64: load of migration failed: Operation not permitted
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  target/arm/cpu.h        |  6 +++++
>>  target/arm/kvm.c        | 23 ++++++++++++++++
>>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>>  target/arm/trace-events |  7 +++++
>>  4 files changed, 88 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index bf221e6f97..a7ed3f34f8 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -936,6 +936,12 @@ struct ArchCPU {
>>      uint64_t *cpreg_vmstate_values;
>>      int32_t cpreg_vmstate_array_len;
>>  
>> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
>> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_missing_indexes_array_len;
>> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
> "indices"?

Originally we had
   uint64_t *cpreg_vmstate_indexes;
so I reused the same terminology

As a non native english speaker I don't know if the usage is wrong. I
thought some references on the net though

Eric
>
>> +
>>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>>      DynamicGDBFeatureInfo dyn_svereg_feature;
>>      DynamicGDBFeatureInfo dyn_smereg_feature;
> (...)
>


