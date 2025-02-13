Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9FFC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tieEQ-0003o6-5W; Thu, 13 Feb 2025 13:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tieEM-0003ni-UK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:46:35 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tieEK-0002zr-Um
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:46:34 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de63846e56so2206710a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739472391; x=1740077191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7P5ccA1Na2YK7M6sc814cNO9xoaj4QBgHhRupoAW1Y=;
 b=SzG7CPQra5WF+oQXwlHcrNla5bKG1L52gIioXrIVgUmoffkmVDkscakSpxgj+baWMr
 vVMKjVRw2pBLxqqqEFLXb/Z0R64n1Km0o2Te1GeOvk4qy76Kn63hlsxDNWPeZ+Nvu8px
 aU4TuyApe+DDZMuLq+yTyMzDhjIiXLsdCZXxjGNhlt5B4Qm+FGUdhHIUBh+2VKMCu9ME
 LgFesj8Zw8HLzSLlq1bjMRtzcNTAXdnE4wBybz9Yt/5NN9XfP+2JnVJ7DuVdEpdQH5x8
 ngLVctvqE/h+nGmiU4NoN9GP5BcCfar8+EtUHQCMVhc7BofOXb1kyp9yTLkUn1EzeSmd
 GoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739472391; x=1740077191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7P5ccA1Na2YK7M6sc814cNO9xoaj4QBgHhRupoAW1Y=;
 b=qKDNjZhpafVUCqZ+nG6uA8RKy4gKm4s6ZtTg8Ut1hnDsPzEFVu19nZg2Jh2soH1uj/
 RlDC6Kr6kzwrb0dQE3nibzpCwAQRB6TEf8xdC3qYfrHZAAiCD059Xh9GEabLchO6DwPs
 byk2uDniL4UA/vLyQ3NQWW0iDP3pOzywfJIQVmXARlV2CmyNKl86VWLdRvjsbUL42GLE
 0uKNwis2U3Mgznb10Dh+0XU0qAOwwbaT5KG3D/oCxenwZMJA14SfLentf5qXImtaNqdS
 E0NsfYyH6QQB87OI5RmXD3c9/PRHI2NfCk7iCRGluMYwwyCVkb8JTwF1+1BpXhgSShAy
 6MMw==
X-Gm-Message-State: AOJu0YzKkh4sIaFr8aXhOMbSAshLAXiC9PI54W+3eeEa7NbndwXdmmU0
 v6ypX6G/mFsawSKK7H2F8Zldb6yG5sCkGf7yXsYr5U3ilWBX38aeB7yihkjGLbTc+I+FVtaNpBH
 FchvyzjckH4XStQlvtfXJECqvNiA=
X-Gm-Gg: ASbGncsBF0MVNpVMtHKMfFkQ9UGZi9DrorVADW2gYv6oI70fQeBE+Z7Sn9lkIcA5WGm
 Dy2D3vcDramE6/bQJZhoDgKi8pAaQJISU0xoseo3sSWTld4U6MTFEoj3sgZSXSzSt9MsHBfY=
X-Google-Smtp-Source: AGHT+IGj0y2GERSUZnU9ZSkW9Fcczkzyvpet/WXFGZ4/vrwC/izaDfl6ywIAA4oAK+ZJQBGCk04MVz/6ps3UNWuqVac=
X-Received: by 2002:a05:6402:40c7:b0:5de:6bc2:7bb with SMTP id
 4fb4d7f45d1cf-5deb088ebb9mr7268127a12.17.1739472390528; Thu, 13 Feb 2025
 10:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20250212155408.29502-1-philmd@linaro.org>
In-Reply-To: <20250212155408.29502-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Feb 2025 13:46:18 -0500
X-Gm-Features: AWEUYZmGw-pHk8ReHFl3WMPAIS-oJUN7_DjPHL-SaA_YOHdi4nVQaYhQKSLh1sY
Message-ID: <CAJSP0QUg0X0E7m2Pm0Ni9HiVeXnaHHTAaxgC1+fkZjFcHHeisg@mail.gmail.com>
Subject: Re: [PULL 00/29] Misc HW patches for 2025-02-12
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Feb 12, 2025 at 10:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The following changes since commit f9edf32ea2e18a56de5d92f57e9d10565c8223=
67:
>
>   Merge tag 'pull-request-2025-02-11' of https://gitlab.com/thuth/qemu in=
to staging (2025-02-11 13:27:32 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20250212
>
> for you to fetch changes up to b374adcae577dddfe6cfd404985014fdd2443428:
>
>   hw: Make class data 'const' (2025-02-12 15:39:46 +0100)
>
> Since 2025-02-10: Dropped MicroBlaze endianness patches, added constify.
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Use qemu_hexdump_line() in TPM backend (Philippe)
> - Remove magic number in APIC (Phil)
> - Disable thread-level cache topology (Zhao)
> - Xen QOM style cleanups (Bernhard)
> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
> - Invert logic of machine no_sdcard flag (Philippe)
> - Housekeeping in MicroBlaze functional tests (Philippe)

Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9133190122#L949

Thanks,
Stefan

> - Prevent out-of-bound access in SMC91C111 RX path (Peter)
> - Declare more fields / arguments as const (Philippe)
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
> Philippe Mathieu-Daud=C3=A9 (25):
>   backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
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
>   hw/riscv/opentitan: Include missing 'exec/address-spaces.h' header
>   tests/functional: Explicit endianness of microblaze assets
>   tests/functional: Allow microblaze tests to take a machine name
>     argument
>   tests/functional: Remove sleep() kludges from microblaze tests
>   tests/functional: Have microblaze tests inherit common parent class
>   hw: Declare various const data as 'const'
>   hw: Make class data 'const'
>
> Zhao Liu (1):
>   hw/core/machine: Reject thread level cache
>
>  hw/sd/sdhci-internal.h                        |  2 +-
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
>  hw/core/machine-smp.c                         |  7 +++
>  hw/core/null-machine.c                        |  1 -
>  hw/core/sysbus.c                              | 54 ++++++++++-------
>  hw/display/ramfb-standalone.c                 |  3 +-
>  hw/i386/amd_iommu.c                           |  2 -
>  hw/i386/intel_iommu.c                         |  2 -
>  hw/i386/x86-iommu.c                           |  2 +-
>  hw/intc/apic.c                                |  3 +-
>  hw/isa/vt82c686.c                             |  2 +-
>  hw/net/fsl_etsec/etsec.c                      |  4 +-
>  hw/net/smc91c111.c                            |  9 +++
>  hw/riscv/microchip_pfsoc.c                    |  1 +
>  hw/riscv/opentitan.c                          |  1 +
>  hw/riscv/sifive_u.c                           |  1 +
>  hw/rtc/m48t59-isa.c                           |  2 +-
>  hw/rtc/m48t59.c                               |  2 +-
>  hw/s390x/s390-virtio-ccw.c                    |  1 -
>  hw/sd/sdhci.c                                 |  2 +-
>  hw/sensor/emc141x.c                           |  2 +-
>  hw/sensor/isl_pmbus_vr.c                      |  2 +-
>  hw/sensor/tmp421.c                            |  2 +-
>  hw/tpm/tpm_tis_sysbus.c                       |  3 +-
>  hw/usb/hcd-ehci-pci.c                         |  2 +-
>  hw/usb/hcd-uhci.c                             |  2 +-
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
>  62 files changed, 211 insertions(+), 205 deletions(-)
>
> --
> 2.47.1
>
>

