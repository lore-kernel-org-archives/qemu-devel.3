Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE4CC9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jc6-0005E5-R7; Thu, 24 Sep 2026 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9jc4-0005Dc-Rj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9jc0-0005lS-EL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790256942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vshkQVFITpqH2vOLyhtffskoGqItXSX3caa0iu331ug=;
 b=UXksRXKQgza08HqZoe71EY8WYVAJEM/U2QMAMTCS06X9vh7VFgE89fHkfryXuEjpZWRExV
 UCeOD5hNjeXWQ6ucdYigz9tIpX1HXIK/1Qs+0Y/WJOTh6dMF5BV0/uczDzB8WM1c0gxDJH
 GgcqtiUWp6IWHhPDE8pjlXnmE2en95Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-2OJBU6lfPcCxLpphaqC2zg-1; Thu, 24 Sep 2026 09:35:41 -0400
X-MC-Unique: 2OJBU6lfPcCxLpphaqC2zg-1
X-Mimecast-MFC-AGG-ID: 2OJBU6lfPcCxLpphaqC2zg_1790256940
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f18da958so647310f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256940; x=1790861740;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vshkQVFITpqH2vOLyhtffskoGqItXSX3caa0iu331ug=;
 b=ATb/jk8s4f12dgcr2QXopI+JHY7as0vDZdYJ65drDxQiEhLGngUj6dO7g6TFS1vb9p
 2tXjp0wohfxIFK65RP7d4IboKoblvnw/jV9g9+QO6laMIG4ZE2ZpOeJkSd2VaEd2aHox
 vYKBt9Fgzp3craxn4k1ZMiLI1RMbbD523IncdFv8BBzTn021RgVDaEm1+0h96bRGrOx6
 Gkczw6ildOdr9V/vPW7P6VDqcZ0qyiGybqrEJE3a4BS9T2Ukfr4XslxUyn1jii0NLpXw
 nMShZeyvO2tU6RhGw9W5528NL6defdBmV62b92qsKZfPNRhFquDyo36occ1ugZ7azU0f
 PROA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ1b/TBz7F+fd7EBlIqAzIlgE+ZuO9BUhgt3qgEZkUSs58qaxjD80YnYctBj8BCWRd66snhriM0y8P@nongnu.org
X-Gm-Message-State: AFuF++kynupmDNGaAL8TT2jQ54jwlPVRMuQtJaJDHjp67Yu47ZPKYkfq
 CySnPuExMUcoMSWUE9askDzQlKKMnEiQT7iiJzDQdl8/DLJiBJUU7Rlg5lQuv1rPNrAvxuRr71+
 dMyvk29h4Nlobd6VnSkUHlMptJv2X0K7+UTMCMSei32xJa7QDbqUh+ERR
X-Gm-Gg: AYBFou2rT54i+r76fSm4G0A+KSwMOaNhLOrnNofLsjHMzrxktx2fmbQ0Xdm690+iJUm
 QJ1BFBGplMhdzx4hTgtOyUrGGqYuneYHdOq2V8dru9Pb79Cn172BgiI/2SmJXGDX44aO+HPUhq5
 +8aKKB6W1j16i1iNIHS3/BTU9fmeVoSFVtALiL0PpF9l7tPbk++BYv3ex4c7o8fp805gjD/vrCE
 w7jMSIdexxU7QXM+koRKxda0rphOBF9FnsFP7FLtMDI2lXqjuPNkq5Hw0FXA0qAo219QRNxGFdk
 G3DDaP2iXOQKhqT3ocR43JN1egZChBGr0q2GUD6haJBw8wOhmDyeEtI0s1AiXYtVklnt9CXdLJe
 Q1gSRGDMzMEwnUSBpwfooQxw2r6LJ77hiPWGPzcwdbbYLFJhY
X-Received: by 2002:a05:6000:184e:b0:488:5fa9:34aa with SMTP id
 ffacd0b85a97d-488716d22bcmr5147037f8f.20.1790256939807; 
 Thu, 24 Sep 2026 06:35:39 -0700 (PDT)
X-Received: by 2002:a05:6000:184e:b0:488:5fa9:34aa with SMTP id
 ffacd0b85a97d-488716d22bcmr5146982f8f.20.1790256939370; 
 Thu, 24 Sep 2026 06:35:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm14729085f8f.2.2026.09.24.06.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:35:38 -0700 (PDT)
Message-ID: <872fd689-3a28-4c0d-ab0f-86a7062bf974@redhat.com>
Date: Thu, 24 Sep 2026 15:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 09/25] target/arm: introduce named CPU model
 infrastructure
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
 <20260921123249.1708067-10-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-10-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Add scaffolding for named CPU models on Arm on top of the property
> layer. A model is a list of (property, value) overrides plus an
> optional parent; a child inherits its parent's property values and may
> override them.
>
> Instance init steps:
>     - host feature discovery.
>     - zero out isar.idregs[] and restore RES1 fields.
>     - install SYSREG_ and sve* properties.
>     - walk the parent chain root-first and apply each level's
>       properties.
you should explain about prop types. I see they are either bool or uint.
Given the parent series bool usage is not obvious.
>
> This assumes that each property is idempotent. `pauth` is intentionally
> not installed because the model's ID register view is authoritative
> and can be configured through SYSREG_ properties.
>
> No models are defined yet.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu-models.c | 191 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu-models.h |  36 ++++++++
>  target/arm/meson.build  |   1 +
>  3 files changed, 228 insertions(+)
>  create mode 100644 target/arm/cpu-models.c
>  create mode 100644 target/arm/cpu-models.h
>
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> new file mode 100644
> index 0000000000..fed3197186
> --- /dev/null
> +++ b/target/arm/cpu-models.c
> @@ -0,0 +1,191 @@
> +/*
> + * ARM named CPU models.
> + *
> + * Each model is defined as an array of MODEL_PROP macros, listing only
> + * the properties that DIFFER from the parent model.
> + *
> + * Initialization starts with a zeroed idregs[] array.
> + *
> + * During initialization, the parent chain is walked root-first and every
> + * level's properties are applied via QOM, so the leaf's values naturally
> + * override its ancestors.
> + *
> + * Assumptions:
> + *     - All named CPU model properties are idempotent.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "system/kvm.h"
> +#include "cpu.h"
> +#include "internals.h"
> +#include "kvm_arm.h"
> +#include "cpu-idregs.h"
> +#include "cpu-models.h"
> +
> +#define MODEL_PROP_FIELD_STR  str
> +#define MODEL_PROP_FIELD_BOOL b
> +#define MODEL_PROP_FIELD_NUM  num
> +
> +#define MODEL_PROP(_name, _type, _value) \
> +    { .name = (_name), .type = ARM_MODEL_PROP_##_type, \
> +      .u.MODEL_PROP_FIELD_##_type = (_value) }
> +
> +#define MODEL_PROP_END  { .name = NULL }
> +
> +/* Maximum parent-chain depth for named CPU models. */
inheritence depth?
> +#define ARM_NAMED_CPU_MODEL_MAX_DEPTH 16
> +
> +static const ArmNamedCpuModel arm_cpu_models[] = {
> +    {NULL, NULL, NULL}
> +};
> +
> +const ArmNamedCpuModel *arm_find_model(const char *name)
> +{
> +    for (size_t i = 0; i < ARRAY_SIZE(arm_cpu_models); i++) {
> +        if (!arm_cpu_models[i].name) {
> +            break;
> +        }
> +
> +        if (g_str_equal(arm_cpu_models[i].name, name)) {
> +            return &arm_cpu_models[i];
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void arm_apply_model_props(Object *obj, const ArmModelPropValue *props,
> +                           Error **errp)
> +{
> +    const ArmModelPropValue *pv;
> +    ERRP_GUARD();
> +
> +    for (pv = props; pv->name; pv++) {
> +        switch (pv->type) {
> +        case ARM_MODEL_PROP_BOOL:
> +            object_property_set_bool(obj, pv->name, pv->u.b, errp);
> +            break;
> +        case ARM_MODEL_PROP_NUM:
> +            object_property_set_uint(obj, pv->name, pv->u.num, errp);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        if (*errp) {
> +            error_prepend(errp, "property '%s': ", pv->name);
> +            return;
> +        }
> +    }
> +}
> +
> +void arm_realize_model_chain(Object *obj, const ArmNamedCpuModel *model,
> +                             Error **errp)
> +{
> +    const ArmNamedCpuModel *cur, *parent;
> +    const ArmNamedCpuModel *chain[ARM_NAMED_CPU_MODEL_MAX_DEPTH];
> +    size_t depth = 0;
> +
> +    for (cur = model; cur; ) {
> +        if (depth >= ARRAY_SIZE(chain)) {
> +            error_setg(errp, "model '%s': parent chain too deep", model->name);
> +            return;
> +        }
> +        chain[depth++] = cur;
Please add a comment about the so-called chain and especially describing
that chain[0] is the child and high-level eindex lements are the parents
it derives from.
> +
> +        if (!cur->parent) {
> +            break;
> +        }
> +        parent = arm_find_model(cur->parent);
I guess you directly assert
> +        if (!parent) {
> +            error_setg(errp, "model '%s': unknown parent '%s'", cur->name,
> +                cur->parent);
> +            return;
> +        }
> +        cur = parent;
> +    }
> +
> +    while (depth--) {
> +        arm_apply_model_props(obj, chain[depth]->props, errp);
> +        if (*errp) {
> +            return;
> +        }
> +    }
> +}
> +
> +static void reset_res1_fields(ARMCPU *cpu)
> +{
> +    for (size_t i = 0; i < NUM_ID_IDX; i++) {
> +        for (size_t j = 0; j < arm64_id_regs[i].fields_count; j++) {
> +            if (strcmp(arm64_id_regs[i].fields[j].name, "RES1") == 0) {
> +                cpu->isar.idregs[i] = deposit64(cpu->isar.idregs[i],
> +                    arm64_id_regs[i].fields[j].shift,
> +                    arm64_id_regs[i].fields[j].length,
> +                    MAKE_64BIT_MASK(0, arm64_id_regs[i].fields[j].length));
> +            }
> +        }
> +    }
> +}
> +
> +static void arm_named_cpu_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
> +    const ArmNamedCpuModel *model = arm_find_model(acc->info->name);
> +
> +    if (!model) {
> +        error_report("'%s' CPU model entry not found",
> +                     acc->info->name);
> +        return;
> +    }
> +
> +    if (!kvm_enabled()) {
> +        error_report("'%s' CPU model requires KVM (-accel kvm)",
> +                     acc->info->name);
> +        return;
> +    }
> +
> +    kvm_arm_set_cpu_features_from_host(cpu);
> +    if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        return;
> +    }
> +
> +    /* 1.a Reset ID regs to 0 */
> +    memset(cpu->isar.idregs, 0, sizeof(cpu->isar.idregs));
> +
> +    /* 1.b Properly set RES1 fields. */
> +    reset_res1_fields(cpu);
> +
> +    /* 2. Add sveNNNN and SYSREG_ properties */
> +    aarch64_add_sve_properties(obj);
> +    aarch64_add_idregs_properties(obj);
Can you give more explanations about why we don't have
aarch64_add_pauth_properties()
kvm_arm_set_cpreg_mig_tolerances()

at least.

By the way it is not clear what will become legacy compositive options
with named vcpu models. I see you keep sve but what about the others.
> +
> +    /* 3. Realize the model chain. */
> +    arm_realize_model_chain(obj, model, &error_abort);
> +}
> +
> +void arm_register_named_cpu_models(void)
> +{
> +    static ARMCPUInfo *arm_named_cpu_infos;
> +    size_t i, n = ARRAY_SIZE(arm_cpu_models);
> +
> +    if (!n) {
> +        return;
> +    }
> +
> +    arm_named_cpu_infos = g_new0(ARMCPUInfo, n);
> +    for (i = 0; i < n; i++) {
> +        if (!arm_cpu_models[i].name) {
> +            break;
> +        }
> +
> +        arm_named_cpu_infos[i].name = arm_cpu_models[i].name;
> +        arm_named_cpu_infos[i].initfn = arm_named_cpu_initfn;
> +        arm_cpu_register(&arm_named_cpu_infos[i]);
> +    }
> +}
> +
> +type_init(arm_register_named_cpu_models)
> diff --git a/target/arm/cpu-models.h b/target/arm/cpu-models.h
> new file mode 100644
> index 0000000000..144778744e
> --- /dev/null
> +++ b/target/arm/cpu-models.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef ARM_CPU_MODELS_H
> +#define ARM_CPU_MODELS_H
> +
> +#include "qapi/error.h"
> +#include "qom/object.h"
> +
> +typedef enum ArmModelPropType {
> +    ARM_MODEL_PROP_BOOL,
> +    ARM_MODEL_PROP_NUM,
> +} ArmModelPropType;
> +
> +typedef struct ArmModelPropValue {
> +    const char *name;
> +    ArmModelPropType type;
> +    union {
> +        bool b;
> +        uint64_t num;
> +    } u;
> +} ArmModelPropValue;
> +
> +typedef struct ArmNamedCpuModel {
> +    const char *name;
> +    const char *parent;
any reason why you don't point to the patent ArmNamedCpuModel pointer
instead?
> +    const ArmModelPropValue *props;
> +} ArmNamedCpuModel;
> +
> +void arm_register_named_cpu_models(void);
> +
> +const ArmNamedCpuModel *arm_find_model(const char *name);
> +void arm_apply_model_props(Object *obj, const ArmModelPropValue *props,
> +                           Error **errp);
> +void arm_realize_model_chain(Object *obj, const ArmNamedCpuModel *model,
> +                             Error **errp);
> +
> +#endif /* ARM_CPU_MODELS_H */
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 384d90c530..dd28146c52 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -32,6 +32,7 @@ arm_common_system_ss.add(files(
>    'arm-qmp-cmds.c',
>    'cpu-idregs.c',
>  ))
> +arm_system_ss.add(when: 'TARGET_AARCH64', if_true: files('cpu-models.c'))
>  arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
>  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>  
Eric


