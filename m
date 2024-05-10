Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7BFC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5RTT-0000Kn-V0; Fri, 10 May 2024 10:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5RTO-0000Ii-FY
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:43:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5RTM-0006qa-DY
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:43:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a599c55055dso551779466b.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715352222; x=1715957022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pzrPkNNMUY38XC4/Eb7sqyd3JaDqPzJLdSElwVxzsVs=;
 b=gYe/rs/TaLESfePocYcCLogO2sGT89WejSzOUlxLDwDMBa+el1Z5TFii2IrjbNrCUt
 HtbnIU+OdbTAd2eLJgVffeShA0sxE1ZWK2bJF1nCaQezbg6NW8aARFOjs6s3OBOVxYhT
 EJkHHt5fqmE8hgnLd1MLkLTKXf6/q153CYSeDf++B9e50EUQ2u/8TEb4fSBKppD+qF8D
 8XVtQTFQ73uKma+lkqCI/YTcotG9Ol3YBpBldiMKzigNdIZFQS/EzonJlk4dNYioveMd
 y9bDGoZvBhaAIxn2kq2bVuP4wcgJKjLyMA/oOzJLlGXVb+1AKgKsX2Qjh9jzWiylzxFo
 EUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715352222; x=1715957022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzrPkNNMUY38XC4/Eb7sqyd3JaDqPzJLdSElwVxzsVs=;
 b=Fvz7U+SdRi+XPricUnK+2yhEui+uauM6d2wSFHRW6+UqOFVNkChX80GU+IWgQqdO7g
 RYejCkgZLI4omirYQ02EvwuldRSHWBhqfQZxUpHZOlRewN2IyDTGQsFYk5A/KCRYBSv3
 vFtAbCtUyBVRZmxL3HKurW1r1fSIBi1uwpps70XZVy9Mh4b7HydhJ4s7B0Uklj7dWO5Q
 +XiROA2HCP0lYPKvB1BXs3UfEng1AFKt62wDBPefHJLdt6kBBXynfIM8fe1MI59iBC+T
 5qkKerIexNEBdWqzxmesw8qiKV4iXQr+rld+z4Qp0s02u909Ta9z4K9DofhlCfz2+6fF
 NlpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDN6oAzPk7ZBu4/mC+V+wOuJXzzA6bY5iPq/FwS2MjbYh4w6UnFF1NJKSNtjdosER0X1HeFhSNE09in3bHkT1f0+H8/+0=
X-Gm-Message-State: AOJu0Yypms1w7F48qXbMXZnLtuREHIzNYW8o8jMP/kP1hHqS0ZOw6hBH
 tXbCGKghokZu7JneLpsYMhL92bBAezhHFv//HdkkBDTKy9iwUJ/WAwkwElqJjac=
X-Google-Smtp-Source: AGHT+IE/x+aFqSAIP+P33UWs1eMwCIVtb4RQa4OiotnfVecAK9waIFaN5NjngxhvKJB97+RQw7y4ow==
X-Received: by 2002:a17:906:f1ca:b0:a52:2486:299f with SMTP id
 a640c23a62f3a-a5a2d67864amr189561266b.71.1715352222427; 
 Fri, 10 May 2024 07:43:42 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17892450sm192570766b.63.2024.05.10.07.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 07:43:41 -0700 (PDT)
Message-ID: <e94b0e14-efee-4050-9c9f-08382a36b63a@linaro.org>
Date: Fri, 10 May 2024 16:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
 <9747db79-4444-4d31-b014-8c368936cab4@linaro.org>
 <ed20ba7ef8d949fea9b81ed194c59bf6@huawei.com>
 <2f817b76-8090-418b-8547-98d366c52838@linaro.org>
 <ec1f4df024d94542a55835c852eededb@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ec1f4df024d94542a55835c852eededb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 8/5/24 12:46, Salil Mehta wrote:
> Hi Phillipe,
> 
> Sorry, I missed this mail earlier.
> 
>>   From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   Sent: Friday, May 3, 2024 7:23 PM
>>   To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
>>   qemu-arm@nongnu.org
>>   
>>   On 3/5/24 17:57, Salil Mehta wrote:
>>   > Hi Philippe,
>>   >
>>   >>   From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   >>   Sent: Friday, May 3, 2024 10:40 AM
>>   >>   Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
>>   >>   {creation,parking} code
>>   >>
>>   >>   Hi Salil,
>>   >>
>>   >>   On 12/3/24 02:59, Salil Mehta wrote:
>>   >>   > KVM vCPU creation is done once during the vCPU realization when Qemu
>>   >>   > vCPU thread is spawned. This is common to all the architectures as of now.
>>   >>   >
>>   >>   > Hot-unplug of vCPU results in destruction of the vCPU object in QOM
>>   >>   > but the corresponding KVM vCPU object in the Host KVM is not destroyed
>>   >>   > as KVM doesn't support vCPU removal. Therefore, its representative KVM
>>   >>   > vCPU object/context in Qemu is parked.
>>   >>   >
>>   >>   > Refactor architecture common logic so that some APIs could be reused
>>   >>   > by vCPU Hotplug code of some architectures likes ARM, Loongson etc.
>>   >>   > Update new/old APIs with trace events instead of DPRINTF. No functional
>>   >>   change is intended here.
>>   >>   >
>>   >>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   >>   > Reviewed-by: Gavin Shan <gshan@redhat.com>
>>   >>   > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>   >>   > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>   >>   > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>   >>   > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>   >>   > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>   >>   > ---
>>   >>   >   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++-
>>   -----
>>   >>   ----
>>   >>   >   accel/kvm/trace-events |  5 +++-
>>   >>   >   include/sysemu/kvm.h   | 16 +++++++++++
>>   >>   >   3 files changed, 69 insertions(+), 16 deletions(-)
>>   >>   >
>>   >>   > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>   >>   > a8cecd040e..3bc3207bda 100644
>>   >>   > --- a/accel/kvm/kvm-all.c
>>   >>   > +++ b/accel/kvm/kvm-all.c
>>   >>   > @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
>>   >>   >   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>>   >>   >
>>   >>   >   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>>   >>   > +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>>   >>   >
>>   >>   >   static inline void kvm_resample_fd_remove(int gsi)
>>   >>   >   {
>>   >>   > @@ -314,14 +315,53 @@ err:
>>   >>   >       return ret;
>>   >>   >   }
>>   >>   >
>>   >>   > +void kvm_park_vcpu(CPUState *cpu)
>>   >>   > +{
>>   >>   > +    struct KVMParkedVcpu *vcpu;
>>   >>   > +
>>   >>   > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   >>   > +
>>   >>   > +    vcpu = g_malloc0(sizeof(*vcpu));
>>   >>   > +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>   >>   > +    vcpu->kvm_fd = cpu->kvm_fd;
>>   >>   > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node); }
>>   >>   > +
>>   >>   > +int kvm_create_vcpu(CPUState *cpu)
>>   >>   > +{
>>   >>   > +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>>   >>   > +    KVMState *s = kvm_state;
>>   >>   > +    int kvm_fd;
>>   >>   > +
>>   >>   > +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   >>   > +
>>   >>   > +    /* check if the KVM vCPU already exist but is parked */
>>   >>   > +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
>>   >>   > +    if (kvm_fd < 0) {
>>   >>   > +        /* vCPU not parked: create a new KVM vCPU */
>>   >>   > +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>>   >>   > +        if (kvm_fd < 0) {
>>   >>   > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
>>   >>   > +            return kvm_fd;
>>   >>   > +        }
>>   >>   > +    }
>>   >>   > +
>>   >>   > +    cpu->kvm_fd = kvm_fd;
>>   >>   > +    cpu->kvm_state = s;
>>   >>   > +    cpu->vcpu_dirty = true;
>>   >>   > +    cpu->dirty_pages = 0;
>>   >>   > +    cpu->throttle_us_per_full = 0;
>>   >>   > +
>>   >>   > +    return 0;
>>   >>   > +}
>>   >>
>>   >>   This seems generic enough to be implemented for all accelerators.
>>   >>
>>   >>   See AccelOpsClass in include/sysemu/accel-ops.h.
>>   >>
>>   >>   That said, can be done later on top.
>>   >
>>   > Let me understand correctly. Are you suggesting to implement above
>>   > even for HVF, TCG, QTEST etc?
>>   
>>   Not for you to implement the other non-KVM accelerators, but since you
>>   are introducing this, now is a good time to think about a generic interface.
>>   
>>   So far AccelOpsClass::[un]park_vcpu() handlers make sense to me.
> 
> Sure, but what is the advantage of defining these 'supporting' functions
> as part of the AccelOpsClass? Each of these functions in any case will need
> to be defined individually for different Accelerators or unless we are
> planning to extract some common accelerator functions in a separate file
> and use them across all the accelerators?

kvm_arm_create_host_vcpu() [*] seems generic. Maybe we could do the
same with HVF at least.

[*] 
https://lore.kernel.org/qemu-devel/20230926100436.28284-7-salil.mehta@huawei.com/
> 
> I'm surely missing some key point here.

I started https://etherpad.opendev.org/p/QEMU_vCPU_life to
document the vCPU spagetti code. In that big picture the "park"
method makes sense to me, but we can discuss that later. Again,
certainly not a block for your work, I'm just trying to see
the whole view.

Regards,

Phil.


