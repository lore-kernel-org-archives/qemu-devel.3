Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2EAE95398
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncHJ-00065a-Jy; Wed, 04 Feb 2026 07:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vncHB-00062P-FJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vncH8-00020x-Uz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770209187;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnNqsuB7MsxdyRmokhHDO3ppw+6cIaFPn+RsgOJ+ngg=;
 b=NgH7shrpPtVWz8xGFfAKfoHjCuLETN768OJx+LFsyw6stB3WHaCVwyBMxxGSESevjo3PFS
 f7dRTNWsuJGvSNwkeRfNuGYBrTv9zkIchE7Hcp0xuls5Q6qeaY30KlTCBh4Q/QZdIY14rb
 LRqHTWS4NBneZL7AM26AsGhD9CLw16o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-KSqrNTr_NuiqMQYsJIVm9Q-1; Wed, 04 Feb 2026 07:46:25 -0500
X-MC-Unique: KSqrNTr_NuiqMQYsJIVm9Q-1
X-Mimecast-MFC-AGG-ID: KSqrNTr_NuiqMQYsJIVm9Q_1770209185
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482eec44485so35409335e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 04:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770209184; x=1770813984;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnNqsuB7MsxdyRmokhHDO3ppw+6cIaFPn+RsgOJ+ngg=;
 b=MDNuJ4uf6FRzrFue5yQ82BIyqQoP31zeqSfYgtEVTDD4F9NH8vplPBtNCFIeR3HZ1j
 HYjazrLuVjiXw8ipp4ijbTuKPQamhAg0kST3F0FKt3KLRW/ciMAavhtvQkOl3XSaixg3
 wLysCcoSgxc/2qiq9M6asCYhJ6uNxP9kkQxe9I47vZW79sq76/kdY5c20+bJ+Yq4d02E
 8AD0qn9g7h0RV10ovRUBOisSXXEoawMxPhOTjqq/J2rheVmuOX1DIvydBNvHCfKCPXs6
 n8olklO6qJy8zBaVPbWOohUT5CV5AZ/DvxoqIw+bA1ztOsG7Br5z9Ch+gxK7MfcWNqn7
 1dSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNvHhoYQROMcQucdOnQF/WLd+Q4iM3niXKhv59Dr7Gb5iqeEXxN8ryrqLUzZqnmBY41uTrPh8eB3Lp@nongnu.org
X-Gm-Message-State: AOJu0YysUOeloxAIVADdljDosN4CvEb9WyZYK1TTodwyXcGLxR78oPwJ
 n231W598sKIaNHcxpbsW4CszXfbrcJxBwtP/4Suj5LS+8bi/KjwRCgXaSWE8Ycxw8VB/ZcfsYj5
 8KpylgXHqL68g/ix4unAu+UZiSWSpbV2RdlS1cmxE4CKuBgnHEb2+Hs/5
X-Gm-Gg: AZuq6aIDq+d01Uvtjo9bm+mIfXoI9lbrl4U0FKOK0DespO/GkHOqhwnchTfaZvAr2Jt
 qgARXjOlniiV2hACzGxQDKAM+GqAhffJNQGT+UO5PijpchFRcNdR55JIvdFTP/HCtsnWfAQYX1Y
 g6O2sabrN5H57WaPlk/ba0C3JQRFDqQym/x2HK1vbBBL+OXwWSbXaLu08coCf6mBh1PV3FNbl1n
 8aiU3Mv7xtNIpuj3KWOHlLQDbjyoeQHKvsafepPvLxBs47EdhASjwt88vI1pGwQIpH/WoJd7aQs
 sdSf3jKteVHjUDDDxS3kwBpWKWlz3FK7A3NiVAy1Eu91xqLoO/6+oXW8NytjNnTemTsJBJ0nlsh
 L1/05Ih9CHdLT7L1gHA0ypZMR5bnLJAbgFxGrOCfRzKBDFUahatjYnVTJ2w==
X-Received: by 2002:a05:600c:3b14:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-4830e93a276mr40677355e9.16.1770209184163; 
 Wed, 04 Feb 2026 04:46:24 -0800 (PST)
X-Received: by 2002:a05:600c:3b14:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-4830e93a276mr40676945e9.16.1770209183662; 
 Wed, 04 Feb 2026 04:46:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25d02sm6011512f8f.3.2026.02.04.04.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 04:46:23 -0800 (PST)
Message-ID: <55723681-f8d0-4727-b7ad-3ac0345df0c1@redhat.com>
Date: Wed, 4 Feb 2026 13:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6 03/11] target/arm/cpu: Allow registers to be hidden
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-4-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20260126165445.3033335-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Alex,

On 1/26/26 5:53 PM, Eric Auger wrote:
> More recent kernels sometimes expose new registers in an
> unconditionnal manner. This situation breaks backward migration
> as qemu notices there are more registers in the input stream
> than supported on the destination host. This leads to a
> "failed to load cpu:cpreg_vmstate_array_len" error.
>
> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
> migration from a host kernel that features the commit to a destination
> host that doesn't, fail with above error.

Please find below a follow up on your question regarding hidden reg,
during yesterday's qemu biweekly

Regarding this KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW reg, this latter
was introduced by 

[PATCH v8 3/6] KVM: arm64: Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2 <https://lore.kernel.org/all/20250221140229.12588-4-shameerali.kolothum.thodi@huawei.com/#r>

https://lore.kernel.org/all/20250221140229.12588-4-shameerali.kolothum.thodi@huawei.com/
The purpose is to let userspace retrieve and negotiate available Vendor
Hyp services. So it allows qemu to opt in for specific services (the
first one being the MIDR based errata mgt). So the guest only reads this
reg and does not change it. So this sounds safe to ignore saving/restore
the reg state as long as qemu does not play with the reg.   QEMU does
not get/set this reg yet. Support may come later. Shameer posted an RFC:
[RFC PATCH RESEND 3/4] target/arm/kvm: Handle KVM Target Imp CPU
hypercalls
https://lore.kernel.org/all/3bf24eb7-b1cd-793c-158f-7b6e2aeab026@redhat.com/
There you can see how the reg is accessed. Besides, enlarging your
question to an hidden reg likely to be written by the guest and whose
state wouldn't be saved/restored due to the "hidden" nature of the reg,
we could add a check in qemu that compares the reg value against default
init one on migration source and in case it differs fail the migration.
Thanks Eric
> Currently QEMU is not using that feature so ignoring this latter
> is not a problem. An easy way to fix the migration issue is to teach
> qemu we don't care about that register and we can simply ignore it
> when syncing its state during migration.
>
> This patch introduces an array of such hidden registers. Soon it will
> be settable through an array property.
>
> If hidden, the register is moved out of the array of cpreg which is
> built in kvm_arm_init_cpreg_list(). That way their state won't be
> synced.
>
> To extend that functionality to TCG, do the same in add_cpreg_to_list()
> and count_cpreg().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>
> ---
> v2 -> v3:
> - use kvm_regidx
>
> v1 -> v2:
> - Move the property in a separate patch
> - improve the commit msg
> - change the trace point to just print info in
>   kvm_arm_init_cpreg_list()
> - improve comment in cpu.h (Connie)
>
> target/arm/helper: Skip hidden registers
>
> In case a cpreg is hidden, skip it when initialing the cpreg
> list.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu.h        | 20 ++++++++++++++++++++
>  target/arm/helper.c     | 12 +++++++++++-
>  target/arm/kvm.c        | 12 +++++++++++-
>  target/arm/trace-events |  2 ++
>  4 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e900ef7937b..e87f222e7be 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1045,6 +1045,15 @@ struct ArchCPU {
>      /* KVM steal time */
>      OnOffAuto kvm_steal_time;
>  
> +    /*
> +     * Array of register indexes that need to be hidden to allow migration
> +     * in certain cases, i.e. when a register is exposed in KVM or defined
> +     * in TCG but not actually used in QEMU. Indexes are described in Linux
> +     * Documentation/virt/kvm/api.rst for both KVM and TCG.
> +     */
> +    uint64_t *hidden_regs;
> +    uint32_t nr_hidden_regs;
> +
>      /* Uniprocessor system with MP extensions */
>      bool mp_is_up;
>  
> @@ -1185,6 +1194,17 @@ struct ARMCPUClass {
>      ResettablePhases parent_phases;
>  };
>  
> +static inline bool
> +arm_cpu_hidden_reg(ARMCPU *cpu, uint64_t regidx)
> +{
> +    for (int i = 0; i < cpu->nr_hidden_regs; i++) {
> +        if (cpu->hidden_regs[i] == regidx) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  /* Callback functions for the generic timer's timers. */
>  void arm_gt_ptimer_cb(void *opaque);
>  void arm_gt_vtimer_cb(void *opaque);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dce648b4824..8217517150b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -235,9 +235,13 @@ static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
>      ARMCPU *cpu = opaque;
>      uint32_t regidx = (uintptr_t)key;
>      const ARMCPRegInfo *ri = value;
> +    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
>  
> +    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
> +        return;
> +    }
>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
> -        cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
> +        cpu->cpreg_indexes[cpu->cpreg_array_len] = kvm_regidx;
>          /* The value array need not be initialized at this point */
>          cpu->cpreg_array_len++;
>      }
> @@ -247,6 +251,12 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
>  {
>      ARMCPU *cpu = opaque;
>      const ARMCPRegInfo *ri = value;
> +    uint32_t regidx = (uintptr_t)key;
> +    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
> +
> +    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
> +        return;
> +    }
>  
>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>          cpu->cpreg_array_len++;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index c6f0d0fc4e1..7e0a3680748 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -789,7 +789,10 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>      qsort(&rlp->reg, rlp->n, sizeof(rlp->reg[0]), compare_u64);
>  
>      for (i = 0, arraylen = 0; i < rlp->n; i++) {
> -        if (!kvm_arm_reg_syncs_via_cpreg_list(rlp->reg[i])) {
> +        uint64_t regidx = rlp->reg[i];
> +
> +        if (!kvm_arm_reg_syncs_via_cpreg_list(regidx) ||
> +            arm_cpu_hidden_reg(cpu, regidx)) {
>              continue;
>          }
>          switch (rlp->reg[i] & KVM_REG_SIZE_MASK) {
> @@ -805,6 +808,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>          arraylen++;
>      }
>  
> +    trace_kvm_arm_init_cpreg_list_arraylen(arraylen);
> +
>      cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
>      cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
>      cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
> @@ -816,9 +821,14 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>  
>      for (i = 0, arraylen = 0; i < rlp->n; i++) {
>          uint64_t regidx = rlp->reg[i];
> +
>          if (!kvm_arm_reg_syncs_via_cpreg_list(regidx)) {
>              continue;
>          }
> +        if (arm_cpu_hidden_reg(cpu, regidx)) {
> +            trace_kvm_arm_init_cpreg_list_skip_hidden_reg(rlp->reg[i]);
> +            continue;
> +        }
>          cpu->cpreg_indexes[arraylen] = regidx;
>          arraylen++;
>      }
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 0a5ed3e69d5..20f4b4f2cd0 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -14,6 +14,8 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  # kvm.c
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>  kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
> +kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
> +kvm_arm_init_cpreg_list_skip_hidden_reg(uint64_t regidx) "hidden 0x%"PRIx64" is skipped"
>  
>  # cpu.c
>  arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64


