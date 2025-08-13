Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF181CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 05:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um4Px-0000V2-41; Wed, 13 Aug 2025 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1um4Pt-0000UU-Fu; Wed, 13 Aug 2025 01:52:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1um4Po-0003NO-Lw; Wed, 13 Aug 2025 01:52:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24049d1643aso46015825ad.3; 
 Tue, 12 Aug 2025 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755064360; x=1755669160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=gTIoHxDTXzoqsTmHt3xEgOu5VLB5+SnH+evVgMW7V/Q=;
 b=l8fk4w3S7GoOjFe3iXPTBtFw5soqmMlG1serpkfuriHsUCpu+AuoY5lk8MKH9cSkm6
 AYKatCU2lwX9IvclR7k+PBrioo6ZhHYHoAdrI7DBEF9ziTHpqG5W+PjeQH4a5zc8qc8J
 queL36Vg2NcwJ+Ln6dv4OPN18S+HqBinqSobVQYEukp1u5DoU4rbIjZz1SXxx5qvsdz7
 ndzs2ArluqA/xnKHjRzwlSxmLUUFMiZweiQgCWDIoxQzygQT3wQKGaY30QN1DxgOQm6C
 IF66YZhKVsn6vuJrVq2SZXlPCTioBp15qUU9XpK/4XjS49RFsSo60GZGZrPWdQ2SCrTg
 Uw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755064360; x=1755669160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTIoHxDTXzoqsTmHt3xEgOu5VLB5+SnH+evVgMW7V/Q=;
 b=DBvsNTF4g+M8+Eaj6eU6L7Fs3ddTfVeDvKV2eWWP2+TKFc2PMY/gWJF0ifaYhItfNL
 4U3vt2TQKIBwpZBc1HMYnyAQdM4hJyMQgePtQhLJC1JJFG1ZHl7fsBAZyLk9KhJfywGf
 f8E1VWZ0oyoMegAIbVFnNBs4qnvTkx0ebdm6AmMa19y/tgIRuDj1+g42NjIPSmi8yTqX
 DdJPo/WKRnF+faBtmYQh+VNg8/WNu7wnUVIS/GyTcbMMzzc2YzLg9JLmmbzNMy5B9WPm
 G110hP6lHeQeWddEgyTbd6vogPSOIz3QZ5TgpI76KwWMaEhKRKvpIglhqUy0Xpkhofwe
 X5Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+OabzhfSTSvZBIpKoe31j728FK2x3p0G8SmMO+XX4fdDGHcm6CLkwEj+yoLu1inKjMNd0yDVeE7yM@nongnu.org
X-Gm-Message-State: AOJu0Yxye+/AXWOb6DF/j6+1Akvk4N0AU/tVs2ekLSftSTqd012T/QFa
 /kUv32PhJ9xI8K4Toik22d3SMw2tVE6go8+Uths+/ccZ3oxVa6jhYaGx
X-Gm-Gg: ASbGncv+dm24XOL03f/0h05Fgc3baWGHTdViYGqPgqsuEeEVJxIDocwxoSjb4vrJLO3
 wEkPjXc+4C3ljw3l6pEldNqTvaKWKsk7GaE2O6plexpqEqyNZb5HyX8CCzJX7ywoxj5YOKXsG01
 x2A/gUA2pEZNJsE/QlFFMK5ewqvHcS8ckAdc75FCNy9YgMw298j8VVUuo0Sz1E8xnsdk223pYOL
 8zGf03SuPPN3On5tHw5vK4qN+ExktSVeCf7WuZLdJFhUhKmXNKJZZVQLoID4nUzx5t/zEkCzren
 nwZxHU6bI5QQQRccjK19cdiGstwZYRstkJYCSERW0RDhkTciaFhcyBhPiDSVlUlDhAXiAW5P2Jk
 2elPlmS/nbavZ+m3ufcJubf95v6skhQ==
X-Google-Smtp-Source: AGHT+IEKqjHkh2mb+p/DhVkmn+ElVIfmjnU/WLjzWekSYoQDKBeJ1nVvlfPykLsq5/ojV7Bak0yTxQ==
X-Received: by 2002:a17:902:da83:b0:242:9bc4:f1c7 with SMTP id
 d9443c01a7336-2430d225e40mr31208105ad.54.1755064359631; 
 Tue, 12 Aug 2025 22:52:39 -0700 (PDT)
Received: from donnager-debian.. ([203.38.48.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67aesm316968625ad.6.2025.08.12.22.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 22:52:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs: riscv-iommu: Update status of kernel support
Date: Wed, 13 Aug 2025 15:22:24 +0930
Message-ID: <20250813055225.410620-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.07,
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

The iommu Linux kernel support is now upstream. VFIO is still
downstream at this stage.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Daniel, the wording might require some massaging but I thought it was
best that we update the status of the kernel support. I ran some boot
tests with v6.17-rc1 and the examples seemed to work.

 docs/specs/riscv-iommu.rst | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 991d376fdc24..19a0ecdbe4c1 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -30,15 +30,15 @@ This will add a RISC-V IOMMU PCI device in the board following any additional
 PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
 defined by the spec but its operation is OS dependent.
 
-As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
-does not have support for features like VFIO passthrough.  The IOMMU emulation
-was tested using a public Ventana Micro Systems kernel repository in
-`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
-enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
-is feature complete feel free to use the kernel available in the Ventana Micro Systems
-mirror.
-
-The current Linux kernel support will use the IOMMU device to create IOMMU groups
+Linux kernel iommu support was merged in v6.13. Qemu IOMMU emulation can be
+used with mainline kernels for simple IOMMU PCIe support.
+
+As of v6.17, it does not have support for features like VFIO passthrough.
+There is a `VFIO` RFC series that is not yet merged. The public Ventana Micro
+Systems kernel repository in `ventana-linux`_ can be used for testing the VFIO
+functions.
+
+The v6.13+ Linux kernel support uses the IOMMU device to create IOMMU groups
 with any eligible cards available in the system, regardless of factors such as the
 order in which the devices are added in the command line.
 
@@ -49,7 +49,7 @@ IOMMU kernel driver behaves:
 
   $ qemu-system-riscv64 \
         -M virt,aia=aplic-imsic,aia-guests=5 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=1.0 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
         (...)
@@ -58,21 +58,11 @@ IOMMU kernel driver behaves:
         -M virt,aia=aplic-imsic,aia-guests=5 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=3.0 \
         (...)
 
 Both will create iommu groups for the two e1000e cards.
 
-Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
-considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
-use the riscv-iommu-pci device with the existing kernel support we need to emulate
-a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
-
-.. code-block:: bash
-
-  $ qemu-system-riscv64 -M virt	\
-     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
-
 Several options are available to control the capabilities of the device, namely:
 
 - "bus": the bus that the IOMMU device uses
@@ -84,6 +74,7 @@ Several options are available to control the capabilities of the device, namely:
 - "g-stage": enable g-stage support
 - "hpm-counters": number of hardware performance counters available. Maximum value is 31.
   Default value is 31. Use 0 (zero) to disable HPM support
+- "vendor-id"/"device-id": pci device ID. Defaults to 1b36:0014 (Redhat)
 
 riscv-iommu-sys device
 ----------------------
@@ -111,6 +102,6 @@ riscv-iommu options:
 
 .. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
-.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
+.. _VFIO: https://lore.kernel.org/linux-riscv/20241114161845.502027-17-ajones@ventanamicro.com/
 
 .. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
-- 
2.47.2


