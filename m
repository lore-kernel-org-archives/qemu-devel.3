Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ABCCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHh21-00073T-GA; Fri, 16 Oct 2026 08:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHh20-00073D-D4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHh1x-0001eS-PZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792153643;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlxikIztOcmCD0oPJfrv0Y7gX8E5iK379iIKvtymFhg=;
 b=BgJfdGbFkV/G5XvpM/B0DttAlh8pFxGH0bl9Mf/kxAIisumOxdriBlO4yzyciBHuu8M47V
 xV3dsFe6OP+VCP8iuEkHRiGk0duhkJo37tmFiN162+bcZEwnvN0G0ymu1eFEU0t+CANIys
 j/VLrVpOgHiyzhkdn4Yhjau8hIba9pk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-31EeiujOO-qcWehC_hzPFQ-1; Fri, 16 Oct 2026 12:27:22 +0000
X-MC-Unique: 31EeiujOO-qcWehC_hzPFQ-1
X-Mimecast-MFC-AGG-ID: 31EeiujOO-qcWehC_hzPFQ_1792153641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1bfd5516bso19577075e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153641; x=1792758441;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlxikIztOcmCD0oPJfrv0Y7gX8E5iK379iIKvtymFhg=;
 b=GvxeDqjTLDhIc3UblosMrFBmFkvwqcKmJ3o5ZFxAcpeUJxx5Rg6iX5NwrUbK0uNeZ0
 YNWc3NpKZXO82eoBrUYUckfnNXbgeTKsQyiOoM0hpODkKK53iagDGiY5q6kVuRmKIZA5
 SyTyvWx3fmvXK2+h6jKc63pjgxzenEnvxS1LHZHJcx9p6ZJui1sjWX5pKvEv3apHEpCa
 CKbMef8Vb24WKfCl+CFVtQKcD3nYHvy6ENuF5PSYcfYd18PJj64yBD51CupY59nX+/x5
 N3ooBWaOpBHRA7+KVjYxYMG3RTLVFFHcwCoZOA1ddobNdOXdeAayRi18YLLTEe7wmOHO
 gteQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4/vxS4b73vQ2sjQ/PkVhwaRf4mczqrfFrMt03GIdpJzhRhKm1aGZDL/O7JaK5qs57j/IEP8UEvBBs@nongnu.org
X-Gm-Message-State: AFq9FYKrBC9/h1VRdDPA1+5cqyaaSJVRlni0roo3Z/lJKaFpG7DoYluS
 G9Z2B0UQPogHXkWUHzYvlRzxfrOsnWXHODe/afEpD1PHo7COUepZR6RAwKG815+NsBJAruktGNf
 quBnZAzBxp0Tva6d+fwumF9xGxZ90kePnO0XLtIhdXDm+S7e6nVnSO6RI
X-Gm-Gg: AYBFou1u1JE8g+0IokImafTydte5LsxINA/wlJUtWO3IVgftwazBrwk8cxUMX7ala88
 xuxjw+zEi6iyulHk3XpRYYIEINngAllhCB6zxVQ352seI0+GlZ53/Vf2USz0hCwvWpSKXLiQuA/
 Cca/EOpoVGstwK47j8JvvIycmEzP49Hn5uJWjRABs2ArKRCmMthQV9y8nLex8PNmXoGwzhlBEIW
 fNFZ5m8//neyFEp2rpcGyrXNqMgb3fYZWLmM3YQS/5dR8akq9oengYi+A61Bt5tKplL2jD4h4NF
 HmlXRRpxaQbPz5lqPXUr3a3Ctfiq97per1KqSJiuZ8kOgWb5QbC5NUvFQxotmmDX2tDrK9s4Be+
 ZYfFHcCh8R4/ImVVmF8UFKralFXv+RW2DoiU47dbwEDRIBkxB
X-Received: by 2002:a05:600c:1c10:b0:4a1:d0e4:2bc7 with SMTP id
 5b1f17b1804b1-4a1d0e42e91mr30622125e9.15.1792153641094; 
 Fri, 16 Oct 2026 05:27:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1c10:b0:4a1:d0e4:2bc7 with SMTP id
 5b1f17b1804b1-4a1d0e42e91mr30621305e9.15.1792153640583; 
 Fri, 16 Oct 2026 05:27:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a8a15sm144945085e9.4.2026.10.16.05.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 05:27:20 -0700 (PDT)
Message-ID: <09800653-48cd-4cbb-a2ca-3d3cc65253f9@redhat.com>
Date: Fri, 16 Oct 2026 14:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 17/25] target/arm: fail named CPU models on unknown
 non-zero feature ID regs
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-18-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-18-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Khushit
On 9/21/26 2:32 PM, Khushit Shah wrote:
> Named CPU models zero the ID registers QEMU knows about and then apply
> SYSREG_ properties. However, the host and KVM might expose ID
> registers that QEMU does not know about yet. In this scenario, named
this may also happen with reserved fields becoming named, no?
> CPU models might
\n
> leak host features to the guest.
>
> Part of the problem can be addressed because the Arm Architecture
> Reference Manual specifies that unused encodings in the space (op1==0,
> CRn==0, CRm=={2-7}) may be treated as RES0. This range includes all
> ID_AA64* registers.
actually the KVM writable API covers AArch64 System register space

with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
so do you mean you only check part of the space. In the positive don't we need to be more precise and check for a given opcode if it is known


>
> Error out if KVM returns a non-zero value for a register in the above
> space which QEMU does not know about yet.
>
> get_sysreg_idx() now returns -1 for encodings that are not known ID
> registers, and kvm_arm_read_sys_reg64() exposes a KVM GET_ONE_REG
> read for this probe.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu-models.c  | 74 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu-sysregs.h |  2 +-
>  target/arm/cpu64.c       |  3 +-
>  target/arm/kvm-stub.c    |  7 ++++
>  target/arm/kvm.c         |  7 ++++
>  target/arm/kvm_arm.h     | 12 +++++++
>  6 files changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> index 4e92909755..855eb5ee6b 100644
> --- a/target/arm/cpu-models.c
> +++ b/target/arm/cpu-models.c
> @@ -362,6 +362,78 @@ static void reset_res1_fields(ARMCPU *cpu)
>      }
>  }
>  
> +/*
> + * From ARM ARM:
> + *
> + *     For unused encodings in the part of the space that has op1==0 and
> + *     CRm=={2-7}, direct reads that are not trapped behave as Reserved,
> + *     RES0 to ensure correct behavior if the encodings are used for ID
> + *     registers in the future.
> + *
> + * It includes every ID_AA64* register.
> + *
> + * For named CPU models, we can check if any of the unknown ID registers
> + * that fall into this space is non-zero on the host. If so, the named CPU
> + * model leaks those host features. Error out in such case.
> + *
> + * We cannot do the same for the remaining Feature ID space (op1==0 and
> + * CRm==0, or op1=={1,3}). Unused encodings there are UNDEFINED. The
> + * implemented registers in that space (MIDR_EL1, CTR_EL0, DCZID_EL0,
> + * CCSIDR_EL1, ...) are identification or cache geometry.
> + */
> +static void arm_named_cpu_zero_unknown_feature_ids(ARMCPU *cpu, Error **errp)
> +{
> +    uint32_t init_features0 = 0;
> +    static bool checked;
> +    uint32_t target;
> +    int fdarray[3];
> +    int crm, op2;
> +    int fd;
> +
> +    if (checked) {
> +        return;
> +    }
> +
> +    if (!kvm_arm_create_scratch_max_host_vcpu(fdarray, &init_features0,
> +                                              &target, errp)) {
can't we do that when we retrieve the host features on the 1st created
scratch vcpu. We shall avoid creating too many of them if possible
> +        return;
> +    }
> +
> +    fd = fdarray[2];
> +    for (crm = 2; crm <= 7; crm++) {
> +        for (op2 = 0; op2 <= 7; op2++) {
> +            uint64_t val = 0;
> +            int ret;
> +
> +            if (get_sysreg_idx(ENCODE_ID_REG(3, 0, 0, crm, op2)) != -1) {
> +                continue;
> +            }
> +
> +            ret = kvm_arm_read_sys_reg64(fd, &val, 3, 0, 0, crm, op2);
> +            if (ret) {
> +                continue;
> +            }
> +
> +            /*
> +             * TODO: if this encoding is writable, try to write 0?
> +             */
> +            if (val) {
> +                error_setg(errp,
> +                           "unknown Feature ID register "
> +                           "(op0=3, op1=0, CRn=0, CRm=%d, op2=%d) "
> +                           "reads as 0x%" PRIx64 " on the host; named CPU "
> +                           "models cannot hide it",
> +                           crm, op2, val);
> +                kvm_arm_destroy_scratch_host_vcpu(fdarray);
> +                return;
> +            }
> +        }
> +    }
> +
> +    kvm_arm_destroy_scratch_host_vcpu(fdarray);
> +    checked = true;
> +}
> +
>  static void arm_named_cpu_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -401,6 +473,8 @@ static void arm_named_cpu_initfn(Object *obj)
>  
>      /* 3. Realize the model chain. */
>      arm_realize_model_chain(obj, model, &error_abort);
> +
> +    arm_named_cpu_zero_unknown_feature_ids(cpu, &error_abort);
>  }
>  
>  void arm_register_named_cpu_models(void)
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index 7877a3b06a..d48b44705f 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -37,6 +37,6 @@ typedef enum ARMSysRegs {
>  
>  extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>  
> -int get_sysreg_idx(ARMSysRegs sysreg);
> +int get_sysreg_idx(ARMSysRegs sysreg); /* -1 if @sysreg is not a known ID register */
>  
>  #endif /* ARM_CPU_SYSREGS_H */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index a0114b0fa2..3cc698d65a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -57,8 +57,9 @@ int get_sysreg_idx(ARMSysRegs sysreg)
>  {
>      switch (sysreg) {
>  #include "cpu-sysregs.h.inc"
> +    default:
> +        return -1;
>      }
> -    g_assert_not_reached();
>  }
>  
>  #undef DEF
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index eae2e1ec2c..d263adc921 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -50,6 +50,13 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>      g_assert_not_reached();
>  }
>  
> +int kvm_arm_read_sys_reg64(int fd, uint64_t *val,
> +                           uint8_t op0, uint8_t op1,
> +                           uint8_t crn, uint8_t crm, uint8_t op2)
> +{
> +    g_assert_not_reached();
> +}
> +
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>  {
>      g_assert_not_reached();
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 70d9a07580..6f704c0509 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -263,6 +263,13 @@ static int read_sys_reg64(int fd, uint64_t *pret, uint64_t id)
>      return ioctl(fd, KVM_GET_ONE_REG, &idreg);
>  }
>  
> +int kvm_arm_read_sys_reg64(int fd, uint64_t *val,
> +                           uint8_t op0, uint8_t op1,
> +                           uint8_t crn, uint8_t crm, uint8_t op2)
> +{
> +    return read_sys_reg64(fd, val, ARM64_SYS_REG(op0, op1, crn, crm, op2));
> +}
> +
>  static uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
>  {
>      return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 997120966f..4e563fab96 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -154,6 +154,18 @@ bool kvm_arm_create_scratch_max_host_vcpu(int *fdarray,
>   */
>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>  
> +/**
> + * kvm_arm_read_sys_reg64:
> + * @fd: vCPU fd
> + * @val: filled with the register value on success
> + * @op0/@op1/@crn/@crm/@op2: System ID register encoding
> + *
> + * Returns: 0 on success, -1 on failure.
> + */
> +int kvm_arm_read_sys_reg64(int fd, uint64_t *val,
> +                           uint8_t op0, uint8_t op1,
> +                           uint8_t crn, uint8_t crm, uint8_t op2);
> +
>  /**
>   * kvm_arm_add_vcpu_properties:
>   * @cpu: The CPU object to add the properties to
Thanks

Eric


