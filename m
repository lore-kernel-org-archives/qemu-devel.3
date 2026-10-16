Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9614CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhhW-0002zI-Ev; Fri, 16 Oct 2026 09:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhhU-0002nA-6Z
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhhR-0006mQ-Dg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Af5urTeD3afgs1G+MH27XDb+cPeKPt9pbqkwAvjLXI=;
 b=GqPkkeE8IGTDGo5JxKVexa7AGBpGYbOC5nZdHXfz8Vr818aDI6peYfRbQKoXvGWEdYRS06
 KASv7c5PLUonX7o8dCjVB15Wm7KH9rFpV7K1cfoRPylBOosRM5N+0JZdjSBGzw8Dzt12KX
 X8zqyYthWWGfhXokEd3s7zMXiPETtVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hbpuQ6axP3mUEnHw2tSB9w-1; Fri, 16 Oct 2026 13:10:14 +0000
X-MC-Unique: hbpuQ6axP3mUEnHw2tSB9w-1
X-Mimecast-MFC-AGG-ID: hbpuQ6axP3mUEnHw2tSB9w_1792156214
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso51504725e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156213; x=1792761013;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Af5urTeD3afgs1G+MH27XDb+cPeKPt9pbqkwAvjLXI=;
 b=Vq4XzrjCR64gbk7TBpo0MbJR4HbpU2fdcaYjnntnxN7dXkmfIQo7akl3eTMICffL3L
 6NxBVqiQ3lwtO5pVJRVLlOZVOfll+FnK29uS9Y8tmLD6BoZXQswWQrNcWFeWdLsoODCs
 Cryv2CUYCPpM/IjZshAGwcb05QX8awYIOzuMQQIZ9PrCjTo5zqdYbY3W73nF9SidHbJL
 WP5UTOLhZG3yqoqqL0F+/suND7IgO1YIXITxGnQuBeKXcI6mCaH4ogA/p6r05EtRw+lq
 n7nr8+ghDMmI1U/Q1QL/YD3oglihqApPw6h7iDIo7So5GEfrvWLk+Bhag/9f6AHjszfM
 hJKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLHQmdpXquBMJuWw7B3T9rxZZaT92VqI62XZTEW4fd33GJ+tBleilZIl8cynevZnaS8mFv/MUCyfaO@nongnu.org
X-Gm-Message-State: AFq9FYIlslac1mmhEjZYE+U3UILcHmHtKfbm786K0oNRCMCuAtStVS35
 iZuoS8Mn4N57babkb67suynniSkMeb52BHLD2Sg/kfKrSEYOZs21oI9sNyE7IUEll6mhELLT95q
 M/pB7JPiaxMDRcgiLC63ct2wUW/ibXuHwZiCRJqBYkpSK7HrTJeJ+0HPq
X-Gm-Gg: AYBFou1ivq8kknITH41vYvetd71ArplKkRgXHYClrCM9iku7kU++FzYKT7E1FTdu2aa
 mwBQTYytMjc41bInT+1xPQHuPxbfwvABthIOdSf1JeuDmwv6G/8ueR7u6fFwPWYkXFtQgg7sIg2
 mQp5UkPFfu3otgbPebw0yOFCMK54r8q5NgwRydqxnMQr4MwqKeYkw6D5vJcw1ypJXv+JS+L/c7s
 CMEie4/uEPIgg4Xu1PfAFXCHR+lwmo8jP4MY6LX1dG8UZxe+ZEHzG7tgDRFDVR9emJ605T3EPdE
 BWlDzYTYWtN9JsNIQO+w/e4ep++di1ujrewpYAikc7alZqIBy1vZvYg+ChYcXy3mfP4A9wvuFOo
 Evw8c5Gmo9KReXGjHpbZwOzaIjufHltm36FIGpyHiIxtAcy0q
X-Received: by 2002:a05:600c:8b78:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a18e47acf5mr511272115e9.11.1792156213480; 
 Fri, 16 Oct 2026 06:10:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b78:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a18e47acf5mr511271195e9.11.1792156212849; 
 Fri, 16 Oct 2026 06:10:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8d12sm5106320f8f.36.2026.10.16.06.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:10:12 -0700 (PDT)
Message-ID: <3e20590e-4276-4166-91d4-47db4875543b@redhat.com>
Date: Fri, 16 Oct 2026 15:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 20/25] target/arm/kvm: compute host-supported
 values for ID register fields
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
 <20260921123249.1708067-21-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-21-khushit.shah@nutanix.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Add kvm_arm_field_get_supported_values() which, for a given ID register
> field, builds the set of values KVM allows it to take on the given host.
>
> Non-writable fields are pinned to the host value. Writable fields follow
> their per-field constraints. This function must be updated when KVM
> starts exposing a new writable field that is not lower-safe; hence the
> special handling of TGranX_2/SpecSEI/L1Ip/MIDR/REVIDR/AIDR.

This effectively advocates for having a snapshot of all the IDREGS that
are known to be writable and handled by the qemu code. Because otherwise
we may return wrong safe values for a given prop.

> signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>
> --------
> Note:
> - We should have an authoritative static list of "writable" fields in
>   QEMU.
> ---
>  target/arm/kvm-stub.c |  7 +++
>  target/arm/kvm.c      | 99 +++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h  | 28 ++++++++++++
>  3 files changed, 134 insertions(+)
>
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index d263adc921..c9cd47bf47 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -144,3 +144,10 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
>  {
>      g_assert_not_reached();
>  }
> +
> +void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
> +                                        const ARMISARegisters *host_isar,
> +                                        ArmFieldValueSet **value_set)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6f704c0509..77b1bcdf55 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1324,6 +1324,105 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>      return true;
>  }
>  
> +static bool arm_field_is_signed(const ARM64SysRegField *field)
> +{
> +    return field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran4")    ||
> +           field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran64")   ||
> +           field_matches(field, ID_MMFR0_EL1_IDX, "InnerShr")      ||
> +           field_matches(field, ID_MMFR0_EL1_IDX, "OuterShr")      ||
> +           field_matches(field, ID_AA64DFR0_EL1_IDX, "DoubleLock") ||
> +           field_matches(field, ID_AA64DFR0_EL1_IDX, "PMUVer")     ||
> +           field_matches(field, ID_DFR0_EL1_IDX, "PerfMon")        ||
> +           field_matches(field, ID_AA64PFR1_EL1_IDX, "MTE_frac")   ||
> +           field_matches(field, ID_AA64MMFR4_EL1_IDX, "E2H0")      ||
> +           field_matches(field, ID_DFR1_EL1_IDX, "MTPMU")          ||
> +           field_matches(field, ID_AA64PFR0_EL1_IDX, "FP")         ||
> +           field_matches(field, ID_AA64PFR0_EL1_IDX, "AdvSIMD");
> +}
> +
> +static void ranges_add(GArray *ranges, uint64_t min, uint64_t max)
> +{
> +    ArmFieldRange r = { .min = min, .max = max };
> +    g_array_append_val(ranges, r);
> +}
> +
> +void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
> +                                        const ARMISARegisters *host_isar,
> +                                        ArmFieldValueSet **value_set)
> +{
> +    bool is_signed = arm_field_is_signed(field);
> +    uint64_t host = extract64(host_isar->idregs[field->index],
> +                              field->shift, field->length);
> +    GArray *ranges = g_array_new(false, false, sizeof(ArmFieldRange));
> +
> +    /* A non-writable field can only ever hold the host value. */
> +    if (!arm_field_is_writable(field)) {
> +        ranges_add(ranges, host, host);
> +        goto done;
> +    }
> +
> +    if (field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran4_2")  ||
> +        field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran16_2") ||
> +        field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran64_2")) {
> +        /* Either support the host value or the "off" value */
> +        ranges_add(ranges, host, host);
> +        if (host != 1) { /* 1 = "off" */
> +            ranges_add(ranges, 1, 1);
those are tagged with SAFE_EXACT policy in the kernel. Could you elaborate?
> +        }
> +    } else if (field_matches(field, CTR_EL0_IDX, "L1Ip")) {
> +        /* Only safe to downgrade to VIPT, other values are reserved. */
> +        ranges_add(ranges, host, host);
> +        if (host != 2) { /* 2 = "VIPT" */
> +            ranges_add(ranges, 2, 2);
*ID_AA64FPFR0_EL1_F8* hals have* EXACT policy and I don't see them
special cased here.


> +        }
> +    } else if (field_matches(field, ID_AA64MMFR1_EL1_IDX, "SpecSEI") ||
> +               field_matches(field, ID_MMFR4_EL1_IDX, "SpecSEI")) {
> +        /* It is safe to upgrade SpecSEI to 1, other values are reserved. */
> +        ranges_add(ranges, host, host);
> +        if (host != 1) {
> +            ranges_add(ranges, 1, 1);
> +        }
> +    } else if (field->index == MIDR_EL1_IDX ||
> +               field->index == REVIDR_EL1_IDX ||
> +               field->index == AIDR_EL1_IDX) {
> +        /*
> +         * No restriction on value that can be set for implementation ID
> +         * registers fields.
> +         */
> +        uint64_t max = 0;
> +        if (field->length == 64) {
> +            max = ~0ULL;
> +        } else {
> +            max = (1ULL << field->length) - 1;
> +        }
> +        ranges_add(ranges, 0, max);
> +    } else {
> +        /*
> +         * After handling the special cases, other writable fields are
> +         * either lower-safe or signed lower-safe.
> +         */
> +        if (field->arch_vals_count) {
> +            for (uint32_t i = 0; i < field->arch_vals_count; i++) {
> +                uint64_t av = field->arch_vals[i];
> +                int64_t v = is_signed ?
> +                    sextract64(av, 0, field->length) : (int64_t)av;
> +                int64_t hv = is_signed ?
> +                    sextract64(host, 0, field->length) : (int64_t)host;
> +                if (v <= hv) {
> +                    ranges_add(ranges, av, av);
> +                }
> +            }
> +        } else {
> +            g_assert(!is_signed); /* No signed field with no arch vals */
> +            ranges_add(ranges, 0, host);
> +        }
> +    }
> +done:
> +    *value_set = g_new0(ArmFieldValueSet, 1);
> +    (*value_set)->n_ranges = ranges->len;
> +    (*value_set)->ranges = (ArmFieldRange *)g_array_free(ranges, false);
> +}
> +
>  static bool arm_field_skip_writeback_always(const ARM64SysRegField *field)
>  {
>      /*
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 4e563fab96..9481e56412 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -175,6 +175,34 @@ int kvm_arm_read_sys_reg64(int fd, uint64_t *val,
>   */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>  
> +typedef struct ARM64SysReg ARM64SysReg;
> +typedef struct ARM64SysRegField ARM64SysRegField;
> +typedef struct ARMISARegisters ARMISARegisters;
> +
> +typedef struct ArmFieldRange {
> +    uint64_t min;
> +    uint64_t max;
> +} ArmFieldRange;
> +
> +typedef struct ArmFieldValueSet {
> +    ArmFieldRange *ranges;
> +    size_t n_ranges;
> +} ArmFieldValueSet;
> +
> +/**
> + * kvm_arm_field_get_supported_values:
> + * @field: The field to get the supported values for
> + * @host_isar: The host ISAR registers
> + * @value_set: The set of supported values for the @field
> + *
> + * Will be allocated and filled in with the supported values for the @field
> + * based on the host_isar and whether the field is writable or not.
> + * The caller must free the value_set.
> + */
> +void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
> +                                        const ARMISARegisters *host_isar,
> +                                        ArmFieldValueSet **value_set);
> +
>  /**
>   * kvm_arm_steal_time_finalize:
>   * @cpu: ARMCPU for which to finalize kvm-steal-time
Eric


