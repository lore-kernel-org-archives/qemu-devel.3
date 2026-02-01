Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E107D172AA
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmhKl-0005gb-PW; Sun, 01 Feb 2026 18:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKk-0005fQ-7C; Sun, 01 Feb 2026 18:58:26 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vmhKi-0007lG-0X; Sun, 01 Feb 2026 18:58:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 28956443B8;
 Sun,  1 Feb 2026 23:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40FEC2BC87;
 Sun,  1 Feb 2026 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769990295;
 bh=JieCMwyS0dmjhE3hJJyzeCoQ/1nKVfDaK15QBXDcDVQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ADN1FRkHiOPIsI+sGayZ19c/j98FvC7yyp8wkLqCugnqgeciUi+WWHvGXfrLRbayv
 2qzMSCAZAwmnW/tXG2FeOUb13i8sgL/kzrc8JLR5FZPMLOUpjwgNHklM5oFQYr3w+e
 ppEUuWYZI/hzObDgMO0mwb/SR9bz7JVPK056Hv0gl2MBvtrYDpEasYAQ5AOUTCjjgU
 q0hUGkAd6vL6wsj5OpDE6PYF4i7o9X4Edr+Tnx34m5UCjQgE3XEzpWgxQn8pFKbACY
 Wst9RAJ4SHu9mgkYINdAeH8/jYXrULANC0WqjiLuuv8oC0TVnHMoM0vFG07XvRZc3/
 r1f9cu9FhELXw==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 01 Feb 2026 15:58:11 -0800
Subject: [PATCH v5 5/6] hw/riscv: add CBQRI to Kconfig and build if enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-riscv-ssqosid-cbqri-v5-5-273ea4a21703@kernel.org>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
In-Reply-To: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=fustini@kernel.org;
 h=from:subject:message-id; bh=kehPvMBHTRUHu6S9Q2DPtFbCgSRsdDVPdSLNBUBFc4s=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTWv5iiaHQtSralKJ1ZLT5vRT4TU3+/ZOMx0ZvJTIXpE
 hcnZit0lLIwiHExyIopsmz6kHdhiVfo1wXzX2yDmcPKBDKEgYtTACayupmR4WZf26070icMI+RV
 b7QfbPdVlf7tWfIzcsXFbQorHqxlEGD47/4kYf5MA6G2JSZHN0sdM8vhf/A+sE1nv+XUTVYbdpj
 /ZgEA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolas Pitre <npitre@baylibre.com>

Add boolean property for CBQRI and imply it should be enabled for the
RISC-V virt machine. Build the CBQRI controllers when RISC-V CBQRI is
enabled.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/Kconfig     | 4 ++++
 hw/riscv/meson.build | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd981e..663cb78b813c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,3 +1,6 @@
+config RISCV_CBQRI
+    bool
+
 config RISCV_IOMMU
     bool
 
@@ -68,6 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    imply RISCV_CBQRI
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136cc4..79e15514b797 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_CBQRI', if_true: files('cbqri_capacity.c', 'cbqri_bandwidth.c'))
 
 hw_arch += {'riscv': riscv_ss}

-- 
2.43.0


