Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xYc-0003h0-9L; Fri, 03 May 2024 14:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xYZ-0003gM-5y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:22:51 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xYX-0001xK-AL
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:22:50 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so3429666b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714760568; x=1715365368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0B8Kp8I+pZe8HtYdpqqePpbeGetGBTcIfaEC3SQF7A=;
 b=MlosjsNZ+okVqhR5GZUsA4mX/YGAfM4UZayp9oX1cvwQe9AMfg7BjuxEAOqRr/KoOz
 oKIGIPVy4UU3U3THhXYnZDCEuYc/BONMtvqhywFANp5LDBnLe6McoccY0UjnHhg/7IIc
 8n4I7cBMHUYDQsvJ/QGpTnlAXa728NglDXE+axeKbkTzlUlAt+sMor2senXYPqOCPnjs
 fyjgZG9gubk3NFxx75wav8OCJdUW/heuYjAsbpq2sqp0uKZi3lWyCfTqR6bC30hb6Lv1
 IPhYWC9jmiR1Ac7LxGVLTN7eXkS6M3MmtUkYfycns+lcs0n9dVLYEAOJtWS8adY75vv8
 QR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714760568; x=1715365368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0B8Kp8I+pZe8HtYdpqqePpbeGetGBTcIfaEC3SQF7A=;
 b=Me62UPMjwm/InprGC+j4AviVeCceHbhrIrrm1oQQyZtOYslkG9FH+JyKj3JJWPGsfX
 rpg4pRQeM6SDj+SoncxE7xWpFNs6wj/tmwUW2txVwYMpKlGobnxKT4Zcto0YaL1vbrYe
 qIZX0j4S1q8cJhGGusG1KBb1Q1HXXc8IfebqMCH3nvjRCtEtWPpaGBAhBcUFh2p67Zvw
 574mJqKI9ciF1isYw+SkIb3l/ceorZsbeYaqJgheR5WJNpGaR1GLMPhWtvqwvvefIqRh
 /5fg4UMkZ5b3Sz0NjMy1QZq6g8LBNy58PlaPEfmDJRZV/9IS6iL1Cin6gBKn2dYcfdYE
 Taqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkeC90elI47+SBoS/eT/N64je+vFTvzaKQ0SLF3aRf9RH2KOIvDMgpSpNW72TmlDkPaRRt5RE3kmPbbq0vO6dJobHpTEk=
X-Gm-Message-State: AOJu0YxizM9wPmQ3tsqHQqtMOBrc5q1Mc6NydrWOTj47PXUNmPkb0GUb
 ctuh+rLbLOiom+YrVxkPbccLKyL0PcMG+dDW5uYfInqKkP6bHFxOm8WxOOjY9Ig=
X-Google-Smtp-Source: AGHT+IHaRKSzLB8eo2c1V8i9ct56vfFLivlDJKBcAPOObW/FTJ24uCx1lmd1NBR1l4qpEETGpNpOaA==
X-Received: by 2002:a17:906:4f0f:b0:a58:e569:1242 with SMTP id
 t15-20020a1709064f0f00b00a58e5691242mr1929230eju.4.1714760567635; 
 Fri, 03 May 2024 11:22:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a17090615c200b00a58f15b070dsm1952439ejd.43.2024.05.03.11.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:22:47 -0700 (PDT)
Message-ID: <2f817b76-8090-418b-8547-98d366c52838@linaro.org>
Date: Fri, 3 May 2024 20:22:43 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ed20ba7ef8d949fea9b81ed194c59bf6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 3/5/24 17:57, Salil Mehta wrote:
> Hi Philippe,
> 
>>   From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   Sent: Friday, May 3, 2024 10:40 AM
>>   Subject: Re: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
>>   {creation,parking} code
>>   
>>   Hi Salil,
>>   
>>   On 12/3/24 02:59, Salil Mehta wrote:
>>   > KVM vCPU creation is done once during the vCPU realization when Qemu
>>   > vCPU thread is spawned. This is common to all the architectures as of now.
>>   >
>>   > Hot-unplug of vCPU results in destruction of the vCPU object in QOM
>>   > but the corresponding KVM vCPU object in the Host KVM is not destroyed
>>   > as KVM doesn't support vCPU removal. Therefore, its representative KVM
>>   > vCPU object/context in Qemu is parked.
>>   >
>>   > Refactor architecture common logic so that some APIs could be reused
>>   > by vCPU Hotplug code of some architectures likes ARM, Loongson etc.
>>   > Update new/old APIs with trace events instead of DPRINTF. No functional
>>   change is intended here.
>>   >
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > Reviewed-by: Gavin Shan <gshan@redhat.com>
>>   > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>   > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>   > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>   > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>   > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>   > ---
>>   >   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++------
>>   ----
>>   >   accel/kvm/trace-events |  5 +++-
>>   >   include/sysemu/kvm.h   | 16 +++++++++++
>>   >   3 files changed, 69 insertions(+), 16 deletions(-)
>>   >
>>   > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>   > a8cecd040e..3bc3207bda 100644
>>   > --- a/accel/kvm/kvm-all.c
>>   > +++ b/accel/kvm/kvm-all.c
>>   > @@ -126,6 +126,7 @@ static QemuMutex kml_slots_lock;
>>   >   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>>   >
>>   >   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>>   > +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>>   >
>>   >   static inline void kvm_resample_fd_remove(int gsi)
>>   >   {
>>   > @@ -314,14 +315,53 @@ err:
>>   >       return ret;
>>   >   }
>>   >
>>   > +void kvm_park_vcpu(CPUState *cpu)
>>   > +{
>>   > +    struct KVMParkedVcpu *vcpu;
>>   > +
>>   > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   > +
>>   > +    vcpu = g_malloc0(sizeof(*vcpu));
>>   > +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>>   > +    vcpu->kvm_fd = cpu->kvm_fd;
>>   > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node); }
>>   > +
>>   > +int kvm_create_vcpu(CPUState *cpu)
>>   > +{
>>   > +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
>>   > +    KVMState *s = kvm_state;
>>   > +    int kvm_fd;
>>   > +
>>   > +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   > +
>>   > +    /* check if the KVM vCPU already exist but is parked */
>>   > +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
>>   > +    if (kvm_fd < 0) {
>>   > +        /* vCPU not parked: create a new KVM vCPU */
>>   > +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>>   > +        if (kvm_fd < 0) {
>>   > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu",  vcpu_id);
>>   > +            return kvm_fd;
>>   > +        }
>>   > +    }
>>   > +
>>   > +    cpu->kvm_fd = kvm_fd;
>>   > +    cpu->kvm_state = s;
>>   > +    cpu->vcpu_dirty = true;
>>   > +    cpu->dirty_pages = 0;
>>   > +    cpu->throttle_us_per_full = 0;
>>   > +
>>   > +    return 0;
>>   > +}
>>   
>>   This seems generic enough to be implemented for all accelerators.
>>   
>>   See AccelOpsClass in include/sysemu/accel-ops.h.
>>   
>>   That said, can be done later on top.
> 
> Let me understand correctly. Are you suggesting to implement above even for
> HVF, TCG, QTEST etc?

Not for you to implement the other non-KVM accelerators, but since
you are introducing this, now is a good time to think about a generic
interface.

So far AccelOpsClass::[un]park_vcpu() handlers make sense to me.

> Thanks
> Salil.
> 
> 
> 
> 


