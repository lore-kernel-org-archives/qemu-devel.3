Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E5ED4A5FB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 04:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgbWX-0004ui-Ar; Thu, 15 Jan 2026 23:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgbWS-0004pw-Vo; Thu, 15 Jan 2026 23:33:21 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgbWN-0001Xy-HA; Thu, 15 Jan 2026 23:33:20 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60G4VWHe004570
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 16 Jan 2026 13:32:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iCN2Zgfq0CIMP2y3+ZI1rL/kDnygavz6LTyv0leM9AQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768537922; v=1;
 b=quNbsY+ykShyyK0w/RET1N+s9UV8qy+dNwuU2+ecOfQRFTitd79zHYtVSVowC1Fm
 kxYKt/wu0I9wbblQt17sv2Ut/GZMfCE4U3IhBDHw3M5SCPU1/P8PrmaV3wkAOc3j
 +35g5kbaZkTgALuHKJOauWm2pYo/XHo5vh2ajhA9MFdD/0Klin4EjlMBtcykdS5q
 +idXMauqtAcyTFBHhABRrbl9px9/0XeOU5q9pE9mgXFdQ9iKW+2qTZniyBZ4k6kD
 FLTnX0OMcsxbTALLmjuLmDG8UPPdyoPwRwGKSfJUyOMZUTrjBMD03hppIC0IwdgZ
 JIBQRvOigMdHhjmaGX1pHQ==
Message-ID: <21a657b0-b37f-4b3f-aecf-2012a25a9674@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 16 Jan 2026 13:31:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/26] whpx: add arm64 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Xu <peterx@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
 <20260115001505.57237-16-mohamed@unpredictable.fr>
 <696b6da1-08b8-4121-aa5b-f18861b10c2e@rsg.ci.i.u-tokyo.ac.jp>
 <3A97241E-F8F2-4699-A20F-1B3B6574128B@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3A97241E-F8F2-4699-A20F-1B3B6574128B@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/16 8:15, Mohamed Mediouni wrote:
> 
> 
>> On 15. Jan 2026, at 07:18, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/01/15 9:14, Mohamed Mediouni wrote:
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   accel/whpx/whpx-common.c    |   1 +
>>>   target/arm/meson.build      |   1 +
>>>   target/arm/whpx/meson.build |   3 +
>>>   target/arm/whpx/whpx-all.c  | 815 ++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 820 insertions(+)
>>>   create mode 100644 target/arm/whpx/meson.build
>>>   create mode 100644 target/arm/whpx/whpx-all.c
>>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>>> index 05f9e520b7..827f50f3e0 100644
>>> --- a/accel/whpx/whpx-common.c
>>> +++ b/accel/whpx/whpx-common.c
>>> @@ -12,6 +12,7 @@
>>>   #include "gdbstub/helpers.h"
>>>   #include "qemu/accel.h"
>>>   #include "accel/accel-ops.h"
>>> +#include "system/memory.h"
>>>   #include "system/whpx.h"
>>>   #include "system/cpus.h"
>>>   #include "system/runstate.h"
>>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>>> index 462c71148d..ce155ba9b4 100644
>>> --- a/target/arm/meson.build
>>> +++ b/target/arm/meson.build
>>> @@ -59,6 +59,7 @@ arm_common_system_ss.add(files(
>>>   ))
>>>     subdir('hvf')
>>> +subdir('whpx')
>>>     if 'CONFIG_TCG' in config_all_accel
>>>      subdir('tcg')
>>> diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
>>> new file mode 100644
>>> index 0000000000..1de2ef0283
>>> --- /dev/null
>>> +++ b/target/arm/whpx/meson.build
>>> @@ -0,0 +1,3 @@
>>> +arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>>> +  'whpx-all.c',
>>> +))
>>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>>> new file mode 100644
>>> index 0000000000..62fda15597
>>> --- /dev/null
>>> +++ b/target/arm/whpx/whpx-all.c
>>> @@ -0,0 +1,815 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * QEMU Windows Hypervisor Platform accelerator (WHPX)
>>> + *
>>> + * Copyright (c) 2025 Mohamed Mediouni
>>> + *
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "cpu.h"
>>> +#include "system/address-spaces.h"
>>> +#include "system/ioport.h"
>>> +#include "gdbstub/helpers.h"
>>> +#include "qemu/accel.h"
>>> +#include "accel/accel-ops.h"
>>> +#include "system/whpx.h"
>>> +#include "system/cpus.h"
>>> +#include "system/runstate.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "hw/core/boards.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/qapi-types-common.h"
>>> +#include "qapi/qapi-visit-common.h"
>>> +#include "migration/blocker.h"
>>> +#include "accel/accel-cpu-target.h"
>>> +#include <winerror.h>
>>> +
>>> +#include "syndrome.h"
>>> +#include "cpu.h"
>>> +#include "target/arm/cpregs.h"
>>> +#include "internals.h"
>>> +
>>> +#include "system/whpx-internal.h"
>>> +#include "system/whpx-accel-ops.h"
>>> +#include "system/whpx-all.h"
>>> +#include "system/whpx-common.h"
>>> +#include "hw/arm/bsa.h"
>>> +#include "arm-powerctl.h"
>>> +
>>> +#include <winhvplatform.h>
>>> +#include <winhvplatformdefs.h>
>>> +
>>> +struct whpx_reg_match {
>>> +    WHV_REGISTER_NAME reg;
>>> +    uint64_t offset;
>>> +};
>>
>> As per docs/devel/style.rst, this should be:
>>
>> typedef struct WHPXRegMatch {
>>     WHV_REGISTER_NAME reg;
>>     uint64_t offset;
>> } WHPXRegMatch;
>>
> Hello,
> 
> Applied the change to this for the next rev. Do you have tips on how to automate this

Sorry but no, I don't have any useful tips for automation.

There are tools like scripts/checkpatch.pl, Coccinelle, clang-format, 
clang-tidy, and LLMs (docs/devel/code-provenance.rst allows LLMs for 
static analysis though including AI generated content in a patch is 
forbidden).

The problem is that these tools are not wired up properly to enforce 
docs/devel/style.rst in a comprehensive manner. You can still hack these 
tools to check this and other rules, but my experience shows that you 
will still need to see if these tools correctly function, and simply 
manually auditing the code is easier than that.

> (inherited this from the HVF code style as are a lot of your other reviews in this series really)

Unfortunately, the rules described in docs/devel/style.rst, 
include/qemu/error-report.h, and other documentations are often not 
followed by the existing code.

Automation is really needed for proper enforcement as you suggested, 
but, for now, I think the best course we can take is to try to enforce 
them manually for new code to prevent normalization of deviance.

It will be nice if you clean up existing code (e.g., HVF), but I won't 
require that; if the new code is fine and not so diverged from existing 
code that it makes the code hard to understand, I will give my Reviewed-by.

Regards,
Akihiko Odaki

> 
> Thank you,
> -Mohamed
>>> +
>>> +static const struct whpx_reg_match whpx_reg_match[] = {
>>> +    { WHvArm64RegisterX0,   offsetof(CPUARMState, xregs[0]) },
>>> +    { WHvArm64RegisterX1,   offsetof(CPUARMState, xregs[1]) },
>>> +    { WHvArm64RegisterX2,   offsetof(CPUARMState, xregs[2]) },
>>> +    { WHvArm64RegisterX3,   offsetof(CPUARMState, xregs[3]) },
>>> +    { WHvArm64RegisterX4,   offsetof(CPUARMState, xregs[4]) },
>>> +    { WHvArm64RegisterX5,   offsetof(CPUARMState, xregs[5]) },
>>> +    { WHvArm64RegisterX6,   offsetof(CPUARMState, xregs[6]) },
>>> +    { WHvArm64RegisterX7,   offsetof(CPUARMState, xregs[7]) },
>>> +    { WHvArm64RegisterX8,   offsetof(CPUARMState, xregs[8]) },
>>> +    { WHvArm64RegisterX9,   offsetof(CPUARMState, xregs[9]) },
>>> +    { WHvArm64RegisterX10,  offsetof(CPUARMState, xregs[10]) },
>>> +    { WHvArm64RegisterX11,  offsetof(CPUARMState, xregs[11]) },
>>> +    { WHvArm64RegisterX12,  offsetof(CPUARMState, xregs[12]) },
>>> +    { WHvArm64RegisterX13,  offsetof(CPUARMState, xregs[13]) },
>>> +    { WHvArm64RegisterX14,  offsetof(CPUARMState, xregs[14]) },
>>> +    { WHvArm64RegisterX15,  offsetof(CPUARMState, xregs[15]) },
>>> +    { WHvArm64RegisterX16,  offsetof(CPUARMState, xregs[16]) },
>>> +    { WHvArm64RegisterX17,  offsetof(CPUARMState, xregs[17]) },
>>> +    { WHvArm64RegisterX18,  offsetof(CPUARMState, xregs[18]) },
>>> +    { WHvArm64RegisterX19,  offsetof(CPUARMState, xregs[19]) },
>>> +    { WHvArm64RegisterX20,  offsetof(CPUARMState, xregs[20]) },
>>> +    { WHvArm64RegisterX21,  offsetof(CPUARMState, xregs[21]) },
>>> +    { WHvArm64RegisterX22,  offsetof(CPUARMState, xregs[22]) },
>>> +    { WHvArm64RegisterX23,  offsetof(CPUARMState, xregs[23]) },
>>> +    { WHvArm64RegisterX24,  offsetof(CPUARMState, xregs[24]) },
>>> +    { WHvArm64RegisterX25,  offsetof(CPUARMState, xregs[25]) },
>>> +    { WHvArm64RegisterX26,  offsetof(CPUARMState, xregs[26]) },
>>> +    { WHvArm64RegisterX27,  offsetof(CPUARMState, xregs[27]) },
>>> +    { WHvArm64RegisterX28,  offsetof(CPUARMState, xregs[28]) },
>>> +    { WHvArm64RegisterFp,   offsetof(CPUARMState, xregs[29]) },
>>> +    { WHvArm64RegisterLr,   offsetof(CPUARMState, xregs[30]) },
>>> +    { WHvArm64RegisterPc,   offsetof(CPUARMState, pc) },
>>> +};
>>> +
>>> +static const struct whpx_reg_match whpx_fpreg_match[] = {
>>> +    { WHvArm64RegisterQ0,  offsetof(CPUARMState, vfp.zregs[0]) },
>>> +    { WHvArm64RegisterQ1,  offsetof(CPUARMState, vfp.zregs[1]) },
>>> +    { WHvArm64RegisterQ2,  offsetof(CPUARMState, vfp.zregs[2]) },
>>> +    { WHvArm64RegisterQ3,  offsetof(CPUARMState, vfp.zregs[3]) },
>>> +    { WHvArm64RegisterQ4,  offsetof(CPUARMState, vfp.zregs[4]) },
>>> +    { WHvArm64RegisterQ5,  offsetof(CPUARMState, vfp.zregs[5]) },
>>> +    { WHvArm64RegisterQ6,  offsetof(CPUARMState, vfp.zregs[6]) },
>>> +    { WHvArm64RegisterQ7,  offsetof(CPUARMState, vfp.zregs[7]) },
>>> +    { WHvArm64RegisterQ8,  offsetof(CPUARMState, vfp.zregs[8]) },
>>> +    { WHvArm64RegisterQ9,  offsetof(CPUARMState, vfp.zregs[9]) },
>>> +    { WHvArm64RegisterQ10, offsetof(CPUARMState, vfp.zregs[10]) },
>>> +    { WHvArm64RegisterQ11, offsetof(CPUARMState, vfp.zregs[11]) },
>>> +    { WHvArm64RegisterQ12, offsetof(CPUARMState, vfp.zregs[12]) },
>>> +    { WHvArm64RegisterQ13, offsetof(CPUARMState, vfp.zregs[13]) },
>>> +    { WHvArm64RegisterQ14, offsetof(CPUARMState, vfp.zregs[14]) },
>>> +    { WHvArm64RegisterQ15, offsetof(CPUARMState, vfp.zregs[15]) },
>>> +    { WHvArm64RegisterQ16, offsetof(CPUARMState, vfp.zregs[16]) },
>>> +    { WHvArm64RegisterQ17, offsetof(CPUARMState, vfp.zregs[17]) },
>>> +    { WHvArm64RegisterQ18, offsetof(CPUARMState, vfp.zregs[18]) },
>>> +    { WHvArm64RegisterQ19, offsetof(CPUARMState, vfp.zregs[19]) },
>>> +    { WHvArm64RegisterQ20, offsetof(CPUARMState, vfp.zregs[20]) },
>>> +    { WHvArm64RegisterQ21, offsetof(CPUARMState, vfp.zregs[21]) },
>>> +    { WHvArm64RegisterQ22, offsetof(CPUARMState, vfp.zregs[22]) },
>>> +    { WHvArm64RegisterQ23, offsetof(CPUARMState, vfp.zregs[23]) },
>>> +    { WHvArm64RegisterQ24, offsetof(CPUARMState, vfp.zregs[24]) },
>>> +    { WHvArm64RegisterQ25, offsetof(CPUARMState, vfp.zregs[25]) },
>>> +    { WHvArm64RegisterQ26, offsetof(CPUARMState, vfp.zregs[26]) },
>>> +    { WHvArm64RegisterQ27, offsetof(CPUARMState, vfp.zregs[27]) },
>>> +    { WHvArm64RegisterQ28, offsetof(CPUARMState, vfp.zregs[28]) },
>>> +    { WHvArm64RegisterQ29, offsetof(CPUARMState, vfp.zregs[29]) },
>>> +    { WHvArm64RegisterQ30, offsetof(CPUARMState, vfp.zregs[30]) },
>>> +    { WHvArm64RegisterQ31, offsetof(CPUARMState, vfp.zregs[31]) },
>>> +};
>>> +
>>> +struct whpx_sreg_match {
>>> +    WHV_REGISTER_NAME reg;
>>> +    uint32_t key;
>>> +    bool global;
>>> +    uint32_t cp_idx;
>>> +};
>>> +
>>> +static struct whpx_sreg_match whpx_sreg_match[] = {
>>> +    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
>>> +
>>> +    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
>>> +#ifdef SYNC_NO_RAW_REGS
>>> +    /*
>>> +     * The registers below are manually synced on init because they are
>>> +     * marked as NO_RAW. We still list them to make number space sync easier.
>>> +     */
>>> +    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
>>> +    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
>>> +#endif
>>> +    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
>>> +    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
>>> +    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
>>> +    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true },
>>> +    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true },
>>> +#ifdef SYNC_NO_MMFR0
>>> +    /* We keep the hardware MMFR0 around. HW limits are there anyway */
>>> +    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
>>> +#endif
>>> +    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
>>> +    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
>>> +    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
>>> +
>>> +    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
>>> +    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
>>> +    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
>>> +    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
>>> +
>>> +    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
>>> +    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
>>> +    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
>>> +    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
>>> +    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
>>> +    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
>>> +    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
>>> +    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
>>> +    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
>>> +    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
>>> +
>>> +    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
>>> +    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
>>> +    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
>>> +    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
>>> +    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
>>> +    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
>>> +    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
>>> +    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
>>> +    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
>>> +    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
>>> +    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
>>> +    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
>>> +    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
>>> +    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
>>> +};
>>> +
>>> +static void flush_cpu_state(CPUState *cpu)
>>> +{
>>> +    if (cpu->vcpu_dirty) {
>>> +        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>>> +        cpu->vcpu_dirty = false;
>>> +    }
>>> +}
>>> +
>>> +HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
>>> +{
>>> +    if (exceptions != 0) {
>>> +        return E_NOTIMPL;
>>> +    }
>>> +    return ERROR_SUCCESS;
>>> +}
>>> +void whpx_apply_breakpoints(
>>> +    struct whpx_breakpoint_collection *breakpoints,
>>> +    CPUState *cpu,
>>> +    bool resuming)
>>> +{
>>> +
>>> +}
>>> +void whpx_translate_cpu_breakpoints(
>>> +    struct whpx_breakpoints *breakpoints,
>>> +    CPUState *cpu,
>>> +    int cpu_breakpoint_count)
>>> +{
>>> +
>>> +}
>>> +
>>> +static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
>>> +{
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    HRESULT hr;
>>> +
>>> +    flush_cpu_state(cpu);
>>> +
>>> +    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
>>> +         &reg, 1, val);
>>> +
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
>>> +    }
>>> +}
>>> +
>>> +static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
>>> +{
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    HRESULT hr;
>>> +    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
>>> +         &reg, 1, &val);
>>> +
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
>>> +    }
>>> +}
>>> +
>>> +static void whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE *val)
>>> +{
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    HRESULT hr;
>>> +
>>> +    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, WHV_ANY_VP,
>>> +         &reg, 1, val);
>>> +
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
>>> +    }
>>> +}
>>> +
>>> +static void whpx_set_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
>>> +{
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    HRESULT hr;
>>> +    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, WHV_ANY_VP,
>>> +         &reg, 1, &val);
>>> +
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
>>> +    }
>>> +}
>>> +
>>> +static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
>>> +{
>>> +    assert(rt <= 31);
>>> +    if (rt == 31) {
>>> +        return 0;
>>> +    }
>>> +    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
>>> +    WHV_REGISTER_VALUE val;
>>> +    whpx_get_reg(cpu, reg, &val);
>>> +
>>> +    return val.Reg64;
>>> +}
>>> +
>>> +static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
>>> +{
>>> +    assert(rt < 31);
>>> +    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
>>> +    WHV_REGISTER_VALUE reg_val = {.Reg64 = val};
>>> +
>>> +    whpx_set_reg(cpu, reg, reg_val);
>>> +}
>>> +
>>> +static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
>>> +{
>>> +    uint64_t syndrome = ctx->Syndrome;
>>> +
>>> +    bool isv = syndrome & ARM_EL_ISV;
>>> +    bool iswrite = (syndrome >> 6) & 1;
>>> +    bool sse = (syndrome >> 21) & 1;
>>> +    uint32_t sas = (syndrome >> 22) & 3;
>>> +    uint32_t len = 1 << sas;
>>> +    uint32_t srt = (syndrome >> 16) & 0x1f;
>>> +    uint32_t cm = (syndrome >> 8) & 0x1;
>>> +    uint64_t val = 0;
>>> +
>>> +    assert(!cm);
>>> +    assert(isv);
>>> +
>>> +    if (iswrite) {
>>> +        val = whpx_get_gp_reg(cpu, srt);
>>> +        address_space_write(&address_space_memory,
>>> +                            ctx->Gpa,
>>> +                            MEMTXATTRS_UNSPECIFIED, &val, len);
>>> +    } else {
>>> +        address_space_read(&address_space_memory,
>>> +                           ctx->Gpa,
>>> +                           MEMTXATTRS_UNSPECIFIED, &val, len);
>>> +        if (sse) {
>>> +            val = sextract64(val, 0, len * 8);
>>> +        }
>>> +        whpx_set_gp_reg(cpu, srt, val);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void whpx_psci_cpu_off(ARMCPU *arm_cpu)
>>> +{
>>> +    int32_t ret = arm_set_cpu_off(arm_cpu_mp_affinity(arm_cpu));
>>> +    assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
>>> +}
>>> +
>>> +int whpx_vcpu_run(CPUState *cpu)
>>> +{
>>> +    HRESULT hr;
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>>> +    AccelCPUState *vcpu = cpu->accel;
>>> +    int ret;
>>> +
>>> +
>>> +    g_assert(bql_locked());
>>> +
>>> +    if (whpx->running_cpus++ == 0) {
>>> +        ret = whpx_first_vcpu_starting(cpu);
>>> +        if (ret != 0) {
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    bql_unlock();
>>> +
>>> +
>>> +    cpu_exec_start(cpu);
>>> +    do {
>>> +        bool advance_pc = false;
>>> +        if (cpu->vcpu_dirty) {
>>> +            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>>> +            cpu->vcpu_dirty = false;
>>> +        }
>>> +
>>> +        if (qatomic_read(&cpu->exit_request)) {
>>> +            whpx_vcpu_kick(cpu);
>>> +        }
>>> +
>>> +        hr = whp_dispatch.WHvRunVirtualProcessor(
>>> +            whpx->partition, cpu->cpu_index,
>>> +            &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
>>> +
>>> +        if (FAILED(hr)) {
>>> +            error_report("WHPX: Failed to exec a virtual processor,"
>>> +                         " hr=%08lx", hr);
>>> +            ret = -1;
>>> +            break;
>>> +        }
>>> +
>>> +        switch (vcpu->exit_ctx.ExitReason) {
>>> +        case WHvRunVpExitReasonGpaIntercept:
>>> +        case WHvRunVpExitReasonUnmappedGpa:
>>> +            advance_pc = true;
>>> +
>>> +            if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
>>> +                error_report("WHPX: cached access to unmapped memory"
>>> +                "Pc = 0x%llx Gva = 0x%llx Gpa = 0x%llx",
>>> +                vcpu->exit_ctx.MemoryAccess.Header.Pc,
>>> +                vcpu->exit_ctx.MemoryAccess.Gpa,
>>> +                vcpu->exit_ctx.MemoryAccess.Gva);
>>> +                break;
>>> +            }
>>> +
>>> +            ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
>>> +            break;
>>> +        case WHvRunVpExitReasonCanceled:
>>> +            cpu->exception_index = EXCP_INTERRUPT;
>>> +            ret = 1;
>>> +            break;
>>> +        case WHvRunVpExitReasonArm64Reset:
>>> +            switch (vcpu->exit_ctx.Arm64Reset.ResetType) {
>>> +            case WHvArm64ResetTypePowerOff:
>>> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>> +                break;
>>> +            case WHvArm64ResetTypeReboot:
>>> +                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>>> +                break;
>>> +            default:
>>> +                g_assert_not_reached();
>>> +            }
>>> +            bql_lock();
>>> +            if (arm_cpu->power_state != PSCI_OFF) {
>>> +                whpx_psci_cpu_off(arm_cpu);
>>> +            }
>>> +            bql_unlock();
>>> +            break;
>>> +        case WHvRunVpExitReasonNone:
>>> +        case WHvRunVpExitReasonUnrecoverableException:
>>> +        case WHvRunVpExitReasonInvalidVpRegisterValue:
>>> +        case WHvRunVpExitReasonUnsupportedFeature:
>>> +        default:
>>> +            error_report("WHPX: Unexpected VP exit code 0x%08x",
>>> +                         vcpu->exit_ctx.ExitReason);
>>> +            whpx_get_registers(cpu);
>>> +            bql_lock();
>>> +            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>>> +            bql_unlock();
>>> +            break;
>>> +        }
>>> +        if (advance_pc) {
>>> +            WHV_REGISTER_VALUE pc;
>>> +
>>> +            flush_cpu_state(cpu);
>>> +            pc.Reg64 = vcpu->exit_ctx.MemoryAccess.Header.Pc + 4;
>>> +            whpx_set_reg(cpu, WHvArm64RegisterPc, pc);
>>> +        }
>>> +    } while (!ret);
>>> +
>>> +    cpu_exec_end(cpu);
>>> +
>>> +    bql_lock();
>>> +    current_cpu = cpu;
>>> +
>>> +    if (--whpx->running_cpus == 0) {
>>> +        whpx_last_vcpu_stopping(cpu);
>>> +    }
>>> +
>>> +    qatomic_set(&cpu->exit_request, false);
>>> +
>>> +    return ret < 0;
>>> +}
>>> +
>>> +static void clean_whv_register_value(WHV_REGISTER_VALUE *val)
>>> +{
>>> +    memset(val, 0, sizeof(WHV_REGISTER_VALUE));
>>> +}
>>> +
>>> +void whpx_get_registers(CPUState *cpu)
>>> +{
>>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>>> +    CPUARMState *env = &arm_cpu->env;
>>> +    WHV_REGISTER_VALUE val;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
>>> +        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
>>> +        *(uint64_t *)((char *)env + whpx_reg_match[i].offset) = val.Reg64;
>>> +    }
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
>>> +        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
>>> +        memcpy((char *)env + whpx_fpreg_match[i].offset, &val, sizeof(val.Reg128));
>>> +    }
>>> +
>>> +    whpx_get_reg(cpu, WHvArm64RegisterPc, &val);
>>> +    env->pc = val.Reg64;
>>> +
>>> +    whpx_get_reg(cpu, WHvArm64RegisterFpcr, &val);
>>> +    vfp_set_fpcr(env, val.Reg32);
>>> +
>>> +    whpx_get_reg(cpu, WHvArm64RegisterFpsr, &val);
>>> +    vfp_set_fpsr(env, val.Reg32);
>>> +
>>> +    whpx_get_reg(cpu, WHvArm64RegisterPstate, &val);
>>> +    pstate_write(env, val.Reg32);
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
>>> +        if (whpx_sreg_match[i].cp_idx == -1) {
>>> +            continue;
>>> +        }
>>> +
>>> +        if (whpx_sreg_match[i].global) {
>>> +            /* WHP disallows us from accessing global regs as a vCPU */
>>> +            whpx_get_global_reg(whpx_sreg_match[i].reg, &val);
>>> +        } else {
>>> +            whpx_get_reg(cpu, whpx_sreg_match[i].reg, &val);
>>> +        }
>>> +        arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx] = val.Reg64;
>>> +    }
>>> +
>>> +    assert(write_list_to_cpustate(arm_cpu));
>>> +    aarch64_restore_sp(env, arm_current_el(env));
>>> +}
>>> +
>>> +void whpx_set_registers(CPUState *cpu, int level)
>>> +{
>>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>>> +    CPUARMState *env = &arm_cpu->env;
>>> +    WHV_REGISTER_VALUE val;
>>> +    clean_whv_register_value(&val);
>>> +    int i;
>>> +
>>> +    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
>>> +        val.Reg64 = *(uint64_t *)((char *)env + whpx_reg_match[i].offset);
>>> +        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
>>> +    }
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
>>> +        memcpy(&val.Reg128, (char *)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));
>>> +        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
>>> +    }
>>> +
>>> +    clean_whv_register_value(&val);
>>> +    val.Reg64 = env->pc;
>>> +    whpx_set_reg(cpu, WHvArm64RegisterPc, val);
>>> +
>>> +    clean_whv_register_value(&val);
>>> +    val.Reg32 = vfp_get_fpcr(env);
>>> +    whpx_set_reg(cpu, WHvArm64RegisterFpcr, val);
>>> +    val.Reg32 = vfp_get_fpsr(env);
>>> +    whpx_set_reg(cpu, WHvArm64RegisterFpsr, val);
>>> +    val.Reg32 = pstate_read(env);
>>> +    whpx_set_reg(cpu, WHvArm64RegisterPstate, val);
>>> +
>>> +    aarch64_save_sp(env, arm_current_el(env));
>>> +
>>> +    assert(write_cpustate_to_list(arm_cpu, false));
>>> +
>>> +    /* Currently set global regs every time. */
>>> +    for (i = 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
>>> +        if (whpx_sreg_match[i].cp_idx == -1) {
>>> +            continue;
>>> +        }
>>> +
>>> +        val.Reg64 = arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx];
>>> +        if (whpx_sreg_match[i].global) {
>>> +            /* WHP disallows us from accessing global regs as a vCPU */
>>> +            whpx_set_global_reg(whpx_sreg_match[i].reg, val);
>>> +        } else {
>>> +            whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static uint32_t max_vcpu_index;
>>> +
>>> +static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
>>> +{
>>> +}
>>> +
>>> +int whpx_init_vcpu(CPUState *cpu)
>>> +{
>>> +    HRESULT hr;
>>> +    struct whpx_state *whpx = &whpx_global;
>>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>>> +    CPUARMState *env = &arm_cpu->env;
>>> +    int ret;
>>> +
>>> +    uint32_t sregs_match_len = ARRAY_SIZE(whpx_sreg_match);
>>> +    uint32_t sregs_cnt = 0;
>>> +    WHV_REGISTER_VALUE val;
>>> +    int i;
>>> +
>>> +    hr = whp_dispatch.WHvCreateVirtualProcessor(
>>> +        whpx->partition, cpu->cpu_index, 0);
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to create a virtual processor,"
>>> +                     " hr=%08lx", hr);
>>> +        ret = -EINVAL;
>>> +        goto error;
>>
>> Simpler: return -EINVAL;
> 
> Thanks, allowed to get rid of the goto error later as this was the only user of it.
>>> +    }
>>> +
>>> +    /* Assumption that CNTFRQ_EL0 is the same between the VMM and the partition. */
>>> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
>>> +
>>> +    cpu->vcpu_dirty = true;
>>> +    cpu->accel = g_new0(AccelCPUState, 1);
>>> +    max_vcpu_index = MAX(max_vcpu_index, cpu->cpu_index);
>>> +    qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
>>> +
>>> +    env->aarch64 = true;
>>> +
>>> +    /* Allocate enough space for our sysreg sync */
>>> +    arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
>>> +                                     sregs_match_len);
>>> +    arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
>>> +                                    sregs_match_len);
>>> +    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
>>> +                                             arm_cpu->cpreg_vmstate_indexes,
>>> +                                             sregs_match_len);
>>> +    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
>>> +                                            arm_cpu->cpreg_vmstate_values,
>>> +                                            sregs_match_len);
>>> +
>>> +    memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
>>> +
>>> +    /* Populate cp list for all known sysregs */
>>> +    for (i = 0; i < sregs_match_len; i++) {
>>> +        const ARMCPRegInfo *ri;
>>> +        uint32_t key = whpx_sreg_match[i].key;
>>> +
>>> +        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>>> +        if (ri) {
>>> +            assert(!(ri->type & ARM_CP_NO_RAW));
>>> +            whpx_sreg_match[i].cp_idx = sregs_cnt;
>>> +            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
>>> +        } else {
>>> +            whpx_sreg_match[i].cp_idx = -1;
>>> +        }
>>> +    }
>>> +    arm_cpu->cpreg_array_len = sregs_cnt;
>>> +    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
>>> +
>>> +    assert(write_cpustate_to_list(arm_cpu, false));
>>> +
>>> +    /* Set CP_NO_RAW system registers on init */
>>> +    val.Reg64 = arm_cpu->midr;
>>> +    whpx_set_reg(cpu, WHvArm64RegisterMidrEl1,
>>> +                              val);
>>> +
>>> +    clean_whv_register_value(&val);
>>> +
>>> +    val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
>>> +    whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
>>> +
>>> +    return 0;
>>> +
>>> +error:
>>> +    return ret;
>>> +}
>>> +
>>> +void whpx_cpu_instance_init(CPUState *cs)
>>> +{
>>> +}
>>> +
>>> +int whpx_accel_init(AccelState *as, MachineState *ms)
>>> +{
>>> +    struct whpx_state *whpx;
>>> +    int ret;
>>> +    HRESULT hr;
>>> +    WHV_CAPABILITY whpx_cap;
>>> +    UINT32 whpx_cap_size;
>>> +    WHV_PARTITION_PROPERTY prop;
>>> +    WHV_CAPABILITY_FEATURES features;
>>> +
>>> +    whpx = &whpx_global;
>>> +    /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
>>> +    whpx_irqchip_in_kernel = true;
>>> +
>>> +    if (!init_whp_dispatch()) {
>>> +        ret = -ENOSYS;
>>> +        goto error;
>>> +    }
>>> +
>>> +    whpx->mem_quota = ms->ram_size;
>>> +
>>> +    hr = whp_dispatch.WHvGetCapability(
>>> +        WHvCapabilityCodeHypervisorPresent, &whpx_cap,
>>> +        sizeof(whpx_cap), &whpx_cap_size);
>>> +    if (FAILED(hr) || !whpx_cap.HypervisorPresent) {
>>> +        error_report("WHPX: No accelerator found, hr=%08lx", hr);
>>> +        ret = -ENOSPC;
>>> +        goto error;
>>> +    }
>>> +
>>> +    memset(&features, 0, sizeof(features));
>>> +    hr = whp_dispatch.WHvGetCapability(
>>> +        WHvCapabilityCodeFeatures, &features, sizeof(features), NULL);
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to query capabilities, hr=%08lx", hr);
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    if (!features.Arm64Support) {
>>> +        error_report("WHPX: host OS exposing pre-release WHPX implementation. "
>>> +            "Please update your operating system to at least build 26100.3915");
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to create partition, hr=%08lx", hr);
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    memset(&prop, 0, sizeof(prop));
>>> +    prop.ProcessorCount = ms->smp.cpus;
>>> +    hr = whp_dispatch.WHvSetPartitionProperty(
>>> +        whpx->partition,
>>> +        WHvPartitionPropertyCodeProcessorCount,
>>> +        &prop,
>>> +        sizeof(prop));
>>> +
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to set partition processor count to %u,"
>>> +                     " hr=%08lx", prop.ProcessorCount, hr);
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    if (!whpx->kernel_irqchip_allowed) {
>>> +        error_report("WHPX: on Arm, only kernel-irqchip=on is currently supported");
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    memset(&prop, 0, sizeof(prop));
>>> +
>>> +    hr = whp_dispatch.WHvSetupPartition(whpx->partition);
>>> +    if (FAILED(hr)) {
>>> +        error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
>>> +        ret = -EINVAL;
>>> +        goto error;
>>> +    }
>>> +
>>> +    whpx_memory_init();
>>> +
>>> +    return 0;
>>> +
>>> +error:
>>> +    if (whpx->partition != NULL) {
>>> +        whp_dispatch.WHvDeletePartition(whpx->partition);
>>> +        whpx->partition = NULL;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
> 
> 


