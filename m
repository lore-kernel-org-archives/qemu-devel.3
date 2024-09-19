Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A1ACDD552
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 03:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr7QY-0002D6-55; Wed, 18 Sep 2024 23:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sr7QW-0002BZ-OC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 23:01:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sr7QV-0004UG-1p
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 23:01:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2068acc8b98so4161275ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726714907; x=1727319707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqBtv4OXp3A6obzu34wGIKdBspJWbTUiWxm7rhVlyOo=;
 b=sIKrFEzVAEf51mr0Wo84gdjLaa+f7EtWVYWrea1TIhr9bdjKzm8xWGcz38Ofrjeg1j
 d3ol3Ojv4JzUi8Fg+s5KitrRJ2PYVdZpCY998wBXF4UzqhYEgIbZBLv50v0WjKrJ79WN
 E0fevxsnK/6P6QFw2b8MxCl9Iu7zJkoNJ43dEnVx+ecMXJxVyToUjLRSH4EHkhReUHGp
 uFWK3HMJYAn6O9wbriPz0vuKvxDXMOEH4fow6B5S6jM4FKy31P7L1tphcpdDCYiyHYV5
 jztpfcN4YpvQTpfFAknoUJO+H1fS0xQJ97Hfb/wVNHV37MTAx/eOQ33GiHQQ9oOaD+lx
 /jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726714907; x=1727319707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqBtv4OXp3A6obzu34wGIKdBspJWbTUiWxm7rhVlyOo=;
 b=CqYQor2AmD0lushhjAkLgNP9VjzA6o9EsSWCW4OT5mSRaOMZC01Uf2Upx4vKCvhINk
 WMIslG+aO7UYjwQVgR823vBJvzQRYAWunVTq+lOw8ZflTvYJeaXFYcw2j6tLn1qJQUQb
 E1q5IuOK7FnfTrsl2Vip9/mJ8bOjDeZl1lo/SimBKFiRnrt69aduoZLMzand/JX01/Jz
 Rq0UkXCCnO6nsTCRbuoSQWJwvhXB7dRK86yoRWg0vc+npapqfwKiOeLONqjUWgGZN0d6
 gNEEVrfsnFKxVE1rDJlOWC/WFxqg+8z9r5Yv7ZzNLE/qPt1wdfO/7U370cs+tZpKXldm
 yVZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPRJjI+9FsB2unZey+h7WjaIr2JFiC+cR93SPrBoRrBmuIR5RCSteI6zBlxOP5VmnjaRCKOwgQr34V@nongnu.org
X-Gm-Message-State: AOJu0YzM1rhPGraK029muIVSV67U5SEaNw/Jqc8mZVQSqVu1p/7cKRXK
 EbbZVdzoUJT/eSlO40oKAHy0PoD1tETj1IwlMVr2JsoaGK5FO82N4oAgpnwfhRU=
X-Google-Smtp-Source: AGHT+IGj2pG61vee5ELpRccYNXfgwLhAaXzT3LY/aHNdcsy53Pb21EigopcEGi67b8JzNzrFQQKwJw==
X-Received: by 2002:a17:902:e88a:b0:205:8a25:904b with SMTP id
 d9443c01a7336-2076e45c40emr367783485ad.57.1726714907476; 
 Wed, 18 Sep 2024 20:01:47 -0700 (PDT)
Received: from [192.168.0.101] ([187.75.38.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946d1837sm71318755ad.173.2024.09.18.20.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 20:01:40 -0700 (PDT)
Message-ID: <5a2696fe-7f11-4b4d-89cc-5763dc95a677@linaro.org>
Date: Thu, 19 Sep 2024 00:01:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
To: Cornelia Huck <cohuck@redhat.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
 <87bk0mtljv.fsf@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <87bk0mtljv.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Cornelia and Ganapatrao,

On 9/17/24 11:13, Cornelia Huck wrote:
> On Thu, Sep 12 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>> Changes since V1:
>> 	Added code to enable MTE before reading register
>> id_aa64pfr1 (unmasked MTE bits).
>>
>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
>> and default case(i.e, no mte).
>>
>>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>>   target/arm/cpu.c     |  7 +++--
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>   5 files changed, 126 insertions(+), 33 deletions(-)
>>
> (...)
>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 849e2e21b3..29865609fb 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -39,6 +39,7 @@
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "target/arm/gtimer.h"
>> +#include "migration/blocker.h"
>>   
>>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>       KVM_CAP_LAST_INFO
>> @@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>>       if (vmfd < 0) {
>>           goto err;
>>       }
>> +
>> +    /*
>> +     * MTE bits of register id_aa64pfr1 are masked if MTE is
>> +     * not enabled and required to enable before VCPU
>> +     * is created. Hence enable MTE(if supported) before VCPU
>> +     * is created to read unmasked MTE bits.
>> +     */
> Maybe
>
> "KVM will mask the MTE bits in id_aa64pfr1 unless the VMM has enabled
> the MTE KVM capability, so do it here for probing."
>
> ?

KVM_CAP_ARM_MTE must be set before creating the VCPUs, as

stated in the KVM API docs, so enabling this cap. here for later

probing the MTE bits correctly feels more like a consequence. So

I prefer the the original comment, which mentions that

requirement. But I think something shorter like the following

would work too:

"MTE capability must be enabled by the VMM before creating

any VCPUs. The MTE bits of the ID_AA64PFR1 register are masked

if MTE is not enabled, allowing them to be probed correctly."


Cheers,

Gustavo


>> +    if (kvm_arm_mte_supported()) {
>> +        KVMState kvm_state;
>> +
>> +        kvm_state.fd = kvmfd;
>> +        kvm_state.vmfd = vmfd;
>> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
>> +    }
>> +
>>       cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>>       if (cpufd < 0) {
>>           goto err;

