Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EF3E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MI7-0005ck-AO; Wed, 30 Oct 2024 23:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHw-0004lu-A6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHu-0004H7-Ao
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:56:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so4884665ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346957; x=1730951757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+o3lCvLW9WsHGBD9qvHFJODJe/o7XQJnqoUKD43VUc=;
 b=KF+5bZMaDHEZfHY6sv/ddn9YrZ0TE9GiXgbpqzPumCoe0nPgFeEztbQ+u9swWVgExV
 JOelDrKBquf6OJ9DfhYB1b4wv4NjKxt8PcEnR1+oJbs7VtQ1cncqYDgQegprM59gUPsG
 DGQPcIerB6gCKRidigIV9WBCbjzuS04vbiRaMkpraCZPUI0FPaDqL3pz7Vrhi/HLqTxW
 JTubL33qhrpPC4IA7JxPtqBhG6UMIsMGHSAIamcLVYO3fNffVO0u7k74pJl0ITNZvKm8
 QvacFXAnjA7M6G4zIEU5tqjhkMdX3c0X9XUFAHeIkrEty5dU+7VwunA+lzIj9hoXp+zT
 oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346957; x=1730951757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+o3lCvLW9WsHGBD9qvHFJODJe/o7XQJnqoUKD43VUc=;
 b=CoHaeOAeCaOcK4v5NNjw6fVuFEkp2qepzmTMq55Y936aPNGGeS9I1QxySjIvK4qu/M
 DiLBP6ieCQoaPOl8x9JvYWbIXIianSEsvvwfNmUzXZOEclbADdtCKpXwzcGK9jqjnsXG
 IgYZWMp0pXbPqxzwfdnL8WOAiJCQtbBdlGPDN1DvNhzky8k3MJJzwrE4o10Deu/WndXm
 XUoyBqIc4uyFcZWuXujsC89dbOjoAbKtvtNyWW3iplYYNFdh2Pp4eGR4eaZR0R3tJ9gJ
 O2GdSd+Kd2l8Uokt6uNeNwFn109nvLJUm1D58FK01YCVq9R/ysjvXEObo4KGFhpamNhW
 Y+VA==
X-Gm-Message-State: AOJu0YzFKyLqRg4iVgSeACUI1h9BA74QhZsauK762R3/y4R2KZAnyesH
 94ThM9Rx7QSB0cUMKHTdnuR1eulM1hDajyOiMhCTgh5qtT+WqFTX4kgcqLHf
X-Google-Smtp-Source: AGHT+IF41D5a7WNUdUXM3pRiyeEwR5EV95qu0fPT0BgqqTWZRG652m3GhZS8FLV9OWTMut16fy7qNQ==
X-Received: by 2002:a17:902:e747:b0:20c:a44b:3221 with SMTP id
 d9443c01a7336-21103ace14amr23819065ad.15.1730346956692; 
 Wed, 30 Oct 2024 20:55:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/50] docs/specs: add riscv-iommu
Date: Thu, 31 Oct 2024 13:53:15 +1000
Message-ID: <20241031035319.731906-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a simple guideline to use the existing RISC-V IOMMU support we just
added.

This doc will be updated once we add the riscv-iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241016204038.649340-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-iommu.rst | 90 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst | 13 ++++++
 3 files changed, 104 insertions(+)
 create mode 100644 docs/specs/riscv-iommu.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 6495ed5ed9..ff5a1f03da 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -36,3 +36,4 @@ guest hardware that is specific to QEMU.
    vmgenid
    rapl-msr
    rocker
+   riscv-iommu
diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
new file mode 100644
index 0000000000..463f4cffb6
--- /dev/null
+++ b/docs/specs/riscv-iommu.rst
@@ -0,0 +1,90 @@
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
+defined by the spec but its operation is OS dependent.
+
+As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
+does not have support for features like VFIO passthrough.  The IOMMU emulation
+was tested using a public Ventana Micro Systems kernel repository in
+`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
+enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
+is feature complete feel free to use the kernel available in the Ventana Micro Systems
+mirror.
+
+The current Linux kernel support will use the IOMMU device to create IOMMU groups
+with any eligible cards available in the system, regardless of factors such as the
+order in which the devices are added in the command line.
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
+Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
+considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
+use the riscv-iommu-pci device with the existing kernel support we need to emulate
+a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
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
+
+.. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a34..8e9a2e4dda 100644
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
2.47.0


