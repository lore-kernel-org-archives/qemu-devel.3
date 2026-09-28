Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645CDC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAZB-0005r2-89; Mon, 28 Sep 2026 08:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBAZ9-0005qe-Jc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBAZ7-00011v-QK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790598880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZAeYsL9d3qjmBo71QrP8m38Q962rFexlqL7pjbHsys=;
 b=NR61W59gU7TuNAhBvKUztMlalFrr5Cw4lbCyoCdx0Iq2Hc87edT3WgJ9AxLAaDMHM66j+M
 UQCYXOXqZ3O0NGCUnGfrrqxOKCZbPfttHeNOTAx6JW+EqIyOSefNYksIeFKsCRx487gnXw
 oVBSq8+sc0/TXsevVNaLnQ1y0M5VsWQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-kvFyjJmuNvywRO8a2RFBeQ-1; Mon, 28 Sep 2026 08:34:38 -0400
X-MC-Unique: kvFyjJmuNvywRO8a2RFBeQ-1
X-Mimecast-MFC-AGG-ID: kvFyjJmuNvywRO8a2RFBeQ_1790598878
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4843227cfcfso2791567f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790598877; x=1791203677;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZAeYsL9d3qjmBo71QrP8m38Q962rFexlqL7pjbHsys=;
 b=NK9caYqEJf55rjrm2IjYG3ZccvTPhVM56hpubWwfSfy6y3tDzT6VEM4Umdx4UHHIIe
 /b6LpxYy9tkqkdoXbiWVN4If/iQUsmsFFsZM1lrFLEKQUP+BP+/a5iVxkFvsn6b/P6Rn
 L91kdrWpMNL8/eNJ4t0A31RDWwp+sy7++FWLsxcAlC0YA6m1tl4Ca8qh3YZDiXj1LGri
 WhbGhTX9PPf+AZawYhBTBfncoTB9uau7x5jJN5JgNM76mSZVz0Gm9e546WQRpBc34g2B
 EDNHLwrphy+TGf+/lieo4auwPqWC5quyVC1Vov13kDj+D/admMhpQIJ001jOnHo7Ea1G
 uX+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4V67e+tLGRVhdntHl77rhmqpRZxnpCEnM5qKFo9hfMnVOe94oo5xwdU+SyhH4XaVOrnT8rUo29taA@nongnu.org
X-Gm-Message-State: AFuF++lGyfHZYsPgpxB/UY5cM3DlV1yBTkcLYffOk/jm1izhbj1s6IYe
 NeABW5QAL5fxFTpRAWeBaCJ+wyuSf5eSMGMtGpyz6NJq8N8ACL0eUA8lbX2Aqi6wqnsy6mcqUZ3
 WKQqcRmtaOh2oB73AtqwsJtPFZYaOSE3KzjOygO4MkZypcetAEkUZ43Hh
X-Gm-Gg: AYBFou01sDp/lRRnYQKDX63SnUFIvIMj9CUpwuZubcpyIc1JNfY/btB2z6+8YTeRF1F
 muACqHRaqmouoQkGng+2/Ktbh/SF7keephOkB9uzFnmRy2RpvGX4kg49P+ilFW6otQe/9fa2Ix7
 y2ox/DQH8EpE44Gi7tpOcKS0Y/VkTJdENcwOHtzLIt1T677GmVcYV1/Pnr+kl1PeM9ArwMdnO8h
 /LHPWBo65BiViBI6cCaSRO41ZlsCeSLj6B1LF9WNIV2Q5QJJkVllwIU0zzkAcCIegHmdqjhej9e
 mk3aT997ohLvZ1yoTre1BlAqqTzmpQewzNRYTf0ettolrglCPPqcVEn8ft4IBcHcX3pa2UGt5es
 RUX/9a9fcS7zWXs07VvC6j9RpXXRuIupvDSjGK6k5ER1BXf32
X-Received: by 2002:a05:600d:864d:10b0:4a0:592:690b with SMTP id
 5b1f17b1804b1-4a005926c0emr28887315e9.8.1790598877647; 
 Mon, 28 Sep 2026 05:34:37 -0700 (PDT)
X-Received: by 2002:a05:600d:864d:10b0:4a0:592:690b with SMTP id
 5b1f17b1804b1-4a005926c0emr28886895e9.8.1790598877230; 
 Mon, 28 Sep 2026 05:34:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-489bd7b1df0sm6841186f8f.31.2026.09.28.05.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 05:34:36 -0700 (PDT)
Message-ID: <c70d8f51-958c-43cd-b07b-96f2a4fada6f@redhat.com>
Date: Mon, 28 Sep 2026 14:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/26] target/arm/kvm: Retrieve writable ID reg map
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
 <20260916144721.751810-11-eric.auger@redhat.com>
 <FC2C35F5-6C1D-4C8C-B4E2-9D2EB1924445@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <FC2C35F5-6C1D-4C8C-B4E2-9D2EB1924445@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi,

On 9/25/26 2:37 PM, Khushit Shah wrote:
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Add an helper to retrieve the writable id reg bitmask.
> s/an/a
>> then retrieve the writable_map array and dispatch it in the writable_map
> s/writable_map/writable_mask
>> fields of arm64_id_regs[] elements.
> s/fields/field

fixed
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> v7 -> v8
>> - added kvm_enabled()
>>
>> v5 -> v6
>> - use arm64_id_regs[].writable_map
>> - squashed 2 commits (helper + user)
>> - removed stub
>> ---
>> target/arm/kvm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 61 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index ed99be7fd8..c6eac41991 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -28,6 +28,7 @@
>> #include "kvm_arm.h"
>> #include "cpu.h"
>> #include "cpu-sysregs.h"
>> +#include "cpu-idregs.h"
>> #include "trace.h"
>> #include "internals.h"
>> #include "hw/pci/pci.h"
>> @@ -51,6 +52,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>> static bool cap_has_mp_state;
>> static bool cap_has_inject_serror_esr;
>> static bool cap_has_inject_ext_dabt;
>> +static bool writable_map_dispatched;
>>
>> /**
>>  * ARMHostCPUFeatures: information about the host CPU (identified
>> @@ -273,6 +275,21 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
>>     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
>> }
>>
>> +static int kvm_feature_idx_to_idregs_idx(int kidx)
>> +{
>> +    int op1, crm, op2;
>> +    ARMSysRegs sysreg;
>> +
>> +    op1 = kidx / 64;
>> +    if (op1 == 2) {
>> +        op1 = 3;
>> +    }
>> +    crm = (kidx % 64) / 8;
>> +    op2 = kidx % 8;
>> +    sysreg = ENCODE_ID_REG(3, op1, 0, crm, op2);
>> +    return get_sysreg_idx(sysreg);
>> +}
>> +
>> static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>> {
>>     /* Identify the feature bits corresponding to the host CPU, and
>> @@ -480,9 +497,53 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>     ahcf->features = features;
>> }
>>
>> +static int kvm_arm_get_writable_id_regs(uint64_t *idregmap)
>> +{
>> +    int cap_writable_id_regs;
>> +    struct reg_mask_range range = {
>> +        .range = KVM_ARM_FEATURE_ID_RANGE,
>> +        .reserved = {0},
>> +        .addr = (uint64_t)idregmap,
>> +    };
>> +
>> +    cap_writable_id_regs =
>> +        kvm_check_extension(kvm_state, KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES);
>> +
>> +    if (!cap_writable_id_regs ||
>> +        !(cap_writable_id_regs & (1 << KVM_ARM_FEATURE_ID_RANGE))) {
>> +        return -ENOSYS;
>> +    }
>> +
>> +    if (kvm_vm_ioctl(kvm_state, KVM_ARM_GET_REG_WRITABLE_MASKS, &range)) {
>> +        return -errno;
>> +    }
> I think just doing return kvm_vm_ioctl(kvm_state, KVM_ARM_GET_REG_WRITABLE_MASKS, &range) is enough.
sure
>> +    return 0;
>> +}
>> +
>> void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>> {
>>     CPUARMState *env = &cpu->env;
>> +    uint64_t *writable_map;
>> +
>> +    writable_map = g_new(uint64_t, KVM_ARM_FEATURE_ID_RANGE_SIZE);
>> +
>> +    if (kvm_enabled() && !writable_map_dispatched &&
>> +        !kvm_arm_get_writable_id_regs(writable_map)) {
>> +        for (int i = 0; i < KVM_ARM_FEATURE_ID_RANGE_SIZE; i++) {
>> +            uint64_t mask = writable_map[i];
>> +
>> +            if (mask) {
>> +                int idx = kvm_feature_idx_to_idregs_idx(i);
>> +
>> +                if (idx < 0 || idx > ARRAY_SIZE(arm64_id_regs)) {
> Bug: >=
> Also, this condition will never be true, as get_sysreg_idx() asserts out on an unknown ID register. Which probably
> should not happen.

removed
>
>> +                    continue;
>> +                }
>> +                arm64_id_regs[idx].writable_mask = mask;
>> +            }
>> +        }
>> +        writable_map_dispatched = true;
> What is the need of writable_map_dispatched, why can’t we use arm_host_cpu_features.dtb_compatible as below?
Using a dtb related condition to decide whether we shall do the writable
mask dispatch looks far-fetched to me, although it would effectively work.

I would rather keep it as it and wait for other comments if any.

Thanks

Eric
>
> Warm Regards,
> Khushit
>> +    }
>> +    g_free(writable_map);
>>
>>     if (!arm_host_cpu_features.dtb_compatible) {
>>         kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
>> -- 
>> 2.53.0
>>


