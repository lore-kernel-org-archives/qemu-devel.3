Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G5Csnpwg;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GgGWH1VD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWcqe-0004Mr-7H; Thu, 26 Nov 2026 12:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWcq3-0004Iy-Di
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 12:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWcq0-00018K-N4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 12:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795712447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNjCOS8vDJEZBDE7+EdkAsSR8TKTXPOARGUmWVsbcMc=;
 b=G5Csnpwg0Yw1wj5hSF2w012A1YYwHz+LZjIncG4qtQGIRnv39eahBpWugY40EfHcgkTM9I
 th25ajqCLWWiCazsp6eoKvXNKwXej58PIcou4LNLZttCjnrrXIAQEkfgIrM4DwVxbq2tHW
 bPoT4bRSRhtIQu49GDV4QaD7U2PRcf0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-J4TaMI3ZOvCW2d2JNoTEmA-1; Thu, 26 Nov 2026 17:00:35 +0000
X-MC-Unique: J4TaMI3ZOvCW2d2JNoTEmA-1
X-Mimecast-MFC-AGG-ID: J4TaMI3ZOvCW2d2JNoTEmA_1795712431
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so55695645e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795712431; x=1796317231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CNjCOS8vDJEZBDE7+EdkAsSR8TKTXPOARGUmWVsbcMc=;
 b=GgGWH1VD8canV2ydCjMP7JzojNg+Zg9IowP717mtPKDBmgMMMAiwZNggZSwhOSJ0c+
 eJdTVSrYI0JEJx2F3oWAGokajgpmeXf2mJv/EFn6px2cpIB2Oaxfduz4HL83qwzXrfoa
 Yjbgm2oNadQ4+CeIi0A86mhKzh15oTDWc6KYIWkbmfVsbnoZ5PbXB0cVq2pk3YxjJrur
 mtMVM9VaEXrEa6+s5tZfHuGN3/4FN9MrOeiGIQBGhfGkaXU23Jg3IWAC1bnzEfsfVkE+
 b0Cbf6fX30WoYIPO7w7x8OkZhP9Oibbwd5K61gGp4iKddsrlrr5i4DJzEpyygmpli51x
 1Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712431; x=1796317231;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNjCOS8vDJEZBDE7+EdkAsSR8TKTXPOARGUmWVsbcMc=;
 b=D+bisDoMo/UQLs2lgujj6UPJ3t6pHxVlOMH1rWfCpYSuurdngua8zH0dY6vSxNZSa7
 IZd9Me5DoTBXGFdMZ8bSB4N1Xj+HOCE8RHe74eLZO608I/PJ2neJVzIGbkGr63H7aVKN
 zBDyOc/OE5rS8WVkOg/Ks+kyuqbdvxwhPore5qmrhwxUMjx64UBUy2DQHbPmXpT1OF/9
 5gPyoi6ntBb+kAo+QjNmZTWmF+UiWgqYbFKfUMEVUwSQZva4FGNjE+C6cze/lzmTTCQY
 Hrp8UGODecC6QLscDig4VWogMm2/1y2mc4GgzOOiSFVIt5JfS7xI0VfNuk408Wrtnadt
 xKFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEGizkeHwKX0+gbRuAiKJaJ0n3wQsEVg/m0NsB6mfsEmhpFufiDOeWeM7jHhHuST0pv4xN6vArc/w5/@nongnu.org
X-Gm-Message-State: APuU4Z+eV3cwoBN38DmJm1q7Y5tq3omrOka9qRuseDp0l2rGBsz21EEL
 kFfcFBdvSxr8/uzICRmxEkHHGpdBdLTxFtvT64lDg2klIMawa7a3v0mUIdudI6bZVE9rjT385pn
 CJLg91J6KOfyQPg85vw1UyITIqXlKKXefyB0w8xFgnsR+plJMCj9Cfxll
X-Gm-Gg: AZFdTZfOvcToFZxEA38uvvAF+kA2ADFkNsMPXKN8VLrP135oscMP827Kld7aHo4iGTx
 2Cp8Nf99pgIkyxqS8r5WOo3O/raJzP2rxRZlnrv4fs7iiAtwYRtIlh1Jfbf1Qb85TrGpBGpPz2G
 JZ3veSdA0S4sQtRJ9xvZpTMLSpYrDWvNvjMZAueqAkKeJKSHQesvjElzOXi4LSIf9dWhmpzbSo6
 VKMjHAU+u40TFkyNbbHiyvfU7s3soAkUtiSzm7TGmWO0+ISWrdFMRIc9msCDTI4KFyT5iduVZoQ
 wq/UEGYjPHDiOnhWjxIaOGdEj6Pt4K0c0UrTNRl/tiNXWdXdnD3phRNAyk0SsuDoKNnD3+RDHsM
 /d/iig6YwBKdqJRCH8hGvtXQu9zBvyo8PRnG9zFrHMVgRurBb2N0ipmti+/9MqsDAc0k2GqyB7R
 iGvqhEamSBkEuO/Zvd
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr454531995e9.5.1795712430715; 
 Thu, 26 Nov 2026 09:00:30 -0800 (PST)
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr454530965e9.5.1795712430155; 
 Thu, 26 Nov 2026 09:00:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm724300475e9.11.2026.11.26.09.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 09:00:29 -0800 (PST)
Message-ID: <c96d22b8-c344-496d-9e08-e00e89c8708a@redhat.com>
Date: Thu, 26 Nov 2026 18:00:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/3] target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH
 select an nVHE EL2
To: Khushit Shah <khushit.shah@nutanix.com>,
 Haseeb Ashraf <haseebashraf091@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Eric Auger
 <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
 <20261126052741.90607-3-haseebashraf091@gmail.com>
 <6BB40C51-1983-4760-BDFD-500351A7B0C9@nutanix.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <6BB40C51-1983-4760-BDFD-500351A7B0C9@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Khushit,

On 11/26/26 7:21 AM, Khushit Shah wrote:
>=20
>=20
>> On 26 Nov 2026, at 10:57=E2=80=AFAM, Haseeb Ashraf <haseebashraf091@gm=
ail.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
>>
>> KVM runs a nested guest with a VHE-only EL2 (HCR_EL2.E2H RES1) unless
>> KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at KVM_ARM_VCPU_INIT time. With=

>> that feature FEAT_VHE is hidden: ID_AA64MMFR1_EL1.VH reads 0 and
>> HCR_EL2.E2H is RES0. Guest hypervisors which only support nVHE, such a=
s
>> Xen, can only run in the latter mode.
>>
>> Do not add a dedicated machine or CPU option for it.  Derive the vCPU
>> init feature from the ID register field selected by the user instead:
>> SYSREG_ID_AA64MMFR1_EL1_VH=3D0 requests KVM_ARM_VCPU_HAS_EL2_E2H0.
>>
>> KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
>> "writable fields only" rule would not create the property. Expose it
>> explicitly when the host supports KVM_CAP_ARM_EL2_E2H0. Apply this
>> init-driven property before creating the scratch vCPU and use it when
>> initializing real vCPUs. Setting VH=3D0 without virtualization=3Don is=

>> rejected.
>>
>> KVM derives other ID register fields from the selected init mode. Re-r=
ead
>> ID_AA64MMFR1_EL1 and ID_AA64MMFR4_EL1 after vCPU initialization so QEM=
U's
>> cached CPU model and query-cpu-model-expansion agree with the values t=
he
>> guest sees.
>>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Suggested-by: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
>> Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
>> ---
>>
>> v3:
>> - Apply init-driven properties before creating the scratch vCPU.
>> - Refresh MMFR1 and MMFR4 from KVM after vCPU initialization.
>> docs/system/arm/cpu-features.rst | 22 ++++++++++++
>> target/arm/arm-qmp-cmds.c        | 38 +++++++++++++++++++++
>> target/arm/cpu-idregs.h          | 31 +++++++++++++++++
>> target/arm/cpu64.c               | 51 ++++++++++++++++++++++------
>> target/arm/kvm-stub.c            |  5 +++
>> target/arm/kvm.c                 | 58 ++++++++++++++++++++++++++++++--=

>> target/arm/kvm_arm.h             |  8 +++++
>> 7 files changed, 199 insertions(+), 14 deletions(-)
>>
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-fe=
atures.rst
>> index 13454783cf..cde26c04b9 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -579,6 +579,28 @@ either not writable with the specific host kernel=
, unknown to this QEMU
>> build, or intentionally not exposed because it overlaps a legacy compo=
site
>> option.
>>
>> +Selecting an nVHE-only EL2
>> +--------------------------
>> +
>> +With ``-machine virt,virtualization=3Don``, KVM presents a VHE-only E=
L2 to
>> +the guest (``HCR_EL2.E2H`` is RES1) by default.  A guest hypervisor w=
hich
>> +only supports nVHE, such as a type-1 hypervisor like Xen, needs VHE t=
o be
>> +hidden. This is done by setting ``ID_AA64MMFR1_EL1.VH`` to 0::
>> +
>> +  $ qemu-system-aarch64 -M virt,virtualization=3Don -accel kvm \
>> +        -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=3D0
>> +
>> +QEMU then requests ``KVM_ARM_VCPU_HAS_EL2_E2H0`` when initializing th=
e
>> +vCPUs, so that ``HCR_EL2.E2H`` is RES0 for the guest. Leaving the
>> +property unset, or setting it to 1, keeps the default VHE-only EL2.
>> +Setting it to 0 requires ``virtualization=3Don``.
>> +
>> +KVM does not allow userspace to write ``ID_AA64MMFR1_EL1.VH`` directl=
y, so
>> +this is an exception to the rule that only writable fields get a
>> +property: the ``SYSREG_ID_AA64MMFR1_EL1_VH`` property is exposed when=
 the
>> +host kernel supports ``KVM_CAP_ARM_EL2_E2H0``. Without this support t=
he
>> +property does not exist.
>> +
>> A note on compatibility
>> -----------------------
>>
>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>> index 9a0258a3d6..b8e6c212a8 100644
>> --- a/target/arm/arm-qmp-cmds.c
>> +++ b/target/arm/arm-qmp-cmds.c
>> @@ -98,6 +98,7 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionT=
ype type,
>>     Visitor *visitor =3D NULL;
>>     Error *err =3D NULL;
>>     bool scratch_created =3D false;
>> +    bool e2h0_requested =3D false;
>>     const char *name;
>>     int fdarray[3];
>>     int fd =3D -1;
>> @@ -173,6 +174,38 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansi=
onType type,
>>             goto bail_out;
>>         }
>>
>> +        /*
>> +         * Init-driven SYSREG properties must be visible while the sc=
ratch
>> +         * vCPU is initialized, not only when the remaining propertie=
s are
>> +         * applied below.
>> +         */
>> +        for (const QDictEntry *entry =3D qdict_first(qdict_in);
>> +                 entry !=3D NULL; entry =3D qdict_next(qdict_in, entr=
y)) {
>> +            const char *key =3D qdict_entry_key(entry);
>> +            QObject *val_obj =3D qdict_entry_value(entry);
>> +            Visitor *v;
>> +            uint64_t value;
>> +
>> +            if (!strcmp(key, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
>> +                v =3D qobject_input_visitor_new(val_obj);
>> +                if (!visit_type_uint64(v, key, &value, errp)) {
>> +                    visit_free(v);
>> +                    goto bail_out;
>> +                }
>> +                visit_free(v);
>> +                e2h0_requested =3D value =3D=3D 0;
>> +            } else {
>> +                continue;
>> +            }
>> +
>> +            v =3D qobject_input_visitor_new(val_obj);
>> +            if (!object_property_set(obj, key, v, errp)) {
>> +                visit_free(v);
>> +                goto bail_out;
>> +            }
>> +            visit_free(v);
>> +        }
>> +
>>         /**
>>          * Test SYSREG option settings
>>          * In full mode, build a scratch vcpu that reflects composite =
legacy
>> @@ -237,6 +270,11 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansi=
onType type,
>>             visit_free(v);
>>         }
>>
>> +        if (scratch_created && e2h0_requested &&
>> +            kvm_arm_refresh_e2h0_idregs(ARM_CPU(obj), fd, errp)) {
>> +            goto bail_out;
>> +        }
>> +
>>         visit_check_struct(visitor, &err);
>>         if (err) {
>>             goto bail_out;
>> diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
>> index 465ec83c97..76d7b94858 100644
>> --- a/target/arm/cpu-idregs.h
>> +++ b/target/arm/cpu-idregs.h
>> @@ -73,4 +73,35 @@ int arm_cpu_apply_sysreg_props(ARMCPU *cpu, ARMSysr=
egPropApplyFn accel_apply_fn,
>> bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field=
,
>>                                   uint64_t value, Error **errp);
>>
>> +/**
>> + * arm_cpu_sysreg_prop_get:
>> + *
>> + * Look up the value the user set through a SYSREG_<IDREG>_<FIELD>
>> + * property, before it is applied to the vcpu.  Accelerators use it t=
o
>> + * derive vcpu init settings from the requested ID register values.
>> + *
>> + * @cpu: vcpu the property belongs to
>> + * @reg_idx: ID register index (<REG>_EL1_IDX)
>> + * @shift: lowest bit of the field
>> + * @value: set to the requested field value when the property was set=

>> + *
>> + * returns true if the property was set by the user
>> + */
>> +bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
>> +                             uint64_t *value);
>> +
>> +/**
>> + * arm_cpu_sysreg_field_init_driven:
>> + *
>> + * Some fields cannot be written with the accelerator once the vcpu e=
xists
>> + * but are selected through a vcpu init feature instead (for instance=

>> + * ID_AA64MMFR1_EL1.VH with KVM_ARM_VCPU_HAS_EL2_E2H0).  Their SYSREG=

>> + * property is exposed even if the field is not writable.
>> + *
>> + * @field: ID register field
>> + *
>> + * returns true if @field is selected at vcpu init time on this host
>> + */
>> +bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field);
>> +
>> #endif
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index c08eba7010..1fc3a4bb7c 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -835,6 +835,21 @@ static ARM64SysRegField *arm_sysreg_get_field(ARM=
64SysReg *reg, int bit)
>>     return NULL;
>> }
>>
>> +bool arm_cpu_sysreg_prop_get(ARMCPU *cpu, int reg_idx, int shift,
>> +                             uint64_t *value)
>> +{
>> +    gpointer value_ptr;
>> +    uint64_t key =3D IDREG_FIELD_KEY(reg_idx, shift);
>> +
>> +    if (!g_hash_table_lookup_extended(cpu->sysreg_props,
>> +                                      GUINT_TO_POINTER(key), NULL,
>> +                                      &value_ptr)) {
>> +        return false;
>> +    }
>> +    *value =3D GPOINTER_TO_UINT(value_ptr);
>> +    return true;
>> +}
>> +
>> /**
>>  * arm_cpu_validate_sysreg_prop:
>>  *
>> @@ -879,6 +894,13 @@ bool arm_cpu_validate_sysreg_prop(ARMCPU *cpu, AR=
M64SysRegField *field,
>>             error_setg(errp, "%s is non null whereas pmu is unset", pr=
opname);
>>             return false;
>>         }
>> +    /* nVHE-only EL2, selected at vcpu init time */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64MMFR1_EL1_VH")) {
>> +        if (value =3D=3D 0 && !cpu->has_el2) {
>> +            error_setg(errp, "%s=3D0 requires -machine virtualization=
=3Don",
>> +                       propname);
>> +            return false;
>> +        }
>>     /* aarch64=3Doff */
>>     } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>>         if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
>> @@ -988,17 +1010,9 @@ static void get_sysreg_prop(Object *obj, Visitor=
 *v,
>>     int index =3D field->index;
>>     int lower =3D field->shift;
>>     int length =3D field->length;
>> -    gpointer value_ptr;
>>     uint64_t value;
>> -    uint64_t key =3D IDREG_FIELD_KEY(index, lower);
>> -    gboolean exists;
>> -
>> -    exists =3D g_hash_table_lookup_extended(cpu->sysreg_props,
>> -                                          GUINT_TO_POINTER(key), NULL=
,
>> -                                          &value_ptr);
>> -    if (exists) {
>> -        value =3D GPOINTER_TO_UINT(value_ptr);
>> -    } else {
>> +
>> +    if (!arm_cpu_sysreg_prop_get(cpu, index, lower, &value)) {
>>         uint64_t mask =3D MAKE_64BIT_MASK(lower, length);
>>         uint64_t *idregs =3D cpu->isar.idregs;
>>
>> @@ -1028,6 +1042,20 @@ static const char * const aarch64_sysreg_prop_s=
kip_list[] =3D {
>>     "SYSREG_ID_AA64ISAR2_EL1_GPA3",
>> };
>>
>> +/*
>> + * Fields which KVM does not let userspace write with KVM_SET_ONE_REG=
,
>> + * but which QEMU can still select through a vcpu init feature, see
>> + * kvm_arm_vcpu_prepare_init_features().  ID_AA64MMFR1_EL1.VH is hidd=
en
>> + * by KVM_ARM_VCPU_HAS_EL2_E2H0, which requests an nVHE-only EL2.
>> + */
>> +bool arm_cpu_sysreg_field_init_driven(ARM64SysRegField *field)
>> +{
>> +    /* Compare the field first: this runs for every ID register field=
 */
>> +    return field->index =3D=3D ID_AA64MMFR1_EL1_IDX &&
>> +           field->shift =3D=3D R_ID_AA64MMFR1_VH_SHIFT &&
>> +           kvm_enabled() && kvm_arm_el2_e2h0_supported();
>> +}
>> +
>> static bool aarch64_sysreg_prop_skipped(const char *prop_name)
>> {
>>     for (int i =3D 0; i < ARRAY_SIZE(aarch64_sysreg_prop_skip_list); i=
++) {
>> @@ -1084,7 +1112,8 @@ aarch64_add_one_idreg_properties(Object *obj, AR=
M64SysReg *reg,
>>         }
>>         map =3D map & ~field_mask;
>>
>> -        if (writable_only && !field_writable_mask) {
>> +        if (writable_only && !field_writable_mask &&
>> +            !arm_cpu_sysreg_field_init_driven(field)) {
>>             continue;
>>         }
>>
>> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
>> index 88e35909c4..75e82887d6 100644
>> --- a/target/arm/kvm-stub.c
>> +++ b/target/arm/kvm-stub.c
>> @@ -47,6 +47,11 @@ bool kvm_arm_el2_e2h0_supported(void)
>>     return false;
>> }
>>
>> +int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> /*
>>  * These functions should never actually be called without KVM support=
=2E
>>  */
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 8ef5597c68..2a72f52c44 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -1324,9 +1324,15 @@ bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, =
int cpufd,
>>         return false;
>>     }
>>
>> -    ret =3D kvm_arm_override_idreg_field(cpufd, field, newfv, errp);
>> -    if (ret) {
>> -        return false;
>> +    /*
>> +     * Init-driven fields (e.g. VH) are selected through a vcpu init
>> +     * feature, which the scratch vcpu may not have: do not write the=
m.
>> +     */
>> +    if (!arm_cpu_sysreg_field_init_driven(field)) {
>> +        ret =3D kvm_arm_override_idreg_field(cpufd, field, newfv, err=
p);
>> +        if (ret) {
>> +            return false;
>> +        }
>>     }
>>
>>     cpu->isar.idregs[field->index] =3D
>> @@ -2183,6 +2189,30 @@ bool kvm_arm_el2_e2h0_supported(void)
>>     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
>> }
>>
>> +int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp)
>> +{
>> +    static const ARMIDRegisterIdx indices[] =3D {
>> +        ID_AA64MMFR1_EL1_IDX,
>> +        ID_AA64MMFR4_EL1_IDX,
>> +    };
>> +
>> +    for (int i =3D 0; i < ARRAY_SIZE(indices); i++) {
>> +        ARMIDRegisterIdx index =3D indices[i];
>> +        int ret;
>> +
>> +        ret =3D read_sys_reg64(fd, &cpu->isar.idregs[index],
>> +                             idregs_sysreg_to_kvm_reg(
>> +                                 id_register_sysreg[index]));
>> +        if (ret) {
>> +            error_setg(errp, "failed to refresh %s after vCPU init",
>> +                       arm64_id_regs[index].name);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> bool kvm_arm_mte_supported(void)
>> {
>>     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
>> @@ -2239,7 +2269,19 @@ static void kvm_arm_vcpu_prepare_init_features(=
ARMCPU *cpu)
>>                                       1 << KVM_ARM_VCPU_PTRAUTH_GENERI=
C);
>>     }
>>     if (cpu->has_el2 && kvm_arm_el2_supported()) {
>> +        uint64_t vh;
>> +
>>         cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_HAS_EL2;
>> +        /*
>> +         * KVM exposes a VHE-only EL2 by default.  An nVHE-only EL2 c=
an
>> +         * only be selected at vcpu init time, so derive it from the
>> +         * requested ID_AA64MMFR1_EL1.VH value.
>> +         */
>> +        if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
>> +                                    R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
>> +            vh =3D=3D 0) {
>> +            cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_HAS_EL2_=
E2H0;
>> +        }
>>     }
>> }
>>
>> @@ -2286,6 +2328,16 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **er=
rp)
>>         return ret;
>>     }
>>
>> +    uint64_t vh;
>> +    if (arm_cpu_sysreg_prop_get(cpu, ID_AA64MMFR1_EL1_IDX,
>> +                                R_ID_AA64MMFR1_VH_SHIFT, &vh) &&
>> +        vh =3D=3D 0) {
>> +        ret =3D kvm_arm_refresh_e2h0_idregs(cpu, CPU(cpu)->kvm_fd, er=
rp);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +    }
>> +
>=20
> There should not be a need to explicitly refreshing this specific regis=
ters.
>=20
> I think this should be handled by Eric=E2=80=99s series by refreshing a=
ll the ID=20
> registers after write-back.
>=20
> Eric, what is your view on this?

yes effectivity the value read for isar.idregs[] corresponding to not exp=
licitly set SYSREG props might be the one read from the "max" scratch vcp=
u and not the final one.
So I think we need to fix that

Thanks

Eric> >=20
> Thanks,
> Khushit
>>     if (cpu_isar_feature(aa64_sve, cpu)) {
>>         ret =3D kvm_arm_sve_set_vls(cpu);
>>         if (ret) {
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 0916a5fdb4..670b410a1a 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -208,6 +208,8 @@ bool kvm_arm_el2_supported(void);
>>  * KVM_ARM_VCPU_HAS_EL2_E2H0, and false otherwise.
>>  */
>> bool kvm_arm_el2_e2h0_supported(void);
>> +
>> +int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd, Error **errp);
>> #else
>>
>> static inline bool kvm_arm_aarch32_supported(void)
>> @@ -229,6 +231,12 @@ static inline bool kvm_arm_el2_e2h0_supported(voi=
d)
>> {
>>     return false;
>> }
>> +
>> +static inline int kvm_arm_refresh_e2h0_idregs(ARMCPU *cpu, int fd,
>> +                                              Error **errp)
>> +{
>> +    return 0;
>> +}
>> #endif
>>
>> /**
>> --=20
>> 2.34.1
>>
>=20


