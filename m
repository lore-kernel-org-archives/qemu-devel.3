Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB4C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 18:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thuyL-00058q-9Y; Tue, 11 Feb 2025 13:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thuyE-00058Q-GC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:26:55 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thuy8-0000O0-TG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:26:54 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so79460a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739298407; x=1739903207; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQJv5YsZTN+1pvBFtijIMXXcyKE6p+KEbccdEbZXJi0=;
 b=kETGPPjD37/4CNf/bdO2qhVfxjI9I9f/4YbSfJ3yFtR7/W5AFG41Gynt7G/dw6/ufl
 uRlr8xZC3EJj5EUPuVW5e4mVdg7+Wf3R8lwVpLv6E4gWR2pDw+No5aH0dd+wz8Oeu0Co
 RFp7HqsYhB+BmZUn2bTG1QT4uoLpTeDTC0NISpVAYT3NPhqu3I3lluKCghE199OeZIxF
 fbx4VLag9BrHlCE8sp0RHqvzvtk7o3PetgTOHgz6T3pjl67lR3uHbrj3ujDIyAf/Vn/m
 IGMD01WrYkLBbk2YCBdJsGRwP2I1sFzQ8Q/RnDqBLEYoz8pX0lJAdsz33C4r76qNN8Ho
 WxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739298407; x=1739903207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQJv5YsZTN+1pvBFtijIMXXcyKE6p+KEbccdEbZXJi0=;
 b=TQ4djkXsfFnt5oGCjJa+xSGqTpV3/uni140zYDgojRRvIoJhcJ0mq7lZoX9NxhpsK4
 el9RIjxu3JLcG6DsRR29ltHKhg5oopmY55elmWfBwIha8mgZO7QVixrznQKXAwJoWq5K
 1NzYhMeiivvOH+FqveJcjgVoyiwlXcajWrbrHfC3Q6YllgVXGl6CsFwEC0/u8o+bdGq+
 g6vS30RQYVfRG8p5EoN81eVV68dWbjxUk+a0XWtr/GumyJBbgUE+yxRblGq8wH0RhnvX
 Wv0OEBtToz8bIjvJmDYKThe0QSLjmyr2AV3u+T8eHJ061L48PjokIk24cYVAY4mJkNTp
 mfGA==
X-Gm-Message-State: AOJu0Yz8PPYru/F/3euUlehUsQkfHutE32r4X8PouYjkkEK1UdsKFu1D
 kEA0Ppgb5ZCLKGCbOyOgPw0+6sr3IvFaQ3r37O1yfkYkIIHuDGuG6R8n4q90Iii7qmxXBhFXkuG
 Ao2NqDbVYQy4s4ntf0hpxx4gcz5cTgeON
X-Gm-Gg: ASbGnctFB5hdi1UHFyaSrbyVbKKX7WSF77ZwXoG8LmEi+NoWComrmqXd1M2PdtHMJPD
 /J5+TIpFcYeLgC74nvO63PZLq+wje2WDMzhdA93+wgA9/+7xZCn6WmlZNRy0cAEFVLamucMU=
X-Google-Smtp-Source: AGHT+IFqX+Lh5ayZjLWIMrS2t3xOdlUSOHNFP509DhJ4ZBE7WDpZzE4TYOgsyGTOIbPgHnx+TBRKn//PmIMQeA3Ceg0=
X-Received: by 2002:a05:6402:4616:b0:5dc:8fc1:b3b5 with SMTP id
 4fb4d7f45d1cf-5deae101349mr44908a12.15.1739298406442; Tue, 11 Feb 2025
 10:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20250210204204.54407-1-philmd@linaro.org>
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Feb 2025 13:26:34 -0500
X-Gm-Features: AWEUYZlmMkPzrk6E0z24ojn2o_IB_JeXO6-XeQ8fRttCwJgfJHghFIjoWDQn-4U
Message-ID: <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Feb 10, 2025 at 3:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The following changes since commit 54e91d1523b412b4cff7cb36c898fa9dc133e8=
86:
>
>   Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/armbru i=
nto staging (2025-02-10 10:47:31 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20250210
>
> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>
>   hw/net/smc91c111: Ignore attempt to pop from empty RX fifo (2025-02-10 =
21:30:44 +0100)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Use qemu_hexdump_line() in TPM backend (Philippe)
> - Make various Xilinx devices endianness configurable (Philippe)
> - Remove magic number in APIC (Phil)
> - Disable thread-level cache topology (Zhao)
> - Xen QOM style cleanups (Bernhard)
> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
> - Invert logic of machine no_sdcard flag (Philippe)
> - Housekeeping in MicroBlaze functional tests (Philippe)

Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9106591368

Thanks,
Stefan

> - Prevent out-of-bound access in SMC91C111 RX path (Peter)
>
> ----------------------------------------------------------------
>
> Bernhard Beschow (1):
>   hw/xen: Prefer QOM cast for XenLegacyDevice
>
> Peter Maydell (1):
>   hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
>
> Phil Dennis-Jordan (1):
>   hw/intc/apic: Fixes magic number use, removes outdated comment
>
> Philippe Mathieu-Daud=C3=A9 (28):
>   backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
>   hw/intc/xilinx_intc: Make device endianness configurable
>   hw/net/xilinx_ethlite: Make device endianness configurable
>   hw/timer/xilinx_timer: Make device endianness configurable
>   hw/char/xilinx_uartlite: Make device endianness configurable
>   hw/ssi/xilinx_spi: Make device endianness configurable
>   hw/arm/xlnx-zynqmp: Use &error_abort for programming errors
>   hw/sysbus: Use sizeof(BusState) in main_system_bus_create()
>   hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
>   hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
>   hw/vfio: Have VFIO_PLATFORM devices inherit from
>     DYNAMIC_SYS_BUS_DEVICE
>   hw/display: Have RAMFB device inherit from DYNAMIC_SYS_BUS_DEVICE
>   hw/i386: Have X86_IOMMU devices inherit from DYNAMIC_SYS_BUS_DEVICE
>   hw/net: Have eTSEC device inherit from DYNAMIC_SYS_BUS_DEVICE
>   hw/tpm: Have TPM TIS sysbus device inherit from DYNAMIC_SYS_BUS_DEVICE
>   hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE
>   hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
>   hw/boards: Explicit no_sdcard=3Dfalse as ON_OFF_AUTO_OFF
>   hw/boards: Rename no_sdcard -> auto_create_sdcard
>   hw/boards: Do not create unusable default if=3Dsd drives
>   hw/arm: Remove all invalid uses of auto_create_sdcard=3Dtrue
>   hw/riscv: Remove all invalid uses of auto_create_sdcard=3Dtrue
>   hw/boards: Ensure machine setting auto_create_sdcard expose a SD Bus
>   tests/functional: Explicit endianness of microblaze assets
>   tests/functional: Allow microblaze tests to take a machine name
>     argument
>   tests/functional: Remove sleep() kludges from microblaze tests
>   tests/functional: Have microblaze tests inherit common parent class
>   hw/riscv/opentitan: Include missing 'exec/address-spaces.h' header
>
> Zhao Liu (1):
>   hw/core/machine: Reject thread level cache
>
>  include/hw/boards.h                           |  2 +-
>  include/hw/sysbus.h                           |  2 +
>  include/hw/xen/xen_pvdev.h                    |  5 +-
>  backends/tpm/tpm_util.c                       | 24 ++++----
>  hw/arm/aspeed.c                               | 20 +++++++
>  hw/arm/bananapi_m2u.c                         |  1 +
>  hw/arm/cubieboard.c                           |  1 +
>  hw/arm/exynos4_boards.c                       |  2 +
>  hw/arm/fby35.c                                |  1 +
>  hw/arm/imx25_pdk.c                            |  1 +
>  hw/arm/integratorcp.c                         |  1 +
>  hw/arm/mcimx6ul-evk.c                         |  1 +
>  hw/arm/mcimx7d-sabre.c                        |  1 +
>  hw/arm/npcm7xx_boards.c                       |  5 ++
>  hw/arm/omap_sx1.c                             |  2 +
>  hw/arm/orangepi.c                             |  1 +
>  hw/arm/raspi.c                                |  5 ++
>  hw/arm/raspi4b.c                              |  1 +
>  hw/arm/realview.c                             |  4 ++
>  hw/arm/sabrelite.c                            |  1 +
>  hw/arm/stellaris.c                            |  1 +
>  hw/arm/versatilepb.c                          |  2 +
>  hw/arm/vexpress.c                             |  2 +
>  hw/arm/xilinx_zynq.c                          |  1 -
>  hw/arm/xlnx-versal-virt.c                     |  1 +
>  hw/arm/xlnx-zcu102.c                          |  1 +
>  hw/arm/xlnx-zynqmp.c                          | 38 ++++--------
>  hw/char/xilinx_uartlite.c                     | 27 +++++----
>  hw/core/machine-smp.c                         |  7 +++
>  hw/core/null-machine.c                        |  1 -
>  hw/core/sysbus.c                              | 54 ++++++++++-------
>  hw/display/ramfb-standalone.c                 |  3 +-
>  hw/i386/amd_iommu.c                           |  2 -
>  hw/i386/intel_iommu.c                         |  2 -
>  hw/i386/x86-iommu.c                           |  2 +-
>  hw/intc/apic.c                                |  3 +-
>  hw/intc/xilinx_intc.c                         | 52 +++++++++++-----
>  hw/microblaze/petalogix_ml605_mmu.c           |  3 +
>  hw/microblaze/petalogix_s3adsp1800_mmu.c      |  4 ++
>  hw/net/fsl_etsec/etsec.c                      |  4 +-
>  hw/net/smc91c111.c                            |  9 +++
>  hw/net/xilinx_ethlite.c                       | 20 +++++--
>  hw/ppc/virtex_ml507.c                         |  1 +
>  hw/riscv/microchip_pfsoc.c                    |  1 +
>  hw/riscv/opentitan.c                          |  1 +
>  hw/riscv/sifive_u.c                           |  1 +
>  hw/s390x/s390-virtio-ccw.c                    |  1 -
>  hw/ssi/xilinx_spi.c                           | 24 +++++---
>  hw/timer/xilinx_timer.c                       | 35 +++++++----
>  hw/tpm/tpm_tis_sysbus.c                       |  3 +-
>  hw/usb/xen-usb.c                              |  6 +-
>  hw/vfio/amd-xgbe.c                            |  2 -
>  hw/vfio/calxeda-xgmac.c                       |  2 -
>  hw/vfio/platform.c                            |  4 +-
>  hw/xen/xen-legacy-backend.c                   |  9 +--
>  hw/xen/xen_pvdev.c                            |  2 +-
>  system/vl.c                                   | 24 ++++++--
>  .../functional/test_microblaze_s3adsp1800.py  | 34 +++++++++--
>  .../test_microblazeel_s3adsp1800.py           | 32 ++--------
>  tests/qemu-iotests/172.out                    | 60 -------------------
>  60 files changed, 314 insertions(+), 248 deletions(-)
>
> --
> 2.47.1
>
>

