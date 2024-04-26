Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B358C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Md6-000869-MF; Fri, 26 Apr 2024 10:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Md4-00085q-Ft; Fri, 26 Apr 2024 10:32:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0Md2-0003xL-Jc; Fri, 26 Apr 2024 10:32:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VQwDV1Yrlz4x1x;
 Sat, 27 Apr 2024 00:32:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQwDR3gHpz4wnv;
 Sat, 27 Apr 2024 00:32:39 +1000 (AEST)
Message-ID: <eb6954b8-e64d-4f0e-9533-52dcdf64e1a5@kaod.org>
Date: Fri, 26 Apr 2024 16:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] ppc/pnv: Add HOMER for POWER11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-5-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240426110023.733309-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oYEp=L7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/26/24 13:00, Aditya Gupta wrote:
> Power11 core is same as Power10, declare PNV11_HOMER as a child
> class of PNV10_HOMER, so it goes through same class init
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv_homer.c         | 8 ++++++++
>   include/hw/ppc/pnv_homer.h | 3 +++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> index f9a203d11d0d..1b0123a6f2ea 100644
> --- a/hw/ppc/pnv_homer.c
> +++ b/hw/ppc/pnv_homer.c
> @@ -394,6 +394,13 @@ static const TypeInfo pnv_homer_power10_type_info = {
>       .parent        = TYPE_PNV_HOMER,
>       .instance_size = sizeof(PnvHomer),
>       .class_init    = pnv_homer_power10_class_init,
> +    .class_base_init = pnv_homer_power10_class_init,
> +};
> +
> +static const TypeInfo pnv_homer_power11_type_info = {
> +    .name          = TYPE_PNV11_HOMER,
> +    .parent        = TYPE_PNV10_HOMER,
> +    .instance_size = sizeof(PnvHomer),
>   };
>   
>   static void pnv_homer_realize(DeviceState *dev, Error **errp)
> @@ -442,6 +449,7 @@ static void pnv_homer_register_types(void)
>       type_register_static(&pnv_homer_power8_type_info);
>       type_register_static(&pnv_homer_power9_type_info);
>       type_register_static(&pnv_homer_power10_type_info);
> +    type_register_static(&pnv_homer_power11_type_info);
>   }
>   
>   type_init(pnv_homer_register_types);
> diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
> index b1c5d498dc55..8f1cc8135937 100644
> --- a/include/hw/ppc/pnv_homer.h
> +++ b/include/hw/ppc/pnv_homer.h
> @@ -35,6 +35,9 @@ DECLARE_INSTANCE_CHECKER(PnvHomer, PNV9_HOMER,
>   #define TYPE_PNV10_HOMER TYPE_PNV_HOMER "-POWER10"
>   DECLARE_INSTANCE_CHECKER(PnvHomer, PNV10_HOMER,
>                            TYPE_PNV10_HOMER)
> +#define TYPE_PNV11_HOMER TYPE_PNV_HOMER "-POWER11"
> +DECLARE_INSTANCE_CHECKER(PnvHomer, PNV11_HOMER,
> +                         TYPE_PNV11_HOMER)
>   
>   struct PnvHomer {
>       DeviceState parent;


