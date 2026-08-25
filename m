Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE499C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrsx-0000aa-3A; Tue, 25 Aug 2026 10:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyrsv-0000a7-Rk
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyrst-0002Or-JY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787667133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4iL8cm9xLlw42MXWWTWh2uxD3jujV4/hT7MHer/4wA=;
 b=A0ifL1TIPDaNHhDcOH6B6l7d9Bj20WjKOD3TLxON8C4pifhVe3jiTI9ay0pLso4w+j5zIQ
 YPEBVQ7nIWbBgPVhHh2kM1ijEtUVuM0Mb63XIgTBoTa4Gjwt4BCMgdfRyWQGOPPidzfWys
 iYCzRR7wEZ5bx8nxJVG+ZV7R01ppTSA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-61jlKsPsOkuTQgtBWRYDYw-1; Tue, 25 Aug 2026 10:12:11 -0400
X-MC-Unique: 61jlKsPsOkuTQgtBWRYDYw-1
X-Mimecast-MFC-AGG-ID: 61jlKsPsOkuTQgtBWRYDYw_1787667130
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c1f3117bc6bso440667966b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667130; x=1788271930;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M4iL8cm9xLlw42MXWWTWh2uxD3jujV4/hT7MHer/4wA=;
 b=kCpSFUFSuf6lx8r5Ge9iUiUHzCqdHAgvSFOH6gHn5eYWz6a/8Or0u5BqZQpfRmPNWq
 b7vDed1w6trqn+7viHF1M+jPmkPGOzEQ1UhjiL/U6TUKOXRcDUeNwI2LHHBv/hMRRtpf
 JIQYGuX8iQacjozMspHOqy0QBTgjTsXcnq87W3iAWtKMakssWFrqWDC4GJUHKGGeCrwa
 8lA4npbc1qNwGX+lsYxkiVluJpOiMMtTAQxwX3VCXc8Um/qEahKC7CLPUmUqmhKGf5/v
 pMo+7EUSI+bHCQw1TsqMYgK8IRIsAx9jPtGRgnlAzh/fiiRWIqOxxi1fafOeBFvU6ZYt
 9omg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcRxZvY2Wu2GhEj/n1YUt3/m7YnpLd7QYg3eih1cmYUtDDJH7PajfnF5ZTFItx/1Wa4/61zfYvkJCI@nongnu.org
X-Gm-Message-State: AFuF++lZAaxjGvTp4m0wHDHomUUgn7g/WuGcsEwHeln5Q1OI3yIN1H6C
 EJo4sevybZQizW4Mw/CxHAcfGtSGfIDNLxQuv1udKHkNrKav9Vrm8bzwRaLcRwL2gtKPBMp8adc
 7jzL5225v+lW5jq/FoncozxCLsmuqF4Py7YgpBpRCdaiNRIj/Mp88SqDI
X-Gm-Gg: AR+sD13RH7s+WLI81ZYCdWlg3Jzkhg3wnMIk47akFuDdtRAw+cS1tHcNE2G/pfboJrX
 Y2LdZy9QYi5S8eDV02olmXW6DxjGaH7QP6po28C0N6Fs5twEvH/mOLBO/hqcYO/QgmxFvSR9TkU
 hOEGMCBdtAQ3lcgDUr7RBvSLHk5yifr+XToowhMglm29sWDk+OPecyYVNiKddAdrP5Tz3HPKuf5
 M+V7Fa9VPtJ7WshJq52GXfc4okUnNzCR+61di0RaemYfy9b4CvGBm7fnzJpq8a5lAG/aXMr+047
 1sN7xwMPBnB55klemR1hDsb/cVms3C019EjuF53v9/g7XUwaZ0Mn8Hq+2UubGYbB5FDDXsmINww
 ZSIBqXs7O1YKun7B9C9b+z5uMtmOMKVCCXNLPnkoLb7XKjmJR
X-Received: by 2002:a17:906:9f8e:b0:c24:b11a:46fc with SMTP id
 a640c23a62f3a-c24e5be5ae6mr717380466b.22.1787667130152; 
 Tue, 25 Aug 2026 07:12:10 -0700 (PDT)
X-Received: by 2002:a17:906:9f8e:b0:c24:b11a:46fc with SMTP id
 a640c23a62f3a-c24e5be5ae6mr717373766b.22.1787667129592; 
 Tue, 25 Aug 2026 07:12:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d7399sm20394026a12.26.2026.08.25.07.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 07:12:08 -0700 (PDT)
Message-ID: <54207f52-e9f0-49f1-9ac2-1653e4a1bd53@redhat.com>
Date: Tue, 25 Aug 2026 16:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 18/18] arm-qmp-cmds: introspection for ID register
 props
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, yangjinqian1@huawei.com, cohuck@redhat.com,
 richard.henderson@linaro.org, sebott@redhat.com, skolothumtho@nvidia.com,
 philmd@oss.qualcomm.com, maz@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-19-eric.auger@redhat.com> <878q613tae.fsf@pond.sub.org>
 <cae6f5c2-edb2-4811-a915-cbd93bbd903b@redhat.com>
 <87wltemu97.fsf@pond.sub.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87wltemu97.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Markus,

On 8/25/26 11:20 AM, Markus Armbruster wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> Hi Markus,
>>
>> On 8/20/26 1:50 PM, Markus Armbruster wrote:
>>> Eric Auger <eric.auger@redhat.com> writes:
>>>
>>>> From: Cornelia Huck <cohuck@redhat.com>
>>>>
>>>> Implement the capability to query available ID register values by
>>>> adding SYSREG_* options and values to the cpu model expansion for the
>>>> host model, if available.
>>>>
>>>> Excerpt:
>>>> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
>>> Is this qmp-shell?
>> yes it is. Is that a problem?
> I wouldn't call use of qmp-shell a problem.  Except some reader may not
> recognize it from the example input, or may not even know it exists.
> Mentioning it takes care of all that.
>
> I prefer to use QMP directly myself, like this:
>
>     $ socat "READLINE,history=$HOME/.qmp_history,prompt=QMP> " UNIX-CONNECT:/path/to/socket
>
> But that's just personal preference.

OK thank you for the details. For now I clarified in the commit msg that
those are qmp-shell examples.

Eric
>
>>>> {"return": {"model": {"name": "host", "props": {"SYSREG_ID_AA64PFR0_EL1_EL3": 1,
>>>> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0, "SYSREG_CTR_EL0_L1Ip": 3,
>>>> "SYSREG_MIDR_EL1_PartNum": 3407, "SYSREG_CTR_EL0_DminLine": 4,
>>>> "SYSREG_ID_AA64MMFR0_EL1_PARange": 5, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0
>>>> ../..
>>>>
>>>> This allows the upper stack to detect available writable ID regs and
>>>> the "host passthrough model" values.
>>>>
>>>> It also allows to test some ID reg field values:
>>>> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
>>>> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x13) exceeds length of field (4)!"}}
>>>>
>>>> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x2}}
>>>> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x2) does not match any arch valid enum value!"}}
>>> The examples use CPU "host".  Inconvenient for me, because I run into
>>> "The CPU type 'host' requires KVM" when I try to play with them myself.
>>> If you don't actually need "host" here, consider using something that
>>> works more widely, just to help reviewers.
>> It only applies to the host model, that's the reason. Extending this to
>> TCG models is theorerically feasible but would induce huge changes
>> without much benefits I think. With TCG you already have named vcpu
>> models you can migrate as is. The purpose of this series is to allow
>> tweaking the host passthrough model to allow migration between
>> differents hosts.
> Thanks!
>
>>>> The following checks are performed:
>>>> - the value does not exceed the field size
>>>> - if the field is associated to enum values, the set value must be one
>>>>   of those enum values
>>>> - the value is applied against a scratch vcpu making sure the setting is
>>>>   not rejected for this host
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>
>>>> ---
>>>>
>>>> v5 -> v6:
>>>> - add the write capability
>>>> ---
>>>>  target/arm/arm-qmp-cmds.c | 98 +++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 98 insertions(+)
>>>>
>>>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>>>> index 83ec95c290..41fefadcea 100644
>>>> --- a/target/arm/arm-qmp-cmds.c
>>>> +++ b/target/arm/arm-qmp-cmds.c
>>>> @@ -21,6 +21,7 @@
>>>>   */
>>>>  
>>>>  #include "qemu/osdep.h"
>>>> +#include "qemu/error-report.h"
>>>>  #include "qemu/target-info.h"
>>>>  #include "hw/core/boards.h"
>>>>  #include "kvm_arm.h"
>>>> @@ -30,7 +31,10 @@
>>>>  #include "qapi/qapi-commands-machine.h"
>>>>  #include "qapi/qapi-commands-misc-arm.h"
>>>>  #include "qobject/qdict.h"
>>>> +#include "qobject/qnum.h"
>>>>  #include "qom/qom-qobject.h"
>>>> +#include <linux/kvm.h>
>>>> +#include "system/kvm.h"
>>>>  #include "cpu.h"
>>>>  
>>>>  static GICCapability *gic_cap_new(int version)
>>>> @@ -84,11 +88,14 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>>>                                                       Error **errp)
>>>>  {
>>>>      CpuModelExpansionInfo *expansion_info;
>>>> +    ObjectPropertyIterator iter;
>>>>      const QDict *qdict_in;
>>>> +    ObjectProperty *idregprop;
>>>>      QDict *qdict_out;
>>>>      ObjectClass *oc;
>>>>      Object *obj;
>>>>      const char *name;
>>>> +    int fdarray[3];
>>>>      int i;
>>>>  
>>>>      if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
>>>> @@ -133,6 +140,38 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>>>  
>>>>      obj = object_new(object_class_get_name(oc));
>>>>  
>>>> +    if (kvm_enabled()) {
>>>> +        bool pmuv3_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
>>>> +        bool sve_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>>>> +        struct kvm_vcpu_init init = { .target = -1, };
>>>> +        bool el2_supported = kvm_arm_el2_supported();
>>>> +        bool pauth_supported;
>>>> +        int ret;
>>>> +
>>>> +        pauth_supported = kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
>>>> +                          kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC);
>>>> +
>>>> +        if (sve_supported) {
>>>> +            init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
>>>> +        }
>>>> +        if (el2_supported) {
>>>> +            init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>>>> +        }
>>>> +        if (pauth_supported) {
>>>> +            init.features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>>>> +                             1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>>>> +        }
>>>> +        if (pmuv3_supported) {
>>>> +            init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>>> +        }
>>>> +
>>>> +        ret = kvm_arm_create_scratch_host_vcpu(fdarray, &init);
>>>> +        if (!ret) {
>>>> +            error_setg(errp, "failing creating a scratch vcpu");
>>> This error message feels off.  I'd use something like "can't create
>>> FOO".  Still bad, because it provides no clue on why.  What are the
>>> possible failure modes?
>> OK. There are quite a lot of possible failures which are handled in
>> kvm_arm_create_scratch_host_vcpu()
>> opening of /dev/kvm, KVM_CREATE_VM, KVM_CREATE_VCPU,
>> KVM_ARM_PREFERRED_TARGET, KVM_ARM_VCPU_INIT.
>> In next version I will add an Error handle to
>> kvm_arm_create_scratch_host_vcpu() so that precise error message gets
>> returned.
> Makes sense.
>
> [...]
>


