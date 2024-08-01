Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXyh-0000Kg-5c; Thu, 01 Aug 2024 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXyf-0000BW-Ea
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:44:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXyd-00052k-FM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:44:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc52394c92so63223885ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722527066; x=1723131866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+95jWKmk4aQoLjYG+gtoxOZXqELiMs5nlBx0uDE6Dc=;
 b=cfb/xpBpgUsE2DmZob/Gnho5djOkCbDzW2AgZ47Ex1AchIXvPBhGSEWJDz/mU6S5Kr
 UNk9wRbmE1ltGe9KssfmGxVldSYSGXXheAKgNkhKyCgB//wAxxoUAMxPSuQ0z4dlSKxE
 0L6NTH+e0qDz8GiRvYhpbsRTMjTtcm0t0gGNPJjkjfGdJgvhZhR6spxd6Pu0/Ki/x3Qq
 U49aeQbMQAKeBMblb1c+BSwFMq+GHO6L6Bpv/3LvmPowtb6/NZH93ynrfP4qqmXmM5XQ
 6bK2oDRUjaQm58kBu71H7psibaJefgEqeQl5i1b5CkfeLzHT/VOR5dWEqfHJDH9C4faP
 4xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722527066; x=1723131866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+95jWKmk4aQoLjYG+gtoxOZXqELiMs5nlBx0uDE6Dc=;
 b=tecM12IZUOCvb6R10HjQSLU19wC92j+O0COGmBuTtmborBv5NcNCwg84jmb2DXImhP
 UxQXlUsonFttXfGLL6GfykvmPlLCTZzZmpZsvFwli8nruf8jVW7e53Isi1RviHemhOM/
 DZmdul4HTJFzH2HYlY4OYS/SARMmcFqjNo8is6HnodfQwK5/TQFX4qzaJEa9VOFBGiFf
 xRFilbR9EGJgAmtqX/dlwC3Y65yBKxjlM/+ucC7V2nqpbNixYPWMULVaP1CNpDTQLi8C
 aZe/qW+xFOqi37c0Phq/Zuqg1TqLsOp2czmdvwYgTEFM89jMuzkfu14A+/WHcaVqk6WY
 p4aQ==
X-Gm-Message-State: AOJu0YwNa6+SupzXGSdxwTQ9Uywsa0Ht2tMGBSH6UohWtmkMggk7TSvA
 RGjDdi2GmtbM7plRHTn+tP9YbfNQCHryGR7PyksJxav40y7VB5MztURzPh/71bci2DI+ON58aD+
 w
X-Google-Smtp-Source: AGHT+IFEdN5bkJg77FiFw53mI7F7GATXS9ywVr+5j7z3Ej0qTRM5x40Cua2TBgiV4P/EFm1LJnzHfg==
X-Received: by 2002:a17:903:1209:b0:1fd:8f66:b06c with SMTP id
 d9443c01a7336-1ff573cd0e2mr7101535ad.46.1722527065596; 
 Thu, 01 Aug 2024 08:44:25 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9c650sm17183a12.16.2024.08.01.08.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:44:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.2 v6 12/12] docs/specs: add riscv-iommu
Date: Thu,  1 Aug 2024 12:43:33 -0300
Message-ID: <20240801154334.1009852-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-iommu.rst | 80 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst | 13 +++++++
 3 files changed, 94 insertions(+)
 create mode 100644 docs/specs/riscv-iommu.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 1484e3e760..c68cd9ae6c 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
    virt-ctlr
    vmcoreinfo
    vmgenid
+   riscv-iommu
diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
new file mode 100644
index 0000000000..e3b8f7208e
--- /dev/null
+++ b/docs/specs/riscv-iommu.rst
@@ -0,0 +1,80 @@
+.. _riscv-iommu:
+
+RISC-V IOMMU support for RISC-V machines
+========================================
+
+QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
+version 1.0 `iommu1.0`_.
+
+The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
+RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
+device.
+
+riscv-iommu-pci reference device
+--------------------------------
+
+This device implements the RISC-V IOMMU emulation as recommended by the section
+"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
+class 08h, sub-class 06h and programming interface 00h.
+
+As a reference device it doesn't implement anything outside of the specification,
+so it uses a generic default PCI ID given by QEMU: 1b36:0014.
+
+To include the device in the 'virt' machine:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_opts] (...)
+
+This will add a RISC-V IOMMU PCI device in the board following any additional
+PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
+defined by the spec but its operation is OS dependent.  As of this writing the
+existing Linux kernel support `linux-v8`_, not yet merged, will configure the IOMMU
+to create IOMMU groups with any eligible cards available in the system,
+regardless of factors such as the order in which the devices are added in the
+command line.
+
+This means that these command lines are equivalent as far as the current
+IOMMU kernel driver behaves:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        (...)
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        (...)
+
+Both will create iommu groups for the two e1000e cards.
+
+Another thing to notice on `linux-v8`_ is that the kernel driver considers an IOMMU
+identified as a Rivos device, i.e. it uses Rivos vendor ID.  To use the riscv-iommu-pci
+device with the existing kernel support we need to emulate a Rivos PCI IOMMU by
+setting 'vendor-id' and 'device-id':
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt	\
+     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
+
+Several options are available to control the capabilities of the device, namely:
+
+- "bus": the bus that the IOMMU device uses
+- "ioatc-limit": size of the Address Translation Cache (default to 2Mb)
+- "intremap": enable/disable MSI support
+- "ats": enable ATS support
+- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
+- "s-stage": enable s-stage support
+- "g-stage": enable g-stage support
+
+.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+
+.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index c3f94f63da..dd884ea919 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -84,6 +84,19 @@ none``, as in
 
 Firmware images used for pflash must be exactly 32 MiB in size.
 
+riscv-iommu support
+-------------------
+
+The board has support for the riscv-iommu-pci device by using the following
+command line:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
+
+Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
+works.
+
 Machine-specific options
 ------------------------
 
-- 
2.45.2


