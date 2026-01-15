Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B206D46638
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 23:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWcQ-0000Zn-Dq; Thu, 15 Jan 2026 18:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgWcO-0000ZD-Bi
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:19:08 -0500
Received: from p-east2-cluster1-host3-snip4-1.eps.apple.com ([57.103.76.4]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgWcK-0004La-IC
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:19:08 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 6CDCE1800165; Thu, 15 Jan 2026 23:19:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768519143; x=1771111143;
 bh=Acu32Lcfw8AvR+Ig/QSkrpjXcuZWfLKDHPwyWf61ERQ=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=DZSEmhWRQJd9ARIHKs4hvta6RPPhnCUyHe8lUWPG/Hhlq5YhLQDkOmhSm0ve4U4TkUjvFv34fukpNBlwGk2wkrcVIoRtNpQ2h/XAECX2/HVAAGV63GQWOGpgAszKxyy8VNjXTET26rQqvhxv33V4BFyKeaVcWClACQsrqO9HecYOOtQJDYZbX8+WeTKOw29M2NUYYugEf0IXP8DEXs8flVDZyLSVqfdm2lP7eorN4RD8xyp7n0K8KhHQLp6zSJaU/6n/RbNEK/uf515CSHKG4sgw0MMbF1iv1G0mWSFGTrnDjKyAObVyi1hGD6GBN+XzIgRcPjhvi0ek+TsHQ7KkkQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 9F432180008D; Thu, 15 Jan 2026 23:18:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <08FA06E5-DAAA-4939-9547-FC51563B48D1@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_0B5C5ECE-8B90-44DF-940E-F4FA51132E6A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v15 14/26] whpx: interrupt controller support
Date: Fri, 16 Jan 2026 00:18:43 +0100
In-Reply-To: <d148dd60-6666-404d-9b18-37975bfac0cf@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
 <20260115001505.57237-15-mohamed@unpredictable.fr>
 <d148dd60-6666-404d-9b18-37975bfac0cf@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info: v=2.4 cv=KrhAGGWN c=1 sm=1 tr=0 ts=696975e6
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=z2a8LLWyoXQ6zlAPQ-0A:9 a=QEXdDO2ut3YA:10
 a=qRJx5fHQmxuhlBqSpHYA:9 a=R4p1XLbCs-2smFIh:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: h_P-gCDn3k8FScg45jzgjCpom8Gk4fJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE4NCBTYWx0ZWRfX6FjEqgEXyy6i
 NiLNyUoxKK3SxrfAOO3e7j2nN0oP61gET7D7RBz3AMDee7ikzhlZvYwM3/uDd6o5EKjSMjYrOtr
 UT14Z5U1dg08Oc0Q9ABl+3FX2CM8fMQcikpG0qf6G3YnKw/R97VfI3HSEVt47A+pAhXOHFHvu1v
 UpiUNy3W4e8zcNsfuilBfKXBa3poi85dp3Ssu84IkAnc8zEyp643anyBUPsMsFjeIt1aI7QMkLV
 pU1XHeh7yKZgzxZKww6D1IZelnjmF40CxYM9Rle2LmfMvT6zjgsEO4OZBWzzU++sWV1L+LERoEK
 0BxTJ9IVcLNwm7/QVjk
X-Proofpoint-ORIG-GUID: h_P-gCDn3k8FScg45jzgjCpom8Gk4fJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601150184
X-JNJ: AAAAAAABOXPd4PmFcgCdMFbVm9AMKhoHT4mJeXXyDigf6UVupqw5qCRjihuVNAwTR/q59/sDILIenep88CFpnSRtgnQWw7TwAncgHqS9xYtV1VezSyu1UDCo3nLLp2q1hYA9e7FuOYDVKSx6eMkwDJ3JeKLmenCRUTlPJTJZxB/o9B51NwfCiIZe3E3+ICB8AyGQECWF/wP+yJYGHvfiUNqv4sBqkMPA7bJD4Us3qLUALRJC84B4UGXtWtYwYYAIXy0zAm3erZ/ksmLTNU4p1EI8lX9zA7mXqf/fOH8eXqy8mGKBzCBsJIYv2MFx8iXI5uUgaMz9f1LQVfDHS3Gti0wxywjZSChNFm/EuXFgNjgEU9nWwKOV+bcswyyXKTUOwDrny3Yd9s6ssjKH7REwvJ1KEzZCnkTr4dvYyAkyu59vq/vGcvlkY3lgJJEt7FU3yzF1apaudmRWNyclsZbx8vgFS+XI0LLMca0kBGP+IAel+a567Y7hmiZATR/Jp1ZsqMTmCLVhtMRZtC8558YsMmRNsP8HhLt3rAQdDEMR6GV+rknegtUE6EvgmNwxPu+sRAWhHp4FYvb2hRQnK/en3rPZRL+FcocoJZhaTeHQe1FQMRfxpbQ52dX73yNBx8RYCOM+7crEz9o2sZN3GdFuJyONxpytWQDX0Mi40nu8s7b4/BQ1iciWmL3KYMm9EH4fRUBbW41+4NDJaQGyd/NaRCplzd0TVqfpWCjUE+zFOpGM3wZa7IxDQiyV7tpsA+oPJM8mJEMJNu2reSsbwRP95UTfm1LxLRhXiN3dNxYl2RSRJrLoZtRp1WJYFaxSMNZjGqACbqIKi+pjoDZb0RBRVrHD7RxyxhOCbfNovnpR6WI7gTy4Eu6UulMA8S9YodvVUkV2dsbXT8nxoIa3nbFTcrqMmIrf2G7lGJVGDU8mZ15QjeBSJGfZKzY3gPBkKnjzpclcSateqcX5OrGAmzInn+Zbh+1C/na
 Mjg==
Received-SPF: pass client-ip=57.103.76.4;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_0B5C5ECE-8B90-44DF-940E-F4FA51132E6A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 15. Jan 2026, at 07:15, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> On 2026/01/15 9:14, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  hw/arm/virt.c                      |   3 +
>>  hw/intc/arm_gicv3_common.c         |   3 +
>>  hw/intc/arm_gicv3_whpx.c           | 239 =
+++++++++++++++++++++++++++++
>>  hw/intc/meson.build                |   1 +
>>  include/hw/intc/arm_gicv3_common.h |   3 +
>>  5 files changed, 249 insertions(+)
>>  create mode 100644 hw/intc/arm_gicv3_whpx.c
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index bc0d54eb7c..b51c97a020 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -49,6 +49,7 @@
>>  #include "system/tcg.h"
>>  #include "system/kvm.h"
>>  #include "system/hvf.h"
>> +#include "system/whpx.h"
>>  #include "system/qtest.h"
>>  #include "system/system.h"
>>  #include "hw/core/loader.h"
>> @@ -2117,6 +2118,8 @@ static void =
finalize_gic_version(VirtMachineState *vms)
>>          /* KVM w/o kernel irqchip can only deal with GICv2 */
>>          gics_supported |=3D VIRT_GIC_VERSION_2_MASK;
>>          accel_name =3D "KVM with kernel-irqchip=3Doff";
>> +    } else if (whpx_enabled()) {
>> +        gics_supported |=3D VIRT_GIC_VERSION_3_MASK;
>>      } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
>>          gics_supported |=3D VIRT_GIC_VERSION_2_MASK;
>>          if (module_object_class_by_name("arm-gicv3")) {
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 0a2e5a3e2f..9054143ea7 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -32,6 +32,7 @@
>>  #include "gicv3_internal.h"
>>  #include "hw/arm/linux-boot-if.h"
>>  #include "system/kvm.h"
>> +#include "system/whpx.h"
>>      static void =
gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
>> @@ -663,6 +664,8 @@ const char *gicv3_class_name(void)
>>  {
>>      if (kvm_irqchip_in_kernel()) {
>>          return "kvm-arm-gicv3";
>> +    } else if (whpx_enabled()) {
>> +        return TYPE_WHPX_GICV3;
>>      } else {
>>          if (kvm_enabled()) {
>>              error_report("Userspace GICv3 is not supported with =
KVM");
>> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
>> new file mode 100644
>> index 0000000000..f34f841a4a
>> --- /dev/null
>> +++ b/hw/intc/arm_gicv3_whpx.c
>> @@ -0,0 +1,239 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * ARM Generic Interrupt Controller using HVF platform support
>> + *
>> + * Copyright (c) 2025 Mohamed Mediouni
>> + * Based on vGICv3 KVM code by Pavel Fedin
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/intc/arm_gicv3_common.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/module.h"
>> +#include "system/runstate.h"
>> +#include "system/whpx.h"
>> +#include "system/whpx-internal.h"
>> +#include "gicv3_internal.h"
>> +#include "vgic_common.h"
>> +#include "qom/object.h"
>> +#include "target/arm/cpregs.h"
>> +
>> +#include "hw/arm/bsa.h"
>> +#include <winhvplatform.h>
>> +#include <winhvplatformdefs.h>
>> +#include <winnt.h>
>> +
>> +struct WHPXARMGICv3Class {
>> +    ARMGICv3CommonClass parent_class;
>> +    DeviceRealize parent_realize;
>> +    ResettablePhases parent_phases;
>> +};
>> +
>> +OBJECT_DECLARE_TYPE(GICv3State, WHPXARMGICv3Class, WHPX_GICV3)
>> +
>> +/* TODO: Implement GIC state save-restore */
>> +static void whpx_gicv3_check(GICv3State *s)
>> +{
>> +}
>> +
>> +static void whpx_gicv3_put(GICv3State *s)
>> +{
>> +    whpx_gicv3_check(s);
>> +}
>> +
>> +static void whpx_gicv3_get(GICv3State *s)
>> +{
>> +}
>> +
>> +static void whpx_gicv3_set_irq(void *opaque, int irq, int level)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +
>> +    GICv3State *s =3D opaque;
>> +    if (irq > s->num_irq) {
>> +        return;
>> +    }
>> +
>> +    WHV_INTERRUPT_CONTROL interrupt_control =3D {
>> +        .InterruptControl.InterruptType =3D =
WHvArm64InterruptTypeFixed,
>> +        .RequestedVector =3D GIC_INTERNAL + irq,
>> +        .InterruptControl.Asserted =3D level
>> +    };
>=20
> This is a mixed declaration prohibited in docs/devel/style.rst
>=20
> Please ensure that mixed declarations are avoided everywhere, not just =
the places I pointed out.
>=20
>> +
>> +    whp_dispatch.WHvRequestInterrupt(whpx->partition, =
&interrupt_control,
>> +         sizeof(interrupt_control));
>> +}
>> +
>> +static void whpx_gicv3_icc_reset(CPUARMState *env, const =
ARMCPRegInfo *ri)
>> +{
>> +    GICv3State *s;
>> +    GICv3CPUState *c;
>> +
>> +    c =3D env->gicv3state;
>> +    s =3D c->gic;
>> +
>> +    c->icc_pmr_el1 =3D 0;
>> +    /*
>> +     * Architecturally the reset value of the ICC_BPR registers
>> +     * is UNKNOWN. We set them all to 0 here; when the kernel
>> +     * uses these values to program the ICH_VMCR_EL2 fields that
>> +     * determine the guest-visible ICC_BPR register values, the
>> +     * hardware's "writing a value less than the minimum sets
>> +     * the field to the minimum value" behaviour will result in
>> +     * them effectively resetting to the correct minimum value
>> +     * for the host GIC.
>> +     */
>> +    c->icc_bpr[GICV3_G0] =3D 0;
>> +    c->icc_bpr[GICV3_G1] =3D 0;
>> +    c->icc_bpr[GICV3_G1NS] =3D 0;
>> +
>> +    c->icc_sre_el1 =3D 0x7;
>> +    memset(c->icc_apr, 0, sizeof(c->icc_apr));
>> +    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
>> +
>> +    if (s->migration_blocker) {
>> +        return;
>> +    }
>> +
>> +    c->icc_ctlr_el1[GICV3_S] =3D c->icc_ctlr_el1[GICV3_NS];
>> +}
>> +
>> +static void whpx_gicv3_reset_hold(Object *obj, ResetType type)
>> +{
>> +    GICv3State *s =3D ARM_GICV3_COMMON(obj);
>> +    WHPXARMGICv3Class *kgc =3D WHPX_GICV3_GET_CLASS(s);
>> +
>> +    if (kgc->parent_phases.hold) {
>> +        kgc->parent_phases.hold(obj, type);
>> +    }
>> +
>> +    whpx_gicv3_put(s);
>> +}
>> +
>> +
>> +/*
>> + * CPU interface registers of GIC needs to be reset on CPU reset.
>> + * For the calling arm_gicv3_icc_reset() on CPU reset, we register
>> + * below ARMCPRegInfo. As we reset the whole cpu interface under =
single
>> + * register reset, we define only one register of CPU interface =
instead
>> + * of defining all the registers.
>> + */
>> +static const ARMCPRegInfo gicv3_cpuif_reginfo[] =3D {
>> +    { .name =3D "ICC_CTLR_EL1", .state =3D ARM_CP_STATE_BOTH,
>> +      .opc0 =3D 3, .opc1 =3D 0, .crn =3D 12, .crm =3D 12, .opc2 =3D =
4,
>> +      /*
>> +       * If ARM_CP_NOP is used, resetfn is not called,
>> +       * So ARM_CP_NO_RAW is appropriate type.
>> +       */
>> +      .type =3D ARM_CP_NO_RAW,
>> +      .access =3D PL1_RW,
>> +      .readfn =3D arm_cp_read_zero,
>> +      .writefn =3D arm_cp_write_ignore,
>> +      /*
>> +       * We hang the whole cpu interface reset routine off here
>> +       * rather than parcelling it out into one little function
>> +       * per register
>> +       */
>> +      .resetfn =3D whpx_gicv3_icc_reset,
>> +    },
>> +};
>> +
>> +static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, =
WHV_REGISTER_VALUE val)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    HRESULT hr;
>> +
>> +    hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, =
cpu->cpu_index,
>> +         &reg, 1, &val);
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to set register %08x, hr=3D%08lx", =
reg, hr);
>> +    }
>> +}
>> +
>> +static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    GICv3State *s =3D WHPX_GICV3(dev);
>> +    WHPXARMGICv3Class *kgc =3D WHPX_GICV3_GET_CLASS(s);
>> +    Error *local_err =3D NULL;
>> +    int i;
>> +
>> +    kgc->parent_realize(dev, &local_err);
>> +    if (local_err) {
>=20
> This is not correct. Citing my comment for v13:
>=20
> > With ERRP_GUARD(), this should be:
> >
> > kgc->parent_realize(dev, errp);
> > if (*errp) {
> >   return;
> > }
> >
> > include/qapi/error.h has an explanation for this.
Hello,

Also going to apply this change to the HVF vGIC code (wrote both of them =
at around the same time=E2=80=A6)

Thank you,
-Mohamed
>> +        return;
>> +    }
>> +
>> +    if (s->revision !=3D 3) {
>> +        error_setg(errp, "unsupported GIC revision %d for platform =
GIC",
>> +                   s->revision);
>> +        return;
>> +    }
>> +
>> +    if (s->security_extn) {
>> +        error_setg(errp, "the platform vGICv3 does not implement the =
"
>> +                   "security extensions");
>> +        return;
>> +    }
>> +
>> +    if (s->nmi_support) {
>> +        error_setg(errp, "NMI is not supported with the platform =
GIC");
>> +        return;
>> +    }
>> +
>> +    if (s->nb_redist_regions > 1) {
>> +        error_setg(errp, "Multiple VGICv3 redistributor regions are =
not "
>> +                   "supported by WHPX");
>> +        error_append_hint(errp, "A maximum of %d VCPUs can be used",
>> +                          s->redist_region_count[0]);
>> +        return;
>> +    }
>> +
>> +    gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, NULL);
>> +
>> +    for (i =3D 0; i < s->num_cpu; i++) {
>> +        CPUState *cpu_state =3D qemu_get_cpu(i);
>> +        ARMCPU *cpu =3D ARM_CPU(cpu_state);
>> +        WHV_REGISTER_VALUE val =3D {.Reg64 =3D 0x080A0000 + =
(GICV3_REDIST_SIZE * i)};
>> +        whpx_set_reg(cpu_state, WHvArm64RegisterGicrBaseGpa, val);
>> +        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>> +    }
>> +
>> +    if (s->maint_irq) {
>> +        error_setg(errp, "Nested virtualisation not currently =
supported by WHPX.");
>> +        return;
>> +    }
>> +}
>> +
>> +static void whpx_gicv3_class_init(ObjectClass *klass, const void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>> +    ARMGICv3CommonClass *agcc =3D ARM_GICV3_COMMON_CLASS(klass);
>> +    WHPXARMGICv3Class *kgc =3D WHPX_GICV3_CLASS(klass);
>> +
>> +    agcc->pre_save =3D whpx_gicv3_get;
>> +    agcc->post_load =3D whpx_gicv3_put;
>> +
>> +    device_class_set_parent_realize(dc, whpx_gicv3_realize,
>> +                                    &kgc->parent_realize);
>> +    resettable_class_set_parent_phases(rc, NULL, =
whpx_gicv3_reset_hold, NULL,
>> +                                       &kgc->parent_phases);
>> +}
>> +
>> +static const TypeInfo whpx_arm_gicv3_info =3D {
>> +    .name =3D TYPE_WHPX_GICV3,
>> +    .parent =3D TYPE_ARM_GICV3_COMMON,
>> +    .instance_size =3D sizeof(GICv3State),
>> +    .class_init =3D whpx_gicv3_class_init,
>> +    .class_size =3D sizeof(WHPXARMGICv3Class),
>> +};
>> +
>> +static void whpx_gicv3_register_types(void)
>> +{
>> +    type_register_static(&whpx_arm_gicv3_info);
>> +}
>> +
>> +type_init(whpx_gicv3_register_types)
>> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
>> index faae20b93d..96742df090 100644
>> --- a/hw/intc/meson.build
>> +++ b/hw/intc/meson.build
>> @@ -41,6 +41,7 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: =
files('apic.c', 'apic_common.c'))
>>  arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: =
files('arm_gicv3_cpuif_common.c'))
>>  arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: =
files('arm_gicv3_cpuif.c'))
>>  specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: =
files('arm_gic_kvm.c'))
>> +specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: =
files('arm_gicv3_whpx.c'))
>>  specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], =
if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>>  arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: =
files('armv7m_nvic.c'))
>>  specific_ss.add(when: 'CONFIG_GRLIB', if_true: =
files('grlib_irqmp.c'))
>> diff --git a/include/hw/intc/arm_gicv3_common.h =
b/include/hw/intc/arm_gicv3_common.h
>> index 3d24ad22d2..c55cf18120 100644
>> --- a/include/hw/intc/arm_gicv3_common.h
>> +++ b/include/hw/intc/arm_gicv3_common.h
>> @@ -313,6 +313,9 @@ typedef struct ARMGICv3CommonClass =
ARMGICv3CommonClass;
>>  DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
>>                       ARM_GICV3_COMMON, TYPE_ARM_GICV3_COMMON)
>>  +/* Types for GICv3 kernel-irqchip */
>> +#define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
>> +
>>  struct ARMGICv3CommonClass {
>>      /*< private >*/
>>      SysBusDeviceClass parent_class;


--Apple-Mail=_0B5C5ECE-8B90-44DF-940E-F4FA51132E6A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 15. Jan 2026, at 07:15, Akihiko Odaki =
&lt;odaki@rsg.ci.i.u-tokyo.ac.jp&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 2026/01/15 9:14, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>Reviewed-by: Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt;<br>---<br>&nbsp;hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 =
+<br>&nbsp;hw/intc/arm_gicv3_common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 =
+<br>&nbsp;hw/intc/arm_gicv3_whpx.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 239 =
+++++++++++++++++++++++++++++<br>&nbsp;hw/intc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>&nbsp;include/hw/intc/arm_gicv3_common.h | &nbsp;&nbsp;3 =
+<br>&nbsp;5 files changed, 249 insertions(+)<br>&nbsp;create mode =
100644 hw/intc/arm_gicv3_whpx.c<br>diff --git a/hw/arm/virt.c =
b/hw/arm/virt.c<br>index bc0d54eb7c..b51c97a020 100644<br>--- =
a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -49,6 +49,7 =
@@<br>&nbsp;#include "system/tcg.h"<br>&nbsp;#include =
"system/kvm.h"<br>&nbsp;#include "system/hvf.h"<br>+#include =
"system/whpx.h"<br>&nbsp;#include "system/qtest.h"<br>&nbsp;#include =
"system/system.h"<br>&nbsp;#include "hw/core/loader.h"<br>@@ -2117,6 =
+2118,8 @@ static void finalize_gic_version(VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* KVM =
w/o kernel irqchip can only deal with GICv2 =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supported=
 |=3D =
VIRT_GIC_VERSION_2_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;accel_name =3D "KVM with kernel-irqchip=3Doff";<br>+ =
&nbsp;&nbsp;&nbsp;} else if (whpx_enabled()) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supported |=3D =
VIRT_GIC_VERSION_3_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else if =
(tcg_enabled() || hvf_enabled() || qtest_enabled()) =
&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gics_supp=
orted |=3D =
VIRT_GIC_VERSION_2_MASK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;if (module_object_class_by_name("arm-gicv3")) {<br>diff --git =
a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c<br>index =
0a2e5a3e2f..9054143ea7 100644<br>--- a/hw/intc/arm_gicv3_common.c<br>+++ =
b/hw/intc/arm_gicv3_common.c<br>@@ -32,6 +32,7 @@<br>&nbsp;#include =
"gicv3_internal.h"<br>&nbsp;#include =
"hw/arm/linux-boot-if.h"<br>&nbsp;#include "system/kvm.h"<br>+#include =
"system/whpx.h"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;static void =
gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)<br>@@ -663,6 =
+664,8 @@ const char =
*gicv3_class_name(void)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(kvm_irqchip_in_kernel()) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
"kvm-arm-gicv3";<br>+ &nbsp;&nbsp;&nbsp;} else if (whpx_enabled()) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
TYPE_WHPX_GICV3;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(kvm_enabled()) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;error_report("Userspace GICv3 is not supported with =
KVM");<br>diff --git a/hw/intc/arm_gicv3_whpx.c =
b/hw/intc/arm_gicv3_whpx.c<br>new file mode 100644<br>index =
0000000000..f34f841a4a<br>--- /dev/null<br>+++ =
b/hw/intc/arm_gicv3_whpx.c<br>@@ -0,0 +1,239 @@<br>+/* =
SPDX-License-Identifier: GPL-2.0-or-later */<br>+/*<br>+ * ARM Generic =
Interrupt Controller using HVF platform support<br>+ *<br>+ * Copyright =
(c) 2025 Mohamed Mediouni<br>+ * Based on vGICv3 KVM code by Pavel =
Fedin<br>+ *<br>+ */<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"qapi/error.h"<br>+#include "hw/intc/arm_gicv3_common.h"<br>+#include =
"qemu/error-report.h"<br>+#include "qemu/module.h"<br>+#include =
"system/runstate.h"<br>+#include "system/whpx.h"<br>+#include =
"system/whpx-internal.h"<br>+#include "gicv3_internal.h"<br>+#include =
"vgic_common.h"<br>+#include "qom/object.h"<br>+#include =
"target/arm/cpregs.h"<br>+<br>+#include "hw/arm/bsa.h"<br>+#include =
&lt;winhvplatform.h&gt;<br>+#include =
&lt;winhvplatformdefs.h&gt;<br>+#include &lt;winnt.h&gt;<br>+<br>+struct =
WHPXARMGICv3Class {<br>+ &nbsp;&nbsp;&nbsp;ARMGICv3CommonClass =
parent_class;<br>+ &nbsp;&nbsp;&nbsp;DeviceRealize parent_realize;<br>+ =
&nbsp;&nbsp;&nbsp;ResettablePhases =
parent_phases;<br>+};<br>+<br>+OBJECT_DECLARE_TYPE(GICv3State, =
WHPXARMGICv3Class, WHPX_GICV3)<br>+<br>+/* TODO: Implement GIC state =
save-restore */<br>+static void whpx_gicv3_check(GICv3State =
*s)<br>+{<br>+}<br>+<br>+static void whpx_gicv3_put(GICv3State =
*s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;whpx_gicv3_check(s);<br>+}<br>+<br>+static void =
whpx_gicv3_get(GICv3State *s)<br>+{<br>+}<br>+<br>+static void =
whpx_gicv3_set_irq(void *opaque, int irq, int level)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+<br>+ &nbsp;&nbsp;&nbsp;GICv3State *s =3D =
opaque;<br>+ &nbsp;&nbsp;&nbsp;if (irq &gt; s-&gt;num_irq) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;WHV_INTERRUPT_CONTROL =
interrupt_control =3D {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.InterruptControl.InterruptType =
=3D WHvArm64InterruptTypeFixed,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.RequestedVector =3D =
GIC_INTERNAL + irq,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.InterruptControl.Asserted =3D =
level<br>+ &nbsp;&nbsp;&nbsp;};<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This is a mixed declaration prohibited in =
docs/devel/style.rst</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Please ensure that mixed declarations are =
avoided everywhere, not just the places I pointed out.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">+<br>+ =
&nbsp;&nbsp;&nbsp;whp_dispatch.WHvRequestInterrupt(whpx-&gt;partition, =
&amp;interrupt_control,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizeof(interrupt_control))=
;<br>+}<br>+<br>+static void whpx_gicv3_icc_reset(CPUARMState *env, =
const ARMCPRegInfo *ri)<br>+{<br>+ &nbsp;&nbsp;&nbsp;GICv3State *s;<br>+ =
&nbsp;&nbsp;&nbsp;GICv3CPUState *c;<br>+<br>+ &nbsp;&nbsp;&nbsp;c =3D =
env-&gt;gicv3state;<br>+ &nbsp;&nbsp;&nbsp;s =3D c-&gt;gic;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_pmr_el1 =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;/*<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* Architecturally the =
reset value of the ICC_BPR registers<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* is =
UNKNOWN. We set them all to 0 here; when the kernel<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* uses these values to program the ICH_VMCR_EL2 =
fields that<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* determine the guest-visible =
ICC_BPR register values, the<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* hardware's =
"writing a value less than the minimum sets<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* the field to the minimum value" behaviour will =
result in<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* them effectively resetting to =
the correct minimum value<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* for the host =
GIC.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G0] =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G1] =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_bpr[GICV3_G1NS] =3D 0;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_sre_el1 =3D 0x7;<br>+ =
&nbsp;&nbsp;&nbsp;memset(c-&gt;icc_apr, 0, sizeof(c-&gt;icc_apr));<br>+ =
&nbsp;&nbsp;&nbsp;memset(c-&gt;icc_igrpen, 0, =
sizeof(c-&gt;icc_igrpen));<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(s-&gt;migration_blocker) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;c-&gt;icc_ctlr_el1[GICV3_S] =3D =
c-&gt;icc_ctlr_el1[GICV3_NS];<br>+}<br>+<br>+static void =
whpx_gicv3_reset_hold(Object *obj, ResetType type)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;GICv3State *s =3D ARM_GICV3_COMMON(obj);<br>+ =
&nbsp;&nbsp;&nbsp;WHPXARMGICv3Class *kgc =3D =
WHPX_GICV3_GET_CLASS(s);<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(kgc-&gt;parent_phases.hold) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kgc-&gt;parent_phases.hold(obj, =
type);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;whpx_gicv3_put(s);<br>+}<br>+<br>+<br>+/*<br>+ * CPU =
interface registers of GIC needs to be reset on CPU reset.<br>+ * For =
the calling arm_gicv3_icc_reset() on CPU reset, we register<br>+ * below =
ARMCPRegInfo. As we reset the whole cpu interface under single<br>+ * =
register reset, we define only one register of CPU interface =
instead<br>+ * of defining all the registers.<br>+ */<br>+static const =
ARMCPRegInfo gicv3_cpuif_reginfo[] =3D {<br>+ &nbsp;&nbsp;&nbsp;{ .name =
=3D "ICC_CTLR_EL1", .state =3D ARM_CP_STATE_BOTH,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.opc0 =3D 3, .opc1 =3D 0, .crn =3D 12, =
.crm =3D 12, .opc2 =3D 4,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* If ARM_CP_NOP is used, resetfn is =
not called,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* So ARM_CP_NO_RAW =
is appropriate type.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.type =3D ARM_CP_NO_RAW,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.access =3D PL1_RW,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.readfn =3D arm_cp_read_zero,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.writefn =3D arm_cp_write_ignore,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* We hang the whole cpu interface =
reset routine off here<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* rather =
than parcelling it out into one little function<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* per register<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.resetfn =3D whpx_gicv3_icc_reset,<br>+ =
&nbsp;&nbsp;&nbsp;},<br>+};<br>+<br>+static void whpx_set_reg(CPUState =
*cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D &amp;whpx_global;<br>+ =
&nbsp;&nbsp;&nbsp;HRESULT hr;<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx-&gt;partition, =
cpu-&gt;cpu_index,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;reg, 1, =
&amp;val);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
set register %08x, hr=3D%08lx", reg, hr);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
whpx_gicv3_realize(DeviceState *dev, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;ERRP_GUARD();<br>+ &nbsp;&nbsp;&nbsp;GICv3State *s =3D =
WHPX_GICV3(dev);<br>+ &nbsp;&nbsp;&nbsp;WHPXARMGICv3Class *kgc =3D =
WHPX_GICV3_GET_CLASS(s);<br>+ &nbsp;&nbsp;&nbsp;Error *local_err =3D =
NULL;<br>+ &nbsp;&nbsp;&nbsp;int i;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;kgc-&gt;parent_realize(dev, &amp;local_err);<br>+ =
&nbsp;&nbsp;&nbsp;if (local_err) {<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This is not correct. Citing my comment for =
v13:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; With ERRP_GUARD(), this should =
be:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt;</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; kgc-&gt;parent_realize(dev, =
errp);</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; if (*errp) {</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; &nbsp;&nbsp;return;</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; }</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt;</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; include/qapi/error.h has an =
explanation for this.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div>Hello,</div><div><br></div>Also going to =
apply this change to the HVF vGIC code (wrote both of them at around the =
same time=E2=80=A6)</div><div><br></div><div>Thank =
you,</div><div>-Mohamed<br><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if (s-&gt;revision !=3D =
3) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, =
"unsupported GIC revision %d for platform GIC",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;revision);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if (s-&gt;security_extn) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "the =
platform vGICv3 does not implement the "<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"security extensions");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if (s-&gt;nmi_support) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "NMI =
is not supported with the platform GIC");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(s-&gt;nb_redist_regions &gt; 1) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "Multiple =
VGICv3 redistributor regions are not "<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"supported by WHPX");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_append_hint(errp, "A =
maximum of %d VCPUs can be used",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;s-&gt;redist_region_count[0]);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, =
NULL);<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; s-&gt;num_cpu; =
i++) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPUState =
*cpu_state =3D qemu_get_cpu(i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ARMCPU *cpu =3D =
ARM_CPU(cpu_state);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE val =3D =
{.Reg64 =3D 0x080A0000 + (GICV3_REDIST_SIZE * i)};<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu_state, =
WHvArm64RegisterGicrBaseGpa, val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;define_arm_cp_regs(cpu, =
gicv3_cpuif_reginfo);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (s-&gt;maint_irq) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "Nested =
virtualisation not currently supported by WHPX.");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
whpx_gicv3_class_init(ObjectClass *klass, const void *data)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;DeviceClass *dc =3D DEVICE_CLASS(klass);<br>+ =
&nbsp;&nbsp;&nbsp;ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>+ =
&nbsp;&nbsp;&nbsp;ARMGICv3CommonClass *agcc =3D =
ARM_GICV3_COMMON_CLASS(klass);<br>+ &nbsp;&nbsp;&nbsp;WHPXARMGICv3Class =
*kgc =3D WHPX_GICV3_CLASS(klass);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;agcc-&gt;pre_save =3D whpx_gicv3_get;<br>+ =
&nbsp;&nbsp;&nbsp;agcc-&gt;post_load =3D whpx_gicv3_put;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;device_class_set_parent_realize(dc, =
whpx_gicv3_realize,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;kgc-&gt=
;parent_realize);<br>+ =
&nbsp;&nbsp;&nbsp;resettable_class_set_parent_phases(rc, NULL, =
whpx_gicv3_reset_hold, NULL,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&amp;kgc-&gt;parent_phases);<br>+}<br>+<br>+static const TypeInfo =
whpx_arm_gicv3_info =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =3D =
TYPE_WHPX_GICV3,<br>+ &nbsp;&nbsp;&nbsp;.parent =3D =
TYPE_ARM_GICV3_COMMON,<br>+ &nbsp;&nbsp;&nbsp;.instance_size =3D =
sizeof(GICv3State),<br>+ &nbsp;&nbsp;&nbsp;.class_init =3D =
whpx_gicv3_class_init,<br>+ &nbsp;&nbsp;&nbsp;.class_size =3D =
sizeof(WHPXARMGICv3Class),<br>+};<br>+<br>+static void =
whpx_gicv3_register_types(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;type_register_static(&amp;whpx_arm_gicv3_info);<br>+}<br=
>+<br>+type_init(whpx_gicv3_register_types)<br>diff --git =
a/hw/intc/meson.build b/hw/intc/meson.build<br>index =
faae20b93d..96742df090 100644<br>--- a/hw/intc/meson.build<br>+++ =
b/hw/intc/meson.build<br>@@ -41,6 +41,7 @@ specific_ss.add(when: =
'CONFIG_APIC', if_true: files('apic.c', =
'apic_common.c'))<br>&nbsp;arm_common_ss.add(when: 'CONFIG_ARM_GIC', =
if_true: =
files('arm_gicv3_cpuif_common.c'))<br>&nbsp;arm_common_ss.add(when: =
'CONFIG_ARM_GICV3', if_true: =
files('arm_gicv3_cpuif.c'))<br>&nbsp;specific_ss.add(when: =
'CONFIG_ARM_GIC_KVM', if_true: =
files('arm_gic_kvm.c'))<br>+specific_ss.add(when: ['CONFIG_WHPX', =
'TARGET_AARCH64'], if_true: =
files('arm_gicv3_whpx.c'))<br>&nbsp;specific_ss.add(when: =
['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: =
files('arm_gicv3_kvm.c', =
'arm_gicv3_its_kvm.c'))<br>&nbsp;arm_common_ss.add(when: =
'CONFIG_ARM_V7M', if_true: =
files('armv7m_nvic.c'))<br>&nbsp;specific_ss.add(when: 'CONFIG_GRLIB', =
if_true: files('grlib_irqmp.c'))<br>diff --git =
a/include/hw/intc/arm_gicv3_common.h =
b/include/hw/intc/arm_gicv3_common.h<br>index 3d24ad22d2..c55cf18120 =
100644<br>--- a/include/hw/intc/arm_gicv3_common.h<br>+++ =
b/include/hw/intc/arm_gicv3_common.h<br>@@ -313,6 +313,9 @@ typedef =
struct ARMGICv3CommonClass =
ARMGICv3CommonClass;<br>&nbsp;DECLARE_OBJ_CHECKERS(GICv3State, =
ARMGICv3CommonClass,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;ARM_GICV3_COMMON, TYPE_ARM_GICV3_COMMON)<br>&nbsp;+/* Types for =
GICv3 kernel-irqchip */<br>+#define TYPE_WHPX_GICV3 =
"whpx-arm-gicv3"<br>+<br>&nbsp;struct ARMGICv3CommonClass =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*&lt; private =
&gt;*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SysBusDeviceClass =
parent_class;</blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_0B5C5ECE-8B90-44DF-940E-F4FA51132E6A--

