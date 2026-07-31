Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61095C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFm-0002kT-CW; Fri, 31 Jul 2026 01:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM5-0005rF-Uj; Thu, 30 Jul 2026 23:56:18 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002HY-AD; Thu, 30 Jul 2026 23:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470153; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=lOIM/Cc14RzT2Ss1jXc7sxt3HuykJrKEV9sxrNWyD+s=;
 b=WNyZtZbRp0w85tD9OLoAi0SN76GaNn7vm9qYi+Vt/JjonCVYXUxuNlxoC1oelRmz+O9V0ukiOSnGXkK+amZtVQHcmDFCJ5hMNnMdWF5ZVgIVWaICzYCixQb3qBSQy9ATsiClGYyjEbqoZNQbwl9ALL7KUmgg/mM9H4sMlgIqVuw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwNG_1785469833; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwNG_1785469833 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:37 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 01/17] docs/system/riscv/virt: document the cove-vm
 machine option
Date: Fri, 31 Jul 2026 11:49:55 +0800
Message-Id: <20260731035011.4178103-2-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
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

Describe the cove-vm option of the virt machine and how a CoVE TEE VM
(TVM) differs from a regular KVM guest: its memory and vCPU state are
owned by the TEE Security Manager (TSM), the guest images are measured
before it starts, interrupts are delivered as MSIs only, there is no
virtio-mmio transport and vhost cannot be used.

The option itself is added by the following patches.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 docs/system/riscv/virt.rst | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..d053dbc300 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,45 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- cove-vm=[on|off]
+
+  When this option is "on" the guest is created as a RISC-V CoVE
+  (Confidential VM Extension) TEE VM, or TVM. Defaults to "off". See
+  `Running a confidential VM`_ below.
+
+Running a confidential VM
+-------------------------
+
+With "cove-vm=on" the ``virt`` machine creates a TEE VM (TVM) instead of a
+regular KVM guest. The memory and the vCPU state of a TVM are owned by the
+TEE Security Manager (TSM) running in M-mode and are not accessible to the
+host, which changes the machine in a few ways:
+
+- the kernel, the initrd and the device tree are added to the initial
+  measurement of the guest before it starts, so that the guest can be
+  attested later on;
+
+- interrupts are delivered as MSIs only. An IMSIC is therefore mandatory and
+  "aia=aplic-imsic" is selected automatically when no AIA mode is requested.
+  The APLIC is emulated by QEMU because KVM does not implement one for a TVM;
+
+- no virtio-mmio transport is created. Devices have to be attached to the
+  PCIe host bridge, and they always negotiate VIRTIO_F_ACCESS_PLATFORM so
+  that DMA is bounced through memory the guest shares explicitly;
+
+- vhost cannot be used, as the kernel datapath has no access to guest memory.
+
+This requires a host with CoVE support, both in the firmware and in KVM, and
+it only works with ``-accel kvm``. An example command line is:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -M virt,cove-vm=on -accel kvm \
+      -m 256M -smp 1 -nographic \
+      -kernel Image -append "console=ttyS0 root=/dev/vda" \
+      -drive file=rootfs.ext4,format=raw,id=hd0,if=none \
+      -device virtio-blk-pci,drive=hd0,disable-legacy=on
+
 Running Linux kernel
 --------------------
 
-- 
2.34.1


