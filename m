Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D71CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 11:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYMsG-00044s-06; Sat, 13 Jun 2026 07:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wYMsD-000444-OU
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 07:50:01 -0400
Received: from mr-2005l-snip4-2.eps.apple.com ([57.103.71.15]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wYMsB-0005O0-JN
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 07:50:01 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 816D31800209; Sat, 13 Jun 2026 11:49:54 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjIPTnArD15zXQBMCy8aX3BCDVVxWnRaHzJ8SAQrD1oFMn86AS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1781351395; x=1783943395;
 bh=M4JbZdgIszBviQd60ZM6YwQDrlfpLNK8VKTNX4k72m4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=VayxBA+S8O9gG0FriqFBF4un2UmcEJ2V8RHf4JLfCQgOnFOO/A82KAeXwWnHepEbDKiQLmF4iLif8NIzTEF7n65GpJuRpk52QLt7wJ8rfOb/hbYmDlp5bKFGf6dXAm15zlcjpREnYjaUZUXxd2ViaqO5ydS5AOSzL+wXQ/QyQ/uT1S1GU8UZIQ4Fl3tvmY4nLL/yDxlkXccIzfLqT0nvVSty0mzb1KMjHDAiOGD746kNWYVap3uwVCiz8WfH5JXaCDcbzJCq6P3loSrKD5RYvBYHgGJ2TReyBrH7SDmisbfLoPnfbxVvqkNvGmFVvtmSAPv72Qtag3L9YsUN1+HlZQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 2D2E0180014A; Sat, 13 Jun 2026 11:49:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3891.100.17.1.3\))
Subject: Re: [PULL 15/28] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <a35bb538-541d-487c-b28f-39e265ac80a0@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 13:49:40 +0200
Cc: qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B66CF85A-948B-4B24-B7C1-BE07F817BFB2@unpredictable.fr>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
 <20260501101505.3485916-16-peter.maydell@linaro.org>
 <a35bb538-541d-487c-b28f-39e265ac80a0@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3891.100.17.1.3)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyMCBTYWx0ZWRfX4JSi4i3gKis9
 hO6fyGLOoR7CQtWbA7zJkUmDkZYKTAdhK5WIKtOc6Vm+azyuw3nzDK5/iOwcp3dX/ny7SGIGdZz
 B7hj98C48H+9FSWQn+vjdTWKz+sioJj9rvzI/LS84wd3gYUyaTxRJGC2TWhlBHXtCHoUkUZ9qh7
 +c1HgQCWl2vWiZwgk02gT6W/92dWR1hpH9YDAa1MOz7hKvrKs0Xg4j6zvtrjxjQBTDfJ+w0fGUv
 zG4NcLBgwOtbTpgx83598mPygBdKZKDn7PRGfbVKC1rWCRnk8fvO1I6YtWQ6AuwCVoSPzEB97jQ
 8OMt0q+lLofQxTA2k/v
X-Proofpoint-GUID: jFfBnyRAoAXRlNkBB6BS_seYHdHM_q0P
X-Proofpoint-ORIG-GUID: jFfBnyRAoAXRlNkBB6BS_seYHdHM_q0P
Received-SPF: pass client-ip=57.103.71.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 13. Jun 2026, at 13:45, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> Hi Mohamed,
>=20
> On 1/5/26 12:14, Peter Maydell wrote:
>> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>> On HVF, some of the GIC state is in an opaque Apple-provided =
structure.
>> Save/restore that state to be able to save/restore VMs that use the =
hardware GIC.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Message-id: 20260429190532.26538-3-mohamed@unpredictable.fr
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/intc/arm_gicv3_common.c         |  1 +
>>  hw/intc/arm_gicv3_hvf.c            | 94 =
++++++++++++++++++++++++++++--
>>  hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
>>  hw/intc/meson.build                |  1 +
>>  include/hw/intc/arm_gicv3_common.h |  3 +
>>  5 files changed, 120 insertions(+), 4 deletions(-)
>>  create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
>=20
>=20
>> diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
>> index 22f19d274d..ae881092ea 100644
>> --- a/hw/intc/arm_gicv3_hvf.c
>> +++ b/hw/intc/arm_gicv3_hvf.c
>> @@ -13,6 +13,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/module.h"
>>  #include "system/runstate.h"
>> +#include "migration/vmstate.h"
>>  #include "system/hvf.h"
>>  #include "system/hvf_int.h"
>>  #include "hvf_arm.h"
>> @@ -37,8 +38,13 @@ struct HVFARMGICv3Class {
>>    typedef struct HVFARMGICv3Class HVFARMGICv3Class;
>>  -/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON =
*/
>> -DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
>> +typedef struct HVFGICv3State {
>> +    GICv3State parent_obj;
>> +    uint32_t size;
>> +    void *state;
>> +} HVFGICv3State;
>> +
>> +DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
>>                       HVF_GICV3, TYPE_HVF_GICV3);
>>    /*
>> @@ -668,7 +674,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] =3D=
 {
>>  static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
>>  {
>>      ERRP_GUARD();
>> -    GICv3State *s =3D HVF_GICV3(dev);
>> +    GICv3State *s =3D (GICv3State *)HVF_GICV3(dev);
>>      HVFARMGICv3Class *kgc =3D HVF_GICV3_GET_CLASS(s);
>>      int i;
>>  @@ -715,6 +721,86 @@ static void hvf_gicv3_realize(DeviceState *dev, =
Error **errp)
>>      }
>>  }
>>  +/*
>> + * HVF doesn't have a way to save the RDIST pending tables
>> + * to guest memory, only to an opaque data structure.
>> + */
>> +static bool gicv3_is_hvf(void *opaque)
>> +{
>> +    return hvf_enabled() && hvf_irqchip_in_kernel();
>> +}
> Unfortunately this commit (48396ad6ce9) breaks bisection:
>=20
> ../../hw/intc/arm_gicv3_hvf.c:730:29: error: call to undeclared =
function 'hvf_irqchip_in_kernel'; ISO C99 and later do not support =
implicit function declarations [-Wimplicit-function-declaration]
>  730 |     return hvf_enabled() && hvf_irqchip_in_kernel();
>      |                             ^
> 1 error generated.

Hi,

My mistake. Will try to see in which rev of the patchset I intro=E2=80=99d=
 this one=E2=80=A6
and will see how to avoid it going forward...

On a side note, two bugs affecting HVF right now:

- looks like on M1 there=E2=80=99s an issue affecting detecting 36-bit =
PAs

think that bug was intro=E2=80=99d by me but will have to look more into =
it

- and qemu master is broken rn with HVF (and there=E2=80=99s an unmerged =
patch for
that)

>=20
> The method is declared / defined in the following commit =
(2a3c965516f).
>=20
> Please be careful to avoid that in future to avoid manual operations.
>=20
> Regards,
>=20
> Phil.



