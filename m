Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686ACA5FA6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEIO-0002nC-Dp; Tue, 20 Jan 2026 11:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1viEIH-0002mL-IR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:09:26 -0500
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1viEIF-0006Pu-I4
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:09:25 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.86])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dwXMC4FbWz5vrn;
 Tue, 20 Jan 2026 16:09:11 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 20 Jan
 2026 17:09:10 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00292744a0c-444c-43c1-96ca-4913ae1004a1,
 21EA59D4F1114275CF698448FAF8CB5A144B01CF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1433fb86-bb1b-41f7-b7ec-45560e52146a@kaod.org>
Date: Tue, 20 Jan 2026 17:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 842f24e1-b751-4961-81ce-cc7d92fad1a6
X-Ovh-Tracer-Id: 12152682123131194290
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFa9cxNgNqvbSuC3CQR12dLi8tFcYAvU56LW4p6FoyoyvtiV2hGqHxTKs+hVPevy21clvi0a6g8cOr/c0hEw40Az5RnLKFk2Vx2bO8fw4EizpYbhUbF1jgFYuGqUl0fGPhDirgosRrhO4QUxqMarwZbQpTF8iXGFAiCYVQVVzXc/g9VVH0OvxK5NM/oFRNe1WSArsbKJaEnC5frf35UDoDN8RQmx2yFlW1jhQhd4DOsGqbj5tkmYKjHfnibTvKaVQC91qXrUxR1jYLhPYnvd1Vxyb/RdUjAl2K4E6MGYThXEJ1H0L8Zp6jZtedaet9IHDPP3VnblVQDx074AJipqcPneLVPcthTgCtXKfZ+V6riN/gOywsLziAMxLzDWVuLQ08214Fk5N1ykKZx9Kck3S/FzHFwFvbc5i4b3Pe+Mdh1wWLvAzy6+FkShOPmYR/0c0lB24C89PCsMN3oOxpL/BdJq+63RPoUBTX0ok11gMncrge+7c7TogL+1zWBA6HB+lpLid0jNZ8WPP2QxRzR0ADL2xhu31upBdwlRpwWwgBSov9pZ2V8w4CQi6M7b9UoA1lg4VHB7+GAeXrAxSYEOFN9oXHBzxwapIBwlTHccoiRPnREI1eeplHmv3b4I4fQoFfmRwONT5C2Utpi8SG0nNFN26iREVzvJMLGEeivGwhqkQ
DKIM-Signature: a=rsa-sha256; bh=ddIZh+0aniWV4BokIFLg/3rus/0Il6t6CBNbSWXos80=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768925352; v=1;
 b=OhG8Wsj0aC3E0CF4YTXbuqWOwk8fZ7AnUfJ79ymRwnolw7vLtubMw3/wKLkXq/WB6mudsF2H
 rycZVjlbN5BzE6TLfin8wWGs0pGVXMPYdAO41VUp4KoFVl/M0qJeLrHEjkMiFBbCEbZquV9HjWZ
 vjqZ3vrNB1NOAA7DJ7kcQqLertHaEw/TJXDCisOLVXIBEsPE9wyBzctMuQ0+nscX6PZBFEuV6My
 Thpq8V7lQKCXVFBLFUT/e22G261jVn9f1KHdbMUMcpIGlU6lTB5ujXvrojeOUsy6FbCyTxrMIEg
 toGLqbMTUfznYHdhB5KPAQYpue0ziMmAUPeHOgCGV+OYw==
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
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

Kane, Jamin,

For some reason, I don't receive your proposals anymore. My provider
seems to drop silently these emails. Have you changed anything recently ?

Thanks,

C.

On 1/20/26 06:18, Kane Chen via qemu development wrote:
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
> This patch series is based on the aspeed_next branch and incorporates
> recent I2C bus label changes.
> Ref: https://patchwork.kernel.org/project/qemu-devel/patch/20260112083054.4151945-2-kane_chen@aspeedtech.com/
> 
> It introduces a basic LTPI controller model and wires it into the
> AST27x0 SoC. The series also adds the AST1700-specific LTPI expander
> device and incrementally connects common peripherals on the AST1700
> model. For the I3C block, which may cause kernel crashes, its MMIO
> region is modeled as an unimplemented device to reserve address space
> and make the missing functionality explicit, ensuring stable guest
> probing.
> 
> In the official release images, the AST1700 functions are not included
> by default. To test the AST1700-related functionality, please include
> the following DTS files for probing:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi0.dtsi
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-ltpi1.dtsi
> 
> After including these DTS files in the BMC image, you can verify LTPI
> functionality using the following scenarios:
> 
> 1. In U-Boot:
>     Run the ltpi command to trigger the LTPI connection and display the
>     current connection status.
> 2. In BMC Linux:
>     Run i2cdetect -y <16-38> to scan and test the I2C buses exposed by
>     the AST1700.
> 
> Any feedback or suggestions are appreciated!
> 
> Kane
> 
> ---
> 
> ChangeLog
> ---------
> v5:
> - Add functional test case for AST1700 I2C
> - Corrected the From attribution
> - Fixed incorrect DRAM setting for SPI and I2C controllers
> - Refine code structure
> 
> v4:
> - Add missing Signed-off-by
> - Fix checkpatch.pl warnings
> - Refine code structure
> - Enable AST1700 support only after all devices are ready
> 
> v3:
> - Add PWM model
> - Integrate the SGPIO model
> - Fix I2C test case failure
> - Refine code structure
> 
> v2:
> - Separate the AST1700 model into a standalone implementation
> - Refine the mechanism for assigning the AST1700 board number
> 
> v1:
> - Initial version
> ---
> 
> Cédric Le Goater (1):
>    hw/misc: Add basic Aspeed PWM model
> 
> Kane-Chen-AS (21):
>    hw/misc: Add LTPI controller
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
>    hw/arm/aspeed: Introduce 'bus-label' property for AST1700 SoC
>    hw/arm/aspeed: attach I2C device to AST1700 model
>    hw/arm/aspeed: Attach WDT device to AST1700 model
>    hw/arm/aspeed: Attach PWM device to AST1700 model
>    hw/arm/aspeed: Attach SGPIOM device to AST1700 model
>    hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
>    hw/arm/aspeed: Enable AST1700 IO expander support
>    test/functional/aarch64: Parameterize I2C bus ID in AST2700 test
>    test/functional/aarch64: Add I2C test for AST1700 IO expanders
> 
>   include/hw/arm/aspeed_ast1700.h               |  55 ++++
>   include/hw/arm/aspeed_soc.h                   |  25 +-
>   include/hw/intc/aspeed_intc.h                 |   2 +
>   include/hw/misc/aspeed_ltpi.h                 |  33 +++
>   include/hw/misc/aspeed_pwm.h                  |  31 ++
>   hw/arm/aspeed_ast1700.c                       | 280 ++++++++++++++++++
>   hw/arm/aspeed_ast27x0.c                       | 170 ++++++++++-
>   hw/intc/aspeed_intc.c                         |  60 ++++
>   hw/misc/aspeed_ltpi.c                         | 193 ++++++++++++
>   hw/misc/aspeed_pwm.c                          | 121 ++++++++
>   hw/arm/meson.build                            |   1 +
>   hw/misc/meson.build                           |   2 +
>   hw/misc/trace-events                          |   4 +
>   .../functional/aarch64/test_aspeed_ast2700.py |  52 +++-
>   14 files changed, 999 insertions(+), 30 deletions(-)
>   create mode 100644 include/hw/arm/aspeed_ast1700.h
>   create mode 100644 include/hw/misc/aspeed_ltpi.h
>   create mode 100644 include/hw/misc/aspeed_pwm.h
>   create mode 100644 hw/arm/aspeed_ast1700.c
>   create mode 100644 hw/misc/aspeed_ltpi.c
>   create mode 100644 hw/misc/aspeed_pwm.c
> 


