Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A2D6C287
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTjO-0002pM-BM; Tue, 19 Nov 2024 14:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTjI-0002ne-2N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTjF-0007hk-9G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:39 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72483f6e2fbso2942142b3a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043856; x=1732648656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsTb34GN4ViZbRmdsc1D7ztxOvyrze/RXxWHRe6RRhA=;
 b=Zv//HfcGo6ntoz4JLS4jk2P82LqIzMD95NuS01Pj4P9Gpm+BdZp2qg8HKmsRZXzTpl
 LGCmdLj/NSEl1SDs5N5bTTGz2qreJPGoFFEjWqhgUkNib8cSVGLD1SVN6ksgIRZw0NxP
 fcNqwY1i3dim2BrEysXqewta26MKJD3uUm07wWtUvnyxkXic3oewek0kg/ohztRQSegB
 XkqlpZojvygIEy05SyfYsP3Bg24ePVWBWuvMApk+RSlHif4dUAyeQqtyNXCON6TqA3WU
 SAqRWZB119vsw1ZepdNV34lhwtWjsAQ9/p5CTCwu04rsUThEVx3VllEzeAkkhg9QB6D3
 8Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043856; x=1732648656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsTb34GN4ViZbRmdsc1D7ztxOvyrze/RXxWHRe6RRhA=;
 b=spu2SYf8onYfoBEgTaND5UO0HQV3GUhw9/hKsPztjcEySyiHvYtkQTQCPa8w5bEvZL
 H8/HihyltMdrcTtXdH0HPU/XSaQ6V7ZZpnySomqhzDLQRkjiGsIb9iq6zrG5cExoF0qT
 mlzYTChhs1h9ms+FmY0R93pHbsU/iWnD9q+zKaIFH+EFT1PJZTxMCF0j5jCdZU3YalAu
 SwurkulzyUElqLBWFxuLEa+AX0q3qGm637/tZBsktt0r7yTCBLP4tQ7D65nKUtqJ5J+s
 jeyTryX9yM3JpnnkI81T0mdgWCc3rIqMShfKc7hDk+1QGSrK/2Lnt3tBAMqZ2t0O0Am2
 PD3g==
X-Gm-Message-State: AOJu0Yy8NrVKNr5EGRNVmg4f9S9pEOfLPUvXIxwFesdMU6OcFcU15ZOw
 n4z8axjiuhTT/dXb2eR2ZHOLgICTHXqBoQ0jfGL2dUU76YvkW1VOOw1JEZ70qDIGxYsQlU2uNDw
 s
X-Google-Smtp-Source: AGHT+IHDIL2QEkJZSU2bWHPxmZ23ZPHLdmGVmlFKC+1VddDH46erDhrcoegQ5I7pm2fOLIFt0pWeqw==
X-Received: by 2002:a05:6a00:2285:b0:71e:55e2:2c58 with SMTP id
 d2e1a72fcca58-724becc5a22mr171603b3a.15.1732043855609; 
 Tue, 19 Nov 2024 11:17:35 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:35 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 8/8] docs: update riscv/virt.rst with
 kernel-irqchip=split support
Date: Tue, 19 Nov 2024 16:17:06 -0300
Message-ID: <20241119191706.718860-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Also add a new page, docs/specs/riscv-aia.rst, where we're documenting
the state of AIA support in QEMU w.r.t the controllers being emulated or
not depending on the AIA and accelerator settings.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-aia.rst   | 83 ++++++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst |  7 ++++
 3 files changed, 91 insertions(+)
 create mode 100644 docs/specs/riscv-aia.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index ff5a1f03da..d7675cebc2 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -37,3 +37,4 @@ guest hardware that is specific to QEMU.
    rapl-msr
    rocker
    riscv-iommu
+   riscv-aia
diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
new file mode 100644
index 0000000000..8097e2f897
--- /dev/null
+++ b/docs/specs/riscv-aia.rst
@@ -0,0 +1,83 @@
+.. _riscv-aia:
+
+RISC-V AIA support for RISC-V machines
+======================================
+
+AIA (Advanced Interrupt Architecture) support is implemented in the ``virt``
+RISC-V machine for TCG and KVM accelerators.
+
+The support consists of two main modes:
+
+- "aia=aplic": adds one or more APLIC (Advanced Platform Level Interrupt Controller)
+  devices
+- "aia=aplic-imsic": adds one or more APLIC device and an IMSIC (Incoming MSI
+   Controller) device for each CPU
+
+From an user standpoint, these modes will behave the same regardless of the accelerator
+used.  From a developer standpoint the accelerator settings will change what it being
+emulated in userspace versus what is being emulated by an in-kernel irqchip.
+
+When running TCG, all controllers are emulated in userspace, including machine mode
+(m-mode) APLIC and IMSIC (when applicable).
+
+When running KVM:
+
+- no m-mode is provided, so there is no m-mode APLIC or IMSIC emulation regardless of
+  the AIA mode chosen
+- with "aia=aplic", s-mode APLIC will be emulated by userspace
+- with "aia=aplic-imsic" there are two possibilities.  If no additional KVM option
+  is provided there will be no APLIC or IMSIC emulation in userspace, and the virtual
+  machine will use the provided in-kernel APLIC and IMSIC controllers.  If the user
+  chooses to use the irqchip in split mode via "-accel kvm,kernel-irqchip=split",
+  s-mode APLIC will be emulated while using the s-mode IMSIC from the irqchip
+
+The following table summarizes how the AIA and accelerator options defines what
+we will emulate in userspace:
+
+
+.. list-table:: How AIA and accel options changes controller emulation
+   :widths: 25 25 25 25 25 25 25
+   :header-rows: 1
+
+   * - Accel
+     - Accel props
+     - AIA type
+     - APLIC m-mode
+     - IMSIC m-mode
+     - APLIC s-mode
+     - IMSIC s-mode
+   * - tcg
+     - ---
+     - aplic
+     - emul
+     - n/a
+     - emul
+     - n/a
+   * - tcg
+     - ---
+     - aplic-imsic
+     - emul
+     - emul
+     - emul
+     - emul
+   * - kvm
+     - ---
+     - aplic
+     - n/a
+     - n/a
+     - emul
+     - n/a
+   * - kvm
+     - none
+     - aplic-imsic
+     - n/a
+     - n/a
+     - in-kernel
+     - in-kernel
+   * - kvm
+     - irqchip=split
+     - aplic-imsic
+     - n/a
+     - n/a
+     - emul
+     - in-kernel
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 8e9a2e4dda..ae4a2031e1 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -123,6 +123,13 @@ The following machine-specific options are supported:
   MSIs. When not specified, this option is assumed to be "none" which selects
   SiFive PLIC to handle wired interrupts.
 
+  This option also interacts with '-accel kvm'.  When using "aia=aplic-imsic"
+  with KVM, it is possible to set the use of the kernel irqchip in split mode
+  by using "-accel kvm,kernel-irqchip=split".  In this case the ``virt`` machine
+  will emulate the APLIC controller instead of using the APLIC controller from
+  the irqchip.  See :ref:`riscv-aia` for more details on all available AIA
+  modes.
+
 - aia-guests=nnn
 
   The number of per-HART VS-level AIA IMSIC pages to be emulated for a guest
-- 
2.47.0


