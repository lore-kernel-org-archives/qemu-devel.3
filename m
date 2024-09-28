Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5ECF649C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 08:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTH9-0007ss-Kh; Sat, 28 Sep 2024 04:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTH8-0007rv-1C
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTH5-0002F9-NU
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cdb6ebc1cso672053f8f.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513877; x=1728118677;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ezdNH92l/f3wZ8d6SIBGztD5KzOv8BJuw8J/3sO/X/A=;
 b=NjykWxFD9zq33XisnaiQdho+EM0xDvK/OugtBMY8a4BgPJd2GjHSiw5ekaihggrF5R
 8erTC1e3PSDXu5tGEsQgKdSry4C16xA3UycaPDjpWA8i+gQT5Rs++V3h0Q5OwVr+2SwU
 N5Uj5apeniI1+x8y8oVrrNeHvpfF8GBAzFGC5iODa65mFzH/WE3CsD0McIi4XU38K+Vi
 eEC+1kmyW02jW1HkSGHCCd8RTcGzemFFs7LDLMx6nt5uH0HL1W25Rhmz3SEOPQnhWR+M
 wPamdTk0V25SMt44IXzn0H5Kcd+QkAHAUiFb5QcexCxnsSeXuy/qITXLKxTboRqyqim0
 uaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513877; x=1728118677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ezdNH92l/f3wZ8d6SIBGztD5KzOv8BJuw8J/3sO/X/A=;
 b=imDRllYPkalNagrS6LCj3yoghk6YAquFMT8urT6sDIFUOilOcNIXSe1vap1fruxw4S
 ng2JFcf+V+9CG1MrrPt7GSrNUl938Z1sibeXrH99ZHQXMdNfEF6bk8A2pGBmB9Mm4pGw
 OaM04qNn1lX+3O7bOOQZRxtY/NgfvGuZcECgveCXx+P8OOF/QCNzVqEbnwjjdg+1ZS4P
 mwIQhL8gxGvE91MkMvFefD+86ylnljWRzyeZ7LaEj2XYbN8W0Xlz5C1+43qaMznZPMge
 5A1XwrHk0RPiny9QPWzd1Os5hI0ejj5CifgwNb9MQ4QnzOtvcoWocOx87tP/EJrRpo3q
 OboQ==
X-Gm-Message-State: AOJu0Yw5k8NYGx1cbXWVIJnL2V4Z4OwugelWAbSjnpSd5XfVyW/rDsvn
 l3np9VrI3oB3uSvu7G5WK7YpQV1eEjZz8+KtbEQ0PYjrMYto5BkL3nw1eC6ehuQxxqYhFCaPAnX
 vrg==
X-Google-Smtp-Source: AGHT+IGOAP9rTRljyxi9JqbpvbLNmgeGfivG1g4QKSm4v05bpUkbj2vIrasV19luqwA++uTrzyKfxQ==
X-Received: by 2002:adf:e982:0:b0:374:b31e:3b36 with SMTP id
 ffacd0b85a97d-37cd5aaf6a4mr3438174f8f.6.1727513876788; 
 Sat, 28 Sep 2024 01:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:57:56 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 00/14] macOS PV Graphics and new vmapple machine type
Date: Sat, 28 Sep 2024 10:57:13 +0200
Message-Id: <20240928085727.56883-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::433;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

(Apologies to anyone who has received more than one version of this
series of emails; my git-send-email was misconfigured and this is
a new attempt.)

This patch set introduces a new ARM and macOS HVF specific machine type
called "vmapple", as well as a family of display devices based on the
ParavirtualizedGraphics.framework in macOS. One of the display adapter
variants, apple-gfx-vmapple, is required for the new machine type, while
apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64
macOS guest OSes.

Previous versions of this patch set were submitted semi-separately:
the original vmapple patch set by Alexander Graf included a monolithic
implementation of apple-gfx-vmapple. I subsequently reviewed and reworked
the latter to support the PCI variant of the device as well and submitted
the result in isolation. As requested in subsequent review, I have now
recombined this with the original vmapple patch set, which I have updated
and improved in a few ways as well.

The vmapple machine type approximates the configuration in macOS's own
Virtualization.framework when running arm64 macOS guests. In addition to
generic components such as a GICv3 and an XHCI USB controller, it
includes nonstandard extensions to the virtio block device, a special
"hardware" aes engine, a configuration device, a pvpanic variant, a
"backdoor" interface, and of course the apple-gfx paravirtualised display
adapter.

There are currently a few limitations to this which aren't intrinsic,
just imperfect emulation of the VZF, but it's good enough to be just
about usable for some purposes:

 * macOS 12 guests only. Versions 13+ currently fail during early boot.
 * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
   between Apple M series CPUs and TCG's aarch64 implementation? macOS
   hosts only because ParavirtualizedGraphics.framework is a black box
   implementing most of the logic behind the apple-gfx device.)
 * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
   we'd need to include the GICv3 ITS, but it's unclear to me what
   exactly needs wiring up.
 * Due to lack of MSI(-X), event delivery from USB devices to the guest
   macOS isn't working correctly. My current conclusion is that the
   OS's XHCI driver simply was never designed to work with legacy IRQs.
   The upshot is that keyboard and mouse/tablet input is very laggy.
   The solution would be to implement MSI(-X) support or figure out how
   to make hcd-xhci-sysbus work with the macOS guest, if at all possible.
   (EHCI and UHCI/OHCI controllers are not an option as the VMAPPLE
   guest kernel does not include drivers for these.)
 * The guest OS must first be provisioned using Virtualization.framework;
   the disk images can subsequently be used in Qemu. (See docs.)

The apple-gfx device can be used independently from the vmapple machine
type, at least in the PCI variant. It mainly targets x86-64 macOS guests
from version 11 on, but also includes a UEFI bootrom for basic
framebuffer mode. macOS 11 is also required on the host side, as well
as a GPU that supports the Metal API. On the guest side, this provides
3D acceleration/GPGPU support with a baseline Metal feature set,
irrespective of the host GPU's feature set. A few limitations in the
current integration:

 * Although it works fine with TCG, it does not work correctly
   cross-architecture: x86-64 guests on arm64 hosts appear to make
   some boot progress, but rendering is corrupted. I suspect
   incompatible texture memory layouts; I have no idea if this is
   fixable.
 * ParavirtualizedGraphics.framework and the guest driver support
   multi-headed configurations. The current Qemu integration always
   connects precisely 1 display.
 * State serialisation and deserialisation is currently not
   implemented, though supported in principle by the framework.
   Both apple-gfx variants thus set up a migration blocker.
 * Rendering efficiency could be better. The GPU-rendered guest
   framebuffer is copied to system memory and uses Qemu's usual
   CPU-based drawing. For maximum efficiency, the Metal texture
   containing the guest framebuffer could be drawn directly to
   a Metal view in the host window, staying on the GPU. (Similar
   to the OpenGL/virgl render path on other platforms.)

---

v2 -> v3:

 * Merged the apple-gfx and vmapple patchsets.
 * Squashed a bunch of later apple-gfx patches into the main one.
   (dGPU support, queried MMIO area size, host GPU picking logic.)
 * Rebased on latest upstream, fixing any breakages due to internal
   Qemu API changes.
 * apple-gfx: Switched to re-entrant MMIO. This is supported by the
   underlying framework and simplifies the MMIO forwarding code which
   was previously different on x86-64 vs aarch64.
 * vmapple: Fixes for minor bugs and comments from the last round of
   review.
 * vmapple aes, conf, apple-gfx: Switched reset methods to implement
   the ResettableClass base's interface.
 * vmapple: switched from virtio-hid to an XHCI USB controller and
   USB mouse and tablet devices. macOS does not provide drivers for
   virtio HID devices, at least not in version 12's vmapple kernel.
   So input now sort of works (interrupt issues) rather than not
   at all. Use network-based remote access to the guest OS as a
   work-around.


Alexander Graf (9):
  hw: Add vmapple subdir
  hw/misc/pvpanic: Add MMIO interface
  hvf: arm: Ignore writes to CNTP_CTL_EL0
  gpex: Allow more than 4 legacy IRQs
  hw/vmapple/aes: Introduce aes engine
  hw/vmapple/bdif: Introduce vmapple backdoor interface
  hw/vmapple/cfg: Introduce vmapple cfg region
  hw/vmapple/virtio-blk: Add support for apple virtio-blk
  hw/vmapple/vmapple: Add vmapple machine type

Phil Dennis-Jordan (5):
  hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
    support
  hw/display/apple-gfx: Adds PCI implementation
  ui/cocoa: Adds non-app runloop on main thread mode
  hw/display/apple-gfx: Adds configurable mode list
  MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF

 MAINTAINERS                     |  15 +
 docs/system/arm/vmapple.rst     |  63 +++
 docs/system/target-arm.rst      |   1 +
 hw/Kconfig                      |   1 +
 hw/arm/sbsa-ref.c               |   2 +-
 hw/arm/virt.c                   |   2 +-
 hw/block/virtio-blk.c           |  19 +-
 hw/display/Kconfig              |  14 +
 hw/display/apple-gfx-pci.m      | 179 +++++++++
 hw/display/apple-gfx-vmapple.m  | 215 ++++++++++
 hw/display/apple-gfx.h          |  72 ++++
 hw/display/apple-gfx.m          | 668 ++++++++++++++++++++++++++++++++
 hw/display/meson.build          |   3 +
 hw/display/trace-events         |  26 ++
 hw/i386/microvm.c               |   2 +-
 hw/loongarch/virt.c             |   2 +-
 hw/meson.build                  |   1 +
 hw/mips/loongson3_virt.c        |   2 +-
 hw/misc/Kconfig                 |   4 +
 hw/misc/meson.build             |   1 +
 hw/misc/pvpanic-mmio.c          |  61 +++
 hw/openrisc/virt.c              |  12 +-
 hw/pci-host/gpex.c              |  36 +-
 hw/riscv/virt.c                 |  12 +-
 hw/vmapple/Kconfig              |  32 ++
 hw/vmapple/aes.c                | 584 ++++++++++++++++++++++++++++
 hw/vmapple/bdif.c               | 245 ++++++++++++
 hw/vmapple/cfg.c                | 106 +++++
 hw/vmapple/meson.build          |   5 +
 hw/vmapple/trace-events         |  26 ++
 hw/vmapple/trace.h              |   1 +
 hw/vmapple/virtio-blk.c         | 212 ++++++++++
 hw/vmapple/vmapple.c            | 661 +++++++++++++++++++++++++++++++
 hw/xtensa/virt.c                |   2 +-
 include/hw/misc/pvpanic.h       |   1 +
 include/hw/pci-host/gpex.h      |   7 +-
 include/hw/pci/pci_ids.h        |   1 +
 include/hw/virtio/virtio-blk.h  |  12 +-
 include/hw/vmapple/bdif.h       |  31 ++
 include/hw/vmapple/cfg.h        |  68 ++++
 include/hw/vmapple/virtio-blk.h |  39 ++
 include/qemu-main.h             |   2 +
 meson.build                     |   5 +
 target/arm/hvf/hvf.c            |   9 +
 ui/cocoa.m                      |  15 +-
 45 files changed, 3443 insertions(+), 34 deletions(-)
 create mode 100644 docs/system/arm/vmapple.rst
 create mode 100644 hw/display/apple-gfx-pci.m
 create mode 100644 hw/display/apple-gfx-vmapple.m
 create mode 100644 hw/display/apple-gfx.h
 create mode 100644 hw/display/apple-gfx.m
 create mode 100644 hw/misc/pvpanic-mmio.c
 create mode 100644 hw/vmapple/Kconfig
 create mode 100644 hw/vmapple/aes.c
 create mode 100644 hw/vmapple/bdif.c
 create mode 100644 hw/vmapple/cfg.c
 create mode 100644 hw/vmapple/meson.build
 create mode 100644 hw/vmapple/trace-events
 create mode 100644 hw/vmapple/trace.h
 create mode 100644 hw/vmapple/virtio-blk.c
 create mode 100644 hw/vmapple/vmapple.c
 create mode 100644 include/hw/vmapple/bdif.h
 create mode 100644 include/hw/vmapple/cfg.h
 create mode 100644 include/hw/vmapple/virtio-blk.h

-- 
2.39.3 (Apple Git-145)


