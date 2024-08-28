Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF5C7112F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 20:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjPDE-0005tz-7T; Wed, 28 Aug 2024 16:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjPDC-0005qm-4H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:24:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjPD9-0005et-QH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:24:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso6061386b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724876650; x=1725481450; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gguf8t3rKhToKTPy5d+X9ibzd4TMeHO1MB4Pi9unjgo=;
 b=TsjaUTew8DaD1aIzyS3VOLJRG75plIaxIWXYcNRcVlr0WJOfGJgzlMS8cUb5aygTAv
 lCKhqEvUK8yXE1k+Pz3cwZudorCmxeGz/s26jIprTxnpzOCuQcGrSfoUh/PCI9F3oSA5
 FLJwVANU39/ZRmBCrlaZYW37O8jHtELMbzpABOsRhmpIG7E5ygPVXk5qb8w2FMQich2L
 248bn0pijSEtXxA7JoMnLLux4jU8fBQAGVH4K9Wu0wyFST08zK8JccUrSdDl7aY6V4yG
 zoIUulpdMZHBb6stNbzicbdLSKP2z9es3GaVvNgS90CxOpTEo4+M66f/EdBolFE0/858
 RT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724876650; x=1725481450;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gguf8t3rKhToKTPy5d+X9ibzd4TMeHO1MB4Pi9unjgo=;
 b=mmJ8YcuiTr9hzKkRdyHAI4vF3kWg5LHkNrCNJISp3lHp1FeWAbhtc7imAUKRjdKZcu
 CCT2qWHaR9HCTuy8CnunyYEagD3j3+PaqL5DI/B4wiQdppyHSr6zis89TgZhVYWdFbe9
 yZoRfNLHn220+yUl+3jmUM2GNwu8IAuYq54jObUzIugoTRe9TGG5r4egGJ5WF8YMJutF
 Tf5JUn/Vbs9/DicDIWqanhqlPqyBx0U9Pd6jPZEQFah6QyL2oE8RzOduu2E5d79d+7gJ
 om+OVRwJdIN4dpmNY9CrRzQmYHxKNBm8IyYEpTmzef7/w6WU7OQEmLOR6y7uAvm+OW0g
 qZpg==
X-Gm-Message-State: AOJu0Yx5RCwv3HjFHvM0stMG8GqOsbF7VrkeOeuuHwphpNB4ZmMZJI5V
 ZLTRISIBSLsNa4DLcE9yZ9X+QbQOxzh/ah6Dz2c++xIb6NCAsscaOXknYaYzs18=
X-Google-Smtp-Source: AGHT+IHXBdX2GWacJtu/ZCYA1GSI/ZEm37DGFP1j+ITVUMRKps8USMB6yKK34yttZLp405lr71NG9w==
X-Received: by 2002:a05:6a00:1747:b0:70b:2a:15cd with SMTP id
 d2e1a72fcca58-715df97c536mr917622b3a.0.1724876649752; 
 Wed, 28 Aug 2024 13:24:09 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:bb79:4bdf:de43:1f6c:1151?
 ([2804:7f0:b400:bb79:4bdf:de43:1f6c:1151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ec2esm10521121b3a.27.2024.08.28.13.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 13:24:09 -0700 (PDT)
Subject: Re: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
To: Salil Mehta <salil.mehta@huawei.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
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
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <2cb51f91bea3472e8ac04854d7c6bb71@huawei.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <be14d023-f65f-96e4-45ef-8fe002e69bc4@linaro.org>
Date: Wed, 28 Aug 2024 17:23:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2cb51f91bea3472e8ac04854d7c6bb71@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.084,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

On 8/19/24 9:35 AM, Salil Mehta via wrote:
> Hi Alex,
> 
>>   From: Alex Bennée <alex.bennee@linaro.org>
>>   Sent: Friday, August 16, 2024 4:37 PM
>>   To: Salil Mehta <salil.mehta@huawei.com>
>>   
>>   Salil Mehta <salil.mehta@huawei.com> writes:
>>   
>>   > vCPU Hot-unplug will result in QOM CPU object unrealization which will
>>   > do away with all the vCPU thread creations, allocations, registrations
>>   > that happened as part of the realization process. This change
>>   > introduces the ARM CPU unrealize function taking care of exactly that.
>>   >
>>   > Note, initialized KVM vCPUs are not destroyed in host KVM but their
>>   > Qemu context is parked at the QEMU KVM layer.
>>   >
>>   > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>   > [VP: Identified CPU stall issue & suggested probable fix]
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > ---
>>   >  target/arm/cpu.c       | 101
>>   +++++++++++++++++++++++++++++++++++++++++
>>   >  target/arm/cpu.h       |  14 ++++++
>>   >  target/arm/gdbstub.c   |   6 +++
>>   >  target/arm/helper.c    |  25 ++++++++++
>>   >  target/arm/internals.h |   3 ++
>>   >  target/arm/kvm.c       |   5 ++
>>   >  6 files changed, 154 insertions(+)
>>   >
>>   > diff --git a/target/arm/cpu.c b/target/arm/cpu.c index
>>   > c92162fa97..a3dc669309 100644
>>   > --- a/target/arm/cpu.c
>>   > +++ b/target/arm/cpu.c
>>   > @@ -157,6 +157,16 @@ void
>>   arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn
>>   *hook,
>>   >      QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);  }
>>   >
>>   > +void arm_unregister_pre_el_change_hooks(ARMCPU *cpu) {
>>   > +    ARMELChangeHook *entry, *next;
>>   > +
>>   > +    QLIST_FOREACH_SAFE(entry, &cpu->pre_el_change_hooks, node,
>>   next) {
>>   > +        QLIST_REMOVE(entry, node);
>>   > +        g_free(entry);
>>   > +    }
>>   > +}
>>   > +
>>   >  void arm_register_el_change_hook(ARMCPU *cpu,
>>   ARMELChangeHookFn *hook,
>>   >                                   void *opaque)  { @@ -168,6 +178,16
>>   > @@ void arm_register_el_change_hook(ARMCPU *cpu,
>>   ARMELChangeHookFn *hook,
>>   >      QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);  }
>>   >
>>   > +void arm_unregister_el_change_hooks(ARMCPU *cpu) {
>>   > +    ARMELChangeHook *entry, *next;
>>   > +
>>   > +    QLIST_FOREACH_SAFE(entry, &cpu->el_change_hooks, node, next) {
>>   > +        QLIST_REMOVE(entry, node);
>>   > +        g_free(entry);
>>   > +    }
>>   > +}
>>   > +
>>   >  static void cp_reg_reset(gpointer key, gpointer value, gpointer
>>   > opaque)  {
>>   >      /* Reset a single ARMCPRegInfo register */ @@ -2552,6 +2572,85 @@
>>   > static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>   >      acc->parent_realize(dev, errp);
>>   >  }
>>   >
>>   > +static void arm_cpu_unrealizefn(DeviceState *dev) {
>>   > +    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
>>   > +    ARMCPU *cpu = ARM_CPU(dev);
>>   > +    CPUARMState *env = &cpu->env;
>>   > +    CPUState *cs = CPU(dev);
>>   > +    bool has_secure;
>>   > +
>>   > +    has_secure = cpu->has_el3 || arm_feature(env,
>>   > + ARM_FEATURE_M_SECURITY);
>>   > +
>>   > +    /* rock 'n' un-roll, whatever happened in the arm_cpu_realizefn
>>   cleanly */
>>   > +    cpu_address_space_destroy(cs, ARMASIdx_NS);
>>   
>>   On current master this will fail:
>>   
>>   ../../target/arm/cpu.c: In function ‘arm_cpu_unrealizefn’:
>>   ../../target/arm/cpu.c:2626:5: error: implicit declaration of function
>>   ‘cpu_address_space_destroy’ [-Werror=implicit-function-declaration]
>>    2626 |     cpu_address_space_destroy(cs, ARMASIdx_NS);
>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>>   ../../target/arm/cpu.c:2626:5: error: nested extern declaration of
>>   ‘cpu_address_space_destroy’ [-Werror=nested-externs]
>>   cc1: all warnings being treated as errors
> 
> 
> The current master already has arch-agnostic patch-set. I've applied the
> RFC V3 to the latest and complied. I did not see this issue?
> 
> I've create a new branch for your reference.
> 
> https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v4-rc4
> 
> Please let me know if this works for you?

It still happens on the new branch. You need to configure Linux user mode
to reproduce it, e.g.:

$ ../configure --target-list=aarch64-linux-user,aarch64-softmmu [...]

If you just configure the 'aarch64-softmmu' target it doesn't happen.


Cheers,
Gustavo

