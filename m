Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C0CD19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQco-0001PG-Cy; Mon, 26 Jan 2026 12:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcc-0001Iz-Ka
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:32 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcZ-0008TW-P1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso55214615e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449404; x=1770054204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uJAdMdnjddS4F5QHuOESIzUAh13P1xUfWp5JVXSSH1I=;
 b=DChDqvakm+HY69+TMgASgZYD/oUFfWs5kli9rLX3ohPblBTMd6Excf7vBP5Bo//z08
 yDVGN4UrVTdirH2KrHu/UPkEJ6DBBZUlsRKNW2ZcziZJ+cjJ2qnNQLkgTIPLV+McDT3v
 cm9DkdQARF76vAcXli2+HkfZiHypxqbImfmiRYFISSn1uDvC53vyE+DtUBR4156KizP6
 e2xWCA1xXFwm1GZrMulFX1N7bvFLyqJ8bWeolFHnRjWQtOaTMJgZzbqLaam09dctxynA
 /fSE3IzozYa5yWabJHK66Tu8SXEpw4eeJjfXzCkFnvQtCy6wskrR75fk8iH6YTS73m8A
 luWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449404; x=1770054204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJAdMdnjddS4F5QHuOESIzUAh13P1xUfWp5JVXSSH1I=;
 b=PWt+mX5eHgrSgAENQONlZje2IX9qMSsLKkdJSyMFFAnWsPR+K+u1vR51keQixhXRnQ
 QZj/Emp0LXTK6eRdi5d8bIsc4qXckD1pTdUMUXVJrCdD2XoPI9aFSk/AKuf44/37rkAQ
 ZxK6li4uafWQnt0tWpH+8ZKyEA+VwekD5GRoe5K7pJgZfbDdbolmwPiyLSSoUAVy/DgN
 vqiATAhlFq7Ne5+5Y4f0TCFhzajUnFPBPR9QnlBIr9RMuPUq5Go9Nvldd/Zopk2sE914
 +y+tYn1vOxUsJA6Iad0KOdvQ6E+R+f7LA+8clxzL9adFjlEuvpTnqpXTTugInkDttDOo
 OO8Q==
X-Gm-Message-State: AOJu0Yy64kLTIE0ZoOT/N+EyrTPgG3wQZFCIBJJA07qHDibWxV/qXZjO
 QrdKmGm6z/kIPUBhDGe3niLJOLAirIAjUm3d+fBzQJOufSAhWRKh+WMxdFVZSGid
X-Gm-Gg: AZuq6aIiGtt8r3lP+kp75sQtcyDPqJf/qE0zbWzMGY3xrA1bOUdQh+SUSyWJ+HbBBw3
 OIeRMB32Ra6PuS44+4fYSEwNF30ZOZnVN2AxJSkemyNVNUWfMatDNTUIWMMm5CDjs5nf97QWQ57
 F+4jA68GIgTd2ClLC3Fh7cYe7T2yYwWNztTmG4utu1+PBoKBSzPe8aqmCxguA5wWDgKqrRHtoZR
 cY38I1D0PXJBybUUC1RWYUkSfUExh4wdEypeg2I2M4ValzxyEU/s4t2aMfy2ZE1gC24dT1iQTCw
 MHipHXjLHWnDblx0q6i7Xk3UU1KpQKo+RQ5FthU9muMVV9dzqnrndmYWpSDrgbmXg5AEOhXyBZp
 awlSFEx2xHEA5nmfv0WuBxXUFmOqgf4nrYw/rmwdLzNryCAg2lU8VVTTuKQWxe9vgG+vFZeYv/c
 s0g7+PWM4mWGm1z8K2FF1JCX1A/zX06S6REpUSo7tMTgmzFuNsh64DFA==
X-Received: by 2002:a05:600c:444c:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-4805cf67274mr85950375e9.19.1769449403793; 
 Mon, 26 Jan 2026 09:43:23 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:23 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 00/27] hw/arm: Add generic FDT-based machine and infrastructure
Date: Mon, 26 Jan 2026 18:42:46 +0100
Message-ID: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch series introduces new ARM machine model, arm-generic-fdt, and the underlying infrastructure required to instantiate a QEMU machine from a Device Tree.

Origin
This feature originates from AMD QEMU repository and was originally developed by AMD.
The sources available by link: https://github.com/Xilinx/qemu.

Motivation
Currently, adding support for a new ARM board in QEMU required writing a dedicated C source file to define the memory map, instantiate devices, and wire interrupts.
Any modification to board configuration requires a corresponding change in the source code and rebuild of the QEMU binary.

This series introduce alternative approach to define board configuration via a Device Tree. The new arm-generic-fdt machine parses DTB at runtime to dynamically construct system topology.

Beyond providing more flexible board creation, the series provides the infrastructure needed to enable Hardware Co-Simulation workflows in future by using Remote-Port protocol:
https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg02121.html.
In mixed simulation environments - where QEMU emulates CPU subsystem and external simulator (such as SystemC) handles custom logic - memory map and interrupt lines may need to be changed depending on external hardware configuration.

Implementation overview
The series implements FDT loading framework itself, which is capable of:
- Parsing and creating device models
- Set properties for them from a device tree
- Connect IRQs for SysBus devices
- Map memory regions for IO device or system RAM.

NOTE: The GPIO wiring for non-SysBus devices would be added in future patch series.

Patch Summary
- hw/core: Add Generic FDT parsing infrastructure and utility functions
- hw/arm: Add the arm-generic-machine model
- hw/core/sysbus: Add IO memory mapping for standard SysBus devices
- system/memory: Allow MemoryRegions to be configured from FDT
- hw/intc: Add FDT support for ARM GIC (IRQ translation and default wiring)
- target/arm: Add FDT support for CPU timers

Testing
Testing performed used Yocto core-image-minimal rootfs and kernel image.

The hardware description Device tree (used with '-hw-dtb' option) can be found here: https://gist.github.com/ruslichenkor/19a1b7d937dbf889190e670cb677e43e#file-arm64-virt-hw-dts

The guest device tree (used with standard '-dtb' option) can be found here: https://gist.github.com/ruslichenkor/19a1b7d937dbf889190e670cb677e43e#file-arm64-virt-guest-dts

Execute command itself:

./qemu-system-aarch64 \
    -machine arm-generic-fdt \
    -hw-dtb arm64-virt-hw.dtb \
    -dtb arm64-virt-guest.dtb \
    -cpu cortex-a57 -smp 4 -m 256 \
    -drive id=disk0,file=./core-image-minimal-qemuarm64.rootfs-20251218190831.ext4,if=none,format=raw \
    -device virtio-blk-device,drive=disk0 \
    -kernel ./Image \
    -nographic \
    -append 'root=/dev/vda console=ttyAMA0 mem=256M swiotlb=0 '

Ruslan Ruslichenko (27):
  system/device_tree: update qemu_fdt_getprop/_cell
  system/device_tree: add few parsing and traversal helpers
  util/log: add log entry for fdt generic utils
  hw/core: introduce generic FDT device model registry
  hw/core/fdt_generic: implement FDT machine creation helpers
  hw/core/fdt_generic: add cpu clusters management
  hw/core/fdt_generic_util: implement main fdt parse routine
  hw/core/fdt_generic_util: implement fdt_init_qdev
  hw/core/fdt_generic_util: initilize qdev properties from fdt
  hw/core/fdt_generic_util: actually realize device
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_MMAP
  hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
  hw/core/fdt_generic_util: implement fdt_get_irq/_info API
  hw/core/fdt_generic_util: map device memory
  hw/core/fdt_generic_util: Connect device irqs
  hw/core/fdt_generic_util: realize cpu clusters
  hw/core: add fdt_generic to the build
  hw/core/machine: add '-hw-dtb' option for machine
  hw/arm: add generic ARM machine initialized by FDT
  hw/core/sysbus: implement FDT_GENERIC_MMAP_CLASS interface
  hw/intc/arm_gic: implement FDT_GENERIC_INTC and fdt support
  target/arm/cpu: add fdt support for armv8-timer
  qom/object: export object_resolve_link()
  system/memory: add setters for MemoryRegion properties
  system/memory: implement FDT_GENERIC_MMAP interface
  hw/core/fdt_generic_util: initialize serial devices
  system/memory: add QOM aliases for fdt support

 hw/arm/arm_generic_fdt.c           |  166 ++++
 hw/arm/boot.c                      |    8 +-
 hw/arm/meson.build                 |    2 +
 hw/arm/raspi4b.c                   |    8 +-
 hw/arm/vexpress.c                  |    4 +-
 hw/arm/xlnx-zcu102.c               |    3 +-
 hw/core/fdt_generic.c              |  286 ++++++
 hw/core/fdt_generic_util.c         | 1349 ++++++++++++++++++++++++++++
 hw/core/machine.c                  |   19 +
 hw/core/meson.build                |    2 +
 hw/core/sysbus.c                   |   28 +
 hw/intc/arm_gic.c                  |   32 +
 hw/intc/arm_gic_common.c           |   50 ++
 include/hw/core/boards.h           |    1 +
 include/hw/core/fdt_generic.h      |  127 +++
 include/hw/core/fdt_generic_util.h |  140 +++
 include/qemu/log.h                 |    1 +
 include/qom/object.h               |   12 +
 include/system/device_tree.h       |   62 +-
 qemu-options.hx                    |    9 +
 qom/object.c                       |    2 +-
 system/device_tree.c               |  236 ++++-
 system/memory.c                    |  248 ++++-
 system/vl.c                        |    3 +
 target/arm/cpu.c                   |  115 +++
 util/log.c                         |    1 +
 26 files changed, 2875 insertions(+), 39 deletions(-)
 create mode 100644 hw/arm/arm_generic_fdt.c
 create mode 100644 hw/core/fdt_generic.c
 create mode 100644 hw/core/fdt_generic_util.c
 create mode 100644 include/hw/core/fdt_generic.h
 create mode 100644 include/hw/core/fdt_generic_util.h

-- 
2.43.0


