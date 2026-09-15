Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37413C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vao-0007L3-4q; Tue, 15 Sep 2026 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Val-0007JV-0x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:07 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vai-0003Lt-Pe
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:06 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f55eff0so440322066b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488063; x=1790092863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oFPZQwKQuCjCzMZUGK+48BZ68TnFn0kAPX01KvNhndo=;
 b=rWcwnFsp3wndq84OahT+8M7h4fKyH2stKlLuyUMxS8Z5VmOTWX4VqbV3Vdy5efyWk9
 vMkj87Rc18rg7vJBGoTNQVC0R1v2e/hfQWMDgPXf14EzoY4kgM0FRKHBHDIcl/d7xlF5
 98Tw27x4L7nXaEXIP+FwjBgEZ+Er+77jK3Io9WiyDiA+9NADfvS7YGMZ4W+/PDpFdDGZ
 rfVlhW0laZkcvNKiNKn2aNK9kSnhaQtBQJU6ISjKZa6pcMrd19uHWLEbL5MxqecmFl7O
 ayxHLbbQwj/0ZFnNp8QmFXyN3TMnyM8oAz5TbbSMpyHl0jGhztdCpTOu1JkKPPb2VFJp
 Vegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488063; x=1790092863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oFPZQwKQuCjCzMZUGK+48BZ68TnFn0kAPX01KvNhndo=;
 b=CrBuyr5bdjz8EaDkj1BB0Ifs6/ZL3r2Ync5GmxcFFw4cuJaafcJ09Uq8TwTMOvxm1H
 9kVcmTEvQ0jIrKcktBupxfdiWs8FOjt9Ok3chRRJwlAPX0kbUttM2IkL+yd6paVu/1Oa
 G/d9Frocm+xCDtkAowg2W8xF3azAVXXdaQ5yhMBHrIGyYK7qAojitCYZ6z2f/bYbz4sO
 uZkg5g/j6eszICGvdPswoh1yBKvNbYryO1UvKPHmbEbyF/j/YE5dp5tZB1hV9MN/KX3t
 +tR4E0FyADGqzOcQjOqZNKAAct85y6zel52MgmYy+0K9r4XQei4bymB/6XB4GEL1aKEF
 x6BA==
X-Gm-Message-State: AFuF++kmIXBt2scCE9Ii3trArE7colTSVpzj1OZGLgBkHKP1ymE1H+fe
 bYg0IKv1xidGsjPkIFD2LGuZ90/55h+z+P2T7EPgG/fYKZEGCEk4RY7GpK1N+w==
X-Gm-Gg: AYBFou3+8NGM6pO/py+dsLf2D7sc1V3Ny72tBJdDoniUYhExER+eNLFZyt9NA2hBHSx
 0i42hTWuq29y5N08Yf29+9jSx3ZT1K3v4LwVX9wxE+s2DouWuaFUO/gOFW3u5cLr6POaTPfbiLX
 m3SKQKsQi5yxtfTfGha1wi4IZZXTuhu7beyjLXTWFLSAYdnbTIzkVvk0nu5fj/TuYrm5oX8BSCQ
 q1MdxQGTvOfbEXajFbWKbWkiIa902e3RA+qvTOouClANhOZTA6DcAO608l0l2sWpbGluDpwp0rN
 oUCZzURhabDPFRZtnk9jCxfJlPZlAj9aNK1MrjBx78Y0+s02YrhseNAn/eal6lKpS24EgWeddKN
 xkVlpAvYSmdD8TwEN6WtZVQ5LR0I09JjsjYvGnDaZnFZRElCUza6DhQjyD2orBacmlnjzK0lOku
 VDO4bE8kOUCgf+lFzXgFebEsBNxxoYkPIGLXXiVUsjQc5bCneqUB9bfyMJWXm6VpIv95m4sWpAd
 j9CjVNV06uDmae+kQkHz+Bk5puAbnJREbVGker7t24UIA==
X-Received: by 2002:a17:907:948d:b0:c25:2cbe:edeb with SMTP id
 a640c23a62f3a-c29b863a5e1mr562368966b.21.1789488062524; 
 Tue, 15 Sep 2026 09:01:02 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:01 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com
Subject: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulation Protocol
Date: Tue, 15 Sep 2026 18:00:24 +0200
Message-ID: <20260915160044.345788-1-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

This patch series introduces the Remote Port (RP) subsystem, a framework designed to connect QEMU with external simulation environments (such as SystemC models or RTL simulators).

Updates in v2:

- Removed global 'machine-path' and 'sync-quantum' cmdline options
- Added EventNotifier for communication between IO and CPU threads, instead of pipes and sockets
- Made chrdev_id mandatory and simplified chardev configuration
- MemoryTransaction .access handler dropped and reworked RPMemoryTransaction to use existing .read/write_with_attrs
- Reduced coupling with HW Device Tree by making rp devices register themselves within rp core using rp-chan property
- Dropped debug macros and added tracepoints instead
- Added reference to sample project using QEMU with SystemC
- Addressed review comments from v1 patch series:
  https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg01760.html

Origin:
The Remote Port protocol was originally developed by Edgar E. Iglesias.
The original source code is available in the QEMU repository at AMD: https://github.com/Xilinx/qemu.

Motivation
In modern SoC and FPGA development, specialized hardware blocks are often verified using SystemC, Verilog, or VHDL long before silicon is available. While QEMU is optimized for high-performance CPU emulation and software development, it requires hardware models to be rewritten in C, which is time-consuming and duplicates effort.

The Remote Port (RP) subsystem addresses this limitation by enabling a Co-simulation environment. It allows QEMU to act as the high-performance Processing Subsystem, booting complex operating systems (e.g. Linux), while delegating specific peripheral modeling to external simulators (SystemC, RTL) via a socket connection.

The Remote Port protocol provides a socket-based interface that supports:

Memory Transactions: Bidirectional memory accesses (Master and Slave) allowing QEMU to access remote devices and vice versa.
Interrupts/GPIO: Propagation of interrupt signals between QEMU and the remote peer.
IOMMU/ATS Support: Support for Address Translation Services, allowing remote devices to operate correctly behind IOMMU.
Time Synchronization: Keeps QEMU and the external simulator in sync by advancing time in fixed steps (quantums).

Integration with SystemC Ecosystem

To connect the simulation side, the open-source libsystemctlm-soc library [1] is used. It acts as a bridge, translating Remote Port protocol packets into standard SystemC/TLM-2.0 transactions [2]. This allows users to attach existing TLM-2.0 compliant models to QEMU.

Architecture Overview

The series is structured into the following logical components:

1. Core Protocol & Infrastructure

Establishes the socket connection and handshake (Hello protocol).
Implements the packet dispatch loop and thread management.

2. Memory Transaction Support

RP Memory Slave: Allows the remote peer to initiate bus transactions within QEMU.
RP Memory Master: Represents a memory region in QEMU that forwards accesses to the remote peer.

3. Address Translation Services (ATS)

Implements the logic to handle ATS requests from remote masters.
Integrates with QEMU's IOMMU notifiers to manage translation caches.

4. Device Tree (FDT) & Configuration

Added FDT support for Remote Port Memory Master and GPIO

Dependencies

Patches 19-20 in series are based on the following previously submitted series:
FDT based machine v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00415.html

Instantiation of Remote Port via FDT also registers its reset handler,
needed to start protocol thread.

Validation:

The Sample Project demonstrating test setup with QEMU/Remote Port and SystemC emulated PL011 UART module available by following link:
https://github.com/renesas/SysC_Island_MIT


Patch Summary
The series is organized as follows:

System/Global:

system/physmem: Add ats_do_translate helper

Remote Port Core:

hw/core: Add Remote Port protocol packet definition
hw/core: Add Remote Port header helpers
hw/core: Add Remote Port session state and hello protocol
hw/core: Add Remote Port object skeleton
hw/core: Add Remote Port protocol thread and handshake
hw/core: Implement Remote Port response handling
hw/core: Implement Remote Port time synchronization
hw/core: Implement Remote Port irq, sync and ATS helpers
hw/core: Add Remote Port files to build

Memory & Bus Access:

hw/core: Implement Remote Port bus access helpers
hw/core: Add Remote Port Memory Master object skeleton
hw/core: Implement Remote Port Memory Master bus transactions
hw/core: Add Remote Port memory slave device

ATS & Streams:

hw/core: Add Remote Port Stream device
hw/core: Add Remote Port ATS device skeleton
hw/core: Implement Remote Port ATS logic and cache management

FDT & GPIO:

hw/core: Add Remote Port GPIO/Interrupt bridge
hw/core: Add FDT support to Remote Port GPIO
hw/core: Add FDT support to Remote Port memory master

Links:
[1] libsystemctlm library: https://github.com/Xilinx/libsystemctlm-soc

[2] SystemC TLM description: https://systemc.org/overview/systemc-tlm/


Ruslan Ruslichenko (20):
  hw/core: Add Remote Port protocol packet definition
  hw/core: Add Remote Port header helpers
  hw/core: Add Remote Port session state and hello protocol
  hw/core: Implement Remote Port bus access helpers
  hw/core: Implement Remote Port irq, sync and ATS helpers
  hw/core: Add Remote Port object skeleton
  hw/core: Add Remote Port protocol thread and handshake
  hw/core: Implement Remote Port response handling
  hw/core: Implement Remote Port time synchronization
  hw/core: Add Remote Port Memory Master object skeleton
  hw/core: Implement Remote Port Memory Master bus transactions
  system/physmem: Add ats_do_translate helper
  hw/core: Add Remote Port ATS device skeleton
  hw/core: Implement Remote Port ATS logic and cache management
  hw/core: Add Remote Port memory slave device
  hw/core: Add Remote Port GPIO/Interrupt bridge
  hw/core: Add Remote Port Stream device
  hw/core: Add Remote Port files to build
  hw/core: Add FDT support to Remote Port GPIO
  hw/core: Add FDT support to Remote Port memory master

 hw/core/Kconfig                             |   4 +
 hw/core/meson.build                         |  10 +
 hw/core/remote-port-ats.c                   | 412 +++++++++++
 hw/core/remote-port-gpio.c                  | 210 ++++++
 hw/core/remote-port-memory-master.c         | 369 +++++++++
 hw/core/remote-port-memory-slave.c          | 242 ++++++
 hw/core/remote-port-proto.c                 | 467 ++++++++++++
 hw/core/remote-port-stream.c                | 246 ++++++
 hw/core/remote-port.c                       | 782 ++++++++++++++++++++
 hw/core/trace-events                        |  22 +
 include/hw/core/remote-port-ats.h           |  76 ++
 include/hw/core/remote-port-gpio.h          |  34 +
 include/hw/core/remote-port-memory-master.h |  81 ++
 include/hw/core/remote-port-memory-slave.h  |  35 +
 include/hw/core/remote-port-proto.h         | 541 ++++++++++++++
 include/hw/core/remote-port.h               | 164 ++++
 include/system/memory.h                     |   8 +
 system/physmem.c                            |  53 ++
 18 files changed, 3756 insertions(+)
 create mode 100644 hw/core/remote-port-ats.c
 create mode 100644 hw/core/remote-port-gpio.c
 create mode 100644 hw/core/remote-port-memory-master.c
 create mode 100644 hw/core/remote-port-memory-slave.c
 create mode 100644 hw/core/remote-port-proto.c
 create mode 100644 hw/core/remote-port-stream.c
 create mode 100644 hw/core/remote-port.c
 create mode 100644 include/hw/core/remote-port-ats.h
 create mode 100644 include/hw/core/remote-port-gpio.h
 create mode 100644 include/hw/core/remote-port-memory-master.h
 create mode 100644 include/hw/core/remote-port-memory-slave.h
 create mode 100644 include/hw/core/remote-port-proto.h
 create mode 100644 include/hw/core/remote-port.h

-- 
2.43.0


