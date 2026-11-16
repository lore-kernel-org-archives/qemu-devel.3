Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976D606A894
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=k40kQm51
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSxC2-0006UC-3u; Mon, 16 Nov 2026 08:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1xSxBl-0006TY-Uz
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:56:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1xSxBj-0006hC-Po
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:56:05 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80EA93F2D1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794837361;
 bh=wl8kzpPBuwPFvMqs3QALXk57W+uxStjSHw8EooDLB2U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=k40kQm51YdGyDzTBiX69yjm9bkX1uCTFxxQoJy2PgFxaB5yyzBeaVvczqnq0dE5Sl
 dEnLxHYtYZ6kNMLjCtXET5nPc6QxwfX2gJLCN+B2xfFklEdyxqoQ9IYqY/6Y/lL0j6
 MHTQMtTMf0fRBgZsMCSEKzCi7slccgZsvtv9qVqKcReB9Gc1EJSB+ESSjm1TbDcHCs
 Nk/u5YZ6kqKgsRXHTa6Dor+CjZXPQMTXrnBn4iwntWm/EVqag+Hdb+mfkeJYk95d69
 cpSk48wOs+M3UpI2452nCO63cqDXU/yIFbYQLp+tmVFTw00zbNLXNEBEn68O0Tpdpl
 XCKclDoN0FpPDX9S4Mo/QN7RSIi0XJXKgdoz4Rli8JiPgXmB8PYlzNKPzo9ZpjLM6n
 zcuaMcie16jLKAGXy42a5ckhdwxYynyRd7VDkb70bG/VeK/jgaO4m8RGTlpTXsXr0e
 0pYAsWRI4HRNcIxA4rawBjLZmE90WKtvHGLq+kKuMidFtGlRCJQJ/BjmhKoyvSs1l0
 /wM6GX5vN4rrdcplGiKr0oWtF//3P0yX4JYUGbxOm7RS9HArHS3dtdyzXgM+cezq83
 Nm7Jat5cOc4wus1Fmc82qtYlSraRGA/x6xP9PYpFi9KL75RjxS5gHd9F9jjVEaiQMt
 8AjaaheBYqoUMbfBSIinknZw=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a70b42bab0so16282835e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837361; x=1795442161;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wl8kzpPBuwPFvMqs3QALXk57W+uxStjSHw8EooDLB2U=;
 b=hWUKHGVvN0L8cdh9X0DCaWBGTtbclrS6t/Hg5IyjTXS3rLrXzS9sV1wU6KIQHWwiux
 R/EV3UFXKXYteB3jztQA9mzGVW5iCdqwpW9BvVR//KzHT+iSdca1YFzlsf1uR77z6eg5
 PnSWy+SW5p5MSiauatgUb8Fez+vLI57CF92gwxsCbGKB9Td8/lVTqnXoqZKk+SKhU39L
 r7AKQc3ohI7Rlek3PI7jVD5vWKJlqaVjwxmlqfOEO+tK4kdvYiYmT9tRhTBT4jt1Vg+k
 cyw6s6SzI8IrumpAzPUqzoHHx1ZeDEIOWjF1j4DqSkXM4QAPBlS3BKOvOwuE8g1DL6pe
 BgCg==
X-Gm-Message-State: APuU4Z+O9Cgfky/P0TEY9zPjqD57f/hj77m8jrsAgSdUMRpv0r0Hbe9A
 RvKsYEf+9bCjAlhcatyvQGKIPspINeH75dopNWgtPt0kKvLVAYiwljSXO09HjnLBO7GaRWSUgVz
 W0EtDahCSMn8nQ5r2yXlDfRISw8QS2jRZKBHvXeHcXYNVRTh8uw4fII3aWJkOawkQPoqe5pTI
X-Gm-Gg: AYBFou3UoH9gWy6oNyOOkOHk4iG+dFfCf1T7atmYjOtl2SZ3fed97Z5K2Q1nhSYnBWx
 zJrlkLLIAPLyuDHr0cRnfTqh7HvKbHIFaAX/e1hQ2HVa7DCbCkBha1dbWGfOjCEclHg+R46BDPB
 dXAUWzGsuex8YAsztRRT1ZmlygA8W15Y+nbdz/ZiHhJuknWkTlyoqV008BbCoL/zRW9+eQlRpIH
 +mttosYOjPGRAsywP4OleAUg6inIzR8JzE8s9wYPhny9fXmxtuyY7t4ZFRy0dW+02bMyydpn2dZ
 C4UUxlEmW+JSutq05ddn3sRGOa+sjEftj0uJA6LxAe01XYnm5/6Je4+zk4jdJ1eGsBOu6O1dlca
 Ir29KjDVbkAHvV01vNFyfUQTLVdOaXBzK2ELgQpJKdUIzoDPrQY7gqVDOJNvfOLuL/wEBQC00K+
 K+o0c2donGRVKfkHlvvPIJNx2hWoaN7qJtws23IUVijpU5JPRR4hXmhirP+IYhoFgzbLKg66PXb
 A==
X-Received: by 2002:a05:600c:8b16:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb5d382639mr203014005e9.12.1794837361074; 
 Mon, 16 Nov 2026 05:56:01 -0800 (PST)
X-Received: by 2002:a05:600c:8b16:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb5d382639mr203013535e9.12.1794837360683; 
 Mon, 16 Nov 2026 05:56:00 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:beae:76e1:12ab:7bc6?
 ([2a02:908:1242:30e0:beae:76e1:12ab:7bc6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29daa5sm403874075e9.12.2026.11.16.05.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:56:00 -0800 (PST)
Message-ID: <635d77af-07e0-413f-8ce6-8908ef4bbee3@canonical.com>
Date: Mon, 16 Nov 2026 14:55:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/riscv/virt: Limit interrupt identities to what KVM
 AIA supports
To: Qingwei Hu <qingwei.hu@bytedance.com>, Stefan Butz <mail@butz.st>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Sunil V L <sunilvl@qti.qualcomm.com>, Sunil V L <sunilvl@oss.qualcomm.com>
References: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
 <20260928-spacemit-k3-v1-4-8c57d0596b87@butz.st>
 <AB465835-0ECC-4A80-A410-FBC0C945140F@bytedance.com>
 <50141629-8EFA-4AD1-9BB6-75EBE845649A@bytedance.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <50141629-8EFA-4AD1-9BB6-75EBE845649A@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 03:45, Qingwei Hu wrote:
> 
>> On Oct 6, 2026, at 10:53, Qingwei Hu <qingwei.hu@bytedance.com> wrote:
>>
>> Hi Stefan,
>>
>>> On Sep 28, 2026, at 14:06, Stefan Butz via <qemu-riscv@nongnu.org> wrote:
>>>
>>> The number of interrupt identities supported by the host's KVM AIA
>>> is limited. On Spacemit K3 and Tenstorrent Atlantis to 63.
>>> virt machine alwayas aks for 255 identities, so it fails if on those
>>> platforms.
>>>
>>> Read and apply host limit from KVM AIA device and apply.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4599
>>>
>>> Signed-off-by: Stefan Butz <mail@butz.st>
>>> ---
>>> hw/riscv/virt.c              | 12 +++++++++++-
>>> target/riscv/kvm/kvm-cpu.c   | 16 ++++++++++++++++
>>> target/riscv/kvm/kvm-stub.c  |  5 +++++
>>> target/riscv/kvm/kvm_riscv.h |  1 +
>>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 28fa31d538..2af85ec5c3 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -78,6 +78,16 @@ static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
>>>     return riscv_use_emulated_aplic(msimode);
>>> }
>>>
>>> +static void virt_kvm_aia_create(RISCVVirtState *s)
>>> +{
>>> +    kvm_riscv_aia_create();
>>> +
>>> +    s->num_msis = MIN(s->num_msis, kvm_riscv_aia_get_num_ids());
>>
>> The host may support more than 255 guest interrupt identities, but
>> this MIN() keeps num_msis capped at the default value of 255.
>> Is this intentional to preserve the existing default? Would it make
>> sense to allow users to configure a higher value when the host
>> supports it?
>>
>>> +    if (!virt_use_emulated_aplic(s->aia_type)) {
>>> +        s->num_sources = MIN(s->num_sources, s->num_msis);
>>
>> The value of num_sources has been modified here, while the value of
>> aplic_props.irqchip_num_sources set in create_fdt_sockets still uses
>> the default hard-coded value.
>>
>>> +    }
>>> +}
>>> +
>>> static bool virt_aclint_allowed(void)
>>> {
>>>     return tcg_enabled() || qtest_enabled();
>>> @@ -734,7 +744,7 @@ static void virt_machine_init(MachineState *machine)
>>>     }
>>>
>>>     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
>>> -        kvm_riscv_aia_create();
>>> +        virt_kvm_aia_create(s);
>>>     }
>>>
>>>     /* Initialize sockets */
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 1098581e7a..0409af3255 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1870,6 +1870,22 @@ void kvm_riscv_aia_create(void)
>>>     }
>>> }
>>>
>>> +uint64_t kvm_riscv_aia_get_num_ids(void)
>>> +{
>>> +    uint64_t num_ids;
>>> +    int ret;
>>> +
>>> +    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>>> +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
>>> +                            &num_ids, false, NULL);
>>
>> The KVM CONFIG_IDS GET attribute writes a u32, so num_ids should
>> be uint32_t. With the current uint64_t variable, the upper 32 bits
>> remain uninitialized and may affect the MIN() result.
>>
>> The return type, declaration, and non-KVM stub should also be
>> updated accordingly.

The same issue can be found in origin/main, e.g. for
reading KVM_DEV_RISCV_AIA_CONFIG_MODE.

[PATCH 1/1] target/riscv/kvm: aia mode is an uint32_t
https://lore.kernel.org/qemu-riscv/20261116135102.32508-1-heinrich.schuchardt@canonical.com/T/#u

Considering hypothetical big-endian usage all write accesses to 
KVM_DEV_RISCV_AIA_GRP_CONFIG should be reviewed, too.

Best regards

Heinrich

>>
>>> +    if (ret < 0) {
>>> +        error_report("KVM AIA: failed to get number of msi");
>>> +        exit(1);
>>> +    }
>>> +
>>> +    return num_ids;
>>> +}
>>> +
>>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>>>                         uint64_t aplic_base, uint64_t imsic_base,
>>> diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
>>> index 672f635b08..f5f5418b3c 100644
>>> --- a/target/riscv/kvm/kvm-stub.c
>>> +++ b/target/riscv/kvm/kvm-stub.c
>>> @@ -14,6 +14,11 @@ void kvm_riscv_aia_create(void)
>>>     g_assert_not_reached();
>>> }
>>>
>>> +uint64_t kvm_riscv_aia_get_num_ids(void)
>>> +{
>>> +    g_assert_not_reached();
>>> +}
>>> +
>>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>>>                         uint64_t aplic_base, uint64_t imsic_base,
>>> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
>>> index 532e42b0df..d8ae73fa1e 100644
>>> --- a/target/riscv/kvm/kvm_riscv.h
>>> +++ b/target/riscv/kvm/kvm_riscv.h
>>> @@ -24,6 +24,7 @@
>>> void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>>> void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>>> void kvm_riscv_aia_create(void);
>>> +uint64_t kvm_riscv_aia_get_num_ids(void);
>>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>>>                         uint64_t aplic_base, uint64_t imsic_base,
>>>
>>> -- 
>>> Git-157)
>>>
>>
>> Best regards,
>> Qingwei Hu
> 
> Hi Stefan,
> 
> Are you already working on v2 of your AIA series? If it would help, I’d be
> happy to prepare an updated version based on your patchset, addressing the
> review comments.
> 
> Please let me know if you have changes in progress so we can avoid duplicating work.
> 
> Thanks,
> Qingwei
> 
> 
> 


