Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E0CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 10:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1MZb-0005Qh-At; Wed, 24 Sep 2025 06:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1MZZ-0005Pt-GH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:18:05 -0400
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1MZS-0003Zr-BF
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:18:05 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.170])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cWt8H5L8Jz6MrS;
 Wed, 24 Sep 2025 10:17:51 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 24 Sep
 2025 12:17:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0071734adcc-2719-4fe2-8341-456c75838f5d,
 FFBB6E977D22EB3F6A0A3CEA11E4CFA931BEF3A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <eb5dc6d2-29d9-451e-9588-6a3de03a952e@kaod.org>
Date: Wed, 24 Sep 2025 12:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents
 into CA35 boot ROM
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250924055602.294857-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 25bc5261-52aa-4036-a197-3b5c8f83b778
X-Ovh-Tracer-Id: 14217582549251558191
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEpdn2Hd+Qydru7ZAE80PhlXsbHUuBPq4TFyggkWgT8S2DDqCWR7Ko6x480PcL8EFonoSEHBsxVAXs0gllOa2DDwIzVPd5+2rDW/Ou0Ph90N1WTvZqrF4rq7jX5AXj5WF9lGYztrNycmOauDQ+Uwc4g6iylaFDjcFKe3lNQjmzhsJoxNthTTB3RKGChd/2pnEHGnE07Re37LRAmOTEJLuCtLi7KXrEKxESjNg1S8Nu/LY/031lBZuKeEBqK28Zo9xZLLyvsp7ZE6tecHn8xuQmpLrwT66II/wqOQGGh7STq+euTFELs35DY5SawFSORGpHbB1IcMt5ka7uUyporii4Tonid9tCnCFkC0Rp/s4eN+IK0aWWS/Zc4VL6xiroIyYQeroekwPzvmVsnWa+eLvlGTlgoCoEgMdk09/OoullBhNe6NX819C0FVjMozdZv0Vh3V8aMKM32Pep69+AaN0uDAmUzNvxDsP10B62ykT6oY96yxrc6UiIncQ9rG/gLNZJ7TuPgBP1yYjjXKqmJlo64eYJZRZj/144gKUCwHnH7gmhq5wWDLVXFrseGIRABn4uXbvkEd7iwf8qUG+NOe8TB8njkONjAjN9SA07lkGtyVf1aABa/WtS6Zlf9ksuyArKIpg8JeyyD7cnq3jlYxj9EaXMzHSj9fFXtoOWW6rWAyg
DKIM-Signature: a=rsa-sha256; bh=fielKEJ2cni+E/FQx6EHd7/UOhjvAk2qJE2aoTzJC1g=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758709072; v=1;
 b=NSYW7Ejw7r7a40ViIdy/lj/g+pM7EJBSJuYYrne+7rhXTcyEfbQaQFnw/OYZ/J7EqBEsO6rN
 I0GTEcAJe2X6VSYfRvZ1c/g2LwWahUv8/CwXLvEF7hsaYALmkkET/NiGYnydTnfe+jYq/zMlSkI
 e6ur9RK/T8vOgXtEHg38+O/qPk1eLe5oRT8c8lc9poPHMXKc5ZuXHNlWJIya++h5YUXbOm7yO25
 xuGto1uhfWcSBkbgpAXL+pIDoSSkFsgA+icIrFF9shIOraXNwS/1W1vBOpDdekyGv2k3JbWWSNi
 05CL/ShxCZOa6QawMjE+r1PFuRBcLS4jIJ+nXxkWdXFWw==
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

On 9/24/25 07:56, Jamin Lin wrote:
> This patch introduces a dedicated ca35_boot_rom memory region and
> copies the FMC0 flash data into it when mmio_exec is disabled.
> 
> The main purpose of this change is to support the upcoming VBOOTROM
> , which can directly fetch data from FMC0 flash at the SPI boot ROM
> base address (0x100000000) without requiring any SPI controller
> drivers.

That's the 'execute-in-place' case but the property activating
'execute-in-place' is always false in this machine. Could you
explain why booting from vbootrom needs the fmc0 contents to be
mapped in memory too ?




> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index b15cb94c39..2e6036b192 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -35,6 +35,7 @@ struct Ast2700FCState {
>   
>       MemoryRegion ca35_memory;
>       MemoryRegion ca35_dram;
> +    MemoryRegion ca35_boot_rom;
>       MemoryRegion ssp_memory;
>       MemoryRegion tsp_memory;
>   
> @@ -61,7 +62,10 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       Ast2700FCState *s = AST2700A1FC(machine);
>       AspeedSoCState *soc;
>       AspeedSoCClass *sc;
> +    BlockBackend *fmc0 = NULL;
> +    DeviceState *dev = NULL;
>       Error **errp = NULL;
> +    uint64_t rom_size;
>   
>       object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
>       soc = ASPEED_SOC(&s->ca35);
> @@ -119,6 +123,16 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       ast2700fc_board_info.ram_size = machine->ram_size;
>       ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
>   
> +    if (!s->mmio_exec) {

bool 'mmio_exec' is always false in this machine. Should we keep it ?

Thanks,

C.



> +        dev = ssi_get_cs(soc->fmc.spi, 0);
> +        fmc0 = dev ? m25p80_get_blk(dev) : NULL;
> +
> +        if (fmc0) {
> +            rom_size = memory_region_size(&soc->spi_boot);
> +            aspeed_install_boot_rom(soc, fmc0, &s->ca35_boot_rom, rom_size);
> +        }
> +    }
> +
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
>   }
>   


