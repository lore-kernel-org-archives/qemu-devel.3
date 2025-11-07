Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCA3CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMdz-0000q5-MY; Fri, 07 Nov 2025 08:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMdx-0000pm-Uu
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:36:46 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMdw-0003Ob-2w
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:36:45 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.128])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d30TP3ZnPz6PhJ;
 Fri,  7 Nov 2025 13:36:41 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 14:36:40 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003fd54b3ac-f008-46af-9c7c-47306b9c9216,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fa0cf341-f336-48cd-b5d6-458710d187e9@kaod.org>
Date: Fri, 7 Nov 2025 14:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-7-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-7-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 2da700f4-248c-4847-a853-636671700698
X-Ovh-Tracer-Id: 17719694209407814578
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFBrgKgFRo5iMKET623w/QsLZfqxsprA0JwCY8eQkXQCOaUD9l9AnETDbqaAWStTKPPs1PUVi13fx8qc6EgFhBBjzW+S9/4q618oGeFSfBC+OKYlS401s4dKYUn4nMjZvvvI0wbyjAHPa5YqycWBJPIgj7t8EOSbxZwzUXzEjvpKdAkWP/TMY8O8muX6yu3Yl70a78N0L5tetVPUc8Fb9XwY5eOMiHxRV95dn+S3UvZ/MqDtOkXpJ6pYekaP4PWG89oMAhVFEQAw3BRor79+wvtzbUZQXDG83xoGYGYUt23AJzAxgI6b+74dP0KSGf+lT9yqDTh9l7fA1Ud/jTeI0VGOapuZxi87hjj/zL2r8zv1NrfcDYKGcTvLtL1XfjJRxSDEJWfPymbOTtX3c3te4Ov3+2oR4f6Il/fQim+KH3Q95+mRKQaXXGw6UpbAzkY0lIdub6iGoDGxGhZjjQX6hKJRjb8u0RNeSr3PQW1IYAZCfXYsGjVUoEoTJPuhUuRL94A1+n7NhIY+wBuZ42iQzBS4UIIOjYQ6QI1qxC0jDaC5Tz6dvxvk9oUSp5u45mCw9s8t+TeckKdORBYrsrlVFwly1mTqzlhBTOrmTqW/iYnd3YYl331Qla5+/a+WfHCxzsvwSNSDciQWyFAWh1moO2doLzJLhQqGKcVrrepGwMpKw
DKIM-Signature: a=rsa-sha256; bh=vkyr3y/qKC+lrtIlsT2HdC5BxgbE3leV577oSr+vkRI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762522601; v=1;
 b=enU71+1OQaRDBhUEBsblfqQjZ/VTkVSk7nYPRUle3LHxLLZIXto6x1GBRehmY4cahTBS7jNH
 dTXN0duPy5QlBj6dpuHJSzv5KR3XUXqTWfrywMbVSDpZGbAdI/8a8goiIMS53vqk0aY+UVgRWfv
 iZQU657J/+yYeShDSIHEhlVRKTCeOuIXWdpmjhkvCI6n6YPuUpkudAfAACBssTRxJliIJa7Bxme
 oBQnv3Nz3nLEJrNWF7+aPIK90FI0o7OFgzM4nfJGaDMHFvyo9XOveqMON2QyjFexfUQ2L5nBvDH
 Xw6iincfJxbs8NMidMcQbFH4P/NE7SQc6OKxqeqQOtakQ==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the LTPI controller to the AST1700 model by mapping its MMIO
> region and wiring its interrupt line.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_ast1700.h |  2 ++
>   hw/misc/aspeed_ast1700.c         | 21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
> index 624ef61eda..c2bea11346 100644
> --- a/include/hw/misc/aspeed_ast1700.h
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -28,6 +28,8 @@ struct AspeedAST1700SoCState {
>       SysBusDevice parent_obj;
>   
>       MemoryRegion iomem;
> +
> +    AspeedLTPIState ltpi;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index 3125bec795..0ca2b90ff0 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -16,6 +16,14 @@
>   #include "hw/misc/aspeed_ast1700.h"
>   
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
> +
> +enum {
> +    ASPEED_AST1700_DEV_LTPI_CTRL,
> +};
> +
> +static const hwaddr aspeed_ast1700_io_memmap[] = {
> +    [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
> +};
>   static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
> @@ -26,10 +34,23 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                          AST2700_SOC_LTPI_SIZE);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
> +    /* LTPI controller */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
>   }
>   
>   static void aspeed_ast1700_instance_init(Object *obj)
>   {
> +    AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
> +
> +    /* LTPI controller */
> +    object_initialize_child(obj, "ltpi-ctrl",
> +                            &s->ltpi, TYPE_ASPEED_LTPI);
> +
>       return;
>   }
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



