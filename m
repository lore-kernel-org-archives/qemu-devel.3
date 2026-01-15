Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE5D44C69
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPcA-0000MY-IS; Thu, 15 Jan 2026 10:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgPc8-0000LY-WB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:50:25 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgPc5-0005gx-D9
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:50:24 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.72])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dsS9h2KwCz5ybC;
 Thu, 15 Jan 2026 15:50:16 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 15 Jan
 2026 16:50:15 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008246df43f-9257-49fb-bbaa-a2096afb8be9,
 730BEF4863DC82B2970748FB5926F4A3C98AA806) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bc52933c-757d-42e6-9036-2b39a2dbfe94@kaod.org>
Date: Thu, 15 Jan 2026 16:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Be consistent about capitalization of 'Arm' (again)
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Ninad
 Palsule <ninad@linux.ibm.com>, Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alexandre Iooss
 <erdnaxe@crans.org>, Alistair Francis <alistair@alistair23.me>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260115150545.669444-1-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260115150545.669444-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: e851bd13-5be4-4acc-9e53-71e890f2ef58
X-Ovh-Tracer-Id: 916482525802433293
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEeJuyiYGA8Ed43LcOVVYGYSiAY89vmfTtaxCI7ypMbWMPmNuzAPF9DM3uaA7wOLnBg7quddqtvvWY30MVxhayV2geSVuV58LaDQyyR98uL8caszUyCiaDN/ZHT7YdCTuggUgFHdPlSRR4UMlH51eIqFuMMX7MA2JujjdqW/tzqiOiyQzFQoET0IQKH2W1zHkslA/T6nphEs3vAo+m+i45BsTyLzst+YO6ZXztq/TiCWRnRkbrS2iG6hnrQIfrWyjnItSQrhNgGsdfLPa7hTNgFSGk2wMP90/ZUbPesB9WldU3SNNHxXS3a1XErgcyIY5A35A9DkfpJwkMFSVfUhdoZIcIVvICw/tNIaV4TFDxTFZgAtrskNKp55fBmIA3Y3ow8+RgsSdOtRzJGTq50vDDi/1i0MxQfrIvsxvFthwW7bVl/D2NkfCcjAHfwh1msHkof+TQMOkPAwMsLVQrFIfmauIIQaLGiTSwvar5QxJv8t2flgJHvuVCeG4kddMKAxvim3DWf0hZcNqImeoJ6cWPwN8y9/BuBb3SuT/3bZ466DUCATwtm46+kb/F99otPgiKiVVy6/pwbyINOUoJOx8FH9mzHrMW0cKhHjYkurktDxMxRU7UQuXTxFSd6oBivsMccclDatqojQxHY8qljZGzPUHnCpiEy5yAbQ9iF71jAcg
DKIM-Signature: a=rsa-sha256; bh=EIPow59PjD1kCN2B4aIlNr4Rh7tkMc/xhKfZoRdyRV0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768492218; v=1;
 b=dwYNm5y/LltbXJwEhU0cLrrUYfV/JWvxl59uCZqMa3tubc1B+O5qWexnB5KDyH0SH9iXo9gA
 gX78AVZVJqsCJJCPmUQYSbtzlCqPP5zF+cpNKUWc87Tu6c6V/KTfTX6vSlQm6DDNLEslGYaVAa7
 gMJKy+4ck2Pg2NqglxkmUQOqdkVlBNlhPbOL4IsxQqDDGJD26ECc3D0YDAV+sOmdQL9qs3wx7uW
 ySeV2OiiVzpvyZ+CN2OTZxP7vCypq1JmuQVxAyXFuCuYHtx/m/d38XcJEs1CMAypZ5nCc8eTxo9
 AFQiakxLAwxs5LnwApvhZ6luVduraEkj8qnZ+zz+ApRSQ==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On 1/15/26 16:05, Peter Maydell wrote:
> The company 'Arm' went through a rebranding many years back
> involving a recapitalization from 'ARM' to 'Arm'. As a result
> our documentation is a bit inconsistent between the two forms.
> It's not worth trying to update everywhere in QEMU, but it's
> easy enough to make docs/ consistent.
> 
> We last did this in commit 6fe6d6c9a in 2020, but a few new
> uses of the wrong capitalization have crept back in since.
> 
> As before, "ARMv8" and similar architecture names, and
> older CPU names like "ARM926" still retain all-caps.
> 
> In a few places we make minor grammar fixups as we touch
> the sentences we're fixing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have left the uses in xlnx-zynq.rst because I fixed those
> in a different patchset that overhauled that file.
> ---
>   docs/devel/testing/qgraph.rst        |  8 ++++----
>   docs/devel/vfio-iommufd.rst          |  2 +-
>   docs/specs/fsi.rst                   |  2 +-
>   docs/system/arm/aspeed.rst           |  6 +++---
>   docs/system/arm/b-l475e-iot01a.rst   |  2 +-
>   docs/system/arm/nrf.rst              |  4 ++--
>   docs/system/arm/stm32.rst            | 12 ++++++------
>   docs/system/arm/xlnx-versal-virt.rst | 16 ++++++++--------
>   docs/system/guest-loader.rst         |  2 +-
>   docs/system/replay.rst               |  2 +-
>   10 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/docs/devel/testing/qgraph.rst b/docs/devel/testing/qgraph.rst
> index 43342d9d65..ca63d1ea98 100644
> --- a/docs/devel/testing/qgraph.rst
> +++ b/docs/devel/testing/qgraph.rst
> @@ -8,7 +8,7 @@ take care of booting QEMU with the right machine and devices.
>   This makes each test "hardcoded" for a specific configuration, reducing
>   the possible coverage that it can reach.
>   
> -For example, the sdhci device is supported on both x86_64 and ARM boards,
> +For example, the sdhci device is supported on both x86_64 and Arm boards,
>   therefore a generic sdhci test should test all machines and drivers that
>   support that device.
>   Using only libqos APIs, the test has to manually take care of
> @@ -195,7 +195,7 @@ there.
>   The ``arm/raspi2b`` machine node is listed as "UNAVAILABLE". Although it is
>   reachable from the root via '' -> 'arm/raspi2b' the node is unavailable because
>   the QEMU binary did not list it when queried by the framework. This is expected
> -because we used the ``qemu-system-x86_64`` binary which does not support ARM
> +because we used the ``qemu-system-x86_64`` binary which does not support Arm
>   machine types.
>   
>   If a test is unexpectedly listed as "UNAVAILABLE", first check that the "ALL
> @@ -214,9 +214,9 @@ Here we continue the ``sdhci`` use case, with the following scenario:
>   
>   - ``sdhci-test`` aims to test the ``read[q,w], writeq`` functions
>     offered by the ``sdhci`` drivers.
> -- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``ARM``
> +- The current ``sdhci`` device is supported by both ``x86_64/pc`` and Arm
>     (in this example we focus on the ``arm-raspi2b``) machines.
> -- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``ARM`` and
> +- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for Arm and
>     ``QSDHCI_PCI`` for ``x86_64/pc``. Both implement the
>     ``read[q,w], writeq`` functions.
>   
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175..c29d9f3fb0 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -122,7 +122,7 @@ container:
>   Supported platform
>   ==================
>   
> -Supports x86, ARM and s390x currently.
> +Supports x86, Arm and s390x currently.
>   
>   Caveats
>   =======
> diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
> index af87822531..f7d86d3e37 100644
> --- a/docs/specs/fsi.rst
> +++ b/docs/specs/fsi.rst
> @@ -40,7 +40,7 @@ for the implementation are: (see the `FSI specification`_ for more details)
>      MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
>      address space.
>   
> -5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
> +5. An APB-to-OPB bridge enabling access to the OPB from the Arm core in the
>      AST2600. Hardware limitations prevent the OPB from being directly mapped
>      into APB, so all accesses are indirect through the bridge.
>   
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 4fa1739cb5..97e14b7d33 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -5,7 +5,7 @@ The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
>   Aspeed evaluation boards. They are based on different releases of the
>   Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
>   AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
> -with dual cores ARM Cortex-A7 CPUs (1.2GHz).
> +with dual cores Arm Cortex-A7 CPUs (1.2GHz).
>   
>   The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
>   etc.
> @@ -279,7 +279,7 @@ Aspeed 2700 family boards (``ast2700-evb``, ``ast2700fc``)
>   
>   The QEMU Aspeed machines model BMCs of Aspeed evaluation boards.
>   They are based on different releases of the Aspeed SoC :
> -the AST2700 with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz).
> +the AST2700 with quad cores Arm Cortex-A35 64 bits CPUs (1.6GHz).
>   
>   The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
>   etc.
> @@ -453,7 +453,7 @@ Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb
>   
>   The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
>   evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
> -and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
> +and AST1060 (Platform Root of Trust Processor), both integrating an Arm Cortex M4F CPU (200MHz).
>   
>   The SoC comes with SRAM, SPI, I2C, etc.
>   
> diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
> index 2adcc4b4c1..31a40e3b3b 100644
> --- a/docs/system/arm/b-l475e-iot01a.rst
> +++ b/docs/system/arm/b-l475e-iot01a.rst
> @@ -2,7 +2,7 @@ B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
>   ============================================
>   
>   The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
> -ARM Cortex-M4F core. It is part of STMicroelectronics
> +an Arm Cortex-M4F core. It is part of STMicroelectronics
>   :doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L4
>   ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
>   integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A board
> diff --git a/docs/system/arm/nrf.rst b/docs/system/arm/nrf.rst
> index eda87bd760..e0ea6a8b7e 100644
> --- a/docs/system/arm/nrf.rst
> +++ b/docs/system/arm/nrf.rst
> @@ -1,7 +1,7 @@
>   Nordic nRF boards (``microbit``)
>   ================================
>   
> -The `Nordic nRF`_ chips are a family of ARM-based System-on-Chip that
> +The `Nordic nRF`_ chips are a family of Arm-based System-on-Chip that
>   are designed to be used for low-power and short-range wireless solutions.
>   
>   .. _Nordic nRF: https://www.nordicsemi.com/Products
> @@ -18,7 +18,7 @@ supported by QEMU.
>   Supported devices
>   -----------------
>   
> - * ARM Cortex-M0 (ARMv6-M)
> + * Arm Cortex-M0 (ARMv6-M)
>    * Serial ports (UART)
>    * Clock controller
>    * Timers
> diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
> index 511e3eb9ac..23b03f9029 100644
> --- a/docs/system/arm/stm32.rst
> +++ b/docs/system/arm/stm32.rst
> @@ -1,24 +1,24 @@
>   STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
>   ===============================================================================================================
>   
> -The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
> +The `STM32`_ chips are a family of 32-bit Arm-based microcontrollers by
>   STMicroelectronics.
>   
>   .. _STM32: https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
>   
> -The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
> +The STM32F1 series is based on an Arm Cortex-M3 core. The following machines are
>   based on this chip :
>   
>   - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
>   
> -The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
> +The STM32F2 series is based on an Arm Cortex-M3 core. The following machines are
>   based on this chip :
>   
>   - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
>   
> -The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
> +The STM32F4 series is based on an Arm Cortex-M4F core, as well as the STM32L4
>   ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
> -The following machines are based on this ARM Cortex-M4F chip :
> +The following machines are based on this Arm Cortex-M4F chip :
>   
>   - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
>   - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
> @@ -29,7 +29,7 @@ There are many other STM32 series that are currently not supported by QEMU.
>   Supported devices
>   -----------------
>   
> - * ARM Cortex-M3, Cortex M4F
> + * Arm Cortex-M3, Cortex-M4F
>    * Analog to Digital Converter (ADC)
>    * EXTI interrupt
>    * Serial ports (USART)
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index 640cc07f80..8d31369f71 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -27,12 +27,12 @@ Versal
>   """"""
>   Implemented CPU cores:
>   
> -- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
> -- 2 RCPUs (ARM Cortex-R5F) with their GICv2
> +- 2 ACPUs (Arm Cortex-A72) with their GICv3 and ITS
> +- 2 RCPUs (Arm Cortex-R5F) with their GICv2
>   
>   Implemented devices:
>   
> -- 2 UARTs (ARM PL011)
> +- 2 UARTs (Arm PL011)
>   - An RTC (Versal built-in)
>   - 2 GEMs (Cadence MACB Ethernet MACs)
>   - 8 ADMA (Xilinx zDMA) channels
> @@ -51,12 +51,12 @@ Versal Gen 2
>   """"""""""""
>   Implemented CPU cores:
>   
> -- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
> -- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
> +- 8 ACPUs (Arm Cortex-A78AE) with their GICv3 and ITS
> +- 10 RCPUs (Arm Cortex-R52) with their GICv3 (one per cluster)
>   
>   Implemented devices:
>   
> -- 2 UARTs (ARM PL011)
> +- 2 UARTs (Arm PL011)
>   - An RTC (Versal built-in)
>   - 3 GEMs (Cadence MACB Ethernet MACs)
>   - 8 ADMA (Xilinx zDMA) channels
> @@ -134,7 +134,7 @@ Direct Linux boot of PetaLinux 2019.2:
>         -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
>         -object rng-random,filename=/dev/urandom,id=rng0
>   
> -Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
> +Boot PetaLinux 2019.2 via Arm Trusted Firmware (2018.3 because the 2019.2
>   version of ATF tries to configure the CCI which we don't model) and U-boot:
>   
>   .. code-block:: bash
> @@ -188,7 +188,7 @@ Run the following at the U-Boot prompt:
>     fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
>     booti 30000000 - 20000000
>   
> -Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
> +Boot Linux as Dom0 on Xen via Arm Trusted Firmware and U-Boot:
>   
>   .. code-block:: bash
>   
> diff --git a/docs/system/guest-loader.rst b/docs/system/guest-loader.rst
> index 304ee5d531..12436cc791 100644
> --- a/docs/system/guest-loader.rst
> +++ b/docs/system/guest-loader.rst
> @@ -32,7 +32,7 @@ size. Additional information can be passed with by using additional
>   arguments.
>   
>   Currently the only supported machines which use FDT data to boot are
> -the ARM and RiscV ``virt`` machines.
> +the Arm and RiscV ``virt`` machines.
>   
>   Arguments
>   ^^^^^^^^^
> diff --git a/docs/system/replay.rst b/docs/system/replay.rst
> index 28e5772a2b..fd78bd1f73 100644
> --- a/docs/system/replay.rst
> +++ b/docs/system/replay.rst
> @@ -23,7 +23,7 @@ Deterministic replay has the following features:
>      the memory, state of the hardware devices, clocks, and screen of the VM.
>    * Writes execution log into the file for later replaying for multiple times
>      on different machines.
> - * Supports i386, x86_64, ARM, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
> + * Supports i386, x86_64, Arm, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
>      PowerPC, PowerPC64, M68000, Microblaze, OpenRISC, SPARC,
>      and Xtensa hardware platforms.
>    * Performs deterministic replay of all operations with keyboard and mouse

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


