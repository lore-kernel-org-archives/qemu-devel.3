Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F2ACCA476
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 00:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6IK2-0001cu-Ja; Tue, 07 Oct 2025 20:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1v6F67-0005eq-5y; Tue, 07 Oct 2025 17:19:51 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1v6F65-0006eG-Bl; Tue, 07 Oct 2025 17:19:50 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 13CF66080403;
 Tue,  7 Oct 2025 23:19:46 +0200 (CEST)
Message-ID: <a38b7692-29b4-4580-a6ec-e22fe5913f69@csgraf.de>
Date: Tue, 7 Oct 2025 23:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/4] hw: vmapple: include missing headers
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
 <20251007203153.30136-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20251007203153.30136-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Oct 2025 20:46:19 -0400
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


On 07.10.25 22:31, Mohamed Mediouni wrote:
> Disablement by default led to:
>
> ../hw/vmapple/vmapple.c:276:39: error: use of undeclared identifier 'GTIMER_VIRT'
>    276 |         qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
>        |                                       ^
> ../hw/vmapple/vmapple.c:479:54: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
>    479 |         object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
>        |                                                      ^
> ../hw/vmapple/vmapple.c:556:13: error: call to undeclared function 'arm_build_mp_affinity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    556 |             arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
>        |             ^
> 3 errors generated.
>
> pretty quickly.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>


This patch should be stand alone and not RFC.

Alex


> ---
>   hw/vmapple/vmapple.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> index 16e6110b68..5928df4411 100644
> --- a/hw/vmapple/vmapple.c
> +++ b/hw/vmapple/vmapple.c
> @@ -51,6 +51,8 @@
>   #include "system/reset.h"
>   #include "system/runstate.h"
>   #include "system/system.h"
> +#include "gtimer.h"
> +#include "cpu.h"
>   
>   struct VMAppleMachineState {
>       MachineState parent;

