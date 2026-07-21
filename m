Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95136C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBi5-00005Z-Gs; Tue, 21 Jul 2026 10:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmBi3-0008WM-SC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmBi0-0001IZ-8w
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784645074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qOLTXIqCHBJNWwLhqkRmuXFRlWryXYDrTXwlOJLLCY=;
 b=bYDViH52zE45bPhvMrf1oYLe1o0HbmH5reTxJwYzmPmYpDpTtaAFmeh5zcpKVPB1Iic86H
 kxj6yQ7cU/SgiJhuq8nIHeiOpyjB/bdEWlvugvIxrhUMGPT+kToYgzfvHZeX9PrtCPLB7U
 sEGIZqFWFNM1Qtjae51Iu4dDEX4EByo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-fPNeSjflOYmNe5Icgzx8xw-1; Tue, 21 Jul 2026 10:44:32 -0400
X-MC-Unique: fPNeSjflOYmNe5Icgzx8xw-1
X-Mimecast-MFC-AGG-ID: fPNeSjflOYmNe5Icgzx8xw_1784645072
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493e94719e7so76388115e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645071; x=1785249871;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6qOLTXIqCHBJNWwLhqkRmuXFRlWryXYDrTXwlOJLLCY=;
 b=LJ1uJLlkaitPoDa5qWJsQfRA5dmL+hYJ4ZTZGsfM/rNVppJA+kVDaNQwG4bIuvYiKQ
 3y+nUpAUeF0W+bGlf267YgvdyYYK5RocloiyuJiniSxgVpN30TC4yZjS02ZKoMtOCbz/
 VCUpDOmapoTArJqSmX8jTfdCEjf7XMKDyWDGgFb44/iYmXSWyOahwevCW2mqcDw9nald
 fjEGxpb706SCnoIiQRT2xr1GLADp6PzxDG9blZb23xnTM1/J3rv1qq49jWM7RCUQ2wQp
 OPLVEKCR929qvopn1MYSkKQ8gqqdWTakFaL/tGPY4kvIQXsy2fUtm/qX7law9QqAWoAn
 2vqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyP+9Q/wFLqayFPmnlH1ahtAafc/EF0uGzpL1aur2LqEYTQRtrnEO0kMsWClzz8AJi4o4Os0mH80PN@nongnu.org
X-Gm-Message-State: AOJu0YyY01GItYKAHGcEfF4hkPV9WZCofIc6GItuCkyUeVYr4vfpnsu4
 kM+4nHGRDkB6gzoXvH6EML8yCp4eDNPRu0m0cwOAy7Kec6YmW4fTyESjnEYZtQzRWK61xp6P/Kj
 3CduJDrmPQaerYCiM+NGcPiOg+LGORPoWShBSTE7CVaQcRyvUn4cPO4bA
X-Gm-Gg: AfdE7cmFdkB5uFrHDJWN3sggEWUnMmjyi9WddKy9IHk6X7hiIJqqw0oecjz+4WIAB3h
 QaN/rh9iw2eYWh4Fnb7w/SGKEfl7f2kq7pBfZzse5GEvQERHdMC3NJZhc9wJ0ufbOMZfgfm7F5+
 0wtdjSXsBeg7qwFQW8Nr7YNMX5jueKVdZTjxL1RY5XFFnIgLCoPDOd4hGprgkinxaEDOPlShZ5R
 rGyoVC/n28AWkRxHy7p0RVG56/ajsZPpXBZG0n4fNqEdnK2LZAIaL78I25K3XO7RRRNzAcv+iMg
 hwDx+lfV+YvDGs39890dQ1tL19fn6BGaNzNSjAWHhZELAcXcl31xlJuXjXC6fr1UXUnMvycYpm9
 f8aH1EuxvshnOQrJdBb6QCHYXv5RQxIwwC4ya0hT98XMUPRY7
X-Received: by 2002:a05:600c:46d4:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4954a3d64c9mr244040325e9.7.1784645071551; 
 Tue, 21 Jul 2026 07:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:46d4:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4954a3d64c9mr244039785e9.7.1784645071056; 
 Tue, 21 Jul 2026 07:44:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563e4573bsm77744275e9.0.2026.07.21.07.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:44:30 -0700 (PDT)
Message-ID: <2c79dd3a-389d-448d-bb6b-cbaef18210dd@redhat.com>
Date: Tue, 21 Jul 2026 16:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/19] target/arm: expose all ID regs fields as
 properties
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 prerna.saxena@nutanix.com
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-5-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260716213858.609699-5-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Khushit,

On 7/16/26 11:38 PM, Khushit Shah wrote:
> Upcoming named cpu models layer requires exposing all the ID register
> fields as properties.
>
> While doing so also move the code to cpu64.c to make it
> accelerator-agnostic, and rename the function to
> `aarch64_add_idregs_properties()`.

Better to split that patch into 2 to ease the review:
1) update the code in kvm to expose all ID regs including those which
are not writable and adaptation in set_sysreg_prop to handle RAZ,
RES0/1, ...
2) Move to cpu64.c

To me it is still arguable whether it makes sense to expose settings
which cannot be really set. To me It pollutes the qmp introspection
output and I don't know whether there is any case history.

Why can't we:
- only expose writable id regs as props
- other non writable settings you need to check could be registered in a
hash table during named cpu model definition in props. 
in arm_apply_model_props() when you enumerate all props you can check if
there is an existing prop for this name, in which case you really call

object_property_set_bool(), otherwise, you go through another path, which is not visible by the end user where you check the KVM value matches your "prop" value. No need to pretend this is writable.
Also I am doubtful about RES/RAZ.

+    MODEL_PROP("SYSREG_CTR_EL0_RES1_31", NUM, 1),

does not make sense to me

Why can't you enumate all ID regs and go through those fields and check the KVM value matches. Why would we need to explicitly set a RAS/RES0/1 field. Why can't that be checked transparently.
Thanks

Eric

>
> This makes porting this solution to other accelerators easy in future.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu64.c      | 116 +++++++++++++++++++++++++++++-
>  target/arm/internals.h  |   3 +
>  target/arm/kvm.c        | 151 ----------------------------------------
>  target/arm/kvm_arm.h    |   8 ---
>  target/arm/trace-events |   4 +-
>  5 files changed, 119 insertions(+), 163 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 92a01d4ce7..cdad0fc46d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -38,6 +38,7 @@
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpu-idregs.h"
> +#include "trace.h"
>  
>  /* convert between <register>_IDX and SYS_<register> */
>  #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
> @@ -644,6 +645,113 @@ static const Property arm_cpu_pauth_qarma3_property =
>  static Property arm_cpu_pauth_qarma5_property =
>      DEFINE_PROP_BOOL("pauth-qarma5", ARMCPU, prop_pauth_qarma5, false);
>  
> +#ifndef CONFIG_USER_ONLY
> +static void set_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t old, value, mask;
> +    int lower = field->shift;
> +    int length = field->length;
> +    int index = field->index;
> +
> +    if (!visit_type_uint64(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (length < 64 && value > ((1ULL << length) - 1)) {
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> +                   name, value, length);
> +        return;
> +    }
> +
> +    if (field->arch_vals) {
> +        /* this field has some enum values */
> +        for (int i = 0; i < field->arch_vals_count; i++) {
> +            if (value == field->arch_vals[i].value) {
> +                goto valid;
> +            }
> +        }
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) does not match any "
> +                   "arch valid enum value!", name, value);
> +        return;
> +    }
> +
> +    /* If the field is RESx or RAZ, it should not be written anything else */
> +    if (strstr(field->name, "RES0") && value != 0) {
> +        error_setg(errp, "idreg %s is RES0 field and cannot write %ld",
> +            name, value);
> +        return;
> +    } else if (strstr(field->name, "RAZ") && value != 0) {
> +        error_setg(errp, "idreg %s is RAZ field and cannot write %ld",
> +            name, value);
> +        return;
> +    } else if (strstr(field->name, "RES1") && value != 1) {
> +        error_setg(errp, "idreg %s is RES1 field and cannot write %ld",
> +            name, value);
> +        return;
> +    }
> +
> +valid:
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
> +    int lower = field->shift;
> +    int length = field->length;
> +    int index = field->index;
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = (idregs[index] & mask) >> lower;
> +    visit_type_uint64(v, name, &value, errp);
> +    trace_get_sysreg_prop(name, value);
> +}
> +
> +static int
> +aarch64_add_idreg_properties(Object *obj, ARM64SysReg *reg)
> +{
> +    int nb_sysreg_props = 0;
> +
> +    for (int i = 0; i < reg->fields_count; i++) {
> +        ARM64SysRegField *field = &reg->fields[i];
> +        char *prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name,
> +                                          field->name);
> +        object_property_add(obj, prop_name, "uint64",
> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> +        g_free(prop_name);
> +        nb_sysreg_props++;
> +    }
> +
> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> +    return 0;
> +}
> +
> +void aarch64_add_idregs_properties(Object *obj)
> +{
> +    for (int i = 0; i < NUM_ID_IDX; i++) {
> +        ARM64SysReg *reg = &arm64_id_regs[i];
> +        aarch64_add_idreg_properties(obj, reg);
> +    }
> +}
> +#endif
> +
>  void aarch64_add_pauth_properties(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -865,8 +973,12 @@ static void aarch64_host_initfn(Object *obj)
>      kvm_arm_set_cpu_features_from_host(cpu);
>      aarch64_add_sve_properties(obj);
>  
> -    /* generate SYSREG properties according to writable masks */
> -    kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
> +#ifndef CONFIG_USER_ONLY
> +    /* generate SYSREG properties */
> +    if (kvm_enabled()) {
> +        aarch64_add_idregs_properties(obj);
> +    }
> +#endif
>  
>  #elif defined(CONFIG_HVF)
>      hvf_arm_set_cpu_features_from_host(cpu);
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index a632584a4e..7502b6db8a 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1754,6 +1754,9 @@ void aarch64_max_tcg_initfn(Object *obj);
>  void aarch64_add_pauth_properties(Object *obj);
>  void aarch64_add_sve_properties(Object *obj);
>  void aarch64_add_sme_properties(Object *obj);
> +#ifndef CONFIG_USER_ONLY
> +void aarch64_add_idregs_properties(Object *obj);
> +#endif
>  
>  /* Return true if the gdbstub is presenting an AArch64 CPU */
>  static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 892433a612..76583db3f0 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -327,157 +327,6 @@ static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
>      return err;
>  }
>  
> -static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
> -{
> -    for (int f = 0; f < reg->fields_count; f++) {
> -        struct ARM64SysRegField *field = &reg->fields[f];
> -        int upper = field->shift + field->length - 1;
> -
> -        if (i >= field->shift && i <= upper) {
> -            return field;
> -        }
> -    }
> -    return NULL;
> -}
> -
> -static void set_sysreg_prop(Object *obj, Visitor *v,
> -                            const char *name, void *opaque,
> -                            Error **errp)
> -{
> -    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    uint64_t *idregs = cpu->isar.idregs;
> -    uint64_t old, value, mask;
> -    int lower = field->shift;
> -    int length = field->length;
> -    int index = field->index;
> -
> -    if (!visit_type_uint64(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    if (length < 64 && value > ((1 << length) - 1)) {
> -        error_setg(errp,
> -                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> -                   name, value, length);
> -        return;
> -    }
> -
> -    if (field->arch_vals) {
> -        /* this field has some enum values */
> -        for (int i = 0; i < field->arch_vals_count; i++) {
> -            if (value == field->arch_vals[i].value) {
> -                goto valid;
> -            }
> -        }
> -        error_setg(errp,
> -                   "idreg %s set value (0x%lx) does not match any "
> -                   "arch valid enum value!", name, value);
> -        return;
> -    }
> -
> -valid:
> -
> -    mask = MAKE_64BIT_MASK(lower, length);
> -    value = value << lower;
> -    old = idregs[index];
> -    idregs[index] = old & ~mask;
> -    idregs[index] |= value;
> -    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
> -}
> -
> -static void get_sysreg_prop(Object *obj, Visitor *v,
> -                            const char *name, void *opaque,
> -                            Error **errp)
> -{
> -    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    uint64_t *idregs = cpu->isar.idregs;
> -    uint64_t value, mask;
> -    int lower = field->shift;
> -    int length = field->length;
> -    int index = field->index;
> -
> -    mask = MAKE_64BIT_MASK(lower, length);
> -    value = (idregs[index] & mask) >> lower;
> -    visit_type_uint64(v, name, &value, errp);
> -    trace_get_sysreg_prop(name, value);
> -}
> -
> -/*
> - * decode_idreg_writemap: Generate props for writable fields
> - *
> - * @obj: CPU object
> - * @reg: description of the sysreg
> - */
> -static int
> -decode_idreg_writemap(Object *obj, ARM64SysReg *reg)
> -{
> -    uint64_t map = reg->writable_mask;
> -    int i = ctz64(map);
> -    int nb_sysreg_props = 0;
> -
> -    while (map) {
> -        ARM64SysRegField *field = get_field(i, reg);
> -        int lower, upper;
> -        char *prop_name;
> -        uint64_t field_mask;
> -
> -        if (!field) {
> -            warn_report("%s bit %d of %s is writable but no named field "
> -                        "in target/arm/cpu-idregs.h.inc",
> -                        __func__, i, reg->name);
> -            warn_report("%s is target/arm/cpu-idregs.h.inc up-to-date?", __func__);
> -            map =  map & ~BIT_ULL(i);
> -            i = ctz64(map);
> -            continue;
> -        }
> -        lower = field->shift;
> -        upper = field->shift + field->length - 1;
> -
> -        /* Sanity check the field is not a reserved field */
> -        if (strstr(field->name, "RES0") || strstr(field->name, "RES1") ||
> -            strstr(field->name, "RAZ")) {
> -            trace_unexpected_writable_reserved_field(reg->name, field->name,
> -                                                     lower, upper);
> -            continue;
> -        }
> -        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
> -        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
> -        object_property_add(obj, prop_name, "uint64",
> -                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> -        g_free(prop_name);
> -        nb_sysreg_props++;
> -
> -        field_mask = MAKE_64BIT_MASK(lower, field->length);
> -        map = map & ~field_mask;
> -        i = ctz64(map);
> -    }
> -    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> -    return 0;
> -}
> -
> -/* analyze the writable mask and generate properties for writable fields */
> -void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
> -{
> -    Object *obj = OBJECT(cpu);
> -
> -    for (int i = 0; i < NUM_ID_IDX; i++) {
> -        ARM64SysReg *sysregdesc = &regs[i];
> -
> -        if (sysregdesc->writable_mask) {
> -            /*
> -             * special case REVIDR_EL1 and AIDR_EL1 which are writable but
> -             * do not expose named fields. They will need to be handled
> -             * separately
> -             */
> -            if (strcmp(sysregdesc->name, "REVIDR_EL1") &&
> -                strcmp(sysregdesc->name, "AIDR_EL1")) {
> -                decode_idreg_writemap(obj, sysregdesc);
> -            }
> -        }
> -    }
> -}
>  
>  static void
>  kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 2b3474cc36..133a026036 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -143,14 +143,6 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>  
>  typedef struct ARM64SysReg ARM64SysReg;
> -/**
> - * kvm_arm_expose_idreg_properties:
> - * @cpu: The CPU object to generate the properties for
> - * @reg: registers from the host
> - *
> - * analyze the writable mask and generate properties for writable fields
> - */
> -void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
>  
>  /**
>   * kvm_arm_steal_time_finalize:
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index e67730de6b..f33b0d821d 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -15,11 +15,11 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>  get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>  kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
> -decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
> +
> +# cpu64.c
>  get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
>  set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
>  nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
> -unexpected_writable_reserved_field(const char *reg_name, const char *field_name, int lower, int upper) "Unexpected writable reserved field: %s.%s [%d,%d], skip it ..."
>  
>  # cpu.c
>  arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64


