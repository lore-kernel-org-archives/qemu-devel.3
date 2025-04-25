Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E34C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u86kc-00073O-TE; Thu, 24 Apr 2025 20:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u86ka-00072u-9r
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:17:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u86kX-0004iL-Hv
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:17:04 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B44C955D22F;
 Fri, 25 Apr 2025 02:16:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id gG_Di_tbSrhb; Fri, 25 Apr 2025 02:16:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B845555D236; Fri, 25 Apr 2025 02:16:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5EC1745683;
 Fri, 25 Apr 2025 02:16:54 +0200 (CEST)
Date: Fri, 25 Apr 2025 02:16:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Anton Johansson <anjo@rev.ng>
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
In-Reply-To: <20250424222112.36194-9-philmd@linaro.org>
Message-ID: <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-815259812-1745539818=:88121"
Content-ID: <94c413dc-bb31-6529-1f58-a38bb48a9afb@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-815259812-1745539818=:88121
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <b215bd93-e49f-1f88-7dd8-600358c682ec@eik.bme.hu>

On Fri, 25 Apr 2025, Philippe Mathieu-Daudé wrote:
> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
> will be available on qemu-system-arm and qemu-system-aarch64
> binaries.
>
> One defined with DEFINE_MACHINE_AARCH64() will only be available
> in the qemu-system-aarch64 binary.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/arm/machines-qom.h | 13 +++++++++++++
> target/arm/machine.c          | 12 ++++++++++++
> 2 files changed, 25 insertions(+)
>
> diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
> index a17225f5f92..6277ee986d9 100644
> --- a/include/hw/arm/machines-qom.h
> +++ b/include/hw/arm/machines-qom.h
> @@ -9,10 +9,23 @@
> #ifndef HW_ARM_MACHINES_QOM_H
> #define HW_ARM_MACHINES_QOM_H
>
> +#include "hw/boards.h"
> +
> #define TYPE_TARGET_ARM_MACHINE \
>         "target-info-arm-machine"
>
> #define TYPE_TARGET_AARCH64_MACHINE \
>         "target-info-aarch64-machine"
>
> +extern InterfaceInfo arm_aarch64_machine_interfaces[];
> +extern InterfaceInfo aarch64_machine_interfaces[];
> +
> +#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
> +                                       arm_aarch64_machine_interfaces)
> +
> +#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
> +                                       aarch64_machine_interfaces)
> +
> #endif
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 978249fb71b..193c7a9cff0 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -8,6 +8,7 @@
> #include "cpu-features.h"
> #include "migration/cpu.h"
> #include "target/arm/gtimer.h"
> +#include "hw/arm/machines-qom.h"
>
> static bool vfp_needed(void *opaque)
> {
> @@ -1111,3 +1112,14 @@ const VMStateDescription vmstate_arm_cpu = {
>         NULL
>     }
> };
> +
> +InterfaceInfo arm_aarch64_machine_interfaces[] = {
> +    { TYPE_TARGET_ARM_MACHINE },
> +    { TYPE_TARGET_AARCH64_MACHINE },
> +    { }
> +};
> +
> +InterfaceInfo aarch64_machine_interfaces[] = {
> +    { TYPE_TARGET_AARCH64_MACHINE },
> +    { }
> +};

Why do you need these? If you define DEFINE_MACHINE_WITH_INTERFACES as 
OBJECT_DEFINE_TYPE_WITH_INTERFACES then you can write:

DEFINE_MACHINE_WITH_INTERFACES(name, initfn, { TYPE_TARGET_ARM_MACHINE },
     { TYPE_TARGET_AARCH64_MACHINE }, { })

and no more macros needed. Ideally those places that are now blown up 
should use DEFINE_MACHINE too. Maybe they don't yet because the parent
type  is hardcoded so we should really have

DEFINE_MACHINE_EXTENDED(name, parent, initfn, interfaces...)

and remove more bolier plate that way?

Regards,
BALATON Zoltan
--3866299591-815259812-1745539818=:88121--

