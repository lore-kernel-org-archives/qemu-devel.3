Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4836CF58C1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm5i-0008Ie-3W; Wed, 19 Nov 2025 12:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLm5g-0008IQ-PK
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLm5e-0005E5-JT
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1lw2Z4Kz9YInokjfhDL5D1lBcfHCtYdap07+ltevnI=;
 b=cTznxulfi+OTVAdMiygjXT1UBk77Xg6KecvxQ4EEg3YTI3EfSAq4mHX/HE0zFpAEQaDnB4
 ejI82dMqdq06PaX9CuQQou7rUAzmmpbcxzwjhiTehtn683+HzaGDpetnSNKMK0MWm7G2bc
 IiUQmEFwFWBxWkODvQyLA43OX+QlNq4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-BuaOvZRvO3anowadBWj1Xg-1; Wed, 19 Nov 2025 12:35:31 -0500
X-MC-Unique: BuaOvZRvO3anowadBWj1Xg-1
X-Mimecast-MFC-AGG-ID: BuaOvZRvO3anowadBWj1Xg_1763573730
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so208655e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573730; x=1764178530;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1lw2Z4Kz9YInokjfhDL5D1lBcfHCtYdap07+ltevnI=;
 b=gJtESoHTEE6M/VXv71CrupIFnuMe3ewThitnuRm3UcAAYhztJNb23HTcDxIaDVwODl
 uWIGjO2zUrEQT5H4hcrhu2Syu8KxFI6MSXtb/ZmTq93eyItcY4HqhLKCN566yBYhVj3E
 U8uCdVp9u0jX7Egf67F7kxne+CZ2kHbzA19osXKT2l2mLN4mfEG7dzKPO0uoAjM4LQmr
 TZzKHSdY7AxF/un8X7fvlXGxQwiPqYh9Un4y6k7IGX4Z1BZNe077BrWK1MtRM388kQ6I
 9Pk0AXzir6ZlY7EW5fIZ4sv7aLx8clgHKLxckbCl80Ez4irA2QF/QcF9N5LXwMwecM1K
 5AuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnPDs+WuGdMQ0OeOhDpW9n5fotgrJ+mZp8ZrkNBhdQMrMIwzZfwe4bUjzV3oSXVh8vBfMZR6q93YwI@nongnu.org
X-Gm-Message-State: AOJu0YzUugn/8VR/LSNSNmJvreZ8u+JAREscBvyznWyrYu0bUGtoklN6
 NZdHXAWL1nYxaW/cRIIBeOUnWPxNhfIqJrX95Jra8S05KmLhy9QjfztZPbftddCxRZ6kLnLQ/yv
 V3v7xhDnH+A9oGPwnDLfBWcSCiszDniP3d8LdNryARKMGiW4K7ZibfNIG
X-Gm-Gg: ASbGnctVyNhbJ6uhxRyrOuM12iV7AsOeR2Op2WUIA6VgcaMsJmYg6gsA83jHMCujsOf
 bKAwYNXSx9peoD8gd57c6syNaEf28vuXqGo9f7iOBp/BZsFGYo9yMKnnuSFS4Ffpvxtl4/qWaci
 NDvMjmUinHEZSkgbYtiHsTREuslN2zhTz+Wv/+Nui7gYrQcKyGiAdsFNMz/yFFK/ymBK27EMf5z
 KRW2+6j6GlqrudZmuVtRks9tuLczaBo8w8I+mP1BUiUsHAbSjVIE9G2NuxB2X28CvZqUlrXjvu5
 NvGwCeuh/xnR7mB7HUquRA0P5OzIvRFnr7N+GrqFNYg/abl025qwaD+8s2gJL8T7GbrCfYfjoA4
 oic1FgCXv9wNY1T81OtCs0OWrkRUlR1693vtuhOROP0Gh4r0XR8xMkuPw2w==
X-Received: by 2002:a05:600c:1c91:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-477b8a8eb6emr551755e9.17.1763573730240; 
 Wed, 19 Nov 2025 09:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOt11BSQW1Lkoju4P4M5Du3UOtN23ghkHkf/fVYVD8goCopVA2AsoHc10BtQQdt7dZpxYQQg==
X-Received: by 2002:a05:600c:1c91:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-477b8a8eb6emr551335e9.17.1763573729794; 
 Wed, 19 Nov 2025 09:35:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b82cc6c4sm3435015e9.2.2025.11.19.09.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 09:35:29 -0800 (PST)
Message-ID: <935782b9-27e3-4406-92ec-462413c3ad0b@redhat.com>
Date: Wed, 19 Nov 2025 18:35:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] target/arm/cpu: Allow registers to be hidden
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251118160920.554809-1-eric.auger@redhat.com>
 <20251118160920.554809-3-eric.auger@redhat.com> <871pluq8u5.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <871pluq8u5.fsf@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Connie,

On 11/19/25 5:35 PM, Cornelia Huck wrote:
> On Tue, Nov 18 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> More recent kernels sometimes expose new registers in an
>> unconditionnal manner. This situation breaks backward migration
>> as qemu notices there are more registers in the input stream
>> than supported on the destination host. This leads to a
>> "failed to load cpu:cpreg_vmstate_array_len" error.
>>
>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>> migration from a host kernel that features the commit to a destination
>> host that doesn't, fail with above error.
>>
>> Currently QEMU is not using that feature so ignoring this latter
>> is not a problem. An easy way to fix the migration issue is to teach
>> qemu we don't care about that register and we can simply ignore it
>> when syncing its state during migration.
>>
>> This patch introduces an array of such hidden registers. Soon it will
>> be settable through an array property.
>>
>> If hidden, the register is moved out of the array of cpreg which is
>> built in kvm_arm_init_cpreg_list(). That way their state won't be
>> synced.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - Move the property in a separate patch
>> - improve the commit msg
>> - change the trace point to just print info in
>>   kvm_arm_init_cpreg_list()
>> - improve comment in cpu.h (Connie)
>> ---
>>  target/arm/cpu.h        | 23 +++++++++++++++++++++++
>>  target/arm/kvm.c        | 12 +++++++++++-
>>  target/arm/trace-events |  2 ++
>>  3 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 077b0cce5b..0a283940be 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1044,6 +1044,18 @@ struct ArchCPU {
>>      /* KVM steal time */
>>      OnOffAuto kvm_steal_time;
>>  
>> +    /*
>> +     * Register indexes that must be hidden. Although normally
>> +     * supported (defined in TCG description or exposed by KVM) they are
>> +     * willingly hidden for migration sake. This may be used to allow
>> +     * backward migration to older versions that do implement a specific
>> +     * feature. With KVM acceleration the indexes are the ones described
>> +     * in linux/Documentation/virt/kvm/api.rst. With TCG, this is the TCG
>> +     * sysreg index.
>> +     */
> Hmm... what about
>
> "Array of register indexes that need to be hidden to allow migration in
> certain cases, i.e. when a register is exposed in KVM or defined in TCG
> but not actually used in QEMU. For the KVM case, the indexes are as
> described in Linux Documentation/virt/kvm/api.rst. For TCG, the indexes
> are the TCG sysreg indexes."
sounds good.

about the TCG index, I am not sure. It rather looks 
cpreg_to_kvm_id(ENCODE_CP_REG()) in the case of Aarch32 DBGDTRTX index I
need to use to succeed the migration



>
>> +    uint64_t *hidden_regs;
>> +    uint32_t nr_hidden_regs;
>> +
>>      /* Uniprocessor system with MP extensions */
>>      bool mp_is_up;
>>  
> Otherwise, LGTM.

Thanks!

Eric
>


