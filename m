Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCEDC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYSk-0006Pz-VV; Mon, 10 Feb 2025 13:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1thYSc-0006Of-Ua
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:24:47 -0500
Received: from ma-mx03.apple.com ([17.23.4.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1thYSa-0004Hl-2h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:24:46 -0500
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by st47p01nt-mxp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SRH07JH6CARRK10@st47p01nt-mxp03.apple.com> for
 qemu-devel@nongnu.org; Mon, 10 Feb 2025 18:20:54 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=qMEdyulZfdiP73iCLUpds07W2dQse2Y7pgxfHGbEn0s=;
 b=lQ86fTdE2Xz1V1EkSQwzyXDKhWL/QL5X9fjXtseXP1rmntZGxyAA+PDNrIH4yQDm8mGW
 h+NZnZMG+Dv5CsQ0vxzOAqGJx4w7RcZvITc/QmDxpZMp7ssRkem2ckbp3G94UMSKkTIq
 Cr6goznA9Os16VPNGM9Hqy++JOywz0tmBsjIdp2uZR2rjutc7QF4jkVIWNwEvYHZU13m
 GzqmACj2EBSeAJq07F700NoU7YXjgfI4uLShG3Mx2WtudbrJa2EZgf/M3Ydydb+DXG+k
 zm6V40W7bvK3ykBqPy9qxQF8ZvMpMXb4DKgIFvV0eC1mVI1opsOo/7zSLRNsqamZH80Z Ew==
Received: from mr55p01nt-mmpp04.apple.com
 (mr55p01nt-mmpp04.apple.com [10.170.185.204])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SRH00LM2CAQTAF0@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 10 Feb 2025 10:20:51 -0800 (PST)
Received: from process_milters-daemon.mr55p01nt-mmpp04.apple.com by
 mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SRH2BW00C815300@mr55p01nt-mmpp04.apple.com>; Mon,
 10 Feb 2025 18:20:50 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: c44a9cfa28000692834f9157fcd48a55
X-Va-E-CD: 2325b25e1853304713f33c2dc3bf5831
X-Va-R-CD: f2c730f0a964009da4023b008f6c4c11
X-Va-ID: 6ce190e8-4232-4cea-a369-31dd77f2cc8c
X-Va-CD: 0
X-V-A: 
X-V-T-CD: c44a9cfa28000692834f9157fcd48a55
X-V-E-CD: 2325b25e1853304713f33c2dc3bf5831
X-V-R-CD: f2c730f0a964009da4023b008f6c4c11
X-V-ID: b0fa74e5-afc4-486b-8ed7-0780e2f8b18f
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
Received: from smtpclient.apple (unknown [17.243.208.254])
 by mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SRH2B99MCAPMW00@mr55p01nt-mmpp04.apple.com>; Mon,
 10 Feb 2025 18:20:50 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3815.100.3\))
Subject: Re: [PATCH v2 3/3] hvf: arm: Implement and use
 hvf_get_physical_address_range
From: Danny Canter <danny_canter@apple.com>
In-reply-to: <e67f8106-f741-4e81-a291-db06bfbedd7c@linaro.org>
Date: Mon, 10 Feb 2025 10:20:39 -0800
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>, dirty@apple.com,
 rbolshakov@ddn.com, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com
Content-transfer-encoding: quoted-printable
Message-id: <1CE8C01E-6930-4DFA-8C96-CACCFEBD24AE@apple.com>
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-4-danny_canter@apple.com>
 <e67f8106-f741-4e81-a291-db06bfbedd7c@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3815.100.3)
Received-SPF: pass client-ip=17.23.4.21; envelope-from=danny_canter@apple.com;
 helo=ma-mx03.apple.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Will do. I=E2=80=99ll reach out if I need extra info. The issue appears =
to be closed though, was this fixed/no-repro already though?

-Danny=20

> On Feb 10, 2025, at 9:26=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Danny,
>=20
> On 28/8/24 13:15, Danny Canter wrote:
>> This patch's main focus is to use the previously added
>> hvf_get_physical_address_range to inform VM creation
>> about the IPA size we need for the VM, so we can extend
>> the default 36b IPA size and support VMs with 64+GB of
>> RAM. This is done by freezing the memory map, computing
>> the highest GPA and then (depending on if the platform
>> supports an IPA size that large) telling the kernel to
>> use a size >=3D for the VM. In pursuit of this a couple of
>> things related to how we handle the physical address range
>> we expose to guests were altered, but for an explanation of
>> what we were doing:
>> Today, to get the IPA size we were reading id_aa64mmfr0_el1's
>> PARange field from a newly made vcpu. Unfortunately, HVF just
>> returns the hosts PARange directly for the initial value and
>> not the IPA size that will actually back the VM, so we believe
>> we have much more address space than we actually do today it seems.
>> Starting in macOS 13.0 some APIs were introduced to be able to
>> query the maximum IPA size the kernel supports, and to set the IPA
>> size for a given VM. However, this still has a couple of issues
>> on < macOS 15. Up until macOS 15 (and if the hardware supported
>> it) the max IPA size was 39 bits which is not a valid PARange
>> value, so we can't clamp down what we advertise in the vcpu's
>> id_aa64mmfr0_el1 to our IPA size. Starting in macOS 15 however,
>> the maximum IPA size is 40 bits (if it's supported in the hardware
>> as well) which is also a valid PARange value so we can set our IPA
>> size to the maximum as well as clamp down the PARange we advertise
>> to the guest. This allows VMs with 64+ GB of RAM and should fix the
>> oddness of the PARange situation as well.
>=20
> Could you have a look at the following issue related to your patch?
> https://gitlab.com/qemu-project/qemu/-/issues/2800
>=20
>=20
>> Signed-off-by: Danny Canter <danny_canter@apple.com>
>> ---
>>  accel/hvf/hvf-accel-ops.c | 12 ++++++++-
>>  hw/arm/virt.c             | 31 +++++++++++++++++++++-
>>  target/arm/hvf/hvf.c      | 56 =
++++++++++++++++++++++++++++++++++++++-
>>  target/arm/hvf_arm.h      | 19 +++++++++++++
>>  target/arm/internals.h    | 19 +++++++++++++
>>  target/arm/ptw.c          | 15 +++++++++++
>>  6 files changed, 149 insertions(+), 3 deletions(-)
>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>> index dbebf209f4..d60874d3e6 100644
>> --- a/accel/hvf/hvf-accel-ops.c
>> +++ b/accel/hvf/hvf-accel-ops.c
>> @@ -53,6 +53,7 @@
>>  #include "exec/address-spaces.h"
>>  #include "exec/exec-all.h"
>>  #include "gdbstub/enums.h"
>> +#include "hw/boards.h"
>>  #include "sysemu/cpus.h"
>>  #include "sysemu/hvf.h"
>>  #include "sysemu/hvf_int.h"
>> @@ -319,8 +320,17 @@ static int hvf_accel_init(MachineState *ms)
>>      int x;
>>      hv_return_t ret;
>>      HVFState *s;
>> +    int pa_range =3D 36;
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>>  -    ret =3D hvf_arch_vm_create(ms, 0);
>> +    if (mc->hvf_get_physical_address_range) {
>> +        pa_range =3D mc->hvf_get_physical_address_range(ms);
>> +        if (pa_range < 0) {
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    ret =3D hvf_arch_vm_create(ms, (uint32_t)pa_range);
>>      assert_hvf_ok(ret);
>>        s =3D g_new0(HVFState, 1);
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 62ee5f849b..b39c7924a0 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -66,6 +66,7 @@
>>  #include "hw/intc/arm_gicv3_its_common.h"
>>  #include "hw/irq.h"
>>  #include "kvm_arm.h"
>> +#include "hvf_arm.h"
>>  #include "hw/firmware/smbios.h"
>>  #include "qapi/visitor.h"
>>  #include "qapi/qapi-visit-common.h"
>> @@ -3030,7 +3031,35 @@ static int virt_kvm_type(MachineState *ms, =
const char *type_str)
>>    static int virt_hvf_get_physical_address_range(MachineState *ms)
>>  {
>> -    return 0;
>> +    VirtMachineState *vms =3D VIRT_MACHINE(ms);
>> +
>> +    int default_ipa_size =3D hvf_arm_get_default_ipa_bit_size();
>> +    int max_ipa_size =3D hvf_arm_get_max_ipa_bit_size();
>> +
>> +    /* We freeze the memory map to compute the highest gpa */
>> +    virt_set_memmap(vms, max_ipa_size);
>> +
>> +    int requested_ipa_size =3D 64 - clz64(vms->highest_gpa);
>> +
>> +    /*
>> +     * If we're <=3D the default IPA size just use the default.
>> +     * If we're above the default but below the maximum, round up to
>> +     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
>> +     * returns values that are valid ARM PARange values.
>> +     */
>> +    if (requested_ipa_size <=3D default_ipa_size) {
>> +        requested_ipa_size =3D default_ipa_size;
>> +    } else if (requested_ipa_size <=3D max_ipa_size) {
>> +        requested_ipa_size =3D max_ipa_size;
>> +    } else {
>> +        error_report("-m and ,maxmem option values "
>> +                     "require an IPA range (%d bits) larger than "
>> +                     "the one supported by the host (%d bits)",
>> +                     requested_ipa_size, max_ipa_size);
>> +        return -1;
>> +    }
>> +
>> +    return requested_ipa_size;
>>  }
>>    static void virt_machine_class_init(ObjectClass *oc, void *data)
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 19964d241e..6cea483d42 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -22,6 +22,7 @@
>>  #include <mach/mach_time.h>
>>    #include "exec/address-spaces.h"
>> +#include "hw/boards.h"
>>  #include "hw/irq.h"
>>  #include "qemu/main-loop.h"
>>  #include "sysemu/cpus.h"
>> @@ -297,6 +298,8 @@ void hvf_arm_init_debug(void)
>>    static void hvf_wfi(CPUState *cpu);
>>  +static uint32_t chosen_ipa_bit_size;
>> +
>>  typedef struct HVFVTimer {
>>      /* Vtimer value during migration and paused state */
>>      uint64_t vtimer_val;
>> @@ -839,6 +842,16 @@ static uint64_t hvf_get_reg(CPUState *cpu, int =
rt)
>>      return val;
>>  }
>>  +static void clamp_id_aa64mmfr0_parange_to_ipa_size(uint64_t =
*id_aa64mmfr0)
>> +{
>> +    uint32_t ipa_size =3D chosen_ipa_bit_size ?
>> +            chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
>> +
>> +    /* Clamp down the PARange to the IPA size the kernel supports. =
*/
>> +    uint8_t index =3D round_down_to_parange_index(ipa_size);
>> +    *id_aa64mmfr0 =3D (*id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) =
| index;
>> +}
>> +
>>  static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>  {
>>      ARMISARegisters host_isar =3D {};
>> @@ -882,6 +895,8 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      r |=3D hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, =
&ahcf->midr);
>>      r |=3D hv_vcpu_destroy(fd);
>>  +    =
clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
>> +
>>      ahcf->isar =3D host_isar;
>>        /*
>> @@ -904,6 +919,30 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      return r =3D=3D HV_SUCCESS;
>>  }
>>  +uint32_t hvf_arm_get_default_ipa_bit_size(void)
>> +{
>> +    uint32_t default_ipa_size;
>> +    hv_return_t ret =3D =
hv_vm_config_get_default_ipa_size(&default_ipa_size);
>> +    assert_hvf_ok(ret);
>> +
>> +    return default_ipa_size;
>> +}
>> +
>> +uint32_t hvf_arm_get_max_ipa_bit_size(void)
>> +{
>> +    uint32_t max_ipa_size;
>> +    hv_return_t ret =3D =
hv_vm_config_get_max_ipa_size(&max_ipa_size);
>> +    assert_hvf_ok(ret);
>> +
>> +    /*
>> +     * We clamp any IPA size we want to back the VM with to a valid =
PARange
>> +     * value so the guest doesn't try and map memory outside of the =
valid range.
>> +     * This logic just clamps the passed in IPA bit size to the =
first valid
>> +     * PARange value <=3D to it.
>> +     */
>> +    return round_down_to_parange_bit_size(max_ipa_size);
>> +}
>> +
>>  void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
>>  {
>>      if (!arm_host_cpu_features.dtb_compatible) {
>> @@ -931,8 +970,18 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>>    hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t =
pa_range)
>>  {
>> +    hv_return_t ret;
>>      hv_vm_config_t config =3D hv_vm_config_create();
>> -    hv_return_t ret =3D hv_vm_create(config);
>> +
>> +    ret =3D hv_vm_config_set_ipa_size(config, pa_range);
>> +    if (ret !=3D HV_SUCCESS) {
>> +        goto cleanup;
>> +    }
>> +    chosen_ipa_bit_size =3D pa_range;
>> +
>> +    ret =3D hv_vm_create(config);
>> +
>> +cleanup:
>>      os_release(config);
>>        return ret;
>> @@ -1004,6 +1053,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>                                &arm_cpu->isar.id_aa64mmfr0);
>>      assert_hvf_ok(ret);
>>  +    =
clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar.id_aa64mmfr0);
>> +    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, =
HV_SYS_REG_ID_AA64MMFR0_EL1,
>> +                              arm_cpu->isar.id_aa64mmfr0);
>> +    assert_hvf_ok(ret);
>> +
>>      return 0;
>>  }
>>  diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
>> index e848c1d27d..26c717b382 100644
>> --- a/target/arm/hvf_arm.h
>> +++ b/target/arm/hvf_arm.h
>> @@ -22,4 +22,23 @@ void hvf_arm_init_debug(void);
>>    void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
>>  +#ifdef CONFIG_HVF
>> +
>> +uint32_t hvf_arm_get_default_ipa_bit_size(void);
>> +uint32_t hvf_arm_get_max_ipa_bit_size(void);
>> +
>> +#else
>> +
>> +static inline uint32_t hvf_arm_get_default_ipa_bit_size(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline uint32_t hvf_arm_get_max_ipa_bit_size(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +#endif
>> +
>>  #endif
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 203a2dae14..c5d7b0b492 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -450,6 +450,25 @@ static inline void update_spsel(CPUARMState =
*env, uint32_t imm)
>>   */
>>  unsigned int arm_pamax(ARMCPU *cpu);
>>  +/*
>> + * round_down_to_parange_index
>> + * @bit_size: uint8_t
>> + *
>> + * Rounds down the bit_size supplied to the first supported ARM =
physical
>> + * address range and returns the index for this. The index is =
intended to
>> + * be used to set ID_AA64MMFR0_EL1's PARANGE bits.
>> + */
>> +uint8_t round_down_to_parange_index(uint8_t bit_size);
>> +
>> +/*
>> + * round_down_to_parange_bit_size
>> + * @bit_size: uint8_t
>> + *
>> + * Rounds down the bit_size supplied to the first supported ARM =
physical
>> + * address range bit size and returns this.
>> + */
>> +uint8_t round_down_to_parange_bit_size(uint8_t bit_size);
>> +
>>  /* Return true if extended addresses are enabled.
>>   * This is always the case if our translation regime is 64 bit,
>>   * but depends on TTBCR.EAE for 32 bit.
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 278004661b..defd6b84de 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -96,6 +96,21 @@ static const uint8_t pamax_map[] =3D {
>>      [6] =3D 52,
>>  };
>>  +uint8_t round_down_to_parange_index(uint8_t bit_size)
>> +{
>> +    for (int i =3D ARRAY_SIZE(pamax_map) - 1; i >=3D 0; i--) {
>> +        if (pamax_map[i] <=3D bit_size) {
>> +            return i;
>> +        }
>> +    }
>> +    g_assert_not_reached();
>> +}
>> +
>> +uint8_t round_down_to_parange_bit_size(uint8_t bit_size)
>> +{
>> +    return pamax_map[round_down_to_parange_index(bit_size)];
>> +}
>> +
>>  /*
>>   * The cpu-specific constant value of PAMax; also used by =
hw/arm/virt.
>>   * Note that machvirt_init calls this on a CPU that is inited but =
not realized!
>=20


