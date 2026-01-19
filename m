Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A80CA5FFB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhjyG-000304-Nc; Mon, 19 Jan 2026 02:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vhjxD-0002bD-7j
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:45:49 -0500
Received: from 4.mo552.mail-out.ovh.net ([178.33.43.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vhjx8-0003AX-3c
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:45:37 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.84])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dvjDK1QW8z5vSk;
 Mon, 19 Jan 2026 07:45:20 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 19 Jan
 2026 08:45:16 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00382a1bd3c-e016-4ec9-a158-2e9f76f4153f,
 CBA6FA7C12C66A1134E3410DCAD37710A17CDEF2) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ee63db86-2981-42d4-b0f0-f20245a2203f@kaod.org>
Date: Mon, 19 Jan 2026 08:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251224014203.756264-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 75b996eb-0696-4784-bb7c-5a3a27cc2df3
X-Ovh-Tracer-Id: 16217462260739836917
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFx6Kqk/NFDJP4CoxClpGwLSi+jfcwnUtKOjhupCqMRU8Z0Tpooe8hqkzpR2Xv6HqL99gUetePbJc+AYpYePsx2S9UoqW8ta6yAwixEyboDmAdcPHaY+lsMM1wiZASyeQunU8ofFp1xl8pjgcHza2qqs6r3C8E/ObnyO7Xis0MQbwa3NOwfWqVhU0nppWQ3oQZs35Tc61r/pwdEjH2xugZtpiUjIhbLERt4dp2afTpcsdZuALOe7IPQxEmnM61HufqNTFDSEXexY6kcmeNf1Cws1fejjwQoPnl/697trMi7SsqxFpvX4EYbW3+M+MRF8mByZC+kxFbjb2HBtC7fFkFSqwwJD4K3fwLuiBHy0enrJcGt5L6t6RhhSvWlol9VJT0VK0bTTUIQPQ2DXc948TTwJfQ6brTHsQav/i5j8kgUoP92XxtxRhZIVuS7r+tyNvw0wi5Lt+PcqeSZYcqyFXztbG5kZIezp8UO4P3esfP3YwZYm9vNM4XRZ7ErsOFZ4fQje/sxfxal5Coyg+FhZ79vKmAnbEPrNqRmkyDfK4mIqDWbOf1LJtWXENCmyou6tfAYdKssWN0Xw7Rc8bfL+T/iboGTo0ia90PEbTQVWDb85UXXZG9n8JmSbPJtNFu2HiruO6dzS0qwRx7s2/ij9YDDr8U7qRY8c7OKJL8agA3AkQ
DKIM-Signature: a=rsa-sha256; bh=wLd1idKL2XspmuckTaib4lEb2vQa6fAIHsJXmgUncwA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768808722; v=1;
 b=sfrYRoY5C1qE+VhabyuVy8BLrqywdhD/ZaQhzCaogT0F5wI+CF8IyCawa5hBklSv6GmF2vYg
 iXHrFvR9tLgJcGDaAbjx1/WKsp5LV7SYtSE/pI7hr8KfFtEEMkiURlIgMY5fyJRL103U7zllei1
 quso9biujAWr3SLjC9mIkYdxPbR+RMhbNVjOhS8U8egYuDYpyh/vXuQXU9BwzKO1DBtl7Oi4Sf8
 sJqZcT7xy9ahkNjIdtt3qNp3mbdryTMTD8Gruq86Q+iMG/jS3Q373JgkHZ3n5/OQZnWc/HAP1bJ
 D2UPNt5A+QkEnYcA38oq3bb0CBFRcsklUHdOnECtZPY6A==
Received-SPF: pass client-ip=178.33.43.201; envelope-from=clg@kaod.org;
 helo=4.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Kane,

On 12/24/25 02:41, Kane Chen via wrote:
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
> This patch series is based on the SGPIO changes:
> https://patchwork.kernel.org/project/qemu-devel/patch/20251219-aspeed-sgpio-v5-1-fd5593178144@google.com/
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


Could you please resend a v5 asap ? The next quarter should be
quite buzy and I will have less time for Aspeed related matters.

Thanks,

C.


> ---
> 
> ChangeLog
> ---------
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
> Kane-Chen-AS (19):
>    hw/misc: Add LTPI controller
>    hw/arm/aspeed: Attach LTPI controller to AST27X0 platform
>    hw/misc: Add basic Aspeed PWM model
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
>    hw/arm/aspeed: attach I2C device to AST1700 model
>    hw/arm/aspeed: Attach WDT device to AST1700 model
>    hw/arm/aspeed: Attach PWM device to AST1700 model
>    hw/arm/aspeed: Attach SGPIOM device to AST1700 model
>    hw/arm/aspeed: Model AST1700 I3C block as unimplemented device
>    hw/arm/aspeed: Enable AST1700 IO expander support
> 
>   include/hw/arm/aspeed_ast1700.h |  53 +++++++
>   include/hw/arm/aspeed_soc.h     |  25 ++-
>   include/hw/i2c/aspeed_i2c.h     |   1 +
>   include/hw/intc/aspeed_intc.h   |   2 +
>   include/hw/misc/aspeed_ltpi.h   |  33 ++++
>   include/hw/misc/aspeed_pwm.h    |  31 ++++
>   hw/arm/aspeed_ast1700.c         | 268 ++++++++++++++++++++++++++++++++
>   hw/arm/aspeed_ast27x0.c         | 165 ++++++++++++++++++--
>   hw/i2c/aspeed_i2c.c             |  19 ++-
>   hw/intc/aspeed_intc.c           |  60 +++++++
>   hw/misc/aspeed_ltpi.c           | 193 +++++++++++++++++++++++
>   hw/misc/aspeed_pwm.c            | 121 ++++++++++++++
>   hw/arm/meson.build              |   1 +
>   hw/misc/meson.build             |   2 +
>   hw/misc/trace-events            |   4 +
>   15 files changed, 959 insertions(+), 19 deletions(-)
>   create mode 100644 include/hw/arm/aspeed_ast1700.h
>   create mode 100644 include/hw/misc/aspeed_ltpi.h
>   create mode 100644 include/hw/misc/aspeed_pwm.h
>   create mode 100644 hw/arm/aspeed_ast1700.c
>   create mode 100644 hw/misc/aspeed_ltpi.c
>   create mode 100644 hw/misc/aspeed_pwm.c
> 


