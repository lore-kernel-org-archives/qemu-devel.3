Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7112CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d1a-0001jb-8w; Fri, 17 Oct 2025 01:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1Y-0001jB-7M
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:29:08 -0400
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1T-0001ne-U1
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:29:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.8])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cntfK49yQz5xm7;
 Fri, 17 Oct 2025 05:28:57 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:28:56 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e3376bc9-2bf2-4774-8fb2-ac92c3582564,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d9442867-a314-43d0-8db3-a48d525bedd7@kaod.org>
Date: Fri, 17 Oct 2025 07:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 06/12] hw/arm/ast27x0: Share single UART set
 across PSP, SSP, and TSP
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
 <20251015062210.3128710-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251015062210.3128710-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: dc6018d4-de80-4c96-b7fe-60f5d2f50acc
X-Ovh-Tracer-Id: 15282965338979666735
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF6hAN0PVdUMAQA8vtEsrb6eDChMTjEe1rI0wHC9B0hhMTfTdH8h432H1Ntsm658EsXnvCqr63853mdhR+QK4SJdxDqCHSKjcRI4ACrrkhr9Bk616SiwcrOsGSVMXv+OrwBzsDT+H9O+QUSGqLS1D0vPf1AQ3MOPs4lUs0Ytfxrr4CcqtlzXxbyPQrQe9cKc8EArM56PfXAxUg8iYGWB/+OAtBfWUQD6XLfMqZky8pHHGvuuLA52aBW7YR6OIaUp13a/4SJ/gwnM/IPWCfvHU2fQRR0XSWYwck74qllSwN0AM1MQZyLe5MupSMt1AFKIvSh8/U/oNmbWIL4MMjDvEsUrBW99PbLhPCfANsTEeGfYR4xC3J9Rzvp4LnHHTB9XQ2ZOErK39gjmIfNNQM7bW+aqA8f3H6bXFQTz17saofmjx0CSXocOcE6BOdyjeoU2SyaVCwesKS1mRWD4H/v072KoFVIjYc0IFOlqQUi3sW7Jju7l3OLjjSl3qG2c7JVP0xUyxvLJxuCMVyrI11u3tVmtL+7/PujmTF+wwOTAWfKDqG6NQ7xTpp2HQeOHv8Enjygnu6bMAslpiOZMWaEYQXwRxVy/VFvQnWsjv8JjSlTr7X2ApLWrntcSoL2WcW5v2GwkqdXH4wzIGm3UdvGFE/PA3WIVkYEP8P91XCaUH5eJg
DKIM-Signature: a=rsa-sha256; bh=73JLKDctlJHSU2l1xXMKLq1lJ7sEs3VFcPD90JRiyP4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760678938; v=1;
 b=bCqYwy4hzXnMi2kKiLAbonOzzqPmOGS8LGNh4Rrj9Yv+zFs/Xr4VVUCUnPWI4B+SsWjoHg6d
 kbIWjI0iRc+DOmcPPtj0hyAzCSqbMdGE7+tshDTfZ9WurWeWeZGq1w66w/xaI4mO2qYZWdWkF9V
 FsBJdVS9+mGy+ACg0cMBMX46Q6hErJvKJrJV1iVuanzp/RIEpkGcF2FcflK/1/r8wJA0YVPPnfY
 pWSI4YLlRDNIygKfL6w/0pb2u8yTfswTaIWPL8ZcOBDXRBxzY+p0h+jJl4SV1uMDWv5rviaY6Mt
 PDgrapVhYw/40CL3FVMuvSP0vsC3e2mg0NgCl4Vbmoj5g==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
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

On 10/15/25 08:22, Jamin Lin wrote:
> In the original model, each subsystem (PSP, SSP, and TSP) created its own
> set of 13 UART devices, resulting in a total of 39 UART instances. However,
> on real AST2700 hardware, there is only one set of 13 UARTs shared among
> all processors.
> 
> This commit reworks the UART handling to correctly model the shared
> hardware design. The PSP now creates the full set of 13 UART instances,
> while the SSP and TSP link to the corresponding shared UART device
> through object properties.
> 
> Changes include:
> - Add "DEFINE_PROP_LINK("uart", ...)" and "DEFINE_PROP_INT32("uart-dev", ...)"
>    to allow each coprocessor to reference a specific shared UART instance.
> - Modify SSP to link to PSP’s UART4, and TSP to link to PSP’s UART7.
> - Introduce "uart_alias" to remap the UART’s MMIO region into the coprocessor’s
>    memory space.
> - Redirect the UART interrupt to the coprocessor’s NVIC, replacing the
>    default routing to the PSP’s GIC.
> 
> With this change, only one set of 13 UART devices is instantiated by the PSP,
> while the SSP and TSP reuse them via aliasing and shared interrupt routing,
> matching the real AST2700 hardware behavior.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  6 +++---
>   hw/arm/aspeed_ast27x0-fc.c          | 24 ++++++++++++------------
>   hw/arm/aspeed_ast27x0-ssp.c         | 29 ++++++++++++-----------------
>   hw/arm/aspeed_ast27x0-tsp.c         | 29 ++++++++++++-----------------
>   hw/arm/aspeed_coprocessor_common.c  |  3 +++
>   5 files changed, 42 insertions(+), 49 deletions(-)
> 



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



