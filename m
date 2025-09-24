Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E64DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 10:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1MOb-0003LF-7b; Wed, 24 Sep 2025 06:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1MOQ-0003KX-P8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:06:36 -0400
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1MOM-0001hj-St
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:06:33 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.167])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cWsv23dVhz6V2K;
 Wed, 24 Sep 2025 10:06:22 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 24 Sep
 2025 12:06:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0025b9f5017-fdda-431f-872c-1eb24eeabb50,
 FFBB6E977D22EB3F6A0A3CEA11E4CFA931BEF3A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <87fc57a4-cbbb-4c57-877f-900089e0a715@kaod.org>
Date: Wed, 24 Sep 2025 12:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/arm/aspeed_ast27x0-fc: Replace error_abort with
 local errp
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250924055602.294857-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 615b4e3f-42f0-4d8f-ad87-e63630e0a880
X-Ovh-Tracer-Id: 14023646292086721327
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGeuQ6H9gO3NN9K/nZJYL/xOPm62lk8EPoyNaKTUBnUMIYziYCCBYBv5X2yn6P2pr6L0hznCEW2DUVFx05y3uCKCejSmswbX0Cme1BoAln6h81Y1MSC+z/z+8IAitGXwsuPb0XTzhnF+10kx2+4OLMoUR6cqPN10b5GN0wBspkKRxV6/DaeBaescvCnRU/1BXDj5j6b5DCBAfUDdaEY6s5uHjVnwv8FcPYkfucXWVGqeiLsE/kcDHmZjJuY/EMDM72Eqvl9FVJUH3/1g/Ptv17j5z53dzsbDslXY/wJJ1K4GKOXg87rlKKjwFIpcbCmV7WUnPm/WQ9SHW0EgtOhRRGCtdpbSRP56Uvkf+1WCJB+FghHUptjOIdChw639eWzWevCBW/y/LSki/iYA4FNV1O5omylfdMYzu8p/df4vG3mlwWo/3JNxlPYYkPhe6KkkIDURLXxgl7IsFHHruWtXBCI7rIB7oK5KKoshf2BmMArG042fNKeYhqqoTGLad9mcS/VxVLFKnkrQtc9xS1RFdw4jLz3Xp8o2gyR8ssTwY9Qptd3KklJxTFpSU/LbdHHOancfLt9OUnV5gnkED4sbSSjEU7zxt3TyBLhJ7s6fkRJEwvyaCUnJwAGBw9F78ow7D40u9y1Pv8xmW6hINJr5+BhKVWI9GB01S8Gah/d3Cb8/A
DKIM-Signature: a=rsa-sha256; bh=ncGy/po5DjGHcn2SHNup3fdd3Whdn71l9H7KlnfEuPg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758708382; v=1;
 b=ftX0Qzeorojnc0ctQ3zbhvsa7mg3DdO1B5F2aOlaihE8DRPpE25J1ViFfw17cGCGSe1JUmql
 yNlIwPL7P80v98tSWcGZgf476QeeOfRjRwItEL7rcc12J3+f54cb9c0S4kGYC5HLcgpk20BQBqB
 xoIOrePNtuLbdbCp1lWWinoGGepUyv3MK/ofZ6Lb4EIyDCJ7Zj4TkFkeAWltJugiPVG3hiR+bJr
 +DOwNo6NcI5ywerFGjCNC4cKZFceL1iIgjaKDUwA6jWd549T7whM1+xqFvjzZ4ghebfbWkfbaK7
 tLmsyO6iPBCxUOxtkDTqAZ2/y//L/Fkus42hVaUjR2hTw==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 9/24/25 07:55, Jamin Lin wrote:
> This patch introduces a local Error **errp = NULL and
> replaces error_abort with errp in these paths.
> 
> This makes error handling more consistent with QEMU guidelines and avoids
> using error_abort in cases where failure should not be treated as a
> programming error.
> 
> Discussion:
> object_property_set_link() can return false only when it fails, and it
> sets an error when it fails. Since passing &error_abort causes an abort,
> the function never returns false, and the return statement is effectively
> dead code. If failure is considered a programming error, using
> &error_abort is correct. However, if failure is not a programming error,
> passing &error_abort is wrong, and errp should be used instead. This
> patch follows the latter approach by replacing error_abort with errp.
> https://patchwork.kernel.org/project/qemu-devel/patch/20250717034054.1903991-3-jamin_lin@aspeedtech.com/#26540626
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 7087be4288..b15cb94c39 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -61,6 +61,7 @@ static void ast2700fc_ca35_init(MachineState *machine)


ast2700fc_ca35_init(), and others below, should to take an 'Error **errp'
parameter and return a bool, which should be false in case of error. The
caller, ast2700fc_init() would then check the returned value and possibly
report the error.

A good reading on the error topic is in file "include/qapi/error.h".
  
>       Ast2700FCState *s = AST2700A1FC(machine);
>       AspeedSoCState *soc;
>       AspeedSoCClass *sc;
> +    Error **errp = NULL;
>   
>       object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
>       soc = ASPEED_SOC(&s->ca35);
> @@ -71,20 +72,20 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       memory_region_add_subregion(get_system_memory(), 0, &s->ca35_memory);
>   
>       if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
> -                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
> +                                AST2700FC_BMC_RAM_SIZE, errp)) {
>           return;
>       }
>       if (!object_property_set_link(OBJECT(&s->ca35), "memory",
>                                     OBJECT(&s->ca35_memory),
> -                                  &error_abort)) {
> +                                  errp)) {
>           return;
>       };
>       if (!object_property_set_link(OBJECT(&s->ca35), "dram",
> -                                  OBJECT(&s->ca35_dram), &error_abort)) {
> +                                  OBJECT(&s->ca35_dram), errp)) {
>           return;
>       }
>       if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
> -                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
> +                                 AST2700FC_BMC_RAM_SIZE, errp)) {

object_property_set_int() is considered as a routine which shouldn't fail.
So the common practice in models is to pass &error_abort and ignore the
returned value.


Thanks,

C.



>           return;
>       }
>   
> @@ -95,15 +96,15 @@ static void ast2700fc_ca35_init(MachineState *machine)
>           }
>       }
>       if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
> -                                 AST2700FC_HW_STRAP1, &error_abort)) {
> +                                 AST2700FC_HW_STRAP1, errp)) {
>           return;
>       }
>       if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
> -                                 AST2700FC_HW_STRAP2, &error_abort)) {
> +                                 AST2700FC_HW_STRAP2, errp)) {
>           return;
>       }
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
> -    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
> +    if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
>           return;
>       }
>   
> @@ -125,6 +126,8 @@ static void ast2700fc_ssp_init(MachineState *machine)
>   {
>       AspeedSoCState *soc;
>       Ast2700FCState *s = AST2700A1FC(machine);
> +    Error **errp = NULL;
> +
>       s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
>       clock_set_hz(s->ssp_sysclk, 200000000ULL);
>   
> @@ -134,13 +137,13 @@ static void ast2700fc_ssp_init(MachineState *machine)
>   
>       qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
>       if (!object_property_set_link(OBJECT(&s->ssp), "memory",
> -                                  OBJECT(&s->ssp_memory), &error_abort)) {
> +                                  OBJECT(&s->ssp_memory), errp)) {
>           return;
>       }
>   
>       soc = ASPEED_SOC(&s->ssp);
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
> -    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
> +    if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
>           return;
>       }
>   }
> @@ -149,6 +152,8 @@ static void ast2700fc_tsp_init(MachineState *machine)
>   {
>       AspeedSoCState *soc;
>       Ast2700FCState *s = AST2700A1FC(machine);
> +    Error **errp = NULL;
> +
>       s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
>       clock_set_hz(s->tsp_sysclk, 200000000ULL);
>   
> @@ -158,13 +163,13 @@ static void ast2700fc_tsp_init(MachineState *machine)
>   
>       qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
>       if (!object_property_set_link(OBJECT(&s->tsp), "memory",
> -                                  OBJECT(&s->tsp_memory), &error_abort)) {
> +                                  OBJECT(&s->tsp_memory), errp)) {
>           return;
>       }
>   
>       soc = ASPEED_SOC(&s->tsp);
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
> -    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
> +    if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
>           return;
>       }
>   }


