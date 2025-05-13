Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C9FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqvU-0007Y1-1X; Tue, 13 May 2025 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqvJ-0007XD-Eq
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqvH-0001N3-5n
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747147677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KO5SYIXLZCeX5S3WIj7POPk8p8ZK2T5x7U07pEAcVtE=;
 b=TObxP9Ra5YOj93l0MpA4/ihPWJHpjooCNqHyUXQ0Sy8VpfTcxSl3Cq+yclft8gpVcj4KLo
 6cL9aTM+gydyEzPq1gjY+YxXbwOF2UdSQn7WoeArK+wVpC5Dwo0Mdr2dCFYmeaUZ4vI0dA
 ijBykAcgzAV1cardauMxA3chMn7ORpI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Jw6potafPWyZnXTPy_irHg-1; Tue, 13 May 2025 10:47:56 -0400
X-MC-Unique: Jw6potafPWyZnXTPy_irHg-1
X-Mimecast-MFC-AGG-ID: Jw6potafPWyZnXTPy_irHg_1747147674
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso43289555e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747147674; x=1747752474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KO5SYIXLZCeX5S3WIj7POPk8p8ZK2T5x7U07pEAcVtE=;
 b=nRkzHv+qpiBpe1PrHqxCaiK+cY8KOo3Ajt0ahcii6OxzIWClliXi2NDGtDu7yUacyW
 4tAmXG4yGAnHA9f7eOWhawdsui7UuC5UprTuYoq9Lz2akZ+VcN8Z8nzLwZ4FPBwU0j37
 hKTuyJtjJuGW5VrQKdj7kLM+5YEzLIHORJitKXl14go5DQoCOuHMCxPaAnpf+6xU86Or
 2823bC/6Fvn/2weFabMYIBtm5CHnEW59/HZdNI/s/dRnJ5fO4pnStZIzcTZXE21Y0iA0
 kJZG2XXEO3Ar8F6+zzE1V3WDjhgN92tCwu5jigiku/UryJl0gfl1MAYuqAc+XpqyPxp3
 fBbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzy8QPOw08Nj4+sNUKV31IoYNXAAfPm2x0DLu0MSBmT+mCyii9LwZRGUzw7BThQ0DDnmnOF1w51CHW@nongnu.org
X-Gm-Message-State: AOJu0Yzy4jR4Wn86+b4+vWQ18zS3X/hLtO6QyZj6e3zCHk/2eYa0Q4Yl
 oPcIAvQHPBmD3RAzswONYo2sSgnDa0iCgD/woOppK4NzAr1SJ+45wBef7kv/jC3qEMSv+DnO2bG
 NaNy5XD9Kc6OQBeZeYsxVjKToKYhXDhoOrL+tq8hMNDnmJ2KLjiBp
X-Gm-Gg: ASbGncvqRDb9RFX6QQ9JC58im1gS72zYTpH5HTm0nHQVE+9eHCTiCv+e+nrP06tKRK/
 U8UrPeOrWKETOWnU8jDhTATbbfDMVDDEuDc/YXpSMjs8FdYQJki8OjNpQKLq3hXOvf+fBAPgmji
 ur7DbOKyv0iAkoc1Mg4+XDBmrZhClu0ox6AXHinoeC4qBYolU0sLE+WKKrVa4OQEUtm/REknYCn
 zdTBkTR6s2g81GcStZsNQWEAE33v8M2ioRJLrNPGwdkIkS4jxRej+3o8pHLXFYeeL5smkmE4q4W
 +qU6/VjSIlJj7fds7ElXZbNkLTmpgTatkRHNEHJO8tKDTo43FYhLWH7XR0I=
X-Received: by 2002:a05:600c:3d0c:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-442d6c31f3fmr173950955e9.0.1747147674312; 
 Tue, 13 May 2025 07:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9i3LCubWcoWCnaAyoT+dRfk4oBEpL2SCgGb3oFyN1spbQp21KOH+bltdu8thC5kvb3d5NQA==
X-Received: by 2002:a05:600c:3d0c:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-442d6c31f3fmr173950675e9.0.1747147673885; 
 Tue, 13 May 2025 07:47:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442e9c9a193sm53493925e9.21.2025.05.13.07.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:47:53 -0700 (PDT)
Message-ID: <7a9279ee-99d3-4871-b9f7-5d5529864f1e@redhat.com>
Date: Tue, 13 May 2025 16:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] arm/cpu: more customization for the kvm host cpu
 model
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-9-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-9-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/14/25 6:38 PM, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> If the interface for writable ID registers is available, expose uint64
> SYSREG properties for writable ID reg fields exposed by the host
> kernel. Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
I remember we had a comment in the early RFC that suggested to remove
the "SYSREG_" prefix. I introduced to ease the qmp introspection if I
remember correctly. Could we manage without it?
> being those used  in linux arch/arm64/tools/sysreg. This done by
s/used in/used in
> matching the writable fields retrieved from the host kernel against the
> generated description of sysregs.
>
> An example of invocation is:
> -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
> which sets DP field of ID_AA64ISAR0_EL1 to 0.
>
> [CH: add properties to the host model instead of introducing a new
> "custom" model]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
> ---
>
> Interaction with the existing cpu properties is still a bit unclear --
> at the moment, the different configurations can overwrite each other.
> ---
>  target/arm/cpu.c        |  12 ++++
>  target/arm/cpu64.c      |  22 ++++++-
>  target/arm/kvm.c        | 135 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h    |  10 +++
>  target/arm/trace-events |   4 ++
>  5 files changed, 182 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a3de5ee2b19c..c03f38ad5cfe 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1991,6 +1991,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /*
> +     * If we failed to retrieve the set of writable ID registers for the "host"
> +     * CPU model, report it here. No error if the interface for discovering
> +     * writable ID registers is not available.
> +     * In case we did get the set of writable ID registers, set the features to
> +     * the configured values here and perform some sanity checks.
> +     */
> +    if (cpu->writable_id_regs == WRITABLE_ID_REGS_FAILED) {
> +        error_setg(errp, "Failed to discover writable id registers");
> +        return;
> +    }
> +
>      if (!cpu->gt_cntfrq_hz) {
>          /*
>           * 0 means "the board didn't set a value, use the default". (We also
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 60a709502697..c595dbb532c1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -757,11 +757,31 @@ static void aarch64_host_initfn(Object *obj)
>  {
>  #if defined(CONFIG_KVM)
>      ARMCPU *cpu = ARM_CPU(obj);
> -    kvm_arm_set_cpu_features_from_host(cpu, false);
> +    bool expose_id_regs = true;
> +    int ret;
> +
> +    cpu->writable_map = g_malloc(sizeof(IdRegMap));
> +
> +    /* discover via KVM_ARM_GET_REG_WRITABLE_MASKS */
> +    ret = kvm_arm_get_writable_id_regs(cpu, cpu->writable_map);
> +    if (ret == -ENOSYS) {
> +        /* legacy: continue without writable id regs */
> +        expose_id_regs = false;
> +    } else if (ret) {
> +        /* function will have marked an error */
> +        return;
> +    }
> +
> +    kvm_arm_set_cpu_features_from_host(cpu, expose_id_regs);
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
>          aarch64_add_pauth_properties(obj);
>      }
> +    if (expose_id_regs) {
> +        /* generate SYSREG properties according to writable masks */
> +        kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
> +    }
> +
>  #elif defined(CONFIG_HVF)
>      ARMCPU *cpu = ARM_CPU(obj);
>      hvf_arm_set_cpu_features_from_host(cpu);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 9e4cca1705c8..63e27906cc42 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -335,6 +335,141 @@ static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
>      return err;
>  }
>  
> +static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
> +{
> +    GList *l;
> +
> +    for (l = reg->fields; l; l = l->next) {
> +        ARM64SysRegField *field = (ARM64SysRegField *)l->data;
> +
> +        if (i >= field->lower && i <= field->upper) {
> +            return field;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void set_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t old, value, mask;
> +    int lower = field->lower;
> +    int upper = field->upper;
> +    int length = upper - lower + 1;
> +    int index = field->index;
> +
> +    if (!visit_type_uint64(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (length < 64 && value > ((1 << length) - 1)) {
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> +                   name, value, length);
> +        return;
> +    }
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = value << lower;
> +    old = idregs[index];
> +    idregs[index] = old & ~mask;
> +    idregs[index] |= value;
> +    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
> +}
> +
> +static void get_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t value, mask;
> +    int lower = field->lower;
> +    int upper = field->upper;
> +    int length = upper - lower + 1;
> +    int index = field->index;
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = (idregs[index] & mask) >> lower;
> +    visit_type_uint64(v, name, &value, errp);
> +    trace_get_sysreg_prop(name, value);
> +}
> +
> +/*
> + * decode_idreg_writemap: Generate props for writable fields
> + *
> + * @obj: CPU object
> + * @index: index of the sysreg
> + * @map: writable map for the sysreg
> + * @reg: description of the sysreg
> + */
> +static int
> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
> +{
> +    int i = ctz64(map);
> +    int nb_sysreg_props = 0;
> +
> +    while (map) {
> +
spurious empty line
> +        ARM64SysRegField *field = get_field(i, reg);
> +        int lower, upper;
> +        uint64_t mask;
> +        char *prop_name;
> +
> +        if (!field) {
> +            /* the field cannot be matched to any know id named field */
> +            warn_report("%s bit %d of %s is writable but cannot be matched",
> +                        __func__, i, reg->name);
> +            warn_report("%s is cpu-sysreg-properties.c up to date?", __func__);
> +            map =  map & ~BIT_ULL(i);
> +            i = ctz64(map);
> +            continue;
> +        }
> +        lower = field->lower;
> +        upper = field->upper;
> +        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
> +        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
> +        object_property_add(obj, prop_name, "uint64",
> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> +        nb_sysreg_props++;
> +
> +        mask = MAKE_64BIT_MASK(lower, upper - lower + 1);
> +        map = map & ~mask;
> +        i = ctz64(map);
> +    }
> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> +    return 0;
> +}
> +
> +/* analyze the writable mask and generate properties for writable fields */
> +void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
> +{
> +    int i, idx;
> +    IdRegMap *map = cpu->writable_map;
> +    Object *obj = OBJECT(cpu);
> +
> +    for (i = 0; i < NR_ID_REGS; i++) {
> +        uint64_t mask = map->regs[i];
> +
> +        if (mask) {
> +            /* reg @i has some writable fields, decode them */
> +            idx = kvm_idx_to_idregs_idx(i);
> +            if (idx < 0) {
can it happen? I understand it asserts?
> +                /* no matching reg? */
> +                warn_report("%s: reg %d writable, but not in list of idregs?",
> +                            __func__, i);
> +            } else {
> +                decode_idreg_writemap(obj, i, mask, &regs[idx]);
> +            }
> +        }
> +    }
> +}
> +
>  static bool
>  kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf,
>                                bool exhaustive)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 90ba4f7d8987..ba5de45f868c 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -157,6 +157,16 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu, bool exhaustive);
>   */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>  
> +typedef struct ARM64SysReg ARM64SysReg;
> +/**
> + * kvm_arm_expose_idreg_properties:
> + * @cpu: The CPU object to generate the properties for
> + * @reg: registers from the host
> + *
> + * analyze the writable mask and generate properties for writable fields
> + */
> +void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
> +
>  /**
>   * kvm_arm_steal_time_finalize:
>   * @cpu: ARMCPU for which to finalize kvm-steal-time
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 955149ee1ac4..8d2a234d5272 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -15,3 +15,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>  get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>  kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
> +decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
> +get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
> +set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
> +nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
Eric


