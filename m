Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413F2CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9dc-0004Yf-4Y; Wed, 29 Oct 2025 13:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9da-0004YW-E0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:07:06 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vE9dV-0006d1-NR
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:07:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.235])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cxYYt4dHTz5vtR;
 Wed, 29 Oct 2025 17:06:42 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 29 Oct
 2025 18:06:38 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004ae3e3c5e-f1e6-4c0b-97a6-68532c3c0611,
 1C4C5A15D30C5F2C89D761F8A9BCD43732F6FBF1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.104.153
Message-ID: <561601ce-fdcd-4f65-8a46-648d753a317e@kaod.org>
Date: Wed, 29 Oct 2025 18:06:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [SPAM] [PATCH v1 01/13] hw/arm/aspeed: Move AspeedMachineState
 definition to common header for reuse
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
 <20251023100150.295370-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251023100150.295370-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 4132fba2-3f60-43a1-bd6d-0ae75410dd0e
X-Ovh-Tracer-Id: 5305521836082039730
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFjj8VyB2lABgXpm2UGukBvDInZo7UoOF/uNtd9hTvWjeYPwIEc0CZf1FYg2kcHZaRKA0IVwNmVytMxoJRPHQW09+eqyqyy08LwL/VaqLzLb8nsSC1UhvwjMZTGHJv21Nd8fj8w5BClNo9aUK5GMKTKlqi/fSIF3wEhj6o0F804Z/XcNuQ6cBW2O3HltRJWwx2TutQHZsbUuqJFIFy9G2KwaGQgw62AQz4xbeT8LH+5k5n7GsqAhah9AokLIhdLtVdjK6CBpe6lm/pntxBSD4QT6CCBi/9PCTINVsntBxnih7Yp6b4bLh5uBkoPi5NcS5aSsKyPCb2G/rluwWOmm1gvHn+yYoFquQqGYAWx+YXJLA7smf+h6QUNGS82lVfgnRN5axjUgtvk6Ey4DpmIME1UQ8vkXKT6zK2Q75Y6zpDC9oYGlXWPGBP+RYeZ32CZewnVd9FGCX2LPdYbGPeZU7I/DxsStroNbbRKAAyN4vnQwQk26Mx9/UjI76rhS3Z0MbEGJgD0GCMozy8tIQaE+oeI3nI2h5oL0PoDF6GwMjFnCdb9m1sfCzE4fH53TROaOsqGmWNJ9bvw81caQmeIkJkvmCE4juqFgTfXRMsr94c1Fk5jES9rmzHugDGVYuhLtS+qfLqvf1nVFaTh147B17Sbq6K5s5K9bxZCKSE8MAaDGw
DKIM-Signature: a=rsa-sha256; bh=DOYw0PTLrs1SMRAYJVL2JbXc0tz92vKk7Vm8Bqyu4rA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1761757604; v=1;
 b=RAv0RxpBfSkaolXKPgktvyCHqbKoRb7a4wakyRSeWPRC+Dz220EILPl1UgbmbbybUhNHEQ0V
 BwkqOfAHffYOzM9gmDp29PEmR8a2IlyNtGlnsq53KDBXfaFdP8/i0jDvN/HWGj2dc1085FUrIuL
 qyEORvAeEZ1JeJ6xzsNhhxQsZ8jSAltU+ps5AM23XHe61VnBC2JBXCqnfRQbjMk5YPHy03usto+
 qt6IvxcevSLGjdKeNuotWqtR3XtpLGvyioxrEjac8cLvuvq9vDPNWOI23GBzOJCvXPbnQFiYG6e
 RsjXu6Jpj4j7QgC2Dt6DiiB25ap5j/kpI6mOd2YIAYKEw==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/25 12:01, Jamin Lin wrote:
> Aspeed machines will be moved into split C files for better
> modularization and future maintenance.
> 
> To allow all machine implementations to reuse the same
> AspeedMachineState structure, the struct definition is moved
> from aspeed.c to the shared header aspeed.h.
> 
> This change centralizes the common state structure used across
> all Aspeed machine models, reduces redundancy, and simplifies
> future refactoring work for new machines.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed.h | 14 ++++++++++++++
>   hw/arm/aspeed.c         | 14 --------------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 6c36455656..383ebb9759 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -11,6 +11,7 @@
>   
>   #include "hw/boards.h"
>   #include "qom/object.h"
> +#include "hw/arm/aspeed_soc.h"
>   
>   typedef struct AspeedMachineState AspeedMachineState;
>   
> @@ -24,6 +25,19 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
>   #define ASPEED_MAC2_ON   (1 << 2)
>   #define ASPEED_MAC3_ON   (1 << 3)
>   
> +struct AspeedMachineState {
> +    /* Private */
> +    MachineState parent_obj;
> +    /* Public */
> +
> +    AspeedSoCState *soc;
> +    MemoryRegion boot_rom;
> +    bool mmio_exec;
> +    uint32_t uart_chosen;
> +    char *fmc_model;
> +    char *spi_model;
> +    uint32_t hw_strap1;
> +};
>   
>   struct AspeedMachineClass {
>       MachineClass parent_obj;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1bc9e534ba..761b526994 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -35,20 +35,6 @@ static struct arm_boot_info aspeed_board_binfo = {
>       .board_id = -1, /* device-tree-only board */
>   };
>   
> -struct AspeedMachineState {
> -    /* Private */
> -    MachineState parent_obj;
> -    /* Public */

You could drop the 'Private' and 'Public' comments.

Anyhow,



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

   > -
> -    AspeedSoCState *soc;
> -    MemoryRegion boot_rom;
> -    bool mmio_exec;
> -    uint32_t uart_chosen;
> -    char *fmc_model;
> -    char *spi_model;
> -    uint32_t hw_strap1;
> -};
> -
>   /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
>   #if HOST_LONG_BITS == 32
>   #define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)



