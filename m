Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FA9D11043
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7aki-00066H-JR; Sun, 03 Nov 2024 08:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akf-00065d-VZ; Sun, 03 Nov 2024 08:34:46 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akd-0001Cz-SB; Sun, 03 Nov 2024 08:34:45 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so529133366b.1; 
 Sun, 03 Nov 2024 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640881; x=1731245681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ubvVYqxGpdaNkoauT3AWCkvRpExFF88myWzlqAkC6Vg=;
 b=Dfg7BQJAzh5Ddgmh89gFId/6sX3rBR2cz0jv0IR1FS9E7WDmecUU+vJQ5+d8poYYhf
 C8Nol/kFgHceSGWz/z6zLLdqQFIxqYiMNhLfD6hac3j5SGjD6GxfM3VRBEfn+VL3Lj7F
 a3N67DWisjynXUl8zscUFH2LB6SkjguIeOEHwy4WWQ7zCEe/Gwx3+76fRVj5gMQ4/wdV
 8ELtDbkexxQH7tOZNGqkkptGYjzm/lnA5of375WniAFDVLep4u1Cr23YoB8j4wjNXefx
 iSLrzMfCFGZPJcrKvGpRb1AipiNZ1GsVJt1ApZnoqRsaEcYCZ8SH3P0s8WEtZcmZsLWy
 GGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640881; x=1731245681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ubvVYqxGpdaNkoauT3AWCkvRpExFF88myWzlqAkC6Vg=;
 b=cyAmZsi0mG9CBd/br5tYvg5pZwyfalu1lpT3PVhNtzANGkSS/mLC5iT1qRko5C03KE
 KivciHeIg8R+lAogBTwVgutHbIcumoIL2IAMFOqWtcdz2Ycn1fhd0Q3s5aCOFvnPUwHC
 FXJLyOMa6FXE89eL+/3MELvjdJUjqCpDAs6CtePo2WPVGJgZ/BByiqkfWR+jo9WI7FsH
 ZeHOf608civ5l7n2ViaxKoRk4/Lavk9Yv7dT2a+cs6GISTeCCUicUwzQJnwgcRC4nWLN
 HR3Qxf5WJMhRBpnm3c12bBYvVmD77dX0s4h9jfmTcWnpBDyMjrFQ/GBg+4HDj3dRs51x
 ONLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9ArjxyogLU3GnUBo4Lb6XofyXviwGhBPZXUvnTyhahY08j2ybYlL5eKfrf4/Drw1wCd/gEIaEWLi@nongnu.org,
 AJvYcCXZr95dC1Gc01skXGXi/VxSZ6YwUK15rwepcBOFfmS6ndrIHeOJT1S7smBGK/CcycROsiTTbpwr+nw=@nongnu.org
X-Gm-Message-State: AOJu0YxdRXPy2FPaU4i9IH4iU7WDxDO820lzgbup8+G8m2uHFoDN8NTN
 LX2TMIdir7I/suhWO7J4f2S2k8rfO+8Iar7rfa0RwW8R9Oh4tsvtY2k2Kw==
X-Google-Smtp-Source: AGHT+IFuElUhF+xBM4OiJaNvzoaCxa/tbtJM8LemeSBmZ1jq+xtzvJiJISlf9j6+nkpWxrvJKDsqEg==
X-Received: by 2002:a17:907:9482:b0:a9a:5a50:3e42 with SMTP id
 a640c23a62f3a-a9e508a0648mr1415070566b.12.1730640881118; 
 Sun, 03 Nov 2024 05:34:41 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:40 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 00/26] E500 Cleanup
Date: Sun,  3 Nov 2024 14:33:46 +0100
Message-ID: <20241103133412.73536-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series is part of a bigger series exploring data-driven machine creati=
on=0D
using device tree blobs on top of the e500 machines [1]. It contains patche=
s to=0D
make this exploration easier which are also expected to provide value in=0D
themselves.=0D
=0D
The cleanup starts with the e500 machine class itself, then proceeds with=0D
machine-specific device models and concludes with more or less loosely rela=
ted=0D
devices. Device cleanup mostly consists of using the DEFINE_TYPES() macro.=
=0D
=0D
Patches still missing R-b tags: 1,2,6,8,9,15,23,26=0D
=0D
v4:=0D
* Pick up R-b tags (thanks, Corey!)=0D
* Keep descriptive names for TypeInfo arrays (Corey)=0D
=0D
v3:=0D
* Pick up R-B tags (Kevin, Zoltan -- thanks!)=0D
* Rely on trace events only and drop unimp logging in CCSR space after=0D
  discussion=0D
* Merge https://patchew.org/QEMU/20241005100228.28094-1-shentey@gmail.com/ =
since=0D
  ARM now mostly unaffected=0D
* Add patch to reuse MII constants in etsec device=0D
=0D
Testing done:=0D
* Build qemu_ppc64_e5500_defconfig in Buildroot, run it in the ppce500 mach=
ine=0D
  and issue the `poweroff` command. Observe that QEMU is shut down cleanly.=
=0D
=0D
v2:=0D
* Add R-b tags (Cedric, Zoltan -- thanks!)=0D
* Add missing S-o-b tag to ds1338 patch (Cedric)=0D
* Populate POR PLL ratio status register with real-world values (Zoltan)=0D
* Rephrase one commit message (Zoltan)=0D
* Also rename header of ppce500_ccsr to match struct name=0D
* Don't mention ppc440_bamboo in license since unrelated (Zoltan)=0D
* Various style changes (Zoltan)=0D
=0D
Supersedes: 20241005100228.28094-1-shentey@gmail.com=0D
=0D
Bernhard Beschow (26):=0D
  hw/ppc/e500: Do not leak struct boot_info=0D
  hw/ppc/e500: Remove firstenv variable=0D
  hw/ppc/e500: Prefer QOM cast=0D
  hw/ppc/e500: Remove unused "irqs" parameter=0D
  hw/ppc/e500: Add missing device tree properties to i2c controller node=0D
  hw/ppc/e500: Reuse TYPE_GPIO_PWR=0D
  hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal=0D
    resources=0D
  hw/ppc/e500: Extract ppce500_ccsr.c=0D
  hw/ppc/ppce500_ccsr: Trace access to CCSR region=0D
  hw/ppc/mpc8544_guts: Populate POR PLL ratio status register=0D
  hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access=0D
  hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro=0D
  hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define=0D
  hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro=0D
  hw/net/fsl_etsec/miim: Reuse MII constants=0D
  hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro=0D
  hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro=0D
  hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro=0D
  hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch=0D
  hw/sd/sdhci: Prefer DEFINE_TYPES() macro=0D
  hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro=0D
  hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro=0D
  hw/rtc/ds1338: Prefer DEFINE_TYPES() macro=0D
  hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro=0D
  hw/vfio/platform: Let vfio_start_eventfd_injection() take=0D
    VFIOPlatformDevice pointer=0D
  MAINTAINERS: Add hw/gpio/gpio_pwr.c=0D
=0D
 MAINTAINERS                            |   3 +-=0D
 hw/ppc/e500.h                          |   9 +-=0D
 hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} |   8 +-=0D
 hw/block/pflash_cfi01.c                |  21 ++---=0D
 hw/gpio/mpc8xxx.c                      |  22 ++---=0D
 hw/i2c/mpc_i2c.c                       |  29 +++---=0D
 hw/i2c/smbus_eeprom.c                  |  19 ++--=0D
 hw/net/fsl_etsec/etsec.c               |  22 ++---=0D
 hw/net/fsl_etsec/miim.c                |  19 ++--=0D
 hw/pci-host/ppce500.c                  |  54 +++++------=0D
 hw/ppc/e500.c                          |  81 +++++------------=0D
 hw/ppc/mpc8544_guts.c                  |  32 ++++---=0D
 hw/ppc/ppce500_ccsr.c                  |  57 ++++++++++++=0D
 hw/rtc/ds1338.c                        |  20 ++---=0D
 hw/sd/sdhci.c                          |  62 ++++++-------=0D
 hw/usb/hcd-ehci-sysbus.c               | 118 +++++++++++--------------=0D
 hw/vfio/platform.c                     |   7 +-=0D
 hw/i2c/trace-events                    |   5 ++=0D
 hw/intc/Kconfig                        |   4 +=0D
 hw/intc/meson.build                    |   3 +-=0D
 hw/ppc/Kconfig                         |   1 +=0D
 hw/ppc/meson.build                     |   1 +=0D
 hw/ppc/trace-events                    |   3 +=0D
 23 files changed, 290 insertions(+), 310 deletions(-)=0D
 rename hw/ppc/{e500-ccsr.h =3D> ppce500_ccsr.h} (71%)=0D
 create mode 100644 hw/ppc/ppce500_ccsr.c=0D
=0D
-- =0D
2.47.0=0D
=0D

