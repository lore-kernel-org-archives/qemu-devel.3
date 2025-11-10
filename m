Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BE2CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUzo-000618-Fg; Mon, 10 Nov 2025 11:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIUzb-0005y6-LC
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:43:48 -0500
Received: from 4.mo552.mail-out.ovh.net ([178.33.43.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIUzU-0002EG-FE
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:43:44 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.84])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d4wTh2yqjz5yJL;
 Mon, 10 Nov 2025 16:43:36 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 10 Nov
 2025 17:43:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008b76823c4-6543-491b-9762-d2f85efe009b,
 2CC8F654BF9A736B588295E2BFA8A60E013487DB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3751eebe-8a2f-4e85-bb9c-3a856407cc4f@kaod.org>
Date: Mon, 10 Nov 2025 17:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: a6cfb403-0914-4bae-83ba-8b77b53db6d8
X-Ovh-Tracer-Id: 1601029671803259826
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFI1/+AcsJJ9GvOCHSVWSH5f+kRTmCZrYeDrf405lSJYlD698RzBtt5eKlkbRKbDvGkhZfE4V0E3dbMvP/+DLiDb/OSHl4zDrisTx1C1NPU1+wZIpOBDGNRE7jOBblsWgqaziahwDjPNkZbQcLtMlBNeChUhk7VwNw9guOIigGarXQ01S/8pGZ23eQyvW8UNLb2wOdBGWbEKcbHkcxcbbXG96/q7ZMK/Ib3rwcdtliNhmHnAQNvtl+2kdSzexFqu/HokUV4WguzrJBEM3N6U7j+GytZCP3iQLnY2VhWfzxBG79513VON8GL76U5tyAudjXNcQz6iuWB0E/eyRZcE50kj80kahZGaxH9iXkBKSMmxwBvOcK1lQpH/iEBnTAWpTe2VhlFLPyK1BblVoNlwl6fa01Inl4lO5QL+0ADQb9p8aNKJbY6kwAKjPmO5g7pnpJCMI6ywjM4dxmjljFW6z1imCTaQa1hCiY2Ie29xAB8U2U5nl6Wg2rlCqzM+mvJCqtw76/BvusEwgXy/dnM2HI7uLDxbVdwOZuffOSZlkfKuWfB9+shFW3vcPRh2qnayIylVWIDSNdmXTe8mVoQiAzV+nTW44CD4WQrzkBI/br3Z1KExxfCKhg1taJUK+iapGwEX3qNbwO7SBR/QV4Hl7EUSYYsArjs8KKfFPmJ+RAMcA
DKIM-Signature: a=rsa-sha256; bh=oEdswl9Cx+KDXjFjg5r0xa3RnnmFnwxEWNAtwzurlWM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762793016; v=1;
 b=oe9lzrPliB9a/O02XjAL2KlFL6D46CG/Byu+BrUV+LY12g0I0rr4mE1Gh93ZBE6Ht4Hy86d1
 9pwWsfzNT0km0i1UiPClOvQtlXRY8eElEmb0Yjrn84Pi6/sOJdW3JY1skQPUO6EU8stgdrMBzKF
 /h7jaP1x+lW7N0kfZwETUrnWTw9YDciDVknvVC+h5cr0zBNDGlIEhPHXBv/HutpkG+48s2FtOED
 d3mN8s6WSOlJOql/qpTnlEFlO4bE4B/j7C6/XUnLnJTw9LXFk3AqSQ9nmbIZH+6qRDep+ieqUwL
 m8YM6GLQ4bWPn9tBDBGmCaNm4ZuUjd9fww26QPf2DYhlg==
Received-SPF: pass client-ip=178.33.43.201; envelope-from=clg@kaod.org;
 helo=4.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Hi all,
> 
> LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
> 2.0 specification (see Figure 2):
> https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> 
> LTPI provides a protocol and physical interface for tunneling various
> low-speed signals between the Host Processor Module (HPM) and the
> Satellite Controller Module (SCM). In Figure 2 of the specification,
> the AST27x0 SoC (left) integrates two LTPI controllers, allowing it to
> connect to up to two AST1700 boards. On the other side, the AST1700
> consolidates HPM FPGA functions and multiple peripheral interfaces
> (GPIO, UART, I2C, I3C, etc.) onto a single board.
> 
> Because the AST1700 exposes additional I/O interfaces (GPIO, I2C, I3C,
> and others), it acts as an I/O expander. Once connected over LTPI,
> the AST27x0 can control additional downstream devices through this link.
> 
> This patch series introduces a basic LTPI controller model and wires it
> into the AST27x0 SoC. It also adds the AST1700-specific LTPI expander
> device and gradually connects common peripherals on the AST1700 model.
> For blocks that are not yet functionally implemented (I3C, SGPIOM, PWM),
> their MMIO regions are modeled as unimplemented devices to reserve
> address space and make the missing functionality explicit, ensuring that
> guest probing remains stable.

Thanks for the improved cover letter.

> In the official release images, the AST1700 functions are not included
> by default. To test the AST1700-related functionality, please include
> the following DTS files for probing:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi0.dtsi
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi1.dtsi

Is a release planned ?

> After including these DTS files in the BMC image, you can verify LTPI
> functionality using the following scenarios:
> 
> 1. In U-Boot:
>     Run the ltpi command to trigger the LTPI connection and display the
>     current connection status.
> 2. In BMC Linux:
>     Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by
>     the AST1700.

because this would be good to have for functional tests.

> 
> Any feedback or suggestions are appreciated!

The AST1700 model is rather big and very similar to a SoC, without CPUs.
Perhaps we should move the model under hw/arm instead ?


Thanks,

C.


> 
> Kane
> ---
> 
> ChangeLog
> ---------
> v2:
> - Separate the AST1700 model into a standalone implementation
> - Refine the mechanism for assigning the AST1700 board number
> 
> v1:
> - Initial version
> ---
> 
> Kane-Chen-AS (17):
>    hw/arm/aspeed: Add LTPI controller
>    hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
>    hw/arm/aspeed: Add AST1700 LTPI expander device model
>    hw/arm/aspeed: Integrate AST1700 device into AST27X0
>    hw/arm/aspeed: Integrate interrupt controller for AST1700
>    hw/arm/aspeed: Attach LTPI controller to AST1700 model
>    hw/arm/aspeed: Attach UART device to AST1700 model
>    hw/arm/aspeed: Attach SRAM device to AST1700 model
>    hw/arm/aspeed: Attach SPI device to AST1700 model
>    hw/arm/aspeed: Attach ADC device to AST1700 model
>    hw/arm/aspeed: Attach SCU device to AST1700 model
>    hw/arm/aspeed: Attach GPIO device to AST1700 model
>    hw/arm/aspeed: Attach I2C device to AST1700 model
>    hw/arm/aspeed: Attach WDT device to AST1700 model
>    hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
>    hw/arm/aspeed: Model AST1700 SGPIOM block as unimplemented device
>    hw/arm/aspeed: Model AST1700 PWM block as unimplemented device
> 
>   include/hw/arm/aspeed_soc.h      |  20 +-
>   include/hw/intc/aspeed_intc.h    |   2 +
>   include/hw/misc/aspeed_ast1700.h |  51 ++++++
>   include/hw/misc/aspeed_ltpi.h    |  25 +++
>   hw/arm/aspeed_ast27x0.c          | 154 ++++++++++++++--
>   hw/intc/aspeed_intc.c            |  60 ++++++
>   hw/misc/aspeed_ast1700.c         | 303 +++++++++++++++++++++++++++++++
>   hw/misc/aspeed_ltpi.c            |  98 ++++++++++
>   hw/misc/meson.build              |   2 +
>   9 files changed, 700 insertions(+), 15 deletions(-)
>   create mode 100644 include/hw/misc/aspeed_ast1700.h
>   create mode 100644 include/hw/misc/aspeed_ltpi.h
>   create mode 100644 hw/misc/aspeed_ast1700.c
>   create mode 100644 hw/misc/aspeed_ltpi.c
> 


